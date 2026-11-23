"""Uniform primitive Schar error; exact Gauss weights once. Conditional numerical models only."""
import math,json
X=4.9e26; Q=150000; A=.011670451**2/(4*(17.58+17.41053338496)); xp=X**(-.25)
phi=list(range(Q+1)); mu=[1]*(Q+1); prim=[1]*(Q+1)
for p in range(2,Q+1):
    if phi[p]==p:
        for n in range(p,Q+1,p):
            phi[n]-=phi[n]//p;mu[n]*=-1;prim[n]*=p-2
        for n in range(p*p,Q+1,p*p):mu[n]=0
cs=[c for c in range(1,Q+1,2) if mu[c]]
Fmax=1.2534; Iquad=52.11714704834
weights={name:{} for name in ['geometry','source_upper','optimistic_quadrature']}
for c in cs:
    sums=[0.,0.,0.]
    for r in range(c,Q+1,2*c):
        if not mu[r]:continue
        z=2*c*prim[c]/phi[r]**3
        sums[0]+=z
        sums[1]+=z*min(381.22,1.2e6/r*Fmax**2)
        sums[2]+=z*min(Iquad,1.2e6/r*Fmax**2)
    for name,v in zip(weights,sums):weights[name][c]=v
bins=[]
for lo in [1]+[2**k for k in range(1,18)]:
    hi=min(2*lo,Q+1)
    if lo>Q:break
    bins.append({'conductor_min':lo,'conductor_max_exclusive':hi,
        **{name:sum(v for c,v in data.items() if lo<=c<hi) for name,data in weights.items()}})
rows={}
rho=X**(-.125)
for name,data in weights.items():
    total=sum(data.values()); baseline=math.sqrt(A/(xp*total))
    if name=='geometry':continue
    running=0.; qs={}
    for C in [.1,.25,.5,1,2,5,10,25,50,100]:
        tail=total;cut=None;rem=None
        for c,v in sorted(data.items()):
            tail-=v
            bound=xp*C*C*(rho*rho*(total-tail)+tail)
            if bound<=A:
                cut=c;rem=bound;break
        qs[str(C)]={'min_conductor_cutoff_in_model':cut,'A_at_cutoff':rem,
                    'A_if_all_conductors_beta_le_3_4':xp*C*C*rho*rho*total}
    rows[name]={'total_weight':total,'principal_weight':data[1],
                'nonprincipal_weight':total-data[1],
                'uniform_C_cap':baseline,'all_certified_beta_3_4_C_cap':baseline/rho,
                'hybrid_infinite_height_cutoffs':qs}
# A hypothetical exponentially decreasing fraction of the total absolute zero envelope.
# Restrict delta to [-D,D] and give one quarter of A to the complement via Fourier t^-2.
geom=sum(weights['geometry'].values());tailconst=2*1.016**2*49**4/3
height=[]
for C in [.1,.25,.5,1,2,5,10,25]:
    D=(4*xp*C*C*geom*tailconst/A)**(1/3)
    a=min(.005,.28/(1+D))
    # Give three quarters A to interior, use source weight bound and certify every conductor.
    allowed=math.sqrt(.75*A/(xp*C*C*rows['source_upper']['total_weight']))
    frac=(allowed-rho)/(1-rho)
    T=None if frac<=0 else max(0,-math.log(min(1,frac))/a)
    height.append({'C':C,'twist_cutoff_D':D,'decay_rate_a':a,
                  'hypothetical_height_if_all_conductors_certified':T,
                  'warning':'Requires unproved relative exponential tail with constant C and no bandwidth shift.'})
result={'warning':'No analytic estimate certified. Primitive E_c means Schar error BEFORE reconstruction. All finite sums are floating point. Source-upper I_q bounds rely on stated source Fourier bounds; optimistic quadrature is uncertified.',
'primitive_uniform_profile':'|E_chi| <= C_c*x^(7/8)',
'weight_formula':'W_c=2*c*primitiveCount(c)*sum_{odd squarefree r<=150000,c|r} I_r/phi(r)^3',
'geometry_sum_direct':sum(2/phi[r] for r in cs),'geometry_sum_by_conductor':geom,
'A_cap':A,'x_minus_quarter':xp,'beta_3_4_amplitude_gain':rho,
'conductor_dyadic_bins':bins,'models':rows,'hypothetical_heights':height}
print(json.dumps(result,indent=2))
