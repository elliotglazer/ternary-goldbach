"""High adjacent Hurwitz nodes by shifted Taylor cells and retained finite heads."""
from fractions import Fraction
from pathlib import Path
from time import perf_counter, process_time
import hashlib
import json
import sys
import flint
from flint import acb,arb,ctx

HERE = Path(__file__).resolve().parent
Q, FIRST = 10004, 84198
M, CELLS = (64,4) if "--adaptive" in sys.argv else (32,8)
ctx.prec, ctx.threads = 224, 1


def clock():
    return (perf_counter(),process_time())


def elapsed(start):
    w,c = clock()
    return dict(wall=w-start[0],cpu=c-start[1])


def cutoff():
    term = Fraction(1)
    for k in range(1,1000):
        term *= Fraction(6580+k-1,2*CELLS*M*k)
        ratio = Fraction(6580+k,2*CELLS*M*(k+1))
        if k>=2 and ratio<1:
            tail = term*(1+Fraction(M,k-1))/(1-ratio)
            if tail < Fraction(1,2**115):
                return k,tail
    raise ValueError("no admissible cutoff")


def rounded(x):
    y = x*(1<<81)
    v = (y+arb(1)/2).floor().unique_fmpz()
    assert v is not None and abs(y-v)<arb(1)/2
    return int(v)


def run():
    begin = clock()
    kmax,tail = cutoff()
    bound = arb(tail.numerator)/tail.denominator
    radius = arb(0,bound.upper())
    assert radius.contains(bound) and radius.contains(-bound)
    widen = acb(radius,radius)
    centers = [arb(2*j+1)/(2*CELLS) for j in range(CELLS)]
    rows = []
    dt = arb(5)/64
    for i in range(4800):
        a = (2501*(1+2*(i%2))+4880*pow(6,(i//2)%40,41)+2624*pow(2,i//80,61))%Q
        alpha = arb(a)/Q
        cell = CELLS*a//Q
        delta = alpha-centers[cell]
        assert abs(delta)<=arb(1)/(2*CELLS)
        terms = []
        for n in range(M):
            x = n+alpha
            phase = -dt*x.log()
            terms.append((x.rsqrt()*acb(0,FIRST*phase).exp(),acb(0,phase).exp()))
        rows.append((a,cell,delta,terms))
    result = dict(precision=ctx.prec,threads=ctx.threads,python_flint=flint.__version__,
                  script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  first_omitted=kmax,tail=str(bound),cells=CELLS,head=M,
                  cold_head_and_step_setup=elapsed(begin),nodes=[])
    for h in [FIRST,FIRST+1]:
        start = clock()
        s = acb(arb(1)/2,dt*h)
        factors = [acb(1)]
        for k in range(kmax-1):
            factors.append(-factors[-1]*(s+k)/(k+1))
        # High derivatives multiply tiny Hurwitz values by large rising factorials.
        coeffs = [[] for b in centers]
        amplification = Fraction(1)
        for k,f in enumerate(factors):
            bits = (max(224,178+amplification.numerator.bit_length()-amplification.denominator.bit_length())
                    if "--adaptive" in sys.argv else 704)
            with ctx.workprec(bits):
                for b,vals in zip(centers,coeffs):
                    vals.append(f*(s+k).zeta(M+b))
            amplification *= Fraction(6580+k,2*CELLS*(k+1))
        setup = elapsed(start)
        start = clock()
        lines = ["index\ta\tre\tim\n"]
        for i,(a,cell,d,terms) in enumerate(rows):
            if h==FIRST:
                head = sum((t for t,_ in terms),acb(0))
            else:
                head = sum((t*step for t,step in terms),acb(0))
            poly = coeffs[cell][-1]
            for k in range(kmax-2,-1,-1):
                poly = poly*d+coeffs[cell][k]
            z = head+poly+widen
            lines.append(f"{i}\t{a}\t{rounded(z.real)}\t{rounded(z.imag)}\n")
        per_residue = elapsed(start)
        path = HERE.parent/"c10004-high-reference"/f"j{h}-source.tsv"
        reference = path.read_bytes()
        assert reference.decode().splitlines()=="".join(lines).splitlines()
        result["nodes"].append(dict(j=h,setup=setup,produce=per_residue,rows=4800,
                                    reference_sha256=hashlib.sha256(reference).hexdigest()))
        result["inclusive"]=elapsed(begin)
        target = "adaptive.json" if "--adaptive" in sys.argv else "receipt.json"
        (HERE/target).write_text(json.dumps(result,indent=2)+"\n")


if __name__ == "__main__":
    run()
