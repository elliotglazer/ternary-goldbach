"""Build and audit a sharded finite Goldbach theorem against the pinned Mathlib."""
import argparse
from concurrent.futures import ProcessPoolExecutor, ThreadPoolExecutor
from hashlib import sha256
import json
import os
from pathlib import Path
import subprocess
import sys
import time

from replay import run_lean


ROOT = Path(__file__).resolve().parent
SUPPORT = ("PrimeSupport","PrimeBitmap","Table","PrefixCheck","PrefixSource","PrefixJoin","PrefixFactorial")
AXIOMS = "[propext, Classical.choice, Quot.sound]"


def compile_one(task):
    name, src_dir, build, lean, env, memory = task
    relative = Path(*name.split("."))
    src = src_dir/relative.with_suffix(".lean")
    obj = build/relative.with_suffix(".olean")
    obj.parent.mkdir(exist_ok=True,parents=True)
    try:
        row = run_lean([lean,"-t0","-j1",f"-M{memory}","-o",str(obj),str(src.relative_to(src_dir))],env,cwd=src_dir)
    except Exception as exc:
        (build/(name+".error.log")).write_text(str(exc),encoding="utf-8")
        raise
    row.update(source_sha256=sha256(src.read_bytes()).hexdigest(),
               olean_sha256=sha256(obj.read_bytes()).hexdigest(),olean_bytes=obj.stat().st_size)
    (build/(name+".json")).write_text(json.dumps(row,indent=2)+"\n",encoding="utf-8")
    print(name, round(row["cpu_seconds"],2), flush=True)
    return row


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--sources",type=Path,default=ROOT/"shards")
    p.add_argument("--support",type=Path,default=ROOT)
    p.add_argument("--packages",type=Path)
    p.add_argument("--lean")
    p.add_argument("--memory",type=int,default=3500)
    p.add_argument("--jobs",type=int,default=2)
    p.add_argument("--upstream-only",action="store_true",help="check the upstream adapter after a successful replay")
    args = p.parse_args()
    if args.jobs<1:
        p.error("--jobs must be positive")
    source, support = args.sources.resolve(), args.support.resolve()
    plan = json.loads((source/"modules.json").read_bytes())
    if args.packages:
        deps = [p/".lake/build/lib/lean" for p in sorted(args.packages.resolve().iterdir()) if p.is_dir()]
    else:
        raw = subprocess.check_output(["lake","env",sys.executable,"-c","import os; print(os.environ['LEAN_PATH'])"],
                                      cwd=support,text=True).strip()
        deps = [(support/p).resolve() for p in raw.split(os.pathsep) if p]
    lean = args.lean or str(Path(subprocess.check_output(["lean","--print-prefix"],cwd=support,text=True).strip())/
                            "bin"/("lean.exe" if os.name=="nt" else "lean"))
    version = subprocess.check_output([lean,"--version"],text=True).strip()
    if "eb6cafb7290e8bd5f2937522d8d804f58f02bafc" not in version:
        raise RuntimeError(version)
    build = source/".split-build"
    build.mkdir(exist_ok=True)
    env = dict(os.environ,LEAN_PATH=os.pathsep.join(map(str,[build,*deps])))
    if args.upstream_only:
        from narrow_import import narrow
        report = json.loads((build/"replay.json").read_bytes())
        if report["lean"] != version or report["power"] != 10:
            raise RuntimeError("a completed ten-billion build is required")
        adapter = build/"adapter"
        adapter.mkdir(exist_ok=True)
        imports = adapter/"imports"
        statement = Path("TernaryGoldbach/Statement.lean")
        narrow(support/statement,imports/statement)
        env["LEAN_PATH"] = os.pathsep.join(map(str,[adapter,build,*deps]))
        stages = {}
        for name,root in (("TernaryGoldbach.Statement",imports),("Upstream10",ROOT)):
            stages[name] = compile_one((name,root,adapter,lean,env,args.memory))
        targets = ("binaryGoldbachUpToTenBillion","binaryGoldbachUpTo_of_le_ten_billion","binaryGoldbachUpToPower")
        query = "import Upstream10\n"+"".join(f"#print axioms SmallGoldbach.{name}\n" for name in targets)
        stages["audit"] = run_lean([lean,"-t0","-j1",f"-M{args.memory}","--stdin"],env,query,cwd=adapter)
        for name in targets:
            if f"'SmallGoldbach.{name}' depends on axioms: {AXIOMS}" not in stages["audit"]["output"]:
                raise RuntimeError(stages["audit"]["output"])
        (adapter/"adapter.json").write_text(json.dumps(stages,indent=2)+"\n",encoding="utf-8")
        print(stages["audit"]["output"],flush=True)
        return
    start = time.monotonic()
    def task(name,root=source):
        return name,root,build,lean,env,args.memory
    receipts = {n:compile_one(task(n,support)) for n in SUPPORT}
    if plan.get("fast_hex"):
        receipts["FastHex"] = compile_one(task("FastHex"))
    receipts[plan["base"]] = compile_one(task(plan["base"]))
    # Windows meters child processes by handle. POSIX meters cumulative children per worker.
    executor = ThreadPoolExecutor if os.name == "nt" else ProcessPoolExecutor
    with executor(max_workers=args.jobs) as pool:
        receipts.update(zip(plan["blocks"],pool.map(compile_one,map(task,plan["blocks"])),strict=True))
    for n in (plan["public"],plan["audit"]):
        receipts[n] = compile_one(task(n))
    target = f"SmallGoldbach.Power{plan['power']}.binaryGoldbachUpTo"
    if f"'{target}' depends on axioms: {AXIOMS}" not in receipts[plan["audit"]]["output"]:
        raise RuntimeError(receipts[plan["audit"]]["output"])
    summary = dict(lean=version,power=plan["power"],jobs=args.jobs,stages=receipts,
                   cpu_seconds=sum(t["cpu_seconds"] for t in receipts.values()),wall_seconds=time.monotonic()-start)
    (build/"replay.json").write_text(json.dumps(summary,indent=2)+"\n",encoding="utf-8")
    print(receipts[plan["audit"]]["output"],summary["cpu_seconds"],summary["wall_seconds"],flush=True)


if __name__ == "__main__":
    main()
