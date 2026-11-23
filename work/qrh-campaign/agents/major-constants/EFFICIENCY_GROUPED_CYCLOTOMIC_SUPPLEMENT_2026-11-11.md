# Grouped order roots with sum-only cyclotomic checks

2026-11-11. New supplement; the frozen grouped-root report is unchanged. This is paper mathematics and exact integer exponent/schedule arithmetic only. No modular candidate values, primality search, Lean/MM0 build or evaluator was run. The root sum-only packet has now received the independent review cited below. This supplement and its new cost projections require their own review.

**Result:** mixed cyclotomic/unit groups improve the explicit successful-certificate schedules. For m160, four roots plus one inverse now use40 squares and37 other products, versus43 and49 in the frozen grouped schedule. The new circuit has14 additions/subtractions versus10. There is also a two-root, zero-inverse format using159 products and two wide coordinates; the old one-root/one-inverse format uses184 products and the same two coordinates. These are new options for a cost model, not a measured speedup or a proof of globally optimal circuits.

## 1. A mixed group needs only one source of its Fermat identity

Let n>1 be odd. Partition the full, certified prime powers of F into disjoint nonempty groups. For a group with product d supply a root X and compute Y_q=X^(d/q) modulo n for every prime q|d. A nontrivial 2-primary group uses Y_2=−1. For each odd q select exactly one of:

* **Unit leaf:** Y_q−1 is a unit modulo n, certified as part of the one global aggregate inverse.
* **Cyclotomic leaf:** S_q(Y_q)=0 modulo n and q does not divide n, where S_q(Y)=1+Y+...+Y^(q−1).

If the group is odd and has no cyclotomic leaf, separately check X^d=1. Otherwise no separate Fermat power is required: the even leaf gives X^d=Y_2²=1, or the identity (Y_q−1)S_q(Y_q)=Y_q^q−1 gives X^d=1 from a cyclotomic leaf. This implication is within the same group. A leaf in another group supplies no information about this group's X.

For every prime r|n, X^d=1 makes X nonzero modulo r and its order t divide d. A unit leaf implies Y_q!=1 modulo r. At a cyclotomic leaf, Y_q=1 would give q=0 modulo r, hence r=q, contrary to q∤n. Thus in either case t∤d/q. Since t|d, this says v_q(t)=v_q(d), including the complete prime-power exponent rather than just one factor q. All leaves together give order exactly d modulo r. For an even group, odd r makes −1!=1 and gives the same full 2-adic conclusion.

A singleton group d=2 needs no root: oddness of n already forces2|(r−1) for every r|n. This free case is not applicable to d=2^e with e>1 or to a mixed even group. The partition optimizer includes that exact exception.

Taking all groups, F divides r−1. If n<(F+1)^2 then n is prime: a composite n has a prime factor r<=sqrt(n)<F+1, contradicting r>=F+1. The generic overlapping-group form uses lcm(d_j), never the product of repeated prime powers; the computed schedules use disjoint atomic prime-power blocks only.

The earlier unit-only criterion did not need F|(n−1). Cyclotomic leaves now require their stated q-exclusions. There are two honest interfaces: check those nondivisibilities, or retain the exact candidate encoding n=kF+1, which proves them. They are not erased because n will eventually be prime. For the fixed smooth-F ladder, the second interface already matches the position encoding. Its equality/range checks still cost work.

## 2. One inverse across all remaining unit leaves

Concatenate the unit-leaf values Z_i=Y_q−1 from every group. If there are u>0, supply V and check (product_i Z_i)*V=1 modulo n. This is equivalent to all u values being units. Forming the product uses u−1 products and its inverse check uses one: u products total, one inverse coordinate, and u residue subtractions. If u=0 omit all of these, including V.

This accounting is global. The script allocates one product per unit leaf for the additive cost recurrence; it does not secretly allocate one inverse to each group. The final concrete circuit multiplies the concatenated list once. For whole-product checking, replace n by the exact product M of the claimed bounded odd candidates and keep the factor/product bindings. Congruences descend to every candidate. Cyclotomic guards must hold modulo M; the checked n_i=k_iF+1 identities imply q∤M. The least-factor proof is applied to each individual n_i with its individual size bound, not to the huge product M.

Intended prime CRT production still needs distinct candidates or genuine lifts to repeated prime powers. Increasing accepted ladder positions provide distinctness. The acceptance test itself does not accept an incomplete squarefree-only CRT congruence in place of the congruence modulo M.

## 3. Concrete circuits searched

