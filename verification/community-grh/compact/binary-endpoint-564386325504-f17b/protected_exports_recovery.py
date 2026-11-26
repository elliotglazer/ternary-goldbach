"""Check exact full binary proof exports in the stock Linux Lean/NanoDa sandbox."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import shutil
import signal
import time
import threading

WORKER_SHA="c99727b5e03b78c59b8c33cbc0afb20958adccfa59e98a3bac698d27641718a2"
SOURCE="f17b38415535507fe31ba15eba396ef7fbd863af"
SOURCE_FINGERPRINT="6ce489f265b47bf36b15e98244fb318b152bc5083cb9d9a0a845eb0cc651e843"
FIXED_CHALLENGE_SHA="553a79110caf1a369e4eb9b6d30bc797218c564d4afc01cd4aaf15fd8ca724f2"
BWRAP_SHA="e318903862396f96de3df57264e0158682b952fd3fb53ac23d876413e7b30f71"

def sha(path):
    with path.open("rb") as fp:
        return hashlib.file_digest(fp,"sha256").hexdigest()

def required(ok,msg):
    if not ok:
        raise ValueError(str(msg))

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--input",required=True,type=Path)
    p.add_argument("--out",required=True,type=Path)
    p.add_argument("--worker",required=True,type=Path)
    p.add_argument("--toolchain",required=True,type=Path)
    p.add_argument("--bwrap",required=True,type=Path)
    p.add_argument("--deadline-seconds",required=True,type=int)
    p.add_argument("--tiny-control",action="store_true")
    p.add_argument("--host-guard",type=Path)
    p.add_argument("--reuse-exports",type=Path)
    a=p.parse_args()
    required(a.tiny_control or a.host_guard,"the full local proof needs active host headroom monitoring")
    required(a.deadline_seconds>0 and os.geteuid()!=0,"positive deadline and unprivileged uid required")
    required(sha(a.worker)==WORKER_SHA,"checker worker identity")
    required(sha(a.bwrap)==BWRAP_SHA,"local sandbox binary identity")
    spec=importlib.util.spec_from_file_location("tg_binary_endpoint",a.worker)
    w=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(w)
    for s in (signal.SIGINT,signal.SIGTERM,signal.SIGHUP):
        signal.signal(s,w.marker)
    stock={k:sha(a.toolchain/"bin"/k) for k in w.TOOLS}
    required(stock==w.TOOLS,"stock Linux release binaries")
    a.out=a.out.resolve()
    a.out.mkdir(parents=True,exist_ok=False)
    t0=time.monotonic()
    os.nice(10)
    os.sched_setaffinity(0,{max(os.sched_getaffinity(0))})
    state={"kind":"tiny-cross-export-control" if a.tiny_control else "full-production-binary-cross-export","started_utc":w.now(),"success":False,"status":"preflight","stages":{},"checker":WORKER_SHA,"tools":stock,"bwrap_sha256":BWRAP_SHA,"uid":os.geteuid(),"cpu_affinity":sorted(os.sched_getaffinity(0))}
    run=w.Runner(a.out,t0+a.deadline_seconds,state)
    run.persist()
    stop_guard = threading.Event()
    def watch_host():
        low = 0
        while not stop_guard.wait(1.0):
            try:
                sample=json.loads(a.host_guard.read_bytes())
                stale=time.time()-sample["updated_unix"]>90
                strained=(sample["available_ram_gib"]<1.8 or sample["available_commit_gib"]<3.6 or sample["free_disk_gib"]<2.5)
                low=low+1 if strained else 0
                if stale or low>=8:
                    w.STOP="host resource guard" if not stale else "host heartbeat expired"
                    state["host_guard_trigger"]={"stale":stale,"sample":sample,"sustained_s":low}
                    return
            except (OSError,ValueError,KeyError):
                low+=1
                if low>=90:
                    w.STOP="host heartbeat unreadable"
                    return
    if a.host_guard:
        initial=json.loads(a.host_guard.read_bytes())
        required(time.time()-initial["updated_unix"]<30,"stale startup host resource guard")
        threading.Thread(target=watch_host,daemon=True).start()
    try:
        if a.tiny_control:
            rfile=a.input/"receipt.json"
            n=json.loads(rfile.read_bytes())
            required(n.get("kind")=="small-control" and n.get("success") is True and n["worker_sha256"]==WORKER_SHA,"trusted control origin")
            target=w.CONTROL_NAME
            module="EndpointControlProof"
            basis=n["checker_inputs"]
            csha=basis["challenge.export"]["sha256"]
            ssha=basis["solution.export"]["sha256"]
        else:
            rfile=a.input/"native-export.json"
            n=json.loads(rfile.read_bytes())
            required(n["status"]=="exported" and n["exit"]==0 and n["guard"] is None,"native stock export must be complete")
            required(n["commit"]==SOURCE and n["closure_sha256"]==SOURCE_FINGERPRINT and n["eligible_modules"]==415,"native source validation")
            required(n["observed_axioms"] and set(n["observed_axioms"])==set(w.AXIOMS),"native axiom audit")
            required(n["theorem"]==w.TARGET and n["challenge_export_sha256"]==FIXED_CHALLENGE_SHA,"unrelated endpoint receipt")
            target=w.TARGET
            module=w.MOD
            csha=FIXED_CHALLENGE_SHA
            ssha=n["solution"]["sha256"]
        state.update(native_receipt_sha256=sha(rfile),theorem=target)
        config={"challenge_module":"TrustedBinaryEndpoint","solution_module":module,"theorem_names":[target],"definition_names":[],"permitted_axioms":w.AXIOMS,"external_kernels":{"nanoda":["nanoda_bin"]}}
        cfg=a.out/"comparator.json"
        w.save(cfg,config)
        cfg.chmod(0o444)
        pair=[]
        for name,expected in [("challenge.export",csha),("solution.export",ssha)]:
            src=a.input/name
            dst=a.out/name
            stored=a.reuse_exports/name if a.reuse_exports else None
            if stored is not None and stored.is_file() and stored.stat().st_size==src.stat().st_size and sha(stored)==expected:
                os.link(stored,dst)
            else:
                required(shutil.disk_usage(a.out).free>src.stat().st_size+1024**3,"insufficient space for the protected input")
                with src.open("rb") as ins,dst.open("xb") as outs:
                    while data:=ins.read(8*1024**2):
                        w.check_clock(run.due)
                        outs.write(data)
            required(sha(dst)==expected,("input hash mismatch",name))
            dst.chmod(0o444)
            pair.append(dst)
        original_policy_sha256=sha(cfg)
        retained_nanoda=False
        if a.reuse_exports:
            prior_dir=a.reuse_exports
            prior_file=prior_dir/"receipt.json"
            prior_log=prior_dir/"protected-kernels.log"
            if prior_file.is_file() and prior_log.is_file():
                prior=json.loads(prior_file.read_bytes())
                carried=prior.get("retained_nanoda")
                if carried:
                    carried_file=prior_dir/"retained-nanoda-receipt.json"
                    carried_log=prior_dir/"retained-nanoda.log"
                    required(carried_file.is_file() and carried_log.is_file()
                             and sha(carried_file)==carried["prior_receipt_sha256"]
                             and sha(carried_log)==carried["prior_log_sha256"],
                             "missing original accepted NanoDa transcript in carried evidence")
                    prior_file,prior_log=carried_file,carried_log
                    prior=json.loads(prior_file.read_bytes())
                observed=prior.get("observed_kernel_markers",{})
                eligible=observed.get("nanoda kernel accepts the solution") is True and (
                    (prior.get("status")=="incomplete" and "host" in str(prior.get("reason",""))
                     and not observed.get("Lean default kernel accepts the solution"))
                    or (a.tiny_control and prior.get("success") is True))
                if eligible:
                    expected={"kind":state["kind"],"checker":WORKER_SHA,"tools":stock,"uid":os.geteuid(),
                              "bwrap_sha256":BWRAP_SHA,"theorem":target,"native_receipt_sha256":sha(rfile),
                              "challenge_sha256":csha,"solution_sha256":ssha,"policy_sha256":original_policy_sha256}
                    required(all(prior.get(k)==v for k,v in expected.items()),"prior NanoDa provenance")
                    prior_stage=prior["stages"]["protected-kernels"]
                    required(prior_stage.get("log_sha256")==sha(prior_log),"prior comparator log digest")
                    required("nanoda kernel accepts the solution" in prior_log.read_text().splitlines(),
                             "prior positive NanoDa verdict")
                    retained_nanoda=True
                    state["retained_nanoda"]={"prior_receipt_sha256":sha(prior_file),
                                              "prior_log_sha256":sha(prior_log),
                                              "prior_policy_sha256":original_policy_sha256,
                                              "prior_status":prior.get("status")}
                    for retained_source,filename in ((prior_file,"retained-nanoda-receipt.json"),
                                                     (prior_log,"retained-nanoda.log")):
                        dst=a.out/filename
                        shutil.copyfile(retained_source,dst)
                        required(sha(dst)==sha(retained_source),"retained original NanoDa transcript")
                        dst.chmod(0o444)
                    cfg=a.out/"default-comparator.json"
                    w.save(cfg,{**config,"external_kernels":{}})
                    cfg.chmod(0o444)
        state.update(challenge_sha256=csha,solution_sha256=ssha,policy_sha256=sha(cfg))
        log=run.stage("protected-kernels",w.sandbox(a.bwrap.resolve(),a.toolchain.resolve(),cfg,*pair),a.out,{"PATH":"/usr/bin:/bin","LANG":"C.UTF-8"})
        lines=log.read_text(errors="replace").splitlines()
        state["kernel_markers"]={m:m in lines for m in ["nanoda kernel accepts the solution","Lean default kernel accepts the solution","Your solution is okay!"]}
        if retained_nanoda:
            state["current_kernel_markers"]=dict(state["kernel_markers"])
            required(not state["current_kernel_markers"]["nanoda kernel accepts the solution"],
                     "unexpected duplicated NanoDa invocation")
            state["kernel_markers"]["nanoda kernel accepts the solution"]=True
        required(all(state["kernel_markers"].values()),"both protected checkers must accept")
        state.update(status="accepted",success=True)
        return 0
    except w.Incomplete as x:
        state.update(status="incomplete",reason=str(x))
        return 124
    except Exception as x:
        state.update(status="failed",reason=str(x))
        return 1
    finally:
        stop_guard.set()
        visible=a.out/"protected-kernels.log"
        if visible.exists():
            lines=visible.read_text(errors="replace").splitlines()
            state["observed_kernel_markers"]={m:m in lines for m in ["nanoda kernel accepts the solution","Lean default kernel accepts the solution","Your solution is okay!"]}
        state.update(finished_utc=w.now(),wall_s=round(time.monotonic()-t0,3))
        run.persist()
        print(json.dumps({k:state[k] for k in ["kind","status","success","wall_s","reason"] if k in state}))

if __name__=="__main__":
    raise SystemExit(main())
