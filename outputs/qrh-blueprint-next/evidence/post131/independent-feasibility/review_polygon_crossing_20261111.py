"""Exact finite edge regressions and source pins; not the analytic paper proof."""
from fractions import Fraction as F
from pathlib import Path
from itertools import product
import hashlib,json

HERE=Path(__file__).resolve().parent
WORK=HERE.parent.parent.parent
SRC=WORK/'ternary-goldbach'/'TernaryGoldbach'/'Explicit'
ML=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib')
note=HERE.parent/'major-constants'/'POLYGON_CROSSING_PROOF_2026-11-11.md'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(note)=='21acea6753546cb2d22e8be2949fa02a3d6a030b21960c6a024731514f09e08b'

def det(a,b):return a[0]*b[1]-a[1]*b[0]
def crossing(a,b):
    if a[1]<=0<b[1] and det(a,b)>0:return 1
    if b[1]<=0<a[1] and det(a,b)<0:return -1
    return 0
def avoids_zero(a,b):
    return a!=(0,0) and b!=(0,0) and not(det(a,b)==0 and a[0]*b[0]+a[1]*b[1]<=0)
def positive_ray_hit(a,b):
    dy=b[1]-a[1]
    if dy==0:return a[1]==0 and max(a[0],b[0])>0
    t=F(-a[1],dy)
    return 0<=t<=1 and a[0]+t*(b[0]-a[0])>0
def eps(a):return 1 if a[1]<=0 else -1
def rotate(a):return (-a[1],a[0])

points=[p for p in product(range(-3,4),repeat=2) if p!=(0,0)]
edges=hits=degenerate=horizontal=ray_endpoint=0
for a,b in product(points,repeat=2):
    if not avoids_zero(a,b):continue
    edges+=1
    hit=positive_ray_hit(a,b); hits+=hit
    degenerate+=a==b; horizontal+=a[1]==b[1]
    ray_endpoint+=(a[1]==0 and a[0]>0) or (b[1]==0 and b[0]>0)
    c=crossing(a,b)
    assert crossing(b,a)==-c
    if hit:assert eps(a)-eps(b)==2*c
    else:assert c==0
    for t in (F(0),F(1,4),F(1,2),F(3,4),F(1)):
        m=(a[0]+t*(b[0]-a[0]),a[1]+t*(b[1]-a[1]))
        assert avoids_zero(a,m) and avoids_zero(m,b)
        assert crossing(a,m)+crossing(m,b)==c
triangles=0
for a,b,c in product(points,repeat=3):
    if not(avoids_zero(a,b) and avoids_zero(b,c) and avoids_zero(c,a)):continue
    wind=crossing(a,b)+crossing(b,c)+crossing(c,a)
    ar,br,cr=map(rotate,(a,b,c))
    assert wind==crossing(ar,br)+crossing(br,cr)+crossing(cr,ar)
    triangles+=1
square=[(1,-1),(1,1),(-1,1),(-1,-1),(1,-1)]
assert sum(crossing(a,b) for a,b in zip(square,square[1:]))==1

files=[note,SRC/'RectResidue.lean',SRC/'Landau.lean',
       ML/'Analysis/SpecialFunctions/Complex/Arg.lean',
       ML/'Analysis/SpecialFunctions/Complex/LogDeriv.lean',
       ML/'MeasureTheory/Integral/IntervalIntegral/Basic.lean',
       ML/'MeasureTheory/Integral/IntervalIntegral/FundThmCalculus.lean']
out={'status':'PASS: exact finite regressions only; universal analytic proof reviewed separately',
     'edges':edges,'edges_meeting_positive_ray':hits,'zero_length_edges':degenerate,
     'horizontal_edges':horizontal,'edges_with_positive_ray_endpoint':ray_endpoint,
     'subdivision_tests':5*edges,'admissible_triangles_quarter_turn_checked':triangles,
     'source_sha256':{str(p):sha(p) for p in files}}
HERE.joinpath('review_polygon_crossing_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
