# Tight leaf constants and the exact tensor denominator for mean-input error

2026-11-11. Narrow conditional successor to the mean-input paper [1]. This proves the sharp and tight normalized-Bluestein constants for mean-input error, then composes them through ordered CT and the actual tensor fibers. It uses the explicit old peak guard. It does not replace that guard with the reduced error coefficient.

The resulting combined intrinsic/input-conversion allowance is

    E(c,p)=phi(c)/sqrt(c) * [rho/T+186*S_t/(T-S_t)],
    T=2^p, rho=1[p<100].                              (1)

Here S_t is the sum of tight full-plan axis constants. The stored source is the admitted full-P20 construction, including the guarded height domain and exact grid100 export. The converter, every root/gate/cache contract, and the nonnegative head/representation radius sums remain premises. Runtime capacities use V_width=692 under their separate pointwise proof, never186. No precision assignment, inventory or cost fold is performed or authorized. No coefficient/root/function/transform/prime/zero values, builds, declarations, proof emission or frozen changes occurred.

## 1. Local mean theorem and the final chirp

For an arbitrary exact stored length-n input, put M=sum|x_j|/n and V=M+1. The base paper proves the required radix/direct leaves and ordered CT mean argument. Its equations6-10 also prove the actual rounded-normalized-cache intermediates

    e_F<=PAuV,   e_K<=PAu,
    e_Z<=q*uV,   e_I<=E_B*uV,
    q=3nA+n+2,
    E_B=P*q+R*[n*(2n-1)+2P].                         (2)

This includes the original kernel FFT enclosure, the cache scaling round, both point-product operand errors and their cross term, all radix round errors and the unnormalized inverse factor P. These are mean-input results from a new proof, not substitutions into the old sup theorem.

Keep

    m=2n-1, P=2^k=nextPowerOfTwo(m), R=2k+4, A=1+3R,
    Q=3nPA+1, D_B=max(1,2k,PA,Q),
    C_old=6PA+2R*(2n+1)+8, X=E_B/n.

The selected exact convolution coordinate has norm at most nM, since its exact expansion is the original n-term transform with unit coefficients. Its final chirp and product round therefore satisfy

    e_out<=(1+u)e_I+u*nM+u.

After division by n*u*V, a sufficient coefficient is

    X+uX+(n+1)/n.                                    (3)

The same expression held in the old sup proof, but (2) and the exact nM bound now establish it for the mean. No assumption about the distribution of the input mass or the mean of computed frequency values has entered.

Under D_B, the base mean proof already gives the sharp integer coefficient

    C_sharp=9PA/2+3P/2+3Rn+12R+14.

The exact algebra in the independently reviewed tight-leaf source [3,4] gives

    2n*[C_sharp-(3X/2+(n+1)/n)]
       =R*(27n-6P)+26n-6P-2>0,
    C_old-C_sharp=R*(9P/2+n-10)-6>=74.               (4)

Indeed 2n<=P<4n, n>=2, R>=8, so the first right side is positive. Thus X<C_sharp<C_old before the following extra guard is used.

Require the actual old peak condition C_old*u<=1/2. It implies uX<=1/2. Since (n+1)/n<=3/2, (3) is at most X+2. Therefore

    C_t=ceil(E_B/n)+2,
    D_t=max(D_B,2*C_old)                             (5)

proves `max|Dhat-D|/n<=C_t*u*(M+1)`. The ceiling is exact integer arithmetic. Also X>=3PA>=300. Hence `3X/2+(n+1)/n>X+2`; since C_sharp is an integer exceeding this expression, it is at least ceil(X)+2. This proves C_t<=C_sharp<=C_old for the mean theorem too.

The explicit extra guard is necessary for this argument. At n2, P4, D_B601 and C_old688, u=1/1024 passes D_B but fails 2*C_old*u<=1. No claim that D_B alone supplies (5) is made. The proof applies to the rounded grid-p normalized cache. An exact finer-grid or unnormalized kernel is not given the tight coefficient by this companion.

## 2. Ordered CT and retained safety

Identity, radix-two and direct leaves keep the base mean pairs. At a CT node n=rm, the actual first child is m and the second is r. Put a=C_t(m), b=C_t(r). If M_i denotes the original mean in first-child row i, its mean proof gives error m*a*u*(M_i+1). After the cross twiddle the row error is bounded by m*u*d*(M_i+1), with d=a*(1+u)+1.

Averaging those row means over the precise second-child inputs gives their stored mean plus1 at most `m*(M+1)*(1+u*d)`. Exact transport of first-child errors and the second child's mean theorem yield coefficient

    d+b*(1+u*d)=a+b+1+u*(a+b*d).

Thus the genuine mean recurrence is

    C_t(n)=a+b+2,
    D_t(n)=max(D_t(m),D_t(r),1,a+b*(2a+1)).          (6)

The individual row means are retained until that average. A first-child row need not have mean at most the global mean. This supplies the missing semantic join that a bare reuse of the old CT formula would not establish.

