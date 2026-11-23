# Proved digit tables for ordinary-PA arithmetic

2026-11-11. Source research, proof schemas and exact size/event arithmetic only. No digit table or arithmetic proof was generated, no MM0/Lean build or benchmark ran, and no candidate prime or analytic value was evaluated. This report extends the existing nibble/byte arithmetic plan without adding a lookup axiom, a native multiplication rule, or an unproved imported table.

## Bounded recommendation

Keep radix 256 as the first matched baseline and test radix 1024 before committing to a much larger dense library. Radix 4096 is another legitimate tradeoff, but its table and statement working set are substantially larger. A fully populated radix-65536 table is a poor default under the pinned format and checker memory design. Wider machine limbs in the producer do not force equally wide proof digits.

There is a separate ordinary-PA alternative with only 2*beta-1 closed square facts. A digit product can be proved from the square-of-a-sum identity and addition proofs. This avoids a quadratic-size multiplication table, but adds enough carry work that it is not a speed winner under the conservative event schedule below. Its useful role is a small-library fallback and a concrete point on the setup-versus-replay tradeoff.

The event counts are exact evaluations of specified proposed proof templates. They are not executed MMB opcode counts, measured verifier times, or already implemented PA-only proofs. Numeral construction, unification, reference widths and representation conversions remain explicit additional costs.

## 1. Actual source boundary

The inspected MM0 snapshot is commit 0d414c0bfdaaeb7fea571895127abc1fa5a3d956 under work/mm0-efficient/toolchain-sources.

- examples__peano_hex.mm1:526--545 contains decmul_lem and a closed digit-product theorem generator. It uses a previous product equality, a successor equality and an addition proof; the meta-level multiplication selects the proposed result, while the emitted proof justifies it. Lines 548--587 give the recursive schoolbook multiplication proof.
- The same file:418--508 constructs addition/carry facts and numeral addition proofs. The table facts are reusable theorems, not calls to a trusted machine multiplier.
- Its hex coercion is not free in a PA-only contract. examples__peano_hex.mm0:67--134 explicitly adds coercion axioms, and the mm1 file registers string axioms around line 200. Use closed natural-number numerals built from 0, b0 and b1, with H_beta(a,d)=beta*a+d defined over naturals, or prove an appropriate conservative translation. This proposal takes the closed-numeral route and introduces no hex-sort axioms.
- examples__peano.mm0:288--293 defines b0(n)=n+n and b1(n)=suc(b0(n)). The actual PA proofs of addcan1/addcan2 are at peano.mm1:2097/2102, multiplication commutativity/distributivity/associativity at 2120/2131/2140/2143, and multiplication cancellation at 2401/2406. These suffice for the polynomial identities below. eqdivmod at 2693 supplies the quotient/remainder interface used by the existing modular-product plan.

No claim is made that adapting these source patterns has already produced a checked PA-only backend. In particular, replacing an axiom declaration with a generated numeric statement would not suffice; its proof must be accepted against the allowed PA specification.

## 2. A real PA schema for table generation and use

Let beta=2^b. A closed product table contains, for each 0<=a,d<beta, a proof of

    numeral(a)*numeral(d)=numeral(beta*h+l),
    h=floor(ad/beta), l=ad mod beta.

The generator may compute h,l however it likes. The checker accepts only the resulting PA equality, together with the required digit-bound facts and radix interpretation. The product statement can equivalently use a single canonical numeral z and a separately proved split z=beta*h+l.

One construction follows the actual decmul_lem pattern. Begin with a*0=0. Given a*d=z, prove a*(d+1)=z+a by the multiplication successor law and a closed addition proof. This makes each next entry cost bounded addition work, not another full digit multiplication. All predecessor facts must exist earlier in the checked dependency order. For a symmetric table a<=d, the diagonal can use the already proved a*(a-1), obtained by commutativity from the previous row; the remainder of the row then follows by successor steps. There is no hidden unary iteration in the numeral representation: closed binary numerals and explicit sharing/conversion lemmas are required.

