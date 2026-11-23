"""Compare dense and screened native repair discovery on previously counted grids.

The screen proposes candidates. Every retained repair still needs the original
sign certificate and a successful Turing test. A failed test can use the dense
search. This experiment charges neither of those proof stages to discovery.
"""
from fractions import Fraction
from hashlib import sha256
from math import comb
from pathlib import Path
from statistics import median
from time import process_time_ns
import argparse
import json
import sys

import numpy as np


HERE = Path(__file__).resolve().parent
HOL = HERE.parent
TEAM = HOL.parents[1] / 'grh-goldbach-20261120' / 'team'
sys.path[:0] = [str(TEAM / 'q10004-gaussian'), str(HOL / 'one-character-completeness'),
                str(HOL / 'small-character-kernel')]
import repair as reference


def bernstein_stencils(nodes):
    """Control values on [0,1] for the polynomial interpolating the given nodes."""
    degree = len(nodes) - 1
    columns = []
    for node in nodes:
        power = [Fraction(1)]
        for other in nodes:
            if node == other:
                continue
            nxt = [Fraction(0)] * (len(power) + 1)
            for j, a in enumerate(power):
                nxt[j] -= a * other / (node - other)
                nxt[j + 1] += a / (node - other)
            power = nxt
        columns.append([sum(power[k] * Fraction(comb(j, k), comb(degree, k))
                            for k in range(j + 1)) for j in range(degree + 1)])
    rows = list(zip(*columns))
    assert all(sum(row) == 1 for row in rows)
    assert rows[0][nodes.index(0)] == rows[-1][nodes.index(1)] == 1
    return np.array(rows, dtype=float)


NODES = list(range(-3, 5))
ROWS = bernstein_stencils(NODES)
KERNELS = [np.array(reference.weights(16, k, 32), dtype=float) for k in range(1, 32)]


def candidate_cells(data, halo, last):
    window = data[halo + NODES[0]:halo + last + NODES[-1]]
    control = np.array([np.correlate(window, row, 'valid') for row in ROWS])
    signs = control > 0
    changes = np.count_nonzero(signs[1:] != signs[:-1], axis=0)
    # Extra sign variations of the interpolant, or a control value sufficiently
    # near zero, warrant the full 1/32 search. This padding is heuristic.
    near_zero = np.min(np.abs(control), axis=0) <= 0.002 * np.max(np.abs(control), axis=0)
    return np.flatnonzero((changes > (signs[0] != signs[-1])) | near_zero)


