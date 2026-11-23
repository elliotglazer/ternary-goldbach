# Independent review of shorter large-branch windows

2026-11-11. PASS at the conditional analytic-certificate scope, with no correction. The candidate h=159/500, m=41 has uniform analytic interpolation error below `(927193523/10^9)*2^-46` for the stated family and target range. The result replaces only the analytic-tail part of the existing contract. It produces no samples, kernels, signs, production inventory or runtime claim.

Reviewed author: `audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md`, SHA256 `32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E`. Its script `7C51A4655CE47873A3352BB8BE74EE9FB8A371A4F38365A1CFFA91564C005FA4` and receipt `745A2EF89CF23580562D76DDAD5D4C6EB57CC4F1C4FA50329148021745953A41` match. Paths are relative to `work/qrh-campaign/agents`.

I read the complete successor and its scalar program. This review reuses the source and continuum proof in the frozen baseline DA67CB3B, reviewed at `873F9A0A15D77D5F90032139F42B29329F812C370FD122716504A207E6828AEF`. The primitive nonprincipal restriction, actual endpoint-normalized Y, c<=265800, 0<=t0<=7000, fixed root phase, Delta=5/64 and B=32/5 are unchanged. The new h is inserted in BOTH Fourier and sample bounds. No strict-tilt argument is used at eta=1.

## 1. New uniform constants

The Machin identity and alternating arctangent remainder prove 157/50<pi<22/7. I independently used twelve terms followed by the thirteenth at both rational arguments, instead of the author's ten/three-term pair. The resulting rational enclosure has the required endpoints. This is a symbolic elementary-series certificate, not an arctangent evaluation; the Machin identity and alternating-series theorem remain mathematical inputs for formalization.

The exact fourth-power comparisons justify the conductor-power bounds 5000 and 1500000 in the odd/even Fourier estimates. The sixteenth-power comparison gives `(c/(2pi))^(5/16)<28` throughout the conductor range. Positivity is essential when passing from these integer-power inequalities to the fractional powers and is present here.

The zeta bounds follow from the decreasing-series integral test. I independently used five terms for zeta(2) and three for zeta(3), obtaining bounds below 5/3 and 5/4. The old zeta(9/8)<=9 remains valid. None requires a numerical zeta value.

For the first Gamma expression in Platt Lemma 6.3, the three rational-power witnesses give a constant below `(6/5)*(9/5)*(5/4)=27/10`. For the second, sqrt(2pi)<18/7, pi/8+1/4<3/4, and e<3 imply exp(pi/8+1/4)<7/3 by the fourth-power witness. Its constant is strictly below 6. Multiplying the larger constant by `(3/2+|t|)^(1/4)>1` bounds both branches, including negative t.

Combining Gamma6, zeta9 and conductor28 gives the all-real envelope `1512*(2+|t|)`. This is a uniform family bound; it need not improve the old conductor-specific expression for every very small conductor. It is a valid and much smaller replacement for the old maximum-family prefactor in this scalar certificate. It uses no RH or actual magnitude information.

The separate square comparisons imply `1/sqrt(2pi)<2/5` and `1/(2sqrt(2))<5/14`. Therefore

    P_h=h*(22/7)*(7000+(2/5)h+1+5/14)

upper-bounds the source Gamma integral for every target in the range. No target-dependent quantity is silently held fixed while h changes.

## 2. Rational exponential certificate and continuum domains

For positive x, the finite positive sum `P24(x/16)` is strictly below exp(x/16). Hence `P24(x/16)^(-16)` is a strict upper bound for exp(-x). An exponential upper remainder is not needed in this direction. The reciprocal and exponentiation preserve the required inequality because the sum is positive.

For each candidate and parity, I checked positivity of `2*pi_L*B*M-M^2/(2h^2)` and used it in the Fourier factor. Both parities are computed; the uniform bound is their maximum. The reciprocal pi factor uses pi_L and the positive Gamma-integral factor uses pi_U, so the directions agree.

The source sample-tail proof remains valid for off-grid targets and t0=0. With z=mDelta, the condition `z*(2+z)>=h^2` implies the decreasing-envelope condition for every A=2+t0. The ratio factor is largest when A=2, while the numerator envelope is bounded by its value at t0=7000. Taking those endpoints separately is conservative. The rational exponential upper bound only increases the ratio, and every tested ratio is below one. Thus the denominator 1-r is positive and the resulting geometric bound is valid uniformly, not just at a sampled target height.

