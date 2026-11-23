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

ranges=((3,10000),(10001,50000),(50001,100000),(100001,150000),(150001,300000))
rows=[];axes=set();examples={}
for low,high in ranges:
    old=new=zero();nc=labels=inputs=outputs=0
    for c in range(low,high+1):
        if not ((c%2 and c<=150000) or c%4==0):continue
        v,n,dims,a,b=cdata(c);j=samples(c)
        axes.update(dims);nc+=1;labels+=n;inputs+=j*v;outputs+=j*n
        old=add(old,mul(j,a));new=add(new,mul(j,b))
        if c in (5,8,10007,65536,100003,131072,150000,262144,300000):
            examples[c]=dict(v=v,n=n,axes=dims,old=obj(a),mixed=obj(b))
    rows.append(dict(range=[low,high],conductors=nc,primitive_labels=labels,coarse_residue_inputs=inputs,
                     coarse_primitive_outputs=outputs,baseline=obj(old),mixed=obj(new)))

def aggregate(rs):
    old=tuple(sum(r['baseline'][k] for r in rs) for k in KEYS)
    new=tuple(sum(r['mixed'][k] for r in rs) for k in KEYS)
    ratios={k:str(Fraction(new[i],old[i])) if old[i] else None for i,k in enumerate(KEYS)}
    ratio_boxes={k:[str(Fraction(new[i]*10**6//old[i],10**6)),str(Fraction((new[i]*10**6+old[i]-1)//old[i],10**6))] if old[i] else None for i,k in enumerate(KEYS)}
    return dict(baseline=obj(old),mixed=obj(new),mixed_over_baseline=ratios,
                mixed_over_baseline_enclosures=ratio_boxes,
                conductors=sum(r['conductors'] for r in rs),primitive_labels=sum(r['primitive_labels'] for r in rs),
                coarse_residue_inputs=sum(r['coarse_residue_inputs'] for r in rs),
                coarse_primitive_outputs=sum(r['coarse_primitive_outputs'] for r in rs))

alltot=aggregate(rows);large=aggregate(rows[1:])
assert alltot['conductors']==149999 and alltot['primitive_labels']==5543640187
assert large['coarse_primitive_outputs']==75730502011007
assert large['coarse_residue_inputs']==114223068442718
assert alltot['coarse_primitive_outputs']==80459602925766

oldblue={d for d in axes if not power2(d)};newblue=set();active=set()
def visit(n):
    if n in active:return
    active.add(n)
    if choices[n][0]=='split':
        _,r,m=choices[n];visit(r);visit(m)
    elif choices[n][0]=='bluestein':newblue.add(n)
for d in axes:visit(d)
def setup(bs):
    return dict(kernel_count=len(bs),kernel_forward_fft=obj(add(zero(),*(radix2(blue_length(n)) for n in bs))),
                chirp_entries=sum(bs),kernel_entries=sum(blue_length(n) for n in bs),
                max_padded_length=max((blue_length(n) for n in bs),default=0))

# Small exact structural checks only: no roots of unity are evaluated.
checks=0
for r in range(2,12):
    for m in range(2,12):
        n=r*m;g=rot=neg=0
        for a in range(1,r):
            for b in range(1,m):
                if 4*a*b%n:g+=1
                elif (4*a*b//n)%4==2:neg+=1
                else:rot+=1
        assert bridge(r,m)==(g,0,rot,neg,0);checks+=1
        for a in range(r):
            for b in range(m):
                for u in range(r):
                    for v in range(m):
                        assert ((a+r*b)*(v+m*u)-(a*v+m*a*u+r*b*v))%n==0
        checks+=1
for n in range(2,100):
    expected=[0,0,0,0]
    for j in range(n):
        if 2*j*j%n==0:expected[(2*j*j//n)%4]+=1
    assert chirps(n)==(n-sum(expected),expected[1]+expected[3],expected[2],expected[0]);checks+=1

plan_data={str(n):dict(choice=choices[n],count=obj(mixed(n))) for n in sorted(active)}
planhash=hashlib.sha256(json.dumps(plan_data,sort_keys=True,separators=(',',':')).encode()).hexdigest()
out=dict(status='PASS_INTEGER_MIXED_RADIX_INVENTORY',scope='Same reduced nonprincipal family and nominal5/64 coarse grid; no FFT values, sign success, runtime or complete precision claim.',
         rules='Power2 radix2; prime<=11 direct; larger primes Bluestein; composite smallest-prime split if products and additions do not increase, else Bluestein.',
         rows=rows,all_reduced=alltot,large_reduced=large,examples=examples,structural_checks=checks,
         active_plan_count=len(active),canonical_plan_sha256=planhash,
         choices_count={typ:sum(choices[n][0]==typ for n in active) for typ in ('radix2','direct_prime','split','bluestein')},
         old_setup=setup(oldblue),mixed_setup=setup(newblue),
         mixed_CT_full_root_table_entry_upper=sum(n for n in active if choices[n][0]=='split'),
         mixed_direct_prime_root_entries=sum(n for n in active if choices[n][0]=='direct_prime'),
         setup_scope='One cached Bluestein kernel per distinct length and precision; root construction, CT roots, root errors, permutations and general arithmetic still charged separately.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(dict(large=large,examples=examples,old_setup=out['old_setup'],mixed_setup=out['mixed_setup'],choices=out['choices_count'],checks=checks),indent=2))
