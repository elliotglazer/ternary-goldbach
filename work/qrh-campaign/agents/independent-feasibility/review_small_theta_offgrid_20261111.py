"""Independent exact majorants and index congruences; no transforms or values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json

HERE=Path(__file__).resolve().parent
A=HERE.parent
pins={
'major-constants/SMALL_THETA_OFFGRID_ARITHMETIC_SCHEDULE_2026-11-11.md':'8B299BFBDB936C6B85E0AEE6A3D61B0104A2D40D9E604DA98E1E8A76AAD8A0B9',
'major-constants/small_theta_offgrid_arithmetic_20261111.py':'282B1E326DD909163F1BA93D69F9DF5A3B6B4BD22B1DA4049DEEA1B60EEFC189',
'major-constants/small_theta_offgrid_arithmetic_20261111.json':'6C28F063B8FE59B7BAD84FE50CF87425F6A3635AABDA62549660CABA5E425609',
'integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md':'19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081',
'moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md':'B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F',
'prime-estimates/WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md':'74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE',
'prime-estimates/small_family_theta_inventory_final_20261111.json':'26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def rf(x):return F(x['numerator'],x['denominator'])
for p,h in pins.items():ck(hashlib.sha256((A/p).read_bytes()).hexdigest().upper()==h)
saved=json.loads((A/'major-constants/small_theta_offgrid_arithmetic_20261111.json').read_text())
B=3125000000001
M=44*B
ck(saved['B']==B and saved['M']==M)
rows=[]
for theta,bu,bv in [(64,252,246),(128,353,347)]:
 eps=F(1,2**82*3**theta);u=F(1,2**bu);v=F(1,2**bv)
 ck(u<=eps/2**68);ck(v<=eps/2**62)
 worst=F(0)
 for depth in range(18,32):
  N=2**depth;J=(25*N+191)//192
  ck(2*J<N)
  for h in range(4):
   d=2**h;k=depth+h
   ck(u<=F(1,2*k))
   for phase in [False,True]:
    e0=(B+1)*u if phase else F(0)
    e=e0
    # The sharper local constant is B/2+3/2; use the author's larger one.
    for _ in range(k):e=(1+u/2)*e+(F(B,2)+2)*u
    closed=2*e0+k*(B+4)*u
    ck(e<=closed);ck(e<1)
    ck((1+u/2)**k<F(2))
    lam=F(448*d,5)
    bound=lam*(2*(B+1)+k*(B+4))*u+(B+2)*u
    ck(lam*e+(B+2)*u<=bound);ck(bound<eps/64)
    worst=max(worst,bound/eps)
 local=340*(M+3)*v/eps
 ck(local<F(1,16))
 row=next(r for r in saved['precision_rows'] if r['tilt']==theta)
 ck(worst==rf(row['worst_output_over_eps']))
 ck(local==rf(row['local_arithmetic_over_eps']))
 # Work in units tau=4*3^theta*eps for final real scaling.
 ck(F(49,256)+F(1,4)+F(1,4)<F(3,4))
 ck(F(15,64)+F(1,4)+F(1,4)<F(3,4))
 rows.append(dict(theta=theta,worst_ratio=str(worst),local_ratio=str(local)))

for e in range(18,32):
 N=2**e;J=(25*N+191)//192
 for h in range(4):
  d=2**h
  fn=N*e//2;fd=d*N*(e+h)//2
  ck(fd-d*fn==d*N*h//2)
 for row in saved['schedule_examples']:
  if row['N']==N:
   fn=N*e//2;fd=8*N*(e+3)//2
   expected=dict(N=N,J=J,base_butterflies=fn,seven_polyphase_butterflies=7*fn,
    seven_phase_products=7*J,padded8_total_butterflies=fd,
    padded8_increment_over_base=fd-fn,padded8_extra_over_all_polyphase=12*N,
    polyphase_workspace_complex_slots=N,padded_workspace_complex_slots=8*N)
   for key,val in expected.items():ck(row[key]==val)

for N in [8,32]:
 for d in [1,2,4,8]:
  for j in range(-3,4):
   for ell in range(d):
    for k in range(N):
     direct=j*(d*k+ell)
     padded=(j%(d*N))*(d*k+ell)
     poly=d*(j%N)*k+j*ell
     ck((padded-direct)%(d*N)==0)
     ck((poly-direct)%(d*N)==0)
for d in [2,4,8]:
 ck(((8-1)-(-1))%(8*d)!=0)

# Strict scalar break-even threshold with an explicit feasible minimum q.
for a in [1,3,7]:
 for den in [1,3,17]:
  for right in [-19,0,4,29]:
   q=max(a,right//den+1)
   ck(q*den>right)
   ck(q==a or (q-1)*den<=right)
out=dict(scope='Exact recurrence/index/cost metadata only',checks=checks,pins=pins,
 precision=rows,source_semantics='T exact centers; physical comparison at target only')
dest=HERE/'review_small_theta_offgrid_20261111.json'
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(checks=checks,sha256=hashlib.sha256(dest.read_bytes()).hexdigest().upper())))
