import csv,json
from collections import defaultdict
from pathlib import Path
from time import process_time,perf_counter
from flint import arb,acb,ctx
ctx.prec=128;ctx.threads=1
p=Path(__file__).resolve().parent
data=defaultdict(list)
for r in csv.DictReader((p/'top-panels.tsv').open(),delimiter='\t'):data[int(r['T'])].append(r)
results=[]
for t,panels in data.items():
    t0=perf_counter();u0=process_time();g=2**24;last=2*g;cross=0
    first=acb(2,t).zeta();z0=first
    assert first.real>0
    for r in panels:
        a,b=map(int,[r['left_traversal'],r['right_traversal']]);assert a==last and a>b and int(r['scale'])==g
        z=acb(arb(arb(a+b)/(2*g),arb(a-b)/(2*g)),t).zeta()
        branch=int(r['halfplane_REpos_IMpos_REneg_IMneg'])
        assert [z.real>0,z.imag>0,z.real<0,z.imag<0][branch]
        z1=acb(arb(b)/g,t).zeta()
        if branch==2:
            assert (z0.imag>0 or z0.imag<0) and (z1.imag>0 or z1.imag<0)
            cross+=(int(z0.imag>0)-int(z1.imag>0))
        last=b;z0=z1
    assert last==g//2
    ang=z0.arg()+2*cross*arb.pi()
    theta=acb(arb(1)/4,arb(t)/2).lgamma().imag-arb(t)*arb.pi().log()/2
    value=1+(theta+ang)/arb.pi()
    n=value.unique_fmpz();assert n is not None
    results.append(dict(t=t,crossings_net=cross,final_principal_arg=str(z0.arg()),lifted_arg=str(ang),value=str(value),count=int(n),
                        panels=len(panels),cpu=process_time()-u0,wall=perf_counter()-t0))
    print(results[-1],flush=True)
(p/'branch-check.json').write_text(json.dumps(results,indent=2)+'\n')
