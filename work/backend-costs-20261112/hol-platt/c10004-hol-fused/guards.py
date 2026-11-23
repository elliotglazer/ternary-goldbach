"""Create p81 coefficient centers for the published two-chart completion."""
import sys
from pathlib import Path

here = Path(__file__).resolve().parent
native = here.parent/'c10004-real-transform'
sys.path.insert(0, str(native))
from completed import Q, S, acb, arb, ctx, dft, parity, read, tensor

units = [int(row['a']) for row in read(here.parent/'c10004-reference/h1.tsv')]
labels = [(k,l) for k in range(1,40) for l in range(1,60)]
gauss = tensor([acb.exp_pi_i(acb(2*a)/Q) for a in units],dft)
phases = {}
for p,t in zip(labels,gauss,strict=True):
    if p in phases:
        continue
    w = t/(acb(0,1)**parity(*p)*arb(Q).sqrt())
    if w.real > -arb(1)/2:
        r = ((1+w.real)/2).sqrt()
        phase = acb(r,-w.imag/(2*r))
    else:
        assert w.real < arb(1)/2
        r = ((1-w.real)/2).sqrt()
        phase = acb(-w.imag/(2*r),r)
    partner = (40-p[0],60-p[1])
    phases[p] = phase
    if partner != p:
        phases[partner] = phase.conjugate()

def center(x):
    a = x*S
    n = int((a+arb(1)/2).floor().unique_fmpz())
    assert abs(a-n) < arb(1)/2
    return n

for h in [1,2]:
    s = acb(arb(1)/2,arb(5*h)/64)
    factors = []
    for a in (0,1):
        g = (s+a)/2
        factors.append((acb(Q)/arb.pi())**g*g.gamma()*acb(Q)**(-s))
    spectra = read(native/f'h{h}-spectrum.tsv')
    decisions = read(native/f'h{h}-completed.tsv')
    with (here/f'h{h}-guards.tsv').open('w',newline='\n') as out:
        for p,spec,dec in zip(labels,spectra,decisions,strict=True):
            assert p == (int(spec['k41']),int(spec['k61'])) == (int(dec['k41']),int(dec['k61']))
            coeff = phases[p]*factors[parity(*p)]
            a,b = center(coeff.real),center(coeff.imag)
            e,sign = int(spec['abs_error_grid_units']),int(dec['sign'])
            assert sign in (-1,1) and e >= 0
            out.write(f'{a}\t{b}\t{e}\t{sign}\n')
