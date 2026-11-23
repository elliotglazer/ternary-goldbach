"""Check a local module against the project's Lean 4.35 cache, and meter the process."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time


HERE = Path(__file__).resolve().parent
TEAM = HERE.parent
WORK = HERE.parents[2]
WIDE = TEAM / "aws-pilot/wide"
sys.path.insert(0, str(WIDE))
from run_wide import windows_stats


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("modules", nargs="+")
    parser.add_argument("--lean", type=Path, default=Path.home() / ".elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
    parser.add_argument("--packages", type=Path, default=Path.home() / "Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
    parser.add_argument("--scope",type=Path,help="separate build directory and source overrides")
    parser.add_argument("--memory",type=int,default=3000)
    args = parser.parse_args()
    paths = [HERE, WIDE / "b8192-02", WORK / "backend-costs-20261112/finite-lean",
             WORK / "formal-goldbach-bench/prime-cert"]
    paths += sorted(p / ".lake/build/lib/lean" for p in args.packages.iterdir() if p.is_dir())
    scope = args.scope.resolve() if args.scope else HERE
    env = dict(os.environ, LEAN_PATH=os.pathsep.join(map(str,[scope,*paths])))
    for mod in args.modules:
        relative = Path(*mod.split(".")).with_suffix(".lean")
        directory = WORK / "ternary-goldbach" if mod == "TernaryGoldbach.Statement" else HERE
        if args.scope and (scope/relative).exists():
            directory = scope
        src = directory / relative
        obj = (scope / relative).with_suffix(".olean")
        obj.parent.mkdir(exist_ok=True,parents=True)
        log = scope / (mod+".log")
        cmd = [str(args.lean), "-t0", "-j1", f"-M{args.memory}", "-o", str(obj), str(relative)]
        start = time.monotonic()
        with log.open("wb") as f:
            proc = subprocess.Popen(cmd, cwd=directory, env=env, stdout=f, stderr=subprocess.STDOUT)
            rc = proc.wait()
            stats = windows_stats(proc)
        elapsed = time.monotonic()-start
        receipt = dict(module=mod, exit=rc, lean=subprocess.check_output([str(args.lean),"--version"],text=True).strip(),
                       wall_seconds=elapsed, **stats, source_sha256=sha(src), log_sha256=sha(log))
        if rc == 0:
            receipt.update(olean_bytes=obj.stat().st_size,olean_sha256=sha(obj))
        (scope/(mod+".json")).write_text(json.dumps(receipt,indent=2)+"\n")
        print(mod,rc,stats,round(elapsed,2),flush=True)
        if rc:
            print(log.read_text(encoding="utf-8",errors="replace").encode("ascii","backslashreplace").decode(),flush=True)
            return rc
    return 0


if __name__ == "__main__":
    sys.exit(main())
