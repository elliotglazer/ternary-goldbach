# Computational backend comparison

Objective: continue researching options and establish time/computational costs for
each, for an end-to-end standard-foundation proof of ternary Goldbach.

Compare stock Lean, Rocq VM/native conversion, HOL4 cv_compute, Candle, ordinary
MM0, and a prospective specialized verified evaluator. Include a native arithmetic
baseline. Distinguish measured timings, source-reported timings, projections, and
currently unknown costs. Do not transfer a speed ratio across unrelated workloads.

Required evidence:

1. Same finite acceptance predicate and literal data for cross-backend arithmetic
   measurements, with soundness statements and negative controls.
2. Timings separating construction, checking, imports/setup, memory and proof size.
3. Trust contract for each backend, including whether it produces a result accepted
   by stock Lean, an ordinary MMB checker, or a different verified kernel.
4. Spectral and finite-Goldbach workload accounting. End-to-end estimates must retain
   source generation, roots, error propagation, counting, and coverage obligations.
5. Engineering/setup effort and limitations, with no claim that an unimplemented
   backend or unverified translation already exists.
6. A comparison report and reproducible scripts, plus a recommendation supported by
   the measured or explicitly conditional costs.

Initial authoritative artifacts: ../lean-pilots/batched-transform and the older
../qrh-blueprint/estimates-20261111 models. The latter contain stale progress prose
and unvalidated mappings from operation counts to Lean/MM0 costs. Preserve them as
historical models; do not treat their totals as measured efficient implementations.

2026-11-12 inventory: Rocq 9.1.0 with OCaml 4.14.2 is installed. Stock Lean 4.35
and the prior fixtures are present. The existing WSL docker-desktop distribution
starts, but compiler/HOL tools were not on its PATH during the first inspection.
The Docker daemon was unavailable during that inspection. No new goal completion
claim is supported yet.

Checkpoint, 2026-11-13 UTC: Candle's closed arithmetic output and isolated
export, HOL4's four matching arithmetic fixtures/controls/export, and actual
Rocq 9.0 native/VM comparison with independent replay are complete. See REPORT.md
and the backend RESULTS.json files. Every subprocess has ended; no build or
benchmark handle needs resuming. Do not repeat those completed pilots without
a new implementation question.

The local output-producing rounded butterfly and its positive-scale evaluator
precondition now have HOL4 proofs. The next useful experiment is a genuinely
dependent block with compact inputs/conclusions, measuring the entire sound
acceptance path. Ordinary PA MM0, source/root/zero-count workload coverage,
backend-specific finite-coverage costs and the end-to-end forecast remain
unfinished. The persistent research goal remains active.

Later checkpoint, 2026-11-13 01:47 UTC: the dependent arithmetic network and
matching native GMP benchmark are complete, including three fresh processes
per backend. HOL4 derives closed local-residual/length/final-bound/checksum
theorems, rejects five controls and produces identical exports. See
hol4-setup/DEPENDENT_BLOCK_REPORT.md, DEPENDENT_RESULTS.json and the explicitly
component-only DEPENDENT_SENSITIVITY.json. The largest block has pooled medians
73.960 ms HOL acceptance and 3.747830 ms native execution; fresh literal setup
is a separate 4.269485 CPU seconds. All subprocesses are terminal.

The immediately preceding goal turn primarily restated existing evidence and
is classified as no progress for the goal's continuation audit. This turn
revalidated that state, implemented the next experiment, measured it and changed
the next action. It is progress. Remaining work is the matching algorithm in
stock Lean/Candle, input representation/production, ordinary PA MM0, separate
prime coverage, and complete workload/engineering costs. Analytic roots, source,
propagation and completeness contracts remain outside the pilot. The objective
and completion requirements above remain intact; the goal is active.

Checkpoint, 2026-11-13 UTC, after the stock-Lean comparison: the matching
dependent network, generic integer contract, five controls, exact standard
axiom audit and twelve fresh replay processes are complete. The 8192-butterfly
Lean median is 13.464615 elapsed seconds. A separate packed-Nat experiment also
passes all audits and 24 replay processes; it finds modest small-batch gains,
large-batch losses, and a fix for slow input-literal parsing. The generic
packing-to-pointwise-products bridge remains unproved. See lean-dependent's
REPORT.md, RESULTS.json, PACKED_REPORT.md and PACKED_RESULTS.json.

