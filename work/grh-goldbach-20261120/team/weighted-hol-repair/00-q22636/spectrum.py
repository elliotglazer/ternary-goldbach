"""Enclose two conjugate pairs of genuine tilted Gaussian spectra on the selected grid."""
from fractions import Fraction
from hashlib import sha256
import json
from pathlib import Path
import sys
from time import process_time, perf_counter

from flint import acb, arb, ctx, dirichlet_char

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent/"small-character-kernel"))
from plan import SOURCE

Q = 22636
BASE_LABELS = (4647,)
LABELS = tuple(l for b in BASE_LABELS for l in (b, pow(b, -1, Q)))
BITS = 256
SCALE = 1 << BITS


def parameters():
    return 38644, 39284, 262144, 34134, 64

def phase_and_weights():
    chars = [dirichlet_char(Q, l) for l in LABELS]
    assert [c.parity() for c in chars] == [0,0] and all(c.is_primitive() for c in chars)
    roots = [acb.exp_pi_i(acb(2*r)/Q) for r in range(Q)]
    tables = [[c(n) for n in range(Q)] for c in chars]
    phases = []
    for c, table in zip(chars, tables):
        W = sum((v*r for v,r in zip(table,roots)), acb(0)) / (arb(Q).sqrt() * acb(0,1)**c.parity())
        assert abs(W).contains(1) and not W.imag.contains(0)
        phase = 1/W.sqrt()
        assert (phase**2*W).contains(1) and abs(phase).contains(1)
        phases.append(phase)
    for a,b in ((0,1),):
        assert all(x.conjugate().overlaps(y) for x,y in zip(tables[a], tables[b]))
    return phases, tables


def coordinate(v):
    a = int((v.mid()*SCALE).floor().unique_fmpz())
    assert abs(v*SCALE-a)<2
    return a


def run():
    ctx.prec, ctx.threads = 400, 1
    start, cpu = perf_counter(), process_time()
    main, final, nfft, J, theta = parameters()
    V = arb(5*final)/64
    omega = 2*arb.pi()/(arb(5*nfft)/64)
    b = arb.pi()/4-theta/V
    radial = arb.pi()/Q*acb((2*theta/V).sin(),(2*theta/V).cos())
    phases, tables = phase_and_weights()
    parity = [dirichlet_char(Q,l).parity() for l in LABELS]
    weights = [[z*(n if parity[h] else 1) for n,z in enumerate(col)] for h,col in enumerate(tables)]
    largest = terms = empty = 0
    eps = Fraction(1, (1<<80)*4*3**theta)
    assert Fraction(44*3, SCALE) < eps/32 and 8*(2*J+1) < 44*Fraction(5*nfft,64)
    with (HERE/"coefficients.tsv").open("w",newline="\n") as out:
        for j in range(J+1):
            x = omega*j
            z = radial * (2*x).exp()
            d = z.real
            # Even and odd tails are both bounded by the sum of n exp(-d*n*n).
            m = 0 if d>256 else int((256/d).sqrt().upper().ceil().unique_fmpz())
            largest = max(largest,m)
            assert m<Q and d*(m+1)**2 > 256
            r = arb(m+2)/(m+1)*(-d*(2*m+3)).exp()
            assert r<1
            tail = (m+1)*(-d*(m+1)**2).exp()/(1-r)
            sums = [acb(0) for _ in LABELS]
            if m == 0:
                empty += 1
            else:
                second = (-8*z).exp()
                # Exact exponent differences along each residue class modulo 10.
                # Restart both powers every 24 terms to limit interval wrapping.
                for residue in (1,):
                    for i0 in range(residue,m+1,48):
                        power = (-z*i0**2).exp()
                        ratio = (-z*(4*i0+4)).exp()
                        for i in range(i0,min(i0+48,m+1),2):
                            for h,w in enumerate(weights):
                                sums[h] += power*w[i]
                            terms += 1
                            power,ratio = power*ratio,ratio*second
            row = [j]
            for h,total in enumerate(sums):
                k = arb(1+2*parity[h])/2
                pref = 2*phases[h] * (k*acb(x-arb(Q).log()/2,b)).exp()
                err = abs(pref)*tail
                prod = pref*total + acb(arb(0,err),arb(0,err))
                if j == 0:
                    assert prod.imag.contains(0)
                row.extend((coordinate(prod.real), coordinate(prod.imag) if j else 0))
            out.write("\t".join(map(str,row))+"\n")
            if j % 8192 == 0:
                print(j, round(process_time()-cpu,2),flush=True)
    report = dict(q=Q,labels=LABELS,main=main,final=final,N=nfft,J=J,theta=theta,bits=BITS,
                  recurrence_terms=terms,empty=empty,largest_m=largest,
                  cpu_seconds=process_time()-cpu,wall_seconds=perf_counter()-start,
                  sha256={p.name:sha256(p.read_bytes()).hexdigest() for p in [Path(__file__),HERE/"coefficients.tsv"]})
    (HERE/"spectrum.json").write_text(json.dumps(report,indent=2)+"\n")
    print(report,flush=True)


if __name__ == "__main__":
    run()
