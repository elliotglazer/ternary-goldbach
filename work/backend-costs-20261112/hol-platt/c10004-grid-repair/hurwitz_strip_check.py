"""Independently bound the same normalized Hurwitz stencil by Hardy strip estimates."""
from fractions import Fraction as F
from hashlib import sha256
import json
from math import prod
from pathlib import Path
import sys

from flint import arb, ctx

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE.parent/'guard-repricing'))
from strip_interpolation import remainder, real


def main():
    ctx.prec=256
    source=HERE/'hurwitz-stencil.json'
    data=json.loads(source.read_bytes())
    first,last,k=data['first'],data['last'],data['left']
    nodes=range(first,last+1)
    x=F(2*k+1,2)
    weights=[prod((x-j)/(i-j) for j in nodes if j!=i) for i in nodes]
    vals=list(map(arb,data['coarse_samples']))
    dot=sum((real(w)*v for w,v in zip(weights,vals,strict=True)),arb(0))
    dt=F(5,64)
    product=real(abs(prod((x-i)*dt for i in nodes)))
    b=18
    rho=F(2*b-1,2)
    parity=(1+21+33)%2
    alpha=real(F(64,84839*dt))
    # Recheck the row-dependent sufficient conditions inherited from the
    # even-conductor theta=64 coefficient and time-periodization bounds.
    V,P,Wbar=84839*dt,524288*dt,F(80000000,64)
    eps=F(1,4*2**80*3**64)
    K=next(k for k in range(1,1000) if 32*Wbar**2*F(3,8)**k < eps/4)
    L=next(k for k in range(1,1000) if 12*Wbar*F(3,8)**k < eps/4)
    assert V>=128 and 1<=10004*V/64<=Wbar
    assert F(8,3)**20 >= Wbar*(20+L)
    assert P>=max(2*V*K/64,V+2*K,6) and 68267==(25*524288+191)//192
    n0=8192
    v0=3*n0**2/Wbar
    z0=3*(2*n0+1)/Wbar-F(1,n0)
    assert v0>=2 and z0>0 and 44*2*n0*(1+1/z0)*F(3,8)**(v0//1)<eps/8
    omega=2*arb.pi()/real(524288*dt)
    # For a complex t on a Cauchy circle centred at any stencil ordinate,
    # Re(t) >= first*dt-rho. The remaining normalization is constant.
    tilt=(-alpha*real(first*dt-rho)-(1+2*parity)*arb(10004).log()/4).exp()/omega
    error=remainder(len(nodes),b,parity,nodes,product)*tilt
    midpoint=dot+arb(0,error.upper())
    direct=arb(data['direct'])
    assert midpoint*data['signs'][1]>0 and midpoint.overlaps(direct)
    report=dict(order=len(nodes),b=b,rho=str(rho),normalized_remainder=error.str(45),
                gaussian_parameters=dict(K=K,L=L,V=str(V),P=str(P),qV=str(10004*V),Wbar=str(Wbar)),
                midpoint=midpoint.str(45),direct=direct.str(45),signs=data['signs'],
                hashes={p.name:sha256(p.read_bytes()).hexdigest() for p in
                        (source,HERE.parent/'guard-repricing/strip_interpolation.py',
                         HERE.parent/'dispatched-score/LARGE_HARDY_DERIVATIVE_AUDIT.md',Path(__file__))})
    (HERE/'hurwitz-strip-check.json').write_text(json.dumps(report,indent=2)+'\n')
    print(report['normalized_remainder'],report['midpoint'],flush=True)


if __name__=='__main__':
    main()
