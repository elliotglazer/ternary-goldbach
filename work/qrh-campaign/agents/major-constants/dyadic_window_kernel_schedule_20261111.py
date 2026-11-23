"""Symbolic counts and rational bounds only. No offset, digit or kernel enumeration."""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib,json
AG=Path(__file__).resolve().parents[1]
HERE=Path(__file__).resolve().parent
checks=[]
def ck(label,p):
    assert p,label
    checks.append(label)
pins={
'audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md':'32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E',
'major-constants/REVIEW_SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md':'61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730',
'audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md':'6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA',
'major-constants/REVIEW_LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md':'3D8831ABB2BBD69A1AD82389B8A2082DBCE18D5E6C47E73230F6808F0EBFF589'}
for p,h in pins.items():ck('pin '+p,hashlib.sha256((AG/p).read_bytes()).hexdigest().upper()==h)
h=Q(159,500);delta=Q(5,64);A=delta*delta/(2*h*h)
ck('exact Gaussian parameter',A==Q(390625,12943872))
ck('fractional a argument',A<Q(1,32))
ck('fractional b argument',2*A<Q(1,16))
ck('fixed integer Gaussian argument',41**2*A<53)
eps=Q(1,2**80)
ck('T recurrence coefficient',1+2*41==83)
ck('Gaussian error coefficient',1+41+1+42==85)
ck('kernel error coefficient',85+1+1+1==88)
ck('target kernel radius',88*eps<Q(1,2**72))
ck('stronger spare radius',88*eps<Q(1,2**73))
ck('sinc uniform alternating remainder',Q(2**32,factorial(33))<Q(1,2**90))
ck('sinc first consecutive term ratio',Q(4,6)<1)

# Linear polynomials in nf,ntheta; no substitution by an offset list.
def scale(a,v):return tuple(a*x for x in v)
def plus(a,b):return tuple(x+y for x,y in zip(a,b))
D=(41,1);F=(1,0);S=(0,1)
gaussian_products=scale(2,plus(D,scale(-1,F)))
general=plus(gaussian_products,D)
rational=D
clamps=plus(general,rational)
negative=(20,1)
ck('partial Gaussian product count',gaussian_products==(80,2))
ck('partial general product count',general==(121,3))
ck('partial rational stage count',rational==(41,1))
ck('partial gate clamp count',clamps==(162,4))
ck('partial negative signs',plus(scale(21,S),scale(20,plus(F,scale(-1,S))))==negative)
def dense(v):return (sum(v),-sum(v)) # nf=ntheta=Q-1
ck('dense distinct distances',dense(D)==(42,-42))
ck('dense general products',dense(general)==(124,-124))
ck('dense exact rational stages',dense(rational)==(42,-42))
ck('dense all rounded stages',dense(clamps)==(166,-166))
ck('dense negative signs',dense(negative)==(21,-21))
# Doubling an abstract mesh denominator gives the next-level odd-numerator keys.
old_dense=dense(D);doubled=(2*old_dense[0],old_dense[1])
ck('new level distance coefficient',plus(doubled,scale(-1,old_dense))==(42,0))
ck('cold exponential leaf count',(2,39)==plus((2,-2),(0,41)))
ck('direct minus recurrence exponential leaf count',plus((42,-42),scale(-1,(2,39)))==(40,-81))
ck('half-offset base sinc count',Q(2,2)==1)
ck('lattice removable sample count',2*41+1==83)
ck('uniform center inclusive unsigned capacity',2**80+1<=2**81)
ck('uniform signed center capacity',2**80<2**81)
ck('raw nonnegative product capacity',2**160<2**161)

out={'scope':'Symbolic schedule only. No rational offset or digit list was generated.',
     'pins':pins,'count':len(checks),'checks':checks,'A':str(A),'seed_and_gate_radius':'2^-80',
     'Gaussian_radius':'85*2^-80','kernel_radius':'88*2^-80 < 2^-72',
     'partial_counts':{'distance_keys':'41*nf+ntheta','general_products':'121*nf+3*ntheta',
                       'exact_rational_round_stages':'41*nf+ntheta','gate_clamps':'162*nf+4*ntheta',
                       'negative_signs':'20*nf+ntheta','exponential_seeds':'41+2*nf if ntheta>0',
                       'sinc_seeds':'number of complementary offset classes'},
     'dense_counts':{'Q':'2^R; R>=1','distance_keys':'42*(Q-1)','exponential_seeds':'2*Q+39',
                     'sinc_seeds':'Q/2','general_products':'124*(Q-1)',
                     'exact_rational_round_stages':'42*(Q-1)','gate_clamps':'166*(Q-1)'},
     'production_success':False,'timing_claim':False}
path=HERE/'dyadic_window_kernel_schedule_20261111.json'
with path.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'sha256':hashlib.sha256(path.read_bytes()).hexdigest().upper()},indent=2))
