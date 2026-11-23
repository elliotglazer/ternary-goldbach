"""Finite combinatorial/rational envelopes only, no polynomial values."""
from math import comb,factorial
from fractions import Fraction as F
from pathlib import Path
import json,hashlib
ROOT=Path(__file__).resolve().parents[4]
pins={
 'work/qrh-campaign/agents/prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC',
 'work/qrh-campaign/agents/major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md':'AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054',
 'work/qrh-campaign/agents/major-constants/ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md':'FB0B0F9AF9C53150E14C1F5FFDE7A39E78DD8A6BFA09FE7769BF234EBB965E46',
}
checks=0
def ck(x):
 global checks
 checks+=1
 assert x
for path,digest in pins.items():
 ck(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==digest)
S=[[0]*20 for _ in range(20)]
S[0][0]=1
for m in range(1,20):
 for j in range(1,m+1):S[m][j]=j*S[m-1][j]+S[m-1][j-1]
D=20**19
E=[]; envelope=[]
for j in range(20):
 n=sum(comb(k,m)*5**(k-m)*20**(19-k)*factorial(j)*S[m][j]
       for k in range(j,20) for m in range(j,k+1))
 E.append(n)
 check_gap=4*D-3*n
 ck(n>=0 and check_gap>0)
 # A separate rational summation verifies the common-denominator encoding.
 rational=sum(F(comb(k,m)*factorial(j)*S[m][j],4**(k-m)*20**m)
              for k in range(j,20) for m in range(j,k+1))
 ck(rational==F(n,D))
 envelope.append(dict(order=j,numerator=n,denominator=D,reduced=str(rational),
  gap_to_four_thirds_crossproduct=check_gap))
raw=[]
for j in range(1,20):
 general=(5+j)*E[j]
 secondary=j*E[j-1]
 # j19 general is not used by degree19 initialization; retaining it is conservative.
 total=general+secondary
 ck(3*total<80*D)
 ck(3*secondary<80*D)
 raw.append(dict(order=j,denominator=20*D,general_product_numerator=general,
  secondary_or_top_numerator=secondary,sum_numerator=total,
  sum_reduced=str(F(total,20*D)),gap_to_four_thirds=80*D-3*total))
insertion=F(4*D+E[0],4*D)
ck(insertion<F(4,3))
advances=[]
for j in range(19):
 n=E[j]+E[j+1]
 ck(2*n<3*D)
 advances.append(dict(order=j,numerator=n,denominator=D,reduced=str(F(n,D)),
  gap_to_three_halves_crossproduct=3*D-2*n))
# All degree-truncated envelopes are no larger than the degree19 envelope.
for degree in range(20):
 for j in range(degree+1):
  part=sum(F(comb(k,m)*factorial(j)*S[m][j],4**(k-m)*20**m)
           for k in range(j,degree+1) for m in range(j,k+1))
  ck(part<=F(E[j],D))
C=2**16
ck(F(4,3)*C+F(1,2**102)<2**17)
ck(F(3,2)*C+F(2,2**102)<2**17)
ck((531600**19).bit_length()==362)
widths=[]
for length in range(1,261):
 Sbound=sum(comb(length-1,k) for k in range(min(19,length-1)+1))
 p=102+Sbound.bit_length()
 ck(103<=p<=197 and F(Sbound,2**p)<F(1,2**102))
 widths.append(dict(length=length,p=p,rounded_live_and_add_signed=p+18,
   exact_b100_initializer_signed=480,initial_product_signed=p+380,
   initial_residual_signed=p+381,initial_doubled_residual_signed=p+382))
ck(widths[-1]['rounded_live_and_add_signed']==215)
ck(widths[-1]['initial_doubled_residual_signed']==579)
out=dict(status='PASS_FINITE_STIRLING_ENVELOPES_AND_RAW_SUM_BOUNDS',checks=checks,
 assumptions=dict(degree_at_most=19,absolute_base_at_most='1/4',absolute_step_at_most='1/20',
                  coefficient_norm_at_most='C>=0'),
 pins=pins,common_denominator=D,envelopes=envelope,raw_newton=raw,
 constant_insertion_bound=str(insertion),raw_advances=advances,
 maximum_envelope_order=max(range(20),key=lambda j:E[j]),
 maximum_advance_order=max(range(19),key=lambda j:E[j]+E[j+1]),rounded_widths=widths,
 scope='Pure finite coefficients/counts; no coefficient arrays, polynomial samples, integrals or builds.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(dict(status=out['status'],checks=checks,max_envelope=out['maximum_envelope_order'],
 max_raw_advance=advances[out['maximum_advance_order']]['reduced'])))
