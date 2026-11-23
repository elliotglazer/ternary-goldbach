"""Exact rational count/tail/allocation checks; no analytic values or spectral data."""
from pathlib import Path
from fractions import Fraction as F
import json

R=132900
LIMIT=2*R
SCALE=10**12
spf=list(range(LIMIT+1))
for p in range(2,LIMIT+1):
    if spf[p]==p:
        for n in range(p*p,LIMIT+1,p):
            if spf[n]==n: spf[n]=p
def factors(n):
    result=[]
    while n>1:
        p=spf[n];e=0
        while n%p==0: n//=p;e+=1
        result.append((p,e))
    return result
def ceil(x): return (x.numerator+x.denominator-1)//x.denominator
def exp_lower(x,n):
    term=F(1);total=term
    for k in range(1,n+1):
        term*=x/k;total+=term
    return total
phi=[1]*(LIMIT+1)
primitive=[1]*(LIMIT+1)
squarefree=[True]*(LIMIT+1)
for c in range(2,LIMIT+1):
    for p,e in factors(c):
        phi[c]*=(p-1)*p**(e-1)
        primitive[c]*=p-2 if e==1 else (p-1)**2*p**(e-2)
        if e>1: squarefree[c]=False
p8=[8**k for k in range(40)]
p3=[3**k for k in range(40)]
counts={};heights={};hist={};samples={}
for c in range(3,LIMIT+1):
    if not ((c%2 and c<=R) or c%4==0): continue
    qt=2*c if c%2 else c
    H=max(300,ceil(F(704*8*R,343*qt)))
    heights[c]=H
    k=1
    while p8[k]*600<=p3[k]*c*101*H: k+=1
    upper=F(101*H*(k-1),300)+1+F(200, H)*(42+F(693*k,100))
    counts[c]=ceil(upper)
    hist[H]=hist.get(H,0)+1
    if c in (3,4,5,8,10001,60004,132899,265800):
        samples[str(c)]={'H':H,'count_upper':counts[c],'log_upper_integer':k}
assert min(heights.values())==300 and max(heights.values())==545549
assert [c for c in heights if heights[c]==545549]==[4]
A=0;B=0;Bsf=0;Bnsf=0;mass=0;gausschecks=0
for q in range(1,LIMIT+1):
    if not ((q%2 and q<=R) or q%2==0):continue
    eligible=[1]
    for p,e in factors(q):
        if e==1: eligible += [c*p for c in eligible]
        else: eligible=[c*p**e for c in eligible]
    assert sum(c*primitive[c] for c in eligible)==phi[q]**2
    gausschecks+=1
    sf=sum(c*primitive[c]*counts.get(c,0) for c in eligible if c>1 and squarefree[c])
    nsf=sum(c*primitive[c]*counts.get(c,0) for c in eligible if c>1 and not squarefree[c])
    B+=(SCALE*(sf+nsf)+phi[q]-1)//phi[q]
    Bsf+=(SCALE*sf+phi[q]-1)//phi[q]
    Bnsf+=(SCALE*nsf+phi[q]-1)//phi[q]
    if squarefree[q]:
        assert nsf==0
        den=phi[q]**3
        A+=(SCALE*sf+den-1)//den
        mass+=(SCALE+phi[q]-1)//phi[q]
QA=F(A,SCALE*10**25);QB=F(B,SCALE*10**25)
assert F(mass,SCALE)<14

# Real-exponential comparisons proved using finite positive rational Taylor sums.
assert exp_lower(F(2397,50),200)>F(1338,5)*10**18  # EB(300)<1e-18
assert exp_lower(F(1065,10000)*32**2,500)>F(588,1000)*32**2*10**44
geom=1+F(600001)/F(27,10)
window=800*geom+F(106,300)*geom**2
assert window<2*10**10
windowB=800*3+F(106,300)*3**2
assert windowB<2404
tail=2*(F(2404,10**18)+F(2*10**10,10**44))
assert tail<F(5,10**15)
e=tail+F(1,10**18)+F(1,10**12)
assert e<F(2,10**12)
TA=F(8,10**9);TB=F(48,10**5)
assert (8*R)*14<4000**2
assert (3*R//2)*(8*R)*(2*R)<240000000**2
assert F(12,5)**8>1000

def check_profile(qa,qb):
    # beta .5075 on squarefree c; beta .62 elsewhere. Uniform 1e6 also bounds sf.
    lowA=7000000*F(12,5)*qa
    lowB=7000000*10**6*qb
    assert lowA<(F(2,10**6)-TA)**2
    assert lowB<(F(648,100)-TB)**2
    assert F(648,100)**2<42<62
    return {'GQA_upper':str(lowA),'GQB_upper':str(lowB),
            'A_bound':'4/1000000000000','B_bound':42}
previous=json.loads(Path(__file__).with_name('wstar_critical_baseline_metadata_20261111.json').read_text())
old=previous['profiles']['star_tail']
oldcheck=check_profile(F(old['Q_A_line_upper']),F(old['Q_B_line_upper']))
newcheck=check_profile(QA,QB)
# The revised consumer A4e-12/B62 row, checked without a square-root evaluation.
assert F(7875,1000)**2>62
assert F(1902,10**9)+F(2,10**6)+F(885,10**9)*F(7875,1000)<F(2964,1000)*F(367,10**8)
assert F(2964,1000)**2<F(879,100)
result={'status':'PASS_EXACT_FLOOR300_COUNTS_AND_TAIL','R':R,'floor':300,
        'active_nonprincipal_conductors':len(counts),'modulus_gauss_checks':gausschecks,
        'height_min':300,'height_max':545549,'max_height_conductors':[4],
        'conductors_at_floor':hist[300],'samples':samples,
        'directed_sum_denominator':SCALE,'weighted_count_A_numerator':A,
        'weighted_count_B_numerator':B,'weighted_count_B_squarefree_numerator':Bsf,
        'weighted_count_B_nonsquarefree_numerator':Bnsf,
        'Q_A_line_upper':str(QA),'Q_B_line_upper':str(QB),
        'sum_squarefree_inverse_phi_upper':str(F(mass,SCALE)),
        'geometric_window_A_bound':str(window),'geometric_window_B_bound':str(windowB),'high_tail_upper':str(tail),
        'remainder_upper':str(e),'TA_upper':str(TA),'TB_upper':str(TB),
        'old_floor1000_profile_check':oldcheck,'new_floor300_profile_check':newcheck,
        'scope':'Paper count and scalar bounds only. No actual spectrum, transform or function values.'}
out=Path(__file__).with_suffix('.json')
if out.exists():raise SystemExit('Refusing to overwrite existing receipt')
out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2))
