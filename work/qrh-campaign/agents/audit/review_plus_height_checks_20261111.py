"""Independent exact scalar and saved-metadata checks; no analytic evaluation."""
from fractions import Fraction as F
from pathlib import Path
from hashlib import sha256
import json

root = Path(__file__).resolve().parents[4]
author = root / 'work/qrh-campaign/agents/major-constants'
saved = json.loads((author/'plus_finite_rh_height_scalars_20261111.json').read_text())
checks = []
def record(name, ok):
    assert ok, name
    checks.append(name)
def rat(v):
    return F(int(v['numerator']), int(v['denominator']))

piu = F(31416,10000)
slo, shi = F(233,10), F(1989,100)
slopes = [slo*piu*531600, slo*piu*1063200, shi*piu*1063200]
for name, slope in zip(['Aodd','Aeven_low','Aeven_high'], slopes):
    record(name, rat(saved[name]) == slope)
record('positive Taylor at 0.7 exceeds 2', 1+F(7,10)+F(7,10)**2/2+F(7,10)**3/6 > 2)
record('260 exponential exponent', F(1598,10000)*260 > 59*F(7,10))
eb = F(892,1000)*260/F(2**59)
record('saved EB exact', rat(saved['EB_cap']) == eb)
z, c, b = F(17726,100), F(9,100), F(21768,10000)
for name, a, ea in [('E2_low',F(222000),F(6,10**23)), ('E2_high',F(877,100),F(12,10**17))]:
    # Independently factor out the common factor 2 from the source expression.
    val = F(25848,100)*(eb*(z*b+c*b*b)+ea*(z*a+c*a*a))
    record(name+' saved exact', rat(saved[name]) == val)
    record(name+' cap', val < F(112,10**12))
record('old E2 allocation', F(112,10**12)*F(54773,100)<F(69,10**9))
record('c3 at lower height', 11*F(44,10)<c*460*F(12039,10000))
record('IA low', 1+piu*600001/F(8492,1000)<222000)
record('IA high', 1+piu*21/F(8492,1000)<F(877,100))
record('EA 23.3 source upper', F(588,1000)*slo**2*F(176,10**27)<F(6,10**23))
record('EA 19.89 source upper', F(588,1000)*shi**2*F(505,10**21)<F(12,10**17))
record('uniform delta', F(1063200,2)<600000)
record('high even delta', F(1063200,60000)<20)

# Both branches of ceil(200+max(260,A/c)) are bounded by max(461,201+A/c).
for name, cap, slope in [('odd',132900,slopes[0]),('even low',60000,slopes[1]),('even middle',125000,slopes[2])]:
    record(name+' floor branch', 461*cap<10**8)
    record(name+' slope branch', 201*cap+slope<10**8)
record('even high floor branch', 261*265800<75000000)
record('even high slope branch', 265800+slopes[2]<75000000)
for name,zl,s1,s2 in [('K1',F(14521,100),28515,37864),('K2',F(14321,100),33086,43934)]:
    k=zl*(F(s1)/F(348,100)+s2)
    record(name+' saved exact', rat(saved[name])==k)
    record(name+' cap', k<7660000)
for item in saved['examples']:
    q=item['c']
    slope=slopes[0] if q%2 else slopes[1] if q<=60000 else slopes[2]
    raw=200+max(F(260),slope/q)
    ceilraw=-(-raw.numerator//raw.denominator)
    record('ceil '+str(q), ceilraw==item['new_closed_integer_height'] and raw<=ceilraw<raw+1)
    old=F(10**8,q) if q%2 else max(F(10**8,q),200+F(75000000,q))
    record('old '+str(q), rat(item['original_height'])==old and ceilraw<old)
record('pointwise implies candidate energy', F(425,10**9)**2 < F(702,10**15))
base=root/'work/ternary-goldbach/TernaryGoldbach'
paths=['Explicit/ZeroSumGen.lean','Explicit/ZeroSumBound.lean','Explicit/ZeroSums.lean',
       'Explicit/EtaPlusBound.lean','MajorArcs/Prop942.lean','MajorArcs/Thm714.lean',
       'MajorArcs/Cor713.lean','MajorArcs/ArcChars.lean','MajorArcs/GRH.lean']
pins=[{'path':str((base/p).relative_to(root)),'sha256':sha256((base/p).read_bytes()).hexdigest().upper()} for p in paths]
out={'status':'PASS','scope':'Exact scalar and saved-data consistency only; not spectral or Lean validation',
     'count':len(checks),'checks':checks,'source_pins':pins,
     'author_script_sha256':sha256((author/'plus_finite_rh_height_scalars_20261111.py').read_bytes()).hexdigest().upper(),
     'author_receipt_sha256':sha256((author/'plus_finite_rh_height_scalars_20261111.json').read_bytes()).hexdigest().upper(),
     'review_script_sha256':sha256(Path(__file__).read_bytes()).hexdigest().upper()}
target=Path(__file__).with_suffix('.json')
with target.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2)
    f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'sha256':sha256(target.read_bytes()).hexdigest().upper()}))
