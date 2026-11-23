"""Independent integer schedule/error-bound reconstruction, no transform values."""
from pathlib import Path
from math import prod
import hashlib
import json

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents/zero-sum'
PINS={
 'MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'mixed_radix_precision_metadata_20261111.py':'3750A9C8FD77163C878694959158762D183F1425E4F85F983230A841BAEBDC42',
 'mixed_radix_precision_metadata_20261111.json':'8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E',
 'MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md':'C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01',
 'mixed_radix_character_inventory_20261111.json':'2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F',
}
for name,expected in PINS.items():
    assert hashlib.sha256((BASE/name).read_bytes()).hexdigest().upper()==expected
saved=json.loads((BASE/'mixed_radix_precision_metadata_20261111.json').read_text())
old=json.loads((BASE/'mixed_radix_character_inventory_20261111.json').read_text())

N=300000
small=[0]*(N+1)
for p in range(2,N+1):
    if small[p]==0:
        for j in range(p,N+1,p):
            if small[j]==0: small[j]=p
def factors(n):
    out=[]
    while n>1:
        p=small[n]; e=0
        while n%p==0: n//=p; e+=1
        out.append((p,e))
    return out
families=[]; axes=set()
for c in range(3,N+1):
    if not (c%4==0 or c%2==1 and c<=150000): continue
    ds=[]
    for p,e in factors(c):
        if p==2:
            ds.append(2)
            if e>=3: ds.append(2**(e-2))
        else: ds.append((p-1)*p**(e-1))
    assert prod(ds)==prod((p-1)*p**(e-1) for p,e in factors(c))
    families.append((c,ds)); axes.update(ds)
assert len(families)==saved['conductor_count']==149999
assert len(axes)==saved['axis_length_count']==13943

def add(*vs): return tuple(sum(v[i] for v in vs) for i in range(5))
def scale(v,k): return tuple(x*k for x in v)
def power2(n): return n&(n-1)==0
def rad(n):
    # Stagewise count rather than the author's closed expression.
    out=[0]*5
    length=2
    while length<=n:
        groups=n//length
        out[0]+=groups*max(0,length//2-1-int(length>=4))
        out[1]+=n
        out[2]+=groups*int(length>=4)
        length*=2
    return tuple(out)
def pad(n): return 1<<(2*n-2).bit_length()
def blue(n):
    d=prod(p**((e+1)//2) for p,e in factors(n//(2 if n%2==0 else 1)))
    count=(n-1)//d+1
    alpha=(2*d*d//n)%4
    assert 2*d*d%n==0
    odd=count//2
    quarter=odd if alpha in (1,3) else 0
    negative=odd if alpha==2 else 0
    P=pad(n)
    return add(scale(rad(P),2),(P+2*(n-count),0,2*quarter,2*negative,P))
def bridge(r,m):
    n=r*m; counts=[]
    for h in (1,2,3):
        counts.append(sum(1 for a in range(1,r) if h*n%4==0 and (h*n//4)%a==0 and 0<h*n//(4*a)<m))
    return ((r-1)*(m-1)-sum(counts),0,counts[0]+counts[2],counts[1],0)
def rb(n):
    k=n.bit_length()-1
    return (2*k+4,max(1,2*k)) if n>1 else (0,1)
def bb(n):
    P=pad(n); k=P.bit_length()-1; R=2*k+4; A=1+3*R
    return 6*P*A+2*R*(2*n+1)+8,max(1,2*k,P*A,3*n*P*A+1)

counts={}; choices={}; bounds={}; oldbounds={}
for n in range(1,max(axes)+1):
    oldcounts=rad(n) if power2(n) else blue(n)
    oldbounds[n]=rb(n) if power2(n) else bb(n)
    counts[n]=oldcounts
    bounds[n]=oldbounds[n]
    if power2(n): choices[n]=['radix2']
    elif small[n]==n:
        if n<=11:
            choices[n]=['direct_prime']; counts[n]=((n-1)**2,n*(n-1),0,0,0); bounds[n]=(2,1)
        else: choices[n]=['bluestein']
    else:
        r=small[n]; m=n//r
        candidate=add(scale(counts[m],r),scale(counts[r],m),bridge(r,m))
        if candidate[0]<=oldcounts[0] and candidate[1]<=oldcounts[1]:
            choices[n]=['split',r,m]; counts[n]=candidate
            cm,dm=bounds[m]; cr,dr=bounds[r]
            bounds[n]=(cm+cr+2,max(1,dm,dr,cm+cr*(2*cm+1)))
        else: choices[n]=['bluestein']

active=set(); stack=list(axes)
while stack:
    n=stack.pop()
    if n in active: continue
    active.add(n)
    if choices[n][0]=='split': stack.extend(choices[n][1:])
keys=['general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales']
plan={str(n):dict(choice=choices[n],count=dict(zip(keys,counts[n]))) for n in sorted(active)}
ph=hashlib.sha256(json.dumps(plan,sort_keys=True,separators=(',',':')).encode()).hexdigest()
assert ph==saved['plan_sha256']==old['canonical_plan_sha256']
assert len(active)==saved['active_plan_count']==37117
assert len(saved['axis_rows'])==len(axes)
seen=set(); badraw=[]; badbits=[]
def bits(d): return (d-1).bit_length()
for row in saved['axis_rows']:
    n=row['n']; assert n in axes and n not in seen; seen.add(n)
    oc,od=oldbounds[n]; nc,nd=bounds[n]
    assert row==dict(n=n,old_C=oc,new_C=nc,old_D=od,new_D=nd)
    assert nc<=oc
    if nd>od: badraw.append(row)
    if bits(nd)>bits(od): badbits.append(row)
assert seen==axes and badraw==saved['safety_exceptions'] and not badbits
assert [r['n'] for r in badraw]==[598]
assert not saved['coefficient_exceptions'] and not saved['safety_dyadic_bit_exceptions']
maxold=max(oldbounds[n][1] for n in axes); maxnew=max(bounds[n][1] for n in axes)
assert maxold==saved['max_old_D'] and maxnew==saved['max_new_D']
assert bits(maxold)==saved['old_safety_bits']==45
assert bits(maxnew)==saved['new_safety_bits']==43
maxs=[0,0]
for c,ds in families:
    a=sum(oldbounds[n][0] for n in ds); b=sum(bounds[n][0] for n in ds)
    assert b<=a
    maxs=[max(maxs[0],a),max(maxs[1],b)]
    if str(c) in saved['examples']:
        assert saved['examples'][str(c)]==dict(axes=ds,old_sum_C=a,new_sum_C=b)
assert maxs==[saved['max_old_sum_C'],saved['max_new_sum_C']]
result=dict(status='PASS_INTEGER_RECONSTRUCTION',scope='No roots/transform values; analytical bound requires separate paper proof',
            pins=PINS,conductors=len(families),axis_lengths=len(axes),active_nodes=len(active),plan_sha256=ph,
            exceptions=badraw,dyadic_exceptions=badbits,max_old_D=maxold,max_new_D=maxnew,
            safety_bits=[bits(maxold),bits(maxnew)],max_sum_C=maxs)
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8',newline='\n') as out:
    json.dump(result,out,indent=2); out.write('\n')
print('PASS: 149999 conductors, all 13943 axes, 37117 active nodes, identical plan hash.')
