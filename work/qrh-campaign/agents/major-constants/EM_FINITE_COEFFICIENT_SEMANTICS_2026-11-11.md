# Finite EM Taylor coefficient semantics

2026-11-11. Complete paper derivation of the finite coefficient rules and their interval inclusion invariant. This note creates no Lean declaration and runs no numerical evaluator or build. The proposed lemma statements are mathematical proof tasks, not author-approved Lean anchors. Native `acb_series` execution is not treated as a trusted proof operation.

The source pin is `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`; pinned Mathlib is `56a005855ea17e0b0958f73ec801ae140b0a1679`. The matching cache inspected is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. The reviewed EM identity is in `EM_SOURCE_PROOF_PLAN_2026-11-11.md`, SHA256 `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`; its independent review is `moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md`, SHA256 `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1`.

## 1. Exact producer expressions

The inspected producers are:

| File | SHA256 |
| --- | --- |
| `agents/mellin/psi_head_counts_20261111.py` | `D7F187FA357EACA184A2214F8952B396B9D2DF42348580993005B7DA00252A9A` |
| `agents/zero-sum/em_top_horizontal_20261111.py` | `F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10` |

In both scripts, let B=N+1, M=32, K=24 and `b_k=B_(2k)/(2k)!`, where `B_j` denotes the ordinary Bernoulli number with `B_1=-1/2`. Their finite entire function is exactly

```
D(s) = Σ_{n=1}^{N} exp(-s log n)
       + (1/2) exp(-s log B)
       + exp(-s log B) Σ_{k=1}^{M} b_k B^(1-2k) (s)_(2k-1),
g(s) = (s-1)D(s) + exp((1-s)log B).
```

The rising factorial is `(s)_r=∏_{j=0}^{r-1}(s+j)`. The half term belongs inside D and is multiplied by s-1. The exponential pole-removal term lies outside that multiplication. These parentheses are essential.

Head `Evaluator.__init__`, `finite` and `Model.__init__`, at lines 56-76 and 99-109, sum n=1,…,N, retain the odd rising-factorial lengths 1,3,…,63 and extract array indices 0,…,23. For the height-1500 certificate, N=500 and B=501. Head models have arbitrary rational complex centers and actual radius at most 1/10; their Cauchy radius is 1.

Top-path lines 10, 28-47 set `T=1000000`, `N=ceil(T/3)=333334`, `B=333335`, and use the same finite expression. The six exact centers are

`c ∈ {5/8,7/8,9/8,11/8,13/8,15/8} + i·1000000`.

The actual block radius is 1/8, the Cauchy radius is 1, and the coefficient indices are again 0,…,23. N is not 333333 and B is not N. The producer's Python integer/series initialization does not change these mathematical indices.

Both arrays are ordinary power-series coefficients. The intended entry j is `g^(j)(c)/j!`. They are not raw derivatives, and Horner evaluation must not divide them by j! a second time.

## 2. Exact coefficient recurrences

Fix an exact center c∈ℂ. Write the local variable as z=s-c. All coefficients below are exact complex numbers. Define a coefficient with a negative index to be zero; an implementation can instead use an explicit j=0 branch.

For a positive real base n and `ℓ_n=log n`, define

`E_n[0]=exp(-cℓ_n)`,

`E_n[j+1]=(-ℓ_n)E_n[j]/(j+1)`.

Induction gives

`E_n[j]=exp(-cℓ_n)(-ℓ_n)^j/j!`,

and the exponential addition law and its convergent power series give

`exp(-(c+z)ℓ_n)=Σ_{j≥0}E_n[j]z^j`.                         (E)

For n=1, ℓ_1=0, so E_1[0]=1 and every higher coefficient is zero. An interval implementation need only enclose these exact values; it may also use this simplification.

For the pole-removal term use a separate array

`H[0]=exp((1-c)ℓ_B)`,

`H[j+1]=(-ℓ_B)H[j]/(j+1)`.

