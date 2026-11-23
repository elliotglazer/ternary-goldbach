"""Independent formal finite-difference controls; no actual function values."""
from pathlib import Path
from math import comb
from fractions import Fraction as Q
import hashlib, json, sys
BASE=Path(__file__).resolve().parents[1]
paths=sys.argv[1:4]
assert len(paths)==3
pins={p:hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper() for p in paths}
data=json.loads((BASE/paths[2]).read_text())
checks=0
def ck(v):
    global checks
    assert v
    checks+=1
for row in data['pins']:
    ck(hashlib.sha256((BASE/row['path']).read_bytes()).hexdigest().upper()==row['sha256'])
def add(a,b):
    z=a.copy()
    for k,v in b.items(): z[k]=z.get(k,0)+v
    return {k:v for k,v in z.items() if v}
def mul(a,axis,factor=1):
    out={}
    for k,v in a.items():
        kk=list(k);kk[axis]+=1
        if factor*v:out[tuple(kk)]=factor*v
    return out

# Direct alternating-binomial finite differences, independent of Stirling
# recurrence. All source coefficient numerators and q,F,v remain indeterminate.
mu={(h,j):sum((-1)**(j-z)*comb(j,z)*z**h for z in range(j+1))
    for h in range(20) for j in range(20)}
def expected(i,j):
    out={}
    for ell in range(i+1):
        for h in range(ell+1):
            a=comb(ell,h)*mu[h,j]
            if a:out[(19-i+ell,ell-h,h,i-ell)]=a
    return out
formal_states=0
for m in range(1,21):
    state=[{(19,0,0,0):1}]
    general=small=additions=0
    for i in range(1,20):
        old=state
        state=[{} for _ in range(min(i+1,m))]
        state[0]=add(mul(old[0],1),{(19-i,0,0,i):1})
        general+=1;additions+=1
        for j in range(1,len(state)):
            if j==i:
                state[j]=mul(old[j-1],2,j);small+=1
            else:
                state[j]=add(add(mul(old[j],1),mul(old[j],2,j)),mul(old[j-1],2,j))
                general+=1;small+=1;additions+=1
        for j,s in enumerate(state):
            ck(s==expected(i,j));formal_states+=1
    row=data['initialization'][m-1]
    expected_row=dict(m=m,general_products=general,recurrence_additions=additions,
        small_scales=small,binary_additions=sum((20-j)*(j.bit_count()-1) for j in range(1,m)),
        shifted_operands=sum((20-j)*j.bit_count() for j in range(1,m)),coefficient_prescales=19)
    expected_row['total_initialization_additions']=general+expected_row['binary_additions']
    ck(row==expected_row)
    ck(general==m*(39-m)//2)

matrix_entries=0
u=Q(1,2**100)
C=2**16
ell=(531600**19).bit_length()
ck(Q(4,3)*C+u/4<2**17)
ck(Q(4,3)+Q(1,4)+1<Q(8,3))
ck(633*Q(31,12)==Q(6541,4))
for L in range(1,261):
    m=min(20,L)
    state=[[int(j==k) for k in range(m)] for j in range(m)]
    S=sum(comb(L-1,k) for k in range(m))
    p=102+S.bit_length()
    count=0
    for n in range(L):
        live=min(19,L-1-n)
        ck(len(state)==live+1)
        for j,row in enumerate(state):
            want=[comb(n,k-j) if 0<=k-j<=n else 0 for k in range(m)]
            ck(row==want);matrix_entries+=m
            ck(sum(row)<=S)
            ck(n+j<=L-1)
        if n+1<L:
            next_live=min(19,L-2-n)
            # New-list update independently checks the author's ascending
            # in-place schedule, which must read every old upper state.
            state=[[a+b for a,b in zip(state[j],state[j+1])]
                   if j<19 else state[j].copy() for j in range(next_live+1)]
            count+=min(19,L-1-n)
    ck(Q(S,2**p)<u/4)
    ck(count==(L*(L-1)//2 if L<=20 else 19*L-190))
    row=dict(L=L,m=m,S=str(S),p=p,advances=count,
        exact_live_signed=100+ell+m+17,
        exact_raw_add_signed=None if L==1 else 100+ell+m+18,
        rounded_live_signed=p+m+17,
        rounded_raw_add_signed=None if L==1 else p+m+18,
        initial_shift_or_product_signed=p+ell+m+17,
        initial_residual_signed=p+ell+m+18,
        initial_comparison_signed=p+ell+m+19,
        final_dyadic_scratch_signed=p+20)
    ck(row==data['lengths'][L-1])
    for j in range(m):
        ck(Q(4,3)*C*2**j+u/4<2**(17+j))
        ck(Q(1,4)*Q(4,3)+Q(1,2)*Q(4,3)/2==Q(2,3))
        ck(Q(1,2)*Q(4,3)/2==Q(1,3))
        ck(Q(1,4)*Q(4,3)+1==Q(4,3))

result={'scope':'formal polynomial/matrix identities and exact scalar widths only',
        'checks':checks,'pins':pins,'dependency_pins':data['pins'],
        'formal_state_comparisons':formal_states,'matrix_entries_compared':matrix_entries,
        'all_lengths_checked':[1,260],'max_p':197,'max_live_bits':234,
        'max_raw_add_bits':235,'max_initial_comparison_bits':598}
out=Path(__file__).with_suffix('.json')
with out.open('x',encoding='utf8',newline='\n') as f:
    json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'formal_states':formal_states,'matrix_entries':matrix_entries,
                 'receipt_sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper()}))
