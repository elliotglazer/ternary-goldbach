# Independent scope and resource audit

2026-11-10 Pacific. Research/source review; no new verifier build, formal proof, or benchmark run. **PASS within the conditional research scope:** the mathematical indexing, acceptance contract, resource-model arithmetic, and final native coverage summary pass review. This is not a claim that the future verifier or full Goldbach proof has been completed.

## Reviewed state

| Artifact | SHA256 |
|---|---|
| `SCOPE.md` | `9864941bd71b90706032b21d202e3d9a5043b2e63eb9cbe699ebaa073ae8dc63` |
| `resource_model.py` | `b9eba46f4fba2704ec0caa0cbbd0aca908c05d48a2e744eb22fc0db0a3cac49e` |
| `resource_model.json` | `8a239d718ac4e809da87ca943a615177143aedf120041cbdf9dba4815151e9bc` |
| `native-prime/cases.json` | `104dbc306a65f2b983f72d1d7c4132c634eb4539e433a774afd83e1ae16096bb` |
| `native/summary.json` | `09f3ae125e1de0cbd255450e86ac06f1ebdab2f1a86277ec0fa49e4609c6f22f` |
| `native/REPORT.md` | `d75edbe01a9f4fa77f8d2d44d32daef622613d2f6d4d811e7e4bfc5e4d8f59f3` |
| `native/SHA256_MANIFEST.json` | `dbbc6eed9eb854b92d9f185d56d8b3f31aa2b348cc81df1699aff6e99bfd59d9` |
| `native/bulk_wide_native.json` | `8d38b40122564a28f055b49aff0fe4d10519da21a54f587b7cfd2746d2bca5cd` |
| `native/bulk_wide_scalar.json` | `d22770efd4e4c3a449a9de773048d87143c06dafa1ac23203efdf6014e52594c` |

The resource script was executed in memory with its output write intercepted. The regenerated JSON exactly matched the saved model, and its recorded measured-input hash matched the current certificate-size data. No source or benchmark artifact was changed by this review.

## What passed

* The target is every even integer from 4 through 4e18, with exactly 2e18−1 targets. It is distinct from the separate analytic ternary-Goldbach project.
* The partition uses the initial interval `[4,2L)` and outer blocks `n=2(rL+t)`, `1<=r<=floor(E/L)`, `0<=t<min(L,E−rL+1)`. It covers the inclusive endpoint, including the width-one last block when L divides E.
* The anchor identity gives `p=2(t+s)+1`. The source maximum `2L+2D−1` and the tile halo `[a,b+D)` are correct. Recursing on the initial interval does not use Goldbach to certify source primes.
* The checker contract establishes PA derivability through proved expansion/admissibility and an exact-executable refinement. The scope distinguishes this from ordinary MMB output, source-audited interim code, and the stronger completed binary proof. It does not require a global PA reflection principle.
* Global proof preservation, expansion totality, registry invariants, exact target binding, a final axiom whitelist, and elimination/avoidance of extra syntax axioms are explicit deliverables. The incomplete upstream compiler/verifier chain is not treated as proved infrastructure.
* Streamed source reuse includes a persistent certified factor cache or separately priced replacement. Discarded source segments are not silently accepted as later primality evidence.
* Counts, bitmap byte rounding, decimal artifact sizes, binary memory units, nanosecond/microsecond conversions, and hypothetical wall-time arithmetic are consistent. The final 1.672-microsecond cached-Pocklington calibration gives about 0.0126 core-years at the top-level 2^32 layout.
* Certificate production is separated from an independent consumer's verification. The 100-core-year target and 50–300 range are labeled conditional engineering judgments, not measurements of a complete system, confidence bounds, or optimality claims.

Earlier review corrections were incorporated: measured-input hashing, final primality timings, allocated-core wording, explicit global preservation, conservative foundation translation, and the streamed factor-cache dependency.

## Final native measurements

Independently recomputed all 40 loaded-summary rows and 20 warm-file-summary rows from the final raw wall times, repetitions, and targets per sweep. Each median uses three trials. Loaded denominators equal width times case count; warm-file denominators equal `2*(2^26+2^28)`. Minima, maxima, prefix means, and word-update rates also agree. Both raw files record 40 positive and 44 negative controls and explicitly record that prime certificates were not checked. All 21 manifest file hashes and byte lengths match their current artifacts.

| Final measurement | Native vectorized build | Scalar coverage-loop build |
|---|---:|---:|
| Best loaded 32 MiB case, ns/even | 0.3097459674 | 1.1501390487 |
| Best warm-file parse and check, ns/even | 0.3396267692 | 1.4759251475 |
| Warm-file throughput extrapolated to coverage core-years | 21.5242458 | 93.5384914 |

The best strategies differ: native uses 64K-bit tiles, scalar uses 256K-bit tiles on these measurements. The reported 3.71-fold loaded and 4.35-fold warm-file ratios compare the best measured strategy for each build. The scope correctly uses nanoseconds for coverage and microseconds for anchor-primality checks. The resource model's added 0.31 and 0.34 ns rows are rounded sensitivity inputs, not exact end-to-end measurements.

The updated scope explicitly states that a complete scalar implementation may exceed the 100-core-year central estimate, and that the 50-year end relies on retaining much of the vectorized performance. Its 50–300 range remains a conditional planning envelope. The benchmark does not calibrate the remaining implementation-proof, global scheduling, source-primality, exception, or cold-I/O costs. Scalar refers to disabled coverage-loop vectorization; platform memory routines may use SIMD.

Final wide native/scalar files have retained source, binary, assembly, fixture, and measurement identities. The earlier high-prime-range run's exact executable was overwritten; the report and manifest disclose that provenance limit. It remains supporting historical evidence, not a reproduced measurement of the retained binary. The samples overlap and cannot be counted as independent full-range coverage.

## Remaining evidence boundary

The mathematical and resource-model checks do not validate a universal 512-anchor guarantee, bounded exception cost, sample-to-global certificate sizes, full-range sieve/producer cost, cluster utilization, development schedule, or the final verified implementation's throughput. These uncertainties are disclosed in the scope and remain material.

The scoped final deliverable is a research/project design. No further fundamental proof obligation was found missing from that design. Formal PA rules, the justified executable, integrated producer/checker, complete certificate, and independent full replay remain future work.
