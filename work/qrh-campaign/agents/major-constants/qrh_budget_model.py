"""Exploratory QRH error budgets at ternary-goldbach commit 23b2d68.
Floating-point arithmetic only. No output is a certified analytic bound.
All hypothetical constants refer to primitive-character errors after subtracting
the principal Fourier main term. The model does not prove these estimates.
"""
import json
import math

X = 4.9e26
Y = X / 49
Q = 300000
main = 1.314 * 0.800689
fixed = 49 * 2.03e-5 * 2.85
rho_coeff = 8.79 * 49 / 9 + 4.5 * 7.78 * 2.85 + 49 / 9 * 0.640208 * 13.59756
u_coeff = 8.79
budget = main - fixed - 1.0376
rho0, u0 = 8.85e-7, 3.67e-6

def hypot_uniform(C, q=Q):
    # |E_plus| <= C*x^(7/8), |E_star| <= C*y^(7/8).
    # Existing sum_residual_le triangle loss and conductor Gauss bound.
    plus = C * X**(-1/8)
    star = C * Y**(-1/8)
    rho = math.sqrt(3 * (q + 1)) * plus
    u = math.sqrt(3 * (q + 1)) * star
    return dict(C=C, rho=rho, u=u,
                dynamic_loss=rho_coeff*rho + u_coeff*u,
                major_if_other_bounds_survive=main-fixed-rho_coeff*rho-u_coeff*u)

# A weighted character estimate |E| <= C*z^(7/8)/sqrt(conductor)
# avoids growth in conductor. Principal error still contributes to residual.
def hypot_weighted(C):
    rho = math.sqrt(6)*C*X**(-1/8)
    u = math.sqrt(6)*C*Y**(-1/8)
    return dict(C=C,rho=rho,u=u,
                dynamic_loss=rho_coeff*rho+u_coeff*u,
                major_if_other_bounds_survive=main-fixed-rho_coeff*rho-u_coeff*u)

# Reproduce exact width sums of Qset(150000).
# qt(q)=2q for odd q and q for even q.
phi = list(range(Q+1))
mu = [1]*(Q+1)
for p in range(2,Q+1):
    if phi[p] == p:
        for n in range(p,Q+1,p):
            phi[n] -= phi[n]//p
            mu[n] *= -1
        for n in range(p*p,Q+1,p*p):
            mu[n] = 0
width_sum = weighted_width_sum = conductor_width_sum = 0.0
count=0
for q in range(1,Q+1):
    qt=2*q if q%2 else q
    if qt>Q:
        continue
    count+=1
    width=2400000/qt
    mphi=mu[q]**2/phi[q]
    width_sum+=width
    weighted_width_sum+=width*mphi
    conductor_width_sum+=width*q

def l2_model(C, weighted=False,t=1e-4):
    # Exact width version of L2Major.Jq_bounds Steps B/C.
    # Ignore negligible coprime-removal errors; include them in any proof.
    f=C*X**(-1/8)
    ep_integral=(width_sum if weighted else conductor_width_sum)*f*f
    principal_integral=weighted_width_sum*f*f
    return dict(C=C,weighted=weighted,t=t,
                lower=(1-t)**2*0.6392*13.597558-(1-t)/t*principal_integral,
                upper=(1+t)**2*0.640208*13.59756+
                      (1+t)*(1+1/t)*principal_integral+(1+t)*ep_integral)

uniform_max=budget/hypot_uniform(1)["dynamic_loss"]
weighted_max=budget/hypot_weighted(1)["dynamic_loss"]
report = dict(
    source_commit="23b2d68ca344203d4384e0aff7affa4ec034bef9",
    warning="Exploratory floating-point models. Analytic assumptions unproved.",
    x=X,y=Y,q=Q,x_minus_eighth=X**(-1/8),y_minus_eighth=Y**(-1/8),
    major_main=main,fixed_smoothing_loss=fixed,
    rho_coefficient=rho_coeff,u_coefficient=u_coeff,dynamic_budget=budget,
    current_major=main-fixed-rho_coeff*rho0-u_coeff*u0,
    max_rho_with_current_u=(budget-u_coeff*u0)/rho_coeff,
    max_u_with_current_rho=(budget-rho_coeff*rho0)/u_coeff,
    exact_output_coefficient_targets=dict(
        uniform_plus=4.25e-7/(math.sqrt(Q)*X**(-1/8)),
        uniform_star=1.49e-6/(math.sqrt(Q)*Y**(-1/8)),
        weighted_plus=4.25e-7/X**(-1/8),
        weighted_star=1.49e-6/Y**(-1/8),
        principal_plus=2.83e-7/X**(-1/8)),
    basegap_uniform_target=((.0121-.01125-549*2e-9)/548)/Y**(-1/8),
    major_only_hypothetical_C_targets=dict(uniform=uniform_max,weighted=weighted_max),
    width_sums=dict(count=count,width=width_sum,principal_weight=weighted_width_sum,
                    conductor_weight=conductor_width_sum),
    hypothetical_uniform=[hypot_uniform(c) for c in [1,1e-2,1e-4]],
    hypothetical_weighted=[hypot_weighted(c) for c in [1,.01]],
    l2_hypothetical=[l2_model(c,w) for c in [1,.01,.0001] for w in [False,True]],
    log10_x_needed_for_existing_plus_outputs_uniform_C1=
        8*math.log10(math.sqrt(Q)/4.25e-7),
    log10_y_needed_for_existing_star_outputs_uniform_C1=
        8*math.log10(math.sqrt(Q)/1.49e-6),
    log10_x_needed_for_existing_plus_outputs_weighted_C1=
        8*math.log10(1/4.25e-7),
    log10_x_needed_for_major_only_uniform_C1=math.log10(X)-8*math.log10(uniform_max),
    log10_x_needed_for_major_only_weighted_C1=math.log10(X)-8*math.log10(weighted_max),
    rectangle_sobolev_low_coefficient_per_Z=8.239*math.sqrt(2e8),
    rectangle_sobolev_weighted_error_at_X_per_Z=8.239*math.sqrt(2e8)*X**(-1/8))
print(json.dumps(report,indent=2))

