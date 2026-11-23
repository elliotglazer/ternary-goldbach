# Independent review: mixed-radix intermediate widths

2026-11-11. **PASS for the stated conditional paper bounds and integer metadata. No correction requested.** Reviewed author report `independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md`, SHA256 `5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A`, in full, together with its script/receipt and the accepted precision supplement/review.

The conclusion is that both circuits admit the same conservative absolute-error precision and a common peak-width allocation under which mixed radix needs no extra integer bit. It does not prove that each mixed gate is smaller than a corresponding baseline gate, that optimized peak widths satisfy the same ordering, or that the operation-count advantage yields a measured runtime improvement. Root construction and arithmetic proof costs remain separate.

No roots, transforms, character or L-function values were evaluated. No source edit or Lean build was made. A new independent script reconstructed integer schedules, peak bounds and conductor layouts without importing or executing the author script; all comparisons passed.

## 1. Shared precision and the augmented variable

The prerequisite error theorem concerns positive unnormalized D_n, with normalized error bounded by C_n*u*(L+1) on exact stored inputs of norm<=L. I checked that the author does not mistake this for an actual division by n. The only computed transform normalization here is Bluestein's inverse division by P.

The shared u must satisfy the old schedule's dyadically rounded safety requirements and S_old*u<=1/2. The accepted precision comparison proves both the mixed local safety constraints and S_mixed<=S_old. Descendant C values do not exceed their ancestor C; Bluestein's internal radix coefficient is also covered. Thus C_n*u<=1/2 at every child. Every actual conductor layout has a nontrivial axis with C_old>=6, so u<=1/12; the weaker u<=1/3 used below is valid. An empty identity transform, if added outside this inventory, is an exact separate case rather than an excuse to divide by S=0.

For |z|+1<=aV, V=B+1>=1, a>=1, the semantic output bound is

    |computed D_n(z)|+1
      <=nL+nC_n*u*(L+1)+1
      <=n(1+C_n*u)*(L+1)
      <=(3/2)n*aV.

The middle inequality pays n-1>=0. It is a bound on the final child output only. The report correctly proves separate peak recurrences instead of using this semantic bound on internal FFT values.

If B bounds true values instead of stored centers, replacing B by B+E0 is necessary and explicitly retained. Similarly the unit-root error and arithmetic-gate error are separate complex-norm contracts; coordinate-wise u errors would not automatically satisfy them.

## 2. Internal peaks, including the Bluestein inverse

For a radix-two stage, |next|<=(2+u)L+2u implies

    |next|+1 <=(2+u)(L+1)

because u<=1. Under 2ku<=1, (1+u/2)^k<=2, so every stage peak is <=2n*aV. The exact root-product operand norm product is covered by the same next-stage bound. Direct-r leaves obey the stated partial-sum inequality: the required final comparison reduces to (r-2)u<=r-1. This is valid for the selected r>=3 and u<=1; K_direct=2r also includes coefficients and product intermediates.

For CT n=rm, the m child comes first. Its small semantic output is at most m(1+C_m*u)aV in augmented norm. The cross twiddle plus its rounding maps an augmented bound H to at most(1+u)H. Hence the r child receives at most2m*aV, giving

    K_CT=max(K_m,2m*K_r).

Both child peaks and the cross-twiddle product are included. Using K_m itself as the first child's output would be safe but much more expensive; using its semantic final output here is justified.

For Bluestein, let m=2n-1 and P the least power of two >=m. The accepted error proof gives e_F<=PAu*aV and e_K<=PAu with PAu<=1. Therefore stored data-transform norm <=(n+1)aV and stored kernel norm <=2n. The kernel is never treated as a unit coefficient. The rounded point product has augmented norm at most

    Z*aV,    Z=2n(n+1)+2.

Applying every unnormalized inverse stage before division gives peak <=2PZ*aV. This is the decisive missing scale in an incorrect final-output-only estimate. Both the forward data peak2P(1+u)aV and the kernel-construction peak2P(2+u) fit inside it. After division by P and possible rounding, augmented norm <=(2Z+2)aV; the last chirp raises this to at most(1+u)(2Z+2)aV<=2PZ*aV. Here n>=2 gives P>=4 and Z>=14, making the last inequality safely strict under the stated u bound.

Thus K_Blue=2PZ=4P(n^2+n+1) covers cached setup values, point products and all inverse values before normalization. Imported caches still require their accepted error/magnitude certificate. Root-enclosure construction is not part of this peak theorem.

## 3. Induction and conductor uniformity

For a proper split n=rm, r,m>=2, P_m<=P_n and2P_r<=P_n. The latter follows from comparing the least dyadic ceilings of2r-1 and2rm-1, not from assuming the padding lengths multiply. Consequently

    2m*K_r <=4P_n*m(r^2+r+1) <=4P_n(n^2+n+1),

