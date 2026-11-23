# Exact finite differences for the existing residue polynomial — V2

2026-11-11. V2 corrects one sentence in section8: the 4C bound applies to supporting polynomial values, while differences carry the stated 2^j factor. The frozen predecessor C8E320260345661BAF41751B337E2D5CB415034CC0A3AB65EB4A32CD29B36A7F is preserved. Conditional finite arithmetic and paper error proof. No Hurwitz coefficients, elementary values, characters, primes, zeros or transforms were evaluated. No Lean declaration, source edit or build was made. This supplies a correct candidate circuit, not a runtime improvement or an accepted production receipt.

**Result.** For a block of at least20 consecutive numerators lying in one fine-alpha cell, the existing degree-19 polynomial can be evaluated using exact integer forward differences with denominator `2^b*(2c)^19`. After initialization, only integer additions and one final conversion per consumed unit residue are needed. The source coefficient/analytic errors are unchanged; final rounding costs at most the old per-gate `u_H`, rather than Horner's `(8/3)u_H` per residue. The integers can be much wider than Horner's operands. Short blocks and any block failing the complete cost test retain Horner.

## 1. Match the actual source polynomial

The scaled seed report, lines136–174, evaluates the first20 delivered coefficient centers at

    h = Dout*(alpha-anchor),  |h|<=1/4.

The first four output normalizations are `Dout=512,1024,2048,4096`; the final one is8192. The final source grid is4096, but its delivered coefficients are postscaled to8192: `JOINT_QUARTER_MESH_HEAD_TRADEOFF`, lines80–105. The m159 refinement changes the EM correction/remainder, not that delivered normalization. All current delivered centers have the conservative magnitude bound `2^16` from the cited source bounds. No unscaled derivative is used here.

Put `F=2Dout`, choose conductor `c>10000` in the selected family and a unit numerator `1<=a<c`, and set `alpha=a/c`. Fix ties toward the larger fine anchor by

    k = floor(F*a/c + 1/2) = floor((2F*a+c)/(2c)).

Then `anchor=k/F` is in[0,1], and

    (2k-1)c <= 2F*a < (2k+1)c,
    r(a)=F*a-k*c,   v=2c,
    h(a)=r(a)/v,    -1/4<=h(a)<1/4.                 (1)

Thus the denominator is **2c**, not `cDout`. The fine denominator F occurs in the numerator step. This tie convention is a legal specialization of the predecessor's nearest-anchor contract, which permits either endpoint at equality; an actual cache must use and bind this same convention.

The integer cell is exactly

    max(1,ceil((2k-1)c/(2F))) <= a
      <= min(c-1,ceil((2k+1)c/(2F))-1).             (2)

Its integers include nonunits. The old contraction consumes only units. The new circuit may step through intervening nonunits, but it may neither export them as unit inputs nor omit later unit targets. The half-open tie partition covers every required unit exactly once.

At one height and anchor let the exact stored complex centers be

    z_j=(n_j^re+i*n_j^im)/2^b,  0<=j<=19,
    P(h)=sum_(j=0)^19 z_j h^j.                     (3)

Here b is a checked common dyadic exponent, obtained by exact shifts from each coordinate's actual encoding. Source uncertainty remains attached to the original coefficient theorem. Aligning denominators is exact and adds no radius. This report does not replace that uncertainty by independent errors at each difference update. An optional b122 layout is discussed below; the theorem works for any admitted finite b.

## 2. Integer identity and initialization

Write d=19 and `Q=2^b v^d`. Treat the two coordinates independently, writing n_j for one coordinate integer. Define

    I(a)=sum_(j=0)^d n_j r(a)^j v^(d-j).             (4)

This is an integer polynomial in a of degree at most d, and its associated coordinate of P(h(a)) equals I(a)/Q exactly. This follows by multiplying (3) by Q. Signed r and signed coefficients require ordinary signed-integer arithmetic; absolute-value multiplication without the sign bridge is not the same circuit.

Choose a block `a0,...,a0+L-1` contained in (2), with L>=20. First form the19 nontrivial coefficient prescales `A_j=n_j v^(d-j)` for j<d; A_d=n_d. The exact powers `v^0,...,v^19` depend only on c and can be proved/cached across cells and heights. Their construction and cache access still cost work.

Evaluate (4) at the first20 block nodes using Horner with these A_j and the respective signed r(a). Each value costs19 integer multiplications by r and19 integer additions, per coordinate. These are wider numerator computations than the old rounded rational Horner gates; they are not priced as identical gates.