All jobs from those experiments are terminal. Do not rerun them without a new
implementation question. This turn implemented and measured new options, so it
is progress. Remaining comparison work includes Candle's dependent path,
ordinary PA MM0, backend-specific finite coverage, and a complete cost forecast
with engineering/setup and all omitted analytic/input obligations. The
research goal remains active; these arithmetic timings are not a full TG proof
or a completed end-to-end forecast.

Latest checkpoint, 2026-11-13 UTC: Candle's matching dependent network is also
complete. Normalized signed arithmetic, negative floor division, rounding,
all local residuals, list validity/length, the dependent contract, final bounds
and checksum have proofs. Three clean processes pass every case/control and
all full-coordinate comparisons. Balanced input definitions fix the initial
export failure, and all three kernel-channel exports are identical. The
largest-block median is 158.679 ms CPU, with 4.186 seconds separate input setup.
See candle-setup/DEPENDENT_REPORT.md and DEPENDENT_RESULTS.json. The ordinary
source/compiler/FFI provenance qualifications remain; this is a HOL result,
not a stock-Lean theorem or ordinary MM0 certificate.

All new jobs are terminal, including the export/transport audit. This turn
made further substantive progress. Do not repeat the completed arithmetic
pilots without a new question. Remaining work is ordinary PA MM0, complete
spectral and finite-coverage blocks, and backend-specific end-to-end forecasts
including source, roots, propagation, completeness, engineering and setup.
The research goal remains active. NATIVE_CERTIFICATION_DESIGN.md gives the
current recommendation without claiming that an unimplemented Lean extension
or a full TG checker already exists.

Latest checkpoint, 13 November 2026 03:25 UTC: ordinary PA scalar arithmetic
is now implemented and independently checked. A pinned mm0-rs frontend creates
real certificates against peano.mm0's unchanged 26-axiom specification. The
64-product fixture is closed as one conjunction theorem; literal provenance,
all axioms and absence of sorry opcodes are audited. Fifty fresh mm0-c runs
pass and four corrupted controls reject. A proved four-bit addition table
improves the 32-product verifier by 2.29 times, generation by 2.89 times and
file size by 2.83 times. The final 64-product theorem checks in 220.877 ms
median CPU; generation and assembly cost 85.94 CPU seconds, and its certificate
is 52.09 MB. These are scalar arithmetic results, not a signed network or a
full TG forecast. See mm0-pa/REPORT.md and RESULTS.json.

The initial compiler build failed from temporary filesystem exhaustion; the
successful portable build and all subsequent proof processes are terminal.
This turn made substantive progress in implementation, independent checking
and optimization. Do not repeat these completed pilots without a new question.
Remaining work is the matching PA signed-network path, complete spectral and
prime-coverage blocks, optimized representations and end-to-end forecasts with
all source, roots, propagation, counting, engineering and setup costs retained.
The persistent research goal remains active, with its original scope intact.

Finite-coverage checkpoint, 13 November 2026: finite-lean/Block1024.lean now
proves binary Goldbach for all even n in
[3999999997356537860,3999999997356539908), with exactly the standard Lean
axioms and no remaining primality/coverage premises. It certifies all 283
positive source bits and 110 anchors using 1537 shared prime nodes. The
monolithic primality build exceeded its 4 GiB limit; 13 smaller modules all
compiled successfully. Assembly costs 172.84 CPU seconds in the first build.
The first strict replay renames and rechecks all 8650 project certificate
declarations, taking 8.676 elapsed seconds. Replications and negative controls
are still pending. PrimeBitmapShift.lean compiles, but the proposed shifted
singleton variant has not yet been built or timed. Do not claim its benefit.

finite-hol/primebench.sml independently checks the same 393 roots through the
pinned upstream Lucas certificate library. Its first run passes all roots,
three corruption controls, four-standard-HOL-axiom audit and theory export.
The all-root cohort takes 9.110 CPU seconds; source and anchor cohorts take
4.897 and 4.805 separately with fresh proof caches. This is primality only,
not yet a complete HOL interval proof. Replications and a summary are pending.

All jobs from that research turn ended. It was substantive progress. The
subsequent exchange about the blue desktop indicator made no proof-research
progress; it clarified that this chat used shell tools, not desktop/mouse
automation. No local-resource prohibition or pause was requested. This
continuation revalidated the completed artifacts and resumes sequential,
bounded checks. The full end-to-end objective and remaining spectral,
finite-range, engineering and cost-model obligations remain unchanged.

