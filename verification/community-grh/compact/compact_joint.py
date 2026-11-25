#!/usr/bin/env python3
"""Fresh, pinned community GRH source replay on a dedicated Linux builder."""
import argparse
import importlib.util
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

UPSTREAM = '72fead102f663d5c7a407964a13dc0cf9d977207'
SUBTREE = 'b834f80c6399db99d54ce171ba541c4a95a4f90f'
REPO = 'https://github.com/elliotglazer/ternary-goldbach.git'
TC = 'leanprover/lean4:v4.35.0'
MATH = '56a005855ea17e0b0958f73ec801ae140b0a1679'
TARGETS = ['PalomarTernaryGoldbach.ternary_goldbach']
AX = {'propext','Quot.sound','Classical.choice'}
TRUSTED_CHALLENGE = 'module\n\npublic import Mathlib.Data.Nat.Prime.Defs\npublic import Mathlib.Algebra.Ring.Parity\n\npublic section\n\nnamespace PalomarTernaryGoldbach\n\n/-- Challenge stub for the trusted side of Comparator. -/\ntheorem ternary_goldbach :\n    ∀ n : ℕ, Odd n → 5 < n →\n      ∃ p q r : ℕ, Nat.Prime p ∧ Nat.Prime q ∧ Nat.Prime r ∧ p + q + r = n := by\n  sorry\n\nend PalomarTernaryGoldbach\n'
AUDIT = 'import GoldbachSolution\nimport Lean\nopen Lean Elab Command\nprivate def checkEdge (source : Name) (wanted : List Name) : CommandElabM Unit := liftCoreM do\n  let ci ← getConstInfo source\n  unless ci matches .thmInfo _ do throwError "expected theorem {source}"\n  let some proof := ci.value? (allowOpaque := true) | throwError "missing proof body {source}"\n  for n in wanted do\n    unless proof.getUsedConstants.contains n do throwError "missing edge {source} -> {n}"\n  logInfo m!"checked proof edges {source}: {wanted}"\nrun_cmd checkEdge `PalomarTernaryGoldbach.ternary_goldbach [`CompletedGoldbach.ternary_goldbach]\nrun_cmd checkEdge `CompletedGoldbach.ternary_goldbach [`GoldbachFinite.completed_of_release, `riemannHypothesis, `LFunction_eq_zero_re_of_isPrimitive]\n#print axioms PalomarTernaryGoldbach.ternary_goldbach\n#print axioms CompletedGoldbach.ternary_goldbach\n'
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


def verify_manifest(data,before,after):
    if isinstance(data,dict) and 'files' not in data:
        data=[{'path':k.removeprefix('src/'),'upstream_sha256':v['upstream'],'converted_sha256':v['module_sha256']} for k,v in data.items()]
    rows=data.get('files') if isinstance(data,dict) else data
    require(isinstance(rows,list),'need conversion manifest files list')
    seen=set()
    for row in rows:
        name=row['path']
        require(name not in seen and name in before and row['upstream_sha256']==before[name] and row['converted_sha256']==after[name], 'invalid conversion record: '+name)
        seen.add(name)
    require(seen==set(before),'incomplete conversion manifest')

