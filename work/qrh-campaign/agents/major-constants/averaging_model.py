"""Exploratory averaging targets and modulus-one smoothing integral.
Binary floating point and composite Simpson quadrature, without error certificate.
No output proves an analytic estimate or a Goldbach threshold.
"""
import json
import math
X=4.9e26
Y=X/49
J=8.79
B=2*(J+.640208*13.59756)
budget=1.314*.800689-49*2.03e-5*2.85-1.0376
A_cap=(budget/2)**2/B
V_cap=(budget/2)**2/J

def nodes(n):
    result=[]
    for a,b in [(.25,.5),(.5,1)]:
        h=(b-a)/n
        for i in range(n+1):
            t=a+i*h
            weight=h/3*(1 if i in [0,n] else 4 if i%2 else 2)
            eta=4*max(math.log(2)-abs(math.log(2*t)),0)
            result.append((t,weight*eta))
    return result

def etaU_sq_integral(n):
    pts=nodes(n)
    value=0.0
    for r,wr in pts:
        for s,ws in pts:
            value+=wr*ws*r*r*s*s/(r*r+s*s)**2.5
    return 3*math.sqrt(math.pi/2)*value

values={str(n):etaU_sq_integral(n) for n in [50,100,200,400]}
I=49*values["400"]
delta_max=600000
fourier_tail_cap=2*1.016**2*49**4/(3*delta_max**3)
results=dict(
    warning="Exploratory only. Simpson error has not been certified.",
    x=X,y=Y,J=J,B=B,budget=budget,
    equal_budget_Aplus_cap=A_cap,equal_budget_Vstar_cap=V_cap,
    equal_budget_Astar_plus_cross_cap=V_cap/2,
    etaU_L2_squared_quadrature=values,
    q1_full_Fourier_weight_integral=I,
    q1_weight_truncation_tail_cap=fourier_tail_cap,
    q1_plus_sup_error_cap_using_existing_bound=math.sqrt(A_cap/(49*7.78)),
    q1_plus_sup_error_cap_using_quadrature=math.sqrt(A_cap/I),
    q1_QRH_C_cap_using_existing_bound=math.sqrt(A_cap/(49*7.78))/X**(-1/8),
    q1_QRH_C_cap_using_quadrature=math.sqrt(A_cap/I)/X**(-1/8),
    QRH_zero_Aplus_cap=A_cap*X**.25,
    QRH_zero_Astar_cap=V_cap/2*Y**.25,
    log_x=math.log(X),largeConductor_lower_limit_for_A_zero=math.log(X)**5,
    max_B_for_Q300000=math.log(math.sqrt(X)/300000)/math.log(math.log(X)),
    raw_sieve_scale_at_length_x=.640208*math.log(X),
    high_conductor_model_coefficient=49*7.78*.640208*math.log(X))
print(json.dumps(results,indent=2))

