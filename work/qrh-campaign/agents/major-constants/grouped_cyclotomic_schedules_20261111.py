"""Integer exponent circuits and bounded cost projections, never modular values."""
from pathlib import Path
from functools import lru_cache
from math import prod
import json, hashlib

HERE=Path(__file__).resolve().parent
OLD=HERE/'grouped_order_root_schedules_20261111.json'
old=json.loads(OLD.read_text())
qs=tuple(old['qs']);FULL=(1<<len(qs))-1
TREES={r['mask']:r for r in old['tree_records']}
prices=((1,1),(1,2),(2,1))
def ix(mask):return [i for i in range(11) if mask>>i&1]
def pc(e):return e.bit_length()-1,e.bit_count()-1,0
def plus(*cs):return tuple(sum(c[i] for c in cs) for i in range(3))
def rank(c,price):return price[0]*c[0]+price[1]*c[1],c[2],c[0],c[1]
@lru_cache(None)
def sc(q):
    if q==1:return 0,0,0
    if q==2:return 0,0,1
    if q==3:return 1,0,2
    a,b,c=sc(q//2);return a+1,b+1,c+1+q%2
def ladder(E):return max(E).bit_length()-1,sum(e.bit_count()-1 for e in E),0

results=[]
for prior in old['rows']:
    es=prior['exponents'];F=prior['F']
    all_prices=[]
    for price in prices:
        groups={}
        for mask in range(1,FULL+1):
            ids=ix(mask);odd=mask&~1
            d=prod(qs[i]**es[i] for i in ids)
            if mask==1 and es[0]==1:
                groups[mask]={False:dict(cost=(0,0,0),roots=0,unit_count=0,cyclo_mask=0,method='parity',d=d)}
                continue
            rad=prod(qs[i] for i in ids);t=d//rad
            leafE={d//qs[i] for i in ids}
            base=[(ladder(leafE),'leaf_binary_ladder')]
            tr=TREES[mask]
            tree=(tr['squares'],tr['products'],0)
            base += [(plus(pc(t),tree),'tree_binary_prepower'),
                     (plus(tuple(sum((es[i]-1)*pc(qs[i])[k] for i in ids) for k in range(3)),tree),'tree_prime_chain')]
            opts={}
            cm=odd
            while True:
                ci=ix(cm);units=(odd^cm).bit_count()
                tests=plus(*(sc(qs[i]) for i in ci),(0,units,units))
                # units products = (units-1) product formation + one global inverse check,
                # summed across groups; valid after all group unit lists are concatenated.
                needs_fermat=not(mask&1) and cm==0
                bopts=list(base)
                if needs_fermat:
                    power=min((pc(qs[i]) for i in ids),key=lambda c:rank(c,price))
                    bopts=[(plus(c,power),m+'_fermat_from_leaf') for c,m in base]
                    bopts.append((ladder(leafE|{d}),'full_binary_ladder'))
                for bcost,method in bopts:
                    cost=plus(bcost,tests)
                    rec=dict(cost=cost,roots=1,unit_count=units,cyclo_mask=cm,method=method,d=d,
                             needs_separate_fermat=needs_fermat,prepower=t)
                    flag=bool(units)
                    if flag not in opts or (rank(cost,price),cm,method)<(rank(opts[flag]['cost'],price),opts[flag]['cyclo_mask'],opts[flag]['method']):opts[flag]=rec
                if cm==0:break
                cm=(cm-1)&odd
            groups[mask]=opts

        @lru_cache(None)
        def dp(mask):
            if mask==0:return {(0,False):((0,0,0),())}
            bit=mask&-mask;sub=mask;out={}
            while sub:
                if sub&bit:
                    for gf,g in groups[sub].items():
                        for (r,f),(c,bs) in dp(mask^sub).items():
                            key=(r+g['roots'],f or gf)
                            v=(plus(g['cost'],c),tuple(sorted(((sub,gf),)+bs)))
                            if key not in out or (rank(v[0],price),v[1])<(rank(out[key][0],price),out[key][1]):out[key]=v
                sub=(sub-1)&mask
            return out
        answer=[]
        for (r,f),(c,bs) in sorted(dp(FULL).items()):
            records=[dict(mask=b,**groups[b][bf]) for b,bf in bs]
            assert sum(b for b,bf in bs)==FULL
            assert sum(g['unit_count'] for g in records)>0 if f else sum(g['unit_count'] for g in records)==0
            assert sum(g['roots'] for g in records)==r
            assert plus(*(g['cost'] for g in records))==c
            answer.append(dict(roots=r,inverse_coordinates=int(f),coordinates=r+int(f),squares=c[0],
                products=c[1],additions=c[2],equal_weight_total=c[0]+c[1],weighted_total=price[0]*c[0]+price[1]*c[1],
                unit_count=sum(g['unit_count'] for g in records),groups=records))
        # Resource frontier of the sampled support points, not the complete vector Pareto set.
        for v in answer:
            v['sampled_resource_nondominated']=not any(
                all(w[k]<=v[k] for k in ('coordinates','squares','products','additions')) and
                any(w[k]<v[k] for k in ('coordinates','squares','products','additions')) for w in answer)
        all_prices.append(dict(square_price=price[0],product_price=price[1],rows=answer))
    results.append(dict(multiplier=prior['multiplier'],F=F,exponents=es,price_projections=all_prices))

# Exact bit/exponent witnesses for the frozen tree library, separately from any value evaluation.
def validate_tree(mask,multiplier=1):
    split=TREES[mask]['split']
    if split is None:
        return {mask:multiplier}
    l,r=split;assert l&r==0 and l|r==mask
    return validate_tree(l,multiplier*prod(qs[i] for i in ix(r)))|validate_tree(r,multiplier*prod(qs[i] for i in ix(l)))
for mask in range(1,FULL+1):
    v=validate_tree(mask);rad=prod(qs[i] for i in ix(mask))
    assert all(v[1<<i]==rad//qs[i] for i in ix(mask))
pins=[OLD,HERE/'EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md',HERE.parents[2]/'qrh-blueprint/CYCLOTOMIC_SUM_ONLY_CERTIFICATES_2026-11-11.md',HERE.parents[2]/'qrh-blueprint/cyclotomic_sum_only_schedules_20261111.json']
out=dict(scope='three fixed square/product price projections; exact within specified fixed-tree library; not full vector/time optimum',
    prices=prices,prime_sum_costs={str(q):sc(q) for q in qs[1:]},rows=results,
    pins=[dict(path=str(p),sha256=hashlib.sha256(p.read_bytes()).hexdigest().upper()) for p in pins])
path=Path(__file__).with_suffix('.json');path.write_text(json.dumps(out,indent=2)+'\n')
for row in results:
    equal=row['price_projections'][0]['rows']
    print(row['multiplier'],[(v['roots'],v['inverse_coordinates'],v['equal_weight_total']) for v in equal])
print('SHA256',hashlib.sha256(path.read_bytes()).hexdigest().upper())
