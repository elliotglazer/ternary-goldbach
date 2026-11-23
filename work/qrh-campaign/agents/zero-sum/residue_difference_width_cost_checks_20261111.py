"""Exact width/count inequalities only; no polynomial or analytic values."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
A=Path(__file__).resolve().parents[1]
pins={
'integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md':'691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025',
'prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md':'99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1',
'prime-estimates/large_residue_bucket_occupancy_20261111.json':'19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB',
'prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231'}
checks=0
def ck(v):
 global checks
 checks+=1
 assert v,checks
for p,h in pins.items():ck(hashlib.sha256((A/p).read_bytes()).hexdigest().upper()==h)
for L in range(20,261):
 adv=sum(min(19,L-i-1) for i in range(L-1))
 ck(adv==19*L-190)
 ck(380+190+adv==19*(L+20))
 ck(380+190+19*(L-1)==19*(L+29))
ck(F(1,4)+F(19,40)==F(29,40)<F(3,4))
ck(F(4,3)*(2**16+F(1,2**100))<2**17)
v=531600;B=122;g=100
ell=v.bit_length();ell19=(v**19).bit_length()
ck(ell==20 and ell19==362)
ck((2**B*v**19).bit_length()==484)
ck((2**(B-g)*v**19).bit_length()==384)
ck(B+ell+18==160)
ck(B+ell19+37==521 and B+ell19+38==522)
ck(B+ell19+38==522 and B+ell19+39==523)
ck(F(20,130)==F(2,13) and F(280,130)==F(28,13))
R=59962061953248;R1=44637243437690;R2=10919369148972
ck(19*R==1139279177111712)
ck(F(744,1000)<F(R1,R)<F(745,1000))
ck(F(926,1000)<F(R1+R2,R)<F(927,1000))
out={'status':'PASS exact symbolic-cost scalar specializations only','checks':checks,'pins':pins,
 'conditional_b122_g100_maximum_widths':{'v_bits':ell,'v19_bits':ell19,'Q_bits':484,
 'final_divisor_bits':384,'fused_Horner_signed_numerator_capacity':160,
 'pruned_difference_signed_stored_capacity':521,'pruned_temporary_capacity':522,
 'screened_full_state_stored_capacity':522,'screened_temporary_capacity':523},
 'main_unit_inputs':R,'main_Horner_stages':19*R}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':out['status'],'checks':checks}))
