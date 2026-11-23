"""Independent rational-only review; no producer imports or analytic evaluations."""
from fractions import Fraction as Q
from pathlib import Path
from math import isqrt
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
pins = {
    'mellin/PRINCIPAL_MODULAR_RECTANGLE_ADAPTER_2026-11-11.md': '3ACC47F6948ADE678D9F615D8701E3C51C818B381C12338BC8AADB709E51D89C',
    'mellin/principal_modular_rectangle_adapter_20261111.py': '7014C0E7DB233524A76712A1728894F2B39738BB8A01DB641D2ADC2372A61AE4',
    'mellin/principal_modular_rectangle_adapter_20261111.json': '1F5A102C1D5BAB8C29F3B33CE5F587534C6A72A7C3FAD34F5DBA8C900DDC590E',
    'prime-estimates/principal_modular_xi_panel_pilot_20261111.json': '0B01EC0CA4A0102816CFB22DE51AE5751975288AC1544F5ABBABCA84BF4A8608',
}
for name, digest in pins.items():
    assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest().upper() == digest
a = json.loads((ROOT/'mellin/principal_modular_rectangle_adapter_20261111.json').read_text())
for name, digest in a['pins'].items():
    assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest().upper() == digest
d = json.loads((ROOT/'prime-estimates/principal_modular_xi_panel_pilot_20261111.json').read_text())
cs = d['coefficients']
rho = Q(1,64)
assert d['degree'] == 12
assert Q(d['parameters']['sigma']) == Q(3,5)
assert Q(d['parameters']['t']) == 14
assert Q(d['parameters']['eta']) == Q(1,33)
assert Q(d['parameters']['rho']) == rho
assert [c['j'] for c in cs] == list(range(13))
centers = [tuple(Q(int(n),int(c['center_denominator'])) for n in c['center_numerators']) for c in cs]
assert int(cs[0]['center_denominator']) == 2**256
assert list(map(Q,a['rational_image_center'])) == list(centers[0])
for c in cs:
    assert Q(c['total_error']) == sum((Q(c[k]) for k in ('Q','S','node_error','weight_error','summation_error')), Q(0))
remainder = Q(d['constants']['D'])*rho**13/(1-rho)
assert remainder == Q(40121785,387381625547900583936) == Q(d['disk']['remainder'])
error = remainder + sum(Q(c['total_error'])*rho**c['j'] for c in cs)
assert error == Q(d['disk']['coefficient_error_plus_remainder']) == Q(a['error_plus_remainder_rechecked'])

# An independently rounded upper bound for each exact rational coefficient norm.
def norm_upper(xy):
    n = xy[0]**2 + xy[1]**2
    scale = 2**256
    k = isqrt(n.numerator*scale**2//n.denominator)
    if Q(k,scale)**2 < n:
        k += 1
    assert Q(k,scale)**2 >= n
    return Q(k,scale)
variation_check = sum(norm_upper(centers[j])*rho**j for j in range(1,13))
variation = Q(d['disk']['polynomial_variation_upper'])
assert 0 <= variation_check <= variation
radius = variation + error
assert radius == Q(d['disk']['total_radius_about_constant']) == Q(a['accepted_radius_about_image_center'])
margin = centers[0][0] - radius
assert centers[0][0] > Q(159,10)
assert 0 <= radius < Q(9,5)
assert margin == Q(a['real_part_lower_bound']) > Q(141,10)

# Independent geometry using printed endpoints, then compare every saved panel.
xl,xr,yb,yt = Q(379,640),Q(389,640),Q(1791,128),Q(1793,128)
verts = [(xl,yb),(xr,yb),(xr,yt),(xl,yt),(xl,yb)]
assert 0 < xl < xr < 1
assert (xl+xr)/2 == Q(3,5) and (yb+yt)/2 == 14
assert (xr-xl)/2 == (yt-yb)/2 == Q(1,128)
max_dist_squared = ((xr-xl)/2)**2 + ((yt-yb)/2)**2
assert max_dist_squared == Q(1,8192) < rho**2
assert [[Q(v) for v in p] for p in a['rectangle']['vertices_ccw']] == [list(p) for p in verts]
crossings = []
for j,p in enumerate(a['panels']):
    assert list(map(Q,p['from'])) == list(verts[j])
    assert list(map(Q,p['to'])) == list(verts[j+1])
    assert list(map(Q,p['rotation'])) == [1,0]
    v,w = tuple(map(Q,p['image_from'])),tuple(map(Q,p['image_to']))
    assert v == w == centers[0] and v[0] > 0
    determinant = v[0]*w[1]-v[1]*w[0]
    up = v[1] <= 0 < w[1] and determinant > 0
    down = w[1] <= 0 < v[1] and determinant < 0
    crossings.append(int(up)-int(down))
    assert p['crossing'] == crossings[-1] == 0
assert sum(crossings) == a['crossing_sum'] == 0
area2 = sum(verts[j][0]*verts[j+1][1]-verts[j+1][0]*verts[j][1] for j in range(4))
assert area2 == Q(1,2048) == Q(a['rectangle']['signed_twice_area'])
steps = [(verts[j+1][0]-verts[j][0],verts[j+1][1]-verts[j][1]) for j in range(4)]
assert steps == [(Q(1,64),0),(0,Q(1,64)),(-Q(1,64),0),(0,-Q(1,64))]
ball = a['argument_principle']
assert tuple(map(Q,ball['ball_center'])) == verts[0]
assert Q(ball['R']) == Q(33,16) > 0
assert xr-xl+yt-yb == Q(ball['rectangle_distance_L1_upper']) == Q(1,32)
assert Q(1,32) < Q(ball['R_over_2']) == Q(ball['R'])/2

out = {'status':'PASS rational-only independent review', 'input_pins':pins,
       'accepted_dependency_pins':a['pins'], 'coefficients_checked':13,
       'norm_upper_method':'integer square root, directed upward at denominator 2^256',
       'variation_upper_recomputed':str(variation_check), 'disk_radius':str(radius),
       'real_part_margin':str(margin), 'margin_exceeds':'141/10',
       'max_distance_squared':str(max_dist_squared), 'signed_twice_area':str(area2),
       'crossings':crossings, 'scope':'No analytic evaluations, no producer execution, no Lean; accepted disk enclosure reused.'}
dest = HERE/'review_principal_modular_rectangle_20261111.json'
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'status':out['status'],'coefficients_checked':13,'crossings':crossings,'margin_exceeds':'141/10','receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
