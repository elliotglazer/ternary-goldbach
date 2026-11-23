"""Independent exact metadata and rational checks. No analytic or spectral values."""
from pathlib import Path
from fractions import Fraction as F
from math import gcd
import hashlib,json
HERE=Path(__file__).resolve().parent;AG=HERE.parent;WORK=AG.parents[1]
checks=0;pins=[]
def ok(p):
    global checks
    assert p
    checks+=1
def pin(path,digest):
    actual=hashlib.sha256(path.read_bytes()).hexdigest().upper();ok(actual==digest)
    pins.append({'path':str(path),'sha256':actual})
rootnote=WORK/'qrh-blueprint/MIXED_CONDUCTOR_WSTAR_PROFILE_2026-11-11.md'
floornote=AG/'zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md'
pin(rootnote,'42A5373CDA2DABBCC10722CBA8D2704A7D2E6DAFD601B94EC5F599856249BBA0')
pin(floornote,'E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794')
for note in [rootnote,floornote]:
    for line in note.read_text().splitlines():
        if not line.startswith('|'):continue
        a=[t.strip().strip('`') for t in line.strip('|').split('|')]
        if len(a)!=2 or len(a[1])!=64:continue
        rel=a[0]
        path=WORK/rel if rel.startswith('qrh-blueprint/') else (AG.parent/rel if rel.startswith('agents/') else AG/rel)
        pin(path,a[1])
pin(WORK/'qrh-blueprint/check_mixed_wstar_profile_20261111.py','F3DED4875780509102F99D95EE23CA8FFB37E644691912AC21586BE80ABB20C9')
pin(WORK/'qrh-blueprint/mixed_wstar_profile_20261111.json','42C7BDBEEDEA175A3757830C75EF9D482756586FEDB57709D83A61948EB4A9D4')
old=json.loads((AG/'zero-sum/wstar_critical_baseline_metadata_20261111.json').read_text())['profiles']['star_tail']
targets={f:json.loads((AG/f'zero-sum/wstar_floor{f}_metadata_20261111.json').read_text()) for f in (300,500)}
R=132900;M=2*R;S=10**12
phi=list(range(M+1));mu=[1]*(M+1)
for p in range(2,M+1):
    if phi[p]==p:
        for j in range(p,M+1,p):phi[j]-=phi[j]//p;mu[j]*=-1
        for j in range(p*p,M+1,p*p):mu[j]=0
prim=phi.copy();prim[1]=1
for d in range(1,M+1):
    for j in range(2*d,M+1,d):prim[j]-=prim[d]
def ambient(q):return q%2==0 or q<=R
counts={f:[0]*(M+1) for f in targets};atfloor={f:0 for f in targets};active=0
for c in range(3,M+1):
    if not ambient(c) or prim[c]==0:continue
    active+=1;qt=c if c%2==0 else 2*c
    raw=(704*8*R+343*qt-1)//(343*qt)
    for f in targets:
        h=max(f,raw);ok(f<=h<=545549)
        atfloor[f]+=int(h==f)
        k=1
        while 8**k*600<=3**k*c*101*h:k+=1
        # Integer numerator of 1.01h(k-1)/3+1+200(42+6.93k)/h.
        numerator=101*h*h*(k-1)+300*h+600*(4200+693*k)
        counts[f][c]=(numerator+300*h-1)//(300*h)
        sample=targets[f]['samples'].get(str(c))
        if sample:ok(sample=={'H':h,'count_upper':counts[f][c],'log_upper_integer':k})
nums={f:([0]*(M+1),[0]*(M+1)) for f in targets}
gauss=[0]*(M+1)
for c in range(1,M+1):
    if not ambient(c) or prim[c]==0:continue
    weight=c*prim[c]
    for r in range(1,M//c+1):
        q=c*r
        if not ambient(q) or mu[r]==0 or gcd(r,c)!=1:continue
        gauss[q]+=weight
        if c>1:
            for f in targets:nums[f][int(mu[c]==0)][q]+=weight*counts[f][c]
result={f:[0,0,0,0] for f in targets};nq=0;tot=0
for q in range(1,M+1):
    if not ambient(q):continue
    nq+=1;ok(gauss[q]==phi[q]**2)
    if mu[q]:tot+=(S+phi[q]-1)//phi[q]
    for f in targets:
        a,b=nums[f][0][q],nums[f][1][q]
        result[f][1]+=(S*(a+b)+phi[q]-1)//phi[q]
        result[f][2]+=(S*a+phi[q]-1)//phi[q]
        result[f][3]+=(S*b+phi[q]-1)//phi[q]
        if mu[q]:
            ok(b==0);result[f][0]+=(S*a+phi[q]**3-1)//phi[q]**3
for f,t in targets.items():
    keys=['weighted_count_A_numerator','weighted_count_B_numerator','weighted_count_B_squarefree_numerator','weighted_count_B_nonsquarefree_numerator']
    ok(result[f]==[t[k] for k in keys])
    ok(atfloor[f]==t['conductors_at_floor'] and active==t['active_nonprincipal_conductors']==132899)
    ok(nq==t['modulus_gauss_checks']==199350)
    ok(F(tot,S)==F(t['sum_squarefree_inverse_phi_upper'])<14)
def lower_series(x,n):
    s=z=F(1)
    for j in range(1,n+1):z*=x/j;s+=z
    return s
ok(lower_series(F(2397,50),200)>F(1338,5)*10**18)
ok(lower_series(F(799,10),300)>446*10**31)
ok(lower_series(F(1065,10000)*1024,500)>F(588,1000)*1024*10**44)
g=1+F(600001)/F(27,10)
sa=800*g+F(106,300)*g*g;sb=2400+F(106,300)*9
ok(sa<2*10**10 and sb<2404)
tail300=2*(F(2404,10**18)+F(2*10**10,10**44))
tail500=2*2*10**10*(F(1,10**31)+F(1,10**44))
ok(tail300<F(5,10**15) and tail500<F(5,10**21))
ok(tail300+F(1,10**18)+F(1,10**12)<F(2,10**12))
ok(F(12,5)**8>1000 and 25*(2*F(203,400)-1)==F(3,8))
ok(25*(2*F(31,50)-1)==6)
rows=[(F(old['Q_A_line_upper']),F(old['Q_B_line_upper']))]+[(F(result[f][0],S*10**25),F(result[f][1],S*10**25)) for f in targets]
for a,b in rows:
    ok(7000000*F(12,5)*a<(F(2,10**6)-F(8,10**9))**2)
    ok(7000000*10**6*b<(F(648,100)-F(48,10**5))**2)
ok(7000000*10**6*rows[0][1]<F(647,100)**2)
ok(F(647,100)+F(48,10**5)<F(648,100) and F(648,100)**2<42<62)
ok(F(7875,1000)**2>62 and F(2964,1000)**2<F(879,100))
ok(F(1902,10**9)+F(2,10**6)+F(885,10**9)*F(7875,1000)<F(2964,1000)*F(367,10**8))
ok(F(1989,100)*F(31416,10000)>F(704,343))
out={'scope':'Independent exact metadata, pins and rational composition; no spectral values or source theorem execution.',
     'checks':checks,'floors':result,'conductors_at_floor':atfloor,'active_conductors':active,'ambient_moduli':nq,'pins':pins}
HERE.joinpath('review_wstar_lower_floors_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS',checks,'exact checks')
