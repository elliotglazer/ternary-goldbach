# Intrinsic character-transform error from the input mean

2026-11-11. Conditional paper theorem, submitted for independent review. This note proves a mean-input replacement for the older conservative mixed-radix error constants. It does not assume that a sup-norm theorem already has this stronger conclusion. The proof treats each leaf, ordered CT node, and outer product-group axis. It includes zero padding, cached-kernel uncertainty, absolute gate errors, and their cross terms.

The result permits an intrinsic error bound proportional to `mean_a |x_a|+1`. Under the separately reviewed full-P20 source and actual head/representation radius contracts, this augmented mean is below186 uniformly in the present large-conductor domain. Runtime capacities remain based on a separately proved pointwise bound, such as692. No selector, precision distribution, width fold, cost ledger or sign success is adopted. No input, coefficient, root, function, transform, prime or zero value was evaluated. There was no conductor, residue or gate enumeration, build, declaration, proof emission or frozen-file change.

## 1. Exact circuit and proposed theorem

Use the positive unnormalized cyclic transform and its ordered CT implementation from [1]. The outer unit-group axes retain their actual order and multiplicity. The negative radix transform in Bluestein obeys the same argument. Let

    M(x) = (1/n) sum_(j=0)^(n-1) |x_j|,   V(x)=M(x)+1.

Here x consists of exact stored complex centers. It is not the unknown analytic input. Every approximate unit root or chirp has complex error at most u. Each rounded complex addition or multiplication has absolute complex error at most u from its operation on the stored operands. Cheap exact roots, signs, permutations and padding may be exact; overcharging them is safe. Coefficient uncertainty and arithmetic error are different terms. No independence or cancellation of errors is used.

For each full selected node, the new assertion is

    max_k |Dhat_n(x)_k-D_n(x)_k|/n <= C_n*u*V(x),       (M)
    provided 0<u<=1/D_n^safe.

The pair C,D below is the LEGACY conservative pair from [2]. This paper re-proves its validity for (M). It does not automatically strengthen later tight-leaf, tight-tensor or conductor-local error constants. Those need their own mean-input proofs before composition. Requested outputs inherit (M) only when their actual pruned circuit is the dependency-closed restriction of this full circuit. The mean always uses all n inputs, not the number of primitive or retained outputs.

Unknown input errors remain separately transported by the exact operator. For radii e_j, an unnormalized output changes by at most sum e_j. That term is not multiplied by C. The numerical +1 in V pays absolute rounding; it is not an analytic error allowance.

## 2. Radix two and direct leaves

For a fixed output of a standard length2^k butterfly tree, each butterfly combines two disjoint equal-size input supports. Bit-reversal and exact permutations only change their labels. This support property is needed; a global mean is not a bound on every subblock mean.

Suppose each half has m inputs, means M_L,M_R, and normalized error coefficient c. Put M=(M_L+M_R)/2 and V=M+1. The ideal right output has norm at most m*M_R. An approximate right twiddle, one product round and one output addition round give

    error/(2m) <= c*u*V + u*M_R/2
                       + c*u^2*(M_R+1)/2 + u/m
                 <= u*V * [(1+u)c+1+1/m].            (1)

The left and right child errors were added with their own means before averaging. Both butterfly signs satisfy (1). At level j, m=2^(j-1), so a sufficient recurrence is

    c_0=0,   c_j=(1+u)c_(j-1)+1+2^(1-j).

If 2ku<=1, finite binomial expansion gives `(1+u)^k<=1/(1-ku)<=2`. The sum of the inhomogeneous coefficients is at most k+2. Consequently c_k<=2k+4. Thus the old radix pair

    C_rad=2k+4,   D_rad=max(1,2k)

proves (M). Length1 is exact, with C=0,D=1. This proof allows all input mass to lie in one half; uniform distribution was not assumed.

For a direct leaf r in {3,5,7,11}, the root-error contribution to one output is at most `u*sum_j |x_j|`. There are at most r-1 product rounds and r-1 sum rounds. Dividing by r gives `u*M+2u<=2u*(M+1)`. The zero row and exact roots only improve this estimate. The old direct pair C=2,D=1 therefore proves (M).

## 3. Ordered CT composition

For n=rm the actual indexing in [1] is j=a+rb and output k=v+mu. It first applies r length-m transforms, then the cross twiddle at (a,v), then m length-r transforms. The identity

    jk/n = bv/m + au/r + av/n + bu