Thus `exp((1-c-z)ℓ_B)=Σ H[j]z^j`. One may prove `H[j]=B E_B[j]`, but the producers compute the two constant exponentials separately. Their interval enclosures need not satisfy that identity as equal boxes. Soundness requires that each contains its own exact value, not that separately rounded arrays are identical.

Let P_r[j] be the coefficient of z^j in `(c+z)_r`. Initialize

`P_0[0]=1`, `P_0[j]=0` for j>0,

and update

`P_(r+1)[j]=(c+r)P_r[j]+P_r[j-1]`.                         (P)

This follows by multiplying the polynomial by `c+r+z`. It proves by induction that P_r[j]=0 for j>r and that every retained entry is the exact shifted rising-factorial coefficient. Each update must use the old array, or an equivalent correctly ordered in-place operation. An ascending in-place update that reuses an already changed `P_r[j-1]` would be wrong.

For 0≤j<K define

```
A[j] = Σ_{k=1}^{M} b_k B^(1-2k) P_(2k-1)[j],
D[j] = Σ_{n=1}^{N} E_n[j] + (1/2)E_B[j]
       + Σ_{r=0}^{j} E_B[r] A[j-r],
G[j] = (c-1)D[j] + D[j-1] + H[j].
```

Then G[j] is the coefficient of z^j in g(c+z). This is the full source expression, including the shift contributed by multiplication by s-1. The D[j-1] term is zero at j=0.

The products `b_k B^(1-2k)` are rational when B is rational. Their signs are not replaced by absolute values in coefficient computation. Absolute values appear only in norm upper bounds for Cauchy remainders.

### 2.1. Why truncation after every operation is exact below degree K

For coefficient sequences a,b, define their product coefficient by

`(a*b)[j]=Σ_{r=0}^{j}a[r]b[j-r]`.

If j<K, every input index used on the right is also below K. Consequently replacing both inputs by their first K entries leaves every output below K unchanged. Addition, scalar multiplication and multiplication by an affine factor have the same property. Induction through the expression tree proves that discarding entries of degree K and above after every finite operation has no effect on the first K coefficients.

This is a formal coefficient statement. It does not claim that the truncated polynomial equals g as a function. Its analytic tail is handled separately in section 6.

For exponential series of a general analytic input `A(z)=Σ a_j z^j`, the corresponding local rule is

`e_0=exp(a_0)`, `e_n=(1/n)Σ_{j=1}^{n} j a_j e_(n-j)` for n≥1.

It follows from `(exp A)'=A' exp A` and coefficient comparison, and determines e_n using only a_0,…,a_n. The head and top scripts need only the affine specialization a_j=0 for j≥2, which is exactly (E). No logarithm of a power series, reciprocal of a series, or division by its variable is needed for these finite jets.

## 3. Identification with analytic Taylor coefficients

There is a direct source-backed route that does not depend on the numerical series library.

For analytic f near c set `J_j(f,c)=iteratedDeriv j f c / j!`. Pinned Mathlib `Analysis/Calculus/IteratedDeriv/Lemmas.lean:418` proves the Leibniz formula

```
iteratedDeriv n (f*g) c = Σ_{i=0}^{n}
  choose(n,i) · iteratedDeriv i f c · iteratedDeriv (n-i) g c,
```

under the required finite differentiability hypotheses. All functions used here are entire, so those hypotheses hold. Divide by n! and use

`choose(n,i) i! (n-i)! = n!`, `0≤i≤n`.

This yields exactly `J_n(fg,c)=Σ_i J_i(f,c)J_(n-i)(g,c)`. The same file gives derivative additivity at line 309 and constant multiplication at line 366. Constants and the affine function s↦s have their usual finite derivative arrays. Repeated differentiation of `exp(-sℓ)` gives `(-ℓ)^j exp(-sℓ)` and hence (E); recurrence (P) follows from the product rule with an affine factor. Thus the G[j] computed in section 2 equals `J_j(g,c)` for every retained j.

Pinned `Analysis/Calculus/IteratedDeriv/Defs.lean:339` states exactly

