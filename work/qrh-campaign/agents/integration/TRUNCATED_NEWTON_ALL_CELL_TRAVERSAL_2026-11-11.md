# Truncated Newton initialization and in-cell traversal

2026-11-11. New conditional paper circuit, formal polynomial identities and exact scalar metadata only. No coefficient, analytic, prime, zero or transform values, builds, declarations or source edits. Frozen predecessors remain unchanged. This proves an all-cell domain and error interface; it does not select a cost winner, adopt later-band savings or change any spectral output requirement.

Only the difference orders needed to reach the remaining physical points are retained. This removes the c>10F and c>20F guards: every supporting polynomial value stays in the original cell. The underlying polynomial still has degree19 and still uses all twenty source coefficients. There is no truncation of that polynomial.

## 1. Exact source-bound object

Let c>0, F=2Dout>0, v=2c, and fix a nonempty ties-down nearest-anchor bucket in1,...,c-1 with anchor k. Its endpoints are

    a0=max(1,floor((2k-1)c/(2F))+1),
    a1=min(c-1,floor((2k+1)c/(2F))),
    L=a1-a0+1 >=1.

Thus the numerators a0,...,a0+L-1 are consecutive, include any nonunits, and have

    q(t)=F(a0+t)-kc=q0+Ft,
    h(t)=q(t)/v in(-1/4,1/4],  0<=t<=L-1.

The actual delivered fine-grid normalizations are Dout512,1024,2048,4096,8192. The last still has F16384 even though its source grid is4096. The coefficient lookup must bind this anchor, normalization, height and exact source object. No auxiliary point is reassigned to a different nearest anchor.

Consume exact complex centers z_j=n_j/2^b, j0..19, with |z_j|<C=2^16 and an established common grid. For the selected source-compatible rounded variant below, use the independently reviewed b100 adapter applied to the ORIGINAL delivered centers. Its twenty coefficient conversions and source uncertainty remain separate. Define

    P(h)=sum_(j=0)^19 z_j h^j,
    f(t)=P((q0+Ft)/v),
    I(t)=sum_(j=0)^19 n_j(q0+Ft)^j v^(19-j),
    Q=2^b v^19,  f(t)=I(t)/Q.

This is the degree19 polynomial for the existing Hurwitz attachment. The separate finite-head/residue corrections, c^-s, character transforms, sign tests and zero-count closure remain unchanged. This note neither computes nor certifies their values.

Set m=min(20,L). The initializer will compute only Delta^j I(0) for0<=j<m. Higher initial differences are not needed for any output in this cell.

## 2. Truncated initialization preserves the lower orders exactly

The reviewed Newton proof uses the binomial polynomial basis and

    t*binom(t,j)=j*binom(t,j)+(j+1)*binom(t,j+1).

Multiplication by q0+Ft therefore makes a new order j depend only on old orders j and j-1. It never depends on a higher old order. Dropping all orders>=m is consequently exact for the retained orders through every degree step, even when the actual polynomial degree exceeds m-1.

Start with D0=n19. At degree i=1,...,19:

    if i<m: assign new D_i=iF*old D_(i-1) first;
    for j=min(i-1,m-1),...,1 in DESCENDING order:
        D_j=(q0+jF)*D_j+jF*D_(j-1);
    D_0=q0*D_0+n_(19-i)*v^i.

The descending order reads the old lower entry before it is changed. The top assignment occurs only when a new retained order is created. When i>=m, no discarded top is computed. The exact invariant after degree i is

    D_j=Delta^j J_i(0),  0<=j<=min(i,m-1),
    J_i(t)=sum_(ell=0)^i n_(19-i+ell)v^(i-ell)(q0+Ft)^ell.

This follows by the same multiplication identity and induction; it does not use any coefficient values. At i=19, J_19=I. The final retained state is exactly the lower part of the full twenty-order state.

In particular L=1 gives m=1 and nineteen ordinary degree steps for D0. It still uses every coefficient of P. Reducing the number of retained differences does not permit dropping high-degree source coefficients or their conversions.

## 3. Partial-degree and raw-product bounds need no conductor guard

