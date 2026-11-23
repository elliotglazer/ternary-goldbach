# Independent review of square and Karatsuba proof templates

2026-11-11. PASS at paper-algebra, inspected-source, and conditional event-model scope. No correction is required to `prime-estimates/EFFICIENCY_MM0_SQUARE_KARATSUBA_2026-11-11.md`, SHA256 `4ADB3C676ABA3A82128A8F27CBB91221B414689F94CDC5D60BA0FA75A8421FFA`.

This is not an implemented PA arithmetic checker, a checked MM0 proof, or a runtime result. The new triangular and recursive lifting lemmas, their numeral representation, and the complete ordinary-PA table derivations remain work. No Lean/MM0 build, candidate modular computation, primality evaluation, or proof generation was performed. The only executed script independently checked integer recurrence tables.

## Triangular square and exact carries

Take positive digit width n and radix beta=2^b with b>=1. All digits are natural numbers below beta. A zero-width representation would require a separate zero case; it is not used by the receipt.

The decomposition x^2=D+2U is the exact expansion of the double sum. D contains the diagonal products and U contains each pair j<i once. It is essential that the algorithm later proves U+U. A symmetric product table alone would not justify dropping half the terms.

At the beginning of row i, the invariant is U_before=L_i+beta^i A_i, with L_i<beta^i and either A_i<p_i or A_i=p_i=0. It holds at i=1. When p_i>0, B_i=A_i+d_i p_i<beta p_i. Euclidean decomposition B_i=u_i+beta A_next therefore gives A_next<p_i and u_i<beta. The update L_next=L_i+beta^i u_i is below beta^(i+1), and the update to U is exactly beta^i d_i p_i. Since p_next=p_i+d_i beta^i>=p_i, the next invariant follows. When p_i=0, B_i=A_next=0. Either p_next=0 or A_next<p_next. Thus zero initial digits do not break the induction.

The row uses i accumulator digits because A_i<p_i<beta^i in the nonzero case. Each multiply-accumulate cell has total at most

    (beta-1)^2+(beta-1)+(beta-1)=beta^2-1.

The product's low digit is first added to the accumulator digit; the resulting low digit is added to the incoming one-digit carry. Their two one-bit carries are then added to the product's high digit with the third full-adder fact. The bound proves that this last operation has no overflow. The incoming carry is a digit, not falsely assumed to be a bit. All equations must be exact natural-number equations.

After the last row A_n has at most n-1 digits, and L_n has at most n digits. For n=1, U=0 directly. Every diagonal d_i^2 occupies only positions 2i and 2i+1, so diagonal blocks do not overlap. Their concatenation still needs a representation proof. Finally 0<=2U<=D+2U=x^2<beta^(2n), which justifies the two 2n-digit additions and their zero final carries. This is a mathematical bound on genuine data, not permission to discard a nonzero carry in malformed supplied data.

The row and diagonal schedules sum to

    5*n*(n-1)/2 + 2*(n-1)+1 + 2*n+1 + 2*(4*n+1)+1
    = 5*n*(n-1)/2 + 12*n+3.

The generic schoolbook count is lower at n=1,2,3. The minimum used by the author is therefore a valid choice between two proposed complete proof templates.

## Positive-sum Karatsuba without evaluated cross-products

With h=ceil(n/2), g=floor(n/2), R=beta^h, the three checked child products are ac, bd and (a+b)(c+d). Distributivity proves the symbolic identity

    (a+b)(c+d)=ac+bd+ad+bc.

Combining this identity with the checked equation m+z0+z2=zs and the three child equalities gives m=ad+bc by rearrangement and additive cancellation. The two cross-products occur only in a generic algebraic proof. Their concrete numeral values need not be computed or normalized. This is why the proposal has three evaluated child products rather than five. A supplied natural m is acceptable only when the exact middle relation is proved.

The inspected `peano.mm1` bodies provide `addass` at 2083, `add4` at 2094, `addcan1` and `addcan2` at 2097 and 2102, `muladd` and `addmul` at 2131 and 2140, and `mulass` at 2143. These are actual proof bodies. They support the generic derivation; they are not the already-written specialized Karatsuba theorem.

Both input sums are below 2R. They require h+1 digits, including when n is odd. The third product and the checked middle sums fit 2h+2 digits. Recombination consists of nonnegative terms whose sum is xy<beta^(2n); its intermediate partial sums therefore fit the final width. Exact split and shift identities are still required. The square variant uses a=c and b=d, yielding m=2ab and only one input-sum addition.

