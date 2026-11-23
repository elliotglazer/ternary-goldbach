"""Independent rational-only review. No author execution or analytic values."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
AUTHOR = HERE.parent / 'major-constants'
names = {
    'COUPLED_PLUS_HEIGHT_CUBIC_BUDGET_2026-11-11.md': '6767F9E14E5B6D7264D972085EA9C70359C87544403D37DAE315CBEF2510FC54',
    'coupled_plus_height_budget_20261111.py': '48310E18F09209DC367261E68B259F21A49AE3D5F0C698F1A0844A7B8730A94A',
    'coupled_plus_height_budget_20261111.json': '0223AE0090DFB1FF7C8DEC1CD67523BA388F8A943AEA3D1CFEBFA720295BB213',
}
checks = {}
def ck(key, condition):
    assert condition, key
    checks[key] = True
def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()
for name, pin in names.items():
    ck('author_pin_' + name, sha(AUTHOR / name) == pin)
data = json.loads((AUTHOR / 'coupled_plus_height_budget_20261111.json').read_text())
for path, pin in data['input_sha256'].items():
    ck('dependency_' + path, sha(ROOT / path) == pin)

def lower_exp(z):
    # Independent degree-20, 128-piece positive Taylor lower witness.
    term = total = F(1)
    for k in range(1, 21):
        term *= z / (128*k)
        total += term
    return total**128

Z, C, a, K = F('177.26'), F('.09'), F('1.371'), F(393400)
ib, eb = F('2.1768'), F('4.6e-16')
ck('IA_constant', 1+F('3.1416')/F('8.492') < a)
ck('IA_inverse_conductor', F('3.1416')*1063200/F('8.492') < K)
ck('growth_at_455', F('48.4') <= C*455*F('1.2039'))
ck('EB_independent_polynomial', F('.892')*255 < eb*lower_exp(F('.1598')*255))
specs = [(2,100,'23','1.414','10','1.061e-22'),
         (100,1000,'21.5','10','32','1.133e-19'),
         (1000,10000,'20.5','31.62','100','9.023e-18'),
         (10000,265800,'19.5','100','516','5.781e-16')]
rows=[]
for index, (lo,hi,us,ls,rs,es) in enumerate(specs):
    u,l,r,e = map(F, (us,ls,rs,es))
    ck(f'band_{index}_square_roots', 0<l and l*l<=lo and hi<=r*r)
    ck(f'band_{index}_EA_independent_polynomial', F('.588')*u*u < e*lower_exp(F('.1065')*u*u))
    # Independent coefficient expansion, retaining the c^(-3/2) contribution.
    linear = 2*Z*a+2*C*a*a
    inverse = 2*K*(Z+2*C*a)
    cubic = 2*C*K*K
    g = linear*r + inverse/l + cubic/(lo*l)
    val = F('129.24')*(516*eb*(2*Z*ib+2*C*ib*ib)+e*g)
    saved=data['bands'][index]
    ck(f'band_{index}_stored', (lo,hi,str(u),str(l),str(r),str(e),str(g),str(val)) ==
       tuple(saved[k] for k in ['c_lower','c_upper_for_bound','u','sqrt_lower','sqrt_upper','EA_upper','G_upper','scaled_E2_upper']))
    ck(f'band_{index}_E2', val<F('1.49e-7'))
    rows.append({'band':index,'E2_upper':str(val),'reserve':str(F('1.49e-7')-val)})
ck('sqrt_c_global',265800<516**2)
ck('sqrt_x',F('2.21e13')**2<F('4.9e26'))
ck('E1',F('7.66e6')/F('2.21e13')<F('3.47e-7'))
ck('four_error_plus_inner_removal',F('3.47e-7')+F('1.49e-7')+F('2e-17')+F('516e-15')<F('5e-7'))
rho=F('5.75e-7')
ck('positive_rho_reserve',rho>F('516e-15'))
ck('orthogonal_plus',F('5e-7')**2+F('2.83e-7')**2<(rho-F('516e-15'))**2)
ck('integrated_residual',16*150000*19*rho*rho<F('.006')**2)
aa=F('.640208')*F('13.59756')
ck('principal_X_root',aa<F('2.951')**2)
ck('new_X', (F('2.951')+F('.006'))**2<F('8.79'))
cc=F(49,9)*(F('8.79')+aa)+F(9,2)*F('7.78')*F('2.85')
ck('C_identity',cc==F(914205504131,4687500000))
old=F('8.79')*F('3.67e-6')+F('8.85e-7')*cc
ck('old_budget',old==F(64019155993729,312500000000000000))
ck('j_root',F('2.965')**2>F('8.79'))
ck('B_root',F('43.762')**2>1915)
joint=F('2.965')*(F('1.902e-6')+F('3e-6')+rho*F('43.762'))+rho*cc
ck('joint_pass',joint<old)
ck('joint_receipt',str(joint)==data['joint_upper'] and str(old-joint)==data['joint_reserve'])
ck('base_odd',F('19.5')*3*531600>27000000)
ck('base_even',F('19.5')*3*1063200>54000000)
ck('star_slope',F('19.5')*3>F(704,343))

def ceilfrac(n,d):
    return (n+d-1)//d
def heights(c):
    # Pure integer ceilings, independent of the author's Fraction/ceil recipe.
    qt=c if c%2==0 else 2*c
    u10=230 if c<100 else 215 if c<1000 else 205 if c<10000 else 195
    new=200+max(255,ceilfrac(31416*u10*1063200,100000*qt))
    old100=1989 if c%2==0 and c>60000 else 2330
    prev=200+max(260,ceilfrac(31416*old100*1063200,1000000*qt))
    return new,prev
for ex in data['examples']:
    n,p=heights(ex['c'])
    ck('height_example_'+str(ex['c']), n==ex['candidate_height'] and p==ex['fallback_height'])
all_profile=True
for c in range(2,265801):
    n,p=heights(c)
    qt=c if c%2==0 else 2*c
    base=ceilfrac(54000000 if c%2==0 else 27000000,c)
    star=max(300,ceilfrac(704*1063200,343*qt))
    all_profile &= 455<=n<=p and n>=base and n>=star
ck('all_integer_profiles_265799',all_profile)
out={'scope':'independent exact scalar and integer metadata; no analytic values',
     'checks':checks,'count':len(checks),'bands':rows,'joint_reserve':str(old-joint),
     'author_pins':names,'dependency_pins':data['input_sha256']}
(HERE/'review_coupled_plus_height_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(str(len(checks))+' checks passed; all 265799 integer conductor profiles checked')
