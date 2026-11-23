# Independent review of full P20 magnitude below grid70

2026-11-11. PASS at conditional source/paper and fixed-rational scope. No correction requested. The companion extends the full-P20 magnitude bound to coefficient grids at least60 and separately admits the specified full20-term fixed shape with b0=94. It does not admit arbitrary grid60 accuracy, a shorter-output profile, any assignment or any price change.

The frozen author is `independent-feasibility/FULL_P20_GRID60_MAGNITUDE_SCOPE_COMPANION_2026-11-11.md`, SHA256 `FE52146FBF51009631A9E232492A141053B9936AA90EB1B4017FE7A8D0021A5E`. Its script and receipt pins, and the independent check evidence, appear below. All paths are relative to `work/qrh-campaign/agents` unless marked blueprint.

## Source and evaluator identity

I read the full companion, its scalar source and small receipt; the5691 magnitude author/review; the stored-degree formulas; the joint Horner author/review; the shorter-output target and finite-shift argument; and the separate short-guard admission. I imported or executed no author program. No inventory, coefficient or analytic value was read or evaluated. No builds, declarations or proof emission occurred.

The actual objects are the delivered finite translated coarse-polynomial centers, including their source and translation arithmetic errors. They are not exact fine-anchor derivatives. The first four bands retain P27 and the existing rightmost unshifted P20 endpoint. The final band retains sourceD4096/N1500/P28/m159, the admitted signed quarter shifts, and the2^-j postscale to output normalization8192. The analytic finite-shift bias remains a separate term in the actual-function error, not another perturbation to add to the already specified stored vector's magnitude.

The chosen full profile has twenty grids

```text
[94,94,94,94,91,89,89,89,83,81,
 81,81,75,73,73,73,65,65,65,65].
```

It converts each original stored coefficient directly, copies the converted top coefficient, and applies nineteen rounded real-displacement products followed by exact additions. It does not first round every coefficient to grid100. The displacement is exact with absolute value at most1/4, including tie endpoints and clipped endpoint cells. The profile's top is degree19; no K18 or K19 substitution occurs.

## Fresh magnitude proof for grids at least60

For nearest coordinate rounding, the squared complex error is at most one half of an ulp squared, strictly below nine sixteenths. Thus e_j=(3/4)2^-b_j is a valid strict Euclidean error at every integer b_j. This elementary fact does not require the older b>=70 magnitude table.

For any full20-term profile with b_j>=60, the actual recurrence is

```text
A19=Z19+e19,
Aj=Zj+2ej+A_(j+1)/4, j=18,...,0.
```

Its expansion counts twenty conversions and nineteen product rounds. The top error has multiplicity one; every lower error has multiplicity two. Hence the rounding contribution is strictly below `(8/3)*(3/4)*2^-60=2^-59`. Exact additions and exact output re-encoding add no numerical error. This magnitude statement does not require a monotone grid sequence, although a concrete arithmetic schedule and capacities must be supplied for the chosen sequence.

I reconstructed the stored Z_j envelopes independently from their rational source formulas and evaluated the backward magnitude recurrence with e60. In the first-four class the weighted numerical contribution is at most20W. The ideal positive-degree contribution is bounded by6 times the rational factorial majorant at5/16 minus its constant term. In the final class the numerical sum is below4eta/3 and the ideal positive-degree contribution uses15/2 times that majorant at7/32. The actual final output postscale is essential to the latter argument.

Including R=2^-116 and every displayed numerical term gives strict A0 bounds10345/2 and9027/2. The finite head has magnitude below516 before its separately certified pointwise center error at most1. Exact assembly, one admitted p80..108 regrid and the augmented1 therefore preserve uniform5691 and final-source-only5032. These conclusions retain the actual head grid and radius premises. A transformed head-error bound with cancellation would not establish individual center radii.

The generic magnitude extension is not an alpha-admission theorem for arbitrary b>=60. Nor does it automatically extend old raw-stage signed capacities or old cost tables below their stated grid range.

