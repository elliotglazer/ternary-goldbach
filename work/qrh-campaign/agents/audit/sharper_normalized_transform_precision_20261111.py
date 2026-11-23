"""Fixed rational identities and source hashes only. No inventory or value inputs."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
AGENTS = 'work/qrh-campaign/agents/'
checks = 0

def check(value):
    global checks
    assert value
    checks += 1

pins = {
    AGENTS+'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md': '4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
    AGENTS+'zero-sum/mixed_radix_precision_metadata_20261111.py': '3750A9C8FD77163C878694959158762D183F1425E4F85F983230A841BAEBDC42',
    AGENTS+'independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md': '5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A',
    AGENTS+'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md': 'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
    AGENTS+'independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md': '412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7',
    AGENTS+'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md': '09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
    AGENTS+'major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md': '1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A',
    AGENTS+'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md': '15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2',
    'work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md': 'EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39',
}
for name, expected in pins.items():
    check(hashlib.sha256((ROOT/name).read_bytes()).hexdigest().upper() == expected)

# Formal polynomial arithmetic. Variables are n, P, R, a, b, x, y.
ZERO = (0,)*7
def constant(c): return {ZERO:F(c)} if c else {}
def variable(i):
    v=list(ZERO);v[i]=1
    return {tuple(v):F(1)}
def plus(*args):
    out={}
    for p in args:
        for e,c in p.items(): out[e]=out.get(e,F(0))+c
    return {e:c for e,c in out.items() if c}
def times(p,q):
    out={}
    for e,c in p.items():
        for f,d in q.items():
            g=tuple(x+y for x,y in zip(e,f))
            out[g]=out.get(g,F(0))+c*d
    return {e:c for e,c in out.items() if c}
def scale(c,p): return times(constant(c),p)
n,P,R,a,b,x,y = [variable(i) for i in range(7)]
A=plus(constant(1),scale(3,R))
q=plus(scale(3,times(n,A)),n,constant(2))
C=plus(scale(F(9,2),times(P,A)),scale(F(3,2),P),scale(3,times(R,n)),scale(12,R),constant(14))
Cold=plus(scale(6,times(P,A)),scale(2,times(R,plus(scale(2,n),constant(1)))),constant(8))
twonCexact=plus(scale(3,plus(times(P,q),times(R,plus(times(n,plus(scale(2,n),constant(-1))),scale(2,P))))),scale(2,plus(n,constant(1))))
gap=plus(times(R,plus(scale(27,n),scale(-6,P))),scale(26,n),scale(-6,P),constant(-2))
check(plus(scale(2,times(n,C)),scale(-1,twonCexact)) == gap)
check(plus(Cold,scale(-1,C)) == plus(times(R,plus(scale(F(9,2),P),n,constant(-10))),constant(-6)))
Q=plus(scale(3,times(times(n,P),A)),constant(1))
check(plus(Q,scale(-1,times(P,plus(A,constant(1))))) == plus(times(plus(scale(3,n),constant(-1)),times(P,A)),scale(-1,P),constant(1)))
check(plus(Q,scale(-1,q)) == plus(scale(3,times(times(n,A),plus(P,constant(-1)))),scale(-1,n),constant(-1)))
# F(a+x,b+y)-F(a,b), proving monotonicity of the ordered CT guard.
def guard(c,d): return plus(c,times(d,plus(scale(2,c),constant(1))))
check(plus(guard(plus(a,x),plus(b,y)),scale(-1,guard(a,b))) == plus(times(x,plus(constant(1),scale(2,b))),times(y,plus(scale(2,a),constant(1))),scale(2,times(x,y))))

u=lambda p:F(1,2**p)
global_s=202305920
global_c=1266*global_s*2**14
fixed=F(927193523,10**9)*u(46)+135*(u(82)+4*u(63))+10*u(54)+93*u(55)+u(51)
ratio=(fixed+135*global_c*u(108))/u(45)
check(ratio == F(2804840254168152529,4294967296000000000))
check(ratio < F(653052762,10**9) < F(691,1024))
check(29961461170177 < 2**100)
check(2*424706204 < 2**100)
check(global_c == 4196258524692480)
check(global_c*u(108)+u(82)+2*u(63)<1)
check(2**100>3)
check(256*790257<global_s<256*790258)
check(4*265800 < 1266**2)

result=dict(status='PASS_FIXED_SCALAR_IDENTITIES',checks=checks,pins=pins,
    formal_identities=5,complete_radius_ratio=str(ratio),
    scope='No inventory, plan, conductor, root, function or transform evaluation; generic proof is in the paper.')
raw=(json.dumps(result,indent=2)+'\n').encode()
with (HERE/'sharper_normalized_transform_precision_20261111.json').open('xb') as out:
    out.write(raw)
print(json.dumps(dict(checks=checks,receipt_sha256=hashlib.sha256(raw).hexdigest().upper(),bytes=len(raw))))
