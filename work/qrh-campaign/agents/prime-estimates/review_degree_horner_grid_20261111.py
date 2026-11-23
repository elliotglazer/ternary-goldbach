"""Independent error-recurrence and capacity metadata; no coefficient values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
A=ROOT/'work/qrh-campaign/agents'
B=ROOT/'work/qrh-blueprint'
checks=0
def ck(ok):
 global checks
 checks+=1
 assert ok
pins={
 'work/qrh-blueprint/DEGREE_DEPENDENT_HORNER_GRID_PROPOSAL_2026-11-11.md':'0249787E3EC22DAC609C28FE62CE847A8389CDB6D81ADD5A65D783A872A5DE12',
 'work/qrh-blueprint/degree_horner_precision_checks_20261111.py':'DD79FB92239C33508EA8C707A491DD4822DD8C5D977A1D67989F77451FBAB4EE',
 'work/qrh-blueprint/degree_horner_precision_checks_20261111.json':'82C68F3E3445E4594076BD411EDAC6421A9276B9878C385CCAD90322B8C32A6A',
}
data=json.loads((B/'degree_horner_precision_checks_20261111.json').read_text())
for p,h in data['input_pins'].items():pins['work/qrh-campaign/agents/'+p]=h
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
grid=[100 if j<2 else 100-j for j in range(20)]
ck(grid==data['grid'])
unit=lambda b:F(2)**(100-b)
# Derive weights by descending Horner recurrence, not a geometric-sum copy.
coeff=unit(grid[19]); arithmetic=F(0)
for j in range(18,-1,-1):
 coeff=coeff/4+unit(grid[j])
 arithmetic=arithmetic/4+unit(grid[j])
ck(coeff==F(data['coefficient_weight']))
ck(arithmetic==F(data['arithmetic_weight']))
error=F(3,4)*(coeff+arithmetic)
ck(error==F(data['error_in_u']))
reserve=F(8,3)-error
ck(reserve==F(data['reserve_in_u']) and reserve>F(1,24))
ck(error<F(21,8) and 633*F(21,8)==F(13293,8)<1688)
ck(F(2,4)<F(9,16))
ck(sum(grid)==1811 and sum(grid[:-1])==1730)
# Actual coefficient bound after direct conversion, and full recursive state cap.
C=F(40665)+F(3,4)*F(2)**(-81)
ck(C<2**16)
mag=C
capacities=[]
for j in range(18,-1,-1):
 b=grid[j]; oldb=grid[j+1]; delta=b-oldb
 ck(delta==(0 if j==0 else 2 if j==1 else 1))
 old_numer_bound=mag*2**oldb
 raw=132900*old_numer_bound*2**delta
 rounded_numer=mag*2**b/4+F(1,2)
 witness=531600*rounded_numer
 residual=raw+witness
 mag=C+mag/4+F(3,4)*F(2)**(-b)
 ck(mag<2**17)
 ck(raw<2**(b+35))
 ck(rounded_numer<2**(b+16))
 ck(witness<2**(b+36))
 ck(residual<2**(b+37) and 2*residual<2**(b+38))
 expected=dict(stage=j,fractional_bits=b,alignment_shift=delta,
  accumulator_signed_bits=b+18,raw_product_signed_bits=b+36,
  residual_signed_bits=b+38,doubled_residual_signed_bits=b+39)
 ck(expected==data['stage_widths'][j])
 capacities.append(expected)
out=dict(status='PASS_INDEPENDENT_DESCENDING_ERROR_AND_WIDTH_RECONSTRUCTION',checks=checks,
 pins=pins,coefficient_weight=str(coeff),arithmetic_weight=str(arithmetic),
 error_in_u=str(error),reserve_in_u=str(reserve),stage_rows=capacities,
 scope='Scalar envelope metadata only; no author execution, coefficients, functions or builds.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(dict(status=out['status'],checks=checks,error=str(error))))
