# The next spectral reduction: remove outputs, not another constant

2026-11-11. Research priorities and one finite algebraic reduction. No evaluations, builds, new premises, or changes to frozen work. This memo does not select a replacement strategy.

**Recommendation:** the highest-value mathematical target is a direct bound for the actual weighted major-arc residual energies, coupled to the pointwise base-gap bound. A conductor product alone does not remove the present bulk computation. First test whether the aggregate route can close those exact consumers without evaluating each character. If it cannot, retain the reviewed characterwise algorithm and improve its shared arithmetic implementation; do not launch another open-ended search for slightly smaller spectral cutoffs.

## 1. What is still expensive

The current original-finite-RH route has R132900, N0=989*10^24 and the original smoothing. Its large branch still has 99,513,098,256,768 residue-height inputs. With P20, literal residue Horner evaluation has 1,890,748,866,878,592 real-times-complex stages. Fixed-order primitive transforms add 1,849,018,578,634,950 general complex products and 3,808,420,069,398,260 complex additions.

The reviewed composition is about 1.12*10^16 real products with four-product complex multiplication, or 9.33*10^15 with the cached three-product decomposition. Both exclude seed production, elementary heads/phases, rounding proofs, cheap gates, signs/completeness and all finite-range work. Scaled jets reduce the sufficient precision of a seed interface; they do not erase these contractions or transforms. The three-product implementation also needs its own correct rounding/width refinement.

These are exact costs of specified circuits. They are not lower bounds for finite RH, ternary Goldbach, or all possible transform algorithms. Even the number of residue inputs is a lower bound only for a design that explicitly generates all those entries. The same caution applies to the 66,172,730,256,514 nominal primitive output slots: a checker which consumes each separately must process them, but the mathematical theorem does not require that representation.

## 2. A precise aggregate reduction that does hold

The useful aggregation is an energy identity, not the statement that there are fewer conductor names than character names. Here is a finite identity that avoids character outputs once the correct residue vector is available.

Fix q>=1, G=(Z/qZ)^*, v=phi(q), and u:G->C. Use the positive unnormalized character transform uhat(chi)=sum_g u(g)chi(g). For d|q let K_d be the kernel of reduction to units modulo d, and let A_d be convolution with 1_Kd/|K_d|. It is the orthogonal projection onto characters whose conductor divides d. For c|q put P_c=sum_(d|c) mu(c/d) A_d. Its character multiplier is exactly the indicator of conductor c.

Define w(q,c)=c if q/c is squarefree and coprime to c, and zero otherwise. The source Gauss identity gives this exact weight, with no assumption of primitivity at level q. Character orthogonality now proves

    E_q(u) := sum_chi [w(q,cond chi)/v] |uhat(chi)|^2
            = sum_(c|q) w(q,c) <u,P_c u>
            = sum_(c|q) w(q,c) sum_(d|c) mu(c/d)/|K_d|
                * sum_(r in (Z/dZ)^*) |sum_(g -> r) u(g)|^2.       (1)

The inner product is the unnormalized sum over G, conjugate-linear in its first argument. To check the last equality, A_d u is the average on each K_d coset. Summing conjugate(u) times that average gives the squared coset sum divided by |K_d|. The first equality follows from Parseval's factor v, cancelling the displayed 1/v in the energy. This proof retains all normalizations.

If the principal character is to be omitted, subtract its c=1 term, or use a residue vector whose principal component was explicitly removed. For different supported-conductor weights, replace w by those weights; do not assume an inducing character has Gauss norm squared c outside the stated support. The inverse-character convention in the source is harmless only after the explicit inverse permutation, which preserves the conductor and Gauss weight.

Given u, all block sums in (1) can be formed using at most v*tau(q) bucket additions, followed by sum_(d|q) phi(d) norm squares and finite divisor-weight combination. This avoids outputting phi(q) character transforms. It is an algebraic operation bound, not a bit-cost comparison: the Mobius combination has signed terms and requires controlled cancellation. Existing source `MinorArcs/Bombieri.lean:27,78,135,152` already supplies the orthogonality, twist and Gauss-weight ingredients. The new regrouping must not be counted as a new bound on the energies themselves.

For plus and star residual vectors u,z, the mixed quantity at one q is E_q(u)E_q(z). It includes **all pairs** of characters. A convolution producing sum_chi |uhat(chi) zhat(chi)|^2 keeps only the diagonal and is not this mixed consumer. One can instead multiply the two correctly bounded scalar energies; a proof of separate integrated L2 bounds does not bound the integral of their product. A uniform bound on one factor, or a genuine joint fourth-moment estimate, remains necessary.

## 3. The missing step, and a bounded research gate

For the Goldbach application u must be the residue vector of the **actual normalized smoothed prime residual**, with its principal main term and coprime corrections. It is not the Hurwitz residue table at a spectral height. The latter transforms to L(1/2+it,chi), whereas the required residual involves the smoothed prime sum or its weighted explicit formula. Replacing one vector by the other would be false.

Thus (1) yields a useful next target but no present saving: derive a uniform upper certificate for its actual block sums or quadratic forms without summing primes to x and without reconstructing all individual zero lists. A possible analytic route is a direct progression-correlation/large-sieve argument specialized to these smoothings. A possible certificate route is a shared contour representation using the actual logarithmic derivatives, with a cheaply certified common inverse. Both need a quantitative theorem, not just their formal identities.

The first bounded deliverable should be an all-consumer lemma package at R132900, x>=4.9e26, y=x/49:

