"""Independent rational edge oracle against the frozen compact criterion.

No analytic value generation. No imports from interval libraries.
"""
from fractions import Fraction as F
from itertools import product
from pathlib import Path
import hashlib
import json
import runpy
import sys
from itertools import combinations_with_replacement

sys.dont_write_bytecode = True

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'prime-estimates/COMPACT_RECIPROCAL_RECTANGLE_2026-11-11.md': '53E2BCD126E06BCB280F579352BEB05BCB1C939AE4ACC97661F0525B3486434F',
    'prime-estimates/compact_reciprocal_rectangle_20261111.py': 'E32289AA8773520002804572C3F95B207850C41574A9BE45ECB178A8E632426F',
    'prime-estimates/compact_reciprocal_rectangle_20261111.json': '73EF65C8CC1CF9DAD2C025F5A03880F2DC66BC0DDDC541555B3E943337BFD8D7',
    'integration/COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md': '85651AA198E92AEBDB541C48A2C42AC666B0F5A72A7DDB728545A83F01AD19A8',
    'major-constants/REVIEW_COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md': '2BD81A05B6C84A27149C1BEE5827B4918DD4F7F454AB799B1DEA8E954398F9DC',
}


def edge_extrema(box):
    """Union of both coordinate stationary-edge candidates, including degeneracies."""
    (a, b), (c, d) = box
    if a > b or c > d or (a <= 0 <= b and c <= 0 <= d):
        return None
    points = set(product((a, b), (c, d)))
    for x in (a, b):
        for y in (F(0), x, -x):
            if c <= y <= d:
                points.add((x, y))
    for y in (c, d):
        for x in (F(0), y, -y):
            if a <= x <= b:
                points.add((x, y))
    real = [x / (x*x+y*y) for x, y in points]
    imag = [-y / (x*x+y*y) for x, y in points]
    return ((min(real), max(real)), (min(imag), max(imag)))


def quadratic_minimum(a, b, lo, hi):
    """Independent unconstrained-vertex computation, allowed rational division."""
    points = [lo, hi]
    if a > 0 and lo <= -b/(2*a) <= hi:
        points.append(-b/(2*a))
    return min(a*x*x+b*x for x in points)


def residual_truth(box, a, b):
    (xl, xu), (yl, yu) = box
    return quadratic_minimum(a, b, xl, xu)+quadratic_minimum(a, F(0), yl, yu) >= 0


def decode(x):
    m, e = int(x['mantissa']), x['exponent']
    assert abs(m).bit_length() <= 4096 and abs(e) <= 4096
    return F(m*(1 << e)) if e >= 0 else F(m, 1 << -e)


def decode_box(x):
    return tuple((decode(x[k]['lo']), decode(x[k]['hi'])) for k in ('re', 'im'))


def neg_range(r):
    return (-r[1], -r[0])


def actual_gates():
    path = AGENTS/'integration/lossless_modular_two_step_20261111.json'
    assert hashlib.sha256(path.read_bytes()).hexdigest().upper() == '31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE'
    nodes = {n['id']: n for n in json.loads(path.read_text())['packet']['nodes']}
    result = []
    for ident, src, sign in [('S_output', 'translated', -1), ('A', 'root', 1)]:
        box = decode_box(nodes[src]['value'])
        out = decode_box(nodes[ident]['value'])
        ranges = edge_extrema(box)
        assert ranges is not None
        if sign < 0:
            ranges = tuple(map(neg_range, ranges))
        assert all(o[0] <= r[0] <= r[1] <= o[1] for o, r in zip(out, ranges))
        result.append((ident, box, out, sign))
    return result


