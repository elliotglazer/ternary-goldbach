# Gamma inputs to primitive strip growth

Date: 2026-11-11. Source and paper audit only. No Lean build, declaration, analytic-value computation, or modification of existing artifacts was performed.

Verdict: both inspected OAI Gamma bounds follow from standard Gamma/beta identities and elementary integral, recurrence, and compactness arguments. No mathematical defect was found in the stated domains, treatment of Gamma poles, or uniformity in height. This closes the two Gamma proof-assembly cuts left by `QRH_PRIMITIVE_LOG_CONTROL_AUDIT_2026-11-11.md` at paper level, relative to the library facts listed below. It does not validate the whole QRH provider or its transitive kernel axioms.

OAI source root in this report is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, revision `4eaee87548250b2682affda7d05d947c05554bae`. The inspected Mathlib source is the target cache at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/`, revision `56a005855ea17e0b0958f73ec801ae140b0a1679`. OAI's manifest instead pins Mathlib `d13f23b723b8a846827a245b89c10fc7d3f11612`. Matching the named statements and arguments below is source evidence, not an elaboration or whole-version compatibility result.

## 1. Exact shifted-pair statement

`QuadraticSieve/MainTermDifference.lean:229`, namespace `CubicReflectionKernel`, states that for real \(a,\sigma,t\) and natural \(n\),

\[
 a+\sigma>0,\qquad n-2\sigma>0
\]
imply
\[
 \left|\frac{\Gamma(a+\sigma+it)}{\Gamma(a-\sigma+n-it)}\right|
 \le \frac{\Gamma(a+\sigma)}{\Gamma(a-\sigma+n)}.
\tag{1}
\]

The hypotheses imply \(a-\sigma+n>0\). Both complex arguments therefore have strictly positive real part, so their Gamma values are finite and nonzero. The result is uniform in every real \(t\), including zero and negative heights. It is not a constant uniform over arbitrary \(a,\sigma,n\); the right side records those dependencies. In particular, the proof does not extend its premises to \(a+\sigma=0\) or \(n-2\sigma=0\).

The proof assembly, beginning at line 159, is as follows.

1. Define the real beta integral
   \[
   B(p,q)=\int_0^1x^{p-1}(1-x)^{q-1}\,dx.
   \]
   For \(p,q>0\), this integral is absolutely convergent. The actual complex beta integral uses powers of the positive real numbers \(x\) and \(1-x\), so their moduli are precisely the real powers of their real exponents. Endpoint values do not affect the integral.
2. `norm_betaIntegral_le:178` applies the norm-of-integral inequality and identifies the resulting real integral. For the positive arguments used here,
   \[
   |B(p+it,q)|\le B(p,q).
   \]
   `realBeta_eq_Gamma:189` and `Gamma_ratio_eq_beta:197` use the library beta-Gamma identity. Division by \(\Gamma(q)\) is legitimate because \(q>0\).
3. `Gamma_vertical_ratio_bound:204` gives
   \[
   \left|\frac{\Gamma(p+it)}{\Gamma(p+q+it)}\right|
   \le\frac{\Gamma(p)}{\Gamma(p+q)}.
   \]
4. Substitute \(p=a+\sigma\), \(q=n-2\sigma\). The denominator in (1) has imaginary part \(-t\), whereas the beta ratio has \(+t\). `QuadraticSieve/InitialBound.lean:539`, `Gamma_vertical_conj`, is exactly Gamma conjugation, followed by invariance of the norm under conjugation. It changes only the denominator's norm. It does not assert equality of the two complex quotients.

The source's auxiliary norm inequality is stated for arbitrary complex beta arguments, using totalized integrals. No part of this application relies on the behavior of a divergent beta integral: both real exponents in the application are positive.

## 2. The actual left-boundary specialization

`Hecke/Strip.lean:17`, `gamma_ratio_left_bound`, takes

\[
 s=-1/10+it,\quad a=1/2,\quad\sigma=3/5,\quad n=2,
\]

and replaces the height in (1) by \(-t\). The two positive beta parameters are \(11/10\) and \(4/5\). It obtains

\[
 |\Gamma(1-s)/\Gamma(s+2)|\le\Gamma(11/10)/\Gamma(19/10).
\]

`inverse_Gamma_shift:218` proves the all-argument reciprocal identity

\[
 \Gamma(z)^{-1}=\left(\prod_{k=0}^{n-1}(z+k)\right)\Gamma(z+n)^{-1}.
\tag{2}
\]

It uses the library recurrence for reciprocal Gamma, which includes zero and all nonpositive integers. This avoids an invalid cancellation at a Gamma pole. `norm_Gamma_shift_factor:268` bounds the product by \((|z|+n)^n\). Since \(|s|\le1/10+|t|\), the source concludes

\[
 |\Gamma(1-s)/\Gamma(s)|
 \le \frac{\Gamma(11/10)}{\Gamma(19/10)}(3+|t|)^2.
\tag{3}
\]

All constants in (3) are independent of the conductor and height. The field's functional equation supplies the separate completion-scale factor and conductor exponent. This Gamma argument does not use that functional equation, a character estimate, or a zero-free region.

The same source also derives `Gamma_pair_strip_bound:287`: for fixed \(a>1/4\) and natural \(A\), the unshifted quotient has a bound \(C(1+|t|)^{2A+2}\), uniformly for \(-1/4\le\sigma\le A\). It chooses \(n=2A+2\), applies (1), bounds its real Gamma ratio on the compact sigma interval, and applies (2). Thus even when the unshifted denominator is at a Gamma pole, the reciprocal form remains valid. This related theorem is consistent with the same proof mechanism; (3) uses the explicit specialization rather than this existential compact-strip constant.

## 3. Exact reciprocal-Gamma strip statement

`Mellin/VerticalContourShift.lean:435`, namespace `CubicGammaExponential`, states

\[
 \forall a,b\in\mathbb R,\ \exists C>0,\ \forall z\in\mathbb C,
 \quad a\le\Re z\le b\Longrightarrow
 |\Gamma(z)^{-1}|\le C\exp(\pi|\Im z|).
\tag{4}
\]

The constant may depend on the fixed endpoints \(a,b\). It does not depend on height, conductor, character, or a subsequently chosen point of the strip. The assertion is harmless for an empty interval \(a>b\). The source does not compute \(C\), assert a uniform constant for all strip endpoints, or claim the sharp exponential rate \(\pi/2\).

The proof at lines 292–433 covers both small and large imaginary parts.

### 3.1 Integral and reflection estimates

For \(\Re w>0\), `norm_Gamma_le_real:292` uses the actual Euler integral and gives

\[
 |\Gamma(w)|\le\Gamma(\Re w).
\tag{5}
\]

The library establishes absolute integrability on this domain. On \(x>0\), the integrand's modulus is \(e^{-x}x^{\Re w-1}\), so there is no logarithm-branch ambiguity in (5).

`norm_sin_le_exp_abs_im:304` expands sine as a difference of exponentials and proves
\[
 |\sin u|\le e^{|\Im u|}.
\]
If \(\Im z\ne0\), both \(\Gamma(z)\) and \(\Gamma(1-z)\) are nonzero. `inverse_Gamma_reflection:323` first justifies these nonzero factors and \(\sin(\pi z)\ne0\), then rearranges the library reflection formula:
\[
 \Gamma(z)^{-1}=\Gamma(1-z)\sin(\pi z)/\pi.
\]
For \(\Re z<1\), (5) now applies at \(1-z\), yielding `inverse_Gamma_norm_of_left:341`:
\[
 |\Gamma(z)^{-1}|\le\frac{\Gamma(1-\Re z)}\pi e^{\pi|\Im z|}.
\tag{6}
\]

The source does not apply this rearrangement at real integers, where cancellation would be invalid.

### 3.2 The shift goes left and its factors are lower-bounded

Choose a natural \(n>b\). For \(z=\sigma+it\) with \(\sigma\in[a,b]\), put \(w=z-n\). Then \(\Re w<1\), and
\[
 1-\Re w=n+1-\sigma\in[n+1-b,n+1-a]\subset(0,\infty).
\]
When \(|t|\ge1\), each factor \(w+k\) in (2) has modulus at least \(|t|\ge1\). The identity at \(w\) therefore implies
\[
 |\Gamma(z)^{-1}|\le|\Gamma(z-n)^{-1}|.
\tag{7}
\]
This is `inverse_Gamma_norm_le_shift_left:359`. It is a lower bound on the recurrence product. Reversing (7) or estimating this product only from above would not prove the claimed bound.

Let \(C_g>0\) bound the real Gamma function on \([n+1-b,n+1-a]\). Such a bound exists by continuity away from the nonpositive integers and compactness. Applying (6) to \(w\) and then (7) gives
\[
 |\Gamma(z)^{-1}|\le (C_g/\pi)e^{\pi|t|}\quad(|t|>1).
\]

### 3.3 The compact rectangle includes all exceptional real points

The function \(z\mapsto\Gamma(z)^{-1}\) is entire in Mathlib's convention, including the nonpositive integers, where its value is zero. `inverse_Gamma_compact_strip_bound:383` uses this function's continuity on the compact rectangle \([a,b]+i[-1,1]\) to choose \(C_c>0\). It does not use continuity of Gamma itself at a pole.

For \(|t|\le1\), \(e^{\pi|t|}\ge1\) gives the required estimate. The two branches combine with the single positive constant
\[
 C=C_c+C_g/\pi.
\]
The equality cases \(t=\pm1\) are assigned to the compact branch, and there is no omitted interval or real-axis exception. The final complex theorem merely rewrites \(z=\Re z+i\Im z\).

## 4. Exact library facts and scope of inspection

The following actual declarations were read in the target Mathlib source. All paths in this table are below `Analysis/SpecialFunctions/Gamma/`.

| File and line | Declaration and role |
|---|---|
| `Basic.lean:66,87` | Real and complex `GammaIntegral_convergent`: integrability for positive real part. The real proof splits at 1, using power integrability near zero and exponential decay at infinity. |
| `Basic.lean:319,405` | Complex and real `Gamma_eq_integral`: identify the continued function with Euler's integral on the positive half-plane. |
| `Basic.lean:356,419,443` | `Complex.Gamma_conj`, `Complex.Gamma_ofReal`, `Real.Gamma_pos_of_pos`. |
| `Beta.lean:124` | `Gamma_mul_Gamma_eq_betaIntegral`: the underlying beta identity, proved using absolutely integrable positive convolution and scaling, before division by Gamma. |
| `Beta.lean:398` | `Gamma_mul_Gamma_one_sub`: the reflection identity. Its proof uses `GammaSeq_tendsto_Gamma` and the Euler sine product, with the integer cases handled separately. |
| `Beta.lean:427,454` | `Gamma_ne_zero` away from the nonpositive integers and `Gamma_ne_zero_of_re_pos`. |
| `Beta.lean:514` | `one_div_Gamma_eq_self_mul_one_div_Gamma_add_one`: recurrence valid at every complex argument, including zero. |
| `Beta.lean:522` | `differentiable_one_div_Gamma`: entire reciprocal, proved by finitely shifting into a positive half-plane and applying the recurrence. |
| `Beta.lean:537` | `betaIntegral_eq_Gamma_mul_div`: positive-real-part beta/Gamma quotient identity used by OAI. |
| `Deriv.lean:222` | `Real.differentiableOn_Gamma_Ioi`: continuity of real Gamma on positive compact intervals. |

The Gamma integral and beta-convolution proof bodies, the reflection proof's use of Euler limit and sine product, and the recurrence/entire-reciprocal bodies were inspected. This report does not separately audit the full library proof of the Euler sine product, every dominated-convergence step behind the Gamma limit, or all general integration and compactness theorems. Those remain library mathematical foundations. No new special-function estimate is silently assumed in the OAI assembly.

In particular, (4) is not a consequence of a numerical Gamma routine or a Stirling error estimate. Its compact constants are nonconstructive in this source. This is sufficient for the later Phragmen-Lindelof admissible-growth hypothesis, which only needs some finite exponential-growth constant for each fixed strip. It does not produce a finite-precision Gamma evaluator or a numerical error budget.

## 5. Consequence for the primitive-log audit

For the fixed strip \([-1/10,11/10]\), (3) gives the explicit real Gamma ratio used in the uniform left boundary, and (4) supplies inverse-Gamma growth \(Ce^{\pi|t|}\). `Hecke/Strip.uncompleted_exp_bound:284` combines the latter with a positive real completion-scale power, bounded on that fixed real interval, and a bounded Mellin transform. The completion-scale bound can depend on the conductor. Phragmen-Lindelof subsequently removes dependence on that temporary growth constant from the boundary maximum estimate.

The distinction matters: the Gamma estimates are uniform in height; the temporary uncompleted-L growth witness need not be uniform in the character; the final primitive logarithmic-control constants are uniform because the actual boundary bounds have already been expressed in the chosen conductor-height complexity.

The remaining provider work is the actual theta/Gauss/Mellin and arithmetic assembly, the zero-supremum continuation argument, the family-to-Dirichlet bridge, version-compatible compilation, and a transitive axiom check. This report neither assumes nor establishes the final \(7/8\) zero-free region.

## 6. Frozen source hashes

SHA256 values are hashes of the actual inspected local files. OAI paths are below the root specified at the start; Mathlib paths are below its inspected target-cache root.

| File | SHA256 |
|---|---|
| OAI `QuadraticSieve/MainTermDifference.lean` | `3B2152A57FB0EA580EEC5CB32ADE8709F9892890B6DBDD93392300BFB1CA3924` |
| OAI `QuadraticSieve/InitialBound.lean` | `5D3A030862AAE4997A9D8E13D51FBDBDEE1C41EC1AEC4D23BE49D8B183F7ABC4` |
| OAI `Mellin/VerticalContourShift.lean` | `134E7C35AFB52CFE6282F1415F7304F84FC18C31C93AD9086FEE8440414C7ABD` |
| OAI `Hecke/Strip.lean` | `E6E35BDEA0A7595D8AD88FB185A8C38367E8EC1878C9312E3D2BB0BE3C4F8AB8` |
| Mathlib `Analysis/SpecialFunctions/Gamma/Basic.lean` | `924736ACB968C113FAF74DD1BE6D125C3BC67EBA9492A2965A043172A3D6A136` |
| Mathlib `Analysis/SpecialFunctions/Gamma/Beta.lean` | `C166D25802EDF2883DB91226CFF7B5F5432BB9E8DCF1A0EDD88932D59C3E724C` |
| Mathlib `Analysis/SpecialFunctions/Gamma/Deriv.lean` | `5DD1B5D20D3572A0D765462EAE531BBF9AC48172492875F6C6759499B9E17019` |
