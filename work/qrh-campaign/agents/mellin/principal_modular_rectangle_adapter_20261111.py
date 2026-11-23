"""Exact adapter for one accepted xi disk. No analytic evaluations or node replay."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    'prime-estimates/PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md': '85EDD45B5DEB8E96AEC957AA956E90AEBEC4B9B0C9BE31C7D06FA52DAE6E2D49',
    'prime-estimates/principal_modular_xi_panel_pilot_20261111.py': '626A931E23A0B3585C0803D34D920BE759E792B230638BDD0E48155874203416',
    'prime-estimates/principal_modular_xi_panel_pilot_20261111.json': '0B01EC0CA4A0102816CFB22DE51AE5751975288AC1544F5ABBABCA84BF4A8608',
    'independent-feasibility/REVIEW_PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md': '0A9D6BB382FC0C12D228C9DE892EE9EE3E956ECA72BA3E7851FCF90AC2DCE836',
    'major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md': '21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B',
    'independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md': 'F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0',
}
for name, expected in PINS.items():
    assert hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==expected, name
data=json.loads((AGENTS/'prime-estimates/principal_modular_xi_panel_pilot_20261111.json').read_text())
pars=data['parameters']
assert F(pars['sigma'])==F(3,5) and F(pars['t'])==14
assert F(pars['eta'])==F(1,33) and F(pars['rho'])==F(1,64)
assert data['degree']==12
coefs=data['coefficients']
assert [p['j'] for p in coefs]==list(range(13))
c0=tuple(F(int(n),int(coefs[0]['center_denominator'])) for n in coefs[0]['center_numerators'])
assert len(c0)==2
rho=F(1,64)
disk=data['disk']
remainder=F(data['constants']['D'])*rho**13/(1-rho)
assert remainder==F(disk['remainder'])
e_poly=sum((F(p['total_error'])*rho**p['j'] for p in coefs),F(0))+remainder
assert e_poly==F(disk['coefficient_error_plus_remainder'])
variation=F(disk['polynomial_variation_upper'])
radius=variation+e_poly
assert radius==F(disk['total_radius_about_constant']) and radius>=0
margin=c0[0]-radius
assert c0[0]>F(159,10) and radius<F(9,5) and margin>F(141,10)

s0=(F(3,5),F(14))
half=F(1,128)
vertices=[(s0[0]-half,s0[1]-half),(s0[0]+half,s0[1]-half),
          (s0[0]+half,s0[1]+half),(s0[0]-half,s0[1]+half)]
vertices.append(vertices[0])
assert vertices[0][0]<vertices[1][0] and vertices[0][1]<vertices[3][1]
norm_sq_max=2*half**2
assert norm_sq_max==F(1,8192)<rho**2
# Componentwise bounds prove containment of every rectangle point, not just vertices.
for v in vertices:
    assert sum((v[i]-s0[i])**2 for i in [0,1])<=norm_sq_max
side_deltas=[tuple(vertices[j+1][i]-vertices[j][i] for i in [0,1]) for j in range(4)]
assert side_deltas==[(F(1,64),F(0)),(F(0),F(1,64)),(F(-1,64),F(0)),(F(0),F(-1,64))]
area_twice=sum(vertices[j][0]*vertices[j+1][1]-vertices[j][1]*vertices[j+1][0] for j in range(4))
assert area_twice==F(1,2048)>0
def cross(a,b):
    det=a[0]*b[1]-a[1]*b[0]
    if a[1]<=0<b[1] and det>0: return 1
    if b[1]<=0<a[1] and det<0: return -1
    return 0
image=[c0]*5
crossings=[cross(image[j],image[j+1]) for j in range(4)]
assert crossings==[0,0,0,0] and all(v[0]>0 for v in image)
# Existing argument-principle carrier, centered at the bottom-left corner.
dx=dy=F(1,64)
arg_R=2*(dx+dy+1)
assert arg_R==F(33,16) and dx+dy<arg_R/2
assert 0<vertices[0][0]<vertices[1][0]<1

def pair(v): return [str(x) for x in v]
out={
 'status':'PASS: exact rational adapter to accepted external disk',
 'pins':PINS,
 'function':'F_b(s)=exp(-i*b*(s-1/2))*TernaryGoldbach.Explicit.xiF(s)',
 'fixed_b':'pi/4-1/33',
 'accepted_disk':{'center':pair(s0),'radius':str(rho)},
 'rectangle':{'closed':True,'vertices_ccw':list(map(pair,vertices)),
              'side_deltas':list(map(pair,side_deltas)),
              'norm_sq_from_disk_center_upper':str(norm_sq_max),
              'disk_radius_sq':str(rho**2),'signed_twice_area':str(area_twice)},
 'rational_image_center':pair(c0),
 'accepted_radius_about_image_center':str(radius),
 'error_plus_remainder_rechecked':str(e_poly),
 'real_part_lower_bound':str(margin),
 'strict_real_part_comparison':'lower_bound > 141/10 > 0',
 'panels':[{'from':pair(vertices[j]),'to':pair(vertices[j+1]),'rotation':['1','0'],
            'image_from':pair(image[j]),'image_to':pair(image[j+1]),'crossing':crossings[j]} for j in range(4)],
 'crossing_sum':sum(crossings),
 'argument_principle':{'ball_center':pair(vertices[0]),'R':str(arg_R),
                       'rectangle_distance_L1_upper':str(dx+dy),'R_over_2':str(arg_R/2)},
 'scope':'Reuses accepted whole-disk analytic enclosure. No new function, theta, Gaussian, transcendental, node, FFT or spectral evaluations. No Lean proof. Constant image polygon is a half-plane surrogate, not the actual image.'
}
dest=HERE/'principal_modular_rectangle_adapter_20261111.json'
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'status':out['status'],'pins':len(PINS),'panels':4,'crossing_sum':0,
                  'norm_sq_upper':str(norm_sq_max),'real_part_lower_bound_gt':'141/10',
                  'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
