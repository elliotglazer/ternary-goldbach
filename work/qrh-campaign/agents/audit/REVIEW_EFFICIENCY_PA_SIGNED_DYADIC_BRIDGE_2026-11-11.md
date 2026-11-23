# Review of the ordinary-PA signed dyadic bridge

2026-11-11. Paper/source review only. No values, digit tables, proof streams, builds, analytic functions or transforms were evaluated. The author and source files remain unchanged.

## Verdict and correction

PASS for the original note together with the separately frozen correction below, at ordinary-proof design scope. The signed arithmetic, asymmetric tie rule and power-of-two split are sound. The source supports the needed natural equalities and order arguments. The 14/14/22 counts are proposed wrapper applications, not complete primitive proof events. Fixed-radix linear bounds describe the number of local proof-template applications; they do not establish linear serialized bytes or measured verification time.

A correction was needed to compose the no-rounding and normalization branches. Section 5 permits an already-on-grid value to retain its original magnitude and exponent e when k=g-e<=0. Section 6 must then normalize using that retained exponent, not universally g. Write the current value as sign times R*2^h, with natural R and h=e on the retained branch or h=g after grid rounding. If R=2^t*U, the canonical exponent is h+t. This also distinguishes the signed grid integer M from its natural magnitude. The correction preserves all arithmetic and macro counts.

I read and hash-verified [CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md), SHA256 `8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03`. It makes this branch correction explicitly and preserves the original bytes. Its operative condition and assignments are unambiguous; under k<=0 the original spacing is at least the requested spacing, so the unchanged value is indeed on the requested grid. It also states the macro-versus-bytes/time qualification. No unresolved correction remains for this bounded scope.

The original reviewed author is [EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md), SHA256 `EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD`.

## Natural equalities suffice for the signed gates

For natural pairs define equivalence by P+N'=P'+N. Reflexivity and symmetry are immediate; transitivity follows by regrouping and natural cancellation. Addition preserves the relation. Multiplication preserves it by distributivity and regrouping. This is a proof using symbolic natural identities; it does not require evaluating four large products for each concrete sign/magnitude multiplication.

For fixed input signs, all but one term in the pair-product formula vanish. Thus a single numerical equality A*B=C, followed by the appropriate fixed symbolic identity, proves the signed product with the XOR sign. Zero causes no exception to semantic equality. Both signs at magnitude zero denote the same pair-equivalence class.

For a positive first operand and negative second operand the sum has pair representation (A,B). If B+C=A, this pair is equivalent to (C,0); if A+C=B, it is equivalent to (0,C). Reversing both signs reverses the resulting sign. In each branch the same equality gives the required natural order via the existential definition of <=. There is no need to verify a separate comparison and then independently compute a subtraction. If A=B, cancellation forces C=0 in either branch. Both resulting signs are semantically allowed internally, but only the designated positive-zero encoding is canonical externally.

These are not uses of truncated natural subtraction as signed subtraction. The pinned source explicitly calls its subtraction truncated and provides `eqsub2` and `eqsub1` only under an addition equality. The proposed equation witnesses avoid that ambiguity entirely.

The magnitude bounds are also valid. An opposite-sign result is no larger than the winning magnitude. Equal-sign addition can require one extra bit, and multiplication retains the actual sum of input widths. A complex subtraction must therefore use its product-width capacity even if the final algebraic expression later cancels.

## Actual PA source and the trust boundary

I inspected [examples__peano.mm1](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/mm0-efficient/toolchain-sources/examples__peano.mm1) at the pinned version. The relevant declarations are ordinary proved identities in that file:

- `addass`, `add4`, `addcan1`, `addcan2` at 2083-2102 justify regrouping and cancellation.
- `mul01`, `mul02`, `mulcom`, `muladd`, `addmul`, `mulass` at 2105-2143 give the zero, symmetry and distributive reductions used by the sign cases.
- `eqsub2`, `eqsub1`, `dfle` at 2161-2175 support the addition-witness interpretation and existential order.
- `mulpos`, `mulne0` at 2409-2415 preserve the distinction between an arbitrary zero-containing product and a product of positive magnitudes.
- `eqdivmod` at 2693 takes both the remainder bound and the exact quotient/remainder equation. `modlt` at 2710 requires a nonzero divisor.
- `powpos`, `powne0`, `pow2ne0` at 5010-5016 supply positivity/nonzeroness. `powadd` at 5024 and the shift identities at 5049-5083 give the symbolic power-of-two transport. These do not require normalizing a huge power into a numeral.

The inspected [hexadecimal example](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1) really does implement a proof-producing recursive successor/comparator around 345-409, followed by digit add/carry and multiplication generators. Its internal branch selection is not itself a kernel proof: the returned proof must establish the advertised comparison. Equality by shared exact numeral syntax is a different case from an unchecked machine comparison.

That example also explicitly declares `h2nlt` and the digit-coercion equations as axioms at 125 and 133-148. They cannot be imported as if already ordinary PA theorems. The author's proposed closed-natural-digit replacements and radix fold lemmas remain necessary. Similarly, source `add-eval` hooks are producer conveniences, not a new accepted arithmetic instruction.

The new pair congruence, sign routing, split fold, floor connection, canonical-output connection and rational/real embedding still need ordinary proofs. Reading the source establishes a credible proof route, not a completed composed theorem or checked implementation.

