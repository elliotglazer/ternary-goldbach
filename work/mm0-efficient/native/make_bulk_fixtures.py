"""Numerical actual-prime fixtures for a native bulk checker, not a formal proof."""
import json,math,struct,time
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parent
OLD=ROOT.parents[1]/"formal-goldbach-bench"/"prime-cover"
D=1<<20;M=1<<32

def primes_to(n):
    p=np.ones(n+1,dtype=np.bool_);p[:2]=False
    for i in range(2,math.isqrt(n)+1):
        if p[i]:p[i*i::i]=False
    return np.flatnonzero(p).tolist()

def sieve(start,count,primes):
    a=np.ones(count,dtype=np.bool_);end=start+2*(count-1)
    for p in primes:
        if p==2:continue
        if p*p>end:break
        first=max(p*p,((start+p-1)//p)*p)
        if first%2==0:first+=p
        if first<=end:a[(first-start)//2::p]=False
    if start==1:a[0]=False
    return a

def main():
    t=time.perf_counter();pools=json.loads((OLD/"results.json").read_text())["pools"]
    primes=primes_to(math.isqrt(2*M+D)+1);cache={};records=[];blobs=[]
    for width in (1<<16,1<<18,1<<20):
        for pool in pools:
            anchors=pool["anchors"][:512];base=pool["base"]
            shifts=[(base-q-1)//2 for q in anchors]
            for offset in (M//4,M//2,3*M//4,M-width):
                key=(width,offset)
                if key not in cache:
                    flags=sieve(2*offset+1,D//2+width,primes)
                    cache[key]=np.packbits(flags,bitorder="little").tobytes()
                source=cache[key];bits=len(source)*8;sw=len(source)//8
                source_int=int.from_bytes(source,"little");mask=(1<<width)-1;u=0;prefix=0
                for j,s in enumerate(shifts):
                    u |= source_int>>s
                    if u&mask==mask:prefix=j+1;break
                assert prefix
                target=base+2*offset;first=2*offset+1
                assert all(first+2*s+q==target and s+width<=bits for q,s in zip(anchors,shifts))
                idx=len(records)
                header=struct.pack('<8Q',width,bits,512,sw,target,first,prefix,idx)
                pairs=b''.join(struct.pack('<2Q',q,s) for q,s in zip(anchors,shifts))
                blobs.append(header+pairs+source)
                records.append(dict(id=idx,width=width,pool=pool["key"],base=base,
                    target_start=target,source_first_odd=first,source_bits=bits,
                    source_words=sw,offset=offset,anchors=512,reference_prefix=prefix))
    with (ROOT/"bulk_actual.bin").open('wb') as f:
        f.write(b'BULKCOV1');f.write(struct.pack('<Q',len(records)))
        for b in blobs:f.write(b)
    (ROOT/"bulk_actual.json").write_text(json.dumps(dict(cases=records,
        source="Previously FLINT-checked actual prime anchors; independent local Eratosthenes sieves",
        generation_seconds=time.perf_counter()-t,bytes=(ROOT/"bulk_actual.bin").stat().st_size,
        warning="Numerical fixture, not formal prime certificates"),indent=2))
    print(len(records),(ROOT/"bulk_actual.bin").stat().st_size,time.perf_counter()-t)

if __name__=='__main__':main()
