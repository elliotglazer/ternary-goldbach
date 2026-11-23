"""Independent saved-input precision/cache reconstruction; no writer imports."""
from pathlib import Path
from collections import Counter
import hashlib
import json

HERE = Path(__file__).resolve().parent
AG = HERE.parent
MAX_BYTES = 64 * 1024 * 1024
MAX_ROWS = 1000000
PIN_MANIFEST = 'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'
PIN_AXIS = '8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E'
CHECKS = 0
def ck(condition, label):
    global CHECKS
    if not condition:
        raise AssertionError(label)
    CHECKS += 1
def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()
def read_pinned(rel, expected):
    path = AG / rel
    ck(path.stat().st_size <= MAX_BYTES, 'input byte cap '+rel)
    raw = path.read_bytes()
    ck(hashlib.sha256(raw).hexdigest().upper() == expected, 'input hash '+rel)
    return json.loads(raw)

manifest = read_pinned('integration/transform_structural_manifest_20261111.json', PIN_MANIFEST)
axis_receipt = read_pinned('zero-sum/mixed_radix_precision_metadata_20261111.json', PIN_AXIS)
ck(manifest['schema'] == 'selected-transform-structural-manifest-1', 'manifest schema')
ck(manifest['conductor_fields'] == ['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'], 'source row schema')
plan = {int(n): value for n, value in manifest['plan'].items()}
ck(len(plan) == 37117, 'full saved plan count')
canonical = hashlib.sha256(json.dumps(manifest['plan'], sort_keys=True, separators=(',',':')).encode()).hexdigest()
ck(canonical == manifest['canonical_plan_sha256'] == axis_receipt['plan_sha256'], 'canonical plan binding')
axis = {row['n']: row for row in axis_receipt['axis_rows']}
ck(len(axis) == len(axis_receipt['axis_rows']) == 13943, 'unique saved axis count')

def radix_bound(n):
    if n == 1:
        return (0, 1)
    k = n.bit_length()-1
    return (2*k+4, max(1,2*k))
def blue_bound(n):
    padded = 1 << (2*n-2).bit_length()
    k = padded.bit_length()-1
    radius = 2*k+4
    amp = 1+3*radius
    return (6*padded*amp+2*radius*(2*n+1)+8,
            max(1,2*k,padded*amp,3*n*padded*amp+1))

# Increasing saved lengths provide a topological order. No planner is called.
mixed = {}
children = {}
for n in sorted(plan):
    choice = plan[n]['choice']
    kind = choice[0]
    if kind == 'split':
        _, r, m = choice
        ck(r*m == n and 1 < r < n and 1 < m < n, 'split domain')
        cr, dr = mixed[r]
        cm, dm = mixed[m]
        mixed[n] = (cm+cr+2, max(1,dr,dm,cm+cr*(2*cm+1)))
        children[n] = (r,m)
    elif kind == 'radix2':
        ck(n > 0 and n & (n-1) == 0, 'saved radix domain')
        mixed[n] = radix_bound(n)
        children[n] = ()
    elif kind == 'direct_prime':
        ck(n in (3,5,7,11), 'saved direct domain')
        mixed[n] = (2,1)
        children[n] = ()
    else:
        ck(kind == 'bluestein' and n >= 2, 'saved Blue domain')
        mixed[n] = blue_bound(n)
        children[n] = ()
for n, row in axis.items():
    old = radix_bound(n) if n > 0 and n & (n-1) == 0 else blue_bound(n)
    ck(old == (row['old_C'], row['old_D']), 'baseline coefficient row')
    ck(mixed[n] == (row['new_C'], row['new_D']), 'mixed coefficient row')

