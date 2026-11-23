"""Independent exact rational/pin checks; no analytic values or author imports."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
MATHLIB = Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib')
checks = {}
def check(name, proposition):
    assert proposition, name
    checks[name] = True

author = AGENTS/'major-constants/THREE_HALVES_ZERO_RATIO_AND_TURING_2026-11-11.md'
check('author_frozen', hashlib.sha256(author.read_bytes()).hexdigest().upper() == 'C28A4328D55AFCD5638F0171FC152E7C2C7DAB627EAB13FE97A5DF7AF920F1F9')
# Verify each author-listed table pin against its actual source root.
pins = []
for line in author.read_text(encoding='utf-8').splitlines():
    if not line.startswith('|'):
        continue
    fields = [s.strip().strip('`') for s in line.strip('|').split('|')]
    if len(fields) not in (2,3) or len(fields[-1]) != 64:
        continue
    relative = fields[0]
    path = (MATHLIB if len(fields)==3 else AGENTS)/relative
    actual = hashlib.sha256(path.read_bytes()).hexdigest().upper()
    check('pin:'+relative, actual == fields[-1])
    pins.append({'path':relative, 'sha256':actual})

u = Q(7,8)
lo, hi = Q(2,15), Q(15,112)
# P(t) = 2t - t log t - sum c_k t^(k+1).
c = {k: Q(1,k*(2*k+1)) for k in range(1,7)}
for k in c:
    check('second_derivative_coefficient_'+str(k), c[k]*k*(k+1)==Q(k+1,2*k+1))
upper = 2*u+u*hi-sum(c[k]*u**(k+1) for k in c)
dlo = 1+lo-sum((k+1)*c[k]*u**k for k in c)
dhi = 1+hi-sum((k+1)*c[k]*u**k for k in c)
check('atanh_interval', lo/(1-Q(1,15)**2)==hi)
check('P_exact', upper==Q(40205673181,26990346240))
check('dlo_exact', dlo==Q(50822861,3373793280))
check('dhi_exact', dhi==Q(369817499,23616552960))
check('P_cap', upper<Q(191,128))
check('derivative_cap', 0<dlo<=dhi<Q(1,8))
check('concavity_cap', Q(191,128)+Q(1,2)*Q(1,8)**2==Q(3,2))
check('log2_bound', Q(2,3)/(1-Q(1,3)**2)==Q(3,4))
low_const=Q(3,2)*Q(2525,1000)+Q(1,40)+Q(2368,1000)
check('lower_constant', low_const==Q(12361,2000))
check('lower_Z_coefficient', Q(1,2)-Q(3,2)*Q(1,2)==-Q(1,4))
combined=low_const+Q(3434,1000)
check('combined', combined==Q(19229,2000))
check('b9', combined+18<9*Q(314,100))
check('b10', combined+20<10*Q(314,100))
check('nominal_h13_reserve', 2-Q(1,2)-Q(18,13)==Q(3,26))
check('h12_equality', Q(1,2)+Q(18,12)==2)
delta=Q(5,64)
grid_h=167*delta
check('ceil13', 166*delta<13<grid_h)
check('grid_h_reserve', 2-Q(1,2)-18/grid_h==Q(201,1670))
check('main_grid_overshoot_needed', 265800*6172*delta>128160000)
check('main_grid_example', 265800*6172*delta==Q(256330875,2) and 265800*6171*delta<128160000)
for h in (Q(13),grid_h):
    check('corrected_log_cap_'+str(h), (128160000+265800*(delta+h))/6<Q(8,3)**18)

receipt={'scope':'Exact rational comparisons and file pins only; continuum argument reviewed on paper.',
         'checks':checks,'check_count':len(checks),'source_pins':pins,
         'author_sha256':hashlib.sha256(author.read_bytes()).hexdigest().upper(),
         'application_corrections':['Include main-grid overshoot 265800*5/64.',
                                    'h=13 requires rational endpoint evaluation; grid alternative h=835/64 needs new A,W,D.']}
HERE.joinpath('review_three_halves_ratio_20261111.json').write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print('PASS',len(checks),'exact rational/pin checks')
