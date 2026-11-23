# A reusable certificate schedule for dyadic window kernels

2026-11-11. Bounded algebraic research, pending independent review. No offsets or digits were enumerated, no kernels or functions were evaluated, and no builds, declarations, proofs or production inventories were emitted. The counts below are symbolic. They assume neither a number of sign queries nor successful signs.

For the accepted h=159/500, m=41, Delta=5/64 window, exact evenness reduces a complete dyadic-level kernel cache to 42*(Q-1) noninteger distance keys, Q=2^R. A normalized sinc factor avoids amplification of a shared sine error near the lattice. A separate Gaussian recurrence uses two exponential seed roles per fractional key plus41 fixed shared constants. Its added arithmetic and proof costs are explicit below. These role counts conservatively allow repeated mathematical arguments. This is a conditional schedule, not a runtime or method selection.

## 1. Fixed contract and canonical keys

The source window is `audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md`, SHA256 `32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E`, reviewed at `61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730`. The conditional numerical contract is `audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md`, `6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA`, reviewed at `3D8831ABB2BBD69A1AD82389B8A2082DBCE18D5E6C47E73230F6808F0EBFF589`. Paths are relative to `work/qrh-campaign/agents`.

Let a target have exact coordinate t0=(k+theta)Delta, k integer, with theta=j/2^r in [0,1). Define

    A=Delta^2/(2h^2)=390625/12943872,
    K(z)=exp(-A*z^2)*sinc(pi*z).

The finite coefficient at sample k+d is K(d-theta), d=-41,...,41. K is even. Its sign is NOT removed by taking an absolute distance: sinc changes sign between successive integers.

Use a reduced dyadic rational as the mathematical distance key. A noninteger positive distance has unique form u=a/2^r with r>=1 and positive odd a. Here a<42*2^r. The function/cache key must additionally bind h, Delta, the exact K definition, the output grid, the enclosure radius and the producer/certificate version. A conductor, character or integer target k is not part of the kernel's mathematical argument. They remain part of the sample and output binding.

At theta=0 the exact coefficients are K(0)=1 and K(d)=0 for every other integer d in the stencil. These are removable-sinc and integer-sine identities, requiring no numerical Gaussian or sine enclosures. A lattice query may return its already certified Y sample, with its radius and any required output conversion. This does not remove the sample's source, phase or binding proof.

Complementary offsets obey

    K(d-(1-theta))=K((1-d)-theta).

The reflected stencil is [-40,42], not [-41,41]. Reversing83 cached entries without the extra boundary coefficient is therefore invalid. The canonical-distance cache below includes that boundary. In particular theta=1/2 needs42 distinct absolute distances for its83 entries.

## 2. Exact count for a requested set of classes

Let Theta be the set of distinct NONZERO fractional offsets actually requested within a fixed precision/cache cohort. Repeated queries with the same fractional offset do not enlarge this set. Put

    F=Theta union {1-theta : theta in Theta},
    T={min(theta,1-theta) : theta in Theta},
    n_theta=|Theta|, n_f=|F|, n_t=|T|.

For each f in F, required positive distances have form u=l+f. If f belongs to Theta, l=0,...,41 is required. If f is present only as a complement, l=0,...,40 suffices. Write this last index as M_f. To see the asymmetry, the original offsets d<=0 give u=(-d)+theta, while d>=1 give u=(d-1)+(1-theta).

Consequently the number of distinct noninteger distance keys is exactly

    D=sum_f(M_f+1)=42*n_theta+41*(n_f-n_theta)
      =41*n_f+n_theta.                                  (1)

This counts the complete declared stencil for each requested class. It does not omit terms based on unproved smallness. The number of negative signed kernel entries is `21*n_theta+20*(n_f-n_theta)=20*n_f+n_theta`, because their integer part l is odd. There are21*n_f nonnegative entries.

For the full grid at maximum level R>=1, let Q=2^R and Theta={j/Q:1<=j<Q}. Then F=Theta, n_theta=n_f=Q-1 and n_t=Q/2. The absolute distances are exactly

    {a/Q : 1<=a<42Q and Q does not divide a}.

