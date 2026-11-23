"""Check one wide packed fixture. Run producer first. Append no old receipts."""

import argparse
import ctypes
from ctypes import wintypes
from hashlib import sha256
import json
import os
from pathlib import Path
import subprocess
import time

parser=argparse.ArgumentParser()
parser.add_argument("width",type=int,choices=[8192,262144])
parser.add_argument("label")
parser.add_argument("--prime-build",type=Path,help="Directory with checked Shared.olean and Anchors.olean")
parser.add_argument("--arithmetic-build",type=Path,help="Reuse the immutable expansion/arithmetic checkpoint")
parser.add_argument("--replay",action="store_true",help="Time the two complete numerical theorem closures in a warm kernel")
parser.add_argument("--cached",action="store_true",help="Use the binary-input, checked-operand cache variant")
parser.add_argument("--inputs-only",action="store_true",help="Measure cached arithmetic before the independent shared expansion proof")
parser.add_argument("--combine-build",type=Path,help="Combine already certified consecutive shards")
parser.add_argument("--expansion-from",type=Path,help="Compile split shared expansion against immutable input definitions")
parser.add_argument("--join-from",type=Path,help="Benchmark theorem assembly against a complete pair of adjacent shards")
parser.add_argument("--small-tiled",action="store_true",help="Certify a block using two actual source windows and one anchor list")
parser.add_argument("--tiled-replay-from",type=Path,help="Replay the real two-window certificate components")
parser.add_argument("--source-build",type=Path,help="Reuse certified segmented source expansion from this directory")
parser.add_argument("--conditional",action="store_true",help="Close the two wide intervals conditional on their explicit primality obligations")
args=parser.parse_args()
here=Path(__file__).resolve().parent
work=here.parents[2]
fixture=here/(f"wide{args.width}"+("-cache" if args.cached else ""))
run=fixture/args.label
run.mkdir(exist_ok=False)
lean=Path("C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe")
source_lib=work/"backend-costs-20261112/finite-lean"
prime_lib=work/"formal-goldbach-bench/prime-cert"
pkgs=Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages")
paths=[run,here,source_lib,prime_lib,*sorted(p/".lake/build/lib/lean" for p in pkgs.iterdir() if p.is_dir())]
modules=["PackedWideSource","PackedArithmetic0","PackedArithmetic1"]
if args.cached:
    modules.insert(0,"PackedWideInputs")
    if args.inputs_only:
        modules.remove("PackedWideSource")
if args.prime_build:
    paths.insert(1,args.prime_build.resolve())
    assert (args.prime_build/"Shared.olean").is_file() and (args.prime_build/"Anchors.olean").is_file()
    if args.cached:
        modules.append("PendingPrimes")
    modules.extend(["PackedWideShard0","PackedWideShard1","PackedWideTogether"])
if args.arithmetic_build:
    assert args.prime_build or args.replay or args.conditional, "checkpoint run needs a consumer"
    paths.insert(1,args.arithmetic_build.resolve())
    data_modules=[m for m in modules if m in {"PackedWideInputs","PackedWideSource","PackedArithmetic0","PackedArithmetic1"}]
    if args.source_build:
        paths.insert(1,args.source_build.resolve())
    assert all(((args.source_build if m == "PackedWideSource" and args.source_build else args.arithmetic_build)/
                (m+".olean")).is_file() for m in data_modules)
    modules=[m for m in modules if m not in data_modules]
if args.combine_build:
    assert args.prime_build and args.arithmetic_build
    paths.insert(1,args.combine_build.resolve())
    modules=["PackedWideTogether"]
if args.join_from:
    assert args.combine_build
    paths.insert(1,args.join_from.resolve())
    modules=["PackedAssemblyReplay"]
if args.small_tiled:
    assert args.prime_build and args.arithmetic_build
    modules=["SmallTiled"]
if args.tiled_replay_from:
    assert args.arithmetic_build and args.prime_build
    paths.insert(1,args.tiled_replay_from.resolve())
    modules=["SmallTiledReplay"]
if args.conditional:
    assert args.arithmetic_build
    modules=["PendingPrimes"]
if args.expansion_from:
    assert args.cached and not args.prime_build and not args.replay
    assert (args.expansion_from/"PackedWideInputs.olean").is_file()
    paths.insert(1,args.expansion_from.resolve())
    modules=json.loads((fixture/"expansion-groups.json").read_text())+["PackedWideSource"]
if args.replay:
    modules.append("PackedReplay")
env=dict(os.environ,LEAN_PATH=os.pathsep.join(map(str,paths)))
get_times=ctypes.windll.kernel32.GetProcessTimes
get_times.argtypes=[wintypes.HANDLE]+[ctypes.POINTER(wintypes.FILETIME)]*4
rows=[]
for module in modules:
    source=fixture/(module+".lean")
    out=run/(module+".olean")
    cmd=[str(lean),"-t0","-j1","-M2048","-o",str(out),str(source)]
    start=time.perf_counter()
    with (run/(module+".log")).open("w",encoding="utf-8") as log:
        p=subprocess.Popen(cmd,cwd=fixture,env=env,stdout=log,stderr=subprocess.STDOUT,
                           creationflags=subprocess.CREATE_NO_WINDOW)
        try:
            code=p.wait(timeout=180)
            timed_out=False
        except subprocess.TimeoutExpired:
            p.kill()
            code=p.wait()
            timed_out=True
        times=[wintypes.FILETIME() for _ in range(4)]
        if not get_times(int(p._handle),*map(ctypes.byref,times)):
            raise ctypes.WinError()
    row=dict(module=module,exit=code,wall_seconds=time.perf_counter()-start,
             cpu_seconds=sum((t.dwHighDateTime<<32)+t.dwLowDateTime for t in times[2:])/1e7,
             timeout=timed_out,command=cmd,source_sha256=sha256(source.read_bytes()).hexdigest())
    if code==0:
        row["olean_sha256"]=sha256(out.read_bytes()).hexdigest()
    rows.append(row)
    (run/"receipt.json").write_text(json.dumps(dict(rows=rows,lean_path=list(map(str,paths))),indent=2)+"\n")
    print(row["module"],code,row["cpu_seconds"],row["wall_seconds"],flush=True)
    if code:
        print((run/(module+".log")).read_text(encoding="utf-8")[:3000])
        raise SystemExit(code)
