# Independent review of the lower transform precision allocation

2026-11-11. PASS at conditional mathematical and exact-scalar scope, without correction. The p108 candidate preserves a stronger complete output-radius ceiling than the former p112 allocation. The p106 candidate meets the separate radius target 2^-45. Neither is selected for production, and neither supplies a sign or count certificate.

Reviewed author: `work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md`, SHA256 `EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39`. Author scalar script: `8D629DE9D0F6969BD2B4E4541761E2B01EE937E2E2CB5D491C479EDE4EA98945`. Author receipt: `2E94F2BDDCACFF7B9002C1A2241C4F485B14CD17AA436B7E211EC610CC051BF5`.

I read the full author and scalar source, the accepted stability and shorter-window packets and reviews, and the normalized-cache proof and context interface. I did not execute or import the author's script. Independent exact rational arithmetic checked all thirteen saved precision rows and the threshold comparisons. No function, coefficient, root, kernel, transform, sign, zero or prime value was produced. No inventory, build, declaration or proof emission occurred.

## Error composition and ordered magnitude bounds

The scope is unchanged: actual endpoint-normalized Y for primitive nonprincipal characters of conductor at most 265800, h=159/500, m=41, Delta=5/64, and every retained sample in [-7000,7000]. The shorter-window certificate bounds the analytic error by `(927193523/10^9)*2^-46`. Its independent review explicitly verifies this rational upper bound. The stability proof separately supplies exact kernel l1 norm below 5, completion magnitude below 27, |L|<4032 and |Y|<108864. No sign-equivalent proxy replaces Y.

The intrinsic coefficient is `C_T=4196258524692480`. The theorem is parameterized by p; its former p112 example met the additional allocation 2^-60. That example does not limit the theorem to p>=112. The inherited safety requirements already hold at p100 and remain true above it. Grid100 centers embed exactly at those precisions, provided the implementation checks the embedding and the actual stored-input bound M+1<=2^14. Input uncertainty remains unchanged by that exact embedding.

For every p>=100, the pre-scale discrepancy

    epsilon(p) + 2^-82 + 2*2^-63

is below one. This proves the final stored transform bound |Shat|<516*4033<2^21 before using the approximate conductor factor. Its contribution to scale error is at most 2^21*2^-84=2^-63. Thus

    rL = epsilon(p) + 2^-82 + 4*2^-63 < 1,

and |Lhat|<4033<4096. The four terms retain head, new assembly, scale-factor error and scale formation. The alpha allowance already includes its full source/shift/evaluation budget and is charged once. This is not an internal FFT-buffer bound.

The actual completion multiplier has error at most 2^-66, so multiplication by |Lhat|<4096 contributes at most 2^-54. Direct sample formation contributes another 2^-54. Hence

    rDirect = 27*rL + 2*2^-54 < 1.

This first proves the direct stored magnitude below 2^17. Only then is it used in the inverse-character adapter. Exact attenuation is at most one; its enclosure error and formation error contribute `2^17*2^-72+2^-55=2*2^-55`. The common radius is therefore

    rY = 27*rL + 2*2^-54 + 2*2^-55 < 1.

The adapted stored magnitude is also below 2^17. This ordering avoids circular magnitude assumptions. The old intermediate radius 2^-51 is replaced, not silently reused. All actual phase, amplitude, damping and formation tolerances remain as before.

The exact split `K*(Y-Yhat)+(K-Khat)*Yhat` then gives

    R = T + 5*rY + 83*2^-55 + 2^-51.

The kernel-error term uses the independently proved stored-sample magnitude. It omits no cross term. The 166-round accumulation contract, its product cap below 2^18 and partial-sum cap below 2^20 remain sufficient. These arithmetic tolerances and widths are separate from the transform grid p.

## Exact thresholds

An independent expansion in units of 2^-45 gives

    R/2^-45 = T/2^-45 + 135*C_T*2^(45-p)
       + 135/2^37 + 540/2^18 + 15/512 + 83/1024 + 1/64.

This expression matches every author receipt row. With the sharper T, the p108 ratio is exactly

    2804840254168152529 / 4294967296000000000
      < 653052762/10^9 < 691/1024.

At p106 the ratio is below 837311263/10^9<1. The immediately preceding rows fail the respective sufficient tests. The positive intrinsic term halves at each increment of p, so these adjacent comparisons establish the stated minima on p>=100. With the coarser T=2^-46, the first passing precisions remain p106 for 2^-45 and p108 for 0.7*2^-45. With the sharper T, p108 is first below the old 691/1024 ceiling.

The minima concern these particular upper-bound tests. Failure of a test does not lower-bound true error or rule out a better analysis, evaluator or precision allocation.

## Normalized cache and implementation limits

The normalized Bluestein proof `FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9` and independent review `09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA` prove the unchanged local C_old/D_old contract for the newly rounded scaled cache under the old safety conditions. CT and product-axis composition can therefore retain the same global intrinsic bound. The proof is not restricted to its illustrative p112/134/152 cost rows.

This compatibility requires the actual rounded cache and its error, newly bound exact cached coefficient sums, roots/chirps and runtime arithmetic at the chosen p. The unnormalized outer transform and character labels stay fixed. Moving the internal inverse normalization into a cache does not introduce a new outer scale. Cache construction, rounding and lifetime costs remain charged. The context supplement `412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7` preserves the needed semantic peak conditions and does not authorize subtracting bits from unrelated old histograms.

Changing precision or cache representation changes centers. Actual strict signs must be checked again, or transferred through a proved center relation. Completion, interpolation, count integration, source and head work do not become cheaper merely because transform p is smaller. Byte-width repricing and full producer/checker costs remain separate. The review establishes no successful brackets, multiplicity, Turing surplus, principal certificate, finite Goldbach coverage or runtime improvement.

## Independent evidence

The new exact receipt is `work/qrh-campaign/agents/zero-sum/review_lower_transform_precision_allocation_20261111.json`, SHA256 `0CF8103058C0BA9F14F8C2B7B33D08D3DD6A7960D59D3685C45FE41E42FF066F`. Its 216 checks cover eleven input hashes, every saved scalar row, independently expanded radii, ordered magnitude bounds, safety, strict rational ceilings, monotonicity, thresholds and unchanged accumulation capacities. It was produced by a bounded inline integer/Fraction calculation, with no author execution and no analytic evaluator. The receipt records all source pins and check names. Frozen predecessors remain unchanged.
