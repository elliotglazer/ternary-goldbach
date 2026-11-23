"""Build and meter the wide certificate, retaining only successful resumable stages."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
from time import monotonic


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def windows_stats(proc):
    import ctypes as c
    from ctypes import wintypes as w
    times=[w.FILETIME() for _ in range(4)]
    timing=c.windll.kernel32.GetProcessTimes
    timing.argtypes=[w.HANDLE]+[c.POINTER(w.FILETIME)]*4
    if not timing(int(proc._handle),*map(c.byref,times)):
        raise RuntimeError("GetProcessTimes failed")
    secs=[((t.dwHighDateTime << 32)+t.dwLowDateTime)/1e7 for t in times[2:]]
    fields=[("cb",w.DWORD),("faults",w.DWORD)]+[(s,c.c_size_t) for s in
            ("peak","rss","pp","p","pnp","np","page","peakpage")]
    mem=type("MemoryCounters",(c.Structure,),{"_fields_":fields})()
    mem.cb=c.sizeof(mem)
    getmem=c.windll.psapi.GetProcessMemoryInfo
    getmem.argtypes=[w.HANDLE,c.c_void_p,w.DWORD]
    rss=mem.peak//1024 if getmem(int(proc._handle),c.byref(mem),mem.cb) else None
    return dict(user_seconds=secs[1],system_seconds=secs[0],max_rss_kib=rss)


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("fixture",type=Path)
    p.add_argument("build",type=Path)
    p.add_argument("--lean",default="lean")
    p.add_argument("--lean-path",help="existing compatible dependency cache, or omit for the Linux package's Lake environment")
    p.add_argument("--seed",type=Path,help="re-use the generic Windows Lean cache for PrimeSupport, PrimeBitmap and BatchPrime")
    a=p.parse_args()
    root=Path(__file__).resolve().parents[1]
    fixture=a.fixture.resolve()
    build=a.build.resolve();build.mkdir(parents=True,exist_ok=True)
    data=json.loads((fixture/"workload.json").read_text())
    for file,meta in data["inputs"].items():
        if sha(fixture/file)!=meta["sha256"]:
            raise ValueError(f"fixture hash mismatch in {file}")
    base_pins=json.loads((root/"inputs.json").read_text())
    for mod in ["PrimeSupport","PrimeBitmap","BatchPrime"]:
        if sha(root/f"{mod}.lean")!=base_pins[f"{mod}.lean"]:
            raise ValueError(f"generic checker source changed: {mod}")
    if a.lean_path:
        base_path=a.lean_path
    else:
        base_path=subprocess.check_output(["lake","env","printenv","LEAN_PATH"],cwd=root,text=True).strip()
        base_path=os.pathsep.join(str((root/part).resolve()) for part in base_path.split(os.pathsep) if part)
    env=dict(os.environ,LEAN_PATH=str(build)+os.pathsep+base_path)
    version=subprocess.check_output([a.lean,"--version"],env=env,text=True).strip()
    if "eb6cafb7290e8bd5f2937522d8d804f58f02bafc" not in version:
        raise ValueError(f"unexpected Lean version: {version}")
    seed={}
    if a.seed:
        seed_path=a.seed.resolve()
        for mod in ["PrimeSupport","PrimeBitmap","BatchPrime"]:
            o=next(Path(part)/f"{mod}.olean" for part in base_path.split(os.pathsep)
                   if (Path(part)/f"{mod}.olean").exists())
            seed[mod]=sha(o)
        prior=json.loads(seed_path.read_text())["project_dependencies"]
        if any(s not in prior.values() for s in seed.values()):
            raise ValueError("seed olean differs from checked endpoint pilot")
    mods=([] if a.seed else ["PrimeSupport","PrimeBitmap","BatchPrime"])+data["stages"]
    mods.insert(mods.index("Shared")+1,"ReadTable")
    rp=build/"receipt.json"
    info=dict(platform=platform.platform(),lean_version=version,fixture_sha256=sha(fixture/"workload.json"),
              source_bitmap_bytes=data["bytes_source_bitmap"],seed=seed,stages=[],passed=False)
    if rp.exists():
        old=json.loads(rp.read_text())
        if any(old[k]!=info[k] for k in ["platform","lean_version","fixture_sha256","seed"]):
            raise ValueError("incompatible resume; choose a fresh build directory")
        info=old
    done={r["module"]:r for r in info["stages"] if r["exit_code"]==0}
    def save():
        pending=rp.with_suffix(".tmp")
        pending.write_text(json.dumps(info,indent=2)+"\n");pending.replace(rp)
    for mod in mods:
        directory = Path(__file__).resolve().parent if mod=="ReadTable" else (
            fixture if (fixture/f"{mod}.lean").exists() else root)
        source=directory/f"{mod}.lean"
        obj=build/f"{mod}.olean"; log=build/f"{mod}.log"
        if mod in done:
            if sha(source)!=done[mod]["source_sha256"] or sha(obj)!=done[mod]["olean_sha256"]:
                raise ValueError(f"checkpoint changed: {mod}")
            continue
        cmd=[a.lean,"-t0","-j1","-M4096","-o",str(obj),source.name]
        start=monotonic()
        with log.open("wb") as output:
            if os.name=="nt":
                proc=subprocess.Popen(cmd,cwd=source.parent,env=env,stdout=output,stderr=subprocess.STDOUT,
                                      creationflags=subprocess.CREATE_NO_WINDOW)
                try:
                    code=proc.wait(timeout=600)
                except subprocess.TimeoutExpired:
                    proc.kill();proc.wait();code=124
                stats=windows_stats(proc)
            else:
                proc=subprocess.Popen(["timeout","--kill-after=15","600",*cmd],cwd=source.parent,env=env,
                                      stdout=output,stderr=subprocess.STDOUT)
                _,status,u=os.wait4(proc.pid,0)
                code=os.waitstatus_to_exitcode(status);proc.returncode=code
                stats=dict(user_seconds=u.ru_utime,system_seconds=u.ru_stime,max_rss_kib=u.ru_maxrss)
        row=dict(module=mod,command=cmd,source_sha256=sha(source),source_bytes=source.stat().st_size,
                 log_sha256=sha(log),exit_code=code,wall_seconds=monotonic()-start,**stats)
        if code==0:
            row.update(olean_sha256=sha(obj),olean_bytes=obj.stat().st_size)
        info["stages"].append(row);save();print(json.dumps(row),flush=True)
        if code:
            print(log.read_text(encoding="utf-8")[-4000:]);sys.exit(code)
    expected="'WideGoldbach.endpoint_range' depends on axioms: [propext, Classical.choice, Quot.sound]"
    if expected not in (build/"WideAudit.log").read_text().splitlines():
        raise ValueError("axiom audit differed from the expected result")
    info["axioms_line"]=expected
    info["passed"]=True
    save()


if __name__=="__main__":
    main()