```
AnalyticAt.hasFPowerSeriesAt (h : AnalyticAt ℂ f c) :
  HasFPowerSeriesAt f
    (FormalMultilinearSeries.ofScalars ℂ
      (fun n => iteratedDeriv n f c / n.factorial)) c.
```

`FormalMultilinearSeries.ofScalars` is defined in `Analysis/Analytic/OfScalars.lean:38`; `coeff_ofScalars` at line 85 recovers the scalar coefficient without another factorial. These facts identify the exact G array with the actual analytic Taylor series.

Global convergence for this particular g can be established directly. Each exponential expansion is absolutely convergent for every z; the remaining factors are polynomials and finite sums. Pinned `Analysis/Normed/Algebra/Exponential.lean:490-496` provides the exponential HasSum/power-series facts, with `Complex.exp_eq_exp_ℂ` in `Analysis/SpecialFunctions/Exponential.lean:209` identifying the normed-algebra exponential with Complex.exp. The Cauchy product theorem `hasSum_sum_range_mul_of_summable_norm` in `Analysis/Normed/Ring/InfiniteSum.lean:153` handles products of absolutely summable series. These prove

`g(c+z)=Σ_{j≥0}G[j]z^j` for every z∈ℂ,

where G is extended by the same exact formulas to all j. Alternatively, `AnalyticOn.hasFPowerSeriesOnSubball` in `Analysis/Calculus/IteratedDeriv/ConvergenceOnBall.lean:27` packages the analytic equality once the radius bound is supplied. No general composition theorem for multilinear series is needed for the primary implementation.

## 4. Rational boxes and outward-rounded operations

A real box `[l,u]` has rational endpoints with l≤u and denotes all real x with l≤x≤u. A complex box is a product of two real boxes. All acceptance data must decode to exact rational endpoints; an ordinary decimal midpoint without an enclosing error is not enough.

The primitive real operations use the usual interval hulls. Addition has endpoints `l₁+l₂,u₁+u₂`; negation swaps and negates the endpoints; multiplication takes the minimum and maximum of the four endpoint products. Division by a known positive rational d divides both endpoints by d. A rational constant is the singleton interval containing that exact rational. Complex addition and multiplication follow from

`(x+iy)(u+iv)=(xu-yv)+i(xv+yu)`.

These formulas immediately preserve membership by order arithmetic. Rounding may enlarge their results. For example, at dyadic precision p, replace a computed lower rational r by `floor(2^p r)/2^p`, and an upper rational r by `ceil(2^p r)/2^p`. The resulting interval still encloses the exact interval. This uses true floor and ceiling for negative as well as positive values; rounding toward zero is not an adequate substitute.

A fixed precision of 128 bits is an implementation parameter, not a proof that an operation rounded correctly. A future checker must either prove the implementation's outward-rounding semantics or recompute/check endpoint inequalities using exact arithmetic. This note supplies the latter mathematical contract without asserting that native FLINT operations are already formalized.

### 4.1. Exact constants for logarithms and exponentials

The logarithm constants are real logarithms of positive rational bases. A concrete finite certificate is available. Reduce a positive rational b to `b=2^m u` with integer m and `1≤u≤2`, put `v=(u-1)/(u+1)`, and use

`log u = 2 Σ_{j=0}^{p-1} v^(2j+1)/(2j+1) + R_p`,

`0≤R_p≤2 v^(2p+1)/[(2p+1)(1-v²)]`.

To prove the formula directly, use `u=(1+v)/(1-v)` and the real FTC to write `log u=2∫₀ᵛ(1-t²)^(-1)dt`. The finite geometric identity splits the integrand into `Σ_{j<p}t^(2j)+t^(2p)/(1-t²)`. Integrating the finite sum gives the displayed terms; `0≤t≤v<1` bounds the last denominator by `1/(1-v²)` and gives precisely R_p. This proves the enclosure without an unproved infinite-series interchange.

Use the same bound for log 2 and interval arithmetic for `m log 2+log u`. Negative m reverses the relevant endpoint order automatically through interval multiplication. The current head/top bases are at least 1, but this extension also covers the positive fractional bases in Hurwitz family evaluators. These elementary FTC and finite-geometric wrappers still need their Lean implementations; the subsequent rational inequalities are finite exact checks.

