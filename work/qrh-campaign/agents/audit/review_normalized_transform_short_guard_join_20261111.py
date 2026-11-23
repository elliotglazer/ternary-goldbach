"""Independent integer-only saved-DAG review; no planner or numerical evaluator."""
from pathlib import Path
from collections import defaultdict, Counter
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
LIMIT = 220108
checked = 0
pins = {}

def need(value):
    global checked
    if not value:
        raise AssertionError(checked)
    checked += 1

def read(name, expected):
    path = AGENTS / name
    raw = path.read_bytes()
    need(len(raw) <= 64 * 1024**2)
    actual = hashlib.sha256(raw).hexdigest().upper()
    need(actual == expected)
    pins[name] = actual
    return json.loads(raw)

mf = read('integration/transform_structural_manifest_20261111.json', 'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637')
orig = read('integration/transform_structural_events_20261111.json', '06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B')
norm = read('independent-feasibility/normalized_bluestein_events_20261111.json', '721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2')
gr = read('integration/short_window_guard_conductor_rows_20261111.json', 'A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA')
gs = read('integration/short_window_guard_ledger_20261111.json', 'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4')
pr = read('moebius/normalized_transform_precision_costs_20261111.json', 'C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4')
new = read('integration/normalized_transform_short_guard_events_20261111.json', 'F26896C955B06006AEBA260FB6605EDE21DDD3EA9CED984E0DD46BADAA855897')
receipt = read('integration/normalized_transform_short_guard_join_20261111.json', '4F6F20570E0E1F35C806E173E2FA13B95CCD084B177F38F359E3F3171F5EB66A')

nodes = {(x[0], x[1]): x for x in mf['requests']}
need(len(nodes) == len(mf['requests']) == 35190)
need(len(mf['conductors']) == len(gr['rows_data']) == 125400)
need(mf['extras'] == gr['extras'] == [0, 167, 320, 640])
ends = mf['band_last_indices']
need(ends == gr['band_last_indices'] == [6400, 12800, 25600, 64000, 128000])
opskeys = ['general_complex_products', 'complex_add_sub', 'quarter_turns', 'negations', 'dyadic_scales']
pending = defaultdict(dict)
metadata = [Counter() for _ in range(20)]

def accumulate(table, key, weights, factor):
    if factor == 0:
        return
    target = table.setdefault(key, [0] * len(weights))
    for index in range(len(weights)):
        target[index] += weights[index] * factor

def intersect_count(start, stop, lo, hi):
    return max(0, min(stop, hi) - max(start, lo))

for source, guard in zip(mf['conductors'], gr['rows_data']):
    c, phi, prim, height, J, axes, oldw = source
    gc, gJ, gp, gn, perheight, guardw = guard
    need((c, J, phi, prim) == (gc, gJ, gp, gn))
    need(len(oldw) == len(guardw) == 20)
    for scenario, extra in enumerate(mf['extras']):
        start = J + extra
        lo = 0
        for band, end in enumerate(ends):
            i = 5 * scenario + band
            need(oldw[i] == intersect_count(0, start, lo, end + 1))
            need(guardw[i] == intersect_count(start, start + 41, lo, end + 1))
            lo = end + 1
        need(sum(guardw[5*scenario:5*scenario+5]) == 41)
    for i, w in enumerate(guardw):
        metadata[i].update({'conductor_height_nodes': w, 'residue_inputs': phi*w, 'primitive_outputs': prim*w})
        metadata[i].update({k: v*w for k, v in zip(opskeys, perheight)})
    axis_full = [x[0] for x in axes]
    suffix = [1] * (len(axes) + 1)
    for j in range(len(axes)-1, -1, -1):
        suffix[j] = suffix[j+1] * axis_full[j]
    need(suffix[0] == phi)
    before_full = before_kept = 1
    foundops = [0]*5
    for j, (n, q) in enumerate(axes):
        need((n, q) in nodes and (q == 0 or n % q == 0))
        multiplier = before_kept * suffix[j+1]
        accumulate(pending[n], (q, 2*before_full), oldw+guardw, multiplier)
        for k, v in enumerate(nodes[n, q][5]):
            foundops[k] += v * multiplier
        before_full *= n
        before_kept *= n if q == 0 else n - n//q
    need(foundops == perheight and before_kept == prim)
