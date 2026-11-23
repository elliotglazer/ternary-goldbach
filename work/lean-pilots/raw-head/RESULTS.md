# Raw-head pilot: current evidence

This report supersedes the historical pending-status checkpoint prose; `PLAN.md` also now contains a newer 2026-11-13 checkpoint. It summarizes saved successful builds and independent audits; preparing and updating it launched no build, evaluator or benchmark. The result is a compiled actual-source-to-state producer plus measured source-component replays, **not a complete raw-head export, spectral sign block or end-to-end TG proof**.

## What is now proved

The current core provides the following actual-function conclusions under ordinary Lean axioms:

- The range-reduced integer log program exports a grid129 center with error strictly below `2^-128` against `Real.log x`. It uses grid137, 45 Horner stages and a checked shared log2 center. The 8- and 64-input fixtures discharge their range and computed-center premises. Corruption and signed-rounding controls compile.
- Supplied inverse-root candidates are checked by adjacent-square inequalities. A second implementation computes `Nat.sqrt ((S*S)/x)` and proves the same enclosure. At `S=2^98`, both 64-case exports have exactly the same compiled theorem type, with no candidate or accuracy premise left.
- The actual integer exponential/Horner program and its final regrid produce a grid122 step approximating `exp(-i*(5/64)*log x)` with error strictly below `2^-120`. The final theorem requires only `x>0`, `k≤18`, and `2^k≤x≤2*2^k`; its intermediate polynomial/rounding premises are discharged.
- `RawHead.rawStateValue_error` in `RawStateProducer.lean` initializes the actual inverse-root candidate exactly on grid120 and advances it using the actual rounded complex product with that fixed grid122 step. For the same four integer range premises and `j≤90000`, it proves error strictly below `2^-96` against `integerPower x ((j:Real)*5/64)`, the actual positive-base power `x^(-1/2-it)`. There is no assumed step accuracy, recurrence accuracy or candidate certificate in this final theorem.

The last theorem is generic, not an evaluated 90,001-entry array. Its proof retains the step-error cross term and bounds total error by `2^-98 + 270000*2^-120 < 2^-96`. No grid100 export feeds back into the persistent state. Exact source/cache identity is still needed for any supplied literal state or step array.

Current evidence was rechecked against source, object and log hashes for 20 successful core/extended/state receipts, including `logcases64_06`, `sourceaudit04`, `expinteger04`, `stepproducer02`, `extendedaudit01`, `dyadicproduct02`, `stateproducer02` and `stateaudit01`. The state probe prints the actual final type and five standard-only axiom lists. `STATE_SOURCE_AUDIT.md` independently reviews the mathematical composition. The standard lists are `[propext, Classical.choice, Quot.sound]` for the inspected exported closures; this is not a project-wide axiom claim.

## Nine completed CPU observations

All rows below passed the saved CPU-handshake protocol. Times are seconds **per rechecked 64-input bundle**, not initial proof construction. Each row is a fresh process; it repeats the same fixture 50 times for logs or 1,000 times for inverses.

| Receipt | Repetitions | Phase process CPU / 64 | Inner elapsed / 64 |
|---|---:|---:|---:|
| `cpu_logs64_02` | 50 | 1.011875 | 1.01996075 |
| `cpu_logs64_03` | 50 | 0.820625 | 0.82913035 |
| `cpu_logs64_04` | 50 | 0.8378125 | 0.84469406 |
| `cpu_inverse64_01` | 1,000 | 0.131140625 | 0.1321724346 |
| `cpu_inverse64_02` | 1,000 | 0.137140625 | 0.1380385143 |
| `cpu_inverse64_04` | 1,000 | 0.14578125 | 0.1480673285 |
| `cpu_generated_inverse64_01` | 1,000 | 0.205203125 | 0.2076441875 |
| `cpu_generated_inverse64_02` | 1,000 | 0.22296875 | 0.2272305655 |
| `cpu_generated_inverse64_03` | 1,000 | 0.219328125 | 0.2306453559 |

Median CPU per bundle is **0.8378125 s logs**, **0.137140625 s supplied inverses**, and **0.219328125 s computed inverses**. CPU ranges are respectively 0.820625–1.011875, 0.131140625–0.14578125 and 0.205203125–0.22296875 seconds. These are observed ranges, not confidence intervals.

