"""Source hashes and exact endpoint counts only; no primality or power tests."""
from pathlib import Path
from hashlib import sha256
import json
import re

ROOT = Path(__file__).resolve().parents[2]
AGENTS = ROOT / 'work/qrh-campaign/agents'
BLUEPRINT = ROOT / 'work/qrh-blueprint'
LEAN = Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean')
REPORTS = [
    'major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md',
    'audit/REVIEW_EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md',
    'prime-estimates/SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md',
    'audit/REVIEW_SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md',
    'major-constants/EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md',
    'audit/REVIEW_EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md',
    'prime-estimates/SUPPLIED_ROOT_PRODUCTION_PAYLOAD_2026-11-11.md',
    'integration/LEAN_SUPPLIED_ROOT_CHECKER_ARCHITECTURE_2026-11-11.md',
]

def digest(path):
    return sha256(path.read_bytes()).hexdigest().upper()

def resolve(label, report):
    label = label.strip(' `')
    if label.startswith('installed '):
        return LEAN / label[len('installed '):].strip(' `')
    options = [ROOT / label, AGENTS / label, report.parent / label,
               ROOT / 'work/ternary-goldbach/TernaryGoldbach' / label]
    matches = list(dict.fromkeys(p.resolve() for p in options if p.is_file()))
    assert len(matches) == 1, (label, matches)
    return matches[0]

reports = []
pins = []
for name in REPORTS:
    report = AGENTS / name
    reports.append({'path': name, 'sha256': digest(report)})
    for line in report.read_text(encoding='utf-8').splitlines():
        if line.startswith('|'):
            cells = [c.strip() for c in line.split('|')[1:-1]]
            if len(cells) >= 2 and re.fullmatch(r'`[0-9A-F]{64}`', cells[-1]):
                target = resolve(cells[0], report)
                expected = cells[-1].strip('`')
                assert digest(target) == expected, str(target)
                pins.append({'report': name, 'path': str(target), 'sha256': expected})
        match = re.fullmatch(r'- ([^:]+): ([0-9A-F]{64})', line)
        if match:
            target = resolve(match[1], report)
            assert digest(target) == match[2], str(target)
            pins.append({'report': name, 'path': str(target), 'sha256': match[2]})

def ceildiv(a, b):
    return -(-a // b)

F = 2**45
rows = []
for N in [10**27, 989 * 10**24]:
    T = N - 1
    for B in [10**15, 2*10**15, 5*10**15, 10**16, 2*10**16, 4*10**18]:
        H = (B-2)//F
        k_first_max = B//F
        k_target = ceildiv(T-B-1, F)
        necessary_new = max(0, ceildiv(T-B-3, B-2))
        necessary_same_F = 1 + ceildiv(max(0, k_target-k_first_max), H)
        assert k_first_max*F+1 <= B+1 < (k_first_max+1)*F+1
        assert (k_target-1)*F+1+B < T <= k_target*F+1+B
        assert necessary_same_F >= necessary_new
        rows.append({'analytic_threshold': N, 'binary_cutoff': B,
                     'H': H, 'deficit_bits': (H-1).bit_length(),
                     'necessary_new_primes_all_formats': necessary_new,
                     'necessary_new_primes_same_F': necessary_same_F})

result = {'scope': 'source binding and exact counts, not prime availability or kernel proof',
          'reports': reports, 'matched_source_pin_count': len(pins),
          'matched_source_pins': pins, 'geometry': rows}
out = BLUEPRINT / 'reconcile_adaptive_certificates_20261111.json'
out.write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
print(json.dumps({'matched_source_pins': len(pins), 'reports': reports,
                  'new_threshold_rows': rows[6:], 'receipt_sha256': digest(out)}, indent=2))
