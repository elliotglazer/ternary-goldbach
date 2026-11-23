# Independent review of tight mean-input tensor composition

2026-11-11. PASS at conditional paper/source scope. No mathematical correction requested. Reviewed author `independent-feasibility/MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md`, SHA256 `4A7EB4A925A84F70F882A2AC4A1D44B5EB6132B5C6066C12FB4DC4159EF1CDED`.

The successor genuinely proves the tighter rounded-normalized-cache coefficient for the mean-input theorem, composes it through the ordered CT fibers, and obtains the exact tensor denominator. It does not assume those conclusions from the old sup-norm theorem. The intrinsic mean bound186 and the pointwise runtime bound692 serve different purposes and remain separate. The original local and peak guards, actual producer contracts, full-P20 premise and one admitted input conversion are required.

This verdict approves no precision assignment, selector execution, inventory, width or price fold, data producer, numerical sign or count success. No such work was performed in this review.

## 1. Tight leaf from actual mean-input intermediates

The accepted base mean paper160E2535 and its review0B9AED86 supply, for the actual rounded grid-p normalized kernel, e_I<=E_B*u*(M+1). Here M is the mean of the original stored length-n input, and

    E_B=P*(3nA+n+2)+R*(n*(2n-1)+2P),
    R=2log2(P)+4, A=1+3R, X=E_B/n.

This bound already includes sparse padded data/chirp errors, the original kernel FFT enclosure, normalization rounding, both point-product operand errors and their cross term, and the unnormalized inverse factor P. None of those terms is removed in the successor.

The selected ideal convolution coordinate is a sum of n original inputs with unit coefficients, so its norm is at most nM. Thus the actual final chirp and product round give

    e_out <= (1+u)e_I+u*nM+u.

After normalizing by n*u*(M+1), the expression X+uX+(n+1)/n is a valid upper bound. It is conservative and is not claimed to equal the actual error. This establishes the final-chirp input needed by the tight-leaf algebra for a mean, without importing the conclusion of the sup proof.

I independently expanded the two identities

    2n*(C_sharp-(3X/2+(n+1)/n))
       =R*(27n-6P)+26n-6P-2,
    C_old-C_sharp=R*(9P/2+n-10)-6.

For2n<=P<4n, n>=2 and R>=8, the first is positive and the second is at least74. Hence X<C_sharp<C_old is established before using the peak condition. The explicitly retained C_old*u<=1/2 then implies uX<=1/2. With (n+1)/n<=3/2, the coefficient is at most X+2 and therefore at most

    C_t=ceil(E_B/n)+2.

The ceiling is exact. X>=3PA>=300 also gives3X/2+(n+1)/n>X+2. Since C_sharp is an integer exceeding that quantity, C_t<=C_sharp follows for both integral and nonintegral X.

The extra guard cannot be inferred from D_B alone. The fixed n2 case has D_B601 and C_old688; u=1/1024 obeys the former and violates2*C_old*u<=1. The successor correctly exports D_t=max(D_B,2*C_old). It applies specifically to the rounded normalized cache. Exact finer-grid scaling and the original unnormalized cache do not inherit this new tight coefficient by name or representation similarity.

## 2. Ordered CT and the old guards

The actual m-first CT decomposition retains the original row means M_i until the next-child average. With a=C_t(m), b=C_t(r), its cross-twiddle coefficient is d=a*(1+u)+1. The second child's stored mean plus1 is bounded by m*(M+1)*(1+u*d). Exact transport and the second intrinsic theorem yield

    d+b*(1+u*d)=a+b+1+u*(a+b*d).

Using u<=1 and d<=2a+1 proves the same CT pair formula, now supported by the mean-input semantics:

    C_t=a+b+2,
    D_t=max(D_t(m),D_t(r),1,a+b*(2a+1)).

This is not a substitution of one global mean for every row. Repeated child roles remain repeated even when their node identifiers coincide.

The safety comparison is D_t<=max(D_mix,2*C_mix) for the SAME ordered plan. It is not the stronger and unsupported D_t<=D_mix. The polynomial f(a,b)=a+b*(2a+1) is increasing on nonnegative arguments; its increment under a+x,b+y is x*(1+2b)+y*(2a+1)+2xy. The independent checker verifies that identity formally. Each legacy child C is at most its legacy parent C. Together these facts propagate the leaf guard to the full node.

The admitted-family conditions T>=D_local_old and T>=2*S_base remain necessary. The inherited same-family S_mix<=S_base comparison and descendant bounds make these conditions cover each tight D and every old Bluestein C_old*u<=1/2 premise. They preserve the separate semantic peak proof as well. Replacing them by a guard involving only the reduced S_t would not be this theorem.

