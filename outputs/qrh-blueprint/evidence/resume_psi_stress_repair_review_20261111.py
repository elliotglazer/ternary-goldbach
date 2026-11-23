"""Independent bounded audit: all rational chains; only final window re-sieved."""
from pathlib import Path
from fractions import Fraction as F
from math import isqrt, factorial
import json,hashlib
HERE=Path(__file__).resolve().parent
P=HERE.parent/'prime-estimates'
files=['resume_psi_short_gap_20261111.json','resume_psi_multi32_20261111.json','resume_psi_stress512_20261111.json']
data=[json.loads((P/f).read_text()) for f in files]
pilot,prior,stress=data
D=10**9
# Literal source Small.chkLow/Small.chkStep for n=1.
def checklog(box,n):
    lo,hi=box
    assert 0<lo<hi and hi-lo<=100
    def exp_bound(k,upper):
        a,r=divmod(k,D);f=F(r,D)
        t=sum((f**j/F(factorial(j))) for j in range(12))
        if upper:t+=f**12*F(13,12*factorial(12))
        return F(27182818286 if upper else 27182818283,10**10)**a*t
    assert exp_bound(lo,True)<=n<exp_bound(hi,False)
L=F(999967635190289132,D);U=F(999970323068320645,D)
a=D;box=[20723265833,20723265841];checklog(box,a)
allrows=[{'a':a,'b':pilot['pilot_endpoint'],'count':pilot['pilot_count'],'log_box':pilot['pilot_log_box'],'theta_lower':pilot['pilot_theta_lower'],'theta_upper':pilot['pilot_theta_upper']}]+prior['windows']+stress['windows']
fail=[];relaxed=[];total=0
for idx,r in enumerate(allrows,1):
    b=r['b'];c=r['count']
    assert r['a']==a and b==a+a//4000 and c>=0
    rb=r['log_box'];checklog(rb,b)
    if 'subwindows' in r:
        cursor=a
        for sub in r['subwindows']:
            assert sub['n']==cursor and 0<sub['width']<=32768
            assert 0<=sub['count']<=sub['width'];cursor+=sub['width']
        assert cursor==b and sum(s['count'] for s in r['subwindows'])==c
    L+=F(c*box[0],D);U+=F(c*rb[1],D)
    assert L==F(r['theta_lower']) and U==F(r['theta_upper'])
    ml=L-(b-F(b,24000));mh=b+F(b,24000)-U
    if 'lower_margin' in r:assert ml==F(r['lower_margin']) and mh==F(r['upper_margin'])
    if min(ml,mh)<0:fail.append(idx)
    relaxed.append(min(L-(b-F(b,10000)),b+F(b,10000)-U))
    total+=c;a=b;box=rb
assert len(allrows)==538 and fail==[538] and min(relaxed)>0
assert total==stress['cumulative_primes_after_seed']
assert stress['remaining_grid_windows_without_external_counts']==6439-538==5901
assert L<a-F(a,24000)<U<a+F(a,24000)
# Independent final-cell sieve: complete base by incremental trial division;
# mark each odd composite individually, then trial-divide all survivors.
r=allrows[-1];left,right=r['a'],r['b']
primes=[]
for n in range(2,isqrt(right)+1):
    if all(n%p for p in primes if p*p<=n):primes.append(n)
start=left+1 if (left+1)%2 else left+2
composites=set()
for p in primes[1:]:
    z=max(p*p,((start+p-1)//p)*p)
    if z%2==0:z+=p
    composites.update(range(z,right+1,2*p))
survivors=[n for n in range(start,right+1,2) if n not in composites]
assert all(all(n%p for p in primes if p*p<=n) for n in survivors)
assert len(survivors)==r['count']==13635
for sub in r['subwindows']:
    assert sum(sub['n']<n<=sub['n']+sub['width'] for n in survivors)==sub['count']
digest=hashlib.sha256(''.join(str(n)+'\n' for n in survivors).encode()).hexdigest()
assert digest==r['prime_list_sha256']
upper=F(1,4000)+(F(1,10000)+F(17,360000))*F(4001,4000)
lower=F(1,4000)+F(1,10000)
assert max(upper,lower)<F(1,2300)
assert F(14262,10000)**2 < F(17,360000)**2*10**9
assert F(27,10)**23>5*10**9
assert F(999967635190289132,D)>=D-F(D,10000)
assert F(999970323068320645,D)<=D+F(D,10000)
out={'status':'external exact arithmetic and final-cell recount only; not Lean',
 'source_data_sha256':{f:hashlib.sha256((P/f).read_bytes()).hexdigest() for f in files},
 'replayed_windows':len(allrows),'tight_acceptance_failures':fail,'all_relaxed_checkpoints_pass':True,
 'minimum_relaxed_margin':str(min(relaxed)),'failed_endpoint':a,
 'tight_lower_margin':str(L-(a-F(a,24000))), 'tight_interval_overlap':True,
 'actual_tight_violation_established':False,'final_window_recount':len(survivors),'final_window_prime_sha256':digest,
 'final_theta_lower':str(L),'final_theta_upper':str(U),
 'remaining_uncounted_windows':5901,'upper_interpolation_coefficient':str(upper),
 'lower_interpolation_coefficient':str(lower),'upper_slack_to_1_over_2300':str(F(1,2300)-upper),
 'scope':'All 538 rational checkpoint/log/subwindow bookkeeping replayed from source seed; earlier 537 prime counts accepted as supplied, only window538 independently recounted.'}
(HERE/'resume_psi_stress_repair_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
