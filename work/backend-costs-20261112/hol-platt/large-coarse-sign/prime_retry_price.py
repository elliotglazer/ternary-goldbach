"""Time selective integer dot products against full Bluestein retries on the same inputs."""
import hashlib
import json
import statistics
from pathlib import Path
from time import process_time

import flint
from flint import acb, arb, ctx

from check import chirps, nearest, slice_transform
from prime_panel import phase_table, residues, source
from reference import upnorm

HERE = Path(__file__).resolve().parent
PRECISION = 48


def timed(fn, *args):
    start = process_time()
    result = fn(*args)
    return result, process_time() - start


def round_enclosure(z, grid):
    a, b = nearest(z, grid)
    assert abs(z*grid - acb(a,b)) < 1
    return a, b


def roots(n, grid):
    return [round_enclosure(acb.exp_pi_i(acb(2*j)/n), grid) for j in range(n)]


def dot(mode, rows, twiddles):
    # index=(index+mode)%n with at most one subtraction.
    n = len(rows)
    index = re = im = 0
    for a,b in rows:
        c,d = twiddles[index]
        re += a*c - b*d
        im += a*d + b*c
        index += mode
        if index >= n:
            index -= n
    return re,im


def summarize(times):
    return dict(samples=times, median=statistics.median(times))


def measure_node(q, rs, phases, twiddles, record, selected, grid):
    j = record['j']
    (s, order, raw), source_cpu = timed(source, rs, q, j)
    assert order == record['taylor_order']
    rows, round_cpu = timed(lambda: [round_enclosure(z, grid) for z in raw])
    n = len(rows)
    parts = [(arb.pi()*s.imag/4).exp() * (acb(q)/arb.pi())**((s+a)/2) *
             ((s+a)/2).gamma()*acb(q)**(-s) for a in (0,1)]
    def sign(k, a, b, error, denom):
        z = (phases[k]*parts[k%2])*acb(arb(a,error),arb(b,error))/denom
        assert z.imag.contains(0)
        return int(z.real > 0) - int(z.real < 0)

    bits = int(record['reference_signs_hex'],16)
    def reference(k):
        return 1 if (bits >> (record['sign_count']-k)) & 1 else -1

    # For each summand the unit root has norm one. The error from rounding the
    # input costs grid, and the root error costs |(a,b)|, on the grid^2 scale.
    radius, radius_cpu = timed(lambda: n*grid+sum(upnorm(a,b) for a,b in rows))
    holes = next(s['modes'] for s in record['tests'] if s['bits']==24)
    assert set(selected).issubset(holes)
    sparse_times = {}
    for k in holes:
        (a,b), seconds = timed(dot,k,rows,twiddles)
        assert sign(k,a,b,radius,grid*grid)==reference(k)
        sparse_times[k]=seconds
    full_inputs = [(a,b,1) for a,b in rows]
    full_times = []
    for _ in range(3):
        spectrum, seconds = timed(slice_transform, full_inputs, PRECISION)
        assert len(spectrum)==n-1
        full_times.append(seconds)
    for k in holes:
        a,b,e=spectrum[k-1]
        assert sign(k,a,b,e,grid)==reference(k)
    return dict(j=j, nodes_in_source=n, holes=len(holes), selected=len(selected),
                source_cpu=source_cpu, round_cpu=round_cpu, radius_cpu=radius_cpu,
                full_axis_cpu=summarize(full_times), sparse_times=sparse_times,
                all_dot_cpu=sum(sparse_times.values()),
                selected_dot_cpu=sum(sparse_times[k] for k in selected))


def main():
    ctx.prec,ctx.threads = 192,1
    price_input = HERE/'prime-repair.json'
    raw_input = HERE/'prime-131071.json'
    plan=json.loads(price_input.read_bytes())
    panel=json.loads(raw_input.read_bytes())
    assert hashlib.sha256(raw_input.read_bytes()).hexdigest()==plan['input_sha256']
    q = panel['q']
    generator,rs = residues(q)
    assert q==131071 and generator==panel['generator']
    grid = 1<<PRECISION
    phases,phase_cpu = timed(phase_table,rs,q)
    twiddles,root_cpu = timed(roots,len(rs),grid)
    _,chirp_cpu = timed(chirps,len(rs),PRECISION)
    panels = {}
    for group,records in [('low',panel['nodes'][:3]),('high',panel['nodes'][3:])]:
        case=next(d for d in plan['panels'][group] if d['bits']==24)
        chosen = case['selected_pairs']
        nodes=[]
        for rec in records:
            selected=[k for j,k in chosen if j==rec['j']]
            item=measure_node(q,rs,phases,twiddles,rec,selected,grid)
            nodes.append(item)
            print(group,rec['j'],item['selected'],item['selected_dot_cpu'],item['full_axis_cpu']['median'],flush=True)
        byid={r['j']:r for r in nodes}
        full=sum(byid[j]['full_axis_cpu']['median'] for j in case['selected_whole_heights'])
        sparse=sum(r['selected_dot_cpu']+(r['radius_cpu'] if r['selected'] else 0) for r in nodes)
        # A full transform or individual dots can be chosen separately at every height.
        hybrid=sum(min(r['selected_dot_cpu']+r['radius_cpu'],r['full_axis_cpu']['median'])
                   for r in nodes if r['selected'])
        panels[group]=dict(nodes=nodes, minimum_heights=case['selected_whole_heights'],
                           whole_height_cpu=full, selected_cpu=sparse,
                           hybrid_for_selected_pairs_cpu=hybrid)
    output=dict(q=q, precision=PRECISION, flint=flint.__version__, rounds=3, panels=panels,
                phase_cpu=phase_cpu,root_cpu=root_cpu,chirp_cpu=chirp_cpu,
                prime_repair_sha256=hashlib.sha256(price_input.read_bytes()).hexdigest(),
                script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest())
    (HERE/'prime-retry-price.json').write_text(json.dumps(output,indent=2)+'\n')


if __name__=='__main__':
    main()
