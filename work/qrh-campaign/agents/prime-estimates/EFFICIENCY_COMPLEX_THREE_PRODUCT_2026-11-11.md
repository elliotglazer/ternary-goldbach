# Three-real-product complex gates with explicit errors

2026-11-11. Symbolic algebra and integer proof-template sizing only. No analytic coefficient, transform, L-function, modular value or benchmark was evaluated. This is a local gate replacement and cost model, not a complete precision proof for the mixed-radix transform or a promise that a frozen output box remains accepted.

## Result

The proposed fixed-coefficient identity is exact. For z=a+ib and w=c+id, put

    t=c(a+b),  u=b(c+d),  v=a(d-c).
    Re(zw)=t-u,  Im(zw)=t+v.

It uses three real products and three runtime additions/subtractions if c+d and d-c are cached. Their two setup additions and storage must be charged. The ordinary four-product method uses four real products and two runtime additions. General Gauss multiplication uses three products and five additions.

The cleanest bounded-common-grid implementation computes the center arithmetic exactly and rounds only the two final coordinates. All three identities then have the same exact center and the same final-rounding error. The three-product paths need at most one or two extra raw product bits, not a new analytic assumption. With rounding at every gate, the formulas below retain all additional errors. Arbitrary signed-exponent dyadics do not automatically admit cheap exact pre-sums; the compact rounded-sum fallback remains necessary.

## 1. Exact identities and branch choices

The four-product reference is

    R=ac-bd, I=ad+bc.

General Gauss multiplication computes p=ac, q=bd, t=(a+b)(c+d), then R=p-q and I=t-p-q. Expansion proves both coordinates. The fixed-coefficient identity in the introduction follows because c(a+b)-b(c+d)=ac-bd and c(a+b)+a(d-c)=ad+bc.

One may instead pivot on d:

    t=d(a-b), R=t+a(c-d), I=t+b(c+d).

This can reduce the rounded-pre-sum error when |d|<|c|. The two cached sums are the same up to sign. The pivot and signs must be part of the actual checked circuit; no approximate-angle branch is needed. A wrong sign d-c versus c-d changes the imaginary coordinate and is rejected by the symbolic check in the companion script.

The source complex-product definitions are Mathlib Basic/Complex/Basic.lean, mul_re:215 and mul_im:219. The new identities follow from real distributivity. In ordinary PA the signed dyadic version needs explicit sign/magnitude or integer-encoding bridges; the natural-number multiplication templates alone do not prove signed subtraction.

## 2. Separate input/coefficient uncertainty from center arithmetic

Let actual z and w lie in rectangles centered at a+ib and c+id, with component errors alpha,beta and gamma,delta respectively. A common exact-center product has input-error bounds

    E_R=|c|alpha+|a|gamma+alpha*gamma
          +|d|beta+|b|delta+beta*delta,
    E_I=|d|alpha+|a|delta+alpha*delta
          +|c|beta+|b|gamma+beta*gamma.

These bounds hold for any of the three algebraic circuits. In the uniform rectangle case alpha=beta=r_z and gamma=delta=r_w, both are bounded by

    (|c|+|d|)r_z+(|a|+|b|)r_w+2r_z*r_w.

Do not treat a component radius as a Euclidean radius without conversion. For genuine complex norm balls, the familiar bound |w_center|r_z+|z_center|r_w+r_z*r_w applies instead. Add the separately derived arithmetic errors to the appropriate component bounds, then round each final radius outward. The radius calculation and final endpoints need their own exact dyadic checks.

Stored c+d and d-c should be derived from the same stored c,d used in this error decomposition. If they are independently approximated analytic values, their finite residuals from those stored-center sums must still be certified. Correlation or an expected trigonometric identity is not a reason to set the residual to zero.

## 3. Exact pre-sums and final-only rounding

Suppose a,b share a binary grid, as do c,d, and their signed mantissas have at most p and q bits respectively. Then a+b and c+d or d-c need at most p+1 and q+1 mantissa bits. Exact arithmetic gives:

- four-product path: four products with at most p+q raw bits;
- fixed path: three products with at most p+q+1 raw bits;
- Gauss path: two products with at most p+q bits and one with at most p+q+2 bits.

Final addition/subtraction capacity must also be supplied. A safe temporary may be one bit wider again; the exact resulting center has the usual complex-product bound. If only the final R,I are rounded with certified errors r_R,r_I, the total rectangle error is E_R+r_R and E_I+r_I, regardless of which exact identity was used. This avoids an artificial precision penalty from internal cancellation.

This implementation does not require huge rational denominators: it operates on signed mantissas and exponent sums. But it does require the stated grid/alignment bound. If a and b have an enormous exponent separation, materializing their exact common denominator is precisely the path the compact-dyadic plan forbids. Either certify a bounded alignment, use a bounded rounded pre-sum with the next section's errors, or retain the four-product path. Merely saying that addition is exact does not establish a scalable representation.

