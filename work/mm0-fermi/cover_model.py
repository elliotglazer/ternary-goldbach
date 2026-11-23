"""Synthetic set-cover and arithmetic Fermi model; not prime data or a proof."""
import json
import math
import random
import statistics

rng = random.Random(20261110)
words = 31_250_000_000_000_000
block_evens = 2**32
blocks = math.ceil(1_999_999_999_999_999_999 / block_evens)
results = []
for pool_size, density in ((512, 0.058), (512, 0.087), (1024, 0.058), (1024, 0.087)):
    counts = []
    failed = 0
    for _ in range(128):
        masks = [sum((rng.random() < density) << j for j in range(64))
                 for _ in range(pool_size)]
        remaining = (1 << 64) - 1
        count = 0
        while remaining:
            best = max(masks, key=lambda mask: (remaining & mask).bit_count())
            if not best & remaining:
                failed += 1
                break
            remaining &= ~best
            count += 1
        if not remaining:
            counts.append(count)
    results.append(dict(pool_size=pool_size, density=density, trials=128, failures=failed,
                        minimum=min(counts), median=statistics.median(counts),
                        maximum=max(counts)))

events = words * 15 * 200
print(json.dumps(dict(
    warning="Independent Bernoulli masks, not actual primes; no rigorous tail bound",
    trials=results, words=words, blocks=blocks, seeds=blocks * 512,
    central_cover_events=events,
    central_cover_core_years=events / 2e8 / (365.25*86400),
    cover_payload_bytes=words * 15 * 9 // 8,
    central_expanded_cover_bytes=words * 15 * 250,
), indent=2))
