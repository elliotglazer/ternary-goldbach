"""Rational envelopes for a proposed compact positive bump. No zeta/prime calls."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

def exp_lower(z,n=160):
    return sum((z**k/F(factorial(k)) for k in range(n)),F(0))
def sinh_lower(z,n=60):
    return sum((z**(2*k+1)/F(factorial(2*k+1)) for k in range(n)),F(0))
def pack(q):
    return dict(numerator=str(q.numerator),denominator=str(q.denominator),
                display=float(q))

X=10**27
pi_lo=F(31415,10000)
sqrt_pi_lo=F(443,250)
sqrt_X_lo=3162*10**10
root8_X_lo=2370
assert sqrt_pi_lo**2<pi_lo and sqrt_X_lo**2<X and root8_X_lo**8<X
assert exp_lower(F(63))>X+2*10**16 and 2**100>X+2*10**16
rows=[]
for B,H,c,d,Rnumer,lr,lrfull,lh,lhfull in [
    (10**16,6200000000000,F(15),F(1,16),F(11),27,29,28,30),
    (2*10**16,2950000000000,F(71,5),F(7,100),F(533,50),26,28,27,29),
]:
    x=F(X)+F(B,2)
    a=F(B,2*(X+B))
    Rbar=Rnumer/a
    assert c>=4 and Rnumer**2>=8*c
    assert 1-(2*c/(a*H))**2-F(1,H*H)>=d and d>=F(1,16)
    assert exp_lower(F(lr))*2*pi_lo>Rbar
    assert exp_lower(F(lrfull))>Rbar
    assert exp_lower(F(lh))*2*pi_lo>H
    assert exp_lower(F(lhfull))>H
    assert a< F(1,100) and Rbar>1000
    sh=sinh_lower(c)
    G=2000+Rbar/(4*sqrt_pi_lo)*(lr-2+2/sqrt_pi_lo)+5*lrfull+F(167,8)
    Nbar=F(H)/(2*pi_lo)*(lh-1)+5*lhfull+F(167,8)
    head=F(2,sqrt_X_lo)*(G+((c/sh)**2+a/(2*(1-a/2)))*Nbar)
    T2=F(lh)/(pi_lo*H)+F(5*lhfull+F(187,8),H*H)
    tail=F(2,root8_X_lo)*4*c*c/(d*a*a*sh*sh)/(1-4*a)*T2
    pp=(4*c/a)*63*(F(B,sqrt_X_lo)+50)/X
    Ktail=4*c*c/(d*a*a*sh*sh)/(1-4*a)
    vertical=F(802)*(H*(2+lhfull)/(1-a/2)+Ktail*(3+lhfull)/H)
    left=vertical/(2*pi_lo*X*sqrt_X_lo)
    total=head+tail+pp+left
    assert total<1
    rows.append(dict(B=B,H=H,c=pack(c),d=pack(d),a=pack(a),
        head=pack(head),qrh_tail=pack(tail),prime_power=pack(pp),
        left_line=pack(left),total=pack(total),margin=pack(1-total),
        count_bound=pack(Nbar),R_upper=pack(Rbar),
        log_bounds=dict(R_over_2pi=lr,R=lrfull,H_over_2pi=lh,H=lhfull),
        finite_RH_only_same_bound=pack(head+tail*root8_X_lo+pp+left)))

result=dict(scope="conditional paper kernel criterion; rational scalar bounds only",
    pi_lower=pack(pi_lo),sqrt_pi_lower=pack(sqrt_pi_lo),sqrt_X_lower=sqrt_X_lo,
    X_eighth_root_lower=root8_X_lo,rows=rows)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    for r in rows:
        print({k:r[k] for k in ('B','H')},
              {k:r[k]['display'] for k in ('head','qrh_tail','prime_power','total','finite_RH_only_same_bound')})
