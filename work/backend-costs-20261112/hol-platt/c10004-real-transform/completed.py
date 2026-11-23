"""Enclose phase-fixed conductor-completed character values at two heights."""
import csv
import hashlib
import json
from collections import Counter
from pathlib import Path
from time import perf_counter
from flint import acb, arb, ctx

from reference import tensor

ctx.prec = 176
ctx.threads = 1
HERE = Path(__file__).resolve().parent
Q = 10004
S = 1 << 81
roots = {n: [acb.exp_pi_i(acb(2*j)/n) for j in range(n)] for n in (2,40,60)}


def dft(row):
    n = len(row)
    return [sum((z*roots[n][j*k % n] for j,z in enumerate(row)),acb(0))
            for k in range(1,n)]


def read(path):
    with path.open() as f:
        return list(csv.DictReader(f,delimiter='\t'))


def parity(k,l):
    return (1+k+l) % 2


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run():
    start = perf_counter()
    source = read(HERE.parent / 'c10004-reference/h1.tsv')
    units = [int(row['a']) for row in source]
    for j,a in enumerate(units):
        assert a%4 == 1+2*(j%2) and a%41 == pow(6,j//2%40,41) and a%61 == pow(2,j//80,61)
    tau = tensor([acb.exp_pi_i(acb(2*a)/Q) for a in units],dft)
    labels = [(k,l) for k in range(1,40) for l in range(1,60)]
    w = {p:z/(acb(0,1)**parity(*p)*arb(Q).sqrt()) for p,z in zip(labels,tau)}
    phases = {}
    charts = Counter()
    for p in labels:
        if p in phases:
            continue
        k,l = p
        partner = (40-k,60-l)
        z = w[p]
        assert abs(z).contains(1) and w[partner].overlaps(z.conjugate())
        if z.real > -arb(1)/2:
            r = ((1+z.real)/2).sqrt()
            phase = acb(r,-z.imag/(2*r))
            charts['positive_real'] += 1
        else:
            assert z.real < arb(1)/2
            r = ((1-z.real)/2).sqrt()
            phase = acb(-z.imag/(2*r),r)
            charts['positive_imaginary'] += 1
        phases[p] = phase
        if partner != p:
            phases[partner] = phase.conjugate()
        else:
            assert z.real > 0 and z.contains(1) and phase.contains(1)
    assert all((phases[p]**2*w[p]).contains(1) for p in labels)
    report = dict(precision_bits=ctx.prec,gauss_phase_seconds=perf_counter()-start,charts=charts,
                  self_inverse=[20,30],nodes=[])
    signs = {}
    for h in (1,2):
        start = perf_counter()
        s = acb(arb(1)/2,arb(h*5)/64)
        factors = []
        for a in (0,1):
            g = (s+a)/2
            factors.append((acb(Q)/arb.pi())**g*g.gamma()*acb(Q)**(-s))
        counts = Counter()
        smallest = None
        output = HERE/f'h{h}-completed.tsv'
        inputs = HERE/f'h{h}-spectrum.tsv'
        with output.open('w',newline='') as f:
            writer = csv.writer(f,delimiter='\t',lineterminator='\n')
            writer.writerow(('k41','k61','parity','sign','real_ball'))
            for p,row in zip(labels,read(inputs),strict=True):
                assert p == (int(row['k41']),int(row['k61']))
                rad = int(row['abs_error_grid_units'])
                box = acb(arb(int(row['re']),rad),arb(int(row['im']),rad))/S
                value = phases[p]*factors[parity(*p)]*box
                assert value.imag.contains(0)
                real = value.real
                sign = 1 if real>0 else -1 if real<0 else 0
                counts[sign] += 1
                signs[h,p] = sign
                margin = int((abs(real).lower()*10**12).floor().unique_fmpz())
                if smallest is None or margin < smallest[0]:
                    smallest = (margin,p)
                writer.writerow((*p,parity(*p),sign,real.str(42)))
        report['nodes'].append(dict(h=h,counts=counts,min_abs_floor_1e12=smallest,
              seconds=perf_counter()-start,bytes=output.stat().st_size,
              spectrum_sha256=digest(inputs),sha256=digest(output)))
    report['opposite_endpoint_signs'] = sum(signs[1,p]*signs[2,p]<0 for p in labels)
    print(json.dumps(report,indent=2))


if __name__ == '__main__':
    run()
