"""Exact scalar allocation only: no Gamma, L, exp, log, trig or spectral values."""
from fractions import Fraction as Q
from pathlib import Path
import json

def pair(x):
    return [str(x.numerator), str(x.denominator)]

def ceilq(x):
    return -((-x.numerator)//x.denominator)

def run():
    phase=[]
    for parity in (0,1):
        alpha=Q(2*parity+1,4)
        for J in (0,1):
            remainder=1/(48*(alpha+J)**2)
            lower=1-remainder**2/2
            assert lower>0
            phase.append({'a':parity,'J':J,'remainder':pair(remainder),'cos_lower':pair(lower)})
    assert phase[0]['remainder']==pair(Q(1,3))
    assert phase[0]['cos_lower']==pair(Q(17,18))
    assert phase[2]['remainder']==pair(Q(1,27))
    assert phase[2]['cos_lower']==pair(Q(1457,1458))
    rows=[]
    for c,V,p in ((4,Q(0),0),(8,Q(1330),68),(300000,Q(1330),68),
                  (300000,Q(60343058),128)):
        tau=Q(1,2**p)
        B0=2*(c+1)*(V+1)
        B=B0+1
        eta=tau/(64*B)
        input_L=Q(3,2)*Q(1,2**(p+5))
        assert input_L<=tau/16 and input_L<=1
        phase_elementary=eta/(4*(V+1))
        phase_error=(Q(5,4)*V+Q(1,4))*phase_elementary+eta/2
        assert phase_error<eta
        # epshat*rhat, exact eps is unit; rhat differs from a unit by <=eta.
        qerror=eta*(1+eta)+eta+phase_error
        assert qerror<=4*eta
        total=input_L+B*qerror+tau/16
        assert total<Q(1,4)*tau
        # An explicit cap for an arbitrary-accuracy true-unit-Hardy phase.
        Jcap=ceilq(2*B/tau)
        for alpha in (Q(1,4),Q(3,4)):
            assert 1/(48*(alpha+Jcap)**2)<=eta
        true_total=tau/16+B*(5*eta)+tau/16
        assert true_total==Q(13,64)*tau<tau/4
        rows.append({'c':c,'V':pair(V),'p':p,'p_L':p+5,'B':pair(B),
                     'eta':pair(eta),'elementary_each':pair(phase_elementary),
                     'proxy_total_over_tau':pair(total/tau),'true_H_J_cap':str(Jcap),
                     'true_H_total_over_tau':pair(true_total/tau)})
    return {'scope':'exact scalar bounds only; no analytic values or arrays',
            'phase':phase,'allocations':rows}

if __name__=='__main__':
    result=run()
    path=Path(__file__).with_suffix('.json')
    assert not path.exists(),'Do not overwrite frozen receipt'
    path.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print('PASS: phase positivity and four end-to-end scalar allocations')
