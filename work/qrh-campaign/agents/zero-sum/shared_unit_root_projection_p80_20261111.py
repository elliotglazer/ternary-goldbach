"""Fixed 29-grid corollary checks, no root identities or values."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
 'prime-estimates/SHARED_UNIT_ROOT_CHIRP_PROJECTION_2026-11-11.md':'01C4FE83F6F642D47977825696B70F308156F5E3B2532EBA75A62255A3B03EEB',
 'zero-sum/REVIEW_SHARED_UNIT_ROOT_CHIRP_PROJECTION_2026-11-11.md':'C1D3C4F7AE61B3A1176BC0792C7F2B27CAEAEEB5BE86080770DEC1438AA586C5',
 'prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md':'EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD',
 'prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md':'8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03',
 'audit/REVIEW_EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md':'E3EFDD1A7DC6185E02421DDB0E50417748FB694EA663E5663AAE6416446266A7',
}
checks=[]
def check(label,condition):
    assert condition,label
    checks.append(label)
for name,pin in PINS.items():
    check('pin '+name,sha256((AGENTS/name).read_bytes()).hexdigest().upper()==pin)

H=110
high=(1<<H)+1
check('sqrt half strictly below three quarters',F(1,2)<F(9,16))
check('high signed width',high.bit_length()+1==112)
rows=[]
for p in range(80,109):
    k=H-p;d=1<<k;low=1<<p
    raw=high+low*d
    floor_raw=(low+1)*d+(d-1)
    tag='p'+str(p)+' '
    check(tag+'gap',2<=k<=30)
    check(tag+'unit error guard',F(1,d)+F(3,4)<=1)
    check(tag+'projected coordinate integrality',F(1,d)+F(1,2)<1)
    check(tag+'shifted low bound',low*d==1<<110)
    check(tag+'raw residual signed width',raw.bit_length()+1==113)
    check(tag+'raw doubled signed width',(2*raw).bit_length()+1==114)
    check(tag+'floor route before narrowing',floor_raw<1<<111)
    check(tag+'floor remainder doubling',(2*(d-1)).bit_length()==k+1)
    check(tag+'accepted residual width',(d//2).bit_length()+1==k+1)
    check(tag+'accepted doubled residual width',d.bit_length()+1==k+2)
    check(tag+'exact low sums',(2*low).bit_length()+1==p+3)
    check(tag+'raw byte capacity',(114+7)//8==15)
    rows.append({'p':p,'k':k,'error_ratio_rational_upper':str(F(1,d)+F(3,4)),
       'projected_magnitude_bits':p+1,'projected_signed_bits':p+2,
       'low_sum_magnitude_bits':p+2,'low_sum_signed_bits':p+3,
       'raw_residual_signed_bits':113,'raw_doubled_residual_signed_bits':114,
       'floor_q_signed_bits':p+2,'floor_fold_magnitude_bits':111,
       'unsigned_remainder_bits':k,'unsigned_doubled_remainder_bits':k+1,
       'accepted_residual_signed_bits':k+1,'accepted_doubled_residual_signed_bits':k+2,
       'high_magnitude_byte_capacity':14,'raw_signed_byte_capacity':15})
check('29 grids',len(rows)==29)
check('max accepted signed residual',max(r['accepted_residual_signed_bits'] for r in rows)==31)
check('max unsigned doubled remainder',max(r['unsigned_doubled_remainder_bits'] for r in rows)==31)
check('max signed doubled residual',max(r['accepted_doubled_residual_signed_bits'] for r in rows)==32)
record={'scope':'Fixed precision-range arithmetic only; no coefficient/angle/cache demand enumeration.',
        'checks':len(checks),'source_pins':PINS,'H':H,'rows':rows,
        'identity_count':None,'requested_low_pair_count':None,'cache_lifetimes':None,
        'demand_bound_multiplier':29,'subgrid_transform_admitted':False,
        'assertions':checks}
encoded=(json.dumps(record,indent=2,sort_keys=True)+'\n').encode()
path=HERE/'shared_unit_root_projection_p80_20261111.json'
with path.open('xb') as stream: stream.write(encoded)
print(json.dumps({'checks':len(checks),'bytes':len(encoded),'sha256':sha256(encoded).hexdigest().upper()}))
