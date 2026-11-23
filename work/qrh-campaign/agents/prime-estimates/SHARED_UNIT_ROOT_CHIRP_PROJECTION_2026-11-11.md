# Shared high-precision unit-root and chirp projection

Date: 2026-11-11. Scope: paper producer-adapter contract and fixed scalar metadata. No roots, angles, coefficients, conductors or transforms were enumerated or evaluated. No implementation, formal declaration, proof emission, build, inventory saving or production choice is claimed.

## 1. Result and exact source boundary

One certified complex center on grid 2^-110, with **complex-norm** error at most 2^-110 from its specified exact unit, can supply each requested grid p=100,...,108 by direct coordinate-nearest rounding. Each result has complex-norm error strictly below 2^-p and fits the existing p+1 magnitude-bit coefficient capacity. This changes a producer interface, not the exact roots or transform normalization. It does not establish how many exact coefficient identities are shared, whether their construction is cheaper, or whether any resulting sign test succeeds.

The pinned mixed-radix character identity uses the positive, unnormalized transform D_n(x)_k=sum_j x_j exp(2*pi*i*j*k/n). Its CT bridge roots and Bluestein chirps must retain their exact index, sign and axis conventions. For example the chirp identity uses zeta=exp(pi*i/n), hence rational turns j^2/(2n), with the appropriate negative sign for the difference kernel. The precision supplement sections 1--4 assumes separate root/chirp error at most u and complex arithmetic-gate error at most u. Its section 4 distinguishes unit chirps from the transformed, generally nonunit, cached kernel. Reuse never divides coefficient error by the number of uses.

An identity key therefore denotes the exact complex number, its source role and the proof connecting that role to the shared object. Equality of rational turns modulo an integer can justify sharing only after that equality and the exponential identity are proved. Approximate floating-angle equality cannot. Include roots used to construct cached kernels, not just roots in runtime transforms. Equivalent identities may have different labels; deduplication needs an actual checked equivalence and transport.

This note does not place Gauss root numbers, Hardy normalizations, Gamma/completion phases or their canonical branch conventions in the transform identity catalogue. The abstract lemma applies to any certified unit, but those objects have separate producers and normalization obligations. Exact quarter turns or signs can be literal objects only with their own identity proof. Their possible removal from projected demand is not counted here.

## 2. High-grid enclosure and projection proof

Put u_p=2^-p. The high producer supplies signed integers A,B, an exact source identity rho with |rho|=1, and

    rho_H=(A+iB)*2^-H,      |rho_H-rho| <= u_H.                 (1)

The grid equality is part of the certificate. Any rounding used to create rho_H is already included in (1). A rectangle with coordinate radii u_H does not itself prove (1). Sufficient rectangle radii r_x,r_y must satisfy r_x^2+r_y^2 <= u_H^2; for example each radius at most u_H/2 suffices. Alternatively a coordinate-radius-u_H contract requires its norm conversion and a different guard. It cannot be silently relabeled.

For H>p let Pi_p round both coordinates to the nearest grid point, with ties toward positive infinity. Each coordinate error is at most u_p/2. Thus

    |Pi_p(rho_H)-rho_H| <= sqrt(2)*u_p/2 < 3*u_p/4.

When H>=p+2, triangle inequality gives

    |Pi_p(rho_H)-rho| < (1/4+3/4)*u_p = u_p.                 (2)

Consequently |Pi_p(rho_H)| < 1+u_p. This is exactly the required root enclosure; no assertion that the stored center itself has norm one is needed. H=110 covers all nine requested grids. For p=H, reuse rho_H exactly, with error <=u_p and norm <=1+u_p. The one-bit gap H=p+1 is not admitted by this proof: its triangle allowance is u_p/2+sqrt(2)*u_p/2>u_p. A sharper supplied enclosure or a checked direction-sensitive residual might admit a particular object, but is not provided here.

Every lower center is projected directly from the certified high center. Successive rounding through intermediate grids can double-round; neither its center equality nor its error is inherited from (2). New centers need not equal separately generated old p-centers. The transform's mathematical error contract survives, but old computed transform centers or successful sign decisions cannot be reused merely because their radii had the same bound.

## 3. Exact integer rounding and signs

