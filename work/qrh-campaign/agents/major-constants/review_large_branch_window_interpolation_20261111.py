"""Independent rational witnesses and source pins; no analytic values or builds."""
from fractions import Fraction as Q
from pathlib import Path
from math import factorial
import hashlib,json

AG=Path(__file__).resolve().parents[1]
checks=[]
def check(name,p):
    assert p,name
    checks.append(name)
pins={
'audit/LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md':'DA67CB3B463FED71B6545CD13DF374B7713924DFA92C44B37E83862FBA4CCE69',
'audit/large_branch_window_interpolation_20261111.py':'117F621DFA28E17605D9FDA022FE616C98A1D0091D603196B3D5607A5BD16C2B',
'audit/large_branch_window_interpolation_20261111.json':'0DCB23EFB7A5C9ED3B7D2B748557FC623E33F852FF2E71AAB9BFA113EF71E700',
'audit/platt_turing_1305_3087.pdf':'8FD109AA21345BC3FEAC4FDE2FAA7DFB51B4EF1FC9A430F643323612A39EF417',
'audit/platt_turing_1305_3087.txt':'2A2EABBCA321E6B29BC3E0BAE4339245C819B5234C0C4CC222C65E981E84E3E9',
'audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
'zero-sum/REVIEW_LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'F6F38CBFC4237AB0C4AAC978EF1D0157754DFAA461D01FC3D54D921B1FE45D54',
'prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md':'06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E'}
for rel,h in pins.items():check('pin '+rel,hashlib.sha256((AG/rel).read_bytes()).hexdigest().upper()==h)
stored=json.loads((AG/'audit/large_branch_window_interpolation_20261111.json').read_text())
check('saved scope',not stored['sign_success'])
check('saved parameters',stored['parameters']=={'delta':'5/64','B':'32/5','h':1,'m':256,'max_conductor':265800,'max_target_height':7000})

# e^(7/10)>2 follows from a strict positive Taylor lower polynomial.
T=sum((Q(7,10)**j/Q(factorial(j)) for j in range(7)),Q(0))
check('Taylor witness',T>2)
# Elementary source constants use only 3<pi<4, e<3, and the zeta integral test.
check('zeta9/8 integral-test bound',1+1/Q(1,8)==9)
check('zeta2 integral-test bound',1+1/Q(1)==2)
check('zeta3 integral-test bound',1+1/Q(2)<2)
check('first Gamma factor coarse bound',2*2*3<16)
check('second Gamma sqrt bound',8<3**2)
check('second Gamma exponential exponent',Q(4,8)+Q(1,4)<1)
check('second Gamma factor coarse bound',3*3<16)
check('growth coefficient',9*16==144)
check('growth exponent',Q(5,16)+Q(1,4)==Q(9,16)<1)
check('sqrt2pi inverse below half',2*3>4)
check('inverse2sqrt2 below half',2>1)
check('Pbar bound',4*(7000+2)<2**15)

Delta=Q(5,64);bandwidth=1/(2*Delta)
check('Weiss normalization',bandwidth==Q(32,5) and 2*bandwidth*Delta==1)
c=265800
check('conductor cap',c<2**19)
check('even conductor-power cap',c*c<2**38)
rows=[]
for parity,M,prefbits,power in [(1,Q(3,2),34,80),(0,Q(5,2),53,132)]:
    sigma=M+Q(1,2)
    check('contour Gamma real part '+str(parity),(sigma+parity)/2==Q(3,2))
    check('contour absolute convergence '+str(parity),sigma==3-parity and sigma>1)
    conductorcap=2**19 if parity else 2**38
    pref=Q(2*conductorcap*2*2**15)/(3*M)
    decay=2*3*bandwidth*M-M*M/2
    check('prefactor '+str(parity),pref<2**prefbits)
    check('negative exponent '+str(parity),decay>power*Q(7,10))
    rows.append({'parity':parity,'M':str(M),'prefactor_upper':str(pref),
                 'decay_lower':str(decay),'tail_binary_exponent':prefbits-power})
check('odd Fourier bound',rows[0]['tail_binary_exponent']==-46)
check('even Fourier bound',rows[1]['tail_binary_exponent']==-79)

m=256;z=m*Delta
check('sample distance',z==20)
check('decreasing sample envelope minimum',z*(2+z)>1)
ratio_exponent=z*Delta+Delta*Delta/2
check('ratio exponential witness',ratio_exponent>2*Q(7,10))
check('ratio polynomial witness',1+Delta/(2+z)<2)
check('tail Gaussian witness',z*z/2>285*Q(7,10))
check('tail polynomial witness',2+7000+z<2**13)
tailpref=2*144*2**19*2**13*2
check('tail prefactor',tailpref<2**42)
check('tail exponent',42-285==-243)
check('sample count',2*m+1==513)
check('left t0zero guard',-m*Delta==-20)
guard=Q(424195,64)+257*Delta
check('current maximum guarded analytic cap',guard<7000)
check('target7000 is not guarded',7000+m*Delta>7000)
check('Fourier target gap',Q(1,2**46)>Q(1,2**82))
check('combined analytic allowance',Q(1,2**46)+Q(1,2**243)<Q(1,2**45))
check('author saved allowances',stored['Fourier_error_upper']=='2^-46' and stored['sample_tail_upper']=='2^-243')

# Formal completion-of-square coefficients, with lambda,h,t0 as rational symbols
# specialized only to test the polynomial sign convention. The proof is in the note.
for lam,h,t0 in [(Q(1),Q(1),Q(0)),(Q(3,7),Q(5,2),Q(11,3))]:
    shifted=t0-lam*h*h
    original=[-t0*t0/(2*h*h),t0/(h*h)-lam,-1/(2*h*h)]
    moved=[-lam*t0+lam*lam*h*h/2-shifted*shifted/(2*h*h),shifted/(h*h),-1/(2*h*h)]
    check('Gaussian shift polynomial '+str((lam,h,t0)),original==moved)
out={'scope':'Source/conditional paper review only; no values or sign success.',
     'pins':pins,'checks':checks,'count':len(checks),'fourier_rows':rows,
     'Taylor_lower_at_7_over_10':str(T),'tail_ratio_exponent_lower':str(ratio_exponent),
     'guarded_current_max':str(guard),'sample_radius':'20','finite_samples':513,
     'analytic_allowance':'2^-46+2^-243','full_2^-82_tolerance_proved':False}
path=Path(__file__).with_suffix('.json')
with path.open('x',encoding='utf-8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'sha256':hashlib.sha256(path.read_bytes()).hexdigest().upper()},indent=2))
