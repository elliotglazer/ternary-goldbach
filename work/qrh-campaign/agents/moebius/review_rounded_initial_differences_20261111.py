"""Independent formal linear propagation and rational widths; no values."""
from pathlib import Path
from fractions import Fraction as F
from math import comb
import hashlib,json
HERE=Path(__file__).resolve().parent
A=HERE.parent
PATH=A/'major-constants/rounded_initial_differences_20261111.json'
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
def main():
 doc=json.loads(PATH.read_text(encoding='utf-8'))
 for p,h in doc['pins'].items():ck(hashlib.sha256((A/p).read_bytes()).hexdigest().upper()==h)
 ck(len(doc['rows'])==260)
 u=F(1,2**100)
 # Full formal coefficient matrix, one indeterminate for each initial error.
 matrix=[[int(j==k) for k in range(20)] for j in range(20)]
 for n,row in enumerate(doc['rows']):
  for j in range(20):
   for k in range(20):
    expected=comb(n,k-j) if j<=k and k-j<=n else 0
    ck(matrix[j][k]==expected)
  sums=[sum(r) for r in matrix]
  S=sum(comb(n,k) for k in range(min(19,n)+1))
  p=102+S.bit_length()
  ck((row['L'],row['S'],row['bitlength'],row['p'])==(n+1,S,S.bit_length(),p))
  ck(S*F(1,2**p)<u/4)
  ck(all(s<=S for s in sums))
  ck(row['old_guard']==dict(signed_live=p+38,signed_add_temporary=p+39,
    signed_initial_scaled_product=p+400,signed_initial_residual=p+401,signed_initial_doubled_residual=p+402))
  ck(row['ten_guard']==dict(signed_live=p+44,signed_add_temporary=p+45,
    signed_initial_scaled_product=p+406,signed_initial_residual=p+407,signed_initial_doubled_residual=p+408))
  ck(row['initial_complex_rounds']==20 and row['advance_complex_additions']==19*n)
  for j in range(19):
   matrix[j]=[x+y for x,y in zip(matrix[j],matrix[j+1])]
 g10=5*(F(6,5)**20-1)
 g20=4*(1-F(3,4)**20)
 ck(F(doc['g10'])==g10<192)
 ck(F(doc['g20'])==g20<4-F(1,512))
 ck(g10*2**35+1<2**43)
 ck(g20*2**35+1<2**37)
 ck(F(4,3)+F(1,4)+1==F(31,12)<F(8,3))
 ck(633*F(31,12)==F(6541,4))
 ck(F(1688)-F(6541,4)==F(211,4))
 v=2*265800; V=v**19
 ck(V<2**362)
 for p in range(103,198):
  for d in (37,43):
   # Initial I*2^(p-100) and rounded-state timesV use the same raw bound.
   ck(2**(p+d)*V<2**(p+d+362))
   ck(2*(2**(p+d)*V)<2**(p+d+363))
   ck(4*(2**(p+d)*V)<2**(p+d+364))
 witnesses=0
 for c in (2,3,5,17):
  V=(2*c)**19
  for I in (-V-1,-V,-1,0,1,V,V+1):
   for p in (103,130,197):
    U=I*2**(p-100)
    m=(2*U+V)//(2*V)
    ck(-V<=2*(U-m*V)<V)
    ck(abs(F(m,2**p)-F(I,2**100*V))<=F(1,2**(p+1)))
    witnesses+=1
 ck(doc['rows'][-1]['S']==32305056352236018054956299912)
 ck(doc['rows'][-1]['p']==197)
 ck(doc['selected']==[doc['rows'][n-1] for n in (1,10,20,40,80,130,260)])
 out=dict(status='PASS_SYMBOLIC_PROPAGATION_AND_WIDTHS',checks=checks,synthetic_initial_round_witnesses=witnesses,
   author_receipt_sha256=hashlib.sha256(PATH.read_bytes()).hexdigest().upper(),
   scope='All260 full formal20x20 error matrices, radius/width rows and initial conversion algebra; no coefficient/function samples or cost adoption.')
 with (HERE/'review_rounded_initial_differences_20261111.json').open('x',encoding='utf-8') as f:
  json.dump(out,f,indent=2);f.write('\n')
 print(json.dumps(out))
if __name__=='__main__':main()
