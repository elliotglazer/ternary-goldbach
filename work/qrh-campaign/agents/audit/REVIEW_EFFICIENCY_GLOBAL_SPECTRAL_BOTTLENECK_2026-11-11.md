# Independent review of the global spectral bottleneck proposal

2026-11-11. Paper and source review only. No evaluator, numerical experiment, build, Lean declaration, or change to an existing artifact was used.

Verdict: the finite aggregate identity and the stated consumer limitations pass, with one required conditioning correction recorded below. The frozen author memo is accepted only together with that correction. Neither the identity nor this review establishes a smaller production workload, an actual residual bound, finite RH, or removal of the existing `PlattGRH` premises.

The reviewed [author memo](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/EFFICIENCY_GLOBAL_SPECTRAL_BOTTLENECK_2026-11-11.md) has SHA256 `FA15C61A449E9B752E8D64626E0AE6F19314BEBACA9A90696F242BECDB12311E`. Its bytes remain unchanged. The author acknowledged the correction during this review.

## 1. Conditioning correction

Section 4 writes `||b||_1 >= 1/min |L|` immediately after discussing an approximate inverse. That statement requires an exact inverse. For a candidate with primitive residual transforms satisfying

    |1 - L(s,chi) bhat(s,chi)| <= q < 1,

the correct bound is

    ||b(s)||_1 >= (1-q)/min_primitive |L(s,chi)|.

Indeed, choose a character attaining the minimum and use `|bhat| <= ||b||_1` and `|L bhat| >= 1-q`. The scalar algebraic example `L=1, b=1/2` has residual `1/2` and disproves the unqualified stronger claim. For the exact inverse, set `q=0`. The minimum notation presumes a nonempty primitive family; empty families have no conditioning obstruction of this form.

The earlier product report explicitly states its stronger bound for `b_exact`, so this is a transcription issue in the new memo. At a fixed residual margin bounded away from one, small factors still force large candidate norms. Allowing the margin to approach one does not justify a uniform inverse-norm lower bound. No scalar budget in the memo depends on the omitted factor.

## 2. Independent finite derivation

Let `q>=1`, `G=(Z/qZ)^*`, and `v=phi(q)`. For each `d|q`, unit reduction to `(Z/dZ)^*` is surjective. One can lift a unit modulo `d` while avoiding the primes of `q` absent from `d`, by CRT. Its kernel `K_d` therefore has size `v/phi(d)`. This includes `d=1` and the singleton unit group at `q=1`.

Use the positive transform `uhat(chi)=sum_g u(g)chi(g)`, the unnormalized inner product `sum_g conjugate(u(g))v(g)`, and unnormalized group convolution. The operator `A_d` is convolution by the uniform probability on `K_d`. It is self-adjoint and idempotent. On a character basis it has multiplier one precisely when the character is trivial on `K_d`, equivalently when its conductor divides `d`.

With the positive transform, the coordinate basis functions are inverse characters. This changes no conductor condition because a character and its inverse factor through exactly the same quotients. Thus

    P_c = sum_(d|c) mu(c/d) A_d

has multiplier, on a character of conductor `f`,

    sum_(d|c, f|d) mu(c/d) = 1 if f=c, and 0 otherwise.

When `f` does not divide `c` the sum is empty. Otherwise this is the divisor sum of the Mobius function on `c/f`. Consequently `P_c` is an orthogonal projection, even though its displayed Mobius expansion has signed coefficients. The projections over `c|q` partition the identity. No assumption that every divisor supports a primitive character is necessary; a corresponding projection can be zero.

Finite Parseval gives

    <u,P_c u> = (1/v) sum_(cond chi=c) |uhat(chi)|^2.

For a reduction fiber `F_r`, `A_d u` is its constant average. Hence

    <u,A_d u> = (1/|K_d|) sum_r |sum_(g in F_r) u(g)|^2.

Combining these proves equation (1) with its precise `1/v` and `1/|K_d|` factors. The induced Gauss formula supplies

    w(q,c) = c * indicator[Squarefree(q/c) and Coprime(q/c,c)].

