# Integer handoff result review

2026-11-13. PASS for the exact integer-only comparison, based on the handoff10 numerical receipts and successful readback03 recovery. Both numerical arms passed their own final equality checks and all controls; readback03 independently loads their existing exports and confirms identical full final theorem conclusions. The original combined runner and readback01/02 remain failed attempts. No build, numerical evaluation or benchmark was run for this review. This is source and recorded-runtime validation, not an independent kernel replay.

## What the numerical arms established

Both sources construct identical initial/step literals, identical expected final literals and identical control code. I independently compared those source blocks, parsed the final literals as four rows of 129 pairs, and matched the materialized eight-by-129 trace literals to the pinned `state_fixture.json`. This is source/receipt inspection, not an independent recomputation of the numeric recurrence.

The final intended theorem is the unconditional integer equality

```
raw_pipeline [1;2;3;41;61;10004;262144;265800] 61 128 sources
  = SOME heads
```

Here both arguments are full literal terms after the private source definition is unfolded. Each numerical arm requires its actual theorem to have exactly this input and output before saving `final_integer_pipeline`. The materialized arm proves the producer trace, checks its equality to the supplied intermediate literal, translates that named literal, proves the consumer and composes via `raw_pipeline_join`. The fused arm proves the combined pipeline directly. Both use ordinary proof-producing CV computation; a Python success bit is never a theorem premise.

`raw_shape` checks all eight rows, exactly 129 entries per row, with both coordinates strictly between minus and plus `2^121`. It is checked before any consumption. The denominator is row 4, base 61; outputs use numerator rows 0–3. Total list operations cannot silently truncate this accepted input. There are 1024 recurrence updates and 1032 state pairs, followed by 516 output pairs. The recurrence divisor is `2^122`; the conductor/conjugate product divisor is `2^140`. Both coordinate operations use the existing signed nearest rounding, including its tie convention.

This establishes integer computation on supplied initial states and step constants. It does not prove their HOL logarithm, inverse-root, exponential, analytic state-error or actual raw-head meaning. Nor does it prove source-to-character, L-value, sign, interpolation, Turing count or TG closure. The fact that the seed fixture originated in the Lean work does not import Lean theorems into HOL.

## Controls and trust evidence

Both logs reach `HANDOFF_PRIMARY_COMPLETE,516,8,129` and `HANDOFF_DONE`, exit 0, and record all nine false controls: seed, step, interior, row_index, dropped_row, repeated_row, final_entry, base_label and denominator. Both additionally prove the true signed-tie conjunction `round_scaled 2 (~5) = ~2 /\ round_scaled 2 5 = 3`.

The dropped/repeated controls shorten/lengthen an inner state row; their names do not mean an arbitrary same-length duplicate is excluded by `raw_shape`. Interior and row-swap controls instead compare against the exact producer. The denominator control changes guarded conductor 61 to 62; it is not a test mutating the fixed arithmetic divisor. These controls test their stated corruptions, not every conceivable malformed input.

The materialized log contains 13 audited theorem tags and the fused log 12. Every printed tag has only `DISK_THM` in its oracle list and an empty direct axiom field. Both ancestry scans list only the four standard HOL bool axioms. Source checks require empty hypotheses. This is an ordinary source/runtime audit, not an independent kernel replay of the exported `.dat` files.

## Timing boundaries

All seconds below are from one run per arm, in fixed materialized-then-fused order. They are not medians or a controlled repetition study.

| Measured quantity | Materialized | Fused |
|---|---:|---:|
| Primary instrumented CPU sum | 8.752890 | 0.657195 |
| Primary instrumented elapsed sum | 8.778989 | 0.660355 |
| Control instrumented CPU sum | 53.331812 | 45.738566 |
| Theory export CPU | 4.442880 | 4.204669 |
| Sum of all instrumented CPU phases | 66.527582 | 50.600430 |
| Whole numerical process CPU | 77.84 | 61.59 |
| Whole numerical process elapsed | 89.75 | 74.03 |
| Peak RSS, KiB | 2098024 | 2098380 |
| Exported theory bytes | 6135030 | 4758006 |

