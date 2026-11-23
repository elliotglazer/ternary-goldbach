"""Cross-check a difficult interior repair on each channel and both gamma integrals."""
from fractions import Fraction as F
from hashlib import sha256
import json
from time import process_time

from flint import acb, arb, ctx, dirichlet_char
from repair import SUB, SCALE, enclosure
from phase_ends import independent_integral,ball
from grid import GRID_BITS
from spectrum import HERE,LABELS,Q,parameters,phase_and_weights


def run():
    ctx.prec,ctx.threads=228,1
    start=process_time()
    main,final,N,J,theta=parameters()
    phases,_=phase_and_weights()
    dt=arb(5)/64
    omega=2*arb.pi()/(N*dt)
    b=arb.pi()/4-theta/(final*dt)
    path=HERE/"stencils.txt"
    data=iter(path.read_text().splitlines())
    tables={}
    for i in range(int(next(data))):
        idx,order,offset,den,radius=map(int,next(data).split())
        tables[idx]=(den,radius,list(map(int,next(data).split())))
    worst={}
    for i in range(int(next(data))):
        label,at,idx,sg=map(int,next(data).split())
        xs=list(map(int,next(data).split()))
        den,radius,w=tables[idx]
        center=F(sum(a*b for a,b in zip(xs,w,strict=True)),den*(1<<GRID_BITS))
        if abs(at%SUB-SUB//2)==SUB//2-1:
            continue
        if label not in worst or abs(center)<abs(worst[label][1]):
            worst[label]=(at,center,F(radius,1<<GRID_BITS),sg)
    assert next(data,None) is None and set(worst)==set(LABELS)
    checked=[]
    for col,label in enumerate(LABELS):
        at,center,radius,sg=worst[label]
        t=dt*at/SUB
        chi=dirichlet_char(Q,label)
        k=arb(1+2*chi.parity())/2
        s=acb(arb(1)/2,t)
        pref=(((s+chi.parity())/2)*(arb(Q)/arb.pi()).log()+
              ((s+chi.parity())/2).lgamma()+b*t-k/2*arb(Q).log()).exp()
        actual=phases[col]*pref*chi.l(s)/omega
        assert actual.imag.contains(0) and (actual.real>0 if sg else actual.real<0)
        assert abs(actual.real-ball(center))<ball(radius)
        checked.append(dict(label=label,t=str(F(at*5,64*SUB)),direct=str(actual.real),interpolated=float(center),
                            difference=str(abs(actual.real-ball(center))),error_budget=float(radius)))
    gamma=[]
    for parity in (0,1):
        T,H=F(main*5,64),F(final*5,64)
        lo,hi=enclosure(Q,parity,T,H)
        independent=independent_integral(Q,parity,T,H)
        assert independent.imag.contains(0) and independent.real>ball(F(lo,SCALE)) and independent.real<ball(F(hi,SCALE))
        gamma.append(dict(parity=parity,integral=str(independent.real),lo=lo,hi=hi))
    report=dict(checks=checked,gamma=gamma,cpu=process_time()-start,input_sha256=sha256(path.read_bytes()).hexdigest())
    (HERE/"independent.json").write_text(json.dumps(report,indent=2)+"\n")
    print(checked,gamma,flush=True)


if __name__=="__main__":
    run()
