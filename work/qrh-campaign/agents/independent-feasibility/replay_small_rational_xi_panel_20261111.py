"""PREPARED, NOT NUMERICALLY RUN: independent exact-rational 929-node replay.

Standard library only. No producer imports, floats or function-value oracles.
Future full execution requires the explicit command-line flag below.
The analytic interpretation relies on the pinned, reviewed paper lemmas;
this Python program is not a Lean proof or a verified implementation.
"""
from fractions import Fraction as Q
from math import factorial, isqrt
from pathlib import Path
import argparse
import hashlib
import json
import time

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
BITS = 384
GRID = 1 << BITS
EXP_N = 112
CIS_N = 192
ATAN_N = 160
K = 928
DEGREE = 6
H = Q(1, 256)
RHO = Q(1, 64)
NODE_GRID = 1 << 32
WEIGHT_GRID = 1 << 64
PRODUCT_GRID = 1 << 96
DEADLINE = None
PINS = {
    'prime-estimates/NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md':
        '92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957',
    'zero-sum/REVIEW_NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md':
        '2F05928D57B1E76F513095FE5CCA4D5930EF314EB658EE748016E52FBE84CC97',
    'mellin/REVIEW_THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md':
        '8C81655B87AA6855AEE4A28D34A8713FFEC95CABEEE8F538E82888A0409304CD',
    'integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md':
        '5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571',
    'integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':
        'C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D',
}
TARGET = {'T_input': 32, 'T_work': 14, 'h': '1/256', 'K': 928,
          'degree': 6, 'sigma': '3/5', 't': '14', 'rho': '1/64',
          'eta': '1/33', 'function': 'exp(-i*b*(s-1/2))*xiF(s)',
          'b': 'pi/4-1/33', 'node_grid_bits': 32, 'weight_grid_bits': 64}


def require(p, label):
    if not p:
        raise ValueError(label)


def guard():
    if DEADLINE is not None and time.monotonic() > DEADLINE:
        raise TimeoutError('bounded replay deadline; partial records are not acceptance')


def floor(q):
    return q.numerator // q.denominator


def ceil(q):
    return -floor(-q)


def iv(lo, hi):
    lo, hi = Q(lo), Q(hi)
    require(lo <= hi, 'ordered interval')
    return Q(floor(lo * GRID), GRID), Q(ceil(hi * GRID), GRID)


def pt(x):
    x = Q(x)
    return x, x


Z = pt(0)
O = pt(1)
CZ = (Z, Z)
CO = (O, Z)


def add(a, b): return iv(a[0] + b[0], a[1] + b[1])
def neg(a): return -a[1], -a[0]
def sub(a, b): return add(a, neg(b))
def mul(a, b):
    x = [u*v for u in a for v in b]
    return iv(min(x), max(x))
def scale(a, x): return mul(a, pt(x))
def square(a):
    return iv(0 if a[0] <= 0 <= a[1] else min(a[0]**2, a[1]**2),
              max(a[0]**2, a[1]**2))
def divide(a, b):
    require(b[1] < 0 or b[0] > 0, 'real denominator excludes zero')
    x = [u/v for u in a for v in b]
    return iv(min(x), max(x))
def widen(a, e):
    require(e >= 0, 'nonnegative radius')
    return iv(a[0] - e, a[1] + e)
def ca(a, b): return add(a[0], b[0]), add(a[1], b[1])
def cn(a): return neg(a[0]), neg(a[1])
def cs(a, q): return scale(a[0], q), scale(a[1], q)
def cc(a): return a[0], neg(a[1])
def cm(a, b):
    return sub(mul(a[0], b[0]), mul(a[1], b[1])), add(mul(a[0], b[1]), mul(a[1], b[0]))
def l1(a): return sum(max(abs(x) for x in c) for c in a)
def cw(a): return [[str(x) for x in c] for c in a]


