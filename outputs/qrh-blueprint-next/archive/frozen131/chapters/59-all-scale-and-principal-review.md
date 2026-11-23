# All-scale Q90090 review and bounded principal follow-up

2026-11-11. Independent research audit against `work/ternary-goldbach`, baseline `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical edit. I ran the exact all-scale certificate to completion and read the analytic domination against the original source formulas. No blocking mathematical defect was found.

## Exact accepted minor scope

The reviewed paper result applies to the reduced denominator q=90090 of 2alpha, with its coprimality and exact phase representation, for

`y>=10^25`, `1200000/49<=u=q|Delta|<=33000`.

It uses the new parameters on `.05<=w<=2`, the old raw first-choice bound on `2<=w<=8`, and the trivial coefficient 17 outside. Its conclusion is the unchanged `|S_etaStar(alpha,49y)|/y<=ghatY(y,150000)`, conditional on the original analytic Type I/II producer estimates. The lower twist endpoint is part of the source-domain claim. The report now states it explicitly. An abbreviated phrase such as “all u<=33000” must not replace this domain.

The second pass with cutoff 2.5 covers the source band only through u=26000, also at every y>=10^25. Neither result covers `33000<u<26400000/49`, joins the high-twist tangent band, proves q=1, or adds q90090 to the all-twist denominator count.

## Original formulas, floor and size conditions

I read `TypeITotal.typeI1_le:101` and its `muBound`, `TypeI.bound_4_41:177`, `TypeI2Sum.typeI2_le_small:300` and `cPlus/coefUV/coefQ`, and `TypeIITotal.typeII_637:331`. These contain the Type I1 quadratic and full error term, both Type I2 coefficients, and both Type II remainders used in the certificate. Their original Platt-related analytic dependencies remain; numerical comparison cannot remove them.

With z=wy, T=z^(1/3), H=3T^2/4, a=1/(144sqrt(180180)), b=72, U=floor(aT^2), V=floor(bT), the uniform brackets `alpha*T^2<=U<=a*T^2`, `beta*T<=V<=b*T` follow from epsilon*a*T^2>=1 and epsilon*b*T>=1. Here alpha=a(1-epsilon), beta=b(1-epsilon), epsilon=1e-8. Their minimum is at w=.05,y=1e25, and the script checks it for every bin's lower scale.

The stated T>79000000 bound suffices for U>=sqrt3, U<=min(z/4,z/e,H/2), qV<=H, 16V<=H, V>=2.5e7, UV<=z, V<=z/4, 3.5z/U<=H and 2eq<=V. In particular the lower U bound, not an upper floor approximation, is used in the Type II reciprocal terms. At the enlarged central cutoff, wu<=66000 gives the small-twist condition strictly. The approximation error follows from wu<4T/3 and q<=H, with inherited coprimality. The upper-w raw branch has |wDelta|<8 and t=2q. Changing decomposition at w=2 is valid because each bounds the same sum before integration.

The normalization of the Type I2 quadratic is correct. Dividing its source expression by z gives the four terms

`.511 a^2 b^2/q`, `a^2 b log(q)/T`, `1.022 a b^2/T^2`, `.511 q b^2/T^4`.

The script retains all four, as well as `1.0064*coefUV*ab` and `1.0064*(3/(4T))*coefQ`. The Type II zeta correction is correctly bounded by `216/(alpha*sqrt(beta)*T)` and its kap correction by `27/(alpha*sqrt(beta)*T)`.

## Unbounded scale control

The two muBound caps are valid. Put s=log T and M=2.8q/phi(q). Before saturation, each upper logarithmic numerator increases. After saturation, differentiation of its quotient gives respectively the negative constants `3log(alpha)-log(2q^2)` and `-log(384q^2)-log(72q)`. Their maxima are exactly the displayed G1 and G2. The positivity of the numerators on the actual scale range permits multiplication by the monotone muBound majorant. This step avoids an unjustified unbounded logarithm from using muBound<=1 forever.

The omitted logPlus in bound_4_41 vanishes because aq/(c2T)<1. Both max-log replacements by 1 use arguments bounded above by e at T0 and decreasing with T. Other logPlus terms are bounded above by the positive upper logarithms; no unjustified equality for the floored U is needed. The stated logarithmic-over-power derivative test covers the remaining terms, whose denominators and logarithms stay positive. Products with c1(T) or K(T) preserve decrease. The normalization of each source error term agrees with the proposed frozen remainder.

For lambda=log(z/(UV)), positivity and lambda<=L=log(1/(alpha beta)) hold. The source difference of log-log terms is exactly

`Phi=log(2q)*log(1+lambda/log(V/(2q)))`.

With v=log(y)/3+log(9/601200) and r=1/v, the lower bound `log(V/(2q))>=v+h(w0)` is correct. Hence the rational function `r/(1+h*r)` gives an increasing upper bound on each compact r cell. The raw upper-w formula has the matching denominator shift `log(300000/(2q))+log(w0)/3`. The consumer lower envelope is increasing in r as well, so evaluating the upper bound at a cell's right endpoint and the lower bound at its left endpoint proves the whole cell, despite both original quantities decreasing with y. No monotonicity of their difference is assumed.

The interval `[0,rmax]` covers every finite y>=1e25. Inclusion of r=0 safely checks the limiting formulas. The 159 w bins cover [.05,8], and both cutoffs are exact bin endpoints. Positive Gaussian masses multiply positive upper envelopes. Simpson's explicit remainder and the two trivial tails are retained. This is a complete conditional interval comparison, not a sample of scales.

## Replay evidence and formal limits

`resume_minor_allscale_certificate.py` exited zero. All 128 cells passed for each cutoff, 256 in total. The reproduced worst gaps are:

| Cutoff | Twist upper endpoint | Worst cell | Certified lower gap |
|---|---:|---:|---:|
| 2.5 | 26000 | 48 | `1305758681/10^12` |
| 2 | 33000 | 55 | `70212357/200000000000` |

The interval engine performs exact Fraction arithmetic with outward rounding, and the script uses upper rmax and directed log/root enclosures. The imported earlier certificate does not run its main experiment on import. This review relies on the previously reviewed utility log/root and Simpson proofs, with a fresh check of the current interval-operation directions and source substitutions.

Status: independently reviewed complete paper comparison on the stated band, with successful external exact replay. Formal proofs of the domination, numerical checker soundness, and consumer application are still needed. The original prime/Mobius producers remain explicit, including the new P6 paper repair rather than an assumed compiled replacement.

## Bounded follow-up on the principal report

I also read `mellin/RESUME_PRINCIPAL_2026-11-11.md`, checked `xi_partial_approx`, `logDeriv_xiF`, the actual etaPlus tail threshold, and the source tail-window definitions, and ran its scalar script successfully. The new translated-mass, Gram and Schur argument has no mathematical defect found in this bounded review. It remains conditional on the stated analytic bridges and on a new finite nonvanishing theorem, not on a completed certificate.

The xi approximation has the correct sign: taking real parts converts `-(rho-s)^(-1)` at s=2+ic into the positive weight `(2-beta)/((2-beta)^2+(gamma-c)^2)`. Enlarge the fixed compact disk to contain the chosen finite zeros and the evaluation point; true multiplicities must be transported before dropping positive terms. The digamma series at 1+iv has the stated nonnegative summands; their decreasing integral comparison yields `1+.5log(1+v^2)`. The zeta logarithmic derivative bound and constants then give the claimed translated mass bound. The digamma series and multiplicity transport remain formal obligations.

The full-line Gram identity uses Mellin real part `beta+beta'-1`, so its range is indeed [-3/4,3/4]. The extended weight E has exponent k=sigma+2, and `a^2E-E''=[16-8k+(4k+4)z-4z^2]E`. The 427.8 numerator, 25/16 denominator and trivial bound 4 follow from the stated projection-norm hypotheses. Those actual-smoothing projection and integration-by-parts bridges are not yet Lean theorems.

