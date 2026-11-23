"""Rational scalar inequalities for an Abel/count bound; no zero values."""
from fractions import Fraction as F
from pathlib import Path
import json

checks=[]
def ck(name,p):
    assert p,name
    checks.append(name)

def atan_box(q,n=12):
    x=F(1,q)
    s=sum((-1)**j*x**(2*j+1)/F(2*j+1) for j in range(n))
    tail=x**(2*n+1)/F(2*n+1)
    return (s,s+tail) if n%2==0 else (s-tail,s)

def log_box(x,n=60):
    assert 1<=x<=2
    z=(x-1)/(x+1)
    s=2*sum(z**(2*j+1)/F(2*j+1) for j in range(n))
    err=2*z**(2*n+1)/F(2*n+1)/(1-z*z)
    return s,s+err

a,b=atan_box(5);c,d=atan_box(239)
pi_lo,pi_hi=16*a-4*d,16*b-4*c
pl,pu=F('3.14159'),F('3.14160')
ck('Machin pi bracket',pl<pi_lo<pi_hi<pu)
l2,u2=log_box(F(2)); lx,ux=log_box(F(375,256))
la,ua=10*l2+lx,10*u2+ux
ck('log1500 bracket',F('7.3132')<la<ua<F('7.3133'))
# log(2*pi)=2*log2+log(pi/2), with rational pi endpoints.
ll,_=log_box(pl/2); _,uu=log_box(pu/2)
lp,up=2*l2+ll,2*u2+uu
ck('log2pi bracket',F('1.8378')<lp<up<F('1.8379'))
dl,du=F('5.4753'),F('5.4755')
ck('D lower subtraction',dl==F('7.3132')-F('1.8379'))
ck('D upper subtraction',F('7.3133')-F('1.8378')==du)
A=1500
base=F('1.668')+(du-1)/(2*pl)+F(7,8*A)-dl*dl/(4*pu)
oldC=2*(base+F(65,A))
sharpC=2*(base+F(9,A))
ck('accepted-count C below2/25',oldC<F(2,25))
ck('optional sharper-count C below1/100',sharpC<F(1,100))
ck('new baseline remains below .031',F('0.030686')+F(2,25)/36**2<F('0.031'))
out=dict(status='PASS_EXACT_ABEL_SCALARS_ONLY',checks=checks,
    accepted_count_additive_C_upper=str(oldC),selected_C='2/25',
    optional_R_log_additive_C_upper=str(sharpC),optional_C='1/100',
    consumer_baseline_upper=str(F('0.030686')+F(2,25)/36**2),
    scope='Conditional on accepted Q1500 and analytic count theorem. No zero data or RH computed.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(out,indent=2))
