"""Independent finite rational checks only. No analytic evaluator or author import."""
from fractions import Fraction as F
from pathlib import Path
import json

checks = {}
def ck(name, proposition):
    assert proposition, name
    checks[name] = True

def expbox(z, degree=80):
    term = F(1)
    total = term
    for j in range(1, degree+1):
        term *= z/j
        total += term
    omitted = term*z/(degree+1)
    ratio = z/(degree+2)
    assert 0 <= ratio < 1
    return total, total+omitted/(1-ratio)

pi_lo, pi_hi = F(157,50), F(22,7)
ck('log10', expbox(F(23,10))[1] < 10 < expbox(F(231,100))[0])
ck('logA', 36 < 16*F(23,10) < 16*F(231,100) < 37)
ck('logX', 62 < 27*F(23,10) < 27*F(231,100) < 63)
for name,z,target,direction in [
    ('log36',F(179,50),36,'upper'),('log8',F(21,10),8,'lower'),
    ('log_four_thirds',F(3,10),F(4,3),'lower'),('log127',F(5),127,'lower'),
    ('exp6',F(6),400,'lower'),('exp1',F(1),F(8,3),'lower'),
    ('log4',F(1387,1000),4,'lower'),('logAover2pi',F(547,100),F(10500,44),'upper'),
    ('log1500',F(183,25),1500,'lower')]:
    lo,hi=expbox(z)
    ck(name, hi < target if direction=='upper' else lo > target)

# I1(20) positive-term recurrence, independent of factorial implementation.
term=F(10); i1=term
for n in range(1,45):
    term *= F(100,n*(n+1)); i1 += term
ck('sqrt10pi',F(28,5)**2 < 10*pi_lo)
ck('D20',F(56,5)*i1 > F(97,100)*expbox(F(20),140)[1])
eps=F(1,10000); cmax=F(75,2)
ck('eps_uniform',F(37**2*7,10**8)<eps)
ck('ceps',cmax*eps<F(31,500)**2)
ck('high_exp',F(71,100)*F(31,500)<F(9,200) and expbox(F(9,200))[1]<F(21,20))
ck('mid_prefactor',1+11*cmax*eps<F(21,20))
ck('c_over_eps_lt_sqrtx',50*F(2,3)<36*6)
ck('t2_gt_5000',6/eps>5000)
ck('sqrtpi',F(177,100)**2<pi_lo)
ratio=(F(3,8)+F(1,2**24))/(1-F(1,2**48))
ck('cosh_sinh',ratio<F(19,50))
low=(F(1,2)-F(491,6300))**2/(2*pi_lo)
mid=F(21,20)*F(19,50)/(4*pi_lo*36)
high=F(4,25)*F(51,10000)*F(21,20)*5/72
ck('low',low<F(71,2500)); ck('middle',mid<F(9,10000)); ck('high',high<F(3,50000))
ck('high_prefactor',F(1,200)*(1+F(1,2**36))/(1-F(1,2**48))<F(51,10000))
excess=2*(F(417,250)-((F(547,100)-1)**2+1)/(4*pi_hi)+(5*F(183,25)+F(207,8))/1500)
ck('centered_head_excess',excess<F(1,10))
ck('B0',F(97,100)*F(99,100)*36**2/150>1)
outer=1/(1-2*eps)*(1+eps/36)
ck('desmoothing_outer',outer<F(10003,10000))
ck('desmoothing_coefficient',4*F(10003,10000)/F(177,100)<F(2261,1000))
res=F(201,100)*eps*F(10003,10000)/36+F(5,2)*F(10003,10000)/(10**8*36)+F(2,10**8*36**2)+F(1,2*10**8*36)
ck('residual_and_jump',res<F(3,500000))
ck('prime_power',400**6<10**16 and F(1387,1000)+F(126,400)<F(171,100))
ck('prime_power_normalized',F(171,100)/36**2<F(33,25000))
allocation=F(71,2500)+F(9,10000)+F(3,50000)+F(3,500000)+F(33,25000)+F(1,12960)
ck('allocation',allocation<F(31,1000))
sx=3163*10**10
ck('sqrtX',sx*sx>10**27)
ck('sqrt62',F(39,5)**2<62)
ck('height',cmax*sx/(62**2*F(39,5))<4*10**10)
rows=[]
for q,b in [(1,6*10**17),(2,3*10**17),(4,15*10**16),(8,8*10**16),(16,5*10**16),(32,3*10**16),(48,2*10**16),(50,2*10**16)]:
    a=F(31,1000)+F(2261,1000*q)
    margin=b-4-2*a*sx*63**2
    ck('gap_Q'+str(q),margin>0 and b>=2*10**16)
    rows.append({'Q':q,'H':4*10**10*q,'B':b,'coefficient':str(a),'margin_lower':str(margin)})
out={'scope':'independent finite rational inequalities, not spectral certification','check_count':len(checks),'checks':checks,'rows':rows,'allocation':str(allocation),'reciprocal_excess_upper':str(excess)}
path=Path(__file__).with_suffix('.json')
with path.open('x',encoding='utf-8') as f:
    json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'receipt':str(path)}))
