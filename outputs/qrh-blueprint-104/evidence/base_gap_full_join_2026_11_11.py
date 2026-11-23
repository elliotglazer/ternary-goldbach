"""Join reviewed conditional base-gap intervals. No Lean or spectral validation."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
import json

HERE = Path(__file__).resolve().parent
pins = {
 'agents/zero-sum/RESUME_BASE_GAP_FINITE_FAMILY_2026-11-11.md': '09340D4135D7E895E6F3FDA660DE9A7F773A91FF41F3B88FC125C814884D5E74',
 'agents/zero-sum/resume_base_gap_finite_family_20261111.py': '7B51EFCE9DF84125EFFEA001154483B21C0DBE92EE7C80D514D90420EE08C036',
 'agents/zero-sum/resume_base_gap_finite_family_20261111.json': 'BE725BE94D16589C47E4F2387559B994BBA8F75A008121D100930313935CFB7A',
 'agents/audit/RESUME_BASE_GAP_FAMILY_REVIEW_2026-11-11.md': '973B7B90B892E2514D3C3A6953880F784964D0E22BEE19D628877940FE0D7E73',
 'agents/moebius/RESUME_Q1_GAP_2026-11-11.md': 'BE08109B6433B3DB1CF349A15418283765ABE2CDD62930F3917BB1CA21F02782',
 'agents/moebius/resume_q1_high_certificate.json': '55F8E1AB0A7ACAB34BF6B91C8B3227EF1245C1296035B6595B52ACF3DFDF33FC',
 'agents/independent-feasibility/RESUME_Q1_FINITE_REVIEW_2026-11-11.md': '364E835BC52A02779D587F40AAA6CC1FBC9BE579F01614D978A7FD4DFF1CAD4E',
 'agents/moebius/RESUME_SMALL_Q_HIGH_2026-11-11.md': 'CCF603C0A6CD5FCE9D0AD35BD0BF92B3AC3509D6E6C44EA4CCB361C7462FAAF2',
 'agents/moebius/resume_small_q_high_certificate.py': '384548E16140CB18BA6964CB805C391B476864C68EE36CE1F1C902C85E05FAA3',
 'agents/moebius/resume_small_q_high_certificate.json': '6F9FFE0269E0DA8F9AFC9E7DACAD42840C4E521505B6F7855DBD1FC5F2664FEE',
 'agents/independent-feasibility/RESUME_SMALL_Q_HIGH_REVIEW_2026-11-11.md': 'F3EC07159059587EA4031B2FD06BFF74BDC1491048DAD986BE79201A29ED3F54',
}
for name, digest in pins.items():
    assert sha256((HERE/name).read_bytes()).hexdigest().upper() == digest, name
def read(name):
    return json.loads((HERE/name).read_text(encoding='utf-8'))
family = read('agents/zero-sum/resume_base_gap_finite_family_20261111.json')
q1 = read('agents/moebius/resume_q1_high_certificate.json')
small = read('agents/moebius/resume_small_q_high_certificate.json')
assert family['sharp_transform_cap'] == '13/8'
assert family['sharp_full_gap_failures'] == [1,2,3]
assert family['sharp_passing_reduced_q_count'] == 149997
assert family['reduced_q_count'] == 150000
assert F(family['uniform_ghat_floor']) == F('0.04712')
samples = {row['q']: row for row in family['samples']}
assert q1['q'] == 1 and q1['u_lower'] == 190000 and q1['u_upper'] == 1200000
assert F(q1['y_min']) == 10**25
assert len(q1['rows']) == q1['r_cells'] == 128
assert all(F(row['gap']) > 0 for row in q1['rows'])
high = next(row for row in small['results'] if F(row['Fmax']) == 2)
assert high['u_lower'] == 300000 and high['u_upper'] == 1200000
assert small['q_min'] == 2 and small['q_max'] == 39
assert F(small['y_min']) == 10**25
assert len(high['rows']) == small['r_cells'] == 32
assert high['passes'] and all(F(row['gap']) > 0 for row in high['rows'])
phi = {row['q']: row for row in small['phi_rows']}
joins = []
for q, high_start in [(1,190000),(2,300000),(3,300000)]:
    prefix = samples[q]['sharp_u_prefix_integer']
    assert prefix == {1:486477,2:972954,3:1068377}[q]
    assert F(1200000,49) < high_start <= prefix < 1200000
    # The source reviews certify all scales and every real u in these intervals.
    # The exact comparisons here check their overlap, not the analytic theorems.
    if q > 1:
        assert F(q, {2:1,3:2}[q]) <= 2
    joins.append({'q':q,'finite_u_interval':['1200000/49',prefix],
                  'high_u_interval':[high_start,1200000],
                  'overlap':prefix-high_start})
covered = set(range(4,150001)) | {row['q'] for row in joins}
assert covered == set(range(1,150001))
result = {
 'status':'Complete conditional paper coverage only; finite spectrum, global QRH validation, analytic producer replacements and Lean proofs remain obligations.',
 'source_pin':'23b2d68ca344203d4384e0aff7affa4ec034bef9',
 'spectral_profile':'Original uniform beta<=111/200 through Hp(c); weighted alternative not substituted.',
 'reduced_q_domain':[1,150000], 'u_domain':['1200000/49',1200000],
 'y_domain':'y>=1e25', 'finite_full_gap_count':149997,
 'joined_exception_count':3, 'conditional_covered_count':len(covered),
 'remaining_uncovered_denominators':0, 'joins':joins, 'reviewed_pins':pins,
 'not_claimed':['finite spectral truth','unconditional analytic producers','Lean theorem closure']
}
Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if k!='reviewed_pins'},indent=2))
