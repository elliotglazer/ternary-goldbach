"""Replay interior repairs using short integer stencils and a uniform strip bound."""
from collections import Counter
from fractions import Fraction as F
from functools import lru_cache
from hashlib import sha256
from math import ceil, frexp, isqrt, prod
from pathlib import Path
from time import process_time
import argparse
import json

from flint import arb, ctx, dirichlet_char

from endpoint_policy import HERE, HOL, TEAM, checked


ORDERS = (8, 12, 16, 20, 24, 32)
HEAD_BITS = (8, 12, 16, 20)
WEIGHT_BITS = 24
STEP = F(5, 64)


def ball(x):
    x = F(x)
    return arb(x.numerator) / x.denominator


def rational_sqrt_ceil(x):
    return isqrt((x.numerator - 1) // x.denominator) + 1


@lru_cache(None)
def mass(q, a, b, last):
    # D is uniform over the whole nonnegative source grid. Bound the damping
    # correction at the smallest D. sqrt(2)<3/2 and log(2)>2/3.
    B, p = F(2*b-1, 2), F(b+a-1, 2)
    damping_exponent = ceil(F(9,4)*p*B/(b+2))
    squared = F(q,3)**(b+a) * (b+2+last*STEP)**(b+a-1)
    return 6 * 2**damping_exponent * rational_sqrt_ceil(squared)


@lru_cache(None)
def stencil(order, x):
    nodes = range(order)
    weights = [prod((x-j)/(i-j) for j in nodes if i != j) for i in nodes]
    assert sum(weights) == 1
    scale = 1 << WEIGHT_BITS
    rounded = tuple(round(w*scale) for w in weights)
    assert all(abs(w*scale-k) <= F(1,2) for w,k in zip(weights,rounded))
    return rounded, abs(prod((x-i)*STEP for i in nodes))


def sign_test(quanta, weights, error):
    # All quantities after source rounding are integers except the rational
    # analytic error in units of the sample quantum.
    dot = sum(v*w for v,w in zip(quanta, weights, strict=True))
    remainder_units = ceil(error*(1 << WEIGHT_BITS))
    threshold = (remainder_units + sum(map(abs, weights))
                 + (sum(map(abs, quanta)) + len(quanta) + 1)//2)
    return (dot > threshold) - (dot < -threshold), remainder_units


def digest(path):
    return sha256(path.read_bytes()).hexdigest()


def run(folder, packets):
    grid = json.loads((folder/'grid.json').read_bytes())
    spec = json.loads((folder/'spectrum.json').read_bytes())
    counts = json.loads((folder/'counts.json').read_bytes())
    q, last, nfft, theta = (spec[k] for k in ('q', 'final', 'N', 'theta'))
    sub = counts['sub']
    target = F(counts['T']) * sub/STEP
    assert target.denominator == 1
    guards = [r['extra'] for r in next(iter(counts['counts'].values()))['fixed']]
    edges = {1, target-1, target+1, *(target+g*sub-1 for g in guards)}
    delta_freq = 2*arb.pi()/(nfft*ball(STEP))
    eps = ball(F(1, 4*2**80*3**theta))
    # The raw time grid rounds the approximating Fourier sum within two
    # integer units. Its analytic comparison to the completed L-function
    # is in the same (tilted, omega-divided) units.
    coarse_radius = 3*eps/(4*delta_freq) + ball(F(2,2**grid['bits']))
    population, hits, earliest = 0, Counter(), Counter()
    unresolved, channels = [], []
    for row in grid['rows']:
        label = row['label']
        a = int(dirichlet_char(q, label).parity())
        raw = list(map(int, checked(folder/f'grid-{label}.txt', row['grid_sha256']).splitlines()))
        name = f'signs-{label}.tsv'
        signs = [tuple(map(int, line.split())) for line in checked(folder/name, counts['sha256'][name]).splitlines()]
        jobs = [(t,sgn) for t,sgn in signs if t % sub and t not in edges]
        expected = next(x for x in counts['channels'] if x['label']==label)
        assert len(jobs) == expected['discovery_requests']
        power = delta_freq * arb(q)**(arb(1+2*a)/4)
        @lru_cache(None)
        def amplitude(j):
            assert 0 <= j <= last
            center = arb((raw[grid['halo']+j], -grid['bits']))
            return (center+arb(0,coarse_radius)) * power * (arb(theta*j)/last).exp()
        for tick, ref_sign in jobs:
            left, offset = divmod(tick, sub)
            population += 1
            first = None
            for order in ORDERS:
                start = min(max(0, left+1-order//2), last-order+1)
                x = F(offset,sub) + left-start
                weights, product = stencil(order, x)
                bound = min(mass(q,a,b,last) * product / F(2*b-1,2)**order for b in range(2,6))
                values = [amplitude(j) for j in range(start,start+order)]
                top = max(float(abs(v).upper()) for v in values)
                for bits in HEAD_BITS:
                    exp = frexp(top)[1]-bits
                    unit = F(2)**exp
                    integers = [int((v.mid()/ball(unit)+ball(F(1,2))).floor().unique_fmpz()) for v in values]
                    assert max(map(abs,integers)) <= 1 << bits
                    assert all(abs(v-ball(i*unit)) < ball(unit) for i,v in zip(integers,values))
                    answer, remainder_units = sign_test(integers, weights, bound/unit)
                    assert answer in (0,ref_sign)
                    if order==12 and bits==16:
                        packets.append((q,label,tick,sub,exp,WEIGHT_BITS,
                                        remainder_units,answer,*integers,*weights))
                    if answer:
                        hits[f'{order},{bits}'] += 1
                        if first is None and bits==16:
                            first = order
            earliest[str(first)] += 1
            if first is None:
                unresolved.append([label,tick])
        channels.append(dict(label=label,parity=a,jobs=len(jobs),raw_sha256=row['grid_sha256'],sign_sha256=counts['sha256'][name]))
    return dict(q=q,coarse_intervals=len(grid['rows'])*last,jobs=population,
                hits=hits,first_order_at_16_bits=earliest,unresolved=unresolved,channels=channels,
                inputs_sha256={name:digest(folder/name) for name in ('grid.json','spectrum.json','counts.json')})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    panels = parser.add_mutually_exclusive_group()
    panels.add_argument('--stress', action='store_true')
    panels.add_argument('--holdout', action='store_true')
    args = parser.parse_args()
    ctx.prec, ctx.threads = 192, 1
    started = process_time()
    folders = [HOL/'full-height-count',TEAM/'q10004-gaussian',TEAM/'high-conductor-full',
               *(TEAM/f'gaussian-panel-q{q}' for q in (65536,180180,65537,132899))]
    if args.stress:
        folders.append(TEAM/'repair-density-stress')
    if args.holdout:
        freeze = json.loads((TEAM/'stratified-180180'/'freeze.json').read_bytes())
        assert [len(group) for group in freeze['selected']]==[4,4]
        folders = [TEAM/'stratified-180180'/f'group{i}' for i in range(4)]
    packets = []
    rows = [run(f,packets) for f in folders]
    if args.holdout:
        frozen_labels = sorted(label for group in freeze['selected'] for _,a,b in group for label in (a,b))
        assert sorted(c['label'] for r in rows for c in r['channels'])==frozen_labels
    hits = sum((Counter(r['hits']) for r in rows),Counter())
    orders = sum((Counter(r['first_order_at_16_bits']) for r in rows),Counter())
    out = dict(scope='Interior repair jobs proposed by the archived Gaussian scanner. True Hardy node balls reconstructed by inverting the Gaussian scale. Interval and dyadic sign calculation is conditional on the analytic input and uniform strip bounds. Each reference sign is used only for the terminal check.',
               rows=rows,total_jobs=sum(r['jobs'] for r in rows),total_coarse_intervals=sum(r['coarse_intervals'] for r in rows),
               hits=hits,first_order_at_16_bits=orders,weight_bits=WEIGHT_BITS,cpu_seconds=process_time()-started,
               script_sha256=digest(Path(__file__)))
    suffix = '-holdout' if args.holdout else '-stress' if args.stress else ''
    packet_file = HERE/f'strip-repair-packets{suffix}.tsv'
    packet_file.write_bytes(('\n'.join('\t'.join(map(str,p)) for p in packets)+'\n').encode())
    out['packet_sha256'] = digest(packet_file)
    out['packet_columns'] = 'q label tick sub sample_quantum_exponent weight_bits exact_remainder_ceiling sign twelve_signed_samples twelve_signed_weights'
    (HERE/f'strip-repair-panel{suffix}.json').write_text(json.dumps(out,indent=2)+'\n')
    print(out['total_jobs'], out['total_coarse_intervals'], hits, orders)


if __name__ == '__main__':
    main()
