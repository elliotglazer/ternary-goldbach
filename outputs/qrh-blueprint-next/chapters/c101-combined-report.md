# Conductor101: alpha grid plus an actual-L Cauchy model

2026-11-11. Bounded external interval experiment only. All99 primitive characters modulo101 passed the requested vertical block sigma=111/200, t in[999.875,1000.125]. The target length1/4 was retained. No builtin zeta/Hurwitz call, full contour, winding count, Hcert verification, Lean build, installation or frozen edit was used.

## Exact result and artifact

`c101_cauchy_alpha_block_20261111.py/json` in this directory implement and record the experiment. Run the existing interval-env Python with the script and `--recompute` to repeat the checks without replacing the frozen JSON. Precision160 bits, FLINT3.6.0. The script constructs models and checks whole panels, rather than sampling signs only. Analytic contracts are described below; elementary interval operations are external and have not been reflected into Lean.

The final run produced159 accepted panels for99 characters, from219 model calls, maximum3 panels per character and subdivision depth2. Every character's ordered panels cover exactly[-1/8,1/8] in ordinate offset, with no gaps. Each entire model enclosure lies in a strict real or imaginary half-plane. This proves local line-segment nonvanishing under the analytic enclosure contracts. There is no closed polygon and no winding claim.

At the two endpoints and center, all99 model values overlapped a separately parameterized direct EM transform. These297 comparisons are consistency checks, not the proof that the whole panels are enclosed.

## Exact character definitions

The script verifies101 is prime by trial divisibility through10. It checks that 2^j mod101, j0..99, enumerates every nonzero residue exactly once and that2^50=-1 mod101. Define

    chi_k(2^j)=exp(2*pi*i*k*j/100), 1<=k<=99,
    chi_k(0)=0.

These are exactly all99 nonprincipal characters of the prime modulus, hence all primitive characters. Their parity is odd for odd k and even for even k. The principal k0 is excluded. Complex conjugation sends k to100-k; the program does not conflate nonreal characters.

The character transform uses the positive exponent above, with scale101^(-s). Its100 inputs are in generator order, not numerical residue order. Both character roots and Cauchy-sampling roots are interval enclosures of their stated exact complex exponentials. The formal adapter must prove these characters agree with actual source DirichletCharacter objects; the finite enumeration itself is checked in the experiment.

## Domains and source growth bound

Let c0=111/200+1000i. The outer disk has radius R1/2, the sampling circle radius rho1/4, and the target radius r1/8. Their real-part lower bounds differ:

    outer disk: Re(s)>=11/200=.055;
    sampling circle: Re(s)>=61/200=.305;
    target vertical segment: Re(s)=111/200=.555.

The new EM code uses the sampling floor61/200. It does not reuse the earlier .555 floor. Exact sample locations lie on the circle; interval roots may enclose slightly more points, but every claimed analytic bound applies to the exact mathematical location, with outward arithmetic enclosing it.

Existing pinned source `TernaryGoldbach/Explicit/LGrowth.lean:179`, `norm_LFunction_le`, states for nonprincipal chi and Re(s)>0:

    |chi.LFunction(s)| <= (q+1)*|s|/Re(s).

The preceding `LFunction_eq_mul_Iint` proves the continued function equals its Abel integral throughout Re(s)>0, by analytic continuation from Re(s)>1. Thus no Dirichlet series convergence is assumed at .305. Nonprincipal LFunction is holomorphic on a neighborhood of the entire outer disk. Primitivity is not needed for this growth theorem.

For q101, |s|<=1000+111/200+1/2=200211/200 throughout the outer disk. Consequently

    M=102*(200211/200)/(11/200)=1856502

bounds every actual L-function there. This is an existing-source constant, not a new sharper partial-sum estimate. No gamma factor, completed Lambda function or extra s-1 multiplier occurs in this model.

Crucially, M bounds actual L, not the finite EM approximation. We use EM only to enclose actual sample values. The subsequent Cauchy model is a model of actual L. There is no assertion that the finite EM expression obeys M on the larger outer disk, and no EM bound with sigma floor.055 is required by this construction.

## Sample enclosure and recalculated alpha error

Each of64 exact points c0+rho*omega_j uses the16-cell,32-coefficient alpha grid. Coefficients are obtained by explicit pole-cancelled EM with N512,M40; direct comparisons use N640,M44. Every sample obeys |s|<1002. For coefficient index k the EM real-part floor is61/200+k, not111/200+k.

The alpha remainder is recalculated on this domain. For K32, A16 and h1/32, Taylor's real-alpha integral remainder gives

    E <= |(s)_32|*h^32/32! *
        [16^(-sigma-32)+16^(1-sigma-32)/(sigma+31)].