An alternative bootstraps each requested wide product independently from the proved radix-16 multiplier. This permits on-demand caching without generating a whole row prefix. For b=4,8,10,12,16, the underlying operand lengths are 1,2,3,3,4 nibbles, with multiplication-template counts 8,25,52,52,89 before representation bridges. At b=10, padding to three nibbles is sound for the underlying natural equality, but converting the result to two ten-bit digits crosses a nibble boundary and must be proved and charged.

At use time, the untrusted generator chooses a theorem identifier. The checker applies that already proved theorem to the actual closed target equality. It need not prove correctness of a table-search algorithm or evaluate a PA list lookup. A wrong identifier or wrong claimed product does not unify with the target. A raw array of machine products, even if accompanied by a hash, is not a substitute for these proofs.

The pinned verifier's Thm handler, verifier.c:470--511, checks the theorem index, installs arguments and runs its unifier against a supplied target expression. Thus a closed theorem application is not automatically a constant-time machine lookup: the statement still must be present and checked. Saving and reusing a proof reference within a bounded proof can avoid repeated applications, but has heap/store costs.

## 3. Full tables, symmetry and carries

The baseline wide-digit cell uses one product equality and three full-adder equalities. A full adder has inputs a,d<beta and carry c in {0,1}. Its output is an exact equality a+d+c=beta*u+v with u in {0,1} and v<beta. Two beta^2 adder tables plus one beta^2 product table give 3 beta^2 facts, excluding digit bounds and general lemmas.

Symmetry reduces each two-input table to beta(beta+1)/2 entries. A use with reversed operands pays a proved commutativity application; no order oracle is needed for soundness because the actual closed equality is checked. Keeping both ordered aliases restores the global fact count and does not give this saving for free.

| b | beta | Ordered product facts | Symmetric product facts | Ordered product + both carry tables | All three symmetric tables |
|---:|---:|---:|---:|---:|---:|
|4|16|256|136|768|408|
|8|256|65536|32896|196608|98688|
|10|1024|1048576|524800|3145728|1574400|
|12|4096|16777216|8390656|50331648|25171968|
|16|65536|4294967296|2147516416|12884901888|6442549248|

Zero/one products can instead use general PA identities, removing those rows/columns. Carry-one addition can also be derived from carry-zero addition plus a proved successor step, reducing setup at the cost of extra replay events. Neither optimization should be counted simultaneously as both fewer facts and unchanged per-cell work without an explicit schedule.

The multiplication-cell invariant is the existing plan's bounded-carry one. For x_j,y_i,A_j,c<beta,

    t=x_j*y_i+A_j+c <= beta^2-1.

First split the digit product, then add its low digit to A_j, add c to that result, and add the two one-bit carries to the high product digit. A fixed PA algebra lemma combines the equalities. The final high overflow is zero by the displayed bound, not by an unproved native truncation. The row and outer product invariants still need their ordinary PA proofs.

## 4. Event sensitivity at the actual widths

Use the previous explicit skeleton S(n)=5n^2+2n+1 for a multiplication of n-digit numbers, A(n)=2n+1 for an adder, and Q(n)=10n^2+10n+5 for a modular product certified by xy=qM+r and r+d+1=M. A square is conservatively charged as a general multiplication here. These counts omit expression construction, decoding, theorem arguments and proof unification.

For n=ceil(w/b), the full ordered-table modular-product counts are:

| b | w=90 | w=718 | w=1436 | w=2871 | w=5741 |
|---:|---:|---:|---:|---:|---:|
|4|5525|325805|1292405|5162425|20635325|
|8|1565|81905|325805|1292405|5162425|
|10|905|52565|208805|832325|3312005|
|12|725|36605|145205|578405|2299205|
|16|425|20705|81905|325805|1292405|

These widths come from 1,8,16,32,64 maximum-size ladder factors, not from assuming every product is a machine word. At 90 bits the corresponding digit lengths are 23,12,9,8,6. At 2871 bits they are 718,359,288,240,180.

Using only a symmetric product table adds at most one commutativity event per multiplication cell, giving Q(n)+2n^2. Symmetrizing all four table uses per cell and the standalone adder positions gives the conservative bound Q(n)+8n^2+3n. The actual swap count depends on the concrete digits; no random-digit proportion is assumed. A dedicated square can reduce the distinct product leaves from n^2 to n(n+1)/2, but its doubling, accumulation and carry proof must also be supplied. This may matter more for the 44-square Proth-root circuit than a radix change alone; the current Q table does not claim that optimization.

