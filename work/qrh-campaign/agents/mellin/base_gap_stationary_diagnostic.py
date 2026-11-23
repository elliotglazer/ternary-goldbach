"""Stationary-height diagnostics, not a bound on actual zeta zero sums.

The contour values evaluate a proved-formula candidate envelope in floating
point. The stationary-phase/density model is explicitly asymptotic and
counterfactual: it places the zero density at beta=7/8. Neither it nor the
quadrature is a certificate or an assertion about actual zero locations.
"""
import math

def H(s):
    A=4*((1-2**(-s))/s)**2 if s else 4*math.log(2)**2
    return A*2**(s/2)*math.gamma(1+s/2)

def contour(D,tau):
    theta=min(.28,tau/(4*math.pi**2*D**2))
    c=math.cos(2*theta); b=2*math.pi*D*math.sin(theta)
    e=-theta*tau+b*b/(2*c)
    term0=(1/c+b/c**2)*math.exp(-theta*tau)
    term1=(b/c+1/c+b*b/c**2)*math.sqrt(2*math.pi/c)*math.exp(e)
    ibp=9*1.2534/(2*math.pi*D)**2*(8*(tau+.875)*(tau+1.875)+2*tau+7.625)
    return min(2*1.2534,ibp,2*(term0+term1))

def BPlog(T):
    # log of exact source BPz2 (no overflow at the heights used here)
    b=9200*(T+22)*(1.25*(T+11))**9+20*(T+22)**3*(1.25*(T+11))**2
    return math.log(b/.355)

sigma=1.375
hs=H(sigma)
eps=1e-5
dh=(H(sigma+eps)-H(sigma-eps))/(2*eps)
print('MODEL_MOMENT',hs,'MODEL_LOG_MOMENT',dh)
for Q in [1,101]:
    for side,D in [('min',600000/(49*Q)),('max_limit',600000/Q)]:
        model=math.sqrt(D)*(hs*math.log(D)+dh)
        gauss_weight=1 if Q==1 else (Q-2)*math.sqrt(Q)/(Q-1)
        print('CASE',Q,side,'delta',D,'model_single_character',model,
              'model_primitive_weighted',gauss_weight*model,'target',79)
        for u in [.25,.5,1,2,4,8]:
            tau=2*math.pi*D*u
            print('  HEIGHT',tau,'u',u,'contour_envelope',contour(D,tau),
                  'source_count_per_3.48',BPlog(tau)/math.log(10/2.7))

# Dimensionless continuous proxy for the source-window sum at Q=1, min delta.
# This is only a scale diagnostic; exact finite window suprema would be needed.
D=600000/49
n=20000; du=20/n
total=0.
for j in range(n):
    u=(j+.5)*du; tau=2*math.pi*D*u
    total+=contour(D,tau)*BPlog(tau)/math.log(10/2.7)/3.48*2*math.pi*D*du
print('Q1_MIN_SOURCE_COUNT_CONTOUR_CONTINUOUS_PROXY',total)
