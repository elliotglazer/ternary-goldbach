# Independent review of the off-critical Gaussian Fourier plan

2026-11-11. Verdict: **PASS at the stated paper-derivation scope. No correction required.** This review accepts the extension to each fixed real `0 < sigma < 1`, conditional on the explicitly identified, previously reviewed theta/Mellin mathematics. It does not supply numerical character values, FFT output, a zero-free contour, a production spectral certificate, or a Lean proof.

## Frozen inputs and independent checks

Reviewed `../zero-sum/OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md`, SHA256 `BA7A5D0517972FD9C93496E6166DEC471B36C18CA0B6BBA734985016ECD24B25`. The complete note was read, its hash checked, and its normalization independently derived before receipt of the final note.

The unchanged predecessors are the Gaussian proof plan `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41`, its independent integration review `098171B14232E392AAA0C4BDD083C0E737D459315E23039F624C862B8E06C577`, the alias proof plan `E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF`, and my alias review `A1B71C24E818CD5628C7A5F5B24105E19BDF5FC4840CCFC47239CAB435A85B33`.

New independent artifacts, in this directory:

* `review_off_critical_fourier_20261111.py`, SHA256 `8F134FBEE2A19BE727E92DF4703EBD53326D15AE23365AF938AF8AEBF38B9736`.
* `review_off_critical_fourier_20261111.json`, SHA256 `87B4B44D6BD475F8EC2DC532329B99A456BB0B666163F311C6D2E17BA4981304`.

The script completed with all 43 checks passing. It uses only exact fractions and affine exponent identities; it does not evaluate an L-function, generate an FFT, or certify any sign. Run it with `python work/qrh-campaign/agents/moebius/review_off_critical_fourier_20261111.py`. The output receipt contains exact rational upper bounds, not floating-point acceptance tests.

## Normalization, parity, and the actual source function

Put `k = sigma + a` and `ell = 1 - sigma + a`, with parity `a` equal to zero or one. The actual entire conductor completion is

`Lambda_chi(s) = c^((s+a)/2) completedLFunction_chi(s)`.

The pinned Mathlib source `NumberTheory/LSeries/DirichletContinuation.lean` was reread at `differentiable_completedLFunction` (line 249), `LFunction_eq_completed_div_gammaFactor` (258), `rootNumber` (271), and `IsPrimitive.completedLFunction_one_sub` (283). The last theorem, applied with parameter `1-s`, gives

`completedL_chi(s) = c^(1/2-s) W_chi completedL_inverse(1-s)`.

Multiplying by `c^((s+a)/2)` gives precisely `Lambda_chi(s) = W_chi Lambda_inverse(1-s)`. No hidden conductor power remains. The use of the actual entire source completion, rather than a globally totalized Gamma product, is necessary and is correct in the producer note.

On `Re(s)>0`, the parity-specific Gamma factor is `GammaR(s+a)`. Its real part is positive. `Analysis/SpecialFunctions/Gamma/Deligne.lean:46` defines `GammaR(z)=pi^(-z/2) Gamma(z/2)`; line 69 gives `GammaR_ne_zero_of_re_pos`. Thus the source division identity transfers zeros between the actual L-function and its completion throughout the proposed strip. This does not assert such a transfer at a Gamma pole. The nonprincipal primitive hypothesis excludes conductor one and supplies entire continuation.

Substituting `y=exp(2v)` into the entire theta-Mellin identity gives

`F_sigma,0(t) = integral h_sigma(v) exp(itv) dv`,

where `h_sigma(w)=2 epsilon c^(-k/2) exp(k w) theta_chi(exp(2w))`. This confirms both the factor two and the indispensable `c^(it/2)` in the source-completed expression for F. With angular Fourier normalization `1/(2pi)`, positive tilt `exp(bt)` corresponds to `h_sigma(x+ib)`, not to the negative shift.

The initial theta-Mellin interchange is only in `Re(s)>1`. Exponential decay at infinity and reciprocal inverse-exponential decay at zero make that integral entire; analytic continuation then supplies the desired strip. There is no use of a conditionally convergent Dirichlet-series interchange on the off-critical line.

## Reciprocal and conjugate channels

The theta factor `exp(-2(a+1/2)w)` changes `exp(k w)` into `exp(-ell w)`. Therefore

`h_sigma,chi(w) = (epsilon_chi W_chi / epsilon_inverse) c^(1/2-sigma) h_(1-sigma),inverse(-w)`.

This changes all three relevant coordinates: character to its inverse, real part to `1-sigma`, and shift `b` to `-b`. The conductor factor is `c^(1/2-sigma)`. At `sigma=111/200` it is `c^(-11/200)`. Equations (6)-(8) retain these changes correctly. The direct negative-frequency series requires only the original epsilon, W, and inverse-character values; it does not require a compatible choice of the inverse character's root phase.

Conjugation is a different operation. It preserves sigma and gives equation (9), with phase ratio `epsilon_chi / conjugate(epsilon_inverse)`. Combining source functional equation and conjugation yields equation (10) only when `epsilon_chi^2 W_chi=1`: the coefficient becomes `epsilon_chi W_chi / conjugate(epsilon_chi)=1`. It relates two different real parts. It makes F real only at sigma one-half. An arbitrary unit epsilon is sufficient for the transform and the modulus estimates. Neither nonreal characters nor off-critical values have been replaced by real-valued data.

## Integrability and the asymmetric estimates

