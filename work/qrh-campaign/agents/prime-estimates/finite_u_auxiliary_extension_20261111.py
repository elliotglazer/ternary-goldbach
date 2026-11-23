"""Scalar witnesses for uncapped finite-U EM allocation; no function evaluator."""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import json

def ceilq(x):
    return -((-x.numerator)//x.denominator)

def encode(x):
    return [str(x.numerator), str(x.denominator)]

def allocation(c, U, p):
    assert 2 <= c <= 300000 and U >= 0 and p >= 0
    u = ceilq(U)
    eps = Q(1, 2**p)
    X1 = c*(u+7)
    q = X1.bit_length()
    Mcap = 1 + (p+q+6)//4  # 1+ceil((p+q+3)/4)
    def eb(m):
        x = c*(u+2*m+5)
        return Q(4*x, 36**m) / (2*m-Q(203,400))
    assert eb(1) < X1 < 2**q
    assert eb(Mcap) < eps/8
    M = next(m for m in range(1, Mcap+1) if eb(m) <= eps/8)
    for m in range(1, Mcap):
        assert eb(m+1) < eb(m)/18
    N = u+2*M+4
    X = c*(N+1)
    qx = X.bit_length()
    Kcap = (p+2*qx+8)//4  # ceil((p+2*qx+5)/4)
    tb = lambda k: Q(32*X*X,15*16**k)
    assert tb(Kcap) < eps/8
    K = next(k for k in range(1,Kcap+1) if tb(k) <= eps/8)
    Pcap = p+qx+5
    rb = lambda k: Q(2*X, factorial(k))
    assert rb(Pcap) < eps/8
    P = next(k for k in range(1,Pcap+1) if rb(k) <= eps/8)
    r = qx.bit_length()
    Qcap = p+qx+(K-1)*r+12
    pole = lambda k: Q(3*X*qx**(K-1), N*factorial(k)*(k+1))
    assert pole(Qcap) < eps/512
    Qpole = next(k for k in range(1,Qcap+1) if pole(k) <= eps/512)
    coefficient_error = eps/32
    full = Q(3,2)*(eb(M)+tb(K)+rb(P)) + Q(16,15)*coefficient_error + eps/8
    assert full < Q(3,4)*eps
    # U passed here is the work height rounded upward to the 1/32 grid.
    J = int(32*U)+1
    assert Q(J-1,32) == U
    assert Q(11,200) < Q(1,16) and Q(3,50) < Q(1,16)
    assert Q(3,50)**2 + Q(1,64)**2 < Q(1,16)**2
    return {'c': c,'U':encode(U),'p':p,'old_cap_holds':c*U<=10**8,
            'M':M,'N':N,'X':X,'K':K,'P':P,'Qpole':Qpole,
            'search_caps':{'M':Mcap,'K':Kcap,'P':Pcap,'Qpole':Qcap},
            'EM_bound':encode(eb(M)),'Taylor_bound':encode(tb(K)),
            'moment_bound':encode(rb(P)),'complete_bound_over_eps':encode(full/eps),
            'pole_coefficient_tail':encode(pole(Qpole)),
            'example_one_sided_grid':{'denominator':32,'J':J}}

def run():
    cases=[(2,Q(0),0),(300000,Q(330),68),(300000,Q(1330),68),
           (149999,Q(50000000,149999)+1000,68),(4,Q(10**8),68),
           (300000,Q(10**12)+Q(1,3),128)]
    # Small denominator rational check only, no character/function values.
    rows=[]
    for c,U,p in cases:
        Uwork=Q(ceilq(32*U),32)
        assert U <= Uwork < U+Q(1,32)
        row=allocation(c,Uwork,p)
        row['requested_U']=encode(U)
        rows.append(row)
    return {'scope':'rational scalar allocation only; no spectral values or runtime claim',
            'formula':'E=4X/(36^M*(2M-203/400)); T=32X^2/(15*16^K); R=2X/P!',
            'rows':rows}

if __name__=='__main__':
    result=run()
    out=Path(__file__).with_suffix('.json')
    assert not out.exists(), 'Do not overwrite a frozen receipt'
    out.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps([{'c':r['c'],'U':r['U'],'p':r['p'],'M':r['M'],'N':r['N'],
                       'K':r['K'],'P':r['P'],'Qpole':r['Qpole'],'old_cap_holds':r['old_cap_holds']} for r in result['rows']]))
