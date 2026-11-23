# Exact elementary interval certificates for spectral calculations

Date: 2026-11-11. Research plan only. No Lean declarations, builds, dependency changes, or edits to frozen files were made. No interval checker is claimed implemented. Source APIs were inspected in Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679` and Goldbach commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

The proposed trust boundary is a finite witness generator followed by a proved checker. An external program may choose rational bounds, dyadic precision, a truncation length, a range-reduction integer, or a polynomial evaluation schedule. The checker verifies the supplied witness using exact integer/rational inequalities. Its soundness theorem relates acceptance to the actual real or complex function. It need not prove that a search algorithm always finds a witness at every requested precision.

External FLINT/Arb or floating-point results may propose witnesses; their answers are never theorem premises. `native_decide` is not part of the acceptance path. The finite Boolean arithmetic must be checked by the kernel, for example with `decide +kernel`, and then consumed by ordinary soundness lemmas. Hashes establish file identity, not mathematical truth.

## 1. Meaning of a certificate

A real interval has rational endpoints `a<=b` and denotes the closed set of real `x` with `(a:Real)<=x<=(b:Real)`. A complex rectangle is a pair of such intervals, constraining real and imaginary parts independently. A point certificate is the special case of a degenerate input interval. Every function certificate must state whether it encloses one exact point or **every point in an input interval/rectangle**. Checking finitely many sampled values does not establish the latter.

Use signed integer numerators and strictly positive natural denominators, or ordinary `Rat`. Coprimality of a numerator and denominator is unnecessary for soundness if the former representation is chosen. A dyadic endpoint is `m/2^p`, with `m:Int` and `p:Nat`; it is an exact rational, not a machine float. Positivity of denominators and well-formed interval order are checked.

For `q=n/d`, `d>0`, proposed dyadic bounds `l=m/2^p` and `u=k/2^p` are accepted precisely when

`m*d <= n*2^p <= k*d`.

These are signed-integer comparisons. The checker does not need a trusted rounding implementation. The generator can supply any outward bounds; proving the comparisons is sufficient. Rounding each intermediate interval outward preserves containment by transitivity. Never use truncated natural subtraction to detect a negative error or failed lower bound.

An acyclic certificate graph can reference earlier enclosures and give a tag identifying the exact operation at each node. Its generic soundness proof is structural induction over the finite graph or an ordered list whose references are earlier indices. Missing inputs, invalid indices, zero denominators, unmet domains, or reversed bounds cause rejection. Finite structural recursion is enough; no numerical convergence or search-termination theorem is required for the generator.

## 2. Rational and complex arithmetic

For real input intervals `X=[a,b]`, `Y=[c,d]`, the following exact enclosures suffice:

| Operation | Raw rational enclosure before optional outward rounding |
| --- | --- |
| `x+y` | `[a+c,b+d]` |
| `-x` | `[-b,-a]` |
| `x-y` | `[a-d,b-c]` |
| `x*y` | Minimum and maximum of `ac,ad,bc,bd` |
| `x^2` | Upper bound `max(a^2,b^2)`; lower bound zero if `a<=0<=b`, otherwise `min(a^2,b^2)` |
| `1/x` | `[1/b,1/a]`, only if `b<0` or `0<a` |
| `x/y` | Multiply `X` by the accepted reciprocal interval for `Y` |

The four-corner multiplication rule is proved by the ordered-field inequalities, with sign cases if necessary. It remains sound when the same variable occurs in both operands; the result may merely be wider. The optimized square rule is useful for lower norm bounds and must not be replaced by a lower bound from multiplying an interval by itself when it crosses zero.

Represent a rational complex point by a pair of rationals and interpret it as `a+b*I`. Use the exact complex coordinate equations

`Re(zw)=Re(z)Re(w)-Im(z)Im(w)`,

`Im(zw)=Re(z)Im(w)+Im(z)Re(w)`.

The real interval operations then prove rectangle addition, multiplication, and conjugation. These equations are field identities, independent of numerical approximation.

For reciprocal and norm, first enclose `s=Re(z)^2+Im(z)^2` using the square rule. If the lower bound `s_lo` is strictly positive, `z!=0` follows and

`1/z = (Re(z)-Im(z)*I)/s`

gives a rectangle via the real reciprocal rule. A rectangle containing zero cannot use this certificate. A larger input domain may be split into finitely many rectangles; coverage of the split must itself be proved. `Complex.norm_def` in `Mathlib/Analysis/Complex/Norm.lean:31` identifies the norm with `sqrt(normSq z)`, and `normSq_eq_norm_sq:149` gives `normSq z = norm(z)^2`. Thus the same squared bounds certify a norm interval or a strict nonzero lower bound. A positive rational `r` with `r^2<=s_lo` proves `r<=norm(z)` without computing a square root.

All integer powers are finite products. A repeated-squaring witness may reduce expression size, but each multiplication and exponent identity must be checked. Negative integer powers also require the reciprocal's nonzero-domain certificate. No complex logarithm is needed for integer powers.

## 3. Square roots

For a real interval `X=[a,b]` restricted to `0<=a<=b`, proposed output `[l,u]` is sound if

`0<=l<=u`, `l^2<=a`, and `b<=u^2`.

Then `l<=sqrt(x)<=u` for every `x in X`. This includes `a=0` and requires no strict positivity of the input. Existing pinned APIs are `Real.le_sqrt`, `sqrt_le_left`, and `sqrt_le_iff` in `Mathlib/Analysis/Real/Sqrt.lean:223–240`, plus `sq_sqrt:177`. Their nonnegativity conditions match the comparisons above. This checker deliberately restricts its domain to nonnegative inputs; it does not silently use Lean's totalized square-root behavior for negative values.

## 4. Pi from Machin's identity and alternating arctangent bounds

Let `A_N(t)=sum_{j=0}^{N-1} (-1)^j*t^(2j+1)/(2j+1)`. On `0<=t<1`, the terms `t^(2j+1)/(2j+1)` are nonnegative, antitone, and summable by comparison with a geometric series. The pinned source provides:

* `Real.hasSum_arctan`, `Mathlib/Analysis/SpecialFunctions/Complex/Arctan.lean:144`, for `abs(t)<1`;
* `Antitone.alternating_series_le_tendsto` and `Antitone.tendsto_le_alternating_series`, `Analysis/SpecificLimits/Normed.lean:1007,1021`;
* `alternating_series_error_bound` in the same file at line 1041, with antitone and summable hypotheses.

These give the concrete certificates

`A_(2m)(t) <= arctan(t) <= A_(2m+1)(t)`

and

`abs(arctan(t)-A_N(t)) <= t^(2N+1)/(2N+1)`.

The one-step gap is the omitted term. Negative rational arguments can use `Real.arctan_neg` and interval negation; Machin's formula needs only positive arguments `1/5` and `1/239`. The endpoints `t=1` and `t=-1` are outside the stated power-series API and are not silently admitted.

`Real.four_mul_arctan_inv_5_sub_arctan_inv_239`, `Mathlib/Analysis/SpecialFunctions/Trigonometric/Arctan.lean:336`, proves the exact identity

`pi = 16*arctan(1/5)-4*arctan(1/239)`.

If the two arctangents have certified intervals `[a,b]` and `[c,d]`, pi belongs to `[16a-4d,16b-4c]`. The reversed endpoint for the negative coefficient is essential. Only finite rational sums and comparisons remain for an individual pi certificate. No previously supplied decimal value of pi is assumed.

There is also an existing independent route in `Mathlib/Analysis/Real/Pi/Bounds.lean` using nested square-root witnesses. It need not be introduced into this checker because Machin's identity and alternating-series bounds already provide the requested arbitrary finite accuracy. Neither route implies a measured checker runtime.

## 5. Exponential by Taylor reduction and verified squaring

For `N>=1`, put `E_N(t)=sum_{j=0}^{N-1} t^j/j!`. The pinned `Real.sum_le_exp_of_nonneg` and `Real.exp_bound'` give, for `0<=t<=1`,

