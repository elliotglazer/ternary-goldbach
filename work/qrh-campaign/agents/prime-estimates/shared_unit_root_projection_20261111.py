"""Fixed grid/error/width arithmetic only; no angle, root or value input."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
B='work/qrh-campaign/agents/'
pins={
 B+'zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md':'C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01',
 B+'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
 B+'zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md':'087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D',
 B+'moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md':'EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B',
 B+'prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md':'EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD',
 B+'prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md':'8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03',
 B+'audit/REVIEW_EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md':'E3EFDD1A7DC6185E02421DDB0E50417748FB694EA663E5663AAE6416446266A7',
 'work/qrh-blueprint/SHARED_HIGH_PRECISION_KERNEL_ADAPTER_2026-11-11.md':'6393BBAD96123F0AD7E1171CFE1BF2D50A1B27641E55C926BCD30D23155ABE42'}
checks=0
def ck(v):
 global checks
 assert v;checks+=1
for path,h in pins.items():
 p=ROOT/path;ck(p.stat().st_size<128*1024)
 ck(hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
# sqrt(2)/2 < 3/4, proved by squaring positive numbers.
ck(F(1,2)<F(9,16))
ck(F(1,4)+F(3,4)==1)
ck(F(1,2)+F(3,4)>1) # This sufficient estimate does not admit a one-bit gap.
H=110
rows=[]
for p in range(100,109):
 k=H-p;ck(2<=k<=10)
 ratio=F(1,1<<k)+F(3,4);ck(ratio<=1)
 # Coordinate integer nearest rounding is below 2^p+1 in magnitude.
 excess=F(1,1<<k)+F(1,2);ck(excess<1)
 high=(1<<H)+1;low=1<<p
 ck(high.bit_length()==111 and low.bit_length()==p+1)
 # Candidate output is additionally bound by |M|<=2^p.
 product=low*(1<<k);ck(product==1<<H)
 raw_diff_bound=high+product
 ck(raw_diff_bound.bit_length()==112)
 # Signed floor q alternative uses |q|<=2^p+1 before adding its remainder.
 floor_product=((1<<p)+1)*(1<<k)
 floor_sum_bound=floor_product+(1<<k)-1
 ck(floor_sum_bound<(1<<(H+1)))
 ck((2*((1<<k)-1)).bit_length()==k+1)
 # Exact cached sums are safely below 2^(p+2); equality 2^(p+1) is allowed by coordinate bound.
 ck(2*low<1<<(p+2))
 rows.append({'p':p,'discarded_bits':k,'rational_error_ratio_upper':str(ratio),'high_magnitude_bits':111,'high_signed_bits':112,'projected_magnitude_bits':p+1,'projected_signed_bits':p+2,'residual_raw_subtraction_magnitude_bits':112,'residual_raw_subtraction_signed_bits':113,'doubled_remainder_magnitude_bits':k+1,'cached_sum_magnitude_bits_safe':p+2,'cached_sum_signed_bits_safe':p+3,'complex_nearest_projection_macros':1,'scalar_nearest_projection_macros':2})
ck(((1<<H)+1).bit_length()==H+1)
result={'scope':'Fixed nine-grid metadata; no root/angle/conductor inventory or numeric values','checks':checks,'pins':pins,'H':H,'rows':rows,'actual_angle_identity_cardinality':None,'actual_cache_lifetimes':None,'selected_production_schedule':False}
raw=(json.dumps(result,indent=2)+'\n').encode();assert len(raw)<16384
with (HERE/'shared_unit_root_projection_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps({'checks':checks,'bytes':len(raw)}))
