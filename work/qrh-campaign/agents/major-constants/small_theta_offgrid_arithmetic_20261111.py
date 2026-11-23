"""Exact integer/rational schedule checks only; no transform or analytic values."""
from fractions import Fraction as F
from pathlib import Path
import hashlib, json

BASE = Path(__file__).resolve().parents[1]
PINS = {
 'integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md':'19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081',
 'moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md':'B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F',
 'prime-estimates/WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md':'74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE',
 'prime-estimates/small_family_theta_inventory_final_20261111.json':'26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69',
}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
def rat(v):
 return {'numerator':v.numerator,'denominator':v.denominator}
for p,h in PINS.items(): ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
B=2*1250000**2+1; M=44*B; Delta=F(5,64)
ck(B<2**42); ck(M<2**48)
rows=[]
for tilt,ub,vb,power in [(64,252,246,102),(128,353,347,203)]:
 eps=F(1,2**82*3**tilt); u=F(1,2**ub); v=F(1,2**vb)
 ck(3**tilt<2**power); ck(u<=eps/2**68); ck(v<=eps/2**62)
 ck(340*(M+3)*v<eps/16)
 for h in range(4):
  d=2**h
  for k0 in range(18,32):
   k=k0+h; Lambda=7*d/Delta
   e=(2*(B+1)+k*(B+4))*u
   out=Lambda*e+(B+2)*u
   ck(u<=F(1,2*k)); ck(e<1); ck(out<eps/64)
 rows.append({'tilt':tilt,'complex_gate_bits':ub,'local_real_gate_bits':vb,
              'worst_output_over_eps':rat((7*8/Delta*(2*(B+1)+34*(B+4))+B+2)*u/eps),
              'local_arithmetic_over_eps':rat(340*(M+3)*v/eps)})
table=[]
for k in (18,24,31):
 N=2**k; J=(25*N+191)//192
 f=N*k//2; f8=8*N*(k+3)//2
 ck(2*J<N); ck(f8-8*f==12*N)
 table.append({'N':N,'J':J,'base_butterflies':f,'seven_polyphase_butterflies':7*f,
               'seven_phase_products':7*J,'padded8_total_butterflies':f8,
               'padded8_increment_over_base':f8-f,'padded8_extra_over_all_polyphase':12*N,
               'polyphase_workspace_complex_slots':N,'padded_workspace_complex_slots':8*N})
# Exact phase congruences, not evaluations of exponentials.
for N in (8,16):
 for d in (2,4,8):
  for j in range(-2,3):
   for ell in range(d):
    for k in range(N):
     exact=F(j*(d*k+ell),d*N)
     poly=F((j%N)*k,N)+F(j*ell,d*N)
     padded=F((j%(d*N))*(d*k+ell),d*N)
     ck((poly-exact).denominator==1); ck((padded-exact).denominator==1)
ck((F((8-1),8*8)-F(-1,8*8)).denominator!=1)
out={'scope':'exact rational error bounds and schedule metadata; no analytic or transform values',
     'checks':checks,'pins':PINS,'B':B,'M':M,'precision_rows':rows,'schedule_examples':table,
     'signed_phase_identity_checked':True,'naive_append_zero_counterexample_checked':True}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2); f.write('\n')
print(json.dumps({'checks':checks,'receipt':str(dest),'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
