"""Integer-only denominator-cleared log and theta audit; no prime generation.

This independent arithmetic representation supplements the prior Fraction replay.
It does not establish the supplied prime counts or produce a Lean proof.
"""
from pathlib import Path
from math import factorial, gcd
import hashlib
import json

H = Path(__file__).resolve().parent
D = H / 'psi_full_candidate_20261111'
S = 10**9
B = 5*10**9
F11 = factorial(11)
manifest = []
def load(path):
    raw = path.read_bytes()
    manifest.append({'file': str(path.relative_to(H)),
                     'sha256': hashlib.sha256(raw).hexdigest()})
    return json.loads(raw)

first = load(H / 'resume_psi_short_gap_20261111.json')
rows = [{'index': 1, 'a': S, 'b': first['pilot_endpoint'],
         'count': first['pilot_count'], 'subwindows': first['pilot_subwindows'],
         'log_box': first['pilot_log_box'], 'theta_lower': first['pilot_theta_lower'],
         'theta_upper': first['pilot_theta_upper']}]
for name in ['resume_psi_multi32_20261111.json', 'resume_psi_stress512_20261111.json']:
    for row in load(H / name)['windows']:
        rows.append(dict(row, index=row['grid_window_index']))
for path in sorted(D.glob('batch_*.json')):
    rows.extend(load(path)['windows'])
assert len(rows) == 6439

def poly(r):
    # 11! S^11 T12(r/S), represented in two separate integer forms.
    acc = 1
    for j in range(10, -1, -1):
        acc = acc*r + (F11//factorial(j))*S**(11-j)
    direct = sum((F11//factorial(j))*r**j*S**(11-j) for j in range(12))
    assert acc == direct
    return acc

log_records = []
max_bits = 0
def check_box(x, lo, hi):
    global max_bits
    assert 0 < x and 0 <= lo <= hi and hi-lo <= 100
    q, r = divmod(lo, S)
    lower_lhs = 27182818286**q * (144*S*poly(r)+13*r**12)
    lower_rhs = x*10**(10*q)*144*F11*S**12
    assert lower_lhs <= lower_rhs
    q2, r2 = divmod(hi, S)
    upper_lhs = x*10**(10*q2)*F11*S**11
    upper_rhs = 27182818283**q2 * poly(r2)
    assert upper_lhs < upper_rhs
    max_bits = max(max_bits, *(z.bit_length() for z in
                              [lower_lhs, lower_rhs, upper_lhs, upper_rhs]))
    log_records.append({'x':x, 'box':[lo,hi],
                        'lower_gap':lower_rhs-lower_lhs,
                        'lower_den':lower_rhs,
                        'upper_gap':upper_rhs-upper_lhs,
                        'upper_den':upper_rhs})

def equals_scaled(text, scaled):
    fields = str(text).split('/')
    num = int(fields[0]); den = int(fields[1]) if len(fields)==2 else 1
    assert den > 0 and num*S == scaled*den

a = S
L = 999967635190289132
U = 999970323068320645
left_lo, left_hi = 20723265833, 20723265841
check_box(a, left_lo, left_hi)
assert a*(S-S//10000) <= L <= U <= a*(S+S//10000)
chain = hashlib.sha256()
min_lower = None
min_upper = None
total = 0
subcell_total = 0
for i, row in enumerate(rows, 1):
    b, c = row['b'], row['count']
    assert row['index']==i and row['a']==a and b==min(B,a+a//4000) and a<b
    n = a
    csum = 0
    for cell in row['subwindows']:
        assert cell['n']==n and 0<cell['width']<=32768
        assert 0<=cell['count']<=cell['width']
        n += cell['width']; csum += cell['count']; subcell_total += 1
    assert n==b and csum==c
    right_lo,right_hi = row['log_box']
    check_box(b,right_lo,right_hi)
    Lnew = L+c*left_lo
    Unew = U+c*right_hi
    if i<=538:
        equals_scaled(row['theta_lower'], Lnew)
        equals_scaled(row['theta_upper'], Unew)
    else:
        assert Lnew==row['theta_lower_scaled'] and Unew==row['theta_upper_scaled']
    ml = Lnew-b*(S-S//10000)
    mu = b*(S+S//10000)-Unew
    assert ml>=0 and mu>=0  # Integer subtraction, never truncated Nat subtraction.
    if min_lower is None or ml<min_lower['margin_scaled']:
        min_lower={'index':i,'endpoint':b,'margin_scaled':ml}
    if min_upper is None or mu<min_upper['margin_scaled']:
        min_upper={'index':i,'endpoint':b,'margin_scaled':mu}
    chain.update(json.dumps([i,a,b,c,left_lo,right_lo,right_hi,Lnew,Unew],
                            separators=(',',':')).encode()+b'\n')
    total += c
    a,L,U,left_lo,left_hi = b,Lnew,Unew,right_lo,right_hi

assert a==B and total==184106689 and subcell_total==125271
assert L==4999882220821805278 and U==4999930929840072558
assert 31622**2 < S
# 1.4262 / 31622 < 17 / 360000, and the two interpolation budgets.
assert 14262*360000 < 17*10000*31622
assert 7*2300 < 20000
assert 572053*2300 < 1440000000
assert 27**23 > B*10**23

def smallest_relative(which):
    winner = log_records[0]
    for rec in log_records[1:]:
        if rec[which+'_gap']*winner[which+'_den'] < winner[which+'_gap']*rec[which+'_den']:
            winner=rec
    num, den=winner[which+'_gap'],winner[which+'_den']
    g=gcd(num,den)
    return {'endpoint':winner['x'], 'box':winner['box'],
            'gap_relative_to_comparison_rhs':[num//g,den//g]}

out = {
    'status':'PASS integer-only arithmetic audit; counts not reproved; no Lean proof',
    'windows':len(rows), 'subcells':subcell_total,
    'log_endpoints_including_seed':len(log_records), 'log_inequalities':2*len(log_records),
    'polynomial_Horner_and_direct_forms_agree':True,
    'maximum_integer_comparison_operand_bits':max_bits,
    'minimum_lower_log_relative_slack':smallest_relative('lower'),
    'minimum_upper_log_relative_slack':smallest_relative('upper'),
    'minimum_lower_checkpoint_margin':min_lower,
    'minimum_upper_checkpoint_margin':min_upper,
    'final_endpoint':a, 'final_theta_scaled':[L,U], 'scale':S,
    'transition_record_digest':chain.hexdigest(),
    'seed_log_and_relative_centering_rechecked':True,
    'supplied_counts_assumed_for_arithmetic_replay':True,
    'input_manifest':manifest,
}
print(json.dumps(out,indent=2))
