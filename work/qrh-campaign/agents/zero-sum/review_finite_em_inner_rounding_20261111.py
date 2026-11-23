"""Independent exact scalar/gate-denominator checks, no function evaluation."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
PINS = {
 'major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md':'60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9',
 'major-constants/finite_em_inner_rounding_allocation_20261111.py':'660A180424D4209E3DC588524C256144E2B9E9A1FD6B39A0913D3FDC0A7DE343',
 'major-constants/finite_em_inner_rounding_allocation_20261111.json':'DBBB6A94FF1D74EB86347830E65F559B27DC3596B92F74DC676CABE5C3A1CB99',
}
checks=[]
def check(name,statement):
    assert statement,name
    checks.append(name)
for path,pin in PINS.items():
    check('pin '+path,hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==pin)
old=json.loads((ROOT/'major-constants/finite_em_inner_rounding_allocation_20261111.json').read_bytes())
def rat(value):
    return F(int(value['numerator']),int(value['denominator']))
eta,eps,delta=F(1,2**1024),F(1,2**512),F(1,2**1040)
check('relative inner tolerance',delta==eta/65536)
logtail=F(22,1025*3**1025)*F(9,8)
pitail=F(20,513*5**513)
logerror=logtail+F(77,4)*delta+eta/2
pierror=pitail+F(145,6)*delta+eta/2
check('log tail headroom',logtail<eta/16)
check('pi tail headroom',pitail<eta/16)
check('raw atanh contraction',sum((F(1,9)**k for k in range(512)),F(0))<F(9,8))
check('raw atan contraction',sum((F(1,25)**k for k in range(256)),F(0))<F(25,24))
check('log inner output factor',F(2,3)*F(9,8)+1==F(7,4))
check('atan inner output factor',F(1,5)*F(25,24)+1==F(29,24))
check('log final interface',logerror<eta and logerror==rat(old['log_complete_error']))
check('pi final interface',pierror<eta and pierror==rat(old['pi_complete_error']))
tail=F(2,2**513*factorial(513))
errors=[]
for k in range(5):
    value=3**k*tail+(3*3**k+F(3**k-1,2))*delta
    errors.append(value)
    check('square stage '+str(k),value==rat(old['real_squaring_errors'][k]) and value<1)
check('real final error',errors[4]==81*tail+283*delta and errors[4]<eta)
cis=F(2*4**513,factorial(513))+81*delta+8192*eta
full=2*errors[4]+cis+eta
check('cis norm reserve',cis<1 and cis==rat(old['cis_error']))
check('complex primitive reserve',full<2**16*eta<eps and full==rat(old['complex_error']))
check('source Taylor ratio real',F(1,2*514)<=F(1,2))
check('source Taylor ratio cis',F(4,514)<=F(1,2))

# Symbolic normalized-coefficient recurrence at representative suffixes.
for k in (0,1,255,510,511):
    for j in range(1,513-k):
        check('Horner coefficient k'+str(k)+'j'+str(j),
              F(factorial(k+1),factorial(k+j))/F(k+1)==F(factorial(k),factorial(k+j)))

b,g=1025,1041
d=625*2**1030
check('real scaled argument divisor',d%(F(629,1250*16).denominator*2**b)==0)
for j in range(8):
    imag=F(31999-2*j,16)
    check('imaginary argument divisor '+str(j),d%(imag.denominator*2**b)==0)
check('twiddle and pi reduction divisors',d%(16*2**b)==0 and d%(2**b)==0)
expmax=d*2**g*512
for k in range(1,513):
    check('exp pre-gate bound '+str(k),d*2**g*k<=expmax)
largest_log_den=0
for n in range(1,1026):
    power=2**(n.bit_length()-1)
    t=F(n-power,n+power)
    check('exact atanh reduction '+str(n),0<=t<=F(1,3) and t.denominator<=2049)
    largest_log_den=max(largest_log_den,t.denominator)
check('maximum reduced denominator',largest_log_den==2049)
den={
 'exp_Horner_max_divisor':expmax,
 'atanh_Horner_max_product':2049**2*2**g*1023,
 'atanh_final_multiply_max_product':2049*2**g,
 'atan_Horner_max_product':239**2*2**g*511,
 'atan_final_multiply_max_product':239*2**g,
 'rounded_real_square_divisor':2**(2*g),
 'final_complex_product_divisor':2**(2*g),
 'raw_log_and_Machin_combination_divisor':2**g,
 'canonical_elementary_grid_divisor':2**b,
}
for name,value in den.items():
    check('denominator '+name,value==int(old['denominator_bounds'][name]))
    check('denominator bits '+name,value.bit_length()==old['denominator_bit_lengths'][name] and value.bit_length()<2100)
check('counts exp/log/atan',512+4+512==1028 and 512+1==513 and 256+1==257)
out={'status':'PASS_EXACT_INDEPENDENT_INNER_SCALARS','pins':PINS,
     'scope':'Exact rational error bounds, normalized polynomial coefficient identities and integer denominator checks only. No elementary values, evaluator imports, FFTs or models.',
     'check_count':len(checks),'checks':checks,
     'maximum_denominator_bits':max(v.bit_length() for v in den.values()),
     'interfaces':['log error < 2^-1024','pi error < 2^-1024','complex primitive error < 2^16*2^-1024 < 2^-512']}
HERE.joinpath('review_finite_em_inner_rounding_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps({k:out[k] for k in ('status','check_count','maximum_denominator_bits')}))
