# Independent review of the future p50 exact tensor selector

2026-11-11. PASS at conditional paper/source scope, with no mathematical correction requested. This review binds `zero-sum/FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md`, SHA256 `F0B7399E638A7EBD43FE37F9EAAD8DCFB0583FEA785F7425D9DAFF096D464DE6`.

The proposed selector and representation extensions are sound under the stated local implementation, cache, input and downstream premises. This verdict does not select a precision, extend an assignment, accept numerical samples, or adopt the separate magnitude-692 proposal. The author's exclusion of that proposal is retained even if it receives a separate review later.

## 1. Actual tensor recurrence and the cleared selector

The source tensor argument uses the actual positive, unnormalized ordered transform. Let N_i be the full product of preceding axis lengths. The proof divides error by N_i; the computation does not insert normalization gates. Exact normalized partial transforms contract the input sup norm. If e_i is this normalized intrinsic error and V bounds the actual regridded input norm plus one, the next leaf has actual input norm at most N_i*(M+e_i). Its augmented norm divided by N_i is at most M+e_i+1/N_i <= V+e_i. Thus

    e_(i+1) <= e_i + C_(i+1)*u*(V+e_i).

The induction gives e <= V*(product(1+C_i*u)-1). Nonnegative elementary symmetric terms are bounded by powers of their sum, so the product minus one is at most s/(1-s) for s=S*u<1. Repeated axis roles remain repeated in S. Primitive-output pruning does not replace the full operator norm phi by the number of retained outputs.

For T=2^p, p>=50 and S<=202305920<2^28, S/T<2^-22. There is no division by S. The input conversion contributes rho/T per complex input, where rho=1 below100 and zero otherwise. Exact operator transport and the exact conductor magnitude therefore give

    E = phi/sqrt(c) * (rho/T + V*S/(T-S)).

The input conversion is separate from intrinsic transform error. It is not multiplied by S or V, and is not charged again after this combined allowance is used. The conductor-scaled alpha error remains a separate single charge.

For V=a/b, b>0, the common numerator is

    W = rho*b*(T-S) + a*S*T.

In particular, the second summand contains T. Clearing the positive denominator b*T*(T-S), comparing to Cg*2^-108 and squaring yields exactly

    phi^2*W^2*2^(2*(108-p)) <= c*Cg^2*b^2*(T-S)^2,
    Cg = 4196258524692480.

The checker independently expands this polynomial, including its cross terms. Positive c, b and T-S and nonnegative sides make squaring reversible. The finite upper limit p<=108 makes the displayed power an integer. No square-root evaluation is needed.

When S=0, W=rho*b*T. The formula retains the input conversion below100 and gives zero at and above100. It neither divides by S nor incorrectly discards the conversion.

For a common fixed V and the same implementation coefficients, rho/T is nonincreasing and drops at100. The intrinsic term decreases as T increases. At a fixed rho the difference between T and2T is

    rho/(2T) + V*S*T/((T-S)*(2T-S)) >= 0.

At the transition from rho=1 to rho=0, the first term is instead1/T, still nonnegative. This proves scalar-predicate monotonicity only. It does not compare changing numerical centers, sign margins or cache availability.

## 2. Safety, magnitude premises and the complete target

The old guards remain T>=D_local_old and T>=2*S_base. The source global caps29961461170177<2^45 and849412408<2^30 are below2^50. This verifies the proposed floor for the already admitted family; it does not prove a local cache theorem for new objects. The local radix, direct, CT and normalized Bluestein proofs retain their hypotheses in u and the old peak/safety conditions.

V must bound the same actual assembled-and-regridded input across every precision under comparison. Merely having a bound on the old p>=80 domain would not suffice. The paper supplies a valid generic example without using692: the original full-source input margin below8826 implies M_new+1<8827+2^-50<8828. Any smaller bound needs its own source and review. Full P20 production, finite-head correction, original grid100 assembly and their actual-function identity remain premises.

At p108, rho=0 and1/(1-S/T)<=2. With phi/sqrt(c)<=633 and V<=16384, E<=Cg*2^-108. Thus the old p108 target is a fallback under the same representation and cache premises. A failed lower-precision test is not evidence of a failed actual error bound.

The independent check reconstructs the complete downstream radius from its retained fixed terms, not just the intrinsic allowance. In units of2^-45, the unchanged ceiling is

    2804840254168152529 / 4294967296000000000
      < 653052762/10^9 < 691/1024.

This includes the old analytic interpolation tail, alpha, scaling/completion and arithmetic allocations exactly as in the consumed complete contract. The stored-output magnitude arguments use E<=E108 after selection. They cannot be used to declare every p50 candidate admissible. Source uncertainty, conductor-scaling enclosures, completion, negative-sample adaptation and interpolation arithmetic retain their own grids and errors.

The59 precision labels and a59-bit mask are an encoding specification only. No precision population or mask was computed in this review.

## 3. Grid100 conversion through a50-bit shift

For1<=d=100-p<=50, the signed witness

    n+2^(d-1) = Q*2^d+t,    0<=t<2^d

has the claimed nearest-rounding convention, with ties toward positive infinity. This includes negative values and zero. Each coordinate error is at most u/2, giving a complex norm error less than u.

The independent source bound |n|<2^114 and supplied output range |Q|<2^(p+14) must be checked before using raw capacities. The actual source margin proves that the candidate range is complete: |Q|<8826*2^p+1/2<2^(p+14). Since p+d=100, both raw witness sides have magnitude below2^115. Source115 signed bits, destination p+15 signed bits and raw addition116 signed bits are sufficient throughout the range.

