# A weaker guard for the full residue-difference state

2026-11-11. New polynomial-only domain extension. No coefficient, analytic, prime, zero or transform values, builds, source edits or selected-family occupancy scans. The frozen full-state, Newton and representation notes remain unchanged. Price and count adoption are separate.

## 1. What changes

The full-state residue circuit and the exact Newton initializer remain valid under the checked guard c>10F, where F=2Dout, with larger integer bounds. Previously reviewed width proofs used c>20F. The new product-only screen phi(c)>10B_c implies the new guard, where B_c counts ALL nonempty integer numerator buckets. Neither the guard nor this screen proves a cost saving.

The supporting polynomial arguments now satisfy |h|<6/5 rather than <3/4. The finite geometric bound is

    sum_{j=0}^{19} (6/5)^j <256.                         (1)

Consequently live differences are below2^43 Q and traversal addition temporaries below2^44 Q when coefficient magnitude C=2^16. These are six bits above the old screened full-state bounds. Newton initialization has a separate raw-product proof below; it also fits2^43 Q globally.

The actual-function approximation and any coefficient-requantization estimate are still consumed only at the original in-cell unit targets, where |h|<=1/4. They are not extended to the polynomial-only setup/support points. Their errors and the final rounding budget are unchanged.

## 2. Geometry, ties and the new screen

Use the reviewed occupancy convention, ties toward the SMALLER nearest anchor:

    k=floor((2F a+c-1)/(2c)),
    (2k-1)c < 2F a <= (2k+1)c.

Here 1<=a<c is an integer, c>10000 is a selected primitive conductor, and

    Dout in {512,1024,2048,4096,8192}, F=2Dout,
    v=2c, q(a)=Fa-kc, h(a)=q(a)/v.

Thus -1/4<h(a)<=1/4. Final-band sourceD4096 still delivers Dout8192 and F16384. Substituting the source grid for F would change this geometry incorrectly.

The bucket endpoints are

    lo=max(1,floor((2k-1)c/(2F))+1),
    hi=min(c-1,floor((2k+1)c/(2F))).

This is an open-left, closed-right real interval of length c/F before endpoint clipping. Its integer length is at most ceil(c/F). The buckets partition1,...,c-1 exactly, including nonunits. If c<=10F, every nonempty bucket has at most10 integers, hence

    phi(c) <= c-1 = sum_k length(bucket_k) <=10B_c.

Contraposition proves phi(c)>10B_c => c>10F. This uses no distribution of primes or units and no new occupancy data. Equality c=10F is covered: the half-open convention prevents an eleventh integer at the two ends. B_c must not be replaced by a count of unit runs or selected trimmed blocks in this argument.

Now impose c>10F directly or via that implication. For every physical numerator a in its chosen bucket and every integer 0<=t<=19,

    |h(a+t)| <=1/4+19F/(2c)
              <1/4+19/20=6/5.                           (2)

The anchor k stays the original bucket's anchor when writing h(a+t). Points beyond the bucket or beyond[0,1] are not reassigned to another source polynomial. They are auxiliary values of this finite polynomial alone.

## 3. Exact state and live magnitudes

Let z_j=n_j/2^b, j0..19, be the chosen exact complex coefficient centers on a verified common dyadic grid, with |z_j|<=C. Define

    P(h)=sum_{j=0}^{19} z_j h^j,
    I(a)=sum_{j=0}^{19} n_j q(a)^j v^(19-j),
    Q=2^b v^19.

Then I(a)/Q=P(h(a)) exactly. For all support points in (2), (1) yields |I(a+t)|<256 C Q. The alternating-binomial identity for forward differences therefore gives

    |Delta^j I(a)| <256 C 2^j Q,  0<=j<=19.             (3)

This holds at every live physical a in the bucket, not only its first point. All twenty orders can consequently be retained even in a short endpoint bucket. Advancing uses D_j <- D_j+D_(j+1) in ASCENDING order j0..18; order19 stays constant. Nonunit numerators still advance the state, but only required units are exported. No advance past the final physical numerator is needed.