source_rows = manifest['conductors']
ck(len(source_rows) == 125400 < MAX_ROWS, 'source conductor count')
expected_rows = []
mask = {n: 0 for n in plan}
hist = Counter()
phis = Counter()
primitives = Counter()
seen_c = set()
sg = 202305920
constant = (1266*sg)**2
for source_id, source in enumerate(source_rows):
    c, phi, primitive, height, height_nodes, axes, weights = source
    ck(c not in seen_c and 10000 < c <= 265800 and 0 < phi <= c, 'source identity/domain')
    ck((c % 2 == 1 and c <= 132900) or c % 4 == 0, 'source parity domain')
    seen_c.add(c)
    prod = 1
    prim_prod = 1
    for n, q in axes:
        prod *= n
        ck(n in axis and (q == 0 or q > 1 and n % q == 0), 'axis binding')
        prim_prod *= n if q == 0 else n-n//q
    ck(prod == phi, 'axis product phi')
    ck(prim_prod == primitive, 'primitive restriction binding')
    ck(len(weights) == 20 and all(type(w) is int and w >= 0 for w in weights), 'unchanged weights type')
    sm = sum(axis[n]['new_C'] for n,q in axes)
    so = sum(axis[n]['old_C'] for n,q in axes)
    dd = max([1] + [axis[n][key] for n,q in axes for key in ('old_D','new_D')])
    ck(0 <= sm <= so and sm <= sg, 'sum bounds')
    left = (2*phi*sm)**2
    right = c*constant
    ck(left <= right, 'p108 available')
    p_budget = 100 if left == 0 else max(100, 108-((right//left).bit_length()-1)//2)
    p_safe = (max(dd,2*so,1)-1).bit_length()
    p = max(p_budget,p_safe,100)
    ck(100 <= p <= 108, 'selected range')
    budget_slack = right-left*2**(2*(108-p))
    ds = 2**p-dd
    ps = 2**p-2*so
    ck(min(budget_slack,ds,ps) >= 0, 'selected safety and budget')
    for smaller in range(100,p):
        ck(left*2**(2*(108-smaller)) > right or 2**smaller < dd or 2**smaller < 2*so, 'minimality')
    expected_rows.append([source_id,c,phi,primitive,axes,sm,so,dd,p,budget_slack,ds,ps])
    hist[p] += 1
    phis[p] += phi
    primitives[p] += primitive
    for n,q in axes:
        mask[n] |= 1 << (p-100)

# Propagate precision masks once per node, from parents to strictly shorter children.
for n in sorted(plan, reverse=True):
    for child in children[n]:
        mask[child] |= mask[n]
node_pairs = [(n,p) for n in sorted(plan) for p in range(100,109) if mask[n] & (1 << (p-100))]
ck(len(node_pairs) <= 9*37117 < MAX_ROWS, 'node/precision cap')
kernels = [[n,p,1 << (2*n-2).bit_length()] for n,p in node_pairs if plan[n]['choice'][0] == 'bluestein']
base_kernel_lengths = {n for n,p,_ in kernels}
ck(len(base_kernel_lengths) == 6004, 'baseline kernel length coverage')
ck(sum(1 << (2*n-2).bit_length() for n in base_kernel_lengths) == 337702368, 'baseline kernel entry coverage')

author_script = AG / 'major-constants/conductor_local_precision_metadata_20261111.py'
ck(digest(author_script) == '8B0C9764E94A7E35FB071CED0E5731135E11D397B9BA9F582119BAA9005386DA', 'author source pin')
author = read_pinned('major-constants/conductor_local_precision_metadata_20261111.json', '7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978')
row_art = read_pinned('major-constants/conductor_local_precision_rows_20261111.json', 'B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7')
cache_art = read_pinned('major-constants/conductor_local_precision_caches_20261111.json', '95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584')
ck(row_art['schema'] == 'conductor-local-precision-rows-1', 'output row schema')
ck(row_art['fields'] == ['source_row_id','c','phi','primitive','ordered_axes_n_q','S_mixed','S_old','D_local','p','squared_budget_slack','D_slack','peak_slack'], 'output row fields')
ck(len(row_art['rows']) == len(expected_rows), 'output row count')
for expected, actual in zip(expected_rows,row_art['rows']):
    ck(expected == actual, 'entire source-bound precision row')
ck(row_art['source_weight_binding'] == 'unchanged saved row identity; weights not folded', 'weight binding scope')
ck(cache_art['schema'] == 'conductor-local-precision-caches-1', 'cache schema')
ck(cache_art['plan_sha256'] == canonical, 'cache plan identity')
ck(cache_art['full_node_fields'] == ['n','p','saved_choice','ordered_child_n_p'], 'node fields')
ck(cache_art['kernel_fields'] == ['n','p','P'], 'kernel fields')
ck(len(cache_art['full_nodes']) == len(node_pairs), 'full node count')
for (n,p), actual in zip(node_pairs,cache_art['full_nodes']):
    expected = [n,p,plan[n]['choice'],[[child,p] for child in children[n]]]
    ck(expected == actual, 'ordered full-plan precision closure')
ck(cache_art['kernels'] == kernels, 'exact kernel membership and padded length')
contract = cache_art['contract']
expected_contract = {
    'id':'local-u-rounded-normalized-blue-v1',
    'p_domain':[100,108],
    'coordinate_grid':'2^-p; exact grid100 input embedding',
    'root_chirp_norm_error':'<=u=2^-p from exact coefficient specified by saved full-plan convention',
    'complex_gate_absolute_error':'<=u, exact common-grid additions allowed',
    'original_kernel_error':'<=P*A*u from specified exact chirp FFT; A=1+3*(2*log2(P)+4)',
    'scaled_kernel_error':'<= (A+1)*u from exact K/P; center is Round_u(Khat/P)',
    'rounding_policy':'coordinate nearest, lower-closed upper-open residual; fixed across object',
    'cached_sums':'two exact REAL sums of the actual new scaled complex center',
    'lifetime':'one cold construction retained for this complete pass; rebuilds not credited free',
    'cache_identity':'full plan/hash, n,P,chirp/sign convention,variant,p,rounding,contract,lifetime',
}
ck(contract == expected_contract, 'complete fixed cache enclosure contract')
contract_hash = hashlib.sha256(json.dumps(contract,sort_keys=True,separators=(',',':')).encode()).hexdigest().upper()
for obj in (row_art,cache_art,author):
    ck(obj['contract_sha256'] == contract_hash, 'contract binding')
    ck(obj['inputs'] == {
        'integration/transform_structural_manifest_20261111.json':{'bytes':25110201,'sha256':PIN_MANIFEST},
        'zero-sum/mixed_radix_precision_metadata_20261111.json':{'bytes':1911933,'sha256':PIN_AXIS}}, 'input provenance')
for obj in (row_art,cache_art):
    ck(obj['guards_included'] is False and obj['prices_included'] is False, 'no guard or price inclusion')
cache_counts = Counter(p for n,p,padded in kernels)
cache_entries = Counter()
for n,p,padded in kernels:
    cache_entries[p] += padded
dist = [{'p':p,'conductors':hist[p],'phi_total':phis[p],'primitive_total':primitives[p],
         'kernel_keys':cache_counts[p],'kernel_entries':cache_entries[p]} for p in range(100,109)]
ck(author['precision_distribution'] == dist, 'all precision distribution fields')
mult = Counter(Counter(n for n,p,padded in kernels).values())
expected_summary = {
    'conductors':len(source_rows),
    'precision_tests':sum((p-99)*count for p,count in hist.items()),
    'max_tests_per_row':max(p-99 for p,count in hist.items() if count),
    'full_plan_precision_states':len(node_pairs),
    'total_output_records':len(source_rows)+len(node_pairs)+len(kernels),
    'baseline_kernel_lengths':len(base_kernel_lengths),
    'baseline_kernel_entries':337702368,
    'local_kernel_keys':len(kernels),
    'local_kernel_entries':sum(cache_entries.values()),
    'extra_kernel_keys':len(kernels)-len(base_kernel_lengths),
    'extra_kernel_entries':sum(cache_entries.values())-337702368,
    'precision_multiplicity_histogram':{str(k):v for k,v in sorted(mult.items())},
    'scaled_cache_complex_rounds':sum(cache_entries.values()),
    'exact_real_cache_sums':2*sum(cache_entries.values()),
    'production_selected':False,
    'runtime_claim':False,
}
for key,value in expected_summary.items():
    ck(author[key] == value, 'summary '+key)
for artifact in author['artifacts']:
    path = AG / 'major-constants' / artifact['path']
    ck(path.stat().st_size == artifact['bytes'] < MAX_BYTES, 'artifact bytes')
    ck(digest(path) == artifact['sha256'], 'artifact receipt pin')
ck(expected_summary['total_output_records'] < MAX_ROWS, 'combined output cap')
ck(author['preflight_sha256'] == '1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A', 'paper contract pin')
ck(author['preflight_review_sha256'] == '15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2', 'math review pin')
out = {
    'scope':'Independent saved-input reconstruction only; no writer import, new planner, conductor/height regeneration, root/value enumeration, guards or price fold.',
    'checks':CHECKS,
    'script_sha256':digest(Path(__file__)),
    'source_manifest_sha256':PIN_MANIFEST,
    'source_axis_receipt_sha256':PIN_AXIS,
    'author_receipt_sha256':'7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978',
    'method':'Bottom-up fixed-plan C/D; quotient-bit-length precision; descending precision masks; exact output/schema comparison.',
    'contract_sha256':contract_hash,
    'precision_distribution':dist,
    'reconstructed_summary':expected_summary,
}
path = HERE / 'review_conductor_local_metadata_20261111.json'
with path.open('x',encoding='utf-8',newline='\n') as stream:
    json.dump(out,stream,indent=2)
    stream.write('\n')
print(json.dumps({'checks':CHECKS,'script_sha256':out['script_sha256'],'receipt_sha256':digest(path),
                  'precision_distribution':dict(sorted(hist.items())), 'cache_keys':len(kernels),'cache_entries':sum(cache_entries.values())}))
