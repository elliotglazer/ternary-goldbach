"""Exact scalar parameter checks only: no characters, L-values, arrays or FFTs."""
from fractions import Fraction as F
from pathlib import Path
import json,hashlib,sys

def choose(c,H,eps):
    assert isinstance(c,int) and c>1 and H>=0 and eps>0
    H=max(F(1),F(H));eps=F(eps)
    K=1
    while 24*c*c*F(3,8)**K>=eps/4:K+=1
    L=1
    while 18*c*F(3,8)**L>=eps/4:L+=1
    x=1
    while F(8,3)**(2*x)<c*(2*x+L):x+=1
    P=2*H+4*K
    N=2
    while N<P*x/3:N*=2
    D=F(88*x,21)
    assert P>=6 and P>2*H and P*x/3>=2
    assert N>=P*x/3 and N<2*P*x/3
    assert N&(N-1)==0
    n0=1
    while True:
        V=F(3*n0*n0,c);z=F(3*(2*n0+1),c)-F(1,n0)
        if z>0 and V>=2:
            q=V.numerator//V.denominator
            series=D*2*n0*(1+1/z)*F(3,8)**q
            if series<eps/4:break
        n0*=2
    time=24*c*c*F(3,8)**K
    freq=18*c*F(3,8)**L
    total=time+freq+series+eps/8+eps/8
    assert total<eps
    return {'c':c,'H_used':str(H),'tolerance':str(eps),'K':K,'L':L,'x':x,
            'period':str(P),'N_integer_only_no_array':N,'omega_N_upper':str(D),
            'first_omitted_Gaussian_n':n0,'V':str(V),'z':str(z),
            'time_upper':str(time),'frequency_upper':str(freq),'series_output_upper':str(series),
            'rounding_per_coefficient_target':str(eps/(8*D)),
            'finite_transform_error_target':str(eps/8),'total_upper':str(total),
            'fraction_of_tolerance_diagnostic':float(total/eps)}

cases=[(3,F(10),F(1,10**12)),(101,F(1000),F(1,10**30)),
       (300000,F(10**8),F(1,10**40)),(4,F(0),F(10))]
out={'status':'PASS_EXACT_PARAMETER_CHECKS_ONLY',
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     'cases':[choose(*case) for case in cases],
     'scope':'Only sufficient rational error-budget inequalities. No actual coefficients, FFT, nonvanishing or spectral evidence.'}
if '--recompute' not in sys.argv:
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
