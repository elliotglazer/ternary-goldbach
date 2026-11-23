"""Exact symbolic identities and saved width-class fold. No numerical gates."""
from pathlib import Path
from collections import Counter,defaultdict
from fractions import Fraction
import hashlib,json
HERE=Path(__file__).resolve().parent; ROOT=HERE.parents[3];BASE='work/qrh-campaign/agents/'
pins={
 BASE+'independent-feasibility/normalized_bluestein_events_20261111.json':'721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2',
 BASE+'independent-feasibility/normalized_bluestein_structural_costs_20261111.json':'F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3',
 BASE+'moebius/normalized_transform_precision_costs_20261111.json':'C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4',
 BASE+'moebius/NORMALIZED_TRANSFORM_LOWER_PRECISION_COSTS_2026-11-11.md':'803DFBF53D07EF2FDBE0389561EF1B56631EC06B83FA56025DD9CDC020CA0243'}
checks=0
def ck(x):
 global checks
 assert x;checks+=1
data={}
for rel,pin in pins.items():
 path=ROOT/rel; cap=24*1024**2 if 'events_' in rel else 128*1024
 ck(path.stat().st_size<=cap)
 raw=path.read_bytes();ck(hashlib.sha256(raw).hexdigest().upper()==pin)
 if rel.endswith('.json'):data[path.name]=json.loads(raw)
events=data['normalized_bluestein_events_20261111.json'];old=data['normalized_bluestein_structural_costs_20261111.json'];baseline=data['normalized_transform_precision_costs_20261111.json']

# Formal four-variable polynomial identities, never values.
def polyvar(i):return {tuple(int(j==i) for j in range(4)):1}
def plus(x,y,sign=1):
 z=dict(x)
 for k,v in y.items():z[k]=z.get(k,0)+sign*v
 return {k:v for k,v in z.items() if v}
def times(x,y):
 z=Counter()
 for a,u in x.items():
  for b,v in y.items():z[tuple(i+j for i,j in zip(a,b))]+=u*v
 return {k:v for k,v in z.items() if v}
a,b,c,d=map(polyvar,range(4));ac=times(a,c);bd=times(b,d)
t=times(c,plus(a,b));u=times(b,plus(c,d));v=times(a,plus(d,c,-1));g=times(plus(a,b),plus(c,d))
real=plus(ac,bd,-1);imag=plus(times(a,d),times(b,c))
ck(plus(t,u,-1)==real);ck(plus(t,v)==imag)
ck(plus(plus(g,ac,-1),bd,-1)==imag)

widths=defaultdict(lambda:[0]*20);counts=[Counter() for _ in range(20)]
ck(len(events['events'])==125279);last=None
for row in events['events']:
 ck(len(row)==8);key=tuple(row[:-1]);ck(last is None or last<key);last=key
 cat,phase,n,stage,de,ce,db,ws=row
 ck(cat in ('root','kernel','add','quarter','neg') and db==0)
 ck(0<=de<=54 and len(ws)==20)
 if cat=='root':ck(ce==1)
 if cat=='kernel':ck(ce==0)
 for i,w in enumerate(ws):
  ck(type(w) is int and w>=0);widths[cat,de,ce,db][i]+=w;counts[i][cat]+=w
ck(len(widths)==133)
ck([dict(x) for x in counts]==old['new_band_counts'])
ck([list(k)+[v] for k,v in sorted(widths.items())]==baseline['normalized_width_classes'])

