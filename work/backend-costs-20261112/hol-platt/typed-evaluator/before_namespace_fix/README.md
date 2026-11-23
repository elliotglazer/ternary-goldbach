# Typed integer block diagnostic

2026-11-13. Source-only implementation handoff. No SML compilation, HOL execution, benchmark or experimental theorem acceptance has occurred. Root alone runs the later serialized checks. Independent source review is separate. This implements the narrow diagnostic in `../compiled-evaluator/NEXT_BACKEND_DESIGN.md`; it is not a general typed-CV compiler or installed fast path.

## Worker and supported domain

`TypedBlock.sml` has no HOL imports and returns raw host values. It uses signed `IntInf.int` and the exact existing three-product butterfly, followed by `(2*r+s) div (2*s)`. The Standard ML [INTEGER specification](https://smlfamily.github.io/Basis/integer.html) defines `div` as floor, including negative numerators; `quot` instead truncates and is not used. Local Poly/ML `Arbintcore.sml` maps division to IntInf. This confirms the specified operation, not an executed test; eight planned cases compare positive and negative ties against stock.

Every call requires positive scale, nonnegative machine-representable depth, even input length, one coefficient per pair, and length within array capacity. Empty arrays avoid modulo zero. Unsupported inputs raise `TypedBlock.Invalid`; this does not claim the same behavior as the total HOL function outside the admitted domain. There is no installed dispatcher or automatic trusted fallback.

Two private arrays are fresh per nonempty call. Read the current array in logical order with offset zero initially, one thereafter. Write each output pair into the other array in unrotated physical order. Swap only after the complete layer and set the new offset to one, rather than incrementing the old offset. The coefficient vector is immutable and restarts at its first entry each layer. The final immutable vector is emitted in logical order. No array or previously computed result is cached between calls.

Bounds retain both inclusive inequalities. The checksum reverse fold exactly implements `r + 3*i + 9*tailChecksum`. Each separately timed acceptance call recomputes the block; it does not reuse the separately timed array.

## Actual fixture/source binding

`prepare_harness.py` checks the pinned stock Compute, CV configuration and `dependent.sml` sources. It writes only exclusive local generated outputs. Every original numerical literal, named data definition, four fixture declarations and five changed-data/control requests is preserved. The local theory identity changes consistently from `DependentBlockResults` to `TypedDependentResults`, avoiding collisions with both predecessor experiments. A leading `open TypedWorkload` and explicit local Holmake prerequisites prevent reliance on incidental preloaded structures. No new HOL_ERR record pattern is used.

`TypedWorkload.run` requires the actual `DependentBlock.block_accept` head and six arguments. It derives the native parameters from that very term. Only the five declared local data constants may be unfolded; each definition must be closed with the exact input constant as its left side. Integer terms are round-trip checked, the row/list type is checked, and natural depth conversion is checked by the host API. Separate native numerical fixtures are not substituted.

From the same arguments it constructs the exact `block_run` term. The unchanged stock CV discovery/parser/interpreter computes the full list and the acceptance Boolean. `TypedStockCompute` only removes the opaque structure boundary, renames the structure, and adds a parser-return interface. It contains no optimized worker. Actual ordered equation theorems and CV requests are recorded outside timed evaluation. Native arrays are compared point by point against the complete stock result, never merely by checksum. Canonical CV decoding rejects negative zero, malformed rows and nonzero nil markers.

On the first sample of each array and predicate, the harness also calls unchanged `cv_computeLib.cv_compute`, checks closedness, exact input/result identity and imported tags, then saves only this stock theorem. The original high-level positive/negative stock checks still run. Experimental values never construct a theorem. Existing Count.Compute and DISK_THM/imported-library trust boundaries remain; no installed kernel source is edited.

This is an exact known-fixture differential experiment, not a proof that the native worker implements arbitrary discovered equations. Future theorem acceptance must either check concrete execution through stock/ordinary proofs or explicitly adopt and audit a larger trusted implementation. A compiler-correctness theorem alone does not certify a particular external run.

## Planned tests and timing

There are 22 edge checks: eight floor/tie cases; six full-array cases covering zero depth, empty data, repeated layers and four-point rotation; five invalid-domain rejections; and three malformed CV rejections. All unexpected exceptions fail. Four actual depths (1,8,32,128) and all five original false controls must then pass. Each actual array has 128 points. The depth-corruption case has depth seven; other corruption cases have depth eight.

Each actual request has 19 timing rows: one decode/validation row, four discovery/parser rows, twelve raw rows for three repetitions of both implementations' array and acceptance calls, and two stock-kernel reference rows. Fourteen positive edge cases each have three preparation/reference rows. Total: `9*19 + 14*3 = 213` TYPED_TIME rows per completed process.

`validate_log.awk` requires the exact timing-label multiset without duplicates, nonnegative fixed-format times, nine full-array pass records with expected dimensions/depths, all five rejection records, exact edge count, run order and completion. The optional Python validator can render a checked log to JSON later; the runner itself does not require Linux Python.

Raw native time includes validation, fresh array allocation, arithmetic and final vector creation; raw stock time includes CV execution and CV allocation. Initial HOL-term decoding and comparison decoding are outside these raw timings. The representations intentionally differ, so a raw ratio is not an end-to-end proof speedup. The stock reference after repetition zero warms the process before repetitions one and two. Equality checks, saved references, logging, collection and retained values affect total process cost. No forced-GC equality or pure arithmetic timing is claimed. Array and acceptance runs overlap conceptually and must not be added as disjoint stages.

## Root-only execution

From this directory in the existing Linux environment:

```
sh run_typed.sh typed01 build
sh run_typed.sh typed02 smoke
```

Use fresh labels. `smoke` runs one fresh process in each order, stock-first and typed-first. Optional `full` runs three in each order and reverses the starting order for the middle pair. No automatic retry occurs.

The runner checks pinned source expectations first, uses `Holmake --no_prereqs`, caps virtual address space at 4 GiB, and applies a 600-second external timeout per build/run. This is not an RSS/private-commit cap. It records named source/dependency/tool/executable hashes before and after, retains failures, and does not build dependencies. Inspect compilation logs and local object provenance: a build command alone does not establish that the expected fresh source was loaded. Build-time module initialization is toolchain behavior, not presumed absent. Shared imported HOL dependencies are not independently rebuilt here.

The final marker still requires a result audit of process exit, all status checks, source/object identity and timing boundaries. Do not import `TypedDependentResults` into production, modify installed Compute/Thm, or infer full spectral cost from this dependent block.

## Checks completed without execution

The source generator and read-only verifier ran, checking pinned files, exact numerical prefix modulo the explicit theory rename, four fixture declarations, recovery of the original control suffix, and unchanged stock interpreter/frontend. Python sources passed AST syntax checks. Generated/source LF line endings were checked. These are text checks only; no arithmetic/function values, SML edge cases or benchmark samples were evaluated. Ordinary SML/API mistakes remain possible until root builds.

## Frozen source pins

| File | SHA256 |
|---|---|
| `Holmakefile` | `81C993CD3CD54DB50858D0EAC64BD3918ECDF61BD803854590F4232FBFD501A7` |
| `prepare_harness.py` | `6551C662808021CAF0745E4BCB0E3B68C1B73755708C5B5E859D8E3973999701` |
| `run_typed.sh` | `73F1B0D5F41905AF76DDEBF88D147CB243EF143F4D8CF6F30BFFC6D526080915` |
| `source_binding.json` | `2E59F73B281E734613A827DF3D852BADB230B7CE24D0F48494BAA74367037F97` |
| `source_expected.sha256` | `987382D5FFD5B681A140EDAA907B8B58AD5AD2978E413EBE4535C86C5E861989` |
| `typed_dependent.sml` | `70E72C3A44F8B9B8676E27792D4DF6AC8636825B39D4E8616DB37DCEDEC87F7B` |
| `TypedBlock.sml` | `3B92EBCD2512CBD814461CBAF96F23E6542F2559D4071F794C8337C6D4136CAF` |
| `TypedCvConfig.sml` | `E0122E05ABF040E94170CC7A0019474D13FE4E290D79B5375097F525D12CC1FD` |
| `TypedStockCompute.sml` | `6E802DAC27BB6B4B259343F6A75D25E8F91DB3CE790768C61EC71EAA6B230955` |
| `TypedWorkload.sml` | `A44D83A45EBBAC48C8867CB545314B932C4D424F60AEAAE791020530A0E1D567` |
| `validate_log.awk` | `1F9A9FCF906B7864AF2C89AB784410629B43B68CC2A5E844A74EB00C14892A8E` |
| `validate_log.py` | `70BE1D4029A503747CD7C33D22089C307A58C976C4EC99360880902D3AF695FC` |
| `verify_sources.py` | `B1DA87654478DC57DD742FB681D0CDD24E6A39F715EEE7E1CB4082212B03E1F2` |
| `DependentBlockScript.sml` | `1A57F4025ED1A7B9C5A823D5F6B73B2A7BE02B109F21AD13D24214EA52D9D665` |
| `BlockRoundScript.sml` | `FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143` |
| `StageCheckScript.sml` | `019B156330F9E3623529F46705F7B5C4682C8E74456E293598F620EEE34AF26C` |
| `Poly Arbintcore.sml` | `0C767A56B2761E318B33FD685FF63FC40B8A522ED309E377C8C39B8E4F1015A2` |
| `stock Thm.sml` | `E0A9F3C274BAB9BE04922D83535A660833A6EF8409F9C02BA9610DDEDAE3FF45` |
