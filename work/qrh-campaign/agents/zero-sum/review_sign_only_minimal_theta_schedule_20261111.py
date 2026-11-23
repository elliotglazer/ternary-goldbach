"""Independent saved-ledger join and rational row contracts; no evaluators."""
from pathlib import Path
from fractions import Fraction as F
from collections import Counter
import json,hashlib
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
A=HERE.parent
P=A/'prime-estimates'
pins={
'SIGN_ONLY_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md':'C1D2C360A296C961BD2FA46576521FEDB1AFE01527610DF1D21CC145E5565918',
'build_sign_only_minimal_theta_schedule_20261111.py':'88225615982B611EBFED86E00EC98CA6A1DEB07AFCCB40CDFC8B9FCE9A7F24B5',
'sign_only_minimal_theta_nonprincipal_schedule_20261111.json':'E767EC3B3E14F2A243837DA85C811DE5ED67CE701BDD08998C2329F9C687C24D'}
checks=0
def ck(v):
 global checks
 checks+=1
 assert v,checks
def load(p): return json.loads(p.read_text())
def ceil(x):return (x.numerator+x.denominator-1)//x.denominator
def bits(x):
 b=max(0,(x.denominator//x.numerator).bit_length()-1)
 while x.numerator*2**b<x.denominator:b+=1
 return b
for p,h in pins.items():ck(hashlib.sha256((P/p).read_bytes()).hexdigest().upper()==h)
new=load(P/'sign_only_minimal_theta_nonprincipal_schedule_20261111.json')
for p,h in new['pins'].items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
old=load(ROOT/'work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json')
for key in ['family_partition','setup','setup_alias_rule','selectors','common','required_unpriced','other_candidates']:
 ck(new[key]==old[key])
ck(new['predecessor_pins']==old['pins'])
ck(len(new['required_unpriced'])==11)
ck(len(new['scenarios'])==4)
selector={(x['odd'],x['theta']):x for x in old['selectors']}
changed={'omega_complex_scalings','final_Y_real_products','positive_scale_real_updates','real_exp_seed_certificates'}
summaries=[]
for n,o in zip(new['scenarios'],old['scenarios']):
 ck(n['extra_nodes']==o['extra_nodes'])
 ck(n['large']==o['large'] and n['safe_cardinality_sum']==o['safe_cardinality_sum'])
 s=n['small_sign_only_conditional_candidate'];t=o['small_minimal_theta_candidate']
 for name in ['conductor_theta','histogram','time_length_conductors','bucket_rounding']:
  ck(s[name]==t[name])
 for before,after in [(t['totals'],s['totals'])]+[(t['by_conductor_parity'][k],s['by_conductor_parity'][k]) for k in t['by_conductor_parity']]:
  ck(set(before)==set(after))
  for key,val in before.items():
   expected=0 if key in changed-{'real_exp_seed_certificates'} else val//2 if key=='real_exp_seed_certificates' else val
   ck(after[key]==expected)
  ck(before['real_exp_seed_certificates']==2*before['conductors'])
  ck(before['omega_complex_scalings']==before['final_Y_real_products']==before['primitive_grid_outputs'])
  ck(before['positive_scale_real_updates']==before['conductor_grid_nodes']-before['conductors'])
 for key,val in s['totals'].items():ck(sum(x[key] for x in s['by_conductor_parity'].values())==val)
 expectedranges={k:v for k,v in t['local_fractional_bit_ranges'].items() if k not in ['time','scale']}
 expectedranges['time_raw_sign']=[x+3 for x in t['local_fractional_bit_ranges']['time']]
 ck(s['local_fractional_bit_ranges']==expectedranges)
 ck(s['range_disposition']['scale']['old_positive_Y_recurrence_only']==t['local_fractional_bit_ranges']['scale'])
 ck(s['removed_prefix_categories']=={k:t['totals'][k]-s['totals'][k] for k in changed})
 for k in t['by_conductor_parity']:
  ck(s['removed_by_conductor_cohort'][k]=={f:t['by_conductor_parity'][k][f]-s['by_conductor_parity'][k][f] for f in changed})
 ck(s['real_exp_seed_split']=={'radial_retained':7499,'positive_Y_removed':7499})
 ck(len(s['raw_metadata'])==len(t['conductor_theta'])==7499)
 ns=Counter();bs=[];ws=[];mult={}
 for (c,theta),row in zip(t['conductor_theta'],s['raw_metadata']):
  odd=c%2==1
  band=sum(c>=cut for cut in [100,1000,10000])
  u=([F(21),F(20),F(39,2),F(96,5)] if odd else [F(113,5),F(211,10),F(201,10),F(191,10)])[band]
  height=200+ceil(max(F(240 if odd else 255),u*F(3927,1250)*F(531600 if odd else 1063200,c)))
  m=ceil(F(64*height,5))+n['extra_nodes']
  par=selector[odd,theta]
  N=8
  while N*theta<2*m*par['K'] or 5*N<5*m+128*par['K'] or 5*N<384:N*=2
  k=N.bit_length()-1;period=F(5*N,64);H=F(44,7)/period
  eps=F(1,2**82*3**theta);W=F(40000000 if odd else 80000000,theta);B=2*W**2+1
  ug=min(F(1,2*k),eps*F(5,64)/(56*(2*k+4)*(B+1)))
  ubits=bits(ug/8);CU=(2*ceil(F(25*N,192))+1)*B
  magbits=ceil(CU+1).bit_length()-1
  if 2**magbits<CU+1:magbits+=1
  ck(row==[c,m,N,ubits,magbits])
  ck(ubits==bits(ug)+3)
  ck(N*(2*k+4)*(ug/8)*(B+1)<eps/(64*H))
  ck(eps/(64*H)<1 and H<1 and H*(CU+1)<=44*B+1)
  ck(F(3,4)/(6/period)+F(3,16)/H==F(109,704)*period)
  ns[N]+=1;bs.append(ubits);ws.append(magbits);mult[str(N)]=str(F(109,704)*period)
 ck(s['threshold_multiplier_of_epsilon_by_N']==mult)
 ck(s['time_length_conductors']=={str(k):v for k,v in sorted(ns.items())})
 ck([min(bs),max(bs)]==[241,343]==s['local_fractional_bit_ranges']['time_raw_sign'])
 ck([min(ws),max(ws)]==s['raw_sample_magnitude_power2_range'])
 summaries.append({'extra_nodes':n['extra_nodes'],'deductions':s['removed_prefix_categories'],'raw_time_bits':[min(bs),max(bs)],'magnitude_bits':[min(ws),max(ws)]})
out={'status':'PASS conditional API/metadata join only','checks':checks,'author_pins':pins,'input_pins':new['pins'],'summaries':summaries}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':out['status'],'checks':checks}))
