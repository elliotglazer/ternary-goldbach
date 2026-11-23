# Simple-phase K0 evaluator: selected paper plan

2026-11-11. This new note combines two independently reviewed paper derivations. It preserves the frozen notes, includes the required Mordell-parameter erratum, and removes the sharp Gamma-phase dependency from both uses of the phase. It is a mathematical proof plan with exact scalar receipts, not a Lean theorem, completed sign checker, or verified high-zero certificate. No builds or scans were run.

The proposed evaluator uses only

\[
 \widehat\theta(t)=\frac t2\log\frac{t}{2\pi}-\frac t2-\frac\pi8+\frac1{48t}.
\]

For every real `t>=1500`, its analytic error is strictly less than

\[
 \frac{451}{1000}t^{-3/4}<\frac{47}{100}t^{-3/4}.
\]

This is an all-height statement; it does not reuse the fixed main-sum amplitude 80 beyond its original finite range. Finite-arithmetic enclosure errors are separate.

## 1. Frozen inputs and exact meaning of acceptance

Paths in this table are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
|---|---|
| `major-constants/GABCKE_K0_ANALYTIC_BLUEPRINT_2026-11-11.md` | `8A65614DA19778FBA1CB08440183FCE49D52B9BCCD9F7B552EA535234C1DD713` |
| `audit/REVIEW_GABCKE_K0_ANALYTIC_BLUEPRINT_2026-11-11.md` | `7B40483351FFAFAEF7039BC89E02C89A4F292A13BAB3281C1CF7482D9D4F51D1` |
| `prime-estimates/COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md` | `C7B701CF5B02D34142E30F38D1FFE573AE30167A561B9A759FD9964F41FC6E79` |
| `independent-feasibility/REVIEW_COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md` | `DE019E48942C1999785FA8F14BC4CD65CAD7C4423038965FA0DEF96DD8BC75D0` |
| `moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028` |
| `integration/REVIEW_PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `A4401782284FFF48DFFBA27BB9DE2EFAF20E6BECB09A4F3737BDD220EA739547` |

The K0 review accepts the low-order conditional analytic reduction and its scalar arithmetic, with one source-ledger correction. The Gamma review accepts the normalized Binet/periodic-polynomial paper derivation. Neither review supplies Lean terms or the remaining Riemann–Siegel contour proof. Here their mathematical consequences are assembled without adding their conclusions as assumptions of the final Goldbach theorem.

Primary source: Gabcke's corrected 1979/2015 thesis, <https://d-nb.info/1072293277/34>, local PDF SHA256 `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53`. The precise low-order source pointers are recorded below; the full ledger remains in the frozen blueprint.

## 2. Exact evaluator and actual Hardy function

For `t>=1500`, set

\[
 a=\sqrt{t/(2\pi)},\quad N=\lfloor a\rfloor,\quad z=1-2(a-N),
 \quad q=\sqrt\pi z,\quad \tau=(8t)^{-1/2}.
\]

Then `N>=1`, `-1<z<=1`, and `tau=1/(4*a*sqrt(pi))`. Let

\[
 F(z)=\frac{\cos(\pi(z^2+3/4)/2)}{\cos(\pi z)}
\]

mean the analytically continued function, with `F(1/2)=F(-1/2)=1/2`. A totalized quotient at its removable points is not this definition. Define

\[
 \widehat Z_0(t)=2\sum_{n=1}^{N}
      \frac{\cos(\widehat\theta(t)-t\log n)}{\sqrt n}
      +(-1)^{N-1}a^{-1/2}F(z).
\]

The target `Z(t)` is Mathlib's actual real `hardyZ`, not a sign-adjusted function. The normalized analytic Gamma logarithm `L`, real on the positive axis with `exp L=Gamma`, defines

\[
 \theta(t)=\Im L(1/4+it/2)-(t/2)\log\pi.
\]

The adapter `Gammaℝ(1/2+it)/|Gammaℝ(1/2+it)|=exp(i*theta(t))` identifies the source expression `exp(i*theta)*zeta(1/2+it)` with Mathlib `hardyZ` via `ofReal_hardyZ`. Equality of moduli or zero sets alone does not fix its sign. The pinned Mathlib source is commit `56a005855ea17e0b0958f73ec801ae140b0a1679`; `NumberTheory/LSeries/HardyZ.lean:76,79` and `Analysis/SpecialFunctions/Gamma/Deligne.lean:46` give these definitions.

At an integral value of a, the floor is `N=a` and `z=1`. The source's endpoint contour convention applies. The approximant can jump when the floor changes; only actual HardyZ is used in continuity/IVT arguments.

## 3. Coarse phase replaces the sharp phase in U

The reviewed Binet construction gives, for `Re w>0`,

\[
 L(w)=(w-1/2)\Log w-w+R(w)-H(1),\qquad H(1)\in\mathbb R.
\]

The periodic-polynomial proof establishes

\[
 R(w)=\frac1{12w}-\frac13\int_0^\infty
       \frac{P_3(\{x\})}{(w+x)^3}\,dx,
 \qquad P_3(r)=r(r-1/2)(r-1),\quad |P_3(r)|\le1/8.
\]

It follows by a split of the integral at `x=Im w` that, at `w=1/4+it/2`,
`|R(w)-1/(12w)|<=1/(4*t^2)`. Elementary real logarithm/arctangent bounds then prove

\[
 |\theta-\widehat\theta|\le\frac1{4t^2}+\frac{23}{384t^3}
       <\frac{13}{50t^2}\quad(t\ge1500).
\]

Consequently, with `theta0=thetahat-1/(48*t)`,

\[
 |\theta-\theta_0|<\frac1t\left(\frac1{48}+\frac{13}{50t}\right)
       <\frac1{40t}=\frac{\tau^2}{5}.
\]

The last inequality already holds for `t>312/5`, so the stated threshold is sufficient. For `U=exp(i*(theta0-theta))`, the real exponential Lipschitz inequality gives `|U|=1` and `|U-1|<tau^2/5`.

This is the complete phase input consumed by the low-order analytic remainder. No use remains here of Gabcke 4.2.3(d), the `1/(3322*t^7)` remainder, `RU(tau)`, or the order-10 expansion of U. The normalized Binet construction and its elementary integral proof still require Lean formalization.

## 4. Reassemble the actual-phase K0 error with this weaker input

The exact saddle identity, Gabcke 1.2.1, p12, is

\[
 Z=M_\theta+(-1)^{N-1}a^{-1/2}\Re(US),
 \quad M_\theta=2\sum_{n=1}^N n^{-1/2}\cos(\theta-t\log n).
\]

The already reviewed low-order derivation uses

\[
 P_1(w)=w^3/3-iw,\quad P_2(w)=w^6/18-(5i/6)w^4-(3/2)w^2,
 \quad S=B_0+B_1\tau+RS_1.
\]

The derivative/contour identities of pp16–17 and 4.1.2–4.1.4 give

\[
 \Re B_0=F(z),\quad \Re B_1=F'''(z)/(3\pi^{3/2}),
 \quad |B_0|\le1,\quad |B_1|<8/5,\quad |F'''(z)|\le4\pi.
\]

The K=1 specialization of 3.1.3, pp47–50, at `t0=1500` and auxiliary parameter `vartheta=1/4`, gives `|RS1|<4.2*tau^2`, uniformly for `|q|<=sqrt(pi)`. Its four constants are bounded by `.001,1.82,2.31,.001`. The incomplete-Gamma leaf has domain `a>=1,x>a`; the used values `3/2,5/2,7/2` and tail thresholds meet it.

Using **the coarse U bound from section 3**, rather than the sharp phase from the original blueprint,

\[
 US=B_0+B_1\tau+E_1,\qquad
 |E_1|<\left(4.2+\tfrac15(1+(8/5)/40)\right)\tau^2<4.41\tau^2.
\]

Here `tau<1/40` follows from `t>=1500`. Taking real parts and multiplying by the source's actual prefactor gives

\[
 |Z-Z_0|<t^{-3/4}
 \left(\frac{(2\pi)^{3/4}}{3\pi}
       +\frac{4.41(2\pi)^{1/4}}{8\sqrt t}\right),
\]

where `Z0=Mtheta+(-1)^(N-1)*a^(-1/2)*F(z)`. Bounds `(2*pi)^(1/4)<198/125`, `pi>157/50`, `sqrt(t)>38` imply the bracket is below

\[
 \frac{3317717799}{7457500000}<\frac{45}{100}.
\]

Thus the .45 bound survives the phase-input replacement. There is no extra `a^(-1/2)` to apply to this final error; it has already been included.

## 5. Global finite-sum phase sensitivity

For each integer `N>=1`, monotonicity of `x^(-1/2)` gives

\[
 \sum_{n=1}^N n^{-1/2}\le1+\int_1^N x^{-1/2}\,dx=2\sqrt N-1.
\]

This also holds at `N=1`. Since `N<=a`,

\[
 2\sum_{n=1}^N n^{-1/2}\le4\sqrt N-2
       <4\sqrt a=4(t/(2\pi))^{1/4}.
\]

Apply `|cos x-cos y|<=|x-y|` termwise. The correction F is phase-independent, so

\[
 |Z_0-\widehat Z_0|
 <4(t/(2\pi))^{1/4}\frac{13}{50t^2}
 =\frac{26}{25(2\pi)^{1/4}t}\,t^{-3/4}
 <\frac{26}{25t}\,t^{-3/4}.
\]

Only `2*pi>1` was discarded in the last step. For **all** `t>=1500`, the relative coefficient is at most `26/(25*1500)=13/18750<1/1000`. Therefore

\[
 |Z-\widehat Z_0|
 <\left(\frac{45}{100}+\frac{13}{18750}\right)t^{-3/4}
 =\frac{33802}{75000}t^{-3/4}
 <\frac{451}{1000}t^{-3/4}<\frac{47}{100}t^{-3/4}.
\]

There is no upper height cutoff in this proof. The fixed amplitude 80, used in earlier notes on `[1500,10^6]`, is not an input. The rational script checks the constants; the integral comparison and power monotonicity are paper lemmas that still need Lean proofs.

## 6. What a sound point checker must establish

At an input height t, certify the floor branch and all arithmetic operations in the finite expression `Zhat0`. Use the continued F at its removable points; an interval containing `+/-1/2` requires a nonsingular representation, not division by an interval containing zero. The theta expression is the simple one in section 2, with a certified real logarithm and pi enclosure.

If interval arithmetic proves `Zhat0(t)` lies in `[l,u]`, and an exact upper enclosure e of `.451*t^(-3/4)` is available, then actual `hardyZ(t)` lies in `[l-e,u+e]`. A strict sign of this enlarged interval certifies the actual sign. The interval `[l,u]` already accounts for finite arithmetic; there is no permission to omit it from the allowance.

Alternatively, a checker reporting a point value with absolute arithmetic error eps may retain the legacy `.47*t^(-3/4)` total allowance when it proves `eps<=.019*t^(-3/4)`. This is a sufficient arithmetic target, not an error bound automatically supplied by an implementation. Bounds on t itself must also be propagated if its representation is an interval rather than an exact real input.

A sequence of such signs gives zero-existence statements only after order, strict alternation, actual HardyZ continuity, and endpoint checks. Completeness still needs the independently certified total zero count. This note proves neither sign-search success nor completeness.

## 7. Corrected remaining analytic proof order

The source correction in audit `7B404833...` is mandatory: the Gabcke route uses Mordell parameters **1, 2, and 1/2**. Parameter 2 occurs explicitly in 4.1.2, p62, identifying the contour Ftilde with its quotient; 1/2 occurs in 4.1.3, p63, and 1 in the Riemann–Siegel integral derivation, p66. No implication between these cases is assumed without proof.

The pending proof tasks are:

1. Construct and identify the normalized analytic Gamma logarithm using the reviewed Binet/Bohr–Mollerup route; formalize the periodic P2/P3 Laplace identity, justified Fubini, cellwise integration by parts, and coarse phase extraction. This supplies the actual theta normalization and both phase inequalities of section 3 without sharp Stirling constants.
2. Prove the special Mordell contour identities at parameters 1,2,1/2, including sloping-path orientations, Gaussian convergence, closing-edge limits, and removable quotient values. A new separate paper reconstruction is `moebius/MORDELL_SPECIAL_CASES_PROOF_PLAN_2026-11-11.md`, SHA `7BA678E0C8D7A25B4598228066B44A0CFADF402606EEFE4F6EB52C1C9F6DB050`; it was awaiting independent review when this note was assembled. The present implication does not treat its formulas as checked Lean facts.
3. Derive Gabcke 4.1.6 from the parameter-1 identity: absolutely convergent double integration, rotated Gamma moments, Dirichlet series, branch normalization, and analytic continuation. Shift past `1,...,N`, compute residues, and perform the exact saddle substitution to prove 1.2.1, including the integer-a indentation convention. This remains a separate complex-analysis task even after the special Mordell identities.
4. Formalize the Rg1 integrating-factor identity, its cancellation at the possible contour pole, and contour straightening. Prove the elementary four-range exponent bounds and Gaussian tails that yield 3.1.3 at K=1. Prove the required Ftilde derivative/moment identities and `|F'''|<=4*pi` using dominated Gaussian differentiation. No order-10 Cauchy truncation or high-order coefficient tables are needed.
5. Prove the HardyZ adapter, exact scalar assembly, global main-sum comparison, and certified arithmetic interval semantics. The scalar script is evidence for rational arithmetic, not a substitute for these analytic proofs.

Useful pinned Mathlib APIs remain those in the original ledger: Gamma integral/functional equations/nonvanishing, Gaussian integrability, parametric differentiation, finite contour Cauchy theorems, improper-integral limits, and analytic uniqueness. In particular `Analysis/SpecialFunctions/Trigonometric/Bounds.lean:283,286` supply `abs_cos_sub_cos_le` and `norm_exp_I_mul_ofReal_sub_one_le`. None of these APIs already states the complete Riemann–Siegel evaluator theorem.

## 8. Reproducible scalar receipt

`simple_phase_k0_scalar_20261111.py` writes the separate JSON receipt with the same basename. It checks the coarse phase-to-U implication, the original first-order scalar bounds, the .45 coefficient, and the global `.45 + 26/(25*1500) < .451 < .47` join using exact `Fraction` comparisons. It uses no special-function evaluator, zero data, floating acceptance decision, or native proof oracle. The selected statement remains a paper implication until the listed analytic and checker proofs are formalized.
