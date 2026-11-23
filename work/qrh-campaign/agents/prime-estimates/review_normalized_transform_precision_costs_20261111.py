"""Independent bounded replay of frozen cost metadata; no author imports or values."""
from pathlib import Path
from collections import defaultdict, Counter
from fractions import Fraction
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
B='work/qrh-campaign/agents/'
pins={
 B+'moebius/NORMALIZED_TRANSFORM_LOWER_PRECISION_COSTS_2026-11-11.md':'803DFBF53D07EF2FDBE0389561EF1B56631EC06B83FA56025DD9CDC020CA0243',
 B+'moebius/normalized_transform_precision_costs_20261111.py':'81983D037823346DA54553F7DF467A9139983C71DE6568DF9040BDA5677215C0',
 B+'moebius/normalized_transform_precision_costs_20261111.json':'C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4',
 B+'independent-feasibility/normalized_bluestein_events_20261111.json':'721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2',
 B+'independent-feasibility/normalized_bluestein_structural_costs_20261111.json':'F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3',
 'work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md':'EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39'}
checks=0
def require(ok):
 global checks
 assert ok
 checks+=1
def read(rel,cap):
 p=ROOT/rel;require(p.stat().st_size<=cap)
 raw=p.read_bytes();require(hashlib.sha256(raw).hexdigest().upper()==pins[rel]);return raw
for rel in list(pins):
 if not rel.endswith('.json'):read(rel,128*1024)
new=json.loads(read(B+'moebius/normalized_transform_precision_costs_20261111.json',256*1024))
old=json.loads(read(B+'independent-feasibility/normalized_bluestein_structural_costs_20261111.json',90*1024))
ev=json.loads(read(B+'independent-feasibility/normalized_bluestein_events_20261111.json',24*1024**2))
for rel,h in new['pins'].items():
 if rel in pins:require(pins[rel]==h)
 else:
  pins[rel]=h;read(rel,128*1024)
require(ev['schema']=='normalized-bluestein-event-histogram-1')
require(ev['kernel_coefficient_exponent_zero_means_grid_p_norm_below_one'] is True)
require(len(ev['events'])==125279)
classes={};seen=set();last=None
categories=[Counter() for i in range(20)]
for event in ev['events']:
 require(len(event)==8)
 cat,phase,n,j,de,ce,db,weights=event
 key=tuple(event[:7]);require(key not in seen);seen.add(key)
 require(last is None or last<key);last=key
 require(cat in {'root','kernel','add','neg','quarter'})
 require(all(type(x)is int for x in (n,j,de,ce,db)))
 require(0<=de<=54 and db==0)
 if cat in ('root','kernel'):require(ce==int(cat=='root'))
 require(len(weights)==20)
 widthkey=(cat,de,ce,db)
 dest=classes.setdefault(widthkey,[0]*20)
 for i,w in enumerate(weights):
  require(type(w)is int and w>=0)
  dest[i]+=w;categories[i][cat]+=w
require(len(classes)==133)
require([list(k)+[classes[k]] for k in sorted(classes)]==new['normalized_width_classes'])
require([dict(x) for x in categories]==old['new_band_counts'])
lengths=old['kernel_lengths'];require(len(lengths)==6004 and len(set(lengths))==6004)
setup=Counter()
for n in lengths:
 require(type(n)is int and n>=2)
 pad=1
 while pad<2*n-1:pad*=2
 e=0
 while (1<<e)<2*n+1:e+=1
 setup[e]+=pad
require(len(setup)==14 and sum(setup.values())==337702368)
require([{'exponent':e,'entries':setup[e]} for e in sorted(setup)]==new['setup_exponent_entry_histogram'])
require(new['unchanged_setup_operation_counts']==old['setup_kernel_fft_unchanged'])

def digits(bits):return (bits-1)//8+1
def add(bits):return 2*digits(bits)+1
def product(x,y):
 dx,dy=digits(x),digits(y)
 return 5*dx*dy+2*min(dx,dy)+1

def charge(p,mode,key):
 cat,e,f,unused=key;a=p+14+e
 if cat=='add':return {'add_complex_add':2*add(a+1)},None
 if cat in ('neg','quarter'):return {},None
 b=p+f
 if mode=='four':
  r=a+b+1;pr=4*product(a,b);ad=2*add(r)
 else:
  r=a+b+2;pr=product(a+1,b)+product(a,b+1)+product(a,b+1);ad=add(a+1)+2*add(r)
 return {cat+'_product':pr,cat+'_exact_add':ad,cat+'_round_add':4*add(r+2)},(a,b,r,r+2)

