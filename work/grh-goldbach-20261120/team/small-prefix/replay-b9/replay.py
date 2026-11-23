"""Replay an extracted source package using its pinned Mathlib cache."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys
import time


ROOT = Path(__file__).resolve().parent


def run_lean(cmd, env, query=None):
    if os.name != "nt":
        import resource
        before = resource.getrusage(resource.RUSAGE_CHILDREN)
    start = time.monotonic()
    with subprocess.Popen(cmd,cwd=ROOT,env=env,text=True,encoding="utf-8",
                          stdin=subprocess.PIPE if query else subprocess.DEVNULL,
                          stdout=subprocess.PIPE,stderr=subprocess.STDOUT) as p:
        output, _ = p.communicate(query)
        wall = time.monotonic()-start
        if os.name == "nt":
            import ctypes
            from ctypes import wintypes
            times = [wintypes.FILETIME() for _ in range(4)]
            call = ctypes.windll.kernel32.GetProcessTimes
            call.argtypes = [wintypes.HANDLE]+[ctypes.POINTER(wintypes.FILETIME)]*4
            if not call(int(p._handle), *map(ctypes.byref,times)):
                raise ctypes.WinError()
            cpu = sum((t.dwHighDateTime<<32)+t.dwLowDateTime for t in times[2:])/1e7
        else:
            after = resource.getrusage(resource.RUSAGE_CHILDREN)
            cpu = after.ru_utime+after.ru_stime-before.ru_utime-before.ru_stime
        if p.returncode:
            raise RuntimeError(f"{cmd} exited {p.returncode}\n{output}")
    return dict(cpu_seconds=cpu,wall_seconds=wall,output=output)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--power",type=int,choices=range(1,10),default=9)
    parser.add_argument("--upstream",action="store_true",help="also build the upstream billion-bound wrapper")
    parser.add_argument("--packages",type=Path,help="existing .lake/packages directory for the pinned Mathlib revision")
    parser.add_argument("--lean",help="path to the toolchain's lean executable")
    args = parser.parse_args()
    if args.upstream and args.power != 9:
        parser.error("--upstream needs --power 9")
    if args.packages:
        paths = sorted(p / ".lake/build/lib/lean" for p in args.packages.resolve().iterdir() if p.is_dir())
    else:
        raw = subprocess.check_output(["lake","env",sys.executable,"-c",
                                       "import os; print(os.environ['LEAN_PATH'])"],cwd=ROOT,text=True).strip()
        paths = [(ROOT/p).resolve() for p in raw.split(os.pathsep) if p]
    if args.lean:
        lean = args.lean
    else:
        sysroot = subprocess.check_output(["lean","--print-prefix"],cwd=ROOT,text=True).strip()
        lean = str(Path(sysroot)/"bin"/("lean.exe" if os.name=="nt" else "lean"))
    version = subprocess.check_output([lean,"--version"],cwd=ROOT,text=True).strip()
    if "eb6cafb7290e8bd5f2937522d8d804f58f02bafc" not in version:
        raise RuntimeError(f"unexpected Lean toolchain: {version}")
    build = ROOT / ".prefix-build"
    build.mkdir(exist_ok=True)
    env = dict(os.environ,LEAN_PATH=os.pathsep.join(map(str,[build,*paths])))
    modules = ["PrimeSupport","PrimeBitmap","Table","PrefixCheck","PrefixSource"]
    if args.power>=7:
        modules.append("PrefixJoin")
    if args.power>=9:
        modules.append("PrefixFactorial")
    modules.append(f"Power{args.power}")
    if args.upstream:
        modules += ["TernaryGoldbach/Statement","Upstream9"]
    timing = {}
    for module in modules:
        src = ROOT / (module+".lean")
        obj = build / (module+".olean")
        obj.parent.mkdir(exist_ok=True,parents=True)
        timing[module] = run_lean([lean,"-t0","-j1","-M3000","-o",str(obj),str(src.relative_to(ROOT))],env)
        print(module,round(timing[module]["cpu_seconds"],2),flush=True)
    target = "SmallGoldbach.binaryGoldbachUpToBillion" if args.upstream else f"SmallGoldbach.Power{args.power}.binaryGoldbachUpTo"
    query = f"import {modules[-1]}\n#print axioms {target}\n"
    timing["audit"] = run_lean([lean,"-t0","-j1","-M3000","--stdin"],env,query)
    if "[propext, Classical.choice, Quot.sound]" not in timing["audit"]["output"]:
        raise RuntimeError(timing["audit"]["output"])
    print(timing["audit"]["output"],flush=True)
    report = dict(lean=version,stages=timing,cpu_seconds=sum(t["cpu_seconds"] for t in timing.values()),
                  wall_seconds=sum(t["wall_seconds"] for t in timing.values()))
    (build/"replay.json").write_text(json.dumps(report,indent=2)+"\n")


if __name__=="__main__":
    main()
