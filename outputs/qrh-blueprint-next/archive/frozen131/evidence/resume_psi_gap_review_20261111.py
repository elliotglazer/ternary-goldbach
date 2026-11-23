"""Independent exact finite-grid design review; no prime data or Lean check."""
from fractions import Fraction as F
from pathlib import Path
import hashlib, json
from math import factorial, log

HERE=Path(__file__).resolve().parent
proposal=HERE.parent/'prime-estimates/resume_psi_finite_gap_20261111.py'
# Replay only the author's computation before its print/write footer.
ns={}
exec(compile(proposal.read_text().split('print(json.dumps')[0], str(proposal), 'exec'),ns)
assert ns['out']==json.loads(proposal.with_suffix('.json').read_text())
assert ns['D_seed']==10**9 and ns['D_log']==10**7
assert ns['out']['log_boxes_certified'] is False
assert ns['out']['missing_new_window_counts']==85721
assert ns['width_ratio']==F(1411,120000000)
assert ns['seed_ratio']+ns['width_ratio']==F(43338634094539,3*10**18)
A=10**9; B=16*10**14
grid=[A]
while grid[-1]<B:
    a=grid[-1]
    grid.append(min(B,(6001*a)//6000))
assert len(grid)==85722 and grid[-1]==B
assert all(A<=a<b<=B and 6000*(b-a)<=a for a,b in zip(grid,grid[1:]))
assert all(b-a>=1 for a,b in zip(grid,grid[1:]))
assert grid[-2]<B and B-grid[-2]<=grid[-2]//6000
digest=hashlib.sha256(''.join(f'{n}\n' for n in grid).encode()).hexdigest()
assert digest==ns['out']['grid_sha256_ascii_lines']

epsilon=F(1,24000); power=F(17,360000); width=F(1,6000)
upper=width+(epsilon+power)*(1+width)
lower=width+epsilon
assert upper==F(17251,67500000)<F(1,3600)
assert lower==F(1,4800)<F(1,3600)
assert F('1.4262')/31622 < power
assert 31622**2<A

def exp_bounds(x,n=300):
    t=s=F(1)
    for k in range(1,n+1):
        t*=F(x,k);s+=t
    return s,s+t*F(x,n+1)/(1-F(x,n+2))
assert exp_bounds(35)[1]<B<exp_bounds(36)[0]
seedlo=F(999967635190289132,10**9)
seedhi=F(999970323068320645,10**9)
assert A*(1-epsilon)<seedlo<seedhi<A*(1+epsilon)

# Replay the ACTUAL fixed-precision source log tests at the endpoints.
def source_log_checks(cN,cD,N):
    a,r=divmod(cN,cD); f=F(r,cD)
    t=sum((f**i/factorial(i) for i in range(12)),F(0))
    lower=F('2.7182818286')**a*(t+f**12*F(13,12*factorial(12)))<=N
    upper=N<F('2.7182818283')**a*t
    return lower,upper
log_boxes={}
for n in [A,B]:
    center=int(log(n)*10**9) # search hint only; acceptance uses exact rationals
    lows=[];ups=[]
    for c in range(center-100,center+101):
        l,u=source_log_checks(c,10**9,n)
        if l:lows.append(c)
        if u:ups.append(c)
    lo=max(lows);hi=min(ups)
    assert hi-lo>1
    assert hi-lo<=100
    log_boxes[str(n)]={'lo_numerator':lo,'hi_numerator':hi,'denominator':10**9,
                       'width':str(F(hi-lo,10**9))}
assert F('1.387')/120000+F('2e-7')+(seedhi-seedlo)/A < F(1,12000)

# Independent interval endpoint identities: no assumption on intermediate primes.
# If theta(a)>=a(1-eps), theta(b)<=b(1+eps), a<=n<=b,
# and 0<=NP(n)<=power*n, monotonicity gives these affine extrema.
for a,b in zip(grid,grid[1:]):
    assert F(b)*(1+epsilon+power)-a <= upper*a
    assert b-F(a)*(1-epsilon) <= lower*a

result={'status':'conditional design audit; no finite theta counts verified',
        'windows':len(grid)-1,'grid_sha256':digest,
        'upper_margin_to_1_over_3600':str(F(1,3600)-upper),
        'lower_margin_to_1_over_3600':str(F(1,3600)-lower),
        'seed_lower_margin':str(seedlo-A*(1-epsilon)),
        'seed_upper_margin':str(A*(1+epsilon)-seedhi),
        'exp35_below_B_and_B_below_exp36':'exact Taylor bounds pass',
        'actual_source_endpoint_log_boxes':log_boxes,
        'proposal_script_sha256':hashlib.sha256(proposal.read_bytes()).hexdigest()}
print(json.dumps(result,indent=2))
(HERE/'resume_psi_gap_review_20261111.json').write_text(json.dumps(result,indent=2)+'\n')
