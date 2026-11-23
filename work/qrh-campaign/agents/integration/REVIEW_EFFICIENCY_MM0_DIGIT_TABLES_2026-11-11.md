# Independent review of ordinary-PA digit tables

2026-11-11. **PASS at source-supported proof-schema and conditional cost-model scope.** No mathematical correction is required to `prime-estimates/EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md`, SHA256 `DAA7F4625A1CCF8D9307AF59D1FA0C74416CCF38F9B87BBC8547C0F0D74836F3`.

This verdict does not establish a radix winner, an implemented PA-only arithmetic backend, generated table proofs, verifier timing, or full MM0 formalization. Byte and ten-bit digits are reasonable proposed **test priorities**, but the source and event model do not supply a calibrated backend-cost basis for preferring them. The opening phrase about the square table not being a speed winner is accepted only as a comparison under the specified event schedule; it is not a conclusion about elapsed generation or checking time.

## PA validity and the actual source boundary

I read `examples__peano_hex.mm1:418–508,526–646`. The multiplication generator computes a proposed result at the meta level, then emits a proof using `decmul_lem`: multiplication at a successor is reduced to a preceding product equality and an addition equality. The addition/carry generators likewise emit proofs. Recursive radix multiplication and conversion steps are actual source bodies, not a multiplication axiom.

The proposed PA-only adaptation is nevertheless new work. `examples__peano_hex.mm0:67–134` explicitly introduces hex/character coercion axioms, including `h2nlt` and digit value axioms. They cannot simply enter an unchanged PA-only axiom set. Closed natural numerals, with `b0` and `b1` defined at `peano.mm0:288–293`, avoid that import. The generic radix interpretation and conversion facts then require ordinary proofs. The author explicitly retains this obligation.

For dense table generation, `a*0=0` followed by `a*(d+1)=a*d+a` is a noncircular PA construction. The symmetric-row proposal is also well founded: at a>0 its diagonal uses the preceding row's `(a-1)*a` by commutativity; a=0 is the zero base. This saves stored products only if reverse uses pay the stated commutativity/bridge cost. Independently deriving an on-demand entry with the smaller-radix multiplier avoids generating an arbitrarily long row prefix, at its own charged proof cost.

The bounded-carry cell is valid: with four digits below beta,

    x*y+A+c <= (beta-1)^2+2(beta-1) = beta^2-1.

Split the product, perform the two low additions, and combine their one-bit carries with the high product digit. The last carry is zero by this inequality. The generic lifting and row-invariant lemmas are necessary; counting their proposed applications does not mean they have already been implemented.

## Square-table polarization

For 0<=n<=2beta-2, the recurrence `S_(n+1)=S_n+2n+1` constructs square facts from addition and the distributive law. It never needs the as-yet-unproved wide digit product. There are exactly 2beta-1 square facts.

Given digits a,d, check s=a+d and the three square facts. The proposed equality

    S_a+S_d+2z=S_s

combined with `(a+d)^2=a^2+d^2+2ad` gives 2z=2ad by addition cancellation, then z=ad by cancellation of nonzero2. The required ordinary PA bodies are present at `peano.mm1:2097–2105,2120–2149,2401–2408`. The index s<=2beta-2 is within the table. For z<beta^2, every checked sum fits the stated at-most2b+2-bit bound. Thus an incorrect proposed product cannot be accepted merely because its producer used a machine multiplier.

The author correctly pays four addition proofs, three square references and fixed algebraic bridges, and switches carry work back to nibble arithmetic in the genuinely small-library version. Retaining a quadratic wide-adder table while claiming linear total setup would have been invalid; the report does not do that. Ten-bit/nibble boundary conversions remain an additional cost. Sparse caching and specialized squaring could alter the tradeoff, but neither is credited as an implemented optimization.

## Event counts, setup and limitations

I independently recomputed365 fields of the frozen scalar JSON: all table counts, symmetry counts, header sizes, size sensitivities, padded digit lengths, multiplication/modular templates, polarization templates and setup break-even fields. All matched. This used bounded exact integer arithmetic only; the author script was read but not imported or executed, and no tables, candidates or modular residues were generated.

