# Raw logarithm construction notes

The original candidate, all eleven expected conclusions, both definitions,
fixed audit and initial manifest were frozen in history/range01 before running
HOL. Parent Horner review bindings were rehashed before preparation.

Range01 stopped at slr_domain_bounds. Its saved heap is preserved in that
archive. The proof used K as a local abbreviation, but K denotes an existing
HOL combinator. Rangediag01 exposed that type-analysis failure. The proof now
uses scale and explicitly associates the natural products before arithmetic.

Rangediag02 through rangediag05 isolated a remaining positive real-power goal
in slr_log_decomposition. POW_POS_LT has a successor exponent, not an arbitrary
one. Rangediag04 also exposed a diagnostic printer failure. The diagnostic
handler was corrected to terminate on failure even when goal printing fails;
no failed run qualified as acceptance. An explicit term printer in rangediag05
showed the unresolved goal. The final proof transports REAL_OF_NUM_POW to the
natural EXP_POS theorem instead. Diagnostic print code was removed afterward.

Rangediag06 passed the first six exact statements, then found missing whitespace
between division and a natural-to-real cast inside a proof quotation. Correcting
that quotation preserved the theorem statement. Rangediag07 passed the first
ten exact statements; the final proof named REAL_DIV_1, which is not available
in this library. It now uses the existing REAL_OVER1 theorem.

Range02 built those ten lemmas but failed in the final triangle combination.
Rangediag08 printed the exact assumptions: std_ss had expanded the natural
2**137 in one opaque numerator and error-bound argument into a large numeral,
while the other two bounds retained the power expression. The linear solver
therefore saw different terms. The final proof establishes grid positivity
explicitly and uses bool_ss for the cast transport, preserving the same grid
expression in all three bounds. The temporary diagnostic printing was removed.

Every diagnostic preserves its input script, input hashes, output, process
receipt and phase timing. They run against the archived failed heap. Their
success markers are exact closed-conclusion checks, but do not replace a final
theory build and execution of the separate fixed expected-term audit.

The final candidate pin check compares all eleven statements and both
definitions with the original and requires the audit to remain byte-identical.
The review accepts only a successful terminal build and audit with matching
source, dependency and output bindings. No numerical schedule was changed and
no campaign throughput credit is inferred from these generic proofs.

Range03 rebuilt all eleven lemmas and executed the fixed audit successfully.
The terminal receipt, all three phase statuses, expected/source/dependency/output
bindings and unchanged original statement/definition/audit checks passed the
recorded-result review. RESULT_REVIEW.md and review_result.json are the accepted
records. All runs in this construction are terminal.