The identical row-mean proof also composes the sharp coefficients. Its nonnegative CT safety polynomial is bounded by the old mixed polynomial because C_sharp<=C_mix. The tight recurrence is the selected symbolic coefficient in this companion; no mix of sharp and tight receipt fields is presumed.

Let C_mix,D_mix be the old pairs for the SAME full ordered node. Structural induction gives

    C_t<=C_sharp<=C_mix,
    D_t<=max(D_mix,2*C_mix).                         (7)

The CT safety polynomial f(a,b)=a+b*(2a+1) is increasing for nonnegative arguments. Increasing them by x,y changes f by `x*(1+2b)+y*(2a+1)+2xy>=0`. Each old child C is at most the old parent C. Together with (5), these facts prove (7), including descendant peak premises. Repeated child roles are not collapsed when their plan objects coincide.

On the admitted conductor family keep BOTH original guards

    T>=D_local_old(c),   T>=2*S_base(c),             (8)

where D_local_old includes the old mixed and baseline denominators. The reviewed family comparison S_mix<=S_base and (7) make (8) imply every local D_t and every descendant old C_old*u<=1/2. These guards also preserve the independent runtime peak proof. They are not replaced by T>=2*S_t.

The inherited global caps D_local_old<=29961461170177<2^45 and 2*S_base<=849412408<2^30 fit below2^50. Their proof remains the same pinned-family evidence used by [7,8]; this note performs no rescan or extension of that family.

## 3. Exact tensor denominator through the actual fibers

Count each ordered outer axis with its multiplicity and put S_t=sum C_t(n_i). After processing axes of product v_i, fix the untouched coordinates and a processed output label. The base paper's fiber invariant is

    ideal partial output norm<=v_i*M_F,
    partial error<=v_i*e_i*(M_F+1),                 (9)

where M_F is the original-input mean over that fiber. The next axis groups equal-size disjoint fibers. Their means average to the parent mean. Applying (6) to the actual stored next-axis line proves

    e_(i+1)=e_i+C_t(n_(i+1))*u*(1+e_i), e_0=0.

This derives the product bound for the tight mean coefficients:

    e_final<=product_i(1+C_t(n_i)*u)-1.

For nonnegative terms of sum s<1, finite induction gives product(1+x_i)<=1/(1-s). At a partial sum t and new term a, the cleared denominator difference is

    (1-t)-(1+a)*(1-t-a)=a*t+a^2>=0.

Consequently, with T=2^p>S_t,

    e_final<=S_t/(T-S_t).                            (10)

The proof works for identity axes and S_t=0 and divides by no C or S_t. It preserves the full group order phi(c) when primitive outputs are selected by dependency-closed pruning. It neither inserts runtime normalization nor averages primitive-output multiplicities.

For the admitted family S_t<=S_mix<=202305920<2^28. At p>=50, T>S_t, so the denominator is positive. Keeping it exact avoids a misplaced fixed tensor factor for a different lower precision floor. The ideal output comparison and actual input averaging in (9), rather than a sup-norm contraction with a substituted mean, justify (10).

## 4. Uniform186 source join and separate692 capacities

Consume the reviewed full-P20 source result [9,10] and the base mean-source proof [1,2]. The actual stored/evaluated polynomial has norm below173 on all selected source bands. The current full-P20 b94/min65 profile needs its separately admitted alpha error and exact grid100 export; magnitude-only grid60 does not admit a new accuracy profile.

The exact head sum is below2c. The actual nonnegative radii obey

    H=c^(-1/2)*sum e_head<=2^-63,
    J0=c^(-1/2)*sum e_rep<=2^-63.

These are per-input radius sums from complete-error section2 and stability-allocation section3. They are not a cancellation-based transformed error. Exact assembly before the single regrid has no new addition error. The current source must supply the head encoding and any earlier representation conversions within H/J0.

For p>=50 the mean contribution of these errors and one admitted regrid is at most

    sqrt(c)/phi(c)*(H+J0)+rho/T
       <=1032*2^-63+2^-50<1.

Adding the augmented1 therefore gives `V_mean<175+2c/phi(c)`. In the same c<=265800 domain, the finite totient argument in [1] gives c/phi(c)<=1001/192, hence V_mean<186. This companion selects the uniform186 constant. It does not create a conductor-dependent magnitude or band-specific policy.

The same actual radius sums bound each individual error by less than1032*2^-63<1. Since the exact head at each representative is below516, the assembled raw input has norm below173+516+1=690. One admitted regrid and the augmented1 give V_width<691+2^-50<692. This supplies the separate pointwise input for the generic peak proofs. All actual runtime capacities remain based on692 and their exact local factors, with the old guards (8). The error-only186 must never replace692 in operand, partial sum, inverse, raw product or witness bounds.

Coefficient/root/kernel capacities, exact coefficient sums, source grids and pre-acceptance range checks remain unchanged at a matched p. A mean bound does not shrink their capacities. There is no new runtime width fold in this paper.

## 5. Converter and complete-output interface

