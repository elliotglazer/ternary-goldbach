"""Exact postprocessing with the already reviewed direct finite mixed bound.
No tail rerun, function evaluation, zero data or floating-point acceptance.
"""
from fractions import Fraction as F
from math import isqrt
from pathlib import Path
import json, hashlib
HERE=Path(__file__).parent
P=HERE/'shared_high_conductor_height_reduction_20261111.json'
assert hashlib.sha256(P.read_bytes()).hexdigest().upper()=='4E4127E970120A5BB5441CF0AF3F419F6262F616C9FA9E715A70C1E8D91CCA1A'
j=json.loads(P.read_text())
assert j['status']=='FAIL_SUFFICIENT_SCALAR_BUDGET'
def get(k):return F(j[k]['exact'])
def sqrtup(x,s=10**12):
    n=-(-(x*s*s).numerator//(x*s*s).denominator);a=isqrt(n)
    if a*a<n:a+=1
    return F(a,s)
# Source-reviewed actual L2 x Linfinity bound, not second-to-fourth inference.
C=F(6794)*10**33
assert C**100<F('1e-9')**100*(49*10**50)**89
assert F('.000032')**2>F('1e-9')
nt=get('total_N_energy');it=get('total_mixed_energy');at=get('total_Aplus_energy')
assert nt<F('.129') and it<F('1.30e-7') and at<F('3.511e-12')
assert get('max_new_tail')<F('7.57e-6') and get('star_tail')<F('1.33e-20')
extra=get('mixed_extra_norm')
cross=(F('.000032')+sqrtup(it)+extra)**2
astar=get('Astar');aplus=get('Aplus');n=get('N');ep=get('Ep')
assert aplus<F('5e-7') and astar<F('2.5e-7') and n<F('1.23') and ep<F('1e-4')
assert cross<F('7e-7') and astar+cross<F('9.5e-7')
assert (F('2.94')-F('.00020001')-F('1e-9'))**2>F('8.6296')
def pack(x):return {'exact':str(x),'display':format(float(x),'.15g')}
o={'status':'PASS_EXACT_SCALAR_REDUCED_HEIGHT_FIXED_BETA_0_555',
 'input_receipt_sha256':hashlib.sha256(P.read_bytes()).hexdigest(),
 'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
 'finite_low_Cross_upper':'1/1000000000','finite_low_Cross_norm_upper':'1/31250',
 'Aplus':pack(aplus),'Astar':pack(astar),'Cross':pack(cross),'Astar_plus_Cross':pack(astar+cross),
 'N':pack(n),'Ep':pack(ep),'mixed_extra_norm':pack(extra),
 'reusable_total_tail_caps':{'N_energy':'129/1000','mixed_energy_original_low_star':'13/100000000',
 'Aplus_energy':'3511/1000000000000000','max_primitive_tail':'757/100000000','star_tail':'133/10000000000000000000000'},
 'note':'Fixed beta=.555 only. The earlier coarse-lowCross sufficient comparison fails; no data discarded.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(o,indent=2)+'\n')
print(json.dumps(o,indent=2))
