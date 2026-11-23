"""Independent rational/symbolic witnesses. No analytic values or author imports."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]
AGENTS = ROOT / 'qrh-campaign' / 'agents'
MATH = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib')
pins = {
    AGENTS/'independent-feasibility/FINITE_BLASCHKE_TURING_REFINEMENT_2026-11-11.md': 'D9B3A7F28CA6EE49F203ECF1092F61E1FFD0DE79B017F0499A205EF2AD4A45DC',
    AGENTS/'independent-feasibility/finite_blaschke_turing_scalars_20261111.py': '46188842B33F488DCEFFBED46A39D3C5AE11DDC25BFB7A63D966243FD30CACF3',
    AGENTS/'independent-feasibility/finite_blaschke_turing_scalars_20261111.json': '80CCFFC89B3C0131CFFECB13E21324B9DC3C2484CB0F4D78659B173498619A23',
    ROOT/'ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean': '5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341',
    MATH/'Analysis/Complex/Harmonic/Poisson.lean': '9F8B08BA2691E698428516F465B373D2212DAA8509D67EDEA9F4DCCF2473C195',
    AGENTS/'audit/TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md': 'A8D21679E5BF2C631D7399D73A70E85E3486EBC6A92CC1668C5060E77E2E11C9',
    AGENTS/'integration/REVIEW_TURING_HORIZONTAL_LOWER_PROOF_PLAN_2026-11-11.md': 'B4CAE7485D7BB6655D207BEB2E1716A904F637E36753C48EF5D15FD1A6B41992',
    ROOT/'qrh-blueprint/turing-scalars/ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md': '0875B2B87A02421B7B8CD6CAD0D1C33433A051E240F48EA4C5F45FE04558BD27',
    AGENTS/'integration/REVIEW_ELEMENTARY_HORIZONTAL_UPPER_2026-11-11.md': '696E6E8B9C73D3AE3593F2D5C1386E4B386048DA046915CD976C0A43425D7E94',
    AGENTS/'integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md': '262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2',
    AGENTS/'integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md': '72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C',
    AGENTS/'independent-feasibility/REVIEW_FINITE_RH_PAIR_DEFICIT_2026-11-11.md': '97645AB7A3A9EC3B807DD4BFDD022175455A0F1DEF46F676141E6C587164C7E5',
}
checks = {}
def check(name, condition):
    assert condition, name
    checks[name] = True

for path, sha in pins.items():
    check('pin:' + path.name, hashlib.sha256(path.read_bytes()).hexdigest().upper() == sha)

# Finite geometric expansion integrated on [0,z]. For y>1, z=(y-1)/(y+1).
# log y = 2 int_0^z (1-t^2)^-1 dt. The remaining integrand is
# 2 t^(2n)/(1-t^2), bounded above by 2 t^(2n)/(1-z^2).
def log_bracket(y, n):
    z = (y-1)/(y+1)
    assert 0 < z < 1 and n > 0
    lo = 2*sum((z**(2*k+1)/F(2*k+1) for k in range(n)), F(0))
    return lo, lo + 2*z**(2*n+1)/(F(2*n+1)*(1-z*z))

brackets = {}
for y,n in [(F(8,5),4),(F(16,5),12),(F(22,7),12)]:
    brackets[str(y)] = tuple(map(str, log_bracket(y,n)))
check('log8/5 lower via integrated geometric series', log_bracket(F(8,5),4)[0] > F(7,15))
check('log16/5 upper via integrated geometric series', log_bracket(F(16,5),12)[1] < F(7,6))
check('log22/7 upper via integrated geometric series', log_bracket(F(22,7),12)[1] < F(5,4))

c,R,r,l = F(5,4),F(6,5),F(11,10),F(3,4)
check('closed disk and segment domain', 0 < l < r < R < c and c-R == F(1,20) and c-l == F(1,2))
check('uniform strict outer maximum', F(3,2)/(c-R)*(1+(c+R)/50) == F(3147,100) < 32)
check('center zeta integral majorant', 1+1/(c-1) == 5)
check('center budget exponential witness', F(27,10)**7 > 320*F(22,7))
check('exp1 positive polynomial witness', sum((F(1, d) for d in (1,1,2,6,24,120)),F(0)) > F(27,10))
check('positive Z', 2*50 > 2*F(22,7))
check('harmonic integral coefficient', 2*r*F(5,4)-l == 2 < F(7,2))
check('inside radial coefficient', l*(1+F(7,6))/F(7,15) == F(195,56) < F(7,2))
check('outside radial coefficient', l*(1+1/F(7,15)) == F(33,14) < F(7,2))

# Exact polynomial identity, four indeterminates R,x,Re(alpha),Im(alpha).
def add(*ps):
    out={}
    for p in ps:
        for e,a in p.items(): out[e]=out.get(e,0)+a
    return {e:a for e,a in out.items() if a}
def neg(p): return {e:-a for e,a in p.items()}
def mul(p,q):
    out={}
    for e,a in p.items():
        for f,b in q.items():
            k=tuple(x+y for x,y in zip(e,f)); out[k]=out.get(k,0)+a*b
    return {e:a for e,a in out.items() if a}
def sq(p): return mul(p,p)
rv,xv,av,bv=[{tuple(int(i==j) for i in range(4)):1} for j in range(4)]
dennorm=add(sq(add(sq(rv),mul(xv,av))),sq(mul(xv,bv)))
numnorm=mul(sq(rv),add(sq(add(xv,av)),sq(bv)))
rhs=mul(add(sq(rv),neg(sq(xv))),add(sq(rv),neg(sq(av)),neg(sq(bv))))
check('full Green polynomial identity', not add(dennorm,neg(numnorm),neg(rhs)))
# Clearing the positive denominator in d/dy[y/(1-y)^2] gives 1+y.
one={(0,0,0,0):1}
check('convexity auxiliary derivative numerator',
      add(add(one,neg(av)),{e:2*a for e,a in av.items()}) == add(one,av))

check('lower slope', F(7,2)-l == F(11,4))
check('lower intercept', F(7,2)*7+F(148,125) == F(6421,250) < 26)
check('difference intercept rounding', 26+F(1717,500) == F(14717,500))
check('difference slope', F(11,4)+F(3,4) == F(7,2))
check('final pi intercept slack', 10*F(157,50)-F(14717,500) == F(983,500) > 0)
check('final pi slope slack', F(9,8)*F(157,50)-F(7,2) == F(13,400) > 0)
b=10+F(9,8)*18
check('b at Z18', b == F(121,4))
check('h50 RH conditional reserve', 2-F(1,2)-2*b/50 == F(29,100))
check('h50 exact count not certified by Dhalf', 1-F(1,2)-2*b/50 == -F(71,100))
check('RH h threshold for Dhalf', 2*b/(2-F(1,2)) == F(121,3))
check('same D old h threshold', 2*(42+F(693,100)*18)/(2-F(1,2)) == F(5558,25))
check('h50 added sample count', F(64,5)*50 == 640)
check('h200 added sample count', F(64,5)*200 == 2560)

result={'status':'PASS_EXACT_REVIEW_SCALARS', 'checks':checks,
        'number_of_checks':len(checks), 'log_rational_brackets':brackets,
        'source_pins':{str(p):s for p,s in pins.items()},
        'scope':'Finite rational and full polynomial identities only; continuum proof in review note.'}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as out:
    out.write(json.dumps(result,indent=2)+'\n')
print(json.dumps({'status':result['status'],'checks':len(checks)}))