## 4. Per-gate rounding, including cached-sum errors

Every error below is an absolute real bound around an exact operation on the stored centers. A nearest-grid rule of spacing h gives error <=h/2; directed endpoint rounding has its corresponding one-sided h bound. The existing signed-floor witness plan handles negative inputs and ties. The algebra does not assume a particular rule as long as its stated bound is checked.

### Four products

If ac,bd,ad,bc have arithmetic errors e_ac,e_bd,e_ad,e_bc and the output additions have errors e_R,e_I, the center errors are

    G_R<=e_ac+e_bd+e_R,
    G_I<=e_ad+e_bc+e_I.

With a common bound epsilon this is 3epsilon in each coordinate.

### General Gauss path

Let U=a+b, V=c+d. Their rounded versions have errors e_U,e_V. Let the product errors of p,q,t be e_p,e_q,e_t, and the final subtraction errors be e_R,e_1,e_2. Then

    G_R<=e_p+e_q+e_R,
    G_I<=|U|e_V+|V|e_U+e_U*e_V+e_t+e_p+e_q+e_1+e_2.

When both pre-sums are exact and all other errors are <=epsilon, this gives (3epsilon,5epsilon). Halving that arithmetic epsilon is sufficient to fit the four-product method's 3epsilon allowance. With all pre-sums also rounded to epsilon, the imaginary error is at most (|U|+|V|+5)epsilon+epsilon^2. It is not universally 5epsilon.

### Fixed coefficient path

Let the stored cached values satisfy

    |C-(c+d)|<=eta_C,   |D-(d-c)|<=eta_D.

Let a+b be computed with error e_s. Let t,u,v have product-rounding errors e_t,e_u,e_v and the two outputs have errors e_R,e_I. Then

    G_R<=|c|e_s+e_t+|b|eta_C+e_u+e_R,
    G_I<=|c|e_s+e_t+|a|eta_D+e_v+e_I.

These formulas prove that exact pre-sums and exact cached sums recover 3epsilon per coordinate, matching the four-product reference under the same absolute product/output error. A rounded cached sum contributes its radius times the actual input magnitude; it is not just another epsilon. The alternative d-pivot replaces |c| by |d| and changes the indicated input factors appropriately.

For a concrete sufficient allocation, suppose |a|,|b|<=A, |c|<=B and target arithmetic error E>0 in each output. Choose

    e_s<=E/(8 max(1,B)),
    eta_C,eta_D<=E/(8 max(1,A)),
    e_t,e_u,e_v,e_R,e_I<=E/4.

Each output then has error <=E/8+E/8+3E/4=E. Choose dyadic radii below these rational allowances and prove the finite rounding inequalities. This works for nonunit coefficients as well. It does not allocate the independent input/coefficient rectangle errors E_R,E_I, which must be budgeted separately.

Cancellation can make a final coordinate arbitrarily small, so none of these absolute bounds gives a uniform relative error or a guaranteed nonzero sign. Conversely, a fixed p-bit floating mantissa does not give the same absolute epsilon at all intermediates. With |a|,|b|<=A and |c|,|d|<=B, fixed-path products can reach 2AB and the Gauss t product can reach 4AB. One or two guard bits may therefore be needed if comparing a relative-rounding implementation with the old path. Such a guard-bit cost is absent only when an exact-center implementation or an explicit absolute-grid budget justifies that claim.

## 5. Unit roots, cached Bluestein kernels and genuine variable products

The current mixed-radix inventory counts all general complex products in one G category, while retaining additions A, quarter turns Q, sign negations N and dyadic scalings S separately. Its actual Cooley--Tukey cross twiddles, direct-prime coefficients, radix-two twiddles and chirps are fixed unit roots. Their stored centers need not have norm exactly one; their certified coefficient errors still enter section 2.

Bluestein is different. The selected algorithm caches the kernel FFT once per length and precision. Its P pointwise products are therefore products by fixed cached coefficients, not necessarily fresh variable-variable products. They can use the fixed-coefficient identity and cache C,D, but the coefficients are not unit roots. The exact unnormalized kernel transform has norm at most 2n-1 because its input has 2n-1 unit chirps. The certified FFT/setup error enlarges the stored-center bound. Treating these products as unit twiddles would understate both error and intermediate size.

If another implementation recomputes both pointwise operands from uncertain data, use the genuine variable-variable Gauss model and both input-error terms. A cached coefficient remains uncertain but can still be precomputed once; "fixed" here means independent of the current transform input, not exact or radius zero. The cached C,D precision may need to be chosen for the largest input magnitude among all consumers. Changing precision or rescaling data can invalidate an old cache budget.

