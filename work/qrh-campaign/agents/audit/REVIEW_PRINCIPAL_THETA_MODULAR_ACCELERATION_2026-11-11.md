# Independent review: principal theta modular acceleration

2026-11-11. **PASS at source and paper-algorithm scope. No correction is required.** The construction preserves the actual theta kernel, supplies a terminating reduction and convergent absolute-error evaluation for each fixed admissible point, and has a uniform terminal Gaussian tail. It does not establish production runtime, bit complexity, a numerical theta packet, or a spectral result.

## Frozen inputs and source checks

Reviewed `integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md`, independently verified SHA256 `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D`.

Its kernel target is the corrected xi evaluator `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, accepted in my review `ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2`. That prior review remains the source of the full xi Fourier, truncation, panel, and zero-order contracts. The present note only replaces pointwise kernel evaluation.

I read the relevant actual Mathlib source under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`:

| Source | SHA256 | Actual interfaces checked |
| --- | --- | --- |
| `NumberTheory/ModularForms/JacobiTheta/OneVariable.lean` | `7C29B4B07AED2E46D40FE408362F2A707126BFBBF05C3B374420AA0EDDF06B5C` | theta3 definition at 29, two-variable identification, period two, S identity at 43, positive-index series |
| `NumberTheory/ModularForms/JacobiTheta/TwoVariable.lean` | `CC4E420DA8441AD20DDBE3709040C4CFBEBB530C6DDD8E101FF2FC1F0B6F8820` | series normalization; periodicity/quasiperiodicity at 377–400; evenness in z; functional equation at 466; differentiation interfaces |
| `Analysis/Complex/UpperHalfPlane/MoebiusAction.lean` | `498AF5F9037BADFDA03DCDB1BEAE0CA106F037BB36B7F17D63DBBF66113F4AF5` | imaginary-part formula at 219/471, S at 302, integer T at 307 |

The existing subscript-2 function is the two-variable theta function, not classical theta2. The note explicitly distinguishes them. The three constant adapters, derivative jets, reduction algorithm, and interval replay are new mathematical constructions, not claimed existing compiled APIs. No Lean/Lake or high-height evaluation was run.

## Transformations and branches

The classical theta2 adapter is `exp(pi*i*tau/4)*Theta(tau/2,tau)`; theta4 is `Theta(1/2,tau)`. These agree term by term with the stated shifted and alternating series. At an integer translation, theta2 gains `exp(pi*i*n/4)`, while theta3/theta4 swap exactly for odd n. The proof uses the even integer k(k+1); it applies also to negative integer n. The same constant multiplier and permutation act on all tau derivatives.

The three S identities follow directly from the source two-variable functional equation. For theta2, substituting z=tau/2 cancels its exponential prefactor. For theta4, z=1/2 gives the transformed argument -v/2, where v=-1/tau; source evenness changes this to v/2 and the exponential is exactly the theta2 prefactor. There is no missing eighth root.

At every S step, `-i*tau` lies in the open right half-plane. Its source principal square root is nonzero and analytic there. The explicit formula using positive real `sqrt((|z|+Re z)/2)` and `Im z/(2u)` gives that branch without a sign decision on Im z. Retaining each local factor avoids an unproved global square-root cocycle. No arbitrary branch may be substituted merely because its square is correct.

## Derivatives and the actual P kernel

With A=(-i*tau)^(-1/2) and v=-1/tau, independent differentiation gives

```
A'/A = -1/(2tau),          A''/A = 3/(4tau^2),
v' = 1/tau^2,             v'' = -2/tau^3.
```

Thus the three displayed jet formulas, including the coefficient `-3/tau^3` of g' in f'', are correct. The derivatives of g are with respect to its own argument, which the note distinguishes from composition derivatives. The value component must remain in the jet: it enters the first and second derivative reconstruction even though it later cancels from P.

For tau=i*exp(2w), termwise differentiation gives

`P(w)=exp(w/2)[6tau*theta3'(tau)+4tau^2*theta3''(tau)]`.

I independently expanded the right side: its coefficients are -12*pi*n^2*exp(5w/2) and +8*pi^2*n^4*exp(9w/2), exactly the accepted source-xi kernel. There is no missing factor of two or change to the xi normalization. Normal convergence on compact upper-half-plane sets justifies the differentiated series; formalizing that second-derivative adapter remains work.

## Reduction and interval boundaries

