"""Exact independent envelope, matrix, grid and ledger checks. No evaluator."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial, comb
import json
import hashlib

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents'
pins={
 'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
 'work/qrh-campaign/agents/major-constants/joint_quarter_mesh_head_tradeoff_20261111.py':'EA607EE8DB1EE54168172D2D8057E770B25EEE8618DB23F26A98339AD98E4C4A',
 'work/qrh-campaign/agents/major-constants/joint_quarter_mesh_head_tradeoff_20261111.json':'F1686B1C1A3183082D9126F4FE680BE6DB42A88D31F82071B752759EE3DE9BD4',
}
checks=0
def ck(condition):
 global checks
 checks+=1
 assert condition,checks
def digest(path): return hashlib.sha256(path.read_bytes()).hexdigest().upper()
for path,pin in pins.items(): ck(digest(ROOT/path)==pin)
data=json.loads((BASE/'major-constants/joint_quarter_mesh_head_tradeoff_20261111.json').read_text())
for path,pin in data['input_sha256'].items():
 ck(digest(ROOT/path)==pin)
 pins[path]=pin
ck(data['parameters']==dict(V=7000,D_source=4096,D_output=8192,N=1500,m=256,P=28))

D,Q,N,P,m,V=4096,8192,1500,28,256,7000
bmin,bmax=N+1,N+2
W=V+32+2*m
eta,delta,u,ut=[F(1,2**p) for p in (100,118,122,110)]
r=F(17,20)
A=F(V+32,D)
ck(F(W,6*bmin)<r and F(W,bmin*D)<1)
ck(A<F(7,4) and A/2<F(7,8) and F(6,D)<F(1,2))
remainder=F(4*bmax,F(4*m-1,2))*r**(2*m)
ck(remainder<F(1,2**116))
for k in range(P):
 ck(A**k/factorial(k)<2)
 bound=F(4*bmax,F(2*k+4*m-1,2))*F(W,bmin*D)**k/factorial(k)*F(W,6*bmin)**(2*m)
 ck(bound<remainder)
eR=eE=eLambda=F(0)
for k in range(1,P):
 eR=A/k*eR+1
 eLambda=F(6,D*k)*eLambda+1
 ck(eR<8 and eLambda<2)
for ell in range(1,P+2*m-1):
 eE=r*eE+1
 ck(eE<7)
ck(P+2*m-2==538==data['max_E_index'])
S=4*r/(1-r*r)
ck(S<13 and 1/(1-r)<7)
term_error=4*7+2+1
sum_error=m*term_error
correction_error=sum_error/ F(6)+1
ck(term_error==31 and sum_error==7936 and correction_error<1324)
z_error=(14*bmax+1)+5+1324
f_error=z_error+2*(2*bmax+4)+1
endpoint_delta=2*bmax+3
endpoint_u=2*f_error+1
head_delta=5*N
head_u=5*N*P+8*N+1
ck(z_error==14*bmax+1330 and f_error==18*bmax+1339)
ck(endpoint_u==36*bmax+2679 and z_error*u<1)
ck(head_delta+endpoint_delta==10507==data['source_delta_coefficient'])
ck(head_u+endpoint_u+1==278753==data['source_u_coefficient'])
seed=(head_delta+endpoint_delta)*delta+(head_u+endpoint_u+1)*u+remainder
ck(seed<F(107,1000)*eta and seed<eta/4)

# Reverse propagation proves exact rows and checks every actual error-injection
# location, independently of the producer's forward matrix multiplication.
stages=[j for outer in range(P-2,-1,-1) for j in range(outer,min(P-2,outer+19)+1)]
ck(len(stages)==350)
max_injection=F(0)
for tau in (F(1,4),F(1,2),F(-1,4)):
 for k in range(20):
  weights=[F(int(j==k),2**k) for j in range(P)]
  for slot in reversed(stages):
   ck(abs(weights[slot])<=1)
   max_injection=max(max_injection,abs(weights[slot]))
   weights[slot+1]+=tau*weights[slot]
  expected=[F(0) if j<k else F(comb(j,k),2**k)*tau**(j-k) for j in range(P)]
  ck(weights==expected)
  ck(sum(abs(w) for w in weights)<=2)
ck(max_injection==1)
output=2*seed+(len(stages)+1)*ut
ck(output<F(557,1000)*eta and output<eta)
target=1266*F(V+20,4*Q)**20/factorial(20)
shift=1266*F(5*(V+P),8*D)**P/factorial(P)
alpha=target+shift+(844+1688)*eta
ck(alpha<F(4,25)*F(1,2**82))
ck(6*(3*N+7)+1==27043<2**16)
ck(2**P*(seed+len(stages)*ut)<1)
for name,value in dict(remainder=remainder,source=seed,source_over_eta=seed/eta,delivered=output,delivered_over_eta=output/eta,target=target,shift=shift,alpha=alpha,alpha_over_budget=alpha*2**82).items():
 ck(F(data['errors'][name])==value)

# Explicit ownership of every fine anchor and its closed nearest-anchor cell.
usage={F(0):0,F(1,4):0,F(1,2):0,F(-1,4):0}
for ell in range(4*D+1):
 coarse,part=divmod(ell,4)
 if part==3: coarse+=1
 source=F(coarse,D)
 out=F(ell,4*D)
 tau=D*(out-source)
 usage[tau]+=1
 ck(0<=source<=1 and 0<=out<=1)
 left=max(F(0),out-F(1,8*D))
 right=min(F(1),out+F(1,8*D))
 ck(Q*(out-left)<=F(1,4) and Q*(right-out)<=F(1,4))
 ck(abs(out-source)+max(out-left,right-out)<=F(5,8*D))
ck(usage=={F(0):D+1,F(1,4):D,F(1,2):D,F(-1,4):D})

def one_height(d,n,m,p,quarter):
 # Count the two anchor classes independently, including all right-endpoint
 # source derivatives for the quarter construction.
 orders=[(d,p),(1,p if quarter else 20)]
 slots=sum(number*order for number,order in orders)
 return dict(source_slots=slots,
  head_scales=sum(number*(order-1)*n for number,order in orders),
  head_additions=slots*n,Bernoulli_terms=slots*m,Bernoulli_additions=slots*m,
  E_stages=sum(number*(order+2*m-2) for number,order in orders),
  translations=(3 if quarter else 1)*d*sum(p-k-1 for k in range(20)),
  final_power2_scales=20*(4*d+1) if quarter else 0,
  final_rounds=20*(4*d+1) if quarter else 0,
  delivered_slots=20*((4 if quarter else 2)*d+1),
  shared_R_stages=p-1,coarse_anchors=d+1)
cases={'baseline':(8192,2387,64,27,False),'head_only':(8192,1500,256,27,False),'mesh_only':(4096,2387,64,28,True),'joint':(4096,1500,256,28,True)}
work={name:one_height(*params) for name,params in cases.items()}
for name,items in work.items():
 for key,value in items.items(): ck(data['per_height'][name][key]==value)
previous=1721*4096+1
active=1501*4096+1
ck(data['transition']==dict(previous=previous,final=active,retained=active,retired=previous-active,introduced=0,union=previous))
for d,n in [(512,220),(1024,387),(2048,720)]: ck(4096%d==0 and n+2<1722)
base_inventory=json.loads((BASE/'major-constants/combined_odd_even_height_inventory_20261111.json').read_text())
for row,base_row,extra in zip(data['scenarios'],base_inventory['scenarios'],[0,167,320,640]):
 H=base_row['global_nodes']-64001
 ck(row['extra_nodes']==extra==base_row['extra_nodes'] and row['final_heights']==H)
 ck(H==20199+extra and F(5*(64001+H-1),64)<7000 and 64001+H<128000)
 for name,params in cases.items():
  for key,val in work[name].items(): ck(row['work'][name][key]==H*val)
  d,n,_,_,_=params
  points=(n+1)*d+1
  intersection=min(n+1,1721)*4096+1
  new=points-intersection
  # Retained states update H times; new states update H-1 times.
  expected=dict(pairs=H*points,updates=H*intersection+(H-1)*new,initial_B=new,step_cis=new,step_grid=new)
  ck(row['argument_work'][name]==expected)

at=4096; end=1722*4096; covered=0; blocks=0
while at<=end:
 last=min(end,at+at//128-1)
 ck(0<=F(last-at,at)<F(1,128))
 covered+=last-at+1; blocks+=1; at=last+1
ck(covered==previous and at==end+1 and blocks==960)
ck(data['log_setup']==dict(points=previous,anchors=960,degree21_stages=21*(previous-960),new_final_band_points=0))
ck(data['new_gamma_constants']==256-64==192)
for path,pin in pins.items(): ck(digest(ROOT/path)==pin)
out=dict(status='PASS conditional joint construction; exact envelopes/matrices/metadata only',checks=checks,pins=pins,errors=data['errors'],per_height=work,transition=data['transition'],log_setup=data['log_setup'],max_injection=str(max_injection),fine_anchor_ownership={str(k):v for k,v in usage.items()})
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:
 json.dump(out,f,indent=2);f.write('\n')
print(f'PASS {checks} exact checks; no analytic values or producer import.')
