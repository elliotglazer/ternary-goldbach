#!/usr/bin/env python3
"""Source-bound warm assembly of the two original Goldbach solution modules."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import sys
import time

HELPER = "65ce0a4ace395459efa319eba1bff721e0158c71e31f2b674827ac4b013bdaa7"
SESSION = "33006912706042b49c1ddbc13515a4fb"
RECEIPT = "5eca91028a75f56c21abfe6c9d189e5f2d02d2b6fc08997172dd2187eced650c"
GRH = "333aa9bb21fd87ef1f6be2159dbffc2c8da75962"
GRH_TREE = "0a3e5b8486771b3ca1acaa2cb465ff756e52c5e2"
FINITE = "24954b2814714e7fe324bcdc0304c0a9ddefb909"
FINITE_TREE = "ffbd19a22cf91aab3933995029b20d5cbce0a246"
PACKAGES = Path("/work/compact-joint-runs/d6b1bfd523e2c54b6e4bb72844deeddf8341879a-"+SESSION+"/run/source/.lake/packages")
GRAPH = {"grh":"Main", "finite":"CompletedFiniteRows"}
FINAL = ("CompletedGoldbach","GoldbachSolution","PalomarTernaryGoldbach.ternary_goldbach")
FACETS = {".olean":("o",0),".olean.server":("o",1),".olean.private":("o",2),".ir":("r",None),".ir.sig":("rs",None)}
LINE = re.compile(r"(?:(?:public|meta|private)\s+)*import(?:\s+all)?\s+([A-Za-z_][\w.]*)\s*(?:--.*)?$")
WORK = Path("/work/tg-warm-diagnostics")
QUEUE = Path("/var/lib/tg-warm-main/session-"+SESSION+"/jobs")
HASH_LEAN = """import Lake.Build.Trace
def main : IO Unit := do
  let inp ← IO.getStdin
  let out ← IO.getStdout
  repeat
    let line ← inp.getLine
    if line.isEmpty then break
    let text := line.trimAsciiEnd.toString
    let value ← match text.splitOn "\\t" with
      | ["file", path] => Lake.computeBinFileHash path
      | ["source", path] => Lake.computeTextFileHash path
      | "external" :: paths => do
        let mut hash := (Lake.BuildTrace.nil "imports").hash
        for path in paths do
          hash := hash.mix (← Lake.computeBinFileHash path)
        pure hash
      | "mix" :: parts => do
        let mut hash := (Lake.BuildTrace.nil "imports").hash
        for hex in parts do
          let some parent := Lake.Hash.ofHex? hex | throw <| IO.userError "malformed hash"
          hash := hash.mix parent
        pure hash
      | _ => throw <| IO.userError "malformed input"
    out.putStrLn value.toString
