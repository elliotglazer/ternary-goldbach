"""Exact scalar enumeration for base-gap finite-family implication; no zeros proved."""
from fractions import Fraction as F
from math import isqrt,gcd,factorial
from pathlib import Path
import json
P=Path(__file__).resolve().parent;M=300000;R=M//2;S=10**12
phi=list(range(M+1));mu=[1]*(M+1);spf=list(range(M+1));n=[1]*(M+1)
for p in range(2,M+1):
    if phi[p]==p:
        for k in range(p,M+1,p):
            phi[k]-=phi[k]//p;mu[k]*=-1
            if spf[k]==k:spf[k]=p
        for k in range(p*p,M+1,p*p):mu[k]=0
for c in range(2,M+1):
    p=spf[c];v=c;a=0
    while v%p==0:v//=p;a+=1
    n[c]=n[v]*(p-2 if a==1 else p**(a-2)*(p-1)**2)
def ceildiv(a,b):return (a+b-1)//b
def H(q,u=1200000):return max(250,ceildiv(242*u,7*q))
def N(h):return ceildiv(20000*h+69600,87)
def Hp(c):return 200+max(1000,ceildiv(844800000,7*(2*c if c%2 else c)))
def exp_lower(t):return sum((t**j/factorial(j) for j in range(200)),F(0))
YP=F(75,10**13)
assert YP**200*(10**25)**89>1
# Recomputed etaU tail for d<=600000, without the plus bandlimit shift.
G=3+F(600000)*F(10,27)
assert 803*G<180000000
assert exp_lower(F('0.1065')*22**2)>F('.588')*22**2/F('2e-20')
EBnum=2*F('.892')*250*(5*250+2500)
assert exp_lower(F('.1598')*250)>EBnum/F('1e-11')
assert 1333**8<10**25
assert (2*180000000*F('2e-20')+F('1e-11'))/1333<F('2e-14')
theta=F(4,10**7)
V=900*8*(187*2/theta+F('2.6')*2/theta**2)
assert F('0.28')/600001>theta
assert V/(3*10**37)+F(400*600,10**25)<F('1e-18')
EPS=F('3e-14');REM=F('2e-9');CAP=F('.04712')
assert exp_lower(F('.69315'))>2
assert 4*F('.69315')**2<F('1.922')
SHARP=F(13,8)
assert F('.555')*F('1.922')+F('.445')*F('1.2534')<SHARP
Wnum=[0]*(M+1);W2=[0]*(M+1);height_checks=0
for c in range(1,M+1):
    if not n[c]:continue
    sr=isqrt(c*S*S)
    if sr*sr<c*S*S:sr+=1
    assert sr*sr>=c*S*S
    for r in range(1,M//c+1):
        m=c*r
        if mu[r] and gcd(c,r)==1:
            Wnum[m]+=n[c]*sr;W2[m]+=n[c]*c
            if m%2==0 or m<=R:
                q=m//2 if m%2==0 else m
                assert H(q)<=Hp(c)
                height_checks+=1
fail=[];sharp_fail=[];rows=[];worst=(F(0),0);max_pass=(F(0),0);sharp_max_pass=(F(0),0)
for q in range(1,R+1):
    m=2*q
    assert W2[m]==phi[m]**2 and phi[m]<=q
    if q%2:
        assert Wnum[q]==Wnum[m] and phi[q]==phi[m] and abs(mu[q])==abs(mu[m])
        assert W2[q]==phi[q]**2
    w=F(Wnum[m],S*phi[m])
    dm=F(600000,49*q)
    main=F(abs(mu[m]),phi[m])*min(F('1.2534'),F('1.016')/dm**2)
    low=4*N(H(q))*YP*w
    bound=main+low+(1+w)*REM+w*EPS
    sharp_bound=main+SHARP*N(H(q))*YP*w+(1+w)*REM+w*EPS
    if sharp_bound>CAP:sharp_fail.append(q)
    elif sharp_bound>sharp_max_pass[0]:sharp_max_pass=(sharp_bound,q)
    if bound>worst[0]:worst=(bound,q)
    if bound>CAP:fail.append(q)
    elif bound>max_pass[0]:max_pass=(bound,q)
    if q<=50 or q in (90090,120120,149993,150000):
        # Largest integer u-prefix certified by the same envelope.
        lo=0;hi=1200000
        while lo<hi:
            mid=(lo+hi+1)//2
            bb=main+4*N(H(q,mid))*YP*w+(1+w)*REM+w*EPS
            if bb<=CAP:lo=mid
            else:hi=mid-1
        slo=0;shi=1200000
        while slo<shi:
            mid=(slo+shi+1)//2
            bb=main+SHARP*N(H(q,mid))*YP*w+(1+w)*REM+w*EPS
            if bb<=CAP:slo=mid
            else:shi=mid-1
        rows.append(dict(q=q,original_m=m,H=H(q),N=N(H(q)),
            W_upper=str(w),W_diagnostic=float(w),main_upper=str(main),
            total_upper=str(bound),diagnostic=float(bound),passes=bound<=CAP,
            u_prefix_integer=lo,sharp_u_prefix_integer=slo,
            sharp_total_upper=str(sharp_bound),sharp_diagnostic=float(sharp_bound)))
    assert q<40 or bound<CAP

# Independent easy bound using W<=sqrt(q), valid at every q>=40.
# H<=A/q+1, N<=20000H/87+801.
A=F(290400000,7)
a=4*YP*F(20000,87)*A
b=4*YP*(F(20000,87)+801)
assert b*R<a # a/sqrtq+b*sqrtq decreases throughout the interval.
assert F('6.32')**2<40 and 388**2>R
simple=a/F('6.32')+b*F('6.325')+F('.000481')+389*REM+388*EPS
# sqrt40<6.325, handled separately in the increasing small b term.
assert F('6.325')**2>40 and simple<CAP
out=dict(status='Exact conditional scalar certificate only; finite .555 and analytic bridges remain open.',
    reduced_q_count=R,source_pin='23b2d68ca344203d4384e0aff7affa4ec034bef9',
    family_profile='original shared Hp(c), beta111/200',height_inclusion_checks=height_checks,
    exact_gauss_square_identity_all_moduli=True,uniform_ghat_floor=str(CAP),
    full_gap_failures=fail,last_failure=max(fail),passing_reduced_q_count=R-len(fail),
    worst_bound_diagnostic=float(worst[0]),worst_q=worst[1],
    maximum_passing_bound_diagnostic=float(max_pass[0]),maximum_passing_q=max_pass[1],
    sharp_transform_cap=str(SHARP),sharp_full_gap_failures=sharp_fail,
    sharp_passing_reduced_q_count=R-len(sharp_fail),
    sharp_maximum_passing_bound_diagnostic=float(sharp_max_pass[0]),sharp_maximum_passing_q=sharp_max_pass[1],
    simple_q_ge_40_bound=str(simple),simple_q_ge_40_diagnostic=float(simple),
    normalized_primitive_tail_cap='2e-14',normalized_contour_zero0_cap='1e-18',
    primitive_residual_allowance='3e-14',noncoprime_allowance='2e-9',
    samples=rows)
P.joinpath('resume_base_gap_finite_family_20261111.json').write_text(json.dumps(out,indent=2))
print(json.dumps({k:v for k,v in out.items() if k!='samples'},indent=2))
print('small q:',[(r['q'],r['diagnostic'],r['u_prefix_integer']) for r in rows if r['q']<=40])
print('sharp small q:',[(r['q'],r['sharp_diagnostic'],r['sharp_u_prefix_integer']) for r in rows if r['q']<=8])
