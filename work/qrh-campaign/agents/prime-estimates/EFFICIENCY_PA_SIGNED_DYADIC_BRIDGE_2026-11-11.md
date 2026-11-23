# Signed dyadic arithmetic from ordinary-PA natural witnesses

2026-11-11. Paper/source proof design only. No arithmetic values, proof stream, digit table, analytic function or transform was evaluated. No build or Lean source edit was made. The finite case lemmas and encoders below remain implementation work; their statements are not new axioms.

## Main result

An opposite-sign addition does not require a separate large comparison and a separate subtraction computation. Supply a nonnegative magnitude C and verify either B+C=A or A+C=B using the existing unsigned adder. The same equality proves which magnitude dominates and proves the signed sum. Cancellation C=0 is included.

Thus the missing signed layer can be implemented with the **same one unsigned product or addition proof per arithmetic gate**, plus a bounded number of fixed sign/case lemmas. Canonicalization, bound validation, comparison and final rounding can be charged separately with linear-in-width templates. This does not assert that the previous unsigned A(n) was already a signed subtraction theorem; it specifies the missing adapter and its premises.

A useful internal representation permits negative zero and unnormalized dyadics. It avoids repeated zero scans and trailing-zero normalization. Only externally required canonical values are normalized. If a wire protocol demands canonical intermediate values, those linear normalization costs must instead be paid at every such value.

## 1. Semantics without assuming an integer arithmetic oracle

Represent a signed magnitude by (s,A), where s is a literal bit and A is a natural number. Its pair interpretation is (A,0) for s=0 and (0,A) for s=1. Define equivalence of pairs (P,N) and (P',N') by the ordinary-PA equation

    P+N'=P'+N.

Addition of pairs is componentwise. Multiplication is (PP'+NN',PN'+NP'). Commutativity, distributivity and natural cancellation prove that equivalence respects these operations. This gives the required signed identities entirely through natural equalities. It need not first construct a quotient sort or import an unproved integer evaluator.

Both (0,0) and (1,0) represent zero. Accepting that internal equivalence is harmless; confusing it with a canonical wire encoding is not. Canonical exported zero has sign0, magnitude0 and exponent0. A nonzero canonical exported magnitude is positive and odd after normalization.

A dyadic additionally has a signed exponent e and denotes the signed magnitude times2^e. Equality/error inequalities can be expressed by clearing positive powers of two, or handled by generic rational-embedding lemmas. Power positivity is proved. A real/complex consumer still needs that embedding and its own analytic enclosure hypotheses; a PA center equality alone does not certify a special-function value.

## 2. Gate witnesses, including every sign and zero case

**Product.** Check the unsigned equality A*B=C. The output sign is s XOR t, verified by the four-entry bit truth table. Expansion of the pair product has only one nonzero possible term and proves the signed result. If C=0, either output sign denotes zero, so internal correctness needs no new magnitude comparison. When canonical output is required, convert this zero to sign0. Positivity, if needed, follows from the input positivity and `mulpos`, not an assumed nonzero product.

**Equal-sign sum.** Check A+B=C. Use the common sign. This covers positive/positive and negative/negative, including a zero operand. A negative zero output is allowed internally and canonicalized if exported.

**Opposite-sign sum, first magnitude wins.** Check B+C=A and use the first sign. Substituting this equation into the pair equivalence proves the signed sum. It also implies B<=A via the definition of natural order. No separate test of A>=B is required.

**Opposite-sign sum, second magnitude wins.** Check A+C=B and use the second sign. This proves the other branch, again without trusting a producer comparison. If A=B, only C=0 can satisfy either branch; natural cancellation proves uniqueness of the magnitude. The two branch choices then represent the same zero.

**Subtraction.** Flip the second sign and apply signed addition. Flipping zero may create negative zero internally, which has already been given exact semantics. With canonical intermediates, the zero branch must be normalized instead.

An attempted wrong winner, negative difference encoded as a natural, changed output magnitude or inconsistent sign is rejected by these equations and finite sign rules. A generic signed comparison is not silently used as an oracle. A producer may compute differences natively to propose witnesses, but acceptance is the unsigned equation plus the proved adapter.

The result magnitude in an opposite-sign sum is at most max(A,B); an equal-sign sum may need one extra bit. A safe adder call can therefore use the previously allocated output-width bound for all cases. Products use the actual two input widths. In particular, complex output subtraction is still a product-width operation, not an input-width operation.

## 3. What can be counted already

Take the earlier unsigned templates M or R for a product and A(n)=2n+1 for a bounded addition, with their existing representation exclusions. A signed gate requires exactly one such numerical equality. Implement one fixed finite-case routing lemma and one pair-semantic bridge per product, sum or negation. This is at most two **named wrapper applications** per gate; it is not a claim of two MMB opcodes or two primitive PA proof steps. Each wrapper must first have an ordinary proof. Its instantiation/unification costs remain real.

