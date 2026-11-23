"""Actual high-p local sieves and prime anchors; no proof certificates claimed."""
import json,math,struct,time,random
from pathlib import Path
import numpy as np
from flint import fmpz
from make_bulk_fixtures import sieve

ROOT=Path(__file__).resolve().parent
D=1<<20; N=4*10**18

def main():
    begin=time.perf_counter();n=math.isqrt((1<<52)+D)+1
    t=time.perf_counter();flags=np.ones(n+1,dtype=np.bool_);flags[:2]=False
    for p in range(2,math.isqrt(n)+1):
        if flags[p]:flags[p*p::p]=False
    primes=np.flatnonzero(flags);del flags
    print('base primes',len(primes),'seconds',time.perf_counter()-t,flush=True)
    sources={};pools={};stats=[]
    for power in (40,48,52):
        base=N-(1<<power);first=(1<<power)-(1<<21)+1
        t=time.perf_counter()
        # Python int arithmetic avoids NumPy scalar overhead/overflow ambiguity.
        local_primes=[int(p) for p in primes if p*p<=first+2*(D//2+(1<<20)-1)]
        a=sieve(first,D//2+(1<<20),local_primes)
        source=np.packbits(a,bitorder='little').tobytes();sources[power]=(first,source)
        stat=dict(power=power,base=base,first=first,sieve_seconds=time.perf_counter()-t,
            base_primes=len(local_primes),odd_prime_density=float(a.mean()))
        del local_primes
        t=time.perf_counter();nearest=[];q=base-1
        while len(nearest)<512:
            if fmpz(q).is_prime():nearest.append(q)
            q-=2
        rng=random.Random(7193+power);spread=[];seen=set()
        while len(spread)<512:
            q=base-(2*rng.randrange(D//2)+1)
            if q not in seen and fmpz(q).is_prime():seen.add(q);spread.append(q)
        stat['anchor_seconds']=time.perf_counter()-t;stats.append(stat)
        pools[power]=[("nearest",nearest),("spread",spread)]
        print(stat,flush=True)
    records=[];blobs=[]
    for width in (1<<16,1<<18,1<<20):
        for power in (40,48,52):
            first,source=sources[power];bits=len(source)*8;base=N-(1<<power)
            for kind,anchors in pools[power]:
                shifts=[(base-q-1)//2 for q in anchors];mask=(1<<width)-1;u=0;prefix=0
                source_int=int.from_bytes(source,'little')
                for j,s in enumerate(shifts):
                    u|=source_int>>s
                    if u&mask==mask:prefix=j+1;break
                missing=width-(u&mask).bit_count()
                assert prefix, (power,width,kind,missing)
                target=base+first-1;idx=len(records)
                assert all(first+2*s+q==target and s+width<=bits for q,s in zip(anchors,shifts))
                blobs.append(struct.pack('<8Q',width,bits,512,bits//64,target,first,prefix,idx)
                    +b''.join(struct.pack('<2Q',q,s) for q,s in zip(anchors,shifts))+source)
                records.append(dict(id=idx,width=width,power=power,pool=kind,base=base,
                    target_start=target,source_first_odd=first,source_bits=bits,
                    reference_prefix=prefix,missing_after_512=missing,
                    anchors=anchors,shifts=shifts))
    with (ROOT/'bulk_large.bin').open('wb') as f:
        f.write(b'BULKCOV1');f.write(struct.pack('<Q',len(records)))
        for blob in blobs:f.write(blob)
    (ROOT/'bulk_large.json').write_text(json.dumps(dict(cases=records,stats=stats,
        generation_seconds=time.perf_counter()-begin,
        bytes=(ROOT/'bulk_large.bin').stat().st_size,
        warning='Exact numerical local sieve and FLINT primality tests, not formal certificates'),indent=2))
    print('finished',time.perf_counter()-begin,flush=True)

if __name__=='__main__':main()