`E_N(t) <= exp(t) <= E_N(t)+R_N(t)`,

`R_N(t)=t^N*(N+1)/(N!*N)`.

The general signed real version `Real.exp_bound` gives the absolute-error bound with `abs(t)` under `abs(t)<=1`. Both are in `Mathlib/Analysis/Complex/Exponential.lean:516–523`. The coefficient follows by bounding the omitted factorial tail; it is not just the first omitted term.

For an exact rational `x>=0`, the generator supplies `k:Nat` with `t=x/2^k<=1/2`, a positive truncation length, and a sequence of rational or dyadic intervals. Check the equality defining `t` and the reduced-domain comparison. Certify the Taylor interval for `exp(t)`, then perform `k` outward-rounded squarings on nonnegative intervals. The identity `exp(2u)=exp(u)^2`, from `Real.exp_nat_mul`, proves the final enclosure for `exp(x)`. Lower bounds remain positive since `E_N(t)>=1`; a certificate may additionally check this positivity explicitly.

For `x<0`, apply the positive route to `-x` and invert its positive output interval using `Real.exp_neg`. This correctly reverses bounds. For a nondegenerate real input interval `[a,b]`, certify `exp(a)` and `exp(b)` separately, then use monotonicity to obtain a uniform enclosure. A single Taylor expansion at the midpoint with no input-error term would not suffice.

