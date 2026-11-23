"""Exact production geometry and Gabcke scalar consequences; no zero computation."""
from fractions import Fraction as Q
import json

A, T, low, total = 1500, 1000000, 1069, 1747146
additional = total-low
samples = additional+1
blocks = 4*(T-A)

def sum_ceil(n, d):
    q,r=divmod(n,d)
    return d*q*(q+1)//2+r*(q+1)

# Block j has upper height 1500+(j+1)/4, EM N_j=ceil(upper/3).
em_terms=sum_ceil(4*T,12)-sum_ceil(4*A,12)
assert blocks==3994000 and additional==1746077 and samples==1746078
# 3.14159 < pi suffices for floor(sqrt(T/(2pi)))<=398.
assert 2*Q(314159,100000)*399**2 > T
assert 2*Q(22,7)*398**2 < T

# Gabcke3.2.2(a), error c*t^{-(2K+3)/4}. Each check is a rational
# fourth-power comparison; this script does not prove the analytic theorem.
checks=[]
for t,K,c,b in [(A,0,Q(47,100),Q(2,1000)),
                (A,1,Q(43,100),Q(47,10**6)),
                (A,4,Q(212,100),Q(4,10**9)),
                (A,10,Q(25966),Q(15,10**15)),
                (T,0,Q(47,100),Q(15,10**6)),
                (T,1,Q(43,100),Q(14,10**9)),
                (T,4,Q(212,100),Q(7,10**17))]:
    assert (c/b)**4 < t**(2*K+3)
    checks.append(dict(t=t,K=K,error_upper=str(b)))
phase=Q(80,3322*A**7)
assert phase<Q(15,10**25)
print(json.dumps(dict(status='PASS_EXACT_GEOMETRY_AND_CONDITIONAL_SCALARS',
    additional_sign_changes=additional,compressed_samples_including_A=samples,
    maximum_main_terms_per_sample=398,compressed_main_term_upper=398*samples,
    quarter_blocks=blocks,EM_finite_sum_terms=em_terms,
    EM_degree23_coefficient_updates=24*em_terms,
    stored_complex_coefficients=24*blocks,stored_rational_endpoints=96*blocks,
    sign_grid_denominator=8,fixed_grid_samples=8*(T-A)+1,
    grid_uint32_bytes=4*samples,one_byte_mode_bytes=samples,
    direct_RS64_point_calls=64*blocks,
    phase_main_sum_error_upper=str(phase),Gabcke_error_checks=checks),indent=2))
