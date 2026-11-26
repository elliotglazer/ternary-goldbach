# Goldbach verification experiments

This supplement records what was measured during the late-November Lean 4.35 work. The [experiment index](experiment-index.json) covers 18 questions. It distinguishes 29 newly extracted records from 21 references to byte-identical public originals. The [historical source index](public-history.json) also identifies the earlier proof-system notes, cost estimates, formalization metadata, and theorem receipt. Each historical entry gives the immutable revision and SHA-256 of the original bytes.

| Question | Observation | Evidence |
| --- | --- | --- |
| Did both kernels accept binary Goldbach through 10¹⁰? | Yes. NanoDa accepted during the first attempt. The Lean default kernel accepted the same challenge and solution exports on a retry. | [Both attempts and the export hashes](experiments/finite-10e10.json) |
| How much did balancing the tile expression save? | On the matched 64-tile comparison, the selected phases used 276.68 fewer CPU seconds. The individual phase times and export sizes allow the comparison to be recomputed. | [64-tile comparison](experiments/64-tiles.json), [adjacent leaf repeats](experiments/adjacent-variants.json) |
| Why did C emission matter? | For the 32,768-hex-digit fixture, changing the literal declaration from `def` to `noncomputable def` reduced generated C from 42,828 to 2,545 bytes. The production follow-up and its source hashes are in the same file. | [Literal and C-generation measurements](experiments/literal-c-emit.json) |
| Why did protected Python startup fail? | Both copied interpreters exited 127 with a missing shared library. The symlinked Python 3.11.18 interpreter completed the same stock confinement control with exit 0. | [Three sandbox executions](experiments/sandbox-python.json) |

### Native compilation

The [compiler measurements](native-module-measurements.jsonl) cover 606 runs across 558 named modules. Of these runs, 569 exited zero and recorded the compiled object digest. The 37 nonzero exits include source errors and resource interruptions. The [summary](native-module-summary.json) gives counts for the six contributing collections.

Each row gives the SHA-256 of its original report, the Lean module and source digest, the recorded exit, and the producing tool’s time field. An elapsed duration includes time spent waiting. CPU seconds are available separately when the original report provided them. Adding timings across rows would double-count repeat trials and overlapping work.

For 582 rows the source digest matched a blob in candidate `3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b`. Re-reading the Git objects confirmed 555 distinct source blobs across those rows. The match connects a module measurement to exact source bytes. Each original run used its own dependency objects and build options. A whole-project, protected verdict requires its own run.

### Rechecking the data

Run `python3 verify_evidence.py` in this directory to check the supplement’s checksums and row counts. Add `--source-repo PATH` with a checkout containing the pinned commit to verify candidate source bytes. Add `--original FILE` to compare an available original report with the extracted measurements. The option can be repeated. These checks require Python 3.9 or later and Git for the source comparison.

The [verification record](verification.json) gives the number of original records reopened for this release. [SHA256SUMS](SHA256SUMS) covers the files in this supplement. Benchmark extracts contain selected measurements and identifiers for mathematical artifacts. An original report’s hash covers its complete unmodified bytes. The hash of an extract covers its own published contents.
