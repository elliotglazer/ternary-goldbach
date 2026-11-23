# Independent review: principal xi Fourier evaluator

2026-11-11. Source and paper audit; no Lean/Lake build, high-height computation, numerical xi evaluation, or frozen-package edit.

## Reviewed version and final verdict

**PASS at source/paper-construction scope for the repaired frozen note**, `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`. This hash was independently verified and the repaired passages reread. Its core theta identity, normalization, Gaussian envelope, and arbitrary-height convergence argument pass. The initial submitted version, SHA256 `47FA488CB5749054598C49E640FA996BD03415C5FA65CF77B458F205014E7097`, required two local corrections, both now implemented:

1. The differentiated *discrete* spatial-tail estimate in section 7 requires `q*exp(2V)>=2` for the stated majorant `exp(4u-q*exp(2u))` to be decreasing. The earlier threshold 1 is sufficient only for the undifferentiated majorant. The corresponding continuous integral bound needs no monotonicity threshold.
2. Section 8 must distinguish scaling of the normalized radix-two output (`h*L`) from that of the reviewed unnormalized Bluestein output (`h`). Equivalently, divide the latter output by L before applying the normalized convention.

These repairs do not change the analytic target, and the stronger truncation threshold still admits a terminating search. No further correction is required. This acceptance proves neither a successful spectral computation nor any Lean declaration; it accepts the mathematical evaluator construction and identifies its remaining formal and implementation obligations below.

## Actual source definitions

I read the relevant source definitions and proofs, rather than relying on module prose. Verified source hashes:

| Source | SHA256 |
| --- | --- |
| Target `TernaryGoldbach/Explicit/Xi.lean` | `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` |
| Mathlib `NumberTheory/LSeries/RiemannZeta.lean` | `DF672932018A87831A240E2FF669C675DA31C75F924D871FBA3D3F8A08FFB210` |
| Mathlib `NumberTheory/LSeries/HurwitzZetaEven.lean` | `A55187C4FC35149EB5ACF82C7625849525E60F520D71A3E428FB2272DEFAC814` |
| Mathlib `NumberTheory/LSeries/AbstractFuncEq.lean` | `9FD5A09427DA6EEE9DF1C1E8A45D4803BE7ED488D4B5924C58F9C3E61249EB07` |
| Mathlib `NumberTheory/ModularForms/JacobiTheta/OneVariable.lean` | `7C29B4B07AED2E46D40FE408362F2A707126BFBBF05C3B374420AA0EDDF06B5C` |

Mathlib root: `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`.

In the actual target file, xiF is defined at line 18 as `s*(s-1)*completedRiemannZeta0(s)+1`. It has no factor 1/2. Lines 37 and 39 give its values 1 at s=1 and s=0; lines 28 and 56 give the right-half-plane product and open-critical-strip zero equivalence. The exact RiemannZeta theorem at line 85 states `Lambda=Lambda0-1/s-1/(1-s)`. An inconsistent sign in that module's introductory description is not the mathematical source used here.

`WeakFEPair.f_modif` at AbstractFuncEq line 249 and `Lambda0` at line 378 give the modified Mellin construction. The value at the split point x=1 does not affect its integral. The even Hurwitz definition divides the FE-pair Mellin transform at s/2 by 2, while the theta series minus its constant term is twice the positive-index Gaussian sum. These factors cancel in the producer's formula (1). The theta functional equation and positive-index series normalization are also explicit in JacobiTheta/OneVariable lines 43 and 71 onward.

## Theta identity and cancellation

Writing psi(x) for the positive-index Gaussian sum, the source split yields

`Lambda0(s)=integral_1^infinity psi(x)[x^(s/2)+x^((1-s)/2)] dx/x`.

Its superexponential tail is locally uniform in s, so it holds for all complex s from the source entire construction, including 0 and 1. Let f(v)=exp(v/2)psi(exp(2v)) and z=s-1/2. The real theta functional equation gives `f(-v)=f(v)+sinh(v/2)`, whence `f'(0)=-1/4`. Differentiating the Gaussian sum gives precisely

`P(w)=2(f''-f/4)=sum (8*pi^2*n^4*exp(9w/2)-12*pi*n^2*exp(5w/2))*exp(-pi*n^2*exp(2w))`.

Normal convergence on compact subsets of `|Im w|<pi/4` justifies these derivatives. Applying `D^2-1/4` kills the reflected sinh term. Thus P is even on the real axis and, by analytic continuation, throughout the strip.

I independently checked the integration by parts sign: with g(v)=exp(zv)+exp(-zv), g(0)=2 and g'(0)=0,

`integral_0^infinity (f''-f/4)g = -2f'(0)+(z^2-1/4)integral_0^infinity fg`.

Multiplication by two and the substitution x=exp(2v) recover `xiF(s)=integral_R P(v)exp((s-1/2)v)dv`. The boundary contribution is exactly +1. Neither an omitted theta constant nor a spurious pole-cancellation zero remains. This is the source's doubled xi, not the commonly halved version.

