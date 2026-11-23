# HOL4 comparison setup

This is an in-progress comparison. StageCheckScript.sml now compiles, proving
the exact matched integer predicate implies the residual specification for
arbitrary matching lists. Its cv_compute translations also have checked
correctness theorems. The four-case benchmark, rejection controls, axiom/oracle
audits and export now pass, as does the separate P343N64 phase profile.

Source is HOL-Theorem-Prover/HOL develop at
1de64f8521b4758508bd875fbaf11d1768261b92. source.json records the archive URL,
size and hash; source_commit.json preserves the fetched commit metadata.
The 28482345-byte archive has SHA256
b90500015802153d18f8af64a746323ff35282241f2d6ca9f7a7d143ea59c77d.

Poly/ML 5.9.1-r1 and its compiler dependencies were installed using Alpine
v3.22 packages into this directory's sysroot, not the system installation.
prepare.py supplies wrappers, a relocated polyc launcher and HOL4's documented
configuration override. run.sh sets the workspace runtime/library paths.
setup_manifest.json hashes those files and the installed package database.

The HOL4 build tools configured successfully in 26.76 CPU seconds and
36.67 elapsed seconds, with 321912 KiB peak RSS. configure.log/.time record it.

The initial core build with selftests reached the build-system regressions and
failed because a test launcher required /bin/bash, which Docker Desktop does
not provide. It consumed 135.06 CPU seconds, 383.01 elapsed seconds and peaked
at 538196 KiB. build_core_missing_bash.log/.time preserve the failure. A local
Bash was installed, and patch_shells.py changed seven test launcher shebangs
to /usr/bin/env bash. Test bodies and prover sources were unchanged;
shell_patches.json records before/after hashes.

The same core build/selftests then resumed incrementally. Session 51473 ended
with exit 1 after building the kernel, base theories and normal HOL heap. The
cv_compute, datatype, list and boss selftests passed. The later statementdossier
test failed because Pandoc is absent; it is a documentation-rendering test.
This is not a fully passing core regression run. build_core.log/.time retain
the result: 789.36 CPU seconds, 1220.73 elapsed seconds, 718584 KiB peak RSS.
The command was:

    ../run.sh bin/build -t --seq=tools/sequences/upto-parallel

The arithmetic automation and 32 prerequisite theories built successfully.
The first local StageCheck proof attempt failed because a rewrite left let-term
beta reductions unresolved. SIMP_TAC bool_ss fixed that assembly. Naming the
induction variables explicitly fixed a separate list-proof issue. The final
successful run is build_stage_lists.log/.time, exit 0, 14.50 CPU seconds,
64.52 elapsed seconds, 397660 KiB peak RSS. This includes dependency scanning
and loading; HOL reports 1.0 second for the theory itself. It is not numerical
fixture throughput. The earlier failed attempts and diagnostic logs remain.

BlockRoundScript.sml also now compiles: nearest-rounding residuals and all four
output errors are proved for positive scale. cv_trans_pre exposed division's
precondition, and round_scaled_pre_ok/rounded_butterfly_pre_ok prove it from
positive scale. build_constructed.log records the successful final build.
This is not a complete network or FFT proof.

The original quotation-based run completed the three 64-row cases but was
deliberately stopped during the 256-row parse, after 829.84 CPU seconds and
838.21 elapsed seconds, peak RSS 4429036 KiB. benchmark_validated.log/.time
retain that incomplete trial, exit 143. It did not finish the controls/export.
The old name of that log is not a success assertion.

The separate P343N64 profile does complete, with exact equality of the ordinary
and prepared conclusions, an empty-hypothesis residual theorem and export.
profile_validated.log/.time have exit 0 and HOL4_PROFILE_DONE. Median raw
kernel conversion is 0.034459 seconds; median prepared conversion back to the
integer checker is 1.432587 seconds. Input representation cost 5.197249 seconds.
The ordinary call in this same run costs 8.632504 seconds. Direct integer term
construction costs 0.451735 seconds, avoiding the 62.558840-second quoted parse.
The raw timing is NOT a full integer theorem cost. The exported file is
.hol/objs/StageProfileResultsTheory.dat, 456532 bytes, with ordinary HOL4
saved-theorem loading trust; it is not an independent proof trace.

Session 67434 completed with exit 0. CONSTRUCTED_RESULTS.json checks the full
completion marker, all four saved residual theorems, all four rejection
markers and the context/oracle audits. It records medians 1.115955 / 2.990814 /
3.917289 / 64.609616 CPU seconds for P100N64 / P343N64 / P415N64 / P343N256.
The last three calls are 51.574 / 93.593 / 64.610 seconds, showing poor scaling
and substantial variation. The whole run costs 254.79 CPU seconds and 260.61
elapsed seconds, with 15251348 KiB peak RSS. The exported
.hol/objs/StageConstructedResultsTheory.dat is 4787855 bytes. All logs, sources
and export hashes are pinned in the JSON. No HOL4 process remains active.

The audit must inspect DB.axioms over StageCheck's ancestry as well as theorem
oracle tags. Tag.sml does not serialize axiom lists into saved theory tags, so
an empty axiom tag after reloading is not a transitive axiom audit. The generated
benchmark initially rejected an additional axiom, then source inspection found
bool.BOOL_CASES_AX at boolScript.sml:228, the upstream Boolean-exhaustiveness
axiom. The completed profile allows exactly HOL4's four standard bool axioms,
including that one. It does not claim a three-axiom Lean result or a cross-system
translation. Only DISK_THM is allowed among imported oracle tags. A fresh source build and
ordinary HOL4 kernel/library-loading trust remain part of this experiment.

## Dependent block completed, 13 November 2026 UTC

DependentBlockScript.sml proves the dependent network's length and local-residual
contract, the acceptance implication and evaluator preconditions. Final theory
build build_dependent_v5.log/.time succeeds, costing 12.02 CPU / 52.31 elapsed
seconds with 425716 KiB peak RSS. Previous failed builds remain recorded.
An unbounded recursive simplification in v3 was stopped; Once fixes it. The
concrete wrapper now proves the scale positive using intLib.REDUCE_CONV and
discharges block_accept_pre using block_accept_pre_ok. It never assumes it.

dependent_run.log/.time and dependent_replay_sample_2/3.log/.time all finish
with exit zero and HOL4_DEPENDENT_BLOCK_BENCHMARK_DONE. All four positive
theorems and five negative controls pass, with empty hypotheses and the
existing four-standard-axiom/context and oracle audits. The three saved .dat
exports are identical. All run handles are terminal; no benchmark is live.

DEPENDENT_RESULTS.json summarizes and pins the complete evidence. The
8192-butterfly block's pooled HOL median is 73.960 ms, versus 3.747830 ms for
the matching native GMP implementation. HOL calls range from 64.013 to
123.944 ms. Native checks all reference coordinates and all five controls.
The literal input/coefficient translation costs a separate median 4.269485
CPU seconds, shared across cases. The initial complete process costs 18.62
CPU / 27.51 elapsed seconds and 1385580 KiB peak RSS. Export is 1655281 bytes.

DEPENDENT_BLOCK_REPORT.md explains the exact contract and limitations. It is
a rotated dependent integer network, not an FFT. The checksum is an exact
output statistic, not a hash assumption or an assertion of vector equality.
Real interpretation, root and source enclosures, global error propagation,
zero counts and finite prime coverage remain absent. DEPENDENT_SENSITIVITY.json
contains only conditional component extrapolations. Matching stock Lean and
Candle implementations, fresh-input costs and the full forecast remain next.
