# An integrated residual contract for the major arcs

2026-11-11. Paper derivation from the actual cubic consumer. No Lean declaration, numerical evaluation, spectral evidence or runtime claim. This replaces an unnecessarily strong sufficient interface for one part of the proof; it does not prove the new quantitative premises.

The major-arc cubic comparison can use two weighted integrated residual moments instead of a pointwise star residual and a pointwise-in-twist plus energy. The proposed moments imply exactly the existing major error allowance. An unweighted fourth-moment estimate is not separately required by this formulation. Other consumers, particularly the base gap and the major-arc L2 bounds, remain.

## Functions, measure and general inequality

Fix x>0 and a finite major-arc family with q in Qset R, b in Bset q, and beta in[-w_q,w_q], where w_q=wrad 8 R x q. Use the finite tagged measure space consisting of these intervals, with counting measure on q,b and Lebesgue measure on beta. Define at each tagged point

    Sp = S etaPlus x (b/q+beta),
    Ss = S etaStar x (b/q+beta),
    Ap = (mu(q)/phi(q)) * Fourier(etaPC)(-beta*x) * x,
    As = (mu(q)/phi(q)) * Fourier(etaUC)(-beta*(x/kappa)) * (x/kappa),
    rp = Sp-Ap, rs = Ss-As, eN = e(-N*(b/q+beta)).

These are the actual full prime sums, including the terms that a character expansion may temporarily remove. The source's As_eq identifies As with the etaSC main term. Norm(eN)=1. All products are integrable because the tagged family is finite, intervals are compact, and the source supplies continuity. Endpoint measure zero permits the source's Ioo/Ioc conventions.

Write integrals over this tagged space as integral_D. Set

    X = integral_D |Sp|^2,       Y = integral_D |Ap|^2,
    Wstar = integral_D |Sp|^2 |rs|^2,
    Wplus = integral_D |As|^2 |rp|^2.

The exact identity

    Sp^2 Ss - Ap^2 As = Sp^2 rs + As rp (Sp+Ap)

and triangle inequality followed by Cauchy-Schwarz give

    |integral_D (Sp^2 Ss-Ap^2 As)eN|
      <= sqrt(X Wstar) + (sqrt X+sqrt Y) sqrt Wplus.       (1)

For the first term use |Sp| times |Sp rs|. For the second use |As rp| times |Sp+Ap|, then Minkowski in L2. No independence, characterwise diagonalization, sign cancellation or a pointwise bound on rs is assumed. Wstar is a genuine mixed moment; bounds for separate unweighted integrals do not imply it.

## A source-compatible sufficient allocation

For the source application take a natural cutoff 1<=R<=150000 and x>=4.9e26. The selected value is R132900. Physical periodic arc assembly uses integer N; retain natural N for the source application. Its final lower bound further retains odd N and N/x=2+9/(8 sqrt(pi/2) kappa). The abstract inequality(1) does not need these stronger bounds. Use kappa=49 and the rational constants

    j=8.79, a=.640208*13.59756,
    u=3.67e-6, rho=8.85e-7, v=7.78*2.85.

The sufficient premises are

    X <= j*x,                 Y <= a*x,
    kappa^2 Wstar/x^3 <= j*u^2,
    kappa^2 Wplus/x^3 <= kappa*rho^2*v.                  (2)

Then the cubic error, normalized by x^2/kappa, is at most

    j*u + rho*sqrt(kappa*v)*(sqrt j+sqrt a).

Since (sqrt j+sqrt a)^2<=2(j+a), and

    (kappa*(j+a)/9 + 9*v/2)^2 - 2*kappa*v*(j+a)
      = (kappa*(j+a)/9 - 9*v/2)^2 >=0,

this is at most

    j*u + rho*(kappa*(j+a)/9 + 9*v/2).                 (3)

Expression(3) is exactly the current major proof's cubic error before the Fourier-tail term. Thus no reserve from the .0013565 final margin is spent by this substitution. The unchanged tail allowance is kappa*2.03e-5*2.85 in the same normalization. This comparison uses exact algebra and nonnegativity; it needs no numerical square-root approximation.

The original pointwise hypotheses imply(2). The star bound |rs|<=u*x/kappa gives Wstar<=(u*x/kappa)^2 X. For plus, at fixed q,beta the main As is independent of b, so sum_b |rp|^2<=(rho*x)^2 gives

    Wplus <= rho^2*x^2 * sum_q mPhi2(q)
                    * integral_beta |Fourier(etaUC)(-beta*x/kappa)*(x/kappa)|^2
          <= rho^2*x^2 * 2.85 * 7.78*x/kappa.

Likewise card(Bset q)*|mu(q)/phi(q)|^2=mPhi(q), so the source Fourier L2 and mass upper bounds give Y<=a*x. These implications establish that this is a sufficient relaxation of the relevant interfaces; they are not a new unconditional proof of(2).

## Actual consumer and unchanged obligations

The source is TernaryGoldbach/MajorArcs/MajorTotal.lean, SHA256106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A. Its pointwise_bound at760 uses h_rho and h_U; per_modulus at808 integrates their cubic error; major_total at974 sums it and applies X<=8.79x. Lines887-915 provide the Fourier etaUC and etaPC L2 estimates. Singular.lean:655 gives sum mPhi2<=2.85, while SumMuPhi.lean:108 gives the mass upper bound13.59756. Restricting nonnegative upper sums to the proposed R132900 is legitimate after the existing Qset inclusion adapter. The source itself still uses R150000 and Fact PlattGRH.

With(1)-(3), a new assembly can sum the cubic errors on the tagged domain directly, then add the existing per-modulus Fourier-tail comparison and main-term/singular-series lower bounds. For q in Qset R, the source qt(q)<=2R gives w_q*x=8R/qt(q)>=4, as required by the unchanged Fourier-tail comparison. The reduced intervals lie inside the original pointwise hypothesis range. The source geometric inequalities8R<=x and8R^2<=x/2 hold in the stated application range. The periodic major-arc partition must still be proved; the tagged measure does not authorize double-counting physical arcs. The current disjointness and periodicity adapters provide that structural task, not new spectral evidence.

The X<=8.79x premise still needs proof for the chosen route. It cannot be imported from the current PlattGRH-dependent theorem while claiming that assumption removed. The lower major-arc energy used by the minor arcs, principal approximation, all nine minor cells, the asymptotic range, nonprime correction and finite Goldbach coverage remain. BaseGap2's all-point etaStar statement is separate and is not implied by(1) or(2).

The point of the reformulation is an exact target for averaged analytic research: prove the two actual weighted moments cheaply without producing all individual L-function or zero certificates. No available large-sieve statement has been shown here to meet them. Character projectors may represent the residuals, but the mixed moment keeps all required indices and twists. A Hurwitz seed array is not the prime-residual vector in this theorem.

Independent review is pending. This note makes no assertion that the proposed route reduces generation/checking work until the quantitative moment premises have an adequate proof and cost model.
