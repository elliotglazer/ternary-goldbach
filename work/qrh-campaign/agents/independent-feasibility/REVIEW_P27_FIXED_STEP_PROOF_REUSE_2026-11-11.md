# Independent review: fixed-step P27 proof reuse

2026-11-11. **PASS at the stated conditional paper and integer-metadata scope; no correction requested.** The proposal supplies a sound ordinary-arithmetic table invariant and a correctly counted reduction of one specified unsigned schoolbook proof-template subtotal. It does not establish lower total checking time, a complete stock-MM0 encoding, or a faster implementation than Lean's kernel arithmetic. These qualifications are material to the verdict.

## Frozen evidence

Author: `../moebius/P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md`, SHA256 `F578D50723A09A1580D6ACFBA4F6AEB93371AF81B7929121A9F402E0ED5A38D0`.

Metadata code: `../moebius/p27_fixed_step_table_metadata_20261111.py`, SHA256 `3275463370F2DB342F5EC1DF7B32FFBE06077746D19E765E869118D4D2F1908E`.

Metadata JSON: same stem, SHA256 `90B05A81CC8F40804722F9E4324DD8F4EB47BD9BE92C475AFD0A8C58724F0300`.

I read the complete author packet and independently verified all nine input pins recorded there. I also read the relevant actual MM0 verifier code and the predecessor digit-table proposal. The directly inspected verifier files are `work/formal-goldbach-bench/mm0/src/verifier.c` (`71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`), `verifier_types.c` (`87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E`) and `types.c` (`B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1`). Paths in this paragraph are relative to the repository root.

The prior independent P27 workload review is `REVIEW_REDUCED_PREFIX_SELECTED_P27_SEED_COST_2026-11-11.md`, SHA256 `97DBD89B29ADED5E74EA92457D67134D109920A8EA53C95028E779D7B9AAB507`. Its selected main-prefix count, rather than a P24 or auxiliary-prefix workload, is the input here.

## Exact arithmetic and widths

The state has 140 fractional bits and the step has 142. With coordinate magnitudes below two, their unsigned mantissas are below `2^141` and `2^143`; the common 144-bit cap therefore fits eighteen radix-256 digits. This is a fixed-grid argument. It gives no permission to align arbitrary exponent gaps at the same width.

For a fixed nonnegative coefficient `c<256^18`, the 256 table facts `T_d=c*d` follow by ordinary addition and the successor/distributivity identity. They fit nineteen digits. A most-significant-digit traversal maintains `v=c*p` for the processed prefix. Appending digit `d` gives `256*v+T_d=c*(256*p+d)`. Every processed prefix is bounded by the complete eighteen-digit operand, so the product and its intermediate prefixes fit thirty-six digits. The signed complex output sums may require an additional bit or digit: the thirty-six-digit claim is a product bound, not a bound for the complete signed update. Those sums and final rounding remain separately charged common work.

The four products are exactly the original `au`, `bv`, `av`, `bu`; the original two signed combinations and rounding rule are retained. Thus the improvement does not introduce another numerical error term. This conclusion requires the table identities to bind the actual coefficient, digit, and result terms, and the operand decomposition, signs, carries and rounding witnesses to be proved. A hash or an external lookup is insufficient. The report states those obligations explicitly.

## Independent count reconstruction

I independently reconstructed the formulas and all five tile schedules using integer arithmetic, without executing the author's script or constructing any phase, table value, seed, transform or spectral value. The reconstruction counted full tiles and remainders separately for old and newly introduced arguments in every band, rather than copying the author's ceiling expression. The inline check completed successfully in tool record `a604ca`; there is no separate retained reviewer receipt.

For the specified macro families,

`A(k)=2k+1`, `M(n,n)=5n^2+2n+1`,

`T(n)=(n-1)A(2n)+n+(n-1)=4n^2-n-2`,

`S(n)=2[255(2n+5)+4]`.

At `n=18`, these are `M=1657`, `T=1276`, `S=20918`. Four products save 1524 events per update before setup. The strict setup crossover is fourteen updates, since `1524*13 <= 20918 < 1524*14`. Setup includes the 255 additions, successor applications and saves for each of the two tables, with the stated base/final allowance. This is a conditional count of these named macros, not an MM0 instruction count.

