# Prepared conversion experiment: unbuilt source and exact driver plan

Status: PreparedEval.sml is source-only and unbuilt. No runnable benchmark or result is claimed. Root must review and serialize any build. This plan parks the signed-round change completely.

The adapter copies the public cv_eval evaluation/transport route using exported cv_repLib, cv_typeLib, cv_transLib and cv_computeLib APIs. Only the conversion construction moves out of the repeat loop. BOTH variants still discover the representation theorem and code equations on every call and decode/transport anew. Thus a measured difference isolates retention of validated conversion/code, rather than silently bundling saved discovery or a saved final theorem. The retained variant additionally checks the entire ordered closed equation conclusions by aconv; this conservatively charges cache validation. Stored closed theorems themselves remain the conversion dependencies. A hash is not its logical authority.

No stale result can be returned from the adapter: finish always invokes the stock conversion. It uses the actual current representation theorem and from/to theorem. Mismatched equations raise an exception before evaluation. Such an exception is a cache miss/failure, not proof that a corrupted mathematical claim is false. Final wrapper must separately check original LHS and true/false RHS and standard tags exactly as the baseline does.

## Required driver patch before build

Use a disjoint copy of the pinned dependent.sml. Preserve all literal definitions, positivity proof, precondition theorems, acceptance function, four fixture terms, five changed claims and mathematical export derivation. Change only theory/export names and driver calls. Import PreparedEval. Reuse the baseline normalize_result and audit functions.

For each depth 1,8,32,128, run these THREE paths on the identical term:

1. stock cv_eval as correctness/reference control;
2. PreparedEval.fresh, rebuilding conversion each call;
3. PreparedEval.prepare once, then invoke the returned closure every call.

The two experimental paths must return exactly the same normalized equation as stock cv_eval. Compare both LHS and RHS with aconv, empty hypotheses, allowed tags and the unchanged block_accept_sound conclusion. Save separate named successful theorems. Use the existing three calls per case, with three fresh processes. Alternate fresh/retained order by process, retaining all raw observations and first calls. Do not claim that the adapter equals stock performance before this calibration, since its extra timer boundaries add overhead.

The prebuild discovery/compiler phases and named-literal construction are paid even when amortized. Report total first acceptance as literal/setup+prebuild+first application+normalization+soundness/export, as well as amortized repeats. Imports/process startup remain separately measured. Each phase timer returns the callback result rather than rerunning it to display a value. Keep one outer end-to-end timer too; nested phase sums are diagnostics, not additional cost to add twice.

Controls: send checksum/bound/depth corruptions through an already prepared conversion only when same_equations succeeds; if not, report a cache miss and prepare their exact equation set separately, paying that cost. Changed-input and changed-coefficient definitions can add equations, so likewise prepare the correctly bound new set. Each must end in the same stock-certified false proposition, not an exception. Also explicitly try an incompatible retained set and require the adapter's cache-identity guard to reject reuse, separate from mathematical rejection. Preserve all five stock controls. No controls may be replaced with a positive-result comparison against an untrusted expected bool.

## Resource and trust boundaries

All dependency theories remain read-only. No kernel or cv_transLib modification is required. Use the same toolchain, process caps and sequential execution as the accepted block run; no extra heartbeat/resource overrides. Pin the adapter, generated driver, actual equation list identities/counts, original input expressions, all imported build artifacts and export. Do not load the old result theorem as a replacement for the fresh computation.

This adapter retains a compiler closure, not a native result oracle. It leaves source literal proofs and generic library assumptions exactly as before. It does not measure the raw executor alone: evaluate_transport still includes target parsing, interpreter execution, result reification and ordinary proof transport/EVAL. The public API does not expose a separate executor timer. Avoid changing kernel code merely to obtain that breakdown.

## Why no driver has been silently launched

This source needs an ordinary source/build review first, including the instantiated library APIs and the exact copy of the baseline harness. The required patch is specified above rather than claiming an untested driver is ready. The report EVALUATOR_OPTIONS provides the source-grounded hypothesis. No speedup threshold or full Platt forecast follows from it.

## Pins

Baseline dependent.sml SHA256 `ECB62C8C7B1F1AAAA8DF9617DAF4145D7FCADBEEDD9CF8579D3F57962C5E1AB1`.

PreparedEval.sml SHA256 `8767BEED69CDB2C54838FDC81B769F4B5A5072E3420588852889F816657617DB`.
