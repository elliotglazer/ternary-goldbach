"""Research coverage accounting, not a proof of the analytic producers."""
from pathlib import Path
from hashlib import sha256
import json

HERE = Path(__file__).resolve().parent
LIMIT = 150000
phi = list(range(LIMIT + 1))
for p in range(2, LIMIT + 1):
    if phi[p] == p:
        for n in range(p, LIMIT + 1, p):
            phi[n] -= phi[n] // p

coarse_path = HERE / 'base_gap_classifier.json'
coarse_data = json.loads(coarse_path.read_text(encoding='utf-8-sig'))
coarse = set(coarse_data['covered_denominators'])
assert len(coarse) == coarse_data['covered_count'] == 49034
domain = set(range(1, LIMIT + 1))
assert coarse <= domain
rectangles = [(50000, 8, 5), (60000, 2, 1), (100000, 4, 1),
              (120000, 1001, 192), (125000, 11, 2)]
prior = coarse | set().union(*(
    {q for q in domain if q >= low and den*q <= num*phi[q]}
    for low, num, den in rectangles))
assert len(prior) == 73578
assert 90090 not in prior
assert phi[90090] == 17280

# Acceptance is the independent source review, not a property inferred from
# the arithmetic output alone. Bind that reviewed input and its exact replay.
expected = {
    'agents/moebius/RESUME_MIDDLE_2026-11-11.md':
        'a0a3c4eacb6723aa65d9b585f05933e87d3c77f2dc9a21cf438f4c63b9a2e8e7',
    'agents/moebius/resume_middle_certificate.py':
        'b70fc634c350e7fdf8174504d033254c24b4fb1209bb7aa385e7f31bcbc06e77',
    'agents/moebius/resume_middle_certificate.json':
        '4ccd7ae1a458fa0af67f284ec97d993e16ea06e4fbccf91cc213938c5875ad38',
}
for name, digest in expected.items():
    assert sha256((HERE / name).read_bytes()).hexdigest() == digest, name
review = HERE / 'agents/audit/RESUME_MIDDLE_REVIEW_2026-11-11.md'
assert review.is_file()
accepted = prior | {90090}
remaining = domain - accepted
assert len(accepted) == 73579 and len(remaining) == 76421
result = {
    'status': 'Conditional research coverage only; Type I/II producers and Lean replay remain obligations.',
    'domain': [1, LIMIT],
    'prior_count': len(prior),
    'new_singletons': [90090],
    'covered_count': len(accepted),
    'remaining_count': len(remaining),
    'coarse_sha256': sha256(coarse_path.read_bytes()).hexdigest(),
    'review_sha256': sha256(review.read_bytes()).hexdigest(),
    'reviewed_middle_inputs': expected,
    'covered_denominators': sorted(accepted),
    'remaining_denominators': sorted(remaining),
}
Path(__file__).with_suffix('.json').write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
print(json.dumps({k: v for k, v in result.items() if not k.endswith('_denominators')}, indent=2))
