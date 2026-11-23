"""Scalar arithmetic only: does not prove the candidate pointwise envelope."""
from fractions import Fraction as F
import json

C = 12000
L = 350
polynomial = 7*L**3+64*L**2+96*L+384
addition = F('1.398')*C*polynomial/F(2**125)
assert addition < F(1, 10**24)
assert F('1.037')+addition+F(1, 10**60) < F('1.037001')
final = F('1.0005')*F('1.037001')+2001*F('22.75')*F('8e-11')
assert final == F('1.03752314232') < F('1.0376')
print(json.dumps(dict(status='Exact scalar budget only; pointwise and transport inputs unproved',
                      polynomial=polynomial, upper=str(addition),
                      diagnostic=float(addition), final=str(final)), indent=2))