The five `(D,N,H)` rows reconstruct `U=1351497402624` updates and the old subtotal `8957724784591872`.

| Tile length | Table pairs | New product-plus-setup subtotal | Reduction |
|---:|---:|---:|---:|
|16|84470315248|8664992797350560|292731987241312|
|32|42235157624|7781517770171728|1176207014420144|
|64|21117578812|7339780256582312|1617944528009560|
|128|10558789406|7118911499787604|1838813284804268|
|256|5279394703|7008477121390250|1949247663201622|

All values agree with the frozen JSON. At length 64, 512 entries per pair give `10812200351744` constructed local entries. Rebuild work, band-boundary rebuilds and short final tiles have not been omitted. The method has not accelerated the separate `35130458950228` head reciprocal scales.

## Actual verifier boundary

`verifier.c:241–249` checks shared unification terms by their stored identity. Lines 382–395 implement references, including exact conversion endpoints; lines 479–517 validate theorem references, arguments, dependencies and freshness through unification. Lines 619–632 implement saving and reject saving an unfinished co-conversion. Lines 768–790 reset local proof storage, run and check the proof, and validate the final theorem conclusion. These support the proposed ordinary-rule local reuse; they do not supply a native multiplication or trusted-table rule.

`verifier_types.c:19,28,35` supplies the stated 65536-entry stack/heap and `1<<26` expression-store bytes. Five hundred twelve table facts fit the heap *count*, but this alone proves no complete tile fits: numerals, intermediate expressions, arithmetic arguments, output bindings and pending proof objects also occupy storage. Local facts do not survive the next theorem reset. Persisting closed global table theorems exchanges rebuilding for statement storage and instantiation; it is not free.

The actual `u32` declaration in `types.c:16` and the theorem-count/table fields at lines 54 and 58 support the stock-format warning. Each displayed number of table pairs exceeds `2^32`, including length 256. One theorem per pair/tile therefore cannot encode the entire schedule in that stock count field. Packing several tiles into one theorem is not ruled out mathematically, but requires a demonstrated scratch bound and an actual encoding. It is not established here.

The proposed bounded-global-state extension is separate from these stock features. Exact statement/dependency lifetimes and unfinished conversion state must survive reclamation. An unchecked checkpoint digest would not preserve ordinary-proof acceptance. This review does not impose a whole-verifier formalization requirement uniquely on MM0: implementation validation and ordinary-axiom proof closure remain distinct obligations in both systems.

## Costs that remain conditional

The formula assigns a macro event to a lookup or fusion application. A local `Ref`, a theorem application with argument checking, and construction of the required numeral terms need not have equal costs. The report correctly leaves term construction, decomposition, carry bounds, proof binding, signed operations, rounding and storage outside its subtotal. Those costs cancel only if the eventual implementations really share them. The model is not evidence against Karatsuba, a specialized constant multiplier, an actual smaller-width baseline, or Lean's ordinary kernel arithmetic.

The global count assumes each shared rational argument is updated once in its proper ownership schedule. A naive anchor loop can revisit the same argument and rebuild its tables, so the suggested loop order is not itself a proof of that assumption. Exact ownership maps and the cost of retaining or transposing contributions must be supplied. Every internal height consumed by the twenty-seven-coefficient seeds and endpoint calculations must remain bound to its high-precision state and EM-grid copy. Exporting only the last state would not suffice.

The quoted `1998323784` raw state/step bytes exclude proof objects and do not settle total memory, movement or downstream accumulation. Keeping fewer states may increase retained contributions or recomputation. The author's explicit `Delta_seed_order`, term, binding and storage terms therefore belong in any go/no-go decision, not in an unpriced footnote.

A useful next experiment, if separately authorized, would compare complete ordinary-proof tiles with differing states and all required output bindings at lengths 16, 64 and 256. It must measure generation and checking separately and report setup, terms, proof bytes, scratch and joins. No such experiment, build, analytic evaluation or source modification was performed in this review. Full spectral correctness, elementary/analytic library implementation, and finite Goldbach coverage remain outside this proposal.
