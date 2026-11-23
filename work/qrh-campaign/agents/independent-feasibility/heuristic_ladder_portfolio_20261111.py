"""Exact geometry and rational arithmetic inside explicitly hypothetical probability models.
No candidate integers are tested for primality. No transcendental evaluator is called.
"""
from fractions import Fraction as F
from itertools import combinations
from math import prod,lcm
from pathlib import Path
import json

small=[2,3,5,7,11,13,17,19,23,29,31]
P=prod(small); fs=[P*m for m in [160,162,165,168,175,180]]
R=prod((F(p,p-1) for p in small),start=F(1))
F2=2**45
terms=[((-1)**(len(s)+1),lcm(*s)) for j in range(1,7) for s in combinations(fs,j)]
period=lcm(*fs)
union=sum(sign*(period//m) for sign,m in terms)
assert period==1000716621552648000 and union==161084
assert all(f*f>10**27 for f in fs)
def floor(q):return q.numerator//q.denominator
def ceil(q):return -floor(-q)
def decimal_box(q,digits=18):
    scale=10**digits
    return {'lower_scaled_integer':floor(q*scale),'upper_scaled_integer':ceil(q*scale),'scale':scale}
def miss_box(nlo,nhi,rho):
    # The interval log(x) in [62,63] is a stipulated top-range scenario.
    lo=(1-rho/62)**nhi; hi=(1-rho/63)**nlo
    return lo,hi
scenarios=[]
for B,W,S,K in [(10**16,128,157,181029996372),(2*10**16,256,313,90804183483)]:
    D=(W-1)*F2
    assert (S+W-1)*F2+2<=B
    n1=D//fs[0]; n1hi=n1+1
    ulo=max(0,sum(sign*(D//m if sign>0 else D//m+1) for sign,m in terms))
    uhi=sum(sign*(D//m+1 if sign>0 else D//m) for sign,m in terms)
    for name,nlo,nhi,rho in [('fixed_proth',W,W,F(2)),('same_window_one_smooth',n1,n1hi,R),('same_window_six_smooth',ulo,uhi,R)]:
        stress=[]
        for eta,cluster in [(F(1),1),(F(1,2),1),(F(1,4),1),(F(1),4)]:
            # cluster=4 is a hypothetical perfect-block correlation stress, not a theorem.
            lo,hi=miss_box(nlo//cluster,(nhi+cluster-1)//cluster,eta*rho)
            stress.append({'density_multiplier':str(eta),'cluster_size':cluster,
                'model_failure_lower':decimal_box(lo),'model_failure_upper':decimal_box(hi),
                'expected_failures_K_lower':floor(K*lo),'expected_failures_K_upper':ceil(K*hi)})
        scenarios.append({'B':B,'geometry':name,'width':D,'K_fixed':K,'candidate_count_lower':nlo,'candidate_count_upper':nhi,'intensity_numerator':str(rho),'stress':stress})
    H=(B-2)//F2
    lo,hi=miss_box(H,H,F(2))
    rho=F(2,63);r=1-rho;miss=r**H
    deficit=r/rho-H*miss/(1-miss)
    tests=(1-miss)/rho
    advance=F2*(H-deficit)
    scenarios.append({'B':B,'geometry':'adaptive_proth_same_F_full_interval','H':H,
        'model_failure_lower':decimal_box(lo),'model_failure_upper':decimal_box(hi),
        'conditional_mean_deficit_at_log63':decimal_box(deficit,8),
        'mean_raw_tests_at_log63':decimal_box(tests,8),
        'conditional_mean_progress_at_log63':decimal_box(advance,0)})

# Collision-aware average intensities. These are residue-lattice facts, not prime facts.
smooth_density=F(union,period)
naive=sum((F(1,f) for f in fs),F(0))
cross=sum((sign*F(1,lcm(F2,m)) for sign,m in terms),F(0))
assert 0<cross<smooth_density<naive
out={'scope':'planning assumptions; probability bounds are conditional model arithmetic, not empirical or prime theorems',
 'R31':str(R),'proth_survival_fraction_for_same_small_wheel':str(2/R),
 'smooth_single_base_success_among_uniform_units':str(1/R),
 'smooth_remaining_success_conditioned_quadratic_nonresidue':str(2/R),
 'Fs':fs,'period':period,'union_per_period':union,'smooth_union_density':str(smooth_density),
 'naive_smooth_density':str(naive),'collision_fraction':str(1-smooth_density/naive),
 'cross_proth_smooth_density':str(cross),'scenarios':scenarios}
path=Path(__file__).with_suffix('.json')
with path.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS_EXACT_MODEL_ARITHMETIC','R31':str(R),'scenarios':len(scenarios)}))
