# A finite spectral leaf for the refined psi estimate

Research, 2026-11-11. No Lean build, source edit, zero evaluation, or new allowed assumption. Frozen `RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md` is unchanged. This note describes tasks whose proofs would discharge its low-zero contract. It does not certify their truth.

## Result of this investigation

A count bound and a first-zero exclusion can establish the **unweighted** reciprocal moment without enumerating all zeros through one million. They do not imply the required narrow strip or, by themselves, its exponentially weighted moment. A concrete sufficient package is:

1. No nontrivial zeta zeros with `|gamma|<=14`.
2. Every nontrivial zero with `|gamma|<=1000000` has `.499<beta<.501`.
3. For positive ordinates through A=1500, with multiplicity,
   `Q_A = sum m*(1/gamma - 1/A) <= 2`.
4. The analytic count majorant below holds for all real `t>=1500`.

These imply the frozen weighted moment **W35<23.913<24**. Condition2 is stronger than the frozen [.49,.51] requirement but does not assert critical-line equality. Conditions1–3 are proposed finite certificate targets, not imported data. Condition4 is an analytic proof task. Global QRH and reflection remain the existing campaign framework.

An alternative package replaces3–4 by the same count majorant for all `t>=14`; it gives an unweighted moment below23.18 and W35<23.594. The separated package avoids silently importing historical low-height computations into the analytic theorem.

## Count theorem and its dependencies

Let N(t) count all nontrivial zeros with `0<gamma<=t`, including multiplicity. Set

\[
F(t)=\frac{t}{2\pi}(\log(t/(2\pi))-1)+\frac78,
\qquad R(t)=.137\log t+.448\log\log t+1.588.
\]

The needed analytic inequality is `N(t)<=F(t)+R(t)` for t>=1500. The .448 coefficient deliberately rounds up the usual .443.

Rosser's Theorem19 gives the familiar global count estimate. Its proof explicitly separates the low range, using Theorems17–18 and computations of Hutchinson and Titchmarsh, from the Backlund-style analytic argument above approximately1467.48. Thus the published all-height theorem is not a computation-free leaf. The high-height argument can be reconstructed with the safer threshold1500, independently of the low computations; this reconstruction has not been formalized or fully rederived here. [Rosser, pp.223–224, original issue scan and text](https://archive.org/stream/sim_american-journal-of-mathematics_1941-01_63_1/sim_american-journal-of-mathematics_1941-01_63_1_djvu.txt).

