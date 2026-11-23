"""Independent rational-only review. No import of producer or function evaluator."""
from fractions import Fraction as Q
from math import factorial, gcd, isqrt
from pathlib import Path
import json, hashlib, time

ROOT = Path(__file__).resolve().parent.parent
SOURCE = ROOT / 'zero-sum/shared_high_conductor_height_reduction_20261111.py'
DATA = SOURCE.with_suffix('.json')
CELLS = SOURCE.with_name(SOURCE.stem + '_cells.json')
LIMIT = 300000
SCALE = 10**20

def ceil(x):
    return -((-x.numerator)//x.denominator)

def upwards(x, scale):
    return Q(ceil(x*scale), scale)

def root_up(x):
    scale = 10**14
    n = ceil(x*scale*scale)
    r = isqrt(n)
    if r*r < n:
        r += 1
    assert Q(r*r, scale*scale) >= x
    return Q(r, scale)

EXP1_LO = sum((Q(1, factorial(k)) for k in range(25)), Q(0))

def negative_exp_upper(x):
    assert x >= 0
    integer = x.numerator // x.denominator
    fractional = x-integer
    polynomial = sum((fractional**k/factorial(k) for k in range(21)), Q(0))
    return 1/(EXP1_LO**integer*polynomial)

def b_tail(t):
    assert t >= 50
    t = min(t, Q(2000))
    return Q(223,250)*t*negative_exp_upper(Q(799,5000)*t)

def a_tail(t,d):
    ratio = t/(Q(22,7)*d)
    assert ratio >= 10
    ratio = min(ratio, Q(40))
    return Q(147,250)*ratio**2*negative_exp_upper(Q(213,2000)*ratio**2)

def cell_upper(lo,hi):
    odd = lo%2 == 1
    d = Q(600000 if odd else 1200000,lo)
    h = Q(50000000 if odd else 99000000,hi)
    assert h-200 >= max(50,10*Q(22,7)*d)
    g = 3+Q(10,27)*d
    ga = 800*g+106*g*g/h
    gb = 2400+954/h
    return (Q(7,2)*(b_tail(h-100)*gb+a_tail(h-100,d)*ga)
            +Q(1,160)*(b_tail(h-200)*gb+a_tail(h-200,d)*ga))/2125

def run():
    start=time.monotonic()
    expected_hashes=['BB53DC83F67E4868CF360F4C44D978EE40655BA5C1D2D17D05D81B45CACFACCE',
        '4E4127E970120A5BB5441CF0AF3F419F6262F616C9FA9E715A70C1E8D91CCA1A',
        '7E4A7D78A90E7ABFB08B5486F8DB003A01DFF11DEC4DA1ABB3AB602DFAF11AC2']
    for path,digest in zip((SOURCE,DATA,CELLS),expected_hashes):
        assert hashlib.sha256(path.read_bytes()).hexdigest().upper()==digest
    data=json.loads(DATA.read_text())
    cells=json.loads(CELLS.read_text())
    assert data['profile']=={'unchanged_through':100000,'odd_numerator':50000000,'even_numerator':99000000}
    tails=[0]*(LIMIT+1)
    expected={True:100001,False:100004}
    for row in cells:
        lo,hi,odd=row['lo'],row['hi'],row['odd']
        step=2 if odd else 4
        assert type(odd) is bool and lo==expected[odd]
        assert lo<=hi<=(150000 if odd else LIMIT)
        assert (hi-lo)%step==0 and lo%step==(1 if odd else 0)
        bound=Q(row['tail_numerator'],SCALE)
        assert cell_upper(lo,hi)<=bound
        for c in range(lo,hi+1,step):
            assert tails[c]==0
            tails[c]=row['tail_numerator']
        expected[odd]=hi+step
    assert expected=={True:150001,False:300004}

    # Independent divisor inversion of phi, and of the constant-one convolution.
    phi=list(range(LIMIT+1))
    for p in range(2,LIMIT+1):
        if phi[p]==p:
            for n in range(p,LIMIT+1,p):
                phi[n]-=phi[n]//p
    counts=phi.copy()
    mu=[0]*(LIMIT+1);mu[1]=1
    for d in range(1,LIMIT+1):
        for n in range(2*d,LIMIT+1,d):
            counts[n]-=counts[d]
            mu[n]-=mu[d]
    active=[c for c in range(1,LIMIT+1) if counts[c] and (c%2==0 or c<=150000)]
    assert len(active)==150000 and sum(counts[c] for c in active)==5543640188
    et=[0]*(LIMIT+1);es=[0]*(LIMIT+1);gw=[0]*(LIMIT+1)
    for c in active:
        dc=Q(1200000,2*c if c%2 else c)
        oldstar=ceil(max(Q(1000),Q(704,343)*dc))
        ns=ceil(400*(Q(50,87)*oldstar+2))
        if c>100000:
            assert oldstar==1000 and tails[c]>0
            h=Q(50000000 if c%2 else 99000000,c)
            assert h>=330 and h<Q(100000000,c)
            # Worst supported base-gap prefix, with ceil bounded by value+1.
            base=Q(290400000 if c%2 else 580800000,7*c)+1
            assert max(Q(250),base)<h
        for m in range(c,LIMIT+1,c):
            if m%2 and m>150000:
                continue
            r=m//c
            if mu[r] and gcd(c,r)==1:
                weight=c*counts[c]
                gw[m]+=weight
                et[m]+=weight*tails[c]**2
                es[m]+=weight*ns
    nt=Q(0);it0=Q(0);at=Q(0)
    for m in range(1,LIMIT+1):
        if m%2 and m>150000:
            continue
        assert gw[m]==phi[m]**2
        d=Q(1200000,2*m if m%2 else m)
        nt+=upwards(2*d*Q(et[m],phi[m]*SCALE**2),SCALE)
        it0+=upwards(Q(et[m]*es[m],phi[m]**2*SCALE**2),10**8)
        if mu[m]:
            at+=upwards(min(Q('381.22'),2*d*Q('1.2534')**2)*Q(et[m],phi[m]**3*SCALE**2),10**32)
    it=it0*49*102000*Q('5.625e-23')
    for key,value in [('new_high_N_energy',nt),('new_high_mixed_energy',it),('new_high_Aplus_energy',at)]:
        assert Q(data[key]['exact'])==value
    nall=nt+Q('.025');iall=it+Q('2.5e-8');aall=at+Q('1e-20')
    star=2*(b_tail(Q(330))*(2400+Q(954,330))
        +a_tail(Q(330),Q(12,49))*(800*Q('3.1')+Q(106,330)*Q('3.1')**2))/1333
    assert star<Q('1e-18')
    extra=Q('2e-15')*55000+Q('2e-12')*25+Q('2e-12')*root_up(300000*nall)+Q('2e-15')*Q('2e-12')*180000000000
    aplus=(Q('.00007')+root_up(aall)+Q('2e-9'))**2
    astar=(Q('.00049')+Q('1.2e-6'))**2
    coarse_cross=(Q('.0005')+root_up(iall)+extra)**2
    assert astar+coarse_cross>Q('9.5e-7')
    assert data['status']=='FAIL_SUFFICIENT_SCALAR_BUDGET'
    # Independently reviewed direct-modulus low Cross<1e-9, not the coarse factor25 allocation.
    assert Q('.000032')**2>Q('1e-9')
    assert (Q('6.794e36')/Q('1e-9'))**100 < (49*10**50)**89
    cross=(Q('.000032')+root_up(iall)+extra)**2
    nvalue=(Q('.032')+root_up(nall)+Q('2e-9'))**2
    checks={'Aplus':aplus<Q('5e-7'),'Astar':astar<Q('2.5e-7'),
            'N':nvalue<Q('1.23'),'Ep':(Q('.0002')+Q('1e-8'))**2<Q('1e-4'),
            'Astar_plus_Cross':astar+cross<Q('9.5e-7')}
    assert all(checks.values())
    return {'status':'PASS_SCALAR_REVIEW','checks':checks,'cells_checked':len(cells),
        'active_conductors':len(active),'changed_conductors':sum(c>100000 for c in active),
        'new_N_energy':str(nt),'new_mixed_energy':str(it),'new_Aplus_energy':str(at),
        'review_Astar_plus_Cross_upper':str(astar+cross),'review_N_upper':str(nvalue),
        'input_sha256':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (SOURCE,DATA,CELLS)},
        'elapsed_seconds_diagnostic':time.monotonic()-start}

if __name__=='__main__':
    result=run()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))
