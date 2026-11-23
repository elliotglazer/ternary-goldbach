# Arithmetic cost interface for the subgrid input witness

2026-11-11. Paper and source inspection only, submitted for independent review. This gives a typed arithmetic interface for the already reviewed one-round input converter. It computes no input counts, assignments or price folds and evaluates no source values. No declaration, proof object or build was produced. The numerical template subtotal below is a static expansion of the existing byte-adder formula, not a measurement or complete checker price.

## Source contract and exact witness

The accepted subgrid packet requires the actual assembled input on coordinate grid100, with polynomial and finite-head centers added exactly before one conversion. A small head error alone does not establish that encoding. The raw complex input has norm below8826 under the selected full P20 magnitude and head contracts. Other evaluators need their own admitted source, magnitude, height and grid-export interfaces. The source/grid100 production and exact assembly bills remain unchanged.

For one scalar coordinate n*2^-100 and 80<=p<100, put d=100-p in1,...,20. Supply signed Q and unsigned t, and check

    n + 2^(d-1) = Q*2^d + t,     0<=t<2^d.              (W)

The output is Q*2^-p. The equality implies

    2(n-Q*2^d)=2t-2^d,

which is the nearest-rounding interval with ties toward positive infinity. It works for negative inputs and zero. Two scalar coordinate errors at most2^-p/2 give complex error below2^-p. This input uncertainty is already charged once by the subgrid error contract. The cost interface introduces no additional analytic error term or change to that allocation.

Before checking (W), obtain independent source and candidate ranges

    |n|<2^114,     |Q|<2^(p+14),     0<=t<2^d.

The original actual-input margin proves completeness of this candidate-Q range: nearest rounding gives |Q|<8826*2^p+1/2<2^(p+14). The generic weak n range by itself is not the stated completeness argument. A malformed supplied candidate must pass its range check before that range is used in raw-width reasoning.

The source has115 signed bits, the destination p+15 signed bits, and |Q*2^d|<2^114. Both raw sides of (W) have absolute value below2^115, so116 signed bits suffice for either witness addition. The remainder has d magnitude bits, at most20. No bound on a small accepted residual is used to allocate a raw intermediate.

## Fixed witness schedule and byte-adder core

Use the existing definitions, where w is an unsigned magnitude-bit capacity:

    A(w)=2*ceil(w/8)+1,
    M(a,b)=5*m*n+2*n+1,
    m=max(ceil(a/8),ceil(b/8)), n=min(...).

A(w) is the unsigned addition-with-carry template core. It is not already a signed theorem, a serialized instruction count or a runtime unit. M is included to identify the matched price vocabulary; this converter uses no generic multiplication template. Multiplication by2^d is a checked shift/fold.

For each coordinate perform the following acceptance schedule.

1. Bind n to the original grid100 source coordinate, Q to the proposed grid-p coordinate, and t to its unsigned numeral. Obtain the independent ranges above.
2. Construct or bind the exact power objects2^d and2^(d-1), and the shifted signed value Q*2^d.
3. Verify the signed addition n+2^(d-1)=W_left.
4. Verify the signed addition Q*2^d+t=W_right.
5. Prove W_left=W_right as the same interpreted integer, then apply the nearest-rounding and grid-embedding lemmas to the actual source/output objects.

Each signed addition reduces to one unsigned magnitude-addition equality plus its proved sign/case rule. Same-sign addition is direct. In an opposite-sign branch, the producer supplies the nonnegative magnitude difference and the checker verifies that difference plus the smaller magnitude equals the larger one. That equation supplies the order information; a trusted native comparison is unnecessary. Zero and negative-zero conventions remain part of the representation adapter.

The raw bound is115 magnitude bits, equivalently116 signed bits. Its byte capacity is15, so A(115)=31. Padding the unsigned argument to116 bits gives the same A(116)=31. Therefore the declared complex converter has exactly

    0 generic M cores,
    4 signed witness additions,
    unsigned addition core = 4*A(115) = 124.             (C)

This expands the chosen schedule only. It does not assert a minimal circuit. It does not price source assembly as one of those four additions or charge the converter once per output character. Conversion acts on each assembled residue input before the shared character transform.

## Costs outside the 124 core

For a fully priced complex converter, keep the following separately typed terms. They may share established facts only through actual proof references and valid lifetimes.