For any retained j and any supporting integer0<=ell<=j, one has ell<=m-1<=L-1. Thus every J_i(ell) uses a physical in-cell argument. Its exact geometric bound is

    |J_i(ell)| <(4/3)C*2^b*v^i,
    |D_j| <(4/3)C*2^(b+j)*v^i.                       (1)

The second inequality follows from the alternating binomial formula and sum of binomial magnitudes2^j. It is valid for all retained partial degrees, without an assumption about cancellation of coefficients or differences.

The raw factors also stay controlled. Both a0 and a0+j are in the cell, so

    |q0+jF|<=v/4,  jF<v/2.

At an interior update, applying(1) to each old operand bounds the unadded products by

    |(q0+jF)D_j| < (C/3)*2^(b+j)*v^i,
    |jF D_(j-1)| < (C/3)*2^(b+j)*v^i.

Their raw sum is below(2C/3)*2^(b+j)*v^i, hence fits the stored bound(1). A new top has just the second bound. At order zero, multiplication contributes less than(C/3)*2^b*v^i and the inserted coefficient contributes less than C*2^b*v^i, giving the same(4/3)C bound before any cancellation. Every binary small-scale partial sum has the sign of its coordinate input and no larger magnitude than the completed scale, so it fits the same raw bound.

When m=1 there is no positive j and no step-size claim is needed. A single-point cell may have arbitrarily large F/c; the D0 proof still uses only |q0|<=v/4. For m>1 the required jF bound follows from actual in-cell endpoints. This is why no global c/F guard remains.

Let ell_i=bitlength(v^i). With C=2^16, a sufficient signed capacity for retained order j at partial degree i, including its raw initialization products/sums, is

    b+ell_i+18+j.                                    (2)

The nineteen coefficient prescales n_(19-i)*v^i fit b+ell_i+17 signed bits. The generic factors q0+jF have at most19 signed bits in the selected family, because |q0+jF|<=c/2<=132900<2^18. The nonnegative small factors jF are below c<=265800<2^19. Their widths are not inferred from an out-of-cell extrapolation.

## 4. Exact traversal with a shrinking live state

At physical position n, retain precisely orders

    0<=j<=r_n=min(19,L-1-n).

Initialize them at n=0 from section2. To advance to n+1, update in ASCENDING order

    D_j <- D_j+D_(j+1),
    j=0,...,min(18,L-2-n).

If order19 is still needed it remains constant because Delta^20 I=0. Discard orders above r_(n+1) after the update. Every read of old j+1 is available, and its support ends at a0+n+j+1<=a0+L-1. Thus the invariant D_j(n)=Delta^j I(n) holds on the entire retained state. The later traversal direction is the opposite of the initializer's direction.

All supporting points of these differences remain physical and in-cell, so(1) at degree19 continues to hold. A raw sum of order j and j+1 is bounded by three times the order-j magnitude bound. A conservative global traversal temporary therefore needs one bit above the largest live-state capacity. At b100, ell_19<=362 and m<=20, the full-cell maxima are

    live/Newton: 100+ell_19+m+17 <=499 signed bits,
    raw traversal addition: 100+ell_19+m+18 <=500.

These are sufficient capacities. Specific orders and partial degrees are smaller. L=1 has no traversal addition.

The exact variant exports D0(n)/Q at each required unit and uses the usual final grid100 rational-round witness. It advances through nonunits. There is no assumed equality of numerical outputs with another valid evaluator. Zero-unit cells may be skipped only with a checked coverage/pruning rule, not merely because this theorem permits their initialization.

## 5. Only m rounded initial differences are needed

Here fix b100 and u=2^-100. Let d_j=Delta^j f(0)=D_j(0)/(2^100 v^19), j0..m-1. Set

    S(L)=sum_(j=0)^(m-1) binom(L-1,j),
    p=102+bitlength(S(L)).                            (3)

Round each retained complex d_j ONCE to coordinate grid2^-p, ties toward positive infinity. There are m complex conversions, or2m coordinate witnesses. Store their integer numerators M_j. The complex initial errors epsilon_j are strictly below2^-p. Traverse with the same pruned integer additions and discards as section4, with no intermediate rounding.

The live error identity is

    2^-p M_j(n)-Delta^j f(n)
      =sum_(k=0)^(m-1-j) binom(n,k)epsilon_(j+k).       (4)