Let `Y_j^0=I(a0+j)` for0<=j<=19. Compute the triangular differences

    Y_j^(e+1)=Y_(j+1)^e-Y_j^e,
    D_e(0)=Y_0^e,  0<=e<=19.                       (5)

There are190 subtractions per coordinate. The standard finite identity, proved by induction using Pascal's rule, is

    D_e(0)=sum_(j=0)^e (-1)^(e-j) binom(e,j) I(a0+j).

It is the actual forward difference, not a claimed numerical derivative. Because (4) has degree<=19, its twentieth forward difference vanishes identically. This can be proved on monomials and extended by integer linearity; no analytic function evaluation occurs in this step.

## 3. Exact advance, skipped units and the finite endpoint

Before output at block position i, retain only orders

    0<=j<=min(19,L-1-i).

The invariant is `D_j(i)=Delta^j I(a0+i)` for every retained order. Output D_0(i)/Q only if that numerator is a required unit. A nonunit contributes no residue output but still advances the state.

To move from i to i+1, for

    j=0,...,min(18,L-i-2)

in **increasing** order perform `D_j <- D_j+D_(j+1)`. The higher slot still has its old value when read. The finite-difference identity `Delta^j I(a+1)=Delta^j I(a)+Delta^(j+1) I(a)` proves the new invariant. If order19 is still needed it stays unchanged because `Delta^20 I=0`. Discard orders which will no longer be needed; do not update them merely to retain a fictitious full state beyond the block.

This pruning is relevant to the width proof. Every retained difference uses values at points still inside the block, hence within the actual cell. No value at `a0+L,...,a0+L+18` is needed. No analytic estimate is extrapolated beyond[0,1] or beyond the cell. For L<20 this schedule is not used; ordinary Horner is the stated fallback, rather than twenty initialization points outside the admissible block.

The exact number of advance additions is

    sum_(i=0)^(L-2) min(19,L-i-1) = 19L-190.        (6)

Blocks may be trimmed to their first/last required units, partitioned further, or omitted if empty of units. Every trim or partition must be checked against the exact unit/cell manifest; the final theorem must cover each old required residue. Neither an omitted-word list nor a cell hash proves coverage.

## 4. Magnitudes and the price of exactness

If `|z_j|<=C`, then inside the cell

    |P(h)| <= C sum_(j=0)^19 (1/4)^j <4C/3.

With C=2^16 this is below2^17. The same bound controls both coordinate values. Therefore `|I(a)|<2^17 Q` at every initialization/live node and, by (5),

    |Delta^j I(a)| <2^(17+j) Q <=2^36 Q.            (7)

The bound uses the sum of absolute binomial coefficients, 2^j, and does not assume any cancellation in numerical errors. A raw addition/subtraction of these bounded operands is below2^37 Q. This uniform bound does not grow with L because higher orders are discarded before their support leaves the block.

The exact Horner initialization also fits a controlled width. Its intermediate after coefficient index j is

    sum_(e=j)^d n_e v^(d-e) r^(e-j),

whose norm is at most `(4C/3)*2^b*v^(d-j)`. The next raw product satisfies the same next-level geometric bound because |r|/v<=1/4. The prescaled coefficients fit `C*Q`. Thus initialization does not require an unbounded symbolic polynomial expansion. Its products have a wide integer factor and the small signed integer r, with |r|<=c/2.

At the current maximum c=265800, `(2c)^19` has exactly362 bits. Consequently a sufficient signed capacity is `b+399` bits for stored differences and `b+400` bits for addition temporaries. For b122 this gives521 and522 bits, respectively; Q has484 bits. The standard b122 seed-grid layout is a possible common layout only when the actual delivered centers are verified to lie on that grid or an exact coarser one. A finer center increases b and these widths. The finite theorem does not assert b122 for arbitrary future certificates.

This is the main tradeoff: old coefficient magnitudes are small, but the exact common denominator creates roughly360 extra bits. Wider additions, prescaling and final quotient checks may defeat product-count savings. Optional exact common-factor cancellation could reduce widths, but it is not counted in this baseline. The current family and F>=1024 imply a cell has at most260 integer points; this is a finite bound, not a promise of260 unit targets.

## 5. One final rounding and the unchanged actual-function interface