For one coordinate set k=H-p and d=2^k. The signed floor/remainder witness is

    A=q*d+r,  0<=r<d;       M=q+[2r>=d].                    (3)

Equivalently the chosen integer M is certified by

    R=A-M*d,               -d <= 2R < d.                    (4)

The asymmetric endpoints implement ties toward positive infinity. Formula (4) proves the coordinate-nearest error, including negative A and zero. A producer may discover q or M natively; acceptance checks the exact equations and comparisons. Multiplication by d is a checked power-of-two shift. Raw products/subtractions are checked at adequate width before narrowing their residuals. No machine overflow or native division is an oracle.

This tie rule is not odd. In particular, projection need not commute with negation or conjugation at ties. Either project each signed high object with (3), or explicitly define a conjugate/sign transform of an already projected center and prove its error by the corresponding isometry. The latter may differ from direct ties-positive projection. It requires a distinct output-recipe binding and costs; it is not an automatic cache-count reduction.

The existing signed-dyadic bridge sections 4--6 provides the ordinary natural-witness split, comparison and sign-case route. Its mandatory current-exponent clarification applies if canonical odd-mantissa normalization is requested. This adapter instead permits the common-grid pair (M,-p), avoiding any need to normalize at each cache access. A format demanding canonical form must separately check and charge it.

## 4. Widths and exact derived sums

All bit counts below are sufficient magnitude-bit capacities, with one additional explicit sign bit. Since (1) implies |A|,|B|<=2^H+1, H=110 needs 111 magnitude bits and 112 signed bits.

For k>=2, coordinate rounding gives

    |M| <= 2^p + 2^-k + 1/2 < 2^p+1,

so integral M satisfies |M|<=2^p. Equality is possible; capacity remains p+1 magnitude bits, p+2 signed bits. Exact p=H reuse allows |A|=2^p+1 and has the same capacities, but not the stronger projected-coordinate bound.

With the candidate range |M|<=2^p checked, |Md|<=2^110. A generic subtraction A-Md has absolute bound 2^111+1, requiring 112 magnitude bits, 113 signed bits before (4) narrows it. In the floor route |q|<=2^p+1 and |qd|+r<=2^110+2^(k+1)-1<2^111. The unsigned remainder has k bits and its doubling k+1 bits, at most 11 here. After (4), |R|<=2^(k-1), so a signed k+1-bit representation suffices. Source equality, zero extension and sign binding precede narrowed comparisons.

For a projected center (C+iD)2^-p, cached c+d and d-c are formed as the **exact signed integer sums** (C+D) and (D-C), with no extra analytic error. Their magnitudes are at most 2^(p+1), so p+2 magnitude / p+3 signed bits suffice. In the exact-reuse branch the bound is 2^(p+1)+2, still below 2^(p+2) in the present range. These are conservative capacities, not a tighter unit-norm repricing. An old independently rounded sum, or the projection of a high-grid sum, is not interchangeable without proof of equality or a newly paid cache-error allowance.

The fixed-three-product refinement may use those exact sums of the chosen stored centers and its existing final-round gate proof. Cached Gauss needs c+d; cached fixed needs both sums. All arithmetic input, product, output and rounding widths remain the separately established gate widths. This projection lemma does not discount their proof costs.

## 5. Ordinary proof and producer work

One complex projection requires two scalar certificates (3) or (4), including sign/zero binding, remainder or shift witnesses, comparisons, tie selection and at most one integer increment per coordinate. Existing signed-bridge notation gives a conservative scalar template Split_b(n)+3A(n+1)+O(1) before optional normalization. At byte radix the high magnitude fits n=14 bytes; raw residual work may need 15. This is a local macro bound, not a count of fully encoded ordinary-MM0 instructions, bytes, unification work or Lean kernel time.

The split/fold lemmas, range facts, exact numeral representation and source-to-cache transport still need ordinary proofs. Reusable proof contexts and immutable identities are explicit resources; neither a native array lookup nor a hash proves that the requested center is the certified one. The direct residual route and split route are alternatives and must not both be charged as mandatory, or neither charged. No numerical complete checker price is supplied in this note.

## 6. Unknown identity sets and cache lifetimes

Let I be the actual set of checked exact unit identities, and P_i a nonempty subset of {100,...,108} actually requested for identity i. Set J=sum_i |P_i|. Then

    |I| <= J <= 9|I|.

