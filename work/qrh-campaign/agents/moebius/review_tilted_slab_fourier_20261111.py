"""Independent exact tilted-slab audit; no Fourier arrays or spectral data."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE=Path(__file__).resolve().parent
SRC=HERE.parent/'zero-sum'
PINS={
 'TILTED_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md':'695BF1B9AE43BDDA950F111D8A484B35DE774578B6F5A14012763740E28848AE',
 'tilted_right_slab_parameters_20261111.py':'15D058DED942333655F3F8599FA9A893A945E18063970BFC69532F95453E1FDD',
 'tilted_right_slab_parameters_20261111.json':'1D009682FFA399B9E9B1A93C81022E4C9A87BB92C74573C52B9801A11C65546B'}
for name,pin in PINS.items():
    assert hashlib.sha256((SRC/name).read_bytes()).hexdigest().upper()==pin
checks=[]
def ck(label,value):
    assert value,label
    checks.append(label)
def first(pred,start=1):
    hi=start
    while not pred(hi): hi*=2
    lo=start-1
    while hi-lo>1:
        mid=(lo+hi)//2
        if pred(mid):hi=mid
        else:lo=mid
    return hi

def construct(c,height,tol):
    H=max(F(1),F(height));B=c*H;e=F(tol)
    K=first(lambda k:32*B*B*F(3,8)**k<e/4)
    L=first(lambda k:12*B*F(3,8)**k<e/4)
    x=first(lambda k:F(8,3)**(2*k)>=B*(2*k+L))
    P=(2+4*K)*H
    N=2**first(lambda j:2**j>=P*x/3)
    D=F(88*x,21)
    def tail(n):
        V=3*n*n/B;z=3*(2*n+1)/B-F(1,n)
        if V<2 or z<=0:return None
        return D*2*n*(1+1/z)*F(3,8)**(V.numerator//V.denominator)
    n=next(2**k for k in range(1000) if tail(2**k) is not None and tail(2**k)<e/4)
    V=3*n*n/B;z=3*(2*n+1)/B-F(1,n)
    time=32*B*B*F(3,8)**K;freq=12*B*F(3,8)**L;series=tail(n)
    total=time+freq+series+e/4
    tag=f'c{c},H{H},eps{e}'
    ck(tag+' time exponent and denominator',F(3,8*H)*(P-H)>K and F(3,8*H)*P>1)
    ck(tag+' power of two and period',P>=6 and P>2*H and N>=P*x/3 and N<2*P*x/3)
    ck(tag+' error allocation',max(time,freq,series)<e/4 and total<e)
    ck(tag+' corrected normalized-DFT split',D*(e/(16*D))+e/16==e/8)
    ck(tag+' unscaled e/8 would be insufficient',D>1 and D*e/8>e/8)
    Rpi=F(1,4)-F(1,8*H)
    for sign in (-1,1):
        bpi=sign*F(1,4)*(1-1/H)
        ck(tag+f' signed shift {sign}',Rpi-abs(bpi)==F(1,8*H) and Rpi<F(1,4))
    ck(tag+' cosine sine lower bound arguments',F(1,2)-2*Rpi==F(1,4*H))
    M=2*B*B
    for r0 in (F(1,10**40),F(10**30)):
        dF=min(F(1),r0/(8*c*c));dA=min(F(1),r0/(8*(M+1)))
        ck(tag+f' product allocation {r0}',c*c*dF+(M+dF)*dA<=r0/4)
        ck(tag+f' panel allocation {r0}',r0/2+2*c**4*H**2*(r0/(4*c**4*H**2))==r0)
    return {'c':c,'H0':str(H),'B':str(B),'F_tolerance':str(e),'K':K,'L':L,'x':x,
            'P':str(P),'N_integer_only':N,'omega_N_bound':str(D),'first_omitted_n':n,
            'V':str(V),'z':str(z),'time_bound':str(time),'frequency_bound':str(freq),
            'series_output_bound':str(series),'rounding_per_coefficient_target':str(e/(8*D)),
            'finite_transform_error_target':str(e/8),'total_bound':str(total),
            'Z_derivative_bound':str(2*c**4*H**2)}

old=json.loads((SRC/'tilted_right_slab_parameters_20261111.json').read_text())
matched=[]
for row in old['cases']:
    new=construct(row['c'],F(row['H0']),F(row['F_tolerance']))
    ck(f'exact frozen row c{row["c"]}',all(new[k]==row[k] for k in new))
    matched.append(new)
extra=[construct(c,H,e) for c,H,e in [(2,0,10**12),(2,10**6,F(1,10**50)),
       (7,F(13,4),F(17,3)),(999,10**9,F(1,10**20))]]
ck('x search growth',F(64,9)*F(3,5)>1)
ck('series eventual decay',2*F(3,8)**3==F(27,256)<1)
for B in (F(2),F(35,3),F(999,4),F(3*10**13)):
    n=-(-B.numerator//B.denominator)
    ck(f'rational B termination {B}',3*(2*n+1)/B-F(1,n)>6 and 3*n*n/B>=3*n)
out={'scope':'Independent rational parameters and normalization scalar audit only',
     'producer_pins':PINS,'passed_checks':len(checks),'checks':checks,
     'matching_rows':matched,'additional_rows':extra,
     'transform_contract':'e/8 bounds error after the final omega or omega*N scaling'}
(HERE/'review_tilted_slab_fourier_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'passed_checks':len(checks),'matching_rows':len(matched),'additional_rows':len(extra)}))
