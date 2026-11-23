# Upward precision portfolios with shared-cache costs

2026-11-11. Bounded paper interface. No inventory, planner, price fold or portfolio search was executed. No source values, coefficients, transforms, signs, zeros, builds, declarations or proofs were produced. Frozen artifacts are unchanged.

The reviewed conductor-local minimum is a mathematical admission threshold, not a total-cost optimum. A small common precision portfolio can preserve the same complete error ceiling while merging cache keys. The correct comparison includes both the runtime classes and the union of actually required precision-specific caches. The proposed compressed second-pass data can support a class-uniform upward map without per-conductor gate expansion; it does not support arbitrary splitting inside a minimum-precision class.

## 1. Admitted upward maps

Bind r(c)=p_min(c) to the reviewed first-pass artifact and its exact error, plan and enclosure contract. This note uses the existing selector based on S_mixed, not the separately derived sharper-C successor. A future sharper minimum needs its own bound row artifact; the current p field cannot silently change meaning.

Let I={100,...,108}. Choose a nonempty allowed set P contained in I and an assignment f with

    f(c) in P,   f(c)>=r(c).                                  (1)

Use f(c) throughout that conductor's transform, all retained characters and all sample heights, including its inverse-character samples. Each assigned p keeps the same normalized rounded-cache circuit and supplies its own required u=2^-p root/gate/cache contracts. There is no within-transform mixed-precision claim.

The local budget test has left side `(2 phi S)^2*2^(2(108-p))`. Increasing p decreases this side and increases both safety slacks `2^p-D_local` and `2^p-2S_old`. Thus every f satisfying (1) remains admitted. The intrinsic error decreases, while all unchanged source, head, scaling, actual Y completion, negative-channel, kernel and interpolation allocations remain fixed. The complete radius stays at most the reviewed exact global-p108 ceiling

    [2804840254168152529/4294967296000000000]*2^-45.

This argument retains the old peak guards as well as local error safety. It does not weaken the source alpha contract or infer successful signs. New p-specific arithmetic generally changes centers, so actual strict sign and count tests must bind those new centers. A uniform radius bound is not a sign-margin certificate.

The current first pass has a nonempty class r=108. Therefore a portfolio covering every current row must contain 108. No subset or assignment is selected here.

The compressed family considered below is

    f(c)=g(r(c)),   g(r)>=r,   g(r) in P.                     (2)

The map g need not be monotone in r. The particular nearest-upward policy `g_P(r)=min{p in P:p>=r}` is valid, but is only a restricted assignment family. Searching sets P with this policy would not prove optimality over all assignments (2), much less over per-conductor assignments (1).

## 2. What monotonicity is actually proved

For the retained normalized width context, data capacity is a=p+14+e and coefficient capacity is b=p+f, with f=1 for roots and f=0 for scaled kernels. The exact context exponents do not change when p increases under the retained guards. The old byte templates are

    A(w)=2 ceil(w/8)+1,
    M(a,b)=5 ceil(a/8)ceil(b/8)+2 min(ceil(a/8),ceil(b/8))+1.

Both are nondecreasing in each nonnegative capacity. The three-product complex core is

    M(a+1,b)+2M(a,b+1)
      +A(a+1)+2A(a+b+2)+4A(a+b+4),

and the four-product core is

    4M(a,b)+2A(a+b+1)+4A(a+b+3).

Every summand is nondecreasing in p. Standalone complex-addition core `2A(a+1)` is also nondecreasing. With fixed nonnegative product/addition prices, the same statement holds for each mode's priced runtime subtotal. It also holds for any fixed nonnegative tariff on these component counts. Cheap-operation counts remain present; their unpriced proof or memory costs are not thereby zero.

For a fixed mode and allowed set, nearest-upward g_P therefore minimizes this runtime subtotal within (2). This does not prove total-cost minimality. Wider classes can merge cache keys and avoid a new setup lifetime.

The pointwise minimum of the two runtime formulas is also nondecreasing if both formulas are admitted at every compared p with the same pricing convention: take a minimizer at the larger p and use that same option at the smaller p. This observation covers only runtime cores. Gatewise switching to the three-product identity additionally creates exact coefficient-sum dependencies, so the minimum cannot be used as a complete price without their incidence and cost. The proposed data naturally supports two fixed-mode comparisons; arbitrary mode switching needs an explicitly sufficient association.

No monotonicity is asserted for every backend's actual time, proof bytes, numeral references, table specialization, cold cache price or repair workload. A different fixed-coefficient product, Gauss implementation, rounding schedule or algorithm dispatch must carry its own admitted price function. Comparing unequal modes at unequal p is not justified by the monotonicity of either fixed mode alone.

