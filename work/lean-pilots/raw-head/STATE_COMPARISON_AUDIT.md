# Matched raw-state proof comparison: source audit

Verdict: PASS for the pinned source comparison and complete consumption described below. Both complete roots have compiled successfully. The compiled comparison confirms structural Lean expression equality and the four expected standard-three-axiom lists. Performance/replay acceptance remains PENDING; no speed conclusion is made. No timing or speed conclusion is made. The completed controls and earlier fixture/source/support audits are reused at their recorded scope.

Only this report was written. No Lean build, source modification, fixture generation, analytic evaluation or benchmark was run by this audit. Read-only Python checks parsed the existing sources and fixture to compare literals and declaration references; they did not recalculate state updates. The reviewer authored the inverse-root helpers and controls, so those components are not presented as newly independent results here. Their existing independent support review and root-controlled successful builds are the consumed evidence.

## Layout refresh and history

This refresh supersedes audit SHA256 `980A48611C26EA45EC5E8ED5449C985E2BD96883478B9DC5D5E7F921736D46B1`, which bound monolithic explicit source `2C3FA116F604C7C60FB83F75662ECA1373BD15A9181F2514DEBDDF02C567D56F`. Its stateexplicit01 build stopped at the private-memory cap, exit 1, without an accepted object; that is not a mathematical rejection. The current split was rechecked against the unchanged fixture, without assuming exact bytes of an archived monolith.

All eleven explicit modules retain namespace `RawStateExplicit`: support, eight bases, aggregate and closure. Physical imports do not move their arithmetic outside the replay prefix.

Completion refresh: prior split-layout audit SHA256 `B4F7D58376D61175A7A10F0DDD51401DD1D0C75A36096323C4A0132F268F0523` left the compiled closure pending. The current receipt checks below close that gate without changing the source-level conclusions. No Lean command or benchmark was run by this reviewer.

## Exact common output

Both full roots export a conjunction whose first component is the complete ordered trace equality

    [rawCachedTrace 0 1 128, rawCachedTrace 1 2 128,
     rawCachedTrace 1 3 128, rawCachedTrace 5 41 128,
     rawCachedTrace 5 61 128, rawCachedTrace 13 10004 128,
     rawCachedTrace 18 262144 128, rawCachedTrace 18 265800 128]
      = RawStateData.allTraces.

Each trace contains the initial row and 128 updates, so this binds all 8*129=1032 literal complex integer pairs, or 2064 coordinates. It is not only a final-row check, length claim, hash or aggregate checksum. The remaining eight conjuncts each quantify over every natural j<129 and prove

    norm(expIntegerValue (2^120) trace_x[j]
         - integerPower x (j*5/64)) < 1/2^96.

The true object is the literal complex exponential representing the positive-base power, not an unspecified approximation target. The time endpoint j=128 is included. All fixed positivity, range-exponent and height premises are discharged inside the concrete proofs; no source equality or analytic-error assumption remains a premise of these output theorems. The quantified j/hj binders are intended and do not move any concrete computation into an assumption.

The two root declarations are `RawStateExplicit.full_output_checked` in the separate closure file and `RawStateComputedPacked.full_output_checked` in the packed file. Both use `type_of%` on the same nine kinds of proved statements, followed by direct conjunction construction. Read-only source comparison found the eight quantified error statements identical after qualifying the imported `RawStateSources.trace_length_x` names. This source check is now corroborated by the successful compiled `Lean.Expr.equal` test on the full root types.

## Explicit operation-certificate path

The eight `RawStateExplicit{x}.lean` base files together contain exactly 1024 theorems named `step_x_j`, with j=0,...,127. Each imports only `RawStateExplicitSupport`. That support imports only the common source and generic certificate modules and defines `follows_cons` in the SAME replay namespace. Aggregate `RawStateExplicit.lean` imports all eight base files in fixture order and consumes all eight `actual_trace_x` results in that order. Closure imports the aggregate. Each states one exact `mulStep (2^122)` equality between literal signed pairs, proved by ordinary `decide +kernel`. The current four-product algorithm and actual signed `roundDiv` are unchanged. The optional three-product helper is not imported or adopted.