The algebraic schedules are consistent with the earlier definitions `S(n)=5n^2+2n+1`, `A(n)=2n+1` and `Q(n)=2S(n)+A(2n)+A(n)+1`. In particular, symmetry charges extra swaps rather than counting reduced tables and unchanged replay simultaneously. The polarization and hybrid formulas consistently replace the cell cost and the separate additions.

These are **template events**, not measured MMB opcodes or equally priced operations. The hypothetical alpha setup factor must remain hypothetical: proof generation, numeral representation, conversion, unification, reference widths, working-set effects and repeated library checking are excluded or separately parameterized. A high enough amortized workload in this model does not establish a real runtime crossover. Full end-to-end comparison must also retain the primality/chain proof, producer work, import/linking and—where relevant—the still-unformalized analytic library. The reviewed note makes no Lean/MM0 time-ratio claim.

## Theorem use and implementation limits

`verifier.c:470–511` checks the theorem index, consumes a target expression, installs arguments and calls `run_unify`. A closed table fact is therefore a checked theorem application, not an unchecked array lookup; its target must exist and match. Saved proof references can help within a pack, but occupy the local heap and expression store. Hashes cannot replace checked facts or authorize imported assumptions.

The inspected sources support the eight-byte theorem-header count and the fixed 65536-entry heap/64-MiB expression store. Even preloading all ordered byte-product instances alone fills that heap. Direct applications or a bounded working set avoid that particular strategy; they do not erase statement-table cost. The MMB document's `p_data`/unify description and the inspected C structure's `p_args` followed by an inline unification stream are not interchangeable implementation layouts; a future encoder must follow its exact chosen verifier. The common conclusions used here—eight-byte header and32-bit theorem metadata/indices in this version—are supported by both inspected sources.

An ordered 16-bit product table has2^32 entries and exceeds the u32 count before other theorems. The symmetric product count fits u32. Its17,180,131,328-byte header array is a serious engineering cost, but alone proves neither a universal4-GB file limit nor impossibility of all symmetric encodings. Actual offsets, statement layout and allocation arithmetic must be checked. Widened, paged or reclaiming implementations that preserve the same ordinary PA inference rules remain legitimate candidates. They require implementation validation, not new mathematical axioms; apply the same implementation-assurance standard to Lean. Adding native arithmetic acceptance is a separate trust/soundness proposal and must not be called stock ordinary-PA replay.

## Pins and scope

All nine pins listed in the author note's final section match. They are:

| Source/artifact | SHA256 |
|---|---|
| `prime-estimates/mm0_digit_table_sizes_20261111.py` | `3C58CB6A8172EE369B8EBD027A65D68AC97189DAA3705EEF825A042F049D29DA` |
| `prime-estimates/mm0_digit_table_sizes_20261111.json` | `D41C177B0A050CE18C71556FFC3663732EB35372BC92668F7E67FE8AD5C4F079` |
| `work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1` | `76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94` |
| `work/mm0-efficient/toolchain-sources/examples__peano.mm1` | `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079` |
| `work/formal-goldbach-bench/mm0/src/mmb.md` | `E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0` |
| `work/formal-goldbach-bench/mm0/src/verifier.c` | `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5` |
| `work/mm0-fermi/sources/mm0-c_types.c` | `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1` |
| `work/mm0-fermi/sources/mm0-c_verifier_types.c` | `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E` |
| `integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md` | `3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227` |

Additional directly inspected source pins: `work/mm0-efficient/toolchain-sources/examples__peano_hex.mm0` SHA `E2F5E461C568E0E3EF784B507E9111272B38956093DF98B943CCC4CD806E351B`; `examples__peano.mm0` in that directory SHA `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052`.

Agent artifact paths without `work/` above are under `work/qrh-campaign/agents/`. Only this review was written. No frozen artifact, proof source or implementation was changed. No build, generated proof table, numerical candidate or runtime test was performed.