Terms with k>n vanish. If L<20 and j is live, then j+n<=L-1=m-1, so no nonzero term in the full Newton identity could involve a missing initial order. If L>=20 all polynomial orders are initially present. This proves(4) and the exact-state comparison in both cases; it does not pretend that f has degree m-1 when L<20.

Nonnegative binomial coefficients and their monotonicity in n yield, for every live state,

    |error_j(n)| <2^-p*S(L)<2^-102=u/4.               (5)

The same proof works for completely correlated initial errors. It is not a random-roundoff estimate. Precision may use a proved larger length bound, but any extra bits must be priced.

At a required unit, round2^-p M0(n) to grid100 with complex error<u. Never feed that output rounding back into the traversal state. Relative to the ORIGINAL delivered-center polynomial, the error is

    coefficient conversion + propagated state error + final round
      <(4/3)u+(1/4)u+u=(31/12)u<(8/3)u.               (6)

Thus the old alpha-evaluation allowance is preserved. Under the inherited amplification633 the all-circuit subtotal is less than6541u/4, leaving211u/4 below1688u. In a mixture with other admitted evaluators, retain the old1688u cap or prove the actual subset-weighted sum. Source uncertainty, analytic shift/target remainders and all finite-head attachments remain separate.

This reuses the rounded-initial-state mechanism of the separate full-state proposal but proves its new truncated domain, support and widths here. It does not import that proposal's c>10F hypothesis or its guard-dependent width table into the all-cell theorem.

## 6. Rounded-state and conversion widths

The true live difference has magnitude below(4/3)C*2^j. Adding the bound u/4 from(5) preserves

    |2^-p M_j(n)|<2^(17+j),

because(4/3)C+u/4<2^17 and2^j>=1. This explicit margin is needed; adding an error to a bare strict power-of-two bound would not suffice. The rounded-state signed capacity is p+18+j. Consequently its whole-cell live and raw-add capacities are p+m+17 and p+m+18.

For each initial conversion, let Q0=v^19 and X_j=D_j(0)*2^(p-100). Here p>=103, so the displayed shift is nonnegative. A supplied integer M_j(0) is accepted by the exact nearest-round relation

    -Q0 <=2(X_j-M_j(0)Q0)<Q0.                         (7)

The signed product, residual, comparison, denominator-power identity and exact shift all require ordinary proofs. They are wide initial conversions, not free dyadic assignments. Sufficient signed capacities at order j are

    X_j and M_j(0)Q0: p+ell_19+18+j,
    raw residual:    p+ell_19+19+j,
    doubled residual:p+ell_19+20+j.

These are derived before using the small accepted residual. At the largest selected cell L260, m20, S=32305056352236018054956299912 has95 bits and p197. The live/add capacities are234/235 signed bits. The largest initialization comparison still needs598 signed bits. The exact wide initializer and these conversions must remain charged.

At a unit output, final grid100 rounding divides M0 by the power of two2^(p-100). Signed Euclidean splitting, remainder/tie handling and exact reconstruction suffice. Multiplication by this divisor is an exact shift, not a general v^19 product. The sharper order-zero bound gives p+18 signed input capacity and118 signed quotient/output capacity; a conservative p+20 signed scratch capacity covers reconstruction/comparison. This is still an arithmetic certificate, not a free extraction of unsigned bits from a negative integer.

For the selected c<=265800,F>=1024, L<=ceil(c/F)<=260. Formula(3) is monotone in L because binomial coefficients are nonnegative and monotone, with missing orders interpreted as zero. Thus p<=197. For L<=20, S(L)=2^(L-1) and p=102+L. The full-length precision must not be charged to a short cell unless that is the chosen implementation.

## 7. Counts and coverage, without a cost conclusion

At degree i the truncated initializer performs min(i,m) general products and the same number of recurrence additions. Its small scales have j=1,...,m-1, each appearing20-j times. Therefore

    G(m)=sum_(i=1)^19 min(i,m)=m(39-m)/2,
    B(m)=sum_(j=1)^(m-1) (20-j)(popcount(j)-1),
    T(m)=sum_(j=1)^(m-1) (20-j)popcount(j).