def screened_discover(raw, last, halo, bits, sub):
    data = np.array([float(v) / (1 << bits) for v in raw])
    cells = candidate_cells(data, halo, last)
    indices = halo + cells
    stencils = np.array([data[indices + offset] for offset in range(-7, 9)])
    values = np.empty((33, len(cells)))
    values[0], values[-1] = data[indices], data[indices + 1]
    for k, kernel in enumerate(KERNELS, 1):
        values[k] = np.einsum('i,ij->j', kernel, stencils, optimize=False)
    signs = values > 0
    switches = np.count_nonzero(signs[:-1] != signs[1:], axis=0)
    jobs = set()
    for col in np.flatnonzero(switches > (signs[0] != signs[-1])):
        turns = np.flatnonzero(signs[1:, col] != signs[:-1, col]) + 1
        for lo, hi in zip(turns, turns[1:]):
            k = lo + int(np.argmax(np.abs(values[lo:hi, col])))
            jobs.add(int(cells[col]) * sub + k * (sub // 32))
    for k in range(1, 32):
        left, center, right = values[k-1:k+2]
        orient = np.where(center > 0, 1, -1)
        cols = np.flatnonzero((switches == 0) & (orient * (center-left) <= 0) &
                              (orient * (right-center) > 0))
        d1 = (right[cols] - left[cols]) / 2
        d2 = right[cols] + left[cols] - 2 * center[cols]
        nz = d2 != 0
        cols, d1, d2 = cols[nz], d1[nz], d2[nz]
        shift = -d1 / d2
        valid = ((center[cols] + d1 * shift / 2) * center[cols] <= 0) & (np.abs(shift) <= 1)
        for col, dx in zip(cols[valid], shift[valid]):
            jobs.add(int(cells[col]) * sub + round((k + float(dx)) * (sub // 32)))
    return jobs, len(cells)


def run_case(folder, repeats):
    counts = json.loads((folder / 'counts.json').read_bytes())
    grid = json.loads((folder / 'grid.json').read_bytes())
    sub, halo, bits = counts['sub'], grid['halo'], grid['bits']
    reference.SUB, reference.HALO, reference.GRID_BITS = sub, halo, bits
    records = []
    for params, row in zip(counts['channels'], grid['rows'], strict=True):
        label = params['label']
        assert row['label'] == label
        payload = (folder / f'grid-{label}.txt').read_bytes()
        digest = sha256(payload).hexdigest()
        assert digest == row['grid_sha256']
        raw = list(map(int, payload.splitlines()))
        last = len(raw) - 2*halo - 1
        assert params['coarse'] == last + 1
        packets = (folder / f'signs-{label}.tsv').read_bytes()
        assert sha256(packets).hexdigest() == counts['sha256'][f'signs-{label}.tsv']
        signed = {int(line.split()[0]) for line in packets.splitlines()}
        times = {'dense': [], 'screened': []}
        for trial in range(repeats):
            order = ('dense', 'screened') if trial % 2 == 0 else ('screened', 'dense')
            for name in order:
                start = process_time_ns()
                if name == 'dense':
                    dense = reference.discover(raw, last)
                else:
                    screened, candidates = screened_discover(raw, last, halo, bits, sub)
                times[name].append((process_time_ns() - start) / 1e9)
            assert len(dense) == params['discovery_requests'] and dense <= signed
        records.append(dict(label=label, grid_sha256=digest, intervals=last, candidates=candidates,
                            reference_requests=len(dense), missing=sorted(dense - screened),
                            extra=sorted(screened - dense), cpu_seconds=times))
    return records


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repeats', type=int, default=6)
    parser.add_argument('--output', type=Path)
    parser.add_argument('--panel', action='store_true', help='Use the two independent even-modulus validation datasets.')
    parser.add_argument('--odd', action='store_true', help='Use the two odd-modulus validation datasets.')
    args = parser.parse_args()
    if args.repeats < 2:
        parser.error('Use at least two alternating passes.')
    folders = [HOL / 'full-height-count', TEAM / 'q10004-gaussian', TEAM / 'high-conductor-full']
    if args.panel:
        folders = [TEAM / 'gaussian-panel-q65536', TEAM / 'gaussian-panel-q180180']
    if args.odd:
        if args.panel:
            parser.error('Select one validation panel at a time.')
        folders = [TEAM / 'gaussian-panel-q65537', TEAM / 'gaussian-panel-q132899']
    cases = {p.name: run_case(p, args.repeats) for p in folders}
    rows = [r for group in cases.values() for r in group]
    # Sum each pass across all grids before taking medians. Small Windows
    # process timers are quantized, especially on the two short high-q grids.
    totals = {name: [sum(r['cpu_seconds'][name][i] for r in rows) for i in range(args.repeats)]
              for name in ('dense', 'screened')}
    summary = dict(intervals=sum(r['intervals'] for r in rows), candidates=sum(r['candidates'] for r in rows),
                   reference_requests=sum(r['reference_requests'] for r in rows),
                   missed=sum(len(r['missing']) for r in rows), extra=sum(len(r['extra']) for r in rows),
                   total_cpu_seconds=totals, medians={k: median(v) for k,v in totals.items()})
    report = dict(script_sha256=sha256(Path(__file__).read_bytes()).hexdigest(),
                  reference_sha256=sha256(Path(reference.__file__).read_bytes()).hexdigest(),
                  cases=cases, summary=summary)
    if args.output:
        args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(summary))


if __name__ == '__main__':
    main()