def run():
    for rel, expected in PINS.items():
        assert hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper() == expected, rel
    source = AGENTS/'prime-estimates/compact_reciprocal_rectangle_20261111.py'
    pin = 'E32289AA8773520002804572C3F95B207850C41574A9BE45ECB178A8E632426F'
    assert hashlib.sha256(source.read_bytes()).hexdigest().upper() == pin
    p = runpy.run_path(str(source))
    D, C = p['D'], p['C']
    accept, quadratic = p['accept'], p['quadratic_nonnegative']
    def dy(q):
        q = F(q)
        d = q.denominator
        assert d & (d-1) == 0
        return D(q.numerator, -(d.bit_length()-1))
    def db(box):
        return tuple(tuple(dy(q) for q in pair) for pair in box)
    def reflect(box):
        return tuple(neg_range(pair) for pair in box)
    intervals = list(combinations_with_replacement(map(F, [F(-7,4), F(-3,4), F(-1,4), 0, F(1,4), F(3,4), F(7,4)]), 2))
    nres = nfull = nequal = norigin = 0
    for box in product(intervals, repeat=2):
        din = db(box)
        for a, b in product(map(F, [-3, -1, F(-1,4), 0, F(1,4), 1, 3]), [-1, 1]):
            assert quadratic(dy(a), b, *din) == residual_truth(box, a, b), (box, a, b)
            nres += 1
        exact = edge_extrema(box)
        if exact is None:
            assert not accept(din, db(((-1024, 1024), (-1024, 1024))))
            norigin += 1
            continue
        # All rational extrema, including non-dyadic values, meet the independently
        # evaluated separable minimum with equality; each inward move fails.
        x, y = box
        (lr, ur), (li, ui) = exact
        for a, b, rect in [(-lr, 1, box), (ur, -1, box),
                           (-li, -1, (y, x)), (ui, 1, (y, x))]:
            assert residual_truth(rect, a, b)
            assert not residual_truth(rect, a-F(1,4096), b)
            nequal += 2
        rounded = tuple((F((v[0]*256).__floor__(),256), F((v[1]*256).__ceil__(),256)) for v in exact)
        candidates = [rounded]
        for side, move in product(range(4), [-1, 1]):
            q = [list(pair) for pair in rounded]
            q[side//2][side%2] += F(move,256)
            candidates.append(tuple(map(tuple,q)))
        for out in candidates:
            expected = all(o[0] <= r[0] <= r[1] <= o[1] for o, r in zip(out, exact))
            assert accept(din, db(out)) == expected, (box, out)
            assert accept(din, db(reflect(out)), -1) == expected
            nfull += 2
    # Malformed order, invalid signs, a pole on an edge or at a corner.
    rejections = [
        (((2,1),(1,2)), ((-100,100),(-100,100)),1),
        (((1,2),(1,2)), ((1,-1),(-100,100)),1),
        (((1,2),(1,2)), ((-100,100),(-100,100)),0),
        (((0,1),(0,1)), ((-100,100),(-100,100)),1),
        (((-1,1),(0,1)), ((-100,100),(-100,100)),1),
    ]
    for x, y, sign in rejections:
        assert not accept(db(x), db(y), sign)
    gates = []
    for ident, box, out, sign in actual_gates():
        rows = []
        for exponent in (0, 10**100, -10**100):
            C.COUNTS.clear(); C.MAXIMA.clear()
            shift = lambda q, e: tuple(tuple(D(v.m,v.e+e) for v in pair) for pair in q)
            assert accept(shift(db(box),exponent),shift(db(out),-exponent),sign)
            rows.append({'scale_exponent':str(exponent), 'counts':dict(C.COUNTS), 'maxima':dict(C.MAXIMA)})
        assert len({r['maxima']['guarded_left_shift'] for r in rows}) == 1
        assert len({r['maxima']['working_mantissa_bits'] for r in rows}) == 1
        gates.append({'id':ident, 'rows':rows})
    for rel, expected in PINS.items():
        assert hashlib.sha256((AGENTS/rel).read_bytes()).hexdigest().upper() == expected, rel
    return {'status':'PASS bounded independent arithmetic review', 'pins':PINS,
            'residual_comparisons':nres, 'compact_full_box_comparisons':nfull,
            'rational_exact_boundary_and_inward_checks':nequal,
            'origin_boxes_rejected':norigin, 'additional_rejections':len(rejections),
            'branch_visits':p['BRANCHES'], 'actual_gates':gates,
            'scope':'No analytic seed, modular value, general parser, Lean theorem, or kernel performance certified.'}


if __name__ == '__main__':
    result = run()
    result['script_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
    path = Path(__file__).with_suffix('.json')
    path.write_text(json.dumps(result, indent=2, sort_keys=True)+'\n', encoding='utf8')
    print(json.dumps({k:v for k,v in result.items() if k not in ('actual_gates','branch_visits')},indent=2))
