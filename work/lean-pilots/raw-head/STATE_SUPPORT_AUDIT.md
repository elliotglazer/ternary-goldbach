# Raw state support: independent source audit

Verdict: PASS for the pinned source mathematics, the four clean build receipts below, and the completed support axiom probe. All 52 requested closures use only subsets of `propext`, `Classical.choice`, and `Quot.sound`. This is not acceptance of the eight literal full traces, a new build, or a performance result.

Scope: `RawCachedLoop.lean`, `RawInverseRootWitness.lean`, `RawStateSources.lean`, and `RawTraceCertificate.lean`. The reviewer read their complete bodies, compared source/data bindings, and checked existing receipts and hashes. No Lean build, benchmark, source modification, new fixture generation, or function-value evaluation was performed. Only this report was written.

## Exact cached recurrence

`RawCachedLoop.lean:12–84` fixes the step at grid 122 and applies the same `mulStep` used by the actual state producer. `cachedState_succ` has the correct iteration orientation. Induction in `cachedState_eq_rawStateNumerator` proves exact integer-pair equality with the original state recurrence, not merely equal error bounds.

`cachedTrace initial step N` contains the initial state and exactly N subsequent update occurrences; its length is N+1. The `List.iterate` equality and both indexed-access lemmas preserve source order and include the endpoint j=N. `rawCachedTrace` places the initializer and step outside the recurrence. This is a valid source-level cached formulation; it does not by itself prove runtime sharing, proof-term sharing, or a cost reduction. The bridge from arbitrary supplied pairs explicitly requires equality to `rawStateInitial x` and `rawStepNumerator k x`.

## Inverse-root witness

`RawInverseRootWitness.lean:14` proves that the natural candidate m satisfying

`m*m*x <= S*S < (m+1)*(m+1)*x`, with `0 < x`,

equals `inverseRootCandidate x S`. Unfolding the candidate gives the natural square root of the natural quotient `S*S/x`; positive-denominator division equivalences and `Nat.eq_sqrt` establish the result. The strict upper square handles exact-square endpoints correctly. The equality theorem needs no positivity of S; the separate analytic approximation theorem retains its own positive-scale condition. This proof avoids evaluating the square-root implementation in the witness bridge, but supplies no measured speed claim.

## Eight fixed source bindings

`RawStateSources.lean` binds bases in this exact order:

`1, 2, 3, 41, 61, 10004, 262144, 265800`,

with exponents `0, 1, 1, 5, 5, 13, 18, 18`. For every base, the source has eleven binder-free fixed theorems: range, logarithm, root, initial pair, inner step, step from log, actual step, step error, initial error, trace length, and trace head. Together with `base_count` and `trace_count`, this is 90 theorems.

The logarithm binding reuses the corresponding previously checked `RawLogCases.center_x` with the exact shared log-two equality. Root binding uses the matching lower/upper square witnesses through the generic uniqueness theorem. Initial binding multiplies the grid-98 root numerator by `2^22` and supplies imaginary coordinate zero, giving the actual grid-120 initializer. The inner-step and final-step checks are concrete kernel arithmetic, and the actual-step equality rewrites through the checked logarithm. Consequently, the fixed initial and step error exports have no assumed arithmetic equality, approximation, or certificate premise left: they concern the literal pair and the actual `integerPower x 0` or `exp (I * (-(5/64) * log x))`, with the range/positivity conditions discharged internally.

The review compared the current `RawStateFixtureData.lean` literals with the already independently reviewed JSON fixture: all eight exponents; all eight log and root numerators; all eight inner-step, step, and initial pairs; and all 1,032 trace pairs agree. This was data comparison, not a new proof that every literal edge is accepted. Every fixed trace has length 129 and its checked head is the actual initializer. Length and head alone do not certify the remaining 128 edges.

## Trace checker soundness and boundaries

`RawTraceCertificate.lean:9–43` checks exact pair equality at every edge. The recursive call uses the just-checked next pair as its predecessor. Empty traces are rejected; a singleton containing the initializer is correctly accepted as a zero-update trace. Soundness gives equality to `cachedTrace initial step (states.length - 1)`. The empty case has already been eliminated, so the natural subtraction is safe.

The alternative edge proof at lines 46–96 inducts over each index satisfying `j+1 < states.length`, then uses list extensionality and the length equality. There is no missing final edge. Completeness for the canonical cached trace is also proved.

`traceCertificate_actual_index` (line 98) requires the exact initializer/step bindings and checker acceptance, then identifies each in-range optional lookup with `rawStateNumerator k x j`. `traceCertificate_actual_error` (line 111) adds the actual source range, positive x, and `j <= 90000`, and consumes the existing state error theorem at height `(j : Real) * 5 / 64`, grid 120, with error below `2^-96`. It does not assume an arbitrary approximation radius. The generic checker intentionally does not require length 129; application-specific coverage must supply the exact literal length and its intended indexing.

These statements provide the sound checker and source adapters. They do not discharge the concrete full-trace acceptance hypothesis. The ongoing computed/explicit literal-trace work is outside this audit.

## Pinned clean build evidence