## Macro counts and omitted work

Under the stated convention of at most two named wrappers per signed operation, the arithmetic is correct:

| Path | Operations receiving wrappers | Bound |
|---|---|---:|
| Four products | 4 products + 2 sums + 1 explicit negation | 14 |
| Cached fixed coefficient | 3 products + 3 sums + 1 explicit negation | 14 |
| Gauss | 3 products + 5 sums + 3 explicit negations | 22 |
| Fixed-coefficient setup | 2 sums + 1 explicit negation | 6 |

The underlying identities agree with the previously reviewed complex formulas. Cache setup is separate from runtime, and every use still needs a binding to the proved cache entries. The sign-bit and branch facts must be checked; they do not come from a producer's description of the operation.

A fixed theorem can package a finite sign case and its pair-semantic consequence. This makes a constant number of named applications plausible. It does not identify that number with MMB opcodes, PA proof steps, substitution work, bytes or elapsed time. Each wrapper first needs a checked proof, and each application has argument/conversion work. Source and output numeral binding, fixed digit libraries and the final complex assembly remain additional costs.

For radix beta=2^b with fixed b>=1, the stated 2n+1 range applications and 3n+1 range/zero-flag applications are reasonable conditional macro counts: one or two fixed digit facts and one fold lemma per digit, with a base case. The fold lemma needs the radix assumptions and exact numeral decomposition. These counts require cached closed digit facts and the proved fold library. Their generation and checking are not free. If radix size varies, constants depending on b cannot be hidden as universal constants.

## Split, rounding and canonicalization

The local right-shift recurrence is correct. With shift j<b, carry c<2^j and digit d<beta, the quantity beta*c+d is below beta*2^j. A quotient digit q_digit<beta and next carry c_next<2^j satisfying

    beta*c+d = 2^j*q_digit+c_next

therefore establish the next division step. All local operands fit the stated fixed-radix size. Initial carry is zero, and induction over the high digits gives H=2^j*q+c. If A=beta^t*H+L with 0<=L<beta^t, then

    A = 2^(bt+j)*q + r,
    r = beta^t*c+L < beta^t*2^j.

This proves the requested full split, including j=0 and an empty low-digit part. The concatenation and induction steps need explicit fold proofs, not just local arithmetic checks. They require O(n) fixed-template applications; a dense whole-quotient multiplication by 2^k is unnecessary.

For k>=1 write A=2^k*q+r and H=2^(k-1). For a positive input the half tie rounds up to q+1; for a negative input it rounds toward positive infinity to -q. When r>H the negative result is -(q+1). Thus all six cases give exactly

    (2M-1)*2^k <= 2*(-1)^s*A < (2M+1)*2^k,

and consequently the signed error interval is

    -2^(g-1) < output-exact <= 2^(g-1).

The strict upper comparison is essential for uniqueness. The complex L1 error bound 2^g follows by adding the two coordinate bounds. It does not erase coefficient or analytic input errors. Zero output is a rounding result unless the input was separately proved zero.

The branch witnesses r+d+1=H, r=H and H+d+1=r prove the threshold comparisons without a machine-order oracle. If k exceeds the magnitude's bit bound by at least one, the symbolic power comparison gives A<H, avoiding materialization of H. Equality with the bit bound needs the ordinary remaining comparison; it cannot be silently sent to the zero branch.

For k<=0 the original value already lies on the requested grid. A symbolic grid-membership proof may retain exponent e and avoid constructing trailing zero digits. This is the branch requiring the normalization correction above. After choosing the actual pair R*2^h, a nonzero magnitude has a finite least set bit. Supplying R=2^t*U with U positive and odd proves value-preserving normalization to U*2^(h+t). At zero, the canonical output is fixed directly and no valuation loop is needed.

One split and a single digit pass avoid repeatedly rescanning the shrinking numerator. The proposed combined subtotal `2Split_b(n)+3A(n+1)+3n+O(1)` is a conservative count of local templates under the stated representation assumptions, plus exponent operations. It is not yet an event-complete proof cost. Repeatedly serializing or unifying length-n prefixes can cost more than linear time or bytes without suitable sharing. The original note's separate term-format and unsigned-template exclusions must stay in any downstream estimate.

Huge exponent gaps remain outside a materialized bounded-numeral claim. Signed exponent arithmetic uses widths of exponent encodings, and symbolic power laws must preserve the exact value. A wire format requiring canonical intermediate values pays normalization at those points. Internal negative zero and common unnormalized grids only avoid that work if the actual protocol permits them.

## Remaining scope

No mathematical oracle is needed for the proposed adapters, but none of the new generic adapters or local digit libraries was implemented or kernel-checked by this review. The full operation count must still include their proved setup, numeral construction/sharing, actual theorem instantiation, cache access, exponent work and endpoint/analytic bindings. This review establishes no new spectral value or complete PA/MM0 proof, and no runtime estimate.

## Verified original pins

| Artifact | SHA256 |
|---|---|
| Author bridge | `EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD` |
| Author current-exponent clarification | `8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03` |
| `work/mm0-efficient/toolchain-sources/examples__peano.mm1` | `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079` |
| `work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1` | `76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94` |
| `moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md` | `EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B` |