For the constant complex exponential `exp(w)`, even when Im(w) is large, a finite enclosure can use scaling and squaring. Choose m≥0 such that a rational bound for `|w|/2^m` is at most 1/2. A box bound `|Re(w)|+|Im(w)|` suffices to choose m without a square root. Let V be the divided box and r≤1/2 a norm bound on V. Form the interval polynomial

`P_p(V)=Σ_{j=0}^{p} V^j/j!`.

For every exact v in V, the exponential power series gives the tail bound

`|exp(v)-P_p(v)| ≤ r^(p+1)/(p+1)! · 1/[1-r/(p+2)]`.

The successive absolute tail ratios are at most r/(p+2). Enlarge both coordinate intervals of P_p(V) by this rational radius, then square the resulting complex box m times. The identity `exp(w)=(exp(w/2^m))^(2^m)` proves inclusion at each stage. This avoids an unproved numerical argument-reduction operation. It is a sound finite algorithm, not a timing claim or a claim to reproduce FLINT's internal algorithm.

In the coefficient calculation, the exact constants w are `-c log n` and `(1-c)log B`. A rounded center box and a proved logarithm box first enclose w by complex interval multiplication. The exponential algorithm then encloses its exact exponential. Dependencies between the same logarithm used in w and later coefficients may be forgotten by interval arithmetic; forgetting them enlarges sets and does not invalidate inclusion.

Bernoulli coefficients and `B^(1-2k)` are rational. The reviewed EM plan proves the Bernoulli recurrence. Integer powers and reciprocal powers of a positive rational can be evaluated exactly, then rounded outward if desired. No exp/log evaluation is necessary for these particular powers.

## 5. Coefficient enclosure induction

Let the center box C contain the exact rational complex center c, and let each real logarithm box L_n contain log n. Start E_n[0] and H[0] with the proved exponential boxes just described. For j=0,…,K-2 form

`E_n_box[j+1]=(-L_n)*E_n_box[j]/(j+1)`

and the analogous H update with L_B. The denominator is a positive integer, so division is safe. Induction using (E) proves that every box contains the corresponding exact coefficient. The center need not be exactly representable at the chosen binary precision.

Initialize the rising-factorial boxes at the exact 1/0 constants. Use the old-array version of (P), with C+r enclosing c+r. Induction first in r and then through each retained index proves containment of every P_r[j]. Summation with the proved rational b_k and power boxes encloses A[j]. The truncated convolutions and final affine update enclose D[j] and G[j]. Each step uses only coefficients of degree below K. Structural induction through the finite expression proves:

> Every returned coefficient box j<K contains the actual analytic coefficient `iteratedDeriv j g c / j!` of the exact source-faithful finite function g.

This is the intended finite semantics theorem. Its conditions are the proved primitive interval operations and their checked data, not additional hypotheses about zeta or its zeros.

The arrays in the existing producer are generated by `acb_series` rather than by a verified recurrence implementation. There are two sound routes to acceptance. One is to prove those concrete series operations satisfy the rules above. The other is to have a small checker recompute these recurrences from certified constants and prove its coefficient intervals are contained in the proposed stored intervals, or use its own intervals in the subsequent panel check. Mere overlap with an independently computed interval is insufficient to validate a claimed coefficient box. If a conservative checker is too wide for a retained witness, it must refine its bounds or reject that witness; the proof cannot infer inclusion from the native evaluator's success.

The head JSON stores geometry and invokes coefficient recomputation during replay. The top-path JSON stores explicit coefficient endpoint boxes. These are different data layouts, but the same semantics theorem applies to both. This note does not claim that all existing native endpoint boxes have passed the proposed exact checker.

## 6. From coefficient boxes to whole-panel enclosures

If Z contains the exact displacement z=s-c, interval Horner evaluation of the boxes G[K-1],…,G[0] encloses the finite Taylor polynomial `Σ_{j<K}G[j]z^j`. This follows by induction from the last coefficient upward. The displacement must be relative to the exact center c. One cannot silently replace it by s minus an unchecked rounded midpoint. Both inspected producers construct their displacements from rational center/geometry differences before interval conversion.

