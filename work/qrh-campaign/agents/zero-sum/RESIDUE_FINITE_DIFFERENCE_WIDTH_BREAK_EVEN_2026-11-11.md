# Width-sensitive break-even for residue finite differences

2026-11-11. Paper cost preparation and exact integer/rational specializations only. No coefficient, function, character, transform, prime or zero values were evaluated; no builds or source changes were made. The finite-difference circuit and occupancy packets are frozen inputs under their separate reviews. This note prices their stated contracts conditionally and selects no runtime winner.

The useful comparison is between complete per-output arithmetic proofs, not between 19 multiplications and 19 additions. Exact differences have a wide common denominator. They also require initialization at every new polynomial and a final wide rational-to-dyadic conversion at every consumed unit. Those costs can erase an apparent multiplication saving.

## 1. Same polynomial and two different traversal schedules

Use `integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md`, SHA `691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025`, and `prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md`, SHA `99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1`. V2, rather than an earlier draft, is the circuit input.

For one height, conductor and fine-alpha cell, let F=2Dout, v=2c and r(a)=Fa-kc. The exact displacement is h=r/v. At actual in-cell targets, |h|<=1/4. The denominator does not contain an additional Dout. With common dyadic coefficient grid 2^-b and degree d=19, one coordinate has integer numerator

    I(a)=sum_(j=0)^19 n_j r(a)^j v^(19-j),
    Q=2^b v^19,             P(h(a))=I(a)/Q.

The same actual stored centers and inherited coefficient/Taylor errors must be used. Exact alignment to b is not a license to round coefficients without a new budget. The illustrative b122 layout below requires proof that all delivered centers lie on that grid or a coarser one.

Let a block contain L consecutive integers and U required unit numerators. L counts nonunits too. The two V2 schedules must not be mixed:

| Schedule | Admission | Advance additions per complex state |
|---|---|---:|
| Pruned in-cell block | L>=20; all initialization/support nodes in the cell |19L-190|
| Screened whole cell | c>20F; every nonempty cell, even short or zero-unit cells |19(L-1)|

Both initialize 20 values by exact numerator Horner, costing 380 wide-by-small products and 380 additions, then 190 triangle subtractions. Both need 19 coefficient prescales unless already cached for this identical polynomial/conductor/height. The total additions are respectively 19L+380 and 19L+551. The latter schedule permits polynomial-only support outside the cell with |h|<3/4; it does not consume an actual Hurwitz approximation there.

The occupancy packet uses ties down. V2 section8 provides that exact convention. Alternatively, ties-up and ties-down *counts* correspond by a->c-a, k->F-k, preserving gcd and length. That bijection does not identify coefficient vectors. An actual circuit must bind a single matching anchor convention. The occupancy reference's A and B totals cannot be inserted into the pruned-block formula without a checked long/short partition.

## 2. The narrow Horner comparator must include rounding

The accepted original contract has 19 real-times-complex products and 19 complex additions per unit, each with complex absolute roundoff at most u_H=2^-100. Its final finite-evaluation error is at most (8/3)u_H. Price all of that arithmetic, including exact rational h, signed operations and round witnesses. A coefficient is not a machine float with an assumed free multiply.

A useful separately justified comparator is a fused rational Horner stage, rounded once. Let the previous coordinate center be M/2^g and the next coefficient n_j/2^b. Put B0=max(b,g). Its exact pre-round numerator and denominator are

    Z=n_j*v*2^(B0-b)+r*M*2^(B0-g),
    D=v*2^B0.

This is the ordinary Horner identity. Coordinate nearest-grid error at most 2^(-g-1) gives complex error below 2^-g. With coefficient norm at most C=2^16 and |h|<=1/4, stored complex Horner states are bounded by `(4/3)(C+2^-g)<2^17` for g=100. The same calculation bounds the signed numerator by `|Z|<v*2^(B0+17)`. Thus a sufficient signed numerator capacity is

    w_H=B0+ceil(log2 v)+18.