For a setup sensitivity, suppose hypothetically that every new closed table fact costs the same alpha events, and ignore all other setup/replay differences. Moving from full byte tables to full b-bit tables amortizes after

    ceil(alpha*(3*2^(2b)-3*2^16)/(Q(ceil(w/8))-Q(ceil(w/b))))

modular products. At w=90 and alpha=100 this is 446837 products for b=10, 5968458 for b=12, and 1130237306 for b=16. The receipt also evaluates alpha=10 and 1000 and all five widths. These are conditional event break-even figures, not seconds. Actual alpha varies with b and the chosen generator; larger closed statements also increase replay unification/reference work. Rechecking the library in independent shards multiplies setup accordingly.

## 5. A linear-size square table with ordinary PA polarization

Store only closed proofs S_n=n*n for 0<=n<=2beta-2. There are 2beta-1 facts: 31,511,2047,8191,131071 at the five radices. Generate them from S_0=0 and

    S_(n+1)=S_n+2n+1,

using closed addition proofs and the PA distributive identity. This is not circular: constructing a square does not call the unproved wide digit multiplier.

For digits a,d and a proposed product z, prove s=a+d, look up the three actual square equalities at a,d,s, and verify by addition

    S_a+S_d+2z=S_s.

The generic PA identity (a+d)^2=a^2+d^2+2ad, addition cancellation and cancellation of the nonzero factor 2 imply z=ad. All bounds are explicit: s<=2beta-2; with a proposed two-digit z<beta^2, the checked sum uses at most 2b+2 bits. An incorrect z cannot pass. No assertion that a native multiplication instruction computed z occurs in the proof.

A conservative proposed template uses three square facts; an adder for s=a+d; three further adders for S_a+S_d, z+z and their sum; and two fixed bridge applications. With nibble adders its count is

    E_b=A(ceil((b+1)/4))+3A(ceil((2b+2)/4))+5,

namely 31,45,51,59,73 events before conversion overhead. These are not one-event digit products.

It is essential not to retain a quadratic-size wide full-adder table while advertising linear-size setup. A fully small-library version uses nibble carries too. Put k=ceil(b/4), n=ceil(w/b). A wide multiplication cell then costs E_b+3A(k)+1=E_b+6k+4 template events. Including row and modular-output additions gives

    Q_square(n)=2*(E_b+6k+4)*n^2+4n+6nk+5,

plus representation split/concat costs. A product-table version with the same nibble carries instead has

    Q_hybrid(n)=2*(6k+5)*n^2+4n+6nk+5.

At b=16,w=90 these are 7445 and 2261, respectively, versus 1565 for full byte tables and 5525 for full nibble tables. Under this particular schedule, polarization saves setup rather than replay work. At b=10 the mixed-radix top nibble and split at bit 10 require additional bridge proofs; the displayed skeleton does not make those conversions free. The adjacent receipt gives all widths. More efficient polarization/addition templates are possible research, but no unimplemented improvement is credited here.

Sparse on-demand wide product facts are another useful point: derive only encountered pairs using smaller-radix PA proofs, then reuse them within a bounded proof pack. The number of distinct pairs is at most the number of actual product uses, not automatically beta^2. However, a successor-row generator can require a long prefix to reach a requested pair; an independent smaller-radix derivation avoids that dependency. No uniform residue distribution or cache hit rate is assumed.

## 6. Memory, imports and 64-bit implementation choices

The pinned MMB v1 specification gives an eight-byte theorem-table header, a u32 theorem count and theorem identifiers, and p32 offsets for theorem data/unification streams. The multiply facts alone therefore require these header bytes before statements or proofs:

- b=8 symmetric: 263168 bytes;
- b=10 symmetric: 4198400 bytes;
- b=12 symmetric: 67125248 bytes;
- b=16 symmetric: 17180131328 bytes.

