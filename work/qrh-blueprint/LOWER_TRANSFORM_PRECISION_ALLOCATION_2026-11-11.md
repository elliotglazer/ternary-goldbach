# Lower transform precision with the complete window error retained

2026-11-11. Root-authored paper derivation and exact rational scalar checks only. No function, transform, kernel, sign, zero or prime values, proof emission, declarations or builds. This is an immutable successor to the reviewed stability allocation, not a change to its bytes. Independent review is required before adoption.

Keeping all its non-transform producer tolerances, p108 suffices for a complete m41 interpolation radius below 0.653052762*2^-45. This is stronger than the previous (691/1024)*2^-45 bound at p112. A separate p106 candidate gives a radius below 0.837311263*2^-45. Neither result selects production precision or proves any actual sign.

## Inputs and unchanged mathematical scope

The accepted stability author is agents/audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md, SHA256 6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA. Its independent review is agents/major-constants/REVIEW_LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md, SHA256 3D8831ABB2BBD69A1AD82389B8A2082DBCE18D5E6C47E73230F6808F0EBFF589. Here and below agents means work/qrh-campaign/agents.

Retain actual endpoint-normalized Y, primitive nonprincipal characters with conductor at most 265800, h=159/500, m=41, Delta=5/64 and all retained sample heights in [-7000,7000]. The exact kernel absolute-sum is below 5, completion magnitude below 27, actual |L| below 4032 and actual |Y| below 108864. These are the reviewed function bounds. The interpolated object is not the coarse sign proxy.

The reviewed shorter-window certificate supplies the sharper analytic allowance

    T = (927193523/10^9)*2^-46.

Its author/review pins are 32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E and 61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730. The simpler allowance 2^-46 remains useful for a comparison that does not spend this extra reserve.

## The intrinsic error theorem applies below p112

The accepted transform model DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C has a parameter p, with

    epsilon(p) = C_T*2^-p,
    C_T = 1266*202305920*2^14 = 4196258524692480.

The previous p112 choice followed the additional allocation epsilon<=2^-60. It was not a lower validity threshold for the circuit theorem. Its sufficient safety conditions are

    2^p >= 29961461170177,
    2^p >= 2*424706204.

Both hold for p>=100. Grid100 source centers embed exactly for those p. The stored-input magnitude condition M+1<=2^14 remains mandatory, together with every root, kernel, arithmetic and normalization hypothesis of the theorem.

The normalized Bluestein author FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9 and independent review 09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA preserve the old error/safety constants for their newly rounded scaled cache. Thus the same epsilon bound is available conditionally for that circuit. Its rounded cache, exact cached sums and compatible centers must be produced for the new p; neither old signs nor cached numerical centers are transferred by this statement.

## Re-establish the magnitude bounds before the error composition

Keep full conductor-scaled alpha error below 2^-82. Keep head H, new assembly J and final scale rounding each at most 2^-63. Keep conductor-factor error at most 2^-84. The comparison before approximating the conductor factor has radius

    2^-82 + 2*2^-63 + epsilon(p) < 1

for p>=100. Since sqrt(c)<516 and |L|<4032, this proves |Shat|<516*4033<2^21 without using the final scale error. It is a final-center bound, not an internal FFT-buffer bound.

Consequently a sufficient final L radius is

    rL(p) = epsilon(p) + 2^-82 + 4*2^-63.       (1)

This is below 1 for p>=100, so |Lhat|<4033<2^12. The four 2^-63 terms are head, assembly, factor error times the stored-transform magnitude, and final scale rounding. The alpha term already contains source/shift/evaluation contributions once.

Keep the actual completion-multiplier error at most 2^-66 and direct sample formation error at most 2^-54. The previous component tolerances for amplitude, canonical phase, root phase, cis and multiplier arithmetic remain sufficient and unchanged. Then

    rDirect(p) = 27*rL(p) + 2*2^-54.           (2)

This is below 1, giving the direct stored positive sample bound |Yhat|<2^17 before that bound is used in the inverse adapter.

