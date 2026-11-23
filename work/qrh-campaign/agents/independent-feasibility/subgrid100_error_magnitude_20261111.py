"""Fixed error-magnitude algebra, no saved metadata or values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
HERE=Path(__file__).resolve().parent
name='SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md'
expected='B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266'
checks=0
def ck(x):
 global checks
 checks+=1
 if not x: raise AssertionError(checks)
ck(hashlib.sha256((HERE/name).read_bytes()).hexdigest().upper()==expected)
Ve=8828; Vw=16384; Sg=202305920; Cg=1266*Sg*Vw
ck(8192+633+1==8826)
ck(F(8827)+F(1,2**80)<Ve<Vw)
ck(2*Ve>Vw)
ck(F(Vw,Ve)==F(4096,2207))
ck(Ve>1)
for p in range(80,109):
 rho=int(p<100)
 ck(F(8827)+F(rho,2**p)<Ve)
 ck(2*Ve*Sg+rho<=2*Vw*Sg+rho)
 ck(F(633*(2*Ve*Sg+rho),2**p)<1)
for p,s in ((80,1),(81,2),(82,5)):
 ck(F(633*(2*Ve*s+1),2**p)<=F(Cg,2**108))
result={'checks':checks,'base_author_sha256':expected,'V_error':Ve,'V_width':Vw,
 'unchanged_target_coefficient':Cg,'intrinsic_coefficient_ratio':[2207,4096],
 'uniform_one_bit_improvement_claimed':False,'metadata_or_values_read':False}
raw=(json.dumps(result,indent=2)+'\n').encode()
with (HERE/'subgrid100_error_magnitude_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps({'checks':checks,'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest().upper()}))
