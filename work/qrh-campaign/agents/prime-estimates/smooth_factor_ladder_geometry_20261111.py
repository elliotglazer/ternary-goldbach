"""Integer lattice and exponent-DAG counts only. No candidate primality tests."""
from itertools import combinations
from math import prod, lcm
from fractions import Fraction
from functools import lru_cache
from pathlib import Path
import json

primes=[2,3,5,7,11,13,17,19,23,29,31]
# Bounded trial division certifies only these eleven fixed small factors.
assert all(p>=2 and all(p%d for d in range(2,p) if d*d<=p) for p in primes)
P=prod(primes); multipliers=[160,162,165,168,175,180]
Fs=[P*m for m in multipliers]; N=10**27
assert Fs[0]==32089678420800 and all(f*f>N for f in Fs)
def ceildiv(a,b): return -((-a)//b)
def count(e,D,f): return (e-1)//f-ceildiv(e-D-1,f)+1
def factor(n):
    out={}
    for p in primes:
        k=0
        while n%p==0: n//=p; k+=1
        if k: out[str(p)]=k
    assert n==1
    return out
subsets=[((-1)**(len(s)+1),lcm(*s)) for j in range(1,7) for s in combinations(Fs,j)]
period=lcm(*Fs)
union_per_period=sum(sign*(period//f) for sign,f in subsets)
rows=[]
def power_cost(e): return (e.bit_length()-1,e.bit_count()-1)
def plus(*pairs): return tuple(sum(v[i] for v in pairs) for i in (0,1))
@lru_cache(None)
def subset_product(mask): return prod(p for j,p in enumerate(primes) if mask>>j&1)
@lru_cache(None)
def complement_tree(mask):
    if mask&(mask-1)==0: return (0,0,None)
    first=mask&-mask; sub=(mask-1)&mask; best=None
    while sub:
        other=mask^sub
        if sub&first and other:
            left=complement_tree(sub); right=complement_tree(other)
            cost=plus(left[:2],right[:2],power_cost(subset_product(sub)),power_cost(subset_product(other)))
            key=(sum(cost),cost[0],sub)
            if best is None or key<best[0]: best=(key,cost,sub,other)
        sub=(sub-1)&mask
    return (*best[1],(best[2],best[3]))
fullmask=(1<<len(primes))-1
tree=complement_tree(fullmask)
def verify_tree(mask,outside=1):
    split=complement_tree(mask)[2]
    if split is None:
        q=subset_product(mask)
        assert outside==P//q
        return
    l,r=split
    assert l&r==0 and l|r==mask
    verify_tree(l,outside*subset_product(r))
    verify_tree(r,outside*subset_product(l))
verify_tree(fullmask)
def tree_records(mask):
    split=complement_tree(mask)[2]
    if split is None: return []
    l,r=split
    return [dict(mask=mask,left=l,right=r,left_exponent=subset_product(r),right_exponent=subset_product(l))]+tree_records(l)+tree_records(r)
for B in [10**15,2*10**15,5*10**15,10**16,2*10**16]:
    S=B//2; D=S-2; K=ceildiv(N,S)
    assert S+D+2==B and S>D>=0
    low=sum((D//f if sign==1 else -ceildiv(D,f)) for sign,f in subsets)
    high=sum((ceildiv(D,f) if sign==1 else -(D//f)) for sign,f in subsets)
    exact=sum(sign*count(N,D,f) for sign,f in subsets)
    assert low<=exact<=high
    rows.append(dict(B=B,S=S,D=D,slots=K,
        per_F_top_counts=[count(N,D,f) for f in Fs],
        per_F_min=[D//f for f in Fs],per_F_max=[ceildiv(D,f) for f in Fs],
        portfolio_union_any_window_min=max(0,low),portfolio_union_any_window_max=high,
        portfolio_union_top=exact,duplicated_top=sum(count(N,D,f) for f in Fs),
        power2_45_top=count(N,D,2**45),power2_45_min=D//2**45,
        power2_45_max=ceildiv(D,2**45)))
frows=[]
for m,f in zip(multipliers,Fs):
    exps=[f]+[f//p for p in primes]
    prefixes={int(bin(e)[2:j],2) for e in exps for j in range(3,len(bin(e))+1)}
    prefixes.discard(1)
    # Alternative binary-power ladder plus separate selected products.
    frows.append(dict(m=m,F=f,factors=factor(f),square_margin=f*f-N,
        max_k=(N-1)//f,k_bit_bound=((N-1)//f).bit_length(),
        fixed_binary_squares=max(exps).bit_length()-1,
        fixed_binary_products=sum(e.bit_count()-1 for e in exps),
        prefix_squares=len(prefixes),prefix_products=sum(e%2 for e in prefixes),
        complement_tree_squares=power_cost(m)[0]+tree[0]+1,
        complement_tree_products=power_cost(m)[1]+tree[1],
        minus_one_variant_squares=power_cost(m)[0]+tree[0],
        minus_one_variant_inverse_checks=len(primes)-1,
        outputs=exps,inverse_checks=len(primes)))
out=dict(scope='geometry and arithmetic schedules, no prime search or success claim',
    N=N,primorial31=P,prime_factors=primes,portfolio=frows,
    period=period,distinct_candidates_per_period=union_per_period,
    density_numerator=union_per_period,density_denominator=period,windows=rows)
out['complement_tree']=tree_records(fullmask)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print('P, period, union',P,period,union_per_period)
    for r in rows: print(r['B'],r['slots'],r['per_F_top_counts'],r['portfolio_union_top'],r['portfolio_union_any_window_min'],r['portfolio_union_any_window_max'],r['power2_45_top'])
    for r in frows: print(r['m'],r['F'],r['fixed_binary_squares'],r['fixed_binary_products'],r['complement_tree_squares'],r['complement_tree_products'])
