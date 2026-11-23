# Ordinary-MM0 proof volume for the current spectral budget

2026-11-11. Source research and symbolic cost models only. No proof generator, verifier modification, build, numerical evaluation or timing experiment was performed. All earlier artifacts remain unchanged.

## Finding

The current operation inventory is large, but it is not a proof-byte inventory. Generic arithmetic theorems can be checked once, their concrete applications can refer to shared terms, and repeated exact inputs or coefficient data can share checked facts. Ordinary MM0 does not require a separate expanded giant theorem statement for each real operation.

It does require an ordinary justification of every concrete fact actually used in the final proof. A universal theorem that a multiplication or FFT algorithm is correct does not establish that an untrusted list contains its output. A concrete execution proof, another exact verification argument, or a mathematical shortcut proving the needed property must still connect that list to the inputs.

The main unresolved volume questions are the materialized witness set, the widths of those witnesses, sharing across the chosen proof blocks, and the compiled instruction/term representation. None is fixed by multiplying the real-operation count by a universal bytes-per-operation price. Conversely, compact algorithm source or compressed proof input does not show that its verification work is small.

## 1. The workload being discussed

The [current spectral operation budget](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-blueprint/CURRENT_SPECTRAL_OPERATION_BUDGET_2026-11-11.md) and its [review](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/REVIEW_CURRENT_SPECTRAL_OPERATION_BUDGET_2026-11-11.md) concern the fixed-order, pruned R132900 large branch. They quote

    G = 1849018578634950 general complex products,
    A = 3808420069398260 complex additions/subtractions,
    N = 99513098256768 residue-height inputs.

With twenty Taylor coefficients, H=19N is the Horner-stage count. The stored composition gives 11177572048296984 real products and 15096375029823604 real additions for the four-product choice. The fixed-coefficient three-product choice gives 9328553469662034 and 16945393608458554 respectively. These are quoted checked inventory values, not new computations in this note.

The inventory excludes seeds, coefficient setup, other scalar transformations, rounding, interpolation, sign/contour and completeness work, the small-conductor branch, binary/ladder work and analytic proof libraries. The three-product rows also require their own width, sign and error implementation. This note neither treats them as completed spectral data nor picks the cheapest implementation from these counts.

## 2. What the current verifier already compresses

The pinned source is `digama0/mm0` revision `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`, in [the local source directory](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/formal-goldbach-bench/mm0/src).

`verifier.c:479-517` applies a checked theorem schema and checks its instantiation without replaying its derivation. `Ref`, `TermSave`, `ThmSave` and `Save` let a local proof reuse expressions and proven instances. Thus the following costs differ:

1. Proving a generic digit/carry, signed-addition, multiplication, rounding or FFT lemma.
2. Instantiating it with particular operands and supplying its required hypotheses.
3. Introducing those operand/witness terms into the current proof context.

There is a useful stronger source fact. In `run_unify`, `verifier.c:241-249`, a `URef` matches the saved expression by arena identity. It does not traverse all its digits. `UTerm` at 252-280 inspects the fixed constructor skeleton and its children. A fixed-size schema with opaque large-number arguments can therefore have bounded structural matching work when its concrete terms are already shared. The argument-sort and dependency checks at 491-511 depend on the schema's arguments and bound-variable masks, not on expanding each natural numeral anew.

This is conditional on actually supplying the same checked term references. Two separately constructed equal-looking numerals are not automatically the same arena object; a generator must share their construction or provide the required conversion/equality proof. It cannot substitute a hash collision or an unproved semantic normalization for equality.

`types.c:205-208` and `verifier.c:151-161` encode a command in 1, 2, 3 or 5 bytes according to its data field. Those are instruction sizes, not per-arithmetic-gate sizes. Argument references, term construction, conversions, local arithmetic proofs, statement tables and the public specification are additional. Whole-file counts/offsets are bounded in the stock format. A larger stream needs the same-rule transport/storage changes already identified in the streaming and parallel notes.

## 3. Two explicit accounting levels

Let proof blocks be indexed by s. For a concrete proposed encoder, partition its emitted proof commands into numeral/term construction C_num,s, arithmetic and error proofs C_arith,s, and binding/join commands C_join,s. Count each command exactly once. Let D_s be the declaration, unification-program and specification bytes introduced by block s, excluding the library. If lambda(c) is the actual encoded command length, the expanded proof-stream size is

    B_expanded = B_library + sum_s D_s
                 + sum_s sum_(c in C_num,s union C_arith,s union C_join,s) lambda(c).