For a simple symbolic obstruction to choosing the smallest p everywhere, suppose classes r<s share a kernel and P allows both. Mapping them to r and s needs two kernel keys; mapping both to s needs one. If the removed r-key setup cost exceeds the extra runtime and other costs of raising the first class, upward mapping is cheaper despite nondecreasing runtime templates. This is a conditional inequality, not a claim about any current conductor. With three classes, a low class can profitably share a high class's cache while an intermediate class remains at its own p. Such a map need not be nearest-upward for its image set.

## 3. Exact runtime projection from compressed data

Moebius's frozen `CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_PREFLIGHT_2026-11-11.md`, hash `C5AAB690B926EC515E8708B2F3CB2B12C20E0ED6FA9C9313EC89803C7406B76E`, is a proposed pass, not executed or independently accepted by this note. Its runtime key is

    (r, category, data_ceiling_exponent,
        coefficient_exponent, division_bits),

with forty weights: twenty old weights and twenty +41 guard weights, each ordered by four alternative scenarios and five bands. At most nine times the old 133 width classes are proposed. This is a grouped structural statistic, not an individual-gate list.

Write H[r,k,j] for these weights and let price_b(k,p,mode) be the complete selected runtime price for one class under backend purpose b. Generation, proof production and ordinary checking generally use different prices. For scenario e, define J_e as its five old and five guard coordinates. Then the supported runtime functional is

    Run_b(g,mode,e)
       =sum_r sum_k sum_(j in J_e) H[r,k,j]
                                      *price_b(k,g(r),mode). (3)

Use only one scenario at a time. Retain band vectors if source/evaluator or backend prices depend on them. The old and guard weights must be included once each; four alternatives are not one campaign. Kernel products remain positive and normalized runtime scales remain zero.

Before any portfolio comparison, the proposed second pass must recover the reviewed common-p108 normalized old+guard comparator and the old histograms required by its own preflight. This note grants no shortcut to that validation. Once H is independently accepted, (3) can reprice a class-uniform map without reopening conductor rows or expanding gates. An aggregate histogram that forgets r cannot do so. A table containing only the already-priced scalar total at p=r cannot recover byte-threshold changes at g(r).

For arbitrary f within one r-class, H loses which conductor supplied which work. The first-pass conductor rows still preserve source identity and axes, but recovering that association requires a separately authorized source-row/context pass. No such pass is requested here. The data limit is about the compressed second-pass output, not a mathematical obstruction to more general assignments.

## 4. Cache union and a complete cost functional

The accepted first-pass cache artifact records every full-plan `(n,r,saved_choice,children)` state and every kernel `(n,r,P_n)` membership. Here r is its recorded original assigned minimum. For a class-uniform g, its required kernel key set is exactly

    U_K(g)={ (n,g(r),P_n,plan,variant,rounding,contract)
                : (n,r,P_n) is in the saved membership }.   (4)

Take the SET after mapping, not the multiset. When two r classes map the same kernel to the same p, setup is shared subject to an actual common cache lifetime. When they map it to different p values, the entries remain separate. A per-p count of entries or a histogram of duplication multiplicities does not determine (4); the saved kernel identities do.

Under the declared one-cold-cache schedule, scaled coefficient entries and complex scale rounds are `sum_(key in U_K) P_n`. Three-product use needs twice that many exact REAL sum operations, built from the new centers. These counts are setup inputs, not their full prices. Original kernel FFT work, root/chirp producers, rounding, signs/ranges, enclosure verification and source binding remain charged.

Full-plan state identities can likewise be mapped and deduplicated for the declared complete-set root/chirp schedule. Include the padded kernel-FFT root sets and transform directions required by each kernel producer. The existing full-node/kernel descriptions support these declared producer sets; they do not prove global deduplication of equal rational angles across unrelated sets. No rational-angle enumeration or new root-sharing count is assumed.

For backend purpose b and scenario e, an explicit complete functional is

    Cost_b(g,mode,e) = Common_b(e) + Run_b(g,mode,e)
       + Embed_b(g,e)
       + sum_(k in U_K(g)) life_K(k)*Build_K,b(k)
       + sum_(s in U_sum(g,mode)) life_sum(s)*Build_sum,b(s)
       + sum_(z in U_root(g)) life_root(z)*Build_root,b(z)
       + BindLoadStore_b(g,mode,e) + Other_b(g,mode,e).        (5)

These categories must be disjoint. In this convention Build_K includes kernel FFT arithmetic, normalized rounds and their kernel-level error/source bindings, but excludes primitive root/chirp production and exact sum-cache work charged in the next terms. Build_root charges those root/chirp producer objects and their proofs. If a backend instead includes roots in Build_K, remove those occurrences from U_root. BindLoadStore charges remaining per-use imports, object identities, representation references, storage/traffic and retention. Runtime signs/ranges/rounding witnesses omitted from a core tariff must appear here or in Other, never vanish.

Common includes unchanged principal, small-family, finite-coverage, source-generation and proof-library work only to the extent it really is identical under the compared schedules. Other explicitly contains costs not yet modeled, including any assignment-dependent proof construction, repair and query work. A full conclusion about a concrete run requires those costs or valid bounds; equation (5) is not a claim that they have been measured.

