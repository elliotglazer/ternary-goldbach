"""Exact rational comparison of paper central envelopes, not a Lean certificate."""
from fractions import Fraction as F
from math import factorial,isqrt,log,floor,ceil
import json
from pathlib import Path

def exp_bounds(x,N=256):
    term=F(1);s=term
    for k in range(1,N+1):term*=x/k;s+=term
    nxt=term*x/(N+1)
    return s,s+nxt/(1-x/F(N+2))
def log_bounds(x):
    scale=10**6
    lo=F(floor(log(float(x))*scale),scale);hi=lo+F(1,scale)
    assert exp_bounds(lo)[1] < x < exp_bounds(hi)[0]
    return lo,hi
def sqrt_bounds(x):
    D=10**18;k=isqrt(x.numerator*D*D//x.denominator)
    return F(k,D),F(k+1,D)
def root_floor(x,k):
    lo=0;hi=1
    while F(hi)**k<=x:hi*=2
    while hi-lo>1:
        mid=(hi+lo)//2
        if F(mid)**k<=x:lo=mid
        else:hi=mid
    return F(lo)
def mass_poly(a,b,N):
    term=F(1);s=F(0)
    for k in range(N+1):
        if k:term*=-F(1,2*k)
        s+=term*(b**(2*k+3)-a**(2*k+3))/(2*k+3)
    return s
Y=F('1e25');tail=F('.000709002');v=F(1001,192)
assert exp_bounds(F(60))[0] > Y/20
assert 3*F(60)/(Y/20) < F('1e-20')
assert exp_bounds(F(32))[0] > 10**13
assert 17*F('.05')**3/3 + 17*F(65,8)/10**13 < tail
assert exp_bounds(F(2))[1] < 180180
bins=[('.05','.25','.69'),('.25','.5','.66'),('.5','1','.64'),('1','2','.70'),('2','3','.72'),('3','4','.74'),('4','6','.78'),('6','8','.80')]
ldata=[]
for aa,bb,cc in bins:
    a,b,c=map(F,(aa,bb,cc));z=a*Y;tmax=max(F(300000),300000*b)
    root=root_floor(z,3)
    ln_hi=log_bounds(4*tmax)[1]
    ld_lo=log_bounds(9*root/(F('2.004')*tmax))[0]
    assert 0<ld_lo and exp_bounds(c)[0]>1+ln_hi/(2*ld_lo)
    # Integral Taylor remainder: odd polynomial lower, even polynomial upper.
    mlo=mass_poly(a,b,257);mhi=mass_poly(a,b,256)
    assert 0<mlo<=mhi and mhi-mlo<F('1e-100')
    ldata.append((a,b,c,z,mhi))
results=[]
for q in [90090,120120]:
    t=F(2*q);llo,lhi=log_bounds(t);log2lo,log2hi=log_bounds(F(2))
    raw=tail;finbin=tail;rows=[]
    for a,b,c,z,mhi in ldata:
        p=((c+F('.5'))*lhi+F('.002')*c+log2hi)*(F('.30214')*lhi+F('.7468'))
        main=sqrt_bounds(v/t*p)[1]
        low=F('2.5257')*sqrt_bounds(1/t)[1]+F('13.2')*v/t+2*(F('16.267')*lhi+F('24.42'))/t
        rem=F('3.77')/root_floor(z,6)+F('1e-20')
        B=main+low+rem
        R=F('.41415')+F('.27125')*c
        Bfin=(R*lhi+F('.8764'))*sqrt_bounds(v/t)[1]+F('2.526')*sqrt_bounds(1/t)[1]+2/t*(v*(F('3.25')*lhi+F('7.82'))+F('13.66')*lhi+F('37.55'))+F('3.8')/root_floor(z,6)
        raw+=mhi*B;finbin+=mhi*Bfin
        rows.append({'w':[str(a),str(b)],'C_bound':str(c),'mass_upper':float(mhi),'raw_B_upper':float(B),'raw_contribution':float(mhi*B)})
    broadlo=F('1.254')*((F('.68')*llo+F('.8764'))*sqrt_bounds(v/t)[0]+F('2.526')*sqrt_bounds(1/t)[0]+2/t*(v*(F('3.25')*llo+F('7.82'))+F('13.66')*llo+F('37.55'))+F('.000428'))+tail
    assert raw<F('.9')*broadlo
    assert raw < F('.067108' if q==90090 else '.058903')
    results.append({'q':q,'v':str(v),'raw_integrated_upper':float(raw),'binned_final_upper':float(finbin),'broad_U_lower':float(broadlo),'gain_lower':float(1-raw/broadlo),'rows':rows})
print(json.dumps(results,indent=2))
Path(__file__).with_name('base_gap_raw_comparison_results.json').write_text(json.dumps(results,indent=2))
print('All exact inequalities passed, including raw upper < .9 * broad U lower for both Q.')