This is a proved candidate comparator, not a claim that an existing checker implements it. It uses a stronger rounding allocation than the old separate product/addition circuit. If the latter is the chosen baseline, price its two rounds instead; the multiplication round has narrow denominator v, and the subsequent coefficient addition has a dyadic alignment/rounding proof.

At c<=265800, b122 and g100, v has20 bits and w_H<=160. After cancellation of the output power of two, the fused denominator is `v*2^(B0-g)`, at most42 bits. Its odd arithmetic core is still v, of at most20 bits. Multiplication by r at an actual target uses |r|<=c/2, a signed factor of at most19 bits. The exact coefficient alignment, signs and carry comparisons must still be charged.

## 3. Difference widths and the final witness

V2 proves, for pruned in-cell blocks, `|I|<2^17Q`, retained order-j differences below `2^(17+j)Q`, and raw addition temporaries below2^37Q. Write ell19=bitlength(v^19). Sufficient signed capacities are b+ell19+37 for stored differences and b+ell19+38 for their addition temporaries. The screened full-state variant uses one extra bit because its supporting polynomial bound is4C rather than4C/3.

At the illustrative maximum conductor and b122:

| Object | Sufficient size |
|---|---:|
|v^19|362 bits|
|Q|484 bits|
|Pruned stored difference / addition temporary|521 /522 signed bits|
|Screened full-state difference / temporary|522 /523 signed bits|
|Final conversion divisor after g100 cancellation|384 bits|

These are conservative capacities, not measured operand lengths. A finer common b raises them. Exact common-factor cancellation, factored witnesses or a more efficient basis initializer would require their own costed circuits; none is credited here.

For final output m/2^g, check `(2m-1)Q <=2^(g+1)I <(2m+1)Q`. With b>=g, use the reduced denominator `D_out=2^(b-g)v^19`; no giant 2^g shift need be materialized. Although the live difference state is wider, the output numerator D_0=I has the sharper in-cell value bound. At b122,g100, output conversion uses an approximately501-bit-magnitude numerator and384-bit divisor, producing an approximately117-bit-magnitude quotient. Exact signed capacities and inequality endpoints remain part of the implementation.

Generation and checking differ here. A generator may perform division; a verifier given quotient/remainder can check multiplication and inequalities. The new final witness multiplies the rounded output by a divisor whose non-dyadic core can have362 bits. The old Horner multiplication round instead has a core of at most20 bits, repeated 19 times per unit, plus its addition-round checks. One new wide quotient witness is not automatically cheaper than those 19 narrow witnesses. This is a priority price to establish, along with wide initialization and additions. The same warning applies if the old comparator is the fused stage above.

## 4. Complete break-even inequalities

Choose an objective t: native generation, ordinary proof production, ordinary proof checking, or a specified sum of those. Give it its own prices at actual operand widths. In complex-coordinate accounting define:

- H_t: one complete old rational Horner stage, including its chosen rounds and witnesses.
- I_t: one exact wide-by-small initialization product; A_t: one wide addition/subtraction.
- P_t: one coefficient prescale; R_t: one final complex quotient/round certificate.
- G_t: all additionally charged geometry/cache binding, traffic, allocation and coverage costs for this block, with shared setup charged once globally.

Each complex scale represents two signed integer products and each complex add two integer additions. If prices vary with coefficient/order, use the explicit sum over stages; the uniform prices below are a declared bound/model, not a hidden equality between wide and narrow gates.

For the pruned block, replacement wins in that fixed charged model exactly when

    19U H_t > 19P_t+380I_t+(19L+380)A_t+U R_t+G_t.       (10)

Equivalently,

    H_t > R_t/19 + P_t/U +20I_t/U +(L+20)A_t/U +G_t/(19U).

For the screened whole-cell option replace L+20 by L+29. For U=0 there is no positive old work to save; omit the cell only after checking its empty unit manifest, or pay its cost in the unpruned reference. Short cells not admitted by the chosen option revert to old Horner.

