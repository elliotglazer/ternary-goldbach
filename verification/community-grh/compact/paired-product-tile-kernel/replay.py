"""Replay two adjacent production prime-product tiles using the stock Lean kernel."""

import argparse
import ctypes
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys


BUNDLE = Path(__file__).resolve().parent
PROVENANCE = json.loads((BUNDLE/"provenance.json").read_text(encoding="utf-8"))


def sha(data):
    return hashlib.sha256(data).hexdigest()


def run(args, cwd, env=None):
    p = subprocess.run(args, cwd=cwd, env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if p.returncode:
        detail = (p.stdout+p.stderr).decode(errors="replace")
        raise RuntimeError(f"{args[0]} exited {p.returncode}\n{detail}")
    return p.stdout


def git(repo, *args):
    return run(["git","-c","safe.directory="+repo.as_posix(),"-C",str(repo),*args],repo)


def inputs(args, repo):
    if args.lean:
        if not args.lib or not args.mathlib:
            raise SystemExit("--lean requires --lib and --mathlib for the prebuilt run")
        lean = args.lean.resolve()
        packages = [p.resolve() for p in args.lib]
        mathlib = args.mathlib.resolve()
    else:
        if args.lib or args.mathlib:
            raise SystemExit("--lib and --mathlib require --lean")
        if git(repo,"rev-parse","HEAD").decode().strip()!=PROVENANCE["source_revision"]:
            raise SystemExit("Check out the source revision from provenance.json before using Lake")
        run(["lake","build",*PROVENANCE["dependency_targets"]],repo)
        prefix=run(["lake","env","lean","--print-prefix"],repo).decode().strip()
        lean=Path(prefix)/"bin"/("lean.exe" if os.name=="nt" else "lean")
        value=run(["lake","env",sys.executable,"-c","import os; print(os.environ['LEAN_PATH'])"],repo).decode().strip()
        packages=[(repo/p).resolve() for p in value.split(os.pathsep) if p]
        mathlib=repo/".lake/packages/mathlib"
    if git(mathlib,"rev-parse","HEAD").decode().strip()!=PROVENANCE["mathlib"]:
        raise SystemExit("Mathlib revision disagrees with provenance.json")
    if not all(p.is_dir() for p in packages):
        raise SystemExit("A requested directory of prebuilt imports is absent")
    version=run([str(lean),"--version"],repo).decode().strip()
    if PROVENANCE["lean_commit"] not in version or "version 4.35.0," not in version:
        raise SystemExit("Lean version disagrees with provenance.json")
    return lean,packages,version


def process_cpu(proc):
    if os.name=="nt":
        from ctypes import wintypes
        ft=[wintypes.FILETIME() for _ in range(4)]
        ok=ctypes.windll.kernel32.GetProcessTimes(wintypes.HANDLE(int(proc._handle)),*[ctypes.byref(time) for time in ft])
        if not ok:raise OSError("GetProcessTimes failed")
        return [((s.dwHighDateTime<<32)+s.dwLowDateTime)/1e7 for s in ft[2:]]
    stat=Path(f"/proc/{proc.pid}/stat")
    if sys.platform.startswith("linux") and stat.is_file():
        fields=stat.read_text().rsplit(") ",1)[1].split()
        ticks=os.sysconf("SC_CLK_TCK")
        return [int(fields[12])/ticks,int(fields[11])/ticks]
    return None


def phase_trial(cmd, out, env, roots, log_file):
    p=subprocess.Popen(cmd,cwd=out,env=env,stdin=subprocess.PIPE,stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT,text=True,encoding="utf-8")
    phases=[]
    with log_file.open("w",encoding="utf-8") as log:
        try:
            for item in p.stdout:
                log.write(item)
                if item.startswith("READY "):
                    _,root,added=item.rstrip().split(" ",2)
                    start=process_cpu(p)
                    p.stdin.write("go\n")
                    p.stdin.flush()
                elif item.startswith("DONE "):
                    end=process_cpu(p)
                    _,finished,ns=item.rstrip().split(" ")
                    if finished!=root:raise ValueError("Mismatched phase")
                    phases.append(dict(root=root,added=added.split(","),elapsed_ns=int(ns),
                                       system_cpu_s=None if start is None else end[0]-start[0],
                                       user_cpu_s=None if start is None else end[1]-start[1]))
        finally:
            p.stdin.close()
            p.wait()
    if p.returncode or [s["root"] for s in phases]!=roots:
        raise RuntimeError(f"Kernel replay did not complete both phases. See {log_file}")
    return phases


def verify_files():
    expected=json.loads((BUNDLE/"sha256.json").read_text(encoding="utf-8"))
    for name,digest in expected.items():
        if sha((BUNDLE/name).read_bytes())!=digest:
            raise SystemExit(f"Digest mismatch for {name}")
    print(f"Verified {len(expected)} bundle files")


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument("checkout",nargs="?",type=Path,help="Git repository containing the pinned Goldbach revision")
    ap.add_argument("--out",type=Path,help="New directory for compilation and receipts")
    ap.add_argument("--verify",action="store_true",help="Only verify the bundle SHA-256 manifest")
    ap.add_argument("--trials",type=int,default=3)
    ap.add_argument("--lean",type=Path,help="Use this Lean executable and supplied prebuilt imports")
    ap.add_argument("--lib",type=Path,action="append",help="Prebuilt library directory (repeatable)")
    ap.add_argument("--mathlib",type=Path,help="Git checkout for the supplied compiled Mathlib")
    args=ap.parse_args()
    verify_files()
    if args.verify:return
    if not args.checkout or not args.out or args.trials<1:
        ap.error("replay requires CHECKOUT, --out, and a positive trial count")
    repo=args.checkout.resolve()
    lean,packages,version=inputs(args,repo)
    out=args.out.resolve()
    out.mkdir(parents=True,exist_ok=False)
    module=PROVENANCE["module"]
    original=git(repo,"show",PROVENANCE["source_revision"]+":"+module+".lean")
    combined=original+(BUNDLE/"append.lean.inc").read_bytes()
    if sha(original)!=PROVENANCE["original_source_sha256"] or sha(combined)!=PROVENANCE["augmented_source_sha256"]:
        raise SystemExit("Pinned or augmented source bytes disagree with the measured module")
    (out/(module+".lean")).write_bytes(combined)
    for f in ("MarginalReplay.lean","MarginalMain.lean"):shutil.copyfile(BUNDLE/f,out/f)
    env={**os.environ,"LEAN_PATH":os.pathsep.join(map(str,[out,*packages]))}
    compile_stdout=run([str(lean),"-j1","-M2600","-o",module+".olean",module+".lean"],out,env)
    (out/"compile.log").write_bytes(compile_stdout)
    roots=[PROVENANCE["first_root"],PROVENANCE["union_root"]]
    for root in roots:
        if (root+"' depends on axioms: [propext, Classical.choice, Quot.sound]").encode() not in compile_stdout:
            raise RuntimeError("The expected three-axiom frontend audit is missing for "+root)
    run([str(lean),"-j1","-o","MarginalReplay.olean","MarginalReplay.lean"],out,env)
    report=dict(lean=version,mathlib=PROVENANCE["mathlib"],source_sha256=sha(combined),trials=[])
    for i in range(args.trials):
        command=[str(lean),"-j1","-M3500","--run","MarginalMain.lean",module,*roots]
        stages=phase_trial(command,out,env,roots,out/f"trial-{i+1}.log")
        report["trials"].append(stages)
        (out/"replay-receipt.json").write_text(json.dumps(report,indent=2)+"\n",encoding="utf-8")
        print("Trial",i+1,"kernel call elapsed seconds",*[round(s["elapsed_ns"]/1e9,6) for s in stages],flush=True)


if __name__=="__main__":
    main()