Let C_out bound |g| on the circle of radius R about c, with R>0. Pinned `Analysis/Complex/Liouville.lean:42`, `norm_iteratedDeriv_le_of_forall_mem_sphere_norm_le`, gives

`|g^(j)(c)|≤j! C_out/R^j`,

under `DiffContOnCl` and the sphere bound. Entire g satisfies that regularity. Dividing by j! and summing the absolute tail gives, for `|z|≤h<R`,

`|g(c+z)-Σ_{j<K}G[j]z^j|≤C_out(h/R)^K/(1-h/R)`.

This is a norm remainder and can be added as a square coordinate error box. There is no factorial remaining in this final geometric expression, because the G coefficients already include 1/j!.

The reviewed EM identity adds a separate error between g and the actual zetaF. On a region with `Re(s)≥σ₀`, `|s|≤S`, it is bounded by

`(S+1) · 4 ∏_{j=0}^{2M-1}(S+j) B^(1-σ₀-2M) / [6^(2M)(σ₀+2M-1)]`.

Head uses σ₀=-1/10 and h≤1/10. Top uses σ₀=1/2 and h=1/8. Both use M=32, K=24 and R=1. The Taylor expansion belongs to finite entire g; the EM theorem need only apply on actual target points, not every point of the outer Cauchy disk.

For the top producer, its coarse head bound on the outer circle is

`Σ_{n=1}^N n^(-σ) ≤ N · max(1,N^(-σ))`,

where σ is the lower real part of that circle. If σ≥0 each term is at most 1; if σ<0 each is at most N^(-σ). This verifies the script's branch in `sm`, without confusing it with a sum of coefficient absolute values. The head producer uses the sharper termwise sum at the corresponding lower σ. Both are valid C_out constructions when their scalar interval calculations are sound.

Top then divides the completed zetaF enclosure by s-1 to enclose zeta itself. This is a value-level interval division after adding both errors. It is not a truncated-series division. On the top path Im(s)=1000000, so s-1 is uniformly nonzero; its denominator enclosure must also be proved to exclude zero before applying reciprocal interval arithmetic. Head returns zetaF directly and performs no such division, including near s=1.

## 7. Reuse for the nonprincipal family

For a Hurwitz component, replace the bases 1,…,N by `a,a+1,…,a+N-1` and B by N+a, with positive rational a. The finite F expression has the same E, P and convolution rules, but no outer multiplication by s-1 unless the chosen analytic target explicitly calls for it.

The common-pole cancellation from the reviewed EM plan adds an affine exponential times a polynomial approximation to exprel, followed by a finite character transform. Both operations use the same coefficient semantics. The DFT is linear in the component arrays, with the exact character coefficients and positive/negative transform convention fixed by the source adapter. Pole cancellation at s=1 is a function identity proved through zero-sum Hurwitz differences; it is not inferred from cancellation between rounded coefficient boxes.

An external error box added for an EM or exprel remainder is a pointwise enclosure, not an analytic function with known derivatives. One must not differentiate that box as if it supplied Taylor coefficients of the remainder. Expand the explicitly defined finite analytic expression, then bound the remaining analytic errors on the actual panel, as the head/top method does. If another family prototype expands a different finite expression, its expression tree and constant identities must first be pinned; the shared rules do not authorize an unstated change of target.

## 8. Formalization boundary

The paper-level finite soundness argument is now explicit: exact function → normalized derivative recurrences → analytic Taylor coefficients → primitive interval inclusion induction → Horner enclosure plus separate Cauchy and EM errors. Source theorems for normalized derivatives, analytic power series and Cauchy bounds were inspected directly. No numerical rerun was needed for this derivation.

The remaining implementation consists of ordinary proofs of these wrappers and the exact interval primitives, followed by a checker that validates the actual data. The given native series computations have not thereby become kernel-checked. No new zero-location assertion, trusted native opcode, custom axiom, or unproved evaluator equality is introduced by this note.