The source global limits29961461170177<2^45 and849412408<2^30 lie below2^50. They are inherited bounds for the admitted family, not a new family or inventory result. The earlier proof's declared p100 interval was not used to hide a local numerical hypothesis; the successor explicitly retains the actual u/safety assumptions and uses the separately reviewed lower-grid adapter.

## 3. Exact tensor denominator through fibers

After processed axes of total length v_i, the induction fixes untouched coordinates. Its M_F is the original mean on that input fiber. It retains

    |ideal partial output|<=v_i*M_F,
    |partial error|<=v_i*e_i*(M_F+1).

The next axis groups disjoint equal-size fibers, whose means average to the parent mean. The actual stored next-line mean plus1 is at most v_i*(M_F+1)*(1+e_i). Applying the newly proved tight local mean theorem gives e_next=e_i+C_i*u*(1+e_i). This supplies the needed mean-dependent tensor proof; a sup-norm contraction statement alone would not suffice.

Starting at zero gives e_final<=product(1+C_i*u)-1. For nonnegative terms with sum s<1, the finite induction step is justified by

    (1-t)-(1+a)*(1-t-a)=a*t+a^2>=0.

Consequently e_final<=s/(1-s)=S_t/(T-S_t). The identity was independently checked as a formal polynomial. Identity axes and S_t=0 are covered without division by a coefficient or by S_t. Repeated outer axes remain in S_t, and pruning outputs does not replace the full input order phi(c) with a primitive-output count. The proof normalization inserts no runtime gates.

The same-plan inequality S_t<=S_mix<=202305920<2^28 and p>=50 ensure the positive denominator. There is no use of a fixed tensor factor proved only for a different precision floor.

## 4. Actual input mean and pointwise capacity

The source join consumes the reviewed complete finite-EM/full-P20 result03680 and its independent review1E9D, together with the base mean proof. It requires the actual stored/evaluated polynomial bound below173 over the selected source/guard domain, an independently admitted full alpha error, the matched full-P20 b94/min65 evaluator and exact grid100 export. It does not admit a new accuracy profile from a magnitude-only grid60 premise or from a shorter polynomial.

The exact raw finite head has norm-sum below2c. H and J0 must be the actual conductor-scaled sums of NONNEGATIVE per-input head and earlier representation radii, each at most2^-63. A cancellation-based bound on a transformed sum would not supply this premise. The cited complete-error section2 defines the sums, and stability section3 supplies their tolerances.

Their mean contribution plus one admitted regrid is at most

    sqrt(c)/phi(c)*(H+J0)+rho/T
       <=1032*2^-63+2^-50<1.

The augmented mean is therefore below175+2c/phi(c). The previously reviewed elementary finite totient argument gives c/phi(c)<=1001/192 on c<=265800, so this is below186. Source polynomial actual-function uncertainty is not added to this stored-center magnitude again; its alpha radius remains separately charged.

The same nonnegative sums also bound each individual head/representation error by their total, below1032*2^-63<1. Since the exact individual head is below516, the actual assembled raw center is below173+516+1=690. After one conversion and the augmented1, the pointwise bound is below691+2^-50<692. This is a valid separate extension of the pointwise source argument to the named p50 range. It relies on the actual input and error contracts, not on mean186.

Only692 and the old norm/context factors may be used for the runtime capacity proofs in this companion. Mean186 does not bound an individual buffer, root/data operand, inverse stage, exact presum, raw product or witness. Coefficient/kernel capacities and setup also remain separate. Pre-acceptance arithmetic needs its proved source and candidate ranges before using accepted-output bounds.

## 5. Conversion, cleared comparison and downstream terms

The actual assembled grid100 center is converted at most once by the independently reviewed p50..108 interface. Below100 its complex error is less than u; at100 the operation is identity and above100 an exact embedding. Its checked signed quotient/remainder, tie rule, raw widths, source/destination ranges, grid bindings and costs remain premises. An enclosure radius alone is not proof of the required encoding.

Exact character transport and conductor scaling give the combined allowance

    E=phi(c)/sqrt(c)*(rho/T+186*S_t/(T-S_t)),
    rho=1 below100 and0 otherwise.

The new conversion contribution is outside the intrinsic term. When E is charged it must not also be included in J0. The source mean includes the changed center's magnitude; that does not replace the separate transport of its conversion error to the analytic input.

Writing W=rho*(T-S_t)+186*S_t*T yields the exact future test

    phi(c)^2*W^2*2^(2*(108-p))
       <=c*Cg^2*(T-S_t)^2,
    Cg=4196258524692480.