fixes both the order and signs. Let M_a be the input mean of row a. Then `(sum_a M_a)/r=M`. At a fixed first frequency v the ideal first-child output is at most m*M_a and its error is at most `m*C_m*u*(M_a+1)`.

After the cross twiddle and its product round, the error is at most

    m*u*d*(M_a+1),   d=C_m*(1+u)+1.                 (2)

The unit-root error contributes u*m*M_a and the product round contributes u; m>=1 absorbs the latter. For the actual stored length-r input yhat to the second child, averaging (2) gives

    M(yhat)+1 <= m*(M+1)*(1+u*d).                  (3)

The exact second DFT propagates the first-stage error by its sum, which after division by rm is at most `u*d*(M+1)`. Applying the second child's mean theorem to yhat gives another `C_r*u*(M+1)*(1+u*d)`. Their coefficient sum is

    d+C_r*(1+u*d)
      = C_m+C_r+1 + u*[C_m+C_r*d].                (4)

Since u<=1 gives d<=2C_m+1, the old ordered recurrence is sufficient:

    C_CT=C_m+C_r+2,
    D_CT=max(D_m,D_r,1,C_m+C_r*(2C_m+1)).          (5)

The last guard pays the complete cross term in (4). The first child's row means need not be equal. Applying a single global mean to each first child would not prove (3); retaining M_a is what makes the argument valid.

## 4. Bluestein with padding and the normalized cache

For n>=2 set

    m=2n-1, P=2^k=nextPowerOfTwo(m), R=2k+4,
    A=1+3R, Q=3nPA+1,
    D_old=max(1,2k,PA,Q),
    C_old=6PA+2R*(2n+1)+8.

Then 2n<=P<4n. Use the original forward-data and kernel FFTs and the rounded normalized cache in [3]. The old final-divide variant is also covered below. Let M be the mean of the n original stored inputs and V=M+1.

The exact prechirped input has sum of norms nM. The n prechirp errors have total at most nuV. The other P-n entries are exact zeros. Thus the mean of the stored padded input is at most

    (n/P)*[(1+u)M+u].

Apply the newly proved radix mean theorem and separately transport the prechirp error. The forward-data transform error is bounded by

    e_F <= PRu*{(n/P)*[(1+u)M+u]+1}+nuV
         <= P*(1+2R)*uV <= PAuV.                  (6)

The exact forward-data output has norm at most nM. Padding does not make the radix absolute gate errors disappear; the +1 and factor P in (6) remain.

The kernel input has m unit entries and exact zeros elsewhere. Its input-error sum is at most mu, and its stored mean is at most `(m/P)*(1+u)`. The same proof yields

    e_K <= PRu*{(m/P)*(1+u)+1}+mu <= PAu.          (7)

Its exact transformed coefficient K has norm at most m. This is not an uncertain unit root. Kernel FFT construction or an imported enclosure proving (7) remains mandatory.

For the rounded normalized cache `Ktilde=Round_u(Khat/P)`, its error from K/P is at most `(A+1)u`. The old guard gives `P(A+1)<Q`, hence `(A+1)u<1/P` and `|Ktilde|<2n/P<=1`. A rounded point product Zhat approximating F*K/P has error

    e_Z <= nM*(A+1)u +(m/P)e_F +e_F*(A+1)u +u
         <= q*uV,   q=3nA+n+2.                    (8)

For the cross term in (8), PAu<=1 gives `e_F*(A+1)u<=V*(A+1)u`. Also q<Q, so qu<=1. The stored point-product mean therefore satisfies

    M(Zhat)+1 <= Z_s*V,   Z_s=nm/P+2.            (9)

This uses a valid pointwise majorant at the point-product stage; no claim that those frequency values have a smaller observed mean is needed. The inverse is UNNORMALIZED. Applying the length-P radix mean theorem and exact transport of the point errors gives

    e_I <= P*[q+R*Z_s]*uV.                       (10)

The selected exact convolution output has norm at most nM. The final chirp and product round therefore give

    e_out <= (1+u)e_I+unM+u.

Using u<1/2, the normalized coefficient is at most

    (3/2)*[Pq+R*(nm+2P)]/n+(n+1)/n
      <= C_new=9PA/2+3P/2+3Rn+12R+14.            (11)

The algebra in [3] now applies to the re-proved mean premises (6)-(10):

    C_old-C_new=R*(9P/2+n-10)-6>=74.

Thus (M) holds with the SAME old C_old,D_old for this normalized-cache circuit. This conclusion follows from the displayed new mean proof, not from substituting a mean into a sup theorem.

