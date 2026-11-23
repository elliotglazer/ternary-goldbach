"""Exact rational metadata, not zeta/prime/zero evaluation or a timing model."""
from fractions import Fraction as F
from math import isqrt
from pathlib import Path
import json

def atan_bounds(q, n=80):
    x = F(1, q)
    s = sum(((-1)**k * x**(2*k+1) / (2*k+1) for k in range(n)), F(0))
    e = x**(2*n+1)/(2*n+1)
    return (s, s+e) if n % 2 == 0 else (s-e, s)

a,b = atan_bounds(5)
c,d = atan_bounds(239)
pi_lo,pi_hi = 16*a-4*d,16*b-4*c
assert F(314159,100000)<pi_lo<pi_hi<F(314160,100000)
machin_width_check = pi_hi-pi_lo<F(1,2**350)
pi_lo=F((pi_lo*2**70).__floor__(),2**70)
pi_hi=F((pi_hi*2**70).__ceil__(),2**70)

def log_unit(x, n=40):
    assert 1<=x<=2
    z=(x-1)/(x+1)
    s=2*sum((z**(2*k+1)/(2*k+1) for k in range(n)),F(0))
    e=2*z**(2*n+1)/((2*n+1)*(1-z*z))
    return s,s+e

log2=log_unit(F(2))
def log_bounds(x):
    assert x>=1
    k=0
    while x>=2:
        x/=2
        k+=1
    a,b=log_unit(x)
    return a+k*log2[0],b+k*log2[1]

def main_count(H):
    # This is ONLY F(H), not N(H) or a zero-count bound.
    x,y=F(H)/(2*pi_hi),F(H)/(2*pi_lo)
    a=log_bounds(x)[0]
    b=log_bounds(y)[1]
    return x*(a-1)+F(7,8),y*(b-1)+F(7,8)

def ceil(x): return -((-x.numerator)//x.denominator)
def root_floor(x): return isqrt(x.numerator//x.denominator)
def root_ceil(x):
    r=root_floor(x)
    return r if r*r==x else r+1

H0=10**8
base=main_count(H0)
rows=[]
for H in [10**11,10**12,3*10**12,9*10**12,10**13]:
    D=H-H0
    lo,hi=main_count(H)
    flo,fhi=lo-base[1],hi-base[0]
    rs_lo=root_floor(F(H,2)/(2*pi_hi))
    rs_hi=root_ceil(F(H)/(2*pi_lo))
    ngrid=8*D
    row=dict(H=H,added_height=D,
      added_main_term_million_enclosure=[(flo//10**6)*10**6,ceil(fhi/F(10**6))*10**6],
      point_grid_1_over8_intervals=ngrid,point_grid_1_over100_intervals=100*D,
      one_bit_grid_payload_bytes=ngrid//8,
      direct_EM_Nceil_t_plus40_head_terms=8*(D*(H0+40)+D*(D+1)//2),
      RS_main_terms_endpoint_upper=rs_hi,
      direct_RS_1_over8_main_terms_upper=ngrid*rs_hi,
      direct_RS_1_over8_main_terms_lower_last_half=4*H*rs_lo,
      endpoint_phase_log_guard_bits=H.bit_length())
    assert row['direct_RS_1_over8_main_terms_lower_last_half']<row['direct_RS_1_over8_main_terms_upper']
    rows.append(row)

# Literal algebra of a radix-two window circuit, not accepted parameter choices.
N=2**15; K=44
butterflies=(K+1)*(N//2)*15+3*K*N*16
assert butterflies==80265216
result=dict(status='PASS_EXACT_METADATA_ONLY',
 scope='No special functions, zeros, primes, FFTs, timing or feasible-parameter claims',
 rows=rows,
 literal_window=dict(N=N,K=K,radix_two_butterflies=butterflies,
  convolution_pointwise_products=2*K*N,gamma_base_nodes=N,
  dense_two_KN_tables_complex_slots=2*K*N),
 machin_pi_interval_width_lt_2_minus350=machin_width_check,
 rounded_pi_interval_width_le_2_minus69=(pi_hi-pi_lo<=F(1,2**69)))
assert result['machin_pi_interval_width_lt_2_minus350']
assert result['rounded_pi_interval_width_le_2_minus69']
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(result,indent=2))
