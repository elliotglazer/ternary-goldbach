# Independent source review: c10004 integer transform

Date: 2026-11-13. Scope: frozen integer reference, prepared proofs, diagnostics and root-only runner. No HOL process, build, evaluation, fixture generation or benchmark was run by this reviewer. The separately owned C10004TensorProjectionScript.sml is excluded.

## Verdict and pre-build action

PASS for the stated integer-program mathematics and diagnostic scope, with one identified translation-readiness repair before the first attempt: register a proved numerical identity theorem `[cv_inline]` before translating `tx_root_row_ok`. That definition uses `GENLIST I n`; this source imports BlockRound, not C10004Map, so the map's new identity registration is not inherited. The analogous map translation failed on the polymorphic combinator. Use an ordinary proof of `!n:num. I n = n`, not a new assumption or altered root predicate. Preserve the reviewed predecessor and bind the repair separately. This is not a successful-compilation verdict; other elaboration or translation repairs may still be required.

Stock `cv_stdScript.sml:321` itself registers I_THM as cv_inline; `cv_repLib.sml:203` applies registered inline rewrites before translation. The proposed local registration follows that mechanism. A possible namespace concern was checked and cleared: transform_audit opens boolLib, whose unsealed structure opens/reexports boolSyntax and Drule. Thus its bare lhs/rhs and UNDISCH_ALL differ from the earlier harness which opened HolKernel alone.

## Arithmetic and ordering

Let S=2^81. `tx_cache_entry(wr,wi)` stores `(wr+wi,wi-wr)` from the same root pair. The three exact products give
`t-u=vr*wr-vi*wi` and `t+v=vr*wi+vi*wr`. Only these two final numerators are rounded, using `round_scaled S z=(2*z+S)/(2*S)` with integer floor division. This is nearest rounding with half ties toward positive infinity, including negative inputs. No intermediate product is rounded. Identity, half-turn and quarter-turn actions are exact signed swaps; the positive quarter-turn is `(-i,r)`, consistent with positive exponential phase. Direct rows start at x0 and add j=1,...,n-1 in ascending order; all sums are exact integers.

For n=r*m, the gather index is j=a+r*b. The output index is k=v+m*u. The identity
`j*k/n = a*v/n + a*u/r + b*v/m + b*u`
explains the positive cross root indexed a*v, followed by the r-point transform at u. All admitted recursive lengths have the declared split: 10=2*5, 15=3*5, 20=2*10, 30=2*15, 40=2*20, 60=2*30. Fuel 6 exceeds the required depth. The fuel-zero definition is a direct row, not arbitrary data. General roots are not established as actual exponential roots; therefore this identity explains the intended exact transform, while the executable object remains a particular rounded integer circuit.

`tx_omit` shares the exact full children and bridge and deletes only output zero. Its local TL relation holds for arbitrary integer inputs and caches, including the identical rounding history of retained outputs. This does not discard the internal v=0 bridge or any child needed by another output. The proof source for this relation and the length/guard lemmas is coherent on inspection but unbuilt.

Full tensor order is input `2*(40*j61+j41)+j4`, then k4 fastest through the first stage, and final index `(2*k41+k4)*60+k61`. The full line counts are 2400,120,80. The selected line counts are 2400,60,39 with lengths 2400,2340,2301 after each stage. Its final index is `59*(k41-1)+(k61-1)`, retaining k4=1 and nonzero k41,k61. `tx_project` selects exactly those full-array positions. The outer universal equality still needs the separately owned list-index proof; the two synthetic equalities are not its replacement. No character-label, residue-scatter or analytic interpretation is supplied by this review.

## Shapes, magnitudes and unresolved mathematical inputs

The public guard requires nine exact root-row lengths and exact identity/quarter-turn entries, coordinate bounds S+1, 4800 input pairs bounded coordinatewise by 2^95-1, and 2301 result pairs bounded by 2^112-1. Public cache entries are constructed internally. These conditions prevent callers from substituting unrelated cached sums. Total lookup defaults remain in the generic functions; at the public admitted shapes, the displayed index ranges are within the intended lists. The general helpers make no useful transform claim for arbitrary other lengths.

