#!/usr/bin/env python3
"""Export the existing all-even binary endpoint and compare it with an independent Mathlib challenge."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import resource
import shutil
import signal
import subprocess
import sys
import time
from datetime import datetime, timezone

MOD = "ProductPrefix564386325504"
TARGET = "SmallGoldbach." + MOD + ".binaryGoldbachUpTo"
MATHLIB = "56a005855ea17e0b0958f73ec801ae140b0a1679"
VERSION = "eb6cafb7290e8bd5f2937522d8d804f58f02bafc"
CLOSURE = "6ce489f265b47bf36b15e98244fb318b152bc5083cb9d9a0a845eb0cc651e843"
ROOT_SHA = "82ed4024d8ea8b941af8a7ff5b82220a3870e43c394a0488232df5c955486f4a"
TOOLS = {"lean":"bf8d54e4714cc4b03d3f6bb34c83b7202b87e49c8bfcbff6895c085bb90ceb38",
         "leanexport":"f6a6483d518a11b323c28b9bac176d2220df0e9fc3230833815db9586669c074",
         "lake":"8ba83c98f76562d03b8dbc33f1057151ba6cbb121679dde76b2260ccc90495e1",
         "leanchecker":"12c38901cdbfab178f1bf6145dd30012e9a3b2c11ca695292a5884fa3cbaddb6",
         "nanoda_bin":"cbf13950fc4a48f635a0beceeb5ed32dd82568b870cfd081b6391c1f2cf02ba5"}
AXIOMS = ["propext","Quot.sound","Classical.choice"]
EXTRAS = "Nat.add Nat.sub Nat.mul Nat.pow Nat.gcd Nat.div Nat.mod Nat.beq Nat.ble Nat.land Nat.lor Nat.xor Nat.shiftLeft Nat.shiftRight String.ofList Char.ofNat List eagerReduce Nat String String.mk Char optParam autoParam semiOutParam outParam".split()
CHALLENGE = """module

public import Mathlib.Data.Nat.Prime.Defs
public import Mathlib.Algebra.Ring.Parity

public section
namespace SmallGoldbach.ProductPrefix564386325504
theorem binaryGoldbachUpTo :
    ∀ n : Nat, Even n → 4 ≤ n → n ≤ 564386325504 →
      ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ p + q = n := by
  sorry