Every such key is attained on the d<=0 side of some offset. Conversely every stencil distance lies in this set. Thus D=42*(Q-1). The number of raw nonzero-class coefficient occurrences is83*(Q-1), consisting of41*(Q-1) twice-used distances and Q-1 unpaired outer distances.

The grids through R are nested, so these are cumulative counts, not sums of separate uncanonicalized grids. At new level r>=1, odd numerator keys contribute42*2^(r-1) new distances and2^(r-1) new fractional keys. The normalized-sinc bases contribute one at r=1, then2^(r-2) at each r>=2. The case R=0 has only theta=0 and needs no noninteger kernels or elementary seeds. These statements are set identities, not an offset enumeration.

## 3. A conditioned factorization

For u=l+f with 0<f<1, set t=min(f,1-f), so 0<t<=1/2 and t<=u. Integer sine identities give

    K(u)=(-1)^l * (t/u) * S(t) * G(u),
    S(t)=sinc(pi*t),  G(u)=exp(-A*u^2).                   (2)

The factors S(t), G(u) and t/u lie in [0,1]. This is preferable to sharing sin(pi*t)/pi and dividing its absolute error by u: that construction can amplify an error by2^r. In (2) the exact rational multiplier t/u is at most one, so a uniform absolute S error remains uniform as the dyadic level grows.

For canonical f=j/q, q=2^r, the final ratio is exactly

    t/u=min(j,q-j)/(l*q+j).                              (3)

Its denominator is positive and below42q. No reciprocal enclosure is needed in the schedule below. The denominator and numerator still carry O(r) input bits; bounded output precision does not make their proof or representation cost constant.

A stable elementary S enclosure is a separate numerical producer. One possible analytic basis is the even series

    sinc(x)=sum_(n>=0) (-1)^n x^(2n)/(2n+1)!.

On |x|<=2 the terms decrease in magnitude. After n=0,...,15 its remainder is at most2^32/33!<2^-90. Since |pi*t|<2, this gives a uniform truncation bound without dividing by t, including the limit t approaching zero. Certified pi/argument approximation, polynomial arithmetic and final rounding must still fit the S seed radius. The tail bound alone is not a complete evaluated enclosure. The cost function below includes those tasks and any exact conversion of a long dyadic argument.

## 4. Two Gaussian seeds per fractional key

For each f in F, construct enclosures of

    a_f=exp(-A*f^2),   b_f=exp(-2A*f).

Also construct and retain shared H_l=exp(-A*l^2), l=1,...,41, with H_0=1 exactly. The exact identities are

    T_0=a_f,  T_l=T_(l-1)*b_f,
    G(l+f)=H_l*T_l.                                    (4)

They follow from `(l+f)^2=l^2+2lf+f^2`. All factors are in [0,1]. Arguments of the fractional seeds lie below1/32 and1/16, and all fixed H arguments are below53. These are domains for elementary enclosure producers, not evaluations of their values.

For each f, (4) uses2*M_f real multiplications to construct its M_f+1 Gaussian factors. At l=0, G(f)=a_f is copied exactly. The cost is therefore2*(D-n_f) products. It replaces D separately constructed Gaussian enclosures with2*n_f+41 exponential SEED ROLE requests when Theta is nonempty. The41 constants are paid once per actual certified cache lifetime, not once per fractional key. With no nonzero requested class, they need not be built.

These are not all distinct arguments. For example b_(1/2)=H_1, and a_f=b_(f^2/2) whenever the latter fractional key is present. An optional exact-argument cache may merge these roles after checking the argument identity, center, radius and proof binding. In the complete level-Q set, the second collision occurs for a canonical f=j/2^r exactly when2r+1<=R, because j is odd. There are2^floor((R-1)/2)-1 such f. Their arguments are below A, so they are disjoint from the single b_(1/2)=H_1 collision at A; the maps are injective. Thus the DISTINCT SEED ARGUMENT count in that dense set is `2Q+39-2^floor((R-1)/2)` for R>=1. The primary cost ledger below does not claim this deduction: it charges the conservative roles and leaves exact-argument lookup/binding as an optional separately priced refinement. It claims no minimal enclosure or circuit count.

