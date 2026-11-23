"""Independent full point-sign replay. No author imports or builtin zeta/Gamma.
Direct zeta EM at B=640, M=40, 192 bits; Machin pi and split-log phase.
"""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json,time,sys
from flint import arb,acb,ctx
BASE=Path(__file__).resolve().parent
AUTHOR=BASE.parent/'mellin'
PINS={
 'principal_signs_1500_20261111.json':'542346deb342369a1d53601dc051afadb39149db34c6e7426c33ab4094bc8cf4',
 'principal_signs_1500_20261111.py':'5dadc07911bbe024947f1ca6ec2ffce0cdf205dc63efd1968d2b545b9e1c182a',
 'PRINCIPAL_SIGNS_1500_CERTIFICATE_2026-11-11.md':'0c2df29b039e0418144edaaf1ada05beef31b90f3e1f0358dcad837f7bf69082',
 'psi_head_counts_20261111_h1500.json':'82ad7acdffbcac24d190a98acb78bf66471249d09bfe2c43051add2aaec0d030',
 'psi_head_counts_20261111.py':'d7f187fa357eaca184a2214f8952b396b9d2df42348580993005b7da00252a9a',
 'PRINCIPAL_COMPLETENESS_ROUTE_2026-11-11.md':'ac1fa5c0308d24c9cb19febf6a2c231b42c6e25113e534d4c23fe62e4ce2d92c',
}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
for name,h in PINS.items():assert sha(AUTHOR/name)==h
reviews={BASE/'PRINCIPAL_COMPLETENESS_ROUTE_REVIEW_2026-11-11.md':'fb268ad7ace08954435194d51bf6fc3c358ae7838e8ccfae7087b0e0f84eaa11',BASE.parent/'moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md':'0bd2af981c7f8a201f15597a7ee4c7b9812053c4987231c8eb02e5a6aa8ba491'}
for p,h in reviews.items():assert sha(p)==h
head=json.loads((AUTHOR/'psi_head_counts_20261111_h1500.json').read_text())
assert head['status']=='PASS_EXTERNAL_HEAD_COUNTS' and head['height']=='1500'
assert head['script_sha256']==PINS['psi_head_counts_20261111.py']
assert head['counts'][0]['t']=='14' and head['counts'][0]['N']==0
assert head['counts'][-1]['t']=='1500' and head['counts'][-1]['N']==1069
assert head['grid']==[r['t'] for r in head['counts']]
q=F(0)
for prev,row in zip(head['counts'],head['counts'][1:]):
    a,b=F(prev['t']),F(row['t'])
    assert a<b and prev['N']<=row['N']
    q+=row['N']*(1/a-1/b)
    assert q==F(row['Q_upper'])
assert q==F(head['Q_upper'])<F(1668,1000)
# Exact identities already accepted from full independent head contour review,
# not recounted here and not inferred from sign data.
data=json.loads((AUTHOR/'principal_signs_1500_20261111.json').read_text())
assert data['status']=='PASS_EXTERNAL_SIGN_COMPLETENESS'
assert data['domain']==['14','1500'] and data['target_count']==1069
assert data['head_sha256']==PINS['psi_head_counts_20261111_h1500.json']
assert data['em_script_sha256']==PINS['psi_head_counts_20261111.py']
assert data['script_sha256']==PINS['principal_signs_1500_20261111.py']
assert (data['EM_N'],data['EM_M'],data['precision_bits'])==(500,32,128)
rows=data['points'];ts=[F(r['t']) for r in rows]
assert len(rows)==1070 and ts[0]==14 and ts[-1]==1500
assert all(a<b for a,b in zip(ts,ts[1:]))
assert all((8*t).denominator==1 for t in ts)
assert [rows[0]['sign'],rows[-1]['sign']]==[-1,1]
assert all(r['sign'] in(-1,1) for r in rows)
assert all(a['sign']==-b['sign'] for a,b in zip(rows,rows[1:]))
ctx.prec=192;B=640;M=40

def ar(q):
    q=F(q);return arb(str(q.numerator))/q.denominator

def exact_bound(v):
    m,e=map(int,v.man_exp())
    return F(m*2**e) if e>=0 else F(m,2**(-e))

def atan_box(x,n=100):
    s=sum(((-1)**j*x**(2*j+1)/F(2*j+1) for j in range(n)),F(0))
    t=(-1)**n*x**(2*n+1)/F(2*n+1)
    return min(s,s+t),max(s,s+t)
