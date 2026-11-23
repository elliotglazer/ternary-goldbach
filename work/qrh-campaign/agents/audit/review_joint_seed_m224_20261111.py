"""Independent exact scalar and schedule review; no analytic-value evaluation."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import json, hashlib

ROOT=Path(__file__).resolve().parents[4]
PINS={
 'work/qrh-blueprint/JOINT_SEED_224_CORRECTIONS_2026-11-11.md':'E438F4EF3AEC8352947B046E55C07418D9DA233B5E602B6FEF5CB402600F61F5',
 'work/qrh-blueprint/check_joint_seed_m224_20261111.py':'516682375632EFEEAE27B7B7C46E8BBA29897C58D291FBB393502568E1043855',
 'work/qrh-blueprint/joint_seed_m224_20261111.json':'AD11383DC11823F6D8178720EFF843424B8F0722AC7F6164B8A54E01896876BB',
 'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
 'work/qrh-campaign/agents/audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A',
 'work/qrh-campaign/agents/major-constants/joint_quarter_mesh_head_tradeoff_20261111.json':'F1686B1C1A3183082D9126F4FE680BE6DB42A88D31F82071B752759EE3DE9BD4',
}
checks=0
def ck(value):
 global checks
 checks+=1
 assert value,checks
for path,pin in PINS.items():ck(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==pin)
data=json.loads((ROOT/'work/qrh-blueprint/joint_seed_m224_20261111.json').read_text())
old=json.loads((ROOT/'work/qrh-campaign/agents/major-constants/joint_quarter_mesh_head_tradeoff_20261111.json').read_text())
N,D,P,V,m=1500,4096,28,7000,224
W=V+32+2*m
ck(data['parameters']==dict(V=V,D=D,N=N,P=P,m=m,W=W))
r=F(W,6*(N+1))
remainder=F(8*(N+2),4*m-1)*r**(2*m)
# Cross-multiplied integer inequality, independent of a floating logarithm.
ck(8*(N+2)*W**(2*m)*2**116 < (4*m-1)*(6*(N+1))**(2*m))
ck(r<F(17,20) and F(W,(N+1)*D)<1)
for k in range(P):
 ck(F(1,2)+k+2*m>1)
 bound=F(8*(N+2),2*k+4*m-1)*F(W,(N+1)*D)**k*r**(2*m)/factorial(k)
 ck(bound<=remainder)
 ck(V+(k+2*m-1)+1<=W)
ck(F(data['remainder'])==remainder)
delta,u,eta,ut=[F(1,2**p) for p in (118,122,100,110)]
e=F(0)
for i in range(1,P+2*m-1):
 e=r*e+1
 ck(e<7)
ck(P+2*m-2==474)
ck(31*m==6944<7936)
ck(F(31*m,6)+1<1324)
ck(4*F(17,20)/(1-F(17,20)**2)<13)
seed=10507*delta+278753*u+remainder
ck(seed/eta==F(data['seed_over_eta']))
ck(seed<F(107,1000)*eta and seed<eta/4)
ck(2*seed+351*ut<F(557,1000)*eta and 2*seed+351*ut<eta)
ck(2**P*(seed+350*ut)<1 and 6*(3*N+7)+1<2**16)
target=1266*F(V+20,4*8192)**20/factorial(20)
shift=1266*F(5*(V+P),8*D)**P/factorial(P)
ck(target+shift+2532*eta<F(4,25)*F(1,2**82))

slots=P*(D+1)
newterms=sum(P for _ in range(D+1))*m
newE=(D+1)*((P-1)+(2*m-1))
previous=old['per_height']['joint']
saved_terms=previous['Bernoulli_terms']-newterms
saved_E=previous['E_stages']-newE
ck(data['per_height']==dict(gamma_terms=newterms,E_stages=newE,gamma_scales_saved=saved_terms,E_stages_saved=saved_E))
ck(slots==114716 and saved_terms==3670912 and saved_E==262208)
ck(newterms==25696384 and newE==1941978)
for row in old['scenarios']:
 H=row['final_heights']
 ck(data['prefix_savings'][str(H)]==dict(gamma_scales_saved=H*saved_terms,gamma_additions_saved=H*saved_terms,E_stages_saved=H*saved_E))
 ck(F(5*(64001+H-1),64)<V)
 for name,val in previous.items():
  replacement=newterms if name in ['Bernoulli_terms','Bernoulli_additions'] else newE if name=='E_stages' else val
  ck(val>=replacement)
ck(old['transition']==dict(previous=7049217,final=6148097,retained=6148097,retired=901120,introduced=0,union=7049217))
ck(m-64==160 and 2*m==448)
for path,pin in data['pins'].items():ck(PINS['work/'+path]==pin)
out=dict(status='PASS conditional m224 refinement, no values or builds',checks=checks,pins=PINS,remainder=str(remainder),seed_over_eta=str(seed/eta),output_over_eta=str((2*seed+351*ut)/eta),per_height=data['per_height'],prefix_savings=data['prefix_savings'],retained_max_E=474,new_gamma_over_m64=160)
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(f'PASS {checks} exact checks; m224 actual-ratio remainder and retained error/work bounds.')
