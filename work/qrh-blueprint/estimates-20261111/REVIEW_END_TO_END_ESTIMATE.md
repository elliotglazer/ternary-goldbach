# Independent review of the combined provisional estimate

2026-11-11. PASS for the bounded synthesis, phase accounting, scalar totals and stated uncertainty. No correction requested. This is not validation of the assumed throughput, completion factors, certificate availability or optimized cost.

Reviewed immutable artifacts:

| Artifact | SHA256 |
|---|---|
| END_TO_END_ESTIMATE.md | FF797585713B632A310451898DC68906057E48FEE733B177FF9125A9EFEDEDD7 |
| END_TO_END_ESTIMATE.json | 4E9C232E246C5D2F4EE7FD923215D5B6474DAAFD3817229381D529E7BC9C4358 |
| combine_end_to_end.py | 47BE044B2C99C7A5CC6F2A1B63EBF39A5D87D80B690A319692C84E770AE2DF20 |

I read all three files and checked the five selected input pins against the files. The combiner was not executed. Independent read-only rational arithmetic reproduced all six rows, their phase sums, conversion to core-years, optional replay treatment and storage-field transfer in 45 checks. The underlying finite and spectral workloads were not regenerated. No inventory, benchmark, build or numerical certificate was produced.

The accepted component reviews remain the evidence for their conditional models: `REVIEW_SPECTRAL_COST_ESTIMATE.md`, SHA256 `C19DED53A60BFAFFEB02439B93943E890513EEB40F04B9D9C5F43B5CE5255693`, and the finite accounting review, SHA256 `658199430387F768E48ECF5E7B0DDCF90A746208359FB50F337C45D1B447A4CE`. The former already checked all 21 spectral source-ledger pins. This synthesis does not claim another reconstruction of those historical producers.

## Totals and units

The joined totals, before the document's presentation rounding, are:

| Backend | Scenario | Core-hours | Core-years |
|---|---|---:|---:|
| Lean | Low | 1402126163.743 | 159950.509 |
| Lean | Central | 67748782333.470 | 7728585.710 |
| Lean | High | 10433668302676.207 | 1190242790.632 |
| Ordinary PA MM0, conditional layout | Low | 2487202723.168 | 283732.914 |
| Ordinary PA MM0, conditional layout | Central | 32707475858.018 | 3731174.522 |
| Ordinary PA MM0, conditional layout | High | 8965408152745.180 | 1022747906.998 |

The document's rounded hours, years and central decomposition agree. One core-year consistently means 8766 core-hours. The combiner converts the finite receipt's saved decimal displays to rational numbers; this preserves those displays, not extra precision beyond the original floating Fermi calculation. The distinction is immaterial at the displayed scale and does not convert scenario assumptions into exact cost bounds.

The selected finite candidates are B=10^16 for Lean and B=2*10^16 for the conditional stock-layout MM0 model. The engineered-MM0 finite alternative is not silently inserted. The scenario labels select the matching finite and spectral assumptions once each.

## One first acceptance

The Lean spectral construction estimate already includes initial kernel admission. The primary combined row therefore adds only that construction estimate and the separate finite generation and first checking phases. It does not add another full spectral check.

The optional Lean replay field equals the separate spectral replay plus the finite checking bill. It is excluded from the primary total. The central optional spectral replay is about 59.6 billion core-hours, as stated. MM0 external generation excludes its first checker run, so the MM0 primary total correctly adds both. No optional second MM0 replay is implied by a null field.

The new complete binary pilot is presented as a correctness example, not as a replacement for the older warm arithmetic calibration or as validation of the scalable finite completion factors. The arithmetic pilot measures prepared 21-declaration kernel replays. The synthesis keeps its hypothetical R-based conversion distinct from an observed gate count or production throughput. Neither system receives the other's measured rate.

## Shared work and missing implementation

Common arithmetic and analytic library CPU reserves are owned by the spectral component. The finite reserve is restricted to finite-specific source and position decoders, interval/range assembly and related work. Under that stated ownership the sum does not charge a common library twice. This is an accounting convention for assumption budgets, not evidence of a completed shared build.

The synthesis retains the corrected small-family categories, raw finite-head producer, EM source costs, principal obligation and completeness/repair allowances from spectral v6. It does not add the old raw-head placeholder again or grant an unpriced mean186 reduction. Different auxiliary schedules are alternative scenarios, not additional workloads summed together.

Human formalization effort is excluded explicitly. The positive CPU allowances for libraries and missing producers do not establish their feasibility. The final note correctly retains actual signs, endpoints, multiplicities, count surplus, provider construction and MM0 analytic formalization as unresolved obligations.

## Storage and interpretation

The decimal conversions are correct. Lean's retained modeled bytes give approximately 5.05 exabytes, 107 exabytes and 12.5 zettabytes. MM0's separate assumed pre-retry stream gives 1.17, 8.51 and 461 zettabytes. These two storage columns have different retention conventions, which the headers disclose; they must not be treated as matched measured file sizes.

The finite binary projection of roughly 262 petabytes is kept separate. The ladder's repeated header-access traffic is not added as serialized proof volume. Raw numerical caches, source bitmaps, proof stream size and live checker memory remain distinct. Library serialization and some finite layout sizes are explicitly unestimated, so the table is not a complete storage upper bound. No independent replay requires a second permanent copy, but transport and replay work remain payable.

The conclusion does not claim an optimized implementation, universal Lean/MM0 ranking, reliable elapsed time, completed spectral pilot or completed goal. It explicitly declines to support a production commitment on these models. Its main cost figures are valid as the requested provisional current-design scenarios, subject to all component assumptions and the possibility that no complete successful certificate implementation is obtained.
