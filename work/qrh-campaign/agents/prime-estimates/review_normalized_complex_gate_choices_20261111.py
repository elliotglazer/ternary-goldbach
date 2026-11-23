"""Independent finite class-price replay; no author import, values or inventory."""
from pathlib import Path
from collections import Counter
from fractions import Fraction
import hashlib,json
HERE=Path(__file__).resolve().parent; ROOT=HERE.parents[3]
B='work/qrh-campaign/agents/'
pins={
 B+'moebius/NORMALIZED_COMPLEX_GATE_CHOICE_FRONTIER_2026-11-11.md':'441F746D96F84276E375A3DC46971EB0F3E956EB0442DAECD3E52417557B9789',
 B+'moebius/normalized_complex_gate_choices_20261111.py':'9D54D235C8D1BBD8D8B9AAD4B16A3A4C1D041BB4A31E3385ED0F910A6BC35A95',
 B+'moebius/normalized_complex_gate_choices_20261111.json':'7D0983C2133F014CE367E60D5F8B6E0827A62CCBC0ECA1605725E2BB711AB1AF',
 B+'moebius/normalized_transform_precision_costs_20261111.json':'C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4',
 B+'independent-feasibility/normalized_bluestein_structural_costs_20261111.json':'F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3',
 B+'prime-estimates/REVIEW_NORMALIZED_TRANSFORM_LOWER_PRECISION_COSTS_2026-11-11.md':'B2C3D637D9983156620A6940B2C32B65146FAED681DEB2CB36F7D3A2C4D7F4E8',
 B+'prime-estimates/EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md':'86D8A9435A9962CFF95194642E590D65C76B334E5AD24377959006E7AB17BEFF',
 B+'prime-estimates/ERRATUM_COMPLEX_ADD_WIDTHS_2026-11-11.md':'AD8DC7692F68A44BF0D10BB6E348DD0D8A3368FF76FC5A94BBF07BFD76030362',
 B+'audit/REVIEW_EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md':'27FADB7F3BD0B49D6A29B1183F04BCAB507FAC2F5C173B3ED8EA230C413424B7',
 B+'zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md':'087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D'}
checks=0
raws={}
def ck(x):
 global checks
 assert x;checks+=1
def load(rel,h,cap):
 p=ROOT/rel;ck(p.stat().st_size<=cap)
 raw=p.read_bytes();ck(hashlib.sha256(raw).hexdigest().upper()==h);return raw
for path,h in pins.items():raws[path]=load(path,h,256*1024)
actual=json.loads(raws[B+'moebius/normalized_complex_gate_choices_20261111.json'])
baseline=json.loads(raws[B+'moebius/normalized_transform_precision_costs_20261111.json'])
old=json.loads(raws[B+'independent-feasibility/normalized_bluestein_structural_costs_20261111.json'])
for path,h in actual['pins'].items():
 if path in pins:ck(pins[path]==h)
 else:
  pins[path]=h
  load(path,h,24*1024**2 if 'events_' in path else 128*1024)
classes=baseline['normalized_width_classes'];ck(len(classes)==133)
ck(len(actual['class_prices'])==196)
ck(actual['price_modes']==['fixed','gauss_inline','gauss_cached','four'])
ck(actual['price_component_order']==['product','exact_add','round_add'])
policies={'no_sum_cache':['four','gauss_inline'],'full_fixed_sum_cache_available':['four','gauss_cached','fixed']}
ck(actual['policy_tie_order']==policies)

def length(x):return (x-1)//8+1
def ad(x):return 2*length(x)+1
def mul(x,y):
 nx,ny=length(x),length(y)
 return 5*nx*ny+2*min(nx,ny)+1

def costs(a,b):
 # Explicit per-product dimensions and per-addition widths, not author helpers.
 dimensions={'fixed':[(a+1,b),(a,b+1),(a,b+1)],'four':[(a,b)]*4,
  'gauss_cached':[(a,b),(a,b),(a+1,b+1)],'gauss_inline':[(a,b),(a,b),(a+1,b+1)]}
 additions={'fixed':[a+1,a+b+2,a+b+2],'four':[a+b+1,a+b+1],
  'gauss_cached':[a+1,a+b+1,a+b+3,a+b+3],
  'gauss_inline':[a+1,b+1,a+b+1,a+b+3,a+b+3]}
 witnesses={'fixed':[a+b+4]*4,'four':[a+b+3]*4,
  'gauss_cached':[a+b+3]*2+[a+b+5]*2,'gauss_inline':[a+b+3]*2+[a+b+5]*2}
 return {m:[sum(mul(*xy) for xy in dimensions[m]),sum(ad(t) for t in additions[m]),sum(ad(t) for t in witnesses[m])] for m in dimensions}

# Exact algebra checked on formal bilinear coefficients ac,ad,bc,bd.
# fixed real c(a+b)-b(c+d), fixed imag c(a+b)+a(d-c)
ck(tuple(x-y for x,y in zip((1,0,1,0),(0,0,1,1)))==(1,0,0,-1))
ck(tuple(x+y for x,y in zip((1,0,1,0),(-1,1,0,0)))==(0,1,1,0))
ck(tuple(x-y-z for x,y,z in zip((1,1,1,1),(1,0,0,0),(0,0,0,1)))==(0,1,1,0))

allmodes=actual['price_modes']+list(policies)
reconstructed={};summary=[];baseline_matches=0;classpriceindex={(r['p'],tuple(r['key'])):r for r in actual['class_prices']}
categorytotals=[Counter() for i in range(20)]
for cat,de,ce,db,ws in classes:
 ck(len(ws)==20 and all(type(v)is int and v>=0 for v in ws))
 for i,w in enumerate(ws):categorytotals[i][cat]+=w
