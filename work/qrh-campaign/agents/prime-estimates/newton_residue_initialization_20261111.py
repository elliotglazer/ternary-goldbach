"""Formal coefficient and integer-size metadata only; no analytic evaluations."""
from pathlib import Path
from math import comb, factorial
import hashlib
import json

ROOT = Path(__file__).resolve().parents[4]
OUT = Path(__file__).with_suffix('.json')
PINS = {
 'work/qrh-campaign/agents/integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md': '691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025',
 'work/qrh-campaign/agents/prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md': '99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1',
 'work/qrh-campaign/agents/moebius/REVIEW_LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md': 'C6096D0C677E09F850065EDD2103B0348E28392D482CCEE568136B387768C86E',
}
checks = 0
def check(ok):
 global checks
 checks += 1
 assert ok

def plus(a, b):
 out = dict(a)
 for k, val in b.items():
  out[k] = out.get(k, 0) + val
 return {k:v for k,v in out.items() if v}

# Formal monomials n_index * q**qe * G**ge * v**ve.
def shift(a, qe=0, ge=0, mul=1):
 return {(n,q+qe,g+ge,v):x*mul for (n,q,g,v),x in a.items() if x*mul}

S = [[0]*21 for _ in range(21)]
S[0][0] = 1
for n in range(1,21):
 for j in range(1,n+1):
  S[n][j] = j*S[n-1][j]+S[n-1][j-1]

for p,h in PINS.items():
 check(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)

rows=[]
for d in range(20):
 state=[{(d,0,0,0):1}]
 for i in range(1,d+1):
  state.append(shift(state[i-1],ge=1,mul=i))
  for j in range(i-1,0,-1):
   state[j]=plus(plus(shift(state[j],qe=1),shift(state[j],ge=1,mul=j)),shift(state[j-1],ge=1,mul=j))
  state[0]=plus(shift(state[0],qe=1),{(d-i,0,0,i):1})
  for j in range(i+1):
   expected={}
   for k in range(d-i,d+1):
    degree=k-(d-i)
    for h in range(j,degree+1):
     value=comb(degree,h)*factorial(j)*S[h][j]
     if value:
      expected[k,degree-h,h,d-k]=value
   check(state[j]==expected)
 general=d*(d+1)//2
 tiny_adds=sum((d+1-j)*(j.bit_count()-1) for j in range(1,d+1))
 shift_terms=sum((d+1-j)*j.bit_count() for j in range(1,d+1))
 check(shift_terms-tiny_adds==general)
 rows.append(dict(degree=d,general_products=general,tiny_scales=general,
                  recurrence_adds=general,tiny_binary_adds=tiny_adds,
                  shifted_operand_occurrences=shift_terms))
check(rows[-1]['general_products']==190)
check(rows[-1]['tiny_binary_adds']==167)
check(rows[-1]['shifted_operand_occurrences']==357)
v=2*265800
vb=(v**19).bit_length()
check(vb==362)
check(3*v//4<2**19)
# Strict upper powers: |state| < 2**37 * Q; raw advance < 2**38 * Q.
widths=[]
for b in (100,110,122,130):
 widths.append(dict(common_fractional_bits=b,Q_bits=(2**b*v**19).bit_length(),
   signed_initial_and_stored_capacity=b+vb+37+1,
   signed_advance_capacity=b+vb+38+1,
   signed_prescale_capacity=b+vb+16+1))
check(widths[2]['signed_initial_and_stored_capacity']==522)
check(widths[2]['signed_advance_capacity']==523)
report=dict(status='PASS_FORMAL_COEFFICIENT_IDENTITIES_AND_SIZE_METADATA',checks=checks,
 pins=PINS,formal_identity='Delta^j(q+G*t)^k evaluated at t=0 = sum_h binom(k,h)*q^(k-h)*G^h*j!*S(h,j)',
 degree_rows=rows,widths=widths,
 degree19_comparison=dict(old_general_products=380,new_general_products=190,
 old_init_adds_and_subtractions=570,new_recurrence_adds=190,
 new_tiny_binary_adds=167,new_total_init_adds=357,
 tiny_shift_occurrences=357,common_nontrivial_prescales=19),
 scope='No coefficient values, analytic functions, transforms, timing or production admission.')
OUT.write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(status=report['status'],checks=checks,receipt=str(OUT))))