Keep exact inverse-character phase sign and damping in (0,1], damping error at most 2^-72 and adapter rounding at most 2^-55. The extra radius is at most 2^17*2^-72+2^-55=2*2^-55. Therefore a sufficient common sample radius is

    rY(p) = 27*rL(p) + 2*2^-54 + 2*2^-55.      (3)

It is below 1 and the adapted stored sample also has magnitude below 2^17. This replaces the previous common 2^-51 radius when p is lowered; that old intermediate bound is not silently retained.

## Complete output bounds

Keep each of the 83 interpolation kernel errors at most 2^-72 and accumulation error at most 2^-51. The latter remains achievable under the stated conditional schedule of 166 rounds each bounded by 2^-59. This is a separate producer contract, not a claim that its fractional grid is p or that any certificate already exists. Its product/partial-sum magnitude argument still uses the unchanged stored-sample cap 2^17.

The exact split K*(Y-Yhat)+(K-Khat)*Yhat yields

    R(p;T) = T + 5*rY(p) + 83*2^-55 + 2^-51.  (4)

The actual interpolation error is strictly below this upper expression because the analytic allowance is strict. Expanding (3) separates its intrinsic part as 135*C_T*2^-p. Every other summand is independent of p in this sufficient allocation. No sample/kernel cross term is omitted; it is the exact-K split already reviewed.

|p|Upward billionth bound for R(p;sharp T)/2^-45|Useful conclusion|
|---:|---:|---|
|105|1.082989264|Does not pass the 2^-45 sufficient test|
|106|0.837311263|Below 2^-45|
|107|0.714472262|Does not pass the old 0.7 target in this test|
|108|0.653052762|Below the old 691/1024 target|
|112|0.595471981|Same unchanged allocation with more intrinsic reserve|

The decimals are rational upper bounds with denominator 10^9. They are not evaluated function errors. For p108, the exact ratio in (4) is

    2804840254168152529 / 4294967296000000000
      < 653052762/10^9 < 691/1024.

Thus p108 preserves and improves the old complete-radius ceiling, with all other producer tolerances held fixed. It spends reserve that had been left unused by the separate epsilon<=2^-60 requirement and the coarser analytic tail allowance. It does not loosen the source alpha contract.

Even with the coarser T=2^-46, the sufficient test is below 2^-45 at p106 and below 0.7*2^-45 at p108. Failure at the immediately preceding p plus monotonicity establishes minimality only for each displayed scalar test on p>=100. It proves no lower bound on actual arithmetic error or on other algorithms. The sharp test is also first below 691/1024 at p108. No precision below 100 is considered with this unchanged input-embedding contract.

## Cost and proof consequences

These candidates reduce the fractional-bit parameter in the transform's arithmetic and coefficient generation. A matched saved-width repricing is a separate task. Crossing byte-capacity boundaries can make operation-count changes discontinuous. Source, head, actual completion, interpolation kernels, count integrals, public numeral bindings and setup/checking lifetimes remain paid. The ordinary-PA event core is not a checker-time model.

Actual center values change when p and its coefficient/cache objects change. A smaller proved radius does not preserve an old sign without the actual new strict center test or a proved center relation. Neither candidate establishes successful critical brackets, multiplicity, count surplus, principal RH or finite Goldbach coverage. Repair and unresolved cases remain governed by the separately reviewed policy. This paper establishes conditional lower-precision options, not a production choice or an end-to-end saving.

## Evidence

Owned script lower_transform_precision_allocation_20261111.py checks 170 exact assertions over the thirteen scalar p cases 100 through 112. It checks seven frozen source hashes, safety, ordered magnitude bounds, the error identities and threshold comparisons. It reads no event inventory and evaluates no analytic function. Its exclusive receipt lower_transform_precision_allocation_20261111.json is 9362 bytes, SHA256 2E94F2BDDCACFF7B9002C1A2241C4F485B14CD17AA436B7E211EC610CC051BF5. All predecessor artifacts are unchanged.

Independent review is pending. DRAFT_ANCHORS: none created. UNREGISTERED_SORRIES: none introduced. DRAFT_IMPORT_VIOLATIONS: no imports changed. SEALED_THIS_TURN: 0. Repository-wide state was not audited.
