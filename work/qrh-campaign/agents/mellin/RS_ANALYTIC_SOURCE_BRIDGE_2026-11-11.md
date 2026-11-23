# The analytic proof behind the Riemann–Siegel evaluator

Research handoff, 2026-11-11. No Lean build, zero enumeration, dependency update, or change to a frozen artifact. The formulas below specify research obligations, not approved Lean declarations.

## What this audit establishes

The FLINT v3.6.0 implementation has an exact, manageable coefficient specification. Its auxiliary integral and reflected assembly have an accessible primary mathematical source. The original quantitative remainder theorem has **not** been obtained, so this note does not close the analytic RS proof bridge. This is a source-access and proof-reconstruction gap, not evidence of an incorrect theorem or library result.

The missing document is J. Arias de Reyna, *High precision computation of Riemann's zeta function by the Riemann–Siegel formula, I*, Mathematics of Computation 80 (2011), 995–1009, DOI [10.1090/S0025-5718-2010-02426-3](https://doi.org/10.1090/S0025-5718-2010-02426-3). Both publisher PDF URL variants, the article page, and the community.ams.org PDF returned 403. The [author's publications page](https://personal.us.es/arias/Publications.html) lists the article without a linked manuscript. Institutional idUS full-text discovery and OpenAlex supplied no alternate copy. The latter was used only as a locator.

The author's [Part II, introduction and §3.2](https://arxiv.org/html/2201.00342) confirms that Part I supplies the analytic bounds, but explicitly says Part II still contains unproved inequalities, including plot-based checks in §3.10. We do not use its floating-point error analysis as a theorem. Its displayed recurrences can corroborate the finite algebra below. In particular, the restrictions in Part II's precision-selection theorem are not silently transferred into, or removed from, Part I Theorem4.2.

Current FLINT 3.7-dev documentation warns that portions are LLM-generated. Its phrases about the number of terms and a large-height restriction do not override pinned v3.6 source or the missing original theorem. All implementation claims below are checked against downloaded, unmodified v3.6 files in `rs-source/`.

## 1. Mathematical carrier and reflected assembly

The primary source [Arias de Reyna, *Riemann's auxiliary function. Basic Results*, Definition4 and Theorem5](https://arxiv.org/html/2406.02403v1) fixes

\[
\mathcal R(s)=\int_L \frac{z^{-s}e^{\pi iz^2}}{e^{\pi iz}-e^{-\pi iz}}\,dz,
\qquad L(u)=\tfrac12+u e^{-3\pi i/4},\quad -\infty<u<\infty.
\]

Use the principal logarithm in \(z^{-s}\). The direction, parameter Jacobian, and branch must be part of the definition. The line misses the branch cut and integer poles. The source gives entire dependence and

\[
\zeta(s)=\mathcal R(s)+\chi(s)\overline{\mathcal R(1-\bar s)},\qquad
\chi(s)=\pi^{s-1/2}\frac{\Gamma((1-s)/2)}{\Gamma(s/2)}.
\tag{A}
\]

For positive height, both auxiliary evaluations therefore have **positive** height: \(\sigma+it\) and \(1-\sigma+it\). The bar over a function in the paper means conjugating its input and output; replacing the second term by \(\overline{\mathcal R(1-s)}\) is wrong.

The proof of (A) remains a mathematical formalization task, including contour convergence, deformations/residues, and identification with Mathlib's continued `riemannZeta`. The 2024 source supplies the formula and branch convention, not a ready Lean proof.

`zeta_rs.c:48` uses precisely this reflected input. Lines61–73 evaluate the equivalent factor

\[
\chi(s)=\frac{(2\pi)^s}{2\cos(\pi s/2)\Gamma(s)}.
\]

Gamma reflection and duplication justify the equivalence. For \(t>0\), these factors have no integer-axis pole/zero ambiguity. Negative heights use conjugation. Ball inputs are evaluated at the midpoint, with a separate derivative bound times the Euclidean input radius added afterward (`zeta_rs.c:111–121`). This latter bound is a separate proof obligation for sampled circles; it is unnecessary at exact rational sign samples.

## 2. Exact finite correction computed by v3.6

For real \(t>0\), put

\[
a=\sqrt{t/(2\pi)},\quad N=\lfloor a\rfloor,\quad p=1-2(a-N),
\quad \theta_0=\tfrac t2\log(t/(2\pi))-\tfrac t2-\tfrac\pi8,
\quad U=e^{-i\theta_0}.
\]

Thus \(-1<p\le1\). Define the following finite expression, with correction index \(K\):

\[
R_K(s)=\sum_{n=1}^{N}n^{-s}
 +(-1)^{N-1}U a^{-\sigma}\sum_{k=0}^{K}a^{-k}C_k(\sigma,p),
\]
\[
C_k(\sigma,p)=\pi^{-2k}\sum_{j=0}^{\lfloor3k/2\rfloor}
 (\pi/(2i))^j d_j^{(k)}(\sigma)F^{(3k-2j)}(p).
\tag{B}
\]

These formulas are reconstructed directly from [zeta_rs_r.c](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_r.c), especially lines157–183. **K means the largest index: there are K+1 terms.** The factor \(\pi^{-2k}\) is realized by successive powers of \((a\pi^2)^{-1}\). The parity sign is negated when N is even. The remainder ball is added before multiplying by \(U a^{-\sigma}\).

The [coefficient evaluator](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_f_coeffs.c) computes

\[
F(z)=\frac{\cos A(z)+i(\sin A(z)-\sqrt2\cos(\pi z/2))}{2\cos(\pi z)},
\qquad A(z)=\pi(z^2/2+3/8).
\tag{C}
\]

Its power-series division initially gives Taylor coefficients; line64's inverse Borel transform multiplies by factorials, so (B) uses derivatives, not derivatives divided by factorials. A kernel replay must preserve that distinction.

Our direct algebra gives the removable values \(F(1/2)=F(-1/2)=(1-i)/4\): both numerator and denominator vanish simply, and their derivatives have this ratio. Derivatives at these points require analytic division after canceling the simple zero. A certificate may instead require an interval proof that its particular p avoids both points. Near either point, a division ball can become useless; that is failure to certify, not permission to omit the denominator check. At an integer a, changing N changes the finite formula; no derivative or continuity assertion about this piecewise approximant is used.

The [d-coefficient recurrence](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_d_coeffs.c) is finite rational algebra for rational sigma. Set \(d_0^{(0)}=1\), and other out-of-range entries to zero. For \(m=3k-2j\ne0\),

\[
d_j^{(k)}=\frac{d_j^{(k-1)}/2+(1-2\sigma)d_{j-1}^{(k-1)}}{2m}
 -(m+1)d_{j-2}^{(k-1)}.
\tag{D}
\]

For even positive k, h=3k/2 is exceptional:

\[
d_h^{(k)}=-\sum_{r=0}^{h-1}(-1)^{h-r}d_r^{(k)}\frac{(2h-2r)!}{(h-r)!}.
\tag{E}
\]

The same-row entries in (E) matter. At sigma=1/2 the first two rows are \((1/12,0)\) and \((1/288,0,-1/4,-1/12)\); the accompanying exact script checks them. This is an algebraic implementation specification, not yet a proof that these coefficients expand the contour integral.

## 3. The unclosed remainder theorem

The [v3.6 bound routine](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/zeta_rs_bound.c) accepts finite s, t>0, K>=1, and either sigma>=0 or sigma+K-2>=0. It upper-bounds a normalized remainder by

\[
E_K(\sigma,t)=\bar c(\sigma)
 \left(\frac{11}{10a}\right)^{K+1}\lfloor K/2\rfloor!,
\tag{F}
\]

where the code's conservative exact-scalar coefficient is

\[
\bar c(\sigma)=\begin{cases}1/2&\sigma\le0,\\
\max(1/2,2^{\lceil3\lceil\sigma\rceil/2\rceil}/7)&\sigma>0.
\end{cases}
\]

The source comments identify the sharper nonnegative-sigma prefactor \(2^{3\sigma/2}/7\), Gamma factor \(\Gamma((K+1)/2)\), and Part I Theorem4.2. For K>=1, \(\Gamma((K+1)/2)\le\lfloor K/2\rfloor!\): odd K is equality and the even case follows from the half-integer formula and induction starting at \(\Gamma(3/2)<1\).

The essential missing theorem is a proof, with fully audited hypotheses, of

\[
|\mathcal R(s)-R_K(s)|\le a^{-\sigma}E_K(\sigma,t).
\tag{G}
\]

**We have not verified (G) from the original Theorem4.2.** The routine's checks and comments do not establish that its stated domain is mathematically sufficient. In particular, this note does not assert or dismiss an additional t/K restriction on the basis of later documentation. The author's Part II §3.2 cites the Gamma-shaped remainder and sigma+K>=2 condition, but is not a replacement for reading/reconstructing the original proof.

If (G) is established for both reflected inputs, (A) gives, without any RH assumption,

\[
|\zeta(s)-[R_K(s)+\chi(s)\overline{R_K(1-\bar s)}]|
\le a^{-\sigma}E_K(\sigma,t)+|\chi(s)|a^{\sigma-1}E_K(1-\sigma,t).
\tag{H}
\]

Error in a numerical enclosure for chi itself must also be propagated, including its product with the reflected auxiliary value. Formula(H) only handles analytic truncation with exact chi.

The author's [2024 asymptotic paper, Theorem5](https://arxiv.org/html/2406.04714v1) offers another proof-reconstruction source, but uses a different complex saddle, coefficients, and an unspecified \(O_{K,\theta}\) constant. It cannot justify (F) by substitution. Its Cauchy remainder/contour method may help reconstruct a bound; an explicit constant and a normalization comparison would still be necessary.

## 4. Critical-line specialization and phase costs

At sigma=1/2, reflected auxiliary values coincide, \(|\chi|=1\), and (H) becomes \(2a^{-1/2}E_K\). Defining the normalized analytic Gamma phase theta gives

\[
Z(t)=2\operatorname{Re}(e^{i\theta(t)}\mathcal R(1/2+it)).
\]

The existing low-height sign proxy is \(V=\operatorname{Re}(e^{i\theta_0}\zeta)\), whose sign agrees with Z by the reviewed Binet bound. **It does not follow that \(2\operatorname{Re}(e^{i\theta_0}\mathcal R)\) has that sign.** The auxiliary function has an additional imaginary component after phase rotation. To evaluate Z from a single auxiliary sum, certify theta or the unit Gamma factor accurately. Alternatively evaluate the assembled zeta ball using chi, then apply the already-reviewed proxy. The latter still needs certified Gamma evaluation for chi.

Conditional scale calculation: for t>=1500, pi<22/7 gives a>15; at sigma=1/2, cbar=4/7. Taking K=24 gives

\[
2a^{-1/2}E_{24}<\frac87(11/150)^{25}12!<10^{-19}.
\]

The exact rational script checks this final inequality. It is conditional on (G), and excludes arithmetic and phase error. It does not prove that every chosen sign sample has sufficient margin. Precision/correction order may need to increase near zeros. Near 1e6 the finite Dirichlet sum has N=398 terms; no complete sign enumeration is undertaken here.

For the already-used top-path circle points, real parts extend beyond the strip. A broad cover sigma in[1/4,9/4] also requires reflected sigma in[-5/4,3/4]. K>=4 satisfies the **code's** negative-sigma check; cbar<=32/7 covers the positive side. A critical-line-only remainder theorem would therefore not validate those off-line point evaluations. The separate proposed EM top-path replacement can remove this particular need without proving the full RS evaluator.

## 5. Existing Lean interfaces and a bounded proof order

Cached Mathlib revision `56a005855ea17e0b0958f73ec801ae140b0a1679` has an unchanged `Mathlib/NumberTheory/LSeries/HardyZ.lean`. Its actual definitions/theorems are `hardyZ : ℝ → ℝ`, `ofReal_hardyZ`, `abs_hardyZ`, `hardyZ_neg`, `hardyZ_eq_zero_iff`, and `continuous_hardyZ`. The carrier is completed zeta's real part divided by the norm of `Gammaℝ`; its TODO explicitly leaves the theta relation open. Reuse this real carrier rather than adding realness as a premise. This is a source inspection, not a build or axiom audit.

Pinned campaign source already provides `TernaryGoldbach.Explicit.xiF_one_sub` and `xiF_eq` in `Explicit/Xi.lean:24,28`, and `xiF_conj` in `Explicit/XiPartial.lean:669`. These support the reviewed proxy connection. `Explicit/ZetaGrowth.lean` supplies the pole-canceled `zetaF` and its entire continuation. None supplies the auxiliary RS contour expansion.

The realistic dependency order is:

1. Obtain Part I Theorem4.2 and the coefficient/remainder definitions it invokes. Audit every quantifier, K convention, contour orientation, Gamma factor, and sigma case before freezing a theorem statement.
2. Define the auxiliary contour as an ordinary real-parameter integral with its Jacobian; prove convergence, holomorphic dependence and (A) for the needed positive-height domain. Prove the finite-sum contour shift separately.
3. Identify the saddle expansion coefficients with (B)–(E), including removable points and exact derivative normalization. Reconstruct the analytic remainder bound (G). This is the principal unproved analytic leaf.
4. Prove the Gamma/chi enclosure or normalized-phase interface, then derive(H) and the real critical-line evaluator. The available real Hardy carrier already supplies continuity and zero equivalence.
5. Build a proof-producing rational interval replay for finite expressions. Exact rational coefficient tables, floor witnesses, elementary function enclosures and propagated errors must be kernel checked. Arb point balls may guide certificate generation but cannot be accepted as axioms or hypotheses. No native-decide shortcut is proposed.
6. Reuse the independently reviewed sign/count completeness argument only after point soundness is proved. The externally accepted 1069 sign changes below1500 and the external top count1747146 at1e6 remain distinct data artifacts with their own proof obligations.

A first bounded implementation target, after the source gap is resolved, is the finite rational recurrence(D)–(E) and its equality to the coefficient normalization in the actual theorem. Before that, source acquisition and proof reconstruction are the useful work. A successful point benchmark cannot substitute for step3.

## Reproducibility

`rs_bridge_scalar_20261111.py` checks only exact algebraic consequences, with Python Fraction; it does not call zeta, Gamma, an indexed-zero routine, or a zero-count routine. The source copies retain their original LGPL headers.

Pinned v3.6.0 source SHA256 values:

| File | SHA256 |
|---|---|
| zeta_rs.c | 0AC9974D05BAE062FF7EABFBDD588FC974EA94184092CE933C4D45BA403B185C |
| zeta_rs_r.c | F932166AE725A2F45C8193C142BCE79928344243629CE9D09F6ACF5B2FFFB5DB |
| zeta_rs_bound.c | BCB5C97890BE1EDEA563885208C1477FB8544F2076C6E53DE4D65B0DFF73C6EE |
| zeta_rs_f_coeffs.c | FE0AB3ECE048311822E0CDF9FF9E3E95D9FD1E9D33B720F32BEC7C68474E7698 |
| zeta_rs_d_coeffs.c | DF2A99527EEA8237867C0F24F5B5133AD522190300D6AA7CDA1E2F69989F03AD |

No original Part I PDF was saved because all attempted publisher retrievals failed. The absence of that source is preserved explicitly rather than filled with a reconstructed theorem attributed to the author.