It supplies no unconditional weight `c` outside that support. Inversion permutes the complete character set and preserves `w`. The principal contribution is exactly `w(q,1)|uhat(1)|^2/v`; it vanishes for nonsquarefree `q`, and otherwise has weight `1/v`. Principal omission is therefore legitimate by the stated subtraction, not by deleting a generic conductor contribution after changing its weight.

The source bodies in [Bombieri.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/Bombieri.lean:27) were read: `parseval_chars` at 27, `Schar` at 72, `sum_char_mul_S` at 78, `totient_mul_sum_units` at 135, and `norm_sq_gaussSum` at 152. These agree with the derivation. The new conductor-projector regrouping is a paper derivation, not a declaration already proved by those source names.

The bucket-work claim is valid as an algebraic schedule once the finite vector is given: process each of its `v` entries for each divisor `d`, form the `phi(d)` fiber norm squares, then combine divisor weights. Index construction, divisor enumeration, finite combination work, bit lengths and cancellation accuracy are additional costs. Positivity of the final quadratic form does not make every Mobius term positive. The formula alone gives no small upper bound.

## 3. Exact actual-function binding

The word "residual vector" needs a specific binding before applying the identity. Here is one valid binding that also checks the principal normalization. Take absolutely summable coefficients `a_n` supported on integers coprime to `q`, a positive scale `z`, a twist `beta`, and a normalized principal target `P`. Define on unit residue classes

    u(g) = (1/z) sum_(n mod q=g) a_n e(n beta) - P/v.

Then

    uhat(chi) = Schar(chi,a,beta)/z - indicator[chi=1] P.

Let `S'_b=sum_n a_n e(n(b/q+beta))`. The actual source Gauss identity, including its inverse character, shows

    sum_(b unit) |S'_b/z - mu(q)P/v|^2 = E_q(u).

For the principal character the constant arc correction has transform `mu(q)P`, exactly its Gauss sum times `P`. There is no division by `mu(q)`, so nonsquarefree moduli cause no exception. This construction retains the principal residual; alternatively, projecting it away requires a separate bound for that principal piece.

The vector `u` here is a residue-class prime-sum vector. It is neither the additive arc array `b -> S'_b/z-mu(q)P/v` nor a Hurwitz coefficient vector at a spectral height. Applying the Gauss weight to the additive arc array again would count that transformation twice. Applying it to the Hurwitz vector would bound a different function.

Absolute summability and coprime support are actual hypotheses of `sum_char_mul_S`. The raw smoothed prime coefficients are not all coprime-supported. The source first takes `coprimePart`, then restores omitted terms quantitatively. These removals must survive any proposed aggregate replacement.

This is visible in [MajorTotal.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/MajorTotal.lean:231): `resid_plus` at 233 and `resid_star` at 264 use `arc_chars`/`arc_chars_star`, coprime removal and the principal approximation. They currently retain `[Fact PlattGRH]`. At 760, `pointwise_bound` consumes a plus sum of squares and a pointwise star residual. At 974, `major_total` still has the same fact and the exact scale relation for `N/x`. Equation (1) supplies neither of those quantitative premises.

The frozen source uses `r0=150000`; the memo's `R132900` is the separately reviewed proposed cutoff reduction. This review does not claim that the source declaration has already been refactored to that cutoff or stripped of its fact instance.

## 4. Mixed and pointwise consumers

At one modulus and twist, multiplying the two energies gives a sum over two independently ranging characters. A diagonal sum over one shared character is not an identity for this product. Even bounds on the separate integrals of the two nonnegative energies do not bound the integral of their product: both functions can concentrate on the same shrinking interval. One needs suitable pointwise information or a joint product estimate. The memo preserves this distinction.

The existing major-arc proof is one sufficient route using pointwise star control. A redesigned integrated proof can use different sufficient inequalities, but must reconstruct the cubic comparison with the actual arc measure, scales and main terms. The five-item proposal in section 3 is an obligation list for such a redesign, not five established lemmas or five unavoidable independent assumptions.

