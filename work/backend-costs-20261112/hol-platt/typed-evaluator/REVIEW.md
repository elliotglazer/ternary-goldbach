# Typed evaluator source review

2026-11-13. PASS for a bounded build and raw diagnostic attempt. No source-level correctness or trust blocker was found in the frozen packet below. This does not certify the worker, admit a trusted fast path, or report a successful build. I performed source reads, hash checks and textual fixture comparisons only. No generator, SML worker, evaluator or benchmark was run.

## Exact supported computation

The worker's three-product butterfly is the `BlockRound.rounded_butterfly` formula: `t=wr*(vr+vi)`, `a=vi*(wr+wi)`, `c=vr*(wi-wr)`, followed by rounding `t-a` and `t+c`. `IntInf.div` is the floor-division operation, not `quot`; with positive `s`, `(2*r+s) div (2*s)` therefore agrees with the source signed rounding and its ties toward positive infinity. Arbitrary-precision value arithmetic avoids fixed-width overflow. Host allocation and index limits remain real limits, with failures aborting the diagnostic rather than proving anything. The eight planned stock-checked rounding cases include negative ties, negative exact division and zero.

Validation requires positive scale, nonnegative machine depth, even input length, exactly one coefficient per pair and array capacity. Natural-depth conversion may reject out-of-range values. That is acceptable for the declared restricted diagnostic; it is not equivalence to all branches of the total HOL function. Immutable input/coefficient vectors are never modified. The empty case returns an empty vector without indexing.

For nonempty arrays, initially offset zero exposes the original vector. Each pair reads only the old array and writes both corresponding positions in the separate destination array. At layer completion, swapping buffers and setting offset to one exposes the source's one-place left rotation. Resetting the offset, rather than incrementing it, is correct because destination writes are in unrotated logical order. It stays in {0,1}; the optimized read function is valid on exactly that invariant. All positions are written before the swap. The coefficient vector restarts each layer, as in `block_layer`. Returning a fresh immutable vector in logical order also preserves the final rotation. No mutable array escapes or is retained between calls.

`within` keeps the source's inclusive bounds. The reverse traversal computes `r+3*i+9*tail`, so the checksum has the correct ordering. Acceptance recomputes the entire block and then applies its bound/checksum tests. It does not reuse a previously timed output vector. Negative bounds and empty vectors consequently retain the source behavior within the admitted shape domain.

## Binding and theorem authority

The adapter accepts only the actual `DependentBlock.block_accept` constant with its six arguments. It decodes parameters from that term, not from a second independently supplied numeric fixture. Only the five listed local data names in `TypedDependentResults` can be resolved, through a closed defining equation with the exact input constant on its left. Integer terms are checked by encode/decode round-trip; row type and canonical CV integer/list/Boolean encodings are checked. Negative zero and malformed list representations are rejected.

The exact `block_run` term is built from those same arguments. Each sample compares every output coordinate against the stock raw interpreter, and separately compares the complete acceptance Boolean. This rules out treating an accidental matching checksum as output equality. The 14-entry expected-source manifest matches current bytes. I independently verified the unchanged original setup prefix apart from the explicit local-theory rename and leading dependency open, all four exact fixture declarations, and the complete original changed-data/control suffix after removing the added typed calls.

The copied `TypedStockCompute` execution/parser prefix matches pinned stock `Compute.sml`, apart from the exposed/renamed structure; its added interface returns parsed program data rather than a theorem. The configuration retains the checked characteristic equations. The adapter obtains and exports the actual ordered source-equation theorems for each request, and stock-kernel reference computations on sample zero verify the same raw result through `cv_computeLib.cv_compute`. Only those stock theorems and ordinary existing checks are saved. There is no theorem constructor accepting the typed worker's answer.

This is sufficient binding for a known-source differential diagnostic. It is not a generic proof that a hand-written worker implements any newly discovered code-equation set. Unsupported inputs may fail; no installed dispatcher or fallback is claimed. The exact saved equations, source hashes and successful result checks must remain part of any later report. A generic equivalence proof alone would still not certify an untrusted external execution.

## Controls and timing interpretation

There are 22 planned edge checks: eight rounding comparisons, six array comparisons, five worker-domain rejections and three malformed CV rejections. Zero depth, empty arrays, repeated rotations and a four-point/two-coefficient example are included. All four existing positive depths and all five existing false controls receive full array and Boolean comparisons on every one of three samples. The source retains the original stock positive/negative proof checks as well.