The primary sum includes shared source construction/definition/translation, expected-output construction, proof computation, final binding and saving the final theorem. It excludes controls, later whole-theory export, imports and uninstrumented work. These are additive explicitly timed scopes, not whole first-acceptance timings. The primary difference is 8.095695 CPU seconds, a ratio of 13.3185584 for these scopes. The whole numerical processes have a ratio of only 1.2638415 and include different amounts of control work. Neither ratio is a backend multiplier or a whole-campaign prediction.

The main observed materialization cost is `translate_intermediate`, 7.363010 CPU seconds. Additional materialized costs include producer decoding 0.750122, intermediate construction 0.066352 and definition 0.203993. Fused final decoding is still 0.543517. This supports avoiding one measured decode/name/retranslate boundary; it does not make final decoding, all representation work or analytic source production free.

The handoff10 generic/build invocations also exit 0, but their logs show scanning rather than fresh theory builds. CPU totals are 3.15 seconds generic, 2.67 materialized launcher build, 2.91 fused launcher build and 2.85 comparison launcher build. They are actual incremental invocations, not first-construction totals. The failed comparison costs another 0.51 CPU seconds. Earlier failed attempts and the earlier successful generic construction remain separate engineering history. Generator-reported proposal CPU 0.03125 seconds excludes the HOL work and is not a full process measurement.

The exports contain the final theorem, controls, private definitions and their context. Their 1,377,024-byte difference is not the byte size of the primary theorem alone. Peak RSS includes each complete process and remains below the runner's distinct 4 GiB virtual-memory cap; virtual memory and RSS must not be equated.

## Comparison recovery status

The original `handoff10_compare` exits 1 because `HandoffMaterializedTheory` and `HandoffFusedTheory` were not declared in that process. Consequently the original runner never reached its final source-check or completion marker. It must remain recorded as failed. The unmodified `summarize_handoff.py` correctly refuses to summarize it as a completed run.

Readback01 builds its launcher but exits 1 during runtime: plain SML `use` encounters the generated loader's `#(FILE)` syntax. Readback02 also builds its launcher and exits 1 during runtime: passing an already-physical `.hol/objs` path to `Meta.qquse` fails its logical-path resolution. Readback03 uses absolute logical theory paths, allowing HOL's filesystem mapping to resolve `.hol/objs` once. It loads existing pinned exports, checks closed permitted-tag theorems, compares their complete conclusions with `aconv`, and inspects the RHS as four 129-pair rows. It contains no numerical evaluator, wrapper invocation or theorem re-export.

Readback03 build and runtime both exit 0. Its log identifies the correct export directory, prints both final theorem tags with only `DISK_THM` and no direct axioms, then `HANDOFF_MATCHED_EXACT_FINAL_THEOREM,516` and `HANDOFF_READBACK_ONLY_DONE`. The before/after input checks, historical launch/support checks, byte-identical archive checks and source check all pass. I independently rehashed their 19 frozen input entries and four recovery-source entries, in addition to the 16 historical launch/support entries. Readback loading/checking took 5.30 CPU seconds and 12.94 elapsed seconds; its launcher build invocation took 2.94 CPU seconds and 28.22 elapsed seconds. These recovery costs remain outside the primary numerical timings. They do not convert the historical failed original run into a successful original runner execution.

## Provenance checked

I rehashed all 11 entries of `handoff10_launch.sha256` and all five entries of `handoff10_support.sha256`; every entry matches current bytes. The support manifest covers selected installed HOL/BlockRound inputs, not a complete transitive dependency inventory. The two archived `.dat` exports match their current `.hol/objs` counterparts byte-for-byte. The recovery manifest also binds the generated loaders and generic theory files, preventing readback from silently using different results.

