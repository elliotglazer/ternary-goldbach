# Materialized Hurwitz alpha grid on conductor-101 residues

2026-11-11. Bounded external arithmetic experiment; no builtin zeta/Hurwitz calls anywhere in the script. No full contour, family verification, Lean build, dependency installation or frozen edit. This tests the proposed alpha interpolation with actual coefficient enclosures, not a production-height spectral premise.

## Outcome

The16-cell,32-coefficient grid was materialized for three whole complex panels and compared with a separately evaluated direct EM formula at all100 residues a/101. Every enclosure was finite and overlapped its direct counterpart. The box containing s=1 also passed, using analytic common-pole subtraction.

The important limitation is visible in the data: alpha interpolation is accurate, but a raw interval in s still loses substantial information. At height1000 the wide panel gives minimum relative accuracy -2 bits with either method. At its center the grid retains at least80 bits, with error dominated by the deliberately coarse alpha remainder. A separate narrow-panel diagnostic gives9 bits. The point and narrow tests do not replace or silently shrink the original wide panels; they identify the dominant error source.

The next production step would be a Taylor or Cauchy model in s, with separately certified remainder. This experiment does not prove such a model, and overlapping independent enclosures alone is not a proof of the analytic formulas.

## Reproducible files and exact domains

Run the existing interpreter with:

    work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/family_alpha_materialize_20261111.py --recompute

The --recompute flag reruns the numerical checks without replacing the frozen JSON. The script and receipt are `family_alpha_materialize_20261111.py/json` in this directory. Precision160 bits; python-flint with FLINT3.6.0. All residue arguments are exact rationals; outward-rounded balls enclose them.

Primary panels:

* Re(s)=111/200, Im(s) in[100-1/512,100+1/512].
* Re(s)=111/200, Im(s) in[1000-1/512,1000+1/512].
* Re(s),Im(s) in[1-1/512,1+1/512] times[-1/512,1/512], respectively.

Thus every actual s has Re(s)>=111/200 and |s|<1002. Input rounding can extend a ball infinitesimally beyond the rational sigma floor; the analytic statement remains about the exact requested panel, not all spurious rounding points. Two additional, explicitly diagnostic cases use the height1000 center and its imaginary radius2^-20.

## What was materialized

Set A16 and divide alpha in[0,1] into G16 equal cells. Center j is alpha_j=(2j+1)/32. At each s-panel construct512 interval coefficients

    c_(j,0)=zeta(s,A+alpha_j)-1/(s-1),
    c_(j,k)=(-1)^k(s)_k*zeta(s+k,A+alpha_j)/k!, 1<=k<32.

These are analytic definitions with the removable continuation at s=1 in k0. For each target alpha=a/101, choose j=floor(16alpha), evaluate its31-degree polynomial by Horner at alpha-alpha_j, add the alpha remainder, then restore the16 initial powers (n+alpha)^(-s). The result encloses

    D(s,alpha)=zeta(s,alpha)-1/(s-1)

with its removable continuation. Every nonprincipal character combination of D equals the corresponding combination of zeta, since its common pole sums to zero. No character transform is executed in this experiment; conductor101 only supplies the100 actual rational residue inputs.

Coefficient construction shares the base logarithms and exp(-s log(n+A+alpha_j)) across k. Higher k use multiplication by positive reciprocal bases. Pochhammer factors and Bernoulli coefficients are enclosed. The complete grid is materialized in memory for each case; the receipt records parameter choices, errors, timing and sample enclosures, not a serialized proof of all512 coefficients. Deterministic recomputation regenerates all coefficients and checks all100 targets.

## Analytic remainder and pole cancellation

Grid coefficients use EM N512,M40. The direct comparison uses a separately coded scalar EM path, N640,M44, at the actual target alpha. It shares exact Bernoulli data and the same analytic EM theorem, so this is independent parameterization/evaluation, not an independent proof of that theorem.

For the coefficient with index k, write u=s+k, beta=A+alpha_j, B=N+beta. Its regular EM part is

    sum_(n=0..N-1)(n+beta)^(-u) + B^(-u)/2
      + sum_(ell=1..M) B_(2ell)/(2ell)! * (u)_(2ell-1)
          * B^(1-u-2ell).

The remainder bound used is

    4*|(u)_(2M)|*B^(1-(111/200+k)-2M)
      / [6^(2M)*(111/200+k+2M-1)].

