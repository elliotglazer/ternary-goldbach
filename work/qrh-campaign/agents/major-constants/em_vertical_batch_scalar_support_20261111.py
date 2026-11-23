"""Exact bounds/counts for a proposed batched finite EM main sum. No values/FFT."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

N=333334;B=N+1;K=24
assert N<578**2
assert F(8,3)**13>B  # exp(1)>8/3, so log(B)<13
weights=[F(1156*13**h,factorial(h)) for h in range(K)]
assert max(weights)<2**26
assert 3*max(weights)<2**33
assert N**5<5120**8  # (8/5)*N^(5/8)<8192
assert F(5,16)*F(22,7)==F(55,56)<1
assert F(2**14,factorial(32))<F(1,2**100)
assert F(2**33,factorial(48))<F(1,2**120)
assert F(2**33,factorial(36))<F(1,2**100)
assert F(2**33,factorial(39))<F(1,2**120)
arith=F(16,7*2**104)
total=F(2**14,factorial(32))+arith
assert total<F(1,2**100)
old=F(3,2)*(F(1,2**38)+F(1,7*2**21))/2**19
assert old+total<F(1,2**42)
rows=[]
for J in [1024,4096]:
 L=4*J; d=L.bit_length()-1;assert L==2**d
 for p in [32,48]:
  transforms=K*p
  rows.append(dict(J=J,L=L,p=p,jet_orders=K,
   moment_contributions=N*K*p,naive_main_coefficient_contributions=J*N*K,
   normalized_transforms=transforms,dense_moment_entries=K*p*L,
   radix_two_butterflies=K*p*(L//2)*d,
   center_contraction_terms=J*K*p,
   one_jet_stream_entries=p*L,
   normalized_output_radius_for_optional_arithmetic=str(F(1,2**104*L*p))))
out={'scope':'scalar truncation and symbolic operation counts only; no actual moments or transforms',
 'max_per_jet_weight_upper':str(max(weights)),
 'weighted_disk_main_sum_upper':8192,
 'p32_batching_quotient_tail_upper':str(F(2**14,factorial(32))),
 'p48_per_jet_tail_upper':str(F(2**33,factorial(48))),
 'optional_total_batching_error_upper':str(total),
 'old_slab_analytic_plus_batching_upper':str(old+total),'rows':rows}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS exact bounds; p32 weighted quotient<2^-100, p48 each jet<2^-120.')
for row in rows: print(row)
