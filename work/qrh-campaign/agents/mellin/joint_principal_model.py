"""Joint principal L2 research: exact rational mass bound and exploratory Gram data.
No transcendental quadrature result in this script is a certificate.
"""
import cmath,json,math,sys
from fractions import Fraction as F

def log_bounds(q,n=24):
    q=F(q); k=0
    while q>=2: q/=2; k+=1
    while q<1: q*=2; k-=1
    def base(q):
        z=(q-1)/(q+1)
        s=2*sum((z**(2*j+1)/F(2*j+1) for j in range(n)),F(0))
        e=2*z**(2*n+1)/(F(2*n+1)*(1-z*z))
        return s,s+e
    l,u=base(q); l2,u2=base(F(2))
    return (l+k*l2,u+k*u2) if k>=0 else (l+k*u2,u+k*l2)

def mass_certificate():
    prime=[True]*2001; prime[0]=prime[1]=False
    for p in range(2,45):
        if prime[p]:
            for j in range(p*p,2001,p): prime[j]=False
    primes=[p for p in range(2,2001) if prime[p]]
    H=sum((F(1,j) for j in range(1,1001)),F(0))
    gamma_lower=H-log_bounds(1001)[1]
    log_pi_lower=log_bounds(F(314159,100000))[0]
    prime_sum_lower=sum((log_bounds(p)[0]/(p*p-1) for p in primes),F(0))
    W=F(3,2)-log_pi_lower/2-gamma_lower/2-prime_sum_lower
    D2=sum((F(2*(-1)**k*math.comb(6,k)*2**(6-k),(6+k)**3) for k in range(7)),F(0))+F(1024,45045)
    assert W<F(7,100)
    assert D2<F(313,1000)**2
    return dict(status='exact rational inequalities; analytic identities and primality bridge still need Lean proofs',prime_count=len(primes),gamma_lower=float(gamma_lower),prime_sum_lower=float(prime_sum_lower),mass_upper=float(W),mass_margin=float(F(7,100)-W),beta_derivative_sq_upper=float(D2),energy_bound_85=float(F(85)**2*F(7,100)**2)/((4.9e26)**.25))

def gram_scan(N=512,K=128,log_grid=False):
    X=4.9e26; beta=.875; L=61; B=.626; epspair=.00313
    r=[2*j/N for j in range(1,N)]
    w=[(4 if j%2 else 2)*2/(3*N) for j in range(1,N)]
    a=[wi*(ri*(2-ri))**3*math.exp(-(ri-1)**2/2)*ri**(beta-1) for ri,wi in zip(r,w)]
    if log_grid:
        du=(math.log(2)+16)/N
        r=[math.exp(-16+du*j) for j in range(N)]
        w=[(1 if j==0 else 4 if j%2 else 2)*du/3*ri for j,ri in enumerate(r)]
        a=[wi*(ri*(2-ri))**3*math.exp(-(ri-1)**2/2)*ri**(beta-1) for ri,wi in zip(r,w)]
    d=[-4+8*j/K for j in range(K+1)]
    dw=[(1 if j in (0,K) else 4 if j%2 else 2)*8/(3*K) for j in range(K+1)]
    phases=[[cmath.exp(2j*math.pi*di*ri) for ri in r] for di in d]
    rows=[]
    heights=sorted(set([j/4 for j in range(241)]+[j for j in range(65,251,5)]+[2.39]))
    if log_grid:
        heights=[0,2.39,10,20,25,26,26.5,27,30,40,50,60,100,150,200,250]
    for gamma in heights:
        ar=[ai*cmath.exp(1j*gamma*math.log(ri)) for ai,ri in zip(a,r)]
        M=[sum(ari*pi for ari,pi in zip(ar,pp)) for pp in phases]
        diag=sum(wi*abs(mi)**2 for wi,mi in zip(dw,M))
        cross=sum(wi*M[i]*M[K-i] for i,wi in enumerate(dw))
        pairnorm=math.sqrt(2*diag+2*abs(cross))
        A=pairnorm+epspair
        maxbeta=A if A>=B/L else B/L*math.exp(-1+L*A/B)
        ratio=(gamma*gamma+(15/8)**2)/6*(maxbeta+1e-9)
        rows.append(dict(gamma=gamma,compact_phase_max_norm=pairnorm,beta_uniform_majorant_ratio=ratio))
    best=max(rows,key=lambda z:z['beta_uniform_majorant_ratio'])
    return dict(status='exploratory Simpson quadrature and discrete height scan; neither quadrature nor between-grid errors certified',N=N,K=K,log_grid=log_grid,maximum_sampled=best,selected=[z for z in rows if z['gamma'] in [0,2.39,10,20,25,26,27,30,40,50,60,100,150,200,250]])

def elementary_interval_certificate():
    # Compact contour + F(A) subadditivity for gamma >=75.
    B=F(626,1000); e=F(313,100000); L=F(61); c=F(225,64)
    q=1-L*e/B
    assert sum((q**j/math.factorial(j) for j in range(4)),F(0))>F(100,51)
    floor=B/L*F(51,100)
    assert sum((F(21,2)**j/math.factorial(j) for j in range(80)),F(0))>36000
    assert sum((F(23)**j/math.factorial(j) for j in range(100)),F(0))>10**9
    R=lambda t:(t*t+c)/6
    p75=F(262,36000)+F(1268)/(F(75)-F(352,7))**4
    p100=F(262,10**9)+F(1268)/(F(100)-F(352,7))**4
    upper75=R(F(75))*F(5658,1000)*p75+R(F(100))*(floor+F(1,10**9))
    upper100=R(F(100))*F(5658,1000)*p100+R(F(250))*(floor+F(1,10**9))
    mass=F(1255,2772)+F(1024,3003)
    assert 4*mass<F(18,10)**2
    low=R(F(16))*(F(18,10)+e+F(1,10**9))
    assert low<85 and upper75<66 and upper100<57
    # Explicit analytic disk bounds for the Gauss quadrature checker.
    qerr=F(2*5*10**18,2**104)/F(3,4)
    derr=F(2*8*10**90,2**360)/F(1,2)
    assert qerr<F(7,10**13) and derr<F(2,10**17)
    return dict(status='exact rational inequalities; compact contour and analytic quadrature lemmas still require proof',compact_ratio_0_16=float(low),compact_ratio_75_100=float(upper75),compact_ratio_100_250=float(upper100),u_gauss26_error=float(qerr),delta_gauss180_error=float(derr),remaining_gamma_cells=2750)

if __name__=='__main__':
    print(json.dumps(mass_certificate(),indent=2))
    print(json.dumps(elementary_interval_certificate(),indent=2))
    if '--mass-only' not in sys.argv:
        N=1024 if '--fine' in sys.argv else 512
        K=256 if '--fine' in sys.argv else 128
        log_grid='--log-grid' in sys.argv
        if log_grid: N=8192; K=256
        print(json.dumps(gram_scan(N,K,log_grid),indent=2))
