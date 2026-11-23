"""Independent native prefix replay using segmented sieving of the large summand."""
import argparse
import json
from math import isqrt
from pathlib import Path
from time import perf_counter, process_time

import numpy as np


HERE = Path(__file__).resolve().parent


def base_primes(limit):
    flags = np.ones(limit+1, dtype=np.uint8)
    flags[:2] = 0
    for p in range(2,isqrt(limit)+1):
        if flags[p]:
            flags[p*p::p] = 0
    return np.flatnonzero(flags).tolist()


def check(bound, stride, prime_cap):
    started, cpu = perf_counter(), process_time()
    primes = base_primes(max(prime_cap,isqrt(bound)))
    anchors = [p for p in primes if 2 < p <= prime_cap]
    checked = 1  # 4 = 2 + 2
    largest_used = 2
    for origin in range(6,bound+1,2*stride):
        w = min(stride,(bound-origin)//2+1)
        end = origin+2*(w-1)-3
        low = max(3,origin-anchors[-1])
        count = (end-low)//2+1
        flags = np.ones(count, dtype=np.uint8)
        for p in primes:
            if p == 2:
                continue
            if p*p>end:
                break
            start = max(p*p,low+(-low)%p)
            if start%2 == 0:
                start += p
            flags[(start-low)//2::p] = 0
        bits = int.from_bytes(np.packbits(flags,bitorder="little").tobytes(),"little")
        missing = (1<<w)-1
        for p in anchors:
            delta = (origin-low-p)//2
            missing &= ~(bits>>delta if delta>=0 else bits<<(-delta))
            if not missing:
                largest_used = max(largest_used,p)
                break
        if missing:
            first_miss = origin+2*((missing & -missing).bit_length()-1)
            raise RuntimeError(f"insufficient anchor cap at {first_miss}")
        checked += w
    if checked != bound//2-1:
        raise RuntimeError("incomplete range")
    return dict(bound=bound,even_targets=checked,block_width=stride,prime_cap=prime_cap,
                greatest_anchor_tested=largest_used,cpu_seconds=process_time()-cpu,
                wall_seconds=perf_counter()-started)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("k",nargs="+",type=int,choices=range(1,14))
    parser.add_argument("--width",type=int,default=2**19)
    parser.add_argument("--prime-cap",type=int,default=4093)
    args = parser.parse_args()
    if args.width<1 or args.prime_cap<3:
        parser.error("positive width and a prime cap of at least 3 required")
    for k in args.k:
        result = check(10**k,args.width,args.prime_cap)
        (HERE/f"scan{k}.json").write_text(json.dumps(result,indent=2)+"\n")
        print(result,flush=True)
