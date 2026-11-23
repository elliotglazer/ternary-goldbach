# Independent review of the entire pole-difference jet enclosure

2026-11-11. **PASS for the corrected paper derivation and effective point-input contract.** One material precision-domain clarification was requested and incorporated before acceptance. No formula, sign, factorial, tail constant or operation count needs further correction. No function, model, FFT, contour or special-function value was evaluated; no evaluator implementation or Lean build was produced.

## Frozen inputs and correction

The accepted author note is `zero-sum/POLE_DIFFERENCE_JET_ENCLOSURE_PLAN_2026-11-11.md`, SHA256 `3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011`. It supersedes `390613DE23688F98C4A8C58FE870F8E501B6B425BC53535F5FCD190BD4D9C4DE`.

I read and checked its parent `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md`, SHA `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC`, and the independent source review `mellin/REVIEW_FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md`, SHA `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64`.

The original precision paragraph could be read as an effective arbitrary-accuracy algorithm for an arbitrary complex input or a fixed uncertain input box. The corrected section 5 explicitly requires an exact rational center or a supplied refinable point-name, access to its refinement procedure, and positive rational budgets. A fixed-width box generally has a nonzero true image diameter. The analytic identities remain valid for every complex s, but arbitrary refinement of arithmetic cannot remove that input variation. The s=1 shortcut now requires a supplied identity; the generic formula never needs to decide equality of a computable complex number to 1. These corrections preserve the actual rational pilot grids and add no final mathematical premise to Goldbach.

## Normalization, entirety and all jets

For c>1, N>=1 and 1<=a<c, put X=cN+1, ell=log X and d=log((cN+a)/X). Positivity gives ell>0, d>=0, d=0 exactly when a=1, and d<1/N by log(1+u)<u. The accepted integer-base residue adapter requires exactly

`P_a(s)=-(1/c)*integral_(ell)^(ell+d) exp((1-s)v) dv`.

Integrating the exponential away from s=1 gives the author's numerator and denominator c(s-1), including the minus sign. At s=1 the integral defines the removable value. No extra c^(-s), parity factor, Gauss factor or s-1 multiplier is present. This is a finite correction in the accepted nonprincipal combination, not an identification of an individual Mathlib totalized Hurwitz value with a classical finite part.

On a compact neighborhood of any s, every derivative of the integrand is uniformly bounded on the finite real v interval by a constant of the form L^h exp(C L). Differentiation under this integral is therefore justified at every order. With v=ell+du,

`P_h(s)=-(d/c)exp((1-s)ell)*(-1)^h/h!`

`        *integral_0^1 (ell+du)^h exp((1-s)du) du`.

The normalized binomial identity `binom(h,k)/h!=1/((h-k)!k!)` gives formula (4) exactly. This convolution retains derivatives of both the common exponential and its residual argument; there is no missing log-power term.

At s=1, phi_k(0)=1/(k+1). Integrating the resulting real polynomial gives

`P_h(1)=(-1)^(h+1)*((ell+d)^(h+1)-ell^(h+1))/(c*(h+1)!)`.

In particular P_0(1)=-d/c, not generally zero. At a=1 all jets vanish identically. The generic formula has no division by d, z=(1-s)d or s-1, so neither case creates a numerical singularity. The cancellation-free moment formula is preferable to subtracting the two close powers in this special-value identity.

## Moment remainder and coefficient transfer

Termwise integration of the uniformly convergent exponential series on u in [0,1] gives the finite moment polynomial `sum_(m<Q)z^m/(m!(m+k+1))`. For its remainder, Taylor's theorem along the real parameter interval supplies a factor (zu)^Q/(Q-1)! and an inner integral with kernel (1-v)^(Q-1). Since u,v are real in [0,1],

`|exp(vzu)|<=exp(max(0,Re z))`.

The inner kernel integrates to 1/Q and the remaining u^(Q+k) integrates to 1/(Q+k+1). Thus the exact upper bound is

`exp(max(0,Re z))*|z|^Q/(Q!*(Q+k+1))`.

This holds for every complex z and Q>=1, including zero and negative real part. It does not presume a real phase or replace Re z by |z| unnecessarily. I read the actual `taylor_integral_remainder` signature at Mathlib `Analysis/Calculus/Taylor.lean:535`: it permits a complete real normed target, hence C, and n=Q-1 gives precisely the required derivative order and factorial. The source file SHA256 is `0AB79A53A36F87AB2A69D907D7999D2516CC4C085799E306F97D8480AE8CA18A`. The derivative and interval adapters remain implementation work.

