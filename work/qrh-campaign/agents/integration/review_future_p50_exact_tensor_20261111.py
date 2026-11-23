"""Fixed formal identities/endpoints only. No candidate or metadata enumeration."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
HERE=Path(__file__).resolve().parent;AG=HERE.parent;ROOT=HERE.parents[3]
def sha(b):return hashlib.sha256(b).hexdigest().upper()
checks=[]
def ck(s,x):
 assert x,s
 checks.append(s)
pins={
 'zero-sum/FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md':'F0B7399E638A7EBD43FE37F9EAAD8DCFB0583FEA785F7425D9DAFF096D464DE6',
 'zero-sum/future_p50_exact_tensor_selector_20261111.py':'6E7B3593AA50756DC3DD70EF17E8D7B92091423D49A0D0EE7147F0186935618F',
 'zero-sum/future_p50_exact_tensor_selector_20261111.json':'4EA4510B7552F07E3B38ACEF9A18B5689ACDE47F1CB6DB702960FE6621C94982',
}
for p,h in pins.items():ck('pin '+p,sha((AG/p).read_bytes())==h)
receipt=json.loads((AG/'zero-sum/future_p50_exact_tensor_selector_20261111.json').read_bytes())
for p,h in receipt['source_pins'].items():ck('source '+p,sha((AG/p).read_bytes())==h)
blue=ROOT/'work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md'
ck('blueprint pin',sha(blue.read_bytes())==receipt['blueprint_pin'])
# Formal polynomials in T,S,a,b,rho, independent coefficient expansion.
def add(*ps):
 d={}
 for p in ps:
  for k,v in p.items():d[k]=d.get(k,0)+v
 return {k:v for k,v in d.items() if v}
def neg(p):return {k:-v for k,v in p.items()}
def mul(p,q):
 d={}
 for k,v in p.items():
  for l,w in q.items():
   z=tuple(x+y for x,y in zip(k,l));d[z]=d.get(z,0)+v*w
 return {k:v for k,v in d.items() if v}
T={(1,0,0,0,0):1};S={(0,1,0,0,0):1};a={(0,0,1,0,0):1};b={(0,0,0,1,0):1};r={(0,0,0,0,1):1}
W={(1,0,0,1,1):1,(0,1,0,1,1):-1,(1,1,1,0,0):1}
ck('positive common denominator numerator',W==add(mul(mul(r,b),add(T,neg(S))),mul(mul(a,S),T)))
sq=mul(W,W)
ck('square keeps VS*T and cross terms',sq=={
 (2,0,0,2,2):1,(1,1,0,2,2):-2,(2,1,1,1,1):2,
 (0,2,0,2,2):1,(1,2,1,1,1):-2,(2,2,2,0,0):1})
ck('S0 common numerator',{k:v for k,v in W.items() if k[1]==0}=={(1,0,0,1,1):1})
ck('intrinsic doubling monotonic numerator',add(add(T,T,neg(S)),neg(add(T,neg(S))))==T)
Sg=202305920;Cg=1266*Sg*16384
ck('p50 tensor denominator positive',F(Sg,2**50)<F(1,2**22)<1)
ck('old safety at50',max(29961461170177,2*424706204)<2**50)
ck('fallback reciprocal <=2',F(Sg,2**108)<F(1,2))
ck('target fixed',Cg==4196258524692480)
ck('common V example atfloor',F(8827)+F(1,2**50)<8828<16384)
ck('grid shift endpoint',100-50==50 and 108-100==8)
ck('root gaps endpoints',110-108==2 and 110-50==60)
ck('unit Euclidean margin',F(1,2)<F(3,4)**2 and F(1,4)+F(3,4)==1)
ck('unit integer output bound',F(1,4)+F(1,2)<1)
ck('converter destination completeness',8826+F(1,2**51)<2**14)
ck('converter raw left',2**114+2**49<2**115)
ck('converter raw right',2**114+2**50-1<2**115)
ck('converter doubled raw',2*(2**115-1)<2**116)
ck('remainder50 partial byte',divmod(50,8)==(6,2))
ck('unsigned adder core only',4*(2*((115+7)//8)+1)==124)
ck('root high magnitude capacity',2**110+1<2**111)
ck('root raw subtraction',2**110+1+2**110<2**112)
ck('root doubled raw',2*(2**110+1+2**110)<2**113)
ck('root floor with checked q range',2**110+2**61-1<2**111)
ck('accepted root signed widths',2**59<2**60 and 2**60<2**61)
ck('root remainder/double bytes',(60+7)//8==8 and (61+7)//8==8)
ck('candidate count and encoding',108-50+1==59 and 58<64 and 64-59==5)
tail=F(927193523,10**9*2**46)
fixed=tail+135*(F(1,2**82)+4*F(1,2**63))+10*F(1,2**54)+93*F(1,2**55)+F(1,2**51)
ratio=(fixed+135*F(Cg,2**108))*2**45
ck('exact complete ceiling',ratio==F(2804840254168152529,4294967296000000000))
ck('old complete target',ratio<F(653052762,10**9)<F(691,1024))
result={'checks':len(checks),'assertions':checks,'artifact_pins':pins,'source_pins':receipt['source_pins'],
 'blueprint_pin':receipt['blueprint_pin'],'R108_ratio':[ratio.numerator,ratio.denominator],
 'scope':'Fixed symbolic identities, endpoints and hashes only; no precision enumeration, inventory, producer values or assignment.',
 'pending_692_consumed':False}
raw=(json.dumps(result,indent=2,sort_keys=True)+'\n').encode()
assert len(raw)<16384
with (HERE/'review_future_p50_exact_tensor_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps({'checks':len(checks),'bytes':len(raw),'sha256':sha(raw)}))
