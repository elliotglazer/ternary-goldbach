# Q=1 base-gap alternative through prime counting

Research only. This note gives a complete analytic reduction and an exact arithmetic budget, not a new prime-counting theorem or a Lean proof. The resulting sufficient prime-counting estimate is currently unavailable without an excluded finite-height RH input. It therefore identifies a concrete alternative to the stationary absolute-zero-count route but does not close the Q=1 branch.

## Domain and result of the reduction

Write y=x/49>=10^25, and let Q be the reduced denominator for 2 alpha. When Q=1 the original reduced denominator q for alpha is 1 or 2. The parity-aware gap widths give

    alpha = a/q + delta/y,
    600000/49 <= D=|delta| < 600000.

Use the actual etaU=eta2 *_M phi, phi(t)=t^2 exp(-t^2/2), and the source identity S etaStar x alpha = expTsum (Lambda(n) etaU(n/y)) alpha. There is no further rescaling of delta by49.

Here is a sufficient, independently meaningful arithmetic target:

    For every real v>=exp(45),
    |psi_R(v)-v| <= 1.1e-8 v,                                      (P)

where psi_R(v)=Helfgott.psi(floor(v)) for v>=0. The source psi has natural-number input; the real extension must be made explicitly. Target (P) is not an approved declaration or a new permitted premise. It must be proved independently if this route is used.

The calculations below show that (P) implies, uniformly on this entire domain,

    |S etaStar x alpha|/y < .046673 < .04712 < ghatY(y,150000).      (Q1)

The final ghat lower bound is the separate research calculation in agents/major-constants/base_gap_variable_budget.py and its report, not a presently kernel-checked theorem. In particular, this comparison uses the actual ghat consumer, not the substantially smaller surrogate constants considered earlier.

## Exact moments of the actual smoothing

Let A(s)=integral eta2(r) r^(s-1) dr. Direct integration of the logarithmic tent defining eta2 gives

    A(s)=4 ((1-2^(-s))/s)^2,
    A(0)=4(log 2)^2.

Thus A(1)=1, A(2)=9/16, A(-2)=9 and A(-4)=225/4. Mellin convolution gives

    integral t etaU(t) dt = A(2) integral u phi(u) du = 9/8.        (M)

All integrals here are over positive reals unless a domain is written. Differentiating the convolution is justified by eta2's compact support [1/4,1] and Gaussian domination:

    etaU'(t)=integral eta2(r) phi'(t/r)/r^2 dr.

Nonnegativity, Tonelli and the substitution t=ru then yield

    integral t |etaU'(t)| dt
      <= A(1) integral u |phi'(u)| du
      <= integral (2u^2+u^4) exp(-u^2/2) du
      =5 sqrt(pi/2) <6.27.                                      (V)

For f_delta(t)=etaU(t) exp(2 pi i delta t), (M) and (V) imply

    integral t |f_delta'(t)| dt <=6.27+(9 pi/4)D.

This bound retains the eta2 convolution exactly; the etaU Gaussian envelope144 is not used.

## Partial summation, including the uncontrolled small range

Let E(v)=psi_R(v)-v and A0=exp45. Stieltjes partial summation gives

    S_delta(y)/y - integral f_delta(t) dt
      = -(1/y) integral E(yt) f_delta'(t) dt.                     (PS)

At infinity the boundary term vanishes by Gaussian decay and the elementary bound psi_R(v)<=v log v; at zero psi_R(v)=0 and f_delta(t)=O(t^2). Thus the identity also proves the required convergence, rather than relying on a potentially divergent tsum convention.

For v>=A0, target (P) bounds the integrand by epsilon*t*|f_delta'(t)|, epsilon=1.1e-8. For 0<=v<A0, Lambda(n)<=log n implies |E(v)|<=46v: when v>=1, psi_R(v)<=45v, and when v<1, psi_R(v)=0.

Set a=A0/y<3.5e-6. From A(-2) and A(-4), without needing any approximation to etaU,

    etaU(t)<=9t^2,
    |etaU'(t)|<=18t+(225/4)t^3.

Consequently the additional small-range contribution is at most

    46 integral_0^a t (18t+(225/4)t^3+18 pi D t^2) dt
      =46 [6a^3+(45/4)a^5+(9 pi/2)D a^4] <1e-12.               (L)

Using the full variation bound for the large-range term only enlarges the answer. Therefore

    |S_delta(y)/y - Fourier(etaU)(-delta)|
      <=epsilon [6.27+(9 pi/4)D]+1e-12.                         (E)

