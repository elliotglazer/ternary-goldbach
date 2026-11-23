"""Exact rational arithmetic for the proposed full-S transfer budgets.
The analytic inequalities are documented in FULL_TRANSFER.md and await Lean validation.
"""
from fractions import Fraction as F
import json

a=F("1.01")
bp=F("3.03e-23")
bs=F("3.03e-17")
J=F("8.79")
M=F("0.640208")*F("13.59756")
width_count_bound=F("3.6e11")
weighted_width_count_bound=F("7.2e11")
star_pointwise=F("22.75")+F("1e-12")+F("1.2534")
estar_integral=F("4.15e14")
eplus_integral=F("53")
assert weighted_width_count_bound*star_pointwise**2 <= estar_integral
assert 3*(J+M+weighted_width_count_bound*F("1e-30")) <= eplus_integral
mixed=a*bp*estar_integral+a*bs*eplus_integral+bp*bs*width_count_bound
full_A=a*F("9.6e-7")+49*F("7.78")*F("2.85")*bp
full_AX=a*a*F("1.88e-6")+F("0.640208")*F("2.85")*bs+mixed
safe_A=F("9.73116250079e-7")
safe_AX=F("1.936851913302e-6")
assert full_A < safe_A
assert full_AX < safe_AX
print(json.dumps({
    "status":"All displayed rational comparisons passed; analytic premises remain separate.",
    "spectral_multiplier":str(a),
    "plus_floor":str(bp),"star_floor":str(bs),
    "mixed_floor_decimal":float(mixed),
    "full_A_decimal":float(full_A),
    "full_Astar_plus_cross_decimal":float(full_AX),
    "safe_A_decimal":float(safe_A),
    "safe_Astar_plus_cross_decimal":float(safe_AX),
    "remaining_A_margin":float(safe_A-full_A),
    "remaining_Astar_plus_cross_margin":float(safe_AX-full_AX),
    "exact_full_A":str(full_A),
    "exact_full_Astar_plus_cross":str(full_AX)
},indent=2))

