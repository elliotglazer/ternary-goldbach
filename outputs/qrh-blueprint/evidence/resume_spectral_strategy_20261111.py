"""Exact checks for the separate base-gap height compatibility lemma.
This performs no L-function evaluation or zero verification.
"""
from fractions import Fraction as F
from pathlib import Path
import json
def ceil(f):return (f.numerator+f.denominator-1)//f.denominator
assert F(59600000,7*150000)>56
assert F(50000000,150000)>250
minimum=None
for q in range(1,150001):
    h=max(250,ceil(F(290400000,7*q)))
    common=F(50000000,q)
    assert h<common
    margin=common-h
    if minimum is None or margin<minimum[0]:minimum=(margin,q,h)
out=dict(status='Exact height inclusion only; no finite spectral assertion proved.',
    selected_profile_unchanged=True,
    conclusion='H(q,U)<50000000/q<=100000000/c for U<=1200000,c<=2q,q<=150000',
    raw_gap_lower='59600000/1050000 > 56',
    minimum_rounded_height_margin=str(minimum[0]),minimum_q=minimum[1],H=minimum[2],
    caveat='The major-moment original Hp leaf is not replaced by this separate base-gap lemma.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2))
print(json.dumps(out,indent=2))
