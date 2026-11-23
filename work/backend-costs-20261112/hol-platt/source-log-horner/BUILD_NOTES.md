# Build and repair record

Horner01 proved the two polynomial identities, then failed in the range proof. The natural-to-real product cast needed its forward orientation, and the final square inequality needed to use the proved rational-square equality.

Hornerdiag02 reached the integer-square cast proof and hit the bounded diagnostic timeout in the broad simplifier. A direct INT_EXP/real_of_int_num rewrite followed by REAL_OF_NUM_POW proves the same exact statement. Hornerdiag03 then proved the range, square cast, denominator positivity, unrounded value and actual half-unit rounding error. The contraction and center estimates needed their existing scalar c*1 bounds normalized in assumptions as well as in the goal.

Hornerdiag04 proved the one-unit actual Horner invariant and the final 7/(4*grid) center bound, then hit the diagnostic timeout while rewriting with the symmetric ABS_SUB rule in the analytic-error combination. Hornerdiag05 instead proves the required absolute-value orientation by ABS_SUB, applies the triangle inequality without that symmetric rewrite, and uses the exact rational ratio identity for ln(2). All eleven remaining exact roots passed with empty hypotheses. Together with the first build's two polynomial identities, every candidate proof has now passed a direct check.

Horner02 integrates only these proof repairs and runs the full recorded-result audit. All thirteen original theorem statements, the ideal-recurrence definition, the fixed audit and the parent source/compiled bindings are unchanged. No failed or diagnostic attempt supplies campaign throughput evidence. Original sources, saved heap and diagnostic scripts are preserved.
