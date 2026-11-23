"""Independent exact replay and small-Q joins. No spectral data or Lean proof."""
from pathlib import Path
from fractions import Fraction as F
from contextlib import redirect_stdout
from unittest.mock import patch
import hashlib, json, math

HERE=Path(__file__).resolve().parent
SRC=HERE.parent/'moebius'
SOURCE=SRC/'resume_small_q_high_certificate.py'
SAVED=SOURCE.with_suffix('.json')
FAMILY=HERE.parent/'zero-sum/resume_base_gap_finite_family_20261111.json'
REPORT=SRC/'RESUME_SMALL_Q_HIGH_2026-11-11.md'
REPLAY=HERE/'resume_small_q_high_independent_replay_20261111.json'
write=Path.write_text
before={p:p.read_bytes() for p in [SOURCE,SAVED,FAMILY,REPORT]}

def redirected(path,data,*args,**kwargs):
    assert path.resolve()==SAVED.resolve(), str(path)
    return write(REPLAY,data,*args,**kwargs)

namespace={'__name__':'__independent_replay__','__file__':str(SOURCE)}
with (HERE/'resume_small_q_high_independent_replay_20261111.log').open('w',encoding='utf-8') as stream:
    with redirect_stdout(stream),patch.object(Path,'write_text',redirected):
        exec(compile(SOURCE.read_text(encoding='utf-8'),str(SOURCE),'exec'),namespace)
result=json.loads(REPLAY.read_bytes())
assert result==json.loads(before[SAVED])
assert all(p.read_bytes()==data for p,data in before.items())
for rectangle in result['results']:
    assert len(rectangle['rows'])==32
    assert all(F(row['gap'])>0 for row in rectangle['rows'])

# Recompute the specific primary joins from the actual family formulas.
family=json.loads(before[FAMILY])
samples={row['q']:row for row in family['samples']}
cap=F('.04712');yp=F('7.5e-12');eps=F('3e-14');rem=F('2e-9')
ceil=lambda f:(f.numerator+f.denominator-1)//f.denominator
def finite(q,u,mellin_cap):
    row=samples[q]
    h=max(250,ceil(F(242*u,7*q)))
    n=ceil(F(20000*h+69600,87))
    w=F(row['W_upper'])
    return F(row['main_upper'])+mellin_cap*n*yp*w+(1+w)*rem+w*eps
primary=[]
for q,prefix in [(2,972954),(3,1068377)]:
    assert samples[q]['sharp_u_prefix_integer']==prefix
    assert finite(q,prefix,F(13,8))<=cap
    assert finite(q,prefix+1,F(13,8))>cap
    assert finite(q,300000,F(13,8))<cap
    assert F(q,sum(math.gcd(k,q)==1 for k in range(1,q+1)))<=2
    primary.append({'q':q,'prefix':prefix,'high_start':300000,
                    'overlap':prefix-300000,'prefix_budget':str(finite(q,prefix,F(13,8)))})
assert F(samples[2]['W_upper'])==1
w3=F(samples[3]['W_upper'])
assert (2*w3-1)**2>=3 and 2*w3-1>0
assert F(samples[2]['main_upper'])==0
assert F(samples[3]['main_upper'])==F('1.016')/F(600000,49*3)**2/2

# Recheck every backup join at its claimed endpoint and raw start.
assert len(result['residual_joins'])==19
for row in result['residual_joins']:
    q=row['q'];prefix=row['finite_prefix'];start=row['high_start']
    assert finite(q,prefix,F(4))<=cap
    assert finite(q,start,F(4))<=cap
    assert prefix>=start

# Scalar source domains, including odd/even Type I ratios separately.
assert F(3,6)+F(1,4)<1
assert 1500>2*39 and 2*10**23>58000000**3
assert 2400000<F(58000000,3)
assert 39<F(58000000,6)
assert F(1,2)*(F(58000000)**2)>9  # V1 <= 9T/2 <= T^3/4.
out={'status':'PASS conditional paper/scalar audit; spectral and analytic inputs remain open',
     'pins':{str(p.relative_to(HERE.parent)):hashlib.sha256(data).hexdigest() for p,data in before.items()},
     'replay_matches_all_json_fields':True,
     'rectangles':[{k:v for k,v in r.items() if k!='rows'} for r in result['results']],
     'primary_sharp_joins':primary,'backup_joins_checked':19}
write(HERE/'resume_small_q_high_review_20261111.json',json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