| Term | Required work not supplied by (C) |
|---|---|
| Signed-add adapters | Four sign/case/equivalence wrappers, including zero conventions and any magnitude-difference witness generation |
| Shift and power binding | Two checked Q-to-Q*2^d transports; exact power/half-power objects, range and exponent identities |
| Range and digit evidence | Source and destination ranges if not inherited; two exact d-bit remainder bounds; raw addition capacities and numeral validity |
| Equality and source binding | Two W_left=W_right bindings, source and output coordinate identities, finite-height/unit/vector association, and cache or proof imports |
| Analytic embedding | Two nearest-grid consequences and their complex assembly/error transport for this actual input |
| Storage and production | Quotient/remainder discovery, construction of arithmetic witnesses and term objects, storage/access, normalization if required, proof production and checking |

These categories are roles, not permission to duplicate a cost already included in a chosen implementation. Conversely an uncharged role is not free. The later price pass must state what its signed-adder, range and binding prices actually include, so that the same fact or command is counted once when genuinely shared.

Allocating ceil(d/8) byte digits does not prove t<2^d if d is not a multiple of8. The partial high digit needs the corresponding bit bound, or an equivalent ordinary inequality proof. For d<=20 the maximum is three byte digits with a four-bit high digit at d20. Exact concatenation by d bits can cross byte boundaries and needs its fold/shift proof; it is not automatically a byte-pointer operation. The per-p power facts may be reusable, but the two shifted Q values depend on the actual input.

The common-grid output is (Q,-p). Canonical odd-mantissa export, if demanded, requires a checked exact normalization of that current pair and its exponent update. No additional round is needed, but the proof and representation work are not in124. Likewise a native hash or same numerical value is not the required source-to-output identity.

## Alternative schedules, without a free comparison

A direct signed-residual schedule could instead verify R=n-Q*2^d and then compare -2^(d-1)<=R<2^(d-1). Before acceptance R still needs116 signed bits. If one explicitly doubles raw R, the generic bound requires117 signed bits; both capacities still occupy15 bytes. The accepted small residual range cannot justify earlier narrowing.

This alternative starts with one signed subtraction per coordinate, but has two signed bound checks per coordinate. Its candidate interface is two signed-add cores per complex input PLUS four fully priced comparisons, shifts, ranges and bindings. If those comparisons are implemented by natural slack equalities, their additional adders must be included. No saving follows from deleting the comparisons from the bill. Rewriting the residual bound as R+2^(d-1)=t with a checked d-bit t recovers a two-addition-per-coordinate form rather than a free one-addition certificate.

A floor/split route may use the signed-dyadic bridge directly. With the source magnitude occupying at most15 bytes, a conservative scalar macro is

    Split_8(15)+3*A_byte(16)+O(1),
    A_byte(n)=2*n+1.

Thus two such scalar macros have subtotal2*Split_8(15)+198 plus their fixed case terms, before optional canonical normalization and the bindings not included by those macros. This is a conservative sufficient alternative, not a lower bound or a reason to choose it. Split_8 includes the exact low-digit remainder and partial-byte transition. It does not require an arbitrary long-division multiplication witness. Floor quotients and intermediate increments may need their own temporary range rather than the final Q range; the stated16-byte macro capacity safely leaves room. Any tighter implementation must prove and price those widths explicitly.

Producer witness discovery and ordinary acceptance are distinct. The producer may prefer a signed bit split even when the checker uses (W). Its search/construction cost is not credited as zero, and the checker need not execute a trusted division routine.

## Exact branch and later pricing

For100<=p<=108, use Q=n*2^(p-100) exactly. At p100 this is an identity/copy binding; above100 the shift is at most eight bits. The destination fits p+15 signed bits. There is no t, no nearest-rounding error, and no mandatory four-addition charge from (C). The actual shift/copy, numeral/grid equality, range and source transport remain paid. This branch must not instantiate2^(d-1) at d0.

No actual input cardinality is supplied here. A later authorized fold can multiply the typed complex-converter interface by the actual admitted source-input/height union for p<100, and use the separate exact-embedding interface otherwise. It must preserve guards, auxiliary samples, unit order, source identities and cache lifetimes, without charging a shared source input once for every primitive output. All grid100 generation, head production, source20 work, transform cache setup and downstream completion/interpolation/count work remain separate. V_width stays16384 under the accepted source proof. This note adopts no narrower capacity from V_error8828 and makes no net-cost claim.

## Pinned sources

All five hashes were checked. Paths are relative to `work/qrh-campaign/agents/`.

| Source and inspected scope | SHA256 |
|---|---|
| independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md, sections1–3 and6 | B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266 |
| audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md, converter, magnitude and cost scope | 8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD |
| integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md, sections4–5 | DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C |
| prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md, sections1–6 | EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD |
| prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md | 8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03 |

This is a paper interface for later matched pricing. No independent implementation, emitted ordinary proof, stock admission, throughput or successful spectral certificate follows from the static template count.
