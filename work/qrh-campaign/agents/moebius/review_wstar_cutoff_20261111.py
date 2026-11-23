"""Independent conductor/count metadata and rational inequalities, no function values."""
from pathlib import Path
from fractions import Fraction as F
from math import gcd
import hashlib,json
HERE=Path(__file__).resolve().parent
AG=HERE.parent
SRC=AG.parents[1]/'ternary-goldbach'/'TernaryGoldbach'
author=AG/'zero-sum/WSTAR_CUTOFF_BASELINE_TRADEOFF_2026-11-11.md'
expected=json.loads((AG/'zero-sum/wstar_critical_baseline_metadata_20261111.json').read_text())
checks=0
def ok(p):
    global checks
    assert p
    checks+=1
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
ok(sha(author)=='55D2E58DA0F13A77ECC3AB097E5CAC45D58EE247178F8A8D5824756A45E1C2AB')
pins=[]
for line in author.read_text().splitlines():
    if not line.startswith('|'):continue
    f=[x.strip().strip('`') for x in line.strip('|').split('|')]
    if len(f)!=2 or len(f[1])!=64:continue
    path=(SRC if f[0].endswith('.lean') else AG)/f[0]
    ok(sha(path)==f[1]);pins.append({'path':str(path),'sha256':f[1]})
R=132900;M=2*R;S=10**12
phi=list(range(M+1));mu=[1]*(M+1)
for d in range(2,M+1):
    if phi[d]==d:
        for n in range(d,M+1,d):phi[n]-=phi[n]//d;mu[n]*=-1
        for n in range(d*d,M+1,d*d):mu[n]=0
# Independent divisor inversion of phi=sum of primitive-character counts.
prim=phi.copy();prim[1]=1
for d in range(1,M+1):
    for n in range(2*d,M+1,d):prim[n]-=prim[d]
ok(all(x>=0 for x in prim[1:]))
def admissible(q):return q%2==0 or q<=R
names=['cap500','cap1000','star_tail','original']
cnt={key:[0]*(M+1) for key in names}
pow8=[8**k for k in range(40)];pow3=[3**k for k in range(40)]
def bounds(c,n,d):
    ok(99*n>5000*d and 99*c*n>700*d)
    k=next(k for k in range(1,40) if pow8[k]*600*d>pow3[k]*101*c*n)
    den=300*d*n
    num=101*n*n*(k-1)+300*d*n+600*(4200+693*k)*d*d
    return (num+den-1)//den,k
for c in range(3,M+1):
    if not prim[c] or not admissible(c):continue
    n,d=(100000000,c) if c%2 or c<=125000 else (200*c+75000000,c)
    qt=c if c%2==0 else 2*c
    hs=max(1000,(704*8*R+343*qt-1)//(343*qt))
    ok(1000<=hs<=545550)
    if c==4:ok(hs==545549)
    nd={'original':(n,d),'star_tail':(hs,1),
        'cap500':(min(n,500*d),d),'cap1000':(min(n,1000*d),d)}
    for key,(a,b) in nd.items():
        cnt[key][c],k=bounds(c,a,b)
        sample=expected['samples'][key].get(str(c))
        if sample:
            ok(F(a,b)==F(sample['T']) and cnt[key][c]==sample['count_upper_integer'] and k==sample['upper_log_integer'])
gauss=[0]*(M+1);nums={key:[0]*(M+1) for key in names}
# Traverse conductors and their admissible squarefree cofactor, instead of factoring q.
for c in range(1,M+1):
    if prim[c]==0 or not admissible(c):continue
    base=c*prim[c]
    for r in range(1,M//c+1):
        q=c*r
        if not admissible(q) or mu[r]==0 or gcd(c,r)!=1:continue
        gauss[q]+=base
        if c>1:
            for key in names:nums[key][q]+=base*cnt[key][c]
tot=0;qs=0
results={key:[0,0] for key in names}
for q in range(1,M+1):
    if not admissible(q):continue
    qs+=1;ok(gauss[q]==phi[q]**2)
    if mu[q]:tot+=(S+phi[q]-1)//phi[q]
    for key in names:
        z=nums[key][q]
        results[key][1]+=(S*z+phi[q]-1)//phi[q]
        if mu[q]:results[key][0]+=(S*z+phi[q]**3-1)//phi[q]**3
for key,(a,b) in results.items():
    e=expected['profiles'][key]
    ok(a==e['weighted_count_A_upper_numerator'] and b==e['weighted_count_B_upper_numerator'])
    ok(F(a,S*10**25)==F(e['Q_A_line_upper']) and F(b,S*10**25)==F(e['Q_B_line_upper']))
ok(qs==expected['Qset_count']==199350)
ok(F(tot,S)==F(expected['sum_squarefree_inverse_phi_upper'])<14)
for t,record in expected['c3_obstructions'].items():
    T=F(t);lo=F(99,100)*T;hi=F(101,100)*T
    k=next(k for k in range(1,40) if F(8,3)**k>3*hi/6)
    ell=max(j for j in range(40) if 3**j<F(7,44)*3*lo)
    low=lo*F(7,22)*(ell-1)-1-200*(42+F(693,100)*k)/T
    ratio=F(3,4)*low/10**25/F(4,7*10**18)
    ok(low==F(record['count_lower']) and ratio==F(record['factor_over_target']))
    ok(ratio>(19 if T>3000000 else 1))
ok(F(9,16)/50+F(22,56)+F(1,300)+F(1,3)<1)
ok(4+F(174,100)**2<F(27,10)**2)
ok(F(12,5)**8>1000)
ok(F(12,5)*F(results['star_tail'][0],S*10**25)<F(4,7*10**18))
ok(F(12,5)*F(results['star_tail'][1],S*10**25)<F(4,7*10**6))
ok(8*R*14<4000**2 and (3*R//2)*(8*R)*(2*R)<240000000**2)
g=1+F(600001)*F(10,27)
ok(800*g+F(106,1000)*g*g<10**10)
ok(1+1/(F(1398,10000)*F(44,10))<3)
ok(F(193,100)*F(44,10)/F(22,7)>F(27,10))
ok(8+10*13+19+10*19+2==349<400)
def positive_series_exceeds(x,cap,limit):
    term=F(1);s=term
    for j in range(1,limit+1):
        term*=x/j;s+=term
        if s>cap:return j
    raise AssertionError('positive series witness not reached')
degrees={}
for label,x,cap,limit in [('EA',F(1065,10000)*1024,F(588,1000)*1024*10**44,500),
                          ('EB',F(1598,10000)*1000,F(892,1000)*1000*10**65,600),
                          ('logc',F(13),F(300001),60),
                          ('logheight',F(19),F(5,4)*(10**8+22),90),
                          ('log1400',F(8),F(1400),50),
                          ('center',F(2),1/F(355,1000),30)]:
    degrees[label]=positive_series_exceeds(x,cap,limit);ok(True)
ok(1000*10**10*(F(1,10**44)+F(1,10**65))<F(1,10**30))
ok(F(1,10**12)+F(1,10**18)+F(1,10**30)<F(2,10**12))
result={'scope':'Independent conductor arithmetic, directed rounding, rational series witnesses and pins only; no spectral evaluation.',
        'checks':checks,'profiles':results,'Qset_count':qs,'totient_numerator':tot,
        'positive_series_degrees':degrees,'pins':pins}
HERE.joinpath('review_wstar_cutoff_20261111.json').write_text(json.dumps(result,indent=2)+'\n')
print('PASS',checks,'integer/rational/pin checks')
