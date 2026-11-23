"""Exact scalar budget only for the proposed 8-center height-2000 EM batch."""
from fractions import Fraction as F
from math import factorial,comb
from pathlib import Path
import json

T=2000;N=1024;B=1025;M=16;K=16;p=24;J=8;L=32
sigma=F(629,1250);t0=F(31999,16);delta=F(-1,8)
rho=F(1,16);R=F(1);A=2034
ts=[t0+j*delta for j in range(J)]
panels=[(t-rho,t+rho) for t in ts]
assert panels[0][1]==T and panels[-1][0]==1999
assert all(panels[j+1][1]==panels[j][0] for j in range(J-1))
assert sigma-1>=F(-1,2) and sigma>=F(1,2)
assert max(ts)+abs(sigma-1)+1<2002
assert min(t-rho for t in ts)>2**10 and min(ts)>3*rho
assert N<33**2 and B<33**2 and A<4*B
bern=[F(1)]
for n in range(1,2*M+1):
 bern.append(-sum(F(comb(n+1,k))*bern[k] for k in range(n))/F(n+1))
assert all(abs(bern[2*k])/factorial(2*k)<=F(4,6**(2*k)) for k in range(1,M+1))
corr=sum(F(4,6**(2*k))*F(A,B)**(2*k-1) for k in range(1,M+1))
assert corr<F(4,5)
outer=(T+4)*(N*33+33*F(13,10))+B*33
assert outer<2**27
em=F(4*(T+3)*33,F(63,2))*F(A,6*B)**32
assert em<F(1,2**38)
tay=F(2**27)*rho**K/(1-rho)
assert tay==F(1,15*2**33)
assert F(65,24)>F(27,10) and F(27,10)**7>B
weights=[F(64*7**h,factorial(h)) for h in range(K)]
assert max(weights)<2**14
assert N**9<72**16 # (16/9)*N^(9/16)<128
assert F(2**8,factorial(p))<F(1,2**70)
assert F(2**25,factorial(p))<F(1,2**54)
bucket=fft=F(1,2**110)
contract=F(1,2**100)
mainarith=L*p*(bucket+fft)+contract
assert mainarith==F(5,2**101) and mainarith<F(1,2**98)
full_correction=assembly=F(1,2**80)
gerr=F(2**25,factorial(p))+2002*F(1,2**98)+full_correction+assembly
assert gerr<F(1,2**53)<F(1,2**52)
coord=F(1,2**52);G=1/(1-rho);finalarith=F(1,2**64)
additional=F(3,2)*G*coord/2**10+finalarith
assert additional<F(1,2**60)
total=F(3,2)*(F(1,2**38)+tay+G*coord)/2**10+finalarith
assert total<F(1,2**44)<F(1,2**40)
out={'scope':'scalar design only; no numerical function or FFT evaluations',
 'parameters':dict(T=T,N=N,B=B,M=M,K=K,p=p,J=J,L=L,
  sigma=str(sigma),t0=str(t0),delta=str(delta),outer_radius=str(R),target_radius=str(rho)),
 'panels':[[str(a),str(b)] for a,b in panels],
 'outer_bound':str(outer),'EM_bound':str(em),'Taylor_bound':str(tay),
 'max_main_jet_weight':str(max(weights)),
 'main_arithmetic_bound':str(mainarith),'full_g_coefficient_error_bound':str(gerr),
 'coordinate_halfwidth':str(coord),'added_quotient_error_bound':str(additional),
 'full_quotient_error_bound':str(total),
 'counts':dict(moment_contributions=N*K*p,normalized_transforms=K*p,
  transform_length=L,radix_two_butterflies=K*p*(L//2)*5,
  bucket_entries=K*p*L,one_jet_bucket_entries=p*L,
  contraction_terms=J*K*p,full_g_coefficients=J*K,
  direct_reference_main_terms=J*N,direct_reference_coefficient_contributions=J*N*K,
  correction_polynomials=J*M,affine_pochhammer_updates=J*(2*M-1))}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS complete scalar budget: full quotient error<2^-44<2^-40; added coefficient/arithmetic<2^-60.')
print(out['counts'])
