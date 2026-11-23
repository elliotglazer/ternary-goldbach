"""Create p81 coefficient centers for the published two-chart completion."""
import sys
from time import perf_counter
from pathlib import Path

here = Path(__file__).resolve().parent
native = here.parent/'c10004-real-transform'
sys.path.insert(0, str(native))
from completed import Q, S, acb, arb, ctx, dft, parity, read, tensor

started = perf_counter()
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


with (here/'phases.tsv').open('w',newline='\n') as out:
    for p in labels:
        out.write(f'{center(phases[p].real)}\t{center(phases[p].imag)}\n')

print("native_phase_seconds",perf_counter()-started)
for h in (1,2):
    started = perf_counter()
    s = acb(arb(1)/2,arb(5*h)/64)
    vals = []
    for parity_id in (0,1):
        g = (s+parity_id)/2
        f = (acb(Q)/arb.pi())**g*g.gamma()*acb(Q)**(-s)
        vals.extend([center(f.real),center(f.imag)])
    spectra = read(native/f'h{h}-spectrum.tsv')
    decisions = read(native/f'h{h}-completed.tsv')
    mask = 0
    for j,(p,row) in enumerate(zip(labels,decisions,strict=True)):
        assert parity(*p) == (1-j%2) == int(row['parity'])
        sign = int(row['sign'])
        assert sign in (-1,1)
        mask += (sign == 1) << j
    radius = max(int(row['abs_error_grid_units']) for row in spectra)
    (here/f'h{h}-params.tsv').write_text('\t'.join(map(str,[*vals,radius,mask]))+'\n')

    print("native_height_seconds",h,perf_counter()-started)
