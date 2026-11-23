# Review of minimal integer theta at the fixed theta128 length

2026-11-11. PASS at conditional parameter, error-allocation and exact metadata scope, with the mandatory frozen bucket-rounding clarification. The original report alone contains an incorrect exact-accumulation sentence. It must be read with the correction below. No further correction is requested.

## Bound artifacts

All paths below are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
|prime-estimates/MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md|73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A|
|prime-estimates/CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md|4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41|
|prime-estimates/small_family_minimal_theta_20261111.py|0B0656A46461D397B9A459BEFEFC9686640FDCBC4EA5C6CD73E19BB2C3B1C5E0|
|prime-estimates/small_family_minimal_theta_20261111.json|25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422|
|prime-estimates/WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md|74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE|
|audit/REVIEW_WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md|34FB45C1CEBFF34A49C7C450BF1C78223593AB188EFEFC7C3EE7FE7658CB0AFE|
|prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md|6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043|

I read the full new report, correction and script, and checked the relevant inherited backend error allocation and whole-family accounting. This review reuses the earlier analytic normalization review. It does not assert a fresh proof of every inherited analytic theorem.

## Independent finite check

The owned `audit/review_minimal_theta_20261111.py` uses exact integers and fractions only and imports no author program. It independently reconstructs primitive even and odd label counts by divisor inversion of ordinary character counts, rather than using the author's primitive-count product and exceptional-channel list. It reconstructs CRT dimensions, exact height and grid ceilings, all 130 cohort/theta parameter sets, and all 29,996 choices. It checks all earlier candidate integers when asserting minimality.

The final receipt records 810998 passing checks. Every reported K and L satisfies its strict inequality and fails at its predecessor. For every theta from 64 through 128, both cohorts satisfy the X=10 bound, the complete Gaussian-tail inequality at n0=8192, seed rounding, prefactor and elementary-circuit safety conditions. This is not interpolation from theta64 and theta128.

The family remains 7499 conductors and 18477108 primitive labels. The independently reconstructed parity dimensions give exactly the inherited one-parity cases c=3,4,12. The selected height H and outer grid ceiling are distinct. With m=ceil(64H/5)+e, the final closed grid retains m+1 outputs and reaches at least H+5e/64. No endpoint or inverse-character channel is removed.

For every row, the least admitted theta gives exactly N128, not just a smaller upper bound. The frequency count, Gaussian work envelope and time-transform length therefore agree with the old theta128 schedule. The main theta64/intermediate/theta128 counts are 3876/3613/10; the other scenarios are 3866/3624/9, 3853/3637/9 and 3830/3658/11. The whole choice lists and histograms match, not merely these totals. V>=2theta, 1<=cV/theta<=Wbar, frequency support below N/2 and m+1<=N all hold.

I reproduced all eight local tolerance comparisons, their fractional-bit ranges and the reported weighted precision differences. The six displayed work totals match the previous theta128 receipt. I also separately reproduced rounded bucket counts, initial Gaussian seed contractions, and both main and Gauss-transform Bluestein inverse-scale counts. The remaining inherited categories depend on the same conductor, axes, parities and N/R/T dimensions. None is dropped by choosing theta per conductor.

## Required bucket correction and other allocations

The original section 3 says the bucket accumulation remains exact. The backend's lines 133–145 instead require per-addition complex norm error at most

`epsilon/(32*C*Bpref*n0)`.

The whole-family inventory's line 84 charges hT rounded additions. Its main theta128 aggregate is 7969016316193. The clarification restores precisely this requirement and this work, without changing the frozen parameter results.

At a fixed parity and frequency, at most n0 summands occur. Thus accumulated rounding contributes at most epsilon/(32*C*Bpref) in the input l1 norm. Gaussian term errors contribute another such amount. A unit-modulus character matrix sends this input error to at most its l1 norm in each output; no extra phi(c) factor is necessary. Intrinsic FFT, prefactor and final-round errors are charged separately.

Since C, Bpref and n0 are fixed, the selected bucket tolerance divided by the old tolerance is exactly 3^(128-theta)>=1. The author correctly distinguishes this extra paper comparison from its eight executed tolerance comparisons. My independent receipt additionally checks that bucket tolerance for every row. It also checks the inherited prefactor, final-coefficient and time-output rounding allowances, and the omega approximation tolerance. The last uses the actual selected Wbar and fixed N, not just the epsilon ratio. The final Y rounding allowance tau/4 is unchanged.

Changing theta changes the tilt, coefficient values and positive scale. The inherited identity still targets the same normalized Hardy Y at the same heights. It does not permit reuse of old approximate coefficients. The final positive-scale allowance alone can tighten as Wbar changes; the complete recurrence tolerance ds, including the factor 3^theta, is the quantity checked here. The actual circuit and its remaining magnitude hypotheses must still be supplied.

## Meaning of the efficiency result

The result is a componentwise relaxation of specified local fractional tolerances at unchanged nominal loop counts. It does not prove minimal total precision, minimum proof size or runtime. Equal N does not imply equal numerical operands, range-reduction work or elementary proof cost. Weighted bit differences are descriptive totals, not bit-operation counts.

A shared root or kernel cache must satisfy all consumers. It may remain at the finest requested tolerance even when most local requests relax. Some rows still use theta128, so the maximum Gaussian seed requirement remains 404 fractional bits. No reduction of the principal or large-conductor problem, shared spectral heights, auxiliary success requirement, or actual zero-count evidence follows.

## Independent evidence and remaining gates

| Artifact | SHA256 |
|---|---|
|audit/review_minimal_theta_20261111.py|5859746E095CFA2F0CC495457E9B2DB5FCA24745F5E24531953E32A92CE157B2|
|audit/review_minimal_theta_final_20261111.json|77D58576F18B7ED72FBA3F407FBBF6010DA46A7A02F799882F7B0D2A1F30806F|

The earlier unqualified preliminary receipt is retained but is not the final evidence bound here. The final receipt binds the correction and backend explicitly. No analytic values, transforms, signs, builds or Lean/MM0 declarations were generated. Actual arithmetic certificates, accepted analytic interfaces, phase and real-zero handling, successful signs and complete closed counts remain open. The final Goldbach statement and its original binary-input condition are unchanged.
