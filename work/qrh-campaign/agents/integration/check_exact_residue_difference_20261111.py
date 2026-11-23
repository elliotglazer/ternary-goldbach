"""Integer polynomial identities and sizes only; no coefficient/function data."""
from pathlib import Path
from math import comb
from fractions import Fraction as Q
import hashlib, json

ROOT = Path(__file__).resolve().parents[4]
OWN = Path(__file__).resolve().parent
paths = [
 'work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md',
 'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md',
 'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md',
 'work/qrh-campaign/agents/major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md',
 'work/qrh-campaign/agents/zero-sum/R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md',
 'work/qrh-campaign/agents/integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md',
]
pins={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}
checks=0
def check(x):
 global checks
 assert x
 checks+=1

rows=[]
for c,F,k in [(100003,1024,500),(265800,1024,512),(265800,2048,1000)]:
 lo=max(1, -(-((2*k-1)*c)//(2*F)))
 hi=min(c-1,-(-((2*k+1)*c)//(2*F))-1)
 L=hi-lo+1
 check(L>=20)
 v=2*c
 check(all((2*F*a+c)//(2*c)==k for a in range(lo,hi+1)))
 for degree in range(20):
  def value(a):return (F*a-k*c)**degree*v**(19-degree)
  level=[value(lo+j) for j in range(20)]
  state=[]
  for order in range(20):
   state.append(level[0])
   check(state[-1]==sum((-1)**(order-j)*comb(order,j)*value(lo+j) for j in range(order+1)))
   level=[level[j+1]-level[j] for j in range(len(level)-1)]
  updates=0
  for i in range(L):
   check(state[0]==value(lo+i))
   if i<L-1:
    for order in range(min(18,L-i-2)+1):
     state[order]+=state[order+1]; updates+=1
  check(updates==19*L-190)
 rows.append({'c':c,'fine_F':F,'anchor_k':k,'lo':lo,'hi':hi,'L':L,'updates':19*L-190})

# Signed nearest-grid rounding, ties toward positive infinity, without any
# analytic values. Exhaustively check a bounded integer witness family.
for den in [1,2,3,16,19,1001]:
 for num in range(-203,204):
  m=(2*num+den)//(2*den)
  check((2*m-1)*den<=2*num<(2*m+1)*den)
  check(abs(Q(m)-Q(num,den))<=Q(1,2))

maxc=265800
power=(2*maxc)**19
power_bits=power.bit_length()
check(power_bits==362)
check((1<<19)<2*maxc<(1<<20))
check((maxc+1023)//1024==260)
check(Q(633,1)<1688)
out={'scope':'Exact polynomial-basis, signed rounding and integer-size checks; no numerical seeds',
     'pins':pins,'checks':checks,'basis_cases':rows,
     'max_denominator_power_bits':power_bits,
     'b122':{'denominator_bits':122+power_bits,
             'live_difference_signed_capacity':122+power_bits+37,
             'addition_temporary_signed_capacity':122+power_bits+38,
             'final_g100_cancelled_denominator_bits':122-100+power_bits},
     'per_block':{'coefficient_prescales':19,'initial_horner_scales':380,
                  'initial_horner_additions':380,'triangle_subtractions':190,
                  'advance_formula':'19*L-190','all_add_sub_formula':'19*L+380'}}
with (OWN/'exact_residue_difference_20261111.json').open('x',encoding='utf-8') as f:
 json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({k:v for k,v in out.items() if k!='pins'},indent=2))