The source Fourier estimate and D>=600000/49 give

    |Fourier(etaU)(-delta)| <=1.016/D^2 <7e-9.

For q=1 this is the needed sum. For q=2, a is odd and the exact identity is

    S_(a/2+delta/y) = -S_delta + 2 sum_(2 divides n)
                         Lambda(n) etaU(n/y) exp(2 pi i delta n/y).

Only powers of2 contribute to the last sum. The elementary noncoprime bound in BaseGap2 gives its norm <=2e-9*y, hence a correction <=4e-9*y. This deliberately keeps the source's loose uniform bound; no new estimate for powers of2 is needed.

## Exact arithmetic and evidence

The adjacent script base_gap_q1_pnt_constants.py uses Python Fraction for every acceptance comparison. It checks

    (2.7182818286)^45 <3.5e19,
    (1.254)^2 >11/7,
    (L) <1e-12,
    1.016/(600000/49)^2 <7e-9,
    epsilon*(6.27+(9/4)*(22/7)*600000)+small+main+4e-9
        <.046673 <.04712.

The elementary external inequalities e<2.7182818286 and pi<22/7, the analytic identities above, and (P) are not proved by that script. Its role is only to certify arithmetic after those inputs. The executed script exited0 and printed PASS_EXACT_BUDGET; PNT INPUT REMAINS UNPROVED IN CAMPAIGN. It also checks the budget for epsilon=1.0412e-8.

## Does an available prime-counting estimate supply (P)?

The corrected Faber--Kadiri table gives epsilon=1.0412e-8 from log(v)>=45, which would be numerically sufficient. However, its Table1 explicitly uses Platt's verification up to H=30,610,046,000; Table2 instead uses Gourdon's verification. The theorem's inputs include finite-height RH. Thus importing this table would restore an excluded dependency, even if the final published table is presented as an unconditional numerical result. See Theorem0.1 and Tables1--2 of [Faber and Kadiri, Corrigendum to New Bounds for psi(x)](https://www.cs.uleth.ca/~kadiri/articles/New-Bounds-for-Psi-Math-Comp-Faber-Corrigendum-Nov2017.pdf).

The global7/8 zero-location assertion alone does not automatically produce (P). The raw scale v^(-1/8) at v=exp45 is exp(-45/8), about.0036, before logarithmic factors and constants; the desired relative error is1.1e-8. This comparison only diagnoses the inadequacy of the available coarse power bound. It is not an impossibility theorem for stronger consequences of QRH.

## Signed zeros and the functional equation

One can retain the signed zeta zero sum in the explicit formula. Conjugation and reflection package it into real oscillatory terms involving exp(i gamma log y) F(beta+i gamma,delta), with the correct reflected beta. This gives an exact identity, but it supplies no uniform cancellation inequality among different heights. The oscillation of a continuous density approximation cannot be substituted for the discrete zero measure without a proved bound on the resulting discrepancy.

A direct signed-zero estimate strong enough for the current gap budget remains a legitimate second route; the previously identified aggregate scaled target79 is sufficient. Stating that target as a new hypothesis would merely restate the missing work. This note instead offers (P), which is stronger than needed but is a conventional arithmetic estimate with an explicit numerical threshold. Neither functional-equation symmetry alone nor the existing local zero counts have been shown here to establish it. No claim about the impossibility of a different unconditional exponential-sum argument is made.

## Source interfaces and remaining work

All line references below are to pinned work/ternary-goldbach/TernaryGoldbach at23b2d68:

- Helfgott/NonPrime.lean:23: Helfgott.psi, natural-number input.
- MinorArcs/BaseGap2.lean:23: etaU_eq_mellinConv.
- MinorArcs/BaseGap2.lean:41: sum_noncoprime_le; lines369--398 provide the <=2e-9*y scalar estimate. The latter is inside a larger proof, so it must be extracted rather than cited as an existing standalone theorem.
- MinorArcs/BaseGap2.lean:170: fourier_const_le; lines331--346 combine it with norm_fourier_etaU_le.
- MinorArcs/BaseGap2.lean:230: S_etaStar_eq_expTsum.
- MinorArcs/LinftyLevels.lean:351: ghatY, the actual consumer.

A formal route would first prove the Mellin moments and differentiated-convolution domination, then the real-variable partial-summation identity with summability, then the conditional reduction (P)=>(Q1). These are meaningful reusable lemmas, but the full result must discharge (P) and the ghat lower bound without adding either as an unexplained final assumption. This research task launches no Lean process and changes no canonical source.