The sum-only circuit is the reviewed recurrence

    S_(2m)(Y)=(1+Y)S_m(Y²),
    S_(2m+1)(Y)=1+(Y+Y²)S_m(Y²),

with bases S1=1, S2=1+Y and S3=1+Y+Y². At each recursive non-base step it costs one square, one other product, and one or two additions. The square is reused in Y+Y². All circuit identities hold in any commutative ring. The script counts the exact recurrence, not a generic polynomial expansion.

For each group, the required leaf exponents remain d/q. The library includes the frozen grouped report's shared binary ladder and its saved best equal-weight complement tree for that prime subset. It compares binary versus repeated-prime prepower for t=d/rad(d). A tree leaf has exponent t*rad(d)/q=d/q. If a separate Fermat identity is needed, the library compares adding d to the shared binary ladder with raising one existing leaf to its q; it also permits that last operation after the complement tree. Otherwise it does neither.

The last ladder-plus-leaf variant modestly enlarges the old exponent library and is stated explicitly. The saved complement trees are not reoptimized for each new square/product price. Thus a reported optimum is only within this concrete library, not among all trees at every price, all addition chains or all modular circuits.

For each group all subsets of odd primes are considered as cyclotomic leaves. Its local record includes squares s, other products m, additions/subtractions a, root count and whether any unit leaf remains. These products include the additive allocation u explained above. The exact q-adic prepower is always charged, even when an exponent is greater than one.

## 4. Partition recurrence and scope of the projections

For every mask S of the eleven atomic prime powers, consider each nonempty A subset S containing S's least set bit. Combine an allowed group record for A with a record for S\A. Root counts add; the unit-presence flag combines by OR; all three operation counts add. The empty mask has zero cost and no inverse. At the final mask, the number of wide witness coordinates is

    C = roots + (1 if at least one unit leaf remains, otherwise 0).

The receipt computes three exact projections: minimize alpha*s+beta*m for (alpha,beta)=(1,1),(1,2),(2,1), at each exact root count and final unit flag. Ties minimize a, then s and m, then a deterministic encoding. These tie rules are compatible with addition of costs and the OR state. They do not price a as zero in a runtime model: they merely define the stated projection. A full vector Pareto implementation would retain every nondominated (s,m,a) at each such state. This receipt does not claim to compute that entire set.

The recurrence enumerates all partitions without group-order duplicates and all leaf-type subsets within this library. Every output retains the selected groups, cyclotomic masks, unit counts, exponents and methods. The independent exponent check reconstructs every leaf of the saved tree library using multiplication of integer exponents. No purported modular result is supplied by the schedule script.

## 5. Cost conclusions and limits

The following equal-square/product-price results retain a global inverse. Entries include its product check and all unit-product formation. The full atomic column instead uses only cyclotomic leaves and no inverse; free parity is used where applicable.

| m |1 root+inverse|2 roots+inverse|4 roots+inverse|6 roots+inverse|10 roots+inverse|Full atomic, no inverse|
|---:|---:|---:|---:|---:|---:|---:|
|160|184|124|77|66|55|55, 11 roots|
|162|185|125|78|68|56|56, 11 roots|
|165|180|120|78|66|57|57, 10 roots|
|168|185|126|78|65|56|56, 11 roots|
|175|180|124|78|66|57|57, 10 roots|
|180|185|125|80|68|56|56, 11 roots|

The full root-count/flag table and the two additional price projections are in the receipt. A fixed root count with an inverse is a different payload point from the same root count without an inverse. For m160 the least equal-weight totals among these generated schedules at each exact coordinate count1 through11 are respectively

    221,159,124,93,77,70,66,62,59,57,55.

Coordinate1 is an all-cyclotomic common root; it is not the old common-root-plus-inverse packet. The coordinate10 optimum uses ten cyclotomic roots and no inverse. At coordinate11, ten roots plus one inverse and eleven roots without an inverse both attain55, but differ in their square/product/addition vectors.

### A complete small witness for the four-root m160 improvement

Here F has prime-power blocks64,3,25,7,11,13,17,19,23,29,31. Use the four groups below. In each row the common binary ladder produces the listed leaf exponents; the table's products include that row's allocated unit-leaf bill, combined globally afterward.

| d | Leaf exponents d/q | Extra checks | Squares | Other products | Additions/subtractions |
|---:|---|---|---:|---:|---:|
|20800=64*25*13|10400,4160,1600|first leaf −1; other two unit leaves|13|8|2|
|627=3*11*19|209,57,33|S3 at209; two unit leaves|8|9|4|
|493=17*29|29,17|raise first leaf to17 for X^493=1; two unit leaves|8|7|2|
|4991=7*23*31|713,217,161|S7 at713; two unit leaves|11|13|6|
|Total|||40|37|14|

