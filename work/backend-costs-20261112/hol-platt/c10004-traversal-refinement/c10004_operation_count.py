"""Source-traced scalar count, not a formal cost theorem or benchmark."""
from pathlib import Path
from collections import Counter
import hashlib, json
base = Path(__file__).resolve().parent
source = base.parent / 'c10004-transform/C10004TransformScript.sml'
source_hash = hashlib.sha256(source.read_bytes()).hexdigest()
assert source_hash == '4f9fe96c14463dc6bd56f2f3e80c68d2865c4acd003cf6bc9ef569264b772346'

def action(n, index):
    k = index % n
    if k == 0: role = 'identity_action'
    elif 2*k == n: role = 'negation_action'
    elif 4*k == n or 4*k == 3*n: role = 'quarter_turn'
    else: role = 'general_root_product'
    return Counter({role: 1})

def direct(n, k):
    if n == 2:
        return Counter({'complex_add' if k % 2 == 0 else 'complex_sub': 1})
    result = Counter({'complex_add': n-1})
    for j in range(1, n): result.update(action(n, j*k))
    return result

def circuit(fuel, n, omit):
    result = Counter()
    if fuel == 0 or n in (2,3,5):
        for k in range(1 if omit else 0, n): result.update(direct(n, k))
        return result
    r = 3 if n == 15 else 2
    m = n // r
    for a in range(r): result.update(circuit(fuel-1, m, False))
    for v in range(m):
        for a in range(r): result.update(action(n, a*v))
    for k in range(1 if omit else 0, n): result.update(direct(r, k//m))
    return result

stages = []
total = Counter()
for name, n, repetitions in [('axis2',2,2400),('rows40',40,60),('rows60',60,39)]:
    per_call = circuit(6,n,True)
    repeated = Counter({key:value*repetitions for key,value in per_call.items()})
    total.update(repeated)
    stages.append({'name':name,'node_length':n,'repetitions':repetitions,
                   'per_call':dict(per_call),'total':dict(repeated)})
model_path = base.parent.parent/'forecast-audit-20261113/end_to_end_model.json'
model = json.loads(model_path.read_text())
factors = {row['name']:row['butterfly_factors'][1] for row in model['semantic_rows']}
anchor = .073960 / 8192
priced = {
 'large_root_product': total['general_root_product'],
 'large_complex_add': total['complex_add']+total['complex_sub'],
 'large_quarter_turn': total['quarter_turn']}
prices = {name:count*factors[name]*anchor for name,count in priced.items()}
result = {'scope':'Source-traced arithmetic roles only; unproved count and unmeasured prices',
 'reference_source_sha256':source_hash,
 'model_json_sha256':hashlib.sha256(model_path.read_bytes()).hexdigest(),
 'stages':stages,'totals':dict(total),'priced_counts':priced,
 'seconds_per_reference_butterfly':anchor,
 'planning_factors':{name:factors[name] for name in priced},
 'nominal_arithmetic_seconds_by_role':prices,
 'nominal_arithmetic_seconds':sum(prices.values()),
 'excluded':'Indexing, copies, allocation, root-cache construction, guards, source/root generation, analytic completion, counting, first admission, export, retries; campaign allowances not applied'}
(base/'C10004_ARITHMETIC_PRICE_INTERFACE.json').write_text(json.dumps(result,indent=2)+'\n',newline='\n')
print(json.dumps({'counts':priced,'unpriced_action_counts':{
 'identity':total['identity_action'],'negation':total['negation_action']},
 'nominal_seconds':sum(prices.values()),'role_seconds':prices},indent=2))
