"""Independent integer checks only. No prime, catalogue, sumset or transform search."""
from pathlib import Path
from hashlib import sha256
import json

root = Path(__file__).resolve().parents[1]
pins = {
    'prime-estimates/SPARSE_THREE_PRIME_BASIS_FRONTIER_2026-11-11.md': 'F394A98D39555F0AAA4AA033004DE07C8EC136B0659AD17FF4519BAB947CBA89',
    'prime-estimates/three_prime_basis_sizes_20261111.py': '1628102F9719F8670899BE642E59B7D4F90FC719ABF5FADEA34673ECDB8719B8',
    'prime-estimates/three_prime_basis_sizes_20261111.json': '066B84F47AE77195B5EF6C1C2FB7B4E4E4FECC9BBFD15672F5CFA04AA00F8F0C',
}
for name, digest in pins.items():
    assert sha256((root / name).read_bytes()).hexdigest().upper() == digest
v = json.loads((root / 'prime-estimates/three_prime_basis_sizes_20261111.json').read_text())
checks = {}
def check(name, condition):
    assert condition, name
    checks[name] = True

N = 989 * 10**24
M = (N - 1 - 9)//2 + 1
check('target_count', M == v['odd_targets_9_through_T'])
h = v['balanced_labeled_set_size']
check('equal_size_threshold', (h-1)**3 < M <= h**3)
s = v['minimum_total_labeled_entries']
def balanced_product(s):
    a, r = divmod(s, 3)
    return a**(3-r) * (a+1)**r
check('total_size_threshold', balanced_product(s-1) < M <= balanced_product(s))
u = v['minimum_union_size_from_unordered_triples']
check('union_threshold', (u-1)*u*(u+1) < 6*M <= u*(u+1)*(u+2))
check('mask_bytes', v['explicit_coverage_mask_bytes'] == (M+7)//8)
check('dense_slots', 2**88 < M <= 2**89 == v['optimistic_dense_transform_length'])
check('modulus_bits', (2**89+1).bit_length() == v['one_prime_transform_modulus_minimum_bitwidth'])
check('array_bytes', v['one_array_fixed_90bit_bytes'] == (90*2**89+7)//8)
for B, k in [(10**16, 98900000000), (2*10**16, 49450000000)]:
    check('chain_'+str(B), k == (N-1-B-3+B-3)//(B-2))
# Universal carry range and telescoping are proved in the report. These are
# independent finite edge-case checks, not catalogue or prime evaluations.
for beta in [2, 3, 10, 16]:
    check('carry_cap_'+str(beta), (3*(beta-1)+2)//beta == 2)
# A deliberately invalid merge: target prefixes 11 and 13 have identical
# target-language comparison states at depth three for range [9,63], but
# catalogue values (3,3,5) reach only prefix 3, never prefix 5 modulo 8.
check('merge_language_states', 1 < 11%8 < 7 and 1 < 13%8 < 7)
check('merge_reachability_differs', (3+3+5)%8 == 11%8 != 13%8)
out = dict(status='PASS_EXACT_COUNTS_AND_EDGE_CHECKS', checks=checks, pins=pins,
           scope='Paper review support only; no actual compressed catalogue or coverage certificate.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out, indent=2)+'\n', encoding='utf-8')
print(out['status'], len(checks))