All log-power/binomial weights are nonnegative. Their sum is `(ell+d)^h/h!`, so replacing d by D, |E| by E_X, the exponential majorant by E_A and ell+d by L proves formula (8), with its complete factor `(D/c)E_X E_A`. Summing with rho^h gives the finite polynomial C_K(rho L) in (9). This bounds only retained coefficient errors. It does not include omitted Taylor orders h>=K, actual EM error, other corrections or character-transform rounding. A weighted budget also must not be advertised as an individual bound for every jet unless separate bounds were imposed.

On the stated strip .555<=Re(s)<=2 and |Im(s)|<=T, the L1 inequality gives |1-s|<=T+1. Since d<1/N, W=(T+1)/N and A=89/(200N) are valid. The common exponential has norm X^(1-Re(s))<=X. With cN>=2, the coarse prefactor is at most `3(cN+1)/(cN)<=9/2`. No principal finite-g bound is imported. A disk extending outside the strip requires new bounds for its actual domain; center jets plus a separately proved finite-function Taylor tail avoid that issue.

## Effective precision, arithmetic and counts

The common tail factor is F_Q(W)=W^Q/(Q+1)!. For W>0 its consecutive ratio is W/(Q+2). Once Q+2>=2W it decreases by at least a factor of two per step. With finite rational upper bounds and positive rational budgets, the common-Q search terminates. W=0 gives zero tail for Q>=1; a=1 needs no search.

The log-d construction uses the exact nonnegative rational u=(a-1)/X and w=u/(2+u)<1/3. Its positive tail follows by replacing all denominators beyond 2R+1 by that first denominator and summing the geometric series in w^2. Binary range reduction of X gives a finite integer exponent and the same rapidly convergent series for ell and log 2. The exact range-reduction integer multiplies the log-2 error and must be charged.

For a refinable point input, the stated complex exponential power series with a certified rational majorant terminates at every requested absolute precision. Its argument may have large imaginary part, so this crude construction is not a practical uniform-height claim. The sensitivity inequality (13) follows by the straight-segment integral of exp and is valid for complex v,w: their real parts along the segment never exceed the larger endpoint real part. The complete prefactor multiplication and all log/phase uncertainty remain in the output error. Adding the analytic moment tail once after finite-expression enclosure is correct; converting coordinate widths to a Euclidean radius requires the explicit norm bound described by the author.

I independently counted Q-1 shared power updates, KQ moment divisions, at most KQ moment additions, two K-term normalized real power arrays, K(K+1)/2 convolution terms and K final common-prefactor products. The real convolution weights can be cached across heights; E is common across residues for fixed c,N,s, while z and d are residue dependent. Thus O(vJ(KQ+K^2)) is a valid arithmetic envelope with variable-Q sums substituted when needed. It is additional to endpoint/Bernoulli corrections and the main transforms. It is not a bit-cost, precision, storage-byte or runtime bound. Bounded W does not bound ell, phase-reduction work or requested accuracy.

The error sent through an exact character contraction is the sum of residue radii. A normalized unit-group circuit's arithmetic error still needs the factor v and its final scaling error. No second c factor, Gaussian scale or parity half is introduced. Whole-panel errors must also include the parent U-function Taylor and actual EM bounds; no spectral inference follows from these coefficient enclosures.

## Reproducible exact checks and remaining work

Owned script `review_pole_difference_jet_scalars_20261111.py`, SHA256 `5C65DDA5369A6AEFC3D63D99EBE4B876892A222A69523CD5A2EFB8D076E0B34D`, replays 11907 finite rational/combinatorial checks. Receipt `review_pole_difference_jet_scalars_20261111.json` has SHA256 `CA711BF918B72CB518A4F3E0CECA1D0C768C76BEB95994D0F63BCF6288F31E81`. These check normalized binomial and removable-value polynomial coefficients, integral/factorial factors, tail denominators, coarse prefactors and convolution counts. They evaluate no log, exponential, phi, P, L, jet or model values and are diagnostics alongside the universal proofs above, not substitutes for them.

The corrected note supplies a concrete terminating correction-jet enclosure scheme at refinable point inputs. It still needs the compact-integral/normalized-jet formal lemmas, certified elementary arithmetic implementation, actual finite packets, complete U outer/EM budgets, and character/panel acceptance. No full-family feasibility, boundary margin, zero exclusion, kernel proof or new final-theorem assumption is established by this review.