The term186*S_t*T is retained. Positive denominators and nonnegative sides justify clearing and squaring. The independent checker verifies the common numerator and its full square symbolically, including mixed terms. This is verification of the paper formula, not execution of a selector on candidates or conductors.

S_t=0 leaves the conversion term below100 and gives zero at and above100. For fixed S_t and the common186 source bound, the sufficient expression decreases with T, including the drop of rho at100. This does not prove cache availability or numerical signs monotone. At p108 the same phi/sqrt(c)<=633 and S_t<=202305920 give the old fallback ceiling Cg*2^-108.

The old complete-output terms remain unchanged. The independent fixed calculation recovers

    (R_fixed+135*Cg*2^-108)/2^-45
       =2804840254168152529/4294967296000000000<691/1024.

Alpha, finite-head and earlier representation errors, the actual conductor-factor enclosure, completion, inverse-character adaptation, interpolation kernels and accumulation are all still required. This radius implication does not certify any actual sign or completeness surplus. Cache identity, rounded variant, p, root/chirp labels, exact new sums and lifetime costs cannot be inferred from a smaller coefficient.

## 6. Independent evidence and restrictions

I read the full frozen companion, the tight-leaf source/review and its base mean and p50 joins. Sixteen author/source pins match. The accepted base mean review was performed by this integration agent; the earlier tight-leaf and source-magnitude results retain their named independent reviewers. This review concerns the new composition, not a new attribution of those reviews.

New independent script `integration/review_mean_input_tight_tensor_20261111.py`, SHA256 `E3C1ED6D5BF74EC0F17F8CA33D3DCBD1D6F4E43EEE4196352A4F45CA64F82671`, passed51 checks on its first execution. Its exclusive5511-byte receipt `integration/review_mean_input_tight_tensor_20261111.json` has SHA256 `76943FE5FCAB1CEE9B0FEB0FBB98CCA737693DA9BB536405B6427376248B03BE`.

The checks use formal polynomial expansions, fixed abstract leaf parameters, rational reserve and radius comparisons, and hashes. They neither import nor execute author code, and read no assignment or inventory. No coefficient, root, transform, L-function, zero, prime or elementary-function values were evaluated. No build, declaration, proof emission, source edit or frozen artifact change occurred. The general proof is the quantified reasoning above; fixed fixtures are not a substitute.

The new tight mean-input/error formula is accepted as a conditional paper theorem. Actual proofs and numerical producer records remain unimplemented here. No precision distribution, pricing, width fold, data production or final proof conclusion follows from this review alone.

## 7. Frozen input ledger

Paths are relative to `work/qrh-campaign/agents`.

- `audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md`: `6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA`.
- `audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md`: `96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D`.
- `audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md`: `03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904`.
- `independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md`: `412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7`.
- `independent-feasibility/MEAN_INPUT_TIGHT_CONSTANT_TENSOR_COMPANION_2026-11-11.md`: `4A7EB4A925A84F70F882A2AC4A1D44B5EB6132B5C6066C12FB4DC4159EF1CDED`.
- `independent-feasibility/MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md`: `160E25353C24850DCA6D167AA5D85D54579FED642BAB3A1E55CC6AD0358C2AF6`.
- `independent-feasibility/mean_input_tight_tensor_20261111.json`: `CC669611310F0842915CBED594298F309DB0D8779B7F7509AE87E601B34BCF2D`.
- `independent-feasibility/mean_input_tight_tensor_20261111.py`: `245FAA10E7146E080988CB45AF11908663BA66DA4B7093B2446D86D9A45537DF`.
- `integration/REVIEW_FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md`: `372F685F72449A11C970ADD855EB5CB64D52E4512B669DB1AD2FC6102FB6DD37`.
- `integration/REVIEW_MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md`: `0B9AED8611C449C11E0A8758F364008032B6B887D45A6BCEF1BFC38CE0BD2EF7`.
- `integration/TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md`: `DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C`.
- `major-constants/REVIEW_TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md`: `E7482930B1A6B57FD6C186AD4612E655379D0978DD6C5EDA9C4D4D6D247920F5`.
- `prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md`: `1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328`.
- `prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md`: `5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F`.
- `zero-sum/FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md`: `F0B7399E638A7EBD43FE37F9EAAD8DCFB0583FEA785F7425D9DAFF096D464DE6`.
- `zero-sum/REVIEW_TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md`: `EC2FD8569DF2D74B758F6FDD9DC58153BD0FF6B662919ECE43B014C0E064BC26`.
