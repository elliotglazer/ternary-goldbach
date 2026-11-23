"""Independent scalar review. No evaluator imports or elementary/function values."""
from fractions import Fraction as F
from math import factorial
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AUTHOR = HERE.parent / 'major-constants'
PINS = {
 'FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md': '50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541',
 'finite_em_rational_elementary_budget_20261111.py': '34CEDFEA0AED31B17BCA3BAE4BE9B244CAFD0A0B4E19D9A197546623E598D9C2',
 'finite_em_rational_elementary_budget_20261111.json': '75989A56D3D376CDDF2573B7938B2B5133ABBC1A3E11B14FFBCA4D9772A017C1',
}
checks = []
def ck(label, condition):
    assert condition, label
    checks.append(label)
def two(e):
    return F(2**e) if e >= 0 else F(1, 2**(-e))
def decode(v):
    return F(int(v['numerator']), int(v['denominator']))
for name, pin in PINS.items():
    ck('pin ' + name, hashlib.sha256((AUTHOR/name).read_bytes()).hexdigest().upper() == pin)
receipt = json.loads((AUTHOR/'finite_em_rational_elementary_budget_20261111.json').read_text())
eta, eps = two(-1024), two(-512)
log_tail = 11 * F(2,1025) * F(1,3)**1025 / (1-F(1,9))
pi_tail = F(16,513*5**513) + F(4,513*239**513)
ck('atanh scaled tail plus rounding', log_tail + eta/2 < eta)
ck('two separate Machin tails plus rounding', pi_tail + eta/2 < eta)
ck('Machin tail dominated by published coarse tail', pi_tail < decode(receipt['pi_tail']))
ck('Machin lower domain has more than eta room',16*(F(1,5)-F(1,375))-F(4,239)-eta > 3)
ck('Machin upper domain has more than eta room',F(16,5)+eta < 4)
ck('rational complex argument size',2001*8 < 2**14)
ck('nearest phase integer bound', F(2**14,6)+F(1,2) < 2**12)
ck('Taylor ratio premise',F(4,514) < F(1,2))
d0=2*F(1,2)**513/factorial(513)
error=d0
for step in range(4):
    ck('real squaring input small '+str(step),error < 1)
    error=error*(2+error)
ck('exact real squaring error below coarse bound',error < 81*d0)
cis=F(2*4**513,factorial(513))+2**13*eta
complex_error=2*81*d0+cis+eta
ck('complex error replay',complex_error == decode(receipt['complex_exp_error']))
ck('complex primitive fits epsilon',complex_error < 2**16*eta < eps)
phase=(3*2001+1)*eps
ck('actual-log phase perturbation',phase < 2**13*eps)
ck('bin ratio perturbation',F(2,3)+F(16,9) < 3)
ck('nearest bin has absolute value at most six',F(16,3)+F(1,2) < 6)
ck('residual perturbation with six',1+F(6,2) <= 4)
ck('residual perturbed domain',F(55,56)+4*eps < 2)
term_bounds=[]
term_sizes=[]
for h in range(16):
    ph=F(8**h,factorial(h))
    dh=F(0) if h == 0 else F(8**(h-1),factorial(h-1))*eps
    for m in range(24):
        rm=F(2**m,factorial(m))
        dm=F(0) if m == 0 else F(2**(m-1),factorial(m-1))*4*eps
        perturb=phase*ph*rm+2*dh*rm+2*ph*dm
        ck('actual factorial term h%d m%d'%(h,m),perturb < 2**82*eps)
        term_bounds.append(perturb)
        term_sizes.append(2*ph*rm)
bucket=1024*max(term_bounds)+eps
ck('independent tighter bucket fits recorded bound',bucket < decode(receipt['bucket_error']) < two(-110))
ck('serialized bucket center bound',1024*max(term_sizes)+eps < 2**80)
fft=F(0)
for stage in range(5):
    fft=(1+2*eps)*fft+2*eps*2**80+eps
ck('FFT exact recurrence replay',fft == decode(receipt['fft_error']))
ck('FFT target gate',fft < 2**87*eps < two(-110))
ck('approximate stage center bound',2**80+fft < 2**81)
horner=(24*32+1)*eps
ck('Horner gate',horner < two(-100))
head=32*24*(bucket+fft)+horner
ck('head arithmetic below recorded bound',head < decode(receipt['head_error']) < two(-98))
cnorm=F(1,2)+16*2**31
qnorm=2002*cnorm+1025
ck('scaled affine norm bound',F(2048,1025) < 2)
ck('scaled correction Q norm',qnorm < 2**48)
ck('exponential coefficient l1 bound',3**8 < 2**13)
corr=qnorm*(2**13*eps*2**13+2**13*eps)+eps
ck('complete correction exact replay',corr == decode(receipt['correction_error']))
ck('correction gate',corr < 2**78*eps < two(-80))
ck('assembly gate',eps < two(-80))
full=two(25)/factorial(24)+2002*head+corr+eps
ck('full midpoint error',full < decode(receipt['full_midpoint_error']) < two(-53))
panel=F(3,2)*(two(-38)+two(-33)/15+two(-52)*F(16,15))/2**10+two(-64)
ck('inherited quotient ledger replay',panel == decode(receipt['panel_error']) < two(-44))
counts={
 'moment_contributions':1024*16*24,
 'bucket_roundings':16*24*32,
 'normalized_transforms':16*24,
 'butterflies':16*24*5*16,
 'fft_output_roundings':16*24*5*32,
 'maximum_horner_affine_roundings':16*8*24,
 'final_horner_scale_roundings':16*8,
 'correction_roundings':16*8,
 'assembly_roundings':16*8,
 'non_elementary_rounding_gates_upper_bound':16*24*32+16*24*5*32+16*8*24+3*16*8,
}
out={
 'scope':'Independent rational scalar checks only; no function values, arrays, transforms, builds or runtime claim.',
 'author_pins':PINS,'check_count':len(checks),'checks':checks,
 'finite_schedule_counts':counts,
 'conditions':'Exact rational algebra between named gates. Matching immutable old centers/boxes is a separate containment obligation. Final quotient evaluation retains its separately checked arithmetic gate.'
}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS',len(checks),'independent scalar checks')
