"""Independent exact rational witness checks, not a Lean soundness proof."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
MATH=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib')
PLAN=HERE.parent/'prime-estimates/INTERVAL_PRIMITIVES_SOURCE_PLAN_2026-11-11.md'
PIN='BD64557F5ABFDDCA57717B180BE6AB93B888351547F3B75505B25226F190B2CC'
assert hashlib.sha256(PLAN.read_bytes()).hexdigest().upper()==PIN
def atan_sum(t,n):return sum(((-1)**j*t**(2*j+1)/Q(2*j+1) for j in range(n)),Q(0))
def mul(x,y):
 v=[a*b for a in x for b in y];return min(v),max(v)
def contains(outer,inner):return outer[0]<=inner[0]<=inner[1]<=outer[1]
def squ(x):
 a,b=x;return (Q(0) if a<=0<=b else min(a*a,b*b),max(a*a,b*b))
def reciprocal(x):
 a,b=x;assert a<=b and (b<0 or a>0);return 1/b,1/a
def record(x):return [str(t) for t in x]

p5=(atan_sum(Q(1,5),16),atan_sum(Q(1,5),17))
p239=(atan_sum(Q(1,239),6),atan_sum(Q(1,239),7))
pi=(16*p5[0]-4*p239[1],16*p5[1]-4*p239[0])
pi_box=(Q(314159265358979323846,10**20),Q(314159265358979323847,10**20))
assert contains(pi_box,pi)
t=Q(1,2);n=20;e=sum((t**j/factorial(j) for j in range(n)),Q(0))
tail=t**n*(n+1)/Q(factorial(n)*n)
exp1=(e*e,(e+tail)**2)
exp_box=(Q(27182818284590452353602,10**22),Q(27182818284590452353604,10**22))
assert contains(exp_box,exp1)
t=Q(1,3);n=12;l=2*sum((t**(2*j+1)/Q(2*j+1) for j in range(n)),Q(0))
log2=(l,l+2*t**(2*n+1)/((2*n+1)*(1-t*t)))
log_box=(Q(693147180559,10**12),Q(693147180561,10**12))
assert contains(log_box,log2)
sqrt2=(Q(1414213562373095,10**15),Q(1414213562373096,10**15))
assert 0<=sqrt2[0]<=sqrt2[1] and sqrt2[0]**2<=2<=sqrt2[1]**2

# Positive/negative large range-reduction witnesses preserve the pi uncertainty.
reductions=[]
for x,k in [(1000000,159155),(-1000000,-159155)]:
 kp=mul((Q(2*k),Q(2*k)),pi_box)
 y=(Q(x)-kp[1],Q(x)-kp[0])
 assert contains((Q(-4),Q(4)),y)
 assert y[1]-y[0]==2*abs(k)*(pi_box[1]-pi_box[0])
 reductions.append({'x':x,'k':k,'Y':record(y),'width':str(y[1]-y[0])})
assert Q(4,8)<=Q(1,2)  # R=4,N=7 is the exact boundary of the complex tail premise.

# Exact finite regression of signed arithmetic and the norm-square guard.
points=[Q(n,4) for n in range(-12,13)]
intervals=[(a,b) for a in points for b in points if a<=b]
reciprocal_checks=0
for x in intervals:
 sx=squ(x)
 for u in [x[0],sum(x)/2,x[1]]:
  assert sx[0]<=u*u<=sx[1]
 if x[1]<0 or x[0]>0:
  rx=reciprocal(x)
  for u in [x[0],sum(x)/2,x[1]]:assert rx[0]<=1/u<=rx[1]
  reciprocal_checks+=1
assert squ((Q(-1),Q(1)))[0]==0
assert mul((Q(-1),Q(1)),(Q(-1),Q(1)))[0]==-1
# The coordinate square [-E,E]^2 is not a radius-E disk.
assert Q(1)**2+Q(1)**2>Q(1)**2
root_residues=0
for m in range(1,33):
 for k in range(-100,101):
  j=(2*k+m)//(2*m);r=k-j*m
  assert k==j*m+r and 2*abs(r)<=m
  root_residues+=1

files=[
 'Mathlib/Analysis/Complex/Norm.lean','Mathlib/Analysis/Real/Sqrt.lean',
 'Mathlib/Analysis/SpecialFunctions/Complex/Arctan.lean',
 'Mathlib/Analysis/SpecificLimits/Normed.lean',
 'Mathlib/Analysis/SpecialFunctions/Trigonometric/Arctan.lean',
 'Mathlib/Analysis/Complex/Exponential.lean',
 'Mathlib/Analysis/SpecialFunctions/Log/Basic.lean',
 'Mathlib/Analysis/SpecialFunctions/Log/Deriv.lean',
 'Mathlib/Analysis/SpecialFunctions/Trigonometric/Basic.lean',
 'Mathlib/Analysis/Complex/Trigonometric.lean',
 'Mathlib/Analysis/SpecialFunctions/Pow/Complex.lean',
 'Mathlib/Analysis/SpecialFunctions/Complex/Log.lean',
 'Mathlib/Analysis/SpecialFunctions/Complex/Arg.lean',
 'Mathlib/RingTheory/RootsOfUnity/Complex.lean',
 'Mathlib/Algebra/Polynomial/Eval/Degree.lean']
manifest={p:hashlib.sha256((MATH/p).read_bytes()).hexdigest().upper() for p in files}
for p in ['Prelim/RamareHarm.lean','MinorArcs/Eta2DDTaylor.lean']:
 path=ROOT/'work/ternary-goldbach/TernaryGoldbach'/p
 manifest['TernaryGoldbach/'+p]=hashlib.sha256(path.read_bytes()).hexdigest().upper()
out={'status':'PASS_EXACT_RATIONAL_WITNESSES','plan_sha256':PIN,
 'pi':record(pi),'exp_one':record(exp1),'log_two':record(log2),'sqrt_two':record(sqrt2),
 'range_reduction':reductions,'square_intervals_checked':len(intervals),
 'reciprocal_intervals_checked':reciprocal_checks,'root_residues_checked':root_residues,
 'source_sha256':manifest,'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
 'scope':'Finite rational data checks and source-file identities only, no implemented verified checker.'}
HERE.joinpath('review_interval_primitives_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k not in ['pi','exp_one','log_two','source_sha256']},indent=2))
