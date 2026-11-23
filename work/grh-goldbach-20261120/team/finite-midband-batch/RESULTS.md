# Finite binary Goldbach near 612 billion

Lean verified every even integer in `[612345678900, 612614114356)`, a prespecified block of 134,217,728 evens. On this block, producing the witnesses took 3.72 CPU seconds and compiling the proof together with its data took 45.20 CPU seconds. Repeating that rate over the 450 billion evens from 100 billion through one trillion would cost approximately 45.6 core-hours before one-time setup and the final join. The 256 rows share 19,142 anchor occurrences. This sample covers about 0.030% of the proposed decade.

## Native witness generation

Both procedures enumerate anchors, cover identical masks and deliver the same original per-row inverses. Grouping works even when two rows share prime factors. Reducing the group inverse modulo each row product recovers its individual inverse. The Lean proof also checks the divisibility and modular-inverse implication. No primality result from the native program is assumed by Lean.

| Work on all 256 rows | Original, CPU seconds | Revised, CPU seconds |
| --- | ---: | ---: |
| Find candidate primes | 5.875 | 0.203125 |
| Select and recheck coverage | 2.921875 | 2.921875 |
| Compute modular inverses | 4.046875 | 0.593750 |
| Total of measured phases | **12.843750** | **3.718750** |

The revised search sieves through 257 and then calls FLINT on the survivors. The original and revised searches returned the same candidate arrays at every row. Combining 32 row products per inverse gave a 3.45-fold reduction in producer CPU. Restoring all 256 original inverse fields, if needed by an existing checker, took another 0.015625 CPU seconds. The shared native setup took 0.28125 CPU seconds. Details are in `producer.json`, `recover.json` and `BatchWitness.lean`.

## Lean timings on identical input

For this comparison every module imports the same compiled data. Each line measures a fresh Lean process, including imports, elaboration, checking and object output. The recorded times measure whole processes and do not isolate kernel reduction.

| Rows per inverse | Proof process, CPU seconds | Peak resident memory, KiB |
| ---: | ---: | ---: |
| 1 | 41.109375 | 1,644,144 |
| 4 | 37.921875 | 1,577,208 |
| 8 | 38.734375 | 1,600,608 |
| 16 | 34.312500 | 1,683,300 |
| 32 | 33.109375 | 1,867,960 |

The reduction in whole-process Lean time was 19.5% for groups of 32. Compiling the all-variants data module separately took 28.6875 CPU seconds. An independent one-module build that includes only the required group-of-32 data took 45.203125 CPU seconds and peaked at 1,876,704 KiB. Direct receipts are `BandRows.json`, `BandBaseline.json`, `BandGroup*.json` and `BandFused32.json`.

On the first fused pair, the original per-row implementation took 42.53125 CPU seconds (29.875 user, 12.65625 system) and the grouped implementation took 45.203125 (25.21875 user, 19.984375 system). Wall times were 45.52 and 173.57 seconds. The two measurements encountered different machine loads. With the producer included, the first pass took 55.375 versus 48.921875 CPU seconds. Both fused `covered` theorems and both endpoints of the matched imported-data comparison reported `propext`, `Classical.choice` and `Quot.sound` from `#print axioms`. The four corresponding `.log` files record the audits.

The factorial certificate for the entire decade took 21.0625 CPU seconds to generate and 223.53125 CPU seconds to prove across nine successful Lean processes, with a peak of 1,840,532 KiB. The source-prime bitmap took 62.53 CPU seconds in its own earlier build. The generic group-inverse lemma took 22.6875 CPU seconds to compile. Together these add about 0.092 core-hours once. The extrapolation assumes compiled Lean and Mathlib dependencies and excludes final cross-block assembly.

The reverse-order replication in `repeat/` took 67.8125 CPU seconds for the original fused proof (46.75 user, 21.0625 system) and 49.5 CPU seconds for the grouped proof (34.890625 user, 14.609375 system). Both exited zero. Their wall times were 122.31 and 52.31 seconds. With the same measured producer phases, their totals were 80.65625 and 53.21875 CPU seconds. Across the two paired runs, grouped end-to-end time fell by 12% and 34%. The grouped midpoint rate projects **45.6–49.6 core-hours** for the decade. The two observations show timing variation, not a statistical confidence interval. The receipts are `repeat/BandFusedBaseline.json` and `repeat/BandFused32.json`.

## Scaling evidence

| Measurement | Native witness CPU seconds | Lean CPU seconds, including row data | Evens |
| --- | ---: | ---: | ---: |
| Near 99.25 billion, existing separate row-data and proof modules | 21.546875 | 47.640625 | 134,217,728 |
| Near 612.35 billion, fused groups of 32 | 3.718750 | 45.203125 | 134,217,728 |
| Ending at one trillion, independently checked endpoint block | 20.578125 | 63.140625 | 134,217,728 |

At their observed rates, the midpoint and high-endpoint implementations imply approximately 46 and 78 core-hours for the decade, respectively. These are two sample-based scenarios. They do not bound performance on the entire interval. The endpoint run uses different grouping and packaging, so the difference cannot be attributed solely to magnitude. The shared factorial permits reuse throughout this decade. Larger decades require a different-sized primality certificate and fresh measurements. The corresponding endpoint receipts are `../finite-adjacent-block/RESULTS.md` and `../finite-trillion-endpoint/BLOCK.md`.

## Checked prefixes for comparison

| Inclusive bound | Independent native scan, CPU seconds | Witness generation, CPU seconds | Lean replay including audit, CPU seconds | End to end, core-hours |
| ---: | ---: | ---: | ---: | ---: |
| 100,000,000, greedy anchors | 0.53125 | 3.30 | 31.72 + 9.25 | 0.0123 |
| 1,000,000,000 | 9.46875 | 9.98 | 100.75 + 9.70 | 0.0335 |
| 10,000,000,000 | 145.625 | 82.14 | 1,105.23 | 0.330 |

The native column is a separate complete scan; it is excluded from the end-to-end totals. Those totals include file assembly or splitting. The upstream ternary-Goldbach adapter adds 53.31 CPU seconds to the ten-billion run. The smaller prefix tables and their receipt links are in `../small-prefix/README.md` and the `scan8.json`, `scan9.json` and `scan10.json` native receipts. On the latest audited contiguous extension, band 4 added 7,247,757,312 more even integers and reached 46,104,568,832 at cost 383.078125 CPU seconds for producing the witnesses and 1,589.59375 CPU seconds for Lean. This is the incremental band cost. Its receipt is `../small-prefix/contiguous-extension/GoldbachBand04Receipt.json`.
