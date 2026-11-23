"""Bounded fold of frozen normalized events; no circuit/value/conductor generation."""
from pathlib import Path
from collections import defaultdict, Counter
from fractions import Fraction
import hashlib, json
HERE=Path(__file__).resolve().parent; ROOT=HERE.parents[3]
BASE='work/qrh-campaign/agents/'
pins={
 BASE+'independent-feasibility/normalized_bluestein_events_20261111.json':'721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2',
 BASE+'independent-feasibility/normalized_bluestein_structural_costs_20261111.json':'F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3',
 BASE+'independent-feasibility/NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md':'F673EFE298538627F30DEAFD2C7F5AFF9606BA468D887A76677E14FF5C963B46',
 BASE+'major-constants/REVIEW_NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md':'49D7AA3C7D292C9A6018B178480BE8E0213C2A0725D6042D8EDC0A8C65F3B86C',
 BASE+'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md':'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
 BASE+'independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md':'412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7',
 BASE+'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md':'09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
 'work/qrh-blueprint/LOCAL_TRANSFORM_WIDTH_COSTS_2026-11-11.md':'1A3DC2D8A7593ADD30DCBCE77FAAA3C93A902AC8FE2D98D73F3905DE4A13AF3B'}
checks=0
def check(x):
 global checks
 assert x
 checks+=1
