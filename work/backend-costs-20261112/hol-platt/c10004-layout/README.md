# c10004 finite layout extension

13 November 2026. **Source-only candidate; not built or evaluated.** No theorem, map or finite-check success is claimed by this handoff. Root runs the bounded stock HOL check later. The existing `c10004-map/C10004MapScript.sml` and its artifacts are unchanged.

## Mathematical target

The old input order is `i = 2400*j4 + 60*j41 + j61`, with dimensions 2,40,60. The proposed tensor order is `t = 2*(40*j61+j41)+j4`. The explicit forward and inverse functions use division/remainder by the corresponding fixed dimensions. The finite checker checks both directions for every index in `GENLIST I 4800`, including coordinate bounds and reconstruction, forward/inverse range and inverse identities. Ordinary list proofs then derive injectivity, exactly-one preimage for every t<4800, and `PERM (GENLIST old_to_tensor 4800) (GENLIST I 4800)`.

`tensor_residue` is the actual direct CRT expression using the predecessor's `local41` and `local61` functions, not a fresh table. Both directions check equality with the predecessor's actual `residue` function. This explicitly ties the permutation to the c10004 input values rather than only proving an abstract permutation of equal-length arrays.

For each actual tensor residue a the checker requires `0<a<10004`, defines

`k = (2048*a+10003) DIV 20008`,

and checks `k<=1024`, `2*k*10004 < 2048*a+10004`, and `2048*a <= (2*k+1)*10004`. The lower form is valid in natural arithmetic even at k=0; after embedding in integers/reals it expresses `(2*k-1)*10004 < 2048*a`. The strict lower/non-strict upper orientation is ties-down. These are 1,025 possible fine-cell indices, not a claim that every cell is occupied. All 4,800 positions are checked; exactly-once means coverage of tensor positions, not injectivity of the cell map.

The resulting real implication `|512*a/10004-k/2|<=1/4` follows algebraically from these inequalities, but this file does not export a real-arithmetic theorem or any analytic error bound. It also does not create sorted cell records, occupancy counts, prefix offsets or a buffer implementation. Those require later explicit consumers.

## Proof construction and boundaries

`layout_finite_checks` contains two EVERY traversals over the full index range. `cv_auto_trans` and `cv_eval` use stock HOL. The script checks that the returned theorem has no hypotheses and is exactly `layout_finite_checks = T` before applying EQT_ELIM. The subsequent theorem proofs use that checked fact and ordinary list/logic results. They do not import a Python enumeration, use a source table, assume a checker result, or add an axiom.

The eight root exports in `layout_audit.sml` check closedness and permit only imported DISK_THM tags, with HOL's four existing bool-theory axioms. This is an intended audit, not a performed one. Stock Compute's trusted implementation and imported predecessor/libraries remain explicit. No new evaluator or kernel edit occurs.

The predecessor is a dependency: root must first successfully build and audit C10004Map. This runner refuses to run without its `.uo` and `.dat` files and does not rebuild it. A later changed predecessor source requires repinning/review. No claim about character identities, positive-exponent DFTs, root phases, primitive-output pruning, stage scatter/gather, L-functions, interpolation or final signs follows from this layout. In particular, the transform worker must separately prove that its ordered axes and output labels consume this permutation correctly.

## Root-only run

From this directory in the existing Linux environment, after the predecessor succeeds:

```
sh run_layout.sh layout01
```

The runner requires a fresh label, verifies source hashes, invokes `Holmake --no_prereqs` for this theory and the local audit executable, and then runs the audit. Each phase has a 600-second wall timeout and inherits a 4-GiB virtual-address cap. The cap is not a bound on RSS/private commit. Logs, CPU/wall statistics, source/dependency/toolchain hashes and output hashes are retained. No automatic retries or cleanup occur. A nonzero build/audit exit stops the run.

The final marker still requires receipt review: inspect actual closed theorem text, all eight audit roots, expected axiom/oracle output, source/object provenance, resource outcomes and unchanged predecessor. Existing objects and generic HOL dependencies are imports, not newly checked source here. The source proofs may need ordinary API/tactic repairs on their first build; no runtime or compile success is assumed.

## Files and input pins

No finite arithmetic evaluation, build or benchmark was run during authoring. Only source reading, source writing and hash checks occurred.

| File | SHA256 |
|---|---|
| `C10004LayoutScript.sml` | `FB174D3F09F91DA10F4735664453CA5A42D0E9814811A67AB0DD9B7CAAC7E90F` |
| `layout_audit.sml` | `FBDF731CCA990481F86F794E5035E42584D8EB60BF24342FCC472C2750E82AF0` |
| `Holmakefile` | `9442FD076D9F5994F45393C37419F73A082B45A308B915D5679F493C39508D9B` |
| `run_layout.sh` | `862A378572FA74B8709C5898C23E649DE4836B4A3A1020F61D98638F1CAEC0F4` |
| `source_expected.sha256` | `7582BDE600ED5083F57CA03CE68AEB96163508D7C5EA3C01BEC887E52355025F` |
| `predecessor C10004MapScript.sml` | `0773AC5249A66AF85814F7694063D53759AEF19C41D6172BE06DA906FD60AC6E` |
| `predecessor REVIEW.md` | `6580D991FE4720FA4AAED1C59FABF63CA04E93C967663013FE8CBED61E3877C8` |
| `C10004_LIVE_DATA_SCHEDULE.md` | `56019E9D091270F46C3C4DCBE17390C2CBFD336135C94675A7F61FCC222F850F` |
