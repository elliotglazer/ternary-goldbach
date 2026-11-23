# Independent review of packed-coverage NTT acceptance

2026-11-11. Verdict: PASS at paper acceptance, source-interface and conditional integer-cost scope. No correction is required. There is no asserted 32-bit parameter certificate, executed NTT, implemented ordinary-PA checker, complete binary coverage or runtime advantage.

Reviewed author files under `work/qrh-campaign/agents/prime-estimates`:

| File | SHA256 |
|---|---|
| `EFFICIENCY_MM0_PACKED_NTT_2026-11-11.md` | `9B212F658CCDE0E72FD255C751604C969A54D5B231D661BC5183E66E8E8368CA` |
| `ntt_coverage_size_models_20261111.py` | `A241129152A77A662782465D71E5376F5EA7A74C38F4081037181E33435405F8` |
| `ntt_coverage_size_models_20261111.json` | `105516787B2B092A68EA07B9D8B282DCD731386B0CDADBCD073EC3A05DBBA2DE` |

I read the complete report and script, the stored geometry, and the previously reviewed coverage and Karatsuba contracts. I inspected the cited division, modular, power and shift interfaces in the pinned MM0 source. Independent calculations reconstructed the four size/count rows and the 50 dyadic count identities. They used integer geometry and cost recurrences only. I did not import or execute the author script, evaluate a modular candidate, construct a transform, test a prime or run a build. Only this new review file was written.

## 1. Coefficient identity and coverage consumption

The source vector Q has binary coefficients. The reversed-offset vector A has nonnegative multiplicities with total m; it need not be a binary vector. For each ordinary convolution coefficient,

    C_l = sum_v A_v Q_(l-v),

where out-of-range Q entries are zero. Thus 0<=C_l<=sum_v A_v=m, including repeated anchor offsets. This bound does not depend on the packed bit length. It would be false to reuse it for arbitrary base-256 multiplication coefficients, and the author explicitly excludes that substitution.

The maximum possible degree is (W+d-1)+d=W+2d-1. Therefore padding to T>=W+2d prevents cyclic wrap, including equality at that endpoint. At l=d+x, reversing the anchor offset gives

    C_(d+x) = sum_i P[a+x+s_i].

All source indices are the ones already justified by the target tile and the anchor bounds. A positive coefficient witnesses at least one genuine set source bit, and that bit plus the corresponding separately certified anchor proves the target's prime representation. The exact inherited residual mask determines which coefficients must be positive. A freely selected subset, missing residual word, or omitted exceptional target is not accepted.

For the old packed representation, b=2^k and m<=b/2 imply C_l<b. No product carries occur between lanes. Adding b/2-1 to a target lane gives at most b-1, so it also creates no interlane carry. Its high bit is one precisely when C_l>0. Thus direct coefficient positivity and the old packed terminal prove the same coverage claim. Avoiding packed dilation does not remove source-bit, multiplicity or residual binding.

## 2. Parameter certificate and complete transform equality

The parameter contract requires a proved odd prime p, p>m, T=2^ell with ell>=1, and a checked residue omega satisfying omega^(T/2)=-1 modulo p. Primality is a separate required proof; it is not inferred from that congruence alone.

Over the field modulo p, omega^T=1. A proper divisor of T divides T/2, so the negative-one check and oddness of p force exact order T. Consequently T divides p-1, and T is nonzero and invertible in the field. For the two example lengths this already forces p>T>512. The generic p>m check remains necessary because the generic m need not be bounded by T.

For h not divisible by T, omega^h is not one. Multiplying the finite geometric sum by 1-omega^h makes it telescope to zero, so field cancellation gives sum_(k<T) omega^(kh)=0. When T divides h the sum is T. This proves the required orthogonality without an unproved numerical Fourier identity.

For completeness, if F(z)=0, multiply its k-th component by omega^(-kj), sum over every k<T, and use orthogonality to obtain T*z_j=0. The inverse powers exist because omega is a unit, and may be represented by indices modulo T. Since T is invertible, z_j=0 for every j. This is the finite algebraic injectivity proof. It does not require a separately evaluated inverse transform.

Finite distributivity also gives F(Q*A)=F(Q)F(A), where the product on the left is circular convolution. The degree bound identifies it with the zero-padded ordinary convolution. Therefore checking all T forward-output identities for the supplied C proves C congruent to that convolution. Both coefficient lists lie in [0,m], with m<p, so congruence implies equality over the natural numbers. The range check on every supplied coefficient and its zero padding are essential to this last step.

Checking a subset of frequencies would not establish injectivity. Checking independent unlinked butterflies would not establish that their output is F of the claimed input. The report retains every frequency, stage input/output binding, permutation, parameter identity and padding requirement. An authenticated array hash alone is explicitly insufficient.

