"""Exact rational allocations and coarse logarithm witnesses; no prime or L evaluation."""
from pathlib import Path
from fractions import Fraction as F
import json

A=10**16
H0=4*10**10
U=3163*10**10*63**2
assert (3163*10**10)**2>10**27
def ceil(q): return -((-q.numerator)//q.denominator)
def alloc(q): return 2*max(A,ceil(U*(F(31,1000)+F(2261,1000)/q)+3))
def log_witness(n,k,lo,hi):
    # log n = 2 sum_{j>=0} z^(2j+1)/(2j+1), z=(n-1)/(n+1).
    z=F(n-1,n+1)
    lower=2*sum((z**(2*j+1)/F(2*j+1) for j in range(k)),F(0))
    upper=lower+2*z**(2*k+1)/((2*k+1)*(1-z*z))
    assert lo<lower and upper<hi
    return {"n":n,"terms":k,"lower":str(lower),"upper":str(upper)}
logs=[log_witness(2,8,F(69,100),F(7,10)),
      log_witness(3,8,F(109,100),F(11,10)),
      log_witness(10,32,F(23,10),F(231,100))]
assert F(231,100)<F(7,3) # Thus log(10^27)<63.
bounds={}
for q in (1,2,4,8,16,32):
    k=q.bit_length()-1
    bounds[q]=(F(2+k)*F(69,100)+10*F(23,10),
               F(2+k)*F(7,10)+10*F(231,100))
# 45<47<48, log45=2log3+log10-log2; log48=4log2+log3.
bounds[47]=(F(69,100)+11*F(23,10)+2*F(109,100),
            6*F(7,10)+10*F(231,100)+F(11,10))
bounds[48]=(6*F(69,100)+10*F(23,10)+F(109,100),
            6*F(7,10)+10*F(231,100)+F(11,10))
bounds[50]=(F(69,100)+12*F(23,10),F(7,10)+12*F(231,100))
qs=(1,2,4,8,16,32,47,48,50)
rows=[]
for q in qs:
    a=F(31,1000)+F(2261,1000*q)
    B=alloc(F(q))
    margin=B-4-2*a*U
    assert B%2==0 and B>=2*A and margin>=2
    rows.append({"Q":q,"H":H0*q,"a":str(a),"B":B,
                 "gap_margin_lower":str(margin),
                 "log_H_lower":str(bounds[q][0]),"log_H_upper":str(bounds[q][1])})
assert alloc(F(46))>2*A and alloc(F(47))==2*A
qsat=F(2261*U,1000*(A-3)-31*U)
assert 46<qsat<47 and alloc(qsat)==2*A
switch=[]
active=(1,2,4,8,16,32,47)
for q,r in zip(active,active[1:]):
    db=F(alloc(F(q))-alloc(F(r)),A)
    dslo=r*bounds[r][0]-q*bounds[q][1]
    dshi=r*bounds[r][1]-q*bounds[q][0]
    assert 0<dslo<dshi
    lo,hi=db/dshi,db/dslo
    # Outward intervals on a 1e-6 grid, for readable display only.
    scale=10**6
    loint=(lo*scale).numerator//(lo*scale).denominator
    hiint=ceil(hi*scale)
    switch.append({"Q_low":q,"Q_high":r,"lambda_lower":str(lo),"lambda_upper":str(hi),
                   "outward_lower_millionths":loint,"outward_upper_millionths":hiint})
for a,b in zip(switch,switch[1:]):
    assert F(a["lambda_lower"])>F(b["lambda_upper"])
out={"scope":"Conditional frontier coefficients, exact integer/rational allocation and coarse log-inequality witnesses only; no spectral or prime certificate.",
     "A":A,"N":10**27,"H0":H0,"U":U,"rows":rows,
     "saturation_Q":str(qsat),"switches":switch,"log_witnesses":logs}
Path(__file__).with_suffix(".json").write_text(json.dumps(out,indent=2)+"\n",encoding="utf-8")
print(json.dumps({"U":U,"rows":rows,"saturation_Q":str(qsat),"switches":switch},indent=2))
