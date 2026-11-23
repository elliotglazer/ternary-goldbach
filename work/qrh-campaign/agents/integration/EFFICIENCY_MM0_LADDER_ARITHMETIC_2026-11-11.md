# Ordinary-MM0 arithmetic for mixed Proth certificates

2026-11-11. Source research and exact integer cost arithmetic only. No MM0/Lean build, primality test, arithmetic proof generator or numerical evaluator was run. All event counts below describe proposed proof templates, not measured MMB instructions or established throughput.

**Recommended ordinary-MM0 baseline:** direct at-most-90-bit Proth powers, grouped into logical proof packs, with shared PA-derived digit facts and quotient/remainder witnesses. Compare this against product-modulus batches on the same concrete candidates. Do not assume the 32-factor batching that helps Lean's native big-integer reduction also minimizes explicit arithmetic proofs. Keep schoolbook multiplication for small operands; price a Karatsuba alternative for unavoidable large products. A radix-256 implementation built from PA-proved radix-16 tables is a credible optimization candidate, not an existing checked backend.

This report supplies a concrete arithmetic proof interface, a cost vector down to digit events, and a byte/scratch model. It does not establish that the pinned mm0-c format/implementation fits the entire proposed 10^11-rung proof. Its simultaneous proof-scratch and statement-metadata constraints must be tested, not hidden by shard success logs. A widened or memory-reclaiming implementation of the **same ordinary PA inference rules** is a distinct credible candidate, discussed below; these implementation limits are not limitations of PA or of all ordinary-MM0 verification.

## 1. Actual library capability and the missing boundary

The inspected primary snapshot is `digama0/mm0` commit `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`, stored under `work/mm0-efficient/toolchain-sources`.

* `examples__peano.mm0:168–228` gives the base natural-number/PA axioms; lines 269–277 specify division/remainder, 288–293 binary constructors, and 424–431 powers/shifts. The `.mm0` specifications alone are not proofs of the declared theorems.
* `examples__peano.mm1:2693–2698` contains the actual proof of `eqdivmod`: R<b and bQ+R=a imply the asserted quotient and remainder. `divmod`/`modlt:2700–2712` and `muladdmod2lt`/`muladdmod1lt:2740–2743` provide nearby arithmetic. `powadd`/`powmul:5024–5032` have induction proofs. These are useful genuine source bodies; no new build or complete dependency validation was performed here.
* `examples__peano_hex.mm1:418–508` generates small addition/carry facts and recursive addition proofs. Lines 526–587 generate digit products and an actual schoolbook multiplication proof; 595–646 connect normalization equalities to expressions. This is more than a schematic multiplication axiom.
* However, `examples__peano_hex.mm0:67–134` explicitly adds coercion axioms for strict hex/character sorts. For an exact PA-only contract, replace each closed hex digit by a closed nat numeral and define H(a,d)=16a+d on naturals, or supply a complete conservative translation. The new plan chooses the former. The tables become ordinary proved closed PA equalities, not trusted computation tables. The existing source proof patterns can be adapted; their PA-only adaptation is still work.
* `mm0-rs__src__mmc__proof__norm_num.rs:1–70,165–229` demonstrates numeral/reference sharing and proof-producing addition, but its displayed value carrier is `u64`. It is not an arbitrary-precision 2,880-bit multiplication implementation. The inspected `smoke.mm0` instead contains schematic `byteor`/trace axioms and concludes `ok`; it cannot supply arithmetic or Goldbach acceptance.

There is no reliance on the native prime validator's timings, MMC compiler completeness, or an arithmetic accelerator. Ordinary checking requires every table, arithmetic lemma and concrete equality to have an actual derivation in the allowed base theory.

## 2. A modular product needs no verified division algorithm

Fix M>=2 and already certified residues 0<=x,y<M. The untrusted producer supplies q,r,d with

    xy = qM+r,                 r+d+1 = M.

All quantities are naturals. Check both equalities by arithmetic proofs. The second gives r<M; `eqdivmod` then identifies r with xy mod M. Since xy<M^2, the actual quotient has q<M; a bounded encoder can therefore use at most w bits for q,r,d when M<2^w. A malformed quotient or remainder simply fails the equalities. The producer may use any division algorithm; its execution is not an acceptance premise.

