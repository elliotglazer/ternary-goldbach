# Complete finite-map result

Coordinator recorded-result review, 13 November 2026. Map15 passed construction, export, audit executable construction and audit execution. This is not an independent kernel replay.

## What was checked

The closed `finite_checks` predicate establishes the displayed factorization of 10004, the complete power lists modulo 41 and 61, their distinctness and ranges, the 4800-element residue list's equality after sorting with the independently enumerated coprime residues, every coordinate and inversion check, and all 2301 retained-label checks. The source accepts the evaluator result only when its exact left side is `finite_checks`, its right side is true, and it has no hypotheses.

The exported consequences establish permutation with the expected unit list, distinctness, membership exactly when `r < 10004` and `gcd r 10004 = 1`, and the universal coordinate and label properties over their full index ranges. The audit reloads six roots, rejects open hypotheses and oracle tags other than the existing `DISK_THM` import tag, and checks that the ancestry declares only the four standard HOL axioms. The six printed conclusions were inspected against the source. The audit does not implement a separate exact-conclusion comparison for each root; source pins and this review bind their statements.

The coordinator rehashed all five source pins, eight dependency/tool pins and three exported artifact pins. All match. The audit has exactly the six expected theorem records and one completion marker. The container exit receipt and all three phase time receipts record exit zero.

- Source SHA256: `D60955E54DCA313D3307340859CB1554074BAAC72DFE7F43A40921BC02450449`.
- Audit log SHA256: `5508523CAC02ED24FA9D741F04EC504F9EF3A576D3EF884D30F788DC263002C8`.
- Phase receipts: `map15_theory.time`, `map15_audit_build.time`, `map15_audit.time`.
- Execution arguments and terminal result: `map15_container_launch.json`, `map15_container_exit.json`.

## Construction costs and limits

The complete theory phase used 12.83 CPU seconds and 74.49 wall seconds, with maximum resident memory 312596 KiB. The inner theory script reports 1.6 seconds; this excludes outer setup, scanning and loading and must not replace the complete phase figure. Audit executable construction used 3.23 CPU seconds and 35.79 wall seconds. Audit execution used 4.39 CPU seconds and 14.34 wall seconds, with maximum resident memory 262272 KiB. The three phases sum to 20.45 CPU seconds and 124.62 wall seconds, excluding outer container setup and runner hashing.

These are finite-map construction and reload costs in the bounded container described by `../CONTAINER_EXECUTION.md`. They are not transform throughput or an end-to-end campaign saving. The numeric map is complete for this conductor, but characters, primitive-character interpretation, the old-to-tensor permutation, DFT semantics, source enclosures, error propagation and zero-count completeness require their separate proofs.

## Preserved failures

The complete result follows recorded parser, translation and generic-proof repairs. Failed sources and receipts remain under `history/`. In particular, map08 through map10 were interrupted during environment setup; map11 failed on the container's default user; map12 passed finite evaluation but was deliberately stopped during an unnecessarily expansive generic list proof; map13 and map14 exposed small membership-proof gaps. Map15 supplies the complete export and reload evidence that those partial runs lacked. No partial run is counted as a successful full check or throughput measurement.
