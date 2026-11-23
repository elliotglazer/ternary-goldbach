"""Fixed rational/symbolic paper checks only. No inventory or numerical values."""
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[4]
AGENTS = ROOT / 'work/qrh-campaign/agents'
PINS = {
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md': '4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 'audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md': '1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537',
 'audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md': '08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F',
 'prime-estimates/REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md': '3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3',
 'major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md': '1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A',
 'independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md': '15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2',
 'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md': '09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
}
checks = []
def check(label, value):
    assert value, label
    checks.append(label)
for rel, expected in PINS.items():
    data = (AGENTS / rel).read_bytes()
    check('pin:' + rel, sha256(data).hexdigest().upper() == expected)
blue = ROOT / 'work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md'
bluehash = 'EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39'
check('pin:lower allocation', sha256(blue.read_bytes()).hexdigest().upper() == bluehash)

# Exact formal bivariate polynomials in (s,a), not numerical instances.
def add(*polys):
    out = {}
    for p in polys:
        for k, v in p.items(): out[k] = out.get(k, 0) + v
    return {k:v for k,v in out.items() if v}
def neg(p): return {k:-v for k,v in p.items()}
def mul(p,q):
    out = {}
    for (i,j),v in p.items():
        for (k,l),w in q.items(): out[(i+k,j+l)] = out.get((i+k,j+l),0)+v*w
    return {k:v for k,v in out.items() if v}
one={(0,0):1}; s={(1,0):1}; a={(0,1):1}
gap=add(one,neg(s),neg(mul(add(one,a),add(one,neg(s),neg(a)))))
check('product induction denominator gap = a*s+a^2', gap == {(1,1):1,(0,2):1})
check('recurrence multiplicative identity', add(mul(add(one,s),add(one,a)),neg(add(one,s,a,mul(s,a)))) == {})
Q=2**72; B=F(Q,Q-1); Sg=202305920; V=2**14
check('global sum below 2^28', 0 < Sg < 2**28)
check('uniform s below 1/Q', F(Sg,2**100) < F(1,Q))
check('B reciprocal identity', B == 1/(1-F(1,Q)))
check('factor between 1 and 2', 1 < B < 2)
check('fixed s reciprocal strictly below B', 1/(1-F(Sg,2**100)) < B)
check('old global local safety at 100', 29961461170177 <= 2**100)
check('old global peak guard at 100', 2*424706204 <= 2**100)
check('mixed sum below baseline cap', Sg <= 424706204)
check('guard height below source cap', F(26525,4) < 7000)
check('B squared integer clearing', B**2*(Q-1)**2 == Q**2)
check('old passing test implies new', Q**2 < 4*(Q-1)**2)
check('zero sum intrinsic and selector', B*0 == 0 and (Q*0)**2 == 0)
check('one bit drop not universally implied', (2*B)**2 > 4)
Cg=1266*Sg*V
check('global intrinsic constant', Cg == 4196258524692480)
T=F(927193523,10**9)*F(1,2**46)
Rf=T+135*(F(1,2**82)+4*F(1,2**63))+10*F(1,2**54)+93*F(1,2**55)+F(1,2**51)
R108=Rf+135*F(Cg,2**108)
ratio=R108*2**45
check('complete radius exact', ratio == F(2804840254168152529,4294967296000000000))
check('complete directed rational bound', ratio < F(653052762,10**9))
check('older complete ceiling retained', F(653052762,10**9) < F(691,1024))
check('intrinsic ceiling below one', F(Cg,2**108) < 1)
record={'scope':'Fixed rational and formal-polynomial checks; no inventory or precision assignments.',
 'checks':len(checks),'assertions':checks,'source_pins':PINS,
 'blueprint_pin':bluehash,'Q':Q,'B':[B.numerator,B.denominator],
 'global_S':Sg,'global_C':Cg,'R_fixed':[Rf.numerator,Rf.denominator],
 'R108_ratio':[ratio.numerator,ratio.denominator],
 'selector':'(Q*phi*S)^2*2^(2*(108-p)) <= c*((Q-1)*1266*Sg)^2',
 'guards':['100<=p<=108','2^p>=D_local_old','2^p>=2*S_base'],
 'precision_counts_computed':False}
out=Path(__file__).with_suffix('.json')
encoded=(json.dumps(record,indent=2,sort_keys=True)+'\n').encode()
with out.open('xb') as f: f.write(encoded)
print(json.dumps({'checks':len(checks),'receipt':str(out),'bytes':len(encoded),'sha256':sha256(encoded).hexdigest().upper()}))
