"""Read-only structural sizing. No masks, sieve runs, Lean files, or timing estimates."""
from pathlib import Path
import json

H = Path(__file__).resolve().parent
P = H / 'psi_full_candidate_20261111'
load = lambda p: json.loads(p.read_bytes())
primes = load(P / 'base_primes.json')['primes']
first = load(H / 'resume_psi_short_gap_20261111.json')
rows = [{'subwindows': first['pilot_subwindows']}]
rows += load(H / 'resume_psi_multi32_20261111.json')['windows']
rows += load(H / 'resume_psi_stress512_20261111.json')['windows']
for p in sorted(P.glob('batch_*.json')):
    rows += load(p)['windows']
cells = [s for r in rows for s in r['subwindows']]
lengths = [p * ((131072 - 1) // p) + 1 for p in primes]
assert len(primes) == 7004 and len(rows) == 6439 and len(cells) == 125271
assert sum(s['width'] for s in cells) == 4000000000
assert sum(s['count'] for s in cells) == 184106689
out = {
    'status': 'structural sizing only; no Lean replay or runtime prediction',
    'base_count': len(primes), 'largest_base_prime': max(primes),
    'range_cap_strict': 70711**2,
    'pattern_bits': 131072, 'cell_width_max': max(s['width'] for s in cells),
    'maximum_shifted_index_bound_exclusive': 32768 + 70710,
    'pattern_payload_bytes_rounded_individually': sum((n+7)//8 for n in lengths),
    'pattern_payload_bytes_fixed_width_upper': 7004 * 16384,
    'pattern_hex_digits_no_leading_zeros': sum((n+3)//4 for n in lengths),
    'pattern_hex_digits_fixed_width_upper': 7004 * 32768,
    'pattern_chunks_of_64': (7004+63)//64,
    'last_pattern_chunk_size': 7004 % 64,
    'base_integer_chunks_of_256_for_0_through_70710': (70711+255)//256,
    'windows': len(rows), 'subcells': len(cells),
    'subcells_per_window_min': min(len(r['subwindows']) for r in rows),
    'subcells_per_window_max': max(len(r['subwindows']) for r in rows),
    'count_modules_at_128_declarations': (len(cells)+127)//128,
    'syntactic_one_pass_base_leaf_visits': len(cells)*len(primes),
    'syntactic_one_pass_outer_chunk_result_visits': len(cells)*110,
    'syntactic_one_pass_outer_binary_ors': len(cells)*109,
    'syntactic_one_pass_all_binary_ors': len(cells)*(len(primes)-1),
    'syntactic_pcL7_leaf_occurrences': len(cells)*128,
    'dynamic_kernel_work_bound_claimed': False,
    'true_prime_bits_over_all_cells': sum(s['count'] for s in cells),
    'materialized_all_cell_masks_bytes_fixed_width': len(cells)*4096,
    'new_endpoint_log_boxes': len(rows),
    'new_log_boolean_checks': 2*len(rows),
}
print(json.dumps(out, indent=2))
