"""Exact tilted Fourier parameter checks; no L-values, grids or FFT arrays."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json,sys

def parameters(c,H,tol):
    assert isinstance(c,int) and c>1 and H>=0 and tol>0
    H=max(F(1),F(H));B=c*H;tol=F(tol)
    K=L=x=1
    while 32*B*B*F(3,8)**K>=tol/4:K+=1
    while 12*B*F(3,8)**L>=tol/4:L+=1
    while F(8,3)**(2*x)<B*(2*x+L):x+=1
    P=(2+4*K)*H;N=2
    while N<P*x/3:N*=2
    D=F(88*x,21)
    assert P>=6 and P>2*H and P*x/3>=2
    assert F(3,8*H)*(P-H)>K
    assert F(3,8*H)*P>1
    assert N>=P*x/3 and N<2*P*x/3 and N&(N-1)==0
    n0=1
    while True:
        V=3*n0*n0/B;z=3*(2*n0+1)/B-F(1,n0)
        if V>=2 and z>0:
            series=D*2*n0*(1+1/z)*F(3,8)**(V.numerator//V.denominator)
            if series<tol/4:break
        n0*=2
    time=32*B*B*F(3,8)**K;freq=12*B*F(3,8)**L
    total=time+freq+series+tol/4
    assert total<tol
    # Pure scalar consequences used in the analytic proof.
    assert B>=2 and F(1,2*H)>0
    assert 2*c**4*H**2>=2*c**3*H**2
    return {'c':c,'H0':str(H),'B':str(B),'F_tolerance':str(tol),
            'K':K,'L':L,'x':x,'P':str(P),'N_integer_only':N,'omega_N_bound':str(D),
            'first_omitted_n':n0,'V':str(V),'z':str(z),
            'time_bound':str(time),'frequency_bound':str(freq),'series_output_bound':str(series),
            'rounding_per_coefficient_target':str(tol/(8*D)),
            'finite_transform_error_target':str(tol/8),'total_bound':str(total),
            'Z_derivative_bound':str(2*c**4*H**2),
            'fraction_of_tolerance_diagnostic':float(total/tol)}

cases=[(3,F(10),F(1,10**12)),(101,F(1000),F(1,10**30)),
       (300000,F(10**8),F(1,10**40)),(4,F(0),F(10)),(5,F(7,3),F(1,1234567))]
out={'status':'PASS_EXACT_TILTED_PARAMETER_CHECKS_ONLY',
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     'cases':[parameters(*q) for q in cases],
     'scope':'No character, transform coefficients, FFT, contour or spectral truth computed.'}
if '--recompute' not in sys.argv:Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'status':out['status'],'rows':[{k:r[k] for k in ['c','H0','K','L','x','N_integer_only','first_omitted_n','fraction_of_tolerance_diagnostic']} for r in out['cases']]},indent=2))
