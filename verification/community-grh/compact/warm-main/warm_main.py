#!/usr/bin/env python3
"""Run a warm, diagnostic-only Main build against completed objects of attempt 33006912."""
import argparse
import datetime
import fcntl
import hashlib
import json
import os
from pathlib import Path
import pwd
import re
import shutil
import subprocess
import time

COMMIT = "d6b1bfd523e2c54b6e4bb72844deeddf8341879a"
TREE = "ddc22b3144b7147ce91c5c767690d9d56aac50ee"
ATTEMPT = "33006912706042b49c1ddbc13515a4fb"
RECEIPT = "5eca91028a75f56c21abfe6c9d189e5f2d02d2b6fc08997172dd2187eced650c"
RUNNER = "d9b3b1a3b1b4a97e7766349c0c6dfcc5e0eab6071935321482d2d91bdbaccf67"
LEAN = "bf8d54e4714cc4b03d3f6bb34c83b7202b87e49c8bfcbff6895c085bb90ceb38"
LAKE = "8ba83c98f76562d03b8dbc33f1057151ba6cbb121679dde76b2260ccc90495e1"
MATH = "56a005855ea17e0b0958f73ec801ae140b0a1679"
DEADLINE = int(datetime.datetime.fromisoformat("2026-11-26T10:17:24+00:00").timestamp())
MODULE = re.compile(r"[A-Za-z_]\w*(?:\.[A-Za-z_]\w*)*")
IMPORT = re.compile(r"^(?:public\s+)?(?:meta\s+)?import(?:\s+all)?\s+([A-Za-z_][\w.]*)\s*(?:--.*)?$")
SUFFIXES = {"o": [".olean", ".olean.server", ".olean.private"], "i": [".ilean"], "r": [".ir"],
            "rs": [".ir.sig"], "c": [".c"], "b": [".bc"]}
SHA = re.compile("[0-9a-f]{40}")

def insist(ok, reason):
    if not ok:
        raise ValueError(reason)

def hashfile(path):
    with path.open("rb") as handle:
        return hashlib.file_digest(handle, "sha256").hexdigest()

def git(repo, *args):
    return subprocess.check_output(["git", "--no-optional-locks", "-c", "safe.directory="+str(repo),
                                    "-C", repo, *args], env={**os.environ, "GIT_NO_REPLACE_OBJECTS":"1"})

def exact_file(root, relative):
    file = root / relative
    insist(file.is_file() and file.resolve() == file, "Expected regular retained file: "+str(file))
    return file

def list_sources(repo, pin):
    files = {}
    raw = git(repo, "ls-tree", "-r", "-z", pin, "--", "CompactGRH/src/")
    for entry in raw.split(b"\0"):
        if not entry:
            continue
        meta, pathname = entry.split(b"\t", 1)
        mode, typ, blob = meta.decode().split()
        rel = pathname.decode()
        name = rel.removeprefix("CompactGRH/src/").removesuffix(".lean").replace("/", ".")
        insist(mode == "100644" and typ == "blob" and rel.endswith(".lean") and MODULE.fullmatch(name),
                "Unknown compact source layout")
        files[name] = (rel, blob)
    return files

def read_blobs(repo, blobs):
    result = subprocess.run(["git","--no-optional-locks","-c","safe.directory="+str(repo),"-C",repo,
                             "cat-file","--batch"],env={**os.environ,"GIT_NO_REPLACE_OBJECTS":"1"},
                            input=("\n".join(blobs)+"\n").encode(),capture_output=True,check=True).stdout
    start = 0
    out = {}
    for blob in blobs:
        end = result.index(b"\n",start)
        sha, kind, length = result[start:end].decode().split()
        insist(sha == blob and kind == "blob", "Unexpected git object")
        out[blob] = result[end+1:end+1+int(length)]
        start = end+int(length)+2
    insist(start == len(result), "Unexpected Git batch trailer")
    return out

def graph(blobs, rows):
    deps = {}
    for n, (_, blob) in rows.items():
        text = blobs[blob].decode("utf-8")
        header = re.split(r"^(?:@\[expose\]\s+)?public section|^section\b",text,flags=re.M)[0]
        names = set()
        for line in header.splitlines():
            if re.match(r"^\s*(?:public\s+)?(?:meta\s+)?import\b",line):
                match = IMPORT.fullmatch(line.strip())
                insist(match is not None, "Unrecognized import header in "+n+": "+line)
                p = match[1]
                if p in rows:
                    names.add(p)
        deps[n] = names
    return deps

def closure(root, graph):
    seen = set()
    def visit(n):
        if n not in seen:
            seen.add(n)
            for p in graph[n]:
                visit(p)
    visit(root)
    return seen

