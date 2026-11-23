"""Two neighboring fine anchors with 64 actual band-1 P27 source heights."""
import hashlib
import json
import sys
from math import factorial,gcd
from pathlib import Path
from time import perf_counter,process_time
from flint import acb,arb,fmpq

HERE=Path(__file__).resolve().parent
BASE=HERE.parent/"c10004-p20-source"
sys.path.insert(0,str(BASE))
from produce import D,N,P,Q,UNIT,GRIDS,dyadic,nearest,pair_times,plus,shifted,to_ball


def coefficients(h,s,gammas,lambdas):
    """Specialize the original normalized finite EM formula at alpha=0."""
    omega=5*h
    b=1+N
    head=[(0,0)]*P
    for x in range(1,b):
        term=dyadic(arb(x)**(-s),122)
        for k in range(P):
            head[k]=plus(head[k],term)
            if k+1<P:
                term=pair_times(term,1,0,x)
    endpoint=dyadic(arb(b)**(-s),122)
    E=[(UNIT,0)]
    for ell in range(P+126):
        E.append(pair_times(E[-1],32+64*ell,omega,64*6*b))
    rising=(UNIT,0)
    result=[]
    for k in range(P):
        correction=(0,0)
        for r,g in enumerate(gammas,1):
            correction=plus(correction,pair_times(E[k+2*r-1],g,0,UNIT))
        v=64*k-32
        Z=plus(pair_times(E[k],b*64*v,-b*64*omega,v*v+omega*omega),
               plus(pair_times(E[k],1,0,2),pair_times(correction,1,0,6)))
        F=pair_times(Z,lambdas[k],0,UNIT)
        result.append(plus(pair_times(head[k],*rising,UNIT),pair_times(endpoint,*F,UNIT)))
        rising=pair_times(rising,-(32+64*k),-omega,D*64*(k+1))
    return result


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run():
    wall,cpu=perf_counter(),process_time()
    cells={k:[a for a in range(1,Q) if gcd(a,Q)==1 and (2048*a+10003)//20008==k] for k in [0,1]}
    reference=json.loads((BASE/"h1-mixed.json").read_text())
    lambdas=[UNIT]
    for k in range(P-1):
        lambdas.append(nearest(-6*lambdas[-1],D*(k+1)))
    gammas=[]
    for r in range(1,65):
        g=fmpq.bernoulli(2*r)*6**(2*r)/factorial(2*r)
        gammas.append(nearest(int(g.p)*UNIT,int(g.q)))
    rows=[]
    max_coarse=max_eval=0.
    for h in range(1,65):
        s=acb(arb(1)/2,arb(5*h)/64)
        coef=coefficients(h,s,gammas,lambdas)
        truth=acb(1)
        for k,c in enumerate(coef):
            error=abs(truth*(s+k).zeta()-to_ball(c,122))
            assert error<arb(1)/2**102
            max_coarse=max(max_coarse,float(error.upper()))
            truth=-truth*(s+k)/(D*(k+1))
        row={"h":h,"mixed":{},"outputs":{}}
        for cell,src in [(0,coef[:20]),(1,shifted(coef))]:
            mixed=[[nearest(x,1<<(122-b)) for x in z] for z,b in zip(src,GRIDS)]
            if h==1:
                assert mixed==reference[str(cell)]
            row["mixed"][cell]=mixed
            out=[]
            for a in cells[cell]:
                num=1024*a-cell*Q
                v=mixed[-1]
                for k in range(18,-1,-1):
                    scale=num*(1<<(GRIDS[k]-GRIDS[k+1]))
                    v=plus(mixed[k],pair_times(v,scale,0,2*Q))
                err=abs(to_ball(v,94)-s.zeta(1+arb(a)/Q))
                assert 633*err<arb(1)/2**82
                max_eval=max(max_eval,float(err.upper()))
                out.append([a,*v])
            row["outputs"][cell]=out
        rows.append(row)
    data=HERE/"slab.json"
    data.write_bytes(json.dumps(dict(grids=GRIDS,cells=cells,rows=rows),separators=(",",":")).encode()+b"\n")
    receipt=dict(slab_sha256=digest(data),source_sha256=digest(Path(__file__)),
                 imported_sha256=digest(BASE/"produce.py"),coarse_pairs=64*P,heights=64,
                 checked_outputs=64*sum(map(len,cells.values())),cells=cells,
                 max_coarse_error=max_coarse,max_horner_error=max_eval,
                 cpu_seconds=process_time()-cpu,wall_seconds=perf_counter()-wall)
    (HERE/"receipt.json").write_text(json.dumps(receipt,indent=2)+"\n")


if __name__=="__main__":
    run()
