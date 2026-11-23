# Smaller converter capacities from the reviewed finite-EM magnitude

2026-11-11. Conditional mathematical and arithmetic-cost interface. This successor uses the reviewed actual raw-input norm below 690 to narrow the existing one-round converter. It preserves the source vector, rounding rule and error charge. No inventory, pricing fold, precision selection, function evaluation, build, declaration or proof emission was performed. All predecessors remain unchanged.

## Input and admissible use

The source is the actual assembled complex input on coordinate grid 100: an admitted full-P20 polynomial center plus its finite-head center, added exactly. The reviewed square-root finite-EM packet gives polynomial magnitude below 173 uniformly over its five bands. The finite-head center is below 517, so the assembled norm is strictly below 690. This is a bound on stored centers, not a claim about source accuracy or a newly computed value.

The same source, height, coefficient, alpha-error, head-error and exact grid-export obligations remain. In particular, a head error radius does not establish a grid-100 encoding. The magnitude-only minimum-grid premise in the source packet does not admit a new accuracy profile. No extra source premise or preliminary round is introduced by this converter.

For either source coordinate write its value as n*2^-100. Then

    |n| < 690*2^100 < 2^110.

We derive the arithmetic interface for every integer p in [50,108]. This wider range is not an analytic admission of p below the range of an existing transform selector. Such a choice still requires a separate complete-error inequality, actual-input contract and safety/peak proof.

## One-round branch: 50 <= p < 100

Set d=100-p, so 1 <= d <= 50. Supply a signed integer Q and an unsigned integer t and check

    n + 2^(d-1) = Q*2^d + t,     0 <= t < 2^d.       (W)

The output coordinate is Q*2^-p. The equality gives

    -2^(d-1) <= n-Q*2^d < 2^(d-1).

Thus (W) is the same deterministic nearest-rounding rule as the predecessor, with half ties toward positive infinity. It works for negative n as well as positive n and zero: at a half tie the source-minus-output residual is the negative endpoint. There is no sign-dependent change of convention. An optional representation change from negative zero to zero is exact and separately justified.

Each coordinate error is at most 2^-p/2; the Euclidean complex error is at most 2^-p/sqrt(2), hence strictly below 2^-p. This is the existing single input-regrid error. It must be charged once through the exact character operator, not added again to a source/head radius or multiplied by the intrinsic arithmetic constant.

### Candidate completeness and independent validation

A correct witness always exists: take the integer floor of (n+2^(d-1))/2^d and its nonnegative remainder. This mathematical existence argument does not install a trusted floor/division instruction in the checker. A producer may use any discovery algorithm; acceptance checks the supplied equality and ranges.

For that correct Q, the actual center bound and nearest-rounding inequality give

    |Q| <= |n|/2^d + 1/2
        < 690*2^p + 1/2
        < 1024*2^p = 2^(p+10).                     (1)

The last inequality holds throughout p >= 50, since (1024-690)*2^p > 1/2. The substantial margin from 690, rather than the weak bit bound on n alone, proves completeness of this strict destination range.

Before using narrower raw capacities for an arbitrary supplied witness, require checked or inherited facts

    |n| < 2^110,   |Q| < 2^(p+10),   0 <= t < 2^d.

A malformed Q cannot borrow (1) before (W) has been proved. Its range must be validated independently. Likewise the source n must be bound to the actual source object, not merely to an unrelated small integer. These checks ensure, before acceptance,

    |Q*2^d| < 2^110,
    |n+2^(d-1)| < 2^110 + 2^49 < 2^111,
    |Q*2^d+t| < 2^110 + 2^50 < 2^111.             (2)

No small accepted residual is used to bound a raw intermediate. All operand magnitudes, result magnitudes and opposite-sign difference witnesses in the two additions fit the conservative 111-bit unsigned magnitude capacity.

| Object | Sufficient capacity, including a separate sign where applicable |
|---|---|
| Source n | 111 signed bits |
| Destination Q | p+11 signed bits |
| Shifted Q*2^d | 111 signed bits |
| Either raw witness-addition result | 112 signed bits |
| Remainder t | d unsigned bits, at most 50 |

