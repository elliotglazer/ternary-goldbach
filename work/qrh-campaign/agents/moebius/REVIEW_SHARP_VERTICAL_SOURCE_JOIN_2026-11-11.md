# Independent review: sharp actual-smoothing vertical bounds

2026-11-11. **PASS as a paper/source join.** The selected etaU constant 900 and etaPlus constant 106000 follow with the stated domains and normalization. No substantive correction is required. No Lean proof or finite spectral certificate is claimed.

Reviewed frozen author: `zero-sum/SHARP_VERTICAL_SOURCE_JOIN_2026-11-11.md`, SHA256 `FBB5FC9E71CB2199F36331D7BB8AFE1E565A3D8C01F95E0CECF69A9D775D0AA4`. The full note and relevant source proof bodies were read. All seven author source hashes match. This review consumes the actual smoothing/Fubini join `DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D`, independently reviewed in `REVIEW_ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md`, SHA256 `D79E28D39B7289BF69D9A7BE9D1368A19960E2E113FE3FC91C724B78979C8952`.

## 1. Actual etaU and the sharp constant

The source etaU definition and the reviewed absolute-Fubini argument give, with ordinary dr measure,

    M_U(s,delta)=integral eta2(r) r^(s-1) Gr(s,delta*r,0) dr,
    1/4<=r<=1, Re(s)>-2.

The exponent is s-1, and the Gaussian Mellin argument is s, not s-1. This distinguishes etaU from etaPlus. The positive support makes the complex-power scaling unambiguous. The r integral is compactly supported away from zero; the v integral after substitution is dominated by `v^(Re(s)+1) exp(-v^2/2)`. Thus the identity is valid on the entire left line and at s=0 before any norm inequality is applied.

On the left line, the weight is exactly `r^(-3/2)`. `MajorArcs/Eta2Moments.moment_3half:176` proves its eta2 moment is at most 2.74517. The exact moment expressions `48-64/sqrt(2)` and `16(sqrt(2)-1)^2` agree. For r in the support, `thetaD(delta*r)>=thetaD(delta)`; the negative exponential reverses this comparison as required. `GrExtend.norm_G_uniform_ext:73` applies because Re(s)=-1/2 lies in its closed domain [-3/2,1]. Consequently the resulting constant is 823.551, below the retained 900.

The optional 112-source improvement is valid too: `ZeroSumBound.norm_G_uniform:40` has domain [-1,1], which includes this line. Its constant becomes 307.45904, below 308. At s=0, the different eta2 moment `moment_one:154` is at most 1.92182. Hence the retained zero-value bound 600 and optional bound 216 both follow. Neither is an assertion about a zero's multiplicity.

This argument proves the selected sharp vertical envelope directly. It does not substitute the qualitatively finite but potentially large Kdelta constant from the full-strip GoodSmoothing proof.

## 2. EtaPlus and the frequency shift

The etaPlus representation in `EtaPlusMellin.mellin_fP_eq:134` uses `Gr(s-1+2*pi*i*xi,delta,0)`. On the left line its real part is -3/2, so the 112 theorem cannot be substituted here. The existing `norm_mellin_fP_uniform:237` uses the extended 300 theorem and retains the frequency shift through `|2*pi*xi|<=200` and `200*thP<=1`.

`EtaPlusCg.cA_le:89` gives `Cg*(2*aH)<=129.24`. Multiplying by 300 and the source bound exp(1)<2.72 gives 105459.84<106000. The separate source `norm_mellin_fP_zero` gives 38772<39000. No frequency-shift factor is dropped in the vertical estimate, and none is incorrectly inserted into the zero-value estimate.

## 3. Source integrals, domain, and normalization

`ExplicitBoundGen.norm_integral_hIntG_le:32` is the correct direct primitive nonprincipal interface. It assumes primitiveness, nonprincipality, positive physical scale and an actual Mellin envelope on the left line. It has no finite-RH binder. Its proof uses the unconditional left-half-strip nonvanishing and logarithmic-derivative bound in `ExplicitFormula:253,493`, followed by exponential integrals.

The principal counterpart `norm_integral_hZeta_le_gen` begins at line 71 (the author's line 74 points within its statement). It concerns the actual zeta logarithmic derivative, with D=3. Its proof explicitly subtracts `1/(s-1)` from the zetaF logarithmic derivative. It therefore includes the required pole correction. Replacing it by the zetaF integral would change the normalization.

The source vertical estimate is `z^(-1/2)*VgL`. The explicit formula contributes `1/(2*pi)`; normalization of the additive sum contributes `1/z`. The author correctly obtains `z^(-3/2)*VgL/(2*pi)`. The retained rates are justified on their exact domains:

* Major etaPlus: actual twist delta, absolute value at most 600000, rate 4e-7 after the thP cap.
* Major star: physical scale y=x/49, actual etaU twist delta/49, rate 2e-5.
* Base-gap etaU: actual twist plus or minus u/(2q), absolute value below 600000, rate 4e-7. It is not divided by 49 again.

There is no Jacobian in this pointwise error bound. A subsequent integral in the arc coordinate has its own change-of-variable factor. The later `norm_SsumG_le_gen` theorem has a critical-line low-zero hypothesis; this review does not use that theorem to bypass the new spectral work.

## 4. Independent exact scalar checks

The independent script `review_sharp_vertical_scalars_20261111.py` passed 27 exact rational checks and all seven source hashes. SHA256 `3F931879C036D9A5B6C184C52D183DA45C5731BCE514D06B106F069D7C270BF6`. Its receipt is `review_sharp_vertical_scalars_20261111.json`, SHA256 `7A08A1CEB388300F11988094A36882C79D81DE8BE9465A1C06EF06550C59D22A`.

The DN bound uses only positive exponential-series lower bounds: exp(1)>65/24>8/3, `(8/3)^13>300001`, and `(8/3)^8>512/.355`. Thus DN<138<150. The elementary inequality log(2)>5/8 can, independently, be obtained by integrating `1/t >= 4/3-4*t/9` on [1,2], giving log(2)>=2/3>5/8. Together with pi>3 these justify the VgL and normalization comparisons without evaluating logarithms or exponentials numerically.

The exact VgL upper expressions are 27560792880000000000, 93734640000000, and 234006732000000000 for major plus, major star, and base star respectively. Their stated scale weakenings and the 1/(2*pi) factor give all three claimed small vertical allowances. Conditional on the separately supplied multiplicity bound m(0)<=400, adding 39000*m(0)/x or 600*m(0)/y stays below the author's 4e-20 or 2.8e-20 bounds, hence below the retained 1e-18. The script and this review do not prove the multiplicity bound. The principal zeta case has no zero at 0.

No analytic function evaluator was run. The initial generic `python` executable alias was unavailable; the existing interval-environment interpreter then ran only the standard-library rational/hash script. An initial source-pin regex excluded the digit in Eta2Moments and stopped before scalar checking; correcting that filename regex produced the final passing receipt. No author artifact changed.

## 5. Limits and remaining work

The selected sharp Gaussian, eta2 moment, etaPlus, and direct vertical-integral statements are unconditional at their source boundaries, and their relevant bodies support the stated derivation. Their import closures also contain conditional results. This source review is not an elaborated axiom audit or a build receipt.

The etaU mixture and integral-comparison wrappers still require Lean implementation. The full-strip admissibility and source-limit adapters remain distinct formalization tasks. The finite zero assertions, global seven-eighths provider, multiplicity input, sharp Gram estimates, nontrivial high-zero tails, and primitive-to-coprime removal are not supplied by this review. Optional constants 308 and 216 have not been substituted into any selected or frozen budget.
