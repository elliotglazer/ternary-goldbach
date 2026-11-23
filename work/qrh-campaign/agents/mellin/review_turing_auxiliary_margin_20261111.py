"""Independent rational validation of the 24 frozen conditional height witnesses."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json
import math

ROOT=Path(__file__).resolve().parents[4]
A='work/qrh-campaign/agents/'
PINS={
 A+'integration/TURING_AUXILIARY_MARGIN_DESIGN_2026-11-11.md':'36AFA1DF2A38D56A0677816038B08821B6CD5919118CEADB7616717047209943',
 A+'integration/turing_auxiliary_margin_design_20261111.py':'5C49EE7A33C86186ADA1A7F11AC2CE424124A2065623D8366C81ADAA684DBAC1',
 A+'integration/turing_auxiliary_margin_design_20261111.json':'25B7183974DFBFE3018A8FB0011D7BD942758DFFE602957BC6E3105D2FA59A35',
 A+'integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md':'72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C',
 A+'mellin/REVIEW_ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md':'2238E4C56B808F9034DCE86ECA834A785BA5DF4E09F2F68935C287BD9CA5AAE3',
 A+'zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md':'6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4',
 A+'major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md':'3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58',
 A+'zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md':'53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54',
 'work/qrh-blueprint/turing-scalars/AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md':'45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47',
 A+'zero-sum/REVIEW_AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md':'5EB56E2F86C5CE05CCA3491C237FE66F4C0053F656AD1401211A47406833DA21',
}
def pins():
    for name,want in PINS.items():
        got=hashlib.sha256((ROOT/name).read_bytes()).hexdigest().upper()
        assert got==want,(name,got,want)
pins()
packet=json.loads((ROOT/(A+'integration/turing_auxiliary_margin_design_20261111.json')).read_text())
assert packet['script_sha256'].upper()==PINS[A+'integration/turing_auxiliary_margin_design_20261111.py']
rows=packet['rows']
cs=[3,4,40,101,1000,10000,150000,300000]
rhos=[F(1,4),F(1,2),F(3,4)]
expected={(c,r) for c in cs for r in rhos}
assert len(rows)==24 and {(r['conductor'],F(r['rho'])) for r in rows}==expected
# A strict elementary witness: exp(1)>sum_{j=0}^4 1/j! >8/3.
exp_one_partial=sum((F(1,math.factorial(j)) for j in range(5)),F(0))
assert exp_one_partial-F(8,3)==F(1,24)
checked=[]
for row in rows:
    c=row['conductor']; rho=F(row['rho']); k=row['log_upper_integer']; h=row['h']
    assert (c%2==1 and c<=150000) or (c%4==0 and c<=300000)
    qt=c if c%2==0 else 2*c
    # Use ceil(200+max(...)), the other equivalent source expression.
    Hp=math.ceil(F(200)+max(F(1000),F(704*1200000,7*qt)))
    T=min(F(Hp),F(10**8,c)); H=T+h
    b=F(42)+F(693,100)*k; allowance=2*b/h
    assert T>50 and 0<rho<1 and 1<=k<=100
    assert h==math.floor(F(9,4)*b/rho)+1
    slack=F(8,3)**k-F(c)*H/6
    assert slack>=0 and allowance<F(8,9)*rho
    assert rho-allowance>rho/9
    # Check all proof-relevant saved fields, not just the displayed table.
    exact={
      'old_Hp':F(Hp),'T_Hcert':T,'H_evaluator':H,
      'per_channel_B_upper':b,'two_channel_allowance_over_h_upper':allowance,
      'conditional_measured_D_ceiling':1-rho,'guaranteed_margin_floor':rho/9,
      'strict_saturation_margin_at_D_ceiling':rho-allowance,
      'h_over_T':F(h)/T,'c_times_T':c*T,'c_times_H':c*H,
      'exp_log_witness_slack':slack,
    }
    for field,value in exact.items():
        assert F(row[field])==value,(c,rho,field,row[field],value)
    assert row['exceeds_old_product_cap']==(c*H>10**8)
    for field in ['measured_D_supplied','certified_gamma_integral_supplied','certified_main_or_auxiliary_signs_supplied']:
        assert row[field] is False
    # Verify claimed first-success k independently by checking earlier candidates.
    for j in range(1,k):
        bj=F(42)+F(693,100)*j
        hj=math.floor(F(9,4)*bj/rho)+1
        assert F(8,3)**j<c*(T+hj)/6
    checked.append({'c':c,'rho':str(rho),'T':str(T),'h':h,'k':k,
                    'cH':str(c*H),'allowance':str(allowance),
                    'conditional_margin':str(rho-allowance)})
middle={r['c']:r for r in checked if r['rho']=='1/2'}
assert F(middle[4]['cH'])==100002880
assert F(middle[300000]['cH'])==334600000
assert F(middle[300000]['h'])/F(middle[300000]['T'])==F(1173,500)
assert {c for c,r in middle.items() if F(r['cH'])<=10**8}=={3,101}
pins()
receipt={'status':'PASS_24_CONDITIONAL_WITNESSES_AND_10_PINS',
 'scope':'No measured D, spectral data, Gamma integral, FFT output, or saturation success supplied.',
 'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
 'pins':PINS,'exp_one_partial':str(exp_one_partial),'rows':checked}
Path(__file__).with_suffix('.json').write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(receipt['status'])