For example the627 ladder costs7 squares and7 products: its leaf popcounts are4,4,2. S3 adds one square and two additions. The4991 ladder costs9 squares and10 products; S7 adds two squares, one product and four additions. The493 ladder costs4 squares and4 products, then the leading-one exponent17 costs4 squares and one product. The20800 ladder has13 squares and six products. Eight global unit factors cost seven product-formation multiplications and one inverse check. This directly reproduces the total without trusting the optimizer.

Keeping these same four groups and replacing S3/S7 by unit leaves plus separate Fermat powers costs four more products and four fewer additions. Thus a definite part of the improvement is the sum-only/Fermat-sharing mechanism itself. The remaining difference from the old optimum also reflects a different partition and the explicitly enlarged extraction library; it is not all attributed to one identity.

### The square/product balance matters

For m160, the four-root-plus-inverse projection at equal prices gives (s,m,a)=(40,37,14). With products priced twice squares, the chosen schedule is (45,34,16); with squares priced twice products it is (39,38,16). None of these three vectors dominates all the others coordinatewise. They illustrate why the equal-weight table is not a complete Pareto theorem.

At eleven coordinates, the ten-root/one-inverse equal-weight option gives (34,21,48), while the eleven-root/no-inverse atomic option gives (33,22,52). One trades a square for a product and four additions; their producer inverses and root work differ too. At five coordinates, comparison to the old four-root schedule saves three squares and twelve products but adds four additions/subtractions. Under identical candidate-layout guards, a local arithmetic cost comparison is therefore 3*C_square+12*C_product against4*C_add, plus any differing proof overhead. No numerical prices are assigned here.

These tables are schedule counts only. A different number of roots, inverses, additions or guards changes both the producer and verifier. Even a simultaneous reduction in squares and products need not reduce end-to-end cost if it adds large witness coordinates or an expensive guard/normalization path.

At batch size b with all candidates below2^90, a coordinate has at most90b bits; C coordinates use at most90b*C bits before candidate indices, headers and proof witnesses. The root-plus-inverse count is therefore a meaningful payload axis, not a substitute for actual byte measurements. The old two-field common-root format and a new one-field all-cyclotomic common root must be compared by C, not just by the number of roots.

Every sum-circuit addition must be normalized modulo the actual modulus or represented with a proved temporary-size bound. Its witness proof cost can differ from a subtraction in a unit check. The q-exclusion proof, exact F factorization, candidate reconstruction, strict size bounds and whole-product construction remain outside the displayed modular-product totals.

Production may retain independent full q^e components and multiply them to form a selected group root. That does not make the coarsened group unit residues equal to their original component residues. If a mixed output retains unit leaves, its actual aggregate inverse must be produced or a specific transformation proved. If all leaves are cyclotomic, that inverse coordinate genuinely disappears. The existing CRT cost schedule then has fewer coordinates, but screening, component projection powers and failed trials still remain.

The pure Proth44-square/one-coordinate criterion is a different candidate family; none of the new smooth-F totals proves it is slower overall. The purpose here is an explicit additional set of acceptance circuits, not a claim about prime availability, generation throughput or a globally fastest Lean/MM0 strategy.

## Evidence status

Root packet `CYCLOTOMIC_SUM_ONLY_CERTIFICATES_2026-11-11.md` is bound by SHA1289E9B4DFBB20B3FC84BB85CD35A676227DDFBFC4A3266A6FAB4A6CC3C27927. Its independent review is `moebius/REVIEW_CYCLOTOMIC_SUM_ONLY_CERTIFICATES_2026-11-11.md`, SHAE47FE2FDD2651772B7448FA9E3C05460DE3C8939787FE653CE1F43F576D3D074. This does not review the new partition computation. The frozen prior grouped report and receipt remain unchanged and are pinned in the new JSON.

| New artifact | SHA256 |
|---|---|
| `grouped_cyclotomic_schedules_20261111.py` | `95BD950D8E5776106B69C8449B62185F75281636A56DF591B479F5321E1829A4` |
| `grouped_cyclotomic_schedules_20261111.json` | `FC21AE178DD49F9923244B3D2CA6547CB31797AE695F8D4F683C8A78519E7585` |

The script completed its finite integer checks, including every saved complement-tree exponent identity. It does not generate arithmetic certificates for any candidate modulus. Its source and receipt are separate reviewable evidence from the manual four-group circuit above.
