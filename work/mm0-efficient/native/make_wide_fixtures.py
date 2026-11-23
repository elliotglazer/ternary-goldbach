"""Large working-set actual prime fixtures, generated in bounded sieve chunks."""
import json,math,struct,time
from pathlib import Path
import numpy as np
from make_bulk_fixtures import sieve,primes_to,OLD,D,M
ROOT=Path(__file__).resolve().parent

def main():
    begin=time.perf_counter();pools=json.loads((OLD/'results.json').read_text())['pools'][:2]
    primes=primes_to(math.isqrt(2*M+D)+1);records=[];first=2*M-2*(1<<28)+1
    with (ROOT/'bulk_wide.bin').open('wb') as f:
        f.write(b'BULKCOV1');f.write(struct.pack('<Q',4))
        for width in (1<<26,1<<28):
            t=time.perf_counter();count=width+D//2;source=bytearray()
            for off in range(0,count,1<<22):
                flags=sieve(first+2*off,min(1<<22,count-off),primes)
                source.extend(np.packbits(flags,bitorder='little').tobytes())
            sieve_time=time.perf_counter()-t;print('sieved',width,sieve_time,flush=True)
            value=int.from_bytes(source,'little');mask=(1<<width)-1
            for pool in pools:
                base=pool['base'];anchors=pool['anchors'][:512];shifts=[(base-q-1)//2 for q in anchors]
                prefix=0;u=0
                for j,s in enumerate(shifts):
                    u|=value>>s
                    if u&mask==mask:prefix=j+1;break
                assert prefix
                target=base+first-1;idx=len(records);bits=len(source)*8
                f.write(struct.pack('<8Q',width,bits,512,bits//64,target,first,prefix,idx))
                for q,s in zip(anchors,shifts):f.write(struct.pack('<2Q',q,s))
                f.write(source)
                records.append(dict(id=idx,width=width,pool=pool['key'],source_first_odd=first,
                    source_bits=bits,target_start=target,base=base,reference_prefix=prefix,sieve_seconds=sieve_time))
                print('reference',width,pool['key'],prefix,flush=True)
    (ROOT/'bulk_wide.json').write_text(json.dumps(dict(cases=records,generation_seconds=time.perf_counter()-begin,
        bytes=(ROOT/'bulk_wide.bin').stat().st_size),indent=2))

if __name__=='__main__':main()