def built_names(log):
    ansi = re.compile(r"\x1b\[[0-?]*[ -/]*[@-~]")
    pattern = re.compile(r"^\S+\s+\[\d+/\d+\]\s+Built\s+(\S+)\s+\(")
    return {m[1] for line in log.splitlines() if (m:=pattern.match(ansi.sub("",line)))}

def checked_trace(source, name, relative, build):
    base = name.replace(".","/")
    trace_rel = Path("lib/lean",base+".trace")
    trace = json.loads(exact_file(build,trace_rel).read_bytes())
    insist(trace["synthetic"] is False and trace["schemaVersion"] == "2025-09-10" and
           re.fullmatch("[0-9a-f]{16}",trace["depHash"]), "Invalid Lake trace")
    insist(any(row[0] == "/project/"+relative for row in trace["inputs"]), "Unmatched trace source")
    setup_rel = Path("ir",base+".setup.json")
    insist(any(row[0]=="Module.name: "+name for row in trace["inputs"]), "Wrong module in completed trace")
    # The original worker pruned setup JSON after recording a successful trace. Lake regenerates it when compiling.
    if (build/setup_rel).exists():
        setup=json.loads(exact_file(build,setup_rel).read_bytes())
        insist(setup["name"]==name and setup["isModule"] is True,"Incorrect module setup")
    outs = trace["outputs"]
    insist(outs.get("m") is True and {"o","r","rs","i","c"}.issubset(outs) and
           not (set(outs)-set(SUFFIXES)-{"m"}),"Incomplete or unknown Lake output facets")
    trace_files = [trace_rel]
    hashes = {}
    for key, suffixes in SUFFIXES.items():
        if key not in outs:
            continue
        items = outs[key] if key=="o" else [outs[key]]
        insist(isinstance(items,list) and len(items)==len(suffixes),"Missing output files")
        for item,suffix in zip(items,suffixes):
            h = item.split(".",1)[0]
            insist(re.fullmatch("[0-9a-f]{16}",h) and item == h+suffix,"Malformed Lake output digest")
            rel = Path("ir" if key in ("c","b") else "lib/lean",base+suffix)
            exact_file(build,rel)
            sidecar = Path(str(rel)+".hash")
            insist(exact_file(build,sidecar).read_text().strip()==h,"Lake sidecar disagrees with trace")
            hashes[rel] = h
            trace_files.extend((rel,sidecar))
    return trace_files,hashes

def stage_seed(old_source,new_source,old_rows,new_rows,new_graph,success,tool,helper,work):
    old_build=old_source/".lake/build"
    new_build=new_source/".lake/build"
    changed={n for n in new_rows if old_rows.get(n)!=new_rows[n]}
    elig=sorted(n for n in success & new_rows.keys() if not closure(n,new_graph)&changed)
    checked={}
    errors={}
    hash_paths=[]
    for n in elig:
        try:
            files,digests = checked_trace(old_source,n,old_rows[n][0],old_build)
            checked[n]=(files,digests)
            hash_paths.extend((n,p,h) for p,h in digests.items())
        except (KeyError,TypeError,ValueError,FileNotFoundError,IndexError) as e:
            errors[n]=str(e)
    if hash_paths:
        hashes=subprocess.run([tool/"bin/lean","--run",helper],check=True,text=True,
                 input="".join(str(old_build/p)+"\n" for _,p,_ in hash_paths),capture_output=True,
                 env={"PATH":str(tool/"bin")+":/usr/bin:/bin","HOME":"/tmp","LC_ALL":"C.UTF-8"})
        actual=hashes.stdout.splitlines()
        insist(len(actual)==len(hash_paths),"Incomplete stock Lake binary-hash verification: "+hashes.stdout[:240])
        for got,(n,p,h) in zip(actual,hash_paths):
            if got!=h:
                errors[n]="actual artifact bytes disagree with Lake trace: "+str(p)
    # Imports of missing or rejected project modules must also be rebuilt.
    okay=set(checked)-set(errors)
    eligible=sorted(n for n in okay if closure(n,new_graph)<=okay)
    copied=0
    copied_files=0
    for n in eligible:
        files,_=checked[n]
        for rel in files:
            src=exact_file(old_build,rel)
            dst=new_build/rel
            dst.parent.mkdir(exist_ok=True,parents=True)
            # copyfile creates a distinct inode. Original EBS outputs are never writable in the sandbox.
            with src.open("rb") as f, dst.open("xb") as g:
                shutil.copyfileobj(f,g,1024*1024)
            copied+=dst.stat().st_size
            copied_files+=1
    record={"changed":sorted(changed),"old_successful_in_graph":len(success & new_rows.keys()),
            "accepted":eligible,"rejected":errors,"copied_bytes":copied,"copied_files":copied_files}
    (work/"seeds.json").write_text(json.dumps(record,indent=2)+"\n")
    return record

