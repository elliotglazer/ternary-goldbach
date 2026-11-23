"""Independent stipulated-multiset arithmetic only; no analytic certificates."""
from fractions import Fraction as F
from pathlib import Path
import json, hashlib

base=Path(__file__).resolve().parents[1]/'integration'
paths=[base/'FAMILY_COMPLEX_CLUSTER_COMPLETENESS_2026-11-11.md',base/'family_complex_cluster_fixtures_20261111.py',base/'family_complex_cluster_fixtures_20261111.json']
pins={p.name:hashlib.sha256(p.read_bytes()).hexdigest().upper() for p in paths}
source=json.loads(paths[-1].read_text())
T,H=F(100),F(110)
nonreal_weights=[(F(102),4),(F(104),2),(F(103),3)]
nonreal_L=sum(m*(H-y) for y,m in nonreal_weights)
nonreal_W=6*(H-105)+3*(H-104)
real_L=2*4*(H-102)
real_W=2*4*(H-103)
assert (nonreal_W,nonreal_L,real_W,real_L)==(48,65,56,64)
assert nonreal_W<=nonreal_L and real_W<=real_L
assert 4+2+10==16 and 2*4+6==14
assert 2*16>16 and 2*(4+6)>14
assert source['nonreal']['K']==source['nonreal']['C']==16
assert source['real']['K']==source['real']['C']==14
assert F(source['nonreal']['W'])==nonreal_W and F(source['nonreal']['actual_integrated_added_count'])==nonreal_L
assert F(source['real']['W'])==real_W and F(source['real']['actual_integrated_added_count'])==real_L
assert F(1,2)+F(1,4)+F(1,4)==1
# Main-boundary orders have no added weight, whereas an invalid auxiliary inclusion
# would incorrectly award a positive weight. This is why T<|gamma| is strict.
invalid_T_weight=3*(H-T)
assert invalid_T_weight==30 and invalid_T_weight>0
result={'status':'PASS_STIPULATED_ARITHMETIC_ONLY','input_pins':pins,
        'nonreal':{'K':16,'W':str(nonreal_W),'L':str(nonreal_L),'loss':str(nonreal_L-nonreal_W)},
        'real':{'K':14,'W':str(real_W),'L':str(real_L),'loss':str(real_L-real_W)},
        'strict_lower_auxiliary_endpoint_required':True,
        'no_analytic_or_lean_validation':True}
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2))
