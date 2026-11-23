"""Compact exact arithmetic prototype; no exp/trig or analytic certification."""
from collections import Counter
from dataclasses import dataclass
from fractions import Fraction
from pathlib import Path
from math import isqrt
import hashlib
import json
import time

HERE = Path(__file__).parent
SOURCE = HERE.parent/'prime-estimates/principal_theta_modular_pilot_20261111.json'
SOURCE_SHA = 'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF'
COUNTS = Counter()
MAXIMA = Counter()


def observe(m, e):
    MAXIMA['working_mantissa_bits'] = max(MAXIMA['working_mantissa_bits'], abs(m).bit_length())
    MAXIMA['working_exponent_bits'] = max(MAXIMA['working_exponent_bits'], abs(e).bit_length())


def left(n, d, bound):
    assert 0 <= d <= bound <= 8192, (d, bound)
    COUNTS['guarded_left_shift'] += 1
    MAXIMA['guarded_left_shift'] = max(MAXIMA['guarded_left_shift'], d)
    result = n << d
    MAXIMA['working_mantissa_bits'] = max(MAXIMA['working_mantissa_bits'],abs(result).bit_length())
    return result


@dataclass(frozen=True)
class D:
    m: int
    e: int = 0

    def __post_init__(self):
        if type(self.m) is not int or type(self.e) is not int:
            raise ValueError('integer mantissa and exponent required')
        m, e = self.m, self.e
        if m == 0:
            e = 0
        else:
            z = (abs(m) & -abs(m)).bit_length()-1
            m >>= z
            e += z
        object.__setattr__(self, 'm', m)
        object.__setattr__(self, 'e', e)
        observe(m, e)

    def __neg__(self):
        return D(-self.m, self.e)

    @property
    def top(self):
        assert self.m
        return self.e+abs(self.m).bit_length()


ZERO, ONE = D(0), D(1)


def mul(a, b):
    COUNTS['product'] += 1
    observe(a.m*b.m, a.e+b.e)
    return D(a.m*b.m, a.e+b.e)


def cmp(a, b):
    COUNTS['comparison'] += 1
    sa, sb = (a.m > 0)-(a.m < 0), (b.m > 0)-(b.m < 0)
    if sa != sb:
        return (sa > sb)-(sa < sb)
    if not sa:
        return 0
    if a.top != b.top:
        return sa*((a.top > b.top)-(a.top < b.top))
    e = min(a.e, b.e)
    W = max(abs(a.m).bit_length(), abs(b.m).bit_length())
    aa, bb = left(abs(a.m), a.e-e, W), left(abs(b.m), b.e-e, W)
    return sa*((aa > bb)-(aa < bb))


def sign3(*values):
    assert len(values) <= 3
    COUNTS['sign_at_most_three'] += 1
    v = [x for x in values if x.m]
    initial = max((abs(x.m).bit_length() for x in v), default=0)
    while len(v) > 1:
        v.sort(key=lambda x: x.top, reverse=True)
        if v[0].top >= v[1].top+2:
            COUNTS['sign_dominance'] += 1
            return 1 if v[0].m > 0 else -1
        a, b = v[:2]
        e = min(a.e, b.e)
        W = max(abs(a.m).bit_length(), abs(b.m).bit_length())
        total = left(a.m, a.e-e, W+1)+left(b.m, b.e-e, W+1)
        observe(total, e)
        assert abs(total).bit_length() <= W+2
        c = D(total, e)
        assert abs(c.m).bit_length() <= initial+4
        COUNTS['sign_near_top_merge'] += 1
        v = ([c] if c.m else [])+v[2:]
    return 0 if not v else (1 if v[0].m > 0 else -1)


def round_grid(x, g):
    COUNTS['directed_rounding'] += 1
    if not x.m or x.e >= g:
        return x, x
    n, d = abs(x.m), g-x.e
    bits = n.bit_length()
    if d >= bits:
        COUNTS['round_small_term_no_shift'] += 1
        q, sticky = 0, 1
    else:
        assert d < bits
        COUNTS['guarded_right_shift'] += 1
        MAXIMA['guarded_right_shift'] = max(MAXIMA['guarded_right_shift'], d)
        q = n >> d
        sticky = int(n != left(q, d, bits))
    if x.m > 0:
        return D(q, g), D(q+sticky, g)
    return D(-q-sticky, g), D(-q, g)


