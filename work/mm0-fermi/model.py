"""Fermi arithmetic, not a performance benchmark or a proof implementation."""
from fractions import Fraction as F
from pathlib import Path
import json

SECONDS_PER_YEAR = 31557600
EVENS = 2 * 10**18
WORDS = EVENS // 64

SCENARIOS = {
    'aggressive': dict(sieve_records=10**18, sieve_events=80,
                       selected_masks=10, cover_events=100,
                       events_per_second=5*10**8,
                       generation_ratio=F(1, 2), native_core_years=50),
    'central': dict(sieve_records=25*10**17, sieve_events=150,
                    selected_masks=15, cover_events=200,
                    events_per_second=2*10**8,
                    generation_ratio=F(1, 2), native_core_years=100),
    'conservative': dict(sieve_records=4*10**18, sieve_events=250,
                         selected_masks=20, cover_events=250,
                         events_per_second=5*10**7,
                         generation_ratio=F(7, 20), native_core_years=300),
}

results = {}
for name, p in SCENARIOS.items():
    sieve = p['sieve_records'] * p['sieve_events']
    coverage = WORDS * p['selected_masks'] * p['cover_events']
    events = sieve + coverage
    checking = F(events, p['events_per_second'] * SECONDS_PER_YEAR)
    generation = checking * p['generation_ratio']
    total = checking + generation + p['native_core_years']
    results[name] = dict(parameters=p, sieve_events=sieve,
                         coverage_events=coverage, total_events=events,
                         checking_core_years=float(checking),
                         generation_core_years=float(generation),
                         total_core_years=float(total))

assert results['central']['total_events'] == 468750000000000000000
assert 110000 < results['central']['total_core_years'] < 113000
assert 10000 < results['aggressive']['total_core_years'] < 11000
assert 950000 < results['conservative']['total_core_years'] < 1050000

block_count = (EVENS+2**32-1)//2**32
anchor_count = block_count*512
sparse_parameters = {
    'aggressive': dict(masks=10, events=200, bytes=200, rate=5*10**8,
                       emitter=10**9, search_cycles=10000, cpu_hz=5*10**9,
                       prime_events=10**6, other_years=100),
    'central': dict(masks=15, events=400, bytes=400, rate=2*10**8,
                    emitter=5*10**8, search_cycles=20000, cpu_hz=4*10**9,
                    prime_events=10**7, other_years=1000),
    'conservative': dict(masks=25, events=1000, bytes=800, rate=10**8,
                         emitter=10**8, search_cycles=100000, cpu_hz=3*10**9,
                         prime_events=10**8, other_years=10000),
}
sparse = {}
for name, p in sparse_parameters.items():
    updates = WORDS*p['masks']
    check = F(updates*p['events'], p['rate']*SECONDS_PER_YEAR)
    prime_check = F(anchor_count*p['prime_events'], p['rate']*SECONDS_PER_YEAR)
    emitted_bytes = updates*p['bytes']
    emission = F(emitted_bytes, p['emitter']*SECONDS_PER_YEAR)
    search = F(WORDS*p['search_cycles'], p['cpu_hz']*SECONDS_PER_YEAR)
    total = check+prime_check+emission+search+p['other_years']
    sparse[name] = dict(parameters=p, coverage_check_years=float(check),
                        anchor_check_years=float(prime_check),
                        proof_emission_years=float(emission),
                        compact_cover_search_years=float(search),
                        proof_stream_bytes=emitted_bytes,
                        total_core_years=float(total))
assert 47000 < sparse['central']['total_core_years'] < 49000
result = dict(kind='Unmeasured Fermi model; all event costs and rates are assumptions',
              even_targets=EVENS, target_words=WORDS,
              preferred_sparse_design=dict(block_evens=2**32, block_count=block_count,
                                            anchors_per_block=512, anchor_count=anchor_count,
                                            scenarios=sparse),
              dense_sieve_alternative=results,
              rounded_planning_core_years=50000,
              wall_years_at_70_percent={str(c):50000/(.7*c)
                                      for c in [1000, 10000, 100000]},
              prior_per_witness_model_core_years=30*40_000_000_000/(60*24*365.25))
text = json.dumps(result, indent=2, default=str)+'\n'
Path(__file__).with_suffix('.json').write_text(text, encoding='utf-8')
print(text)
