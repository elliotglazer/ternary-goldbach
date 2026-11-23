"""Universal finite-FFT precision constructor; exact scalar parameters only.

No FFT, coefficient array, twiddle table, character, or L-value is generated.
The note proves termination and analytic meaning of the rational tests.
"""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

def parameters(d, B, D, tolerance):
    assert isinstance(d, int) and d >= 0
    B,D,tolerance = map(F,(B,D,tolerance))
    assert B >= 0 and D > 0 and tolerance > 0
    delta = min(F(1,2*(d+1)), 1/((d+1)*(B+2)),
                tolerance/(2*(B+2)*(D*d+1)))
    p=2
    while F(1,2**(p-1)) > delta/4:
        p+=1
    J=2
    def pi_error(j):
        return F(16,(2*j+1)*5**(2*j+1))+F(4,(2*j+1)*239**(2*j+1))
    while pi_error(J) > delta/(4*(D+1)):
        J+=1
    A=F(22,7)
    K=6
    def tail(k):
        return A**(k+1)/factorial(k+1)/(1-A/(k+2))
    while tail(K) > delta/4:
        K+=1

    ep=pi_error(J)
    complex_round=F(1,2**(p-1))
    real_round=F(1,2**p)
    amplification_arg=F(d)*delta/2
    amplification_cap=1/(1-amplification_arg)
    Ecap=d*(B+2)*delta
    output_cap=(B+2)*(D*d+1)*delta
    sharper_output=D*Ecap+delta*(B+Ecap)+delta
    assert amplification_arg < F(1,4)
    assert amplification_cap < 2
    assert Ecap < 1
    assert ep+tail(K)+complex_round < delta
    assert D*ep+real_round < delta
    assert complex_round < delta
    assert sharper_output <= output_cap <= tolerance/2 < tolerance
    assert A/(K+2) < F(1,2)

    # Every J>=2 is enclosed by these same short alternating bounds.
    low2=lambda x:x-x**3/3
    high3=lambda x:low2(x)+x**5/5
    lower=16*low2(F(1,5))-4*high3(F(1,239))
    upper=16*high3(F(1,5))-4*low2(F(1,239))
    assert F(3)<lower<upper<F(22,7)
    return {
        'stages':d,'center_norm_bound':str(B),'scale_bound':str(D),
        'output_tolerance':str(tolerance),'local_delta':str(delta),
        'dyadic_bits':p,'Machin_terms_per_arctan':J,'exponential_degree':K,
        'pi_error_upper':str(ep),'exponential_tail_upper':str(tail(K)),
        'complex_rounding_upper':str(complex_round),
        'twiddle_error_upper':str(ep+tail(K)+complex_round),
        'scale_error_upper':str(D*ep+real_round),
        'stage_amplification_upper':str(amplification_cap),
        'stage_error_upper':str(Ecap),'scaled_output_error_upper':str(output_cap),
        'sharper_scaled_output_error_upper':str(sharper_output),
        'error_to_tolerance_ratio':str(output_cap/tolerance),
        'status':'PASS_EXACT_SCALAR_PARAMETERS_ONLY'}

if __name__=='__main__':
    root=Path(__file__).resolve().parents[3]
    upstream=root/'qrh-blueprint/turing-scalars/auxiliary_fourier_parameters.json'
    rows=json.loads(upstream.read_text(encoding='utf-8'))['rows']
    source=next(r for r in rows if r['conductor']==4 and r['target']=='100000000')
    N=source['radix2_length']
    assert N==2**37 and source['period']=='25700000000'
    e=F(source['tolerance']); D=F(source['dft_norm_cap']); C=F(source['c_target'])
    sample=parameters(37,C+1,D,e/8)
    assert 3*e/(8*D)<1
    boundaries=[parameters(0,0,F(1,10),10),
                parameters(1,F(1,3),F(1,7),F(1,100)),
                parameters(1000,10**40,10**12,F(1,10**100))]
    out={'status':'PASS_UNIVERSAL_RULE_SCALAR_WITNESSES',
         'proof_scope':'Termination for all d>=0,B>=0,D>0,tolerance>0 is proved in the note, not by examples.',
         'auxiliary_c4_H1e8':sample,'additional_scalar_boundary_checks':boundaries,
         'input_rounding_target':source['per_coefficient_rounding_target'],
         'no_fft':True,'no_twiddle_table':True,'no_spectral_data':True}
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    print('PASS: c4,H1e8:', {k:sample[k] for k in ('dyadic_bits','Machin_terms_per_arctan','exponential_degree','error_to_tolerance_ratio')})
    print('Boundary scalar checks passed; universal termination is a separate paper proof.')
