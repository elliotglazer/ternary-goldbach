"""Integer-only schedule counts. No FFT, character, L-value or zero evaluation."""
from functools import lru_cache
from pathlib import Path
from fractions import Fraction
import hashlib,json

LIMIT=300000
spf=list(range(LIMIT+1))
for p in range(2,LIMIT+1):
    if spf[p]==p:
        for n in range(p*p,LIMIT+1,p):
            if spf[n]==n:spf[n]=p

def factors(n):
    ans=[]
    while n>1:
        p=spf[n];e=0
        while n%p==0:n//=p;e+=1
        ans.append((p,e))
    return ans

KEYS=('general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales')
def zero():return (0,)*len(KEYS)
def add(*xs):return tuple(sum(v) for v in zip(*xs))
def mul(k,x):return tuple(k*a for a in x)
def obj(x):return dict(zip(KEYS,x))
def power2(n):return n>0 and n&(n-1)==0

def radix2(n):
    if n==1:return zero()
    k=n.bit_length()-1
    return (n*k//2-3*n//2+2,n*k,n//2-1,0,0)

@lru_cache(None)
def chirps(n):
    # Fourth roots iff n divides 2*j^2. All such j are multiples of d.
    d=1
    for p,e in factors(n//(2 if n%2==0 else 1)):
        d*=p**((e+1)//2)
    assert n%d==0
    cheap=[0,0,0,0]
    for j in range(0,n,d):
        assert (2*j*j)%n==0
        cheap[((2*j*j)//n)%4]+=1
    return n-sum(cheap),cheap[1]+cheap[3],cheap[2],cheap[0]

def blue_length(n):return 1<<(2*n-2).bit_length()
@lru_cache(None)
def blue(n):
    P=blue_length(n);g,rot,neg,ident=chirps(n)
    return add(mul(2,radix2(P)),(P+2*g,0,2*rot,2*neg,P))

@lru_cache(None)
def baseline(n):return radix2(n) if power2(n) else blue(n)

@lru_cache(None)
def bridge(r,m):
    n=r*m;rot=neg=0
    for h in (1,2,3):
        if h*n%4:continue
        target=h*n//4
        for j in range(1,r):
            if target%j==0 and 1<=target//j<m:
                if h==2:neg+=1
                else:rot+=1
    return ((r-1)*(m-1)-rot-neg,0,rot,neg,0)

choices={}
@lru_cache(None)
def mixed(n):
    b=baseline(n)
    if power2(n):choices[n]=('radix2',);return b
    r=spf[n]
    if r==n:
        if n<=11:
            candidate=((n-1)**2,n*(n-1),0,0,0)
            assert candidate[0]<=b[0] and candidate[1]<=b[1]
            choices[n]=('direct_prime',);return candidate
        choices[n]=('bluestein',);return b
    m=n//r
    candidate=add(mul(r,mixed(m)),mul(m,mixed(r)),bridge(r,m))
    # Concrete componentwise-safe selection, not global optimization.
    if candidate[0]<=b[0] and candidate[1]<=b[1]:
        choices[n]=('split',r,m);return candidate
    choices[n]=('bluestein',);return b

def cdata(c):
    v=n=1;dims=[]
    for p,e in factors(c):
        v*=(p-1)*p**(e-1)
        n*=p-2 if e==1 else (p-1)**2*p**(e-2)
        if p==2:
            if e==2:dims.append(2)
            elif e>=3:dims.extend((2,2**(e-2)))
        else:dims.append((p-1)*p**(e-1))
    assert n>0
    old=new=zero()
    for d in dims:
        old=add(old,mul(v//d,baseline(d)))
        new=add(new,mul(v//d,mixed(d)))
    return v,n,dims,old,new

def samples(c):
    a=100000000 if c%2 or c<=125000 else 200*c+75000000
    return (64*a+5*c-1)//(5*c)+1


# New output-pruning inventory. The prefix is copied from the frozen full circuit.
HERE=Path(__file__).parent
SOURCE=HERE/'conditional_r138000_mixed_inventory_20261111.json'
assert hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper()=='0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F'
source=json.loads(SOURCE.read_text())
@lru_cache(None)
def kept_chirps(n,q):
    d=1
    for p,e in factors(n//(2 if n%2==0 else 1)):d*=p**((e+1)//2)
    cheap=[0]*4
    for j in range(0,n,d):
        if j%q:cheap[(2*j*j//n)%4]+=1
    return n-n//q-sum(cheap),cheap[1]+cheap[3],cheap[2]
@lru_cache(None)
def kept_bridge(r,m,q):
    n=r*m;rot=neg=0
    assert m%q==0
    for h in (1,2,3):
        if h*n%4:continue
        target=h*n//4
        for a in range(1,r):
            if target%a==0:
                v=target//a
                if 1<=v<m and v%q:
                    if h==2:neg+=1
                    else:rot+=1
    return ((r-1)*(m-m//q)-rot-neg,0,rot,neg,0)
requests=set()
@lru_cache(None)
def pruned(n,q):
    # q=0 means full; otherwise retain k with k%q !=0, q divides n.
    requests.add((n,q))
    f=mixed(n)
    if q==0:return f
    assert q>=2 and n%q==0
    typ=choices[n][0]
    if typ=='bluestein':
        P=blue_length(n);g,Q,z,_=chirps(n);g1,Q1,z1=kept_chirps(n,q)
        ans=add(mul(2,radix2(P)),(P+g+g1,0,Q+Q1,z+z1,P))
    elif typ=='direct_prime':
        assert q==n
        ans=((n-1)**2,(n-1)**2,0,0,0)
    elif n==2:
        assert q==2
        ans=(0,1,0,0,0)
    else:
        if typ=='radix2':r,m=2,n//2
        else:_,r,m=choices[n]
        if q==n:
            ans=add(mul(r,mixed(m)),bridge(r,m),mul(m-1,mixed(r)),pruned(r,r))
        else:
            assert m%q==0
            ans=add(mul(r,pruned(m,q)),kept_bridge(r,m,q),mul(m-m//q,mixed(r)))
    assert all(a<=b for a,b in zip(ans,f)),(n,q,ans,f)
    return ans
def axis_data(c):
    ans=[]
    for p,e in factors(c):
        if p==2:
            if e==2:ans.append((2,2))
            else:ans.extend(((2,0),(2**(e-2),2)))
        else:
            n=(p-1)*p**(e-1)
            ans.append((n,n if e==1 else p))
    return ans
def retained(n,q):return n if q==0 else n-n//q
def order_key(axis):
    n,q=axis;out=retained(n,q);cost=pruned(n,q);d=n-out
    return (1,Fraction(0),Fraction(0),n,q) if d==0 else (0,Fraction(cost[0],d),Fraction(cost[1],d),n,q)
def tensor_cost(axes,between_only=False):
    suffix=1
    for n,q in axes:suffix*=n
    before=1;total=zero()
    for n,q in axes:
        suffix//=n
        total=add(total,mul(before*suffix,mixed(n) if between_only else pruned(n,q)))
        before*=retained(n,q)
    return total,before
def empty():
    return dict(conductors=0,primitive_labels=0,coarse_residue_inputs=0,
                full=obj(zero()),same_order=obj(zero()),G_order=obj(zero()),between_axes_only=obj(zero()))
def addrow(row,c,v,n,J,full,same,ordered,between):
    row['conductors']+=1;row['primitive_labels']+=n;row['coarse_residue_inputs']+=v*J
    for label,cost in (('full',full),('same_order',same),('G_order',ordered),('between_axes_only',between)):
        for k,x in zip(KEYS,cost):row[label][k]+=J*x
rows={'all':empty(),'large':empty(),'small':empty()};examples={};top_axes=set()
for c in range(3,276001):
    if not ((c%2 and c<=138000) or c%4==0):continue
    v,n,_,_,full=cdata(c);J=samples(c);axes=axis_data(c);top_axes.update(axes)
    same,n1=tensor_cost(axes);order=sorted(axes,key=order_key);ordered,n2=tensor_cost(order)
    between,n3=tensor_cost(order,True)
    assert n==n1==n2 and all(a<=b for a,b in zip(same,full)) and all(a<=b for a,b in zip(ordered,full))
    assert ordered[0]<=same[0]
    assert n3==n and all(a<=b for a,b in zip(ordered,between))
    for which in ('all','large' if c>10000 else 'small'):addrow(rows[which],c,v,n,J,full,same,ordered,between)
    if c in (5,8,27,40,120,10007,100003,131072,138000,262144,276000):
        examples[str(c)]=dict(axes=axes,ordered_axes=order,phi=v,primitive=n,
                              full=obj(full),same_order=obj(same),G_order=obj(ordered))
assert rows['large']['full']==source['profiles']['138000']['large_above10000']['operations']
assert rows['all']['full']==source['profiles']['138000']['all_conductors']['operations']
assert rows['all']['primitive_labels']==4692136729
# Exact finite-index checks, not numerical roots or transforms.
checks=0
for n,q in sorted(requests):
    if n>128 or q==0:continue
    S={k for k in range(n) if k%q}
    assert len(S)==retained(n,q) and {(-k)%n for k in S}==S;checks+=1
    if n>2 and choices[n][0] not in ('direct_prime','bluestein'):
        r,m=(2,n//2) if choices[n][0]=='radix2' else choices[n][1:]
        V={k%m for k in S}
        if q==n:
            assert V==set(range(m))
            assert all({k//m for k in S if k%m==v}==set(range(r))-{0} if v==0
                       else {k//m for k in S if k%m==v}==set(range(r)) for v in V)
        else:
            assert V=={v for v in range(m) if v%q}
            assert all({k//m for k in S if k%m==v}==set(range(r)) for v in V)
        checks+=1
def ratio(a,b):
    return [str(Fraction(a*10**6//b,10**6)),str(Fraction((a*10**6+b-1)//b,10**6))] if b else None
out=dict(status='PASS_CONDITIONAL_PRIMITIVE_OUTPUT_PRUNING_INVENTORY',
         scope='R138000 same inputs, heights and grid. Conservative Blue leaves keep full padded inverse FFT.',
         source_receipt_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
         rows=rows,examples=examples,small_index_checks=checks,top_axis_restriction_count=len(top_axes),
         all_recursive_request_count=len(requests),
         large_ratios={label:{k:ratio(rows['large'][label][k],rows['large']['full'][k]) for k in KEYS}
                       for label in ('same_order','G_order','between_axes_only')},
         setup='Retain full-circuit root/kernel setup; no setup saving claimed.',
         order_rule='Increasing G/(input_count-output_count), then A/deficit; zero deficit last.',
         exclusions='No input pruning, inverse-channel deletion, values, signs, precision experiment or runtime forecast.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(dict(status=out['status'],large=rows['large'],ratios=out['large_ratios'],examples=examples,checks=checks),indent=2))