The modern count literature confirms the conventional .443 coefficient, but its numerical all-height corollaries may themselves use finite zero data. In particular, the proof of Hasanalizade–Shen–Wong Corollary1.2 extends the analytic large-height calculation using previous finite computations. This note does not adopt that corollary as an assumption-free replacement. [Hasanalizade–Shen–Wong, Table1 and proof of Corollary1.2](https://arxiv.org/pdf/2107.06506).

## Reciprocal moment and boundary terms

Write T=1000000 and a>0. For any finite multiplicity measure, direct integration of each indicator gives

\[
\sum_{a<\gamma\le T}\frac{m_\rho}{\gamma}
=\frac{N(T)}T-\frac{N(a)}a+
\int_a^T\frac{N(t)}{t^2}\,dt.
\tag{1}
\]

This formula includes zeros at T in N(T). Zeros at a are excluded on the left and cancel on the right. Neither endpoint is allowed to be silently dropped. If N(a)=0, the negative term disappears. If the low zeros are handled separately, it instead produces the useful correction

\[
\sum_{0<\gamma\le T}\frac{m_\rho}{\gamma}
=Q_a+\frac{N(T)}T+\int_a^T\frac{N(t)}{t^2}\,dt,
\quad
Q_a=\sum_{0<\gamma\le a}m_\rho(\gamma^{-1}-a^{-1}).
\tag{2}
\]

In particular, a zero exactly at a has zero weight in Q_a; (2) still counts it correctly through the integral and terminal term.

The count majorant bounds the last two terms of (2) by

\[
B(a,T)=\frac{\log^2(T/(2\pi))-\log^2(a/(2\pi))}{4\pi}
+\frac{F(a)}a+
\frac{R(a)+.137+.448/\log a}{a}.
\tag{3}
\]

Indeed the F integral is exact. For R, integration by parts gives
`R(T)/T + integral_a^T R(t)/t^2 = R(a)/a + integral_a^T R'(t)/t`.
Use `R'(t)=.137/t+.448/(t log t)` and bound the last integral by
`(.137+.448/log a)/a`. This upper bound remains valid at zero ordinates where N jumps; no differentiability of N is used.

Our exact rational scalar checker uses `log log14<1` and `log log1500<2`, giving

* `2 B(14,T) < 23.178845 < 23.18`;
* `B(1500,T) < 9.746111 < 9.747`.

Consequently the selected head condition Q_1500<=2 gives a both-sign ordinate moment below `2*(2+9.747)=23.494`. The real-zero issue is separate: the closed height14 exclusion removes gamma=0, and conjugation then doubles positive-height sums exactly. Finally `1/|rho|<=1/|gamma|`.

## Why [.49,.51] alone is insufficient for this reduction

The frozen target is

\[
W_{35}=\sum_{|\gamma|\le T}m_\rho
\frac{e^{35\max(\beta-1/2,0)}}{|\rho|}\le24.
\]

Suppose reflection preserves the zero carrier and multiplicity and `|beta-1/2|<=d`. First enlarge the denominator to `|gamma|`. Averaging the sum with its image under `beta -> 1-beta` gives

\[
W_{35}\le\frac{1+e^{35d}}2
\sum_{|\gamma|\le T}\frac{m_\rho}{|\gamma|}.
\tag{4}
\]

This is an exact finite bijection argument. At beta=1/2 the summand is fixed and the true factor is1; averaging introduces no half-multiplicity convention. Conjugate pairs and any repeated zeros are treated with their actual multiplicities.

With d=.01 and unweighted upper23.18, the resulting upper expression exceeds28. This only shows that this bound does not discharge W35; it is not a lower bound on the actual W35. With d=.001, (4) gives

* full count-plus-gap route: `23.18*(1+exp(.035))/2 < 23.594`;
* selected head route: `23.494*(1+exp(.035))/2 < 23.913`.

The sharper unrounded full-count expression permits d approximately.00196, but .001 gives a transparent margin. Alternatively, one could retain the wider strip and certify a beta-weighted density moment. That is a different finite task, not a consequence of ordinary N(t).

## How to certify the finite tasks without a list of all zeros

Use the source's entire continuation `TernaryGoldbach.Explicit.zetaF`, defined at `Explicit/ZetaGrowth.lean:17`, with `zetaF_one:22` and `differentiable_zetaF:30`. It equals `(s-1)*zeta(s)` away from1 and has value1 at1. Do not use Mathlib's raw pointwise product at the pole. Orders of nontrivial zeros coincide with those of zetaF; `TernaryGoldbach.Explicit.multRectD_eq_mult` (`WeilBridge.lean:87`) provides the existing divisor bridge, subject to its explicit carrier and T>=1 conditions.

For the height14 exclusion, a zero-free closed rectangle `[.1,.9] x [-14,14]` covers the global QRH strip. A certified nonvanishing boundary and winding number0 prove interior zero count0 by the argument principle; include the boundary nonvanishing proof. This also excludes real zeros relevant to the moment.

For the stronger narrow strip, use the closed right rectangle `[.501,.9] x [-T,T]`. Nonvanishing on its boundary and winding0 exclude the entire rectangle. Global QRH excludes beta>.9; functional-equation reflection, with multiplicity transport proved, gives the left exclusion beta<=.499. No winding calculation is asserted to have been performed. The top/bottom boundary includes any candidate zero with |gamma|=T in this right rectangle, so the desired closed-height conclusion follows. Critical-line zeros on these heights lie outside the rectangle and do not invalidate its contour.

For Q_1500, choose rational checkpoints `14=t0<t1<...<tk=1500`. Certify complete count upper bounds `N(tj)<=nj`. Then

\[
Q_{1500}=\int_{14}^{1500}N(t)t^{-2}\,dt
\le\sum_{j=1}^k n_j(1/t_{j-1}-1/t_j).
\tag{5}
\]

This needs only counts, not individual ordinate enclosures or simplicity. Each count can come from an argument-principle certificate for `[.1,.9] x [0,tj]`. Boundary zeros must be excluded by that certificate, or the checkpoint must be moved outward to a rational height with a certified nonzero boundary and the resulting larger count used. Do not infer completeness from a list of sign changes alone.

A diagnostic geometric grid `tj=min(1500,14*(101/100)^j)` has470 cells. Substituting the *proposed* integers `floor(F(tj)+R(tj))` gave a floating-point acceptance sum about1.816, comfortably below2. These integers are not certified counts; this calculation only suggests that a coarse count certificate is plausible. It is not included among the checked scalar conclusions. A proof-producing count engine must supply actual nj and replay (5) exactly.

An alternative is Hardy-Z sign changes plus a complete argument-principle/Turing count. If the number of distinct sign-change intervals equals the full zero count, there is no room for additional off-line zeros or higher multiplicity. That would prove the stronger critical-line contract, but requires roughly1.75 million positive zeros through T and an additional completeness theorem. The rectangle route avoids requesting critical-line equality; its runtime is not established and may still require many evaluations near the left boundary.

## Replay status and implementation order

`resume_psi_spectral_leaf_20261111.py` passed with exit0. It checks rational Taylor bounds for exponentials, alternating-series bounds in Machin's pi formula, log enclosures, and all displayed rounded scalar implications. It does not call a zeta function. Its output is computational scalar evidence, not a Lean theorem; the elementary analytic soundness lemmas still require kernel proofs.

The smallest next target is the closed height14 rectangle and a few complete N(t) count certificates, exercising a rational complex-function enclosure and argument-principle replay. Then certify the470-or-fewer head checkpoints and Q<=2. In parallel, reconstruct the analytic count bound only for t>=1500. Finally tackle the right narrow rectangle through one million. No external Arb output, historical zero table, or published finite RH result may be turned into an axiom or permanent premise.

The unresolved work is therefore explicit: finite nonvanishing/winding evidence, completeness and multiplicity bridges, the analytic large-height count theorem, and kernel-checkable replay. This note reduces the reciprocal-moment workload; it does not remove the substantial finite narrow-strip certificate.