On each closed substrip `|Im w| <= B < pi/4`, principal logarithms satisfy `Log(exp(2w))=2w`. Both series estimates in (5) follow termwise because

`exp(-d_B n^2 exp(2r)) <= exp(-d_B exp(2r)) exp(-d_B(n^2-1))` for `r>=0`.

The remaining series converges. These estimates dominate each exponential prefactor at both ends. Cauchy estimates in a slightly larger substrip give corresponding derivative decay. This suffices for the vanishing vertical contour edges, differentiation under the integral, integrations by parts, Fourier inversion, Poisson summation, and absolute regrouping used subsequently. There is no unresolved new contour limit in this extension beyond the identified predecessor mathematics.

Using the two elementary positive Gaussian sums gives the common amplitude

`A_even=c^((1-sigma)/2)/sqrt(cos(2y))`,

`A_odd=2c^((1-sigma)/2)/(pi cos(2y))`.

The positive rate is `1-sigma`; the negative rate is `sigma`. In particular, on the negative side the reciprocal conductor factor combines as `c^(1/2-sigma)c^(sigma/2)=c^((1-sigma)/2)`. This checks a place where retaining the critical-line exponent would be wrong. Integration gives `A/[sigma(1-sigma)]`, and the first absolute moment gives `A[(1-sigma)^(-2)+sigma^(-2)]`. Both stated constants are correct.

Splitting half of each Gaussian exponent gives factors sqrt(2) and 2 for the even and odd cases. The resulting unequal Q functions have logarithmic slopes `-(1-sigma)-d exp(2r)` and `-sigma-d exp(2r)`. These prove monotonicity and the two distinct denominators in (16). Time decay has the unchanged rates `R-b` and `R+b`, but the enlarged prefactor `A/[sigma(1-sigma)]`. All integrations are valid for each fixed sigma strictly between zero and one; they are not uniform as sigma approaches an endpoint.

The folding range is the contiguous integer interval from `-(L+1/2)N` through `(L+1/2)N-1`. Thus positive omissions start at X and negative omissions at X+omega. Overcounting the latter from X is safe. The output multiplier is still omega times the unnormalized positive-exponent DFT, or omega*N times normalized `invDFT`. No additional phase, real-part projection, or omission of a signed channel is allowed.

For the truncated theta series, the ratio bound in (17) retains parity a. The numerator's worst exponent is `max(sigma+a,1-sigma+a)`, so the stated common-cutoff test checks both ends. The denominator improves with increasing absolute frequency. The complex norm error ledger adds omega times the sum of all coefficient errors; dependence between interval inputs does not invalidate this triangle inequality.

## Fixed-height scalar budget

The independent exact checks establish, under the stated `sigma in [89/200,111/200]`, `c<=300000`, `T>=1`, `cT<=10^8` domain:

* `sigma(1-sigma)>=9879/40000`, the amplitude ratio is below two, and the time-prefactor ratio is below three.
* The protocol's minimum time exponent is 96; `96*10^8*(3/8)^96 < 10^(-30)`.
* `d exp(2X)/2 > 200`, and `32*10^8*(3/8)^200 < 10^(-75)`. For clarity, each frequency bracket is less than `1+200/89<4`, each Q is at most `4cT exp(-200)`, and there are two signed tails. This derives the coefficient 32.
* For M=100000, `d(M+1)^2>300` and `d(2M+3)-1/(M+1)>1/200`. The latter proves the ratio claim using `log(1+x)<=x`. The elementary bound `1/(1-exp(-1/200))<=201` gives the numerator coefficient `402*(M+1)`.
* The series error is below `10^(-119)` per frequency. `omega*N<16pi<51` bounds its output and all uniform coefficient errors.

The final independent sum even charges `51*10^(-40)` for the stipulated normalized FFT error, in addition to `51*10^(-50)` for input rounding, and remains below `2*10^(-30)`. These are conditional arithmetic budgets. They do not prove that any future implementation attains its stipulated rounding errors or that any output ball misses zero. The fixed-height example cannot be carried into `cT>10^8` without redoing the sigma-dependent parameter inequalities.

## Contour interface and remaining work

The finite trigonometric sum with uniform tail bounds encloses all real t in a panel, not just sampled points. The derivative bound supplies another valid, potentially inefficient interpolation method. Both are sufficient mathematical interfaces; no actual panel data are produced here.

Across varying sigma, F includes the nonholomorphic positive scale `c^(-(sigma+a)/2) exp(bt)`. Recovering Lambda is the clean analytic interface. Alternatively, for one fixed epsilon and continuous tilt, the positive scale contracts to one through positive scales, so a nonzero closed boundary curve has unchanged winding. This is a boundary homotopy assertion, not a claim that F as a function of sigma and t is holomorphic. Arbitrarily discontinuous choices of epsilon between panels would require their own adapter.

The right edge sigma=2 is outside the elementary L1 estimates. A wider-domain theta bound or an independently certified explicit-EM evaluator is still required there. Horizontal connectors, closed vertices, orientation, all-panel nonvanishing, winding, and the transfer to analytic multiplicity remain explicit certificate work. Conductor-one theta constants and pole corrections remain excluded. No critical-line location, simplicity, historical GRH data, or hidden realness premise is used.

The accepted result is a complete paper-level sigma extension and a finite conditional error protocol. Its source adapters, rigorous interval implementation, actual coefficient enclosures, and successful whole-contour data remain unproved/unproduced in Lean. No canonical source or predecessor artifact was edited during this review.