The multiplicity-expanded Schur argument is valid. A repeated-index row count includes all multiplicities, the two-sided 3.48 bins have multiplicity at most 45, and the tail `sum_{j>=4}j^(-2)<=1/3` gives row sum `6308120/2523<2600`. With the explicitly unproved beta<=2/3 condition through height 4e7, the resulting low-height coefficient is `40040000000000*x^(-2/3)`, below .0095 squared at every x>=4.9e26. The strict high tail begins above 4e7, while the low set includes equality, so the split has no endpoint gap.

The source tail threshold is satisfied over the entire twist interval through 600000; the new argument does not reuse the height-250 local tail there. The geometric ratios, counts and normalized tail arithmetic fit below 3e-8. The script still prints an older .64/9000-row diagnostic before its updated 2/3/2600-row checks; both are clearly conditional, and only the latter supports the current report. I did not independently review the cited literature or run a zero-free rectangle computation. The proposed rectangle concerns the analytically continued zetaF with value 1 at its removed pole, as the current note correctly specifies.

Therefore the principal progress is a quantified sufficient route and additional actual-zeta constraints excluding the earlier synthetic cluster. Actual nonvanishing to the right of 2/3 through 4e7, or an adequate weighted density substitute, remains an open leaf. This is not closure of Ep or of any major-arc branch.

## Pins and workflow

| Artifact | SHA256 |
|---|---|
| Minor report | `747F60839CD9CC3F61861ADE682C80D492671627F0F40FFEAA964B5E9E871787` |
| All-scale script | `F7934294EA5907153F2B518F4F6BCB4D1076D347496D9B5726E22BD36BC23FF4` |
| Principal report | `950BD0EC1A67A9591626D5FA527867D127929E7A2028CD7B39A4C1438005F22C` |
| Principal scalar script | `E5C4FAE2D5FA6E897C1ACABF19C282E05A91C31866616AC6E75AA142134B7460` |

No draft anchor, admitted proof, canonical import, or sealed theorem was introduced by this review. All new conclusions here are paper/source review or external arithmetic evidence, as labeled.