def project_box(tool, source, packages, command, bwrap):
    cmd=[str(bwrap),"--unshare-all","--die-with-parent","--new-session","--clearenv","--proc","/proc",
         "--dev","/dev","--tmpfs","/tmp","--dir","/tmp/home"]
    for name in ("/usr","/bin","/lib","/lib64","/etc"):
        if os.path.islink(name):
            cmd += ["--symlink",os.readlink(name),name]
        elif os.path.exists(name):
            cmd += ["--ro-bind",name,name]
    cmd += ["--ro-bind",str(tool),"/tool","--ro-bind",str(source),"/project","--ro-bind",str(packages),
            "/project/.lake/packages","--bind",str(source/".lake/build"),"/project/.lake/build",
            "--bind",str(source/".lake/config"),"/project/.lake/config","--setenv","HOME","/tmp/home",
            "--setenv","PATH","/tool/bin:/usr/bin:/bin","--setenv","LANG","C.UTF-8",
            "--setenv","LEAN_NUM_THREADS","4","--setenv","LEAN_ABORT_ON_PANIC","1",
            "--setenv","LAKE_ARTIFACT_CACHE","false","--chdir","/project",*command]
    return cmd

def run_lake(tool,source,packages,work,bwrap,deadline):
    remaining=min(7200,deadline-time.time()-120)
    insist(remaining>=60,"Too close to original stop")
    cmd=project_box(tool,source,packages,["/tool/bin/lake","--no-cache","build","+Main"],bwrap)
    start=time.monotonic()
    with (work/"warm-main.log").open("xb") as fp:
        # timeout owns the subprocess group, including sandbox child. Existing host timer is independent.
        rc=subprocess.run(["timeout","--kill-after=15",str(int(remaining))+"s",*cmd],stdout=fp,
            stderr=subprocess.STDOUT).returncode
    log=(work/"warm-main.log").read_text(errors="replace")
    result={"kind":"warm GRH source diagnostic","root":"+Main","verdict":"diagnostic only",
            "exit":rc,"wall_seconds":round(time.monotonic()-start,3),"log_sha256":hashfile(work/"warm-main.log"),
            "newly_built":sorted(built_names(log)),
            "failed_source_locations":re.findall(r"(?m)^error:\s*([^\n]+?\.lean:\d+:\d+):",log)}
    (work/"result.json").write_text(json.dumps(result,indent=2)+"\n")
    return result

def source_input(repo,pin,tree):
    insist(SHA.fullmatch(pin) and SHA.fullmatch(tree),"Expected full source IDs")
    insist(git(repo,"rev-parse",pin+"^{commit}",pin+"^{tree}").decode().split()==[pin,tree],
            "Requested Git commit/tree disagree")

