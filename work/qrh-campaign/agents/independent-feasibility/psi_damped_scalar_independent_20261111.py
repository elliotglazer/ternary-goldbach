"""Independent endpoint certificate, coarser pi and shorter rational series.

No imported author code, analytic evaluator, spectral data, or numerical grid.
The companion paper review supplies the continuum and source arguments.
"""
from fractions import Fraction as Q
from pathlib import Path
import hashlib,json

def exp_box(x):
    assert 0<=x<65
    term=Q(1); lo=term
    for k in range(1,65):
        term=term*x/k
        lo+=term
    return lo,lo+(term*x/65)/(1-x/66)

def log_box(x):
    assert x>=1
    n=0
    while x>2:
        x/=2; n+=1
    def unit(y):
        z=(y-1)/(y+1); power=z; total=Q(0)
        for k in range(40):
            total+=2*power/(2*k+1)
            power*=z*z
        return total,total+2*power/(81*(1-z*z))
    a,b=unit(x); c,d=unit(Q(2))
    return a+n*c,b+n*d

def atan_box(x):
    term=x; s=Q(0)
    for k in range(20):
        s+=term/(2*k+1);term*=-x*x
    return s,s+term/41

def cosh_upper(x):
    lo,hi=exp_box(x)
    return (hi+1/lo)/2

def rounded_up(x):
    y=x*10**15
    return str(Q(-(-y.numerator//y.denominator),10**15))

def main():
    p,q=Q(314159,100000),Q(314160,100000)
    a,b=atan_box(Q(1,5));c,d=atan_box(Q(1,239))
    assert p<16*a-4*d and 16*b-4*c<q
    elllo=log_box(Q(1500))[0]-log_box(2*q)[1]
    ellhi=log_box(Q(1500))[1]-log_box(2*p)[0]
    L=Q(2233,100);A=1500;N=1069
    rlo=log_box(Q(500))[0]+log_box(L)[0]+log_box(L+10)[0]/2
    rhi=log_box(Q(500))[1]+log_box(L)[1]+log_box(L+10)[1]/2
    Zlo=rlo-log_box(2*q)[1];Zhi=rhi-log_box(2*p)[0]
    assert Zlo>ellhi>0
    gaplo=(elllo-1)/(2*q)+(5*log_box(Q(A))[0]+Q(167,8)-N)/A
    gaphi=(ellhi-1)/(2*p)+(5*log_box(Q(A))[1]+Q(167,8)-N)/A
    assert gaplo>0
    Dlo=gaplo+(Zlo*Zlo-ellhi*ellhi)/(4*q)
    Dhi=gaphi+(Zhi*Zhi-elllo*elllo)/(4*p)+(Q(46,125)*Zhi+Q(38,125))/(2*p)+Q(5,A)
    assert Dlo>1
    assert 1/exp_box(Q(1))[0]<Q(46,125)
    assert 1/(2*exp_box(Q(1,2))[0])<Q(38,125)
    # Global monotonicity constants, not samples of the continuum.
    assert (500*L)**2*(L+10)>A*A
    assert 500*35*7<125000 and exp_box(Q(11))[0]>Q(125000,6)
    assert (11+Q(46,125))*Q(3,2)/6<3
    assert 4/L+Q(11,200)<Q(1,2) and 4/L<1
    head=Q(417,250)+Q(N,A)
    aa=Q(1,500)/L; qq=Q(1,500)**2/(2*L*L*(L+10))
    principal=2*exp_box(qq)[1]*L*exp_box(aa/2)[1]*(head+cosh_upper(Q(11,200)*(L+aa))*Dhi)/exp_box(L/2)[0]
    lower_endpoint=2*exp_box(qq)[1]*L*32*(head+cosh_upper(Q(11,200)*7)*Dhi)/exp_box(L)[0]
    assert exp_box(Q(7))[0]>1000 and 32*32>1000
    other=Q('.002188002001')
    total=Q('1.000001')*(principal+lower_endpoint+other)
    assert principal+lower_endpoint<Q('.0077')
    assert total<Q('.0099')<Q('.01')
    out=Path(__file__).with_suffix('.json')
    result={'status':'PASS_INDEPENDENT_EXACT_ENDPOINT_AND_GLOBAL_SCALAR_BOUNDS',
      'pi_lower':str(p),'pi_upper':str(q),'exponential_degree':64,'logarithm_terms':40,
      'positive_tail_upper':rounded_up(Dhi),'principal_scaled_upper':rounded_up(principal),
      'lower_endpoint_scaled_upper':rounded_up(lower_endpoint),'full_scaled_upper':rounded_up(total),
      'full_cap':'.0099','scope':'Exact scalar proof only. No spectral or analytic evaluator; continuum argument reviewed separately.'}
    with out.open('x',encoding='utf-8') as f:
        json.dump(result,f,indent=2);f.write('\n')
    print(json.dumps(result))
    print('receipt_sha256',hashlib.sha256(out.read_bytes()).hexdigest().upper())

if __name__=='__main__':main()
