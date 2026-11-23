"""Independent rational implications and source pins; no analytic evaluator."""
from fractions import Fraction as Q
from pathlib import Path
from math import factorial
import hashlib, json

HERE=Path(__file__).resolve().parent
A=HERE.parent
PINS={
 'audit/P4_SHARED_STRIP_REDUCTION_2026-11-11.md':'EE2E6A7752136F751D64890A0E2BD4CD613790529B1A4D5BC24483F2A3B5B585',
 'audit/p4_shared_strip_scalars_20261111.py':'641D47F7ADB06F1266A7D3C15BC5514818FBE1A85139942B6DCE3F4AAEC6ACBA',
 'mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md':'4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303',
 'prime-estimates/XiMass.lean':'DC2F179566C4DD7EFEBBC295CD49C1E40CD1B861EAC5555ABF6EA4377765A899',
 'audit/XIMASS_REVIEW.md':'F285D46C3275A3A605A52974A5FA30BCAA87912007C6A28CC5BFD3772C5DD436',
 'zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md':'C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D',
 'prime-estimates/PRIME_CONSUMER_SOURCE_JOIN_2026-11-11.md':'B5F377CEED926B70B22E2539086D5C423D474A065D3E10F56D93C93108377B61',
 'mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md':'33C01406E927F8F49F329AB52B967AA14B85B64DF7928A034C3028EFEEB91F61',
}

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def poly(x,n):return sum((x**k/factorial(k) for k in range(n+1)),Q(0))

def main():
    for p,h in PINS.items():assert sha(A/p)==h,p
    checks={}
    def check(k,b):
        assert b,k
        checks[k]=True
    check('exp1_lower',poly(Q(1),5)>Q(27,10))
    check('exp1_upper',poly(Q(1),5)+Q(1,factorial(6))*Q(7,6)<Q(11,4))
    check('log_bounds',Q(27,10)**8>1500 and Q(27,10)**14>10**6 and Q(27,10)**7>Q(2000,3))
    check('closed_head_count',250*6+Q(7,8)+40+20<1600)
    check('uniform_count_slope',Q(727,8)<Q(1500,12))
    check('ratio',Q(8,9)+Q(15,8)/Q(239,100)**2<Q(5,4))
    check('low_CS',Q(7,100)*3200*Q(5,4)==280 and 280<17**2)
    check('reciprocal_total',17+2*Q(25,12)*8==Q(151,3))
    check('weight_exponent',35*Q(11,200)<2)
    weight=Q(151,3)*Q(121,16)
    check('weighted_mass',weight==Q(18271,48)<381<436)
    L=Q(2233,100)
    aa=Q(1,500)/L
    dd=Q(1,500)**2/(L*L*(L+10))
    # Independent coarser exp(z)<=1/(1-z) and shorter inverse-exponential polynomial.
    check('lower_endpoint',poly(Q(89,200)*(L-7),24)>900)
    pref=1/(1-dd/2)*(1/(1-Q(111,200)*aa)+Q(1,900))
    check('wider_strip_prefactor',pref<Q(501,500))
    check('sqrt_endpoint',70700**2<5*10**9)
    check('low_error',Q(501,500)*381/70700<Q(27,5000))
    other=sum(map(Q,['.00016','.002001','.000009','.000018','.000000002','.000000000001']))
    check('unchanged_terms',other==Q('0.002188002001') and other/22<Q(1,10000))
    error=(Q(27,5000)+Q(1,10000))*Q(1000001,1000000)
    check('final_upper',error==Q('0.0055000055')<Q('0.005501')<Q('0.0064'))
    check('far_tail',Q('0.0081')/35<Q('0.0064'))
    out=Path(__file__).with_suffix('.json')
    with out.open('x',encoding='utf-8') as f:
        json.dump({'status':'PASS_EXACT_SCALARS_AND_PINS','checks':checks,'pins':PINS,
          'weighted_mass_upper':str(weight),'independent_endpoint_upper':str(pref),
          'error_upper':str(error),'scope':'No source import, analytic evaluation, or Lean proof.'},f,indent=2)
        f.write('\n')
    print(json.dumps({'checks':len(checks),'sha256':sha(out)}))

if __name__=='__main__':main()
