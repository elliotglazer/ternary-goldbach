"""Independent exact one-node guards; no producer or numerical-library import."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'integration/PRINCIPAL_ONE_NODE_BOUND_2026-11-11.md':'5EF2C88A9C98B0CAEE8C8DB277238CAC0EADD1AC00E311D7277F9E563D7C0B14',
 'integration/principal_one_node_bound_20261111.py':'A6BB7EB9EA22790C953C6476963632B9DE60EAAACEBEC395F137CA15DE569CA1',
 'integration/principal_one_node_bound_20261111.json':'3395166C8A2A5804A19EB9449336FB12224E682DC04DC39315443585C9AAE029',
 'integration/lossless_modular_two_step_20261111.json':'31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE',
 'mellin/REVIEW_LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md':'46BDD3D1CA0AD8C730A693AC4CFA7F5D55C3043EDBF4180B82C939C5BC18B697',
 'mellin/REVIEW_LOSSLESS_SEED_TAYLOR_2026-11-11.md':'A842B04F0C18005A89C48F2F377A063E1B9F98B47CFCC9B9CFA1FE579DFD102A',
 'integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':'C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D',
 'audit/REVIEW_PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':'9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED',
 'integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md':'6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99',
 'audit/REVIEW_PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md':'ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2',
}
for p,h in PINS.items():assert hashlib.sha256((AGENTS/p).read_bytes()).hexdigest().upper()==h,p
ML=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib')
for p,h in {
 'Analysis/Real/Pi/Bounds.lean':'58E8B7A97645F6F1BD3CA1D08860CB27B8C705C394FA101E057542970F34B036',
 'Analysis/Complex/Exponential.lean':'564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0',
}.items():assert hashlib.sha256((ML/p).read_bytes()).hexdigest().upper()==h,p
data=json.loads((AGENTS/'integration/principal_one_node_bound_20261111.json').read_text())
c=data['certificate']
assert c=={'T':1000000,'real_node':'0','word':[['T',-1],['S'],['T',0]],
 'theta_types':['theta3','theta4','theta2'],'inverse_t_bound_exponent':20,'A_bound_exponent':10,
 'tau_norm_upper':2,'reduced_imag_lower':1024,'jet_bound_exponent':-505,
 'first_derivative_exponent':51,'second_derivative_exponent':92,
 'P_amplification_exponent':97,'P_radius_exponent':-408,'requested_radius_exponent':-128}
packet=json.loads((AGENTS/'integration/lossless_modular_two_step_20261111.json').read_text())['packet']
nodes={n['id']:n for n in packet['nodes']}
def dy(p):return F(int(p['mantissa']))*F(2)**p['exponent']
def scalar(p):
 m,r=dy(p['mid']),dy(p['rad']);assert r>=0
 lo,hi=dy(p['lo']),dy(p['hi']);assert (lo,hi)==(m-r,m+r)
 return lo,hi
def box(name):return tuple(scalar(nodes[name]['value'][a]) for a in ('re','im'))
def n2(z):return max(x*x+y*y for x in z[0] for y in z[1])
tau,t,v,A=map(box,('tau','translated','S_output','A'))
assert nodes['translated']['args']==['tau']
assert nodes['S_output']['args']==['translated']
assert nodes['A']['args']==['root']
assert -F(3,5)<t[0][0]<=t[0][1]<F(3,5)
assert 0<t[1][0]<=t[1][1]<F(1,2)
assert -F(3,5)<v[0][0]<=v[0][1]<F(3,5)
assert v[1][0]>F(2,5) and v[1][0]>=1024
assert t[1][0]>=F(2)**-20
assert n2(tau)<=4 and n2(A)<=F(2)**20
assert 0<F(1,1000001)<F(3,4)
# The terminal translation may choose the tie representative -1/2.
assert abs(F(-1,2))<=F(1,2)
assert max(abs(q+1) for q in tau[0])<F(1,10)
assert max(abs(q+F(1,2)) for q in v[0])<F(1,10)
E=F(2)**20
d1=F(2)**10*(E/2+E**2)
d2=F(2)**10*(3*E**2/4+3*E**3+E**4)
amp=12*F(2)**51+16*F(2)**92
assert d1<=F(2)**51 and d2<=F(2)**92 and amp<=F(2)**97
# Separate all-height elementary inequalities are proved in the review;
# here check their exact endpoint constants and the final rational sum.
assert 3*1024-1>=2*1024
assert 1/(1-F(1,4))==F(4,3)<2
assert 32*2*2==128 and 128*F(2)**-512==F(2)**-505
assert amp*F(2)**-505<=F(2)**-408<F(2)**-128
assert (12*d1+16*d2)*F(2)**-505<=F(2)**-408
def rat(x):return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
recorded={'Y_lower':v[1][0],'t_imag_lower':t[1][0],
 'tau_norm_squared_upper':n2(tau),'A_norm_squared_upper':n2(A),
 'first_derivative_amplification':d1,'second_derivative_amplification':d2,
 'P_coarse_amplification':amp}
assert {k:rat(q) for k,q in recorded.items()}==data['verification']['recorded_bounds']
assert all(data['verification']['guards'].values()) and len(data['verification']['guards'])==9
assert all(data['verification']['scalar_checks'].values()) and len(data['verification']['scalar_checks'])==11
assert data['verification']['output']['absolute_radius']=={'mantissa':'1','exponent':-408}
receipt={'status':'PASS one actual P node, paper plus exact external arithmetic',
 'pins':PINS,'source_pins':2,'whole_box_guards':9,'producer_scalar_checks_rederived':11,
 'bounds':{k:rat(q) for k,q in recorded.items()},
 'absolute_radius':{'mantissa':'1','exponent':-408},
 'scope':'No producer import, transcendental evaluation, wider node or spectral claim, or Lean run.'}
Path(__file__).with_suffix('.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({k:receipt[k] for k in ('status','whole_box_guards','producer_scalar_checks_rederived','absolute_radius','scope')},indent=2))