One straightforward proof computes the same canonical numeral z in xy=z and qM+r=z, sharing z by a saved reference. It uses two multiplications, one addition of up to 2w bits, one addition-with-initial-carry for r+d+1, and a fixed PA implication combining those four equalities with `eqdivmod`. That implication includes deriving r<M; it is a lemma to prove once, not an extra arithmetic axiom. No huge natural power is expanded. A square can use a dedicated square proof later, but all conservative tables here use the ordinary multiplication proof even for x=y.

The proof boundary also covers product construction, residue-to-factor reductions and gcd witnesses. In a 32-candidate batch, each p divides M by the checked product tree, without assuming the candidates prime or pairwise coprime. Reducing V<M modulo one 90-bit p involves a quotient with roughly the other factors' width; it is **not** another 90-by-90 product. Likewise the final U+offset divisibility check is not free. A common-X scheme needs its actual gcd(X,M)=1 proof; setting X=0 must not fake acceptance. For a small certified prime base a, the checked nonzero remainder M mod a can justify gcd(a,M)=1. More general bases can use a proved Bezout/inverse certificate with its own arithmetic bill.

## 3. A PA-provable radix circuit with bounded digit carries

Let beta=2^b. Represent every number by a shared radix numeral, using closed nat digits 0,...,beta-1. Prove once:

* beta^2 digit-product equalities ab=beta*h+l;
* 2*beta^2 full-adder equalities a+b+c=beta*u+v for c in {0,1};
* digit bounds and the generic fixed algebraic steps which lift these equalities to numeral prefixes.

There are 256+512=768 arithmetic table facts at b=4, and 65,536+131,072=196,608 at b=8, before digit bounds and generic lemmas. A byte table can be proved from the nibble machinery once. A full table at b=16 is not a sensible default: it has 3*2^32 entries. Wider machine limbs may still be used by an untrusted producer; their multiplication must be justified by a smaller-radix circuit or another proved arithmetic algorithm.

For schoolbook multiplication, return zero by the proved zero-product identity when x=0. For x>0 process the digits y_i from low to high. Maintain

    low_i + beta^i A_i = x*(y mod beta^i),     0<=A_i<x.

At a row, compute B=A_i+x*y_i by n digit cells, output B mod beta as the next low digit, and set A_(i+1)=floor(B/beta). Since A_i<x and y_i<beta, B<beta*x, so the next A again fits n digits. No growing arbitrary-precision carry is needed inside a cell:

    t = x_j*y_i + (A_i)_j + c,       0<=t<=beta^2-1.

Obtain t's two digits using one digit product and three full-adder lookups: add the low product digit to A's digit, add c to that low result, then add the two one-bit carries to the high product digit. Its last overflow is zero by the displayed bound. A fixed PA algebra lemma merges these four equalities with the already proved higher-tail equation. At row end, another fixed lemma updates the low/high invariant. This proves the product; it does not assert a native multiply result.

The generator must share numeral tails/prefixes and construct results once. The circuit is traversed row by row; it is not encoded as repeated linear random-access lookups into a PA list. The exact expression representation and resulting opcode counts remain implementation obligations.

Define an **arithmetic event** as a digit-table use or an application of one of these fixed lifting/row/base lemmas. The following explicit accounting convention allows five events per multiplication cell (four table uses plus the fused lifting step), two per row, and one base event:

    S(n) = 5n^2 + 2n + 1.
    A(l) = 2l + 1                         [adder of l digits, including carry-in].
    Q(n) = 2S(n)+A(2n)+A(n)+1 = 10n^2+10n+5.

This is a proposed template-event schedule. It excludes numeral construction, argument/proof references, conversions and generic-library construction; these are priced separately in section 6. It is not a count of executed theorem opcodes. If the PA template requires extra bridge steps, add them to the schedule rather than calling them free. Rectangular m-by-n multiplication uses the analogous n rows of m cells, 5mn+2n+1 events, with explicit unequal-width encoders. Short or zero operands can have cheaper branches only when those branches are actually proved and emitted.

| Bit bound | Radix bits b | Digits n=ceil(w/b) | S(n) | Q(n) |
|---:|---:|---:|---:|---:|
|90|4|23|2,692|5,525|
|90|8|12|745|1,565|
|2,880|4|720|2,593,441|5,191,205|
|2,880|8|360|648,721|1,299,605|