All paths below are in this directory. Each listed receipt reports exit code 0, no stop, unchanged source, no dependency builds, and an explicit `-t0` invocation. Current source, object and log hashes matched the receipt. All four logs are empty, SHA256 `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855`.

| Source / receipt | Source SHA256 | Object SHA256 | Receipt SHA256 |
|---|---|---|---|
| RawCachedLoop / cachedloop01 | 9C372DB0EA74D75F01BD25E3EE9C08760EE3B3E6731717EBBDBD36A0223DB03D | 047ECF9A3951A8F5610650179126A9ED1068D52D82C3DA76C528A5350AD734F2 | 59F8EF0C750C30E6C9FCF404A259EC32438E0462ECDD94EFD6CFBB77813409A0 |
| RawInverseRootWitness / invwitness01 | 4D55FDAC9357B68C7093E472B572E06E59CB7CF8CC7617A80B0AE54AB39C6CE7 | 67F23D82165E6ABAB0368953D3396A6F7BD8F6E122F94F46F13E81651FA30DEA | CE87D83EAD9FA8DE2262665CC931C83AA5692F66C1151D7A5539B89C99B32E8E |
| RawStateSources / statesources02 | F501CDB3DAF8B2B41489B430057AA822854391902802DA091608EB31136756A6 | 5BC80F5F3E34E105ED51D3185D940C0F11FD7CB1DDD2F06BA1CA8E6CCDD1853F | FD21E483EA2160DFD9529345CD75210EF511F880FE69385E7C5E45E1046F550C |
| RawTraceCertificate / tracecert03 | 24B874FC56F7E9EA650D024EA702D1977C83D41282A721D72D91FB98C87E50FC | F1151F588342BAD40313BE519B4565A370BE87C353F19562EAE6148B1D417D64 | F43E1DF1175B238BD9D4A72B6DE8349D8175104551DBB72F9F97CD959876F6D5 |

Additional exact pins:

| Artifact | SHA256 |
|---|---|
| RawStateFixtureData.lean | BB0388FFA768A4F4CAF9154534C7F7D40CC5F4177F91513A301610FEA1B72CFB |
| RawLogCases.lean | 6CC1E45D4E8C33BFD52D3E8A752D2A08F34682399F31E8F92EC27F3C02157AEA |
| state_fixture.json | 01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9 |
| STATE_FIXTURE_AUDIT.md | 0778CFFCF875D206F244ADDB94C755B7DFEAA9F8AC278F2E6E7D2D585221497E |
| STATE_SOURCE_AUDIT.md | 3710C2FCF56DDFD1C846B0FA06ABA4948E9A9F2225413BC2DF9D0912285D9768 |
| EXTENDED_SOURCE_AUDIT.md | 3F30ABA29F289FB11B653E2A3942D98E7E53F15CABDE09658EA11E7DACEDD46E |
| AuditRawStateSupport.lean | AB6F3297FE00B5686B21049E4CC8BD6F62A13A375E1CB62B0EE7430A04A57B60 |

The prior source audits supply the actual logarithm, inverse-root, exponential, step and state-error interpretation; they are not new builds performed here. Shared imported library and earlier concrete-log declarations remain explicit dependencies.

## Completed support axiom probe

This update supersedes the pending-probe status of report SHA256 `62DA5182006F402FF8F45FECAD612D475D19F32B4BCE2766AB29731663664F7F`; no reviewed source changed. The reviewer read the completed `supportaudit01.json` receipt and entire log, matched the current source/object/log hashes, and checked an exact ordered bijection between all 52 probe requests and 52 unique output lines. There are no omitted requests, duplicate declarations, warnings, or extra output lines.

The receipt reports exit code 0, no stop, unchanged source, no dependency builds, and explicit `-t0`. Its 30.625 CPU seconds and 80.62667390002753 wall seconds are recorded build observations, not a new forecast or a pure-kernel measurement. No build was run by this reviewer.

The four generic closures and six fixed exports for each of eight bases have only standard axioms: one list is `[propext, Quot.sound]`, sixteen are `[propext]`, and thirty-five are `[propext, Classical.choice, Quot.sound]`. In particular, neither custom axioms nor `sorryAx` occur in those transitive axiom lists. This statement is limited to the requested closures and does not convert imported-library use into a fresh independent replay of all upstream sources. The probe has no separate literal-type equality example; the exact source statements were read in this audit.

| Artifact | SHA256 |
|---|---|
| supportaudit01.json | 236CFDF641ABC7FB7612EF978E83DA8B5B801B8EF92E46B6DCCDA0419E183B74 |
| supportaudit01.log | 94EDE24940877A68B204DF4F9E79768D3A7DCBDF5BCCD3EA6808381CECF678F6 |
| AuditRawStateSupport.olean | 02CB2511316CB5DD407488C5D83DB35C4AF8705BDAA801BF094A0EE72BF3D2B3 |

Concrete full-trace acceptance remains outside this review. The probe establishes the axiom status of the checker/source support; it does not prove that any separately proposed full literal trace satisfies the checker, and it establishes no timing result for that separate task.