Use the independently reviewed p50..108 adapter [7,8]. Its input is the actual assembled grid100 center. Below100 it rounds that center once to p with complex error less than u, using a checked signed quotient/remainder and tie rule. At and above100 the embedding is exact. Its source/destination ranges, shifts, raw witness capacities, signed/range/binding proofs and production costs remain mandatory. This paper does not infer such an encoding merely from a head radius.

The exact character operator transports the converter error by phi(c), followed by exact conductor magnitude1/sqrt(c). Combining that transport with (10) and V_mean186 proves (1). The regrid term is outside the intrinsic term and is not multiplied by S_t. If (1) is charged, it is not also added to J0. Alpha, head, original representation, conductor-factor approximation, completion, inverse-character samples, interpolation kernels and accumulation retain their original source tolerances.

Keep the old combined intrinsic/input ceiling

    E108=C_g*2^-108, C_g=4196258524692480.

No p is selected here. For a future budget check, the nonnegative quantity (1) is at most E108 exactly when, writing W=rho*(T-S_t)+186*S_t*T,

    phi(c)^2*W^2*2^(2*(108-p))
       <=c*C_g^2*(T-S_t)^2.                         (11)

Positive c,T and T-S_t justify clearing denominators; nonnegative sides justify squaring. S_t=0 retains the regrid term below100 and gives zero at or above100. For one fixed S_t and source bound186, the sufficient expression is nonincreasing with p, including rho's drop at100. Actual cache availability and signs are not thereby monotone.

At p108, rho=0 and S_t/T<1/2. Together with phi/sqrt(c)<=633, S_t<=202305920 and186<=16384, this preserves the old fallback ceiling. If (11) holds with all other premises, the existing complete-output proof gives

    rL<=E(c,p)+2^-82+4*2^-63,
    R<=R_fixed+135*E(c,p)<=R_fixed+135*E108,
    (R_fixed+135*E108)/2^-45
       =2804840254168152529/4294967296000000000.

The retained completion/interpolation multiplier135 is unchanged. This is a sufficient conditional implication, not an assertion that every p>=50 passes, that roots or caches have been generated, or that sign/count evidence exists. No saved assignment or cost baseline is changed.

Every cache still identifies its exact plan, n/P, sign/chirp identities, normalized rounded variant, p, enclosure/rounding contract and lifetime. Shared setup, projection, new low centers and exact cached sums remain charged. Smaller error constants and input means provide no duplicate setup refund. Principal and finite-coverage obligations remain separate.

## 6. Evidence and source pins

The companion `mean_input_tight_tensor_20261111.py`, SHA256 `245FAA10E7146E080988CB45AF11908663BA66DA4B7093B2446D86D9A45537DF`, completed70 fixed rational/hash checks on its first execution. Its exclusive2535-byte receipt `mean_input_tight_tensor_20261111.json` has SHA256 `CC669611310F0842915CBED594298F309DB0D8779B7F7509AE87E601B34BCF2D`.

The checks bind13 frozen inputs, four abstract leaf examples, the guard-separation example, fixed CT/product-induction identities, tensor coefficient fixtures, source reserves, cleared denominator examples, fallback and the complete radius. No author writer was imported. No conductor/axis inventory or precision assignment was read. These fixed examples supplement the quantified paper argument; they do not prove a circuit by sampled execution.

Paths below are relative to `work/qrh-campaign/agents`. This companion corrects only its own source locator: the H/J tolerance table is in stability-allocation section3. The base paper's immutable section4 locator is read with its independent review's qualification.

|Ref|Source and consumed scope|SHA256|
|---|---|---|
|1|independent-feasibility/MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md, sections2-6|160E25353C24850DCA6D167AA5D85D54579FED642BAB3A1E55CC6AD0358C2AF6|
|2|integration/REVIEW_MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md|0B9AED8611C449C11E0A8758F364008032B6B887D45A6BCEF1BFC38CE0BD2EF7|
|3|prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md, sections2-4|5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F|
|4|major-constants/REVIEW_TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md|E7482930B1A6B57FD6C186AD4612E655379D0978DD6C5EDA9C4D4D6D247920F5|
|5|integration/TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md, finite-product inequality and unchanged complete target|DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C|
|6|zero-sum/REVIEW_TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md|EC2FD8569DF2D74B758F6FDD9DC58153BD0FF6B662919ECE43B014C0E064BC26|
|7|zero-sum/FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md, guards, converter and complete-output interface|F0B7399E638A7EBD43FE37F9EAAD8DCFB0583FEA785F7425D9DAFF096D464DE6|
|8|integration/REVIEW_FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md|372F685F72449A11C970ADD855EB5CB64D52E4512B669DB1AD2FC6102FB6DD37|
|9|audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md, sections3-5|03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904|
|10|prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md|1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328|
|11|audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md, section2|96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D|
|12|audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md, section3|6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA|
|13|independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md, separate pointwise capacity contract|412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7|

All13 hashes matched. The independent review of this new mean/tight/exact-denominator composition remains the next gate. Existing assignments, prices, source computations and numerical sign/count status are unchanged.
