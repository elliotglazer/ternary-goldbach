"""Independent histogram fold only. No inventory generator or arithmetic values."""
from pathlib import Path
from collections import Counter,defaultdict
from fractions import Fraction as Q
import json,hashlib
ROOT=Path(__file__).resolve().parents[4];A=ROOT/'work/qrh-campaign/agents';P=ROOT/'work/qrh-blueprint'
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
authors={'LOCAL_TRANSFORM_WIDTH_COSTS_2026-11-11.md':'1A3DC2D8A7593ADD30DCBCE77FAAA3C93A902AC8FE2D98D73F3905DE4A13AF3B',
'local_transform_width_costs_20261111.py':'923F4FBE4AA2BF691CA1457C4A440E41E6C2E3B430E70F0DF9B3F4C0EB8F3A73',
'local_transform_width_costs_20261111.json':'5D4C79F0958F69577D250B35F7FF5C81B7C25E4AC755C8CB3517D699F2891DA1'}
for f,h in authors.items():ck(hashlib.sha256((P/f).read_bytes()).hexdigest().upper()==h)
author=json.loads((P/'local_transform_width_costs_20261111.json').read_text())
for f,h in author['pins'].items():ck(hashlib.sha256((A/f).read_bytes()).hexdigest().upper()==h)
def load(f):return json.loads((A/f).read_text())
ev=load('integration/transform_structural_events_20261111.json')
summary=load('integration/transform_structural_inventory_20261111.json')
base=load('integration/large_transform_pa_templates_20261111.json')
manifest=load('integration/transform_structural_manifest_20261111.json')
ck(ev['manifest_sha256'].upper()==author['pins']['integration/transform_structural_manifest_20261111.json'])
ck(summary['setup']==base['setup']==manifest['unchanged_setup'])
ck(manifest['extras']==[0,167,320,640])
ck(manifest['band_last_indices']==[6400,12800,25600,64000,128000])
ck(len(ev['events'])==138126==author['input_event_classes'])
width=defaultdict(lambda:[0]*20);phase=defaultdict(lambda:[0]*20)
count=[Counter() for _ in range(20)]
for row in ev['events']:
 ck(len(row)==8)
 cat,ph,n,stage,d,e,scale,w=row
 ck(cat in ('root','kernel','add','quarter','neg','scale') and isinstance(ph,str))
 ck(all(type(x)==int for x in (n,stage,d,e,scale)) and n>0 and 0<=d<=54)
 ck(len(w)==20 and all(type(x)==int and x>=0 for x in w))
 if cat=='root':ck(e==1 and scale==0)
 elif cat=='kernel':ck(e==(2*n).bit_length() and e<=18 and scale==0)
 elif cat=='scale':ck(e==0 and 1<=scale<=18)
 else:ck(e==0 and scale==0)
 for i,val in enumerate(w):
  width[(cat,d,e,scale)][i]+=val;phase[(cat,ph)][i]+=val;count[i][cat]+=val
ck(len(width)==400==author['width_classes'])
ck([[*k,w] for k,w in sorted(width.items())]==author['width_multiplicities'])
ck([[*k,w] for k,w in sorted(phase.items())]==author['phase_multiplicities'])
def byteprod(a,b):
 x=(a+7)//8;y=(b+7)//8
 return 5*x*y+2*min(x,y)+1