def A(b):return 2*((b+7)//8)+1
def M(a,b):
 m,n=sorted(((a+7)//8,(b+7)//8),reverse=True)
 return 5*m*n+2*n+1
modes=['fixed','gauss_inline','gauss_cached','four']
def fees(a,b):
 f=[M(a+1,b)+2*M(a,b+1),A(a+1)+2*A(a+b+2),4*A(a+b+4)]
 g=[2*M(a,b)+M(a+1,b+1),A(a+1)+A(b+1)+A(a+b+1)+2*A(a+b+3),2*A(a+b+3)+2*A(a+b+5)]
 gc=[g[0],g[1]-A(b+1),g[2]]
 q=[4*M(a,b),2*A(a+b+1),4*A(a+b+3)]
 return dict(zip(modes,[f,g,gc,q]))
classrows=[];allocations=[];matched=0
policies={'no_sum_cache':['four','gauss_inline'],'full_fixed_sum_cache_available':['four','gauss_cached','fixed']}
for p in (106,108,112,134):
 bands={m:[Counter() for _ in range(20)] for m in modes+list(policies)}
 choices={x:[Counter() for _ in range(20)] for x in policies}
 selections={x:Counter() for x in policies}
 for key,ws in sorted(widths.items()):
  cat,de,ce,db=key;ab=p+14+de
  if cat in ('root','kernel'):
   cost=fees(ab,p+ce)
   chosen={pol:min(opts,key=lambda m:sum(cost[m])) for pol,opts in policies.items()}
   for pol,mode in chosen.items():selections[pol][mode]+=1
   classrows.append(dict(p=p,key=list(key),capacities=[ab,p+ce],
    fees=[cost[m] for m in modes],chosen=chosen))
   for mode in bands:
    actual=chosen.get(mode,mode)
    for i,w in enumerate(ws):
     for part,vv in zip(('product','exact_add','round_add'),cost[actual]):bands[mode][i][cat+'_'+part]+=w*vv
     if mode in policies:choices[mode][i][cat+'_'+actual]+=w
  elif cat=='add':
   for mode in bands:
    for i,w in enumerate(ws):bands[mode][i]['add_complex_add']+=w*2*A(ab+1)
 out={}
 for mode,bb in bands.items():
  scenarios=[]
  for si,extra in enumerate((0,167,320,640)):
   sub=bb[si*5:si*5+5];parts=sum(sub,Counter());prod=sum(v for k,v in parts.items() if k.endswith('_product'));total=sum(parts.values())
   entry=dict(extra_nodes=extra,parts=dict(parts),bands=[dict(x) for x in sub],product_core=prod,addition_core=total-prod,core=total)
   if mode in policies:entry['chosen_operation_counts']=dict(sum(choices[mode][si*5:si*5+5],Counter()))
   scenarios.append(entry)
   if mode in ('fixed','four'):
    ref=next(a for a in baseline['allocations'] if a['p']==p)['profiles']['three' if mode=='fixed' else 'four']['scenarios'][si]
    ck(dict(parts)==ref['parts']);ck([dict(x) for x in sub]==ref['bands']);ck(total==ref['core']);matched+=1
  out[mode]=dict(scenarios=scenarios)
 for pol in policies:out[pol]['selected_product_width_classes']=dict(selections[pol])
 allocations.append(dict(p=p,profiles=out))
ck(matched==32)

# Saved full kernel-cache superset only; root/chirp union is not reconstructed.
lengths=old['kernel_lengths'];ck(len(lengths)==6004 and lengths==sorted(set(lengths)))
entries=sum(1<<(2*n-2).bit_length() for n in lengths);ck(entries==337702368)
setup=[]
for p in (106,108,112,134):
 one=entries*A(p+1);ref=next(a for a in baseline['allocations'] if a['p']==p)['profiles']['three']['setup_per_cache_lifetime']
 ck(2*one==ref['scaled_cache_sum_add_core'])
 setup.append(dict(p=p,full_scaled_kernel_entries=entries,one_exact_kernel_sum_add_core=one,
  two_exact_kernel_sum_add_core=2*one,common_scaled_kernel_round_add_core=ref['scaled_cache_round_add_core'],
  root_chirp_one_sum_per_entry=A(p+2),root_chirp_two_sum_per_entry=2*A(p+2)))
comparisons=[]
for alloc in allocations:
 for si,extra in enumerate((0,167,320,640)):
  fixed=alloc['profiles']['fixed']['scenarios'][si]
  for name in modes[1:]+list(policies):
   other=alloc['profiles'][name]['scenarios'][si]
   comparisons.append(dict(p=alloc['p'],extra_nodes=extra,candidate=name,
    fixed_minus_candidate_product=fixed['product_core']-other['product_core'],
    fixed_minus_candidate_addition=fixed['addition_core']-other['addition_core'],
    candidate_over_fixed_core=str(Fraction(other['core'],fixed['core']))))
out=dict(scope='Same exact stored complex product and same final rounding; conditional saved byte-template pricing, no values or selected method.',
 pins=pins,checks_before_serialization=checks,matched_baseline_scenarios=matched,
 price_modes=modes,price_component_order=['product','exact_add','round_add'],class_prices=classrows,
 policy_tie_order=policies,allocations=allocations,setup=setup,comparisons=comparisons,
 operation_counts_by_band=[dict(x) for x in counts],unchanged_setup_counts=old['setup_kernel_fft_unchanged'],
 cache_union='Need c+d for coefficients used by fixed or cached Gauss, d-c for fixed. Root/chirp exact union unknown. Retaining the full fixed cache is a valid same-lifetime superset.',
 omitted=['signed/canonical/range witnesses','class choice and coefficient/cache bindings','actual proof generation/checking and symbol/numeral representation','cache lifetimes and root/chirp sums','all unaffected setup/nontransform/analytic foundation work'])
raw=(json.dumps(out,separators=(',',':'))+'\n').encode();ck(len(raw)<=256*1024)
with (HERE/'normalized_complex_gate_choices_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=checks,bytes=len(raw),main=[dict(p=a['p'],**{m:a['profiles'][m]['scenarios'][0]['core'] for m in a['profiles']}) for a in allocations])))