Here “signed bits” means magnitude capacity plus one sign bit, as in the predecessor interface; it is not an assumption about a native signed-integer representation. Raw signed capacity 112 fits fourteen bytes. The rounded destination has at most 110 signed bits because p <= 99.

## Matched unsigned-adder core

Retain the same schedule: per coordinate, prove the two signed additions in (W), bind their resulting interpreted integers by equality, and derive the rounding consequence. Each signed addition uses one unsigned magnitude-addition equality plus its proved sign/case adapter. In an opposite-sign case, the nonnegative difference plus the smaller magnitude equals the larger magnitude. This supplies order information without a trusted comparison oracle.

The inherited unsigned template is

    A(w) = 2*ceil(w/8)+1.

Both 111 magnitude bits and a conservative padding to 112 bits use fourteen bytes. Therefore

    A(111) = A(112) = 29,
    four signed-addition roles have unsigned core 4*29 = 116.

This replaces the predecessor's 124 core units for this matched schedule under the stronger actual-input bound. The local difference is eight unsigned template units per rounded complex input. It is not a complete cost, a command count, a runtime saving, or an aggregate change. Four signed roles do not mean four theorem applications: the actual signed wrappers and their instantiations remain separate.

There is no generic multiplication core in (W). Multiplication by 2^d remains an exact checked shift/fold. It is not a free pointer operation. The complete conditional cost retains

    116 + C_signed + C_shift/power + C_ranges
        + C_equal/source + C_embedding + C_storage/production.

These are named roles to be matched to the implementation without charging the same established fact twice. They are not asserted constant prices. In particular:

- Two actual shifted Q objects, the powers and half-powers, and their exponent/grid identities remain bound and checked.
- Source, candidate, raw-capacity and numeral-validity evidence remains required. At d=50 the remainder may use seven bytes, but its high byte must be bounded by two bits. In general ceil(d/8) bytes do not prove the d-bit bound.
- The two raw output equalities, actual coordinate associations, vector/height/unit bindings and complex error transport remain required.
- Quotient/remainder discovery, witness construction, representation conversion, proof references and any canonical odd-mantissa normalization remain outside 116. Exact normalization uses the current pair (Q,-p), not the source exponent.

No alternative converter algorithm or its price is selected here. Increased d can change shift/range costs, so even the smaller unsigned core alone proves no complete-converter improvement across different precisions.

## Exact branch: 100 <= p <= 108

Set Q=n*2^(p-100) exactly. Then |Q|<2^(p+10), so p+11 signed bits suffice. At p=100 this is an identity/source binding; above 100 it is a shift by at most eight bits. At p=108 the destination may require 119 signed bits, so the fourteen-byte raw-addition claim from the rounding branch must not be applied to the exact output representation.

This branch has no t, no nearest-rounding error and no mandatory four-addition charge. It must not instantiate 2^(d-1) with d=0. Actual shift/copy, numeral validity, destination range, grid equality and source transport remain paid. No additional rounding is needed in either branch.

## Scope and source pins

This is a drop-in converter-capacity lemma conditional on the reviewed raw-input bound, not an adoption of a new transform width, input cardinality, cached object or p assignment. The narrower converter alone does not narrow internal transform peaks. Actual p-specific cache and complete-error proofs still determine admission. Conversion counts, if later authorized, attach to assembled residue inputs and heights rather than to primitive output characters. Source20 production, exact head assembly, guard work and downstream completion/counting remain separate.

All seven hashes below were checked read-only. Paths are relative to work/qrh-campaign/agents/. No scalar program or receipt was needed: every comparison is displayed above.

| Source | SHA256 |
|---|---|
| audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md | 03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904 |
| prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md | 1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328 |
| zero-sum/SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md | E2457D3CA0E4436575DBAEA81413D91601312033AC6086233CFB7977D790225D |
| audit/REVIEW_SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md | 56B27935FF994E3F25F735825196076DF72C8DBC33D2A61D4787B61E3BBDD5F0 |
| independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md | B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266 |
| prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md | EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD |
| prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md | 8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03 |
