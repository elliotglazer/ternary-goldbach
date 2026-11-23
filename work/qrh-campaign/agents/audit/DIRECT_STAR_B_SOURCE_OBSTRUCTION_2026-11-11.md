# Direct star B: physical arcs, prime large sieve and the remaining deficit

2026-11-11. Bounded source and mathematical research. No prime, L-function, zero, integral or transform value was evaluated. No Lean build, declaration or source edit occurred. The new receipt uses only rational and integer comparisons.

There is a noncircular physical-arc reduction of B, with the exact principal subtraction and a small coprime correction. Full-circle Parseval gives a growing logarithmic comparison. The source prime large sieve improves this to a bounded comparison, so the logarithm alone is not an obstruction. However, the particular scalar corollary available in source still cannot close the proposed uniform Wstar allocation by that route: even granting sharp coefficient asymptotics, vanishing removal costs and exact principal subtraction, its limiting comparison allowance exceeds 117.6. The Wstar allocation permits less than 53 even at A=0.

This conclusion concerns the displayed sufficient comparisons. It is not a lower bound on actual B, a proof that B<=9 is false, or a limitation on every possible large-sieve or prime-variance argument.

## 1. The actual physical identity

Use R=132900, x=49y, y>=10^25, Dq=8R/qt(q), and

    a_y(n)=Lambda(n)*etaU(n/y),
    F_y(alpha)=sum_n a_y(n)e(n alpha).

The actual source identity identifies F_y with S etaStar x. Let F'_q be its coprimePart(q) sum. The nonprincipal energy from `WSTAR_WEIGHTED_SPECTRAL_STATISTIC` is exactly

    E_q(delta)=sum_(b unit mod q)|F'_q(b/q+delta/x)/y|^2
                 -mu(q)^2/phi(q)*|F'_q(delta/x)/y|^2.

This is finite character Parseval with the ambient principal character removed. The character energy includes the exact Gauss norm and inverse-character label. In particular the principal weight here is mu(q)^2/phi(q), not mu(q)^2/phi(q)^2. The latter appears in the separate A target only after multiplication by the major main factor.

Define

    B=sum_q integral_[-Dq,Dq] E_q(delta) ddelta,
    Lcop=sum_q mu(q)^2/phi(q)
                  *integral_[-Dq,Dq]|F'_q(delta/x)/y|^2 ddelta.

Put M={alpha in (0,1]:alpha in majorArcs 8 R x}. Source arc periodicity/disjointness, with 16R^2<=x, gives

    Cfull=sum_(q,b) integral_[-Dq,Dq]|F_y(b/q+delta/x)/y|^2 ddelta
          =(49/y)*integral_M |F_y(alpha)|^2 d alpha.       (1)

The Jacobian is x/y^2=49/y. Equality follows by combining `LargeSieveArcs.integral_majorArcs_le:103` with `MajorArcs/ArcsEq.sum_arcs_le_integral_majorArcs:34`, then changing variables on each interval. Finite tagged interval endpoints have measure zero. The q=1 and periodic boundary arcs require the same source periodization as the existing major-arc assembly; they are not discarded.

For every q the source gives |F_y-F'_q|/y<=d0=2e-9. Finite-measure Minkowski gives

    B<= (sqrt(Cfull)+epsilon)^2-Lcop,
    epsilon=d0*sqrt(V), V=sum_q 2Dq*phi(q).               (2)

Since R is even, Qset R has R/2 odd moduli and R even moduli. For both parity types phi(q)/qt(q)<=1/2, including q=1,2. Therefore V<=12R^2 and epsilon<.0010632. This is a uniform coarse correction; it is not an assertion that the actual removal is independent of y. Formula (2) keeps both the q-dependent coprime operation and the principal subtraction. Applying full-circle Parseval separately to every q and adding would pay an unnecessary modulus multiplicity.

## 2. What full-circle Parseval supplies

Absolute summability and the source Fourier-series Parseval theorem give

    Cfull <=49*t(y),
    t(y)=(1/y)*sum_n Lambda(n)^2*etaU(n/y)^2.              (3)

