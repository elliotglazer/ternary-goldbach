#!/usr/bin/env python3
"""Fresh, pinned community GRH source replay on a dedicated Linux builder."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import resource
import shutil
import subprocess
import sys
import threading
import time

PIN = "756a70250dcba9162b99d4ea35c186558434c17e"
TREE = "5744eb34797ed52149916cf81104488e0628c001"
REPO = "https://github.com/leanprover-community/riemann-hypothesis"
TC = "leanprover/lean4:v4.37.0-rc1"
MATH = "31ce06eaadf4a200c0e1407c5f10953cf606b8f8"
TARGETS = ["riemannHypothesis", "riemannZeta_eq_zero_re", "LFunction_ne_zero_of_half_lt_re",
           "LFunction_eq_zero_re", "LFunction_eq_zero_re_of_isPrimitive"]
AX = {"propext", "Quot.sound", "Classical.choice"}


def digest(path):
    with path.open("rb") as f:
        return hashlib.file_digest(f, "sha256").hexdigest()


def require(test, message):
    if not test:
        raise RuntimeError(message)


def save(path, obj):
    temporary = path.with_suffix(".tmp")
    temporary.write_text(json.dumps(obj, indent=2, sort_keys=True) + "\n")
    temporary.replace(path)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-dir", type=Path, required=True)
    args = parser.parse_args()
    root = args.run_dir.resolve()
    require(platform.system() == "Linux" and os.geteuid() != 0, "use a dedicated non-root Linux user")
    require(sys.version_info >= (3,11), "Python >=3.11 required")
    root.mkdir(mode=0o700, parents=False, exist_ok=False)
    evidence = root / "evidence"
    evidence.mkdir()
    source = root / "source"
    challenge = root / "challenge"
    empty = root / "judge"
    empty.mkdir()
    state = {"status":"running", "pin":PIN, "git_tree":TREE, "steps":[], "resource_scope":
             "GNU time per command; peak RSS is per process, not total live working set",
             "runner_sha256":digest(Path(__file__).resolve()), "root":str(root),
             "platform":platform.platform(), "started_unix":time.time()}
    receipt = evidence / "receipt.json"
    save(receipt, state)
    stop = threading.Event()
    stats = {"setup_files_removed":0, "logical_bytes_released":0}
    clean_error = []

    def prune():
        while not stop.wait(120):
            try:
                ir = source / ".lake/build/ir"
                lib = source / ".lake/build/lib/lean"
                for parent, _, files in os.walk(ir):
                    for name in files:
                        if not name.endswith(".setup.json"):
                            continue
                        path = Path(parent) / name
                        trace = lib / path.relative_to(ir).with_name(name[:-11] + ".trace")
                        try:
                            old = path.lstat()
                            if path.is_file() and not path.is_symlink() and trace.is_file() and trace.stat().st_mtime_ns > old.st_mtime_ns:
                                path.unlink()
                                stats["setup_files_removed"] += 1
                                stats["logical_bytes_released"] += old.st_size
                        except FileNotFoundError:
                            pass
            except Exception as exc:
                clean_error.append(str(exc))
                return

    def step(name, cmd, cwd=None, output=None, env=None):
        log = evidence / (name + ".log")
        usage = evidence / (name + ".time")
        record = {"name":name,"argv":list(map(str,cmd)),"cwd":str(cwd or root),"start":time.time()}
        state["steps"].append(record)
        save(receipt,state)
        print(time.strftime("%Y-%m-%dT%H:%M:%SZ",time.gmtime()),name,flush=True)
        with log.open("xb") as err:
            if output is None:
                rc = subprocess.call(["/usr/bin/time","-v","-o",usage,*cmd],cwd=cwd or root,env=env,stdout=err,stderr=subprocess.STDOUT)
            else:
                with output.open("xb") as out:
                    rc = subprocess.call(["/usr/bin/time","-v","-o",usage,*cmd],cwd=cwd or root,env=env,stdout=out,stderr=err)
        record.update(exit=rc,end=time.time(),log_sha256=digest(log),time_sha256=digest(usage))
        save(receipt,state)
        require(rc == 0, f"{name} failed with {rc}; see {log}")
        return log

    def git_hash(path, rev):
        return subprocess.check_output(["git","-C",path,"rev-parse",rev],text=True).strip()

    def checkout(name, path, url, sha):
        step(name+"-init",["git","init","-q",path])
        step(name+"-origin",["git","remote","add","origin",url],path)
        step(name+"-fetch",["git","-c","fetch.fsckObjects=true","fetch","--no-tags","--depth=1","origin",sha],path)
        step(name+"-checkout",["git","-c","core.hooksPath=/dev/null","checkout","--detach","-q","FETCH_HEAD"],path)
        require(git_hash(path,"HEAD") == sha, f"{name} commit mismatch")

    try:
        require(shutil.disk_usage(root).free >= 250*2**30,"less than 250 GiB free")
        require(int(Path("/proc/sys/vm/max_map_count").read_text()) >= 1048576,"vm.max_map_count below upstream recommendation")
        soft,hard = resource.getrlimit(resource.RLIMIT_NOFILE)
        require(hard == resource.RLIM_INFINITY or hard >= 65536,"insufficient open-file hard limit")
        resource.setrlimit(resource.RLIMIT_NOFILE,(max(soft,65536) if soft != resource.RLIM_INFINITY else soft,hard))
        state["meminfo"] = Path("/proc/meminfo").read_text()
        state["free_bytes_start"] = shutil.disk_usage(root).free
        tc = Path(subprocess.check_output(["elan","which","lean"],env={**os.environ,"ELAN_TOOLCHAIN":TC},text=True).strip()).resolve().parent.parent
        state["toolchain_path"] = str(tc)
        for tool in ["lean","lake","leanexport","leanchecker-paranoid","nanoda_bin"]:
            require((tc/"bin"/tool).is_file(), f"missing {tool} in {tc}/bin")
        state["tool_sha256"] = {k:digest(tc/"bin"/k) for k in ["lean","lake","leanexport","leanchecker-paranoid","nanoda_bin"]}
        version = subprocess.check_output([tc/"bin/lean","--version"],text=True).strip()
        require("4.37.0-rc1" in version,"incorrect Lean version")
        state["lean_version"] = version
        checkout("source",source,REPO,PIN)
        require(git_hash(source,"HEAD^{tree}") == TREE,"source tree mismatch")
        require((source/"lean-toolchain").read_text().strip()==TC,"toolchain pin mismatch")
        manifest=json.loads((source/"lake-manifest.json").read_text())
        pack = source/".lake/packages"
        require(not (source/".lake").exists(),"project checkout includes prebuilt state")
        pack.mkdir(parents=True)
        for dep in manifest["packages"]:
            name,url,rev = dep["name"],dep["url"],dep["rev"]
            require(re.fullmatch(r"[A-Za-z0-9_-]+",name) and re.fullmatch(r"https://github.com/[-A-Za-z0-9_]+/[-A-Za-z0-9_.]+",url) and re.fullmatch(r"[0-9a-f]{40}",rev) and dep["type"]=="git" and dep["subDir"] is None,"invalid dependency")
            checkout(name,pack/name,url,rev)
        require(git_hash(pack/"mathlib","HEAD")==MATH,"Mathlib pin mismatch")
        state["packages"]={d["name"]:d["rev"] for d in manifest["packages"]}
        state["manifest_sha256"]=digest(source/"lake-manifest.json")
        state["trusted_inputs_sha256"]={f:digest(source/f) for f in ["src/Challenge.lean","src/Main.lean","lakefile.toml","lean-toolchain","export-targets.txt","comparator.json"]}
        cfg=json.loads((source/"comparator.json").read_text())
        require(cfg["challenge_module"]=="Challenge" and cfg["solution_module"]=="Main" and cfg["theorem_names"]==TARGETS and set(cfg["permitted_axioms"])==AX,"unexpected Comparator trust policy")
        require(cfg["external_kernels"]=={"Lean paranoid":["leanchecker-paranoid","--silent","--from-export"],"nanoda":["nanoda_bin"]},"unexpected kernels")
        targets=(source/"export-targets.txt").read_text().split()
        state["export_targets"]=targets
        home = root/"online-home"
        home.mkdir()
        env = {"PATH":str(tc/"bin")+":/usr/local/bin:/usr/bin:/bin","HOME":str(home),"LANG":"C.UTF-8",
               "LEAN_ABORT_ON_PANIC":"1","LAKE_ARTIFACT_CACHE":"false","GIT_CONFIG_NOSYSTEM":"1","GIT_TERMINAL_PROMPT":"0",
               "MATHLIB_CACHE_GET_URL":"https://cache.mathlib.org/mathlib4"}
        # No executable, manifest, or scripts from the GRH checkout are used for cache acquisition.
        depstage=root/"dependencies"
        (depstage/".lake").mkdir(parents=True)
        (depstage/".lake/packages").symlink_to(pack,target_is_directory=True)
        shutil.copy2(source/"lake-manifest.json",depstage/"lake-manifest.json")
        (depstage/"lakefile.toml").write_text('name = "tree"\n[[require]]\nname = "mathlib"\ngit = "https://github.com/leanprover-community/mathlib4"\nrev = "'+MATH+'"\n')
        shutil.copy2(source/"lean-toolchain",depstage/"lean-toolchain")
        env["MATHLIB_NO_CACHE_ON_UPDATE"]="1"
        step("mathlib-cache",["lake","exe","mathlib/cache","get"],depstage,env=env)
        require(not (source/".lake/build").exists(),"GRH build output present before verification")
        for d in manifest["packages"]:
            require(git_hash(pack/d["name"],"HEAD")==d["rev"],"dependency changed")
            subprocess.run(["git","-C",pack/d["name"],"diff","--exit-code","HEAD","--"],check=True,stdout=subprocess.DEVNULL)
        # Isolate Challenge sources; mount dependency state read-only for both builds.
        (challenge/"src").mkdir(parents=True)
        for f in ["lakefile.toml","lake-manifest.json","lean-toolchain","comparator.json","export-targets.txt","src/Challenge.lean"]:
            shutil.copy2(source/f,challenge/f)
        shutil.copy2(source/"comparator.json",empty/"comparator.json")
        for checkout_dir in [source,challenge]:
            (checkout_dir/".lake/build").mkdir(parents=True)
        (challenge/".lake/packages").mkdir()
        hostpaths=["/usr","/bin","/lib","/lib64","/etc"]
        def box(work, writable, command):
            # Host credentials, caller HOME, other workspaces, network, and the receipt directory are absent.
            argv=["bwrap","--unshare-all","--die-with-parent","--new-session","--clearenv","--proc","/proc","--dev","/dev","--tmpfs","/tmp","--dir","/tmp/home"]
            for x in hostpaths:
                if os.path.islink(x):
                    argv+=["--symlink",os.readlink(x),x]
                elif os.path.exists(x):
                    argv+=["--ro-bind",x,x]
            argv+=["--ro-bind",str(tc),"/tool","--ro-bind",str(work),"/project",
                   "--setenv","HOME","/tmp/home","--setenv","PATH","/tool/bin:/usr/bin:/bin","--setenv","LANG","C.UTF-8",
                   "--setenv","LEAN_ABORT_ON_PANIC","1","--setenv","LAKE_ARTIFACT_CACHE","false","--chdir","/project"]
            if work==empty:
                argv+=["--dir","/tmp/judge","--chdir","/tmp/judge"]
            if work!=empty:
                argv+=["--ro-bind",str(pack),"/project/.lake/packages"]
                if writable:
                    argv+=["--bind",str(work/".lake/build"),"/project/.lake/build"]
            return argv+command
        for w in [challenge,source]:
            # Lake may compile project configuration; TOML configuration requires no project-level .olean.
            require(not list((w/".lake/build").iterdir()),"dirty verification starting state")
        step("isolation-preflight",box(challenge,True,["sh","-ec",'test -z "$LEAN_PATH"; test "$LAKE_ARTIFACT_CACHE" = false; test -w .lake/build; test ! -w src/Challenge.lean; test ! -w .lake/packages/mathlib/Mathlib.lean; test -x /tool/bin/lean; test -z "$(ls -A .lake/build)"; cat /proc/net/route; lean --version']))
        step("challenge-build",box(challenge,True,["lake","build","Challenge"]))
        step("challenge-export",box(challenge,False,["lake","env","leanexport","Challenge","--",*targets]),output=evidence/"challenge.export")
        thread=threading.Thread(target=prune,daemon=True)
        thread.start()
        try:
            step("source-build-main",box(source,True,["lake","build","Main"]))
        finally:
            stop.set()
            thread.join()
            state["cleanup"]=stats
        require(not clean_error, f"setup cleanup failed: {clean_error}")
        require((source/".lake/build/lib/lean/Main.olean").is_file(),"missing Main.olean")
        src_names={x.relative_to(source/"src").with_suffix("").as_posix() for x in (source/"src").rglob("*.lean")}
        lib=source/".lake/build/lib/lean"
        state["src_module_count"]=len(src_names)
        objects=0
        with (evidence/"project-objects.tsv").open("x") as out:
            for path in sorted(lib.rglob("*.olean")):
                name=path.relative_to(lib).with_suffix("").as_posix()
                require(name in src_names,"unexpected compiled module "+name)
                require(not path.is_symlink(),"unexpected symlink in build products")
                out.write(f"{digest(path)}\t{path.stat().st_size}\t{name}\n")
                objects+=1
        state["compiled_project_modules"]=objects
        state["object_manifest_sha256"]=digest(evidence/"project-objects.tsv")
        # Run frontend's separate audit on a read-only build; Comparator later checks transitive proofs.
        audit=root/"Audit.lean"
        audit.write_text("import Main\n"+"\n".join("#print axioms "+n for n in TARGETS)+"\n")
        argv=box(source,False,[])
        auditlog=step("axioms",argv+["--ro-bind",str(audit),"/tmp/Audit.lean","lake","env","lean","/tmp/Audit.lean"])
        reports=re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]",auditlog.read_text())
        require(len(reports)==len(TARGETS) and {n for n,_ in reports}==set(TARGETS) and all({x.strip() for x in a.split(",")}<=AX for _,a in reports),"axiom audit failed")
        state["axioms"]=dict(reports)
        step("solution-export",box(source,False,["lake","env","leanexport","Main","--",*targets]),output=evidence/"solution.export")
        for stem in ["challenge","solution"]:
            path=evidence/(stem+".export")
            require(path.stat().st_size>0,"empty export")
            state[stem+"_export"]={"bytes":path.stat().st_size,"sha256":digest(path)}
        argv=box(empty,False,[])
        for stem in ["challenge","solution"]:
            argv+=["--ro-bind",str(evidence/(stem+".export")),"/tmp/"+stem+".export"]
        step("comparator",argv+["lake","comparator","--config","/project/comparator.json","--challenge-from-export","/tmp/challenge.export","--solution-from-export","/tmp/solution.export"])
        subprocess.run(["git","-C",source,"diff","--exit-code","HEAD","--"],check=True,stdout=subprocess.DEVNULL)
        state["status"]="verified"
    except BaseException as exc:
        state["status"]="failed"
        state["error"]=str(exc)
        raise
    finally:
        stop.set()
        state["finish_unix"]=time.time()
        state["free_bytes_end"]=shutil.disk_usage(root).free
        save(receipt,state)


if __name__ == "__main__":
    main()

