"""Independent integer counts and finite index checks; no transforms or values."""
from pathlib import Path
from functools import cache
from fractions import Fraction
from math import prod
import json,hashlib
HERE=Path(__file__).resolve().parent;A=HERE.parent
file=A/'zero-sum/primitive_output_pruning_inventory_20261111.json'
assert hashlib.sha256(file.read_bytes()).hexdigest().upper()=='407DB4730F9A31811D4B95184225C0619630FAD69B22B106CA565B3444C5E0DA'
saved=json.loads(file.read_text(encoding='utf-8'))
limit=276000;spf=[0]*(limit+1);primes=[]
for n in range(2,limit+1):
    if not spf[n]:spf[n]=n;primes.append(n)
    for p in primes:
        if p>spf[n] or p*n>limit:break
        spf[p*n]=p
def factors(n):
    ans=[]
    while n>1:
        p=spf[n];e=0
        while n%p==0:n//=p;e+=1
        ans.append((p,e))
    return ans
def plus(*vs):return tuple(sum(x) for x in zip(*vs))
def times(n,v):return tuple(n*x for x in v)
def is2(n):return n>0 and n&(n-1)==0
def pad(n):return 1<<(2*n-2).bit_length()
def rad(n):
    if n==1:return (0,)*5
    k=n.bit_length()-1
    return (n*k//2-3*n//2+2,n*k,n//2-1,0,0)
def keep(n,q):return n if q==0 else n-n//q
@cache
def chirp(n,q):
    step=prod(p**((e+1)//2) for p,e in factors(n//(2 if n%2==0 else 1)))
    special=[0]*4
    for t in range(0,n,step):
        if q and t%q==0:continue
        assert 2*t*t%n==0
        special[2*t*t//n%4]+=1
    return (keep(n,q)-sum(special),0,special[1]+special[3],special[2],0)
@cache
def blue(n,q):return plus(times(2,rad(pad(n))),chirp(n,0),chirp(n,q),(pad(n),0,0,0,pad(n)))
@cache
def cross(r,m,q):
    rot=neg=0
    for a in range(1,r):
        for phase in (1,2,3):
            num=phase*r*m
            if num%(4*a):continue
            b=num//(4*a)
            if not(0<b<m) or q and b%q==0:continue
            if phase==2:neg+=1
            else:rot+=1
    return ((r-1)*(keep(m,q)-(0 if q else 1))-rot-neg,0,rot,neg,0)
@cache
def full(n):
    if is2(n):return 'rad',rad(n)
    r=spf[n]
    if r==n:
        if n<=11:return 'direct',((n-1)**2,n*(n-1),0,0,0)
        return 'blue',blue(n,0)
    m=n//r
    c=plus(times(r,full(m)[1]),times(m,full(r)[1]),cross(r,m,0));b=blue(n,0)
    return ('split',c) if c[0]<=b[0] and c[1]<=b[1] else ('blue',b)
requests=set();index_tests=0
@cache
def prune(n,q):
    global index_tests
    requests.add((n,q));tag,f=full(n)
    if not q:return f
    assert q>=2 and n%q==0
    if n<=256:
        ix={i for i in range(n) if i%q}
        assert len(ix)==keep(n,q) and {(-i)%n for i in ix}==ix
        index_tests+=1
    if tag=='blue':ans=blue(n,q)
    elif tag=='direct':
        assert q==n
        ans=((n-1)**2,(n-1)**2,0,0,0)
    elif n==2:
        assert q==2
        ans=(0,1,0,0,0)
    else:
        r=2 if tag=='rad' else spf[n];m=n//r
        if q==n:
            ans=plus(times(r,full(m)[1]),cross(r,m,0),times(m-1,full(r)[1]),prune(r,r))
        else:
            assert m%q==0
            ans=plus(times(r,prune(m,q)),cross(r,m,q),times(keep(m,q),full(r)[1]))
        if n<=256:
            for v in range(m):
                actual={u for u in range(r) if (v+m*u)%q}
                expected=({*range(r)}-{0}) if q==n and v==0 else ({*range(r)} if q==n or v%q else set())
                assert actual==expected
            index_tests+=1
    assert all(x<=y for x,y in zip(ans,f))
    return ans
keys=('general_complex_products','complex_add_sub','quarter_turns','negations','dyadic_scales')
def obj(v):return dict(zip(keys,v))
def blank():return dict(conductors=0,primitive_labels=0,coarse_residue_inputs=0,full=obj((0,)*5),same_order=obj((0,)*5),G_order=obj((0,)*5),between_axes_only=obj((0,)*5))
def ordering(axis):
    n,q=axis;delta=n-keep(n,q);c=prune(n,q)
    return (0,Fraction(c[0],delta),Fraction(c[1],delta),n,q) if delta else (1,Fraction(0),Fraction(0),n,q)
def tensor(axes,unpruned=False):
    before=1;remaining=prod(n for n,q in axes);cost=(0,)*5
    for n,q in axes:
        remaining//=n
        cost=plus(cost,times(before*remaining,full(n)[1] if unpruned else prune(n,q)))
        before*=keep(n,q)
    return cost,before
rows={name:blank() for name in ['all','large','small']};examples={};top=set()
for c in range(3,limit+1):
    if not(c%4==0 or c%2 and c<=138000):continue
    fs=factors(c);axes=[]
    phi=prod((p-1)*p**(e-1) for p,e in fs)
    primitive=prod(p-2 if e==1 else (p-1)**2*p**(e-2) for p,e in fs)
    for p,e in fs:
        if p==2:
            assert e>=2
            axes.extend([(2,2)] if e==2 else [(2,0),(2**(e-2),2)])
        else:
            n=(p-1)*p**(e-1);axes.append((n,n if e==1 else p))
    top.update(axes)
    F=plus(*(times(phi//n,full(n)[1]) for n,q in axes))
    S,n1=tensor(axes);ordered=sorted(axes,key=ordering);O,n2=tensor(ordered);B,n3=tensor(ordered,True)
    assert n1==n2==n3==primitive and O[0]<=S[0]
    assert all(a<=b for a,b in zip(S,F)) and all(a<=b for a,b in zip(O,F))
    assert all(a<=b for a,b in zip(O,B))
    height_numerator=100000000 if c%2 or c<=125000 else 200*c+75000000
    J=(64*height_numerator+5*c-1)//(5*c)+1
    for name in ['all','large' if c>10000 else 'small']:
        row=rows[name];row['conductors']+=1;row['primitive_labels']+=primitive;row['coarse_residue_inputs']+=phi*J
        for label,cost in [('full',F),('same_order',S),('G_order',O),('between_axes_only',B)]:
            for key,val in zip(keys,cost):row[label][key]+=J*val
    if str(c) in saved['examples']:examples[str(c)]=dict(axes=[list(t) for t in axes],ordered_axes=[list(t) for t in ordered],phi=phi,primitive=primitive,full=obj(F),same_order=obj(S),G_order=obj(O))
assert rows==saved['rows'] and examples==saved['examples']
assert len(top)==saved['top_axis_restriction_count'] and len(requests)==saved['all_recursive_request_count']
out=dict(status='PASS_INDEPENDENT_PRIMITIVE_OUTPUT_METADATA',author_receipt_sha256=hashlib.sha256(file.read_bytes()).hexdigest().upper(),rows=rows,examples=examples,recursive_requests=len(requests),top_axis_restrictions=len(top),small_index_tests=index_tests,scope='Exact counts and finite index sets only; no root, transform, or character evaluation.')
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print('PASS',len(requests),len(top),index_tests)
print('SHA256',hashlib.sha256(dest.read_bytes()).hexdigest().upper())
