"""Weighted-zero mass arithmetic. No analytic or floating-point certification.
K is a hypothetical norm-to-mass constant BEFORE Gauss reconstruction.
"""
import json, math
X=4.9e26; Y=X/49; Q=300000; R=Q//2; ACAP=9e-7; BCAP=1.65e-6
phi=list(range(Q+1)); mu=[1]*(Q+1); nprim=[1]*(Q+1)
for p in range(2,Q+1):
    if phi[p]==p:
        for n in range(p,Q+1,p):
            phi[n]-=phi[n]//p; mu[n]*=-1
        for n in range(p*p,Q+1,p*p): mu[n]=0
# Primitive count is phi * product_(p||n) (p-2)/(p-1)
# * product_(p^2|n) (p-1)/p, evaluated integrally prime-power by prime-power.
spf=list(range(Q+1))
for p in range(2,math.isqrt(Q)+1):
    if spf[p]==p:
        for n in range(p*p,Q+1,p):
            if spf[n]==n: spf[n]=p
for n in range(2,Q+1):
    p=spf[n]; m=n; k=0
    while m%p==0: m//=p; k+=1
    nprim[n]=nprim[m]*(p-2 if k==1 else (p-1)**2*p**(k-2))

def character_mass_square_sum(c):
    if c==1: return .07**2
    diff=mu[c]+(mu[c//2] if c%2==0 else 0)
    ne=(nprim[c]+diff)//2; no=(nprim[c]-diff)//2
    assert ne>=0 and no>=0 and ne+no==nprim[c]
    me=.5*math.log(c)-.29; mo=.5*math.log(c)+.017
    return ne*me*me+no*mo*mo

masssq=[0.]+[character_mass_square_sum(c) for c in range(1,Q+1)]
rows=[]; weighted={}
for c in range(1,R+1,2):
    if not mu[c]: continue
    g=sum(2*c/phi[r]**3 for r in range(c,R+1,2*c) if mu[r])
    weighted[c]=g*masssq[c]
M2=sum(weighted.values()); principal=weighted[1]
for lo in [1]+[2**k for k in range(1,18)]:
    hi=min(2*lo,R+1)
    if lo>R: break
    z=sum(v for c,v in weighted.items() if lo<=c<hi)
    rows.append(dict(lo=lo,hi_exclusive=hi,weighted_mass_square=z,
       A_if_full_weighted_kernel_K1=X**(-.25)*z))
# Exact imprimitive support: q=c*r, r squarefree, gcd(c,r)=1.
T=[0.]*(Q+1)
for c in range(1,Q+1):
    if masssq[c]==0: continue
    for r in range(1,Q//c+1):
        if mu[r] and math.gcd(c,r)==1:
            q=c*r; T[q]+=c*masssq[c]/phi[q]
T2=sum(t*t for t in T[1:]); crosscoef=(X*Y)**(-.25)*T2
res={
 'status':'Exploratory arithmetic only. Character mass identity and norm inequalities require proofs. K85 is valid as a proposed local q1 bound only, not a character-family or weighted-global bound.',
 'x':X,'y':Y,'weighted_mass_square_total':M2,'weighted_mass_square_principal':principal,
 'A_coefficient_for_full_weighted_kernel_K_squared':X**(-.25)*M2,
 'K_full_weighted_needed_for_Acap':math.sqrt(ACAP/(X**(-.25)*M2)),
 'K_full_weighted_needed_principal_only':math.sqrt(ACAP/(X**(-.25)*principal)),
 'local_uniform_unweighted_K_needed_using_Fmax':math.sqrt(ACAP/(1.2534**2*X**(-.25)*M2)),
 'local_q1_K85_bound_summed_squarefree_principal_moduli':1.2534**2*X**(-.25)*principal*85**2,
 'local_K85_if_hypothetically_all_characters':1.2534**2*X**(-.25)*M2*85**2,
 'cross_mass_T2_sum_all_moduli':T2,
 'cross_coefficient_if_joint_normalized_kernel_product_integral_one':crosscoef,
 'joint_kernel_product_integral_cap_if_all_BCAP_spent_on_cross':BCAP/crosscoef,
 'conductor_bins':rows,
 'definitions':{'K_full_weighted':'||U(-delta/49) times normalized zero sum||_L2 / mass; at each required arc',
 'cross_Tq':'sum_psi |tau_q(psi)|^2 M_conductor(psi)^2 / phi(q)',
 'mixed_kernel_product':'integral kPlus(delta)^2*kStar(delta/49)^2 ddelta, both envelopes normalized per unit mass'}
}
print(json.dumps(res,indent=2))
