# Integer logarithm Horner result review

Run horner02 is accepted for the actual integer Horner and reduced-logarithm
center scope. All thirteen frozen conclusions passed the recorded-result audit,
with empty hypotheses, permitted import tags and standard HOL ancestry. The
three exact program types passed. The original theorem statements, ideal
recurrence definition and fixed audit are unchanged. All seventeen expected-source,
six run-source, forty-nine dependency and three output hashes match. This run
rebuilt the theory and executed the audit; compiling the audit alone did not
qualify as acceptance.

The actual source_log_horner program differs from grid times the ideal real
recurrence by at most one integer unit, for any term count and starting index,
under 0 < B and 3*A <= B. The polynomial identity is proved. The actual
source_log_center program, including its final rounded multiplication, differs
from the corresponding polynomial by at most 7/(4*grid) after normalization,
with grid positive. No external approximate-value or rounding premise is assumed.

Combining this result with SourceLogTail gives the actual 45-term center bound

    abs (real_of_int (source_log_center grid A B 45) / &grid
         - ln ((1 + &A / &B) / (1 - &A / &B)))
      <= 7 / (4 * &grid) + 1 / 2 pow 135,

under 0 < grid, 0 < B and 3*A <= B. The computed ln(2) center is the A=1, B=3
specialization of that same program, with the same bound.

Successful construction and audit phases consumed 67.96
CPU seconds, with 215.221 container elapsed seconds.
All recorded experiment phases total 350.94 CPU seconds, including failed
and timed-out diagnostics, excluding untimed orchestration and file handling.
These are generic proof-development timings, not numerical production prices.

The repairs were a cast-rewrite orientation, use of the proved rational-square
identity, a direct power-cast proof, normalization of scalar error hypotheses,
and a directed absolute-value equality in the final triangle argument.
BUILD_NOTES.md preserves the failed and timed-out attempts. They receive no
campaign speed credit.

This is recorded-result review/reload, not independent whole-kernel replay.
Range reduction, the raw logarithm output regrid, exponential phase production,
complete source/sign/count blocks and the remaining campaign strata are open.
The campaign forecast is unchanged and the full goal remains active.

| Artifact | SHA256 |
|---|---|
| SourceLogHornerScript.sml | 274d41570548c8f3267e4c3e2706a79598b9783de572d92c2ca453404921ce59 |
| horner_audit.sml | f00efaaf1d402be81929b210ccb57fe11ac52c4e1f840e6ce85c47f8b0f6d2b8 |
| source_expected.sha256 | 81ab2bce7383f2f67d38767f1380026a9b38a8958892c4aff99935c452e2f76c |
| .hol/objs/SourceLogHornerTheory.uo | 0336c5b673683c648a2de5317366607af4b695f24f188a5805af9deb166289e2 |
| .hol/objs/SourceLogHornerTheory.dat | 73f917449b5ed4662509b8ec8b515c7051e58435c123778620f31f92e8393bea |
| horner02_audit.log | 9e943d5c0ff6a476808a8e5e2e6f8cbea573019f407fb7fcf5f0f8d79bdd1cf2 |