The source already has fixed-degree instances: `Prelim/SmallPsi.lean` defines `T12` and `ELpow`; `SmallMertens.lean` defines `T12up` and `EHpow`. Their proofs establish the degree-11 case with tail `13*t^12/(12*12!)`. `Explicit/WeilNumC.lean` consumes rational exponential/log certificates. These are reusable examples, but their fixed decimal enclosure of `exp(1)` is not adequate by itself for arbitrary requested precision. The variable-degree, range-reduced route avoids that fixed accuracy limit.

An alternative complex exponential bound, useful below, is already proved as `Complex.exp_bound'`, `Analysis/Complex/Exponential.lean:407`:

if `norm(z)/(N+1)<=1/2`, then

`norm(exp(z)-sum_{j<N} z^j/j!) <= 2*norm(z)^N/N!`.

The stronger unit-disc form `Complex.exp_bound:377` gives `norm(z)^N*(N+1)/(N!*N)` when `norm(z)<=1` and `N>=1`. The Goldbach source uses the first of these in `MinorArcs/Eta2DDTaylor.lean:110`, `norm_cexp_sub_TN`.

## 6. Logarithms: an existing atanh bound or exponential inversion

All real log interval certificates in this plan require a strictly positive input interval `[a,b]`, `0<a`. They do not cover the totalized logarithm at zero or a complex branch of logarithm.

For an exact rational `x>0`, a generator may supply `k:Int` and rational `y` with `x=2^k*y` and `1<=y<=2`. Verify that equality and those inequalities exactly. `Real.log_mul` and `log_zpow`, `Mathlib/Analysis/SpecialFunctions/Log/Basic.lean:133,297`, give

`log x = k*log 2 + log y`.

Compute `log 2` by the same elementary series below with `y=2`. For `y=1`, use `log 1=0`. For `y>1`, set `t=(y-1)/(y+1)`, so `0<t<=1/3`. The exact enclosure is

`L_N(t) <= log y <= L_N(t)+D_N(t)`,

`L_N(t)=2*sum_{j=0}^{N-1} t^(2j+1)/(2j+1)`,

`D_N(t)=2*t^(2N+1)/((2N+1)*(1-t^2))`.

This has an existing source theorem with exactly the needed tail: `TernaryGoldbach.Prelim.RamPf.log_one_add_inv_bounds`, `Prelim/RamareHarm.lean:31`. Substitute `alpha=1/(y-1)>0` into its `log(1+alpha^-1)` formula. Then `1/(2alpha+1)=t`. Its proof uses `Real.hasSum_log_one_add_inv`, `Mathlib/Analysis/SpecialFunctions/Log/Deriv.lean:398`, and compares the tail termwise with a geometric series of ratio `t^2`. Every omitted denominator is at least `2N+1`, giving the displayed tail. `N=0` is mathematically allowed; an implementation may require `N>=1` for convenience as an explicitly checked witness restriction.

Multiplying the `log 2` interval by a negative `k` reverses its endpoints. Use ordinary interval multiplication rather than assuming `k>=0`. For a real input interval, certify both rational endpoints and use log monotonicity. This avoids needing a single binary scaling valid on the whole interval.

As an alternative that adds no series theorem, the generator supplies rational candidate log bounds `[l,u]`, an upper exponential bound `U_l>=exp(l)`, and a lower exponential bound `L_u<=exp(u)`. Check

`U_l <= a` and `b <= L_u`.

Then `exp(l)<=x<=exp(u)` for every `x in [a,b]`, so `l<=log x<=u`. This direction is important: an exponential **lower** bound at `l` is insufficient to certify the lower logarithm bound. The exact APIs are `Real.le_log_iff_exp_le` and `Real.log_le_iff_le_exp`, `Log/Basic.lean:165,161`.

`Prelim/LogWalk.lean` already demonstrates exact outward rounding of atanh terms, including a separate allowance for each truncated integer division. The generic checker can avoid accumulating guessed rounding budgets by checking every proposed dyadic interval against the exact rational expression instead.

## 7. Sine and cosine with certified pi reduction

For a real input interval `X`, the generator supplies an integer `k`, a certified pi interval `P`, and a rational interval `Y` enclosing `X-2*k*P` by the interval rules. For every actual input `x in X`, the **exact** reduced argument `y=x-2*k*pi` then lies in `Y`. The checker must propagate pi's uncertainty multiplied by `2*abs(k)`; replacing pi with a midpoint in this step is unsound.

