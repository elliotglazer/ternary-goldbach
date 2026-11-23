"""Independent formal finite-difference coefficients and rational envelopes."""
from pathlib import Path
from fractions import Fraction as F
from math import comb,factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
PATH=HERE.parent/'prime-estimates/finite_stirling_difference_envelopes_20261111.json'
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
def main():
 doc=json.loads(PATH.read_text(encoding='utf-8'))
 for p,h in doc['pins'].items():
  ck(hashlib.sha256((HERE.parents[3]/p).read_bytes()).hexdigest().upper()==h)
 # Alternating finite-difference coefficient formula, independent of Stirling recursion.
 coeff=[[sum((-1)**(j-t)*comb(j,t)*t**ell for t in range(j+1))
         for ell in range(20)] for j in range(20)]
 for j in range(20):
  for ell in range(20):
   ck(coeff[j][ell]>=0)
   ck((coeff[j][ell]==0) if ell<j else True)
   if ell and j:
    ck(coeff[j][ell]==j*(coeff[j][ell-1]+coeff[j-1][ell-1]))
   if j:ck(coeff[j][j]==factorial(j))
 # All monomial degrees and difference orders, including zero and above degree.
 mono={}
 for degree in range(20):
  for j in range(20):
   terms={ell:comb(degree,ell)*coeff[j][ell] for ell in range(degree+1)}
   ck(all(v>=0 for v in terms.values()))
   if j>degree:ck(all(v==0 for v in terms.values()))
   mono[degree,j]=sum(F(v,4**(degree-ell)*20**ell) for ell,v in terms.items())
 E=[sum(mono[k,j] for k in range(20)) for j in range(20)]
 D=20**19
 ck(D==doc['common_denominator'])
 for j,row in enumerate(doc['envelopes']):
  ck(row['order']==j)
  ck(E[j]==F(row['numerator'],row['denominator'])==F(row['reduced']))
  ck(row['denominator']==D and row['gap_to_four_thirds_crossproduct']==4*D-3*row['numerator']>0)
  ck(E[j]<F(4,3))
  for degree in range(20):ck(sum(mono[k,j] for k in range(degree+1))<=E[j])
 for j,row in enumerate(doc['raw_newton'],1):
  general=(F(1,4)+F(j,20))*E[j]
  secondary=F(j,20)*E[j-1]
  ck(row['order']==j)
  ck(general==F(row['general_product_numerator'],row['denominator']))
  ck(secondary==F(row['secondary_or_top_numerator'],row['denominator']))
  ck(general+secondary==F(row['sum_reduced'])<F(4,3))
  ck(row['gap_to_four_thirds']==80*D-3*row['sum_numerator']>0)
 ck(1+E[0]/4==F(doc['constant_insertion_bound'])<F(4,3))
 for j,row in enumerate(doc['raw_advances']):
  ck(E[j]+E[j+1]==F(row['reduced'])<F(3,2))
  ck(row['gap_to_three_halves_crossproduct']==3*D-2*row['numerator']>0)
 ck(E[0]==F(4,3)*(1-F(1,4)**20))
 ck(doc['maximum_envelope_order']==max(range(20),key=lambda j:E[j]))
 ck(doc['maximum_advance_order']==max(range(19),key=lambda j:E[j]+E[j+1]))
 # Quantitative slack relevant to the already reviewed rounded-state error.
 C=2**16;u=F(1,2**100)
 for j in range(20):ck(C*E[j]+u/4<2**17)
 for j in range(19):ck(C*(E[j]+E[j+1])+u/2<2**17)
 ck(C*(1+E[0]/4)<2**17)
 ck((2*265800)**19<2**362)
 ck(len(doc['rounded_widths'])==260)
 for row in doc['rounded_widths']:
  n=row['length']-1
  p=102+sum(comb(n,k) for k in range(min(19,n)+1)).bit_length()
  ck(row==dict(length=n+1,p=p,rounded_live_and_add_signed=p+18,
    exact_b100_initializer_signed=480,initial_product_signed=p+380,
    initial_residual_signed=p+381,initial_doubled_residual_signed=p+382))
  ck(2**(p+17)*(2*265800)**19<2**(p+379))
 note=(HERE.parent/'prime-estimates/FINITE_STIRLING_DIFFERENCE_STATE_BOUND_2026-11-11.md').read_text(encoding='utf-8')
 for j,row in enumerate(doc['envelopes']):ck(f"|{j}|{row['numerator']}|" in note)
 out=dict(status='PASS_FORMAL_STIRLING_AND_ENVELOPE',checks=checks,
   author_receipt_sha256=hashlib.sha256(PATH.read_bytes()).hexdigest().upper(),
   scope='Formal alternating monomial coefficients, all degree/order envelopes and raw sums; no polynomial function samples or cost adoption.')
 with (HERE/'review_finite_stirling_envelope_final_20261111.json').open('x',encoding='utf-8') as f:
  json.dump(out,f,indent=2);f.write('\n')
 print(json.dumps(out))
if __name__=='__main__':main()