Under this explicit wrapper convention the additional sign-routing applications for one complex gate are:

| path | unsigned products | signed sums | explicit sign flips | wrapper applications |
|---|---:|---:|---:|---:|
| four products |4|2|1|14|
| cached fixed coefficient |3|3|1|14|
| Gauss |3|5|3|22|

The fixed coefficient cache additionally uses two signed sums and one sign flip, at most6 wrapper applications plus the two already priced unsigned setup adders. These counts exclude initial sign-bit validation, final complex assembly and rounded output. They are proposed macro counts, not measured proof-event counts. Fusing a sign flip into a branch may reduce them; no such reduction is claimed here.

If an existing numerical template already carries valid digit/range facts, these wrappers reuse them. Otherwise, a radix-beta numeral with n digits can acquire its range proof by n digit-bound references and n fold-bound lemmas, plus one base lemma: at most2n+1 named applications. The fold lemma is

    A<beta^j and d<beta => beta*A+d<beta^(j+1).

A combined zero/positive flag can be propagated in the same pass. Allowing an additional digit zero/positive reference gives a conservative3n+1 applications. These counts presume cached closed digit facts and proved fold lemmas; generation/checking of those libraries and numeral binding must be charged separately. They do not require a beta-by-beta multiplication or comparison table.

Consequently the **signed semantic overhead** is constant per gate once its bounded natural equality is available. Canonical/range/encoding overhead is linear in the new numeral widths, not a second multiplication. This separates a concrete signed adapter from the still implementation-dependent representation cost of the unsigned Karatsuba templates.

## 4. Comparison and low-bit extraction without hidden division

When an actual order result is needed, a natural witness supplies it: A<=B follows from A+d=B; A<B follows from A+(d+1)=B. The latter can be checked with one successor proof and one unsigned addition. The reverse inequalities exchange A,B. Equality is a bound input equality. This avoids trusting the producer's branch decision.

Alternatively the pinned digit comparator propagates the first differing digit's order through the remaining radix positions. Its source proof generator uses one small-digit order fact and a linear chain of radix-order lemmas, with equality-prefix binding. Neither option is an unproved machine comparison. A fully tabulated large-radix order library is optional and must be priced if used.

For division by2^k, prove

    A=2^k*q+r, 0<=r<2^k.

This should use a digit split, not a generic multiplication of the whole q by a dense2^k numeral. Write k=bt+j with0<=j<b. The low t digits are retained; a partial boundary shift handles j. A most-significant-digit pass for a j-bit right shift has carry c<2^j and local certificate

    beta*c+d = 2^j*q_digit+c_next,
    q_digit<beta, c_next<2^j.

Every local number has at most2b bits. A local product by2^j, addition, and small bounds prove the transition. Accumulating these transitions and the unchanged low-digit concatenation proves the global split; division correctness then follows from `eqdivmod`. There are O(n) transitions for an n-digit magnitude, no n-by-n multiplication. For fixed b write its cost as Split_b(n)<=c_b*n+c'_b, where c_b charges these concrete at-most2b-bit arithmetic and fold lemmas. This is a defensible linear bound, not a numerical guess for the unimplemented encoder.

No arbitrary exponent gap is expanded. If k exceeds the magnitude bit bound, q=0 follows from that bound and a power comparison. If an exact alignment or left shift would allocate an enormous integer, keep a symbolic exponent/shift certificate or reject that materialized representation under its cap. A compact dyadic format is not permission to materialize an enormous common denominator.

## 5. Ties toward positive infinity: exact final-rounding cases

Let the exact coordinate be (-1)^s*A*2^e and the required output grid be2^g. Put k=g-e. If k<=0, the coordinate already lies on that grid and there is no rounding error; the output dyadic may retain its original exponent instead of materializing trailing zeros. A format requiring the full grid mantissa must separately allow and price that shift.

For k>=1, use the split A=2^k*q+r, 0<=r<2^k, and H=2^(k-1). Round the magnitude and retain the sign as follows:

| sign | r<H | r=H | r>H |
|---|---|---|---|
| positive |q|q+1|q+1|
| negative |q|q|q+1|

Thus the negative tie has a different branch: -1/2 rounds to0, while +1/2 rounds to1. The rule is exactly floor(y+1/2), not truncation toward zero and not an odd rounding map. When a negative coordinate rounds to magnitude zero, canonical output has sign0.