The byte radix has a larger one-time table proof, metadata and local-cache cost. It reduces cell counts but is not proved faster in bytes or seconds. Compare the setup against the saved repeated event vector, not just the fourfold asymptotic decrease in cell count.

## 4. Karatsuba, including its addition and sign bill

For an n-digit input, split at h=n/2: x=x0+beta^h*x1 and similarly y. Use z0=x0*y0, z2=x1*y1 and d=abs(x1-x0)*abs(y1-y0). The third product still has h-digit inputs. If the differences have the same sign, cross+d=z0+z2; otherwise cross=z0+z2+d. Then

    xy=z0+beta^h*cross+beta^(2h)*z2.

Avoid unproved subtraction: supply nonnegative difference witnesses and verify x_small+dx=x_large and y_small+dy=y_large. Supply cross and verify the appropriate sum equality. The four sign cases use fixed polynomial identities provable in PA. The equality also proves that the truncated subtraction, if used by a producer, was legitimate. Checking just three unrelated products without these identities would not certify xy.

A proposed node budget is at most 8n digit-adder positions for the two differences, the cross relation and two shifted additions, plus at most seven adder-base/recombination events. Thus the arithmetic skeleton is

    K(n)=3K(n/2)+16n+7,       K(b0)=S(b0),

with explicit **additional** split/concatenation and representation/conversion costs D(n). Inputs are padded to a power of two; this padding is charged. This table evaluates only the displayed skeleton, not D or emitted proof bytes:

| Padded n | Leaf b0 | Leaves | Internal nodes | Sum of internal node widths | K skeleton | Modular skeleton 2K+6n+3 |
|---:|---:|---:|---:|---:|---:|---:|
|1,024|8|2,187|1,093|32,944|1,271,774|2,549,695|
|1,024|16|729|364|21,280|1,300,205|2,606,557|
|1,024|32|243|121|13,504|1,476,866|2,959,879|
|512|16|243|121|6,752|427,938|858,951|

For 90-bit nibble operands, padding 23 digits to 32 with leaf 16 gives a skeleton larger than direct schoolbook. For 2,880-bit operands Karatsuba can reduce the arithmetic skeleton, but whether it wins after D, extra argument references and scratch is unmeasured. Leaf size 8 minimizing this small skeleton does not establish that it minimizes bytes or verification work. A dedicated symmetric square, unequal-width multiplication, remainder tree, or Toom/FFT method needs its own proved identity and full linear/transform costs; none is priced as an available free replacement.

## 5. Apply the model to actual ladder circuits

Use the mixed-ladder report's exact candidate parameters F=2^45, D=2^44, S=157 or 313, offsets below 128 or 256, and p=(Si-t)F+1 with 1<=Si-t<F. For each actual base group, retain its checked positions, product, initial exponent, gap schedule and slot tests. The total arithmetic cost is the sum of the costs at each group's actual width, not a count of equal-cost modular multiplications.

For a full consecutive 32-slot group, the optimized schedule has at most 88 initialization squares, 40 other initialization multiplies in the S=157 case (39 for S=313), and 31 transitions. Thus the two upper schedule totals are 159 or 158 product-modulus operations, before factor reductions, offset powers, product/gcd proofs and final slot tests. Arbitrary grouped positions add the actual jump-table costs. Modulus bit width is at most 90 times the group size.

The direct alternative tests a^((Si-t)*2^44)=-1 mod p with the required unit/primality argument. Compute a^(Si-t) modulo p and then square 44 times: at most 88 squares and 44 other multiplies, all at 90 bits. This is 132 modular operations per rung, or 4,224 for 32 rungs. It has no product M, separate A/U chain, factor reductions or offset power. Generic Proth soundness is still to be translated/proved in the MM0 base; numerical equality alone is not primehood.

Under the fixed-width arithmetic skeleton, using the same general-product proof for squares gives:

| Circuit, 32 rungs | Core arithmetic events only |
|---|---:|
|Direct 90-bit checks, radix16|23,337,600|
|159 product-modulus operations, radix16 schoolbook|825,401,595|
|159 product-modulus operations, radix16 Karatsuba leaf16|414,442,563 plus split/representation costs|
|Direct 90-bit checks, radix256|6,610,560|