For the identical inverse-root output contract, supplied/computed median CPU is exactly `8777/14037 ≈ 0.625276`; computed replay therefore used about 1.599294 times the median CPU in this experiment. The corresponding inner-elapsed ratio is approximately 0.607482. The generated closure has 193 declarations versus 321 supplied declarations, showing why declaration count alone is not a checking-cost measure. No production speedup follows from either ratio.

The independent comparison audit reconstructed all nine rows and summaries with 800 checks, including 26 consistent local dependency pins. Interrupted supplied run03 is excluded with explicit provenance and replaced by run04; no missing cost is imputed. The first failed log handshake is also not a valid observation.

### Construction versus replay

The replay renames and rechecks concrete theorem closures at trust zero, not merely the final theorem reference. Generic libraries remain imported. Pool renaming, imports, initial admission and warmup are outside the measured phase. Phase CPU includes handshake polling/bookkeeping; inner elapsed has narrower boundaries. Wrappers explicitly use unlimited heartbeat count and recursion depth 65,536 within the separately bounded runner: these are disclosed measurement settings, not default elaboration.

The final 64-case source construction uses default heartbeats; the historical raised-heartbeat version remains separately preserved. Its successful `logcases64_06` process used 47.078125 CPU seconds and 44.2049033 wall seconds. The generated inverse-only module's `invgenerated01` used 20.59375 CPU seconds and 19.9427448 wall seconds. These are **not matched construction competitors**: the former also proves logarithm claims. They also include process/import work and exclude construction of prebuilt dependencies. Neither replay totals nor these two module times price the complete source library or full workload.

## Prepared work and limits

`RawCachedLoop.lean` and `RawInverseRootWitness.lean` now have clean successful build receipts `cachedloop01` and `invwitness01`. Their source/object/log hashes were checked against those receipts; both record exit zero, unchanged source, no dependency builds and empty logs. They supply cached-trace identities and a supplied-square-witness identity with the canonical computed initializer. This is **compiled helper evidence pending independent API audit**, not an accepted performance improvement or concrete-trace certificate. The build observations are 27.046875 CPU / 46.3113915 wall seconds and 21.765625 CPU / 25.1390201 wall seconds respectively, with imported-library overhead included.

`RawDyadicProductThree.lean` remains a prepared, unbuilt alternative with no corresponding `.olean` in this snapshot. Its proposed exact three-product update has not been adopted. Operation/width changes and all three helpers' eventual use still require appropriate review and matched measurements. In-progress `RawStateSources` and `TraceCertificate` work is outside this report; no compilation or acceptance claim is made for it.

`state_fixture.json` now contains an **untrusted** proposal for eight bases, 128 updates each and 1,032 retained state pairs. Its exact integer generator is prepared separately from Lean acceptance. No checked literal-trace equality is claimed by the fixture's existence. The next proposed matched block experiment must include initial-state and step bindings, all retained outputs, and source/setup costs. The generic recurrence theorem alone cannot count as having computed these outputs.

The earlier scoped text check of the then-34 immediate `.lean` files found no standalone `sorry`, `native_decide` or `axiom` tokens. That historical lexical observation is not a current directory-wide or transitive proof audit. This update separately checked the three core source files named below and the two newly compiled helpers for `sorry`, `admit`, `sorryAx`, `native_decide` and `axiom` tokens; none were found. The unbuilt three-product source remains unaccepted regardless of token absence.

The following fields apply **only** to the measured roots `RawLogCases64.all_logs`, `RawLogCases64.all_inverse_roots`, `RawInverseRootGenerated64.all_inverse_roots` and the independently audited `RawHead.rawStateValue_error` closure. These are internal pilot exports, not newly frozen campaign anchors. Existing standard-only axiom probes and source audits justify the closure-specific zero counts; they are not an inventory of project manifests or unrelated imports. Newly compiled helpers and in-progress work are excluded from these fields.

```text
DRAFT_ANCHORS: 0 in the specified pilot-export scope; paths: none.
UNREGISTERED_SORRIES: 0 in the inspected specified closures; paths: none.
DRAFT_IMPORT_VIOLATIONS: 0 detected in those audited closures; paths: none. No project-wide graph audit claimed.
SEALED_THIS_TURN: 0; exports: none. This update records evidence and seals no declaration.
```

Actual conductor-cache multiplication, final raw-head grid100 export, full Hurwitz assembly, character transforms, completed signs, interpolation and complete zero counts remain outside this closure. Optimizing the 265,800-integer initializer pool alone does not price the repeated source states, all source-to-input bindings or the selected spectral family.