This is exact as a sufficient bound; t(y) is not an evaluated constant. A coarse source-compatible estimate can be derived without nonprincipal hypotheses. The positive eta2 mixture has mass less than 2, and its Gaussian factor g(v)=v^2 exp(-v^2/2) has supremum 2/e<1. Hence etaU(t)<=2. Also t^2 etaU(t)<6, since r<=1 in the mixture and sup_v v^4 exp(-v^2/2)=16/e^2<3. Positivity gives etaU>=0.

For n>=1, Lambda(n)^2<=Lambda(n)log(n), and log_+(t)<=t^2. Thus

    Lambda(n)^2 etaU(n/y)^2
       <=Lambda(n)*etaU(n/y)*(2log y+6).

The unconditional `MinorTotal.norm_S_etaStar_le_uniform:49`, evaluated at zero frequency, bounds the positive coefficient sum by 22.75y. Consequently

    t(y)<=22.75*(2log y+6).                               (4)

The omitted n=0 term is zero. The same Gaussian domination justifies the squared summability needed in (3). Bound (4) is deliberately coarse. Its growth prevents (3)-(4) from proving a fixed B allowance throughout unbounded y. Even a sharp coefficient estimate has a leading log y term; a fixed principal projection cannot cancel that term after replacing the physical arcs by the whole circle. This is a loss of the full-circle bound, not a statement about the thin physical arcs or actual B.

## 3. The source prime-arc sieve is noncircular but quantitatively insufficient here

Split a_y=g_y+h_y, where g_y is supported on primes n>sqrt(x)=7sqrt(y), and h_y contains the other coefficients. Define

    tlarge(y)=(1/y)*sum_n|g_y(n)|^2,
    esmall(y)=(1/y)*sum_n|h_y(n)|^2.

The source `LargeSieveProof.cor_12_2_5:378` applies to this prime-supported, absolutely summable g_y. With delta0=8 and Q0=R it gives

    integral_M |expTsum g_y|^2 <=C_R(y)*sum_n|g_y(n)|^2,
    C_R(y)=[log(2R)+2]/[.5log y+log(7/2)+cE],
    cE=1.33258.                                         (5)

The denominator is log(2sqrt(x/16))+cE. All size conditions hold on the stated domain: R>=10^5, (20000R)^2<=x/16 and 2R<=(2sqrt(x/16))^.6. The exact sufficient integer checks are in the receipt. This source corollary has a broad Fact PlattGRH binder, but its invoked quotient/totient chain was already traced to principal RH. Localizing that dependency is required; no nonprincipal character estimate is used to justify (5).

Minkowski on M and full-circle Parseval for h_y yield

    Cfull<=49*(sqrt(C_R(y)*tlarge(y))+sqrt(esmall(y)))^2.  (6)

Together with (2), this is a precise noncircular route if sufficiently sharp coefficient and principal-projection bounds can be proved. The existing `MinorTotal.T_le`/Prop715 estimate concerns etaPlus coefficients, not etaU coefficients. It cannot be copied into tlarge(y). Similarly the existing EBound for the etaPlus split cannot simply be renamed esmall(y). A new etaU coefficient-energy and small-prime/prime-power adapter is necessary.

Unlike (3), the ratio (5) cancels a leading log y in tlarge(y). Thus the crude full-circle logarithm does not justify dismissing prime-arc sieve research. The obstacle below is its constant after that cancellation.

## 4. Retaining the principal projection still leaves this comparison above 117.6

Let

    V_U=integral_0^infinity etaU(t)^2 dt,
    L0=sum_q mu(q)^2/phi(q)
                  *integral_[-Dq,Dq]|Fourier(etaUC)(-delta/49)|^2 ddelta.

L0 is independent of y. Principal RH and removals control the difference between sqrt(Lcop) and sqrt(L0). For example a uniform principal coprime error epr=1.502e-6 gives

    Lcop>=max(sqrt(L0)-epr*sqrt(K_R),0)^2,
    K_R=sum_q 2Dq*mu(q)^2/phi(q).