For the original point product Fhat*Khat, (6)-(7) give error at most Q*uV under PAu<=1. Its stored mean plus1 is at most `(nm+2)V` under Qu<=1. The inverse, its division by P and an optional final round give error at most `[Q+R*(nm+2)+1]uV`. The final chirp satisfies the old C_old bound by direct substitution. The exact-cache/coarse-runtime variant has smaller coefficient error than (8) and is covered too. These variants have different centers and representation costs. Bitwise identity is not asserted between them.

The kernel enclosure must be paid at every use, including correlated repeated uses. Scaling it does not divide its uncertainty by the cache reuse count. All root/kernel identities, selected grids, exact cached sums and cache-lifetime costs remain unchanged obligations.

## 5. Product-group transform through input fibers

Let outer axis lengths be n_1,...,n_d, with product v=phi(c). Put S=sum_i C_i for their legacy full-plan constants, counting repeated axes repeatedly. Assume every local D guard and Su<=1/2.

After some axes with product v_0, fix the unprocessed coordinates. The original inputs in that fiber have mean M_F. For each fixed output label on the processed axes, prove simultaneously

    ideal partial output norm <= v_0*M_F,
    partial error <= v_0*E*(M_F+1).                (12)

Initially v_0=1,E=0. The next length-r axis groups r disjoint equal-size fibers. Their original means average to the parent fiber's mean M_F. The mean of the actual stored line plus1 is at most

    v_0*(M_F+1)*(1+E).

Exact propagation of previous errors and (M) for the next child then establish (12) with

    v_0_new=r*v_0,
    E_new=E+C_i*u*(1+E).

This is an induction on actual fibers, not a claim that all intermediate lines have the global input mean. At the final axis,

    E=product_i(1+C_i*u)-1 <= 2S*u,
    |character_error| <= 2*v*S*u*(M_all+1).        (13)

The last inequality follows by finite product expansion and the geometric bound with sum C_i*u<=1/2. When S=0 the transform is exact. The output label can be primitive or imprimitive; restricting labels does not change the mean's denominator v. The original CRT axis order and positive character convention are preserved.

After exact conductor scaling, the intrinsic L-input contribution is

    epsilon_T <= (2*phi(c)/sqrt(c))*S*u*V_mean.     (14)

This leaves the complete-error contract [6] intact. Source, head, regrid, conductor-factor, completion and interpolation errors are still distinct. In particular a once-regridded input contributes an additional `phi(c)*rho*u/sqrt(c)` outside (14), where rho=1 for the admitted rounded adapter and0 for exact embedding. It must be charged once, within the chosen replacement allowance, not again in J.

## 6. A source-faithful mean bound without residue evaluation

The reviewed complete finite-EM and full-P20 magnitude result [9,10] gives a uniform stored polynomial output cap Pstar=173 on the first-four/final source union; final-band-only inputs have Pstar=163. Its current b94/min65 full-P20 evaluator, exact grid100 export and separately admitted alpha contract remain premises. No reduced Taylor length or unproved grid60 accuracy claim is used.

The exact raw head at unit representative a has modulus sqrt(c/a). Positivity and a decreasing-integral comparison give

    sum_(a unit mod c) sqrt(c/a)
      <= sqrt(c)*sum_(a=1)^c a^(-1/2)
      <= sqrt(c)*[1+integral_1^c t^(-1/2)dt]
       =2c-sqrt(c)<2c.                            (15)

The extension to all integers only bounds a positive sum. It does not assume equidistribution of units or characters. The finite sum comparison also covers c=1, though the actual large family has c>10000.

Use the actual nonnegative input enclosure sums from [6,7]:

    H=c^(-1/2)*sum e_head,a <=2^-63,
    J0=c^(-1/2)*sum e_rep,a <=2^-63.

These are sums of individual radii, not merely a small transformed error obtained by cancellation. Head grid100 encoding must be supplied. Exact addition of the polynomial and head has zero new assembly error; any separately admitted representation error is included in J0. Regrid the assembled input at most once. The extra contribution to its mean is at most

    sqrt(c)/phi(c)*(H+J0)+rho*u.

Because c<=265800<516^2 and phi(c)>=1, at p>=50 this is bounded by

    1032*2^-63+2^-50 < 2^-52+2^-50 <1.            (16)