## Full20-term alpha admission at grid94

I computed the chosen profile's error by a backward error recurrence, independently of the author's direct weighted sum. It equals

```text
E20=(5253/2048)*2^-94.
```

The complete admission is `T20+S_class+N_class+633E20<2^-82`, with the actual output normalization in T20 and the unchanged source allowances. The target remainder follows the continued-Hurwitz Taylor theorem at K=20, with the derivative bounded in its absolutely convergent half-plane. It is not termwise critical-line differentiation.

The retained first numerical allowance is2532eta+633*330u_T and the final one844eta. The old evaluation allowance1688u_H is replaced once by633E20. Final source arithmetic already includes its finite-shift rounding; the separate analytic finite-shift bound is still paid. The source final S/N use declared7000/source4096 even at the smaller guard endpoint.

All six independently reconstructed exact ratios agree with the small author receipt. These strict rational upper bounds are each less than one:

|Domain|Upper bound for alpha/2^-82|
|---|---:|
|Band1, V500/D512|508377937/10^9|
|Band2, V1000/D1024|507373628/10^9|
|Band3, V2000/D2048|506995138/10^9|
|Band4, V5000/D4096|639053705/10^9|
|Final declared, V7000/D8192|541815709/10^9|
|Final guard, V26525/4/D8192|541746822/10^9|

For a fixed profile, only the positive target term increases with the absolute height. Each endpoint therefore covers the continuum below it within its actual source band, including negative heights and zero. Guard requests must still use the appropriate band. No height sampling or new profile search is involved.

The separate short-guard paper6DF38245 admitted K18/b94 and K19/b93. It does not alone prove the K20 statement reviewed here. The present conclusion follows from the general source inequality and the six new fixed substitutions, including the full declared7000 case.

## Exact export and remaining obligations

Because b0=94, export to grid100 multiplies the integer numerator by64 without changing the value. More generally b0<=100 permits the corresponding exact shift. This does not restore the old grid100 computation or improve accuracy. Shift, sign/zero/range, representation and consumer identity proofs remain required. All source production still delivers twenty slots through its original P27/P28 schedules.

The accepted result supplies full P20 error/magnitude compatibility for this one fixed profile. It changes no frozen combined assignment, price baseline, source generation, numerical input or sign. A future smaller degree-zero producer must join its own actual stored-vector bound; it cannot use this review as evidence for an unproved EM bound. Other profiles need their own complete alpha admission and raw arithmetic widths.

## Independent evidence

The author script is `independent-feasibility/full_p20_grid60_magnitude_20261111.py`, SHA256 `1F28B6C9577B0894069DC132DF72521B2A2B4FAD0515D213350D9CE99D27CA2D`; the author receipt is `4158B1FBF599616A15EBD7978AB7C36EEDCB2C596355D6EE295689C35EF222D2`.

My checker is `major-constants/review_full_p20_grid60_scope_20261111.py`, SHA256 `863F4D598EC95654BF5CA875C46D5A2EE0F00FB3A62F386FC8C4FDB941DACBB4`. The exclusive3938-byte receipt is `major-constants/review_full_p20_grid60_scope_20261111.json`, SHA256 `4CE04CFC63097F58186F93A0E85C0C7113491149F903F10A6D59C119DF681A62`. It records77 fixed checks; the final receipt-size check brings the executed total to78. Thirteen source/artifact hashes match. The checker reconstructs both magnitude recurrences; the receipt retains six exact alpha ratios. Neither uses actual source values or inventory input.

The principal frozen dependencies are the base magnitude718CFC0D/review42985BB1, stored degree9B777E02/review10281561, joint HornerAEAB2BDC/review84B06243, shorter source0EAED4F9/reviewB15D0C3B, and guard6DF38245/review4D313FBF. Their full hashes are in the checker and receipt. This verdict is limited to the stated mathematical and representation join, with no implementation, cost or spectral-success claim.
