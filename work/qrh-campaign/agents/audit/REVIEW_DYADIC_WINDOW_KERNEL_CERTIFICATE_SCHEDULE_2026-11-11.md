# Review of the dyadic window-kernel certificate schedule

2026-11-11. PASS for the conditional mathematical schedule, cache identities and symbolic cost model, with no correction requested. This does not establish numerical kernel certificates, query counts, successful signs, formal lemmas or runtime savings. No offset/digit list, kernel/function values, declarations, builds or proofs were generated.

## Frozen packet and review method

Author: `major-constants/DYADIC_WINDOW_KERNEL_CERTIFICATE_SCHEDULE_2026-11-11.md`, SHA256 `5ACC1DA3715D9CCCB4B37643A4AE9D5CC98CC040884AC0164EA43ED9CBA006B8`.

Static script: `5EA3C9F8EDD742823D4B011DB8ECBFB34BA85551331C3E15A7E5FAFAEE8EA579`. Receipt: `9DB5A77E99EF4F1BEFFECA6AA9CD0896605A603D1A8675467680B7B1970EFF8B`.

I read all three artifacts and independently reconstructed the set identities, recurrence, error propagation and counts. A read-only check matched those three hashes and all four dependency pins. Separate rational checks verified A, its stated argument ranges, the alternating-series tail and the error reserve. The author script was read but not imported or executed. These checks assigned no dyadic offsets or kernel values.

The dependencies are the shorter-window author/review `32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E` / `61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730` and the stability author/review `6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA` / `3D8831ABB2BBD69A1AD82389B8A2082DBCE18D5E6C47E73230F6808F0EBFF589`. Their actual-Y normalization, sample domain, analytic tails, sample error and completeness obligations are unchanged.

## Exact keys, symmetry and nesting

For h=159/500, Delta=5/64, the exact Gaussian parameter is `A=Delta^2/(2h^2)=390625/12943872`. The kernel is the real even function `K(z)=exp(-Az^2)sinc(pi z)`. Evenness permits an absolute-distance key, not replacing K by its absolute value. Its sinc sign must remain.

The complementary-offset identity maps d to1-d. Thus the original stencil [-41,41] becomes [-40,42]. The author correctly includes the boundary distance rather than reversing an unchanged 83-slot array. At theta=0, K(0)=1 and all other integer stencil coefficients vanish exactly. The sample can be returned with its actual radius and any output conversion. This uses the removable sinc and integer-sine identities, not a missing numerical enclosure. At theta=1/2 there are42 distinct distances for83 occurrences.

For a requested nonzero offset set Theta, let F contain each offset and its complement. A distance with fractional part f is l+f. The d<=0 side requires l=0,...,41 when f belongs to Theta; the d>=1 side requires l=0,...,40 for its complementary fractional part. These positive distances have unique integer/fractional decomposition. Consequently

    D=41|F|+|Theta|.

The negative signed kernels are exactly the odd integer parts, giving `20|F|+|Theta|`. This proves the partial-set formula without presuming that every offset is queried.

For Q=2^R, the complete set is `{a/Q:1<=a<42Q, Q does not divide a}`. Its cardinality is42(Q-1), and it includes all earlier dyadic levels after canonical fraction reduction. New odd-numerator distance keys at level r number42*2^(r-1). The normalized-sinc base count is one at level1 and2^(r-2) new bases at each later level. The R=0 branch correctly has no noninteger kernels. These are symbolic set counts, not an enumerated certificate population.

The mathematical key must bind the exact distance and kernel definition, h,Delta and the numerical certificate contract. Sharing across characters and integer translates is valid because the kernel does not depend on those labels. Their sample vectors and output source bindings do depend on the labels. Radius/representation requirements must be checked before reusing a certificate at a different requested precision; finer nominal precision alone cannot authenticate an old center.

## Factorization and error radius

For u=l+f, t=min(f,1-f), the exact identity is

    K(u)=(-1)^l*(t/u)*sinc(pi*t)*exp(-Au^2).

Here 0<t<=1/2 and t/u<=1. Thus a shared normalized-sinc seed has uniform absolute sensitivity, even as the dyadic denominator grows. This avoids the small-distance amplification of an unnormalized shared sine followed by division by u. For f=j/q, the ratio is exactly `min(j,q-j)/(l*q+j)`; its positive denominator and key-dependent widths remain explicit.

