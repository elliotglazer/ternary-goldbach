"""Independent exact low-order algebra audit; no analytic/numeric Gamma calls."""
from fractions import Fraction as Q
from math import comb
from pathlib import Path
import hashlib,json

checks={}
def check(k,v):
    assert v,k
    checks[k]=True
def add(a,b):return [sum(p[i] if i<len(p) else Q(0) for p in (a,b)) for i in range(max(len(a),len(b)))]
def mul(a,b):
    c=[Q(0)]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]+=x*y
    return c
def reflection(a):
    return [sum(a[j]*comb(j,i)*(-1)**i for j in range(i,len(a))) for i in range(len(a))]
def derivative(a):return [i*a[i] for i in range(1,len(a))]

B2=[Q(1,6),Q(-1),Q(1)]
B3=[Q(0),Q(1,2),Q(-3,2),Q(1)]
check('derivative_B3_equals_3B2',derivative(B3)==[3*v for v in B2])
check('B3_endpoints_zero',B3[0]==sum(B3)==0)
check('B3_reflection',reflection(B3)==[-v for v in B3])
check('B2_continuous_periodic_endpoints',B2[0]==sum(B2)==Q(1,6))
check('B3_factorization_left_half',mul(mul([0,1],[Q(1,2),-1]),[1,-1])==B3)
check('quadratic_complete_square',add([Q(1,16)],[-v for v in mul([-Q(1,4),1],[-Q(1,4),1])])==[0,Q(1,2),-1])
check('B3_simple_bound',Q(1,4)*Q(1,2)==Q(1,8))
# Differentiate -e^(-u*x)*(B2/u+B2prime/u²+B2second/u³): cancellations
# leave e^(-u*x)*B2 because B2third=0.
check('B2_third_derivative_zero',derivative(derivative(derivative(B2)))==[])
d=derivative(B2);dd=derivative(d)
check('Laplace_boundary_at_zero',[B2[0],d[0],dd[0]]==[Q(1,6),Q(-1),Q(2)])
check('Laplace_boundary_at_one',[-sum(B2),-sum(d),-sum(dd)]==[Q(-1,6),Q(-1),Q(-2)])
# k=1/12-u L_B2/2: its coefficients after cancellation are
# (1+2/(e^u-1))/(2u)-1/u².
check('constant_cancellation',Q(1,12)-Q(1,2)*Q(1,6)==0)
check('author_split_R_constant',Q(1,3)*Q(1,8)*Q(3,2)*4==Q(1,4))
check('independent_sharper_R_constant',Q(1,3)*Q(1,16)*4==Q(1,12))
check('leading_phase_cancellation',Q(1,16)+Q(1,8)-Q(1,6)==Q(1,48))
check('elementary_error_sum',Q(1,128)+Q(1,96)+Q(1,24)==Q(23,384))
t=Q(1500)
check('author_phase_enlargement_all_t_ge_1500',Q(1,4)+Q(23,384)/t<Q(13,50))
check('optional_sharper_phase',Q(1,12)+Q(23,384)/t<Q(1,10))
check('weak_phase_one_over40t',Q(1,48)+Q(13,50)/t<Q(1,40))
check('restricted_factor80_error',80*Q(13,50)/t**2<Q(1,100000))
check('global_phase_to_K0_coefficient',Q(47,100)+4*Q(13,50)/t<Q(471,1000))
check('safe_global_K0_049',Q(47,100)+4*Q(13,50)/t<Q(49,100))
out=dict(status='PASS_INDEPENDENT_EXACT_ALGEBRA_ONLY',checks=checks,
    check_count=len(checks),lower_t=str(t),author_phase_error_at1500=str(Q(13,50)/t**2),
    global_K0_coefficient_upper=str(Q(47,100)+4*Q(13,50)/t),
    script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    scope='Polynomial and scalar identities only; analytic integrals, normalized Binet and Gabcke remainder are not proved by this script.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
