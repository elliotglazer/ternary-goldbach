"""Exact metadata and rational inequalities only; no analytic or prime evaluation."""
from fractions import Fraction as F
from math import factorial, isqrt
import json
from pathlib import Path

def enc(x):
    x = F(x)
    scale = 10**15
    return {"numerator": str(x.numerator), "denominator": str(x.denominator),
            "upper_decimal_15": str((x.numerator*scale+x.denominator-1)//x.denominator)}

# Positive Taylor lower sum: exp(2303/1000)>10, hence log(10)<2303/1000.
log10up = F(2303, 1000)
exp_lower = sum((log10up**k/F(factorial(k)) for k in range(25)), F(0))
assert exp_lower > 10
pi_lo, pi_hi = F(314159,100000), F(314160,100000)
B = 4*10**18
old_step = 111616*2**45
records=[]
for e,m in [(27,45),(28,47),(29,49)]:
    N = 10**e
    sqrtNlo = isqrt(N)
    assert sqrtNlo**2 <= N < (sqrtNlo+1)**2
    np = 49*F(202,100)**2*6700000*(e*log10up)/sqrtNlo
    plus_low = F(7700000,isqrt(49*N//100))
    star_low = F(4700000,isqrt(N//100))
    S = 111616 if e==27 else (B-4)//2**m-2047
    step = S*2**m
    rungs = (N-5)//step
    assert S > 2047
    assert (S+2047)*2**m <= B-4
    assert S*rungs < 2**m
    assert N < 2**(2*m)
    if e>27:
        assert 2**(2*(m-1)) < N
        assert 111616*((N-5)//old_step) >= 2**45
    assert F(1049,1000)-F(10376,10000)-np > 0
    records.append({"threshold":str(N),"nonprime_normalized_upper":enc(np),
        "major_sufficient_if_minor_unchanged":enc(F(10376,10000)+np),
        "plus_sqrtq_error_upper":enc(F(75,10**9)+plus_low),
        "star_sqrtq_main_error_upper":enc(star_low),
        "proth_exponent":m,"step_coefficient":S,"step":str(step),
        "window_span":str(2047*2**m),"rungs_through_threshold":rungs,
        "rung_count_ratio_to_original":enc(F(rungs,254638308)),
        "unchanged_old_grid_rungs":(N-5)//old_step,
        "interval_cover_necessary_rungs":(N-B-4+(B-2)-1)//(B-2)})

# A genuinely active even conductor endpoint, independent of N and x.
c=300000
H=F(200)+F(75000000,c)
assert H==450
floor_lo=200+40*pi_lo
floor_hi=200+40*pi_hi
assert H/2 < floor_lo and H/10 < floor_lo and H/100 < floor_lo
assert floor_lo/H > F(723,1000)
# Uniform tenfold reduction also fails the principal and all odd endpoint cases.
assert 10000000 < 6000000*pi_lo
# Half-height even middle range fails already at conductor100000, which has primitive rows.
assert F(100000000,100000)/2 < 200+F(12000000,100000)*pi_lo

out={"scope":"exact rational/integer metadata; no candidate primes or L-values evaluated",
     "records":records,"log10_upper_proof_taylor_degree":24,
     "even_endpoint_height":enc(H),"even_endpoint_admissible_floor_lower":enc(floor_lo),
     "even_endpoint_admissible_floor_upper":enc(floor_hi),
     "uniform_height_factor_necessary_lower":enc(floor_lo/H),
     "fixed_m45_proth_ceiling":str(2**90)}
path=Path(__file__).with_suffix('.json')
path.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