This inequality immediately supplies the allowable final-round price:

    R_t <19H_t-[19P_t+380I_t+(19L+380)A_t+G_t]/U,

with the corresponding whole-cell alteration. A nonpositive right side rejects the pruned replacement irrespective of the final-round implementation. This is more useful than an unweighted count of saved multiplications.

Even with favorable occupancy, initialization is not asymptotically negligible on these short cells. L<=260. For an even-conductor cell of length260, U<=130, so its pruned contribution is at least `(2/13)I_t+(28/13)A_t+R_t/19`, before prescales and setup. The bound is illustrative and necessary, not an estimate of actual U. If all products were assigned the same price and all other costs ignored, unshared prescales change the necessary product-count condition from U>20 to U>21. That artificial screen is not sufficient for (10).

Use actual charged-schedule costs, or upper bounds on the new cost against lower bounds on the old cost for a robust conclusion. Subtracting two unrelated upper runtime bounds does not prove an improvement. A native winner is not automatically a proof-checking winner; all three objectives can be recorded separately.

## 5. Sharing, occupancy and the bounded next measurement

Geometry powers v^j, cell endpoints and unit masks can be cached across heights at fixed conductor/band. Prescaled coefficients and initial differences depend on the height's actual polynomial; their construction is not shared across heights. Same alpha anchors across conductors do not remove the conductor-dependent v and step. A single polynomial split into several blocks may reuse its prescales, but each block's initialization and complete target coverage must be priced.

The occupancy packet counts all integer positions, including nonunits. Its main R=59962061953248 unit inputs reproduce exactly19R=1139279177111712 old stages. Band1 contains between74.4% and74.5% of those inputs; bands1--2 together contain between92.6% and92.7%. Those are useful prioritization bounds, not removable-work fractions. The reference's necessary equal-stage-price screen passes only some conductor/band combinations. It supplies no per-bucket U distribution for an arbitrary trimmed hybrid.

A concrete policy can decide on exact metadata before generating differences: choose a bound-valid block partition, certify U and L, then test (10) using the chosen width-price table. For an interval, U can be checked from an existing unit manifest or exact inclusion-exclusion over the conductor's prime divisors; charge any new manifest work once with the geometry. Check all required units exactly once across selected blocks and fallback targets. Rejected candidates need no difference initialization if this test is purely metadata; any initialization or failed speculative computation actually performed must still be charged.

The highest-value missing prices are: (i) narrow old multiply/divide-round witnesses versus the new wide final witness; (ii) exact wide-by-small initialization and prescales at their varying sizes; (iii) carry/proof cost of521--523-bit additions and state transport; and (iv) the actual common b and cache/layout discipline. A timing-free ordinary-rule arithmetic design can settle some of these. No analytic coefficient evaluation is needed to formulate the screen.

The root's suggested Newton-basis initializer is a separate pending alternative. This framework deliberately retains the complete reviewed-candidate baseline; a proved replacement can substitute its exact initialization count and width bounds into (10). Its proposed counts are not credited before its proof and coverage/width contract are available.

## Evidence and limits

Owned scalar script `residue_difference_width_cost_checks_20261111.py`, SHA `B16550AA61FC7042F4A20159BFB1B9A883BA350AF7F029365A2D391C6FB32805`, and JSON `7405265DABED40E41D487E836F6CC2835883D568EB87F438574280589F67B9A0` pass739 exact width/count specializations. They bind V2, occupancy author/receipt and scaled-seed source `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`. No author generator or evaluator is imported. This does not independently re-audit either entire companion packet.

The older `CURRENT_SPECTRAL_OPERATION_BUDGET` supplies the typed Horner-versus-transform convention, not the current height-reduced totals. This note uses the frozen occupancy totals for the latter. Seed construction, character transforms, phases, height interpolation, strict signs, count closure, repairs and final proof assembly stay outside the proposed contraction replacement. No runtime, total proof-cost or spectral saving is established.