## QRH and forecast status

Full QRH provider validation remains open. The isolated first-leaf diagnostic for `OAI.NumberTheory.DirichletL.Arithmetic.EisensteinCoordinates` stopped with status `observed_private_limit_stop`, exit124, after 9.171875 CPU seconds and 9.4384068 process-wall seconds. Observed private memory reached 4,448,313,344 bytes, beyond the sampled 4 GiB threshold. The diagnostic explicitly records `hard_memory_cap=false`: this was a sampled stop, not a hard allocation limit. No expected primary output was present; no axiom audit or reusable accepted artifact resulted. The attempt used Lean4.35 with cached dependencies while the source recorded Lean4.34.1. It neither validates nor mathematically refutes the provider.

The conditional end-to-end model is **unchanged**. Its measured anchors, assumed transfers and unresolved success/library/representation costs are not replaced by these source-component numbers. There is no new universal backend multiplier, most-efficient forecast or whole-family success evidence. The useful next decision is whether to build and compare matched cached recurrence traces, preserving the complete output contract, rather than extrapolate inverse-root replay to the TG computation.

## Evidence pins

Paths are relative to this directory except where specified. Existing audits contain the detailed source/object/receipt manifests.

| Evidence | SHA256 |
|---|---|
| `MEASUREMENTS.json` | `67E33EED8D679D97E5598B2FD1F68AE9EF8D663BE8CB143C918405A4E97F9815` |
| `INVERSE_COMPARISON_AUDIT.md` | `84878A2DB1674774CAC37CB595C9C679C986C8F110D29DAFC35D93950336E7C3` |
| `SOURCE_COMPONENT_AUDIT.md` | `779C044560FACD665B9DCDB9CEEB28A0ABA6E44B547876B385237F8F70FBF996` |
| `EXTENDED_SOURCE_AUDIT.md` | `3F30ABA29F289FB11B653E2A3942D98E7E53F15CABDE09658EA11E7DACEDD46E` |
| `STATE_SOURCE_AUDIT.md` | `3710C2FCF56DDFD1C846B0FA06ABA4948E9A9F2225413BC2DF9D0912285D9768` |
| `REPLAY_PROTOCOL_AUDIT.md` | `52F362107CB04989577BDB35FFA3EA22FE8A2D1CE420BE0E161C6C9FE169BE40` |
| `COMPUTED_BLOCK_EXPERIMENT.md` | `27C8471B9C1CE653EF2B61C8B2524D120B64C416DAC37884905EF27AFE6C5BFE` |
| `state_fixture.json` (untrusted proposal) | `01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9` |
| `RawCachedLoop.lean` (compiled; independent API audit pending) | `9C372DB0EA74D75F01BD25E3EE9C08760EE3B3E6731717EBBDBD36A0223DB03D` |
| `cachedloop01.json` | `59F8EF0C750C30E6C9FCF404A259EC32438E0462ECDD94EFD6CFBB77813409A0` |
| `RawCachedLoop.olean` | `047ECF9A3951A8F5610650179126A9ED1068D52D82C3DA76C528A5350AD734F2` |
| `RawDyadicProductThree.lean` (unbuilt) | `A6238A80E60A2C44C61B1F56CC7B39432ABE7BD5DB4C909F37F7A25EAF8BCCB5` |
| `RawInverseRootWitness.lean` (compiled; independent API audit pending) | `4D55FDAC9357B68C7093E472B572E06E59CB7CF8CC7617A80B0AE54AB39C6CE7` |
| `invwitness01.json` | `CE87D83EAD9FA8DE2262665CC931C83AA5692F66C1151D7A5539B89C99B32E8E` |
| `RawInverseRootWitness.olean` | `67F23D82165E6ABAB0368953D3396A6F7BD8F6E122F94F46F13E81651FA30DEA` |
| `work/qrh-build/first-leaf-quarantine/1113T063006_f9e4d324/diagnostic.json` | `D1D7EB2F610C08FC78A69F2A39B80917168D063184A0E0864A85A340DD6149EF` |
| `work/backend-costs-20261112/forecast-audit-20261113/END_TO_END_MODEL.md` | `37D11CA50EFD9259021C2B6422C662D476FE683C6C5E1AA3B97C19288AEDE3FA` |

Only `RESULTS.md` was written by this reviewer for this update. No source, receipt, forecast or checkpoint was edited by this review; coordinator checkpoint updates are separate.
