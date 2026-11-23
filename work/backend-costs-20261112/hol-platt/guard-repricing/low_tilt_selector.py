"""Exact selector inequalities for the conductor-265800 comparison polynomial."""
from fractions import Fraction as F
from math import ceil, comb, log2
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
src=HERE.parents[2]/"grh-goldbach-20261120/team/high-conductor-full/selector.json"
meta=json.loads(src.read_text())
q,V=meta["q"],F(meta["V"])
out=[]
for theta in (2,4,8,64,80):
    W=q*V/theta
    eps=F(1,2**82*3**theta)
    r=F(3,8)
    assert V>=2*theta and W>=1
    K=L=X=1
    while 128*W**2*r**K>=eps: K+=1
    while 48*W*r**L>=eps: L+=1
    while F(8,3)**(2*X)<W*(2*X+L): X+=1
    delta=F(5,64)
    while delta*X>1: delta/=2
    N=8
    while N*delta<max(2*V*K/theta,V+2*K,6): N*=2
    J=ceil(N*delta*X/6)
    assert J<N//2
    n0=1
    while True:
        v=3*n0**2/W; z=3*(2*n0+1)/W-F(1,n0)
        if v>=2 and z>0 and 4*(X+1)*2*n0*(1+1/z)*r**int(v)<eps/8: break
        n0*=2
    # Compare on physical spacing 5/64 even if the proof polynomial is oversampled.
    angular=F(44,7)*J/N*F(5,64)/delta
    coeff=(2*J+1)*(2*W**2+1)
    # Normalize the derivative error from the raw sum by omega = 2pi/(N delta).
    omega_upper=F(44,7)/(N*delta)
    rows={n: round(log2(float(omega_upper*coeff*angular**n/comb(n,n//2))),3)
          for n in (8,16,32,64,96,128,192)}
    out.append(dict(theta=theta,q=q,V=str(V),W=str(W),K=K,L=L,X=X,N=N,J=J,n0=n0,
                    delta=str(delta),epsilon=str(eps),log2_normalized_interpolation_remainder=rows))
(HERE/"low-tilt-selector.json").write_text(json.dumps(out,indent=2)+"\n")
for s in out: print(s["theta"],s["X"],s["N"],s["J"],s["n0"],s["log2_normalized_interpolation_remainder"])
