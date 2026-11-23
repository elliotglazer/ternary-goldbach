# Independent review of the arbitrary-height finite-U extension

2026-11-11. PASS for the paper parameter construction and its conditional arithmetic contract. This does not certify any L-value, sign, contour, spectral row, production runtime or Lean theorem.

I read the complete [extension](../qrh-campaign/agents/prime-estimates/FINITE_U_AUXILIARY_EXTENSION_2026-11-11.md), SHA256 `F96610CCC7D7F1B094DB3B9D3D287858AD7C0C38D819AB9B39AFA89946A6B855`, its complete scalar script and receipt, and the reused finite-U, character/height and pole-difference formulas. All nine reused-artifact hashes match. The source formula remains the actual nonprincipal L-function through the common-pole-subtracted Hurwitz combination. There is no extra conductor power or multiplication by s-1.

## Analytic bounds and finite parameter choice

I independently derived `N=ceil(V)+2M+4`, the coarse bound `4X*36^(-M)` for the EM error, and the finite-function outer bound `2X^2`, before receiving the author's formulas. The author's sharper EM denominator is correct: on the target disk sigma>=197/400, so sigma+2M-1>=2M-203/400>0. All rising factors are strictly smaller than N; the 1/c remainder factor cancels only after the upper bound phi(c)/c<=1. The endpoint-power estimate explicitly handles sigma>1 by taking a maximum with1. It follows that

`E_M=4X/[36^M*(2M-203/400)]`

is a valid strict upper bound, with no cV cap. The ratio E_(M+1)/E_M is below1/18. Since E_1<c*(ceil(V)+7), the displayed bit-length cap gives a passing M by a finite integer search. This is a uniform proof for all stated inputs; the sample calculations below are supplementary checks.

The head, half term, every Bernoulli correction, and the entire pole-difference term are retained in the outer bound. The geometric correction estimate remains valid for arbitrary M. With N>=6, the outer estimate is less than2X^(3/2)<=2X^2. Cauchy's estimate for normalized coefficients therefore gives `T_K=32X^2/(15*16^K)`. The bit-length K cap pays T_K<=eps/8. It is applied to the entire finite function F, not to derivatives of an unjustified pointwise L-function error.

The time-batching remainder is separately paid by `2X/P!<=eps/8`. The factorial bound P!>=2^(P-1) proves the proposed finite cap. This argument retains the actual signed time index and both transform normalizations from the tensor construction.

For the pole correction, the normalized h-th jet includes the full convolution over k, with coefficient `ell^(h-k)*d^k/((h-k)!*k!)`. The moment remainder has denominator Q!*(Q+k+1). Summing the convolution gives `(ell+d)^h/h!`, so the author's common coefficient bound

`3X*q_X^(K-1)/(N*Q!*(Q+1))`

is valid for every h<K. It uses |z|<1, |E|<=X, exp(max(0,Re z))<3, log(X_a)<q_X and phi(c)/c<=1. The Q cap follows from the same factorial inequality. No omitted Taylor coefficient is counted as covered by this pole moment bound; the whole F Taylor tail is separate. At a=1 the correction vanishes exactly; no inference from an interval containing zero is required.

## Arithmetic and grid joins

The input-moment errors and normalized-transform errors contribute eps/256 per retained coefficient after multiplying by phi(c)*Ltime and summing P modes. Contraction adds another eps/256. The complete correction allowance and final assembly bring the coefficient allowance to eps/32. Its disk contribution is at most eps/30. With final evaluation allowance eps/8 and coordinate-square padding for the three analytic tails, the complete bound is

`(9/16+1/30+1/8)*eps=173*eps/240<3*eps/4`.

These are requirements on future arithmetic certificates. A fixed precision, old saved interval or an unverified FFT is not asserted to satisfy them. Hardy-function normalization, including error multiplication by Gamma/conductor/root-phase factors, remains separate.

The common grid uses work height V=ceil(32U)/32, rather than underestimating the last center by using U. Its nearest-point distance is at most1/64. Both selected center abscissae differ from1/2 by at most3/50, and `(3/50)^2+(1/64)^2<(1/16)^2`. Thus every critical-line point through U is inside a proved disk. This is one vertical column, not a complete right-rectangle cover or a sign/count certificate. All inverse-character and inclusive-endpoint obligations remain.

## Independent scalar evidence and status

The [independent checker](review_finite_u_auxiliary_20261111.py), SHA256 `F3883BE22583B51F5871ED55B9C0C3A944A63CCD4D3C97102460CBF8F7511059`, imports no producer code and writes no files. It checks the six saved cases using exact fractions, integer powers and a separately constructed factorial. All284 comparisons passed: work-height rounding, parameter equations, stored error bounds, chosen-order minimality, cap sufficiency, EM decay ratios, total error and grid geometry.

The producer script and receipt hashes are `021046F6556AD7B7E1B1558D2F262D207853CC8F5154E9DC87933CF30983642C` and `978D65992310A5F871F2104F5E88D0BC6F18D4F13F759EEADFDF71FB7A2A89EB`. For c=300000, U=1330 and eps=2^-68, the checked choices are M19, N1372, K33, P29, Q56. These are parameter witnesses only, not produced function values or proposed feasible full arrays.

This removes the old cV<=10^8 restriction from the paper finite-U allocation. It does not remove a character, change the selected spectral profile, establish a nonvanishing margin, or close any standard-axiom Lean implementation obligation. No source edit, build, special-function evaluation or prior frozen-artifact modification was performed.
