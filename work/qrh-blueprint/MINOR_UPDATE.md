# Minor-arc research update

This update supersedes the initial blueprint's assessment that the smoothed-energy input had no quantitative replacement route. It does not assert a completed Lean proof. The public goal, binary input, and endpoint remain unchanged.

## New numerical target

It is sufficient to prove, for every x>=4.9e26,

    sum'_n ||a1(x,n)||^2 <= .65*x*log(x),

with the exact source prime-supported coefficients and their summability. The original coefficient near .640208 and its negative intercept need not be reproduced. An exact-rational replay of the nine existing finite-cell envelopes and the asymptotic envelope permits .65 even with zero intercept, while retaining the final minor coefficient 1.0376.

This requires explicit changes to the coefficient-dependent sD and tau values and their comparison lemmas. The original numerical proof cannot be applied unchanged. The fixed arc partitions, ghat bounds, lower major energy 8.6296, prime-supported lower energy 8.6294, and final square-split constants remain the same. The global zero-intercept cap for these chosen envelopes is about .6523618655, with the first cell the limiting one.

The tolerance report and its exact arithmetic are research evidence. They establish the implication from a proposed energy estimate, not that estimate itself.

## QRH route to the energy estimate

The new proposed route applies the unconditional zeta explicit formula directly to the actual etaPlus squared smoothing and to etaPlus squared times log. It uses global beta<=7/8, positive weighted zero mass at two bounded by .07, and two integrations by parts in the logarithmic variable.

The proposed transform bounds are

    |M(etaPlus^2)(beta+i gamma)| <= 172*w2(beta+i gamma),
    |M(etaPlus^2 log)(beta+i gamma)| <= 566*w2(beta+i gamma),

where w2=(2-beta)/((2-beta)^2+gamma^2), uniformly in height and 0<=beta<=7/8. These estimates would bound the normalized weighted-sum error by less than .006 after the vertical remainder, since

    (.07/2125)*(172+566/61) < .006,
    2125^8 < 4.9e26, and log(x)>=61.

Together with the existing integral estimate this gives a paper-level coefficient below .64621, comfortably below .65. The scalar arithmetic has passed a separate exact-rational run. Independent full review found no mathematical defect in the transform derivation, source normalizations, zero treatment, or vertical remainder, conditional on the explicitly tracked global QRH strip and finite weighted-mass theorem. Their validation and the new analytic glue still require Lean proofs. No new low-zero computation or critical-line assertion is proposed for this energy route.

## Unconditional prime-power error

The EBound replacement has a complete paper derivation and independent mathematical review. Starting from Mathlib's elementary Chebyshev bound and the source's nonprime-sum inequality, it gives psi(t)<=1.4t for t>=1e8 and P(y)<=1.5sqrt(y) for y>=4.9e26. The existing low-range and dyadic summand inequalities then give

    E(x)/x <= 3228869/44270000000000000
           = 7.2935825615541e-11 < 8e-11.

The proof explicitly establishes summability; it does not infer it from a bound on a totalized infinite sum. All 17 exact arithmetic checks were rerun successfully. The remaining work is Lean normalization, comparison, summability, and assembly. The report is not a checked Lean theorem.

## Remaining limits

The etaStar base-gap estimate still needs a quantitative family or character argument. Improving its Fourier main term does not control the nonprincipal errors. The nonprincipal major averages, mixed term, upper major energy, moderate prime estimates, and Mertens/totient inputs remain separate obligations. Neither the relaxed energy target nor EBound closes these paths.

The final primary numerical package remains major1.0404, minor1.0376, nonprime reserve.00271, with positive reserve.00009. The new minor-energy choice spends slack inside the existing minor proof, not this final reserve.

## Proof accounting

The preceding goal turn made research progress by producing the exact numerical sensitivity calculation and the unconditional EBound derivation. This continuation checks and integrates that evidence. Compilation remains stopped at the user's research-only instruction.

    DRAFT_ANCHORS: 0
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0
    SEALED_THIS_TURN: 0
    CHECKED_HELPERS: 3, all from earlier work

The full objective remains active and incomplete.
