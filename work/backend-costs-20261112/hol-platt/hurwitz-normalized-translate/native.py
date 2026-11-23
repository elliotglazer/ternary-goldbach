from pathlib import Path
from time import process_time_ns
from flint import fmpz
from statistics import median
import json,sys
p=Path(__file__).resolve().parent
sys.set_int_max_str_digits(0)
bands=json.loads((p/'integer-groups.json').read_bytes())['bands']
producer=json.loads((p.parent/'hurwitz-seed-integer/normalized-seeds.json').read_bytes())
rows=(p/'integer-samples.txt').read_text().splitlines(); out=[]
for b,s in zip(bands,producer,strict=True):
    i,D,w,prec=b['band'],b['degree'],b['field'],b['p']
    B=fmpz(1)<<w; mask=(fmpz(1)<<(w*20))-1
    denbits=prec-94+6*D
    bias=(B//2+(fmpz(1)<<(denbits-1)))*(mask//(B-1))
    offset=(B>>(denbits+1))-(fmpz(1)<<127)
    groups=[list(map(int,rows[(i-1)*5+q].split())) for q in (3,4)]
    def calculate(n):
        # Pre-shift once per seed; offsets affect only the small signed multiplier.
        xx=[[fmpz(x[a])<<(6*k) for k,x in enumerate(reversed(s['seeds']))] for a in (0,1)]
        ret=[[],[]]
        for d in range(-64,n-64):
            for a in (0,1):
                acc=fmpz(0)
                for z in xx[a]:
                    acc=((acc<<(w+1))+d*acc+z)&mask
                y=fmpz(0); u=(acc+bias)&mask
                for k in range(20):
                    y+=(((u&(B-1))>>denbits)-offset)<<(128*k)
                    u>>=w
                ret[a].append(int(y))
        return ret
    times={128:[],129:[]}
    for n in (128,129,129,128,128,129):
        t=process_time_ns(); actual=calculate(n); times[n].append((process_time_ns()-t)*1e-9)
        assert all(xs==ys[:n] for xs,ys in zip(actual,groups,strict=True))
    est=sum(median(times[n])*cnt/3600 for n,cnt in [(128,b['groups']-b['last_groups']),(129,b['last_groups'])])
    out.append(dict(band=i,times=times,core_hours=est)); print(i,times,est,flush=True)
(p/'native-price.json').write_text(json.dumps(dict(bands=out,total=sum(r['core_hours'] for r in out)),indent=2))