A fresh independent parse of the split files checked every literal predecessor, step pair and successor against the saved fixture row, without recomputing multiplication or rounding. It also matched each entire exposed literal tail against fixture rows 1 through 128 and verified namespace/import lists. All sixteen actual-trace and actual-error statement types match their packed counterparts after whitespace and source-name qualification normalization. Their proof bodies differ in rewriting presentation but consume the same initial/step source equalities and certificate; source inspection does not replace the final compiled type test. It also checked that each base's `certificate_x` uses exactly `step_x_0` through `step_x_127` in order. There are no skipped, duplicate or unused explicit edge indices in that certificate sequence.

The shared local `follows_cons` lemma consumes both the checked next edge and the remaining trace proof. Its recursive premise starts from the accepted next pair. `certificate_x` first exposes the exact tail and initial row, then applies that lemma 128 times and closes the empty tail. The first-row equality is justified by the literal data and definitional conversion in the proof; it is not an unchecked generator assertion.

`trace_checked_x` invokes the generic checker soundness theorem, uses the proved trace length 129, and reverses the resulting equality to the common orientation. `actual_trace_x` uses both fixed source equalities to replace the cached initial/step with the canonical actual producers. `actual_error_x` consumes the same certificate and same source bindings through `traceCertificate_actual_error`. Both branches are retained by the final conjunction, so the analytic theorem does not replace the complete literal-output claim.

Support/base/aggregate sources contain 1058 theorem/lemma declarations (132 per base, one support helper and one aggregate): 1024 edge facts, one local composition helper, four exports per base, and the all-traces equality. The separate full closure adds one, giving 1059 named declarations across the explicit replay prefix. This is a source count. Actual collected dependency count, generated auxiliary declarations and runtime still require the replay receipt.

## Computed packed path

`RawStateComputedPacked.lean` has eight `trace_checked_x` theorems, each proving the whole `cachedTrace initial_x step_x 128 = trace_x` equality by `decide +kernel`. Thus Lean checks the actual recursive integer producer against every retained output in one equality per base. It does not merely trust an external recurrence computation or a cached checksum.

Each `certificate_x` is derived from that whole trace equality and the generic theorem that a cached trace passes its own checker. The actual-trace and quantified-error proofs use the same fixed source bindings and generic analytic theorem as the explicit path. The final all-traces and full-output roots retain every base. There are 34 named theorem declarations: four per base and the two final conjunction/equality roots.

Packing changes the module layout, not the mathematical source or the output contract. The packed file documents its original per-base bodies. This audit's acceptance is tied to the packed bytes themselves, not a presumption that a previously compiled split file proves the packed source. Imports are only `RawStateSources` and `RawTraceCertificate`; no explicit-edge proof module or old computed proof module is imported to discharge the new whole-trace checks.

## Shared setup and replay boundary

The prior support audit establishes actual source equality, not just source accuracy: each literal initializer equals `rawStateInitial x`, and each literal step equals `rawStepNumerator k x`. Initializer binding uses the supplied adjacent-square witnesses through the generic uniqueness theorem, preserving the canonical `Nat.sqrt`-defined initializer without evaluating it repeatedly. Step binding uses the checked logarithm, exact integer exponential program and final export. Literal data are shared immutable inputs, not assertions of correctness.

These source proofs, their concrete setup arithmetic and the generic analytic library are outside both state-comparison replay prefixes. They are intentionally common charged dependencies. The state comparison must not be reported as timing full source construction, import checking, first elaboration, log/root/step generation or a complete raw-head campaign.

Inside the explicit prefix, all 1024 concrete state-edge facts and their composition helper are retained. Inside the packed prefix, all eight concrete whole-trace producer checks and their consumers are retained. No concrete state-update theorem is visibly imported from a different namespace to avoid replay. The generic recurrence/checker definitions and their soundness theorems remain common imports, as they should.

The inspected replay collector follows constants in both proof values and types whose names start with the selected prefix, collects theorem dependencies, renames them, and rejects surviving original-prefix references. It checks each renamed declaration with `addDeclCore` at trust zero. Therefore appropriate roots/prefixes are essential:

- `RawStateExplicit.full_output_checked`, prefix `RawStateExplicit.`;
- `RawStateComputedPacked.full_output_checked`, prefix `RawStateComputedPacked.`.