def add_witness(a, b, lo, hi):
    COUNTS['addition_witness'] += 1
    return cmp(lo, hi) <= 0 and sign3(a, b, -lo) >= 0 and sign3(hi, -a, -b) >= 0


def product_witness(a, b, lo, hi):
    COUNTS['product_witness'] += 1
    z = mul(a, b)
    return cmp(lo, z) <= 0 and cmp(z, hi) <= 0


def quotient_witness(a, b, lo, hi):
    COUNTS['quotient_witness'] += 1
    if not b.m or cmp(lo, hi) > 0:
        return False
    if b.m < 0:
        a, b = -a, -b
    return cmp(mul(lo, b), a) <= 0 and cmp(a, mul(hi, b)) <= 0


def sqrt_witness(x, lo, hi):
    COUNTS['sqrt_witness'] += 1
    return (x.m >= 0 and lo.m >= 0 and cmp(lo, hi) <= 0
            and cmp(mul(lo, lo), x) <= 0 and cmp(x, mul(hi, hi)) <= 0)


def wire(x):
    if not isinstance(x, dict) or set(x) != {'mantissa', 'exponent'}:
        raise ValueError('wrong endpoint fields')
    if not isinstance(x['mantissa'], str) or type(x['exponent']) is not int:
        raise ValueError('wrong endpoint types')
    s = x['mantissa']
    if not s or s in ('-', '+') or any(c not in '0123456789' for c in s.lstrip('-')) or s.startswith('+'):
        raise ValueError('invalid mantissa spelling')
    return D(int(s), x['exponent'])


def display(s):
    n, d = map(int, s.split('/'))
    if d <= 0 or d & (d-1):
        raise ValueError('display denominator is not a positive power of two')
    return D(n, -(d.bit_length()-1))


def interval(raw):
    if not isinstance(raw, list) or len(raw) != 2:
        raise ValueError('two endpoints required')
    lo, hi = map(wire, raw)
    if cmp(lo, hi) > 0:
        raise ValueError('reversed endpoints')
    return lo, hi


def box(raw):
    return interval(raw['binary_re']), interval(raw['binary_im'])


def neg_interval(a):
    return -a[1], -a[0]


def same_interval(a, b):
    return cmp(a[0], b[0]) == 0 and cmp(a[1], b[1]) == 0


def contains_interval(outer, inner):
    return cmp(outer[0], inner[0]) <= 0 and cmp(inner[1], outer[1]) <= 0


def same_box(a, b):
    return all(same_interval(x, y) for x, y in zip(a, b))


def square_bounds(a):
    if a[0].m >= 0:
        return mul(a[0], a[0]), mul(a[1], a[1])
    if a[1].m <= 0:
        return mul(a[1], a[1]), mul(a[0], a[0])
    aa, bb = mul(a[0], a[0]), mul(a[1], a[1])
    return ZERO, aa if cmp(aa, bb) >= 0 else bb


def reciprocal_box_witness(inp, out):
    """Sufficient full-rectangle rule; may reject a valid tighter correlated result."""
    COUNTS['coarse_complex_reciprocal_attempt'] += 1
    xs, ys = square_bounds(inp[0]), square_bounds(inp[1])
    if sign3(xs[0], ys[0]) <= 0:
        return False
    for numerator, candidate in zip((inp[0], neg_interval(inp[1])), out):
        for value in numerator:
            for d1, d2 in ((xs[0], ys[0]), (xs[1], ys[1])):
                if sign3(value, -mul(candidate[0], d1), -mul(candidate[0], d2)) < 0:
                    return False
                if sign3(mul(candidate[1], d1), mul(candidate[1], d2), -value) < 0:
                    return False
    return True


def fraction_small(x):
    assert abs(x.e) <= 1000
    return Fraction(x.m)*(Fraction(2)**x.e)