def main():
    p=argparse.ArgumentParser(description=__doc__)
    for key in ["commit","tree","receipt-sha","deadline-epoch","source-repo","output"]:
        p.add_argument("--"+key,required=True)
    a=p.parse_args()
    insist(os.getuid()==pwd.getpwnam("grhreplay").pw_uid!=0,"Use the dedicated unprivileged service account")
    insist(Path("/proc/self/cgroup").read_text().strip()=="0::/system.slice/tg-warm-main.service",
           "Expected the sole warm replay service")
    cgroup=Path("/sys/fs/cgroup/system.slice/tg-warm-main.service")
    quota,period=map(int,(cgroup/"cpu.max").read_text().split())
    insist(0<quota<=16*period and 0<int((cgroup/"memory.high").read_text())<=48*2**30
           and 0<int((cgroup/"memory.max").read_text())<=64*2**30
           and (cgroup/"memory.swap.max").read_text().strip()=="0","Missing CPU/memory/swap guard")
    insist(int(a.deadline_epoch)==DEADLINE and time.time()+180<DEADLINE,"Wrong or expired original stop")
    for service in ("tg-source-replay.service","tg-joint-replay.service","tg-warm-patch-probe.service"):
        events=Path("/sys/fs/cgroup/system.slice")/service/"cgroup.events"
        insist(not events.exists() or "populated 1" not in events.read_text(),"Another replay unit is populated: "+service)
    with open("/run/lock/tg-joint-worker.lock","rb") as lease:
        try:
            fcntl.flock(lease,fcntl.LOCK_EX|fcntl.LOCK_NB)
        except BlockingIOError:
            pass
        else:
            fcntl.flock(lease,fcntl.LOCK_UN)
            raise ValueError("Sole owning worker lock is absent")
    old=Path("/work/compact-joint-runs")/(COMMIT+"-"+ATTEMPT)/"run"
    evidence=old/"evidence";source=old/"source"
    rf=exact_file(evidence,"receipt.json")
    insist(a.receipt_sha==RECEIPT and hashfile(rf)==RECEIPT,
           "Receipt hash mismatch")
    r=json.loads(rf.read_bytes())
    insist(r["root"]==str(old) and r["pin"]==COMMIT and r["git_tree"]==TREE and r["status"]=="failed"
           and r["project_lake_threads"]["effective"]==4 and r["runner_sha256"]==RUNNER
           and (old.parent/"driver.exit").read_text().strip()=="1",
           "Wrong or nonterminal original attempt")
    stage=[s for s in r["steps"] if s["name"]=="source-preflight"]
    log=exact_file(evidence,"source-preflight.log")
    insist(len(stage)==1 and stage[0]["exit"]!=0 and stage[0]["log_sha256"]==hashfile(log),
           "Expected authenticated failed source-preflight stage")
    tool=Path(r["toolchain_path"])
    insist(tool.resolve()==tool and hashfile(tool/"bin/lean")==r["tool_sha256"]["lean"]==LEAN
           and hashfile(tool/"bin/lake")==r["tool_sha256"]["lake"]==LAKE,"Stock tool identity mismatch")
    repo=Path(a.source_repo).resolve(strict=True)
    oldrepo=source.resolve(strict=True)
    source_input(oldrepo,COMMIT,TREE); source_input(repo,a.commit,a.tree)
    old_rows=list_sources(oldrepo,COMMIT); new_rows=list_sources(repo,a.commit)
    insist(len(old_rows)==794 and old_rows.keys()==new_rows.keys(),"Expected identical sets of 794 source paths")
    fresh=read_blobs(repo,[b for _,b in new_rows.values()])
    for rel,blob in old_rows.values():
        data=exact_file(source,rel).read_bytes()
        insist(hashlib.sha1(b"blob "+str(len(data)).encode()+b"\0"+data).hexdigest()==blob,"Old source modified: "+rel)
    graph_now=graph(fresh,new_rows)
    insist(closure("Main",graph_now)==set(new_rows),"Main does not reach exactly 794 compact modules")
    cfg={}
    for f in ["lakefile.toml","lean-toolchain","lake-manifest.json"]:
        cfg[f]=git(repo,"show",a.commit+":"+f)
        insist(cfg[f]==git(oldrepo,"show",COMMIT+":"+f)==exact_file(source,f).read_bytes(),
               "Package configuration or compiler changed: "+f)
    insist(hashfile(source/"lake-manifest.json")==r["manifest_sha256"],"Retained manifest digest mismatch")
    pack=source/".lake/packages"
    manifest=json.loads(cfg["lake-manifest.json"])
    pins={q["name"]:q["rev"] for q in manifest["packages"]}
    insist(pins==r["packages"] and pins["mathlib"]==MATH,"Dependency package pins changed")
    for name,rev in pins.items():
        insist(re.fullmatch(r"[-\w]+",name) and SHA.fullmatch(rev),"Invalid dependency pin")
        check=pack/name
        insist(check.is_dir() and check.resolve()==check and git(check,"rev-parse","HEAD").decode().strip()==rev,
               "Wrong retained dependency "+name)
        git(check,"diff","--quiet","HEAD","--")
    work=Path(a.output)
    insist(work.parent==Path("/work/tg-warm-diagnostics") and work.parent.resolve()==work.parent and
           re.fullmatch(r"[a-f0-9]{40}-[a-f0-9]{32}",work.name) and work.name.startswith(a.commit+"-"),
           "Fresh diagnostic output must be beneath the dedicated root")
    insist(os.stat(work.parent).st_dev==os.stat(source).st_dev and shutil.disk_usage(work.parent).free>=12*2**30,
           "Missing space on original volume")
    work.mkdir(mode=0o750); new=work/"source";new.mkdir()
    for f,v in cfg.items(): (new/f).write_bytes(v)
    for rel,blob in new_rows.values():
        dst=new/rel;dst.parent.mkdir(exist_ok=True,parents=True);dst.write_bytes(fresh[blob])
    for sub in ("build","config","packages"):(new/".lake"/sub).mkdir(exist_ok=True,parents=True)
    seed=stage_seed(source,new,old_rows,new_rows,graph_now,built_names(log.read_text(errors="replace")),
                    tool,Path(__file__).resolve().with_name("WarmArtifactHashes.lean"),work)
    result=run_lake(tool,new,pack,work,shutil.which("bwrap") or "/usr/bin/bwrap",DEADLINE)
    result.update(source_commit=a.commit,source_tree=a.tree,parent_receipt=a.receipt_sha,eligible=len(seed["accepted"]))
    (work/"result.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:result[k] for k in ["kind","root","exit","wall_seconds","log_sha256","eligible","failed_source_locations"]}),flush=True)
    return result["exit"]

if __name__=="__main__":
    raise SystemExit(main())
