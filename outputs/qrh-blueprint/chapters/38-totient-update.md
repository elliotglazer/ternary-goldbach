# Totient replacement status and remaining scope

Research update, 2026-11-10. These are mathematical derivations and source reviews, not compiled Lean theorems. The prior Fermi-estimate exchange did not change proof state; this continuation integrates newly reviewed research and checks the next error budget.

## Three components reviewed

The finite exact theorem needed by this route is

    1<=q<=2^1000, r>=3, q<=r
      ==> q/phi(q)<exp(gamma) loglog(r)+2.50637/loglog(r).

The independent integration review found that the existing `MertProd.inv_2000` supplies both the finite product estimate and theta(2000)>1000. It therefore already supplies the primorial cutoff needed by the elementary exchange proof. A new 303-prime certificate is unnecessary. The comparison variable r has no upper cutoff. The reviewed source path is Platt-free; its transitive kernel axioms and the new theorem still require later Lean validation.

The elementary inequality

    (q/phi(q))^4 <= (27/2)*rad(q) <= 16q

gives q/phi(q)<=2q^(1/4). Together with the finite theorem it supplies exactly the weaker square-root estimate consumed inside `FirstChoiceTypeII`, at all scales. This preserves that consumer's constants.

The downstream `GBound` use can instead use a weaker totient estimate in the unbounded region, adding

    H(r)=132 log^2(2 max(r,2^1000))/(2 max(r,2^1000))^(1/4)

to the algebraic pointwise envelope. Independent review accepted its monotonicity, scaling through the full convolution, and complete layer correction below10^-60. The correction includes the terminal term, using the actual source witness floor((x/49)^(1/4)) in the asymptotic range. The old numerical cells retain their meaning because their algebraic function is unchanged; the new consuming proof must add the correction explicitly.

## The remaining internal calls

| Call site | Required bound | Status |
|---|---|---|
| FirstChoiceTypeII | 7.2539 sqrt(T/6e6) | Reviewed finite theorem plus fourth-root repair |
| GBound | Sharp Fr at the effective radius | Reviewed downstream envelope replacement, conditional on the pointwise theorem |
| SecondTypeIIa | 1.7882 loglog(q')+.9549 | Unbounded q' remains open |
| SecondTypeIIb | a1F0(log T) | Unbounded q' remains open |
| SecondBridge | 1.948 loglog(T)+1 | Unbounded q' remains open |
| LSQuot3.regionS | P/phi(P), P the product of primes <=R or dividing q | Separate quotient large-sieve obligation; not covered by the pointwise tail |

The second-choice reapproximation only gives q'<=T^2/349. The finite theorem covers all these calls when T<=2^500, and covers each individual q'<=2^1000 at arbitrary T. The remaining q'>2^1000 region is unbounded. The fourth-root estimate does not prove the logarithmic helper statements; their consumers need a new, weaker estimate with its own error budget.

A current research candidate is an additional normalized pointwise error of order12000(log T)^2*T^(-1/4), beginning only beyond T=2^500. Its source derivation and transport are under review. The following arithmetic shows that such an error has a viable layer budget if the necessary transport is proved. It does not establish that transport or the pointwise inequality.

## Separate quotient large-sieve use

An exhaustive source search for `div_totient_lt` finds a seventh call at `MinorArcs/LSQuot3.lean:121`, beyond the base-gap call and the five pointwise calls discussed above. This call is in `regionS`, not in the Type I/II pointwise theorem. Its argument is the squarefree product P of primes at most R together with the prime divisors of q. The finite restriction on q alone does not bound P.

The call proves X=P/phi(P)<=.86+.4*log(qR), using log(P)<=log(q)+1.039R and a separate small-R condition. The latter estimate also uses the conditional psi upper bound. Thus replacing the totient call alone would not remove every conditional input to regionS.

The consumer chain is `LSQuot3.regionS` to `LSQuot6.prop_12_2_4`, then `LargeSieveProof.cor_12_2_5`, then the integrated-arc bounds used by the final minor estimate. In the current case split, regionS is only used when q>=22000000000 and R<lamQ(q). The smaller-q branch uses the separate finite Phi2 reduction; the large-R branch uses regionL. The full quotient theorem allows q<=Q0 with unbounded Q0. Therefore the large-q branch cannot be dismissed from the all-scale proof.

This is outside the ten-interface Type I/II boundary, whose report explicitly excludes the integrated large-sieve theorem. The research map must include this additional branch. Neither the downstream H correction nor a successful second-choice pointwise repair would by itself close it.

## A separate budget for a second-choice envelope

For C>0, R>=2^500 and r>0, set

    K(r)=C log^2(max(r,R))/max(r,R)^(1/4), L=log R.

On r>=R this is decreasing and r*K(r) is increasing. Below R it is a constant. Suppose a future pointwise proof permits an addition of1.398*K(n) to the smoothed level envelope. This is a premise of the budget calculation, not a newly admitted premise of the Goldbach theorem.

The reviewed source inequalities give sig<=log x, sig/Dx<=3 and cL(150000)<15. For the same exact source layer weights, dropping negative terms bounds the added Mexpr by

    1.398 * [45*K(150000)
      +3*integral_(150000)^infinity K(t)/t dt
      +K(m)*log x].

The integral is at most C*R^(-1/4)*(L^3+4L^2+32L+128). In the finite-cell range log x<235. In the asymptotic range the source witness m=floor((x/49)^(1/4)) satisfies m>=(x/49)^(1/4)/2, hence log x<7+4log m. The function exp(-u/4)*u^2*(7+4u) decreases for u>=12. Thus the terminal term in both ranges is at most C*R^(-1/4)*L^2*(7+4L).

Consequently the complete addition is bounded by

    1.398*C*R^(-1/4)*(7L^3+64L^2+96L+384).

The coefficient64 differs from the earlier downstream calculation's61 because this K uses log(max(r,R)), while H uses log(2 max(r,R)). The normalization cannot be changed without adjusting the terminal estimate.

At C=12000, R=2^500 and L<350, exact rational arithmetic gives a value below10^-24. This is sufficient for the same final1.0376 bound, provided the new pointwise derivation and convolution justify this K and all other inputs are supplied. The script `work/qrh-campaign/totient_second_budget.py` checks only this arithmetic and the final scalar margin.

## Status

No global totient dependency removal is claimed yet. The second-choice source estimates, their exact domain, and the conversion to a level envelope remain essential obligations. The major residuals, low-denominator base gap, prime/Mobius estimates, provider audit, and Lean implementation also remain incomplete.

    DRAFT_ANCHORS: 0
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0
    SEALED_THIS_TURN: 0
