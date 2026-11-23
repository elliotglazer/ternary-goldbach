"""Exact scalar/coverage arithmetic only. No primes, L-values or evaluator imports."""
from fractions import Fraction as F
from math import factorial, isqrt
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]
SRC = ROOT / 'ternary-goldbach/TernaryGoldbach'

def enc(x):
    x = F(x)
    # The displayed integer is ceil(10^15*x), not a floating-point certificate.
    return {'numerator': str(x.numerator), 'denominator': str(x.denominator),
            'ceil_times_10pow15': str(-(-x.numerator*10**15//x.denominator))}

N0 = 989*10**24
X0 = 49*10**25
CUP = F(989,490)
assert F(5,2)**2 < 2*F(314,100)  # pi>3.14 implies sqrt(2*pi)>5/2
assert 2+F(9,196)/F(5,2) == CUP
assert CUP*X0 == N0 and F(X0,49) == 10**25
assert F(69,10)**32 < N0
assert F(264,100)**64 < N0
assert F(158900000)*F(40804,10000)*49 < F(114,10000)*F(264,100)**31
assert 10**26 <= N0
assert F(462,10) < F(15,100)*F(69,10)**3
assert F(115,100)*F(13862943617,10**10) < F(16,10)
assert F(13862943617,10**10)+F(1,10000) < F(1387,1000)
assert 3*400**2*F(62,10)*F(16001,10000)*F(1387,1000) < 6700000

LOG10 = F(2303,1000)
assert sum((LOG10**k/F(factorial(k)) for k in range(25)), F(0)) > 10
NP = 49*F(202,100)**2*6700000*27*LOG10/isqrt(N0)
assert NP < F(265,100000) < F(271,100000)
assert NP < F(1049,1000)-F(10376,10000)
assert NP < F(10404,10000)-F(10376,10000)

# Tight rational comparison of the unchanged x/y floor, and necessary conditions
# for REUSING the old numerical envelopes. These are not lower bounds on true errors.
SQLO, SQHI = F(25066,10000), F(25067,10000)
assert SQLO**2 < 2*F(314159,100000)
assert SQHI**2 > 2*F(314160,100000)
CLO, CHI = 2+F(9,196)/SQHI, 2+F(9,196)/SQLO
star_den = F(149,10**8)-547*(F(1,10**17)+F(1,10**12))
plus_den = F(425,10**9)-F(75,10**9)-547*F(1,10**15)
assert star_den>0 and plus_den>0 and 547**2<300000
STAR_NEC = CLO*49*(F(4700000)/star_den)**2
PLUS_NEC = CLO*(F(7700000)/plus_den)**2
SIG_NEC = CLO*(F(36691,100)/F(17,10**12))**2

D=111616*2**45
B=4*10**18
OLD_MAX=254638308
OLD_CHUNKS=62168
IMAX=(N0-5)//D
CHUNKS=(IMAX+4095)//4096
assert IMAX == 251837287
assert (N0-5)//D == (N0-6)//D  # even threshold: top odd is N0-1
assert (111616+2047)*2**45 <= B-4
assert 111616*IMAX < 2**45
assert CHUNKS*4096 >= IMAX and (CHUNKS-1)*4096 < IMAX
assert 1+4096*CHUNKS <= 2**28
assert 111616*(1+4096*CHUNKS) <= 2**45
assert OLD_CHUNKS*4096 == 254640128
# Last retained source file starts at250667009; truncate its485 chunks.
PREFIX=250667008
LAST_CHUNKS=CHUNKS-PREFIX//4096
assert 0<LAST_CHUNKS<485

probes=[]
for N in [5*10**26,2*10**26,10**26]:
    # c0>2 implies x<N/2 and y<N/98.
    assert F(4700000)**2 > F(149,10**8)**2*F(N,98)
    assert F(36691,100)**2 > F(17,10**12)**2*F(N,2)
    assert F(69,10)**32 > N
    assumed_np=49*F(202,100)**2*6700000*27*LOG10/isqrt(N)
    assert assumed_np<F(114,10000)
    probes.append({'N':str(N), 'conditional_nonprime_upper':enc(assumed_np),
                   'star_fixed_envelope_fails':True, 'sig_fixed_coefficient_fails':True,
                   'old_chebyshev_6p9_lower_bound_fails':True})

source_names=[
 'Helfgott/Inputs.lean','Helfgott/Numerics.lean','Helfgott/Chebyshev.lean',
 'Helfgott/Main.lean','Helfgott/SmallCases.lean','Helfgott/SupNorms.lean','MainTheorems.lean',
 'MajorArcs/MajorTotal.lean','MajorArcs/ArcChars.lean','MajorArcs/ArcCharsStar.lean',
 'MinorArcs/MinorTotal.lean','MinorArcs/NumericsFinal.lean','MinorArcs/NumericsCore.lean',
 'MinorArcs/NumericsCells.lean','Ladder/Main.lean','Ladder/Spec.lean',
 'Ladder/Data.lean','Ladder/Data/L126.lean','Ladder/Data/L127.lean']
out={'scope':'rational/integer checks and source hashes only; no analytic evaluations',
 'threshold':str(N0),'x_floor':str(X0),'simple_c0_upper':enc(CUP),
 'chebyshev_w_floor_power':enc(F(69,10)**32),
 'nonprime_upper':enc(NP),'original_positive_margin_lower':enc(F(114,10000)-NP),
 'qrh_1p0404_positive_margin_lower':enc(F(28,10000)-NP),
 'exact_blackbox_threshold_lower':enc(CLO*X0),
 'exact_blackbox_threshold_upper':enc(CHI*X0),
 'star_envelope_necessary_N_lower':enc(STAR_NEC),
 'plus_envelope_necessary_N_lower':enc(PLUS_NEC),
 'sig_envelope_necessary_N_lower':enc(SIG_NEC),
 'old_required_rungs':OLD_MAX,'new_required_rungs':IMAX,
 'removed_required_rungs':OLD_MAX-IMAX,'old_checked_chunks':OLD_CHUNKS,
 'new_checked_chunks':CHUNKS,'removed_chunks':OLD_CHUNKS-CHUNKS,
 'new_checked_rungs':CHUNKS*4096,'removed_checked_rungs':(OLD_CHUNKS-CHUNKS)*4096,
 'retained_L126_chunks':LAST_CHUNKS,'probes':probes,
 'source_sha256':{n:hashlib.sha256((SRC/n).read_bytes()).hexdigest().upper() for n in source_names}}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in out.items() if k!='source_sha256'},indent=2))