The computed prefix must not be shortened to an unrelated old namespace, and neither measured root should be replaced by an error-only or final-coordinate-only theorem. Actual wrapper pins, gathered closure counts, common import snapshots and successful marker protocol remain runtime acceptance gates. Source declaration counts do not prove those gates have run.

## Controls and shape semantics

`RawStateControls.lean` compiled successfully in `statecontrols01`: exit 0, unchanged source, empty log and recorded artifact hash. The controls prove explicit false-checker/equality results; a timeout or resource failure is not treated as rejection. They cover altered initial data, a wrong step on the nonconstant x=2 first edge, wrong x=2 versus x=3 source binding, interior/final coordinate mutation, and signed negative and half-tie rounding of the actual algorithms.

The constant x=1 row intentionally demonstrates a necessary distinction: a dropped final row or repeated constant terminal row can still pass the generic recurrence checker. Their 129-row shape test fails. The compared full-output theorems do not rely on the checker alone for a requested length: they bind `cachedTrace ... 128`, the full saved list and the checked length. Thus the controls do not claim that the generic checker rejects every differently sized valid trace.

This is a bounded collection of corruption controls, not a proof of exhaustive mutation detection or a substitute for the source and kernel checks. Controls are a separate validation cost, not secretly included in either replay closure or evidence of an arithmetic speedup.

## Completed compilation gates and pending replay acceptance

`AuditRawStateComparison.lean` imports the two full-output roots and the controls. It requests axiom closures for both roots and the generic uniqueness/error bridge. It then checks structural equality of the two full root types using `Lean.Expr.equal` and emits `MATCHED_STATE_CONTRACT,8,129,full_output_and_analytic_enclosures` only if that check passes. The audit command is a comparison diagnostic, not an additional trusted mathematical axiom.

All thirteen selected build receipts pass the independent receipt audit: Support and base 1 from the first successful batch; the remaining seven bases and aggregate from the resumed `_02` batch; explicit closure; packed computed root; and comparison probe. Each has exit 0, no stop reason, unchanged source, no dependency builds, the intended `-t0 -j1 -M4096` command, and current source/object/log hashes equal to its receipt. All selected build logs are empty except the comparison log. The resource-failed monolithic receipt remains history only and is not counted as a successful build.

The comparison log is exactly four lines listing `[propext, Classical.choice, Quot.sound]`, respectively for `RawStateExplicit.full_output_checked`, `RawStateComputedPacked.full_output_checked`, `RawHead.inverseRootCandidate_eq_of_square_bounds`, and `RawHead.traceCertificate_actual_error`, followed by `MATCHED_STATE_CONTRACT,8,129,full_output_and_analytic_enclosures`. Its pinned source compares the two declaration types with `Lean.Expr.equal` and throws on inequality before emitting that marker. Thus exact compiled type identity, rather than merely equivalent prose or source formatting, is established by this diagnostic. There is no reported `sorryAx` or custom axiom in these four closures.

This is successful compilation and a source/object-bound diagnostic, not independent kernel replay of every imported object by this reviewer. Existing shared source/support audits retain their scope. All current source pins in the earlier audit were rehashed unchanged before accepting the receipts.

The forthcoming six fixed CPU replay jobs are NOT covered by this completion refresh. Their prefix collection, complete renamed declaration closure, actual declaration counts, import snapshots, protocol markers and valid phase measurements must pass independently. No first-build time is substituted for replay time, and the failed monolithic run is not evidence of a relative speedup.

Even after successful builds, the comparison concerns a fixed eight-base, 128-update, four-product grid120/grid122 program. It does not establish end-to-end spectral sign/completeness, bounded-machine overflow implementations, cheapest possible integer encoding, or TG runtime. Shared setup and retained output/export work must remain separately priced.

## Pins

Paths are relative to `work/lean-pilots/raw-head`, except the final replay-library row.

