"""Transparent planning arithmetic, not a forecast validated at full scale.

Run from any directory with Python 3. The only input data dependency is the
measured certificate-size metadata in native-prime/cases.json.
"""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
N = 4 * 10**18
E = N // 2
SECONDS_PER_YEAR = 365.25 * 86400
ANCHORS = 512
HALO = 2**19
size_input = HERE / "native-prime/cases.json"
cases = json.loads(size_input.read_text())
certificate_bytes = cases["cases"]["cached_pock"]["bytes_per_root"]

rows = []
for exponent in [28, 32, 36, 40, 44, 48, 50]:
    length = 2**exponent
    outer_blocks = E // length
    roots = outer_blocks * ANCHORS
    rows.append({
        "log2_L": exponent,
        "L_even_targets": length,
        "outer_blocks": outer_blocks,
        "top_level_even_targets": E - length + 1,
        "initial_prefix_even_targets": length - 2,
        "anchors_assuming_512_per_block": roots,
        "source_max_integer": 2 * length + 2 * HALO - 1,
        "resident_source_GiB": ((length + HALO + 7) // 8) / 2**30,
        "anchor_certificates_TB": roots * certificate_bytes / 10**12,
        "certificates_plus_8B_offsets_TB": roots * (certificate_bytes + 8) / 10**12,
        "anchor_check_core_years_at_1_672us": roots * 1.672e-6 / SECONDS_PER_YEAR,
        "anchor_preparation_core_years_at_0_2ms": roots * 0.0002 / SECONDS_PER_YEAR,
    })
    assert (E - length + 1) + (length - 2) == E - 1

rates = [0.31, 0.34, 0.43, 0.54, 0.70, 1.0, 1.6, 2.0, 5.0]
coverage = [{"ns_per_even": rate,
             "core_years": (E - 1) * rate * 1e-9 / SECONDS_PER_YEAR}
            for rate in rates]
wall = [{"core_years": years, "cores": cores, "utilization": 0.70,
         "days": years * 365.25 / (cores * 0.70)}
        for years in [50, 100, 300] for cores in [1000, 10000]]
result = {
    "target_inclusive": N, "even_targets_4_through_N": E - 1,
    "seconds_per_core_year": SECONDS_PER_YEAR,
    "measured_cached_pock_bytes_per_root": certificate_bytes,
    "size_input_path": "native-prime/cases.json",
    "size_input_sha256": hashlib.sha256(size_input.read_bytes()).hexdigest(),
    "assumptions": [
        "Block table is top level only; initial prefix needs recursive or direct verification.",
        "512 anchors per block is a planning choice, not a coverage theorem.",
        "Certificate size is extrapolated from 4055 distinct sampled roots; no compression credit.",
        "The 0.2ms preparation rate is an illustrative earlier sample, not a complete producer benchmark.",
        "Source storage is resident bitmap only; streaming trades memory for scheduling and I/O.",
        "Large-L coverage density, sieve time, and producer cost must be measured separately.",
        "Timing table is arithmetic at assumed rates; it does not validate those rates globally.",
        "70% cluster utilization is hypothetical, not measured scaling.",
    ],
    "block_sizes": rows, "coverage_rate_sensitivity": coverage,
    "hypothetical_wall_days": wall,
}
(HERE / "resource_model.json").write_text(json.dumps(result, indent=2) + "\n")
print(json.dumps(result, indent=2))