The frozen count report's large-conductor schedule has G=3041383327064694 and A=6301213142003526. No new family inventory was run here. Split symbolically G=G_f+G_v into fixed-coefficient and genuine variable-variable products. Then the real arithmetic counts change from

    four-product reference: 4G products, 2A+2G additions,

to

    three-product mix: 3G products, 2A+3G_f+5G_v additions,

plus two setup additions per distinct fixed coefficient whose cached sums are used. The extra runtime additions are G_f+3G_v. Q,N,S stay separate and must not be multiplied by this replacement factor. This is a symbolic mapping, not a claim that the complete transform is 25 percent faster. Root generation, kernel FFT setup, memory, permutations, normalization and all other proof work remain.

## 6. Ordinary-PA and Lean arithmetic costs

For the PA digit-product skeleton use M(n,m)=5nm+2 min(n,m)+1, orienting the shorter side as the row count. If equal signed input magnitudes have at most p bits, n=ceil(p/b) and n_plus=ceil((p+1)/b), the product-only costs are

    four: 4M(n,n),
    fixed: 3M(n,n_plus),
    Gauss: 2M(n,n)+M(n_plus,n_plus).

These formulas count unsigned magnitude products only. Sign proofs, comparisons, exact signed additions, rounding witnesses and numeral conversions must be added. A positive-natural adder count cannot automatically be assigned to an arbitrary signed subtraction.

At byte radix the exact skeletons are:

| Input magnitude bits p | Four-product events | Fixed three-product events | General Gauss product events |
|---:|---:|---:|---:|
|128|5252|4179|4106|
|192|11716|9147|9034|
|256|20740|16035|15882|
|512|82436|62787|62474|
|1024|328708|248451|247818|

Gauss can have a slightly smaller product skeleton than the fixed identity because only one of its products has both grown operands; it also has two more runtime additions. The cached fixed path is therefore not automatically best even before rounding costs. The receipt includes all five radices 4,8,10,12,16 and a simple addition-skeleton sensitivity; that sensitivity is not a complete signed-arithmetic proof price.

For an exact-center path, only the two final output-rounding witnesses are needed, while the internal integer arithmetic is checked exactly. For a per-gate path, four or three product roundings and the actual add roundings must all be included. Reusing a precomputed coefficient sum is valid only with its proved equality or residual bound. No arbitrary wide word multiplication is imported into ordinary PA.

Lean's numeral path may evaluate signed big-integer products directly during kernel reduction, and its cost can change discontinuously at limb or multiplication-algorithm thresholds. The correct comparison is four products at widths p,q against the three actual grown widths, plus additions, normalizations and proof elaboration. The PA template-event ratio does not calibrate Lean time, nor does a native floating/Arb benchmark calibrate either ordinary PA or kernel reduction. The saved product can matter, but only a matched completed proof test can measure that effect.

## 7. Storage and acceptance conditions

If both original coefficient coordinates and both cached sums are retained, the fixed path stores four real centers instead of two, plus their residual bounds. A runtime implementation can retain only the three quantities c,C,D after a checked setup, but its proof dependencies and original coefficient enclosure must remain recoverable. The shared t value also affects live temporaries and proof-reference lifetime. Caches should be counted by actual distinct coefficient/precision entries, not by G.

Before replacing a frozen circuit, require the exact finite identity and index/sign map, certified coefficient errors, all local gate errors, the chosen absolute or relative precision policy, and the downstream error recurrence. Recheck the final full output containment. A new smaller arithmetic bound alone does not prove that an independently rounded center belongs to an immutable old output box. No nonzero spectral margin, sign certificate or production transform is established by this local replacement.

## Pins and bounded checks

The companion script checks five exact polynomial identities and rejects a sign mutation. It evaluates only integer width/event formulas and three rational examples of the sufficient error allocation. It imports no analytic evaluator and performs no transforms.

- complex_three_product_models_20261111.py: 79A8FB8E67B48633B2B7D5058A6477CCE3194184EDD2BEC94D4E9CABC28C80A9.
- complex_three_product_models_20261111.json: 2749437A7EA7BED80692A04FA74EFC91F6864C0D7497A0562123948C2057BFCC.
- zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md: C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01.
- integration/COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md: 85651AA198E92AEBDB541C48A2C42AC666B0F5A72A7DDB728545A83F01AD19A8.
- moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md: EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B.
- pinned Mathlib Basic/Complex/Basic.lean: C46DF05B286BD59A4725D02B9BCFA8AD9C50C7898C73FB116C11D60B758EEAE3.

The scalar/symbolic script exited zero. Every numerical throughput or complete-transform precision conclusion remains outside its scope.