For the already reviewed p80..108 adapter the same statement is immediate. The p50 observation here is ONLY a scalar reserve; it does not admit a p50 converter, cache or complete-error selector. The intrinsic theorem itself only needs its u/safety hypotheses.

Combining the actual polynomial center, (15), (16), and the augmented1 yields

    V_mean < Pstar+2+2c/phi(c).                    (17)

There is explicit reserve for regridding. Using only a pointwise head error<=1 and then silently absorbing u into an unknown strict gap would not establish (17). Polynomial approximation error is not added again: the cap Pstar already bounds its actual stored/evaluated center, while its actual-function radius remains in the separate alpha contract.

A small elementary uniformization is possible. If c had seven distinct prime factors, their product would be at least

    2*3*5*7*11*13*17=510510>265800.

Hence it has at most six. Euler's finite totient product and the decreasing function p/(p-1) imply

    c/phi(c) <= (2/1)(3/2)(5/4)(7/6)(11/10)(13/12)
               =1001/192.

For fewer factors, fill the comparison with additional factors greater than1. The elementary small-prime ordering lemma and finite totient identity require their ordinary mathematical proofs in a formal implementation; no prime test or factor inventory is imported as an axiom here. Therefore

    V_mean < 175+1001/96=17801/96<186              uniform,
    V_mean < 165+1001/96=16841/96<176              final only. (18)

The sharper conductor-dependent expression in (17) can also be left symbolic. A conductor serving earlier bands cannot use the final-only row for every sample. None of these estimates evaluated the mean or even one raw input.

## 7. What follows and what remains open

The paper supplies a concrete sufficient error theorem. The old legacy normalized mixed circuit can use V_mean=186 in (14) under the stated source and radius premises, while a separately established sup bound still controls arithmetic capacities. This is a mathematical possibility, not a selected precision or a measured saving. A later sharper-C proposal must prove its own mean recurrences or retain these older constants. Combining a newer smaller S with this proof without that join would be invalid.

A mean does not bound individual stored operands. Even with fixed mean, one coordinate may have n times that magnitude. Therefore root/data products, CT partial values, padded FFT stages, inverse stages, exact presums, raw products and round witnesses keep their previous sup-norm width proofs and before-acceptance bounds. The old semantic peak guard is retained in addition to local D whenever those capacities require it. Coefficient, root and kernel-setup widths do not shrink from (18).

Using the same circuit and precision changes no computed center and adds no per-input norm evaluation: (18) is an analytic bound on the existing source contract. If a later selector lowers p or changes input/cache centers, converter costs, coefficient enclosures, cache identities and lifetimes must be recomputed or explicitly adapted. No old sign success transfers to changed centers. The original full sample/guard union, principal work, finite coverage and final standard-axioms closure remain separate.

No metadata or price fold is authorized by this note. Before one is considered, independent review must validate (M), the source mean join, and the particular complete-error replacement allowance. Actual source/head enclosures, gate proofs and signs/counts remain unproduced by this research.

## 8. Fixed evidence and pinned inputs

The companion `mean_input_transform_error_20261111.py`, SHA256 `23C2DDD5E4264FE87BDA21C9892C0F688561C5FB924035004C1284EE19ACCE93`, completed86 fixed rational/hash checks on its first run. It checks six synthetic radix scalar recurrences, six CT coefficient pairs, four abstract Bluestein lengths, four tensor coefficient lists, and the fixed source reserve/totient arithmetic. These are scalar witnesses, not input vectors, gates, conductor inventories or proofs of the quantified statements. It imports no writer and performs no function evaluation.

Its exclusive2644-byte receipt `mean_input_transform_error_20261111.json` has SHA256 `13444563FC4A24DD4508BB17285665A0FE6F26A12AD8CEABD7499ED2A533E764`. The receipt tests the stricter already reviewed p80 reserve; (16)'s p50 extension follows from the displayed powers alone. No p50 assignment is consumed.

Paths below are relative to `work/qrh-campaign/agents`. All eleven pins were checked read-only.

|Ref|Source and consumed scope|SHA256|
|---|---|---|
|1|zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md, sections1-3, exact circuit only|C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01|
|2|zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md, sections1-5,7|4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4|
|2r|audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md|1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537|
|3|independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md, sections1-4|FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9|
|4|independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md|412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7|
|5|integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md|09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA|
|6|audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md, sections2-3|96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D|
|7|audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md, section4|6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA|
|8|independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md, sections1-4|B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266|
|9|audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md, sections3-5|03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904|
|10|prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md|1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328|
