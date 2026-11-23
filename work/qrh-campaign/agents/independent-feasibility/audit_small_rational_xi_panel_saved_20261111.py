"""Saved-data-only audit: no imports of evaluators and no analytic evaluation."""
from fractions import Fraction as Q
from pathlib import Path
from collections import Counter
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'integration/rational_xi_panel_candidate_20261111_01.json':
        '1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F',
    'independent-feasibility/small_rational_xi_panel_replay_20261111_01.json':
        'A8C296D1150E79D928D4990B90D25D4C6BC1F359DC2A1CB89377309185E3C51B',
    'independent-feasibility/small_rational_xi_panel_comparison_20261111_01.json':
        '720B4C7A021EB50421747CF6D7A889242995C26BD11D560A586230B87B89B9AC',
    'independent-feasibility/replay_small_rational_xi_panel_20261111.py':
        'E7C235B05B18818E1C5F44E631BCD924021F2A21D3ADB6D94A2EFE7032C4E171',
}


def need(ok, why):
    if not ok: raise ValueError(why)


def ball_contains(box, center, radius, bits, cap):
    need(len(center) == 2 and all(type(i) is int for i in center), 'integer center')
    r = Q(radius)
    need(0 <= r <= cap, 'radius allocation')
    e = Q(0)
    for endpoints, c in zip(box, center):
        lo, hi = map(Q, endpoints)
        need(lo <= hi, 'ordered independent interval')
        e += max(abs(lo-Q(c, 1 << bits)), abs(hi-Q(c, 1 << bits)))
    need(e <= r, 'entire independent box inside claimed ball')
    return r-e


def expect_reject(fn):
    try: fn()
    except ValueError: return True
    raise ValueError('negative control was not rejected')


