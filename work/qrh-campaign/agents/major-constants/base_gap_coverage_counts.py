"""Integer-only counts for the reviewed five base-gap rectangles and coarse union."""
import hashlib
import json
from pathlib import Path
HERE=Path(__file__).resolve().parent
SOURCE=HERE.parents[1]/'base_gap_classifier.json'
LIMIT=150000
phi=list(range(LIMIT+1))
for p in range(2,LIMIT+1):
    if phi[p]==p:
        for q in range(p,LIMIT+1,p):phi[q]-=phi[q]//p
allq=set(range(1,LIMIT+1))
rectangles=[(50000,8,5),(60000,2,1),(100000,4,1),(120000,1001,192),(125000,11,2)]
sets=[{q for q in allq if q>=lo and den*q<=num*phi[q]} for lo,num,den in rectangles]
binned=set().union(*sets)
data=json.loads(SOURCE.read_text(encoding='utf-8-sig'))
coarse=set(data['covered_denominators'])
assert len(coarse)==len(data['covered_denominators'])==data['covered_count']==49034
assert coarse<=allq
union=binned|coarse

def stats(qs):
    primes=sum(q>=2 and phi[q]==q-1 for q in qs)
    units=int(1 in qs)
    return dict(count=len(qs),primes=primes,composites=len(qs)-primes-units,units=units,min_Q=min(qs) if qs else None,max_Q=max(qs) if qs else None)
result=dict(status='Exact integer set counts. Analytic certificates and upstream Type I/II replacement remain separate proof obligations.',domain=[1,LIMIT],coarse_source_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest(),rectangles=[dict(min_Q=lo,v_num=num,v_den=den,covered=stats(qs)) for (lo,num,den),qs in zip(rectangles,sets)],binned=stats(binned),coarse=stats(coarse),union=stats(union),added_to_coarse=stats(binned-coarse),coarse_outside_binned=stats(coarse-binned),remaining=stats(allq-union),remaining_denominators=sorted(allq-union),covered_denominators=sorted(union))
assert result['union']['count']+result['remaining']['count']==LIMIT
HERE.joinpath('base_gap_coverage_counts.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if not k.endswith('_denominators')},indent=2))