For each consumed coordinate choose a target dyadic exponent g. Let `m=floor(2^g I/Q+1/2)`. A concrete certificate checks

    (2m-1)Q <= 2^(g+1)I < (2m+1)Q.                 (8)

This rule handles negative integers and resolves ties toward positive infinity. It proves coordinate error at most `2^(-g-1)`. Applying it to both coordinates gives complex Euclidean error below2^-g. Common powers of two can be cancelled before constructing (8). If b>=g, compute m by division of I by `2^(b-g)v^19`; no large `2^g I` need be materialized. At b122,g100 this denominator has384 bits. The signed quotient/remainder or witness checks are still required.

Take g100. The new finite evaluation has error below `u_H=2^-100` per residue. It approximates exactly the same polynomial P of stored centers; it need not give the identical rounded center produced by the old Horner circuit. The original actual-function comparison remains

    actual Hurwitz value - exact finite center polynomial
      = inherited analytic target/shift remainder
        + inherited numerical coefficient/shift error.

Those terms are neither amplified through the exact differences nor charged again as fictitious difference errors. After the actual character sum and c^-s scaling, the new evaluation contribution is below633u_H. This replaces the old1688u_H bound, so both the first-four-band complete alpha bound and the final joint bound continue to hold with their original limits. The latter retains its separate analytic shift bias and delivered numerical eta radius. Additional argument approximation is unnecessary because (1) is exact.

Conductor powers, the character transform, elementary phases, interpolation in height, exceptional precision, strict signs and count completeness remain outside this replacement. No new spectral conclusion follows from proving the polynomial circuit.

## 6. Complete conditional cost comparison

Let U be the number of required units in a block of L consecutive integers. In complex-coordinate accounting, one block has:

| Work | Count |
|---|---:|
| Coefficient prescales, if not already cached for this cell/height |19 |
| Wide-by-small initialization scales |380 |
| Initialization additions |380 |
| Difference-triangle subtractions |190 |
| Advance additions |19L-190 |
| Final complex quotient/round certificates |U |

One complex scale means two signed integer products; one complex addition means two integer additions. Prescaling can be shared across multiple blocks of the same polynomial/cell/conductor/height, but not across different coefficient arrays. Geometry powers and residue/index data can be shared across heights with the same conductor/band; their proofs and access costs remain. The unmodified comparator is19U rounded real-times-complex Horner products and19U additions, including its actual exact-rational displacement and rounding implementation.

For one additive objective, write the new bound explicitly as

    setup_geometry + setup_binding + 19*C_prescale
      +380*C_init_mul +(19L+380)*C_wide_add
      +U*C_final_div_round + traffic,

with the prescale term charged once per admitted cache object. Compare it with the actual old Horner price for these same U outputs and the same source certificates. Use distinct generation, proof-production and verification prices when they differ. Degree19, unit sparsity, widths and ordinary proof construction must not be collapsed into one unweighted addition/product count.

Even ignoring width differences and setup, the20-point initialization prevents a multiplication-count win when U<=20 under this conservative method. U>20 is only a necessary first check, not a sufficient price comparison. Later bands can fail it entirely. A cheaper direct difference initializer would require a new costed identity; it is not assumed here. The separate occupancy study is not consumed before its frozen result exists.

Ordinary Lean or MM0 acceptance must prove (1)–(8), the concrete integer products/additions and coefficient/input bindings, and the exact output coverage. A native calculation, checksum or randomized polynomial test supplies none of those conclusions. A compact deterministic reconstruction may avoid serializing every difference state, but its checked computation and proof work still occurs. No arithmetic accelerator or new axiom is part of this plan.

## 7. Evidence and scope

`check_exact_residue_difference_20261111.py` checks all twenty monomial bases on three exact in-cell integer blocks, signed nearest-grid witnesses and the displayed integer widths/counts. It passes15,894 exact checks. These are polynomial-basis identities and synthetic integer rounding cases, not evaluated seed coefficients or analytic samples. The general proof is the finite-difference invariant above. The companion JSON retains six source/report hashes.

Owned script SHA256: `A33EB58C3D0ED9F6494142433C0B96F5D6FCBE58C919D4ECDE384018175DA099`.
Owned receipt `exact_residue_difference_20261111.json` SHA256: `9D38144A3343C2C3D1A84A83753B8010AB1219BDFD5403DB4C4B0FC488D6F330`.