Contour shifting to v+ib gives the multiplier `exp(-i*b*(s-1/2))`, with the sign stated in the note. The vertical connectors vanish by Gaussian decay on a closed substrip. This multiplier is entire and nonzero, so it preserves analytic zero orders. For a fixed b, its logarithmic-derivative correction integrates to zero around a closed contour. Changing b between panels requires the explicit correction or restoration of a common normalization; the note correctly forbids simply joining different normalized values.

## Envelope and quadrature constants

For u=|v| and R=exp(2u), the lower bound on the Gaussian real exponent is `C*n^2*R`, where C=3*kappa. Splitting the exponential in half gives the two elementary bounds used in the note. The coefficient 2048 is `8*16*16`, from pi^2<16 and the fourth-power bound; 96 is `12*4*2`, from pi<4 and the square bound. The remaining powers of exp(u) in both terms are exp(u/2). The positive-index Gaussian sum is bounded by its first term times the geometric factor using `n^2>=1+3(n-1)`. Replacing its denominator by the one at R=1 and using `1/(1-exp(-z))<=(1+z)/z` proves exactly the stated A envelope. Evenness transfers it to negative v; applying the positive-real series directly at large negative v would not be justified by this envelope.

For the real-part strip [0.4968,2], the additional exponential growth is at most exp(3u/2). The resulting envelope is `A*exp(2u-q*exp(2u))`. Substitution R=exp(2u) on both halves gives the M=A/q integral bound and its stated continuous tail. The undifferentiated discrete tail follows from monotonicity once q*exp(2V)>=1.

The strip-trapezoid bound has the correct factor two: each shifted line has L1 norm at most M*exp(Tr); the two Fourier tails sum to `2M exp(Tr)/(exp(2*pi*r/h)-1)`. Gaussian decay and its differentiated bounds justify periodization and Fourier interchanges. This is a paper derivation that still needs a formal trapezoid theorem and source instantiation.

The finite-theta tail includes the n^4 and n^2 factors through the same half-exponential absorption. The remaining sum begins at N+1 and has the indicated geometric ratio bound. Multiplication by the finite quadrature weight gives `h(2K+1) A exp(2V) exp(-q(N+1)^2)`. On negative nodes the finite evaluator is the reflected positive-real series; it is not claiming that an unreflected finite theta polynomial is itself even.

## Height, precision, derivatives, and panels

For T>=1, eta=1/(T+1) is at most 1/2, b=pi/4-eta is positive, r=eta/2, and the outer strip cosine is sin(eta)>=eta/2. Thus kappa=eta/2 is admissible and Tr<1/2. The step-size choice in section 6 gives `2*pi*r/h>J` and hence a trapezoid error below epsilon/4. Increasing K and N then drives their respective displayed tails to zero. These are finite-termination arguments conditional only on implementing a proved convergent elementary interval engine, not on the truth of a zero-free boundary.

The reported rational q values at T=1000000 and T=60343058 are correct. The second height is the conductor-one family task; it is not the narrow-strip task ending at one million. Extra contour height must be included before choosing T. Neither task is declared completed by the evaluator.

For derivatives, `|v|^j<=j!*exp(|v|)` and the coarser integrable envelope `A exp(4u-q exp(2u))` give `|F_b^(j)|<=j!D`, with D=A(1/q+1/q^2). The Cauchy disk of radius one increases the real-part exponent bound by one and is covered by the same envelope. Thus the Taylor coefficient and remainder bounds are valid. On displaced quadrature lines, `|w|^j<=j!exp(|Re w|+r)` gives the stated extra exp(r). The differentiated discrete-tail monotonicity requires the first correction above. Coefficient intervals must still be computed; the derivative bound alone is not a Taylor polynomial.

A midpoint ball with `|a|-e>D*ell` proves nonvanishing of a whole straight panel contained in the real-part strip. This uses one fixed analytic normalization and a derivative bound on the entire segment. Point exclusion alone is insufficient. Boundary zeros may prevent every such strict test from succeeding; no relative-precision or termination guarantee at a zero is claimed.

The finite Fourier-grid phase and signed-index embedding in section 8 are correct. A normalized transform needs hL, while the unnormalized Bluestein transform needs h; this is the second correction above. Only grid ordinates within the chosen height inherit the global error bounds. Finite-array periodicity is not a functional equation for xi.

## Scope

The source nonzero factor `s*(s-1)*GammaR(s)` transfers analytic zero orders between xi and zeta only in the open critical strip, where it is holomorphic and nonzero. Source nonvanishing handles the outer half-planes, and xi's exact values at 0 and 1 exclude spurious poles or zeros. Formal order-transfer and argument-principle adapters remain required. No RH, simplicity, saturation, or successful finite spectrum has been proved here.

All constant checks above are exact symbolic/rational derivations; I ran no numerical xi or high-height computation. The algorithm's arbitrary-precision convergence is not a performance certificate. The note explicitly retains potentially large theta-coefficient work, contour proofs, interval-engine correctness, FFT arithmetic, and Lean formalization as separate obligations.
