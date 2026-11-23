"""Exact rational polynomial/panel tests. No L-functions or floating-point arithmetic."""
from fractions import Fraction as F
from math import comb
from pathlib import Path
import hashlib
import json


def z(x=0, y=0): return (F(x), F(y))
def add(a, b): return (a[0] + b[0], a[1] + b[1])
def neg(a): return (-a[0], -a[1])
def sub(a, b): return add(a, neg(b))
def mul(a, b): return (a[0]*b[0]-a[1]*b[1], a[0]*b[1]+a[1]*b[0])
def scale(a, r): return (a[0]*r, a[1]*r)


def pmul(p, q):
    out = [z() for _ in range(len(p) + len(q) - 1)]
    for i, a in enumerate(p):
        for j, b in enumerate(q): out[i+j] = add(out[i+j], mul(a, b))
    return out


def peval(p, a):
    out = z()
    for x in reversed(p): out = add(mul(out, a), x)
    return out


def pcompose_linear(p, a, d):
    out = [z() for _ in p]
    power = [z(1)]
    for coefficient in p:
        for j, value in enumerate(power): out[j] = add(out[j], mul(coefficient,value))
        power = pmul(power,[a,d])
    return out


def complete_linear_factor_check(p, roots):
    out=[z(1)]
    for root, multiplicity in roots:
        derivative=p[:]
        for order in range(multiplicity):
            assert peval(derivative,root)==z()
            derivative=[scale(derivative[j],j) for j in range(1,len(derivative))]
            out=pmul(out,[neg(root),z(1)])
        assert peval(derivative,root)!=z()
    assert out==p


def quadratic(center):
    """(s-center)^2+1, with roots center +/- i."""
    return [z(center*center + 1), z(-2*center), z(1)]


def bernstein(p, a, b):
    """Coefficients of p(a+t(b-a)) in degree-n Bernstein basis on [0,1]."""
    n, d = len(p)-1, sub(b, a)
    ap, dp = [z(1)], [z(1)]
    for _ in range(n): ap.append(mul(ap[-1], a)); dp.append(mul(dp[-1], d))
    power = [z() for _ in range(n+1)]
    for j in range(n+1):
        for i in range(j, n+1):
            power[j] = add(power[j], scale(mul(mul(p[i], ap[i-j]), dp[j]), comb(i, j)))
    out = []
    for k in range(n+1):
        t = z()
        for j in range(k+1): t = add(t, scale(power[j], F(comb(k, j), comb(n, j))))
        out.append(t)
    assert out[0] == peval(p, a) and out[-1] == peval(p, b)
    return out


def axes(v): return [v[0], -v[0], v[1], -v[1]]
def enc(a): return [str(a[0]), str(a[1])]
def dec(a): return z(*a)


def crossing(a, b):
    det = a[0]*b[1] - a[1]*b[0]
    if a[1] <= 0 < b[1] and det > 0: return 1
    if b[1] <= 0 < a[1] and det < 0: return -1
    return 0


def rectangle(p, bounds, expected):
    xmin, xmax, ymin, ymax = map(F, bounds)
    vertices = [z(xmin,ymin), z(xmax,ymin), z(xmax,ymax), z(xmin,ymax), z(xmin,ymin)]
    panels = []
    def split(a, b, side, depth):
        coeff = bernstein(p, a, b)
        margins = [min(axes(v)[i] for v in coeff) for i in range(4)]
        axis = max(range(4), key=lambda i: margins[i])
        if margins[axis] > 0:
            panels.append({'a': enc(a), 'b': enc(b), 'side': side,
                           'image_a': enc(peval(p,a)), 'image_b': enc(peval(p,b)),
                           'axis': axis, 'margin': str(margins[axis]), 'depth': depth})
            return
        assert depth < 24, 'UNRESOLVED_PANEL_LIMIT'
        midpoint = scale(add(a,b), F(1,2))
        assert peval(p,midpoint) != z(), 'EXACT_BOUNDARY_ZERO'
        split(a,midpoint,side,depth+1)
        split(midpoint,b,side,depth+1)
    for i in range(4): split(vertices[i],vertices[i+1],i,0)
    packet = {'bounds': list(map(str,bounds)), 'polynomial': [enc(a) for a in p],
              'panels': panels, 'winding': expected}
    replay(packet)
    return packet