This is not an automatic cost reduction. For a single half-offset, the cold scheme has43 elementary exponential seeds versus42 separate Gaussian enclosures, and it adds recurrence arithmetic. Argument-dependent enclosure costs, cache state and the proof backend decide the comparison. Other Gaussian recurrences or power constructions may improve this schedule, but are not silently included here.

## 5. Complete rounding and kernel-radius proof

Choose epsilon=2^-80 for this bounded construction. Require every elementary a_f,b_f,H_l,S(t) seed center on grid2^-80 to have absolute error at most epsilon. Project each real center onto [0,1]. Projection is nonexpansive relative to a true value in [0,1], so it preserves the seed radius. Its comparisons, selected value and proof are charged.

Every general real multiplication below is rounded back to grid2^-80 with absolute error at most epsilon and then projected to [0,1]. The exact rational multiply-round in the final stage has the same error target and projection. A deterministic nearest rule, with proved residual and tie convention, can meet the round premise; merely choosing the grid is not a certificate.

For the recurrence in (4), because both true and stored factors are at most one,

    e_T(l)<=epsilon+l*epsilon+l*epsilon=(1+2l)epsilon.

The two terms per step are the b seed error and the multiplication round. There is no independence assumption on reused errors. After multiplying by H_l, for l>=1,

    e_G(l)<=e_T(l)+epsilon+epsilon=(3+2l)epsilon
             <=85epsilon.

At l=0 the tighter bound epsilon holds. Now round and project the product of the S center and G center, then multiply by the EXACT ratio (3), round and project again. The error is at most

    e_G+epsilon+epsilon+epsilon <=88epsilon <2^-72.       (5)

The three added errors are the S seed, first product round and final rational round. The rational ratio itself is not rounded before multiplication. An implementation that first approximates that ratio must add its error and recheck the budget. Finally apply the exact sign (-1)^l. This produces a signed K center with the same radius, not an enclosure of |K| substituted for K.

For a concrete rational-round witness, if the nonnegative input center is y/2^80 and (3) is b/a, the output integer is nearest to y*b/a. Its check must bind the exact numerator product, candidate quotient times a, the residual, doubled-residual inequalities and tie convention. The division is not a free inverse. All numerator/denominator widths depend on the actual canonical key. Their products and residual checks are part of the price below.

Thus the existing rK<=2^-72 stability premise is met conditionally by these seed and arithmetic certificates. The sample radius and e_acc<=2^-51 requirements remain unchanged and separate. Reusing a kernel at many targets reuses its error bound, not a fraction of that bound.

## 6. Typed construction and storage schedule

For an arbitrary nonempty Theta, the schedule has the following exact counts:

|Item|Count|
|---|---:|
|Fixed integer-Gaussian seed roles|41 per cold cache lifetime|
|Fractional Gaussian seed roles|2*n_f|
|Normalized-sinc elementary enclosures|n_t|
|General dyadic multiplications|2*(D-n_f)+D=3D-2n_f|
|Dyadic product rounds|3D-2n_f|
|Exact rational multiply-round stages|D|
|Post-gate [0,1] projections|4D-2n_f|
|Seed projections|41+2n_f+n_t|
|Negative sign assignments|20n_f+n_theta|
|Signed kernel centers to retain|D|

The final rational stage already includes its own round witness and must not be charged twice. Conversely, a general multiplication price that excludes its output round must be joined with the round row. Numerical seed prices include their own internal arithmetic, final grid conversion and enclosure proof; they are not zero-cost theorem calls.

On a complete level-Q cache these specialize to2Q+39 exponential seed roles, Q/2 distinct sinc arguments,124*(Q-1) general products,42*(Q-1) rational stages and166*(Q-1) post-gate projections. For R>=1 the same cache covers all earlier levels. Incremental construction adds only newly canonical keys and their dependencies when the old certificates remain valid at the required precision. The receipt's exponential-seed fields refer to these conservative role counts, not the optional distinct-argument cache.

