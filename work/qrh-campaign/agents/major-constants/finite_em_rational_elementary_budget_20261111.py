"""Scalar bounds only: never computes log/exp/FFT/model values."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import json

def p2(k):
    return F(2**k) if k >= 0 else F(1, 2**(-k))

checks=[]
def ck(label, cond):
    assert cond, label
    checks.append(label)

eta=p2(-1024)
eps=p2(-512)
log_tail=11*F(2,1025)*F(1,3)**1025/(1-F(1,9))
pi_tail=F(20,513*5**513)
ck('512-term binary-scaled log tail',log_tail<eta/16)
ck('256-term Machin tail',pi_tail<eta/16)
ck('log/pi with named rational-to-dyadic rounding',max(log_tail,pi_tail)+eta/2<eta)
ck('Machin coarse lower endpoint',16*(F(1,5)-F(1,375))-F(4,239)>3)
ck('Machin coarse upper endpoint',F(16,5)<4)
ck('phase input size',2001*8<2**14)
ck('integer phase reduction bound',F(2**14,6)+F(1,2)<2**12)
ck('reduced Taylor domain',F(4,514)<F(1,2))
real_tail=2*F(1,2)**513/factorial(513)
real_error=3**4*real_tail
cis_error=F(2*4**513,factorial(513))+2**13*eta
complex_error=2*real_error+cis_error+eta
ck('four real-exp squarings stay within small-error regime',real_error<eta)
ck('complex exp elementary budget',complex_error<2**16*eta<eps)

phase_error=(3*2001+1)*eps
ck('log propagated through main phase',phase_error<2**13*eps)
ck('bin midpoint error below 1/8',3*eps<F(1,8))
ck('coarse bin integer bound',F(2*8,3)+F(1,2)<6)
ck('approximate residual magnitude below two',F(55,56)+4*eps<2)
P_error=15*8**14*eps
R_error=23*2**22*4*eps
term_error=2**13*eps*2**45*2**23+2*P_error*2**23+2*2**45*R_error
ck('log-power perturbation',P_error<2**46*eps)
ck('residual-power perturbation',R_error<2**29*eps)
ck('moment-term perturbation',term_error<2**82*eps)
bucket_error=1024*term_error+eps
ck('bucket radius',bucket_error<2**93*eps<p2(-110))
ck('bucket center size',1024*2**69+eps<2**80)

twiddle=4*eps
fft_error=F(0)
for stage in range(5):
    fft_error=(1+twiddle/2)*fft_error+twiddle*2**80/2+eps
ck('five-stage normalized FFT radius',fft_error<2**87*eps<p2(-110))
ck('computed FFT centers remain bounded',2**80+fft_error<2**81)
contraction=769*eps
ck('residual Horner and final scale rounding',contraction<p2(-100))
head_error=32*24*(bucket_error+fft_error)+contraction
ck('main jet arithmetic',head_error<p2(-98))

Cnorm=F(1,2)+16*2**31
Qnorm=2002*Cnorm+1025
ck('scaled correction polynomial',Cnorm<2**36 and Qnorm<2**48)
ck('exp8 coarse bound',3**8<2**13)
corr_error=Qnorm*(2**13*eps*2**13+2**13*eps)+eps
ck('complete correction coefficient',corr_error<2**78*eps<p2(-80))
ck('final assembly rounding',eps<p2(-80))
full_mid=p2(25)/factorial(24)+2002*head_error+corr_error+eps
ck('full coefficient midpoint error including analytic batching',full_mid<p2(-53))
rho=F(1,16)
panel=F(3,2)*(p2(-38)+p2(-33)/15+p2(-52)/(1-rho))/2**10+p2(-64)
ck('inherited whole-panel quotient budget',panel<p2(-44))

def enc(x):
    if isinstance(x,F): return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
    if isinstance(x,dict): return {k:enc(v) for k,v in x.items()}
    if isinstance(x,list): return [enc(v) for v in x]
    return x

data=dict(scope='Scalar-only sufficient allocation; no elementary values or evaluator execution.',
          internal_eta=eta,external_epsilon=eps,log_terms=512,machin_terms_each=256,
          real_exp_terms=513,real_exp_squarings=4,cis_terms=513,
          log_tail=log_tail,pi_tail=pi_tail,complex_exp_error=complex_error,
          bucket_error=bucket_error,fft_error=fft_error,head_error=head_error,
          correction_error=corr_error,full_midpoint_error=full_mid,panel_error=panel,
          checks=checks,check_count=len(checks))
Path(__file__).with_suffix('.json').write_text(json.dumps(enc(data),indent=2)+'\n',encoding='utf-8')
print(f'PASS {len(checks)} scalar checks; all existing fixed-pilot radius gates fit.')