def replay(packet):
    p = [dec(a) for a in packet['polynomial']]
    xmin,xmax,ymin,ymax = map(F,packet['bounds'])
    vertices = [z(xmin,ymin),z(xmax,ymin),z(xmax,ymax),z(xmin,ymax),z(xmin,ymin)]
    assert xmin < xmax and ymin < ymax
    panels = packet['panels']
    assert panels and dec(panels[0]['a']) == dec(panels[-1]['b']) == vertices[0]
    winding, pos = 0, 0
    for side in range(4):
        expected_start, expected_end = vertices[side],vertices[side+1]
        assert pos < len(panels) and dec(panels[pos]['a']) == expected_start
        while pos < len(panels) and panels[pos]['side'] == side:
            item = panels[pos]; a,b=dec(item['a']),dec(item['b'])
            if side == 0: assert a[1] == b[1] == ymin and xmin <= a[0] < b[0] <= xmax
            if side == 1: assert a[0] == b[0] == xmax and ymin <= a[1] < b[1] <= ymax
            if side == 2: assert a[1] == b[1] == ymax and xmax >= a[0] > b[0] >= xmin
            if side == 3: assert a[0] == b[0] == xmin and ymax >= a[1] > b[1] >= ymin
            if pos: assert a == dec(panels[pos-1]['b'])
            ia,ib = peval(p,a),peval(p,b)
            assert enc(ia)==item['image_a'] and enc(ib)==item['image_b']
            coeff = bernstein(p,a,b)
            margin = min(axes(v)[item['axis']] for v in coeff)
            assert margin == F(item['margin']) and margin > 0
            winding += crossing(ia,ib)
            pos += 1
        assert dec(panels[pos-1]['b']) == expected_end
    assert pos == len(panels) and winding == packet['winding']
    return winding


def roots_on_boundary(p, bounds, roots):
    xmin,xmax,ymin,ymax = map(F,bounds)
    for r in roots:
        assert peval(p,r)==z()
        assert xmin <= r[0] <= xmax and ymin <= r[1] <= ymax
        assert r[0] in (xmin,xmax) or r[1] in (ymin,ymax)
    return {'status': 'EXACT_BOUNDARY_ZERO_STRICT_PANEL_CERTIFICATE_INAPPLICABLE',
            'bounds':list(map(str,bounds)), 'witnesses': [enc(r) for r in roots]}