At an illustrative total of 64 bytes per symmetric product fact, those four totals become about 2.11 MB,33.59 MB,537 MB,137.44 GB. The receipt includes 32/64/128-byte sensitivity; none is an observed theorem size. Closed numeral terms and proof statements may be shared, but their construction, referenced values and global indexes cannot be ignored.

A full b=16 ordered product table has 2^32 facts and exceeds the u32 theorem-count range before adding a library. Removing zero/one cases can bring the count below that particular bound, but does not make the memory or data-offset problem disappear. The symmetric count itself fits u32. Its 17.18 GB header array alone is an engineering warning, not a proof that every MMB file must be below 4 GB: a p32 table start and host pointer indexing can in principle describe an array extending farther. The actual closed statement/unification offsets and checked layout must be analyzed, rather than inferring a blanket limit from the array size.

The inspected checker has HEAP_SIZE=65536 and a 64-MiB default expression store in mm0-c_verifier_types.c. Preloading even all 65536 ordered byte-product proof instances leaves no heap space for other work; preloading the full byte arithmetic library is impossible at that setting. Use direct theorem applications, a bounded set of locally reused facts, resets between proved packs, or a separately reviewed larger/reclaiming implementation. No cache eviction or constant-time proof reuse is assumed merely from the word "table".

The existing Thm instruction carries a variable-width identifier of up to four data bytes. Larger tables can change reference byte lengths. Closed theorem application still runs its statement unifier. A local Ref can reuse a saved proof but costs heap/store and must refer to the exact expression. These costs can erase an apparent saving expressed only in table calls.

A versioned 64-bit ordinary-rule implementation can widen counts, identifiers, offsets and store handles while retaining the same PA inference rules. It must also fix tag encodings, checked allocation arithmetic, parsers and linking; changing a typedef is not a soundness argument. Wider references, paged statements, streaming proof bodies and reclaiming unreachable scratch alter bytes and memory, not the mathematics. Such an implementation must be separately validated. It does not authorize native word multiplication as an inference rule.

Within one complete proof context, table proofs can be checked once and referenced subsequently. Separate shard checks cannot import a table hash as a new axiom. The final acceptance must replay the proofs or use an independently justified checked-import mechanism with exact statement binding. Setup, import I/O and repeated instantiation all belong in the end-to-end comparison. A binary serialized checker state is not automatically such a mechanism.

## 7. Small matched test to authorize later

The next implementation comparison should produce the same complete ordinary-PA arithmetic certificates at 90 bits and at one actual product width, initially 718 or 2871 bits. Hold quotient/remainder witnesses and the final modular identity fixed. Compare full nibble, full byte, symmetric byte, a sparse radix-1024 table, and the square-table fallback; only add dense radix-4096 if its measured setup and working set justify it.

Record table-proof generation and checking separately from repeated arithmetic generation/checking. Record actual theorem applications, local references, unifier/numeral work, encoded bytes, global statement metadata, peak scratch and import cost. Reject a wrong product fact, wrong carry, incorrect quotient/remainder bound, and a forged table identifier through the real proof checker. No such test was run or authorized here. A successful finite-arithmetic test would still not establish the analytic library translation or the full Goldbach proof in MM0.

## Pins and scalar checks

The exact-only scalar script exited zero. It constructs counts and capacities, not tables, candidates, modular residues or proofs.

- mm0_digit_table_sizes_20261111.py: 3C58CB6A8172EE369B8EBD027A65D68AC97189DAA3705EEF825A042F049D29DA.
- mm0_digit_table_sizes_20261111.json: D41C177B0A050CE18C71556FFC3663732EB35372BC92668F7E67FE8AD5C4F079.
- examples__peano_hex.mm1: 76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94.
- examples__peano.mm1: 13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079.
- work/formal-goldbach-bench/mm0/src/mmb.md: E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0.
- work/formal-goldbach-bench/mm0/src/verifier.c: 71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5.
- work/mm0-fermi/sources/mm0-c_types.c: B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1.
- work/mm0-fermi/sources/mm0-c_verifier_types.c: 87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E.
- integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md: 3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227.

This is an ordinary-rule proof-design comparison. It neither asserts a Lean/MM0 time ratio nor treats native arithmetic or a new verified-execution interface as already available.