The finite source totient comparison phi(q)>=q/(21/4), qt(q)>=q and sum_(n>=1)n^-2<2 give K_R<168R. This error is small, but no numerical L0 has been evaluated here.

To test the strongest plausible use of (5) with a scalar coefficient energy, grant the favorable sharp asymptotic

    tlarge(y)=V_U*log y+O(1), esmall(y)=o(1),

and grant exact principal subtraction Lcop=L0 and zero coprime-removal cost. This is an optimistic comparison model, not an inherited etaU theorem. Such a coefficient asymptotic would require weighted partial summation from the retained principal prime estimates and the prime-power split. It does not require nonprincipal RH, but that derivation has not been formalized or supplied as a new checked theorem here.

The limiting allowance produced by (2), (5), (6) under these favorable inputs is

    49*2*(log(2R)+2)*V_U-L0.                             (7)

Full-line Plancherel and nonnegative interval restriction give

    L0<=49*M_R*V_U,
    M_R=sum_(q in Qset R) mu(q)^2/phi(q)<13.59756<14.      (8)

No lower bound on L0 is being used as an upper bound in this step. Equation (8) gives an upper bound on how much principal subtraction could possibly help in (7).

There is a simple analytical lower bound V_U>1/5 without evaluating a transform or integral numerically. The source eta2 mass is integral eta2=1. The positive mixture gives integral etaU=sqrt(pi/2)>1. Because r<=1, its tail above 2 is at most the tail of g above 2. Integration by parts and the Gaussian tail inequality give

    integral_2^infinity g(t)dt
       <=(2+1/2)*exp(-2)<5/14,

using exp(2)>7. Hence integral_0^2 etaU>9/14, and Cauchy-Schwarz gives V_U>(9/14)^2/2>1/5. All boundary terms and integrals are controlled by the same Gaussian mixture. Also log(2R)>11, since exp(1)<3 and 3^11<265800. Therefore (7)-(8) imply that this comparison's limit is strictly greater than

    49*[2*(11+2)-14]/5 =117.6.                           (9)

This rules out obtaining the proposed uniform B allocation from a comparison with these leading terms by the specific source corollary (5), a sharp scalar coefficient-energy asymptotic, and principal subtraction alone. Errors estimated only in the adverse direction cannot improve this comparison. The exact principal limit is part of the stated favorable comparison model, not a new numerical assertion about Lcop. It does not rule out exploiting additional structure before taking the uniform quotient bound, a sharper primitive-family sieve, or a direct bound for centered prime variance. Nor is (9) a lower bound on B: it is a lower bound on the limiting upper-bound expression supplied by this method.

## 5. How far the A/B allocation can be relaxed

The earlier full-residual inequality is

    sqrt(49^2 Wstar/x^3)<=p*sqrt(j)+sqrt(A)+rho*sqrt(B),
    p=1.504e-6, j=8.79, rho=8.85e-7, u=3.67e-6.

The exact frontier is

    sqrt(A)+rho*sqrt(B)<=sqrt(j)*(u-p).                  (10)

For any A<=j*(u-p)^2 this allows

    B<=[sqrt(j)*(u-p)-sqrt(A)]^2/rho^2.

The independent rational checker avoids numerical square roots by testing the equivalent two inequalities

    C-A-rho^2 B>=0,
    (C-A-rho^2 B)^2>=4A*rho^2 B, C=j*(u-p)^2.

The largest integer B at four illustrative A caps is:

| A cap | Largest integer B allowed by (10) |
|---:|---:|
|9e-12|14|
|4e-12|24|
|1e-12|37|
|0|52|

At A=0 the exact ceiling lies strictly between 52 and 53. Thus B<=9 was a convenient allocation with reserve, not a necessary threshold. A bound near 14 could be useful without changing A<=9e-12. No allocation within this residual argument makes the comparison allowance (9) acceptable.

## 6. Minor-arc bounds and the concrete remaining target