Coordinate bounds are representation guards, not a complex norm bound, root enclosure, input accuracy or accumulated error theorem. In particular, a syntactically valid root packet may be analytically wrong. The source explicitly retains root generation/enclosures, input assembly and regridding, the old-to-tensor residue layout, actual characters, phase convention identification, complete error propagation, completion/reality and sign/count acceptance. Those missing joins do not obstruct testing this explicitly integer reference, but do obstruct claiming an L-value or Hardy-sign certificate.

## Diagnostics and trust boundary

The ten small controls test root shape/special entries/bounds, local projection across all nine lengths, both signed half ties, short input, invalid roots at the public entry and input overflow. Six additional full controls test two complete tensor comparisons, two public successes, a nonzero impulse and a deliberately changed output. The root and input fixtures are synthetic integers. Their h1/h2 names do not identify analytic heights. Success is not asserted before execution.

Each prepared check asks stock cv conversion for the exact quoted term, discharges any remaining preconditions by ordinary proof, checks that no theorem hypotheses remain, verifies the exact left-hand side and expected Boolean right-hand side, and saves the resulting stock theorem. The ancestry gate permits only the four standard HOL bool axioms; the tag gate permits DISK_THM imports and prints axiom tags. This is the established HOL/Compute/import trust boundary, not an oracle-free replay of upstream libraries and not a claim of Lean's axiom model. No experimental/native output is used as theorem authority.

The runner verifies the seven-file manifest, records direct dependency/tool hashes and prior artifacts, uses --no_prereqs, separates theory/audit-build/audit-run phases, caps each at 900 seconds and 4 GiB virtual memory, rejects nonzero exits and missing final output, and rechecks source/dependency pins. Its control-count gate is 10 or 16, not an independent label-by-label parser; the fixed source performs named checks and the resulting log still requires inspection. Warm/no-op builds must not be called fresh construction. CPU/elapsed evidence is unavailable at this review.

## Performance limitation

This is a linked-list reference. `tx_pair` and `tx_row` scan from the head; global GENLIST gathers repeatedly request indices up to 4799. These traversals can contribute quadratic work even though children and bridge lists are explicitly let-bound and not recomputed for each final output. The source neither realizes nor proves a packed-array/in-place schedule. Do not infer production throughput, memory savings, or an arithmetic-cost multiplier from this reference's future timing without a traversal/representation refinement and its own measurement. This is a performance limitation, not a defect in the integer result.

## Exact reviewed pins

Manifest SHA256: DA80C47F90CFEC64B41B54D178FAA4B8D376BAD00BC3C4593563BBF3AAA5DA5F. All seven entries below were independently matched to current bytes before writing this report.

```text
F352C75345C809D7BD019DF3959C4984F216AF09E644C1D777F793F52CB56440  C10004TransformScript.sml
248CB8E0548A30A65905197E278071B34E6F0D01DFC71B71A93367918BBA5780  C10004TransformTestsScript.sml
33AF1198A13F551632376A177748C0373433D5231E52C807E1B0DB9E1453DCA2  transform_audit.sml
F1E1DEDA22DAA99AFA301F93C471A531560A8DFD68366081D5AEA919BAD85CA0  Holmakefile
967969741C3D3F729D541F00F35B0AFDD3771D40BB4D0A7DC604ADE1FEA2728A  run_transform.sh
FA3F871BE530BE2A0507D0CA88321F24E6C269955E45D0EA3B779701FCECF2CD  README.md
E94D9AB07B167B92242EF3940C2DBD078022B3B1AC46C4DE5EB1152C41F1C2D9  MISSING_THEOREMS.md
```

Supporting source inspected: BlockRoundScript.sml (round_scaled definition and positive-divisor precondition), StageCheckScript.sml (three_real/three_imag), stock boolLib.sml/HolKernel.sml/Drule.sig (namespace exports), and stock cv_stdScript.sml/cv_repLib.sml (identity inlining). No installed library or implementation file was changed. This review freezes the predecessor; a later translation repair requires an explicit delta binding rather than silently changing these pins.
