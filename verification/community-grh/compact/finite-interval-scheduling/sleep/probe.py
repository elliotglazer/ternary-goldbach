"""Observe real Lean worker threads and simultaneous independent declaration proofs."""
import json, os, sys, subprocess, tempfile, time
from pathlib import Path
from collections import Counter
base=Path(__file__).resolve().parent
lean=Path(sys.argv[1]).resolve()
measures={}
for envv, explicit, async_flag in [(None,None,True),("4",None,True),("4","1",True),("1",None,True),("4",None,False)]:
    tag=f"env-{envv}-j-{explicit}-async-{async_flag}"
    with tempfile.TemporaryDirectory() as d:
        work=Path(d);log=work/"events"
        text=(base/"Concurrency.lean").read_text()
        if not async_flag:text=text.replace("theorem sample1 :", "set_option Elab.async false\ntheorem sample1 :")
        src=work/'Concurrency.lean';src.write_text(text)
        env={**os.environ,"TG_INTERVAL_PROBE_LOG":str(log)};env.pop("LEAN_NUM_THREADS",None)
        if envv:env["LEAN_NUM_THREADS"]=envv
        flags=[] if not explicit else ["-j"+explicit]
        start=time.monotonic();proc=subprocess.Popen([str(lean),*flags,"-o","Concurrency.olean","-i","Concurrency.ilean","-c","Concurrency.c",src.name],cwd=work,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,env=env)
        peak_sys=peak_res=0
        while proc.poll() is None:
            try:
                vals={}
                for row in Path(f"/proc/{proc.pid}/status").read_text().splitlines():
                    if row.startswith(("Threads:","VmRSS:")):vals[row.split(":")[0]]=int(row.split(":")[1].split()[0])
                peak_sys=max(peak_sys,vals.get("Threads",0));peak_res=max(peak_res,vals.get("VmRSS",0))
            except FileNotFoundError:
                pass
            time.sleep(.04)
        msg=proc.communicate()[0].decode()
        if proc.returncode:raise RuntimeError((proc.returncode,msg))
        events=[x.split() for x in log.read_text().splitlines()]
        assert len(events)==24 and Counter(x[1] for x in events)=={str(i):2 for i in range(1,13)}
        times={};sim=mx=0
        for phase,ident,t in sorted(events,key=lambda p:(int(p[2]),p[0])):
            sim+=1 if phase=="start" else -1;mx=max(mx,sim)
        measures[tag]={"kernel_threads_peak":peak_sys,"overlapping_proof_tasks_peak":mx,"peak_resident_KiB":peak_res,"wall_seconds":round(time.monotonic()-start,3),"events":events}
        print(tag,mx,peak_sys,measures[tag]["wall_seconds"],flush=True)
out={"scope":"Twelve independent real stock Lean theorem elaborations, each tracing a 500ms tactic; true simultaneous task overlap is measured separately from Linux thread count. This is a scheduler test, not a Goldbach time or memory estimate.","stock":subprocess.check_output([str(lean),"--version"],text=True).strip(),"cpu_affinity_visible":len(os.sched_getaffinity(0)),"cpu_count":os.cpu_count(),"rows":measures}
(base/"receipt.json").write_text(json.dumps(out,indent=2)+"\n")