def cgroup_stats():
    """Read the aggregate cgroup v2 counters for the whole systemd job."""
    scope = next((line[3:] for line in Path('/proc/self/cgroup').read_text().splitlines() if line.startswith('0::')), None)
    if scope is None:
        return {}
    cgroup = Path('/sys/fs/cgroup') / scope.lstrip('/')
    stats = {}
    for key in ['memory.current', 'memory.peak', 'memory.high', 'memory.max', 'memory.swap.max']:
        p = cgroup / key
        if p.is_file():
            value = p.read_text().strip()
            stats[key] = value if value == 'max' else int(value)
    for key in ['cpu.stat', 'memory.events']:
        p = cgroup / key
        if p.is_file():
            stats.update({f'{key}:{k}': int(v) for k,v in (x.split() for x in p.read_text().splitlines())})
    return stats

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-dir", type=Path, required=True)
    parser.add_argument("--threads", type=int, default=12)
    parser.add_argument('--commit',required=True)
    parser.add_argument('--tree',required=True)
    parser.add_argument('--shard-main',action='store_true',help='compile CompactGRH Main in its own timed Lake step before the joint root')
    parser.add_argument('--profile',choices=['palomar-32x64','full'],default='palomar-32x64')
    parser.add_argument('--toolchain-dir',type=Path,required=True)
    parser.add_argument('--mathlib-cache-dir',type=Path,required=True)
    parser.add_argument('--con-ron',type=Path,required=True)
    parser.add_argument('--advisory-paranoid',action='store_true')
    args = parser.parse_args()
    PIN,TREE=args.commit,args.tree
    require(all(re.fullmatch('[0-9a-f]{40}',n) for n in [PIN,TREE]),'full joint Git commit/tree required')
    require(1 <= args.threads <= 32, "threads must be in 1..32")
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
    start_stats = cgroup_stats()
    if args.profile == 'palomar-32x64':
        page=os.sysconf('SC_PAGE_SIZE')
        high=64*2**30*95//100
        hard=64*2**30*98//100
        require(isinstance(start_stats.get('memory.high'),int) and abs(start_stats['memory.high']-high)<page, 'profile pressure threshold mismatch')
        require(isinstance(start_stats.get('memory.max'),int) and abs(start_stats['memory.max']-hard)<page and start_stats.get('memory.swap.max')==0, 'profile memory ceiling mismatch')
        require(1<=len(os.sched_getaffinity(0))<=32, '32 vCPU ceiling expected')
    state['resource_profile'] = {'name':args.profile,'initial_cgroup':start_stats,'visible_cpus':len(os.sched_getaffinity(0)),'execution_budget_seconds':19800,
        'dispatch_start_unix':int(os.environ.get('TG_DISPATCH_START',state['started_unix'])),
        'environment':'EC2 scheduling and storage; Palomar simulator, not a hosted registry verdict'}
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

    def step(name, cmd, cwd=None, output=None, env=None, allow_failure=False):
        log = evidence / (name + ".log")
        usage = evidence / (name + ".time")
        record = {"name":name,"argv":list(map(str,cmd)),"cwd":str(cwd or root),"start":time.time()}
        state["steps"].append(record)
        save(receipt,state)
        print(time.strftime("%Y-%m-%dT%H:%M:%SZ",time.gmtime()),name,flush=True)
        initial=cgroup_stats()
        peak=initial.get('memory.current',0)
        with log.open('xb') as err:
            out = output.open('xb') if output else None
            try:
                proc=subprocess.Popen(['/usr/bin/time','-v','-o',usage,*cmd],cwd=cwd or root,env=env,stdout=out or err,stderr=err if out else subprocess.STDOUT)
                while True:
                    try:
                        rc=proc.wait(timeout=1)
                        break
                    except subprocess.TimeoutExpired:
                        peak=max(peak,cgroup_stats().get('memory.current',0))
            finally:
                if out:out.close()
        final=cgroup_stats()
        end=time.time()
        record.update(exit=rc,end=end,wall_seconds=end-record['start'],log_sha256=digest(log),time_sha256=digest(usage),
            cgroup_sampled_peak_bytes=max(peak,final.get('memory.current',0)),cgroup_lifetime_peak_bytes=final.get('memory.peak'),
            cpu_seconds=(final.get('cpu.stat:usage_usec',0)-initial.get('cpu.stat:usage_usec',0))/1e6,
            oom_kills=final.get('memory.events:oom_kill',0)-initial.get('memory.events:oom_kill',0))
        save(receipt,state)
        if not allow_failure:require(rc == 0, f"{name} failed with {rc}; see {log}")
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
        require(shutil.disk_usage(root).free >= 100*2**30,"less than 100 GiB free")
        require(int(Path("/proc/sys/vm/max_map_count").read_text()) >= 1048576,"vm.max_map_count below upstream recommendation")
        stack_soft,stack_hard = resource.getrlimit(resource.RLIMIT_STACK)
        require(stack_hard == resource.RLIM_INFINITY, "unlimited stack hard limit required")
        resource.setrlimit(resource.RLIMIT_STACK,(stack_hard,stack_hard))
        state["lean_num_threads"]=args.threads
        soft,hard = resource.getrlimit(resource.RLIMIT_NOFILE)
        require(hard == resource.RLIM_INFINITY or hard >= 65536,"insufficient open-file hard limit")
        resource.setrlimit(resource.RLIMIT_NOFILE,(max(soft,65536) if soft != resource.RLIM_INFINITY else soft,hard))
        state["meminfo"] = Path("/proc/meminfo").read_text()
        state["free_bytes_start"] = shutil.disk_usage(root).free
        tc=args.toolchain_dir.resolve(strict=True)
        state["toolchain_path"] = str(tc)
        for tool in ["lean","lake","leanexport","leanchecker","leanchecker-paranoid","nanoda_bin"]:
            require((tc/"bin"/tool).is_file(), f"missing {tool} in {tc}/bin")
        state["tool_sha256"] = {k:digest(tc/"bin"/k) for k in ["lean","lake","leanexport","leanchecker","leanchecker-paranoid","nanoda_bin"]}
        version = subprocess.check_output([tc/"bin/lean","--version"],text=True).strip()
        require(re.search(r"version 4\.35\.0,",version),"incorrect Lean version")
        state["lean_version"] = version
        checkout("source",source,REPO,PIN)
        require(git_hash(source,"HEAD^{tree}") == TREE,"source tree mismatch")
        require((source/"lean-toolchain").read_text().strip()==TC,"toolchain pin mismatch")
        original=root/'original'
        checkout("original",original,'https://github.com/leanprover-community/riemann-hypothesis.git',UPSTREAM)
        require(git_hash(original,'HEAD:grh-compact/src')==SUBTREE,'upstream compact source tree')
        converted=source/'CompactGRH'/'src'
        before=original/'grh-compact'/'src'
        paths=lambda d:{f.relative_to(d).as_posix():digest(f) for f in d.rglob('*.lean') if f.is_file() and not f.is_symlink()}
        lhs,rhs=paths(before),paths(converted)
        require(len(lhs)==794 and lhs.keys()==rhs.keys(),'incomplete compact source path map')
        m=source/'CompactGRH'/'source-manifest.json'
        verify_manifest(json.loads(m.read_text()),lhs,rhs)
        state['compact']={'commit':UPSTREAM,'src_tree':SUBTREE,'module_count':len(lhs),'conversion_manifest_sha256':digest(m)}
        entries=subprocess.check_output(['git','ls-files','-s','-z'],cwd=source).decode().split(chr(0))
        for entry in filter(None,entries):
            mode,path=entry.split(chr(9),1)
            require(mode.split()[0] in ('100755','100644') and not (set(Path(path).parts)&{'.lake'}) and not path.endswith(('.olean','.ilean','.so','.a','.o','.export','.olean.private','.olean.server')), 'forbidden tracked object or link: '+path)
        manifest=json.loads((source/"lake-manifest.json").read_text())
        official=json.loads((original/'grh-compact'/'lake-manifest.json').read_text())
        identity=lambda deps:{v['name']:(v['url'],v['rev'],v['type'],v.get('subDir')) for v in deps}
        require(identity(manifest['packages'])==identity(official['packages']) and len(manifest['packages'])==len(official['packages']),'candidate dependency graph differs from official Mathlib-only graph')
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
        cfg=json.loads((source/'comparator.json').read_text())
        require(cfg['challenge_module']=='GoldbachChallenge' and cfg['solution_module']=='GoldbachSolution' and cfg['theorem_names']==TARGETS and cfg.get('definition_names')==[] and set(cfg['permitted_axioms'])==AX,'candidate comparator scope')
        # Exact extra export roots in Lean v4.35.0 Lake/CLI/Check.lean, compareIt.
        targets=["Quot","Quot.mk","Quot.lift","Quot.ind",*TARGETS,*cfg["permitted_axioms"],
                 *"Nat.add Nat.sub Nat.mul Nat.pow Nat.gcd Nat.div Nat.mod Nat.beq Nat.ble Nat.land Nat.lor Nat.xor Nat.shiftLeft Nat.shiftRight String.ofList Char.ofNat List eagerReduce Nat String String.mk Char optParam autoParam semiOutParam outParam".split()]
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
        (depstage/"lakefile.toml").write_text('name = "goldbach"\n[[require]]\nname = "mathlib"\ngit = "https://github.com/leanprover-community/mathlib4"\nrev = "'+MATH+'"\n')
        shutil.copy2(source/"lean-toolchain",depstage/"lean-toolchain")
        env["MATHLIB_NO_CACHE_ON_UPDATE"]="1"
        cache=args.mathlib_cache_dir.resolve(strict=True)
        require(cache.is_dir() and cache!=pack and not cache.is_relative_to(source), "separate Mathlib archive cache expected")
        env["MATHLIB_CACHE_DIR"]=str(cache)
        step("mathlib-cache",["lake","exe","mathlib/cache","get"],depstage,env=env)
        require(not (source/".lake/build").exists(),"GRH build output present before verification")
        for d in manifest["packages"]:
            require(git_hash(pack/d["name"],"HEAD")==d["rev"],"dependency changed")
            subprocess.run(["git","-C",pack/d["name"],"diff","--exit-code","HEAD","--"],check=True,stdout=subprocess.DEVNULL)
        # Isolate Challenge sources; mount dependency state read-only for both builds.
        challenge.mkdir()
        (challenge/'GoldbachChallenge.lean').write_text(TRUSTED_CHALLENGE)
        shutil.copy2(source/'lake-manifest.json',challenge/'lake-manifest.json')
        shutil.copy2(source/'lean-toolchain',challenge/'lean-toolchain')
        (challenge/'lakefile.toml').write_text('name = "goldbach"\n[[require]]\nname = "mathlib"\ngit = "https://github.com/leanprover-community/mathlib4"\nrev = "'+MATH+'"\n[[lean_lib]]\nname = "GoldbachChallenge"\n')
        judge_cfg={'challenge_module':'GoldbachChallenge','solution_module':'GoldbachSolution','theorem_names':TARGETS,'definition_names':[],'permitted_axioms':sorted(AX),'external_kernels':{'nanoda':['nanoda_bin']}}
        save(empty/'comparator.json',judge_cfg)
        state['challenge_sha256']=digest(challenge/'GoldbachChallenge.lean')
        state["judge_config_sha256"]=digest(empty/"comparator.json")
        for checkout_dir in [source,challenge]:
            (checkout_dir/".lake/build").mkdir(parents=True)
            (checkout_dir/".lake/config").mkdir()
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
                   "--setenv","LEAN_ABORT_ON_PANIC","1","--setenv","LEAN_NUM_THREADS",str(args.threads),"--setenv","LAKE_ARTIFACT_CACHE","false","--chdir","/project"]
            if work==empty:
                argv+=["--dir","/tmp/judge","--chdir","/tmp/judge"]
            if work!=empty:
                argv+=["--ro-bind",str(pack),"/project/.lake/packages"]
                argv+=["--bind",str(work/".lake/config"),"/project/.lake/config"]
                if writable:
                    argv+=["--bind",str(work/".lake/build"),"/project/.lake/build"]
            return argv+command
        for w in [challenge,source]:
            # Lake may compile project configuration; TOML configuration requires no project-level .olean.
            require(not list((w/".lake/build").iterdir()),"dirty verification starting state")
        step("isolation-preflight",box(challenge,True,["sh","-ec",'test -z "$LEAN_PATH"; test "$LAKE_ARTIFACT_CACHE" = false; test -w .lake/build; test -w .lake/config; test ! -w GoldbachChallenge.lean; test ! -e CompactGRH; test ! -w .lake/packages/mathlib/Mathlib.lean; test -x /tool/bin/lean; test -z "$(ls -A .lake/build)"; cat /proc/net/route; lean --version']))
        step("challenge-build",box(challenge,True,["lake","--no-cache","build","GoldbachChallenge"]))
        step("challenge-export",box(challenge,False,["lake","env","leanexport","GoldbachChallenge","--",*targets]),output=evidence/"challenge.export")
        thread=threading.Thread(target=prune,daemon=True)
        thread.start()
        try:
            if args.shard_main:
                step("compact-main-shard",box(source,True,["lake","--no-cache","build","+Main"]))
            step("joint-source-build",box(source,True,["lake","--no-cache","build","+Main","GoldbachSolution"]))
        finally:
            stop.set()
            thread.join()
            state["cleanup"]=stats
        require(not clean_error, f"setup cleanup failed: {clean_error}")
        require((source/".lake/build/lib/lean/Main.olean").is_file(),"missing Main.olean")
        lib=source/'.lake/build/lib/lean'
        objects=0
        with (evidence/'project-objects.tsv').open('x') as out:
            for file in sorted(lib.rglob('*.olean')):
                require(not file.is_symlink(),'symlink object')
                out.write(f'{digest(file)}\t{file.stat().st_size}\t{file.relative_to(lib)}\n')
                objects+=1
        require((lib/'GoldbachSolution.olean').is_file(),'solution was not compiled')
        state['compact_imported_modules']=sum((lib/Path(name).with_suffix('.olean')).is_file() for name in lhs)
        require(state["compact_imported_modules"]==794,"missing compact modules in joint graph")
        state["compiled_project_modules"]=objects
        state["object_manifest_sha256"]=digest(evidence/"project-objects.tsv")
        # Run frontend's separate audit on a read-only build; Comparator later checks transitive proofs.
        audit=root/"Audit.lean"
        audit.write_text(AUDIT)
        argv=box(source,False,[])
        auditlog=step("axioms",argv+["--ro-bind",str(audit),"/tmp/Audit.lean","lake","env","lean","/tmp/Audit.lean"])
        reports=re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]",auditlog.read_text())
        require(len(reports)==2 and {n for n,_ in reports}==set(TARGETS+['CompletedGoldbach.ternary_goldbach']) and all({x.strip() for x in a.split(",")}==AX for _,a in reports),"axiom audit failed")
        state["axioms"]=dict(reports)
        step("solution-export",box(source,False,["lake","env","leanexport","GoldbachSolution","--",*targets]),output=evidence/"solution.export")
        for stem in ["challenge","solution"]:
            path=evidence/(stem+".export")
            require(path.stat().st_size>0,"empty export")
            state[stem+"_export"]={"bytes":path.stat().st_size,"sha256":digest(path)}
        argv=box(empty,False,[])
        for stem in ["challenge","solution"]:
            argv+=["--ro-bind",str(evidence/(stem+".export")),"/tmp/"+stem+".export"]
        judge_log=step("comparator",argv+["lake","comparator","--config","/project/comparator.json","--challenge-from-export","/tmp/challenge.export","--solution-from-export","/tmp/solution.export"])
        subprocess.run(["git","-C",source,"diff","--exit-code","HEAD","--"],check=True,stdout=subprocess.DEVNULL)
        accepted={k:(k+" kernel accepts the solution") in judge_log.read_text().splitlines() for k in ['Lean default','nanoda']}
        require(all(accepted.values()) and "Your solution is okay!" in judge_log.read_text().splitlines(),"missing official Comparator success marker")
        state["comparator_accepts"]=accepted
        state['mandatory_exit_unix']=time.time()
        save(receipt,state)
        checker=args.con_ron.resolve()
        require(digest(checker)=='4e5616d94374cae37324dad2594f6230c2bb2297240249fc78ff508f3bc5acef','wrong con-ron override')
        classifier=root/'palomar-classifier'
        checkout('palomar-checker-policy',classifier,'https://github.com/PalomarRegistry/PalomarSubmission.git','14aa8d6b3c2f14a8540605e37144560b9a00e7e7')
        classifiers=classifier/'scripts/kernel_outcomes.py'
        spec=importlib.util.spec_from_file_location('palomar_kernel_outcomes',classifiers)
        outcomes=importlib.util.module_from_spec(spec);spec.loader.exec_module(outcomes)
        wall=time.time()-state['resource_profile']['dispatch_start_unix']
        remaining=int(19800-wall)-60 if args.profile=='palomar-32x64' else 1800
        if remaining<1:
            result={'name':'con-ron','status':'declined','reason':'timeout-before-replay'}
        else:
            conbox=box(empty,False,[])+['--ro-bind',str(checker),'/tmp/con-ron','--ro-bind',str(evidence/'solution.export'),'/tmp/solution.export','/tmp/con-ron','--jobs=2','--verified','/tmp/solution.export']
            clog=step('con-ron',['timeout','--kill-after=10s',str(min(1800,remaining)),*conbox],allow_failure=True)
            rec=state['steps'][-1]
            if rec['exit']==124:result={'name':'con-ron','status':'declined','reason':'timeout'}
            elif rec['oom_kills'] and rec['exit'] in (137,-9):result={'name':'con-ron','status':'declined','reason':'out-of-memory'}
            else:result=outcomes.con_ron_outcome(rec['exit'],clog.read_text(errors='replace'),'')
        state['con_ron']=result
        require(result['status'] in ('accepted','declined'),'con-ron disagreement or unclassified exit')
        elapsed=time.time()-state['resource_profile']['dispatch_start_unix']
        state['baseline_elapsed_seconds']=elapsed
        state['within_330_minutes']=elapsed<=19800
        state['profile_outcome']='within-simulated-budget' if args.profile=='palomar-32x64' and elapsed<=19800 else ('over-simulated-budget' if args.profile=='palomar-32x64' else 'unconstrained')
        save(receipt,state)
        if args.advisory_paranoid:
            pbox=box(empty,False,[])+['--ro-bind',str(evidence/'solution.export'),'/tmp/solution.export','leanchecker-paranoid','--silent','--from-export','/tmp/solution.export']
            step('extra-paranoid',pbox)
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

