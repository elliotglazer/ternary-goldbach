"""Independent bounded exact precision audit. No author code or FFT is executed."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
AUTHOR=HERE.parent/'major-constants'
PINS={
 'AUXILIARY_FFT_ROUNDING_EXTENSION_2026-11-11.md':'da25013dfeaaacefeac5cf173a45b632c03be42d1412a4edd9d9a44e77ca4870',
 'auxiliary_fft_rounding_extension_20261111.py':'2df3b740f6ce29771e82f219b9d50c4269100096c4aa987c6e692f170cd4cc9b',
 'auxiliary_fft_rounding_extension_20261111.json':'bc4b2631574d5bf806ad14170aeea7f7d09f770895ce63310dc26398ea45d683'}
for name,sha in PINS.items():
    assert hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest()==sha

A=Q(22,7)
def pe(j):
    return (16*Q(1,5)**(2*j+1)+4*Q(1,239)**(2*j+1))/(2*j+1)
def te(k):
    return A**(k+1)/factorial(k+1)/(1-A/(k+2))
def least_via_bisection(start,fn,target):
    high=start
    while fn(high)>target:
        high*=2
    low=start
    while low<high:
        mid=(low+high)//2
        if fn(mid)<=target: high=mid
        else: low=mid+1
    assert fn(low)<=target
    assert low==start or fn(low-1)>target
    return low

def independent(d,B,D,eps):
    B,D,eps=map(Q,(B,D,eps))
    assert d>=0 and B>=0 and D>0 and eps>0
    delta=min(Q(1,2*(d+1)),Q(1,(d+1)*(B+2)),eps/(2*(B+2)*(D*d+1)))
    q=4/delta
    ceiling=(q.numerator+q.denominator-1)//q.denominator
    p=max(2,(ceiling-1).bit_length()+1)
    J=least_via_bisection(2,pe,delta/(4*(D+1)))
    K=least_via_bisection(6,te,delta/4)
    round_c=Q(1,2**(p-1));round_r=round_c/2
    E=d*(B+2)*delta
    cap=(B+2)*(D*d+1)*delta
    sharp=D*E+delta*(B+E)+delta
    amp=1/(1-Q(d)*delta/2)
    assert round_c<=delta/4
    assert p==2 or 2*round_c>delta/4
    assert amp<Q(4,3) and E<1
    assert pe(J)+te(K)+round_c<delta
    assert D*pe(J)+round_r<delta
    assert sharp<cap<=eps/2<eps
    assert A/(K+2)<Q(1,2)
    return {'stages':d,'center_norm_bound':str(B),'scale_bound':str(D),
      'output_tolerance':str(eps),'local_delta':str(delta),'dyadic_bits':p,
      'Machin_terms_per_arctan':J,'exponential_degree':K,
      'pi_error_upper':str(pe(J)),'exponential_tail_upper':str(te(K)),
      'complex_rounding_upper':str(round_c),
      'twiddle_error_upper':str(pe(J)+te(K)+round_c),
      'scale_error_upper':str(D*pe(J)+round_r),
      'stage_amplification_upper':str(amp),'stage_error_upper':str(E),
      'scaled_output_error_upper':str(cap),
      'sharper_scaled_output_error_upper':str(sharp),
      'error_to_tolerance_ratio':str(cap/eps),
      'status':'PASS_EXACT_SCALAR_PARAMETERS_ONLY'}

receipt=json.loads((AUTHOR/'auxiliary_fft_rounding_extension_20261111.json').read_text())
rows=[receipt['auxiliary_c4_H1e8']]+receipt['additional_scalar_boundary_checks']
for row in rows:
    result=independent(row['stages'],row['center_norm_bound'],row['scale_bound'],row['output_tolerance'])
    assert result==row
assert rows[0]['stages']==37 and (rows[0]['dyadic_bits'],rows[0]['Machin_terms_per_arctan'],rows[0]['exponential_degree'])==(147,32,53)

# Independently selected boundary cases, with no coefficient data.
extra_cases=[(0,0,Q(1,10**30),Q(10**30)),
 (0,10**40,Q(1,7),Q(1,10**100)),(1,0,10**30,Q(1,10**60)),
 (37,Q(1,3),Q(1,10**20),Q(100)),(38,0,Q(1,2),Q(1,10**100)),
 (1000,Q(1,100),10**12,Q(1,10**100)),
 (1000000,10**50,Q(1,10**30),Q(1,10**120)),
 (1,Q(1,10**30),Q(1,10**30),Q(10**30))]
extra=[]
for case in extra_cases:
    result=independent(*case)
    extra.append({k:result[k] for k in ('stages','center_norm_bound','scale_bound',
        'output_tolerance','dyadic_bits','Machin_terms_per_arctan','exponential_degree',
        'error_to_tolerance_ratio')})

lo=lambda x:x-x**3/3
hi=lambda x:lo(x)+x**5/5
pl=16*lo(Q(1,5))-4*hi(Q(1,239))
pu=16*hi(Q(1,5))-4*lo(Q(1,239))
assert Q(3)<pl<pu<A
# Exact first-step tail-ratio bound supporting universal termination.
assert A/8<Q(1,2)
assert te(7)/te(6)<A/8
assert pe(3)/pe(2)<Q(1,25)
assert all(hashlib.sha256((AUTHOR/n).read_bytes()).hexdigest()==sha for n,sha in PINS.items())

out={'status':'PASS: exact bounded independent reconstruction; no FFT or coefficients',
 'author_pins':PINS,'full_author_rows_matched':len(rows),
 'independent_extra_cases':extra,'pi_center_lower':str(pl),'pi_center_upper':str(pu),
 'universal_termination':'Established by the separately reviewed mathematical argument, not sampling.',
 'author_files_unchanged':True,
 'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
HERE.joinpath('review_auxiliary_fft_rounding_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS: all 4 complete author rows matched; 8 additional boundary cases; no FFT')