The p<2^32 row is a conditional size choice. The report neither supplies nor claims to have proved a prime and root meeting it. Proth-form search is only a possible producer; its primality, root order and required size must all be checked before that configuration is admissible. Failure means rejection or a separately priced configuration. Larger moduli cannot retain the four-byte cost automatically.

## 3. Ordinary arithmetic and source boundary

For u,v<p, the genuine quotient in uv=pq+r obeys q<p. The positive equations uv=pq+r and r+slack+1=p prove both the residue equality and strict remainder range. They retain the quotient-times-p product. At p<2^32, operands have at most four radix-256 digits, while the unreduced product can require eight. The ordinary-PA template Q(4)=10*4^2+10*4+5=205 includes those products and range work.

The addition equation u+v=S+ep and subtraction equation v+R=u+ep, with e in {0,1} and canonical S,R<p, correctly cover carry and borrow without truncated subtraction. Their proofs, including one-bit growth, are not included in the 205 product charge; they remain in the separate J_32 term.

The inspected `examples__peano.mm1` interfaces agree with the report. `eqdivmod` at2693 consumes a strict remainder bound and b*Q+R=a. `divmod` at2700 and `modlt` at2710 give the corresponding total identities. `muladdmod2lt` and `muladdmod1lt` at2740-2743 specialize small remainders. `powadd`/`powmul` at5024/5029 and the subsequent shift definition support the stated arithmetic encoding. Their source hashes are `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079` and, for `examples__peano_hex.mm1`, `76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94`.

These are arithmetic ingredients, not an existing formal NTT theorem. Encoded finite sequences, field cancellation, orthogonality, circuit correctness, coefficient uniqueness, source binding and the coverage adapter remain implementation/proof work. The report correctly excludes the hex-coercion axioms from an ordinary-PA claim and proposes separately proved natural-digit representations.

## 4. Counts, storage and the unbalanced comparator

A length-T radix-two transform has T*ell/2 butterflies. At stage s, T/2^s butterflies have twiddle one; summing stages gives T-1. Three transforms therefore use 3*[T*ell/2-(T-1)] nonidentity twiddle products, plus T point products, and 3*T*ell modular additions/subtractions. The author does not assume further special-root or zero-input pruning. The table-setup count T/2-1 is a conservative valid recurrence cost and remains separate.

I independently counted stages, then reconstructed the four geometries and adaptive unbalanced multiplication recurrence. The results match:

| W,d,m,k | T | NTT products | NTT add/subtract | Product-only events | Chunked Karatsuba events |
|---|---:|---:|---:|---:|---:|
|262144,524288,512,10|2097152|61865987|132120576|12682527335|77961219312|
|262144,4096,512,10|524288|13893635|29884416|2848195175|1151716865|
|262144,3789,188,9|524288|13893635|29884416|2848195175|947207308|
|1048576,5056,250,9|2097152|61865987|132120576|12682527335|4372215210|

The two displayed full-stage storage values are exactly 553648128 and125829120 raw bytes, or528 and120 MiB. The root-table and two-buffer counts also agree. These exclude proof objects, quotient witnesses, indices, allocator overhead and parameter data. Neither the three-array trace nor a proposed streaming version has an established feasible ordinary-MM0 memory implementation here.

The Karatsuba comparator respects the unequal packed operand lengths. Let R=beta^n_A and write Q in n_A-digit chunks q_j. With A>0 and carry<A, q_j*A+carry<R*A, so extracting a low n_A-digit word leaves a new carry<A. The same identity reconstructs the product inductively. Nonempty anchor input ensures A>0; the zero multiplier would instead have a separate trivial branch. The final partial chunk can be padded with zeros, and the last carry is emitted exactly.

The cost r*[G(n_A)+A(2n_A)] consequently includes a full conservative carry addition for every chunk. G retains the mandatory ceil(n/2)+1 Karatsuba child. Extra split, final encoding, range and binding work remains in its separate overhead term. The independent digit/chunk triples are (983040,655362,2), (332800,5122,65), (299175,4264,71) and(1185336,5690,209), matching the receipt.

Thus the three narrow/unbalanced rows have a lower Karatsuba skeleton even than NTT's product-only subtotal. The broad-halo row leaves room for NTT but does not prove it wins after modular additions, parameter proofs and circuit/index overhead. In either case a residual OR proof is a different comparator with its own extraction, completeness and proof costs. Counting an OR instruction or a native NTT against fully expanded arithmetic proofs would not be a fair trust or work comparison.

## 5. Accepted scope

The single-prime and three-forward-transform ideas give a sound complete *acceptance* schema for supplied source and coefficient data. They do not supply the prime/root parameter, suitable covering anchors, a successful production search or a formally verified implementation. Source/cache provenance, every inherited residual obligation, and all guards remain mandatory.

The proposed next test appropriately starts with a small proved indexed circuit and corrupted-input controls before large arrays. This review authorizes no such run. The companion integer calculations validate only the stated geometry and cost model; they are not evidence that any genuine prime-cover leaf has passed NTT acceptance.