The proposed sinc series is valid on |x|<=2. Consecutive term magnitudes decrease because their first ratio is at most4/6 and later ratios are smaller. The remainder after n=0,...,15 is at most2^32/33!, strictly below2^-90. The author does not mistake that analytic tail for the full seed radius: certified pi/argument error, finite polynomial arithmetic and final conversion remain inside the separately required sinc producer.

The Gaussian identity uses `T_l=a_f*b_f^l` and `G(l+f)=H_l*T_l`, with `a_f=exp(-Af^2)`, `b_f=exp(-2Af)` and `H_l=exp(-Al^2)`. Expanding the square proves it. A<1/32,2A<1/16 and41^2 A<53 are valid rational domains. H_0=1 and G(f)=a_f require no multiplication at l=0.

Projecting real centers to [0,1] does not increase their error from a true factor in [0,1]. With seed and gate errors epsilon=2^-80, the recurrence therefore has error at most `(1+2l)epsilon`: one initial seed error and one b-seed plus one round error per step. This bound allows fully correlated reuse of the same b seed. The H multiplication contributes another seed and round error, giving `(3+2l)epsilon<=85epsilon`.

The subsequent S*G multiplication contributes the S seed error and one round. Multiplication by the exact ratio t/u contributes one final round. Hence the total is at most88epsilon, strictly below2^-72. The sign application preserves the radius. This count would need revision if the rational ratio were separately rounded; the frozen schedule expressly keeps it exact.

The final rational multiply-round still needs the actual numerator product, quotient-times-denominator, residual, tie inequalities and deterministic rounding convention. Its denominator is below42q, but its bit width grows with the level. A named rational stage is not a free division or constant-width arithmetic primitive.

## Counts and omitted-cost checks

For each f, the two Gaussian products at positive l total2M_f. Summing gives2(D-|F|). There is then one S*G product and one exact rational stage per distance. Therefore the independently reconstructed counts are:

|Category|Count|
|---|---:|
|General products and their output rounds|3D-2 n_f each|
|Exact rational multiply-round stages|D|
|Post-gate projections|4D-2 n_f|
|Seed projections|41+2 n_f+n_t for a nonempty cold cache|
|Negative sign assignments|20 n_f+n_theta|
|Retained signed centers|D|

Here n_f, n_theta and n_t are the cardinalities of F, Theta and T, respectively; n_t counts complementary offset classes. In the complete level-Q case these become124(Q-1) general products,42(Q-1) rational stages and166(Q-1) post-gate projections. The kernel construction does not remove the83 products and82 additions in an actual direct interpolation query. Source guards, sample production and finite-sum rounding are separate.

The exponential count41+2|F| is correctly labeled a conservative seed-role count. It is not the number of distinct arguments. I independently checked the optional dense collision argument: b_(1/2)=H_1 contributes one collision, while canonical f=j/2^r has f^2/2 at level2r+1. Thus there are `2^floor((R-1)/2)-1` additional injective a/b collisions; their arguments lie below A and cannot overlap the H_1 collision. The resulting distinct-argument formula is valid, but its lookup, equality and certificate binding must be priced before any savings are credited. The frozen main ledger does not claim that refinement.

Inclusive center1 needs the stated81 unsigned numerator bits on grid80; its square can be2^160 and needs161 unsigned bits. Signed centers, rational-stage products and residuals have their separate capacities. Streaming a running T value does not eliminate retained proof dependencies or make the complete cache constant-memory.

The price interface includes elementary seeds and their internal proof/arithmetic, rounds, projections, signs, rational witness work, canonical keys, theorem instantiations, exact source imports/binding and cache lifetimes. It does not subtract an unrelated upper estimate to claim a winner. Sparse demand can make the cold recurrence unattractive, as the half-offset example explicitly shows. Repeated mathematical keys save work only when the exact checked objects and sufficient radii are retained or their reconstruction is paid.

The packet therefore supplies a coherent reusable kernel schedule meeting the existing conditional kernel-radius premise. It does not supply actual numerical leaves, choose a query workload or precision escalation policy, prove signs, alter current source/guard inventories, or close Turing completeness. No whole-pipeline saving is established.