"""

def require(ok,msg):
    if not ok:
        raise ValueError(str(msg))

def digest(path):
    with path.open("rb") as file:
        return hashlib.file_digest(file,"sha256").hexdigest()

def exact(root,rel):
    path=root/rel
    require(path.is_file() and path.resolve()==path,("file missing or links outside root",path))
    return path

def root_owned(file):
    for path in (file,*file.parents):
        require(path.stat().st_uid==0 and not path.stat().st_mode & 0o022,("unsealed evidence",path))

def jsonfile(path):
    return json.loads(path.read_bytes())

def git(repo,*args):
    return subprocess.check_output(["git","--no-optional-locks","-c","safe.directory="+str(repo),"-C",repo,*args],
                                  env={**os.environ,"GIT_NO_REPLACE_OBJECTS":"1"})

def attest(work,job,root,pin,tree,fixture=False):
    for name in ["status.json","warm-main-driver.log"]:
        path=exact(job,name)
        if not fixture:
            root_owned(path)
    st=jsonfile(job/"status.json")
    req=st["job"]
    require((req["commit"],req["tree"],req["token"],req.get("root","Main"),req["receipt_sha"],req["main"])==
            (pin,tree,job.name,root,RECEIPT,True),"wrong supervisor request for "+root)
    require(st["kind"]=="warm diagnostics only" and st.get("finished_unix") and not st.get("error") and
            st["old_receipt_sha256"]==RECEIPT and st["warm_main_exit"]==0 and st["warm_main_output"]==str(work),
            "missing successful terminal supervisor record for "+root)
    result=jsonfile(exact(work,"result.json"))
    anchor=[json.loads(line) for line in (job/"warm-main-driver.log").read_text().splitlines() if line.startswith("{")]
    require(len(anchor)==1,"expected one signed-off driver result for "+root)
    anchor=anchor[0]
    for row in (anchor,result):
        require(row["exit"]==0 and row["root"]=="+"+root and row["log_sha256"]==digest(exact(work,"warm-main.log")),
                "driver/result/build log disagree for "+root)
    require(result["kind"]==anchor["kind"] and result["source_commit"]==pin and result["source_tree"]==tree and
            result["parent_receipt"]==RECEIPT and not result.get("failed_source_locations"),
            "result not bound to the requested source")
    require(git(job/"candidate.git","rev-parse",pin+"^{commit}",pin+"^{tree}").decode().split()==[pin,tree],
            "checkout does not have expected immutable commit/tree")
    return {"source_commit":pin,"source_tree":tree,"root":root,"root_job":job.name,
            "result_sha256":digest(work/"result.json"),"status_sha256":digest(job/"status.json"),
            "driver_sha256":digest(job/"warm-main-driver.log"),"log_sha256":result["log_sha256"]}

def map_sources(tree):
    mapped={}
    for rel,blob in tree.items():
        path=rel.removeprefix("CompactGRH/src/") if rel.startswith("CompactGRH/src/") else rel
        if path.endswith(".lean") and re.fullmatch(r"(?:[A-Za-z_]\w*/)*[A-Za-z_]\w*\.lean",path):
            name=path[:-5].replace("/",".")
            # Prefer the compact module when its tracked srcDir exists. Many ancillary nonbuild paths
            # are indexed too; only the real compiler header's reachable module names are consumed.
            require(name not in mapped,("ambiguous project source",name))
            mapped[name]=(rel,blob)
    return mapped

def project_file(source,rel,blob):
    path=exact(source,rel)
    size=path.stat().st_size
    git_sha=hashlib.sha1(("blob "+str(size)+"\0").encode())
    with path.open("rb") as f:
        prefix=f.read(65536)
        git_sha.update(prefix)
        while data:=f.read(1024*1024):
            git_sha.update(data)
    require(git_sha.hexdigest()==blob,("project working source mismatch",rel))
    return prefix,size

def imports(header,name):
    text=header.decode("utf8",errors="ignore")
    names=[]
    for line in text.splitlines():
        stripped=line.strip()
        if re.match(r"(?:(?:public|meta|private)\s+)*import\b",stripped):
            match=LINE.fullmatch(stripped)
            require(match,("unrecognized import",name,stripped))
            names.append(match[1])
        elif stripped.startswith(("@[expose] public section","public section","noncomputable section","namespace ")):
            break
    return list(dict.fromkeys(names))

def object_trace(source,name,rel,hashes,fixture=False):
    root=source/".lake/build/lib/lean"
    stem=name.replace(".","/")
    trace_path=exact(root,stem+".trace");trace=jsonfile(trace_path)
    require(trace.get("synthetic") is False and trace["schemaVersion"]=="2025-09-10" and
            re.fullmatch("[0-9a-f]{16}",trace["depHash"]),("invalid source-build trace",name))
    rows=dict(trace["inputs"]);names=list(rows)
    require(any(n.startswith("Lean 4.35.0, commit "+h.VERSION) for n in names),("wrong trace toolchain",name))
    require("Module.name: "+name in names and "/project/"+rel in names,("wrong trace source or module",name))
    source_digest=rows["/project/"+rel];hashes[("source",str(source/rel))]=source_digest
    imported=dict(rows["deps"])["imports"]
    direct={} if isinstance(imported,str) else {key:val for key,val in imported if ":import" in key}
    out=trace["outputs"];require(out.get("m") is True,("not an ordinary module",name))
    signed={}
    for suffix,(kind,index) in FACETS.items():
        token=out[kind][index] if index is not None else out[kind]
        require(re.fullmatch(r"[0-9a-f]{16}"+re.escape(suffix),token),("malformed facet",name,token))
        path=exact(root,stem+suffix);side=exact(root,stem+suffix+".hash")
        require(side.read_text().strip()==token[:16],("lake recorded facet mismatch",name,suffix))
        hashes[("file",str(path))]=token[:16];signed[suffix]=token[:16]
    return {"trace_sha256":digest(trace_path),"dep_hash":trace["depHash"],"facet_lake_hashes":signed,"direct_import_hashes":direct,"source_lake_hash":source_digest}

def traverse(role,root,source,orig,target,hashes,deadline,external):
    seen={};todo=[root]
    while todo:
        h.check_clock(deadline)
        n=todo.pop()
        if n in seen:continue
        require(n in orig and orig[n]==target.get(n),("source differs across pins",role,n))
        rel,blob=orig[n];prefix,size=project_file(source,rel,blob)
        parents=imports(prefix,n);project=[p for p in parents if p in orig]
        require(all((p in orig)==(p in target) for p in parents),("import changed origin across pins",n))
        require(all(p in orig or external(p) for p in parents),("missing original import",n))
        seen[n]={"path":rel,"source_git_blob":blob,"bytes":size,"project_imports":project,
                 **object_trace(source,n,rel,hashes)}
        todo.extend(project)
    return seen

def box(bw,tool,pack,source,imports_dir,out,roots,pkg_names,command):
    cmd=[str(bw),"--unshare-all","--die-with-parent","--new-session","--clearenv","--proc","/proc",
         "--dev","/dev","--tmpfs","/tmp","--dir","/tmp/home","--dir","/inputs"]
    for path in map(Path,["/usr","/bin","/lib","/lib64","/etc"]):
        if path.is_symlink():cmd+=["--symlink",os.readlink(path),str(path)]
        elif path.exists():cmd+=["--ro-bind",str(path),str(path)]
    for src,dst in [(tool,"/tool"),(source,"/src"),(imports_dir,"/parents"),(pack,"/packages")]:
        cmd+=["--ro-bind",str(src),dst]
    for role,lib in roots.items():cmd+=["--ro-bind",str(lib),"/inputs/"+role]
    cmd+=["--bind",str(out),"/objects"]
    search=["/objects","/parents"]+["/packages/"+p+"/.lake/build/lib/lean" for p in pkg_names]
    for k,v in {"PATH":"/tool/bin:/usr/bin:/bin","HOME":"/tmp/home","LEAN_PATH":":".join(search),
                "LEAN_NUM_THREADS":"1","LEAN_ABORT_ON_PANIC":"1","LANG":"C.UTF-8"}.items():cmd+=["--setenv",k,v]
    return cmd+["--chdir","/src",*command]

def bind_modules(inputs,graphs):
    choices={}
    for role,graph in graphs.items():
        for name,row in graph.items():
            if name in choices:
                prior=graphs[choices[name]][name]
                require(prior["source_git_blob"]==row["source_git_blob"] and prior["facet_lake_hashes"]==row["facet_lake_hashes"],
                        ("overlapping parent facets disagree",name))
                continue
            choices[name]=role
            stem=name.replace(".","/")
            for suffix in FACETS:
                path=inputs/(stem+suffix);path.parent.mkdir(parents=True,exist_ok=True)
                path.symlink_to("/inputs/"+role+"/"+stem+suffix)
    return choices

def check_hashes(tool,work,hashes):
    helper=work/"hash-inputs.lean";helper.write_text(HASH_LEAN)
    result=subprocess.run([tool/"bin/lean","--run",helper],input="".join("\t".join(line)+"\n" for line in hashes),
                          text=True,capture_output=True,env={"HOME":"/tmp","PATH":str(tool/"bin")+":/usr/bin:/bin","LANG":"C.UTF-8"})
    require(result.returncode==0,result.stderr[-800:])
    digests=result.stdout.splitlines()
    require(len(digests)==len(hashes),"Lake failed to hash all parent bytes")
    for actual,(path,expected) in zip(digests,hashes.items()):
        require(actual==expected,("parent artifact bytes fail original Lake digest",path,actual,expected))

def axiom_line(log,name,allowed):
    text=log.read_text("utf8")
    m=re.search("^'"+re.escape(name)+r"' depends on axioms: \[([^\]]*)\]$",text,re.M)
    if m:observed=set(m[1].split(", ")) if m[1] else set()
    else:
        require("'"+name+"' does not depend on any axioms" in text,("missing axiom report",name,text[-300:]))
        observed=set()
    require(observed<=set(allowed) and "declaration uses 'sorry'" not in text,("unexpected axiom",name,observed))
    return sorted(observed)

def run_joint(a,run,fixture=False):
    final=FINAL if not fixture else ("FixtureJoint","FixtureSolution","Fixture.positive")
    roots=GRAPH if not fixture else {"grh":"FixtureLeft","finite":"FixtureRight"}
    outs=a.out
    src=outs/"src";inputs=outs/"imports";objs=outs/"objects"
    for d in (src,inputs,objs):d.mkdir()
    if not fixture:require(a.packages==PACKAGES.resolve(),"packages are not the shared producer store")
    tool=a.toolchain; bw=a.bwrap
    require(digest(tool/"bin/lean")==h.TOOLS["lean"],"incorrect stock Lean")
    jobs={r:getattr(a,r+"_job") for r in roots}
    works={r:getattr(a,r+"_work") for r in roots}
    pins={r:getattr(a,r+"_commit") for r in roots}
    trees={r:getattr(a,r+"_tree") for r in roots}
    if not fixture:
        for r in roots:
            require(jobs[r].parent==QUEUE and re.fullmatch("[0-9a-f]{32}",jobs[r].name) and
                    works[r]==WORK/(pins[r]+"-"+jobs[r].name),("wrong canonical worker locations",r))
    for r in roots:
        run.receipt["parents"][r]=attest(works[r],jobs[r],roots[r],pins[r],trees[r],fixture)
    run.persist()
    pinrepo=jobs["grh"]/"candidate.git"
    whole={r:h.git_tree(jobs[r]/"candidate.git",pins[r]) for r in roots}
    sources={r:map_sources(whole[r]) for r in roots}
    for n in ("lean-toolchain","lakefile.toml","lake-manifest.json"):
        require(whole["grh"].get(n) and whole["grh"][n]==whole["finite"].get(n),("different Lake configuration",n))
        for r in roots:project_file(works[r]/"source",n,whole[r][n])
    if not fixture:
        pkg_dirs,pkg_versions=h.packages(pinrepo,pins["grh"],a.packages);pkg_names=[p.parents[3].name for p in pkg_dirs]
    else:
        pkg_dirs=list(a.packages.glob("*/.lake/build/lib/lean"));pkg_names=[p.parents[3].name for p in pkg_dirs]
        pkg_versions={"fixture":True}
    run.receipt["packages"]=pkg_versions
    libpaths={r:works[r]/"source/.lake/build/lib/lean" for r in roots}
    def external(n):return any((p/(n.replace(".","/")+".olean")).is_file() for p in [tool/"lib/lean",*pkg_dirs])
    hashes={};graphs={}
    for r in roots:
        graphs[r]=traverse(r,roots[r],works[r]/"source",sources[r],sources["grh"],hashes,run.due,external)
    expected={"grh":(794,"d7a090b4721a5f0d9835537871dc17d8002a6cecf29c1edef3e1c923e6962414"),"finite":(732,"3ddd83c87bd72d982bde5478e61941d12e634244f559e08364b30977b957f6b1")}
    for role,graph in graphs.items():
        canonical=sorted((n,[v["path"],v["source_git_blob"],v["project_imports"]]) for n,v in graph.items())
        fingerprint=hashlib.sha256(json.dumps(canonical,separators=(",",":")).encode()).hexdigest()
        if not fixture and pins[role]=={"grh":GRH,"finite":FINITE}[role]:
            require((len(graph),fingerprint)==expected[role],("pinned closure mismatch",role,len(graph),fingerprint))
        for n,row in graph.items():
            for parent in row["project_imports"]:
                fields={"importArts":[".olean"],"importArts (meta)":[".olean",".ir.sig",".ir"],
                        "importAllArts":[".olean",".olean.server",".olean.private",".ir.sig",".ir"]}
                matches=[(k,row["direct_import_hashes"][parent+":"+k]) for k in fields if parent+":"+k in row["direct_import_hashes"]]
                require(matches,("missing actual direct parent in original Lake trace",n,parent))
                for kind,want in matches:
                    key=("mix",*(graph[parent]["facet_lake_hashes"][s] for s in fields[kind]))
                    require(key not in hashes or hashes[key]==want,("inconsistent parent fingerprint",n,parent))
                    hashes[key]=want
            for caption,want in row["direct_import_hashes"].items():
                parent,kind=caption.rsplit(":",1)
                if parent in graph:continue
                ph=parent.replace(".","/")
                lib=next((p for p in [*pkg_dirs,tool/"lib/lean"] if (p/(ph+".olean")).is_file()),None)
                require(lib is not None,("missing external import",n,parent))
                kinds={"importArts":[".olean"],"importArts (meta)":[".olean",".ir.sig",".ir"],
                       "importAllArts":[".olean",".olean.server",".olean.private",".ir.sig",".ir"]}
                suffixes=kinds[kind] if (lib/(ph+".ir.sig")).is_file() else [".olean"]
                key=("external",*(str(exact(lib,ph+x)) for x in suffixes))
                require(key not in hashes or hashes[key]==want,("different external package artifact in the two proofs",n,parent))
                hashes[key]=want
    check_hashes(tool,outs,hashes)
    selected=bind_modules(inputs,graphs)
    for r in roots:
        h.save(outs/(r+"-closure.json"),graphs[r])
        run.receipt["parents"][r].update(modules=len(graphs[r]),closure_sha256=digest(outs/(r+"-closure.json")))
    run.receipt["actual_lake_facets_verified"]=sum(k[0]=="file" for k in hashes)
    run.receipt["actual_source_traces_verified"]=sum(k[0]=="source" for k in hashes)
    run.receipt["distinct_parent_import_hashes_verified"]=sum(k[0]=="mix" for k in hashes)
    run.receipt["distinct_external_import_hashes_verified"]=sum(k[0]=="external" for k in hashes)
    for n in final[:2]:
        rel,blob=sources["grh"][n]
        require(sources["finite"][n]==(rel,blob),"source glue differs across pins")
        st=git(pinrepo,"show",pins["grh"]+":"+rel);(src/(n+".lean")).write_bytes(st)
        ps=imports(st,n)
        expected=[*roots.values()] if n==final[0] else [final[0]]
        require(ps==expected,("unexpected glue imports",n,ps))
    op=lambda cmd:box(bw,tool,a.packages,src,inputs,objs,libpaths,pkg_names,cmd)
    for n in final[:2]:
        run.stage("compile-"+n,op(["/tool/bin/lean","-j1","--tstack=400000","-o","/objects/"+n+".olean",n+".lean"]),outs)
    audit=src/"FreshTheorem.lean"
    audit.write_text("module\npublic import "+final[1]+"\n#check "+final[2]+"\n#print axioms "+final[2]+"\n")
    log=run.stage("fresh-import",op(["/tool/bin/lean","-j1",audit.name]),outs)
    ax=axiom_line(log,final[2],h.AXIOMS)
    run.receipt.update(warm_frontend_passed=True,observed_axioms=ax,theorem=final[2],
                       distinct_imported_modules=len(selected),warm_outputs={n:{
                           "source_sha256":digest(src/(n+".lean")),"oleans":{s:digest(objs/(n+s)) for s in FACETS}}
                           for n in final[:2]})
    run.persist();portable(run)
    if a.protected:
        protected(a,run,op,final,src,objs,pinrepo,pins["grh"],pkg_names,fixture)

def protected(a,run,op,final,src,objs,repo,pin,pkgs,fixture=False):
    for n in ("leanexport","lake","nanoda_bin","leanchecker"):
        require(digest(a.toolchain/"bin"/n)==h.TOOLS[n],"incorrect protected program "+n)
    challenge="FixtureChallenge" if fixture else "GoldbachChallenge"
    (src/(challenge+".lean")).write_bytes(git(repo,"show",pin+":"+challenge+".lean"))
    config=json.loads(git(repo,"show",pin+":comparator.json"))
    require(config["challenge_module"]==challenge and config["solution_module"]==final[1] and
            config["theorem_names"]==[final[2]] and set(config["permitted_axioms"])==set(h.AXIOMS) and
            config["definition_names"]==[],"changed comparison policy")
    # The challenge is compiled in isolation with only its pinned source and authentic dependencies.
    separate=a.out/"trusted-challenge";separate.mkdir()
    (separate/(challenge+".lean")).write_bytes((src/(challenge+".lean")).read_bytes())
    empty=a.out/"empty";empty.mkdir();co=a.out/"challenge-objects";co.mkdir()
    challenge_cmd=lambda cmd:box(a.bwrap,a.toolchain,a.packages,separate,empty,co,{},pkgs,cmd)
    run.stage("challenge-build",challenge_cmd(["/tool/bin/lean","-j1","-o","/objects/"+challenge+".olean",challenge+".lean"]),a.out)
    names=["Quot","Quot.mk","Quot.lift","Quot.ind",final[2],*h.AXIOMS,*h.EXTRAS]
    for role,cmd,module in [("challenge",challenge_cmd,challenge),("solution",op,final[1])]:
        run.stage(role+"-export",cmd(["/tool/bin/leanexport",module,"--",*names]),a.out,export=role+".export")
    config["external_kernels"]={"nanoda":["nanoda_bin"]}
    policy=a.out/"protected-config.json";h.save(policy,config);policy.chmod(0o444)
    pair=[a.out/"challenge.export",a.out/"solution.export"]
    for file in pair:file.chmod(0o444)
    before={p.name:{"bytes":p.stat().st_size,"sha256":digest(p)} for p in pair}
    run.receipt["protected_inputs"]=before;run.persist()
    log=run.stage("protected-kernels",h.sandbox(a.bwrap,a.toolchain,policy,*pair),a.out)
    markers=log.read_text().splitlines()
    require(all(m in markers for m in ["nanoda kernel accepts the solution","Lean default kernel accepts the solution","Your solution is okay!"]),"protected verifier lacks complete acceptance")
    require(all(digest(p)==before[p.name]["sha256"] for p in pair),"an export changed after verification")
    run.receipt["protected_full_theorem_passed"]=True;run.persist()

def portable(run):
    state=run.receipt
    subset=lambda row,keys:{k:row[k] for k in keys if k in row}
    data=subset(state,["kind","status","warm_frontend_passed","protected_full_theorem_passed","theorem",
                       "observed_axioms","worker_sha256","distinct_imported_modules","actual_lake_facets_verified",
                       "actual_source_traces_verified","distinct_parent_import_hashes_verified",
                       "distinct_external_import_hashes_verified","warm_outputs","protected_inputs","wall_seconds"])
    data["parents"]={n:subset(x,["source_commit","source_tree","root","modules","closure_sha256"]) for n,x in state["parents"].items()}
    data["stages"]={n:subset(x,["status","exit","wall_s","user_cpu_s","system_cpu_s","log_sha256"])
                    for n,x in state["stages"].items()}
    h.save(run.out/"portable.json",data)

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    for role,default,tree in [("grh",GRH,GRH_TREE),("finite",FINITE,FINITE_TREE)]:
        parser.add_argument("--"+role+"-job",type=Path,required=True);parser.add_argument("--"+role+"-work",type=Path)
        parser.add_argument("--"+role+"-commit",default=default);parser.add_argument("--"+role+"-tree",default=tree)
    parser.add_argument("--packages",type=Path,default=PACKAGES)
    parser.add_argument("--toolchain",type=Path,default=Path("/work/compact-joint-435-verified-tools/lean-4.35.0-linux"))
    parser.add_argument("--bwrap",type=Path,default=Path("/usr/bin/bwrap"))
    parser.add_argument("--out",type=Path,required=True);parser.add_argument("--deadline-seconds",type=float,default=1800)
    parser.add_argument("--protected",action="store_true");parser.add_argument("--fixture",action="store_true",help=argparse.SUPPRESS)
    a=parser.parse_args()
    global h
    helper=Path(__file__).resolve().with_name("binary_endpoint.py");require(digest(helper)==HELPER,"utility digest mismatch")
    spec=importlib.util.spec_from_file_location("binary_endpoint",helper);h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
    for k in ("packages","toolchain","bwrap","out","grh_job","finite_job"):setattr(a,k,getattr(a,k).resolve())
    for r in ("grh","finite"):
        work=getattr(a,r+"_work") or WORK/(getattr(a,r+"_commit")+"-"+getattr(a,r+"_job").name)
        setattr(a,r+"_work",work.resolve())
    require(os.geteuid()!=0,"must run the proof as an unprivileged user")
    a.out.mkdir(parents=True,exist_ok=False)
    for sig in (signal.SIGTERM,signal.SIGINT,signal.SIGHUP):signal.signal(sig,h.marker)
    state={"kind":"two-root-fixture" if a.fixture else "warm two-root source-bound Goldbach join",
           "success":False,"warm_frontend_passed":False,"protected_full_theorem_passed":False,"parents":{},"stages":{},
           "worker_sha256":digest(Path(__file__)),"uid":os.geteuid(),"started_utc":h.now(),"status":"preflight"}
    start=time.monotonic();run=h.Runner(a.out,start+a.deadline_seconds,state);run.persist()
    try:
        run_joint(a,run,a.fixture)
        state.update(status="accepted",success=True);return 0
    except h.Incomplete as e:state.update(status="interrupted",reason=str(e));return 124
    except Exception as e:state.update(status="failed",reason=str(e));return 1
    finally:
        state.update(finished_utc=h.now(),wall_seconds=round(time.monotonic()-start,3));run.persist();portable(run)
        print(json.dumps({k:state.get(k) for k in ("kind","status","warm_frontend_passed","protected_full_theorem_passed","reason","wall_seconds")}),flush=True)

if __name__=="__main__":sys.exit(main())