The 213 timing-label total is consistent: 14 edge cases times three preparation/reference labels gives 42; nine requests times 19 labels gives 171. The AWK validator checks that exact label set, uniqueness, expected dimensions/depths, all five rejection markers, edge count, run order and completion. Successful process exit and source/object binding remain separate requirements. Printed equation text can be shortened by the pretty-printer; the saved theorem objects, not displayed text alone, are the exact equation record.

The two raw timings are deliberately different implementations/representations. Typed calls include validation, fresh buffers, execution and final vector creation. Stock raw calls execute already-parsed CV code and allocate CV results. Initial term decoding, program discovery/parsing, comparison decoding, recorded equations and theorem export are outside raw execution timing. They are not free when considering a complete path. Each array call and each acceptance call recomputes the block, so their costs are overlapping alternatives rather than disjoint pipeline stages to sum.

Stock reference checking after sample zero warms the process before samples one and two. Both order modes must be retained, with first-sample versus later-sample results distinguished. There is no forced common GC state. Edge checks precede the main requests, and original high-level checks follow them. Whole-process time includes all this work. No final arithmetic result is memoized between samples; only parsed program data and immutable inputs are retained.

A successful raw speed difference could inform the repeated integer execution/representation-overhead portions of a future implementation. It cannot directly reduce ordinary theorem checking, source/log/Gamma/root producers, input/output transport, interval errors, difficult-sign repair, completeness, principal or finite-Goldbach costs. In the unchanged trusted implementation, stock reference checking still costs time. No campaign row or forecast should change from this source review or from raw timing alone.

## Bounded readiness

The explicit local prerequisites and opens address module-loading dependencies. The runner uses the pinned existing HOL environment, `--no_prereqs`, 4 GiB virtual-address limit and a 600-second timeout per build/run. It relies on shell hashing and AWK, not a Linux Python installation. Source/dependency/tool/executable before-and-after hashes and archived result data are required. These cover the selected installed inputs, not a new complete transitive-library rebuild. Verify actual logs and object provenance; a launcher build can defer source loading, and an existing object can make a build incremental.

The appropriate first command from the Linux repository root is:

```sh
sh work/backend-costs-20261112/hol-platt/typed-evaluator/run_typed.sh typed01 build
```

Only after successful source-bound build review should root launch the separate smoke label. Runtime/API failures remain possible despite this paper/source verdict. Preserve failed receipts and repair only as a newly identified source snapshot. Do not describe the emitted `TypedDependentResults` as a theorem-backed typed fast path.

## Frozen inputs

All paths below are local to this directory. The README contains the full input/source pin table; the manifest and expected-hash file bind its executable sources. All listed hashes were checked against the reviewed bytes.

| File | SHA256 |
|---|---|
| README.md | 99E1C13B9330FBBC95A9D08E23710997CB1521A3F0F2DAD53BC6AD3CDA917B93 |
| source_binding.json | 2E59F73B281E734613A827DF3D852BADB230B7CE24D0F48494BAA74367037F97 |
| source_expected.sha256 | 987382D5FFD5B681A140EDAA907B8B58AD5AD2978E413EBE4535C86C5E861989 |
| TypedBlock.sml | 3B92EBCD2512CBD814461CBAF96F23E6542F2559D4071F794C8337C6D4136CAF |
| TypedWorkload.sml | A44D83A45EBBAC48C8867CB545314B932C4D424F60AEAAE791020530A0E1D567 |
| TypedStockCompute.sml | 6E802DAC27BB6B4B259343F6A75D25E8F91DB3CE790768C61EC71EAA6B230955 |
| TypedCvConfig.sml | E0122E05ABF040E94170CC7A0019474D13FE4E290D79B5375097F525D12CC1FD |
| typed_dependent.sml | 70E72C3A44F8B9B8676E27792D4DF6AC8636825B39D4E8616DB37DCEDEC87F7B |
| prepare_harness.py | 6551C662808021CAF0745E4BCB0E3B68C1B73755708C5B5E859D8E3973999701 |
| verify_sources.py | B1DA87654478DC57DD742FB681D0CDD24E6A39F715EEE7E1CB4082212B03E1F2 |
| validate_log.py | 70BE1D4029A503747CD7C33D22089C307A58C976C4EC99360880902D3AF695FC |
| validate_log.awk | 1F9A9FCF906B7864AF2C89AB784410629B43B68CC2A5E844A74EB00C14892A8E |
| run_typed.sh | 73F1B0D5F41905AF76DDEBF88D147CB243EF143F4D8CF6F30BFFC6D526080915 |
| Holmakefile | 81C993CD3CD54DB50858D0EAC64BD3918ECDF61BD803854590F4232FBFD501A7 |