1. Actual plus/star weighted residual energies with the source Gauss weights, principal residual and removal terms retained.
2. Their mixed integral, keeping both character indices and the same modulus/twist.
3. Upper and lower J/I bounds for the reduced arcs.
4. A pointwise etaStar bound on the base gap. An integrated energy estimate cannot certify every point there. Even a Cauchy bound needs a uniform energy input; its dimension and normalization must be charged.
5. The resulting major-minus-minor-minus-nonprime coefficient strictly positive with the current original energy `sig`, all nine scale cells and the asymptotic range.

The currently demonstrated joint reserve is only >.0013565. Do not import the older QRH route's .65 energy or its Aplus/Astar targets as if they were established for this branch. Principal estimates and higher minor-level inputs remain unless separately replaced. A proof only of item 1 is not evidence that the finite family can be removed. If a coarse proposed bound already exceeds the full remaining allowance at the smallest x, record that failed sufficient inequality and stop that version before developing a large library around it.

## 4. Alternatives, ranked by what they can actually remove

| Direction | Valid benefit | Missing requirement or reason not to prioritize it |
|---|---|---|
| Direct weighted residual bounds as above | Could remove the nonprincipal character-output and zero-location layer itself | New uniform numerical bounds, especially mixed energy and pointwise base gap; highest mathematical uncertainty |
| Shared height/conductor arithmetic with bulk exact convolution certificates | Can amortize repeated work and proof construction while retaining the existing theorem | Must price deterministic identities, operand growth, rounding and generation as well as checking; not permission to replace exact verification by random spot checks |
| Global conductor inverse/product certificate | Can remove individual polygons and winding records | No cheap inverse producer, same difficult factors control conditioning; does not yet remove Hurwitz inputs or transforms |
| Less dense nominal height grid with adaptive repairs | May avoid oversampling ordinary cases | New interpolation/count certificate and charged repairs; no uniform zero-separation or margin bound is known here |
| Further cutoff or precision constant tuning | Small proven reductions remain possible | Unlikely to remove the dominant layer; current cutoff margin and all-consumer constraints already bind |

The prior product report proves a sound global inverse test: for primitive projector e and actual coefficient vector a(s), a single b(s) holomorphic across the whole rectangle with ||e-e*a*b||_1<1 on its boundary implies all primitive factors are nonzero inside. Its stronger positive convolution-moment test is also sound. But obtaining b by transforming all factors and reciprocating them preserves the expensive step. Moreover ||b||_1>=1/min_chi|L(s,chi)|, so an almost-zero factor is not hidden by aggregation.

There is also a route mismatch: that report's [.555,2] rectangle proves a weaker finite strip, whereas the current original analysis consumes exact finite RH. A compact zero-free rectangle starting to the right of .5 leaves a sliver. Starting at .5 meets the desired critical-line zeros. An aggregate total-count argument still needs sufficient evidence locating the counted zeros on the line, with multiplicities and closed endpoints. This is a new adapter, not an automatic consequence of the old product certificate.

The old weighted-excess theorem K<=6 was genuinely weaker information for its QRH consumers, but K<=6 remains unproved, its tested explicit density majorants failed, and that theorem is not an original-RH replacement at R132900. No global saving may be credited to it now. The failed majorants are not an impossibility theorem for better density estimates.

## 5. Two tempting amortizations that do not yet help

A fixed alpha mesh does permit precomputation of the composite map from all mesh jets to all character outputs. Dense precomputation is usually the wrong comparison. For example at c=100003 and the lowest band D=512, fine P20 jets have 20*(2D+1)=20500 columns. A literal dense map to 100001 primitive rows has 2,050,020,500 complex products per height. The existing circuit at this conductor uses 4,182,168 complex products plus 19*100002=1,900,038 real-times-complex contractions. Thus the naive dense composite map is worse even before setup. A useful replacement needs proved sparsity, low-rank compression or a fast structured matrix action with error bounds; the word “precompute” alone supplies none.

Likewise, putting many integer operations into one giant packed multiplication can reduce the number of syntactic checks while greatly increasing operand lengths. A proof of exact coefficient extraction and carry bounds is necessary, followed by comparison in the chosen arithmetic model. It is not a universal saving and does not make numerical discovery free. The supported direction is to compare complete bulk-convolution certificates with the existing gate DAG at equal precision and trust, not to claim a unit-price multiplication count.

## 6. Decision and evidence

Spend the next mathematical investigation on the direct aggregate consumer gate in section 3. It has a genuine chance to remove an entire output layer, and its failure can be exposed by an explicit insufficient bound. In parallel operational planning, keep the current fixed-order, scaled-seed characterwise route as the conservative baseline and preserve sharing in its checker. Do not price an aggregate inverse, a thinner grid or an unproved density bound as an achieved reduction.

Read source pins: current blueprint `8FEAC3536CCD7F521CD7BBD3B4986E1E7B9DAF289CA25273F466D5124A21DBDB`; scope addendum `3A9EDE78304E2196ED71437683B74C061637EABDF4047810DB4F5D29D024AA1A`; current operation budget `D0D428B355F2DBD025DBE2BD6C4D1DC846B63892A81506445EC242571A8C1C7F`; scaled-seed paper `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`; product feasibility `B701615E4D93727BF7A2C290C41F94EDEB40C0E9FE2BCFAB4A725CB6AC4B8973` and its review `5A2DD26E445829214DEEA92A6EB0C1527533EC6F1064FCF0F3CA9AE5C0C9929C`; density comparison `37505FDC4F83F99727FE636654E4803E3EB1EBF7C1B35FBF4E8C627097A72C90`.

`work/ternary-goldbach/TernaryGoldbach/MinorArcs/Bombieri.lean` has SHA256 `F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79`. Its actual finite character identities were read for (1). Original-consumer domains and constants are the reviewed modest-cutoff V2 and exact-source-mass packets; older QRH frontier files were used only to identify nontransferable proposed alternatives. No assertion here validates the global QRH provider or claims a runtime bound.
