"""Project genuine Hurwitz residue balls on one frequency and repair one fixed midpoint."""
from fractions import Fraction as F
from hashlib import sha256
from math import ceil, comb, prod
from pathlib import Path
from time import perf_counter, process_time
import csv
import gzip
import json

from complete import phases, factors, comp
from flint import acb, arb, ctx

HERE = Path(__file__).resolve().parent
Q, LEFT, PAIR = 10004, 84184, (21, 33)
ORDER, M, CELLS = 160, 64, 4
N, J, LAST, THETA = 524288, 68267, 84839, 64
FIRST, STOP = LEFT - ORDER//2 + 1, LEFT + ORDER//2
HEIGHT_BOUND = ceil(F(5*STOP,64)) + 1


def ball(x):
    return arb(x.numerator)/x.denominator


def cutoff():
    term = F(1)
    for k in range(1,1000):
        term *= F(HEIGHT_BOUND+k-1,2*CELLS*M*k)
        ratio = F(HEIGHT_BOUND+k,2*CELLS*M*(k+1))
        if k > 1 and ratio < 1:
            tail = term*(1+F(M,k-1))/(1-ratio)
            if tail < F(1,2**115):
                return k,tail
    raise ArithmeticError('no tail bound')


def main():
    ctx.prec,ctx.threads = 224,1
    wall,cpu=perf_counter(),process_time()
    _,phase=phases()
    kmax,tail=cutoff()
    dt=arb(5)/64
    omega=2*arb.pi()/(N*dt)
    parity=comp.parity(*PAIR)
    def scale(t):
        return (-THETA*t/(LAST*dt)-(1+2*parity)*arb(Q).log()/4).exp()/omega
    centers=[arb(2*i+1)/(2*CELLS) for i in range(CELLS)]
    moments=[[acb(0) for _ in range(kmax)] for _ in centers]
    terms,steps=[],[]
    for i in range(4800):
        a=(2501*(1+2*(i%2))+4880*pow(6,(i//2)%40,41)+2624*pow(2,i//80,61))%Q
        character=comp.roots[2][i%2]*comp.roots[40][(i//2*PAIR[0])%40]*comp.roots[60][(i//80*PAIR[1])%60]
        alpha=arb(a)/Q
        cell=CELLS*a//Q
        delta=alpha-centers[cell]
        assert abs(delta)<=arb(1)/(2*CELLS)
        v=character
        for k in range(kmax):
            moments[cell][k]+=v
            v=v*delta
        for l in range(M):
            x=l+alpha
            step_exp=acb(0,-dt*x.log())
            terms.append(character*x.rsqrt()*(FIRST*step_exp).exp())
            steps.append(step_exp.exp())
    radius=arb(0,(4800*ball(tail)).upper())
    nodes=[]
    for h in range(FIRST,STOP+1):
        t=h*dt
        s=acb(arb(1)/2,t)
        assert abs(s)<HEIGHT_BOUND
        if h!=FIRST:
            terms=[v*w for v,w in zip(terms,steps,strict=True)]
        total=sum(terms,acb(0))+acb(radius,radius)
        factor=acb(1)
        amp=F(1)
        for k in range(kmax):
            bits=max(224,178+amp.numerator.bit_length()-amp.denominator.bit_length())
            with ctx.workprec(bits):
                for c,b in enumerate(centers):
                    total+=moments[c][k]*factor*(s+k).zeta(M+b)
            factor=-factor*(s+k)/(k+1)
            amp*=F(HEIGHT_BOUND+k,2*CELLS*(k+1))
        v=phase[PAIR]*factors(t)[parity]*acb(Q)**(-s)*total*scale(t)
        assert v.imag.contains(0)
        nodes.append(v.real)
        if len(nodes)%16==0:
            print('certified coarse samples',len(nodes),'of',ORDER,flush=True)
    offsets=range(1-ORDER//2,1+ORDER//2)
    weights=[prod(F(1-2*j,2*(i-j)) for j in offsets if j!=i) for i in offsets]
    norm=sum(map(abs,weights))
    assert sum(weights)==1 and norm < 5
    dot=sum((v*ball(w) for v,w in zip(nodes,weights,strict=True)),arb(0))
    B=2*F(80000000,THETA)**2+1
    rem=(2*J+1)*B*F(44*J,7*N)**ORDER/comb(ORDER,ORDER//2)
    eps=F(1,4*(1<<80)*3**THETA)
    model_error=3*eps*F(5*N,64)/24
    error=rem+(1+norm)*model_error
    interpolated=dot+arb(0,ball(error).upper())
    ends=nodes[LEFT-FIRST:LEFT-FIRST+2]
    def sign(v):
        return 1 if v>0 else -1 if v<0 else 0
    signs=[sign(ends[0]),sign(interpolated),sign(ends[1])]
    assert signs[0]==signs[2] and signs[1]==-signs[0] and signs[1]!=0
    # Withheld until the stencil and strict result are fixed.
    archive=HERE/'high-midpoints.tsv.gz'
    with gzip.open(archive,'rt') as f:
        row=next(r for r in csv.DictReader(f,delimiter='\t') if
                 (int(r['left_j']),int(r['k41']),int(r['k61']))==(LEFT,*PAIR))
    direct=arb(row['scaled_value'])*scale((LEFT+arb(1)/2)*dt)
    assert int(row['sign'])==signs[1] and direct.overlaps(interpolated)
    # Independent coarse source files in the same gauge also overlap.
    coarse=HERE/'high-signs.tsv.gz'
    overlaps=0
    with gzip.open(coarse,'rt') as f:
        for r in csv.DictReader(f,delimiter='\t'):
            h=int(r['j'])
            if (int(r['k41']),int(r['k61']))==PAIR and FIRST<=h<=STOP:
                assert nodes[h-FIRST].overlaps(arb(r['scaled_value'])*scale(h*dt))
                overlaps+=1
    assert overlaps==16
    data=dict(q=Q,frequencies=PAIR,left=LEFT,offset='1/2',order=ORDER,first=FIRST,last=STOP,
              height_bound=HEIGHT_BOUND,first_omitted=kmax,per_residue_tail=str(tail),
              norm=str(norm),polynomial_remainder=str(ball(rem)),uniform_model_error=str(ball(model_error)),
              radii_budget=str(ball(error)),dot=str(dot),interpolated=str(interpolated),
              direct=str(direct),signs=signs,coarse_overlaps=overlaps,coarse_samples=[v.str(45) for v in nodes],
              wall_s=perf_counter()-wall,cpu_s=process_time()-cpu,
              hashes={p.name:sha256(p.read_bytes()).hexdigest() for p in
                      (Path(__file__),HERE/'high.py',HERE/'complete.py',coarse,archive)})
    (HERE/'hurwitz-stencil.json').write_text(json.dumps(data,indent=2)+'\n')
    print('verified',signs,data['interpolated'],data['direct'],flush=True)


if __name__=='__main__':
    main()