if __name__ == '__main__':
    b,H,T = F(111,200),F(1),F(3,2)
    middle = quadratic(F(1,2))
    fixtures = {
        'allowed_off_line': (pmul(quadratic(F(27,50)),quadratic(F(23,50))),4,0),
        'double_critical': (pmul(middle,middle),4,0),
        'triple_critical': (pmul(pmul(middle,middle),middle),6,2),
    }
    delta=F(1,25)
    assert pcompose_linear(fixtures['allowed_off_line'][0],z(F(1,2)),z(0,1)) == [
        z((1+delta*delta)**2),z(),z(-2+2*delta*delta),z(),z(1)]
    t_base=[z(1),z(),z(-1)]
    assert pcompose_linear(fixtures['double_critical'][0],z(F(1,2)),z(0,1))==pmul(t_base,t_base)
    assert pcompose_linear(fixtures['triple_critical'][0],z(F(1,2)),z(0,1))==pmul(pmul(t_base,t_base),t_base)
    complete_linear_factor_check(fixtures['allowed_off_line'][0],
                                 [(z(beta,sign),1) for beta in [F(27,50),F(23,50)] for sign in [-1,1]])
    for name,multiplicity in [('double_critical',2),('triple_critical',3)]:
        complete_linear_factor_check(fixtures[name][0],[(z(F(1,2),sign),multiplicity) for sign in [-1,1]])
    packets, summary = {}, {}
    for name,(p,total,ordinary_sign_count) in fixtures.items():
        full=rectangle(p,[F(0),F(1),-T,T],total)
        right=rectangle(p,[b,F(2),-T,T],0)
        upper=rectangle(p,[F(9,20),F(11,20),F(9,10),F(11,10)],total//2)
        lower=rectangle(p,[F(9,20),F(11,20),F(-11,10),F(-9,10)],total//2)
        assert upper['winding']+lower['winding']==full['winding']
        assert F(11,20)<b and T>H
        assert total >= ordinary_sign_count+1
        packets[name]={'full':full,'forbidden_right':right,'upper_cluster':upper,'lower_cluster':lower}
        summary[name]={'total_multiplicity':total,'ordinary_line_sign_count':ordinary_sign_count,
                       'integer_deficit':total-ordinary_sign_count,
                       'right_count':right['winding'],'cluster_counts':[upper['winding'],lower['winding']],
                       'panels':{key:len(value['panels']) for key,value in packets[name].items()}}
    boundary_factor=quadratic(b)
    left_factor=quadratic(1-b)
    boundary_poly=pmul(boundary_factor,left_factor)
    packets['exact_beta_boundary']={
        'full':rectangle(boundary_poly,[F(0),F(1),-T,T],4),
        'deflated_right':rectangle(left_factor,[b,F(2),-T,T],0),
        'strict_right_failure':roots_on_boundary(boundary_poly,[b,F(2),-T,T],[z(b,H),z(b,-H)]),
        'boundary_factor': [enc(x) for x in boundary_factor],
        'remaining_factor': [enc(x) for x in left_factor],
    }
    assert pmul(boundary_factor,left_factor)==boundary_poly
    assert peval(boundary_factor,z(b,1))==peval(boundary_factor,z(b,-1))==z()
    complete_linear_factor_check(boundary_poly,[(z(beta,sign),1) for beta in [b,1-b] for sign in [-1,1]])
    summary['exact_beta_boundary']={'total_multiplicity':4,'right_test':'BLOCKED_BY_EXACT_ALLOWED_BOUNDARY_ZEROS',
                                    'after_exact_factor_handling':'WEAK_STRIP_ACCEPTED',
                                    'included_height_endpoints':['-1','1']}
    height_failure=roots_on_boundary(fixtures['allowed_off_line'][0],[F(0),F(1),-H,H],
                                     [z(F(27,50),H),z(F(27,50),-H)])
    square=[z(1,-1),z(1,1),z(-1,1),z(-1,-1),z(1,-1)]
    assert sum(crossing(a,b) for a,b in zip(square,square[1:]))==1
    assert sum(crossing(b,a) for a,b in zip(square,square[1:]))==-1
    # Rejection checks operate on deep copies of valid records.
    from copy import deepcopy
    corrupt=deepcopy(packets['allowed_off_line']['forbidden_right'])
    corrupt['panels'][0]['margin']='0'
    try: replay(corrupt)
    except AssertionError: pass
    else: raise AssertionError('CORRUPT_MARGIN_ACCEPTED')
    corrupt=deepcopy(packets['allowed_off_line']['forbidden_right'])
    del corrupt['panels'][0]
    try: replay(corrupt)
    except AssertionError: pass
    else: raise AssertionError('MISSING_PANEL_ACCEPTED')
    output={'status':'PASS_EXACT_SYNTHETIC_ONLY','b':str(b),'closed_target_height':str(H),
            'contour_top':str(T),'summary':summary,'packets':packets,
            'exact_height_boundary_failure':height_failure,
            'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'scope':'Polynomial fixtures only. Analytic interpretation uses Bernstein convex hull and reviewed polygon theorem. No Dirichlet or Lean proof.'}
    Path(__file__).with_suffix('.json').write_text(json.dumps(output,indent=2)+'\n')
    print(json.dumps({'status':output['status'],'summary':summary},indent=2))
