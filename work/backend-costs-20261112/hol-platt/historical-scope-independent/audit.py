from pathlib import Path
import hashlib,json,math
from fractions import Fraction as F
here=Path(__file__).resolve().parent
N=400000
factors=[0]*(N+1)
for p in range(2,N+1):
    if factors[p]:continue
    for j in range(p,N+1,p):factors[j]=p
def primitive(q):
    v=1
    while q>1:
        p=factors[q];e=0
        while q%p==0:q//=p;e+=1
        v*=p-2 if e==1 else (p-1)**2*p**(e-2)
    return v
def ceil(a):return -(-a.numerator//a.denominator)
def saved_height(c):
    group=0 if c<100 else 1 if c<1000 else 2 if c<10000 else 3
    odd=c%2==1
    u10=([210,200,195,192] if odd else [226,211,201,191])[group]
    return 200+ceil(max(F(240 if odd else 255),F(31416*u10*(531600 if odd else 1063200),100000*c)))
def historic(q):
    return max(F(100000000,q),F(37500000 if q%2 else 75000000,q)+200)
hp=sp=count=run=0
examples=[]
exceed=[]
maxratio=(F(0),0)
for c in range(2,N+1):
    n=primitive(c)
    hp+=n
    if n and ((c%2 and c<=132900) or (c%4==0 and c<=265800)):
        count+=1;sp+=n
        h=saved_height(c);old=historic(c)
        if h>old:exceed.append(c)
        maxratio=max(maxratio,(h/old,c))
        if c in (3,4,10000,10004,132899,265800):examples.append([c,h,str(old)])
# q=1, the primitive trivial character, tests the census boundary.
assert hp==29565923837
manifest=here.parents[2]/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"
records=json.loads(manifest.read_bytes())["conductors"]
assert len(records)==125400
for c,phi,n,h,j,axes,ws in records:
    assert n==primitive(c) and h==saved_height(c)
small=here.parents[2]/"qrh-campaign/agents/prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json"
small_rows=json.loads(small.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]["raw_metadata"]
assert len(small_rows)==7499
for c,m,*extra in small_rows:
    assert m==ceil(F(64*saved_height(c),5))
latest=here.parent/"price-check-20261120/README.md"
transfer=here.parent/"small-gaussian-transform/boundary.json"
boundary=json.loads(transfer.read_text())
out=dict(historical_nonprincipal=hp,historical_including_q1=hp+1,current_nonprincipal=sp,
         active_conductors=count,character_fraction=float(F(sp,hp)),heights_exceed=exceed,
         largest_main_height_ratio=[float(maxratio[0]),maxratio[1]],examples=examples,
         family_seconds_per_character_to_800k=[170999*3600/sp,171528*3600/sp],
         small_only_seconds_per_character_to_800k=[170999*3600/18477108,171528*3600/18477108],
         manifest_sha256=hashlib.sha256(manifest.read_bytes()).hexdigest(),small_sha256=hashlib.sha256(small.read_bytes()).hexdigest(),
         historical_hours=400000,subtotal_sensitivity=[628472,629001],
         remaining_to_twice=[800000-629001,800000-628472],
         sha256={str(p.relative_to(here.parent)):hashlib.sha256(p.read_bytes()).hexdigest() for p in (latest,transfer)})
print(json.dumps(out,indent=2))
(here/"audit.json").write_text(json.dumps(out,indent=2)+"\n")