for rel,h in pins.items():
 p=ROOT/rel
 cap=24*1024**2 if rel.endswith('normalized_bluestein_events_20261111.json') else 90*1024
 check(p.stat().st_size<=cap)
 check(hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
events=json.loads((ROOT/(BASE+'independent-feasibility/normalized_bluestein_events_20261111.json')).read_bytes())
old=json.loads((ROOT/(BASE+'independent-feasibility/normalized_bluestein_structural_costs_20261111.json')).read_bytes())
check(events['schema']=='normalized-bluestein-event-histogram-1')
check(events['kernel_coefficient_exponent_zero_means_grid_p_norm_below_one'] is True)
check(len(events['events'])==old['new_event_classes']==125279)
widths=defaultdict(lambda:[0]*20); counts=[Counter() for _ in range(20)]
last=None
for row in events['events']:
 check(len(row)==8)
 cat,phase,n,j,de,ce,db,weights=row
 key=tuple(row[:-1]);check(last is None or last<key);last=key
 check(cat in ('root','kernel','add','quarter','neg'))
 check(all(type(v) is int for v in (n,j,de,ce,db)))
 check(0<=de<=54 and db==0)
 if cat=='root':check(ce==1)
 if cat=='kernel':check(ce==0)
 check(len(weights)==20)
 target=widths[cat,de,ce,db]
 for i,w in enumerate(weights):
  check(type(w) is int and w>=0)
  target[i]+=w;counts[i][cat]+=w
check(len(widths)==old['new_width_classes']==133)
for i in range(20):check(dict(counts[i])==old['new_band_counts'][i])

# Only saved cache lengths, no full-plan traversal or conductor reconstruction.
lengths=old['kernel_lengths'];check(len(lengths)==6004 and lengths==sorted(set(lengths)))
setuphist=Counter()
for n in lengths:
 check(type(n) is int and n>=2)
 P=1<<(2*n-2).bit_length()
 setuphist[(2*n).bit_length()]+=P
check(sum(setuphist.values())==old['setup_kernel_fft_unchanged']['kernel_entries']==337702368)

def A(bits):return 2*((bits+7)//8)+1
def M(a,b):
 m,n=sorted(((a+7)//8,(b+7)//8),reverse=True)
 return 5*m*n+2*n+1
def price(p,mode):
 bands=[Counter() for _ in range(20)];ranges=defaultdict(list)
 for (cat,de,ce,db),weights in sorted(widths.items()):
  a=p+14+de
  if cat in ('root','kernel'):
   b=p+ce;r=a+b+(2 if mode=='three' else 1)
   prod=M(a+1,b)+2*M(a,b+1) if mode=='three' else 4*M(a,b)
   fee={cat+'_product':prod,cat+'_exact_add':(A(a+1) if mode=='three' else 0)+2*A(r),cat+'_round_add':4*A(r+2)}
   ranges['data_magnitude_bits'].append(a);ranges['coefficient_magnitude_bits'].append(b)
   ranges['raw_magnitude_bits'].append(r);ranges['round_witness_magnitude_bits'].append(r+2)
  elif cat=='add':fee={'add_complex_add':2*A(a+1)}
  else:fee={}
  for i,w in enumerate(weights):
   for k,v in fee.items():bands[i][k]+=w*v
 return bands,{k:[min(v),max(v)] for k,v in ranges.items()}

alloc=[];oldmatches=0
for p in (112,134,106,108):
 scale=sum(P*4*A(p+e+2) for e,P in setuphist.items())
 unscaled_sum=sum(P*2*A(p+e+1) for e,P in setuphist.items())
 scaled_sum=sum(setuphist.values())*2*A(p+1)
 profiles={}
 for mode in ('three','four'):
  bands,ranges=price(p,mode);scenarios=[]
  for si,extra in enumerate((0,167,320,640)):
   subset=bands[5*si:5*si+5];parts=sum(subset,Counter())
   prod=sum(v for k,v in parts.items() if k.endswith('_product'))
   adds=sum(parts.values())-prod
   scenarios.append(dict(extra_nodes=extra,parts=dict(parts),bands=[dict(x) for x in subset],
    product_core=prod,addition_core=adds,core=prod+adds,
    operation_counts=dict(sum(counts[5*si:5*si+5],Counter()))))
   if p in (112,134):
    ref=next(a for a in old['allocations'] if a['p']==p)['profiles'][mode]['scenarios'][si]
    check(extra==ref['extra_nodes']);check(dict(parts)==ref['new_parts'])
    check([dict(x) for x in subset]==ref['new_bands']);check(prod+adds==ref['new_core']);oldmatches+=1
  setup=dict(scaled_cache_round_add_core=scale,scaled_cache_sum_add_core=scaled_sum if mode=='three' else 0,
    total_added_normalized_setup_add_core=scale+(scaled_sum if mode=='three' else 0),
    original_unscaled_sum_comparator_add_core=unscaled_sum if mode=='three' else 0)
  if p in (112,134):
   ref=next(a for a in old['allocations'] if a['p']==p)['profiles'][mode]
   check(scale==ref['new_scale_setup_add_core'])
   check(setup['scaled_cache_sum_add_core']==ref['new_kernel_sum_add_core'])
   check(setup['original_unscaled_sum_comparator_add_core']==ref['old_kernel_sum_add_core'])
  profiles[mode]=dict(scenarios=scenarios,width_ranges=ranges,setup_per_cache_lifetime=setup)
 alloc.append(dict(p=p,profiles=profiles))
check(oldmatches==16)
alloc.sort(key=lambda a:a['p']);by_p={a['p']:a for a in alloc}
comparisons=[]
for high,low in ((134,112),(134,108),(134,106),(112,108),(112,106),(108,106)):
 for mode in ('three','four'):
  hp=by_p[high]['profiles'][mode];lp=by_p[low]['profiles'][mode]
  for hs,ls in zip(hp['scenarios'],lp['scenarios']):
   check(hs['extra_nodes']==ls['extra_nodes'])
   check(hs['operation_counts']==ls['operation_counts'])
   dp=hs['product_core']-ls['product_core'];da=hs['addition_core']-ls['addition_core']
   check(dp>=0 and da>=0)
   comparisons.append(dict(high_p=high,low_p=low,mode=mode,extra_nodes=hs['extra_nodes'],
    runtime_product_core_reserve=dp,runtime_addition_core_reserve=da,
    low_to_high_core_ratio=str(Fraction(ls['core'],hs['core'])),
    setup_add_core_reserve_equal_one_lifetime=hp['setup_per_cache_lifetime']['total_added_normalized_setup_add_core']-lp['setup_per_cache_lifetime']['total_added_normalized_setup_add_core']))
out=dict(scope='Conditional unchanged normalized circuit, original byte arithmetic templates only; no precision or production selection.',
 pins=pins,preflight=dict(event_cap_bytes=24*1024**2,cost_receipt_cap_bytes=90*1024,output_cap_bytes=256*1024,
  event_classes=125279,width_classes=133,weights=20,saved_kernel_lengths=6004),
 checks_before_serialization=checks,old_matched_scenarios=oldmatches,
 normalized_width_classes=[list(k)+[v] for k,v in sorted(widths.items())],
 setup_exponent_entry_histogram=[dict(exponent=k,entries=v) for k,v in sorted(setuphist.items())],
 unchanged_setup_operation_counts=old['setup_kernel_fft_unchanged'],allocations=alloc,comparisons=comparisons,
 remaining_costs=['kernel FFT/root/chirp certificates at each precision','signed/range/shift/encoding and source binding',
 'precision-specific cache lifetimes/rebuilds/imports and new scaled-center sums','quarter-turn/negation/permutation proofs',
 'generation and ordinary proof checking with actual numeral/theorem caches','all nontransform work and full analytic foundations'],
 numerical_evidence=False,precision_selected=False,new_circuit_inventory=False)
raw=(json.dumps(out,separators=(',',':'))+'\n').encode();check(len(raw)<=256*1024)
with (HERE/'normalized_transform_precision_costs_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=checks,bytes=len(raw),setup_classes=len(setuphist),
 main=[dict(p=a['p'],**{m:a['profiles'][m]['scenarios'][0]['core'] for m in ('three','four')},
  setup_three=a['profiles']['three']['setup_per_cache_lifetime']['total_added_normalized_setup_add_core']) for a in alloc])))
