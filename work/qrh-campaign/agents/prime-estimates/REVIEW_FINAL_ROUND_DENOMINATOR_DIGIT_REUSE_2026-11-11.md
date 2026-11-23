# Independent review: fixed-denominator final rounding

2026-11-11. **PASS at conditional paper, source-interface and exact-metadata scope; no correction requested.** The report gives a sound specialization of the existing proved-table/prefix design to a conductor-fixed rounding denominator. It establishes neither implemented ordinary-rule acceptance nor a total-cost improvement. The b100 coefficient adapter and its mixed-evaluator clarification remain explicit inputs with their own acceptance gate.

## Frozen packet

- Author: zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md, SHA256 `E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF`.
- Script: zero-sum/final_round_denominator_digit_reuse_20261111.py, SHA256 `C0ADE08ECDFBDCFF23467DA2690B7C1F6F9AF4B2B9A606A0E8D75DDEB6AB4350`.
- Receipt: same stem JSON, SHA256 `3E3147A9D7FABFC68361C8764450D5EB548C167BCC44A46D54B746FF8DA999A0`.

I read the full report, script and receipt without importing or executing the author program. I also read the P27 fixed-step report and review, the prior digit-table and signed-dyadic papers, and the full coefficient-grid closure plus mandatory mixed-evaluator clarification. The independent checker verifies all six predecessor hashes recorded by the author as well as the three packet hashes. No source or frozen artifact was edited.

## Exact rounding and object binding

The actual b=g100 cancellation is correct: input coordinate I/(2^100 Q), output m/2^100 and Q=(2c)^19>0 give m=floor(I/Q+1/2). Once one signed product p=mQ is proved, R=I-p satisfies the exact acceptance condition -Q<=2R<Q. Dividing by positive2Q gives m-1/2<=I/Q<m+1/2, which is precisely ties toward positive infinity. At I/Q=-1/2, m=0 has R=-Q/2 and passes, while m=-1 has R=Q/2 and fails. The positive half tie similarly selects1. Zero is covered. A residue congruence alone would not give this result.

The complex error claim follows from two coordinate errors <=2^-101: their Euclidean norm is at most sqrt(2)*2^-101<2^-100. Q is even, so the equivalent half-denominator test is available after an exact factor-two identity. There is only one general mQ product; endpoint expressions need not be independently multiplied. The signed residual may have wide operands even though its accepted value is small.

The report correctly binds degree19, conductor, Q power equality, the exact numerator and the b=g grid relation. Its six-product exponent-chain example is valid: v^2,v^4,v^8,v^16,v^18,v^19. Reusing the initialization's geometry proof can avoid duplication only when the exact cache object is retained. The b122 case cannot silently use this same divisor without its additional power-of-two adapter.

The coefficient closure at `9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4` supplies a quantified margin, rather than merely adding rounding to a sharp2^16 bound. Its mandatory clarification `B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815` restricts1477u_H to all-adapter evaluation and retains1688u_H for arbitrary mixtures with original-center Horner. The reviewed report states both distinctions correctly. This review uses that interface conditionally; it does not replace its independent source/error audit.

## Ordinary arithmetic table and widths

The recurrence T[d+1]=T[d]+Q proves T[d]=dQ by induction from T[0]=0 and multiplication distributivity/successor. Processing the actual radix256 digits of |m| maintains V=Qp, where p is the processed prefix. The next equality is 256V+T[d]=Q(256p+d). Together with the checked digit decomposition and signed-magnitude adapter this proves mQ. A wrong table entry, digit or denominator cannot be hidden by a digest: the theorem application must bind those actual terms.

This is the already reviewed P27 fixed-step method, not a newly claimed general table algorithm. The new reuse is stronger in one precise respect: Q is independent of height, fine anchor, coefficient array and coordinate. One conductor table can serve all those output products within its actual checked lifetime. This does not make coefficient-prescale tables conductor-independent or remove their separate costs.

