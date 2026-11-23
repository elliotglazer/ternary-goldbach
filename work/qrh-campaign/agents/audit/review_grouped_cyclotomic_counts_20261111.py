"""Independent saved-circuit integer audit; no modular values or author imports."""
from pathlib import Path
from math import prod
import json
import hashlib

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents/major-constants'
pins={
 'EFFICIENCY_GROUPED_CYCLOTOMIC_SUPPLEMENT_2026-11-11.md':'3429D9CEECB68030C1AE052662A75884453CBBB62993358D0B12D007BE797E58',
 'grouped_cyclotomic_schedules_20261111.py':'95BD950D8E5776106B69C8449B62185F75281636A56DF591B479F5321E1829A4',
 'grouped_cyclotomic_schedules_20261111.json':'FC21AE178DD49F9923244B3D2CA6547CB31797AE695F8D4F683C8A78519E7585',
}
for name,digest in pins.items():
    assert hashlib.sha256((BASE/name).read_bytes()).hexdigest().upper()==digest
data=json.loads((BASE/'grouped_cyclotomic_schedules_20261111.json').read_text())
old=json.loads((BASE/'grouped_order_root_schedules_20261111.json').read_text())
for pin in data['pins']:
    assert hashlib.sha256(Path(pin['path']).read_bytes()).hexdigest().upper()==pin['sha256']
qs=old['qs']; full=(1<<len(qs))-1
assert qs==[2,3,5,7,11,13,17,19,23,29,31]

def ids(mask): return [i for i in range(len(qs)) if mask&(1<<i)]
def plus(*xs): return tuple(sum(x[k] for x in xs) for k in range(3))
def power(e):
    assert e>=1
    return (len(bin(e))-3,bin(e).count('1')-1,0)
def ladder(exponents):
    return (max(power(e)[0] for e in exponents),sum(power(e)[1] for e in exponents),0)
def sums(q):
    # Charge the path to the 1/2/3 base iteratively.
    s=m=a=0
    while q>3:
        s+=1; m+=1; a+=1+q%2; q//=2
    return plus((s,m,a),{1:(0,0,0),2:(0,0,1),3:(1,0,2)}[q])
for q in qs[1:]: assert list(sums(q))==data['prime_sum_costs'][str(q)]

# Validate all saved trees by an explicit stack of exponent multipliers.
trees={x['mask']:x for x in old['tree_records']}
tree_cost={}
for mask in range(1,full+1):
    stack=[(mask,1)]; leaves={}; cost=(0,0,0)
    while stack:
        node,exponent=stack.pop()
        split=trees[node]['split']
        if split is None:
            assert node.bit_count()==1 and node not in leaves
            leaves[node]=exponent
        else:
            l,r=split
            assert l and r and l&r==0 and l|r==node
            lp=prod(qs[i] for i in ids(l)); rp=prod(qs[i] for i in ids(r))
            cost=plus(cost,power(lp),power(rp))
            stack.extend([(l,exponent*rp),(r,exponent*lp)])
    rad=prod(qs[i] for i in ids(mask))
    assert leaves=={1<<i:rad//qs[i] for i in ids(mask)}
    assert cost==(trees[mask]['squares'],trees[mask]['products'],0)
    tree_cost[mask]=cost

group_count=row_count=0
for family in data['rows']:
    es=family['exponents']
    assert prod(q**e for q,e in zip(qs,es))==family['F']==family['multiplier']*prod(qs)
    for projection in family['price_projections']:
        alpha,beta=projection['square_price'],projection['product_price']
        def rank(c): return alpha*c[0]+beta*c[1],c[2],c[0],c[1]
        for row in projection['rows']:
            seen=0; total=(0,0,0); units=roots=0
            for group in row['groups']:
                mask=group['mask']; cm=group['cyclo_mask']; method=group['method']
                assert mask and not seen&mask
                seen|=mask
                d=prod(qs[i]**es[i] for i in ids(mask)); assert d==group['d']
                if method=='parity':
                    assert mask==1 and es[0]==1 and cm==0 and group['roots']==group['unit_count']==0
                    cost=(0,0,0)
                else:
                    assert cm&~mask==0 and cm&1==0 and group['roots']==1
                    roots+=1
                    odd=mask&~1; u=(odd^cm).bit_count(); assert u==group['unit_count']
                    units+=u
                    fermat=(mask&1==0 and cm==0)
                    assert fermat==group['needs_separate_fermat']
                    t=d//prod(qs[i] for i in ids(mask)); assert t==group['prepower']
                    exponents={d//qs[i] for i in ids(mask)}
                    suffix='_fermat_from_leaf'
                    core=method[:-len(suffix)] if method.endswith(suffix) else method
                    if core=='leaf_binary_ladder': cost=ladder(exponents)
                    elif core=='full_binary_ladder':
                        assert fermat
                        cost=ladder(exponents|{d})
                    elif core=='tree_binary_prepower': cost=plus(power(t),tree_cost[mask])
                    elif core=='tree_prime_chain':
                        cost=plus(tree_cost[mask],tuple(sum((es[i]-1)*power(qs[i])[k] for i in ids(mask)) for k in range(3)))
                    else: raise AssertionError(method)
                    if method.endswith(suffix):
                        assert fermat
                        cost=plus(cost,min((power(qs[i]) for i in ids(mask)),key=rank))
                    else: assert not fermat or core=='full_binary_ladder'
                    cost=plus(cost,(0,u,u),*(sums(qs[i]) for i in ids(cm)))
                assert list(cost)==group['cost']
                total=plus(total,cost); group_count+=1
            assert seen==full and roots==row['roots'] and units==row['unit_count']
            assert row['inverse_coordinates']==int(units>0)
            assert row['coordinates']==roots+int(units>0)
            assert total==(row['squares'],row['products'],row['additions'])
            assert total[0]+total[1]==row['equal_weight_total']
            assert alpha*total[0]+beta*total[1]==row['weighted_total']
            row_count+=1

family=data['rows'][0]; assert family['multiplier']==160
equal=family['price_projections'][0]['rows']
curve=[min(x['equal_weight_total'] for x in equal if x['coordinates']==c) for c in range(1,12)]
assert curve==[221,159,124,93,77,70,66,62,59,57,55]
manual=[plus(ladder({10400,4160,1600}),(0,2,2)),
        plus(ladder({209,57,33}),sums(3),(0,2,2)),
        plus(ladder({29,17}),power(17),(0,2,2)),
        plus(ladder({713,217,161}),sums(7),(0,2,2))]
assert manual==[(13,8,2),(8,9,4),(8,7,2),(11,13,6)]
assert plus(*manual)==(40,37,14)
assert prod([20800,627,493,4991])==family['F']
result=dict(status='PASS',scope='Saved integer schedules and manual circuit only; no exhaustive DP rerun or modular values',
            primary_pins=pins,predecessor_pins=data['pins'],trees=len(trees),rows=row_count,groups=group_count,
            manual_m160=manual,manual_total=[40,37,14],m160_coordinate_curve=curve)
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8',newline='\n') as out:
    json.dump(result,out,indent=2); out.write('\n')
print(f'PASS: {len(trees)} trees, {row_count} saved schedules, {group_count} groups; no modular evaluation.')