The new formula uses 3024 for its two sides, exactly twice the new all-real envelope coefficient. It retains the complete Gaussian h dependence in both the first omitted sample and the ratio. The old derivative condition, lattice distances and the two-sided off-grid enumeration are not replaced by a grid-center assumption.

## 3. Independent bounded replay and main certificate

I replayed all 101*29=2929 declared pairs using an independently written Horner evaluation of the Taylor polynomial. The author program was neither imported nor executed. The replay matches every saved minimum-m row, every upward billionth projection, all five m=41 rows and all separately named candidates. There are 1646 passing pair tests in this bounded sufficient test.

The smallest passing m is 41, with exactly these h values at that m: 79/250, 317/1000, 159/500, 319/1000 and 8/25. This is a property of the declared certificate and grid only. Failure of the upper-bound test supplies no lower bound on actual interpolation error, and the replay does not establish global optimality.

For an additional check independent of the author's scaled polynomial, I used the reciprocal of the direct degree-192 positive Taylor polynomial at x itself. This separately certifies the main pair and three useful alternatives. It gives the same displayed upward ratios:

|h|m|Samples|Fourier ratio upper|Sample ratio upper|Total ratio upper|
|---|---:|---:|---:|---:|---:|
|159/500|41|83|.776087317|.151106206|.927193523|
|8/25|41|83|.679873933|.285144210|.965018142|
|13/40|42|85|.493721360|.119845551|.613566911|
|1/3|48|97|.299286713|.000000528|.299287241|

All ratios in the table are upper rational bounds with denominator 10^9, relative to 2^-46. Each total is rounded separately from the exact sum. Separate rounded components need not sum to the displayed rounded total. The main pair leaves more than `(72806477/10^9)*2^-46` within that analytic budget. It is therefore stronger than both 2^-46 and the baseline `2^-46+2^-243` allowance.

This remains a bound near 2^-46, not a full 2^-82 evaluator. A smaller stencil does not by itself repair that different precision requirement.

## 4. Guards, circuit counts and numerical radius

For m=41, the finite set is exactly `[floor(t0/Delta)-41, floor(t0/Delta)+41]`, containing 83 samples. A direct nonempty accumulation uses 83 kernel products and 82 additions. The old m=256 stencil used 513 and 512, so the local count difference is 430 product terms and 430 additions. These are unpriced operations in a declared direct schedule. They exclude kernel production, widths, proof work, source samples and cross-target sharing.

The conservative distance guard is 42Delta=105/32. At the current maximum target the corresponding upper coordinate is 424405/64, below 7000. At t0=0 the actual lowest sample is -205/64. These statements do not generate any guard sample. The dependency union for actual targets, its available positive-height indices and its cost must still be checked. Targets close to the analytic cap7000 still need an extended source domain or another evaluator.

Negative samples retain the exact identity

    Y_chi(-u)=kappa*exp(-pi*u/2)*Y_(chi inverse)(u).

The compatible fixed root-phase sign, inverse channel, central convention, positive damping enclosure and multiplication error remain required. Neither a same-character positive sample nor its old radius can be copied without this conversion.

Changing h changes the kernels and their cache keys. The complete numerical radius remains

    F+S+e_acc+sum_n[(|Khat_n|+rK_n)*rY_n+|Yhat_n|*rK_n].

Source, head, transform, completion and phase errors enter each actual sample radius once. New kernel and finite-arithmetic bounds must be supplied for the selected h. No old arithmetic allowance, sample-error sum or integer-width schedule is inherited merely from the analytic comparison. Strict signs and Turing completeness still require their own evidence.

## 5. Frozen evidence and verdict

Own script `major-constants/review_shorter_large_branch_windows_20261111.py`, SHA256 `97FA6C90622FC48A655ED4C4B189BAC2783448A0E2E39885364B1C8EE2E0F296`; receipt `review_shorter_large_branch_windows_20261111.json`, SHA256 `11094102E1030431EBAC75369758669C5FDF77A82E5D3BFE2E282930A3B9F239`. All 11992 exact assertions pass. The receipt records the bounded-search status digest, all saved minimum rows, the independent direct-Taylor certificates and exact guard coordinates.

All five successor/predecessor pins match. Primary analytic hypotheses and formalization leaves remain those of the accepted source review. No frozen file was modified. PASS without correction for modular substitution of the analytic-tail certificate; no numerical production, sign success, global inventory, optimum or runtime adoption follows.