At C=2^16, (3) is below2^43 Q. The raw sum of two live states is below2^44 Q. After the sum, the exact invariant again supplies (3); no cancellation is assumed in bounding the raw addition operands or temporary.

This is the FULL-state option. It does not replace the separate pruned long-block theorem or its counts. An all-bucket implementation still initializes a bucket with no unit outputs unless a separately proved pruning rule removes it.

## 4. Newton initialization and its unadded products

The reviewed Newton initializer uses the exact binomial-basis identity and has190 general integer-by-complex-integer products,190 small scales,190 additions before expansion of the small scales, and19 coefficient prescales. Its exact algebra does not require the old c>20F guard. The guard was used for widths, which are re-proved here.

At the first physical numerator a0 let q0=Fa0-kc. After partial degree i, the polynomial is

    J_i(t)=sum_(ell=0)^i n_(19-i+ell) v^(i-ell)(q0+Ft)^ell.

For t0..19, (1)–(2) give

    |J_i(t)|<256 C 2^b v^i,
    |Delta^j J_i(0)|<256 C 2^(b+j) v^i, 0<=j<=i.        (4)

The initializer writes the new top first, then updates interior indices downward and D0 last:

    new D_i=iF old D_(i-1),
    new D_j=(q0+jF)old D_j+jF old D_(j-1), 1<=j<i,
    new D_0=q0 old D_0+n_(19-i)v^i.

The binomial identity proves these are exactly the differences of J_i. No numerical test or normalized derivative substitutes for that identity.

For an interior j, before adding the two products,

    |q0+jF|/v <1/4+j/20,       jF/v<j/20.

Apply (4) at degree i-1 separately to each old operand. Their raw absolute sum is less than

    256 C 2^(b+j) v^i * (1/4+j/20+j/40)
       <512 C 2^(b+j) v^i.                              (5)

This is a bound before any cancellation or normalization. Crucially interior j<=i-1<=18, so the apparent extra factor2 in (5) is offset by one fewer possible difference order. At C=2^16, every such raw sum or unadded product is below2^43 Q, since v^i<=v^19.

For the new top, iF/v<i/20 and the previous order is i-1. Its raw product fits the bound256 C 2^(b+i)v^i, hence2^43 Q. For D0, the two unadded magnitudes sum to less than(64+1)C2^b v^i<256 C2^b v^i. The initial n_19 and all coefficient prescales also fit. Thus all Newton initialization state values and raw product/sum temporaries share the2^43 Q global bound.

The binary implementation of a small jF scale uses nonnegative shifted multiples of the same signed coordinate. Each partial sum has magnitude at most the final scaled coordinate, including negative and zero inputs. It therefore fits the separate secondary-product bound used above. This does not declare shifts or signed data movement free.

There is also a useful actual-family narrow-factor bound. Since c<=265800 and F<=16384,

    |q0+jF| <=132900+18*16384=427812<2^19, 0<=j<=18,
    iF<=19*16384=311296<2^19.

Thus the general factor still fits19 magnitude bits plus sign. A looser bound based only on |h|<6/5 would unnecessarily add a narrow-factor bit. Source coefficient numerators and wide state operands still have their full separate widths.

## 5. Sufficient capacities and final conversion

At c<=265800, v^19 has at most362 bits. From Q=2^b v^19 and the bounds above:

|Representation|Live states and Newton raw temporaries, signed bits|Traversal raw additions, signed bits|Coefficient prescales, signed bits|Cancelled final divisor bits at g100|
|---|---:|---:|---:|---:|
|b100|506|507|479|362|
|b122|528|529|501|384|

In general these capacities are b+406, b+407 and b+379. The old c>20F screened live/advance capacities were b+400 and b+401. Only the stated capacities change; this is not a new bit-cost forecast or a requirement to use the maximum width at every partial degree.

For a final coordinate I/Q, nearest grid2^-g rounding is still certified by

    (2z-1)Q <=2^(g+1)I <(2z+1)Q.

