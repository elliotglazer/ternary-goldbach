"""Exact scalar errors and denominator bounds only; no elementary values."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

def p2(k): return F(2**k) if k>=0 else F(1,2**(-k))
checks=[]
def ck(label,p):
    assert p,label
    checks.append(label)

eta=p2(-1024); epsilon=p2(-512); delta=p2(-1040)
log_tail=11*F(2,1025)*F(1,3)**1025/(1-F(1,9))
pi_tail=F(20,513*5**513)
log_horner=F(9,8)*delta
log_output=F(2,3)*log_horner+delta
ck('atanh output gate error',log_output==F(7,4)*delta)
log_complete=log_tail+11*log_output+eta/2
ck('log tail unchanged',log_tail<eta/16)
ck('canonical log error below eta',log_complete<eta)
atan_horner=F(25,24)*delta
atan_output=atan_horner/5+delta
ck('arctangent output gate error',atan_output==F(29,24)*delta)
pi_complete=pi_tail+20*atan_output+eta/2
ck('Machin weighted inner rounding',20*atan_output==F(145,6)*delta)
ck('pi tail unchanged',pi_tail<eta/16)
ck('canonical pi error below eta',pi_complete<eta)

real_tail=2*F(1,2)**513/factorial(513)
real_errors=[real_tail+3*delta]
for i in range(4):
    ck(f'real squaring small-error hypothesis stage{i}',real_errors[-1]<1)
    real_errors.append(3*real_errors[-1]+delta)
real_error=real_errors[-1]
ck('four-squaring closed bound',real_error==81*real_tail+283*delta)
ck('real exponential error below eta',real_error<eta)
cis_tail=F(2*4**513,factorial(513))
cis_error=cis_tail+81*delta+2**13*eta
complex_error=2*real_error+cis_error+eta
ck('cis center norm below two',cis_error<1)
ck('complex primitive old interface',complex_error<2**16*eta<epsilon)
ck('geometric log Horner factor',F(1)/(1-F(1,9))==F(9,8))
ck('geometric atan Horner factor',F(1)/(1-F(1,25))==F(25,24))
ck('common phase denominator covers unscaled arguments',(625*2**1030)%(625*2**1029)==0)
ck('common phase denominator covers reduced imaginary arguments',(625*2**1030)%(2**1029)==0)

g=1041
d=625*2**1030
denoms={
 'exp_Horner_max_divisor':d*2**g*512,
 'atanh_Horner_max_product':2049**2*1023*2**g,
 'atanh_final_multiply_max_product':2049*2**g,
 'atan_Horner_max_product':239**2*511*2**g,
 'atan_final_multiply_max_product':239*2**g,
 'rounded_real_square_divisor':2**(2*g),
 'final_complex_product_divisor':2**(2*g),
 'raw_log_and_Machin_combination_divisor':2**g,
 'canonical_elementary_grid_divisor':2**1025,
}
bits={k:v.bit_length() for k,v in denoms.items()}
ck('all stated pre-gate denominator bounds below2100bits',max(bits.values())<2100)
ck('exp gate exact bound',bits['exp_Horner_max_divisor']==2090)
ck('atanh gate exact bound',bits['atanh_Horner_max_product']==1073)
ck('Machin gate exact bound',bits['atan_Horner_max_product']==1066)
ck('quadratic denominator bound',bits['rounded_real_square_divisor']==2083)
ck('polynomial local magnitude bound',3**4==81 and 1+4*82==329)

def enc(x):
    if isinstance(x,F):return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
    if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
    if isinstance(x,list):return [enc(v) for v in x]
    return x

data=dict(scope='Scalar-only new inner schedule; no elementary witness generation or values',
 delta=delta,eta=eta,epsilon=epsilon,log_complete_error=log_complete,
 pi_complete_error=pi_complete,real_squaring_errors=real_errors,
 cis_error=cis_error,complex_error=complex_error,
 denominator_bounds=denoms,denominator_bit_lengths=bits,
 checks=checks,check_count=len(checks))
Path(__file__).with_suffix('.json').write_text(json.dumps(enc(data),indent=2)+'\n',encoding='utf-8')
print(f'PASS {len(checks)} exact checks; outer elementary interfaces preserved; pre-gate denominators <2100 bits.')
