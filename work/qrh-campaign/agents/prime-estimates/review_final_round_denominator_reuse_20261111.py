"""Independent scalar metadata, pins and synthetic rounding controls only."""
from pathlib import Path
from fractions import Fraction
import hashlib,json
ROOT=Path(__file__).resolve().parents[4]
A=ROOT/'work/qrh-campaign/agents'
checks=0
def ck(ok):
 global checks
 checks+=1
 assert ok
pins={
 'zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md':'E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF',
 'zero-sum/final_round_denominator_digit_reuse_20261111.py':'C0ADE08ECDFBDCFF23467DA2690B7C1F6F9AF4B2B9A606A0E8D75DDEB6AB4350',
 'zero-sum/final_round_denominator_digit_reuse_20261111.json':'3E3147A9D7FABFC68361C8764450D5EB548C167BCC44A46D54B746FF8DA999A0',
}
data=json.loads((A/'zero-sum/final_round_denominator_digit_reuse_20261111.json').read_text())
pins.update(data['pins'])
for p,h in pins.items():
 ck(hashlib.sha256((A/p).read_bytes()).hexdigest().upper()==h)
sourcepins={
 'work/mm0-efficient/toolchain-sources/examples__peano.mm1':'13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079',
 'work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1':'76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94',
 'work/formal-goldbach-bench/mm0/src/verifier.c':'71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5',
}
for p,h in sourcepins.items():
 ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
qbound=(2*265800)**19
ck(qbound.bit_length()==362)
ck(Fraction(4,3)*2**16+Fraction(1,2**101)<2**17)
widths=dict(Q=362,unsigned_rounded_coordinate=117,table_entry=370,product_prefix=479)
ck(widths==data['capacity_bits'])
ck((362+7)//8==46 and (117+7)//8==15)
ck((370+7)//8==47 and (479+7)//8==60)
table=sum(1 for _ in range(15))+sum(2*60+2 for _ in range(14))
school=sum(5*46+2 for _ in range(15))+1
setup=sum(2*47+3 for _ in range(255))+4
saving=school-table
scalar=next(n for n in range(1,100) if n*saving>setup)
complex_count=next(n for n in range(1,100) if 2*n*saving>setup)
events=dict(table_product=table,rectangular_schoolbook=school,one_table_setup=setup,
 strict_scalar_product_crossover=scalar,strict_complex_output_crossover=complex_count)
ck(events==data['macro_events'])
ck(256*47==12032)
# Different synthetic range and direct Fraction floor; no conductor outputs/tables.
cases=0
for Q in range(1,42):
 for I in range(-83,84):
  x=Fraction(I,Q)+Fraction(1,2)
  m=x.numerator//x.denominator
  for candidate in (m-1,m,m+1):
   residual=I-candidate*Q
   ck((-Q<=2*residual<Q)==(candidate==m))
   if Q%2==0:
    ck((-Q//2<=residual<Q//2)==(candidate==m))
   cases+=1
out=dict(status='PASS_INDEPENDENT_PIN_SCALAR_AND_SYNTHETIC_ROUND_CHECKS',checks=checks,
 pins=pins,sourcepins=sourcepins,events=events,widths=widths,
 synthetic_candidate_round_cases=cases,
 scope='No author import/run; no table generation, analytic values, builds or timing.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8')
print(json.dumps(dict(status=out['status'],checks=checks,cases=cases)))
