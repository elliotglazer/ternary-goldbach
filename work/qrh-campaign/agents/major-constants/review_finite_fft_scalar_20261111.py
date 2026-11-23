"""Independent exact scalar checks; no FFT, twiddle table, or L-value evaluation."""
from fractions import Fraction as F
from math import prod
from pathlib import Path
import json

checks = {}
def lt(label, a, b):
    assert a < b, label
    checks[label] = {"left":str(a), "right":str(b), "relation":"<"}

# Enclose the author's 50-term alternating centers by just two/three terms.
def lower2(x): return x-x**3/3
def upper3(x): return lower2(x)+x**5/5
pi_center_lo = 16*lower2(F(1,5))-4*upper3(F(1,239))
pi_center_hi = 16*upper3(F(1,5))-4*lower2(F(1,239))
lt('Machin_center_lower_via_short_enclosure', F(3), pi_center_lo)
lt('Machin_center_upper_via_short_enclosure', pi_center_hi, F(22,7))
tan_four = F(120,119)
assert (tan_four-F(1,239))/(1+tan_four*F(1,239)) == 1
ep = F(16,101*5**101)+F(4,101*239**101)
lt('Machin_remainder',ep,F(1,10**60))
cap = F(22,7)
first_omitted = prod(cap/F(j) for j in range(1,66))
tail = first_omitted/(1-cap/66)
delta=F(1,10**52)
lt('Taylor_tail_ratio',cap/66,F(1))
lt('Complex_floor_rounding',F(1,2**179),delta)
lt('Twiddle_total',ep+tail+F(1,2**179),delta)
lt('Final_scale',16*ep+F(1,2**180),delta)
lt('Multiplier_51',16*cap,F(51))
lt('Fixed_Hcert_power_cap',F(8*257*50_000_000),F(2**37))

B=100000001
x=delta/2
# Compute the actual rational power as an independent check of the coarse bound.
lt('Stage_amplification', (1+x)**36, F(2))
stage_sum = sum((delta*B/2+delta)*(1+x)**j for j in range(36))
stage_cap = 36*(B+2)*delta
lt('Exact_recurrence_vs_coarse',stage_sum,stage_cap)
lt('Stage_cap_below_one',stage_cap,F(1))
final_cap=51*stage_cap+(B+1)*delta+delta
lt('Final_arithmetic',final_cap,F(1,10**40))
lt('Input_centers_bounded',F(1,10**119)+F(1,10**50),F(1))
lt('Series_aggregate',F(51,10**119),F(1,10**117))
ledger=F(1,10**30)+F(1,10**75)+51*(F(1,10**119)+F(1,10**50))+F(1,10**40)
lt('Complete_fixed_example_ledger',ledger,F(2,10**30))

out={"status":"PASS: independent exact scalar review only", "checks":checks,
     "no_fft_executed":True,"no_twiddle_table_generated":True,
     "scope":"c>1, T=Hcert(c)>=1, cT<=1e8; d<=36 example only"}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(f'PASS: {len(checks)} inequalities and exact Machin tangent identity; no FFT.')