Initialization costs G(m) general real-integer-times-complex-integer products, G(m)+B(m) complex additions and T(m) shifted-operand occurrences for the specified binary small scales. The nineteen coefficient prescales remain. General-product operand widths depend on the partial degree and retained order through(2); do not price every product at the maximum. Copies/references and factor setup remain charged.

Exact or rounded traversal performs

    A(L)=sum_(ell=1)^(L-1) min(19,ell)
        =L(L-1)/2              if L<=20,
        =19L-190               if L>=20

complex additions. The two formulas agree at L20. Initial rounding adds m complex wide conversions; final rounding adds U dyadic conversions for U required unit outputs. The exact alternative instead has U arbitrary-denominator final conversions. No initial conversion is needed in the exact alternative. All methods retain twenty original coefficient conversions per distinct shared source object when using the b100 adapter, even when m=1.

|L|m|G(m)|A(L)|p|Rounded live/add signed bits|Largest initial comparison signed bits|
|---:|---:|---:|---:|---:|---:|---:|
|1|1|19|0|103|121 / none|485|
|10|10|145|45|112|139 /140|503|
|20|20|190|190|122|159 /160|523|
|40|20|190|570|141|178 /179|542|
|260|20|190|4750|197|234 /235|598|

These are parameter examples, not new selected-family counts. Domain admission now covers every nonempty physical cell, but cost admission still needs its exact L,U, source/cache identities, all setup and width-sensitive prices. Later bands may consist largely of single-point cells, where initialization and conversion can erase any traversal saving. This theorem supplies no price conclusion about them.

For a fixed same-polynomial initializer, the rounded alternative beats its exact counterpart only if the complete priced reduction

    sum_(unit outputs)(wide final cost - dyadic final cost)
      +sum_(actual pruned advances)(wide add cost - dyadic add cost)
      -sum_(j=0)^(m-1) initial conversion cost - extra setup

is positive for the chosen generation/proof/checking objective. The shared initializer cancels only when it is actually identical and reused; different normalizations or source grids require their own joins. Against either accepted Horner comparator, compare all initialization, coefficients, advances and output witnesses directly. No product-count or bit-width difference alone proves a saving.

## 8. Proof boundary and evidence

The companion script uses formal indeterminates for every coefficient and q0,F,v. It reconstructs the truncated descending recurrence for every m1..20 and every partial degree, comparing each retained order with the independent closed Stirling/binomial expression for Delta^j J_i(0). It separately propagates formal initial-error variables through the pruned traversal, and checks the binomial identity on short lengths and selected longer endpoints. All lengths1..260 have exact precision, count and width checks. No actual polynomial or analytic values are generated.

Script `truncated_newton_all_cells_20261111.py`, SHA `1C1ACCED42EC255D5D880EC70364EB3C43D3118261122E5114607E9319F40441`, and JSON `truncated_newton_all_cells_20261111.json`, SHA `D8E01908E80DEF6EE7DCBA98DFD07F69F42168EFE273EEEACB06240F649A990E`, pass17528 exact checks. They do not import or execute any predecessor generator. The general proofs above, rather than the finite checks, establish the all-cell implication.

The exact input pins below are relative to `work/qrh-campaign/agents`. The new all-cell proof does not replace the independent review of the full-state rounded proposal; its restricted/guarded result remains separate.

|Input|SHA-256|
|---|---|
|prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC|
|moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234|
|integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md|691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025|
|audit/REVIEW_EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_2026-11-11.md|A21A7B16BFF97898E0D6C8F1FFBB3D39C231C1553BE2B9CF77B8770F5819261D|
|integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md|9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4|
|integration/CLARIFICATION_RESIDUE_GRID_MIXED_EVALUATORS_2026-11-11.md|B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815|
|audit/REVIEW_RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md|793AD4410778F45B39040F246B361E8877876ABA11083A2C9492288B2492B16D|
|major-constants/ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md|FB0B0F9AF9C53150E14C1F5FFDE7A39E78DD8A6BFA09FE7769BF234EBB965E46|

Ordinary formal soundness lemmas, source-bound concrete records, exact geometry/unit coverage, arithmetic witnesses, cache/import costs and spectral acceptance are still required. The result removes a polynomial-support guard and reduces retained state/conversion counts. It establishes neither actual signs nor a kernel-checked proof nor a cost saving.
