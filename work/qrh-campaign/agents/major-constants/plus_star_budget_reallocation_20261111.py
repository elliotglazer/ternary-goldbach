"""Exact rational checks only; no function, prime, zero or transform evaluation."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
checks = {}
def check(name, test):
    assert test, name
    checks[name] = True
def rat(x):
    return str(x)

rho = F('5.12e-7')
ep = F('1.80625e-13')
p0 = F('2.83e-7')
rem = 516 * F('1e-15')
check('positive_radius_after_removal', rho > rem)
check('full_plus_radius', ep + p0*p0 < (rho-rem)**2)
check('totient_sqrt', 265800 < 516**2)
j = F('8.79')
a = F('.640208')*F('13.59756')
v = F('7.78')*F('2.85')
C = 49*(j+a)/9 + 9*v/2
old = F(64019155993729,312500000000000000)
check('old_exact_constant', old == j*F('3.67e-6')+F('8.85e-7')*C)
check('amgm_identity', C*C-2*49*v*(j+a) == (49*(j+a)/9-9*v/2)**2)
umax = (old-rho*C)/j
u = F('1.194e-5')
check('selected_u', u < umax < u+F('1e-8'))
check('selected_reserve', old-j*u-rho*C > 0)
check('integrated_plus_residual', 16*150000*19*rho*rho < F('.006')**2)
check('main_norm', a < F('2.951')**2)
check('total_norm', F('2.957')**2 < j)
check('weighted_main_norm', F('.640208')*F(32,13) < F('1.256')**2)
pbar = F('1.902e-6')
check('principal_weighted_norm', F('1.502e-6')*F('1.262')+F('2e-9')*3 < pbar)
ell = F('2.964')
check('sqrt_j_lower', ell**2 < j)
rows = []
for rootA, B in [('0',4200),('1e-6',4000),('2e-6',3750),('3e-6',3500),('1e-5',2000),('2e-5',650)]:
    rootA = F(rootA)
    reserve = ell*u-pbar-rootA
    check('row_positive_'+str(B), reserve > 0)
    check('row_squared_'+str(B), reserve**2 > rho*rho*B)
    rows.append({'A':rat(rootA**2),'B':B,'squared_reserve':rat(reserve**2-rho*rho*B)})

# Conditional application to the explicitly stated etaU coefficient bounds.
check('log_y_lower', 3**50 < 10**25)
check('exp_one_lower', sum((F(1,1)/__import__('math').factorial(k) for k in range(6)), F(0)) > F(27,10))
check('log_2R_upper', F(27,10)**13 > 265800)
ct = 30*F('1.254')*(F('1.000468')+F('.502756')/50) + F(30,50)*2*F('1e-60')
check('sieve_coefficient', ct < 39)
check('sqrt_ct', 39 < F('6.25')**2)
check('sqrt_small', F('2.1e-9') < F('46e-6')**2)
broot = 7*(F('6.25')+F('46e-6'))+F('.0010632')
check('conditional_B', broot**2 < 1915 < 2000)
check('sieve_size1', (20000*132900)**2*16 < 49*10**25)
check('sieve_size2', (2*132900)**10 < (F(49*10**25,4))**3)

inputs = [
 'work/qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md',
 'work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md',
 'work/qrh-blueprint/PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md',
 'work/qrh-campaign/agents/major-constants/PLUS_FINITE_RH_HEIGHT_REDUCTION_2026-11-11.md',
 'work/qrh-campaign/agents/major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md',
 'work/qrh-campaign/agents/audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md',
 'work/qrh-campaign/agents/audit/DIRECT_STAR_B_SOURCE_OBSTRUCTION_2026-11-11.md',
 'work/qrh-campaign/agents/audit/ETA_U_PRIME_COEFFICIENT_ENERGY_2026-11-11.md',
 'work/ternary-goldbach/TernaryGoldbach/MajorArcs/MajorTotal.lean',
]
pins = {p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in inputs}
out = {'scope':'exact scalar implications only; coefficient input conditional',
       'checks':checks,'rho':rat(rho),'C':rat(C),'old_error':rat(old),
       'u_max_linear':rat(umax),'selected_u':rat(u),
       'cubic_reserve':rat(old-j*u-rho*C),'rows':rows,
       'conditional_sieve_product_upper':rat(ct),'conditional_B_upper':rat(broot**2),
       'input_sha256':pins}
(HERE/'plus_star_budget_reallocation_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(f'{len(checks)} exact checks passed')