In the pinned format lambda is one of 1,2,3,5. In a proposed widened local-index format it is a parameter of that encoding, often growing with the relevant index width. Keeping an old 5-byte ceiling while silently allowing unbounded indices would be inconsistent. Reuse local indices only with the validated lifetime/generation discipline.

The corresponding command count is I_expanded=I_library+sum_s |C_num,s|+|C_arith,s|+|C_join,s|. Verifier work also includes executed unifier instructions, type/dependency checks, syntax allocation and input processing. One `Thm` command can invoke several unifier instructions. A macro application count is therefore not itself an instruction count or a time measurement.

For an earlier-stage model, classify concrete arithmetic gates by kind k, operand digit lengths n,m, output/temporary capacities, rounding grid and context. Let V_g be the ordinary arithmetic command count for gate g after compilation, S_g its sign-adapter commands, R_g its rounding/bound commands, and U_s the term-introduction and context work in block s. Then

    I_model = I_library + sum_g(V_g+S_g+R_g)
              + sum_s U_s + I_joins + I_setup + I_other_phases.

The reviewed schoolbook/Karatsuba functions are useful predictors for V_g, but several are unsigned macro skeletons with explicit exclusions. The signed bridge's 14/14/22 numbers are wrapper applications, not substitutions for S_g in command units. A compiled generic wrapper may contribute a fixed number of commands plus references, but that number has not been established for the full encoder.

For storage planning define Intro_s to be the multiset of concrete objects actually introduced during block s. It includes reloads after reclamation, not merely distinct values over the entire campaign. If nu(v) is the cost of introducing v in the selected checked numeral representation, then U_s includes sum_(v in Intro_s) nu(v), references to those objects and any checked decompositions. An operand does not pay nu(v) on every use if it remains shared. Nor may a value discarded after block s be reused for free in a later fresh context.

One concrete starting proxy uses N_mul(n,m), N_add(n) and N_round(n) for the actual width histograms. The earlier ordinary-natural templates give

    M_school(n,m) = 5*n*m + 2*min(n,m) + 1,
    A(n) = 2*n + 1,
    Round_b(n) = 2*Split_b(n) + 3*A(n+1) + 3*n + C_b.

The last line includes the conservative canonicalization path from the signed bridge and excludes exponent and term-format work. Its Split_b(n)<=c_b*n+c'_b requires fixed radix and the specified local proof library. A gate-skeleton ledger can therefore start with

    K = sum_(n,m) N_mul(n,m)*M_selected(n,m)
        + sum_n N_add(n)*A(n) + sum_n N_round(n)*Round_b(n)
        + K_sign + K_exponent + K_setup + K_join.

M_selected may be a justified schoolbook or Karatsuba schedule. These terms must all use the same macro-count convention, and shared work must not be counted twice. K is still not I_expanded. To refine it, separate macro families j with occurrence count K_j and actual compiled command count c_j, and separately count newly constructed terms and reference occurrences. Then a concrete encoder can establish

    I_expanded = I_library + sum_j K_j*c_j
                 + I_new_terms + I_references + I_extra_conversions + I_metadata_proofs.

This equality is a bookkeeping specification after every emitted command has been assigned exactly once, not an asserted value for the unknown c_j. Fixed-arity templates can have bounded c_j independent of large operand widths when those operands already exist as shared terms; their original construction remains in I_new_terms. Dynamic proof branches need their actual c_j or a proved bound. Together with the command-length formula this yields a byte model once the missing encoder facts are supplied, without assigning every arithmetic gate a giant standalone statement.

These formulas expose the quantities still missing. The aggregate G,A,N counts do not determine the distribution of n,m, the number of introduced objects, the number of carries and split witnesses, or the actual declaration strategy.

## 4. Sound opportunities already compatible with ordinary rules

**Generic libraries and digit tables.** Prove each finite digit fact and generic carry/fold/sign/rounding lemma once. Concrete digit operations refer to those checked facts. The table's construction, proof checking, retained memory and lookup binding are real costs. In a natural-number foundation, the hexadecimal example's separate coercion axioms are not free PA theorems. Closed natural digits and their range facts need the replacements described in the signed-bridge review.

**Shared input and coefficient syntax.** Keep the exact coefficient, its bound proof, cached coefficient sums and relevant roots/phase data live across their actual uses. Specialized theorems can keep the fixed coefficient as an opaque parameter. This avoids recopying its bits and re-proving its bounds. It does not prove c*x for every new x without the relevant arithmetic witness. A specialized digit-times-c table or fixed linear-map circuit may be useful, but its setup, carry work and storage must be compared with the existing multiplication schedule rather than declared free.

