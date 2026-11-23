"""Independent full arithmetic reconstruction. No producer import or spectral work."""
from pathlib import Path
from fractions import Fraction as F
from math import prod
import hashlib
import json

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents'
PINS={
 'major-constants/FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md':'3A5444AB295112E86DF0740DB8F4533EC37510A66E41EB0DF0340D16CF82A4E1',
 'major-constants/family_batch_workload_20261111.py':'F6B182D6DF34756385CDAC690D8EE3AAF7E755DA3A69583B125FEB61464C6D82',
 'major-constants/family_batch_workload_20261111.json':'CC223B05E14E0DEF2B8DD5DB9567F638B9328D97D5A555D6B86B3D263597D543',
 'zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md':'53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54',
 'major-constants/FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md':'5064865E9CE249A896B6B083278938E0E77762B88DE4539E038E624AC011FF93',
 'mellin/REVIEW_FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md':'C4A41C85540F6B64E53FD04B485AA879F326D98AD5B049A0CFD5FEC634CA6BC7',
}
def pincheck():
    for p,h in PINS.items():
        assert hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h,p
pincheck()
expected=json.loads((BASE/'major-constants/family_batch_workload_20261111.json').read_text())
limit=300000
# Linear least-prime sieve, unlike the producer's totient sieve/divisor inversion.
lp=[0]*(limit+1); primes=[]; phi=[0]*(limit+1); phi[1]=1
for n in range(2,limit+1):
    if lp[n]==0:
        lp[n]=n; primes.append(n); phi[n]=n-1
    for p in primes:
        m=p*n
        if m>limit: break
        lp[m]=p
        if n%p==0:
            phi[m]=phi[n]*p
            break
        phi[m]=phi[n]*(p-1)

def local_data(n):
    factors=[]
    while n>1:
        p=lp[n]; q=1; e=0
        while n%p==0: n//=p; q*=p; e+=1
        factors.append((p,e,q))
    a=prod((p-2 if e==1 else (q//(p*p))*(p-1)**2) for p,e,q in factors)
    axes=[]
    for p,e,q in factors:
        if p>2: axes.append(q-q//p)
        elif e==2: axes.append(2)
        elif e>=3: axes.extend((2,q//4))
    return a,axes

# A separate convolution check verifies primitive local factors against all totients.
primitive=[0]*(limit+1); primitive[1]=1
for n in range(2,limit+1): primitive[n]=local_data(n)[0]
conv=[0]*(limit+1)
for d in range(1,limit+1):
    for n in range(d,limit+1,d): conv[n]+=primitive[d]
assert conv[1:]==phi[1:]

keys=list(expected['single_common_point_totals'])
sums=dict.fromkeys(keys,0); weighted=dict.fromkeys(keys,0)
lo=dict.fromkeys(keys,0); hi=dict.fromkeys(keys,0); scale=10**6
groups={}; maxima={k:(F(0),None) for k in expected['maxima']}
digest=hashlib.sha256(); count=0
active=sorted(list(range(3,150001,2))+list(range(4,300001,4)))
assert len(active)==149999 and len(set(active))==149999
for c in active:
    a,axes=local_data(c); v=phi[c]
    assert a>0 and prod(axes)==v
    pads=[]; butterflies=products=0
    for m in axes:
        P=1; d=0
        while P<2*m-1: P*=2; d+=1
        pads.append(P)
        butterflies+=(v//m)*3*(P//2)*d
        products+=(v//m)*(P+2*m)
    ws=[a,v,a*v,v*sum(axes),butterflies,products]
    qt=c if c%2==0 else 2*c
    raw_num=704*1200000; raw_den=7*qt
    hp=200+max(1000,(raw_num+raw_den-1)//raw_den)
    H=min(F(hp),F(10**8,c)); T=H.numerator//H.denominator+1
    assert H<T<=H+1
    category=('odd' if c%2 else 'four_divides')+':'+str(c.bit_length()-1)
    g=groups.setdefault(category,dict(conductors=0,primitive_outputs=0,unit_coefficients=0,primitive_T0=0,unit_T0=0))
    for k,value in [('conductors',1),('primitive_outputs',a),('unit_coefficients',v),('primitive_T0',a*T),('unit_T0',v*T)]: g[k]+=value
    for k,w in zip(keys,ws):
        sums[k]+=w; weighted[k]+=w*T
        num=H.numerator*w*scale; den=H.denominator
        lo[k]+=num//den; hi[k]+=(num+den-1)//den
    for k,value in [('phi',v),('primitive',a),('axes',len(axes)),('axis_order',max(axes)),('padded_axis',max(pads)),('height',H)]:
        if value>maxima[k][0]: maxima[k]=(F(value),c)
    digest.update(f'{c}|{a}|{v}|{H}|{T}|{axes}|{butterflies}|{products}\n'.encode())
    count+=1

actual={
 'scope':expected['scope'],'nonprincipal_conductors':count,
 'single_common_point_totals':sums,'T0_weighted_totals':weighted,
 'Hcert_weighted_bounds':{k:dict(lower=str(F(lo[k],scale)),upper=str(F(hi[k],scale)),width=str(F(hi[k]-lo[k],scale))) for k in keys},
 'maxima':{k:dict(value=str(v),conductor=c) for k,(v,c) in maxima.items()},
 'arithmetic_row_digest_sha256':digest.hexdigest().upper(),
 'groups_by_modulus_parity_and_floor_log2':groups,
 'grid_formula':expected['grid_formula'],'uncertified_grid_examples':[]}
for nx,rho in [(1,1),(1,16),(4,16)]:
    actual['uncertified_grid_examples'].append(dict(nx=nx,rho=rho,totals={k:2*rho*(3*nx+2)*weighted[k]+(2*nx+1)*sums[k] for k in keys}))
assert actual==expected, [k for k in actual if actual[k]!=expected[k]]
# Polynomial coefficients in (nx*ny,nx,ny,1) for V+E.
assert tuple(a+b+c for a,b,c in zip((1,1,1,1),(1,1,0,0),(1,0,1,0)))==(3,2,2,1)
pincheck()
out={'status':'PASS_FULL_ARITHMETIC_RECEIPT_RECONSTRUCTION',
 'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
 'pins':PINS,'method':'Linear totient sieve, multiplicative primitive counts, full divisor convolution, independent integer padding and directed weighted heights.',
 'all_300000_divisor_identities':True,'all_149999_rows_digest':digest.hexdigest().upper(),
 'all_receipt_fields_match':True,'reconstructed':actual,
 'scope':'Arithmetic only. No spectral margins, L-values, transforms, or production cost measurements.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(out['status'],count,digest.hexdigest().upper())