need(sum(len(x) for x in pending.values()) == 52560)
for i, m in enumerate(metadata):
    saved = gs['scenarios'][i//5]['added_by_band'][i%5]
    need(all(m[k] == saved[k] for k in ('conductor_height_nodes','residue_inputs','primitive_outputs')))
    need({k: m[k] for k in opskeys} == saved['operations'])
print('Independent saved-row and prefix checks complete.', flush=True)

tables = [{}, {}]
contexts = blue = 0

def put(table, category, phase, length, stage, numerator, denominator, coefficient, division, count, weights):
    if not count:
        return
    need(numerator > 0 and denominator > 0 and count > 0)
    ceilvalue = (numerator + denominator - 1)//denominator
    exponent = (ceilvalue - 1).bit_length()
    key = (category, phase, length, stage, exponent, coefficient, division)
    accumulate(table, key, weights, count)

def vec(table, counts, phase, n, a, weights):
    need(counts[4] == 0)
    for category, count in zip(('root','add','quarter','neg','scale'), counts):
        put(table, category, phase, n, 0, a, 1, int(category == 'root'), 0, count, weights)

def radix(table, size, anum, aden, phase, weights):
    levels = size.bit_length()-1
    need(size == 1 << levels and levels <= 18)
    for stage in range(1, levels+1):
        blocks = size >> stage
        quarter = blocks if stage > 1 else 0
        ordinary = size//2 - blocks - quarter
        for category, count, factor in [('root',ordinary,1<<stage),('quarter',quarter,1<<stage),('add',size,1<<(stage+1))]:
            put(table, category, phase, size, stage, anum*factor, aden, int(category=='root'), 0, count, weights)

for n in sorted({key[0] for key in nodes}, reverse=True):
    active = pending.pop(n, {})
    for (q, a), weights in active.items():
        contexts += 1
        need(contexts <= LIMIT)
        _, _, kind, children, local, total = nodes[n, q]
        for childn, childq, mult, factor in children:
            need(childn < n and mult >= 0 and factor >= 1)
            accumulate(pending[childn], (childq, a*factor), weights, mult)
        if kind == 'bluestein':
            blue += 1
            P = 1 << (2*n-2).bit_length()
            level = P.bit_length()-1
            # Sum stage classes symbolically; never enumerate butterflies.
            rad = [P*level//2 - 3*P//2 + 2, P*level, P//2-1, 0, 0]
            middle = [2*x for x in rad]
            middle[0] += P
            middle[4] += P
            allcounts = [mf['plan'][str(n)]['count'][k] for k in opskeys]
            need(all(x >= y and (x-y)%2 == 0 for x,y in zip(allcounts,middle)))
            pre = [(x-y)//2 for x,y in zip(allcounts,middle)]
            post = [x-y-z for x,y,z in zip(total,middle,pre)]
            need(min(post) >= 0 and post[1] == post[4] == 0)
            for normalized, table in enumerate(tables):
                vec(table, pre, 'blue_pre_chirp', n, 2*a, weights)
                radix(table, P, 2*a, 1, 'blue_forward', weights)
                put(table,'kernel','blue_point',n,0,(n+2)*a,1,0 if normalized else (2*n).bit_length(),0,P,weights)
                if normalized:
                    znum, zden = n*(2*n-1)+2*P, P
                    postfactor = 2*n
                else:
                    znum, zden = 2*n*(n+1)+2, 1
                    postfactor = 4*znum+4
                    put(table,'scale','blue_inverse_division',n,0,2*P*znum*a,1,0,level,P,weights)
                radix(table,P,znum*a,zden,'blue_inverse',weights)
                vec(table,post,'blue_post_chirp',n,postfactor*a,weights)
        elif kind == 'radix2':
            for table in tables: radix(table,n,a,1,'radix',weights)
        elif kind == 'pruned_two':
            for table in tables: put(table,'add','pruned_two',n,1,4*a,1,0,0,1,weights)
        elif kind == 'direct_prime':
            for table in tables: vec(table,total,'direct',n,2*n*a,weights)
        elif kind == 'ct':
            choice = mf['plan'][str(n)]['choice']
            m = n//2 if choice[0] == 'radix2' else choice[2]
            for table in tables: vec(table,local,'ct_bridge',n,2*m*a,weights)
        else:
            raise AssertionError(kind)
need(not pending and contexts == LIMIT and blue == 26064)

def saved_hist(data):
    result = {tuple(row[:-1]): row[-1] for row in data['events']}
    need(len(result) == len(data['events']))
    return result

for table, old in zip(tables, (orig,norm)):
    need({key: v[:20] for key,v in table.items()} == saved_hist(old))
need({key: v[20:] for key,v in tables[1].items() if any(v[20:])} == saved_hist(new))
print('Independent full original, normalized and guard histograms agree.', flush=True)

def collapse(table, start):
    widths = {}
    totals = [Counter() for _ in range(20)]
    for key, values in table.items():
        cat, phase, size, stage, de, ce, db = key
        w = values[start:start+20]
        if not any(w): continue
        accumulate(widths, (cat,de,ce,db), w, 1)
        for i,v in enumerate(w): totals[i][cat] += v
    return widths, totals

oldw, oldcounts = collapse(tables[1],0)
neww, newcounts = collapse(tables[1],20)
_, rawcounts = collapse(tables[0],20)
need([list(k)+[v] for k,v in sorted(oldw.items())] == pr['normalized_width_classes'])
need([list(k)+[v] for k,v in sorted(neww.items())] == receipt['guard_width_histogram'])
need([dict(x) for x in newcounts] == receipt['normalized_guard_band_counts'])
need([dict(x) for x in rawcounts] == receipt['original_guard_band_counts'])
need([dict(x) for x in metadata] == receipt['guard_metadata_by_band'])
for i in range(20):
    source = gs['scenarios'][i//5]['added_by_band'][i%5]
    t = rawcounts[i]
    need([t['root']+t['kernel'], t['add'], t['quarter'], t['neg'], t['scale']] == [source['operations'][k] for k in opskeys])
    need(t['root'] == source['root_products'] and t['kernel'] == source['kernel_products'])
    need(t['scale'] == t['kernel'] > 0)
    need(newcounts[i]['scale'] == 0)
    need(all(newcounts[i][k] == t[k] for k in ('root','kernel','add','quarter','neg')))

def add(bits): return 2*((bits+7)//8)+1
def mul(a,b):
    x,y = (a+7)//8,(b+7)//8
    return 5*x*y+2*min(x,y)+1

def cost(widths,p,three):
    bands = [Counter() for _ in range(20)]
    for (cat,de,ce,db), counts in widths.items():
        a,b = p+14+de,p+ce
        if cat in ('root','kernel'):
            if three:
                fees = [mul(a+1,b)+2*mul(a,b+1), add(a+1)+2*add(a+b+2), 4*add(a+b+4)]
            else:
                fees = [4*mul(a,b),2*add(a+b+1),4*add(a+b+3)]
            named = dict(zip([cat+'_product',cat+'_exact_add',cat+'_round_add'],fees))
        elif cat == 'add': named = {'add_complex_add':2*add(a+1)}
        else: named = {}
        for i,count in enumerate(counts):
            for key,fee in named.items(): bands[i][key] += count*fee
    return bands

def report(bands,scenario):
    band = bands[5*scenario:5*scenario+5]
    total = sum(band,Counter())
    products = sum(v for k,v in total.items() if k.endswith('_product'))
    return dict(parts=dict(total),bands=[dict(x) for x in band],product_core=products,addition_core=sum(total.values())-products,core=sum(total.values()))

main = []
for allocation in receipt['allocations']:
    p = allocation['p']
    need(p in (106,108,112))
    prior = next(x for x in pr['allocations'] if x['p'] == p)
    for mode in ('three','four'):
        before, extra = cost(oldw,p,mode=='three'),cost(neww,p,mode=='three')
        joined = [x+y for x,y in zip(before,extra)]
        target = allocation['profiles'][mode]
        for s in range(4):
            found = target['scenarios'][s]
            for label,bands in [('old',before),('guard',extra),('joined',joined)]:
                need(found[label] == report(bands,s))
            need(found['old'] == {k:prior['profiles'][mode]['scenarios'][s][k] for k in found['old']})
            need(found['guard_operation_counts'] == dict(sum(newcounts[5*s:5*s+5],Counter())))
        setup = target['setup_per_cache_lifetime']
        need(setup == prior['profiles'][mode]['setup_per_cache_lifetime'])
        entries = pr['setup_exponent_entry_histogram']
        need(sum(x['entries'] for x in entries) == 337702368)
        need(setup['scaled_cache_round_add_core'] == sum(x['entries']*4*add(p+x['exponent']+2) for x in entries))
        need(setup['scaled_cache_sum_add_core'] == (337702368*2*add(p+1) if mode=='three' else 0))
        need(target['extra_setup_due_to_guards'] == 0)
        main.append(dict(p=p,mode=mode,old=report(before,0)['core'],guard=report(extra,0)['core'],joined=report(joined,0)['core']))
need(receipt['unchanged_setup'] == mf['unchanged_setup'] == pr['unchanged_setup_operation_counts'])
need(receipt['precision_selected'] is False and receipt['production_adopted'] is False)
author_bytes = sum((AGENTS/'integration'/name).stat().st_size for name in ('normalized_transform_short_guard_events_20261111.json','normalized_transform_short_guard_join_20261111.json'))
result = dict(status='PASS',scope='Saved metadata only; exact independent DAG reconstruction and pricing; no values or kernel closure.',checks=checked,pins=pins,contexts=contexts,blue_contexts=blue,event_classes=[len(x) for x in tables],guard_event_classes=len(new['events']),width_classes=[len(oldw),len(neww)],all_original_histogram_equal=True,all_normalized_histogram_equal=True,all_guard_histogram_equal=True,all_twenty_band_prices_equal=True,main=main,author_new_json_bytes=author_bytes)
raw = (json.dumps(result,indent=2)+'\n').encode()
need(len(raw) <= 1024**2 and author_bytes+len(raw) < 64*1024**2)
with (HERE/'review_normalized_transform_short_guard_join_20261111.json').open('xb') as f:
    f.write(raw)
print(json.dumps(dict(checks=checked,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest().upper(),main=main)),flush=True)
