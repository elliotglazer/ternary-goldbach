"""Finite rational/structural examples only, not a transform or conductor inventory."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json

HERE=Path(__file__).resolve().parent
AG=HERE.parent
checks=0
pins={}
def ck(p):
    global checks
    assert p
    checks+=1
for rel,h in {
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md':'5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A',
 'zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md':'087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D',
 'integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C',
 'independent-feasibility/REVIEW_LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md':'1A0DE2B920A63B27D7E0AB8E6C0DF38F9DCD56872C290C9333783D99A461004E',
}.items():
    ck(hashlib.sha256((AG/rel).read_bytes()).hexdigest().upper()==h)
    pins[rel]=h

def ceil_log2(x):
    x=F(x);v=0
    while F(2)**v<x:v+=1
    ck(F(2)**v>=x and (v==0 or F(2)**(v-1)<x))
    return v
def mul(a,b):
    a=(a+7)//8;b=(b+7)//8
    return 5*a*b+2*min(a,b)+1
def add(a):return 2*((a+7)//8)+1
def complex_three(a,b):
    r=a+b+2
    return dict(product=mul(a+1,b)+2*mul(a,b+1),
                addition=add(a+1)+2*add(r)+4*add(r+2),raw_magnitude_bits=r)
def radix_price(P,p,b,Z):
    stages=[];products=adds=gates=0;k=P.bit_length()-1
    for j in range(k):
        # A common stage allocation covers inputs, root products and outputs.
        a=p+b+ceil_log2(2**(j+2)*Z)
        count=P//2-(1+int(j>=1))*P//2**(j+1)
        ck(count>=0)
        gate=complex_three(a,p+1)
        pr=count*gate['product']
        ad=count*gate['addition']+P*2*add(a+1)
        products+=pr;adds+=ad;gates+=count
        stages.append(dict(stage=j+1,data_magnitude_bits=a,general_products=count,
                           complex_adds=P,product_core=pr,addition_core=ad))
    ck(gates==P*k//2-3*P//2+2)
    return dict(product_core=products,addition_core=adds,stages=stages)

# Small explicit structural choices, not purported active leaf occurrences.
samples=sorted(set(list(range(2,18))+[33,127,257,1025,4097,16385,65537]))
inequalities=[]
for n in samples:
    P=1<<(2*n-2).bit_length();k=P.bit_length()-1
    R=2*k+4;A=1+3*R;m=2*n-1
    Q=3*n*P*A+1;q=3*n*A+n+2
    Z=F(n*m,P)+2
    old=6*P*A+2*R*(2*n+1)+8
    new=9*P*A//2+3*P//2+3*R*n+12*R+14
    exact=F(3,2)*F(P*q+R*(n*m+2*P),n)+F(n+1,n)
    ck(2*n<=P<4*n and P>=4)
    ck(P*(A+1)<Q and q<=Q and Q>2)
    ck(exact<=new<old)
    ck(old-new==R*(9*P//2+n-10)-6>=74)
    # Point, inverse and unchanged setup peaks; postchirp uses old semantic gate.
    ck(Z>F(5,2))
    ck(2*P*Z>5*P and 2*P*Z>2*n)
    ck(2*P*Z==2*n*m+4*P)
    ck(2*P*Z<4*P*(n*n+n+1))
    inequalities.append(dict(n=n,P=P,k=k,old_C=old,new_C=new,
                             new_unrelaxed_C=str(exact),new_peak=2*n*m+4*P))

examples=[]
for n in [13,257,4097,65537]:
    P=1<<(2*n-2).bit_length();k=P.bit_length()-1;m=2*n-1
    Zo=2*n*(n+1)+2;Zn=F(n*m,P)+2
    for p in [112,134,152]:
        b=14
        aF=p+b+ceil_log2(n+2)
        bK=p+ceil_log2(2*n)
        oldpoint=complex_three(aF,bK);newpoint=complex_three(aF,p)
        oldinv=radix_price(P,p,b,Zo);newinv=radix_price(P,p,b,Zn)
        last=p+b+ceil_log2(2*P*Zo)
        final_division_add=P*4*add(last+2)
        oldpc=P*oldpoint['product']+oldinv['product_core']
        newpc=P*newpoint['product']+newinv['product_core']
        oldac=P*oldpoint['addition']+oldinv['addition_core']+final_division_add
        newac=P*newpoint['addition']+newinv['addition_core']
        scale_setup_add=P*4*add(bK+2)
        cache_delta=P*2*(add(p+1)-add(bK+1))
        ck(oldpc>=newpc and oldac>=newac)
        ck(oldpc-newpc+oldac-newac>scale_setup_add+cache_delta)
        # Exact p+k rescaling leaves integer operand capacities unchanged.
        for j in range(k):
            ck(p+k+b+ceil_log2(F(2**(j+2)*Zo,P))==p+b+ceil_log2(2**(j+2)*Zo))
        examples.append(dict(n=n,P=P,p=p,incoming_augmented_bits=b,
            old_point=oldpoint,new_point=newpoint,old_inverse=oldinv,new_inverse=newinv,
            runtime_product_core_saved=oldpc-newpc,runtime_add_core_saved=oldac-newac,
            new_scale_setup_add_core=scale_setup_add,cold_cache_sum_add_delta=cache_delta,
            all_other_prices='Explicit unknowns. These cores do not imply runtime or proof-size dominance.'))

# Exact power-of-two rescaling commutes with the specified integer nearest rule.
# This is a formal denominator identity, tested on signed integer tie cases only.
def round_grid(x,p):
    shifted=x*2**p+F(1,2)
    nearest=shifted.numerator//shifted.denominator
    return F(nearest,2**p)
for d in range(1,9):
    for shift in range(1,5):
        for N in [-2**(d+1),-2**(d-1),-1,0,1,2**(d-1),2**(d+1)]:
            q=(N+2**(d-1))//2**d
            ck(-2**d<=2*(N-q*2**d)<2**d)
            x=F(N,2**(2*d))
            ck(round_grid(x/F(2**shift),d+shift)==round_grid(x,d)/2**shift)

out=dict(scope='Paper scalar and typed local-template examples only; no new leaf/conductor inventory or values.',
    checks=checks,pins=pins,inequalities=inequalities,examples=examples,
    status='PENDING_INDEPENDENT_REVIEW',selected_precision=False,actual_runtime_saving=False)
dest=HERE/'bluestein_cached_normalization_20261111_v2.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),
    'examples':[{k:r[k] for k in ['n','P','p','runtime_product_core_saved','runtime_add_core_saved','new_scale_setup_add_core','cold_cache_sum_add_delta']} for r in examples if r['p']==134]},indent=2))
