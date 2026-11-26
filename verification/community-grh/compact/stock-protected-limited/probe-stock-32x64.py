#!/usr/bin/env python3
"""Measure the stock 32x64 outer process and one genuine delegated phase."""
import json
import os
import secrets
import subprocess
import sys
import tempfile
from pathlib import Path

PIN = "14aa8d6b3c2f14a8540605e37144560b9a00e7e7"
PROFILE = "palomar-namespace-32x64-v1"
GIB = 2**30
PATH_CG = Path("/sys/fs/cgroup")
KEYS = ("memory.max", "memory.high", "memory.swap.max", "cpu.max", "pids.max")

def snapshot(vp):
    rows = {}
    for directory in vp.cgroup_directories():
        values = {}
        for name in KEYS:
            try:
                values[name] = (directory / name).read_text().strip()
            except FileNotFoundError:
                continue
        rows[str(directory)] = values
    return {"uid": os.getuid(), "leaf": next(iter(rows)), "cpu": vp.effective_cpu_count(),
            "memory": vp.effective_memory_bytes(), "affinity": len(os.sched_getaffinity(0)),
            "ancestors": rows}

def classify(outer, inner, props, status, code):
    page = os.sysconf("SC_PAGE_SIZE")
    common = outer["ancestors"].keys() & inner["ancestors"].keys()
    # Only a shared ancestor can impose a joint limit on phase + coordinator.
    def cap(path, key):
        value=outer["ancestors"][path].get(key,"max")
        if key=="cpu.max":
            q,t=value.split() if " " in value else ("max","1")
            return float("inf") if q=="max" else int(q)/int(t)
        return int(value) if value.isdigit() else float("inf")
    shared_memory=[s for s in common if cap(s,"memory.max")==64*GIB]
    shared_cpu=[s for s in common if cap(s,"cpu.max")==32]
    shared_swap=[s for s in common if cap(s,"memory.swap.max")==0]
    memory=int(props["memory.max"]); high=int(props["memory.high"])
    status_group=status["cgroup"]
    rule=inner["ancestors"].get(status_group,{})
    def close(key,expected):
        raw=rule.get(key,"");return raw.isdigit() and abs(int(raw)-expected)<page
    applied=status.get("limits_applied",{})
    levels_ok=(close("memory.max",memory) and close("memory.high",high) and
               all(applied.get(k) is True for k in ("memory.high","memory.max","pids.max")))
    verdict={"outer_selected_profile":outer["cpu"]==32 and outer["memory"]==64*GIB,
            "stock_phase":code==0 and status.get("state")=="finished" and
              status.get("exit_status")==0 and status.get("placement_ok") is True and
              not status.get("deadline_fired") and not status.get("liveness_lost"),
            "phase_cpu_32":inner["cpu"]==32,
            "phase_memory_limits":levels_ok and abs(inner["memory"]-memory)<page,
            "phase_has_zero_swap_cgroup":any(r.get("memory.swap.max")=="0" for r in inner["ancestors"].values()),
            "phase_inside_entry_service":Path(inner["leaf"]).is_relative_to(Path(outer["leaf"])),
            "common_memory64_enforced_by":sorted(shared_memory),
            "common_cpu32_enforced_by":sorted(shared_cpu),
            "common_swap0_enforced_by":sorted(shared_swap)}
    verdict["aggregate_32x64_swap0"]=bool(shared_memory and shared_cpu and shared_swap)
    return verdict

def main():
    sys.dont_write_bytecode=True
    if len(sys.argv)==3 and sys.argv[1]=="--inner":
        sys.path.insert(0,sys.argv[2])
        from scripts import verification_profile as vp
        print(json.dumps(snapshot(vp)));return
    if len(sys.argv)!=3:raise SystemExit("Usage: probe-stock-32x64.py POLICY WRITABLE_WORK")
    policy=Path(sys.argv[1]).resolve(strict=True); work=Path(sys.argv[2]).resolve(strict=True)
    assert os.getuid()!=0 and os.access(work,os.W_OK)
    git=lambda *args:subprocess.check_output(["git","-C",str(policy),*args],text=True).strip()
    assert git("rev-parse","HEAD")==PIN and not git("status","--porcelain","--untracked-files=normal")
    assert os.environ.get("PALOMAR_EXECUTION_PROFILE")==PROFILE
    sys.path.insert(0,str(policy))
    from scripts import verification_profile as vp
    from scripts import verify_submission as v
    assert v.VERIFICATION_PROFILE["id"]==PROFILE
    observed=vp.check_host(v.VERIFICATION_PROFILE,work)
    outer=snapshot(vp)
    assert observed["effective_cpus"]==outer["cpu"]==32 and observed["memory_bytes"]==outer["memory"]==64*GIB,observed
    properties=v.permissive_resource_properties()
    limits=v.translate_resource_properties(properties).cgroup
    assert int(limits["memory.max"])==64*GIB*98//100 and int(limits["memory.high"])==64*GIB*95//100
    boot=v.supervisor_bootstrap(work)
    assert "--user" in boot and "--scope" in boot and "--property=Delegate=yes" in boot
    name="palomar-"+secrets.token_hex(12)
    with tempfile.TemporaryDirectory(prefix="profile-measure-",dir=work) as td:
        temp=Path(td); fifo=temp/"liveness"; statuspath=temp/"status.json"; payload=temp/"payload.json"
        os.mkfifo(fifo,0o600)
        command=v.supervisor_command([sys.executable,"-I",str(Path(__file__).resolve()),"--inner",str(policy)],
                  cwd=work,environment={},timeout=30,resource_properties=properties,unit_name=name,
                  status_path=statuspath,liveness_path=fifo,stdout_path=payload)
        fd=os.open(fifo,os.O_RDWR|os.O_CLOEXEC)
        try:
            run=subprocess.run(command,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=75)
        finally:
            os.close(fd)
        status=json.loads(statuspath.read_text())
        cg=v._cgroup_from_status(status)
        # Stock verifier cleanup of this specific, completed delegated phase.
        try:
            inner=json.loads(payload.read_text())
            report={"policy":PIN,"profile":PROFILE,"observed_host":observed,"raw_physical_memory":vp.host_memory_bytes(),
                "outer":outer,"stock_properties":list(properties),"stock_supervisor_bootstrap":boot,
                "translated_limits":limits,"inner":inner,"stock_status":status,"stdout":run.stdout,
                "classification":classify(outer,inner,limits,status,run.returncode)}
        finally:
            if cg and cg.name==name and cg.is_dir():v._cleanup_phase_cgroup(cg)
        reportfile=work/("stock-32x64-"+name+".json")
        with reportfile.open("x",encoding="utf8") as f:json.dump(report,f,indent=2);f.write("\n")
        print(json.dumps({"report":str(reportfile),"observed_host":observed,"classification":report["classification"]}))
        assert all(report["classification"][k] for k in ("outer_selected_profile","stock_phase","phase_cpu_32","phase_memory_limits")),report["classification"]
if __name__=="__main__":main()