The separate base-gap obstruction is real. [BaseGap2.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/BaseGap2.lean:243) states `norm_S_etaStar_le_gap` pointwise for every `x>=4.9e26` and every point in the stated difference of major-arc sets. Its `gap_point` adapter at 185 retains a closed lower twist bound and a strict upper bound. The proof uses primitive character bounds and noncoprime restoration. An integrated energy bound does not discharge this all-point statement. A uniform total energy can bound each residual term, but the main term, removal and exact numerical size must still be included.

Upper residual estimates also do not automatically provide the lower principal-energy terms or the original `sig` estimates. A finite set of tested scales cannot replace the nine-cell and unbounded-scale arguments. The memo correctly retains these requirements and refuses to transfer the older QRH route's allocations to the current original-analysis route. No global provider or added final premise is introduced by this review.

## 5. Global inverse and claimed savings

The preceding product report's sufficient test is mathematically sound. For one fixed coefficient vector `b(s)` holomorphic on a neighborhood of the entire rectangle, each primitive transform of `e-e*a*b` is holomorphic. A strict boundary norm bound below one bounds each transform there, and the maximum principle carries it into the rectangle. A zero of a primitive `L` would make its residual transform one, a contradiction. Unrelated panelwise inverse candidates do not give this conclusion. The stronger positive convolution moments are finite identities for the same residual and do not bypass this holomorphy requirement.

The earlier rectangle starts at `.555`. Its zero exclusion does not certify exact finite RH. Moving the edge to a value strictly greater than `.5` leaves an unchecked strip. Moving it onto `.5` can meet desired zeros. A count-based alternative needs enough location evidence, multiplicities and the required closed-height convention. Thus the memo correctly treats this as an unbuilt adapter.

The quoted circuit totals are conditional costs of the existing algorithm, not lower bounds on all ordinary-rule proofs. Removing character outputs algebraically is distinct from producing the required actual quadratic forms cheaply. The dense-map comparison and packed-multiplication caution are consistent with that distinction. This review does not assign a runtime, certify an aggregate producer, or independently rerun the operation-budget enumeration.

## 6. Verified pins and remaining scope

The following SHA256 values were checked from local bytes. Context pins are identification checks; the source and finite algebra scope is described above.

| Artifact | SHA256 |
|---|---|
| Bombieri.lean | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| MajorTotal.lean | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A |
| BaseGap2.lean | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| FAMILY_PRODUCT_CERTIFICATION_FEASIBILITY | B701615E4D93727BF7A2C290C41F94EDEB40C0E9FE2BCFAB4A725CB6AC4B8973 |
| REVIEW_FAMILY_PRODUCT_CERTIFICATION_FEASIBILITY | 5A2DD26E445829214DEEA92A6EB0C1527533EC6F1064FCF0F3CA9AE5C0C9929C |
| CURRENT_COMPUTE_BLUEPRINT | 8FEAC3536CCD7F521CD7BBD3B4986E1E7B9DAF289CA25273F466D5124A21DBDB |
| CURRENT_COMPUTE_BLUEPRINT_SCOPE_ADDENDUM | 3A9EDE78304E2196ED71437683B74C061637EABDF4047810DB4F5D29D024AA1A |
| CURRENT_SPECTRAL_OPERATION_BUDGET | D0D428B355F2DBD025DBE2BD6C4D1DC846B63892A81506445EC242571A8C1C7F |
| SCALED_HURWITZ_EM_SEED_PRECISION | 251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231 |
| WEIGHTED_EXCESS_DENSITY_FEASIBILITY | 37505FDC4F83F99727FE636654E4803E3EB1EBF7C1B35FBF4E8C627097A72C90 |

The accepted result is an exact finite reformulation and a correct specification of missing quantitative consumers, subject to section 1's erratum. Actual all-scale bounds, production spectral evidence, formal consumer refactoring, kernel validation and proof-volume estimates remain separate work. The final theorem and its original finite binary input are unchanged.