These are exact products of specified worst schedule bounds and padded-template counts, not observed data and not a universal lower bound on batching. Early small residues, specialized squaring, better proof algorithms and different bases can change them. Nevertheless they identify a real risk in importing the Lean batch choice unchanged: saving a factor of 32 in arithmetic calls can lose much more in explicit digit work. The direct path is the lowest-complexity credible ordinary-MM0 baseline from these source capabilities; a product path must beat it in a complete byte/event comparison, including its extra reductions. The actual choice may differ between Lean and MM0.

For a group of g positions, the crossover is a weighted inequality, not a slogan:

    init(g)*C_mod(90g) + jump(g)*C_mod(90g)
      + product(g) + factor_reductions(g) + offsets(g) + gcd(g)
      < sum_slots C_direct(actual 90-bit exponent/base).

Use squares and nonsquares as separate cost classes when a square proof exists. For factor reductions, q is bounded by the product of the other factors; its multiplication by p is rectangular. A balanced product tree has 31 products for g=32. Reducing the same V to all factors can use a remainder tree, while different U values do not automatically share that reduction. Grouping by base or common X changes these terms and payloads, not the soundness test.

The corresponding Lean comparison must use the same mathematical circuit and witnesses first. Stock Lean can directly reduce native Nat multiplications/remainders in its kernel, or check qM+r equalities instead; the supplied-quotient route exchanges a division for an additional multiplication and more data. Its winner depends on actual bigint/reduction costs. A literal 2,880-bit multiplication is not 518,400 MM0 digit cells inside Lean. Conversely ordinary MM0 cannot charge native multiplication as one trusted primitive. After the same-circuit comparison, each system may choose its cheaper sound arithmetic circuit. No numerical Lean/MM0 ratio is inferred.

## 6. Ordinary proof bytes, generation and scratch

An arithmetic event is not one byte or one uniform verification step. Emit the actual expression DAG, with saved references for operands, numeral tails, proof facts and repeated conclusions. `mmb.md:180–238` defines the relevant commands and pointer-identity sharing requirement. `verifier.c:479–515` consumes theorem arguments, the explicit conclusion expression and hypotheses, then runs unification. The conclusion must be constructed or referenced; it is not created for free by a theorem identifier.

For each template record a vector

    (theorem invocations, saved-proof references, term constructions,
     argument references, conversion commands, allocated expression bytes).

Let E,R,T,C be the first five categories after combining the two reference categories. A parametric encoded-byte bound is

    proof_bytes <= 5(E+R+T) + bytes(C) + framing,

because the ordinary data-bearing commands use at most five bytes. Use their actual 1/2/3/5-byte lengths for real IDs, not this upper bound. Add all numeral DAG construction and theorem-statement/unification streams. Fixed template sizes give constant work per cell only when operands are referenced and unification matches saved subterms; copying each long numeral into every cell destroys that model. Generic theorem proofs are checked once, but every instance still costs argument/unification work.

At nibble radix the 768 closed table proofs can be instantiated once per logical proof and reused with `Ref`; four cell table uses then are four local proof references, not four fresh theorem applications. These references still take bytes and heap slots. Preloading all 196,608 byte-table facts exceeds the default 65,536-entry heap; use a bounded used-fact set, direct theorem applications, or a separately sized implementation. No within-proof eviction mechanism was established. Reprove/reload table instances after each scratch reset, and count this setup; global PA derivations of the tables are not repeated if the final stream references the existing theorems.

Generation includes candidate search, factorization/fallback discovery, modular arithmetic to obtain q/r/d, arithmetic proof construction, DAG deduplication, and MMB linking/serialization. Ordinary final verification then checks those derivations. Compact offsets are sufficient input to a generator, but do not measure the emitted proof volume. A straightforward modular witness has up to 3w bits for q/r/d before proof structure, while x/y/M may be references; alternatives can omit d or regenerate witnesses but must retain an actual checked remainder bound.

Memory matters before the campaign forecast. `verifier_types.c:18–65` has a 64-MiB default expression store and 65,536-entry heap. `verifier.c:771–788` resets them at theorem boundaries. The store cannot be assumed reclaimed merely because a temporary is no longer on the stack. Raising implementation limits does not remove the 32-bit store/statement-format constraints. The current format has a further first-4-GiB statement-data bound, described in `README.md:29–48`.