**Exact instance memoization.** A previously checked operation can be reused if all operands, operation semantics and required output contract agree. For rounded operations the key includes the grid, tie rule and canonicalization convention. It also includes any bound or enclosure being claimed. Producer indices must be bound to these exact objects. A repeated coefficient alone is not a repeated multiplication instance.

**Block-level logical proofs.** Prove once that a particular butterfly, Horner step, FFT stage or rounded straight-line program preserves its invariant. A block proof can use that schema rather than reproduce the invariant's derivation for every gate. Its concrete arithmetic hypotheses remain. A generic loop theorem needs a proof of its transition for the represented run, or another theorem that establishes the loop property for all states admitted by its premises. Checking only a loop count and final-state label is insufficient.

**Avoid unnecessary canonical intermediates.** The signed bridge permits exact sign/magnitude values with negative zero and shared dyadic grids internally. This avoids extra comparisons and repeated trailing-zero scans. Canonical exported zero and odd-mantissa normalization are paid where the protocol actually requires them. The accepted correction uses the current exponent h, not unconditionally the target grid g. The proposal changes no error allowance by itself.

**Fuse multiplication, split and rounding witnesses.** A future ordinary theorem can verify a limb multiplication directly against its output split A*B=2^k*q+r and the carry chain. It need not serialize a separate full product numeral P and then serialize the same digits again as q,r. Rounding can use the proved discarded digits. This is the same exact arithmetic identity, with a different proof interface. It still requires all needed digit/carry equations, remainder bounds, signs and tie handling. No compiled implementation or quantified saving is claimed here.

**Prune only proved-unnecessary work.** The current fixed-order primitive-output pruning already removes a dependency-closed subgraph. It must not be counted as a new proof-compression saving a second time. Further omission requires proof that the removed facts are not consumed, or a different valid computation and error argument. A trace need not expose every temporary as a global theorem, but every retained conclusion must remain justified.

These options can remove repeated syntax, redundant concrete objects and repeated derivation of structural lemmas. They do not justify assuming that all concrete output digits are equal across different inputs.

## 5. Further compression changes the certificate design

A deterministic proof generator can describe a repetitive stream compactly and expand it while a trusted checker consumes the ordinary instructions. Its generator need not be trusted if every expanded step is checked. Archive bytes B_archive may then be much smaller than B_expanded, while verification still processes the expanded command work. The generator must be reproducible from retained inputs. A program which merely recomputes a result natively and submits an acceptance flag is not this construction.

A trusted transport decoder may also expand a bounded template into ordinary checked instructions. That is same-rule engineering only if the expansion and all instantiated ordinary checks are enforced. A new trusted instruction that accepts a large product solely because native multiplication agrees would be a different arithmetic trust boundary. The same policy must be applied to a Lean comparison.

The deterministic nature of the spectral computation defeats a naive information argument that every intermediate must contribute a fresh width-sized payload. Intermediate values can be regenerated, left symbolic, or checked through another exact identity. Conversely, a short generating program is not a short proof of its output's required sign or enclosure. There is no established universal lower bound of G times a full independent giant term, and there is also no established sublinear verification of this workload.

Batch exact verification can sometimes trade many equalities for a larger algebraic computation. Packed integer products require proved field separation, carry/no-wrap bounds and exact extraction. Polynomial-identity verification by deterministic evaluation requires a sufficient exact evaluation set and degree assumptions. Modular verification requires enough proved coprime moduli and an integer bound to lift congruence to equality. Each is a different concrete certificate whose full arithmetic and support costs must be counted. A random checksum or a few sampled gates do not give the required unconditional ordinary proof.

Coarser interval propagation or truncated high-limb multiplication might avoid some low digits if a proved omitted-part bound still fits the analytic margin. That would change the numerical/error proof, so it is not credited in the current budget. It is potentially more useful than compressing a literal full-product trace, but no result here shows that it succeeds for all the required spectral outputs.

Symmetry also needs exact semantics. Conjugation and sign changes preserve many exact algebraic identities, but ties-toward-positive-infinity rounding is not odd. Negating a rounded value need not equal rounding its negation at a tie. Reusing a conjugate/negative rounded trace therefore needs a tie-free proof, an explicit correction or a separately proved enclosure contract. The fixed-reference-circuit precision inheritance must not be lost silently.

## 6. Block size, retained state and parallel checking

The streaming note permits one checked generic library and a bounded proved interface in a continuing verifier. Its deletion policy reduces live memory, not the ordinary proof work already needed. Increasing block size can improve operand/table reuse and shrink repeated headers and imports, while increasing live scratch and index widths. Small blocks may repeatedly introduce the same input or coefficient objects and repeat local theorem instantiations.

