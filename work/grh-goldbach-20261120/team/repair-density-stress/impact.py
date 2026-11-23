"""Independently replay all interior repairs and compare guard-50 strict margins."""
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
from time import process_time
import json
import sys

out=Path(__file__).resolve().parent
parent=out.parents[2]/'backend-costs-20261112/hol-platt'
sys.path.extend([str(parent/'one-character-completeness'),str(parent/'small-character-kernel')])
from repair import GRID_BITS,HALO,ORDER,SUB,WBITS,discover,kernel,rationals
from spectrum import LABELS,parameters
spec=json.loads((out/'spectrum.json').read_bytes())
grid=json.loads((out/'grid.json').read_bytes())
counts=json.loads((out/'counts.json').read_bytes())
analytic,rem,sample=rationals(spec)
main,last,*_=parameters()
totals={'coarse':[0,0],'repaired':[0,0]}
rows=[]
for label,g in zip(LABELS,grid['rows'],strict=True):
    p=out/f'grid-{label}.txt'
    assert sha256(p.read_bytes()).hexdigest()==g['grid_sha256']
    raw=list(map(int,p.read_text().splitlines()))
    error=analytic+rem+5*sample+F(ORDER*max(map(abs,raw)),1<<(WBITS+GRID_BITS))
    coarse=[(j*SUB,1 if v>0 else -1) for j,v in enumerate(raw[HALO:HALO+last+1])]
    start=process_time()
    jobs=discover(raw,last)
    discovery_time=process_time()-start
    start=process_time()
    extra=[]
    for tick in sorted(jobs):
        j,offset=divmod(tick,SUB)
        assert 0<offset<SUB
        first=j+HALO+1-ORDER//2
        dot=sum(w*v for w,v in zip(kernel(offset),raw[first:first+ORDER],strict=True))
        assert abs(dot)>error*(1<<(WBITS+GRID_BITS))
        extra.append((tick,1 if dot>0 else -1))
    cert_time=process_time()-start
    def flips(signs,l,h):
        selected=[(j,s) for j,s in signs if l<=j<=h]
        return [j for (_,s),(j,t) in zip(selected,selected[1:]) if s!=t]
    item=dict(label=label,jobs=len(jobs),main_jobs=sum(j<main*SUB for j in jobs),discovery_CPU_s=discovery_time,
              repair_CPU_s=cert_time,offsets=sorted(set(t%SUB for t in jobs)))
    for name,signs in [('coarse',coarse),('repaired',sorted(coarse+extra))]:
        K=len(flips(signs,0,main*SUB))
        ends=flips(signs,main*SUB,last*SUB)
        weight=sum(last*SUB-j for j in ends)
        item[name]=dict(K=K,guard_brackets=len(ends),W_ticks=weight)
        totals[name][0]+=K
        totals[name][1]+=weight
    rows.append(item)
native=counts['counts'][str(LABELS)]['fixed'][-1]
assert native['extra']==640 and last-main==640
variants={}
for name,(K,weight) in totals.items():
    W=F(5*weight,64*SUB)
    excess=(F(native['phase_upper'])-W+36)/50-K
    variants[name]=dict(K=K,W_ticks=weight,U_minus_K=str(excess),decimal=float(excess),passed=excess<1)
report=dict(labels=LABELS,coarse_cells=2*last,rows=rows,variants=variants,
            freeze_sha256=sha256((out/'freeze.json').read_bytes()).hexdigest())
(out/'impact.json').write_text(json.dumps(report,indent=2))
print(report)