| Artifact | SHA256 |
|---|---|
| `RawStateExplicit.lean` | `16247C42B1934E79AD225C70FF035DC34AD28187903766E47AB86F50C1A9B83E` |
| `RawStateExplicitClosure.lean` | `35B9175E3D9E44393B4C76217765C368B9E57576BBC8781FDF0E7C6B9AFBDE59` |
| `RawStateComputedPacked.lean` | `A124E9404C40D7D9F29ADF12FE6832E09E26EB5254BBCF418213E8F37C5E3AC6` |
| `AuditRawStateComparison.lean` | `10C204094F51C5BAC7B53192A848C9AE7D8BEF5C49AA469B9F9E7E851F9390EF` |
| `state_fixture.json` | `01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9` |
| `STATE_FIXTURE_AUDIT.md` | `0778CFFCF875D206F244ADDB94C755B7DFEAA9F8AC278F2E6E7D2D585221497E` |
| `STATE_SOURCE_AUDIT.md` | `3710C2FCF56DDFD1C846B0FA06ABA4948E9A9F2225413BC2DF9D0912285D9768` |
| `STATE_SUPPORT_AUDIT.md` | `0AB99BA58DD338269D4786DFEC02F3597B6B331F1E50ABE3EFB3FCC992E3C352` |
| `RawStateSources.lean` | `F501CDB3DAF8B2B41489B430057AA822854391902802DA091608EB31136756A6` |
| `RawTraceCertificate.lean` | `24B874FC56F7E9EA650D024EA702D1977C83D41282A721D72D91FB98C87E50FC` |
| `RawStateControls.lean` | `E309DE7BFF739FA9573793A49ECC427D3E1829D79A74A9E5E9FBF8299EB8888B` |
| `statecontrols01.json` | `A395C4F168C376DBDB2D054910BC86787F62180257FCAFD02AED247156C60DDE` |
| `statecontrols01.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `RawReplay.lean` | `3C2BFF76BB762B21A5ED86D02946B4592D5741D843E46AA0A37734B57005E943` |
| `work/backend-costs-20261112/finite-lean/FiniteReplay.lean` | `6F9BC9ECB3CB1000F975B30DB43174D6C2D2A3859B4699857C50AF9E389319C0` |

| `RawStateExplicitSupport.lean` | `42AC1A776A65850D02A5667229A6792167BEA13DB7DF37CD6D90C7A186567833` |
| `RawStateExplicit1.lean` | `B8B51B6DCFD743121F96D1352537EC1BF52689978DC9045C26895F437776D6AF` |
| `RawStateExplicit2.lean` | `3D62AEEBDCA31A6A46172E4B6B0805E03EC6F242C95419E5893FD6DA459AFB14` |
| `RawStateExplicit3.lean` | `D1985A99409A8C83815EECCC1F7F9E53EA0595CE03A7C0F9248F3299EB94A5BF` |
| `RawStateExplicit41.lean` | `507F27150E314F88F675550F8B31D7C6C2F68825CDCB68B079DBB69430594AB9` |
| `RawStateExplicit61.lean` | `191B56AA31BD6123E5CD44237F5922D1CF7518B94FD4A1B08EC5F4E5248C433D` |
| `RawStateExplicit10004.lean` | `5132D59C03F43E6E5ABF3B8DB581F1CB7A6CCBDDC01B401D7068F3A82F7EE669` |
| `RawStateExplicit262144.lean` | `2DDB30964BD391D854BB1A9F9AFF046DC1A5FE9EA9CEB4E41ED9A4A186757A5A` |
| `RawStateExplicit265800.lean` | `844B92776F2E752FF58EFF3EFAF8507629A056FB6AB8321205BC239DAC96FF7F` |
| `stateexplicit01.json` | `DACD556C5128FBFBB1D95A5A8C8D7FEC0EE5D9BAFA76788D6054784E815420A7` |
| `statecomputedpacked01.json` | `0D62FDC8E5B38AFC846DAE35D33DD13970EE008BAA4A5082D7095A5713B4BEE8` |
| `statecomputedpacked01.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `RawStateComputedPacked.olean` | `B934A52AC8F7A097F54A15874F486C2903B19733F1214BE9856BB0D3E0029E42` |
| `stateexplicitsupport_01.json` | `D92C8BEB8E1413F68AFE5BFE1701734361EFF8AB1C2A79D9D47FB1E1B8314D96` |
| `RawStateExplicitSupport.olean` | `DE7428FA8F5404A4ED9250AF7D67267DF9F3E1BB4AD4DE7A3F43E0437ACAC424` |
| `stateexplicit1_01.json` | `8A16B11E8920427B05B9264E829CAAFD4A4BADF069E0A905954D5001E38F392F` |
| `RawStateExplicit1.olean` | `78D62C7C19EAE678BF30BF1642A88B2851B2410F2DBAF764A7D5FA8B37EE41CB` |