The stated node overheads follow from the actual addition widths:

    general: 2*A(h+1)+2*A(2h+2)+2*A(2n)+3 = 12h+8n+21;
    square:    A(h+1)+2*A(2h+2)+2*A(2n)+3 = 10h+8n+18.

For every n>=4 all three child widths h,g,h+1 are positive and strictly smaller than n. At n=2 or 3 the third child equals n; at n=1 it exceeds n. Keeping n<=3 as a base case makes the proposed recursion well founded. The receipt's h-only third-child figure is explicitly invalid and must remain a diagnostic, not an optimization.

## Complete modular-square cost and recurrence replay

For already bounded x<M and M>=2, the supplied witnesses must prove x^2=qM+r and r+d+1=M. The latter gives r<M. The source `eqdivmod` proof at `peano.mm1:2693-2698` then identifies the remainder, after commuting qM into the source's Mq order. The actual quotient satisfies q<M since qM<=x^2<M^2. No verified division algorithm is needed, but the varying qM multiplication and the remainder-bound equality are mandatory.

The modular cost is consequently C_rec(n)+G_rec(n)+6n+3. Applying the square optimization to qM as well would be unsound. Reusing the modulus does not reuse the varying product equality.

The independent script builds bottom-up recurrence tables, summing the separate addition widths instead of copying the author's closed overhead formulas. It imports no author module and only reads frozen data. It verified all 15 width/radix rows, all 120 schedules and 240 component-tree records, including costs, internal nodes, leaves, width sums and depths. It also checks the full three-child tree identity leaves=2*internal_nodes+1 and separately reproduces the intentionally invalid diagnostic.

| Byte-radix operand bits | Triangular plus schoolbook | Adaptive modular square | Combined internal nodes | Combined node-width sum |
|---:|---:|---:|---:|---:|
|90|1297|1297|0|0|
|718|62332|44049|17|660|
|2871|972897|422483|161|7773|

Thus the quoted conditional extra-work budgets, 660*delta+17*gamma<18283 and 7773*delta+161*gamma<550414, have the stated arithmetic. They cover only an extra-cost model that has actually been bounded in those units. They do not independently price differing leaf representation work, proof references, substitution, setup, statement metadata or scratch use.

An event remains one proposed table or reusable-lemma application. The source hex generators at `peano_hex.mm1:418-508,526-587` demonstrate proved addition and multiplication patterns, but do not implement these new schedules. The hex coercion axioms must not enter a PA-only result without the author's promised replacement by proved natural-number representations. Neither choosing the lowest event count nor proving its recurrence establishes fastest verification, smallest bytes, or a full-campaign cost. Carry-bit peeling, sparse values, unequal-width qM, and other representations are separate possible changes that require their own complete counts.

## Evidence pins and remaining gates

All eight pins in the independent receipt matched. In addition to the author note, the directly used inputs are:

| File | SHA256 |
|---|---|
|prime-estimates/mm0_square_karatsuba_sizes_20261111.py|64C11ADCA0ABAB02A95F617AD326F051A3B871F97CF2D4458DFEF4825607039C|
|prime-estimates/mm0_square_karatsuba_sizes_20261111.json|D2E5F35DB7D75C44F8DDD9405D60D78D475A123676CAC036D0CF0F6FFA47D073|
|integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md|3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227|
|examples__peano.mm1|13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079|
|examples__peano_hex.mm1|76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94|

The source examples are under `work/mm0-efficient/toolchain-sources`; report paths in the table are relative to `work/qrh-campaign/agents`.

Owned exact-only evidence:

- `audit/review_mm0_square_karatsuba_counts_20261111.py`, SHA256 `F6FCD9BCBFDD0EF7AAD604774253517147DC07DF63C64477AC3B5E54BED94B2A`.
- `audit/review_mm0_square_karatsuba_counts_20261111.json`, SHA256 `0E65B83C3514C57013B8D3D97783FB102EA00438951F60D0B751F78AAC109417`.

The script exited zero. Frozen inputs were not changed. The next proof gate is to implement and check the complete PA lemmas and numeral interfaces, then emit matched full modular certificates with malformed-data controls. Runtime and production feasibility remain unestablished.
