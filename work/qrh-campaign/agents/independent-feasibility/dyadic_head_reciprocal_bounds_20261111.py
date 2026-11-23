"""Exact error/width/count bounds. Does not produce any reciprocal or seed table."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
pins={
'work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
'work/qrh-campaign/agents/moebius/P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md':'F578D50723A09A1580D6ACFBA4F6AEB93371AF81B7929121A9F402E0ED5A38D0',
'work/qrh-campaign/agents/major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md':'AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F',
'work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9',
'work/qrh-campaign/agents/audit/REVIEW_JOINT_SEED_159_CORRECTIONS_2026-11-11.md':'09DEF5ABB358A807936270B07E61FFEE624EF0F04C3E17AC47A1179D944E2E82'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
N,D,P,q=1500,4096,28,130
delta,u,eps,eta=F(1,2**118),F(1,2**122),F(1,2**q),F(1,2**100)
R=F(312,635)*F(7009,9006)**318
old=10507*delta+278753*u+R
extra=5*N*P*eps
new=old+extra
ck(new<F(107,1000)*eta)
ck(new<eta/4)
ck(2*new+F(351,2**110)<F(557,1000)*eta)
for k in range(P):
 ck(delta+k*(u+eps)<1)
 ck(5*N*k*eps<=extra)
ck(2**P*(new+F(350,2**110))<1)
ck(2**123*eps==F(1,128))
ck(F(1,2)+F(1,128)<1)
max_A=(N+1)*D
ck(max_A<2**23)
ck(2**q>(N+1)*(2**119+1))
ck(123+130==253)
ck(123+12==135)
ck(130+23==153)
head_points=N*D+1
occurrences=N*(D+1)
ck(occurrences-head_points==N-1)
nonunit_uses=(P-1)*(occurrences-1)
ck(nonunit_uses==165928473)
rows=[]
for H in [20199,20366,20519,20839]:
 rows.append(dict(H=H,complex_scalings_including_unity=H*(P-1)*occurrences,
  nonunit_complex_scalings=H*nonunit_uses,nonunit_real_products=2*H*nonunit_uses,
  distinct_nonunit_reciprocals=N*D))
ck(N*D*130%8==0)
out=dict(scope='Exact majorants/widths/counts only; no actual reciprocal table or analytic values',
 checks=checks,pins=pins,parameters=dict(N=N,D=D,P=P,q=q),
 error=dict(old_over_eta=str(old/eta),added_over_eta=str(extra/eta),new_over_eta=str(new/eta),
  output_over_eta=str((2*new+F(351,2**110))/eta)),
 grid=dict(points=head_points,nonunit_points=N*D,occurrences=occurrences,
  nonunit_raw_cache_bytes=N*D*130//8,max_numerator=max_A),scenarios=rows,
 radix256_digit_product_subtotal=dict(dyadic_per_real_product=16*17,
  baseline_quotient_identity_product=16*3,reciprocal_certificate_product=17*3))
dest=HERE/'dyadic_head_reciprocal_bounds_20261111.json'
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(checks=checks,receipt_sha256=hashlib.sha256(dest.read_bytes()).hexdigest().upper(),
 added_error_over_eta=str(extra/eta),scenarios=rows)))
