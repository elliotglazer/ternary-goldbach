"""Bounded interval contour pilot, not a Lean certificate or whole-height run.

Explicit Euler--Maclaurin with an independent coarse remainder. Arb supplies
elementary complex interval arithmetic, not the zeta evaluator in acceptance.
"""
from fractions import Fraction as F
from math import comb, factorial
from pathlib import Path
import hashlib, json, time
from flint import acb, arb, ctx

ctx.prec = 128
N, M = 80, 24
SIGMA_FLOOR = F(16, 25)

def ar(q):
    q = F(q)
    return arb(str(q.numerator)) / q.denominator

def box(a, b):
    return acb(arb(ar((a[0]+b[0])/2), ar(abs(a[0]-b[0])/2)),
               arb(ar((a[1]+b[1])/2), ar(abs(a[1]-b[1])/2)))

bern = [F(1)]
for n in range(1, 2*M+1):
    bern.append(-sum(F(comb(n+1,k))*bern[k] for k in range(n))/F(n+1))
assert bern[2] == F(1,6) and bern[4] == F(-1,30)
coeffs = [ar(bern[2*k]/factorial(2*k)) for k in range(1,M+1)]
pre = {}
for a in [F(1), F(1,3), F(2,3)]:
    b = ar(N+a)
    pre[a] = ([ar(n+a).log() for n in range(N)], b, b.log(),
              [b**(1-2*k) for k in range(1,M+1)])

def error_box(radius):
    e = arb(0, radius.upper())
    return acb(e,e)

def regular_em(s,a):
    logs,b,lb,powers = pre[a]
    poch=[acb(1)]
    for j in range(2*M):
        poch.append(poch[-1]*(s+j))
    bpower=(-s*lb).exp()
    val=sum(((-s*l).exp() for l in logs), acb(0)) + bpower/2
    val += bpower*sum((coeffs[k-1]*poch[2*k-1]*powers[k-1] for k in range(1,M+1)),acb(0))
    sigma=ar(SIGMA_FLOOR)
    rem=(4*abs(poch[2*M])*(lb*(1-sigma-2*M)).exp()
         / (6**(2*M)*(sigma+2*M-1)))
    return val+error_box(rem)

def exprel(z):
    # Entire (exp(z)-1)/z. The omitted Taylor terms are bounded uniformly.
    K=18
    term=acb(1); value=term
    for k in range(1,K+1):
        term=term*z/(k+1); value+=term
    r=abs(z)
    rem=r.exp()*r**(K+1)/factorial(K+2)
    return value+error_box(rem)

def evaluate(kind,s):
    if kind=='zetaF':
        lb=pre[F(1)][2]
        return (s-1)*regular_em(s,F(1))+((1-s)*lb).exp()
    q1=regular_em(s,F(1,3)); q2=regular_em(s,F(2,3))
    l1=pre[F(1,3)][2]; l2=pre[F(2,3)][2]
    step=l2-l1
    pole_difference=((1-s)*l1).exp()*step*exprel((1-s)*step)
    return (-s*arb(3).log()).exp()*(q1-q2+pole_difference)

def contour(kind,left,bottom,top,max_segments=30000):
    started=time.perf_counter()
    vertices=[(left,bottom),(F(2),bottom),(F(2),top),(left,top),(left,bottom)]
    accepted=[]; point_cache={}; evaluated=0; split_count=0; max_depth=0
    def point(p):
        if p not in point_cache: point_cache[p]=evaluate(kind,box(p,p))
        return point_cache[p]
    def visit(a,b,depth):
        nonlocal evaluated,split_count,max_depth
        evaluated+=1
        if evaluated>max_segments or depth>24 or time.perf_counter()-started>45:
            raise RuntimeError('bounded pilot limit reached; no contour acceptance')
        image=evaluate(kind,box(a,b))
        increment=(point(b)/point(a)).arg()
        # One convex rectangle excluding zero confines the image to an open
        # half-plane; the principal endpoint increment is then the local lift.
        if image.is_finite() and not image.contains(0) and increment.abs_upper()<3:
            accepted.append((a,b,increment))
            max_depth=max(max_depth,depth)
            return
        split_count+=1
        mid=((a[0]+b[0])/2,(a[1]+b[1])/2)
        visit(a,mid,depth+1); visit(mid,b,depth+1)
    for a,b in zip(vertices,vertices[1:]): visit(a,b,0)
    angle=sum((v[2] for v in accepted),arb(0))
    winding=angle/(2*arb.pi())
    assert winding.contains(0) and winding>-ar(F(1,4)) and winding<ar(F(1,4))
    # The argument-principle theorem is mathematical justification, not a
    # kernel-checked component of this Python pilot.
    return {'function':kind,'rectangle':[[str(left),str(bottom)],['2',str(top)]],
            'accepted_segments':len(accepted),'evaluations':evaluated,
            'subdivisions':split_count,'max_depth':max_depth,
            'winding_ball':str(winding),'isolated_winding_integer':0,
            'wall_seconds':time.perf_counter()-started,
            'partition':[{'a':[str(z) for z in a],'b':[str(z) for z in b]} for a,b,_ in accepted]}

def main():
    # Independent reference agreement is a diagnostic, not acceptance input.
    references=[]
    for kind in ['zetaF','chi3']:
        for t in [0,1,10,20]:
            s=acb(ar(F(2,3)),t)
            reference=(s-1)*s.zeta() if kind=='zetaF' else (-s*arb(3).log()).exp()*(s.zeta(acb(ar(F(1,3))))-s.zeta(acb(ar(F(2,3)))))
            assert evaluate(kind,s).overlaps(reference)
            references.append({'function':kind,'height':t,'overlap':True})
    assert evaluate('zetaF',acb(1)).contains(1)
    rows=[contour('zetaF',F(2,3),F(0),F(20)),contour('chi3',F(16,25),F(0),F(20))]
    # High-height point only: never counted as a contour or zero-free interval.
    started=time.perf_counter(); high=acb(ar(F(2,3)),40000000).zeta()
    high_point={'height':40000000,'real_part':'2/3','enclosure':str(high),
                'wall_seconds':time.perf_counter()-started,'kind':'builtin point diagnostic only'}
    out={'status':'PASS_EXTERNAL_INTERVAL_PILOT_ONLY','precision_bits':ctx.prec,'N':N,'M':M,
         'sigma_floor':str(SIGMA_FLOOR),'reference_checks':references,'contours':rows,
         'high_point':high_point,'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    path=Path(__file__).with_suffix('.json');path.write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps({**out,'contours':[{k:v for k,v in row.items() if k!='partition'} for row in rows]},indent=2))

if __name__=='__main__':main()
