"""Independent exact metadata review. No producer import or function evaluation."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import json, hashlib

HERE=Path(__file__).resolve().parent
A=HERE.parent
P=A/'independent-feasibility'
pins={
 'RETUNED_FINAL_SHARED_SEED_BAND_2026-11-11.md':'8F08560DDB2BDFEBEABA0D4D5A44FCBCC625BFD43D1027AF05BF62233863FD9B',
 'retuned_final_seed_band_20261111.py':'DDDD2CB0C0E25D8BCFF43DE142EBEED4C1DAFFDB35FED01ECA914B671ADD1FE3',
 'retuned_final_seed_band_20261111.json':'51EF63920A6E298F21FEC3EE228B9DB75302700847D64532ADA76D1240A15B7D'}
nchecks=0
def ck(v):
 global nchecks
 assert v
 nchecks+=1
for name,h in pins.items():ck(hashlib.sha256((P/name).read_bytes()).hexdigest().upper()==h)
d=json.loads((P/'retuned_final_seed_band_20261111.json').read_text())
for name,h in d['pins'].items():ck(hashlib.sha256(Path(name).read_bytes()).hexdigest().upper()==h)
old=json.loads((A/'major-constants/coupled_plus_height_inventory_20261111.json').read_text())
ck(old['candidate_main']['max_nodes']==85902)
ck(old['candidate_main']['max_node_conductors']==[10004])
ck(d['parameters']==dict(V=7000,D=8192,N=2387,P=27,m=64,max_EM_endpoint=2389))

eta=Q(1,2**100);delta=Q(1,2**118);u=Q(1,2**122)
rem=Q(216*2389,255*2**128)
ck(rem==Q(d['error']['remainder']) and rem<Q(1,2**116))
for k in range(27):
 envelope=Q(8*2389,2*k+255)*Q(7160,2388)**k/Q(factorial(k))*Q(7160,6*2388)**128
 ck(envelope==Q(d['error']['remainder_by_k'][k]) and envelope<=rem)
 ck(Q(7032,8192)**k/factorial(k)<=Q(5,4))
for ell in range(153):ck(Q(7001+ell,6*2388)<Q(1,2))
for k in range(1,27):ck(Q(7001+k,8192*(k+1))<Q(5,8))
e=d['error']
for name,val in [('head_delta',11935),('head_u',329407),('endpoint_delta',4779),('endpoint_u',38479),('ideal_C',7166),('shifted_center_bound',28665)]:ck(e[name]==val)
seed=16714*delta+367887*u+rem
ck(seed==Q(e['seed_bound']) and seed/eta==Q(e['seed_over_eta']) and seed<eta/4)
alpha=1266*(Q(5,16)**20/factorial(20)+Q(15,16)**27/factorial(27))+2532*eta+633*330*Q(1,2**110)+1688*eta
ck(alpha==Q(e['alpha_bound']) and alpha*2**82==Q(e['alpha_over_budget']) and alpha*2**82<Q(1,3))
ck((delta/2+512000*Q(1,2**140)+Q(1,2**122))/delta==Q(e['height_error_over_delta'])==Q(701,1024))
ck(Q(5,64)*Q(1,2**144)+2*Q(1,2**142)==Q(517,1024)*Q(1,2**140))
ck(Q(7,16)*Q(1,2**120)<delta/4)
ck(7000*Q(1,2**135)<delta/8)
ck(Q(432705,64)<6762<7000)
ck(2**27*(eta+330*Q(1,2**110))<1 and 28665<2**16)

# Independent sums over coefficient indices, rather than closed producer counts.
struct={'V','D','N','heights','first_index','last_index'}
def audit_ledger(led,J,Nfinal):
 previous=0
 for i,r in enumerate(led['bands']):
  v,mesh,N=[(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(7000 if Nfinal==2387 else 10000,8192,Nfinal)][i]
  first=[0,6401,12801,25601,64001][i]
  last=[6400,12800,25600,64000,J-1][i]
  H=last-first+1; X=(N+1)*mesh+1
  ck([r[k] for k in ('V','D','N','heights','first_index','last_index')]==[v,mesh,N,H,first,last])
  ck(Q(5*last,64)<=v and H>0)
  coeff=mesh*sum(1 for k in range(27))+sum(1 for k in range(20))
  reciprocal=N*(mesh*sum(1 for k in range(1,27))+sum(1 for k in range(1,20)))
  count={
   'independent_P27_source_coefficients':H*coeff,
   'head_reciprocal_scales':H*reciprocal,
   'head_accumulator_additions':H*N*coeff,
   'E_contracting_complex_stages':H*(mesh*153+146),
   'Bernoulli_weighted_terms':H*64*coeff,
   'Bernoulli_accumulator_additions':H*64*coeff,
   'P27_to_P20_midpoint_shift_updates':H*mesh*sum(min(26-i,20) for i in range(26)),
   'P20_fine_anchor_coefficient_deliveries':H*(mesh*2+1)*20,
   'shared_height_R_recurrence_steps':H*26,
   'coarse_anchor_instances':H*(mesh+1),
   'base_height_argument_pairs':H*X,
   'initial_B_certificates':X-previous,
   'step_cis_certificates':X-previous,
   'step_grid_conversions':X-previous,
   'fine_state_complex_updates':(H-1)*X+previous,
   'state_to_EM_grid_conversions':H*X}
  for k,z in count.items():ck(r[k]==z)
  previous=X
 for k,z in led['totals'].items():ck(z==sum(r[k] for r in led['bands']))
 ck(led['totals']['base_height_argument_pairs']-led['totals']['fine_state_complex_updates']==previous)

for i,s in enumerate(d['scenarios']):
 J=85902+[0,167,320,640][i]
 ck(s['global_nodes']==J and s['extra_nodes']==[0,167,320,640][i] and Q(s['last_height'])==Q(5*(J-1),64))
 audit_ledger(s['retuned'],J,2387)
 base=old['scenarios'][i]['selected_P27']
 audit_ledger(base,J,3387)
 ck(s['retuned']['bands'][:4]==base['bands'][:4])
 for k,v in s['retuned']['totals'].items():
  ck(s['saved'][k]==base['totals'][k]-v)
  ck(Q(s['ratios'][k])==Q(v,base['totals'][k]))

for label,end in [('new',2389),('old',3389)]:
 g=d['setup'][label];starts=[];lengths=[];x=8192
 while x<=end*8192:
  starts.append(x);stop=min(x+x//128,end*8192+1)
  ck(0<=Q(stop-1-x,x)<Q(1,128))
  lengths.append(stop-x);x=stop
 ck(starts==g['anchor_starts'])
 ck(len(starts)==g['anchors'] and sum(lengths)==g['points'] and max(lengths)==g['max_length'])
 ck(g['log_nonanchor_horner_stages']==21*(sum(lengths)-len(starts)))
 ck(g['raw_dense_state_step_bytes']==72*sum(lengths))
ck(d['setup']['new']['anchors']==1001)
ck(d['setup']['new']['points']==19562497)
for key,field in [('saved_arguments','points'),('saved_log_horner_stages','log_nonanchor_horner_stages'),('saved_raw_dense_bytes','raw_dense_state_step_bytes')]:
 ck(d['setup'][key]==d['setup']['old'][field]-d['setup']['new'][field])
ck(2*Q(1,128)**22<=Q(1,2**147))
ck(2389*8192<2**25)
out={'status':'PASS_INDEPENDENT_EXACT_METADATA','checks':nchecks,'producer_pins':pins,'input_pins_checked':len(d['pins']),'seed_over_eta':str(seed/eta),'alpha_over_budget':str(alpha*2**82),'scope':'Rational envelopes and integer schedules only; no function values or producer imports.'}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out,indent=2))