It works for signed I and resolves ties toward positive infinity. Coordinate error <=2^(-g-1) gives complex error <2^-g. At g100 and b>=100, cancel powers of two and divide by2^(b-100)v^19. This divisor and the actual in-cell final value bound are unchanged. The larger auxiliary difference states do not enlarge the final output's analytic error. Decoding and requantizing arbitrary finer source encodings still require their own actual input-width bounds; the table is not a bound on arbitrary unvalidated supplied integers.

## 6. Source accuracy and optional b100 representation

Every actual exported argument still satisfies |h|<=1/4 and refers to the same fine-anchor source theorem. The inherited analytic target tail, analytic shift bias and numerical coefficient errors are consumed there exactly as before. Integer Newton/difference arithmetic creates no rounding error at the auxiliary points and does not require an analytic theorem there.

If the original centers are already on an admitted common grid, final g100 rounding contributes <u_H=2^-100 per residue, and <633u_H after the existing character normalization, as in the reviewed exact circuit.

The optional grid-closure note constructs NEW centers on grid2^-100 and pays their difference from the original polynomial separately. Provided its grid/error/source binding and coefficient magnitude premises are supplied, its in-cell estimate remains

    |P_new(h)-P_old(h)| <(4/3)u_H,
    new evaluation error <(4/3)u_H+u_H=(7/3)u_H<(8/3)u_H,
    character-normalized contribution <1477u_H<1688u_H.

There is no256 factor in this error budget. Such a factor would arise only from needlessly demanding a numerical approximation to the old analytic function at the auxiliary points. The circuit computes the new finite polynomial exactly, then compares it with the original polynomial only at an in-cell output.

The grid-closure author's explicit source margins preserve C=2^16 after requantization. Its independent review/adoption remains a separate gate at this supplement's freeze. Nothing here infers a common grid from a norm-error bound alone. Charge the20 complex coefficient conversions per distinct selected source array, their signed witnesses and cache binding if that optional representation is used. Original-center Horner remains the fallback; an unchanged rounded Horner on newly quantized centers cannot silently inherit the same allowance.

## 7. Counts and status

The Newton per-bucket arithmetic counts remain190 general products,357 additions after the specified small-scale expansion,357 shifted-operand occurrences,19 prescales, then19 additions per numerator advance and one final conversion per exported unit. These are identities for a selected full-state bucket, not an aggregate operation adoption. Geometry powers, factors, source/representation binding, traffic and ordinary proof reconstruction remain charged.

Under the artificial product-only comparison190B_c versus19phi(c), the necessary screen is phi(c)>10B_c. Section2 now makes that screen sufficient for this enlarged polynomial DOMAIN, unlike the old c>20F proof. It remains insufficient for a cost improvement: widths, all-numerator advances, coefficient conversion/prescales, setup, final division and proof/storage costs must still be priced. No selected-conductor count or saved stage total is claimed here.

The companion script checks18166 exact statements: four input pins, the rational finite geometric sum, partial-degree/raw-product factors and widths, small abstract ties-down partitions, guard endpoints and the unchanged evaluation allocation. These are geometry and symbolic-bound checks, not a new selected-family occupancy scan or evaluated coefficient array. The proofs above cover the full parameter domain.

Pins relative to `work/qrh-campaign/agents`:

|File|SHA-256|
|---|---|
|integration/EXACT_RESIDUE_FINITE_DIFFERENCE_CIRCUIT_V2_2026-11-11.md|691A9B744FCCE7C7A8F0D8F18F08F70A68C758D2FFFF1C5E826F138E1257D025|
|prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC|
|moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md|995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234|
|integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md|9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4|
|major-constants/residue_difference_ten_guard_20261111.py|F0A0DC446C54A503D8B6E84A2D9441EF420557EC296D329BB36896B550F884A4|
|major-constants/residue_difference_ten_guard_20261111.json|692D89158DF2A16FF35B1BBEB6A7B29F6C96443B842DFFF55127EE99D4176D58|