a,b=atan_box(F(1,5));c,d=atan_box(F(1,239))
pi_lo,pi_hi=16*a-4*d,16*b-4*c
assert F(314159,100000)<pi_lo<pi_hi<F(314160,100000)
pi=arb(ar((pi_lo+pi_hi)/2),ar((pi_hi-pi_lo)/2))
# Coefficients of z/(exp(z)-1) by formal reciprocal, independent of
# the producer's recurrence for Bernoulli numbers B_n.
coeff=[F(1)]
for n in range(1,2*M+1):
    coeff.append(-sum(coeff[k]/factorial(n+1-k) for k in range(n)))
assert coeff[2]==F(1,12) and coeff[4]==F(-1,720)
assert all(coeff[j]==0 for j in range(3,2*M,2))
logs=[arb(n).log() for n in range(1,B)]
lb=arb(B).log();log2=arb(2).log();logpi=pi.log()
cs=[ar(coeff[2*k])*arb(B)**(1-2*k) for k in range(1,M+1)]
rem_scale=4*(lb*ar(F(1,2)-2*M)).exp()/(6**(2*M)*ar(F(2*M)-F(1,2)))
assert rem_scale>0
began=time.perf_counter();answer=[];minimum=None;max_rem=F(0)
for i,(t,row) in enumerate(zip(ts,rows)):
    u=ar(t);s=acb(ar(F(1,2)),u);base=(-s*lb).exp()
    # EM directly encloses zeta, not the pole-cancelled zetaF expression.
    v=sum(((-s*l).exp() for l in logs),acb(0))
    v+=base*(arb(B)/(s-1)+ar(F(1,2)))
    rising=acb(1);correction=acb(0)
    for j in range(1,2*M):
        rising*=s+j-1
        if j%2:correction+=cs[(j-1)//2]*rising
    v+=base*correction
    product=arb(1)
    for j in range(2*M):
        product*=(ar(F(1,2)+j)**2+u**2).sqrt()
    remainder=rem_scale*product
    radius=remainder.upper()
    zeta=v+acb(arb(0,radius),arb(0,radius))
    # Independent phase arrangement and trig product, no complex phase exp.
    phase=(u*(u.log()-log2-logpi-1))/2-pi/8
    proxy=phase.cos()*zeta.real-phase.sin()*zeta.imag
    assert proxy.is_finite()
    sign=1 if proxy>0 else (-1 if proxy<0 else 0)
    assert sign==row['sign'] and sign in(-1,1),(i,str(t),str(proxy))
    signed=sign*proxy;lo=exact_bound(signed.lower())
    assert lo>0
    er=exact_bound(radius);max_rem=max(max_rem,er)
    if minimum is None or lo<minimum[0]:minimum=(lo,i,t)
    answer.append({'index':i,'t':str(t),'sign':sign,'proxy_interval':str(proxy),'signed_lower_dyadic':str(lo),'em_error_upper_dyadic':str(er)})
assert len(answer)-1==head['counts'][-1]['N']
result={'status':'PASS_FULL_INDEPENDENT_EXTERNAL_SIGN_REPLAY','samples':len(answer),'strict_sign_changes':len(answer)-1,'domain':['14','1500'],'count_from_separate_accepted_head':1069,'EM_cutoff_B':B,'finite_sum_terms':B-1,'EM_M':M,'precision_bits':ctx.prec,'pi_method':'exact Machin rational alternating atan 100 terms','Bernoulli_method':'formal reciprocal coefficients of (exp z-1)/z','phase_method':'split log(t)-log(2)-log(pi); real cos/sin product','head_Q_upper':str(q),'minimum_signed_lower':{'value':str(minimum[0]),'index':minimum[1],'t':str(minimum[2])},'maximum_EM_error_upper':str(max_rem),'seconds':time.perf_counter()-began,'author_input_pins':PINS,'accepted_review_pins':{str(p.relative_to(BASE.parent)):h for p,h in reviews.items()},'script_sha256':sha(Path(__file__)),'samples_replayed':answer,'scope':'No author imports, builtin zeta/Gamma, historical zero tables, or Lean. Head contour is composed from separately accepted review, not rerun.'}
output=BASE/'principal_signs_1500_independent_review_20261111.json'
output.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in('samples_replayed','author_input_pins','accepted_review_pins')},indent=2))
