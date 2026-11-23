"""Independent full six-block Cauchy replay. FLINT zeta remains external trust.

Uses192 bits,80 samples, R3/8,rho3/16 instead of128/64/1/2/1/4.
No author-code import, historical count helper, zero search or enumeration.
"""
from pathlib import Path
from fractions import Fraction as Q
import hashlib,json,time
from flint import arb,acb,ctx

HERE=Path(__file__).resolve().parent
SRC=HERE.parent/'integration'
files={'PRINCIPAL_TOP_COUNT_2026-11-11.md':'27e092ef982bd02618f6987c68b58b4653e876f99f55bfdb5b6c38f4669ff94b',
       'principal_top_count_20261111.py':'323ef8e439db952972a81d11bd4216a56f27d8f93e665ad482ab328ab0e9846a',
       'principal_top_count_20261111.json':'452e2d603602da6fb05558f79f8451ff1e9ac26031f54e30a0b9a349cb3c2b2a'}
for n,h in files.items():assert hashlib.sha256((SRC/n).read_bytes()).hexdigest()==h
old=json.loads((SRC/'principal_top_count_20261111.json').read_text())['certificate']
start=time.perf_counter()
ctx.prec=192
T=10**6
assert old['height']==T and old['accepted_panels']==6

def qa(q):
    q=Q(q);return arb(q.numerator)/q.denominator
def rb(x):return [str(x.lower().fmpq()),str(x.upper().fmpq())]
def cb(z):return {'re':rb(z.real),'im':rb(z.imag)}
def inside(a,b):return Q(b[0])<=Q(a[0]) and Q(a[1])<=Q(b[1])
def ceilq(x):return -(-x.numerator//x.denominator)

# Independent exact stored-geometry/error/interval audit.
frozen_error=Q(8000026)/(1-Q(1,4))*(Q(1,4)**64+Q(1,2)**64/(1-Q(1,2)**64))
assert Q(old['model']['alias_plus_truncation_error'][0])<=frozen_error<=Q(old['model']['alias_plus_truncation_error'][1])
for j,b in enumerate(old['blocks']):
    right=Q(2)-Q(j,4);left=right-Q(1,4)
    assert Q(b['from'])==right and Q(b['to'])==left and Q(b['center'])==(left+right)/2
    assert len(b['sample_boxes'])==64 and len(b['coefficient_boxes'])==64
    assert len(b['panels'])==1
    p=b['panels'][0]
    assert Q(p['from'])==right and Q(p['to'])==left and p['halfplane']=='right'
    assert Q(p['model_box']['re'][0])>Q('.07608')
    for e in (right,left):assert Q(old['endpoint_boxes'][str(e)]['re'][0])>0
assert set(old['endpoint_boxes'])=={str(Q(1,2)+Q(j,4)) for j in range(7)}
assert Q(old['endpoint_boxes']['2']['re'][0])>Q(1,4)
lower,upper=map(Q,old['count_interval'])
assert lower<=Q(old['F'][0])+Q(old['S'][0])-Q(1,8)
assert Q(old['F'][1])+Q(old['S'][1])+Q(1,8)<=upper
assert ceilq(lower)==upper.numerator//upper.denominator==1747146
assert Q('1747145.87')<lower<upper<Q('1747146.13')

# Smaller outer disk: Re>=1/4, |s|<=T+3, |s-1|>=T-3/8.
# Source norm_zetaF_le divided by |s-1| gives the following actual-zeta M.
m=80;R=Q(3,8);rho=Q(3,16);r=Q(1,8);M=4*(T+3)+2
assert Q(T+3)/(T-R)<2
error=Q(M)/(1-r/R)*((r/R)**m+(rho/R)**m/(1-(rho/R)**m))
assert error<Q('5e-18')
roots=[acb(0,2*arb.pi()*j/m).exp() for j in range(m)]
eps={x:acb(qa(x),T).zeta() for x in (Q(1,2)+Q(j,4) for j in range(7))}
for x,v in eps.items():
    assert v.real>0
    box=cb(v)
    assert inside(box['re'],old['endpoint_boxes'][str(x)]['re'])
    assert inside(box['im'],old['endpoint_boxes'][str(x)]['im'])
assert eps[Q(2)].real>qa(Q(1,4))

newblocks=[];increments=[]
for bi in range(6):
    hi=Q(2)-Q(bi,4);lo=hi-Q(1,4);center=(hi+lo)/2
    assert center-R>=Q(1,4)
    samples=[(acb(qa(center),T)+qa(rho)*root).zeta() for root in roots]
    # Inverse powers rather than the producer's modulo-indexed root array.
    coeff=[sum((samples[j]*(roots[j]**(-k)) for j in range(m)),acb(0))/m for k in range(m)]
    variable=acb(arb(0,qa(r/rho)))
    poly=acb(0)
    for coefficient in reversed(coeff):poly=poly*variable+coefficient
    value=poly+acb(arb(0,qa(error)),arb(0,qa(error)))
    assert value.real>0,bi
    inc=(eps[lo].log()-eps[hi].log()).imag
    increments.append(inc)
    assert inside(rb(inc),old['blocks'][bi]['panels'][0]['increment'])
    newblocks.append({'index':bi,'from':str(hi),'to':str(lo),'center':str(center),
                      'whole_panel_box':cb(value),'argument_increment':rb(inc)})

arg=eps[Q(2)].log().imag+sum(increments,arb(0))
S=arg/arb.pi()
directS=eps[Q(1,2)].log().imag/arb.pi()
assert S.overlaps(directS)
assert inside(rb(S),old['S'])
F=qa(T)/(2*arb.pi())*((qa(T)/(2*arb.pi())).log()-1)+qa(Q(7,8))
assert inside(rb(F),old['F'])
# Exact endpoint addition avoids Arb radius-storage quantization when comparing
# two independently rounded balls of essentially the same radius1/8.
cl=Q(rb(F)[0])+Q(rb(S)[0])-Q(1,8)
ch=Q(rb(F)[1])+Q(rb(S)[1])+Q(1,8)
count_bounds=[str(cl),str(ch)]
assert ceilq(cl)==ch.numerator//ch.denominator==1747146
assert inside(count_bounds,old['count_interval'])

out={'status':'PASS: full alternative six-block external replay; no formal RS or count theorem',
     'source_sha256':files,'parameters':{'precision_bits':192,'m':m,'R':str(R),'rho':str(rho),'r':str(r),
                                      'M':M,'error_exact':str(error)},
     'height':T,'sample_calls':480,'shared_endpoint_calls':7,
     'blocks':newblocks,'endpoint_boxes':{str(x):cb(v) for x,v in sorted(eps.items())},
     'S':rb(S),'F':rb(F),'count_interval':count_bounds,'unique_integer':1747146,
     'direct_principal_log_endpoint_crosscheck':rb(directS),
     'elapsed_seconds_diagnostic':time.perf_counter()-start,
     'trust_boundary':'FLINT zeta point and elementary interval primitives; normalized analytic count identity remains a paper theorem'}
HERE.joinpath('review_principal_top_count_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'status':out['status'],'count':1747146,'parameters':out['parameters'],
                  'S':str(S),'positive_panel_re_lowers':[str(x['whole_panel_box']['re'][0]) for x in newblocks],
                  'elapsed_seconds':out['elapsed_seconds_diagnostic']},indent=2))
