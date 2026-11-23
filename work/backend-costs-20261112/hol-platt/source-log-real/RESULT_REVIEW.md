# Logarithm tail result review

Run logtail05 is accepted for its stated analytic scope. All twelve original exact
conclusions passed the recorded-result audit with empty hypotheses, allowed
import tags and standard HOL ancestry. The two definitions, all theorem
statements and twelve expected audit statements are unchanged from the candidate frozen before the
first build. All 5 expected-source,
6 run-source,
41 dependency and
3 output hashes match current files. The actual
theory was rebuilt; compiling an audit module alone was not treated as running it.

The accepted result proves, for 0 <= v <= 1/3, the error bound

    abs (ln ((1+v)/(1-v)) - sl_log_partial n v)
      <= (9/4) * (1/3) pow (2*n+1).

The 45-term specialization is at most 2^-135, including ln(2) at v=1/3. The proof
uses the exact remainder derivative, the real mean-value theorem and an exact
rational inequality. No new analytic assumption or imported Lean theorem is used.

Successful construction, audit compilation and audit execution consumed
34.89 CPU seconds, with 163.363
container elapsed seconds. All recorded proof-build and diagnostic phase times
in this directory sum to 156.65 CPU seconds, including the retained
failed and redundant attempts. This sum excludes untimed orchestration and file
handling. Neither timing is a production-source or campaign throughput price.

The derivative induction required explicit denominator cancellation and
distributivity. Endpoint positivity and the already-introduced existential
witness were made explicit in the remainder proof. BUILD_NOTES.md records the
failed integration attempts, which received no theorem or speed credit. The audit
wrapper also contained a leftover SourceInitial ancestry/root block, which stopped
the audit before any root checks ran. That foreign block was removed; the twelve
expected logarithm statements and validation loop are unchanged. The review checks
that this is the only difference from the original audit source.

This is a recorded-result review/reload, not an independent whole-kernel replay.
The actual integer Horner refinement, its rounding, range-reduced logarithm,
exponential step and complete source/sign/count blocks remain open.
NEXT_INTEGER_CONNECTION.md records the next precise source contract. The frozen
campaign forecast is unchanged and the full active goal remains incomplete.

| Artifact | SHA256 |
|---|---|
| SourceLogTailScript.sml | e95cddf353628f08691d03d28bce4c20809f5cfc59ea7978d0b054d1165cb24e |
| log_tail_audit.sml | ef3d003c6c3c22def73c28064d31c2ab70593d5c89e6fdca1d2bb50d0b1a554e |
| source_expected.sha256 | 6831c19a335026672aeeabb09a7e3dc954ceb31cfdd087ec790c93e1c64f4a44 |
| .hol/objs/SourceLogTailTheory.uo | 0fe4d8fbf602eadeacf3fec84fa84cb3796d6e25d1717299fe7220aa62095c4d |
| .hol/objs/SourceLogTailTheory.dat | 51551c3a6945b6663a02b8015b477848883639a0b764dc1d856eb6baa745b11b |
| logtail05_audit.log | 01a8db8b1c1132de165244f898aa8b74ed4740e703cfce8ec1139f711f22eced |