It follows from the periodic Bernoulli EM integral bound, using2pi>6 and zeta(2M)<2. The scalar comparison uses the analogous bound with k0 and its own N,M. All positive real powers use real logarithms. No gamma factor or complex-power branch choice is hidden in these formulas.

For k>=1 the integral term B^(1-u)/(u-1) is nonsingular on the stated domain. For k0 subtract1/(s-1) analytically:

    [B^(1-s)-1]/(s-1) = -log(B)*exprel((1-s)log(B)).

If |(1-s)log(B)|<1, the script uses exprel through degree32 with error exp(r)*r^33/34!. Otherwise the denominator is checked to exclude zero and the quotient is evaluated directly. The box through1 takes the analytic series branch. The same pole cancellation is used in the direct comparison; no subtraction of two infinite balls occurs.

Alpha error is the previous exact Taylor bound, now actually added to every output:

    E=2*product_(j=0..31)(1002+j)/(512^32*32!)
      <2.660e-26.

For clarity, this bound comes from the32nd real-alpha derivative and |alpha-alpha_j|<=1/32, with A16 and sigma>=.555. It is uniform over each entire s-panel because |s+j|<=1002+j. It is not a center-only bound. Input EM error, elementary arithmetic rounding and dependency width are already carried in the coefficient balls; E is an additional square enclosure of the analytic remainder disk. No rounding term is dropped because it is smaller than E.

## Measured results

The reported radius is rad(Re)+rad(Im), a conservative upper bound on Euclidean uncertainty. It includes genuine s-variation and interval dependency, not just numerical error.

| Case | Grid build | 100 grid evaluations | 100 direct EM evaluations | Max grid radius | Max direct radius | Min accuracy grid/direct |
|---|---:|---:|---:|---:|---:|---:|
|height100, radius1/512|.17135s|.00889s|.26438s|.535486|.581157|0 / 0 bits|
|height1000, radius1/512|.16430s|.00817s|.25763s|.594807|.563200|-2 / -2 bits|
|box through1|.14589s|.00792s|.22096s|1.985407|1.995059|2 / 2 bits|
|height1000 point diagnostic|.17992s|.00843s|.27036s|5.319e-26|6.798e-43|80 / 137 bits|
|height1000, radius2^-20 diagnostic|.16374s|.00851s|.25364s|.000290542|.000275098|9 / 9 bits|

All500 comparisons overlap and all outputs are finite. Total measured case processing was2.137s; one-time grid-log initialization, interpreter startup and receipt writing are outside that internal timer. No end-to-end family estimate is inferred from this table.

The largest unmultiplied coefficient-input EM remainder at height1000 is below7.8e-41. This is not the final coefficient error after Pochhammer multiplication; that multiplication is performed with interval arithmetic. The actual point-output radius near2E shows that the chosen interpolation bound dominates the final point enclosure. In contrast, wide-panel radii are about25 orders of magnitude larger than E. Raising arithmetic precision alone would not remove interval dependency or actual variation in s.

The grid build is a fixed cost shared across many residues. The displayed build plus100 evaluations is somewhat cheaper than these direct evaluations, but no asymptotic speed factor follows. N and M differ, neither method has been globally optimized, and a conductor-wide DFT and its output conditioning are absent here.

## Source adapter at s=1

The function D used here is the ordinary analytic finite-part continuation after subtracting1/(s-1). It must not be identified at s=1 with Mathlib's totalized Hurwitz function by definition. The source inventory reports a regularization involving1/((s-1)*Gamma_R(s)); its individual assigned value can differ by a common constant.

The safe formal bridge is to prove the nonprincipal character combination identity first in Re(s)>1, where the Dirichlet/Hurwitz series identity holds, and then extend the entire combination analytically. Common regularization terms cancel because sum chi=0. This preserves the tested nonprincipal combination without asserting a false pointwise equality of differently totalized Hurwitz inputs at s=1. A principal combination needs its own pole-cancelled zetaF adapter.

## Remaining bounded test

Materialization and point conditioning passed at the original parameters; no coefficient failure forced a parameter relaxation. The observed limitation is the s-panel enclosure. A useful next experiment would combine the same alpha grid with a short certified Taylor model in s and compare complete conductor101 character outputs on one modest interval. It should retain the same whole-panel target and report whether character cancellation amplifies uncertainty. A full contour or any Hcert claim would require a separate authorized task and independent analytic review.
