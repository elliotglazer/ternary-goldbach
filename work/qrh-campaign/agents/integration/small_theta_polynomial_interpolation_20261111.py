"""Exact metadata for one centered finite-polynomial interpolation adapter."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import hashlib, json

m=170
nodes=list(range(1-m,m+1))
M=44*(2*1250000**2+1)
ratio=Q(605,1344)
eps=Q(1,2**80*4*3**128)
checks={}
def ck(n,p):assert p,n;checks[n]=True
def enc(x):return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
ck('340_nodes',len(nodes)==340)
ck('bandwidth_halfstep',Q(242,21)*Q(5,128)==ratio<Q(1,2))
ck('mass_bound',M<2**48)
ck('uniform_taylor_remainder',M*ratio**(2*m)<eps/16)
rows=[]
for ell in range(1,8):
    theta=Q(ell,8)
    prod=Q(1)
    for j in nodes:prod*=theta-j
    weights=[]
    for j in nodes:
        denom=(-1)**(m-j)*factorial(j+m-1)*factorial(m-j)
        weights.append(prod/((theta-j)*denom))
    lam=sum(abs(v) for v in weights)
    ck(f'{ell}_constant_reproduction',sum(weights)==1)
    ck(f'{ell}_linear_reproduction',sum(w*j for j,w in zip(nodes,weights))==theta)
    ck(f'{ell}_Lebesgue_below_4',lam<4)
    # This is a metadata consistency check; general exactness is the paper identity.
    ck(f'{ell}_quadratic_reproduction',sum(w*j*j for j,w in zip(nodes,weights))==theta**2)
    rows.append({'offset':enc(theta),'Lebesgue':enc(lam),'kernel_sha256':hashlib.sha256('\n'.join(str(w) for w in weights).encode('ascii')).hexdigest().upper()})
ck('end_to_end_F_error',Q(3,4)+Q(4,64)+Q(1,16)+Q(1,16)<1)
out={'scope':'rational kernel and tail metadata only; no analytic values','nodes':nodes,'mass_upper':M,'bandwidth_halfstep_upper':enc(ratio),'eps_min':enc(eps),'remainder_upper':enc(M*ratio**(2*m)),'rows':rows,'checks':checks}
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'Lebesgue_ceil_thousandths':[(r['offset'],(Q(int(r['Lebesgue']['numerator']),int(r['Lebesgue']['denominator']))*1000).__ceil__()) for r in rows]}))
