# Review of the subgrid converter cost interface

2026-11-11. PASS at paper-interface scope. The four-signed-addition schedule, conservative raw widths and124 unsigned-adder core subtotal are consistent with the reviewed converter and signed arithmetic bridge. No correction to the frozen author is required. This is neither a complete instruction count nor a Lean/MM0 cost or performance estimate.

Reviewed author: `zero-sum/SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md`, SHA256 `E2457D3CA0E4436575DBAEA81413D91601312033AC6086233CFB7977D790225D`. I read the full note, its five pinned inputs at the relevant interfaces, and the signed-dyadic current-exponent clarification. All six hashes match. No inventory, price fold, arithmetic-value experiment, build, declaration or proof emission was performed. Frozen files remain unchanged.

## Witness and independent raw capacities

For d=100-p in1..20 the checked equation is

    n + 2^(d-1) = Q*2^d + t,    0<=t<2^d.

Subtracting the common terms gives `2(n-Q*2^d)=2t-2^d`, hence the correct closed-lower/open-upper residual interval. In particular a negative half tie rounds toward positive infinity. Canonicalizing a resulting negative zero is a representation step, not a second numerical rounding. Both complex coordinates have error at most half an ulp; their Euclidean combination is below one ulp, exactly as in the accepted analytic input adapter.

The independent supplied ranges are essential. With |n|<2^114, |Q|<2^(p+14) and t<2^d, the shifted |Q*2^d| is below2^114. Each raw side is then below2^115 in absolute value. The claimed115 magnitude bits or116 signed bits are sufficient before the equality is proved. A producer cannot use the eventually small residual to bypass those range checks.

The source bound below8826 establishes that correct nearest rounding has |Q|<8826*2^p+1/2<2^(p+14). This proves completeness of the proposed candidate range. It does not prove that an arbitrary supplied Q satisfies it before validation. The original source coordinate uses115 signed bits and the destination uses p+15. These statements agree with the independently reviewed input contract.

## What the124 subtotal counts

For each coordinate the selected schedule proves two signed additions, builds or binds their outputs, and then proves the two resulting interpreted integers equal. The existing signed bridge can implement each signed addition with one unsigned magnitude-addition equality. In an opposite-sign case the nonnegative difference witness plus the smaller magnitude equals the larger one. That same equality establishes the needed ordering; no trusted native comparison is required.

All unsigned values in that equality fit the conservative115-bit magnitude bound. Since ceil(115/8)=ceil(116/8)=15, the template A(w)=2*ceil(w/8)+1 gives31 in either padding convention. Four such calls give124 unsigned core units. No generic M multiplication is needed for the power-of-two shift. This is a sufficient schedule, not a proof that four calls or124 units are minimal.

The author's four signed-add adapter entries are four roles. They are not a demonstrated total of four existing named theorem applications: the cited signed bridge allows up to two wrapper applications per gate, or a composed adapter would itself first need an ordinary proof. This reading follows the author's explicit statement that the extra categories are roles, not complete prices. It leaves the124 unsigned core unchanged. Sign/case routing, zero conventions, interpreted equality, source association and theorem instantiation remain outside that core.

Equality of the two raw outputs is not automatic from matching numerical claims. A checker needs the same canonical object or a proved equality/representation bridge. The note explicitly charges this binding. Similarly, exact shifting is not a free pointer move when d crosses byte boundaries. Power identities, concatenation or bit-fold proofs and range transport remain required.

## Range, split and alternate schedules

The partial-byte caveat is correct. Three byte slots alone do not prove t<2^20; the high slot must be bounded by four bits. The general d-bit remainder and numeral-validity obligations remain, even if existing source facts discharge some of them without new arithmetic calls. Reusable per-p constants and proofs do not make the actual two shifted Q values reusable constants.

The residual alternative begins with R=n-Q*2^d. Independent operand ranges bound |R|<2^115, hence116 signed bits; doubling it before acceptance needs117 signed bits. These both occupy15 bytes. Its two comparisons per coordinate still require ordinary proofs. If implemented by slack equalities, the associated adders must be priced. Rewriting the bound as R+2^(d-1)=t recovers a two-addition schedule per coordinate; the small accepted R cannot justify a free comparison or narrow earlier arithmetic.

The separate split route faithfully instantiates the conservative signed-dyadic macro. A15-byte input yields `Split_8(15)+3*A_byte(16)+O(1)` per coordinate. Since A_byte(16)=33, two coordinates have the stated198 adder subtotal plus two splits and their fixed case terms. This is not a competing complete price: split/fold transitions, local range proofs, signed cases, source binding and optional normalization remain charged. The16-byte intermediate allocation safely covers increments beyond the input capacity.

Optional canonical odd-mantissa normalization uses the current pair `(Q,-p)` and updates its exponent after exact factor removal. It introduces no new approximation but does introduce work. The cited clarification correctly distinguishes this current pair from any retained original finer-grid pair. No unproved integer floor, arbitrary division or normalization opcode is assumed.

## Exact branch and scope of later use

At p100 the converter is an exact identity/copy binding. At p>100 it is an exact shift by at most eight bits. Neither branch has the remainder t or the four-addition rounding schedule. Substituting d=0 into the half-power formula would be invalid, and the author explicitly excludes it. Actual source/grid equality, shift, range, storage and proof-reference work remain payable.

Conversion counts must attach to actual assembled residue inputs and source heights, with shared samples counted once, rather than to every primitive output character. No such count is supplied here. Full grid100 source/head production, exact initial assembly, source20 work, caches and downstream normalization/interpolation/count work remain separate. The selected full P20 source and magnitude contracts are sufficient; other evaluators need their own admitted interface. The error contract still uses V_error8828 and capacities retain V_width16384.

The cost interface therefore may be consumed as a typed component in a separately authorized matched comparison. It supplies no new precision assignment, source data, successful sign, Turing certificate, complete proof-byte count or backend timing. In particular, four signed additions do not mean four MM0 commands,124 template units do not mean124 complete commands, and fixed local wrappers do not prove constant serialization or elaboration cost.

## Verified input pins

Paths are relative to `work/qrh-campaign/agents/`. The author pin is given above.

|Input|SHA256|
|---|---|
|independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md|B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266|
|audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md|8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD|
|integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md|DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C|
|prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md|EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD|
|prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md|8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03|
