# Protected verification of ternary Goldbach

On November 26, 2026, Palomar’s stock verifier built `GoldbachSolution` from source and exported `PalomarTernaryGoldbach.ternary_goldbach`. The theorem states that every odd natural number above five is the sum of three primes. The private rehearsal used Lean 4.35.0, Palomar’s trusted Mathlib cache, and the `palomar-namespace-32x64-v1` profile. The candidate and verifier are pinned separately. [Candidate](https://github.com/elliotglazer/ternary-goldbach/tree/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b) · [Stock verifier](https://github.com/PalomarRegistry/PalomarSubmission/blob/046554302064b2c83c2b924bea6db87fc5900c68/scripts/verify_submission.py) · [Research notebook](../README.md)

## Build and export

| Stage | Measured result |
| --- | --- |
| Source intake | 1,529 Lean files, 364,967,482 candidate source bytes |
| Canonical challenge export | 1,434,686 bytes |
| Cold solution build | Exit 0 in 6,266.44 s (1 h 44 min 26 s) |
| Solution export | Exit 0 in 1,946.365 s (32 min 26 s), 6,079,160,562 bytes |
| Protected comparison | Entered at 14:47 UTC. Kernel verdict pending at that observation. |

The build’s cgroup recorded 50,282.361 CPU seconds, or **13.97 core-hours**. Dividing by 6,266.44 elapsed seconds gives an average of 8.02 CPUs. Reserving all 32 vCPUs for that interval used 55.70 allocated vCPU-hours. The cgroup peaked at **62.45 GiB** and reported zero OOM kills. This measurement covers compilation of the candidate with Mathlib already available. The export and kernel phases have separate costs. Both rows in the raw record describe the same build. The export observation captures the report as comparison began, before the verifier had any kernel verdict to record. [Stock build measurements](solution-build-metrics.jsonl) · [Export sizes and phase exits](export-observation.json)

The rehearsal used preinstalled verifier tools. Its accounting clock started at 12:07:57 UTC, before setup of the protected attempt. The local proof cutoff was 16:57 UTC, giving 4 h 49 min 3 s of the profile’s published 5 h 30 min execution budget. There were about 2 h 10 min left on the local clock when comparison began. The entry process and the verifier child shared a cgroup ancestor that enforced the 32-CPU quota, 64-GiB memory limit and zero swap. [Measured profile and clock](profile-and-clock.json) · [Published profile policy](https://github.com/PalomarRegistry/PalomarSubmission/blob/046554302064b2c83c2b924bea6db87fc5900c68/README.md)

## Which GRH proof was compiled?

The upstream compact directory contains 794 Lean files totaling 7,420,187 bytes. We hashed the original files, reconstructed their Git tree, and matched it to the published community commit. We then read the corresponding 794 Git blobs at the Goldbach candidate revision. Every original and converted SHA-256 matched the port manifest. The converted files total 7,472,018 bytes. [Upstream source](https://github.com/leanprover-community/riemann-hypothesis/tree/72fead102f663d5c7a407964a13dc0cf9d977207/grh-compact/src) · [Port manifest](https://github.com/elliotglazer/ternary-goldbach/blob/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b/CompactGRH/source-manifest.json)

In `Statements.lean`, `New/Main.lean` and `Main.lean`, reversing the module header, public-import markings and public-section line recovers the upstream bytes exactly. This covers the statements and the exported declarations used at the final step. `CompletedGoldbach.lean` applies `GoldbachFinite.completed_of_release` to `riemannHypothesis` and `LFunction_eq_zero_re_of_isPrimitive`. [Community declarations](https://github.com/leanprover-community/riemann-hypothesis/blob/72fead102f663d5c7a407964a13dc0cf9d977207/grh-compact/src/Main.lean) · [Candidate declarations](https://github.com/elliotglazer/ternary-goldbach/blob/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b/CompactGRH/src/Main.lean) · [Goldbach application](https://github.com/elliotglazer/ternary-goldbach/blob/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b/CompletedGoldbach.lean)

The earlier warm build recorded each imported source file and its compiled artifacts. Starting from `Main` and `CompletedFiniteRows`, we followed the project imports in those records and matched all 794 GRH files and 732 Goldbach files to the candidate Git tree. The remaining three Lean files are the final theorem, its solution wrapper and the independent challenge. The warm Lean import reported `propext`, `Classical.choice`, and `Quot.sound`. [Source comparison](source-provenance.json) · [Warm theorem audit](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/joined-theorem-3ca2fcf7/fresh-import.log)
