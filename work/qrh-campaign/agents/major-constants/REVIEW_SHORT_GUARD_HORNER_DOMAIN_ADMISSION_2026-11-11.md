# Independent review: shortened Horner on the added guard domain

2026-11-11. **PASS at the conditional paper/source and exact-rational scope; no correction required.** This review binds root's `work/qrh-blueprint/SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md`, SHA256 `6DF38245BECCD8A35B94F98787C4DEF64EEB9EFCF9FB07E54E1D9EC554C48DF2`. It accepts the new alpha-domain admission, not generated guard samples, signs, completeness, a chosen arithmetic backend, or a runtime claim.

I read the frozen author, its script and receipt, and the relevant inherited source interfaces. The independent checker imports no author program. It reconstructs only the six requested rational cases and verifies eleven input pins. No height or conductor enumeration, coefficient/function evaluation, proof emission, build, or frozen-file mutation occurred.

## Endpoint and source contract

The reviewed sample-guard ledger, section 1 and its endpoint table, fixes the old target intervals rather than extending them recursively. With `Delta=5/64`, the largest old index is 84839. An 83-sample window at `k=floor(t/Delta)` needs indices `k-41,...,k+41`. At the closed old upper endpoint the largest dependency is therefore 84880, at height `26525/4`. This equals `424195/64+41*Delta` and is strictly below 7000. The conservative distance bound 42 Delta does not require index 84881. At the lower endpoint the negative indices stop at -41; their absolute heights are already in every inverse-character positive prefix. The actual phase/attenuation adapter and its numerical errors remain separate.

The shorter-output source, `SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md`, sections 1–3 (lines 7–105), proves the target remainder by real Taylor expansion of the continued Hurwitz function. Its Kth derivative is bounded using the absolutely convergent shifted series at real part K+1/2. Thus it applies to both signs of height and clipped real endpoints, with exact nearest displacement at most `1/(4D_out)`. It is not termwise differentiation of the critical-line series.

For the final band the source still has `V=7000`, `D_source=4096`, `P=28`, `N=1500`, correction count 159, and `D_out=8192`. Its actual finite translations and all twenty output slots are retained. The shortened polynomial consumes a prefix of the finite translated polynomial, not an asserted vector of exact fine derivatives. Summing fewer nonnegative terms preserves the existing analytic shift bound and the numerical delivered-vector allowance. This supplies exactly

    S = 1266*(5*7028/(8*4096))^28/28!,
    N = 844*2^-100.

Only the genuine target Taylor term uses the new target cap. This is the necessary fresh admission beyond the previous actual-height theorem. Merely observing that the source cap is 7000 would not have admitted K18/94 throughout that cap.

## Independent error reconstruction

For the fixed degree-grid shape, I computed the evaluation error backwards: the initial error is the top coefficient's nearest-grid error `e_(K-1)=(3/4)2^-b_(K-1)`; each lower stage sends `E` to `E/4+2e_j`, paying its coefficient conversion and single rounded displacement product. The coefficient addition is exact. This independently yields the author's weighted sum and does not invent a rounded top multiplication.

I computed the Taylor expressions by successive multiplication by `x/k`, rather than running the author's power/factorial code. The full tested quantity is

    alpha(V) = 1266*((V+K)/(4*8192))^K/K! + S + N + 633*E.

The previous generic `1688*2^-100` evaluation allowance is replaced once by `633E`. It is neither retained in N nor silently discarded elsewhere. The 633 character-sum amplification is inherited. Exact rational h remains an input contract; an approximate displacement is not covered without an additional error.

All six saved fractions and all outward billionth bounds match:

| Candidate | Old cap 424195/64 | Guard cap 26525/4 | Declared cap 7000 |
|---|---:|---:|---:|
| K18, b0=94 | <0.858600152 | <0.861409838 | <1.395647229 |
| K19, b0=93 | <0.939289215 | <0.939320968 | <0.945552042 |

Entries are alpha divided by `2^-82`. Each guard result is strictly below one. For fixed K and grids, S, N and E are constant and `(V+K)^K` is increasing for V nonnegative. The endpoint check therefore covers the full real-height domain in the final-band source interface, including negative heights via absolute value. K18/94 fails this sufficient full-7000 test; this is not a lower bound on actual error.

## Unchanged magnitudes, per-instance costs and output interface

The stored-degree source, `STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md`, lines 11–31, 47–69 and 90–113, bounds the actual finite translated centers at source cap 7000, including their numerical error. The final shifts have absolute source displacement at most 1/2 and include the `2^-k` output postscale. Positive-degree envelopes are `(15/2)(7/8)^k/k!+eta`; degree zero uses the separate finite-EM bound. None of these bounds depends on reducing the target cap from 7000 to either the old or new restricted maximum.

The accepted joint-Horner source, sections 4–6 and its two-candidate table, already rebinds converted coefficients and accumulators for the actual grids, including grids below 70. The older stored-source table's separate `b>=70` accumulator claim is not being reused there. For each unchanged candidate, the recurrences `C_j=Z_j+e_j`, `A_top=C_top`, `T_j=A_(j+1)/4+e_j`, `A_j=C_j+T_j` are identical. The same per-instance integer capacities and reviewed arithmetic-template schedules consequently remain sufficient on the new target domain.

I checked the quoted inherited subtotals against that source: K18/94 has 8932 product and 2420 addition template events; K19/93 has 8858 and 2448. The difference is 74 fewer product events but 28 more addition events for K19. This review does not reprice the templates or infer a method winner. Candidate-specific conversions, signed and range bridges, alignment shifts, cache/representation work and source production remain charged separately. New guard instances must still be produced and counted by their actual band.

The exact grid100 export shifts are six and seven bits respectively, with inherited 114-bit signed export capacity. They add no numerical error, but still require their range and representation bindings. Neither export restores earlier numerical centers or sign margins. Later transform-grid embedding is conditional on its own exact adapter. The first four source bands retain their own admitted evaluators; the final-band proof does not relabel all guards as final-band work.

## Frozen evidence and limits

Independent script: `review_short_guard_horner_domain_20261111.py`, SHA256 `C8D85550851FF239720AAEC5229497CBD1616AA8DC2E86484499CE241B2C4BAD`.

Independent receipt: `review_short_guard_horner_domain_20261111.json`, SHA256 `D0C1B79ABD4793D3C4102FF9C38CB65FEC0866251C97D0848DBB9B418B1CE49B`. Its **73 exact assertions** verify the endpoint, six complete compositions, strict outward rounding, admissions, source pins and basic inherited subtotal differences. All eleven full source hashes are recorded there. The two per-evaluation cost schedules are inherited from the independently reviewed joint packet, not regenerated by this bounded review.

The root script is pinned `750C046F8B5B79D78E0A3263DC39C642F99AAB6802838002E86DAA87C71FA28B`; its receipt is pinned `C8EA9BEC79CB00DBDCB3FB14D8C00F142592737D3300267CE29F89F2C5BE01B2`. The joint-Horner author/review pins are `AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63` / `84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7`. The guard author/review pins are `3E447AE8E8EEEC847E95CFB7473879EB2B56CFC5E467863404D3ECDBB0180606` / `15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA`.

This closes the stated conditional alpha-domain extension. All source-generation, transform, head, conductor-scale, completion, kernel, interpolation, sign and completeness obligations remain. No new global operation total or precision selection follows from this review.
