# Shared finite heights versus Platt's published verification domain

Domain comparison only,2026-11-11. No published computation is imported as a Lean proof or new axiom. No zeros were computed, no Lean build ran, and frozen campaign reports remain unchanged. A height outside the stated published guarantee does not refute the finite.555 assertion; it identifies data not covered by that guarantee and matters when considering certificate reuse.

## Primary-source statement and conventions

Platt's Theorem7.1 in the [2013 author preprint](https://arxiv.org/pdf/1305.3087), page14, covers primitive modulus c<=400000, with height

    Tpub(c)=max(100000000/c,200+75000000/c) if c is even,
    Tpub(c)=max(100000000/c,200+37500000/c) if c is odd.

The [accepted manuscript](https://research-information.bris.ac.uk/files/67056136/platt_grh3.0.pdf), Theorem9.1, has the same formula. Its indexed theorem text was retrieved; direct PDF retrieval returned403. The complete preprint theorem was read directly. The [institutional publication record](https://research-information.bris.ac.uk/en/publications/numerical-computations-concerning-the-grh/) identifies Mathematics of Computation85(302),3009–3027, DOI10.1090/mcom/3077. Its abstract says “even characters”, but the theorem explicitly branches on even or odd c: this is modulus parity, not the separate parity chi(-1). The paper's zero-count discussion uses both ordinate signs and multiplicity. For primitive characters modulus equals conductor. These source facts fix the comparison; no imprimitive modulus substitution is made.

The pinned repository Statement.lean:55 defines its external PlattGRH proposition using odd c<=300000 to1e8/c and even c<=400000 to the even formula above. On our active odd set c<=150000 the paper's extra odd branch never dominates, so paper and repository heights coincide there. The repository statement is not a proof of either domain's spectral truth.

## Actual campaign domain

For Qset150000, active primitive conductors are all odd c<=150000 and all multiples of4 up to300000. There are no primitive characters with2-adic valuation1. Every displayed active conductor has positive primitive-character count a(c); c1 is included for zeta.

The exact multiplicative count is a(1)=1, a(p)=p-2, a(p^k)=p^(k-2)(p-1)^2 for k>=2. Integer enumeration gives150000 conductors and5,543,640,188 primitive characters. All are within the paper's conductor ceiling; the only issue is height.

The original selected profile is

    Dc=1200000/qt(c), qt(c)=2c for odd c and c for even c,
    Hp(c)=ceil(200+max(1000,(704/7)Dc)),
    Hs(c)=ceil(max(1000,(704/343)Dc)).

Containment is tested as Hp(c)<=Tpub(c), with Tpub retained as an EXACT rational. Rounding Tpub upward would falsely enlarge the published guarantee. In particular,34 original-plus exceptions would disappear under that incorrect rounding.

## Exact answer for the original shared assertion

The original Hp profile is contained precisely at the odd conductors c<=83333. Its exceptions are exactly

    every active even conductor, and
    odd c in[83335,149999].

These sets have75000 and33333 members respectively. The script checks this exact set equality, not merely its count.

| Original plus profile | Conductors | Primitive characters |
|---|---:|---:|
|Height within published guarantee|41667|1140703839|
|Height beyond published guarantee|108333|4402936349|
|Total|150000|5543640188|

The parity argument explains the large exception set. At even c,

    Hp(c)>=200+(844800000/7)/c,

which exceeds both100000000/c and200+75000000/c, before any floor or ceiling loss. At odd c the slope is422400000/7 divided by c. In the sloping regime c<=60342, even the upper estimate201+(422400000/7)/c is below100000000/c. Once the floor1200 dominates, containment holds exactly when1200c<=100000000, namely odd c<=83333. This proves the classification independently of the enumeration.

Examples show the scale:

| c | Hp(c) | Published exact height |
|---|---:|---:|
|1|60343058|100000000|
|3|20114486|100000000/3|
|4|30171629|25000000|
|83333|1200|100000000/83333|
|83335|1200|100000000/83335|
|100000|1407|1000|
|149999|1200|100000000/149999|
|300000|1200|450|

The largest absolute excess is5,171,629 at c4. The largest height ratio is8/3 at c300000. These are arithmetic properties of the requested domain, not observed failures of GRH or.555.

The original star profile separately has75000 contained and75000 uncontained conductors, representing1,847,865,075 and3,695,775,113 primitive characters. Its exceptions are exactly active c>100000; c100000 is an equality case. The shared plus certificate is already taller than the star certificate, so these are not additional disjoint character workloads.

## Separately proposed reduced profile

For context only, the reviewed reduced proposal uses

    Hp_red=ceil(200+max(300,(484/7)Dc)),
    Hs_red=ceil(max(250,(484/343)Dc)).

It does not eliminate all published-domain exceptions:

| Reduced profile | Within: conductors | Beyond: conductors | Beyond: primitive characters |
|---|---:|---:|---:|
|Plus|96233|53767|1699761198|
|Star|150000|0|0|

All reduced-plus exceptions are even conductors. The first is84748; ceil effects create a non-contiguous transition near the unrounded crossing, so it would be incorrect to replace the exact exception list by one rounded threshold. The maximum reduced-plus ratio is10/9 at c300000. The maximum absolute excess is2021735/31239, approximately64.7183, at c124956. All reduced-star heights are strictly inside the reported domain.

The script stores exact complete lists for every profile in its sets JSON. Only the original Hp profile is the subject of the primary containment answer. The reduced profile and its larger tail allowances belong to the separate cutoff note; this comparison does not select or alter an analytic profile.

## Files and reproducibility

Run `python work/qrh-campaign/agents/major-constants/platt_domain_comparison_20261111.py`.

* platt_domain_comparison_20261111.json contains counts, exact rational extrema, sample heights and directed bounds on the primitive-character-weighted top-up height sum.
* platt_domain_comparison_20261111_original_exceptions.csv lists every original Hp exception, its primitive-character count, requested height, exact rational published height and exact excess.
* platt_domain_comparison_20261111_sets.json stores the full exception sets for all four profiles.

All containment and count operations use integers or Fraction arithmetic. The top-up-height aggregate is enclosed by summing downward/upward rational roundings at denominator1e6; it is a workload proxy, not a runtime forecast. The largest individual rational deficits and the CSV are exact.

## Interpretation for feasibility

Published finite GRH would imply finite.555 inside its stated domain if supplied as an actual proved theorem with the needed function/multiplicity correspondence. The present task supplies no such theorem or replayable certificate. Outside that domain, the paper's stated guarantee alone does not establish even.555; the actual computation may have checked auxiliary heights, but its Turing windows cannot be silently treated as a stronger exported guarantee.

Thus the original shared finite assertion is not wholly a weaker-real-part restatement within the existing published height domain. It asks for taller rectangles on108333 active conductors. That is a certificate-reuse limitation, not evidence against the assertion's mathematical truth. Full proof work still requires an independently checked finite spectral computation or another theorem covering every requested rectangle. Neither the exception counts nor conductor-product aggregation establishes computation time, proof volume or a faster route than Platt's historical verification.
