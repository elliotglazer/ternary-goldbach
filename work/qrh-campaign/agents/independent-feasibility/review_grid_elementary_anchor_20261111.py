"""Independent integer/rational metadata checks; no elementary values or producer import."""
from pathlib import Path
from fractions import Fraction as Q
from math import comb
import hashlib
import json

BASE = Path(__file__).resolve().parent.parent
PINS = {
 'zero-sum/GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md':'E564A8DDEC5F0AD69F5CF22DFC89147F81EA165B6E6D17B4CF0EFB0EEA3824AF',
 'zero-sum/grid_elementary_anchor_metadata_20261111.py':'10AB9F92831A32605FD89F37C9BBD385A9B580D53B382D22D7F0FC72D7B1DC54',
 'zero-sum/grid_elementary_anchor_metadata_20261111.json':'3F9CDE0D49019291509B8382133085CCD6B02F9E496D17C1CB70A4F4C01AABED',
 'integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md':'1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E',
 'major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md':'60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9',
 'zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md':'E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B',
 'prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md':'251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
}
checks = 0
def need(p):
 global checks
 assert p
 checks += 1

for name, digest in PINS.items():
 need(hashlib.sha256((BASE/name).read_bytes()).hexdigest().upper()==digest)
saved = json.loads((BASE/'zero-sum/grid_elementary_anchor_metadata_20261111.json').read_text())
grids=[]
for old in saved['grids']:
 D=old['D']; upper=3389*D; edges=[D]; blocks=[]
 while edges[-1]<=upper:
  left=edges[-1]; right=min(upper,left+left//128-1)
  need(right>=left)
  need(128*(right-left)<left)
  blocks.append([left,right-left+1]); edges.append(right+1)
 need(edges[-1]==upper+1)
 total=upper-D+1; count=len(blocks); rest=total-count
 row=dict(D=D,total_points=total,anchor_count=count,nonanchor_points=rest,
          max_block_points=max(n for _,n in blocks),denominator_bound=upper,
          denominator_bits=upper.bit_length(),first_blocks=blocks[:3],last_blocks=blocks[-3:],
          anchor_plan_sha256=hashlib.sha256(json.dumps(blocks,separators=(',',':')).encode()).hexdigest(),
          degree19_horner_stages_per_function=19*rest,degree17_horner_stages_per_function=17*rest,
          degree19_amplitude_coefficient_slots=20*count,degree17_amplitude_coefficient_slots=18*count,
          all_log135_and_amplitude121_stages=36*rest,fixed64_anchor_count=(total+63)//64)
 for key,value in row.items(): need(value==old[key])
 need(sum(n for _,n in blocks)==total)
 need(count<3073)
 # Dyadic incoming/coefficient grids; unreduced denominator upper bit caps.
 row['log135_raw_denominator_bit_cap']=140+upper.bit_length()+19 .bit_length()
 row['amplitude121_raw_denominator_bit_cap']=126+upper.bit_length()
 grids.append(row)

need(Q(1)+Q(256,256)+Q(comb(256,2),256**2)>2)
need(3389<2**12)
for row in saved['precision_rows']:
 p=row['target_bits']; E=Q(1,2**p)
 k=1
 while Q(2,128**(k+1))>E/8: k+=1
 need(k==row['block_degree']); need(str(Q(2,128**(k+1)))==row['block_tail'])
 q=1
 def tail(q): return Q(27,3**(2*q+1)*(2*q+1))
 while tail(q)>E/8: q+=1
 need(q==row['independent_atanh_terms']); need(row['horner_grid_bits']==p+5)
 for j in range(k+2): need(comb(2*j,j)<=4**j)
need(Q(1,4)+Q(1,8)+Q(2,32)+Q(1,8)==Q(9,16))
need(Q(1,4)+Q(5,32)+Q(4,32)+Q(1,8)==Q(21,32))
need(Q(21,64)+Q(1,8)+Q(1,8)<1)
need(Q(1,1)/(1-Q(1,128))<2)
delta=Q(1,2**118); EL=Q(1,2**135); EA=Q(1,2**121)
need(10000*EL<=delta/8); need(EA==delta/8)
# Product: approximate amplitude <=1+EA, phase error <=delta/8, cis <=delta/8.
need(EA+(1+EA)*(delta/8+delta/8)+delta/8<delta)
result=dict(status='PASS_INDEPENDENT_EXACT_METADATA',checks=checks,pins=PINS,grids=grids,
            log_error_fraction='9/16',amplitude_error_fraction='21/32',
            scope='Integer partitions, rational tails, counts, denominator caps and direct scaled-leaf allocation only; no elementary values.')
out=Path(__file__).with_suffix('.json')
with out.open('x',encoding='utf8',newline='\n') as f: f.write(json.dumps(result,indent=2)+'\n')
print(json.dumps(dict(status=result['status'],checks=checks,output=str(out))))
