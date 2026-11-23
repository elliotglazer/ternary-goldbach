"""Exact assembly checks and source pins only; no analytic values or builds."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib
import json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AG=ROOT/'work/qrh-campaign/agents'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
tests={}
def ck(k,v):
    assert v,k
    tests[k]=True
fixed={
'major-constants/ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md':'C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D',
'zero-sum/REVIEW_ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md':'96D6929824BEBEFC14D5657E9E0134E9B5F0C7ADE194181A3FDE80908994ADC2',
'moebius/EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md':'D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B',
'audit/REVIEW_EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md':'BF2502B9F1138B381518EFB4421A14F8E2F689C3F3C088F4172ACE2749B3F46E',
'zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md':'E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794',
'moebius/REVIEW_WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md':'422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4',
'independent-feasibility/BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md':'776CD34413ECC389D10CE510913C694C6D6C34E8555FFE0D66702582B3A23898',
'integration/REVIEW_BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md':'2E902497CE7445F78CEF7A2F229D0A9042FAF4FB573AB1A01B79D05331635076',
'major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md':'E69701B4AE8145B016015A2C355151DFAA5D4946D2281BAE3CC08A86422196B1',
'audit/THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT_2026-11-11.md':'78119012C8BA40AFC93AB523B84DD441CD19D3FBC76F12418C41DD081B3C9F28',
'moebius/REVIEW_THREE_AGGREGATE_CONSUMER_SUFFICIENCY_2026-11-11.md':'4AD1F28880997030F9F5EF0ABACC637461203E50397964D1247A63D6651E65B5'}
pins={}
for path,h in fixed.items():
    ck(path,sha(AG/path)==h);pins[str((AG/path).relative_to(ROOT))]=h
extra=['work/qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md','work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md','work/qrh-blueprint/PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md']
extra += ['work/ternary-goldbach/TernaryGoldbach/'+x for x in ['MajorArcs/ArcChars.lean','MajorArcs/L2Major.lean','MajorArcs/MajorTotal.lean','MinorArcs/Bombieri.lean','MinorArcs/BaseGap2.lean','MinorArcs/MinorTotal.lean','Helfgott/Inputs.lean','Helfgott/Main.lean','MainTheorems.lean']]
for path in extra:pins[path]=sha(ROOT/path)
odd=Q(741,10**9)**2;even=Q(994,10**9)**2/2;energy=max(odd,even)
ck('odd energy dominates',energy==Q('5.49081e-13') and energy==odd)
ck('relaxed energy',energy<Q('7.02e-13'))
ck('first residual radius',Q('7.02e-13')+Q('2.83e-7')**2<Q('8.844e-7')**2)
ck('outer removal and old radius',(Q('8.844e-7')+Q(516,10**15))**2<Q('7.83e-13')<Q('8.85e-7')**2)
rho=Q('8.85e-7');j=Q('8.79');a=Q('.640208')*Q('13.59756');v=Q('7.78')*Q('2.85')
ck('integrated residual',16*150000*19*rho*rho<Q('.006')**2)
ck('upper moment',a<Q('2.951')**2 and Q('2.957')**2<j)
ck('principal norm',Q('.640208')*Q(32,13)<Q('1.256')**2 and Q('1.502e-6')*Q('1.262')+Q('2e-9')*3<Q('1.902e-6'))
ck('old star allocation',Q('7.875')**2>62 and Q('2.964')**2<j and Q('1.902e-6')+Q('2e-6')+rho*Q('7.875')<Q('2.964')*Q('3.67e-6'))
C=49*(j+a)/9+9*v/2
ck('original cubic constant',j*Q('3.67e-6')+rho*C==Q(64019155993729,312500000000000000))
ck('odd union',Q('19.2')*3*531600>27000000 and Q('19.2')*3>Q(704,343) and 440>300)
ck('even union',Q('19.1')*3*1063200>54000000 and Q('19.1')*3>Q(704,343) and 455>300)
ck('base actual envelope',Q('.024547036')<Q('.03')<Q(435635673,13700000000))
dest=HERE/'review_combined_odd_even_profile_20261111.json'
out={'scope':'conditional component integration and exact scalar checks only','checks':tests,'check_count':len(tests),'combined_Eplus':str(energy),'original_cubic_allowance':str(j*Q('3.67e-6')+rho*C),'pins':pins}
with dest.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(f'{len(tests)} checks PASS; receipt {sha(dest)}')