end SmallGoldbach.ProductPrefix564386325504
"""
CONTROL_NAME="EndpointControl.refl"
CONTROL="module\npublic import Init\npublic section\nnamespace EndpointControl\ntheorem refl (n : Nat) : n = n := by\n  %s\nend EndpointControl\n"
STOP = None

def now():
    return datetime.now(timezone.utc).isoformat()

def check(test,msg):
    if not test:
        raise ValueError(str(msg))

def sha(path):
    with path.open("rb") as fp:
        return hashlib.file_digest(fp,"sha256").hexdigest()

def save(path,data):
    tmp=path.with_suffix(path.suffix+".tmp")
    tmp.write_text(json.dumps(data,indent=2,ensure_ascii=False)+"\n",encoding="utf8")
    os.replace(tmp,path)

def marker(name, *_):
    global STOP
    STOP=signal.Signals(name).name

def git(repo,*args):
    return subprocess.check_output(["git","-c","safe.directory="+str(repo),"-C",str(repo),*args])

class Incomplete(Exception): pass
class Unavailable(Exception): pass

def check_clock(due):
    if STOP or time.monotonic()>=due:
        raise Incomplete(STOP or "deadline")

def proc_sample(root,stats,t):
    pending=[root];seen=set()
    while pending:
        pid=pending.pop()
        if pid in seen: continue
        seen.add(pid);base=Path("/proc")/str(pid)
        try:
            kids=(base/"task"/str(pid)/"children").read_text().split()
            pending.extend(map(int,kids))
            raw=(base/"stat").read_text().rsplit(") ",1)[1].split()
            comm=(base/"comm").read_text().strip()
            if comm not in ("lake","lean","leanexport","leanchecker","nanoda_bin"):continue
            tick=os.sysconf("SC_CLK_TCK")
            row=stats.setdefault(str(pid),{"exe":comm,"first_seen_s":round(t,3),"samples":0})
            rss=next((int(l.split()[1]) for l in (base/"status").read_text().splitlines() if l.startswith("VmHWM:")),0)
            row.update(last_seen_s=round(t,3),samples=row["samples"]+1,user_cpu_s_lower_bound=int(raw[11])/tick,
                       system_cpu_s_lower_bound=int(raw[12])/tick,peak_rss_kib_lower_bound=max(row.get("peak_rss_kib_lower_bound",0),rss))
        except (OSError,ValueError,IndexError): pass

class Runner:
    def __init__(self,out,due,receipt):
        self.out=out;self.due=due;self.receipt=receipt

    def persist(self):
        save(self.out/"receipt.json",self.receipt)

    def stage(self,name,command,cwd,env=None,export=None):
        check_clock(self.due)
        log=self.out/(name+".log")
        state={"started_utc":now(),"command":list(map(str,command)),"status":"running"}
        self.receipt["stages"][name]=state;self.persist()
        prior=resource.getrusage(resource.RUSAGE_CHILDREN);start=time.monotonic();sample=0
        stats={};why=None
        with log.open("wb") as logf:
            output=(self.out/(export+".partial")).open("wb") if export else logf
            try:
                proc=subprocess.Popen(command,cwd=cwd,env=env,stdin=subprocess.DEVNULL,
                                      stdout=output,stderr=logf,start_new_session=True)
                while proc.poll() is None:
                    elapsed=time.monotonic()-start
                    proc_sample(proc.pid,stats,elapsed)
                    if STOP or time.monotonic()>=self.due:
                        why=STOP or "deadline"
                        try: os.killpg(proc.pid,signal.SIGTERM)
                        except ProcessLookupError: pass
                        try: proc.wait(timeout=3)
                        except subprocess.TimeoutExpired:
                            try: os.killpg(proc.pid,signal.SIGKILL)
                            except ProcessLookupError: pass
                        break
                    if elapsed>=sample:
                        state["sampled_processes"]=stats;state["elapsed_s"]=round(elapsed,3)
                        if export:state["bytes_written"]=os.fstat(output.fileno()).st_size
                        self.persist();sample=elapsed+8
                    time.sleep(.35)
                rc=proc.wait()
            finally:
                if export:output.close()
        after=resource.getrusage(resource.RUSAGE_CHILDREN)
        state.update(exit=rc,status="interrupted" if why else "passed" if rc==0 else "failed",
                     finished_utc=now(),wall_s=round(time.monotonic()-start,3),
                     user_cpu_s=after.ru_utime-prior.ru_utime,system_cpu_s=after.ru_stime-prior.ru_stime,
                     log_sha256=sha(log),sampled_processes=stats)
        if export:
            tmp=self.out/(export+".partial");state["bytes_written"]=tmp.stat().st_size
            if rc==0 and not why:
                check(tmp.stat().st_size>0,"empty export")
                final=self.out/export;tmp.rename(final)
                state["export"]={"file":export,"bytes":final.stat().st_size,"sha256":sha(final)}
        self.persist()
        if why:raise Incomplete(why+" during "+name)
        check(rc==0,f"{name} exited {rc}; see {log.name}")
        return log

def git_tree(repo,commit):
    records=git(repo,"ls-tree","-rz","--full-tree",commit).split(b"\0")
    return {name.decode():meta.decode().split()[2] for e in records if e for meta,name in [e.split(b"\t",1)]}

def source_provenance(source,libs,tree,due):
    seen={};remaining=[MOD]
    while remaining:
        check_clock(due);n=remaining.pop()
        if n in seen:continue
        leaf=n.replace(".","/");rel=leaf+".lean";p=source/rel
        check(p.is_file() and rel in tree,("source missing",rel))
        check(p.resolve().is_relative_to(source),("source escapes worktree",rel))
        size=p.stat().st_size;h=hashlib.sha1(("blob "+str(size)+"\0").encode())
        with p.open("rb") as fp:
            prefix=fp.read(65536);h.update(prefix)
            while chunk:=fp.read(1024*1024):h.update(chunk);check_clock(due)
        check(h.hexdigest()==tree[rel],("worktree Git blob mismatch",n))
        parents=[]
        for line in prefix.splitlines():
            for t in re.findall(rb"^(?:(?:public|private|meta)\s+)*import\s+(?:all\s+)?([A-Za-z_0-9.]+)",line):
                parent=t.decode()
                if parent.replace(".","/")+".lean" in tree:parents.append(parent)
        # The independent pinned 415-module digest detects missing or altered import discovery.
        remaining.extend(parents)
        obj=libs/(leaf+".olean")
        if not obj.is_file():raise Unavailable("missing existing compiled parent "+n)
        seen[n]={"source_git_blob":tree[rel],"bytes":size,"imports":parents,"olean_bytes":obj.stat().st_size}
    fingerprint=hashlib.sha256(("\n".join(n+" "+seen[n]["source_git_blob"] for n in sorted(seen))+"\n").encode()).hexdigest()
    check(len(seen)==415 and fingerprint==CLOSURE,("production source closure mismatch",len(seen),fingerprint))
    return seen

def packages(repo,commit,packdir):
    manifest=json.loads(git(repo,"show",commit+":lake-manifest.json"))
    dirs=[];versions={}
    for row in manifest["packages"]:
        pkg=packdir/row["name"]
        actual=git(pkg,"rev-parse","HEAD").decode().strip()
        check(actual==row["rev"],("wrong Mathlib dependency",row["name"],actual,row["rev"]))
        versions[row["name"]]=actual
        lib=pkg/".lake/build/lib/lean"
        if lib.is_dir():dirs.append(lib)
    check(versions.get("mathlib")==MATHLIB,versions)
    return dirs,versions

def sandbox(bw,prefix,config,challenge,solution):
    cmd=[str(bw),"--unshare-all","--die-with-parent","--new-session","--clearenv",
         "--proc","/proc","--dev","/dev","--tmpfs","/tmp"]
    for path in ["/home","/root","/run/user","/var","/tmp/home","/tmp/judge","/project","/helpers"]:
        cmd.extend(["--dir",path])
    for n in ["/usr","/bin","/lib","/lib64","/etc"]:
        path=Path(n)
        if path.is_symlink():cmd.extend(["--symlink",os.readlink(path),n])
        elif path.exists():cmd.extend(["--ro-bind",n,n])
    for src,dest in [(prefix,"/tool"),(bw,"/helpers/bwrap"),(config,"/project/comparator.json"),
                     (challenge,"/tmp/challenge.export"),(solution,"/tmp/solution.export")]:
        cmd.extend(["--ro-bind",str(src),dest])
    for k,v in dict(HOME="/tmp/home",PATH="/tool/bin:/helpers:/usr/bin:/bin",COMPARATOR_BWRAP="/helpers/bwrap",
                    LANG="C.UTF-8",LEAN_ABORT_ON_PANIC="1",LEAN_NUM_THREADS="1",LAKE_ARTIFACT_CACHE="false").items():
        cmd.extend(["--setenv",k,v])
    audit='test ! -w /project/comparator.json && test ! -w /tmp/solution.export && test ! -w /tmp/challenge.export && test -z "$LEAN_PATH" && test ! -e /work && test ! -e /mnt/c && test ! -e /proc/1/root/work'
    return cmd+["--chdir","/tmp/judge","/bin/sh","-ec",audit+'; exec lake comparator --config /project/comparator.json --challenge-from-export /tmp/challenge.export --solution-from-export /tmp/solution.export']

def main():
    p=argparse.ArgumentParser(description=__doc__)
    for opt in ["repo","source-tree","packages","proof-lib","toolchain","out","bwrap"]:
        p.add_argument("--"+opt,type=Path,required=opt in ("toolchain","out"))
    p.add_argument("--commit");p.add_argument("--tree");p.add_argument("--bwrap-sha256")
    p.add_argument("--expected-object-sha256")
    p.add_argument("--deadline-seconds",type=float,default=36000)
    p.add_argument("--control",action="store_true",help="run a labelled tiny equality through both protected kernels")
    p.add_argument("--check-only",action="store_true",help="record production preflight without exports")
    args=p.parse_args()
    if not args.control and not all([args.repo,args.source_tree,args.packages,args.commit]):p.error("production needs --repo --source-tree --packages --commit")
    args.out=args.out.resolve();args.out.mkdir(parents=True,exist_ok=False)
    for s in (signal.SIGTERM,signal.SIGINT,signal.SIGHUP):signal.signal(s,marker)
    os.nice(10);allowed=os.sched_getaffinity(0);os.sched_setaffinity(0,{max(allowed)})
    start=time.monotonic()
    state={"schema":1,"kind":"small-control" if args.control else "production-binary-endpoint",
           "status":"preflight","success":False,"started_utc":now(),"stages":{},"affinity":sorted(os.sched_getaffinity(0)),
           "unprivileged_uid":os.geteuid(),"deadline_seconds":args.deadline_seconds,"worker_sha256":sha(Path(__file__))}
    run=Runner(args.out,start+args.deadline_seconds,state);run.persist()
    try:
        check(os.geteuid()!=0,"run as an unprivileged user")
        prefix=args.toolchain.resolve();bins=prefix/"bin"
        target=CONTROL_NAME if args.control else TARGET
        state["theorem"]=target
        if not args.control:
            repo=args.repo.resolve();source=args.source_tree.resolve();lib=(args.proof_lib or (source/".lake/build/lib/lean")).resolve()
            check(re.fullmatch(r"[0-9a-f]{40}",args.commit) is not None,"require full immutable Git commit")
            commit=git(repo,"rev-parse",args.commit+"^{commit}").decode().strip();check(commit==args.commit,"commit mismatch")
            tree_id=git(repo,"rev-parse",commit+"^{tree}").decode().strip()
            if args.tree:check(tree_id==args.tree,"tree mismatch")
            production=lib/(MOD+".olean");state.update(commit=commit,tree=tree_id,
                production_object_path=str(production),source_tree=str(source),packages_path=str(args.packages.resolve()))
            if not production.is_file():raise Unavailable("the recorded project object does not yet exist: "+str(production))
            check(sha(source/(MOD+".lean"))==ROOT_SHA,"endpoint source mismatch")
            closure=source_provenance(source,lib,git_tree(repo,commit),run.due)
            save(args.out/"source-closure.json",closure)
            facts={k:sha(lib/(MOD+k)) for k in (".olean",".olean.private",".olean.server",".ir",".ir.sig") if (lib/(MOD+k)).is_file()}
            if args.expected_object_sha256:check(facts[".olean"]==args.expected_object_sha256,"unexpected endpoint .olean")
            state.update(source_sha256=ROOT_SHA,source_closure_modules=len(closure),source_closure_fingerprint=CLOSURE,
                         source_closure_file_sha256=sha(args.out/"source-closure.json"),endpoint_facets=facts)
            dirs,dependencies=packages(repo,commit,args.packages.resolve());state["package_revisions"]=dependencies
        else:dirs=[]
        bw=(args.bwrap or Path(shutil.which("bwrap") or "/usr/bin/bwrap")).resolve()
        state["tools"]={n:sha(bins/n) for n in TOOLS};check(state["tools"]==TOOLS,"stock executable hash mismatch")
        state["toolchain_version"]=subprocess.check_output([str(bins/"lean"),"--version"],text=True).strip()
        check(VERSION in state["toolchain_version"],"stock compiler version mismatch")
        state["bwrap_sha256"]=sha(bw)
        if args.bwrap_sha256:check(state["bwrap_sha256"]==args.bwrap_sha256,"bwrap digest mismatch")
        if args.check_only:
            state["status"]="available";return 0
        baseenv={"PATH":str(bins)+":/usr/bin:/bin","HOME":str(args.out),"LANG":"C.UTF-8","LEAN_NUM_THREADS":"1","LEAN_ABORT_ON_PANIC":"1","LAKE_ARTIFACT_CACHE":"false"}
        target_module="EndpointControlProof" if args.control else MOD
        roots=["Quot","Quot.mk","Quot.lift","Quot.ind",target,*AXIOMS,*EXTRAS]
        state["export_roots"]=roots
        for role in ["challenge","solution"]:
            work=args.out/role;work.mkdir()
            if role=="challenge":
                module="TrustedBinaryEndpoint";text=CONTROL%"sorry" if args.control else CHALLENGE
                libs=dirs
            elif args.control:
                module=target_module;text=CONTROL%"rfl";libs=[]
            else:
                module="EndpointAxiomAudit";text="module\npublic import "+MOD+"\n#print axioms "+TARGET+"\n";libs=[lib,*dirs]
            env={**baseenv,"LEAN_PATH":os.pathsep.join(map(str,[work,*libs]))}
            source=work/(module+".lean");source.write_text(text,encoding="utf8");state[role+"_source_sha256"]=sha(source)
            if role=="solution" and not args.control:
                check_owner=run.stage("solution-import",[str(bins/"lean"),"-j1",source.name],work,env)
                log=check_owner.read_text("utf8")
                ax=re.search(r"^'"+re.escape(TARGET)+r"' depends on axioms: \[(.*?)\]$",log,re.M)
                check(ax is not None and set(ax[1].split(", "))<=set(AXIOMS),"production axiom audit failed")
                state["observed_axioms"]=ax[1].split(", ");module=MOD
                check(sha(lib/(MOD+".olean"))==state["endpoint_facets"][".olean"],"endpoint object changed before export")
            else:run.stage(role+"-build",[str(bins/"lean"),"-j1","-o",module+".olean",source.name],work,env)
            run.stage(role+"-export",[str(bins/"leanexport"),module,"--",*roots],work,env,role+".export")
        if not args.control:
            check(all(sha(lib/(MOD+k))==v for k,v in state["endpoint_facets"].items()),"source parent job changed an endpoint facet")
        policy={"challenge_module":"TrustedBinaryEndpoint","solution_module":target_module,"theorem_names":[target],
                "definition_names":[],"permitted_axioms":AXIOMS,"external_kernels":{"nanoda":["nanoda_bin"]}}
        conf=args.out/"comparator.json";save(conf,policy);state["protected_policy_sha256"]=sha(conf)
        pair=[args.out/"challenge.export",args.out/"solution.export"]
        for file in pair:file.chmod(0o444)
        conf.chmod(0o444);state["checker_inputs"]={f.name:{"bytes":f.stat().st_size,"sha256":sha(f)} for f in pair}
        try:
            result=run.stage("protected-kernels",sandbox(bw,prefix,conf,*pair),args.out,{"PATH":"/usr/bin:/bin","LANG":"C.UTF-8"})
        finally:
            result=args.out/"protected-kernels.log"
            messages=result.read_text("utf8",errors="replace").splitlines() if result.exists() else []
            state["kernel_markers"]={m:m in messages for m in ["nanoda kernel accepts the solution","Lean default kernel accepts the solution","Your solution is okay!"]}
        check(all(state["kernel_markers"].values()),"missing required protected acceptance markers")
        check(all(sha(f)==state["checker_inputs"][f.name]["sha256"] for f in pair),"checked export changed")
        state.update(status="accepted",success=True);return 0
    except Unavailable as ex:state.update(status="object-unavailable",reason=str(ex));return 3
    except Incomplete as ex:state.update(status="incomplete",reason=str(ex));return 124
    except Exception as ex:state.update(status="failed",reason=str(ex));return 1
    finally:
        state.update(finished_utc=now(),wall_s=round(time.monotonic()-start,3))
        run.persist();print(json.dumps({k:state[k] for k in ("kind","status","success","wall_s","reason") if k in state}),flush=True)

if __name__=="__main__":
    raise SystemExit(main())