`LinftyLevels.norm_S_etaStar_le_ghat` applies outside its specified major arcs. The present B integrates inside the narrow arcs M. The base-gap target covers the difference between the wider star-scale arcs and the narrower plus-scale arcs; it does not cover this inner region. An upper bound on the outside energy cannot be subtracted from a full-circle upper bound to obtain an inside upper bound. A lower bound on outside energy would be different information and is not supplied by those theorems.

The existing minor cubic estimate also weights with etaPlus coefficients and uses the lower-J and base-gap machinery. It is not an unweighted etaU energy bound. Invoking its old bundled proof to establish the replacement input would restore the nonprincipal premise rather than prove it independently.

The exact current gap is therefore a bound for the centered quantity in (2) sharper than the uniform prime-sieve quotient. One useful target is to retain the principal subtraction inside the arithmetic/sieve argument and prove B<=14, together with A<=9e-12. A primitive-conductor or variance-sensitive estimate could avoid the loss measured in (9). The source `prop_12_1_2:295` retains exact Gq ratios before replacing them by (5); this is a possible place to investigate, but its current theorem still gives a scalar multiple of total coefficient energy. No quantitative improvement is asserted here.

Principal RH through 10^8 and its source localization remain. The three actual aggregate targets remain unproved. This report supplies a sound physical identity, a noncircular source reduction, an optimized allocation, and a quantified obstruction to two specific bounds. It supplies no unconditional Wstar estimate or production saving.

## Evidence

The exact script `direct_star_B_budget_20261111.py` checks four integer frontier maxima and twelve rational/integer comparisons. It does not evaluate t(y), esmall(y), V_U, L0 or B. The source and predecessor pins below bind the inspected interfaces.

| File | SHA256 |
|---|---|
| [WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md) | AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B |
| [THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT_2026-11-11.md) | 78119012C8BA40AFC93AB523B84DD441CD19D3FBC76F12418C41DD081B3C9F28 |
| [direct_star_B_budget_20261111.py](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/direct_star_B_budget_20261111.py) | 21093EDB79CCD6D376380DC40B3863FBC61021D28E0B61293011C576CF5E68C4 |
| [direct_star_B_budget_20261111.json](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/audit/direct_star_B_budget_20261111.json) | A2F8F9FA9DC9416E64AAA152D942FF91B687C4269D4E19E680C2BF64A6BDF74D |
| [ArcsEq.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/ArcsEq.lean) | 302D1DB08BC05B0A3E649AC07C3E37F74E0EDE7DCE5041A8952AA9021FBF2976 |
| [LargeSieveArcs.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/LargeSieveArcs.lean) | 0794C8853D9B1AA91EFEC3C9D91F5F1EFCECB98B484C701C360DD8EF5AC592BF |
| [LargeSievePrimes.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/LargeSievePrimes.lean) | B701BA5355E6ECEAEEF466015BDE4EC477C570BCF6B76A5D95A7043B7804C836 |
| [LargeSieveProof.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/LargeSieveProof.lean) | FB71222C80D0377BDF6739529E527F4BE6A0C908286FF87F0EC19D67DDE9CAF1 |
| [MinorTotal.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/MinorTotal.lean) | 6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742 |
| [LinftyLevels.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/LinftyLevels.lean) | 12605A6C6B8E97BA5ABADEC4F761E322F8C04E8D4C6557AC5BE1084194EA6409 |
| [Bombieri.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/Bombieri.lean) | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| [BaseGap2.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean) | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| [Cor933.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/Cor933.lean) | 554F00DE4FA6F8F0B6B184F8E8535B8AC5C28C0DB47FA2A95119B6BA4899F66E |
| [Eta2Moments.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/Eta2Moments.lean) | 3DDC63BE9937E6022B77B80238CC1666A3B122161CC0CFA02081E0E9A2DF0871 |
| [Eta2.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Helfgott/Eta2.lean) | A2FF833091A7D65D1E02BD24284CCE8C9FCBF6032BD52715CB4DCB055BD850FE |
| [SumMuPhi.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/SumMuPhi.lean) | 7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4 |