reconstructed={};summary=[];oldmatches=0
for p in (112,134,106,108):
 scale=sum(c*4*add(p+e+2) for e,c in setup.items())
 originalsum=sum(c*2*add(p+e+1) for e,c in setup.items())
 scaled=sum(setup.values())*2*add(p+1)
 for mode in ('four','three'):
  rows=[Counter() for i in range(20)];rangecols=[[] for i in range(4)]
  for key,weights in classes.items():
   fees,ranges=charge(p,mode,key)
   if ranges:
    for col,v in zip(rangecols,ranges):col.append(v)
   for label,fee in fees.items():
    for i,w in enumerate(weights):rows[i][label]+=w*fee
  actual=next(a for a in new['allocations'] if a['p']==p)['profiles'][mode]
  range_names=['data_magnitude_bits','coefficient_magnitude_bits','raw_magnitude_bits','round_witness_magnitude_bits']
  require(actual['width_ranges']==dict(zip(range_names,([min(v),max(v)] for v in rangecols))))
  ss={'scaled_cache_round_add_core':scale,'scaled_cache_sum_add_core':scaled if mode=='three' else 0,'total_added_normalized_setup_add_core':scale+(scaled if mode=='three' else 0),'original_unscaled_sum_comparator_add_core':originalsum if mode=='three' else 0}
  require(actual['setup_per_cache_lifetime']==ss)
  if p in (112,134):
   earlier=next(a for a in old['allocations'] if a['p']==p)['profiles'][mode]
   require(scale==earlier['new_scale_setup_add_core'])
   require(ss['scaled_cache_sum_add_core']==earlier['new_kernel_sum_add_core'])
   require(ss['original_unscaled_sum_comparator_add_core']==earlier['old_kernel_sum_add_core'])
  for si,extra in enumerate((0,167,320,640)):
   block=rows[si*5:si*5+5];parts=Counter()
   for row in block:parts.update(row)
   products=sum(v for name,v in parts.items() if name.endswith('_product'))
   additions=sum(parts.values())-products
   counts=Counter()
   for c in categories[si*5:si*5+5]:counts.update(c)
   expected={'extra_nodes':extra,'parts':dict(parts),'bands':[dict(x) for x in block],'product_core':products,'addition_core':additions,'core':products+additions,'operation_counts':dict(counts)}
   require(expected==actual['scenarios'][si])
   if p in (112,134):
    o=earlier['scenarios'][si]
    require(o['new_parts']==dict(parts));require(o['new_bands']==[dict(x) for x in block]);require(o['new_core']==products+additions);oldmatches+=1
   reconstructed[p,mode,extra]=(products,additions,ss['total_added_normalized_setup_add_core'])
   summary.append({'p':p,'mode':mode,'extra':extra,'products':products,'adds':additions,'setup':ss['total_added_normalized_setup_add_core']})
require(oldmatches==16)
require(len(new['comparisons'])==48)
for row in new['comparisons']:
 hp,ha,hs=reconstructed[row['high_p'],row['mode'],row['extra_nodes']]
 lp,la,ls=reconstructed[row['low_p'],row['mode'],row['extra_nodes']]
 require(row['runtime_product_core_reserve']==hp-lp>=0)
 require(row['runtime_addition_core_reserve']==ha-la>=0)
 require(row['setup_add_core_reserve_equal_one_lifetime']==hs-ls)
 require(Fraction(row['low_to_high_core_ratio'])==Fraction(lp+la,hp+ha))
a=reconstructed[112,'three',0];b=reconstructed[108,'three',0]
require(a[0]-b[0]==366515505176327696)
require(a[1]-b[1]==17226756893506508)
require(a[2]-b[2]==3893386112 and b[2]==64162618688)
result={'scope':'Independent bounded frozen-metadata verification; no values or author execution','pins':pins,'checks':checks,'event_rows':len(ev['events']),'width_classes':len(classes),'kernel_lengths':len(lengths),'kernel_classes':len(setup),'matched_old_scenarios':oldmatches,'all_cases':summary,'cold_p112_to_p108':{'product_reserve':a[0]-b[0],'addition_reserve':a[1]-b[1],'setup_reserve':a[2]-b[2]},'sunk_p112_new_p108_setup':b[2],'precision_eligibility_proved_here':False}
out=(json.dumps(result,sort_keys=True,separators=(',',':'))+'\n').encode()
assert len(out)<64*1024
with (HERE/'review_normalized_transform_precision_costs_20261111.json').open('xb') as f:f.write(out)
print(json.dumps({'checks':checks,'output_bytes':len(out),'old_cases':oldmatches,'cost_cases':len(summary)}))
