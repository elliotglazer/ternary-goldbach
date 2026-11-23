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


# Independent file; preceding integer circuit definitions are copied unchanged
# from the pinned R150000 inventory, not imported (its top-level writes).
HERE=Path(__file__).parent
OLD=HERE/'mixed_radix_character_inventory_20261111.json'
assert hashlib.sha256(OLD.read_bytes()).hexdigest().upper()=='2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F'
old=json.loads(OLD.read_text())
def eligible(c,R):
    return (c%2==1 and c<=R) or (c%4==0 and c<=2*R)
def real_primitive(c):
    value=1
    for p,e in factors(c):
        if p==2:value*=1 if e==2 else 2 if e==3 else 0
        else:value*=int(e==1)
    return value
def empty():
    return dict(conductors=0,primitive_labels=0,real_primitive_labels=0,
                nonreal_inverse_pairs=0,unit_coefficients=0,
                nominal_conductor_height_nodes=0,coarse_residue_inputs=0,
                coarse_primitive_outputs=0,max_height_nodes=0,
                operations=obj(zero()))
def accumulate(out,c):
    v,n,ds,_,cnt=cdata(c);J=samples(c);real=real_primitive(c)
    assert (n-real)%2==0
    out['conductors']+=1;out['primitive_labels']+=n
    out['real_primitive_labels']+=real;out['nonreal_inverse_pairs']+=(n-real)//2
    out['unit_coefficients']+=v;out['nominal_conductor_height_nodes']+=J
    out['coarse_residue_inputs']+=v*J;out['coarse_primitive_outputs']+=n*J
    out['max_height_nodes']=max(out['max_height_nodes'],J)
    for k,x in zip(KEYS,cnt):out['operations'][k]+=J*x
    return ds
def setup(axes):
    active=set();bs=set()
    def visit(n):
        if n in active:return
        active.add(n)
        if choices[n][0]=='split':
            _,r,m=choices[n];visit(r);visit(m)
        elif choices[n][0]=='bluestein':bs.add(n)
    for n in axes:visit(n)
    kernel_fft=zero()
    for n in bs:kernel_fft=add(kernel_fft,radix2(blue_length(n)))
    plan={str(n):dict(choice=choices[n],count=obj(mixed(n))) for n in sorted(active)}
    return dict(axis_lengths=len(axes),active_nodes=len(active),
                active_choice_counts={t:sum(choices[n][0]==t for n in active)
                                      for t in ('radix2','direct_prime','split','bluestein')},
                kernel_count=len(bs),kernel_entries=sum(blue_length(n) for n in bs),
                chirp_entries=sum(bs),max_padded_length=max(map(blue_length,bs),default=0),
                kernel_forward_operations=obj(kernel_fft),
                CT_full_root_table_entry_upper=sum(n for n in active if choices[n][0]=='split'),
                direct_prime_root_entries=sum(n for n in active if choices[n][0]=='direct_prime'),
                plan_sha256=hashlib.sha256(json.dumps(plan,sort_keys=True,separators=(',',':')).encode()).hexdigest())
profiles={}
for R in (150000,140000):
    allc=empty();large=empty();small=empty();axes=set();allaxes=set()
    for c in range(3,2*R+1):
        if not eligible(c,R):continue
        ds=accumulate(allc,c);allaxes.update(ds)
        if c>10000:
            accumulate(large,c);axes.update(ds)
        else:accumulate(small,c)
    profiles[str(R)]=dict(all_conductors=allc,large_above10000=large,
                         small_at_most10000=small,large_setup=setup(axes),
                         all_conductor_setup_diagnostic=setup(allaxes))
base=profiles['150000'];new=profiles['140000']
assert base['large_above10000']['operations']==old['large_reduced']['mixed']
assert base['all_conductors']['operations']==old['all_reduced']['mixed']
assert base['all_conductor_setup_diagnostic']['plan_sha256']==old['canonical_plan_sha256']
assert new['small_at_most10000']==base['small_at_most10000']
for label in ('all_conductors','large_above10000'):
    for k in ('conductors','primitive_labels','coarse_residue_inputs','coarse_primitive_outputs'):
        oldk='coarse_primitive_outputs' if k=='coarse_primitive_outputs' else k
        assert base[label][k]==old['all_reduced' if label=='all_conductors' else 'large_reduced'][oldk]
def ratio(a,b):
    return dict(exact=str(Fraction(a,b)),lower=str(Fraction(a*10**6//b,10**6)),
                upper=str(Fraction((a*10**6+b-1)//b,10**6))) if b else None
def compare(a,b):
    out={}
    for k in a:
        if isinstance(a[k],dict):
            if k=='operations':out[k]=compare(a[k],b[k])
        elif isinstance(a[k],int):
            out[k]=dict(old=a[k],new=b[k],removed=a[k]-b[k],ratio=ratio(b[k],a[k]))
    return out
comparisons={k:compare(base[k],new[k]) for k in ('all_conductors','large_above10000','large_setup')}
out=dict(status='PASS_CONDITIONAL_R140000_INTEGER_INVENTORY',
         candidate_status='Mathematical adoption not asserted; R140000 is a pending candidate.',
         domain='Odd 3<=c<=R; 4 divides c<=2R; conductor1 excluded.',
         heights='100000000/c for odd or c<=125000, else200+75000000/c; unchanged.',
         nominal_grid='J=ceil(64H/5)+1; coarse nonnegative grid only, no auxiliary/guard nodes.',
         circuit='Pinned mixed-radix rule; all unit-group outputs, no primitive pruning.',
         source_receipt_sha256=hashlib.sha256(OLD.read_bytes()).hexdigest(),
         profiles=profiles,comparisons=comparisons,
         shared_seed_scope='Same maximum coarse height index; unchanged fixed P24 alpha seed schedule if reused verbatim.',
         exclusions='No theta/time work priced below10000; no roots, L-values, signs, Turing evidence, runtime or total proof-cost ratio.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(dict(status=out['status'],comparisons=comparisons),indent=2))