def byteadd(w):return 2*((w+7)//8)+1
def fees(cat,a,b,three):
 if cat in ('root','kernel'):
  pairs=[(a+1,b),(a,b+1),(a,b+1)] if three else [(a,b)]*4
  raw=a+b+(2 if three else 1)
  adds=([a+1] if three else [])+[raw,raw]
  return {cat+'_product':sum(byteprod(x,y) for x,y in pairs),cat+'_exact_add':sum(map(byteadd,adds)),cat+'_round_add':sum(byteadd(raw+2) for _ in range(4))},raw
 if cat=='add':return {'add_complex_add':byteadd(a+1)*2},a+1
 if cat=='scale':return {'scale_scale_round_add':byteadd(a+2)*4},a+2
 return {},a
results=[]
for allocation in author['allocations']:
 p=allocation['p'];ck(p in (112,134,152));old=next(x for x in base['candidate_allocations'] if x['p']==p)
 ck(allocation['intrinsic_allowance_bits']==old['L_arithmetic_budget_bits'])
 for mode in ('three','four'):
  three=mode=='three';bands=[Counter() for _ in range(20)];caps=[];bounds=defaultdict(list)
  for (cat,d,e,s),weights in sorted(width.items()):
   a=p+14+d;b=p+e if cat in ('root','kernel') else None
   values,raw=fees(cat,a,b,three);caps.append([cat,a,b,s,raw,weights]);bounds[cat].append(a)
   ck(a<=p+68 and (b is None or b<=p+18))
   if cat=='scale':ck(1<=s<=a)
   if b is not None:ck(1<=p<=raw)
   for i,w in enumerate(weights):
    bands[i].update({key:value*w for key,value in values.items()})
  claimed=allocation['profiles'][mode];ck(caps==claimed['capacity_rows'])
  for si,sc in enumerate(claimed['scenarios']):
   totals=Counter();ct=Counter()
   for bi in range(5):
    ck(dict(bands[5*si+bi])==sc['bands'][bi]);totals.update(bands[5*si+bi]);ct.update(count[5*si+bi])
   bs=old['scenarios'][si];ss=summary['scenarios'][si]
   ck(sc['extra_nodes']==bs['extra_nodes']==ss['extra_nodes']==[0,167,320,640][si])
   ck(ct['root']==ss['root_products']==bs['root_product_count'])
   ck(ct['kernel']==ct['scale']==ss['kernel_products']==bs['dyadic_scales'])
   for cat,key in [('add','complex_add_sub'),('quarter','quarter_turns'),('neg','negations'),('scale','dyadic_scales')]:ck(ct[cat]==ss['operations'][key])
   ck(ct['root']+ct['kernel']==bs['G'] and ct['add']==bs['A'])
   ck(ct['quarter']==bs['quarter_turns'] and ct['neg']==bs['negations'])
   local=sum(totals.values());ck(dict(totals)==sc['parts'] and local==sc['local_core'])
   padded=0
   for cat in ('root','kernel','add','scale'):
    bb=p+(1 if cat=='root' else 18) if cat in ('root','kernel') else None
    charge,_=fees(cat,p+68,bb,three);padded+=ct[cat]*sum(charge.values())
   ck(padded==sc['padded_core']==bs['padded_typed_transform_core'][mode])
   ck(0<local<=padded and padded-local==sc['core_difference'])
   ck(str(Q(local,padded))==sc['fraction_of_padded'])
   results.append(dict(p=p,model=mode,extra=sc['extra_nodes'],local=local,padded=padded,parts=dict(totals),category_counts=dict(ct)))
  if p==134:ck((min(bounds['root']),max(bounds['root']),min(bounds['kernel']),max(bounds['kernel']))==(150,201,153,167))
for p,lo,hi in [(112,1927,1928),(134,1784,1785),(152,1594,1595)]:
 r=next(x for x in results if x['p']==p and x['model']=='three' and x['extra']==0)
 saving=Q(r['padded']-r['local'],r['padded']);ck(Q(lo,10000)<saving<Q(hi,10000))
ck(next(x for x in results if x['p']==134 and x['model']=='three' and x['extra']==0)['local']==6305051715366094514)
for key in ['setup_changed','precision_selected','sign_success_claimed','ordinary_templates_implemented','complete_costs_priced']:ck(author[key] is False)
out=dict(status='PASS_CONDITIONAL_SAVED_HISTOGRAM_FOLD',checks=checks,author_pins=authors,input_pins=author['pins'],input_classes=len(ev['events']),width_classes=len(width),scenario_model_rows=results,unchanged_setup=summary['setup'],scope='No author execution or inventory regeneration; upstream structural-envelope review separate; no values/builds/ABI/timing claim')
path=Path(__file__).with_suffix('.json')
with path.open('x') as f:json.dump(out,f,indent=2)
print(json.dumps(dict(checks=checks,rows=len(results),receipt_sha256=hashlib.sha256(path.read_bytes()).hexdigest().upper())))
