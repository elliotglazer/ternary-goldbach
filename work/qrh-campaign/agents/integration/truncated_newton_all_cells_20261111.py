"""Formal coefficient identities and exact geometry/error metadata only."""
from pathlib import Path
from math import comb,factorial
from fractions import Fraction as Q
import hashlib,json
HERE=Path(__file__).resolve().parent
BASE=HERE.parent
checks=0
def ck(v):
 global checks
 checks+=1
 assert v
def plus(a,b):
 r=dict(a)
 for k,v in b.items():r[k]=r.get(k,0)+v
 return {k:v for k,v in r.items() if v}
def times_q(a):return {(n,q+1,f,v):x for (n,q,f,v),x in a.items()}
def times_f(a,j):return {(n,q,f+1,v):j*x for (n,q,f,v),x in a.items() if j*x}
st=[[0]*20 for _ in range(20)]
st[0][0]=1
for h in range(1,20):
 for j in range(1,h+1):st[h][j]=st[h-1][j-1]+j*st[h-1][j]
def closed(i,j):
 out={}
 for ell in range(j,i+1):
  for h in range(j,ell+1):
   c=comb(ell,h)*factorial(j)*st[h][j]
   if c:out[(19-i+ell,ell-h,h,i-ell)]=c
 return out
init_rows=[]
for m in range(1,21):
 state=[{(19,0,0,0):1}]
 gen=small=adds=0
 for i in range(1,20):
  if i<m:
   state.append(times_f(state[i-1],i));small+=1
  for j in range(min(i-1,m-1),0,-1):
   state[j]=plus(plus(times_q(state[j]),times_f(state[j],j)),times_f(state[j-1],j))
   gen+=1;small+=1;adds+=1
  state[0]=plus(times_q(state[0]),{(19-i,0,0,i):1})
  gen+=1;adds+=1
  ck(len(state)==min(i+1,m))
  for j in range(len(state)):ck(state[j]==closed(i,j))
 ck(gen==m*(39-m)//2)
 ck(adds==gen)
 ck(small==sum(20-j for j in range(1,m)))
 binary=sum((20-j)*(j.bit_count()-1) for j in range(1,m))
 shifts=sum((20-j)*j.bit_count() for j in range(1,m))
 init_rows.append(dict(m=m,general_products=gen,recurrence_additions=adds,
  small_scales=small,binary_additions=binary,shifted_operands=shifts,
  total_initialization_additions=adds+binary,coefficient_prescales=19))

# Formal independent initial-error variables; no coefficient values occur.
for L in list(range(1,26))+[40,80,130,260]:
 m=min(20,L)
 state=[{j:1} for j in range(m)]
 for n in range(L):
  live=min(19,L-1-n)
  ck(len(state)==live+1)
  for j in range(live+1):
   expected={j+k:comb(n,k) for k in range(min(n,m-1-j)+1)}
   ck(state[j]==expected)
  if n+1<L:
   for j in range(min(18,L-2-n)+1):state[j]=plus(state[j],state[j+1])
   state=state[:min(19,L-2-n)+1]

u=Q(1,2**100);C=2**16;ell=(531600**19).bit_length()
ck(ell==362)
ck(Q(4,3)*C+u/4<2**17)
ck(Q(4,3)+Q(1,4)+1==Q(31,12)<Q(8,3))
ck(633*Q(31,12)==Q(6541,4))
ck(1688-Q(6541,4)==Q(211,4))
rows=[]
prev=0
for L in range(1,261):
 m=min(20,L)
 S=sum(comb(L-1,j) for j in range(m))
 p=102+S.bit_length()
 ck(S>=prev);prev=S
 ck(Q(S,2**p)<u/4)
 A=sum(min(19,l) for l in range(1,L))
 ck(A==(L*(L-1)//2 if L<=20 else 19*L-190))
 if L<=20:ck(S==2**(L-1) and p==102+L)
 ck(103<=p<=197)
 rows.append(dict(L=L,m=m,S=str(S),p=p,advances=A,
  exact_live_signed=100+ell+m+17,
  exact_raw_add_signed=None if L==1 else 100+ell+m+18,
  rounded_live_signed=p+m+17,
  rounded_raw_add_signed=None if L==1 else p+m+18,
  initial_shift_or_product_signed=p+ell+m+17,
  initial_residual_signed=p+ell+m+18,
  initial_comparison_signed=p+ell+m+19,
  final_dyadic_scratch_signed=p+20))
ck(rows[-1]['p']==197)
ck(rows[-1]['S']=='32305056352236018054956299912')
ck(rows[-1]['rounded_live_signed']==234)
ck(rows[-1]['rounded_raw_add_signed']==235)
ck(rows[-1]['initial_comparison_signed']==598)

# Raw-interior, top and insertion factors relative to C*2^(b+j)*v^i.
ck(Q(1,4)*Q(4,3)+Q(1,2)*Q(4,3)/2==Q(2,3)<Q(4,3))
ck(Q(1,2)*Q(4,3)/2==Q(1,3))
ck(Q(1,4)*Q(4,3)+1==Q(4,3))
sources=[
 'prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md',
 'moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md',
 'integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md',
 'audit/REVIEW_EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_2026-11-11.md',
 'integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md',
 'integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md',
 'audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md',
 'major-constants/ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md',
]
pins=[dict(path=r,sha256=hashlib.sha256((BASE/r).read_bytes()).hexdigest().upper()) for r in sources]
out=HERE/'truncated_newton_all_cells_20261111.json'
out.write_text(json.dumps(dict(scope='formal identities and exact scalar metadata; no coefficient values or scans',
 checks=checks,initialization=init_rows,lengths=rows,pins=pins),indent=2)+'\n',encoding='utf-8')
print(json.dumps(dict(checks=checks,sha256=hashlib.sha256(out.read_bytes()).hexdigest().upper())))
