"""A Fermi estimate for binary Goldbach through 1,615,000,000,000.

This is an engineering forecast, not a full-range measurement. Run with Python.
The source and anchor rows use the same conservative earlier 64-bit certificate
calibration. The smaller numbers here may be cheaper, but that is not credited.
"""
from pathlib import Path
import hashlib
import json
import math

HERE = Path(__file__).resolve().parent
OLD = HERE.parent / 'formal-goldbach-bench/forecast_inputs.json'
data = json.loads(OLD.read_text(encoding='utf-8-sig'))
B = 1615000000000
targets = B // 2 - 1
span = 100000000
blocks = math.ceil((B - 2) / span)
anchors = blocks * 360
source_prime_reserve = 6000000
seconds_per_prime = data['lean']['prime_seconds_per_root']
coverage_hours = math.ceil(targets / data['lean']['width']) * data['lean']['kernel_seconds_per_chunk'] / 3600
rows = {
    'coverage_kernel': coverage_hours,
    'coverage_build_and_layout_extra': coverage_hours * (1.05 * 1.25 - 1),
    'anchor_primality': anchors * seconds_per_prime / 3600,
    'source_primality': source_prime_reserve * seconds_per_prime / 3600,
    'producer_allowance': 10,
    'assembly_imports_storage_exceptions_allowance': 100,
}
result = dict(
    date='2026-11-20', bound=B, even_targets=targets,
    integer_span_per_block=span, blocks=blocks, reserved_anchors_per_block=360,
    anchor_records=anchors, reserved_source_prime_roots=source_prime_reserve,
    model_core_hours=rows, total_core_hours=sum(rows.values()),
    rounded_planning_core_hours=300, fermi_range_core_hours=[100, 1000],
    existing_calibration_file=str(OLD),
    existing_calibration_sha256=hashlib.sha256(OLD.read_bytes()).hexdigest(),
    certificate_cpu_seconds_per_root=seconds_per_prime,
    coverage_elapsed_seconds_per_262144_targets=data['lean']['kernel_seconds_per_chunk'],
    scope='Proof production and first checking of the finite binary range after checker development.',
    exclusions=['GRH upstream build/replay', 'analytic theorem formalization and builds',
                'human engineering time', 'an additional independent full replay'],
    limitations=[
        'The 360-anchor, 10^8-integer block layout follows the 1997 paper; no new full-range certificates have been produced.',
        'Coverage calibration is an arithmetic kernel microbenchmark, not a complete 262144-target Goldbach theorem.',
        'A complete 1024-target theorem exists elsewhere in the workspace but is not scaled per target here.',
        'Prime calibration comes from earlier 64-bit Lucas certificate cohorts, not this smaller 41-bit domain.',
        'Source roots are conservatively priced at the same rate; recursive factors are assumed shared within cohorts.',
        'The source prime reserve assumes a roughly 10^8-size table with a small anchor halo; producer must verify coverage and handle exceptions.',
        'Producer and assembly are allowances. No measured full acceptance pipeline or statistical confidence interval is claimed.',
        'Wall-clock arithmetic timing is projected as dedicated-core work; imports and I/O can change practical scaling.',
        'Existing cached Mathlib is excluded. New checker and library construction must be budgeted separately.',
    ])
(HERE / 'finite_cost.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
print(json.dumps(result, indent=2))
