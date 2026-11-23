"""Actual-prime coverage for large bigint chunks; no formal proof is emitted."""
from collections import Counter
import hashlib
import json
import random
import time
import numpy as np
from flint import fmpz
from actual_cover import ROOT, D, M, small_primes, prime_window, summary

def get_masks(flags, shifts, start, length):
    return [int.from_bytes(np.packbits(flags[k+start:k+start+length],
                bitorder="little").tobytes(),"little") for k in shifts]

def check(masks,length):
    full=(1<<length)-1
    union=0
    productive=0
    first_full=None
    t=time.perf_counter()
    for i,mask in enumerate(masks):
        new=union|mask
        productive+=(new!=union)
        union=new
        if union==full and first_full is None:
            first_full=i+1
            productive_at_full=productive
    elapsed=time.perf_counter()-t
    return dict(complete=union==full,missing_bits=(full^union).bit_count(),
                first_full=first_full,productive_to_full=productive_at_full if first_full else productive,
                all_masks_or_seconds=elapsed,
                mask_density=sum(x.bit_count() for x in masks)/(len(masks)*length))

def main():
    t_all=time.perf_counter()
    data=json.loads((ROOT/"results.json").read_text())
    primes=small_primes(int((2*M+D)**.5)+2)
    regular_offsets=[0,M//4,M//2,3*M//4,M-4*65536]
    windows={}
    setup=[]
    for offset in regular_offsets:
        t=time.perf_counter()
        flags=prime_window(2*offset+1,D//2+4*65536,primes)
        windows[offset]=flags
        setup.append(dict(offset=offset,seconds=time.perf_counter()-t,
                          odd_count=len(flags),prime_count=int(flags.sum())))
    records=[]
    for pool in data["pools"]:
        shifts=[(pool["base"]-q-1)//2 for q in pool["anchors"]]
        for offset in regular_offsets:
            for sample in range(4):
                for length in (1024,16384,65536):
                    start=sample*65536
                    t=time.perf_counter()
                    masks=get_masks(windows[offset],shifts,start,length)
                    mt=time.perf_counter()-t
                    for size in (512,1024):
                        r=check(masks[:size],length)
                        records.append(dict(pool=pool["key"],base=pool["base"],
                            scheme=pool["scheme"],offset=offset+start,length=length,
                            size=size,mask_build_seconds_shared=mt,**r))
            print(pool["key"],offset,"done",flush=True)
    # Four 1-Mibit tests: first base, both anchor schemes, low and high positions.
    length=1<<20
    for offset in (0,M-length):
        flags=prime_window(2*offset+1,D//2+length,primes)
        for pool in data["pools"][:2]:
            shifts=[(pool["base"]-q-1)//2 for q in pool["anchors"]]
            t=time.perf_counter()
            masks=get_masks(flags,shifts,0,length)
            mt=time.perf_counter()-t
            for size in (512,1024):
                records.append(dict(pool=pool["key"],base=pool["base"],
                    scheme=pool["scheme"],offset=offset,length=length,size=size,
                    mask_build_seconds_shared=mt,**check(masks[:size],length)))
            print(pool["key"],"1Mi",offset,"done",flush=True)
    aggregates=[]
    for length in (1024,16384,65536,1<<20):
        for size in (512,1024):
            rows=[r for r in records if r["length"]==length and r["size"]==size]
            aggregates.append(dict(length=length,size=size,observations=len(rows),
                failures=sum(not r["complete"] for r in rows),
                missing_bits=sum(r["missing_bits"] for r in rows),
                first_full=summary([r["first_full"] for r in rows if r["complete"]]),
                mean_density=sum(r["mask_density"] for r in rows)/len(rows),
                total_all_masks_or_seconds=sum(r["all_masks_or_seconds"] for r in rows)))
    out=dict(metadata=dict(source_results_sha256=hashlib.sha256((ROOT/"results.json").read_bytes()).hexdigest(),
        script_sha256=hashlib.sha256(__import__("pathlib").Path(__file__).read_bytes()).hexdigest(),
        wall_seconds=time.perf_counter()-t_all,
        warning="Actual FLINT primes and exact local sieves, not a PA/Lean certificate; correlated samples"),
        setup=setup,aggregates=aggregates,records=records)
    (ROOT/"chunks.json").write_text(json.dumps(out,indent=2))
    print(json.dumps(dict(metadata=out["metadata"],aggregates=aggregates),indent=2))

if __name__=="__main__":
    main()
