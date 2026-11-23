"""Exact conductor metadata only. No L/zero/prime-value evaluation or imports."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]
PROFILE = ROOT / 'qrh-blueprint/SELECTED_HIGH_CONDUCTOR_PROFILE_2026-11-11.md'
PIN = 'D0F77CCCFCE45DBFE5C863643236107ECBBE4D363103A70BB06CE57213A42CB7'
D = 10**8
LIMIT = 300000

def ceilq(q):
    return -((-q.numerator)//q.denominator)

def qobj(q):
    return {'num': str(q.numerator), 'den': str(q.denominator)}

def outward(q, scale=10**12):
    n = q.numerator * scale // q.denominator
    return {'lower_scaled': str(n), 'upper_scaled': str(n+1), 'scale': str(scale)}

def run():
    assert hashlib.sha256(PROFILE.read_bytes()).hexdigest().upper() == PIN
    # phi(n)=n-sum_{d|n,d<n} phi(d), then phi(n)=sum_{d|n} a(d).
    # This divisor-inversion construction is independent of the prime-power formula.
    phi = list(range(LIMIT+1))
    for d in range(1, LIMIT+1):
        for n in range(2*d, LIMIT+1, d):
            phi[n] -= phi[d]
    a = phi.copy()
    for d in range(1, LIMIT+1):
        assert a[d] >= 0
        for n in range(2*d, LIMIT+1, d):
            a[n] -= a[d]
    groups = {k: {'conductors': 0, 'characters': 0,
                  'old_floor': 0, 'old_ceil': 0, 'new_floor': 0, 'new_ceil': 0,
                  'head_terms_old': 0, 'head_terms_new': 0}
              for k in ('low_including_one', 'high_odd', 'high_four_divisible')}
    active = []
    for c in range(1, LIMIT+1):
        if not ((c % 2 and c <= 150000) or c % 4 == 0):
            continue
        qt = 2*c if c%2 else c
        hp = ceilq(200 + max(Q(1000), Q(844800000, 7*qt)))
        old = min(Q(hp), Q(100000000, c))
        new = old if c <= 100000 else Q(50000000 if c%2 else 99000000, c)
        assert 0 < new <= old
        if c > 100000:
            assert old == Q(100000000, c)
        key = 'low_including_one' if c <= 100000 else ('high_odd' if c%2 else 'high_four_divisible')
        g = groups[key]
        g['conductors'] += 1
        g['characters'] += a[c]
        for label,h in (('old', old), ('new', new)):
            val = a[c]*h*D
            g[label+'_floor'] += val.numerator//val.denominator
            g[label+'_ceil'] += ceilq(val)
            # One center for every nonprincipal row at top H; sharing all characters.
            # This is the literal N*phi(c) input-term count of the uniform EM rule,
            # not a predicted evaluation/operation count or optimal schedule.
            if c != 1:
                g['head_terms_'+label] += phi[c]*(ceilq(h)+36)
        active.append(c)
    assert len(active) == 150000
    assert sum(g['characters'] for g in groups.values()) == 5543640188
    assert a[1] == 1
    assert groups['low_including_one']['characters'] == 1847865075
    total = {key: sum(g[key] for g in groups.values()) for key in next(iter(groups.values()))}
    ratio_low = Q(total['new_floor'], total['old_ceil'])
    ratio_high = Q(total['new_ceil'], total['old_floor'])
    assert Q(84607962994,10**11) < ratio_low <= ratio_high < Q(84607962997,10**11)
    assert ratio_low > Q(1,2)
    # Turing auxiliary-zone headroom under the SAME c*T<=1e8 specialization.
    guards = {
        'even_at_c300000_exact_main_height': qobj(Q(1000000,300000)),
        'even_at_c300000_floor_plus_one': qobj(Q(100000000,300000)-331),
        'odd_uniform_for_c_le150000': qobj(Q(50000000,150000)),
    }
    return {'scope': 'exact conductor metadata; no numerical function values or runtime model',
            'profile_sha256': PIN, 'scale': D, 'groups': groups, 'total': total,
            'ratio_bounds_exact': [qobj(ratio_low), qobj(ratio_high)],
            'ratio_decimal_outer': [outward(ratio_low), outward(ratio_high)],
            'one_minus_ratio_bounds': [qobj(1-ratio_high), qobj(1-ratio_low)],
            'principal_old_and_new': 60343058,
            'auxiliary_headroom': guards}

if __name__ == '__main__':
    result = run()
    path = Path(__file__).with_suffix('.json')
    assert not path.exists(), 'Do not overwrite a frozen receipt'
    path.write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
    print(json.dumps({'receipt': str(path), 'total': result['total'],
                      'groups': result['groups'], 'ratio_decimal_outer': result['ratio_decimal_outer']}))
