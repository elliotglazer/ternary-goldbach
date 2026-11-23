"""Exact rational/source metadata only; no analytic function evaluation."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
SRC = ROOT / 'work/ternary-goldbach/TernaryGoldbach'
NAMES = '''Explicit/ZetaZeroSums Explicit/ZeroSumGen Explicit/WeilWindow
Explicit/PsiRanges1e8 Explicit/PsiPlateau1e8 Explicit/PsiLarge
Explicit/PsiRange1 Explicit/PsiAsymp Explicit/ZeroFreeRegion Explicit/IEANTNBridge
Prelim/PsiTwoSided Prelim/ThetaExplicit Prelim/LambdaMu Prelim/MertensProduct
Prelim/MertensLimit Prelim/EOneBound Prelim/EOneRanges
MajorArcs/Prop942 MajorArcs/Thm714 MajorArcs/Cor713 MajorArcs/Prop715
MinorArcs/EBound MinorArcs/TypeI2Large MinorArcs/TypeI2Proof
MinorArcs/TypeIIReduction MinorArcs/BaseGap2 MinorArcs/FirstChoiceTypeII
MinorArcs/GBound MinorArcs/LSQuot3 MinorArcs/SecondBridge
MinorArcs/SecondTypeIIa MinorArcs/SecondTypeIIb'''.split()
pins = {}
for name in NAMES:
    p = SRC / (name + '.lean')
    pins[p.relative_to(ROOT).as_posix()] = hashlib.sha256(p.read_bytes()).hexdigest().upper()
checks = {}
def ck(name, value):
    assert value, name
    checks[name] = True
def enc(q):
    q = Q(q)
    return {'numerator': str(q.numerator), 'denominator': str(q.denominator)}

ck('c3_dynamic', Q(44) / Q('1.2039') < Q('36.6'))
H = Q(2_000_000)
u = 1/H
A = Q('421.2') + Q('73.2')/Q('8.8')
B = Q('73.2')
coef = [64*A/Q('4.4'), 64*(A+B/Q('4.4')), 64*B]
ck('positive_polynomial_coefficients', all(c > 0 for c in coef))
F = 64*(Q('421.2')/H**2 + Q('73.2')/H*(1/(Q('8.8')*H)+1/H**2))*(1/H**2+1/(Q('4.4')*H))
ck('polynomial_identity', F == sum(c*u**(i+3) for i,c in enumerate(coef)))
ck('offC_at_two_million', F < Q(1,10**15))
ck('old_window_support_threshold', 2*(49_000_000+13) == 98_000_026)
threshold491 = 49/Q('0.000000491')
threshold492 = 49/Q('0.000000492')
ck('threshold491_integer_bracket', 99_796_334 < threshold491 < 99_796_335)
ck('threshold492_integer_bracket', 99_593_495 < threshold492 < 99_593_496)
ck('old_K_delta', Q(7)*Q(7,100_000_000) == Q('0.00000049'))
ck('plateau_surplus', Q('0.000000491')-Q('0.00000049') == Q(1,10**9))
result = {'scope':'exact rational inequalities and source hashes only',
          'checks':checks, 'offC_polynomial_coefficients_u3_u4_u5':[enc(c) for c in coef],
          'offC_at_two_million':enc(F), 'offC_margin':enc(Q(1,10**15)-F),
          'threshold491':enc(threshold491), 'threshold492':enc(threshold492),
          'pins':pins}
out = Path(__file__).with_suffix('.json')
with out.open('x', encoding='utf-8') as f:
    json.dump(result,f,indent=2)
    f.write('\n')
print(json.dumps({'checks':len(checks),'pins':len(pins),'output':str(out)}))
