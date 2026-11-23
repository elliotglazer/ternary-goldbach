"""Exact comparison of the two declared parameter schedules; no values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
p=Path(__file__).with_name('small_family_theta_inventory_final_20261111.json')
assert hashlib.sha256(p.read_bytes()).hexdigest().upper()=='26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69'
meta=json.loads(p.read_text())
def ceil(x):return -(-x.numerator//x.denominator)
counts=[]
for extra in [0,167,320,640]:
 same=[];half=[]
 for c in range(3,10001):
  if c%2==0 and c%4:continue
  odd=c%2==1;i=0 if c<100 else 1 if c<1000 else 2 if c<10000 else 3
  u=([F(21),F(20),F('19.5'),F('19.2')] if odd else [F('22.6'),F('21.1'),F('20.1'),F('19.1')])[i]
  H=ceil(200+max(F(240 if odd else 255),F('3.1416')*u*F(531600 if odd else 1063200,c)))
  V=F(5,64)*(ceil(F(64*H,5))+extra)
  ns=[]
  for theta in [64,128]:
   t=next(r for r in meta['parameters'] if r['theta']==theta and r['odd']==odd)
   need=max(2*V*t['K']/theta,V+2*t['K'],F(6))
   ns.append(max(8,1<<(ceil(need/F(5,64))-1).bit_length()))
  assert ns[0] in [ns[1],2*ns[1]]
  (same if ns[0]==ns[1] else half).append(c)
 counts.append(dict(extra=extra,same_N=len(same),half_N=len(half),same_N_conductors=same,half_N_conductors=half))
assert 4<F(3)**64
out=dict(status='PASS_EXACT_TWO_CHOICE_COMPARISON',input_sha256=hashlib.sha256(p.read_bytes()).hexdigest().upper(),rows=counts,scope='N schedules only; no output values or runtime ordering')
with Path(__file__).with_name('small_family_theta_choice_final_20261111.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps([{k:v for k,v in r.items() if not isinstance(v,list)} for r in counts],indent=2))
