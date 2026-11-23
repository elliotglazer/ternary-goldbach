from pathlib import Path
import json, math
from fractions import Fraction as F
Q=300000
phi=list(range(Q+1)); mu=[1]*(Q+1); primes=[]
for p in range(2,Q+1):
    if phi[p]==p:
        primes.append(p)
        for n in range(p,Q+1,p): phi[n]-=phi[n]//p; mu[n]=-mu[n]
        for n in range(p*p,Q+1,p*p): mu[n]=0
main=[]
for q in range(1,Q+1):
    if q%2 and q>150000: continue
    lo=(600000 if q%2 else 1200000)/(49*q)
    bound=abs(mu[q])*min(1.2534,1.016/lo**2)/phi[q]
    main.append((bound,q,lo,phi[q]))
main.sort(reverse=True)
p=max(t for t in primes if t<=150000)
assert all(p % d for d in range(2, math.isqrt(p)+1))
d=600000/(49*p)
yfac=10**(-25/8)
low=F(3,5)*F(8,23)+F(13,100)*F(3,2)-2*F(22,7)**2*F(41,500)**2*F(135,64)
assert low>F(3,25)
assert F(12534,10000)*F(1016,1000)<F(1129,1000)**2
assert F(30030,5760)*F(1129,1000)*49/600000<F(481,1000000)
res={'status':'floating-point diagnostics except explicit Fraction certificates',
 'main_sup_paper_bound':.000481,'main_sieve_top':main[:10],
 'prime_cell':{'p':p,'q_also':2*p,'delta_lower':d,'delta_upper':600000/p,
 'primitive_character_count':p-2,'gauss_L1_weight':(p-2)*math.sqrt(p)/(p-1),
 'y_minus_one_eighth':yfac,'available_single_zero_K_ignoring_remainders':(.0121-.000481)/(((p-2)*math.sqrt(p)/(p-1))*yfac),
 'relaxed_K_ignoring_remainders':(.01398-.000481)/(((p-2)*math.sqrt(p)/(p-1))*yfac),
 'strict_total_weighted_zero_budget':(.0121-.000481)/yfac,
 'relaxed_total_weighted_zero_budget':(.01398-.000481)/yfac,
 'paper_transform_lower_bound':str(low),'safe_transform_lower_bound':.12,
 'one_allowed_zero_per_primitive_absolute_recipe_lower':.12*(p-2)*math.sqrt(p)/(p-1)*yfac},
 'main_paper_certificates':True,
 'domain_examples':[{'q':q,'delta_min':(600000 if q%2 else 1200000)/(49*q),'delta_max':(600000 if q%2 else 1200000)/q} for q in [1,2,3,5,101,1009,10007,p,2*p,300000]]}
out=Path('work/qrh-campaign/agents/zero-sum/base_gap_qrh_results.json')
out.write_text(json.dumps(res,indent=2),encoding='utf-8')
print(json.dumps(res,indent=2))