| `stateexplicitsupport_01.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicit1_01.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicit2_02.json` | `570827DF71B9862BFA1FFA57A6D69EAD184FFCB1FAC7878F515FEAB3651188E5` |
| `RawStateExplicit2.olean` | `8BC8523B815F792A0AE3006382B3F3764649BA1E187DB133F007337BB9BC75E5` |
| `stateexplicit2_02.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicit3_02.json` | `2AC6BD976423110276494F8F17E81100CF4D15C7D6A0B4EBCEB74DC7BC4F1874` |
| `RawStateExplicit3.olean` | `71AEB05AC862EC6A0DC8FEC4687D792D79AF600C70BDBF1B284168DF175ED601` |
| `stateexplicit3_02.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicit41_02.json` | `9B6C7F47D41D2E950558C92D3A6664A9B2170B06DF90A3864B7CC64A3D13EEBC` |
| `RawStateExplicit41.olean` | `B8AA97056A8CDE46A051F47A521D97EB86174ECBC7AE48A8CB30EF05236A78BE` |
| `stateexplicit41_02.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicit61_02.json` | `F58DBA821DEB7B01B58858FC850DB8104CC81D87ED20C11F631950D5BFFD9121` |
| `RawStateExplicit61.olean` | `AE57877180735B1E28CFD5D59F2A5E1DE3DC53960A98D2051A656745B0D7A470` |
| `stateexplicit61_02.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicit10004_02.json` | `8DA1EAB3ECABA7F81C7D7DC99252AAB31E9D6ACD6F28B5F3CF9FB8D63B29CA95` |
| `RawStateExplicit10004.olean` | `B4C23CEFC9941D6EE4BF5E0CB873C45870308A3DFFBF3374A242EE2187779522` |
| `stateexplicit10004_02.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicit262144_02.json` | `C6E5BFCA48D5831963A735B75E59D2B6B3A5D5E802F1363D0BF83904A92DCD40` |
| `RawStateExplicit262144.olean` | `355B025803579F1028CEB87980704E27B310EA51880513A3A80221453CA7F328` |
| `stateexplicit262144_02.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicit265800_02.json` | `79C885AEFFB06CD62354B21424AB540E44D16F334EB20765ECAEE986B235B136` |
| `RawStateExplicit265800.olean` | `EFB9E42397D78D281A1EE2753059B14D35230C226E7F4F5164730AC1BC0DE3C7` |
| `stateexplicit265800_02.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicitassembly_02.json` | `CAEF9E518F97832C0F2A2195B38C455C41ECD1F29563626E85A3FBAE6DCDC8F5` |
| `RawStateExplicit.olean` | `0FC15C55AA70DD5909E1DA8EB19ABDB0E5BF4D4DC82970EFD11A307B2830E277` |
| `stateexplicitassembly_02.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `stateexplicitclosure01.json` | `3F87E4BF7AFD0088B36D734350E282C35197E8A6E35EAA20447C398A9112DE75` |
| `RawStateExplicitClosure.olean` | `D259F743E3B99B0A97A76100C5B30C83AEAE41F9C2891012717B29AB4C1561E4` |
| `stateexplicitclosure01.log` | `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855` |
| `statecomparisonaudit01.json` | `B1C7F736867D1DAC63273BC1ECAD5089F2746C2769C6261A44C01FC9E741364D` |
| `AuditRawStateComparison.olean` | `4487B99BA0C879A889E42776B095B3789BAB148A7B609822AC8872C2CC873709` |
| `statecomparisonaudit01.log` | `F4D7D87CCD9DA7E1CA1DC640908E3C911F1F001E8E72E1F46025A26EBF8D9818` |

Only this owned audit was refreshed. No source, fixture, replay wrapper or reporter was edited; the history above preserves the earlier audit and monolith identifiers.