`Real.sin_add_int_mul_two_pi` and `cos_add_int_mul_two_pi`, `Mathlib/Analysis/SpecialFunctions/Trigonometric/Basic.lean:273,356`, give `sin x=sin y` and `cos x=cos y`. The generator can aim for `Y` inside `[-4,4]`; the checker only accepts when it proves that containment. A wide interval may require subdivision. The checker does not claim that one supplied integer reduces every possible input interval.

Choose rational `R>=0` with `Y` inside `[-R,R]` and a positive integer `N` such that `R/(N+1)<=1/2`. Define finite real polynomials

`C_N(y)=sum_{2j<N} (-1)^j*y^(2j)/(2j)!`,

`S_N(y)=sum_{2j+1<N} (-1)^j*y^(2j+1)/(2j+1)!`.

These are exactly the real and imaginary parts of `sum_{j<N} (I*y)^j/j!`. Applying `Complex.exp_bound'` to `I*y` gives both uniform coordinate bounds

`abs(cos y-C_N(y)) <= 2*R^N/N!`,

`abs(sin y-S_N(y)) <= 2*R^N/N!`.

The proof uses `norm(I*y)=abs(y)`, `abs(Re w)<=norm(w)`, and `abs(Im w)<=norm(w)`, plus the exact parity cycle of powers of `I`. Evaluate the finite polynomials over all of `Y` with interval Horner operations and enlarge both outputs by the rational tail. This handles nonmonotonicity of sine and cosine; evaluating only endpoint function values would not.

For the convenient choice `R=4`, `N>=7` discharges the tail theorem's ratio premise. The generator is free to choose a larger `N` for accuracy or a smaller proved `R`. No new alternating trigonometric-series theorem is required. The existing low-degree `Real.sin_bound` and `cos_bound` are also sound on `abs(y)<=1`, but they are not the variable-precision interface proposed here.

## 8. Complex exponentials, positive-base powers, and roots of unity

`Complex.exp_re` and `exp_im`, `Mathlib/Analysis/Complex/Trigonometric.lean:522,526`, identify

`Re(exp z)=exp(Re z)*cos(Im z)`,

`Im(exp z)=exp(Re z)*sin(Im z)`.

Thus the previous real interval checks give a uniform rectangle enclosure for the complex exponential on any rectangle for which the supplied real and trigonometric witnesses pass. Alternatively, on a bounded rectangle, certify `norm(z)<=R`, evaluate the complex Taylor polynomial by rectangle Horner arithmetic, and add `[-E,E]` in each coordinate with `E=2*R^N/N!` under `R/(N+1)<=1/2`. A disc norm error implies these coordinate errors; a coordinate error pair of size `E` does not conversely imply a norm error of size `E` without a further factor or squared-norm check.

For positive real `r` and complex `s`, the source complex power is exactly

`(r:Complex)^s = exp((log r:Complex)*s)`.

Use `Complex.cpow_def_of_ne_zero`, `Mathlib/Analysis/SpecialFunctions/Pow/Complex.lean:40`, and `Complex.ofReal_log`, `SpecialFunctions/Complex/Log.lean:71`, under `r>0`. This supplies the common finite Dirichlet-sum terms `n^(-s)` for `n>=1`, as well as positive-base real powers through the corresponding real identity. If the base varies over a positive interval, enclose its real log and apply the same operations uniformly. Arbitrary complex bases and noninteger exponents require a branch-aware complex-log certificate; this plan does not silently extend the positive-base identity to them.

For integers `k` and natural `m>0`, define the exact source value

`zeta_(m,k)=exp(2*pi*I*(k/m))`.

Here `k/m` is division after casting into the rational or complex field, never integer quotient. Its interval is obtained from the pi and trig certificates. For argument reduction the generator may supply integers `j,r` with `k=j*m+r` and `2*abs(r)<=m`; check those integer relations. Then `zeta_(m,k)=exp(2*pi*I*(r/m))`, whose real angle lies between `-pi` and `pi`. The interval certificate must enclose this exact exponential, not merely some complex number close to a root of `z^m-1`.

The algebraic root property follows separately from exponential periodicity. When primitivity is required, pinned Mathlib already provides `Complex.isPrimitiveRoot_exp_of_isCoprime` for integer `k`, and `isPrimitiveRoot_exp_of_coprime` for natural `k`, in `Mathlib/RingTheory/RootsOfUnity/Complex.lean:46,60`, with `m!=0` and the exact coprimality condition. `isPrimitiveRoot_exp_rat:64` identifies the order of `exp(2*pi*I*q)` with the reduced denominator of `q`. No coprimality or exact order can be inferred just from a small interval enclosure.

