"""One final-band retune: exact envelope and schedule arithmetic only."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json

HERE=Path(__file__).resolve().parent
A=HERE.parent
ROOT=A.parents[1]/'qrh-blueprint'
FILES={
 A/'integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md':'1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E',
 A/'prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
 A/'integration/REVIEW_SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'043E2E1630B19EC8EED9496FAA5D9AE6AF9C20944F7F2F5589B48E5A119C4F26',
 ROOT/'SELECTED_SCALED_SEED_ORDER_2026-11-11.md':'579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1',
 ROOT/'SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md':'8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413',
 A/'zero-sum/GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md':'E564A8DDEC5F0AD69F5CF22DFC89147F81EA165B6E6D17B4CF0EFB0EEA3824AF',
 HERE/'REVIEW_GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md':'335D5B97A2071E9AFBEFF363C9FA4542CB974B8EB4D0F66B33A4E4FCECC17A29',
 A/'major-constants/coupled_plus_height_inventory_20261111.json':'676388307D0353800DB72B85ED9252C83E3BA4F62F3D54F63A5C3B43A7DB4267',
 HERE/'REVIEW_COUPLED_PLUS_HEIGHT_CONDITIONAL_COST_2026-11-11.md':'222CE080714E39E73398B23AF28E67D37F709A9BAD895FD0D32E2F9F9CB20165',
}
checks=0
def check(p):
 global checks
 assert p
 checks+=1
for p,h in FILES.items():check(hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
old=json.loads((A/'major-constants/coupled_plus_height_inventory_20261111.json').read_text())
V,D,N,P,m=7000,8192,2387,27,64
b=N+2;W=V+32+2*m
eta=F(1,2**100);delta=F(1,2**118);u=F(1,2**122)
check(N==(W+2)//3)
check(F(W,N+1)<3)
check(F(W,6*(N+1))<F(1,2))
check(F(V+32,D)<F(5,4))
check(F(V+32,2*D)<F(5,8))
check(F(6,D)<F(1,2))
check(F(5*(86542-1),64)<6762<7000)
# Original coefficient remainder, with sqrt(b)<=b and 3^k/k!<27.
rem=F(108*b,1)/F(255,2)/2**128
check(rem<F(1,2**116))
by_k=[]
for k in range(P):
 check(F(3**k,factorial(k))<27)
 check(F(V+32,D)**k/factorial(k)<=F(5,4))
 # Every rising factor and every stored E update is within the common bound.
 check(V+k+128<=W)
 bound=F(4*b,1)/F(2*k+255,2)*F(W,N+1)**k/factorial(k)*F(W,6*(N+1))**128
 check(bound<=rem)
 by_k.append(str(bound))
check(V+(P+126)<=W)
hd=5*N;hu=5*N*P+3*N+1;ed=2*b+1;eu=16*b+255
total=(hd+ed)*delta+(hu+eu+1)*u+rem
check(total<eta/4)
C=3*N+5
check(4*C+1<2**16)
L=20*P-210
target=F(1266)*F(5,16)**20/factorial(20)
shift=F(1266)*F(15,16)**P/factorial(P)
alpha=target+shift+2532*eta+633*L*F(1,2**110)+1688*F(1,2**100)
check(alpha<F(1,2**82)/3)
check(2**P*(eta+L*F(1,2**110))<1)
# Preserve the already sufficient recurrence allocation and elementary targets.
eps=F(1,2**140);logerr=F(1,2**144);conversion=F(1,2**122)
check(128000*eps<F(1,2))
height_error=delta/2+2*128000*(2*eps)+conversion
check(height_error/delta==F(701,1024))
check(height_error<delta)
check(F(5,64)*logerr+2*F(1,2**142)<eps)
check(logerr<=F(1,2**137))
check(F(7,16)*F(1,2**120)<delta/4)
check(V*F(1,2**135)<delta/8)

def ledger(J,last):
 rows=[];lo=0;prev=0;prevD=0;prevN=0
 for v,d,n in [(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),last]:
  hi=min(J,64*v//5+1);h=hi-lo
  if h<=0:break
  check(not prevD or d%prevD==0)
  check(n>=prevN)
  check(F(5*(hi-1),64)<=v)
  x=(n+1)*d+1;init=x-prev;k=27*d+20
  rows.append(dict(V=v,D=d,N=n,heights=h,first_index=lo,last_index=hi-1,
   independent_P27_source_coefficients=h*k,head_reciprocal_scales=h*n*(26*d+19),head_accumulator_additions=h*n*k,
   E_contracting_complex_stages=h*(153*d+146),Bernoulli_weighted_terms=64*h*k,Bernoulli_accumulator_additions=64*h*k,
   P27_to_P20_midpoint_shift_updates=330*h*d,P20_fine_anchor_coefficient_deliveries=20*h*(2*d+1),
   shared_height_R_recurrence_steps=26*h,coarse_anchor_instances=h*(d+1),base_height_argument_pairs=h*x,
   initial_B_certificates=init,step_cis_certificates=init,step_grid_conversions=init,fine_state_complex_updates=h*x-init,state_to_EM_grid_conversions=h*x))
  lo=hi;prev=x;prevD=d;prevN=n
 check(lo==J)
 sums={k:sum(r[k] for r in rows) for k in rows[0] if k not in ('V','D','N','heights','first_index','last_index')}
 return dict(bands=rows,totals=sums)
scenarios=[]
for s in old['scenarios']:
 J=s['global_nodes'];baseline=ledger(J,(10000,8192,3387));new=ledger(J,(V,D,N))
 check(baseline==s['selected_P27'])
 check(new['bands'][:4]==baseline['bands'][:4])
 saved={k:baseline['totals'][k]-v for k,v in new['totals'].items()}
 check(all(v>=0 for v in saved.values()))
 check(new['totals']['initial_B_certificates']==(N+1)*D+1)
 check(saved['base_height_argument_pairs']==1000*D*new['bands'][-1]['heights'])
 check(saved['fine_state_complex_updates']==1000*D*(new['bands'][-1]['heights']-1))
 scenarios.append(dict(extra_nodes=s['extra_nodes'],global_nodes=J,last_height=str(F(5*(J-1),64)),
   retuned=new,saved=saved,ratios={k:str(F(v,baseline['totals'][k])) for k,v in new['totals'].items()}))

def grid(endpoint):
 start=D;end=endpoint*D;anchors=[];lengths=[]
 while start<=end:
  length=min(start//128,end-start+1)
  check(length>0 and F(length-1,start)<=F(1,128))
  anchors.append(start);lengths.append(length);start+=length
 points=end-D+1
 check(sum(lengths)==points)
 return dict(points=points,anchors=len(anchors),anchor_starts=anchors,max_length=max(lengths),
  log_nonanchor_horner_stages=21*(points-len(anchors)),raw_dense_state_step_bytes=72*points)
gnew=grid(b);gold=grid(3389)
check(gold['points']==27754497 and gold['anchors']==1046)
check(gold['log_nonanchor_horner_stages']==582822471)
check(gnew['anchor_starts']==gold['anchor_starts'][:gnew['anchors']])
check(2*F(1,128)**22<=logerr/8)
check(b*D<2**25)
out=dict(status='PASS_EXACT_FINAL_BAND_RETUNE',checks=checks,pins={str(p):h for p,h in FILES.items()},
 parameters=dict(V=V,D=D,N=N,P=P,m=m,max_EM_endpoint=b),
 error=dict(remainder=str(rem),remainder_by_k=by_k,head_delta=hd,head_u=hu,endpoint_delta=ed,endpoint_u=eu,
  seed_bound=str(total),seed_over_eta=str(total/eta),ideal_C=C,shifted_center_bound=4*C+1,
  alpha_bound=str(alpha),alpha_over_budget=str(alpha*2**82),height_error_over_delta=str(height_error/delta)),
 scenarios=scenarios,setup=dict(new=gnew,old=gold,saved_arguments=gold['points']-gnew['points'],
  saved_log_horner_stages=gold['log_nonanchor_horner_stages']-gnew['log_nonanchor_horner_stages'],
  saved_raw_dense_bytes=gold['raw_dense_state_step_bytes']-gnew['raw_dense_state_step_bytes']),
 scope='One conditional paper retune; no analytic values, roots, signs, builds or runtime claims')
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=checks,error=out['error'],setup={k:v for k,v in gnew.items() if k!='anchor_starts'},
 scenarios=[dict(d=s['extra_nodes'],totals=s['retuned']['totals'],saved=s['saved']) for s in scenarios]),indent=2))