def inverse(a):
    """Independent exact edge-extrema reciprocal of a closed rectangle."""
    X, Y = a
    require(X[0] <= X[1] and Y[0] <= Y[1], 'reciprocal ordered box')
    require(not (X[0] <= 0 <= X[1] and Y[0] <= 0 <= Y[1]), 'complex nonzero')
    candidates = {(x, y) for x in X for y in Y}
    for x in X:
        if Y[0] <= 0 <= Y[1]: candidates.add((x, Q(0)))
        for y in (x, -x):
            if Y[0] <= y <= Y[1]: candidates.add((x, y))
    for y in Y:
        if X[0] <= 0 <= X[1]: candidates.add((Q(0), y))
        for x in (y, -y):
            if X[0] <= x <= X[1]: candidates.add((x, y))
    re, im = [], []
    for x, y in candidates:
        den = x*x+y*y
        require(den > 0, 'reciprocal candidate denominator')
        re.append(x/den); im.append(-y/den)
    return iv(min(re), max(re)), iv(min(im), max(im))


def sqrt_box(a):
    require(0 <= a[0] <= a[1], 'nonnegative sqrt input')
    low = isqrt(floor(a[0]*GRID*GRID))
    high = isqrt(floor(a[1]*GRID*GRID))
    if Q(high*high, GRID*GRID) < a[1]: high += 1
    out = Q(low, GRID), Q(high, GRID)
    require(0 <= out[0] <= out[1] and out[0]**2 <= a[0]
            and a[1] <= out[1]**2, 'sqrt endpoint squares')
    return out


def principal_sqrt(a):
    require(a[0][0] > 0, 'root in right half-plane')
    norm = sqrt_box(add(square(a[0]), square(a[1])))
    u = sqrt_box(scale(add(norm, a[0]), Q(1, 2)))
    require(u[0] > 0, 'positive real part of root')
    return u, divide(a[1], scale(u, 2))


def make_pi():
    def atan(x):
        low = sum(((-1)**j*x**(2*j+1)/Q(2*j+1) for j in range(ATAN_N)), Q(0))
        return low, low+x**(2*ATAN_N+1)/Q(2*ATAN_N+1)
    a, b = atan(Q(1, 5)), atan(Q(1, 239))
    p = iv(16*a[0]-4*b[1], 16*a[1]-4*b[0])
    require(3 < p[0] < p[1] < 4, 'Machin pi')
    return p


def exp_point(x):
    guard()
    if x <= -384:
        # e>2 and -x>=384. This is an interval, not replacement by zero.
        return Z[0], Q(1, 2**384)
    if x < 0: return divide(O, exp_point(-x))
    t, k = x, 0
    while t > Q(1, 4): t /= 2; k += 1
    require(k <= 20, 'positive exp resource cap')
    acc, term = O, O
    for j in range(1, EXP_N):
        term = mul(term, pt(t/j)); acc = add(acc, term)
    tail = Q(EXP_N+1, 4**EXP_N*factorial(EXP_N)*EXP_N)
    acc = iv(acc[0], acc[1]+tail)
    for _ in range(k): acc = square(acc)
    return acc


def exp_box(a): return exp_point(a[0])[0], exp_point(a[1])[1]


