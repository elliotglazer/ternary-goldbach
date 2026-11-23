"""Exact scalar checks for PRIME_ENVELOPE_ASSEMBLY; does not prove its envelope."""
from fractions import Fraction as F
import json
checks = {
    'log_lower20': F('2.72')**20 < 10**9,
    'log_upper21': F('2.7')**21 > 10**9,
    'floor_allowance': F('.001')*10**9/21 > 1,
    'coarse_envelope': F('.011')/20 < F('.002'),
    'finite_upper': 1+F('1.5262')/1000 < F('1.002'),
    'P1': F('1.002') < F('1.03883'),
    'P4': F('1.002') < F('1.0064'),
    'P5': 1+3*F('.002')+F('.998')/625 < F('1.022'),
    'P7_sqrt': (F('1.6')*F('14.51')+4)/1400 < F('.02'),
    'P7_total': F('.01705')+F('.02') < F('.15'),
}
assert all(checks.values()), checks
print(json.dumps({'status':'exact scalar implication only; E remains unproved',
                  'checks':checks,
                  'P5_coefficient':str(1+3*F('.002')+F('.998')/625)},indent=2))