Primary source interfaces read: `prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md:126,136–174`, SHA `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`; `major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md:78–105`, SHA `AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F`; `zero-sum/R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md:35,100` for nearest ties and cross-conductor non-reuse; and the reconciled schedule's sections2–4 for the actual five output grids. All full pins are in the receipt. The new result is a conditional finite circuit/error theorem at those interfaces, not kernel validation or a production saving.

## 8. A screened all-bucket variant, including short endpoint cells

The preceding circuit is the long-block, pruned-state option. There is a separate conservative variant matching the newly frozen occupancy reference's20 initial values per nonempty cell. It permits polynomial-only initialization outside that cell, under the additional **checked guard c>20F**. No analytic continuation estimate outside the cell is needed for those integer calculations.

The occupancy author `prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md`, SHA `99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1`, uses ties toward the smaller anchor, not section1's convention. To consume its actual bucket manifest, instead set

    k_down=floor((2F*a+c-1)/(2c)),
    (2k_down-1)c < 2F*a <= (2k_down+1)c.

Then h lies in `(-1/4,1/4]`, with the same r, v and absolute bound. The exact cell endpoints are `lo=max(1,floor((2k_down-1)c/(2F))+1)` and `hi=min(c-1,floor((2k_down+1)c/(2F)))`. All identities and bounds above remain valid with this alternative tie rule, but the actual anchor and coefficient cache must bind k_down. Do not combine a ties-up coefficient selection with a ties-down residue manifest. Untrimmed bucket-length and unit-count totals also correspond by reflection a->c-a, k->F-k, but that counting bijection does not identify the underlying coefficient vectors or excuse mismatched bindings.

For any physical numerator a in its chosen cell and 0<=j<=19,

    |h(a+j)| <=1/4+19*Dout/c
                <1/4+19/40=29/40<3/4.              (9)

Thus every polynomial value used in initialization or in the support of a live full difference is bounded by `4C`; the integer difference of order j is bounded by `2^j*4C*Q`. These values can correspond to alpha outside the anchor cell or even outside[0,1] at an endpoint, but they are values of the finite polynomial (3) only. The actual-function approximation is consumed exclusively at the original in-cell unit targets. Claiming the Hurwitz error at the extra initialization nodes would be unjustified and is unnecessary.

Initialize20 values by (4)–(5) even when L<20. Keep all20 orders and perform19 ascending additions at each of the L-1 advances. The exact degree bound proves the invariant as before. With C=2^16, live differences are below2^37 Q and raw addition temporaries below2^38 Q, giving one extra signed bit compared with section4:522 and523 bits at b122 and the maximum conductor. Initial Horner magnitudes use the geometric factor4 instead of4/3; r at those auxiliary nodes may be larger than c/2 and must receive its own bound `|r|<3c/2`. All those setup products remain priced.

Per nonempty bucket the complex-coordinate counts are19 prescales,380 initialization scales,380 initialization additions,190 triangle subtractions,19(L-1) advance additions, and U final conversions. The total addition/subtraction count is `19L+551`. This variant is more expensive in additions than the pruned long-block option, but it has a direct all-bucket reference. It even pays initialization in a bucket containing no units unless a separate checked pruning rule changes that reference.

The occupancy screen `phi(c)>20B_c`, where B_c counts every nonempty integer bucket, implies the guard: if c<=20F, each bucket has length at mostceil(c/F)<=20, so `phi(c)<=c-1=sum lengths<=20B_c`, a contradiction. This implication uses no assumptions about the distribution of units within cells. It does not prove a cost win. The author reports that the necessary screen selects some conductors in the first two bands and none in bands3–5 under its reference; its global metadata review is separate. The present theorem applies whenever c>20F is checked, regardless of the screen or its cost interpretation.

`check_screened_residue_difference_20261111.py` supplies11,227 additional exact polynomial/witness checks, including ten-node endpoint blocks with twenty polynomial initial values and the unchanged full-state recurrence. Its cases use the common absolute geometry and do not establish an actual coefficient table. Script SHA `E25D5B12A5DEE0273B2FB82340D7C3D55A4E6FF0CBEA9D00BEF6786FA82B359B`; receipt `screened_residue_difference_20261111.json` SHA `B3658790344899BE28DB5B9CBD00793084152418E0DDA74674B521879E4556D5`. Both alternatives preserve the same final-round and source-error theorem. Neither supplies a new aggregate saving, and their counts must not be interchanged.