def regress():
    vals = [D(m, e) for m in range(-3, 4) for e in range(-2, 3)]
    pairs = triples = rounds = quotients = roots = 0
    for a in vals:
        for b in vals:
            fa, fb = fraction_small(a), fraction_small(b)
            assert cmp(a, b) == ((fa > fb)-(fa < fb))
            p = mul(a, b)
            assert fraction_small(p) == fa*fb and product_witness(a, b, p, p)
            pairs += 1
            if fb:
                z = 16*fa/fb
                q = z.numerator//z.denominator
                assert quotient_witness(a,b,D(q,-4),D(q+1,-4))
                quotients += 1
            for c in (D(-3, -1), D(0), D(1), D(3, 2)):
                z = fa+fb+fraction_small(c)
                assert sign3(a, b, c) == ((z > 0)-(z < 0))
                triples += 1
    for m in range(-25, 26):
        for e in range(-7, 8):
            x = D(m, e)
            for g in range(-8, 9):
                lo, hi = round_grid(x, g)
                z = fraction_small(x)/(Fraction(2)**g)
                flo = z.numerator//z.denominator
                cei = -((-z.numerator)//z.denominator)
                assert fraction_small(lo) == flo*Fraction(2)**g
                assert fraction_small(hi) == cei*Fraction(2)**g
                rounds += 1
    for x in vals:
        fx = fraction_small(x)
        if fx >= 0:
            q = isqrt((fx.numerator*256)//fx.denominator)
            assert sqrt_witness(x,D(q,-4),D(q+1,-4))
            roots += 1
    H = 10**100
    tiny = D(1, -H)
    assert cmp(tiny, D(1, -H-1)) > 0
    assert sign3(ONE, tiny, -ONE) == 1
    assert sign3(ONE, -ONE, -tiny) == -1
    assert round_grid(tiny, -128) == (ZERO, D(1, -128))
    assert round_grid(-tiny, -128) == (D(-1, -128), ZERO)
    assert add_witness(ONE, tiny, ONE, D((1 << 128)+1, -128))
    assert quotient_witness(D(1, -H), D(3, -H), D(1, -2), D(1, -1))
    assert sqrt_witness(D(2, -2*H), D(1, -H), D(3, -H-1))
    negative = {}
    negative['false_addition'] = not add_witness(ONE, tiny, ONE, ONE)
    negative['false_product'] = not product_witness(D(3), D(4), D(11), D(11))
    negative['false_quotient'] = not quotient_witness(ONE, D(3), ONE, ONE)
    negative['zero_denominator'] = not quotient_witness(ONE, ZERO, ZERO, ONE)
    negative['negative_sqrt_branch'] = not sqrt_witness(D(4), D(-2), D(-2))
    negative['false_sqrt'] = not sqrt_witness(D(2), ONE, ONE)
    for key, bad in [('bad_exponent', {'mantissa':'1','exponent':'-2'}),
                     ('bad_mantissa', {'mantissa':'1.0','exponent':-2})]:
        try:
            wire(bad)
            negative[key] = False
        except ValueError:
            negative[key] = True
    assert all(negative.values())
    return {'comparison_product_pairs':pairs,'three_term_sums':triples,'rounding_cases':rounds,
            'quotient_enclosures':quotients,'sqrt_enclosures':roots,
            'huge_exponent_magnitude':'10^100','negative_controls':negative,
            'counts':dict(COUNTS),'maxima':dict(MAXIMA)}


def run():
    start = time.process_time()
    regression = regress()
    COUNTS.clear(); MAXIMA.clear()
    data_bytes = SOURCE.read_bytes()
    assert hashlib.sha256(data_bytes).hexdigest().upper() == SOURCE_SHA
    data = json.loads(data_bytes)
    outcomes = Counter()
    failures, coarse_unproved, translation_details, quotient_details = [], [], [], []
    inv = {'endpoint_occurrences':0,'pair_occurrences':0,'max_input_mantissa_bits':0,
           'max_input_exponent_bits':0,'min_exponent':0,'max_exponent':0,
           'complex_box_occurrences':0}

    def check(category, name, condition):
        outcomes[category+'_attempted'] += 1
        outcomes[category+('_passed' if condition else '_failed')] += 1
        if not condition:
            failures.append(name)

    def pairs(raw, shown, path):
        if len(raw) == 2 and all(isinstance(x, dict) and 'mantissa' in x for x in raw):
            lo, hi = interval(raw)
            dl, du = map(display, shown)
            inv['pair_occurrences'] += 1
            for endpoint in raw:
                m, e = int(endpoint['mantissa']), endpoint['exponent']
                inv['endpoint_occurrences'] += 1
                inv['max_input_mantissa_bits'] = max(inv['max_input_mantissa_bits'], abs(m).bit_length())
                inv['max_input_exponent_bits'] = max(inv['max_input_exponent_bits'], abs(e).bit_length())
                inv['min_exponent'] = min(inv['min_exponent'], e)
                inv['max_exponent'] = max(inv['max_exponent'], e)
            check('endpoint_order', path, cmp(lo, hi) <= 0)
            check('display_containment', path, cmp(dl, lo) <= 0 and cmp(hi, du) <= 0)
            check('display_directed_rounding', path,
                  cmp(round_grid(lo, -128)[0], dl) == 0 and cmp(round_grid(hi, -128)[1], du) == 0)
        else:
            assert len(raw) == len(shown)
            for k, (r, s) in enumerate(zip(raw, shown)):
                pairs(r, s, f'{path}/{k}')

    def walk(obj, path=''):
        if isinstance(obj, dict):
            if 'binary_re' in obj and 'binary_im' in obj:
                inv['complex_box_occurrences'] += 1
            for key, value in obj.items():
                if key.startswith('binary_'):
                    pairs(value, obj[key[7:]], path+'/'+key)
                else:
                    walk(value, path+'/'+key)
        elif isinstance(obj, list):
            for k, value in enumerate(obj):
                walk(value, f'{path}/{k}')
    walk(data)

    pi = interval(data['binary_pi'])
    for pidx, point in enumerate(data['points']):
        tag = f'point{pidx}'
        T, r = point['T'], Fraction(point['r'])  # small metadata only
        denom = D(T+1)
        w, initial = box(point['w']), box(point['initial_tau'])
        exact_r = D(r.numerator, -(r.denominator.bit_length()-1))
        check('w_real',tag,cmp(w[0][0],exact_r)<=0 and cmp(exact_r,w[0][1])<=0)
        check('w_imag_from_pi_eta',tag,
              sign3(mul(denom,mul(pi[0],D(1,-2))),-mul(denom,w[1][0]),-ONE)>=0
              and sign3(mul(denom,w[1][1]),-mul(denom,mul(pi[1],D(1,-2))),ONE)>=0)
        check('initial_imaginary_lower',tag,cmp(mul(initial[1][0],denom),ONE)>=0)
        previous = initial
        for sidx, step in enumerate(point['steps']):
            st = f'{tag}/step{sidx}/{step["kind"]}'
            inp, out = box(step['input']), box(step['output'])
            check('step_chain',st,same_box(previous,inp))
            check('upper_half_plane',st,inp[1][0].m>0 and out[1][0].m>0)
            if step['kind']=='T':
                n = D(step['n'])
                check('translation',st,
                      sign3(inp[0][0],-n,-out[0][0])>=0
                      and sign3(out[0][1],-inp[0][1],n)>=0
                      and same_interval(inp[1],out[1]))
                # Diagnostic only, with an explicit bounded alignment guard.
                # Positive deficits mean the output excludes a portion of the
                # translated serialized input box. Never align a huge gap here.
                deficits = []
                for terms in ((out[0][0],-inp[0][0],n),(inp[0][1],-n,-out[0][1])):
                    terms = [x for x in terms if x.m]
                    e = min(x.e for x in terms)
                    gap = max(x.e for x in terms)-e
                    if gap <= 2048:
                        d = D(sum(left(x.m,x.e-e,2048) for x in terms),e)
                        deficits.append({'mantissa':str(d.m),'exponent':d.e})
                    else:
                        deficits.append({'sign':sign3(*terms),'exact_diagnostic':'omitted: gap guard'})
                translation_details.append({'path':st,'n':step['n'],'inward_deficits':deficits})
                check('translation_range',st,
                      cmp(mul(out[0][0],D(5)),D(-3))>0 and cmp(mul(out[0][1],D(5)),D(3))<0)
                ph = box(step['phase8']); rem = step['n']%8
                for coord, sign in zip(ph, ((1,0),(1,1),(0,1),(-1,1),(-1,0),(-1,-1),(0,-1),(1,-1))[rem]):
                    if rem%2==0:
                        check('phase8',st,cmp(coord[0],D(sign))<=0 and cmp(D(sign),coord[1])<=0)
                    else:
                        mag = coord if sign>0 else neg_interval(coord)
                        check('phase8',st,sqrt_witness(D(1,-1),mag[0],mag[1]))
            else:
                check('inversion_domain',st,cmp(inp[1][1],D(1,-1))<0)
                check('inversion_growth',st,cmp(mul(out[1][0],D(61)),mul(inp[1][1],D(100)))>0)
                rw=step['root_witness']; z=box(rw['z'])
                norm=interval(rw['binary_norm']); u=interval(rw['binary_u']); v=interval(rw['binary_v'])
                root=box(rw['root']); A=box(rw['A'])
                check('root_argument_enclosure',st,contains_interval(z[0],inp[1])
                      and contains_interval(z[1],neg_interval(inp[0])))
                check('root_branch_domain',st,z[0][0].m>0 and norm[0].m>=0 and u[0].m>0)
                xs,ys=square_bounds(z[0]),square_bounds(z[1])
                check('root_norm_square',st,
                      sign3(xs[0],ys[0],-mul(norm[0],norm[0]))>=0
                      and sign3(mul(norm[1],norm[1]),-xs[1],-ys[1])>=0)
                check('root_u_square',st,
                      sign3(norm[0],z[0][0],-mul(D(2),mul(u[0],u[0])))>=0
                      and sign3(mul(D(2),mul(u[1],u[1])),-norm[1],-z[0][1])>=0)
                corners=[]
                for yi,y in enumerate(z[1]):
                    for ui,uu in enumerate(u):
                        denominator=mul(D(2),uu)
                        lower=sign3(y,-mul(v[0],denominator))
                        upper=sign3(mul(v[1],denominator),-y)
                        accepted=quotient_witness(y,denominator,v[0],v[1])
                        assert accepted == (lower>=0 and upper>=0)
                        corners.append(accepted)
                        if not accepted:
                            quotient_details.append({'path':st,'numerator_endpoint':yi,
                                'u_endpoint':ui,'lower_residual_sign':lower,'upper_residual_sign':upper})
                check('root_v_quotient',st,all(corners))
                check('root_assembly',st,same_interval(root[0],u) and same_interval(root[1],v))
                for label, aa, bb in [('root_A',root,A),('S_output',inp,tuple(neg_interval(c) for c in out))]:
                    result=reciprocal_box_witness(aa,bb)
                    outcomes['coarse_reciprocal_attempted']+=1
                    outcomes['coarse_reciprocal_passed' if result else 'coarse_reciprocal_not_certified']+=1
                    if not result: coarse_unproved.append(st+'/'+label)
            previous=out
        reduced=box(point['reduced_tau'])
        check('final_chain',tag,same_box(previous,reduced))
        check('terminal_domain',tag,cmp(mul(reduced[1][0],D(5)),D(2))>0)
        check('inversion_count',tag,point['inversions']==sum(s['kind']=='S' for s in point['steps'])<=35)
    corruption = {}
    try:
        interval(list(reversed(data['binary_pi'])))
        corruption['reversed_actual_pi_interval'] = False
    except ValueError:
        corruption['reversed_actual_pi_interval'] = True
    corruption['false_actual_display_box'] = not(cmp(ZERO,pi[0])<=0 and cmp(pi[1],ZERO)<=0)
    first_root=next(s['root_witness'] for s in data['points'][0]['steps'] if s['kind']=='S')
    wrong=neg_interval(interval(first_root['binary_u']))
    corruption['opposite_actual_root_branch'] = wrong[0].m<=0
    assert all(corruption.values())
    return {'status':'PASS recorded compact arithmetic checks' if not failures else 'PARTIAL: listed sufficient checks failed',
            'source':str(SOURCE),'source_sha256':SOURCE_SHA,'inventory':inv,
            'checks':dict(outcomes),'failed_checks':failures,
            'translation_details':translation_details,
            'failed_quotient_corners':quotient_details,
            'coarse_reciprocal_not_certified':coarse_unproved,'corruption_controls':corruption,
            'actual_replay_counts':dict(COUNTS),'actual_replay_maxima':dict(MAXIMA),
            'regression':regression,'cpu_seconds_including_regression':time.process_time()-start,
            'not_certified':['truth of pi/exp/sin/cos or Gaussian-tail values',
                             'entire reduced series or derivative-unwind arithmetic',
                             'complete complex reciprocal operations where the coarse sufficient rule did not pass',
                             'actual theta/xi values, spectral statements, or Lean kernel acceptance'],
            'scope':'conditional arithmetic/serialization checks on supplied interval endpoints, not analytic certificate validation'}


if __name__=='__main__':
    result=run()
    result['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({k:result[k] for k in ('status','inventory','checks','failed_checks','actual_replay_maxima')},indent=2))
