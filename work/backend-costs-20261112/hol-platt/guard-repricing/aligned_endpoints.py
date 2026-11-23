"""Count to the next coarse node using certified coarse endpoints and repaired interiors."""
from fractions import Fraction as F
from hashlib import sha256
from math import ceil
from pathlib import Path
import json
import sys
import argparse

from flint import arb, ctx, dirichlet_char

from endpoint_policy import HERE, HOL, Region, checked

sys.path[:0] = [str(HOL / 'one-character-completeness'), str(HOL / 'small-character-kernel')]
from phase_ends import SCALE, ball, enclosure, independent_integral


def main():
    ctx.prec, ctx.threads = 160, 1
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--panel',action='store_true')
    suffix='-panel' if parser.parse_args().panel else ''
    input_path = HERE / f'endpoint-policy{suffix}.json'
    strict = json.loads(input_path.read_bytes())['rows']
    report = []
    for row in strict:
        if row['endpoint_inclusive'] or row['guard']!=640 or row['policy']!='no_edges':
            continue
        q, sub = row['q'], row['sub']
        T = F(row['T'])
        t_tick = ceil(64*T/5)*sub
        h_tick = t_tick + row['guard']*sub
        lower, upper = F(5*t_tick,64*sub), F(5*h_tick,64*sub)
        assert T <= lower < T+F(5,64) and upper-lower==50
        chars = [dirichlet_char(q,l) for l in row['labels']]
        assert chars[0].parity()==chars[1].parity() and all(c.is_primitive() for c in chars)
        phase_lo, phase_hi = (F(a,SCALE) for a in enclosure(q,chars[0].parity(),lower,upper))
        integral = independent_integral(q,chars[0].parity(),lower,upper)
        assert integral.imag.contains(0) and ball(phase_lo)<integral.real<ball(phase_hi)
        assert lower>50 and (q*ball(upper)/(2*arb.pi())).log()<18
        omitted = set(row['available_edges'])
        scans = []
        for path, digest in zip(row['signs'],row['sign_sha256'],strict=True):
            table = [tuple(map(int,line.split())) for line in checked(HERE / path,digest).splitlines()]
            signs = [(t,s) for t,s in table if t not in omitted]
            # Each endpoint used by the test is a strict sign in the ORIGINAL
            # recorded regular grid. No interpolation is performed at a boundary.
            for end in (0,t_tick,h_tick):
                assert end % sub == 0 and any(t==end and abs(s)==1 for t,s in signs)
            a,b = Region(signs,0,t_tick,True), Region(signs,t_tick,h_tick,True)
            scans.append([a.count,a.weight,b.count,b.weight])
        k, weight = sum(r[0] for r in scans), sum(r[3] for r in scans)
        excess = (phase_hi+2*F(row['allowance']))/(upper-lower)-F(weight,h_tick-t_tick)-k
        assert excess>=0
        report.append(row | dict(T=str(lower),required_T=str(T),final_H=str(upper),
                                 t_tick=t_tick,h_tick=h_tick,endpoint_inclusive=True,
                                 phase_upper=str(phase_hi),phase_lower=str(phase_lo),
                                 independent_phase=str(integral),kept_edges=[[],[]],scans=scans,
                                 excess=str(excess),passes=excess<1))
    result=dict(source_sha256=sha256(input_path.read_bytes()).hexdigest(),rows=report)
    (HERE/f'endpoint-grid{suffix}.json').write_text(json.dumps(result,indent=2)+'\n')
    for row in report:
        print(row['q'], row['labels'], row['required_T'],row['T'],sum(r[0] for r in row['scans']),
              float(F(row['excess'])),row['passes'])


if __name__=='__main__':
    main()
