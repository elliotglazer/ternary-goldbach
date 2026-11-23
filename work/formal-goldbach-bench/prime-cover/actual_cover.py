"""Actual prime-mask experiments. Numerical evidence, not a PA/Lean certificate.

Run with the interval-env Python; writes only next to this script.
"""
from __future__ import annotations
import argparse
from collections import Counter
import hashlib
import json
import math
from pathlib import Path
import platform
import random
import time
import numpy as np
import flint
from flint import fmpz

ROOT = Path(__file__).resolve().parent
FULL = (1 << 64) - 1
D = 1 << 20
M = 1 << 32
SPAN = 2*M
N = 4*10**18

def small_primes(limit):
    a = np.ones(limit+1, dtype=np.bool_)
    a[:2] = False
    for p in range(2, math.isqrt(limit)+1):
        if a[p]:
            a[p*p::p] = False
    return np.flatnonzero(a).tolist()

def prime_window(start_odd, count, primes):
    """Exact Eratosthenes sieve of count odd numbers, with all base primes."""
    end = start_odd + 2*(count-1)
    assert start_odd % 2 == 1
    a = np.ones(count, dtype=np.bool_)
    if start_odd == 1:
        a[0] = False
    for p in primes:
        if p == 2:
            continue
        if p*p > end:
            break
        first = max(p*p, ((start_odd+p-1)//p)*p)
        if first % 2 == 0:
            first += p
        if first <= end:
            a[(first-start_odd)//2::p] = False
    return a

def anchor_pool(base, scheme, seed):
    rng = random.Random(seed)
    out, seen = [], set()
    tested = 0
    delta = 1
    t = time.perf_counter()
    while len(out) < 1024:
        if scheme == "nearest":
            delta_now = delta
            delta += 2
        else:
            delta_now = 2*rng.randrange(D//2)+1
        if delta_now >= D:
            raise RuntimeError("Anchor interval exhausted")
        if delta_now in seen:
            continue
        seen.add(delta_now)
        q = base-delta_now
        tested += 1
        if bool(fmpz(q).is_prime()):
            out.append(q)
    return out, dict(tested=tested, seconds=time.perf_counter()-t,
                     minimum_delta=min(base-q for q in out),
                     maximum_delta=max(base-q for q in out))

def greedy(masks):
    rem = np.uint64(FULL)
    selected = []
    while rem:
        scores = np.bitwise_count(masks & rem)
        k = int(np.argmax(scores))
        if not scores[k]:
            break
        selected.append(k)
        rem &= ~masks[k]
    return selected, int(rem)

def sequential(masks):
    rem = FULL
    productive = 0
    for k, mask in enumerate(masks):
        new_rem = rem & ~int(mask)
        productive += (new_rem != rem)
        rem = new_rem
        if not rem:
            return k+1, productive, rem
    return len(masks), productive, rem

def summary(values):
    v = np.array(values, dtype=np.int64)
    return dict(n=len(values), minimum=int(v.min()), mean=float(v.mean()),
                median=float(np.median(v)), p90=float(np.quantile(v,.90)),
                p99=float(np.quantile(v,.99)), maximum=int(v.max()),
                histogram={str(k):v for k,v in sorted(Counter(values).items())})

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--words", type=int, default=128)
    args = parser.parse_args()
    assert 1 <= args.words <= 4096
    t_all = time.perf_counter()
    cpu_all = time.process_time()
    words = args.words
    btop = N//SPAN - 1
    block_indices = [btop, btop-1, btop-7, (N//2)//SPAN-1]
    bases = [4+b*SPAN for b in block_indices]
    offsets = [0, M//4, M//2, 3*M//4, M-64*words]
    primes = small_primes(math.isqrt(2*M+D)+1)
    rng = random.Random(20261110)
    windows = {}
    window_metadata = []
    for offset in offsets:
        t = time.perf_counter()
        start = 2*offset+1
        flags = prime_window(start, D//2+64*words, primes)
        elapsed = time.perf_counter()-t
        checks = rng.sample(range(len(flags)),128)
        for k in checks:
            assert bool(flags[k]) == bool(fmpz(start+2*k).is_prime())
        windows[offset] = flags
        window_metadata.append(dict(offset=offset, start=start,
          last=start+2*(len(flags)-1), odd_count=len(flags),
          prime_count=int(flags.sum()), sieve_seconds=elapsed,
          flint_crosschecks=len(checks)))
    raw = []
    cases = []
    pools = []
    verify_count = 0
    for bi,base in enumerate(bases):
        for si,scheme in enumerate(("nearest","spread")):
            anchors, pool_info = anchor_pool(base,scheme,20261110+bi*11+si)
            assert len(set(anchors))==1024
            assert all(base-D <= q < base for q in anchors)
            pool_key = f"b{bi}-{scheme}"
            pools.append(dict(key=pool_key, base=base, scheme=scheme,
                              anchors=anchors, **pool_info))
            shifts = np.array([(base-q-1)//2 for q in anchors],dtype=np.int64)
            for offset in offsets:
                t = time.perf_counter()
                # Bounded local data, no complete 8.6-billion table.
                indices = (shifts[:,None,None]
                    + (64*np.arange(words,dtype=np.int64))[None,:,None]
                    + np.arange(64,dtype=np.int64)[None,None,:])
                bits = windows[offset][indices]
                packed = np.packbits(bits,axis=2,bitorder="little")
                masks = packed.copy().view("<u8").reshape(1024,words).T.copy()
                build_seconds=time.perf_counter()-t
                del indices,bits,packed
                for size in (512,1024):
                    t_g = time.perf_counter()
                    gr = [greedy(row[:size]) for row in masks]
                    greedy_seconds=time.perf_counter()-t_g
                    t_s = time.perf_counter()
                    sq = [sequential(row[:size]) for row in masks]
                    sequential_seconds=time.perf_counter()-t_s
                    for wi,(selected,missing) in enumerate(gr):
                        used = 0
                        for k in selected:
                            used |= int(masks[wi,k])
                        assert (FULL & ~used)==missing==sq[wi][2]
                        # Recheck witnesses independently with FLINT for first word.
                        if wi == 0:
                            for bit in range(64):
                                if (used >> bit)&1:
                                    k=next(k for k in selected if (int(masks[wi,k])>>bit)&1)
                                    p=base+2*(offset+64*wi+bit)-anchors[k]
                                    assert bool(fmpz(p).is_prime())
                                    verify_count+=1
                        raw.append(dict(pool=pool_key,size=size,offset=offset,
                            word=wi,target_start=base+2*(offset+64*wi),
                            greedy_selected=selected,missing_hex=hex(missing),
                            sequential_examined=sq[wi][0],sequential_productive=sq[wi][1],
                            available_mask_bits=int(np.bitwise_count(masks[wi,:size]).sum())))
                    case = dict(pool=pool_key,base=base,scheme=scheme,size=size,
                        offset=offset, words=words,
                        failures=sum(bool(x[1]) for x in gr),
                        uncovered_bits=sum(x[1].bit_count() for x in gr),
                        greedy=summary([len(x[0]) for x in gr]),
                        sequential_examined=summary([x[0] for x in sq]),
                        sequential_productive=summary([x[1] for x in sq]),
                        mask_build_seconds_shared=build_seconds,
                        greedy_seconds=greedy_seconds,sequential_seconds=sequential_seconds)
                    cases.append(case)
                print(pool_key,offset,"done",flush=True)
    out=dict(metadata=dict(script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        python=platform.python_version(),platform=platform.platform(),numpy=np.__version__,
        flint=flint.__version__, words_per_case=words, anchor_interval=D,block_evens=M,
        bases=bases, distinct_target_words=len(bases)*len(offsets)*words,
        warning="Numerical experiment, not a formal prime certificate or a universal coverage proof",
        total_wall_seconds=time.perf_counter()-t_all,total_cpu_seconds=time.process_time()-cpu_all,
        independent_witness_prime_checks=verify_count),
        windows=window_metadata,pools=pools,cases=cases)
    for size in (512,1024):
        rows=[r for r in raw if r["size"]==size]
        out.setdefault("aggregate",{})[str(size)]=dict(
            observations=len(rows),failures=sum(r["missing_hex"]!="0x0" for r in rows),
            greedy=summary([len(r["greedy_selected"]) for r in rows]),
            sequential_examined=summary([r["sequential_examined"] for r in rows]),
            sequential_productive=summary([r["sequential_productive"] for r in rows]))
    (ROOT/"results.json").write_text(json.dumps(out,indent=2))
    (ROOT/"words.jsonl").write_text("".join(json.dumps(r,separators=(",",":"))+"\n" for r in raw))
    print(json.dumps(dict(metadata=out["metadata"],aggregate=out["aggregate"]),indent=2))

if __name__ == "__main__":
    main()