Grid100 source centers embed exactly at p>=100 by checked shifts of their numerators. This supplies no free conversion proof, no smaller source radius and no new finer source value. Source production itself is not repeated merely because transform p changes. Embed must price the actual number of input uses or retained conversion objects, their widths, identities and lifetimes. Head/alignment producers keep their own error contracts; an unproved regrid cannot be hidden in an exact source embedding.

The proposed H and kernel membership alone do not determine Embed. The frozen second-pass preflight therefore retains, during its already-required row join, per-r forty-weight conductor-height, residue-input and primitive-output arrays. Once independently accepted, these arrays supply the multiplicities for declared per-input/per-output embedding and transport prices without another loop. Unweighted per-r phi totals would be insufficient because sample counts and guards vary. Representation-specific prices and source-object sharing still remain symbolic unless separately proved; grouped counts do not determine individual conversion-cache identities or lifetimes. This note requests no additional loop.

For cold comparison with retained caches, every required key has one lifetime. For a sunk-cache comparison, an already available exactly matching object may have zero new construction lifetimes, but importing/checking/retaining it can still cost work. Do not subtract its historical construction as a refund. Eviction/rebuilds can make lifetime counts exceed one. A cache at another p, variant, rounding rule or enclosure contract is not already available merely because its exact mathematical kernel agrees. Cross-precision regridding or a shared producer enclosure needs its own proved adapter and paid work.

The contract includes both grid and uncertainty. At selected p, root/gate error is <=2^-p, original kernel error is <=PA*2^-p and normalized cache error is <=(A+1)*2^-p. Cached sums are exact sums of the actual new centers. Upward precision requires these tighter producer bounds, not just more zero bits on a coarse coefficient. Full identity includes plan, n, P, coefficient/chirp conventions and direction, normalized variant, rounding policy and actual lifetime.

## 5. Actionable comparison and present boundary

For any two admitted class maps g,h, the sound decision criterion is simply the signed difference of (5): runtime reserve must exceed the extra embedding, union/setup/lifetime, binding/storage and remaining costs. With a small allowed set P, one may later compare nearest-upward policies as a restricted family or permit all class-uniform maps (2). The declared family must accompany any claimed optimum. No subsets or maps were enumerated here, and no portfolio is chosen.

The existing first pass supplies the p_min/source binding and full-plan/kernel membership. The accepted uniform-p price receipt and joined guard receipt supply comparators, not class-conditioned H. The proposed second pass is designed to supply H and preserve those comparators. After independent acceptance, this combination suffices for (3), (4), declared cache setup and a symbolic test (5), without per-conductor gate expansion. It does not by itself determine source-embedding sharing, globally deduplicated root objects, actual cache lifetimes, arbitrary within-class assignments, arbitrary gatewise product-method choices, actual signs or end-to-end checking time.

This is the present useful conclusion: retain the p_min class in the compressed runtime data and exact kernel identities in the cache membership. Those associations support cost-aware upward precision choices. Minimum admitted p remains a safe baseline, but it is not a proof of minimum complete cost.

## Source snapshot

The papers and writer source were read; no saved inventory or price data were parsed or folded in this task. The second-pass schema is a frozen proposal, not executed or accepted by this note. All paths below are relative to `work/qrh-campaign/agents`.

|Source|SHA256|
|---|---|
|major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md|1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A|
|independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md|15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2|
|major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md|2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D|
|independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md|01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C|
|major-constants/conductor_local_precision_metadata_20261111.py, contract and output schema only|8B0C9764E94A7E35FB071CED0E5731135E11D397B9BA9F582119BAA9005386DA|
|moebius/NORMALIZED_TRANSFORM_LOWER_PRECISION_COSTS_2026-11-11.md|803DFBF53D07EF2FDBE0389561EF1B56631EC06B83FA56025DD9CDC020CA0243|
|prime-estimates/REVIEW_NORMALIZED_TRANSFORM_LOWER_PRECISION_COSTS_2026-11-11.md|B2C3D637D9983156620A6940B2C32B65146FAED681DEB2CB36F7D3A2C4D7F4E8|
|integration/NORMALIZED_TRANSFORM_SHORT_GUARD_JOIN_2026-11-11.md|ADDED6BC91975C40C6029A591F4486782932C92B144D39465AC5E0F3CB597E58|
|audit/REVIEW_NORMALIZED_TRANSFORM_SHORT_GUARD_JOIN_2026-11-11.md|47B0B4971E65D79E819DA3717DBEA9058D348CF02411AC6F78F32F4E3CBF489D|
|moebius/CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_PREFLIGHT_2026-11-11.md|C5AAB690B926EC515E8708B2F3CB2B12C20E0ED6FA9C9313EC89803C7406B76E|