ck([dict(c) for c in categorytotals]==actual['operation_counts_by_band'])
for p in (106,108,112,134):
 band={m:[Counter() for i in range(20)] for m in allmodes}
 choicecounts={pol:[Counter() for i in range(20)] for pol in policies}
 classcounts={pol:Counter() for pol in policies}
 for cat,de,ce,db,weights in classes:
  a=p+14+de
  if cat in ('quarter','neg'):continue
  if cat=='add':
   for m in allmodes:
    for i,w in enumerate(weights):band[m][i]['add_complex_add']+=w*2*ad(a+1)
   continue
  ck(cat in ('root','kernel') and db==0)
  b=p+ce;fees=costs(a,b)
  chosen={pol:min(choices,key=lambda m:sum(fees[m])) for pol,choices in policies.items()}
  saved=classpriceindex[p,(cat,de,ce,db)]
  ck(saved['capacities']==[a,b]);ck(saved['fees']==[fees[m] for m in actual['price_modes']]);ck(saved['chosen']==chosen)
  if p in (106,108):ck(fees['fixed'][0]==fees['gauss_cached'][0])
  for pol,m in chosen.items():classcounts[pol][m]+=1
  for mode in allmodes:
   selected=chosen.get(mode,mode)
   for label,fee in zip(('product','exact_add','round_add'),fees[selected]):
    for i,w in enumerate(weights):band[mode][i][cat+'_'+label]+=w*fee
   if mode in policies:
    for i,w in enumerate(weights):choicecounts[mode][i][cat+'_'+selected]+=w
  # Inline Gauss adds exactly one coefficient presum to cached Gauss.
  ck(fees['gauss_inline'][1]-fees['gauss_cached'][1]==ad(b+1))
 savedalloc=next(x for x in actual['allocations'] if x['p']==p)
 for m in allmodes:
  if m in policies:ck(savedalloc['profiles'][m]['selected_product_width_classes']==dict(classcounts[m]))
  for si,extra in enumerate((0,167,320,640)):
   bandpart=band[m][5*si:5*si+5];parts=Counter()
   for row in bandpart:parts.update(row)
   products=sum(v for k,v in parts.items() if k.endswith('_product'));total=sum(parts.values())
   record={'extra_nodes':extra,'parts':dict(parts),'bands':[dict(x) for x in bandpart],'product_core':products,'addition_core':total-products,'core':total}
   if m in policies:
    chosen=Counter()
    for row in choicecounts[m][5*si:5*si+5]:chosen.update(row)
    record['chosen_operation_counts']=dict(chosen)
   ck(record==savedalloc['profiles'][m]['scenarios'][si])
   reconstructed[p,m,extra]=record
   summary.append({'p':p,'mode':m,'extra':extra,'products':products,'adds':total-products,'core':total})
   if m in ('fixed','four'):
    base=next(x for x in baseline['allocations'] if x['p']==p)['profiles']['three' if m=='fixed' else 'four']['scenarios'][si]
    ck(record['parts']==base['parts']);ck(record['bands']==base['bands']);ck(total==base['core']);baseline_matches+=1
ck(baseline_matches==32)
ck(len(actual['comparisons'])==80)
for row in actual['comparisons']:
 p,extra,m=row['p'],row['extra_nodes'],row['candidate'];f=reconstructed[p,'fixed',extra];c=reconstructed[p,m,extra]
 ck(row['fixed_minus_candidate_product']==f['product_core']-c['product_core'])
 ck(row['fixed_minus_candidate_addition']==f['addition_core']-c['addition_core'])
 ck(Fraction(row['candidate_over_fixed_core'])==Fraction(c['core'],f['core']))
entries=0
ck(len(old['kernel_lengths'])==6004)
for n in old['kernel_lengths']:
 pad=1
 while pad<2*n-1:pad*=2
 entries+=pad
ck(entries==337702368)
for row in actual['setup']:
 p=row['p'];one=entries*ad(p+1);scale=next(x for x in baseline['allocations'] if x['p']==p)['profiles']['three']['setup_per_cache_lifetime']['scaled_cache_round_add_core']
 ck(row=={'p':p,'full_scaled_kernel_entries':entries,'one_exact_kernel_sum_add_core':one,'two_exact_kernel_sum_add_core':2*one,'common_scaled_kernel_round_add_core':scale,'root_chirp_one_sum_per_entry':ad(p+2),'root_chirp_two_sum_per_entry':2*ad(p+2)})
ck(actual['unchanged_setup_counts']==old['setup_kernel_fft_unchanged'])
f=reconstructed[112,'fixed',0];g=reconstructed[112,'full_fixed_sum_cache_available',0]
ck(f['product_core']-g['product_core']==8039890902776512)
ck(g['addition_core']-f['addition_core']==5788010916952704)
ck(f['core']-g['core']==2251879985823808)
ck(entries*ad(113)==10468773408)
for p in (106,108,134):
 for extra in (0,167,320,640):ck(reconstructed[p,'fixed',extra]['core']==reconstructed[p,'full_fixed_sum_cache_available',extra]['core'])
result={'scope':'Independent approved saved-width metadata replay and formal bilinear identities only','pins':pins,'checks':checks,'width_classes':133,'product_classes_per_precision':49,'class_price_rows':196,'baseline_matches':baseline_matches,'mode_policy_scenarios':len(summary),'comparison_rows':80,'kernel_entries':entries,'results':summary,'claimed_runtime_or_production_selection':False}
raw=(json.dumps(result,sort_keys=True,separators=(',',':'))+'\n').encode();assert len(raw)<=64*1024
with (HERE/'review_normalized_complex_gate_choices_20261111.json').open('xb') as out:out.write(raw)
print(json.dumps({'checks':checks,'bytes':len(raw),'baseline_matches':baseline_matches,'cases':len(summary)}))
