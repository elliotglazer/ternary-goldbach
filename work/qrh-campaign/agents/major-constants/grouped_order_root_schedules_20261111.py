"""Exact finite exponent-DAG/partition costs; no candidate or prime evaluations."""
from functools import lru_cache
from math import prod
from pathlib import Path
import json

qs=(2,3,5,7,11,13,17,19,23,29,31)
P=prod(qs)
full=(1<<len(qs))-1
def pc(e):
    assert e>=1
    return e.bit_length()-1,e.bit_count()-1
def add(*v): return tuple(sum(x[i] for x in v) for i in (0,1))
def key(v): return sum(v),v[0],v[1]
def indices(mask): return [i for i in range(len(qs)) if mask>>i&1]
@lru_cache(None)
def rad(mask): return prod(qs[i] for i in indices(mask))
@lru_cache(None)
def tree(mask):
    if mask&(mask-1)==0: return (0,0,None)
    bit=mask&-mask
    sub=(mask-1)&mask
    best=None
    while sub:
        other=mask^sub
        if other and sub&bit:
            cost=add(tree(sub)[:2],tree(other)[:2],pc(rad(sub)),pc(rad(other)))
            cand=(key(cost),sub,other,cost)
            if best is None or cand[:3]<best[:3]: best=cand
        sub=(sub-1)&mask
    return (*best[3],(best[1],best[2]))

rows=[]
for multiplier in (160,162,165,168,175,180):
    F=multiplier*P
    rem=F
    es=[]
    for q in qs:
        e=0
        while rem%q==0: rem//=q;e+=1
        assert e>=1
        es.append(e)
    assert rem==1 and prod(q**e for q,e in zip(qs,es))==F
    group={}
    for mask in range(1,full+1):
        ix=indices(mask)
        d=prod(qs[i]**es[i] for i in ix)
        if mask==1 and es[0]==1:
            group[mask]=dict(roots=0,squares=0,products=0,method='oddness',d=d)
            continue
        E={d//qs[i] for i in ix}
        if not(mask&1): E.add(d)
        ladder=(max(E).bit_length()-1,sum(e.bit_count()-1 for e in E))
        t=d//rad(mask)
        pre_binary=pc(t)
        pre_chain=(sum((es[i]-1)*pc(qs[i])[0] for i in ix),
                   sum((es[i]-1)*pc(qs[i])[1] for i in ix))
        pre=min((pre_binary,'binary'),(pre_chain,'prime_chain'),key=lambda z:(key(z[0]),z[1]))
        fermat=(0,0) if mask&1 else min((pc(qs[i]) for i in ix),key=key)
        comp=add(pre[0],tree(mask)[:2],fermat)
        options=[(ladder,'binary_ladder'),(comp,'complement_tree_'+pre[1])]
        cost,method=min(options,key=lambda z:(key(z[0]),z[1]))
        group[mask]=dict(roots=1,squares=cost[0],products=cost[1],method=method,d=d,
            required_exponents=sorted(E),prepower=t,
            ladder_cost=list(ladder),complement_cost=list(comp))

    @lru_cache(None)
    def partition(mask):
        if mask==0:return {0:(0,0,())}
        out={}
        bit=mask&-mask
        sub=mask
        while sub:
            if sub&bit:
                g=group[sub]
                for roots,(s,m,blocks) in partition(mask^sub).items():
                    r=roots+g['roots']
                    v=(s+g['squares'],m+g['products'],tuple(sorted((sub,)+blocks)))
                    if r not in out or (sum(v[:2]),*v)<(sum(out[r][:2]),*out[r]): out[r]=v
            sub=(sub-1)&mask
        return out

    frontier=[]
    prior=None
    for roots,(s,m,blocks) in sorted(partition(full).items()):
        # All ten odd-prime leaf-minus-one unit conditions use nine products and one inverse check.
        assert len(set().union(*(set(indices(b)) for b in blocks)))==11
        assert sum(blocks)==full
        total=s+m+10
        nondominated=prior is None or total<prior
        if nondominated:prior=total
        frontier.append(dict(root_count=roots,inverse_coordinates=1,
            exponent_squares=s,exponent_products=m,aggregate_unit_products=10,
            total_modular_operations=total,root_plus_inverse_coordinates=roots+1,
            nondominated_root_count_total=nondominated,
            groups=[dict(mask=b,prime_powers=[qs[i]**es[i] for i in indices(b)],**group[b]) for b in blocks]))
    rows.append(dict(multiplier=multiplier,F=F,exponents=es,partitions=frontier))

# Every complement-tree edge is a literal exponent multiplication identity.
def check_tree(mask,outside=1):
    split=tree(mask)[2]
    if split is None:
        assert outside==P//rad(mask)
        return
    l,r=split
    assert l&r==0 and l|r==mask
    check_tree(l,outside*rad(r));check_tree(r,outside*rad(l))
check_tree(full)
out=dict(scope='equal-weight exact schedule optimum within stated binary/tree family, not time optimum',
    qs=qs,P=P,source_prime_certification='inherited eleven fixed prime facts, not tested here',
    generic_full_vector_Pareto='specified in prose; this receipt computes only the square+product projection',
    rows=rows,tree_records=[dict(mask=m,split=tree(m)[2],squares=tree(m)[0],products=tree(m)[1]) for m in range(1,full+1)])
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
for row in rows:
    print(row['multiplier'],[(r['root_count'],r['exponent_squares'],r['exponent_products'],r['total_modular_operations']) for r in row['partitions']])
