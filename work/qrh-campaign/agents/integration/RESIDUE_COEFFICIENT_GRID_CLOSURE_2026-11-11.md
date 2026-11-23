# A concrete coefficient grid for exact residue differences

2026-11-11. Paper/source representation closure and exact rational metadata only. No coefficient, Hurwitz, elementary, prime, zero or transform values were generated. No build, source declaration or frozen artifact was changed.

**Result:** the inherited norm-error interfaces alone do not force every supplied coefficient center onto grid2^-122. A compatible nearest-grid implementation can enforce it, but a checker must establish that representation. More economically, an explicit optional requantization of the20 delivered centers to grid **2^-100**, followed by the reviewed exact finite-difference evaluation and final grid2^-100 rounding, fits the existing evaluation allowance. It changes the center polynomial and pays that change separately. The existing first-four-band alpha error below2^-82 and final-band error below `.16*2^-82` are preserved.

## 1. What the selected sources actually specify

The scaled-seed report `SCALED_HURWITZ_EM_SEED_PRECISION`, line71, says a nearest common coordinate grid of step u suffices for complex error u; its inner u is2^-122. Its final head-plus-endpoint addition is rounded at line104. At lines136–156, the midpoint loop uses exact half scaling and a complete-update norm error u_T=2^-110. The actual error theorem does not require every arbitrary center satisfying that norm bound to have denominator dividing2^110.

The joint final seed has the same issue. `JOINT_QUARTER_MESH_HEAD_TRADEOFF`, lines80–105, postscales the source coefficients to normalization8192, then pays a final u_C=2^-110 round. It specifies the arithmetic/error contract but does not prove grid membership for arbitrary supplied records. The m159 refinement preserves this output interface. A center on a finer dyadic grid can satisfy every radius while failing a proposed b122 denominator test.

One valid future specialization is to use nearest coordinate grids2^-122 at inner/final source gates and2^-110 at shift/output gates, retaining exact dyadic shifts between them. The delivered first20 coefficients then lie on grid2^-122: coarser dyadic grids embed exactly in it, and any final postscale is followed by the stipulated output-grid round. This is an implementation choice and a finite membership theorem to check, not a consequence of an absolute error bound alone. No actual coefficient records presently establish it.

The following adapter avoids depending on that choice. It accepts the original exact centers with their actual encodings and inherited source theorem, constructs a new explicitly grid-bound array, and records its error. It does not claim equality with the old centers.

## 2. Exact requantization and its separate polynomial error

Fix one delivered array `z_0,...,z_19` at a source-bound height and fine anchor, with output normalization Dout. For an integer b>=0, round each real and imaginary coordinate to the nearest multiple of2^-b, ties toward positive infinity, and call the resulting exact dyadic centers `z'_j`.

For an exact coordinate x=N/Q with Q>0, certify integer m by

    (2m-1)Q <= 2^(b+1)N < (2m+1)Q,
    x'=m/2^b.                                      (1)

It follows that the coordinate error is at most2^(-b-1); the complex norm error is below2^-b. If the input coordinate is already dyadic, cancel powers of two before checking (1). Inputs on a coarser compatible grid convert exactly. All numerator/denominator, sign and tie checks remain ordinary integer arithmetic, with their actual input sizes charged.

The two exact finite polynomials are

    P(h)=sum_(j=0)^19 z_j h^j,
    P_b(h)=sum_(j=0)^19 z'_j h^j.

For every consumed in-cell argument |h|<=1/4,

    |P_b(h)-P(h)|
      <= sum_j |z'_j-z_j||h|^j
      < (4/3)*2^-b.                               (2)

This is a new center-quantization error, separate from the original coefficient errors, source/EM approximation, analytic shift bias and target Taylor tail. No independence of errors is assumed. After the existing actual c^-s character normalization its contribution is below `844*2^-b`, using the same amplification633. The input polynomial and new polynomial must be different named objects in the certificate unless exact coordinate equality is actually proved.

The finite-difference circuit computes P_b exactly until final output rounding. Its initialization at extra polynomial-only points in the screened variant does not require (2) outside the cell: the actual-function comparison is made only at the original in-cell unit targets. Exact computation introduces no intermediate numerical error to propagate.

## 3. Select b100 with final output g100

The reviewed original evaluation allowance is `(8/3)u_H` per residue, hence `1688u_H` after character normalization, with u_H=2^-100. Exact differences followed by one nearest coordinate-grid2^-100 output round have complex error below u_H. Choosing b100 gives

    new per-residue evaluation error
      < (4/3)u_H + u_H = (7/3)u_H < (8/3)u_H;

    new character-summed evaluation error
      < (844+633)u_H = 1477u_H <1688u_H.             (3)

The explicit reserve is211u_H. Thus this adapter replaces only the old polynomial-evaluation part of the budget. It needs no weakening of the inherited alpha target and no new analytic estimate.

For mixed schedules, a finite-difference block uses the quantized array plus (3); an ordinary Horner fallback can continue using the **original** array and its original allowance. The per-residue bounds then compose under the same character-sum estimate. Do not run an unchanged Horner circuit on the b100-quantized centers and still claim (3): that would pay its own rounding in addition to the quantization error. Such a different fallback would need a separate allocation. Retaining the original-center reference for the stated fallback avoids that change.

The first-four-band bound remains

    E_target + E_shift +2532eta +633*330*2^-110 +1477*2^-100
       <2^-82,

where eta=2^-100 and the same reviewed P27 tails are used. The ratio to2^-82 is exactly

    10040125123354348844960520791
      /32076363635089380005973590016 <1/3.

