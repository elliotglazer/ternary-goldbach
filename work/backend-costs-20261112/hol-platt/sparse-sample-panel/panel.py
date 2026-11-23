import json
from pathlib import Path
from collections import defaultdict
from flint import dirichlet_char
from math import gcd
here=Path(__file__).resolve().parent
base=here.parents[2]/"qrh-campaign/agents"
rows=json.loads((base/"integration/transform_structural_manifest_20261111.json").read_bytes())["conductors"]
schedule=json.loads((base/"prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json").read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]["raw_metadata"]
schedule={r[0]:r[1] for r in schedule}
groups=defaultdict(list)
for q,m in schedule.items():
    n=q
    count=1
    phi=q
    for p in range(2,q+1):
        if n==1: break
        if n%p: continue
        e=0
        while n%p==0:
            n//=p
            e+=1
        phi=phi//p*(p-1)
        count*=p-2 if e==1 else (p-1)**2*p**(e-2)
    height=m*5//64
    if q not in schedule: continue
    group=("odd prime" if phi==q-1 else "odd composite") if q%2 else ("v2=2" if q%8 else "v2>=3")
    groups[group].append((q,count*(schedule[q]+1),count,height,schedule[q]+1))
result={}
for g,rr in groups.items():
    rr.sort()
    total=sum(r[1] for r in rr)
    samples=[]
    for percentile in ([25,75] if g=="odd composite" else [75]):
        accum=0
        for q,w,c,h,points in rr:
            accum+=w
            if 100*accum>=percentile*total:break
        pairs={}
        for a in range(1,q):
            if gcd(a,q)>1:continue
            inverse=pow(a,-1,q)
            if a>=inverse:continue
            chi=dirichlet_char(q,a)
            if not chi.is_primitive():continue
            parity=int(chi.parity())
            pairs.setdefault(parity,[a,inverse])
            if len(pairs)==2:break
        samples.append(dict(percentile=percentile,q=q,height=h,points=points,pairs=pairs))
    result[g]=dict(conductors=len(rr),characters=sum(r[2] for r in rr),samples=total,roster=samples)
print(json.dumps(result,indent=2))
(here/"panel.json").write_text(json.dumps(result,indent=2))