For illustration, the un-deduplicated cell-result layout emits one fresh binary equality term per cell. Its two-argument `store_term` occupies 24 bytes in the inspected C layout. At the full direct schedule, the equality roots alone for two schoolbook products per step would allocate

    132 * 2 * 23^2 * 24 = 3,351,744 bytes per nibble-radix rung,
    132 * 2 * 12^2 * 24 =   912,384 bytes per byte-radix rung.

These are layout-specific accounting floors for that fixed schedule, not a lower bound on all possible MM0 proofs or actual variable-width rungs. They omit numeric nodes, additions and all other terms. Even using nearly 4 GiB of store allows at most 1,281 or 4,707 such rungs in one theorem under those floors. The true fitting pack can be smaller. This is why million-rung logical packs cannot simply be assumed feasible for the explicit proof representation.

Choose pack size only after satisfying both

    scratch(pack) < permitted store/heap limits,
    metadata(ceil(K/pack), joins, tables, library) < format address limits.

Small packs reduce scratch but grow the global theorem table and statement bytes; large packs do the opposite. Splitting every modular step into a global theorem is not a credible default at 10^11 rungs. A proved loop/reflection theorem does not make an ordinary MMB execution certificate disappear. If no feasible pack satisfies both constraints in the pinned implementation, change the proof representation or implementation explicitly; do not import unverified shard conclusions as axioms. The previous composition note gives the complete linking/recheck boundary.

### Same-rule implementation improvements are legitimate candidates

The fixed 32-bit fields and append-only store are engineering choices of the inspected checker. Price a versioned 64-bit MMB/implementation and a reclaiming or streaming verifier **before** declaring an end-to-end ordinary-MM0 route infeasible:

* Widen file offsets, theorem/reference indices and store handles consistently, including tag encodings, bounds checks, allocation arithmetic and parser fields. This removes the particular 4-GiB address limits, not the bytes that must be generated/read. Version and test the format; do not reinterpret old bytes silently. Wider references can increase proof/table bytes, so recalculate the actual encoded lengths rather than retaining the five-byte command bound above for the new format.
* Reclaim expressions when no live stack, hypothesis, retained theorem-unification structure or reference can reach them. Generator-supplied last-use/drop hints are untrusted: dropping a fact must either be validated or make every later reference to it invalid. Preserve handle identity, reject stale references and prevent slot-reuse aliasing. A reference-counted or tracing implementation can leave the logical `Thm`, equality and conversion checks unchanged. An explicit drop instruction is a storage operation, not a new inference granting propositions.
* Stream proof bodies while retaining checked statement interfaces and the state needed for current inference. The full final run still checks every declaration in dependency order against the external PA specification; old theorem bodies need not remain in RAM. Statement tables may be widened, paged or externally stored with exact immutable-input binding. The source checker currently uses a mapped file, so this is implementation work, not a capability already demonstrated by its `main.c`.

These are ordinary-rule MM0 implementations, distinguished from a native arithmetic acceptance rule. Their assurance is to be judged by the same standard used for Lean's kernel implementation: a precisely specified trusted checker implementation, source review, appropriate tests and reproducible artifacts, unless the project explicitly chooses a stronger machine-verified implementation standard for **both**. This report does not demand a compiled-binary correctness theorem uniquely from MM0. Invalid-memory handling, overflow, parser/target binding and inference preservation are real validation work; they are not new mathematical premises. A formal refinement proof is an optional stronger assurance project, charged explicitly on either side.

For a credible efficiency comparison include three rows: pinned mm0-c; widened/reclaiming ordinary-rule MM0; and a separately justified arithmetic accelerator. The second may remove the pack-size obstruction and avoid excessive global declarations. It does not by itself remove digit events or expanded proof I/O. The third could change that arithmetic cost, but then the new acceptance mechanism and its soundness must be stated rather than charged as an ordinary multiplication instruction. Lean should equally be allowed faithful kernel/data-management improvements under the same implementation-assurance policy.

## 7. Missing lemmas and the smallest decisive implementation

The next source implementation, if later authorized, should first close these ordinary proof dependencies:

1. PA-only closed digits, radix encoding/concatenation, digit bounds, full-adder and digit-product tables. Adapt the source hex patterns without adding the coercion axioms.
2. Fused row/carry lemma and outer multiplication invariant; exact decoder-to-numeral bridge; canonical addition/carry and strict-bound witness. Prove every table/bridge rather than adding schema axioms.
3. Concrete q/r acceptance via the actual `eqdivmod` theorem; modular product/square congruence and binary-power invariant, with zero exponents and unused final squares handled explicitly.
4. Proth primality/cancellation and candidate-range facts; actual product factors, gcd and gap transitions if batching is used; general-prime fallback with full dependency closure. Shared prime facts need checked proofs, not probable-prime results.
5. Optional difference-Karatsuba identity, signed-case witnesses, split/concat accounting and exact proof-event templates. A byte table bootstrapped from nibble PA proofs is an independent optimization choice.
6. Exact pack completeness, short final pack and final root target; all mathematical conclusions use actual source integers, not merely successful parser tags.

A decisive later test is a **real** complete direct Proth proof at the required 90-bit size, then a nonidentical 32-rung product group at up to 2,880 bits, including quotients, factor reductions, gcd, final tests and composition. Produce ordinary proofs against the chosen PA specification, with no schematic arithmetic axioms or sorry. Compare nibble/byte schoolbook, then Karatsuba only where necessary. Record the exact event vectors, encoded bytes, allocated scratch, table/setup proof cost, generation time and final checker time separately. Reject wrong quotient, bad remainder bound, changed product factor, skipped group position, false gcd and changed final residue. No such test is performed or authorized by this report.

For full Goldbach in MM0, the analytic foundational/library translation remains separate. Even a completed PA arithmetic kernel would establish only the finite-certificate part, not the complete end-to-end proof. The cheapest credible architecture to develop first is the direct small-modulus radix circuit plus shared tables and bounded logical packs; include a widened/reclaiming ordinary-rule implementation if the pinned format obstructs useful pack sizes. There is no asserted runtime winner. Native arithmetic accelerators or verified executable acceptance paths form an additional comparison, with their own stated soundness boundary, not an assumed capability of either existing checker.

## Pinned sources

Workspace-relative paths below bind the inspected source and input reports. The Rust/helper sources were read, not imported or executed. The `.mm1` arithmetic proofs are source evidence, not a new verification run.

| Source | SHA256 |
|---|---|
| `work/mm0-efficient/toolchain-sources/examples__peano.mm0` | `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052` |
| `work/mm0-efficient/toolchain-sources/examples__peano.mm1` | `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079` |
| `work/mm0-efficient/toolchain-sources/examples__peano_hex.mm0` | `E2F5E461C568E0E3EF784B507E9111272B38956093DF98B943CCC4CD806E351B` |
| `work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1` | `76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94` |
| `work/mm0-efficient/toolchain-sources/mm0-rs__src__mmc__proof__norm_num.rs` | `04C0E3A0A1B5BAAF3BA063B4A332A952E7AA34659C09D19EC8EA74F2E412AC99` |
| `work/formal-goldbach-bench/mm0/smoke.mm0` | `61E258EF306318072DFE9D6E28D1C57BECFFCFEFDE6BC6AA49E4156F1EE969F1` |
| `work/formal-goldbach-bench/mm0/src/mmb.md` | `E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0` |
| `work/formal-goldbach-bench/mm0/src/verifier.c` | `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5` |
| `work/formal-goldbach-bench/mm0/src/verifier_types.c` | `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E` |
| `work/formal-goldbach-bench/mm0/src/types.c` | `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1` |
| `work/formal-goldbach-bench/mm0/src/README.md` | `5ADA16E00CD2F72E7F83D247768CDE6ADE34E56962B1858BC014FABEDC900A70` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Check.lean` | `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `work/qrh-campaign/agents/independent-feasibility/EFFICIENCY_MIXED_LADDER_2026-11-11.md` | `9AACAF7FC0B5DCD9145AB3006D40248A2C7D57319677C57600890D21E5F75783` |
| `work/qrh-campaign/agents/integration/EFFICIENCY_PROOF_COMPOSITION_2026-11-11.md` | `FE62515193754C19CDB4A34728765CFA09DD5BEDD1694E5D575DCC79EE7D4E9B` |
| `work/qrh-campaign/agents/prime-estimates/LEAN_MM0_COMPUTATION_COMPARISON_2026-11-11.md` | `FE173489DF0A8BA350CEA64BEF89B27F756E2815853C9C2E492B673E670D805F` |