The four signed witness additions per complex input retain the unsigned byte-adder subtotal4*(2*15+1)=124. This is an arithmetic macro subtotal, not a complete ordinary-MM0 command count. Signed wrappers, independently supplied ranges, exact equality and shift bindings, source transport, digit splitting, storage and producer costs remain explicit. At d50 a seven-byte remainder still needs the two-bit top-byte range fact. The wider permitted gap does not make that fact free.

A direct raw residual needs116 signed bits and its unchecked double117. Accepted residual bounds cannot justify narrower pre-acceptance arithmetic. At p100 the operation is exact identity. At p>100 it is an exact left shift of at most8 bits. The d=0 branch must not instantiate a negative half-power. Canonical export uses the current grid pair and its changed exponent.

## 4. H110 unit-root projection through gap60

This branch consumes a specified exact unit and a high center whose full complex norm error is at most2^-110. Coordinate-box radii must first establish that norm contract. Direct nearest projection to p50..108 has error less than

    (2^(-k)+3/4)*2^-p <= 2^-p,    k=110-p in2..60.

The low center has norm less than1+2^-p. The integer high coordinate satisfies |A|<=2^110+1. Integrality strengthens the projected range to |M|<=2^p, so p+1 magnitude/p+2 signed bits suffice. Exact low sums use the actual chosen low centers and retain p+2 magnitude/p+3 signed bits.

The generic subtraction A-M*2^k requires113 signed bits, and its double114, before the residual is accepted. The floor-route bound additionally uses its separately checked quotient range |q|<=2^p+1; it is not inferred for an arbitrary witness from the desired final residual. Then |q*2^k|+r<=2^110+2^(k+1)-1<2^111 through k60. Its60-bit remainder and61-bit double fit eight bytes. Only after acceptance may the signed residual and doubled residual use61 and62 bits respectively.

The existing14-byte high-magnitude and15-byte raw templates remain sufficient, with longer splitting and remainder proofs charged. This does not authorize repeated projection or moving projection through negation or conjugation at ties. It does not apply to Gauss root numbers, Hardy/Gamma phases or nonunit transformed kernels. Identity counts and precision demand remain unknown. The symbolic demand bound by59 times the identity count is not a cache inventory or price.

## 5. Independent evidence and limits

The reviewer read the complete frozen author paper, script and receipt, and checked the tensor, normalized context, subgrid, unit-root projection and signed-grid interfaces at their pinned versions. The earlier tensor source was authored by this integration agent; its independent acceptance is zero-sum review EC2FD856. This review does not reattribute that independent review to the present agent.

The new checker is `integration/review_future_p50_exact_tensor_20261111.py`, SHA256 `40C7605FE0E23E75CC6703201401E4F26CF4BAE109C7348A645F93B9BEB63576`. Its first execution passed43 fixed checks. The4421-byte receipt is `integration/review_future_p50_exact_tensor_20261111.json`, SHA256 `F4F8A6EBA1C4C1CF084D48E111A5D8C37E16F66E2EBC1F7E00FCC4DA3C71E26E`.

Checks comprise frozen hashes, symbolic polynomial identities, rational endpoint/capacity inequalities and the exact complete-radius comparison. They do not enumerate candidate precisions or use an assignment, conductor inventory, producer value or author program import. No builds, declarations, proof emission, mathematical function values or frozen edits occurred. Quantified reasoning above supplies the full-range proof; the finite checks do not substitute for it.

The result is a sound conditional paper interface. Ordinary proofs, p-specific producer/cache bindings, actual sample enclosures, complete signed witness costs and successful sign/count certificates remain open. No new assignment, cost reduction or production choice is accepted here.

## 6. Frozen input ledger

All paths below are relative to `work/qrh-campaign/agents`, except the explicitly named blueprint input.

- `audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md`: `8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD`.
- `audit/REVIEW_SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md`: `56B27935FF994E3F25F735825196076DF72C8DBC33D2A61D4787B61E3BBDD5F0`.
- `independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md`: `412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7`.
- `independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md`: `B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266`.
- `integration/TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md`: `DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C`.
- `prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md`: `8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03`.
- `prime-estimates/SHARED_UNIT_ROOT_CHIRP_PROJECTION_2026-11-11.md`: `01C4FE83F6F642D47977825696B70F308156F5E3B2532EBA75A62255A3B03EEB`.
- `zero-sum/FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md`: `F0B7399E638A7EBD43FE37F9EAAD8DCFB0583FEA785F7425D9DAFF096D464DE6`.
- `zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`: `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`.
- `zero-sum/REVIEW_SHARED_UNIT_ROOT_CHIRP_PROJECTION_2026-11-11.md`: `C1D3C4F7AE61B3A1176BC0792C7F2B27CAEAEEB5BE86080770DEC1438AA586C5`.
- `zero-sum/REVIEW_TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md`: `EC2FD8569DF2D74B758F6FDD9DC58153BD0FF6B662919ECE43B014C0E064BC26`.
- `zero-sum/SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md`: `E2457D3CA0E4436575DBAEA81413D91601312033AC6086233CFB7977D790225D`.
- `zero-sum/future_p50_exact_tensor_selector_20261111.json`: `4EA4510B7552F07E3B38ACEF9A18B5689ACDE47F1CB6DB702960FE6621C94982`.
- `zero-sum/future_p50_exact_tensor_selector_20261111.py`: `6E7B3593AA50756DC3DD70EF17E8D7B92091423D49A0D0EE7147F0186935618F`.
- `work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md`: `EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39`.
