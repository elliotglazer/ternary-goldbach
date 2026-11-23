# Actual exponential Horner rounding result review

Run exphorner02 is accepted for the rounding error of the actual integer Horner
routine against its explicitly defined ideal complex recurrence. All twelve
original exact conclusions passed the recorded-result audit with empty
hypotheses, permitted import tags and standard HOL ancestry. Five exact program
types passed. Seventeen expected-source, six run-source, forty-nine dependency
and three output bindings match. The original twelve statements, three
definitions and fixed audit are unchanged. Accepted state-error and raw-log
bindings were rechecked. The run rebuilt the theory and executed the audit.

For d>0 and abs(real_of_int p / &d)<=2, the actual source_exp_horner program
differs from grid times seh_ideal by at most seh_bound k in Euclidean complex
modulus, for every term count n and starting index k. The bound is 9 at k=0,
4 at k=1 and 3 at k>=2. Each local rounding error is proved from the actual
round_scaled calls. The ideal terminal value and affine update are explicit
definitions, and their integer/cast connection is proved. No assumed local
rounding accuracy or externally supplied ideal-value equality is used.

This is an unscaled rounding theorem. It does not yet identify seh_ideal with
the exponential Taylor polynomial or bound the analytic remainder. The actual
raw phase range, output-grid normalization, final regrid and analytic phase
perturbation still require their joins. The EM producer has separate range,
period and precision requirements. No change to precision or update count is
made here.

Successful construction and audit phases consumed 47.63
CPU seconds and 193.068 container elapsed seconds.
All recorded experiment phases total 209.91 CPU seconds, including failed
and timed-out diagnostics, excluding untimed orchestration and file handling.
These are generic proof-development costs, not numerical production throughput.

This is recorded-result review/reload, not independent whole-kernel replay.
Complete source/sign/count blocks and the other campaign strata remain required.
The frozen forecast is unchanged; no aggregate speed credit is assigned and the
full research goal remains active. BUILD_NOTES.md records the failed attempts.
NEXT_ANALYTIC_CONNECTION.md records the next actual-phase obligations.

| Artifact | SHA256 |
|---|---|
| SourceExpHornerScript.sml | 2e61253128c2266874f12cc8d2a984c68f16ec1d48993091b46a95fbd993d6c7 |
| exp_horner_audit.sml | 8624d41be43a40b9be239382194b143704b2c726f2e9800bbe7602dc47be843d |
| source_expected.sha256 | 92ba39f1e265f42d8db9a7d9b092ce04cd65670a0ed5e4cd6113fc1f11627bbc |
| .hol/objs/SourceExpHornerTheory.uo | c437df63ce5e8a8b75b0622edea038d224247fdc48bd0450e704b53d4801fc1e |
| .hol/objs/SourceExpHornerTheory.dat | a4d8c1e60675ecb3ac742c47295863852b638fef975776f0a645686bbd6e0063 |
| exphorner02_audit.log | 5ef8d4d8e9c7783f5fac3d2c47f9dd8437f0f78ce41e2ceed7cd9c021abb627f |