| Input/evidence | SHA256 |
|---|---|
| state_fixture.json | 01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9 |
| RawStateHandoffScript.sml | 774B0143E497705D2575062083B3952B88C9E06C1C9571ED3D53A7BAC114EE9C |
| HandoffRuntime.sml | CB1CC15B68CF987AFA38182BCC7EAFC41E95ADA96565CC611239D23A30B7C1F0 |
| prepare_handoff.py | FE87A04CD1D8B66CF3F2D9D2FE06BE3C1A6481CC5838FCC8637DBB2408404467 |
| handoff_materialized.sml | CC6C9A6A4891BB8B4FB2276474BF8F34EC403E2FF5D3FE1863BE8710E85C73AF |
| handoff_fused.sml | 5C5DED9D9613808528F8DD1D98360C0DD9131B821514C8A4A7D2A85CE900BF5D |
| handoff10_launch.sha256 | ED35FB5E89E8305D23C9DFC9C7BC0A38E5B471FC6463FA40A70251C2546451BD |
| handoff10_support.sha256 | 474C9B45D13DC91EA0FE24180DF207916460F5CB3EDC8E32E1DFAAC47AEF90BF |
| handoff10_materialized.log | 5236BD5CA7A97D6AEC3C5B40BD99407322400BFA43D3A3493031E9E89450F8D3 |
| handoff10_fused.log | 03704DF18B5C4DF0FCC2137049E9F65172896194F85BB4948D1880F7C2E58853 |
| handoff10_materialized.dat | 5627C2483F095E8B48E8D9931856289E62C15F824791CA27ED41D8FC87337D6F |
| handoff10_fused.dat | 7F438CE76D4A56D0199F167CEA8D035F46259A227F3CD0F4C343BC174C6D65B5 |
| handoff10_compare.log | 4C464C0FC572947DBC8E89AF78A7010FB6B86F4DADE562EE008BDC9CDAF01F8B |
| handoff10_compare.time | 79F3422FAA327D5AF812A9078F875289538AC555396289DCDA2340E876B5AA6D |
| compare-recovery/compare_readback.sml | 996348990E8D9B60E67799ECFE7846F2F2C9F5935D74F3E7C3B31A44B194FC4C |
| compare-recovery/compare_readback.exe | FE95A6169B3E0A540BA7343CCC8B530B452CBD3FCA333184AFDCEF263E4C5EC8 |
| compare-recovery/frozen_inputs.sha256 | EAD6106CF2794B9E798029077032235C509CF9347757558AEF74939938DD9562 |
| compare-recovery/readback03_source.sha256 | AF38FF79397D3692E5AA15689347ECD23497AC2BC87AB93CEB29C6C4A92C48D7 |
| compare-recovery/readback03_readback.log | AC44B9833333F8FE179D18E1155D7CBCD242BA28210BE797C08B59C0866804B3 |
| compare-recovery/readback03_readback.time | 47DB8EF53F6FE0607E0AF48A9947F254BEA6FC7029BA0BE3C47AA7AF50A12E06 |
| compare-recovery/readback03_build.time | 2C72D24204755369F570AB8A925D0FBE68E3DB582CF3A5CF331A48A575F9B7DF |
| compare-recovery/readback03_built.artifacts | 35FA5D7953605EB416ADE8F2DB6951524EA3064D4F779CD9DF5B79398D201029 |
| compare-recovery/readback03_inputs_after.log | B83CE9A8333C4B87DD02900994A5042DE1A9845741830FDE2DE7FAA9697215EF |
| compare-recovery/readback03_historical_binding.log | D8D91DDEF4EABB4382365D22077BEDADC82F88028B1F33014419F026CC673F1A |
| compare-recovery/readback03_dat_binding.log | EEADE8718091778EBB21F2CA75D1C9D8C1AE84F9159839C93925C65D70F59724 |
| compare-recovery/readback03_source_check.log | 1A7454B69BAC4A962890F16F193DC9525CB569B2D92AF48802371D45C9980014 |

The next justified implementation choice is to preserve the computed integer object between producer and consumer where the actual downstream contract permits it. Before changing a campaign cost row, repeat a matched run and bind an actual analytic producer/consumer boundary, including required export, cache lifetime and final decoding. This single integer handoff does not justify deleting the entire representation row or applying a speedup to spectral arithmetic, roots, signs or completeness.
