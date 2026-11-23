"""Independent integer and rational review only. No producer import."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial,comb
import json,hashlib
HERE=Path(__file__).resolve().parent
A=HERE.parent
Z=A/'zero-sum'
pins={
'QUARTER_MESH_P28_SHARED_SEED_2026-11-11.md':'A0CD531E1FD20280E49B1EC0AE95E32809C7965222C40916BD4712F7F3A5EA19',
'quarter_mesh_p28_seed_20261111.py':'E16148F355192110DE6A339572F1982F40396FEAE250398041B25016B52F262D',
'quarter_mesh_p28_seed_20261111.json':'B78FB6A57D6261EEC59D08D8EA4D0121489644C5D09A52E4BBC51E35DD99A9BE'}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
for f,h in pins.items():ck(hashlib.sha256((Z/f).read_bytes()).hexdigest().upper()==h)
d=json.loads((Z/'quarter_mesh_p28_seed_20261111.json').read_text())
for f,h in d['pins'].items():ck(hashlib.sha256(Path(f).read_bytes()).hexdigest().upper()==h)
base=json.loads((A/'independent-feasibility/retuned_final_seed_band_20261111.json').read_text())
ck(d['parameters']==dict(V=7000,D_source=4096,D_output=8192,N=2387,P=28,m=64))
D,N,P=4096,2387,28
eta=F(1,2**100);u=F(1,2**122);delta=F(1,2**118);ut=F(1,2**110)
rem=F(216*2389,255*2**128)
seed=(5*N+2*2389+1)*delta+(5*N*P+8*N+1+16*2389+256)*u+rem
coeff=2*seed+351*ut
target=1266*F(7020,32768)**20/factorial(20)
shift=1266*F(5*7028,8*4096)**28/factorial(28)
alpha=target+shift+2532*eta
for k,v in dict(seed=seed,seed_over_eta=seed/eta,coefficient=coeff,coefficient_over_eta=coeff/eta,target=target,shift=shift,alpha=alpha,alpha_over_budget=alpha*2**82).items():ck(F(d['errors'][k])==v)
ck(seed<eta/4 and coeff<eta and alpha*2**82<F(4,25))
ck(1266*F(5*7027,8*4096)**27/factorial(27)>F(1,2**82))
ck(1266*F(7020,16384)**20/factorial(20)>F(1,2**82))
for k in range(P):
 ck(F(7032,4096)**k/factorial(k)<2)
 ck(F(8*2389,2*k+255)*F(7160,2388)**k/factorial(k)*F(7160,6*2388)**128<=rem)
 if k:ck(F(7001+k,4096*(k+1))<F(7,8))
for j in range(154):ck(F(7001+j,6*2388)<F(1,2))
ck(F(7,8)*8+1==8)
ck(6*(3*N+5)+1<2**16 and 2**28*(seed+350*ut)<1)

# Reverse linear propagation independently proves both the output rows and
# every single rounding-error injection, including the negative translation.
gates=[j for i in reversed(range(P-1)) for j in range(i,min(P-1,i+20))]
ck(len(gates)==350)
max_injection=F(0)
for tau in [F(1,4),F(1,2),F(-1,4)]:
 for k in range(20):
  row=[F(int(j==k),2**k) for j in range(P)]
  for j in reversed(gates):
   ck(abs(row[j])<=1)
   max_injection=max(max_injection,abs(row[j]))
   row[j+1]+=tau*row[j]
  expected=[F(0) if j<k else F(comb(j,k),2**k)*tau**(j-k) for j in range(P)]
  ck(row==expected)
  ck(sum(abs(v) for v in row)<=2)

# Every fine anchor, source choice and local-domain endpoint is checked.
offsets={0:0,1:0,2:0,3:0}
for ell in range(4*D+1):
 q,r=divmod(ell,4)
 src=q if r<3 else q+1
 tau=F(ell,4)-src
 ck(0<=src<=D and tau in [F(0),F(1,4),F(1,2),F(-1,4)])
 ck(F(src,D)+tau/D==F(ell,4*D))
 ck(abs(tau)+F(1,8)<=F(5,8))
 offsets[r]+=1
ck(offsets=={0:D+1,1:D,2:D,3:D})
ck(F(4*D-1,4*D)-F(1)==F(-1,4*D))

X=(N+1)*D+1;prior=(1720+1)*4096+1
for i,s in enumerate(d['scenarios']):
 old=base['scenarios'][i]['retuned'];H=base['scenarios'][i]['retuned']['bands'][-1]['heights']
 ck(s['extra_nodes']==[0,167,320,640][i] and s['final_heights']==H)
 ck(s['baseline_totals']==old['totals'])
 per={
  'independent_P27_source_coefficients':P*(D+1),
  'head_reciprocal_scales':N*sum(1 for _ in range(D+1) for k in range(1,P)),
  'head_accumulator_additions':N*P*(D+1),
  'E_contracting_complex_stages':154*(D+1),
  'Bernoulli_weighted_terms':64*P*(D+1),
  'Bernoulli_accumulator_additions':64*P*(D+1),
  'P27_to_P20_midpoint_shift_updates':350*sum(offsets[r] for r in (1,2,3)),
  'P20_fine_anchor_coefficient_deliveries':20*(4*D+1),
  'shared_height_R_recurrence_steps':27,
  'coarse_anchor_instances':D+1,
  'base_height_argument_pairs':X,
  'state_to_EM_grid_conversions':X}
 current={k:H*v for k,v in per.items()}
 current.update(initial_B_certificates=X-prior,step_cis_certificates=X-prior,step_grid_conversions=X-prior,fine_state_complex_updates=(H-1)*X+prior)
 for k,v in current.items():
  ck(s['new_final_band'][k]==v)
  total=sum(r[k] for r in old['bands'][:4])+v
  ck(s['new_totals'][k]==total)
  ck(s['new_minus_baseline'][k]==total-old['totals'][k])
 ck(s['new_totals']['P20_fine_anchor_coefficient_deliveries']==old['totals']['P20_fine_anchor_coefficient_deliveries'])
 ck(s['added_final_coefficient_power2_scales']==s['added_final_coefficient_rounds']==H*20*(4*D+1))
 ck(s['new_totals']['base_height_argument_pairs']-s['new_totals']['fine_state_complex_updates']==X)
 ck(F(5*(base['scenarios'][i]['global_nodes']-1),64)<7000)

for name,mesh in [('new',4096),('baseline',8192)]:
 cursor=mesh;end=2389*mesh;n=0;covered=0
 while cursor<=end:
  stop=min(cursor+cursor//128,end+1)
  ck(0<=F(stop-cursor-1,cursor)<F(1,128))
  covered+=stop-cursor;n+=1;cursor=stop
 ck(d['setup'][name]==dict(points=covered,anchors=n,log_horner_stages=21*(covered-n),dense_state_step_bytes=72*covered))
 ck(covered==(2388*mesh+1))
ck(4096%4096==0 and 2387>=1720)
ck(2*F(1,128)**22<=F(1,2**147))
ck(F(5,64)*F(1,2**144)+2*F(1,2**142)<F(1,2**140))
ck(delta/2+512000*F(1,2**140)+F(1,2**122)<delta)
out=dict(status='PASS_INDEPENDENT_QUARTER_MESH_METADATA',checks=checks,pins=pins,max_single_injection=str(max_injection),seed_over_eta=str(seed/eta),coefficient_over_eta=str(coeff/eta),alpha_over_budget=str(alpha*2**82),scope='Exact finite identities, rational envelopes and integer schedules only; no function evaluations or author imports.')
with Path(__file__).with_suffix('.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out,indent=2))
