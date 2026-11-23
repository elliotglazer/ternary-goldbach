"""Independent exact scalar checks; no special functions or model evaluation."""
from fractions import Fraction as F
from math import comb,factorial
from pathlib import Path
import json,hashlib

T=10**6;N=333334;B=N+1;M=32;K=24;A=T+66
left=F(629,1250); H=F(1,8); R=F(1)
assert N*3>=T and (N-1)*3<T
assert N<578**2 and B<578**2
assert A<4*B and F(A,6*B)<F(501,1000)
bern=[F(1)]
for n in range(1,2*M+1):
 bern.append(-sum(F(comb(n+1,k))*bern[k] for k in range(n))/F(n+1))
for k in range(1,M+1):
 assert abs(bern[2*k])/factorial(2*k)<=F(4,6**(2*k))
corr=sum(F(4,6**(2*k))*F(A,B)**(2*k-1) for k in range(1,M+1))
assert corr<F(4,5)
outer=(T+4)*(N*578+578*F(13,10))+B*578
assert outer<2**48
em=F(4*(T+3)*578,F(127,2))*F(501,1000)**64
assert em<F(1,2**38)
tay=F(2**48)*H**K/(1-H)
assert tay==F(1,7*2**21)
denlo=T-H
assert denlo>2**19
analytic=(F(1,2**38)+tay)/2**19
rectangular=F(3,2)*analytic
assert analytic<F(1,2**42) and rectangular<F(1,2**42)
centers=[F(j,8) for j in range(5,16,2)]
blocks=[(max(left,c-H),c+H) for c in centers]
assert blocks[0][0]==left and blocks[-1][1]==2
assert all(blocks[i][1]==blocks[i+1][0] for i in range(5))
assert all(max(abs(a-c),abs(b-c))<=H for c,(a,b) in zip(centers,blocks))
assert left-1>=F(-1,2)
assert all(c-1>=F(-1,2) for c in centers)
assert max(centers)+1<3
assert F(1,16)<H and (T-F(1,16))-F(1,16)==T-H
assert (T-F(1,16))+F(1,16)==T
out={'scope':'scalar and exact geometry only; no function, coefficient or margin evaluation',
 'N':N,'B':B,'M':M,'K':K,'degree':K-1,'outer_radius':'1',
 'outer_bound':str(outer),'outer_power2_bound':48,
 'finite_correction_upper':str(corr),'EM_upper':str(em),
 'EM_simple_upper':'1/274877906944','Taylor_simple_upper':str(tay),
 'analytic_quotient_upper':str(analytic),'rectangular_error_box_quotient_upper':str(rectangular),
 'simple_quotient_upper':'1/4398046511104',
 'horizontal_blocks':[[str(a),str(b)] for a,b in blocks],
 'new_models':7,'reused_top_models':6,'new_coefficients':7*K,
 'retained_coefficients_total':13*K,
 'new_main_sum_terms':7*N,'new_main_sum_coefficient_contributions':7*N*K,
 'new_correction_polynomials':7*M,'new_affine_pochhammer_updates':7*(2*M-1),
 'source_script_sha256':hashlib.sha256((Path(__file__).parent.parent/'zero-sum/em_top_horizontal_20261111.py').read_bytes()).hexdigest().upper()}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS all exact scalar, Bernoulli, geometry and count checks.')
print('outer =',outer,'<2^48; quotient error (including sqrt2 box loss) <2^-42')