def cis(a, pi):
    # The midpoint proposes k; only the full interval range test certifies it.
    k = floor(((a[0]+a[1])/2)/(pi[0]+pi[1])+Q(1, 2))
    y = sub(a, scale(pi, 2*k))
    require(-4 <= y[0] <= y[1] <= 4, 'cis full reduced domain')
    require(Q(4, CIS_N+1) <= Q(1, 2), 'complex exponential tail domain')
    y2 = square(y)
    cosine, sine = O, y
    tc, ts = O, y
    for j in range(1, CIS_N//2):
        tc = scale(mul(tc, y2), Q(-1, (2*j-1)*(2*j)))
        ts = scale(mul(ts, y2), Q(-1, (2*j)*(2*j+1)))
        cosine = add(cosine, tc); sine = add(sine, ts)
    tail = Q(2*4**CIS_N, factorial(CIS_N))
    return widen(cosine, tail), widen(sine, tail)


def cexp(a, pi):
    e, z = exp_box(a[0]), cis(a[1], pi)
    return mul(e, z[0]), mul(e, z[1])


def phase8(n):
    r = sqrt_box(pt(Q(1, 2)))
    return (CO, (r, r), (Z, O), (neg(r), r),
            (pt(-1), Z), (neg(r), neg(r)), (Z, pt(-1)), (r, neg(r)))[n % 8]


def identity(): return [[CO if i == j else CZ for j in range(3)] for i in range(3)]


def dot(a, b):
    out = CZ
    for x, y in zip(a, b):
        if x != CZ and y != CZ: out = ca(out, cm(x, y))
    return out


def matmul(a, b):
    return [[dot(a[i], [b[k][j] for k in range(3)]) for j in range(3)] for i in range(3)]


def matrix_wire(a): return [[cw(x) for x in row] for row in a]


def word_and_matrix(seed):
    """Forward accumulated J_start = M_total J_terminal, not reverse unwind."""
    t, kind, total = seed, 3, identity()
    word, count = [], 0
    while True:
        guard()
        n = floor((t[0][0]+t[0][1])/2+Q(1, 2))
        new = (sub(t[0], pt(n)), t[1])
        require(-Q(3, 5) < new[0][0] <= new[0][1] < Q(3, 5), 'translation strip')
        phase = phase8(n) if kind == 2 else CO
        next_kind = kind if kind == 2 or n % 2 == 0 else 7-kind
        total = [[cm(x, phase) for x in row] for row in total]
        word.append({'op': 'T', 'n': n, 'type_before': kind, 'type_after': next_kind,
                     'before': cw(t), 'after': cw(new), 'phase': cw(phase)})
        kind, t = next_kind, new
        require(t[1][0] > Q(3, 50), 'maintained height lower bound')
        if t[1][0] >= Q(2, 5): break
        # Force rejection/refinement rather than a fifth inversion.
        require(count < 4, 'four-S cap: must certify stop after fourth')
        require(t[1][1] < Q(1, 2), 'overlapping inversion guard')
        B = inverse(t)
        A = inverse(principal_sqrt((t[1], neg(t[0]))))
        B2 = cm(B, B); B3 = cm(B2, B); B4 = cm(B2, B2)
        M = [[A, CZ, CZ],
             [cs(cm(A, B), Q(-1, 2)), cm(A, B2), CZ],
             [cs(cm(A, B2), Q(3, 4)), cs(cm(A, B3), -3), cm(A, B4)]]
        total = matmul(total, M)
        new = cn(B)
        require(new[1][0] > Q(100, 61)*t[1][1], 'strict certified S height growth')
        next_kind = {2: 4, 3: 3, 4: 2}[kind]
        word.append({'op': 'S', 'type_before': kind, 'type_after': next_kind,
                     'before': cw(t), 'after': cw(new), 'A': cw(A),
                     'matrix': matrix_wire(M)})
        kind, t = next_kind, new
        count += 1
    return t, kind, total, word


def terminal_jet(t, kind, pi):
    require(t[1][0] >= Q(2, 5), 'terminal two-fifths domain')
    jet = [CO if kind != 2 else CZ, CZ, CZ]
    terms = []
    for index in range(16):
        guard()
        a = Q(2*index+1, 2) if kind == 2 else Q(index+1)
        z = (Z, scale(pi, a*a))
        v = cs(cexp(cm(z, t), pi), 2*((-1)**(index+1) if kind == 4 else 1))
        row = [v, cm(v, z), cm(cm(v, z), z)]
        jet = [ca(x, y) for x, y in zip(jet, row)]
        terms.append({'a': str(a), 'derivative_terms': [cw(x) for x in row]})
    # Reviewed fixed 16-mode tail, separate from the weaker general N formula.
    require(32*17**4*300 < 2**30 and Q(6, 5)*16**2 > 307, 'fixed tail arithmetic')
    tail = Q(1, 2**277)
    jet = [(widen(z[0], tail), widen(z[1], tail)) for z in jet]
    return jet, terms


def center_record(box, grid, limit):
    ints = [floor((a[0]+a[1])*grid/2) for a in box]
    center = [Q(i, grid) for i in ints]
    e = sum(max(abs(a[0]-c), abs(a[1]-c)) for a, c in zip(box, center))
    require(0 <= e <= limit, 'actual post-rounding L1 radius')
    return {'center': ints, 'radius': str(e), 'box': cw(box)}


def node(k, pi):
    v = k*H
    e = exp_box(pt(2*v)); c, s = cis(pt(Q(2, 33)), pi)
    seed = (mul(e, neg(c)), mul(e, s))
    terminal, kind, matrix, word = word_and_matrix(seed)
    jet, terms = terminal_jet(terminal, kind, pi)
    initial = [dot(row, jet) for row in matrix]
    pref = cm((exp_box(pt(v/2)), Z), cis(sub(scale(pi, Q(1, 8)), pt(Q(1, 66))), pi))
    out = cm(pref, ca(cs(cm(seed, initial[1]), 6), cs(cm(cm(seed, seed), initial[2]), 4)))
    rec = center_record(out, NODE_GRID, Q(1, 2**24))
    require(sum(Q(i, NODE_GRID)**2 for i in rec['center']) < 2**54, 'node center norm below 2^27')
    rec.update({'k': k, 'v': str(v), 'seed': cw(seed), 'word': word,
                'terminal_type': kind, 'terminal_terms': terms, 'terminal_tail': str(Q(1, 2**277)),
                'accumulated_matrix': matrix_wire(matrix), 'original_jet': [cw(x) for x in initial]})
    return rec, out


def weights(k, pi):
    if k == 0:
        # exp(0)=1 exactly; avoid inventing uncertainty for the author's zero-radius weights.
        return [dict(center_record((pt(H), Z) if j == 0 else CZ, WEIGHT_GRID, Q(1, 2**48)),
                     k=0, sign=1, j=j) for j in range(DEGREE+1)]
    rows = []
    for sign in ([1] if k == 0 else [1, -1]):
        v = sign*k*H
        value = cexp((pt(v/10), pt(14*v)), pi)
        factor = H
        for j in range(DEGREE+1):
            box = cs(value, factor)
            rec = center_record(box, WEIGHT_GRID, Q(1, 2**48))
            rec.update({'k': k, 'sign': sign, 'j': j})
            rows.append(rec)
            factor *= v/Q(j+1)
    return rows


def analytic_budget(pi):
    a = Q(1, 66); A = Q(46687168, 3); M = Q(2054235392, 3)
    D = Q(30813530880); q = Q(1, 44); V = K*H
    den = exp_point(2*pi[0]*a/H)[0]-1
    require(den > 0, 'trapezoid denominator')
    R = exp_point(2*V)
    require(q*R[0] >= 2, 'positive derivative spatial threshold')
    E = exp_point(-q*R[0])[1]
    q0 = 2*M*exp_point(14*a)[1]/den
    qj = 2*D*exp_point(15*a)[1]/den
    s0 = M*E
    sj = A*E*(R[1]/q+1/q**2)
    G = sum(RHO**j for j in range(DEGREE+1))
    tay = D*RHO**7/(1-RHO)
    analytic = q0+s0+(qj+sj)*(G-1)+tay
    require(exp_point(5*V/2)[1] < 2**14, 'node weight envelope')
    require(A*exp_point(V/2)[1]+Q(1, 2**24) < 2**27, 'node-center envelope')
    nb = Q(1857, 262144); wb = Q(1857, 2097152)
    total = analytic+G*(nb+wb)
    require(total <= Q('0.091500568239') < Q(1, 10), 'complete disk allocation')
    return {'Q0': str(q0), 'Qpositive': str(qj), 'S0': str(s0), 'Spositive': str(sj),
            'Taylor': str(tay), 'node_each': str(nb), 'weight_each': str(wb),
            'analytic': str(analytic), 'total': str(total)}


def sum_centers(nodes, all_weights):
    require(len(nodes) == K+1 and len(all_weights) == 12999, 'full workload cardinality')
    sums = [[0, 0] for _ in range(DEGREE+1)]
    seen = set()
    for row in all_weights:
        k, sign, j = row['k'], row['sign'], row['j']
        key = k, sign, j
        require(key not in seen and 0 <= k <= K and 0 <= j <= DEGREE
                and sign in ([1] if k == 0 else [1, -1]), 'unique valid signed weight')
        seen.add(key)
        px, py = nodes[k]['center']; py *= sign
        wx, wy = row['center']
        sums[j][0] += px*wx-py*wy; sums[j][1] += px*wy+py*wx
    return sums


def halfplane(sums):
    U = sum(Q(abs(x)+abs(y), PRODUCT_GRID)*RHO**j for j, (x, y) in enumerate(sums) if j)
    lower = Q(sums[0][0], PRODUCT_GRID)-U
    return {'higher_polynomial_L1': str(U), 'center_minus_polynomial': str(lower),
            'strict_positive_real_disk': lower > Q(1, 10)}


def candidate_bound(box, row, grid, limit):
    require(len(row['center']) == 2 and all(type(x) is int for x in row['center']), 'integer center')
    radius = Q(row['radius'])
    require(0 <= radius <= limit, 'candidate radius allocation')
    direct = sum(max(abs(a[0]-Q(n, grid)), abs(a[1]-Q(n, grid))) for a, n in zip(box, row['center']))
    require(direct <= radius, 'independent enclosure implies entire candidate ball')


def audit_candidate(candidate, own):
    """Canonical schema; no acceptance from overlap or an advertised status."""
    require(candidate['target'] == TARGET, 'exact externally fixed input binding')
    require(len(candidate['nodes']) == K+1 and len(candidate['weights']) == 12999, 'complete candidate')
    for k, (got, ref) in enumerate(zip(candidate['nodes'], own['nodes'])):
        require(type(got['k']) is int and got['k'] == k, 'ordered candidate nodes')
        candidate_bound(tuple(tuple(Q(x) for x in c) for c in ref['box']), got, NODE_GRID, Q(1, 2**24))
        require(sum(Q(i, NODE_GRID)**2 for i in got['center']) < 2**54, 'candidate center norm')
    for got, ref in zip(candidate['weights'], own['weights']):
        require(all(got[key] == ref[key] for key in ('k', 'sign', 'j')), 'signed candidate weight binding')
        candidate_bound(tuple(tuple(Q(x) for x in c) for c in ref['box']), got, WEIGHT_GRID, Q(1, 2**48))
    sums = sum_centers(candidate['nodes'], candidate['weights'])
    require(sums == candidate['coefficients_integer'], 'every exact candidate coefficient sum')
    proof = halfplane(sums)
    require(proof['strict_positive_real_disk'], 'candidate strict whole-disk half-plane comparison')
    return proof


def adapt_integration_receipt(raw):
    """Lossless schema adapter, not an import of the producer's algorithms."""
    target = dict(T_input=32, T_work=14, eta='1/33', center_re='3/5',
                  center_im='14', rho='1/64', h='1/256', K=928, degree=6,
                  b_expression='pi/4-1/33', a='1/66', kappa='1/66', V='29/8',
                  rectangle_re=['379/640', '389/640'],
                  rectangle_im=['1791/128', '1793/128'],
                  ccw_vertices=[['379/640', '1791/128'], ['389/640', '1791/128'],
                                ['389/640', '1793/128'], ['379/640', '1793/128'],
                                ['379/640', '1791/128']],
                  node_grid_bits=32, weight_grid_bits=64,
                  node_radius='1/16777216', weight_radius='1/281474976710656')
    require(raw['target'] == target, 'integration exact target/rectangle')
    assembly = raw['assembly']
    require(assembly['coefficients_grid_bits'] == 96, 'integration coefficient grid')
    require([r['k'] for r in assembly['weights']] == list(range(-K, K+1)), 'all signed rows')
    lookup = {}
    for group in assembly['weights']:
        require(len(group['weights']) == DEGREE+1, 'seven weights in every signed row')
        for j, row in enumerate(group['weights']):
            k = group['k']
            lookup[abs(k), 1 if k >= 0 else -1, j] = dict(row, k=abs(k), sign=1 if k >= 0 else -1, j=j)
    rows = [lookup[k, sign, j] for k in range(K+1)
            for sign in ([1] if k == 0 else [1, -1]) for j in range(DEGREE+1)]
    sums = assembly['coefficients']
    actual = halfplane(sums)
    require(Q(assembly['nonconstant_norm_upper']) == Q(actual['higher_polynomial_L1'])
            and Q(assembly['real_margin']) == Q(actual['center_minus_polynomial']), 'reported polynomial arithmetic')
    require(assembly['strict_positive_real'] == actual['strict_positive_real_disk'], 'reported half-plane flag')
    return {'target': TARGET, 'nodes': raw['nodes'], 'weights': rows, 'coefficients_integer': sums}


def run(seconds, progress):
    global DEADLINE
    DEADLINE = time.monotonic()+seconds
    for name, pin in PINS.items():
        require(hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper() == pin, 'source pin '+name)
    pi = make_pi(); budget = analytic_budget(pi)
    out = {'status': 'INCOMPLETE', 'target': TARGET, 'pins': PINS,
           'working_bits': BITS, 'exp_terms': EXP_N, 'cis_terms': CIS_N, 'atan_terms': ATAN_N,
           'pi': [str(x) for x in pi], 'budget': budget, 'nodes': [], 'weights': []}
    # A progress stream retains only completed nodes, never a false final verdict.
    with progress.open('x', encoding='utf-8') as log:
        log.write(json.dumps({'status': 'INCOMPLETE', 'target': TARGET})+'\n'); log.flush()
        for k in range(K+1):
            guard()
            record, _ = node(k, pi); wr = weights(k, pi)
            out['nodes'].append(record); out['weights'].extend(wr)
            log.write(json.dumps({'node': record, 'weights': wr})+'\n'); log.flush()
    sums = sum_centers(out['nodes'], out['weights'])
    out['coefficients_integer'] = sums
    out['halfplane'] = halfplane(sums)
    out['status'] = ('PASS_INDEPENDENT_RATIONAL_PANEL' if out['halfplane']['strict_positive_real_disk']
                     else 'INCONCLUSIVE_HALF_PLANE')
    out['scope'] = 'Exact external rational arithmetic plus pinned paper analysis; not Lean certification'
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--authorize-full-replay', action='store_true')
    ap.add_argument('--seconds', type=int, default=600)
    ap.add_argument('--output', type=Path, required=True)
    ap.add_argument('--candidate', type=Path)
    args = ap.parse_args()
    require(args.authorize_full_replay, 'full numerical execution not enabled')
    require(1 <= args.seconds <= 600, 'bounded execution policy')
    require(args.output.resolve().parent == HERE and not args.output.exists(), 'new own-directory output only')
    out = run(args.seconds, args.output.with_suffix('.progress.jsonl'))
    if args.candidate:
        data = args.candidate.read_bytes()
        out['candidate_sha256'] = hashlib.sha256(data).hexdigest().upper()
        candidate = json.loads(data)
        if 'assembly' in candidate: candidate = adapt_integration_receipt(candidate)
        out['candidate_review'] = audit_candidate(candidate, out)
    out['script_sha256'] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
    args.output.write_text(json.dumps(out, indent=2)+'\n', encoding='utf-8')
    print(json.dumps({'status': out['status'], 'nodes': len(out['nodes']), 'weights': len(out['weights'])}))


if __name__ == '__main__':
    main()