Since sigma>=61/200>0 and16/(61/200+31)<1, the same coarse rational expression is still valid:

    E=2*product_(j=0..31)(1002+j)/(512^32*32!)
      <2.660e-26.

Its value agrees with the earlier budget because that budget discarded the extra positive sigma decay; its justification has explicitly changed. The script checks the new positivity and bracket inequalities. All coefficient EM errors, finite arithmetic rounding and interval dependency are retained before adding E. The scale101^(-s) and all root enclosures are propagated through the transform.

The common deflated Hurwitz function is the analytic continuation of zeta(s,alpha)-1/(s-1). Its nonprincipal combination equals L by the series identity in Re(s)>1 and analytic continuation. As in the prior report, no equality is asserted between this individual value at1 and Mathlib's differently totalized Hurwitz convention. The common correction cancels in each nonprincipal combination.

A simple independent magnitude budget for the alpha contribution alone is useful: a square radiusE has norm at most2E, so100 transformed inputs contribute at most200E per sample, using101^(-sigma)<=1. Cauchy interpolation on r/rho=1/2 amplifies that by less than2, giving at most400E<1.064e-23. The implementation does not add this budget a second time; it already carries those errors in its sample and coefficient balls.

## Cauchy model and full-panel acceptance

For each character, let f be its actual L-function and m64. Set

    b_n=(1/64)*sum_j f(c0+rho*omega_j)*omega_j^(-n), 0<=n<64,
    P(s)=sum_(n<64) b_n*((s-c0)/rho)^n.

Root orthogonality and Cauchy's bound on the outer disk imply, for |s-c0|<=r,

    |f(s)-P(s)| <= M/(1-r/R) *
        [(r/R)^64+(rho/R)^64/(1-(rho/R)^64)].

The script evaluates this as an exact Fraction. It equals approximately1.341882334416e-13, and is strictly below1.4e-13. The two terms respectively bound the omitted true Taylor tail and coefficient aliasing. Interval samples and roots enclose the exact b_n; their arithmetic errors remain inside polynomial evaluation. The analytic remainder is added as a square enclosure of the error disk.

For each character independently, adaptive bisection evaluates the polynomial on the entire proposed vertical interval. A leaf is accepted only if one coordinate has strict constant sign after the remainder is added. The target interval is never shortened; limits on time, depth and calls fail closed. Independent per-character meshes avoid refining every character to the smallest common leaf.

## Measured errors and work

Final receipt:

| Quantity | Value |
|---|---:|
|64 sample vectors, including alpha grids and character transforms|19.474s|
|99 Cauchy coefficient transforms|.324s|
|219 whole-panel model calls|.0135s|
|297 direct-EM point comparisons|1.320s|
|Total internal processing time|21.143s|
|Largest sample radius, real-plus-imaginary diagnostic|2.110e-24|
|Minimum sample relative accuracy|74 bits|
|Largest Cauchy coefficient radius, real-plus-imaginary diagnostic|1.193e-24|
|Largest unmultiplied EM input remainder|3.766e-40|
|Accepted panels / maximum per character|159 / 3|

These are one-run bounded timings, not production throughput. The internal timer excludes interpreter startup and the initial reusable alpha logarithm table. One earlier run without the extra error diagnostics took18.03s, illustrating host variability rather than a tuned performance estimate.

The largest EM input error is not itself a final output bound after multiplying Pochhammer coefficients; the interval computation performs that multiplication. The sample/coefficient radii report the resulting enclosures. Analytic Cauchy error dominates them by roughly11 orders of magnitude, but remains small enough for every tested whole panel to exclude zero.

The current transforms are direct sums, not optimized FFTs. Character transformation uses64*99*100=633600 complex weighted terms; the Cauchy transforms use99*64*64=405504 terms. The report makes no timing extrapolation to the5.543-billion-character family. The alpha grids still use EM coefficient construction and therefore do not solve high-height evaluation for small conductors.

## What this closes and what remains

This resolves the bounded method question: alpha batching and an actual-function Cauchy model can be combined with correct lower real parts and a source-proved growth bound to enclose an entire quarter-unit block for all primitive characters of a nontrivial moderate conductor. It repairs the s-panel weakness observed in raw alpha interval evaluation without shrinking the target.

It does not certify any rectangle, zero count, entire height interval or production Hcert. General unit-group indexing, high-height coefficient evaluation, complete boundary assembly, independent checker validation and formal analytic bridges remain. The stored JSON contains the panel certificate and summaries; the full512 alpha coefficients and99*64 Cauchy coefficients are regenerated rather than serialized. Independent review should recompute the samples, inspect the changed sigma floors, confirm exact indexing and verify each whole-panel inequality.