def main():
    loaded = {}
    for rel, digest in PINS.items():
        data = (AGENTS/rel).read_bytes()
        need(hashlib.sha256(data).hexdigest().upper() == digest, 'pin '+rel)
        if rel.endswith('.json'): loaded[rel] = json.loads(data)
    a = loaded['integration/rational_xi_panel_candidate_20261111_01.json']
    b = loaded['independent-feasibility/small_rational_xi_panel_replay_20261111_01.json']
    previous = loaded['independent-feasibility/small_rational_xi_panel_comparison_20261111_01.json']
    need(a['target']['T_input'] == 32 and a['target']['T_work'] == 14
         and a['target']['b_expression'] == 'pi/4-1/33'
         and a['target']['h'] == '1/256' and a['target']['K'] == 928
         and a['target']['degree'] == 6 and a['target']['center_re'] == '3/5'
         and a['target']['center_im'] == '14' and a['target']['rho'] == '1/64', 'fixed target')
    need([r['k'] for r in a['nodes']] == list(range(929)), 'all producer nodes')
    need([r['k'] for r in b['nodes']] == list(range(929)), 'all independent nodes')
    slacks = []
    for x, y in zip(a['nodes'], b['nodes']):
        slacks.append(ball_contains(y['box'], x['center'], x['radius'], 32, Q(1, 2**24)))
        need(sum(Q(i, 2**32)**2 for i in x['center']) < 2**54, 'center norm')
    assembly = a['assembly']
    need([g['k'] for g in assembly['weights']] == list(range(-928, 929)), 'all signed groups')
    lookup = {}
    for y in b['weights']:
        k = y['k']*y['sign']; key = (k, y['j'])
        need(key not in lookup, 'independent weight uniqueness')
        lookup[key] = y
    need(len(lookup) == 12999, 'all independent weights')
    weight_slacks = []
    total = [[0, 0] for _ in range(7)]
    for g in assembly['weights']:
        k = g['k']; need(len(g['weights']) == 7, 'seven orders')
        px, py = a['nodes'][abs(k)]['center']
        if k < 0: py = -py
        for j, x in enumerate(g['weights']):
            y = lookup.pop((k, j))
            weight_slacks.append(ball_contains(y['box'], x['center'], x['radius'], 64, Q(1, 2**48)))
            wx, wy = x['center']
            total[j][0] += px*wx-py*wy; total[j][1] += px*wy+py*wx
    need(not lookup, 'no omitted independent weights')
    need(total == assembly['coefficients'], 'seven exact integer coefficient sums')
    U = sum(Q(abs(x)+abs(y), 2**96*64**j) for j, (x, y) in enumerate(total) if j)
    margin = Q(total[0][0], 2**96)-U
    E = Q(assembly['total_disk_error_upper'])
    need(U == Q(assembly['nonconstant_norm_upper']) and margin == Q(assembly['real_margin']), 'polynomial arithmetic')
    need(Q(b['budget']['total']) <= E == Q('0.091500568239') < Q(1, 10), 'independent complete error')
    need(margin > Q('14.0688') and margin-E > Q('13.977299'), 'strict whole-disk margin')
    need(previous['candidate_review']['center_minus_polynomial'] == str(margin), 'previous comparison agrees')
    need(previous['node_balls'] == 929 and previous['weight_balls'] == 12999
         and previous['coefficient_sums'] == 7, 'previous complete counts')
    vertices = [tuple(map(Q, v)) for v in a['target']['ccw_vertices']]
    need(vertices == [(Q(379,640),Q(1791,128)),(Q(389,640),Q(1791,128)),
                      (Q(389,640),Q(1793,128)),(Q(379,640),Q(1793,128)),
                      (Q(379,640),Q(1791,128))], 'exact rectangle and orientation')
    need(all((x-Q(3,5))**2+(y-14)**2 == Q(1,8192) < Q(1,4096) for x,y in vertices), 'whole rectangle in disk')
    # These mutate consumed claims only; unused internal metadata is not a premise.
    x, y = a['nodes'][0], b['nodes'][0]
    bad_center = [x['center'][0]+2**32, x['center'][1]]
    controls = {
        'unit_shifted_node_center': expect_reject(lambda: ball_contains(y['box'], bad_center, x['radius'], 32, Q(1,2**24))),
        'false_zero_node_radius': expect_reject(lambda: ball_contains(y['box'], x['center'], '0', 32, Q(1,2**24))),
        'missing_node': expect_reject(lambda: need(len(a['nodes'][:-1]) == 929, 'node count')),
        'duplicated_node_index': expect_reject(lambda: need([0,0]+list(range(2,929)) == list(range(929)), 'index list')),
        'altered_coefficient_integer': expect_reject(lambda: need(total[0][0]+1 == assembly['coefficients'][0][0], 'coefficient')),
        'altered_target_shift': expect_reject(lambda: need('pi/4-1/32' == a['target']['b_expression'], 'b')),
    }
    group = assembly['weights'][0]; w = group['weights'][1]
    ref = next(z for z in b['weights'] if z['k'] == 928 and z['sign'] == -1 and z['j'] == 1)
    controls['negated_odd_weight'] = expect_reject(lambda: ball_contains(ref['box'], [-c for c in w['center']], w['radius'],64,Q(1,2**48)))
    result = {'status':'PASS_SAVED_DATA_FULL_CONTAINMENT_AND_ASSEMBLY', 'input_pins':PINS,
              'nodes':929,'weights':12999,'coefficients':7,'new_numerical_evaluations':0,
              'minimum_node_containment_slack':str(min(slacks)),
              'minimum_weight_containment_slack':str(min(weight_slacks)),
              'margin':str(margin),'error':str(E),'margin_minus_error':str(margin-E),
              'terminal_types':dict(Counter(x['terminal_type'] for x in a['nodes'])),
              'negative_controls':controls,
              'scope':'All consumed balls and sums; no claims about unused internal metadata or Lean soundness',
              'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
    out = Path(__file__).with_suffix('.json')
    need(not out.exists(), 'new receipt only')
    out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({'status':result['status'],'nodes':929,'weights':12999,'negative_controls':len(controls)}))


if __name__ == '__main__': main()
