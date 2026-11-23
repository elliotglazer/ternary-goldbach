# C10004 finite map source review

2026-11-13. Verdict: PASS for a bounded first build/check attempt, conditional on successful ordinary HOL translation, proof construction and runtime audit. This is a source review, not acceptance of computed roots or a compiled theorem. I did not execute the proposal generator, evaluate the finite domain, or run a build.

## Exact finite contract

`C10004MapScript.sml` defines the map inside HOL. Python output is not read by the theory. For `0 <= i < 4800`, decoding gives `a=i DIV 2400`, `b=(i DIV 60) MOD 40`, `c=i MOD 60`; the inverse flattening is `2400*a+60*b+c`. Thus the axes are exactly 2,40,60, with the 61-coordinate fastest, matching the saved parameter packet. This is distinct from a local Cooley–Tukey split's `j=a+r*b` order. No global length-4800 DFT equivalence is asserted.

The CRT coefficients are correct as integer identities: 2501 is 1 modulo 4 and zero modulo 41 and 61; 4880 is 1 modulo 41 and zero modulo 4 and 61; 2624 is 1 modulo 61 and zero modulo 4 and 41. Their sum is 10005. More importantly, `coordinate_ok` checks the actual three congruences for every input, so acceptance does not depend on this prose calculation.

The proposed 6 modulo 41 and 2 modulo 61 are not assumed generators. `finite_checks` demands endpoint powers 1 and sorted local power lists equal every integer 1..40 and 1..60, together with local distinctness. Successful evaluation therefore supplies exact full-order power enumerations. This review has not established those finite evaluations by running them.

For global coverage, `expected_units` ranges over all 10004 residue representatives and filters by `gcd r 10004 = 1`. Its definition is independent of `residue`. Sorted equality and both length checks cannot be satisfied by a repeated or incomplete 4800-row list. The source then derives permutation, distinctness and membership equivalence using the actual stock results `QSORT_PERM`, `QSORT_MEM`, `ALL_DISTINCT_PERM`, `FILTER_ALL_DISTINCT` and `ALL_DISTINCT_GENLIST`. In particular, stock `QSORT_PERM` has the needed orientation `PERM L (QSORT R L)`. No unproved uniqueness premise is inserted.

The input inverse keeps the modulo-4 coordinate and negates the other exponent coordinates. The checker explicitly demands its range, involution and residue-product congruence 1 for all 4800 inputs. It is not merely a permutation called an inverse.

## Retained labels and limits

`retained_label i=(1,1+i DIV 59,1+i MOD 59)` enumerates exactly the rectangular grid with second coordinate 1..39 and third coordinate 1..59. The checked inverse index formula `(b-1)*59+(c-1)=i` proves injectivity. Conversely, any pair in these bounds gives an index below `39*59=2301` and reconstructs the pair by quotient/remainder, proving coverage of that finite coordinate grid. The current exported `labels_checked` theorem specifically exposes `label_ok`; the bounds/index assertions remain available through `finite_map_checked`. A consumer wanting an explicit label-bijection theorem must derive it, not pretend that it has already been exported separately.

For inversion, `2300-i` changes `(b,c)` to `(40-b,60-c)`, has range below 2301 and is an involution. The fixed central index is 1150 with coordinates `(1,20,30)`. These are exact coordinate facts. This packet does not prove that these 2301 labels are primitive Dirichlet characters, that their phases use the intended sign, or that a tensor transform evaluates the actual character sums. Those algebraic and analytic adapters remain required. There is no full character/DFT source claim, L-value, sign, or zero-count result here.

## Ordinary checking and run boundary

`cv_auto_trans` must successfully translate the actual fixed higher-order functions, including sorting and gcd. `cv_eval` must return a closed theorem with exactly `finite_checks` on the left and `T` on the right before `EQT_ELIM` and export. Failure to translate or discharge a precondition is a failed build, not permission to use Python's result. The six runtime roots are checked for empty hypotheses and only the permitted imported `DISK_THM` oracle tag. The ancestry scan rejects named axioms outside the four standard HOL bool axioms. These are ordinary source/runtime checks; they are not an independent replay of exported proof data. The local `axs` tag component is extracted but not separately printed or filtered. Final review should retain the ancestry list and theorem tags, and must not describe this code as explicitly checking that unused component.

The runner resolves the existing pinned HOL checkout, uses `--no_prereqs`, checks existing sorting/gcd objects, sets a 4 GiB virtual-memory limit, and gives each of theory build, audit build and audit execution 600 seconds. These caps are attempt limits, not measured sufficiency or RSS claims. Ordinary source repairs may still be needed. Its fresh-label/noclobber logs, exit-on-failure and final audit marker are suitable for the initial attempt. Run serially while no other process mutates these sources or dependencies.

The minimal first command, from the Linux host mount at the repository root, is:

```sh
sh work/backend-costs-20261112/hol-platt/c10004-map/run_map.sh map01
```

The Python proposal is optional and unnecessary for this theorem attempt. If run later, price its generation separately. The runner hashes sorting/gcd objects, Holmake and hol.state before/after and the final theory/audit objects. It does not create a complete transitive dependency manifest: arithmetic/list/CV libraries and the setup wrapper still rely on the established pinned checkout. Bind that prior library provenance, wrapper hash below, and actual build logs at acceptance. `--no_prereqs` is not evidence that a failed attempt could safely rebuild dependencies. Existing outputs can also make a later invocation a warm/no-op build; a new label alone does not imply first construction.

After success, require all three phase exit statuses, six closed theorem outputs, the ancestry result, final marker, unchanged source/dependency checks and output hashes. A timeout or memory failure is neither a false finite check nor a mathematical rejection. No timing or campaign saving follows from this preflight.

## Reviewed source pins

All SHA256 values were read from current bytes. Paths below are relative to this directory unless stated otherwise.

| File | SHA256 |
|---|---|
| C10004MapScript.sml | 0773AC5249A66AF85814F7694063D53759AEF19C41D6172BE06DA906FD60AC6E |
| map_audit.sml | 03F3A64E5541EC00B09AB11E91E0351614C2A19E1FC51B4F837DE750762B158F |
| propose_map.py | 46944174CE5CF122768E1DA56946EB97AE025C2721171A220C3320A252648CAF |
| run_map.sh | 2FD416739DB268E177098243ED2746BC70E3546BEE21AE1251062FECCF89DA53 |
| Holmakefile | 6E346FB294CF04A3E4915487015607B28B06BA43B9514BB343327EDEAC48629B |
| README.md | 897CA3840A422D63789C67122D7351B2397C2A9719C5BF8037DF30163A06C583 |
| ../../hol4-setup/run.sh | BD06330A16C06F8FF7D43401F545988EF1ED357FCD2248B53CA2BDBC89D8FF0C |
| Pinned HOL src/sort/sortingScript.sml | 47F7E4CC622495E5D5A58A75E9D28F8F7A5F47C576D086C4D38DA053D83EFFD4 |
| Pinned HOL src/list/src/listScript.sml | 854DA0D8BFE3CAA3E8F8A7EB5C291D7B851A2C0D2A28BB3EE4BF765827734579 |

The saved parameter context remains `forecast-audit-20261113/C10004_PARAMETER_PACKET.md`, pin `2B8102E8134B8BC9DA5BD93DD2105673EE6614B2D3D721B7E701F3A38C09F8EF`: this conductor has no Bluestein leaf. Completing this finite map would fill one missing finite-domain prerequisite, not change that experiment's coverage.