The output-width derivation is sound. At consumed |h|<=1/4, the quantized polynomial is below(4/3)2^16, with enough explicit margin that nearest output rounding gives |m|<2^117. At c<=265800, Q has at most362 bits. Hence table entries have at most370 bits and products/prefixes at most479 bits, fitting47 and60 byte-digits; the factors themselves fit46 and15 digits. The shifted prefix before adding the next nonnegative table entry is bounded by the next prefix product. The60-digit claim requires the sharper bit bounds; arbitrary46-by15-digit factors could require61 digits. The author explicitly preserves that distinction. Signed residual formation and comparisons are not assigned these unsigned product widths without further proof.

I checked the actual PA interfaces at `examples__peano.mm1`: addcan1/2:2097/2102, muladd/addmul/mulass:2131/2140/2143 and eqdivmod:2693. Its SHA is `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`. The successor product proof pattern `decmul_lem` is at peano_hex.mm1:526, SHA `76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94`. The existing PA-only plan must still replace the hex coercion axioms with proved numeral/radix interfaces. Actual verifier.c:470–511 applies a checked theorem through argument/target unification; SHA `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`. These sources support the ordinary proof route, not an already implemented specialized checker.

## Counts and end-to-end limits

I independently reconstructed the declared skeleton by summing its rows:

    table product =15+14*(2*60+1)+14=1723,
    schoolbook =15*(5*46+2)+1=3481,
    setup =255*(2*47+1+2)+4=24739.

The difference is1758 per scalar product. Fourteen uses save24612, insufficient for setup; fifteen save26370. Thus15 scalar uses, or8 complex outputs with two charged coordinate products, is the first strict crossover for this subtotal. It is not a complete proof-cost crossover. The raw256-by47-digit payload is12032 bytes, with no claim that this includes proof terms or fits a complete stock-MM0 pack.

The full comparison correctly separates native generation, proof construction and checking. In particular, discovering the rounded quotient remains work; proving its product with Q by lookup does not perform division for free. Digit decomposition, unification, signed residual/order proofs, term creation, lookup transport and storage can differ between methods. Direct multiplication can strip known powers of two or exploit a smaller conductor too. A robust improvement needs actual prices, or a new-method upper bound against an old-method lower bound, rather than comparing unrelated upper estimates.

The cache lifetime is adequately specified. Local saved facts expire at proof resets; closed global facts replace rebuilding with storage and reinstantiation. Independent shards require ordinary proof replay or genuinely checked provenance. Hash-only imports are excluded. Table setup is charged each time it is rebuilt, and changes of data order retain buffering/transpose costs. One table can serve both coordinates, but neither one lifetime per conductor nor free cross-shard reuse is assumed. Ordinary Lean numeral multiplication is not priced by the explicit-PA macro count and may be the better method; no Lean/MM0 runtime ratio follows.

## Independent evidence and remaining gate

My separate checker reconstructs widths, counts and crossover, verifies twelve packet/predecessor/source hashes, and tests the rounding equivalence on a different small synthetic domain, including wrong adjacent quotients and odd/even denominator cases. It passed30580 checks, including20541 candidate-round cases. It generated no table, conductor output, analytic value or transform, and ran no author code or build. The universal argument is the algebra above, not the synthetic cases.

Reviewer script: review_final_round_denominator_reuse_20261111.py, SHA256 `E016841BEFF0BC06A82093D539296A5D8E3983DA9580346BA442F5DAC6AD8E37`.

Reviewer receipt: same stem JSON, SHA256 `4B470FEC8644F582F8F850962E08BD41151A1BF1E48F80E7C5E9B5E1A1BC7EC0`.

The accepted conclusion is a conditional, source-compatible arithmetic proof design with a correctly counted unsigned subtotal. Actual coefficient/grid records, exact output coverage, generic soundness adapters, ordinary closed acceptance and measured or rigorously priced end-to-end gains remain unprovided. No spectral or finite-Goldbach claim is strengthened by this review.