For character sums, the numerical expression must first be proved equal to the actual character value or actual finite sum in the spectral theorem. A table of approximate roots of unity does not by itself define or certify the correct character, parity, conductor, or indexing.

## 9. Finite polynomial coefficients and evaluation semantics

Specify a coefficient list as the exact polynomial

`p(z)=sum_{j=0}^{d} c_j*z^j`,

with coefficients ordered from constant term upward. A reverse traversal beginning at `c_d` and replacing `h` by `c_j+z*h` evaluates the same polynomial by finite induction. Every rectangle operation may be rounded outward with the rational inclusion check from section 1. For an existing Mathlib polynomial, `Polynomial.eval_eq_sum_range'` and `eval₂_eq_sum_range'`, `Mathlib/Algebra/Polynomial/Eval/Degree.lean:67,49`, require an explicit degree bound; do not omit coefficients above the supplied list without that proof.

For exact rational-complex coefficients, interpretation uses the rational casts and `a+b*I`. For coefficients containing roots of unity, logarithms, exponentials, or other elementary values, the coefficient certificate graph must prove that **the actual coefficient** lies in the stated rectangle. The Horner soundness theorem can take those enclosure proofs internally, but an eventual spectral theorem must discharge them from the coefficient's source formula. Arbitrary supplied coefficient boxes are not numerical evidence for a source-defined polynomial.

If an analytic function is approximated by this polynomial, the finite coefficient semantics and its analytic remainder theorem are separate obligations. The elementary checker does not prove that supplied coefficients equal derivatives divided by factorials, does not supply a Gamma-function enclosure, and does not establish an L-function's analytic continuation or zero count. It can check finite elementary expressions and already justified polynomial/tail formulas. Rouché, argument-principle, interval-Newton, or contour nonvanishing applications still require their own exact source hypotheses and boundary coverage proofs.

## 10. Small coherent implementation order

1. Prove rational/dyadic interpretation, interval inclusion, ordered-field arithmetic, complex rectangle operations, and finite graph/Horner soundness. Closed arithmetic certificates use kernel decisions. Handle zero exclusions explicitly.
2. Prove the square-root comparison wrapper. Prove the arctangent finite-sum wrapper from the existing series and alternating bounds, then combine it with the existing Machin identity for pi certificates.
3. Wrap the existing variable-degree exponential remainder in positive range reduction, repeated squaring, and inversion. Wrap `RamPf.log_one_add_inv_bounds` for positive rational arguments and optional binary scaling; exponential inversion is a second log certificate mode.
4. Prove the uniform sine/cosine polynomial error wrapper from `Complex.exp_bound'` and exact integer-period reduction. Combine it with real exp for complex exponential rectangles.
5. Add positive-base powers and exact roots-of-unity interpretation, then the finite coefficient-to-source-expression bridges needed by a particular spectral certificate. Only then connect to the analytic spectral argument.

The proposed contracts belong in a research plan until the author approves actual source-faithful declarations. No `sorry`, new axiom, interval oracle, or additional unproved numerical premise is authorized. A source-level dependency inventory and small example checks do not establish implementation feasibility or axiom closure. All implementations should use bounded proof tasks and default resource limits; no runtime prediction is made here.

## 11. Four exact witness checks performed for this note

A small standard-library Python calculation using `Fraction`, integer powers, factorials, and comparisons checked these concrete witness inequalities. It did not call a floating-point elementary function, regenerate primes, or run Lean. The analytic validity comes from the source lemmas above; this exercise only confirms that the displayed finite rational witnesses fit their proposed output boxes.

* **Pi:** use `[A_16(1/5),A_17(1/5)]` and `[A_6(1/239),A_7(1/239)]`. The Machin interval is contained in `[314159265358979323846,314159265358979323847]/10^20`.
* **Exp(1):** use `t=1/2`, `N=20`, and square `[E_20(t),E_20(t)+t^20*21/(20!*20)]`. The result is contained in `[27182818284590452353602,27182818284590452353604]/10^22`.
* **Log(2):** use `t=1/3`, `N=12`, and `[L_12(t),L_12(t)+2*t^25/(25*(1-t^2))]`. It is contained in `[693147180559,693147180561]/10^12`.
* **Sqrt(2):** the rational endpoints `[1414213562373095,1414213562373096]/10^15` are nonnegative and their squares bracket 2.

All four comparisons passed. They are examples of accepted rational data for the planned soundness wrappers, not implemented or kernel-checked certificates.