with exact nonnegative difference

    n^2+n+1-m(r^2+r+1)=(m-1)*(r^2*m-1).

Together with the first-child bound this proves the recursive comparison. Power-of-two axes are identical in both schedules, direct small leaves are bounded by Bluestein, and retained Bluestein leaves are unchanged.

Across outer unit-group axes, the product of prior semantic factors satisfies product(1+C_i*u)<=2 because their sum is <=1/2. Therefore incoming augmented norm <=2*v_before*V. The common conductor coefficient max(1,max_axes 2*v_before*K_axis) includes every axis and cache. Applying the factor2 to the first axis is conservative. The pointwise conductor comparison is not inferred merely from comparing global maxima at two different conductors.

## 4. Stored versus exact intermediate integer widths

Fix actual common grid2^-p and V<=2^b, with integer b>=0. For q=ceil(log2 K(c)), a stored coordinate numerator is bounded using |coordinate|<K(c)V<=2^(b+q). The proposed signed width p+b+q+2 is sufficient. This is an absolute fixed-point statement, not a relative-mantissa statement or an arbitrary-exponent representation bound.

I checked the stronger product claim against the circuit cases. Root products are bounded by their next-stage envelope; data/kernel products use the independently bounded nonunit kernel; CT and final-chirp products are included above. Thus each complex operand norm product is <=K(c)V, although bounding two arbitrary stored values independently would only give its square. The exact real products have denominator2^(2p) and magnitudes <=K(c)V. Exact real/imaginary combinations are also controlled (even the crude sum of two product magnitudes suffices), so the signed width

    2p+b+q+2

is safe. Treating those products as having only p fractional bits before a proved rounding would be invalid; the report does not do so.

For a three-real-product complex identity, each presum is bounded by twice the corresponding operand norm. The largest product is bounded by4 times their norm product and successive subtractions by6 times it. Widths p+b+q+3 for presums and2p+b+q+5 for product/subtraction temporaries are sufficient. Intermediate rounding inside this alternative real formula is not licensed by these size bounds; it requires a separate proof of the complex-gate error<=u.

These widths do not automatically bound every integer in a rounding witness, rational root-generation algorithm, serialization conversion or proof backend. The author expressly charges those tasks separately. The result removes an unaccounted circuit-value width increase from the shared-maximum-width comparison; it is not an end-to-end cost measurement or a universal bound on arbitrary implementation helpers.

## 5. Independent metadata replay

The new checker uses a linear least-prime-factor sieve, a closed-form radix count, separately written CT cross-root classification, and recursive integer peak evaluation. It reconstructs the exact canonical schedule hash

    fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b.

It compares all13943 axis rows, all37117 active nodes and all149999 conductor layouts in the author's R150000 inventory. Every axis/conductor inequality, both saving histograms, all example rows and both global maxima agree. The maxima are94362403055075328 at149993 for the baseline and11775570184503296 at149867 for mixed radix. Their ceiling-log2 widths57 and54 are consistent, but the independent pointwise checks—not those two global values—establish the per-conductor comparison. No R138000 or R135000 inventory is silently substituted; restriction to a subfamily inherits the inequality.

This replay validates integer specialization of the paper recurrences and schedule selection. It does not evaluate a transform or prove the actual root/gate inputs.

## Frozen pins and final scope

All paths are relative to `work/qrh-campaign/agents/`.

|Artifact|SHA256|
|---|---|
|`independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md`|`5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A`|
|`independent-feasibility/mixed_radix_width_metadata_20261111.py`|`CA571F8B74849F3F70EE2DA8867D1AD212B8D3140B2D7CE3E448001B3836DE24`|
|`independent-feasibility/mixed_radix_width_metadata_20261111.json`|`364B00C1BA63A06CC5B1C3E0CC777280151BB05E0E5B56063231596B0249B48F`|
|`zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`|`4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`|
|`audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`|`1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537`|
|`major-constants/review_mixed_radix_width_20261111.py`|`11D769B0B1CCC728618A36F6BDB40ED2104F816733E8A9B662FDF3A14346B912`|
|`major-constants/review_mixed_radix_width_20261111.json`|`E96ECBC83E6433CC60D66CC10A42568A9D5AEB2705F442B8A31C467DB16A1E4B`|

The operation savings can be paired consistently with this common conservative precision/peak allocation. No hidden normalization or cached-kernel peak invalidates that particular comparison. Actual per-gate widths, multiplication algorithms, root/cache generation, rounding witnesses, proof-DAG reuse, proof serialization and storage traffic must still be priced before selecting an end-to-end Lean/MM0 implementation. No native trust extension or provider validation is inferred.
