"""Exact union of independently reviewed conditional coverage; not Lean proof."""
from pathlib import Path
from hashlib import sha256
import json

HERE = Path(__file__).resolve().parent
pins = {
    'agents/moebius/RESUME_COVERAGE_EXTENSION_2026-11-11.md': 'D81FDF9FCF7ACF10FAF829435860DE3D833816681D1738975CA52110B4760129',
    'agents/moebius/resume_coverage_wide_certificate.py': '3DBFE3B106C263306E471952CDF3CEC1AE2E3972D52AD760B9D62F7351357F42',
    'agents/moebius/resume_coverage_wide_certificate.json': 'BCD764CA10B3591D9B685649C6817749BDE5383C12D932744B9895C3BCB68056',
    'agents/audit/RESUME_COVERAGE_REVIEW_2026-11-11.md': '1C7DFF632195CE503F085AD2D9159752BA3341D42B01411DEC6E5A61B41EDA6F',
}
for name, digest in pins.items():
    assert sha256((HERE / name).read_bytes()).hexdigest().upper() == digest, name

limit = 150000
phi = list(range(limit + 1))
for p in range(2, limit + 1):
    if phi[p] == p:
        for n in range(p, limit + 1, p):
            phi[n] -= phi[n] // p
domain = set(range(1, limit + 1))
rectangles = [(50000, 8, 5), (60000, 2, 1), (100000, 4, 1),
              (120000, 1001, 192), (125000, 11, 2)]
old_rectangles = set().union(*(
    {q for q in domain if q >= low and den*q <= num*phi[q]}
    for low, num, den in rectangles))
assert len(old_rectangles) == 73578
prior = old_rectangles | {90090}
prior_path = HERE / 'base_gap_coverage_2026_11_11.json'
prior_record = json.loads(prior_path.read_text(encoding='utf-8'))
assert prior == set(prior_record['covered_denominators'])
assert len(prior) == 73579
wide = set(range(90090, 100001))
assert len(wide) == 9911
added = wide - prior
covered = prior | wide
remaining = domain - covered
assert not (covered & remaining) and covered | remaining == domain
assert 1 in remaining
result = {
    'status': 'Conditional research coverage; original analytic producers and Lean proofs remain obligations.',
    'domain': [1, limit], 'new_reviewed_interval': [90090, 100000],
    'reviewed_pins': pins,
    'prior_evidence_sha256': sha256(prior_path.read_bytes()).hexdigest(),
    'prior_covered_count': len(prior),
    'interval_count': len(wide), 'overlap_count': len(wide & prior),
    'new_count': len(added), 'covered_count': len(covered),
    'remaining_count': len(remaining),
    'new_denominators': sorted(added),
    'covered_denominators': sorted(covered),
    'remaining_denominators': sorted(remaining),
}
Path(__file__).with_suffix('.json').write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
print(json.dumps({k:v for k,v in result.items() if not k.endswith('_denominators')}, indent=2))
