# Map04 cancellation and explicit proof repair

13 November 2026. The coordinator reported that map04 was intentionally stopped by sending SIGTERM to the verified leaf HOL process 32 belonging to the exact map04 working directory and command. Holmake records `FAIL<Signal F>` and the outer phase exits 1. This was an owned cancellation, not a mathematical failure or the 600-second timeout.

The preserved timing receipt reports 330.67 user CPU seconds, 26.16 system CPU seconds, 356.83 total CPU seconds, 390.88 elapsed seconds, and maximum RSS 1,035,892 KiB. The last inner messages save the fuel-sort definition and report a context-snapshot warning. They do not identify which tactic was active. No correctness theorem, translated map checker, or numerical map evaluation was reached. This incomplete generic-helper proof effort must not be reported as finite-map evaluation time.

After the coordinator confirmed terminal status and authorized the change, the exact separate proof alternative in `QSORT_EXPLICIT_BOUNDS_PROOF_DRAFT.md` was applied. Only the proof body of `map_num_qsort_fuel_correct` changed. Its statement, fuel-sort code, wrapper, all original finite checks, and final claims are byte-identical. The replacement explicitly derives two partition-length bounds, composes each with the predecessor-fuel bound, instantiates the induction hypothesis twice, and rewrites the same QSORT recursion. It removes the broad final transitivity search. This is a proposed proof repair, not a claim that the former search was definitively the active tactic.

The previous source, both quicksort notes, and outer/inner map04 logs are archived under `history/map04_owned_cancellation/` with `SHA256.json`. Original receipts remain untouched. No build, evaluator, or process action was performed by this author. The successor still requires compilation under the unchanged resource limits.

| Artifact | SHA256 |
| --- | --- |
| Cancelled map04 source | 5E18B255AD5B22D1AE56DE083F68206E99DCDF1927D7FA0F068AE4B41126CA05 |
| Successor C10004MapScript.sml | 7D933BB826C0B8461007E24297C9C74C0B0BE1ABF6E7F98C9ABB7B71A3AF1CD3 |
| Reviewed disjoint proof draft | B499DE70AEC6BFBF034965CE56A2F8F138309AFC34850D567565C6250C3D4929 |
| map04_theory.log | 38E87547B4E71C62AB07471B520B157790C20FB54AFF66B5E1D181210CF0E806 |
| map04_theory.time | 6D67423E6932A914F669A8CE81D462E96A2C90D9C63B57220A03312D27B9CB14 |
| Archived inner theory log | E39D2CCE07B02E759564F5635C8E3D664533842FA7DE9BB16A136C1AAB131769 |

All finite-domain, character-semantics and DFT limitations in the original review remain. No map result is accepted by this note.