Finite comparison completed, 13 November 2026 UTC: the previously launched
Lean campaign was recovered live and allowed to finish without restarting it.
All three full/source/anchor/coverage replays and the corruption controls pass.
The full median is 9.452 elapsed seconds, versus 3.516 ms for the bare bitmap
coverage equality. Source and anchor closures dominate. Successful project
construction cost 547.234 CPU seconds with shared libraries prebuilt. The
concrete closed theorem, exact three-axiom audit and evidence are summarized
in finite-lean/REPORT.md and RESULTS.json.

The HOL matching-primality replications pass, including all 393 roots,
three corruption controls, four-standard-HOL-axiom audit and identical exports.
The new FiniteCover generic theorem and concrete interval also pass. Three
fresh balanced runs give identical exports and four coverage rejections.
The median measured phase total is 11.075 CPU seconds and whole-process CPU
is 18.27 seconds. Balanced witness definitions reduce input translation to
1.448 CPU seconds, versus 58.374 in the first partial flat attempt and 130.737
in the corrected complete flat run. That initial attempt's final conversion
loop was identified, its exact process stopped, and the loop replaced with
checked endpoint equalities. No failed run is called a completed theorem.
See finite-hol/PRIMALITY_REPORT.md, COVER_REPORT.md and their result files.

BatchPrimeScript.sml now proves that a globally checked Lucas certificate tree
contains only primes. Its complete evaluator translation compiles. A small
2/3/7 probe accepts, produces the exact closed semantic theorem, rejects five
corruptions and passes the standard HOL axiom audit. This is a soundness and
integration result, not a timing result. BATCH_PROBE_RESULTS.json is passed.
The next concrete task is the full 1,537-node/393-root fixture and interval
benchmark described in finite-hol/BATCH_PLAN.md. No batch-primality saving is
included in the forecast. The unmeasured Lean shifted-singleton variant and
the original block elaboration profile are deferred behind this larger runtime
question; do not claim a benefit or silently replace the measured baseline.

All processes launched or recovered in this turn are terminal. This turn made
substantive progress in completed interval proofs, independent replications,
representation optimization and a new generic batched checker. The persistent
goal remains active. Complete spectral/source/coefficient/error/count blocks,
production-scale finite coverage and prime ladders, ordinary PA signed-network
work, setup/engineering costs and end-to-end forecasts remain unfinished.

Latest checkpoint, 13 November 2026 UTC: complete recursive-prime batching
has now been built, independently audited and measured in HOL4 and stock Lean.
HOL's graph check takes 64.05 ms median CPU; the whole process takes 13.09 CPU
seconds, versus 18.27 previously. All 393 individual roots and the exact
1,024-target interval remain proved. Three runs pass all nine controls with
identical exports. The native reference is measured separately and has no
proof authority. finite-hol/BATCH_REPORT.md records the complete boundary.

Stock Lean proves the full root conjunction and exact interval using only
propext, Classical.choice and Quot.sound. A single computation hit 4 GiB;
eight modules of proved subtree composition complete within the cap. The
three full replays take median 18.516011 elapsed seconds, slower than the old
9.451671. All twelve full/phase runs, five positive and nine negative controls,
data-identity checks and independent source audit pass. Incremental own-build
CPU is 209.5 seconds, with common support imported. Construction and replay
tradeoffs must remain separate. See finite-lean/BATCH_REPORT.md and its JSON.

All root-owned benchmark processes are terminal. These pilots should not be
repeated without a new question. The restored agents have completed semantic
width, finite frontier, principal/completeness, source-strategy and independent
audits in forecast-audit-20261113. The new end-to-end model has passed an
independent review with 792 rational/scalar assertions across 58 semantic rows,
20 evidence pins and all scenarios. MODEL_INDEPENDENT_AUDIT.md pins the final
report, script and JSON. This approves conditional bookkeeping only, not
production success, an optimized bound or a completed proof.

The next production experiment is an actual c10004 source-to-sign block with
certified height-zero initialization, 4,800 unit inputs, 2,301 primitive outputs,
two positive-height steps and the saved p81 ordered CT plan. It has no Blue
leaf; normalized Bluestein setup needs a separate row. Concrete unit/character
maps, actual source/root certificates, propagated errors and signs remain to
be implemented. C10004_PARAMETER_PACKET.md and NEXT_BLOCK_PLAN.md give the
exact scope. Principal/complete counts, wide small-family time transforms,
dense ladder and ordinary PA production remain separate. This turn made
substantive progress; the persistent research goal remains active.
