"""Independent ten-point audit. Elementary Arb only; external, not Lean.

Does not import or rerun the producer. Changes precision, EM parameters,
pole cancellation, phase propagation, and removable-point evaluation.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import comb, factorial
import hashlib, json, time
from flint import arb, acb, ctx

ctx.prec = 192
ROOT = Path(__file__).resolve().parents[1]
OUT = Path(__file__).with_suffix('.json')
PINS = {
 'mellin/GABCKE_BOUNDED_POINT_PILOT_2026-11-11.md': 'ec0d21b670f9005c65be50f1b157d0051261f6b2375cedf9ad81ca518a5a3080',
 'mellin/gabcke_bounded_point_pilot_20261111.py': '90aae865ff49e10d82532b51dd3f4cc967a4e702467be55625dfa81407fb7fda',
 'mellin/gabcke_bounded_point_pilot_20261111.json': '7944b755df307e3b03b6906869b31762d502c23d4ff6dd1ba06c655631376915',
 'mellin/gabcke_1979_corrected_2015.pdf': 'a28ae7be557f75997d1f9c48c9517247581f55ab89477181127f83e3dffbbe53',
 'audit/GABCKE_PRINCIPAL_EVALUATOR_SOURCE_REVIEW_2026-11-11.md': '55c9c07c7958df4dabcf3799705b56486103ed2afb78453865466aa2b3d7f9ed',
}
POINTS = [Q(1500), Q(12001,8), Q(10000), Q(100000), Q(500000),
 Q(1000000), Q(66213804807,1048576), Q(66875938737,1048576),
 Q(131767946333,524288), Q(263535892667,1048576)]
FLOORS = [15,15,39,126,282,398,100,100,199,200]
SIGNS = [1,1,-1,1,1,-1,1,1,1,1]

def a(q):
    q=Q(q); return arb(str(q.numerator))/q.denominator
def ends(v): return [Q(str(v.lower().fmpq())),Q(str(v.upper().fmpq()))]
def enc(v): return list(map(str,ends(v)))
def err(e): return arb(0,e.upper())
def contains(x,y): return x[0]<=y[0] and y[1]<=x[1]
def overlaps(x,y): return max(x[0],y[0])<=min(x[1],y[1])
def strict(x): return 1 if x[0]>0 else -1 if x[1]<0 else 0
def ceil(q): return -((-q.numerator)//q.denominator)

def sinc18(v):
    r=abs(v); assert r<1
    # Direct factorial coefficients, rather than producer recurrence.
    val=sum(((-1)**j)*v**(2*j)/factorial(2*j+1) for j in range(19))
    tail=r**38/factorial(39)/(1-r*r/(40*41))
    return val+err(tail)

def run():
    start=time.perf_counter()
    def budget():
        if time.perf_counter()-start>120: raise RuntimeError('120 second budget')
    pins={k:hashlib.sha256((ROOT/k).read_bytes()).hexdigest() for k in PINS}
    assert pins==PINS
    original=json.loads((ROOT/'mellin/gabcke_bounded_point_pilot_20261111.json').read_text())
    assert len(original['rows'])==10
    pi=arb.pi()
    logs=[arb(0)]
    for n in range(1,max(ceil(t/3)+32 for t in POINTS)+1):
        logs.append(arb(n).log())
        if n%4096==0: budget()
    M=36
    # Exact triangular recurrence for Bernoulli coefficients; no special API.
    bern=[Q(1)]
    for n in range(1,2*M+1):
        bern.append(-sum(Q(comb(n+1,k))*bern[k] for k in range(n))/Q(n+1))
    assert bern[2]==Q(1,6) and bern[4]==Q(-1,30)
    rows=[]
    for i,t in enumerate(POINTS):
        budget(); rowstart=time.perf_counter(); old=original['rows'][i]
        assert Q(old['t'])==t
        oldg=list(map(Q,old['gabcke'])); olde=list(map(Q,old['reference']))
        assert strict(oldg)==strict(olde)==SIGNS[i]
        assert old['gabcke_sign']==old['reference_sign']==SIGNS[i]
        assert contains(oldg,olde)
        tt=a(t); aa=(tt/(2*pi)).sqrt(); N=FLOORS[i]
        # Certify the floor by squared inequalities against a pi enclosure.
        assert 2*pi*N*N<=tt and tt<2*pi*(N+1)*(N+1)
        assert old['gabcke_metadata']['N']==N
        p=1-2*(aa-N)
        theta0=tt/2*((tt/(2*pi)).log()-1)-pi/8
        gap=1/(48*tt)+7/(5760*tt**3)+31/(80640*tt**5)
        phase_error=1/(3322*tt**7)
        theta=theta0+gap+err(phase_error)
        # Ordinary quotient at all ten points: both near-removable denominators
        # are small but certified nonzero at the increased precision.
        den=(pi*p).cos(); assert not den.contains(0)
        F=(pi*(p*p+a(Q(3,4)))/2).cos()/den
        u=abs(p)-a(Q(1,2))
        chart_overlap=None
        if abs(u)<=a(Q(1,4)):
            sd=sinc18(pi*u); assert sd>a(Q(7,8))
            chart=(1+u)*sinc18(pi*u*(1+u)/2)/(2*sd)
            chart_overlap=overlaps(ends(F),ends(chart)); assert chart_overlap
        main=2*sum((theta-tt*logs[n]).cos()/arb(n).sqrt() for n in range(1,N+1))
        rg=a(Q(47,100))/(tt.sqrt()*tt.sqrt().sqrt())
        g=main+((-1)**(N-1))*F/aa.sqrt()+err(rg)
        # Independent pole-cancelled EM, N=ceil(t/3)+31, M36.
        en=ceil(t/3)+31; B=en+1; s=acb(a(Q(1,2)),tt)
        partial=acb(0)
        for n in range(1,en+1):
            partial+=(-s*logs[n]).exp()
            if n%4096==0: budget()
        bp=(-s*logs[B]).exp()
        regular=partial+bp/2
        rising=acb(1)
        for j in range(1,2*M+1):
            rising*=s+j-1
            if j%2:
                k=(j+1)//2
                regular+=a(bern[2*k]/factorial(2*k))*rising*bp*a(Q(B)**(1-2*k))
        finite_g=(s-1)*regular+B*bp
        ez=4*abs(rising)*((a(Q(1,2))-2*M)*logs[B]).exp()/(6**(2*M)*a(Q(2*M)-Q(1,2)))
        eg=abs(s-1)*ez
        square=err(eg)
        zeta=(finite_g+acb(square,square))/(s-1)
        # Direct true-phase interval multiplication, avoiding proxy/cos division.
        ref=(acb(0,theta).exp()*zeta).real
        assert strict(ends(ref))==strict(ends(g))==SIGNS[i]
        assert contains(oldg,ends(ref))
        assert overlaps(olde,ends(ref)) and overlaps(oldg,ends(g))
        assert contains(ends(g),ends(ref))
        # Audit the producer's gap denominator independently as well.
        assert (gap+err(phase_error)).cos()>a(Q(999,1000))
        row=dict(t=str(t),N=N,sign=SIGNS[i],alternate_gabcke=enc(g),
            alternate_EM=enc(ref),EM_N=en,EM_M=M,EM_zeta_error=enc(ez),
            correction_quotient=enc(F),sinc18_overlap=chart_overlap,
            original_gabcke_contains_alternate_EM=True,
            original_reference_overlaps_alternate_EM=True,
            alternate_gabcke_contains_alternate_EM=True,seconds=time.perf_counter()-rowstart)
        rows.append(row)
        print(json.dumps(dict(index=i,t=str(t),N=N,sign=SIGNS[i],seconds=row['seconds'])),flush=True)
    # Removable point itself is tested algebraically, separately from point list.
    assert sinc18(arb(0))==1
    assert (1+arb(0))*sinc18(arb(0))/(2*sinc18(arb(0)))==a(Q(1,2))
    # Uniform denominator lower bound: sinc(v)>=1-v²/6 at |v|<=pi/4.
    assert 1-(pi/4)**2/6>a(Q(7,8))
    assert a(POINTS[8])<2*pi*200**2<a(POINTS[9])
    budget()
    result=dict(status='PASS_ALL_TEN_INDEPENDENT_EXTERNAL_POINT_CHECKS',
        precision_bits=ctx.prec,input_sha256=pins,
        script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        parameters='EM ceil(t/3)+31, M36; pole-cancelled g; direct true-phase interval; ordinary F quotient',
        rows=rows,elapsed_seconds=time.perf_counter()-start,
        scope='External interval evidence only; no zero scan, completeness, or Lean proof.')
    OUT.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({k:v for k,v in result.items() if k not in ('rows','input_sha256')},indent=2))

if __name__=='__main__': run()
