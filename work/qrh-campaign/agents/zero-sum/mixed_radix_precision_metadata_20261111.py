"""Integer-only error-coefficient/schedule comparison; no root or FFT values."""
from pathlib import Path
from functools import lru_cache
import hashlib, json

ROOT=Path(__file__).parent
OLD=ROOT/'mixed_radix_character_inventory_20261111.json'
assert hashlib.sha256(OLD.read_bytes()).hexdigest().upper()=='2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F'
old=json.loads(OLD.read_text())
N=300000
spf=list(range(N+1))
for p in range(2,N+1):
    if spf[p]==p:
        for j in range(p*p,N+1,p):
            if spf[j]==j: spf[j]=p
def fac(n):
    out=[]
    while n>1:
        p=spf[n];e=0
        while n%p==0:n//=p;e+=1
        out.append((p,e))
    return out
def pow2(n):return n>0 and n&(n-1)==0
def plus(*vs):return tuple(map(sum,zip(*vs)))
def times(k,v):return tuple(k*x for x in v)
def rad(n):
    if n==1:return (0,0,0,0,0)
    k=n.bit_length()-1
    return (n*k//2-3*n//2+2,n*k,n//2-1,0,0)
def plen(n):return 1<<(2*n-2).bit_length()
@lru_cache(None)
def blue(n):
    d=1
    for p,e in fac(n//(2 if n%2==0 else 1)):d*=p**((e+1)//2)
    cheap=[0]*4
    for j in range(0,n,d):cheap[(2*j*j//n)%4]+=1
    g=n-sum(cheap);q=cheap[1]+cheap[3];z=cheap[2];P=plen(n)
    return plus(times(2,rad(P)),(P+2*g,0,2*q,2*z,P))
def baseline(n):return rad(n) if pow2(n) else blue(n)
def bridge(r,m):
    n=r*m;q=z=0
    for h in (1,2,3):
        if h*n%4:continue
        target=h*n//4
        for a in range(1,r):
            if target%a==0 and 1<=target//a<m:
                if h==2:z+=1
                else:q+=1
    return ((r-1)*(m-1)-q-z,0,q,z,0)
choices={}
@lru_cache(None)
def mixed(n):
    b=baseline(n)
    if pow2(n):choices[n]=('radix2',);return b
    r=spf[n]
    if r==n:
        if n<=11:choices[n]=('direct_prime',);return ((n-1)**2,n*(n-1),0,0,0)
        choices[n]=('bluestein',);return b
    m=n//r;v=plus(times(r,mixed(m)),times(m,mixed(r)),bridge(r,m))
    if v[0]<=b[0] and v[1]<=b[1]:choices[n]=('split',r,m);return v
    choices[n]=('bluestein',);return b
KEYS=('general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales')
axes=set();families=[]
for c in range(3,N+1):
    if not ((c%2 and c<=150000) or c%4==0):continue
    ds=[]
    for p,e in fac(c):
        if p==2:
            if e==2:ds.append(2)
            elif e>=3:ds.extend((2,2**(e-2)))
        else:ds.append((p-1)*p**(e-1))
    axes.update(ds);families.append((c,ds))
    for d in ds:mixed(d)
active=set()
def visit(n):
    if n in active:return
    active.add(n)
    if choices[n][0]=='split':
        _,r,m=choices[n];visit(r);visit(m)
for n in axes:visit(n)
data={str(n):dict(choice=choices[n],count=dict(zip(KEYS,mixed(n)))) for n in sorted(active)}
ph=hashlib.sha256(json.dumps(data,sort_keys=True,separators=(',',':')).encode()).hexdigest()
assert ph==old['canonical_plan_sha256']

# Return (normalized intrinsic error coefficient C, safety denominator D).
# If 0<u<=1/D then error<=u*C*(input_sup+1).
def rbound(n):
    if n==1:return (0,1)
    k=n.bit_length()-1
    return (2*k+4,max(1,2*k))
def bbound(n):
    P=plen(n);k=P.bit_length()-1;R=2*k+4;A=1+3*R
    Q=3*n*P*A+1
    return (6*P*A+2*R*(2*n+1)+8,max(1,2*k,P*A,Q))
def obound(n):return rbound(n) if pow2(n) else bbound(n)
@lru_cache(None)
def mbound(n):
    t=choices[n]
    if t[0]=='radix2':return rbound(n)
    if t[0]=='direct_prime':return (2,1)
    if t[0]=='bluestein':return bbound(n)
    _,r,m=t;cr,dr=mbound(r);cm,dm=mbound(m)
    return (cm+cr+2,max(dr,dm,cm+cr*(2*cm+1)))
rows=[]
for n in sorted(axes):
    oc,od=obound(n);nc,nd=mbound(n)
    rows.append(dict(n=n,old_C=oc,new_C=nc,old_D=od,new_D=nd))
badC=[r for r in rows if r['new_C']>r['old_C']]
badD=[r for r in rows if r['new_D']>r['old_D']]
def bits(d):return max(0,(d-1).bit_length())
maxold=max(r['old_D'] for r in rows);maxnew=max(r['new_D'] for r in rows)
badbits=[r for r in rows if bits(r['new_D'])>bits(r['old_D'])]
assert not badC and not badbits
examples={}
maxsum=[0,0]
for c,ds in families:
    a=sum(obound(d)[0] for d in ds);b=sum(mbound(d)[0] for d in ds)
    assert b<=a
    maxsum=[max(maxsum[0],a),max(maxsum[1],b)]
    if c in (10007,100003,150000,262144,300000):examples[str(c)]=dict(axes=ds,old_sum_C=a,new_sum_C=b)
out=dict(status='PASS_INTEGER_ERROR_COEFFICIENT_COMPARISON',scope='Same schedule; conservative bounds only; no roots, transforms, signs, or runtime.',
         source_receipt_sha256=hashlib.sha256(OLD.read_bytes()).hexdigest(),plan_sha256=ph,
         conductor_count=len(families),axis_length_count=len(axes),active_plan_count=len(active),
         coefficient_exceptions=badC,safety_exceptions=badD,safety_dyadic_bit_exceptions=badbits,
         max_old_D=maxold,max_new_D=maxnew,old_safety_bits=bits(maxold),new_safety_bits=bits(maxnew),
         max_old_sum_C=maxsum[0],max_new_sum_C=maxsum[1],examples=examples,axis_rows=rows)
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps({k:v for k,v in out.items() if k!='axis_rows'},indent=2))