Classify r relative to H using the positive equations r+d+1=H, r=H, or H+d+1=r. Each strict branch needs at most one successor and one bounded unsigned addition. The positive branch could also inspect only the highest discarded bit, but the witness equations make every tie explicit. If k exceeds the raw bit bound by at least one, A<H follows directly and the result is zero; the checker must not allocate the huge H just to rediscover this fact.

For the selected signed integer M, the branch equations imply

    (2M-1)*2^k <= 2*(-1)^s*A < (2M+1)*2^k.

Interpreting signed products through pair semantics proves the usual floor interval. Therefore the coordinate error satisfies

    -2^(g-1) < output-exact <= 2^(g-1),

and its absolute value is at most2^(g-1). Two coordinates give the rational L1 complex-error bound2^g. The analytic input/coefficients' errors are then added exactly as in the accepted complex-product note; they do not vanish because the center arithmetic is exact.

For raw n-digit coordinates in the materialized bounded case, this procedure costs one Split_b(n), at most two A(n+1) calls for the strict threshold witness, one A(n+1) call for q+1, and a fixed case/rounding lemma. Thus a conservative subtotal is

    Split_b(n)+3A(n+1)+O(1),

before canonical normalization. The actual cases often need fewer adders. This prices rounding rather than treating an abstract real floor as a computed function.

## 6. Final normalization and exponent work

At zero output use the unique exported triple(sign0,magnitude0,exponent0). For nonzero M, supply t>=0 and positive odd U with M=2^t*U, then output (sign,U,g+t). One power-of-two split with zero remainder proves the identity; the low bit proves oddness. A finite scan through the magnitude's digits finds such t, and t is below its bit width. Negative values use the same natural magnitude, so there is no negative-division convention to guess.

This is one linear split/normalization proof, not a repeated loop which rescans the entire shrinking numeral at every trailing zero. A further Split_b(n)+3n+O(1) bound covers the split plus zero/positive and odd/canonical binding. Combined with rounding, an explicit conservative overhead is

    2Split_b(n)+3A(n+1)+3n+O(1),

plus exponent arithmetic and already excluded term-format handling. It is linear in n for fixed radix. Canonicalization changes no value and introduces no extra error.

The common-grid complex products share the exponent sum e_input+e_coefficient; it need only be checked once per gate. Final grid differences and the two output exponent increments are signed-integer operations of width determined by the exponent fields, not by the magnitude's numeric exponent. They use the same natural-witness signed-add method, without recursive dyadic exponents. Their O(exponent-bitlength) cost must be recorded. Normalizing intermediate values instead would change these exponent paths and add their own costs.

## 7. Implication for D4, Df and Dg

The previous opaque terms can now be split into: fixed sign-wrapper applications14/14/22; the linear range/canonical binding actually required by the representation; two linear final-rounding/normalization passes at the correct P+Q+guard widths; small exponent operations; and the remaining unsigned-template/numeral/unification overhead. Fixed-coefficient setup adds6 wrappers, its two unsigned adders and any required canonical cache binding.

This is not a claim that D4=Df=Dg or that they are zero. Gauss has more wrappers and may have wider raw rounding inputs; canonical-per-gate formats add more scans. Conversely, an internal sign/magnitude circuit with negative zero and shared grids need not pay a full comparison or normalization at every subtraction. These are checkable architectural choices, not numerical assumptions about signs or cancellation.

## Source ledger and proof status

Pinned MM0 snapshot revision0d414c0bfdaaeb7fea571895127abc1fa5a3d956:

* `examples__peano.mm1`, SHA256 13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079: addass/add4 at2083/2094; addcan1/2 at2097/2102; mulcom2120, muladd/addmul/mulass2131/2140/2143; eqsub2/1 at2161/2163; dfle2175; lt01 at2268; mulpos/mulne0 at2409/2415; eqdivmod2693, divmod2700, modlt2710; powadd5024; shift definitions and lemmas5049--5083; bit interpretation and elmodpow2 through5113. The truncated natural subtraction is explicitly not signed subtraction.
* `examples__peano_hex.mm1`, SHA256 76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94: successor/linear comparison345--409, digit add/carry418--508, multiplication526--587. Its hex-coercion axioms are not imported as PA proofs: use the previously proposed closed-natural-digit replacements and prove their radix adapters.
* `moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md`, SHA256 EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B, supplies the previously reviewed mathematical floor/tie and normalization contract. This note specializes its arithmetic to sign/magnitude natural witnesses and power-of-two splits, rather than claiming its Lean APIs are ordinary-MM0 implementation.

The new pair adapters, branch routing, split fold, rounding soundness and canonical-output connection need ordinary proofs and concrete encoders. The source interfaces above justify the proposed proof route; this source reading does not validate an implementation, execution time or any spectral certificate.