If a coefficient fact of introduction cost T_c is used in h blocks, independent local contexts may pay h*T_c. A validated persistent checked cache pays T_c plus h reference/import costs, with its retained memory and eviction/reload costs. This is a concrete amortization model. It is not a guarantee that every coefficient can remain resident throughout the full family. A useful schedule groups operations by genuine coefficient reuse subject to dependencies and the checked rounding order.

The parallel note permits trusted workers to check different blocks and the coordinator to join their exact checked schemas without serially replaying their arithmetic. One shared library costs one library check; P independently initialized persistent workers cost P checks. Both differ from N fresh library checks for N blocks. Parallelism changes wall-time possibilities and simultaneous memory, but not the total proof-byte requirement by a factor P. It may increase import duplication unless the retained-state design accounts for it.

Final summaries must be small statements genuinely proved from the blocks, such as a quantified coverage or completeness property with the required endpoint data. A conjunction or list of every intermediate is not bounded merely because it is called a summary. A hash of a discarded proof cannot replace its checked provenance.

## 7. The feasibility questions still unanswered

The next cost model should specify, without assuming new spectral success:

1. The actual gate-width distribution and rounding policy for the chosen circuit, including coefficient and product-width asymmetry. The current common precision is only a safe envelope.
2. A concrete proof-block interface and materialization policy: which input/output, carry, quotient, residue and bound objects are introduced, shared, exported or regenerated.
3. The instruction templates for one unsigned product, signed addition, multiplication-to-split/rounding gate and block join, including every binding and conversion. Generic library setup is separate.
4. The number of distinct coefficient/cache entries and their live-use spans. Count cache reloads and worker duplication rather than assuming a permanently resident whole-family table.
5. The transport's expanded instruction bytes, term/declaration bytes, archive bytes and maximum live memory as separate quantities. No instruction-count proxy settles all four.
6. The omitted seed, phase, interpolation and completeness proofs. Transform/Horner reductions do not price those stages or the remaining analytic and binary proofs.

These are narrower and more informative questions than either assigning a giant independent proof to every real operation or extrapolating from a tiny fixed arithmetic benchmark. The source supports substantial structural sharing and theorem reuse. It does not yet establish a manageable full certificate size, nor does this audit establish an unavoidable impossibility at the quoted operation count.

## Pinned evidence

The reports were read at the following versions; no new operation inventory was executed. Source references use the same pinned C snapshot as the accepted streaming and parallel reports.

| Artifact | SHA256 |
|---|---|
| `work/qrh-blueprint/CURRENT_SPECTRAL_OPERATION_BUDGET_2026-11-11.md` | `D0D428B355F2DBD025DBE2BD6C4D1DC846B63892A81506445EC242571A8C1C7F` |
| `work/qrh-blueprint/compose_current_spectral_counts_20261111.json` | `34A6EFE3835098016854040A19F75431AFCF20DE115BD93FF8F6A7117B64B958` |
| `major-constants/REVIEW_CURRENT_SPECTRAL_OPERATION_BUDGET_2026-11-11.md` | `67F2BB3478329495B453DAD2283FD24A6FB936CCA975AD3B7B29716D2D494B8D` |
| `audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md` | `53AD15DAE3EE3F19B1ABEA27B26F4ECD593ED7F6C557001FC2BF2A5B7957FE40` |
| `audit/EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md` | `4927B1604C4E13A001CDD3C9176F024D11A3FA8ECB0C6EB35F3C70A0B9F100FE` |
| `independent-feasibility/REVIEW_EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md` | `AA3EF5871BD12DDD6479C7A0C978F746E6EB8DAB57A04791323322552CDC7C43` |
| `prime-estimates/EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md` | `EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD` |
| `prime-estimates/CLARIFICATION_SIGNED_DYADIC_CURRENT_EXPONENT_2026-11-11.md` | `8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03` |
| `audit/REVIEW_EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md` | `E3EFDD1A7DC6185E02421DDB0E50417748FB694EA663E5663AAE6416446266A7` |
| `work/formal-goldbach-bench/mm0/src/types.c` | `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1` |
| `work/formal-goldbach-bench/mm0/src/verifier.c` | `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5` |
| `work/formal-goldbach-bench/mm0/src/verifier_types.c` | `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E` |

Agent paths in the table are relative to `work/qrh-campaign/agents`. No theorem or runtime result is inferred from the hashes themselves.
