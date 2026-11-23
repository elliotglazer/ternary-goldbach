# Source arithmetic recorded-result review

Coordinator review, 13 November 2026. This reviews the recorded construction and reload audit; it is not an independent kernel replay or an analytic producer certificate.

## Accepted scope

The source03 theory phase constructed and exported `SourceArithmeticTheory`. After repairing only the audit executable build rule, source04 completed all three phases with exit status zero. The reload audit checks the exact conclusions and empty hypothesis lists of `source_log_checked_domain`, `source_pool_tick_length`, and `source_mul_residuals`. The last theorem bounds the two integer complex multiplication rounding residuals. It does not establish a complete numerical error budget.

The recorded theory ancestry contains only the four standard HOL axioms listed by the audit. All three loaded theorem tags contain only `DISK_THM` and have empty axiom-tag lists. The audit source checks ancestry, conclusion, hypotheses and permitted oracle tags. This accepts the existing serialized dependency trust boundary; it does not reconstruct every imported theory.

The coordinator rehashed all 16 pinned source/dependency/tool inputs, all three output artifacts, and the receipt's manifest pin. All match. The audit log contains exactly three theorem records and one final completion marker.

- Source SHA256: `A1FC209FE906AC79B9C5447197CD2BB1121039A054F13AE2A376140270EDAA36`.
- Audit log SHA256: `DAE9CE03EA1971D20194547A2B546C6B7241D1A8606BD47E13ABBCB6F6797A6B`.
- Input manifest SHA256: `A480A2142437656F925E882C5F0E555D75DB45223B24B3929E19930243517042`.

## Timing interpretation

The successful source03 theory construction took 7.58 CPU seconds and 41.89 wall seconds, with maximum resident memory 309056 KiB. Its subsequent audit-build phase failed because the executable target rule was missing. That failure remains preserved.

Source04 reused the constructed theory. Its theory phase took 2.70 CPU seconds and 23.13 wall seconds; audit executable construction took 3.04 CPU seconds and 24.94 wall seconds; actual audit execution took 4.13 CPU seconds and 12.31 wall seconds, with maximum resident memory 259836 KiB. These are build and reload costs, not source-generation throughput.

## Remaining work

The integer log, phase and Euler-Maclaurin kernels are defined, but no concrete analytic source values are certified by this result. Logarithm, exponential, pi, inverse-root and Euler-Maclaurin enclosure proofs, the selected anchored-log producer, and integration with the complete Horner/transform/completion pipeline remain open. Supplied logarithm and pi inputs still require semantic certification. No cost-model row or PlattGRH obligation is discharged by the generic timing above.

Earlier failures and statement-preserving repairs are documented in `SOURCE02_RENAME.md`, `SOURCE03_PAIR_NAMES.md`, and `SOURCE04_AUDIT_RULE.md`, with their original inputs and receipts retained under `history/`.
