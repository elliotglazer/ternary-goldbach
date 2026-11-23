"""Explicit coordinator-approved additions. Never infer acceptance from filenames."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
A = ROOT / 'work/qrh-campaign/agents'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()

SPECS = [
    ('em-topcount', 'Preferred explicit-EM top count without a builtin zeta or RS evaluator',
     'zero-sum/EM_TOP_HORIZONTAL_2026-11-11.md',
     'C8062D1BB197EF9A2FD8450BEAAF7E093B1448865751D0DB30623394C76F13BF',
     'independent-feasibility/REVIEW_EM_TOP_HORIZONTAL_2026-11-11.md',
     '6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E',
     ['zero-sum/em_top_horizontal_20261111.py', 'zero-sum/em_top_horizontal_20261111.json',
      'independent-feasibility/review_em_top_horizontal_20261111.py',
      'independent-feasibility/review_em_top_horizontal_20261111.json']),
    ('high-strip', 'Wider sufficient closed principal strip above height 1500',
     'major-constants/PRINCIPAL_HIGH_STRIP_REFINEMENT_2026-11-11.md',
     'B5BA5316102AB6AA303B30929B3E10020526F6A17C2D8D560C24B4AC65C6C47D',
     'audit/PRINCIPAL_HIGH_STRIP_REFINEMENT_REVIEW_2026-11-11.md',
     '57E5A193E155B30DBDA9FCB414296B2D4251737F2411422E6363D28BC9A548E2',
     ['major-constants/principal_high_strip_refinement_20261111.py',
      'major-constants/principal_high_strip_refinement_20261111.json',
      'audit/principal_high_strip_independent_review_20261111.py',
      'audit/principal_high_strip_independent_review_20261111.json']),
    ('topcount1e6', 'Complete external principal top-path count at one million',
     'integration/PRINCIPAL_TOP_COUNT_2026-11-11.md',
     '27E092EF982BD02618F6987C68B58B4653E876F99F55BFDB5B6C38F4669FF94B',
     'independent-feasibility/REVIEW_PRINCIPAL_TOP_COUNT_2026-11-11.md',
     'F8350FCA6195848A9924567F8738AE4C984370312A2EC30F98AEA7144E859D3D',
     ['integration/principal_top_count_20261111.py', 'integration/principal_top_count_20261111.json',
      'independent-feasibility/review_principal_top_count_20261111.py',
      'independent-feasibility/review_principal_top_count_20261111.json']),
    ('sign1500', 'Complete external principal signs and simplicity through height 1500',
     'mellin/PRINCIPAL_SIGNS_1500_CERTIFICATE_2026-11-11.md',
     '0C2DF29B039E0418144EDAAF1ADA05BEEF31B90F3E1F0358DCAD837F7BF69082',
     'audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md',
     'A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE',
     ['mellin/principal_signs_1500_20261111.py', 'mellin/principal_signs_1500_20261111.json',
      'audit/principal_signs_1500_independent_review_20261111.py',
      'audit/principal_signs_1500_independent_review_20261111.json']),
    ('c101-combined', 'Conductor-101 local segment for all 99 primitive characters',
     'zero-sum/C101_CAUCHY_ALPHA_BLOCK_2026-11-11.md',
     '4F73C1FA9C8D8C1C5ECCD22DB0348FCAC52108C126B840E5BC419FCD9968BF5B',
     'moebius/C101_CAUCHY_ALPHA_REVIEW_2026-11-11.md',
     'A27762CDE69D0E903A515487F4192F4B48AAD25F508EBE80E128A0C5FC8A2B4E',
     ['zero-sum/c101_cauchy_alpha_block_20261111.py', 'zero-sum/c101_cauchy_alpha_block_20261111.json',
      'moebius/c101_model_review_20261111.py', 'moebius/c101_model_review_20261111.json',
      'independent-feasibility/NONPRINCIPAL_OUTER_DISK_GROWTH_2026-11-11.md']),
]

path = HERE / 'catalog.json'
catalog = json.loads(path.read_text(encoding='utf8'))
for pid, title, report, rh, review, vh, evidence in SPECS:
    assert sha(A/report) == rh.lower(), report
    assert sha(A/review) == vh.lower(), review
    files = []
    for role, source in [('report', report), ('review', review)] + [('evidence', e) for e in evidence]:
        p = A/source
        dest = f'chapters/{pid}-{role}.md' if role in ('report', 'review') else f'evidence/post131/{source}'
        files.append(dict(source=p.relative_to(ROOT).as_posix(), path=dest, role=role,
                          bytes=p.stat().st_size, sha256=sha(p)))
    packet = dict(id=pid, title=title, status='accepted research evidence; no new Lean proof', files=files)
    existing = [p for p in catalog['accepted_packets'] if p['id'] == pid]
    if existing:
        assert existing == [packet], 'Existing pins changed; explicit new review required'
    else:
        catalog['accepted_packets'].append(packet)
    catalog['pending_slots'] = [p for p in catalog['pending_slots'] if p['id'] != pid]
assert sha(A/'independent-feasibility/NONPRINCIPAL_OUTER_DISK_GROWTH_2026-11-11.md') == 'e188a233a37093f5b0b342edd4f42bf6a9ff6e910006320900bed7d958fe4f47'
catalog['package_stage'] = 'frozen research snapshot; independent synthesis audit pending; not an approved Lean graph'
path.write_text(json.dumps(catalog, indent=2) + '\n', encoding='utf8')
print(json.dumps(dict(accepted_packets=len(catalog['accepted_packets']), pending=catalog['pending_slots'])))