Projection permits the inclusive center value1. A grid80 nonnegative center therefore needs81 unsigned magnitude bits if represented as an ordinary numerator; a signed kernel center can use82 signed bits. Exact dyadic products may have numerator2^160 and need161 unsigned magnitude bits before their round. Raw residual/sign/shift capacities must be derived for the chosen ordinary-arithmetic templates rather than inferred from a smaller semantic result. Rational-stage operands additionally carry the key's denominator bits.

One fractional key can be built in a streaming order using its running T center and a few temporary centers; G need not remain as a separate numerical array after its kernel is constructed. This is not an O(1) certificate-memory claim. The retained kernel centers, seed certificates, recurrence dependencies, imported proof identities and their cache bindings still require storage or paid reconstruction. A persistent D-entry cache is one explicit design, not free memory.

## 7. Complete price interface and permitted reuse

A complete construction price is the sum of the actual elementary enclosure prices at arguments A*l^2, A*f^2,2A*f and pi*t; the general product and round templates; the exact rational multiply-round templates; projections, signs, canonical-key arithmetic and per-row kernel identities; and source/import/binding, memory and cache-lifetime work. The count table specifies multiplicities, not equal prices across types or widths.

For example, with declared uniform template prices C_mul,C_round,C_rat,C_clip,C_sign within one fixed width cohort, its arithmetic part is

    (3D-2n_f)*(C_mul+C_round) + D*C_rat
      +(4D-2n_f)*C_clip +(20n_f+n_theta)*C_sign.

Add the seed producers and projections, universal lemma implementation/checking, every actual theorem instantiation/import, key/argument bindings, numerals and lifecycle/storage work. If widths vary with r, use a sum of actual per-key prices instead of this uniform projection. No comparison subtracts an upper-bound cost from an unrelated lower or unpriced baseline.

The algebraic identities, clipping estimate and recurrence error lemma can be proved once. Every numerical leaf still needs an ordinary checked enclosure, and each use must be bound to the exact rational argument and center. Hash identity is an integrity aid, not a replacement for these proofs. Sharing an ordinary proof DAG requires the exact objects expected by the checker; equal-looking expressions or independently rounded centers are not interchangeable.

At fixed h,Delta and certified radius, kernel certificates can be shared across conductors, characters, integer translates and repeated queries. Canonical dyadic keys also prevent rebuilding the same offset at several nominal levels. A higher-precision request may reuse a certificate only if its proved radius and representation meet the new requirements. Otherwise its producers, recurrence and rounding must be rebuilt or refined. Precision-specific caches and concurrent lifetimes are charged separately.

The finite sum itself generally cannot be reused across different characters or integer targets: their sample vectors differ. For each actual nonlattice query, the admitted direct schedule still has83 products,82 additions and its serialization, with a separately proved accumulation radius. A repeated identical query may reuse its result only with matching sample-center versions, kernel versions and tolerance. Fixed-offset convolution is an exact alternative organization, but needs its own query workload, padding, normalization, numerical-error and cost proof. None is assumed here.

This packet therefore gives a conditional kernel-production/cache reduction without assuming all dyadic offsets are queried or that any sign succeeds. Actual sample guards, source production, completion, interpolation margins and Turing completeness remain the earlier obligations.

## Evidence

Own script `major-constants/dyadic_window_kernel_schedule_20261111.py`, SHA256 `5EA3C9F8EDD742823D4B011DB8ECBFB34BA85551331C3E15A7E5FAFAEE8EA579`; receipt `dyadic_window_kernel_schedule_20261111.json`, SHA256 `9DB5A77E99EF4F1BEFFECA6AA9CD0896605A603D1A8675467680B7B1970EFF8B`. It checks33 rational and symbolic coefficient identities, the exact Gaussian parameter, domains, error reserve and sinc tail. It does not enumerate offsets, digits, kernels or function values. The general key/count and recurrence proofs are given above. Old frozen artifacts are unchanged; independent review is pending.