The overlapping reduction is sound. Approximating the real part with error strictly below 1/10 and choosing a nearest integer to that rational approximation puts the exact translated real part strictly between -3/5 and 3/5, including rational ties. A certificate must verify this strict enclosure; no equality decision about the exact real part is required.

The tests Im>2/5 and Im<1/2 cover every positive imaginary part by open sets. At either boundary the other test is strict. Refining convergent enclosures while testing both therefore eventually certifies an admissible branch. During inversion the exact squared modulus is below 61/100, so the imaginary part increases by more than 100/61. Translation leaves it unchanged. Consequently the stated finite bound on the number of inversions follows, and the stopping domain has Im>2/5. Strict increase alone would not prove termination; the uniform multiplicative increase does.

For the specified quadrature inputs with known nonnegative real part after reflection, the initial imaginary part is at least 1/(T+1). I independently reproduced the least sufficient integer bounds 27 at T=1000000 and 35 at T=60343058, checking both the successful power inequality and its failing predecessor. These are bounds on inversion count only.

Reflection is convenient for those exact quadrature nodes; it is not required for the generic reduction algorithm. For a general computable point or enclosure straddling Re(w)=0, do not add an exact sign-decision prerequisite: run reduction at the original point using any certified positive lower bound on its imaginary part, or use local valid representations. The generic termination proof already supports this. The stronger example inversion counts apply when their stated initial lower bound is available.

Each successful pointwise word has a neighborhood where its strict branch conditions hold. The compact-panel discussion correctly adds the need for effective variation bounds and subdivision; mathematical compactness by itself is not an executable panel certificate. Different internal theta words compute the same exact kernel, so they do not change the external fixed-b xi normalization.

## Terminal tails and error propagation

At Im(tau)>2/5, pi>3 gives the uniform Gaussian exponent alpha=6/5. For derivative order j=0,1,2, split the exponential and maximize `t^(2j)*exp(-alpha*t^2/2)`. The stated M_j is a valid upper bound; dropping the additional factor exp(-j) only loosens it. The bound pi^j<4^j then gives the stated coefficient.

For theta2 the omitted positive half-integers start at u=N+1/2; for theta3/theta4 the first omitted integer N+1 is larger. The inequality `(u+k)^2>=u^2+(2u+1)k` for integer k>=0 proves the geometric denominator in (E). Both signs are covered by the factor two. The central integer term is treated correctly, and no central term is inserted into theta2. Thus the same tail tends to zero for every reduced point in the terminal domain and each of the three required derivatives.

The exact-coefficient jet error inequalities are the rowwise triangle inequalities for (J). With approximate coefficients, splitting against the computed jet centers adds coefficient-error times center-norm terms and rounding; a certified bound on the exact coefficient multiplies the incoming radius. The note also requires propagation of errors in the intermediate tau points, rather than treating rounded modular images as exact. This is essential and is retained.

After fixing a certified finite word, every reciprocal and square-root denominator is bounded away from zero. Refining the input, operation, and coefficient enclosures and increasing the series cutoff therefore converges to each exact reconstructed jet and P value. This is an absolute-error termination argument for a fixed point. It promises neither relative accuracy at a zero nor a useful fixed precision independent of the word.

## Independent scalar receipt and limits

Own script `audit/review_principal_theta_modular_20261111.py`, SHA256 `4EB236F2D51CF28D7B9678E0B11042CB33A527349FB267B6CC8E4D4DCA1C23B3`, exited zero. Its receipt is `audit/review_principal_theta_modular_20261111.json`, SHA256 `23C061DC1BB9E9A223548D4CFA9965A1D25AD7D6B09824974CA2E8B95ADA1FD8`. It checks only the exact growth constant and the two minimal sufficient integer inversion counts. No theta, L-function, Fourier, or spectral value is evaluated.

The source transformations and finite reduction remove the small-imaginary-part Gaussian-tail obstacle in mathematical terms. They do not yet bound the bit sizes of translations, condition numbers of reconstructed derivatives, precision loss, elementary-function work, or all-node data movement. The note appropriately declines an overall O(log T) runtime or end-to-end speedup claim. Those claims would need a further cost analysis or measurements.

The classical-theta source adapters, branch and jet lemmas, reduction replay, terminal series enclosures, and exact error propagation still need implementation and Lean proofs. The original Fourier quadrature, contour, order, and completeness certificates remain separate. Neither the family height 60343058 nor the distinct narrow-strip height 1000000 has been spectrally certified by this packet, and no new final-root assumption is introduced.
