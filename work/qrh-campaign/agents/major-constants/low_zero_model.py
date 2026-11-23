"""Exploratory first-zero-gap and conductor-weight model. No certified analytic bounds."""
import json, math
X=4.9e26
budget=.011670451
I_quad=52.11714704834 # uncertified quadrature, averaging_model.py
I_source=49*7.78
Q=300000
phi=list(range(Q+1)); mu=[1]*(Q+1)
for p in range(2,Q+1):
    if phi[p]==p:
        for n in range(p,Q+1,p):
            phi[n]-=phi[n]//p
            mu[n]*=-1
        for n in range(p*p,Q+1,p*p): mu[n]=0
mods=[q for q in range(1,Q+1) if mu[q] and (q if q%2==0 else 2*q)<=Q]
# Conditional error profile: for each primitive conductor c, normalized error <= e0/sqrt(c).
# For squarefree q the exact Gauss weights cancel c and sum of primitive counts is phi(q).
# Principal character contribution is e0^2/phi(q)^3 after including |mu/phi|^2.
weights={
 'all':sum(1/phi[q]**2 for q in mods),
 'moduli_greater_than_2':sum(1/phi[q]**2 for q in mods if q>2),
 'all_principal_characters':sum(1/phi[q]**3 for q in mods),
 'all_nonprincipal_characters':sum((phi[q]-1)/phi[q]**3 for q in mods),
 'q3_q6_nonprincipal':.25,
}
for d in [10,100,1000,10000,100000]:
    weights['moduli_at_least_'+str(d)]=sum(1/phi[q]**2 for q in mods if q>=d)
C_sob=8.239*math.sqrt(2e8)
e_sob=C_sob*X**(-1/8)
J_results={}
for J in [8.79,9,10]:
    B=2*J+17.41053338496
    A=budget**2/(4*B)
    J_results[str(J)]={'A_cap':A,'V_cap':budget**2/(4*J),
        'C_cap_q1q2_quad':math.sqrt(A/(2*I_quad))*X**(1/8),
        'C_cap_q3q6_nonprincipal_quad':math.sqrt(A/(.25*I_quad))*X**(1/8),
        'C_cap_after_all_principals_removed_quad':math.sqrt(A/(weights['all_nonprincipal_characters']*I_quad))*X**(1/8)}
result={'warning':'Conditional model and uncertified floating point only. A failed upper estimate is not a lower bound or impossibility theorem.',
 'I_source_upper':I_source,'I_quad_uncertified':I_quad,'squarefree_Qset_count':len(mods),
 'weights_with_full_delta_line_upper':weights,
 'sobolev_C_with_Z_equals_1_model':C_sob,'sobolev_normalized_e0':e_sob,
 'sobolev_A_q3q6_nonprincipal_quad_model':e_sob**2*.25*I_quad,
 'gap_14_exponential_ratio':{str(d):math.exp(-14*min(.28/(1+abs(d)),.005)) for d in [0,49,100,1000,600000]},
 'gap_14_sobolev_ratio_q1':math.sqrt((1e8-14)/1e8),
 'J_budgets':J_results}
print(json.dumps(result,indent=2))