Under one persistent high object and one persistent low object per requested pair, construction counts are |I| high centers and J complex projections (2J scalar projections). A full fixed-gate sum cache adds 2J exact real additions. More generally the count for c+d is the size of the actual union of cached-Gauss and cached-fixed demands; d-c is needed only on cached-fixed demands. Cache intersections are counted once only when they bind the same center and lifetime. There is no numerical value of |I| or J in this packet.

If objects are rebuilt across checked contexts, replace these counts by sums of actual lifetime multiplicities ell_H(i) and ell_L(i,p). Each low construction must have access to a still-valid high certificate. Setup-FFT demands and consumer invocations are included in these lifetimes. Error at each use remains u_p, regardless of how often its construction is reused.

Raw packed center payloads would be 224 bits (28 bytes) per H110 complex center and 2(p+2) bits per projected center under the signed capacities above. These omit alignment, indices, exact-angle/source identities, enclosure proofs, cache sums, term objects, theorem statements and transport. They are not memory estimates for a checker or proof file. No free cross-shard persistence is assumed.

## 7. Conditional break-even, separately for each cost measure

For a common lifetime policy, let G_p(i) be construction/certification cost for a direct p-center, G_H(i) that of the high center, R_Hp(i) its checked projection, S_ip the same exact low-sum cache setup, and U_direct/U_shared all remaining identity, proof, storage and transport costs. Compare

    direct = sum_(i,p) G_p(i) + sum_(i,p) S_ip + U_direct;
    shared = sum_i G_H(i) + sum_(i,p) R_Hp(i)
             + sum_(i,p) S_ip + U_shared.                   (5)

The shared option wins this declared cost only if

    sum_(i,p) G_p(i) - sum_i G_H(i)
       > sum_(i,p) R_Hp(i) + U_shared - U_direct.             (6)

Use (5)--(6) separately for producer operations, proof generation, ordinary proof checking and bytes, with their own prices. Higher-precision elementary construction may cost more; an identity used at only one precision need not benefit. A sunk certified high cache removes its future construction cost only if still available in the required checked context. Conversely sunk direct low caches cannot be credited as new savings, and discarding them does not refund their cost. Formula (5) compares valid same-accuracy output contracts, not identical independently generated centers or guaranteed equal sign outcomes.

The separate high-precision **kernel** adapter is not a premise of (2). A transformed kernel is nonunit and has its own magnitude and construction-error allowances. Its different H/p rule cannot justify the one-bit root gap. Projected unit roots can be inputs to such a producer only through that producer's complete setup/error contract and actual identity union. No kernel certification or setup-count reduction is established here.

## 8. Fixed checks and pinned evidence

The companion checks only the nine p values, exact rational guard inequalities, integer capacities and eight file hashes: 101 checks, receipt 6690 bytes. No angle set, root value, cache cardinality or transform is evaluated. The receipt explicitly leaves identity and lifetime counts unknown and marks no production selection.

| Artifact | SHA256 |
|---|---|
| shared_unit_root_projection_20261111.py | A441F6FEC989A2F1859AF7E7A8E5ACF868A61812925EABA658EE87ECFC588300 |
| shared_unit_root_projection_20261111.json | 3489F0CB660D7B9FC1522EAC34EFB7CD59F642FA3075842018B089836D7AF344 |
| ../zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md | C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01 |
| ../zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md | 4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4 |
| ../zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md | 087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D |
| ../moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md | EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B |
| EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md | EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD |
| CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md | 8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03 |
| ../audit/REVIEW_EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md | E3EFDD1A7DC6185E02421DDB0E50417748FB694EA663E5663AAE6416446266A7 |
| work/qrh-blueprint/SHARED_HIGH_PRECISION_KERNEL_ADAPTER_2026-11-11.md (separate scope) | 6393BBAD96123F0AD7E1171CFE1BF2D50A1B27641E55C926BCD30D23155ABE42 |

Remaining obligations are a certified high-grid unit producer on exact source identities, a complete identity-demand/lifetime catalogue, ordinary projection and binding proofs/encoding, correctly constructed low caches, and actual downstream transform/sign/completeness certificates. The paper adapter supplies the sufficient error and width contract only.