The final joint band retains its separately proved delivered numerical coefficient error and analytic shift bias. Its bound is

    1266*(7020/(4*8192))^20/20!
      +1266*(5*7028/(8*4096))^28/28!
      +(844+1477)*2^-100 < (4/25)*2^-82.             (4)

The m159 change does not alter these target/shift or normalization formulas. The companion exact receipt checks (4) and preserves the original bound with1688 for comparison. This does not relabel the first-four coarse eta as a uniform radius for all translated fine coefficients; their inherited weighted propagation is retained.

## 4. The finer b122 variant also closes directly

If b122 is desired for another consumer, (2) adds less than844*2^-122 after the character sum. Even **keeping the entire old1688u_H evaluation allowance**, the exact first-four ratio rises only to

    10065943449089742893525837399
      /32076363635089380005973590016 <1/3.

The old final ratio is below151867/10^6. Adding844*2^-122 still leaves it below151867/10^6<4/25; the receipt retains the exact rational margin, not a floating-point test. Thus b122 can coexist with the old evaluation allowance. Using exact differences and the smaller633u_H final-round allowance gives still more slack.

This finer variant establishes the originally requested grid closure, but it is not the selected width comparator for finite differences. The simpler b100/g100 allocation already fits (3). No attempt is made here to optimize b99 or to trade coefficient precision against a different final grid.

## 5. The coefficient magnitude and concrete integer widths

The magnitude bound must survive the new rounding. It is insufficient to add a tiny error to the statement `|z_j|<2^16` without a quantified margin. The actual source proof provides one: the general scaled construction has `|z_j|<4C+1<=40665`, and the selected first four bands have the stronger bound20661. The joint final construction gives27043. After requantization at either chosen b, the centers therefore have magnitude below40666 or27044, respectively, both strictly below2^16.

Consequently the exact finite-difference width theorem applies unchanged with C=2^16 and now a **guaranteed** coefficient grid. At c<=265800, `(2c)^19` has at most362 bits:

| Grid and final round | Long/pruned live signed bits | Long/pruned addition bits | Screened/full live bits | Screened/full addition bits | Final cancelled divisor bits |
|---|---:|---:|---:|---:|---:|
|b100, g100|499|500|500|501|362|
|b122, g100|521|522|522|523|384|

At b100 each coordinate coefficient numerator fits117 signed bits. The common denominator is `2^100*(2c)^19`; its power-of-two part cancels in the final grid100 rounding, leaving the divisor `(2c)^19`. The polynomial numerators, initial prescales, exact differences and final quotient witnesses still use the wide bounds. This does not make them as cheap as narrow Horner arithmetic.

The selected source centers can be on a finer input grid. Their requantization must read/check the actual input representation; an arbitrary huge numerator does not become cheap merely because its output has117 bits. A future producer that emits the guaranteed grid directly can avoid this separate conversion only through an explicit implementation/grid theorem and a corresponding error proof.

## 6. Cost and cache binding

Charge20 complex coordinate-round operations, equivalently40 real rounding/witness operations, for every distinct coefficient array actually requantized. This charge includes the required error/grid certificate, not just writing the new mantissas. Also charge decoding, exact shifts/divisions and the proof/data references. If grid membership is already proved, the conversion can be the exact identity, with its actual binding/check cost rather than an invented numerical round.

A cache object binds the original20 exact centers and their source theorem, height s, fine anchor k/F, output normalization Dout, band/analytic scope, original encoding, b, tie rule for coordinate rounding, the20 new centers and all inequalities (1). The nearest-alpha tie convention is a separate geometry field: the occupancy adapter uses ties down, while coordinate requantization uses ties toward positive infinity. These rules must not be conflated.

The quantized array can be shared across conductor consumers only when they refer to this same actual height/anchor/normalization/coefficient object. Different conductors have different target displacements but can consume one shared fine-anchor array. The charge is once per retained cache object, not automatically once per conductor bucket and not free after eviction/reconstruction. The conductor-dependent prescales by `(2c)^(19-j)` remain separate and cannot use this sharing to equate different c.

Only arrays selected for the new circuit require this conversion. The original Horner fallback retains its original array/reference. The current operation ledger has not yet been changed by this report; any successor must add actual requantization counts and cache lifetimes before claiming an end-to-end saving. The new widths are sufficient price inputs, not measured memory or proof throughput.

## 7. Frozen evidence

The predecessor exact circuit is `EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md`, SHA `691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025`, independently reviewed at `audit/REVIEW_EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_2026-11-11.md`, SHA `A21A7B16BFF97898E0D6C8F1FFBB3D39C231C1553BE2B9CF77B8770F5819261D`.

Source pins read: scaled seed `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`; joint final seed `AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F`; selected P27 `579AAEC28BD4C1DB8FB83F3CDB1E4782160D3D35FA8AB2B8DC83BFF956ACBCD1`. The m159 source and full paths/hashes of all six inputs are retained in the receipt.

Owned exact script `residue_coefficient_grid_closure_20261111.py` SHA `75E355AC1E89ADB76D1B9F2254C74E35C818852E9BE67B8504EFF4CBE0B84B93`; receipt `residue_coefficient_grid_closure_20261111.json` SHA `28206373F718F044394C5E2E34C193B300BECA3416FFC523E10AAA333565E0DE`. It passes1915 exact grid/error/width checks using rational envelopes and synthetic integer rounding witnesses. No actual coefficient data or analytic evaluations are present. The result closes this conditional representation interface, not numerical certification, implementation or kernel acceptance.
