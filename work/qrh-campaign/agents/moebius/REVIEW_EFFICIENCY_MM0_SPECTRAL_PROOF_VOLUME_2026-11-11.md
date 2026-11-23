# Review of ordinary-MM0 spectral proof volume

2026-11-11. Independent source and symbolic-model review. No build, verifier execution, proof generation, spectral evaluation or operation-inventory rerun.

Verdict: PASS at the stated source/research scope, with no required correction. This accepts the distinctions and conditional accounting models. It does not establish an implemented arithmetic library, a full certificate size, feasible production cost, or a sound new streaming/parallel checker.

Author file: `audit/EFFICIENCY_MM0_SPECTRAL_PROOF_VOLUME_2026-11-11.md`, SHA256 `B171309E58A36A2F9F708CD663118577C660423A1C424CB1544DBC6D48AB5408`. I read the complete report and checked all twelve entries in its source ledger against the current files. The frozen author bytes remain unchanged.

## Actual identity and theorem reuse

The key implementation claim is correct. `verifier_types.c:32–63` stores expressions and child links as offsets into `g_store`. Its `get_uheap` at line 80 removes the saved-entry tag. `verifier.c:241–249` checks `URef` by equality of that store offset and the popped target offset. It does not walk the numeral or compare its interpreted integer value. `UTerm` at lines 252–280 checks the constructor identifier, then visits the immediate child positions required by the unifier program. A fixed constructor skeleton ending in shared `URef` leaves therefore has matching work independent of the internal digit lengths of those leaves.

That conclusion is local and conditional. `ALLOC` at lines 109–116 advances the arena and constructs a new object; `Term`/`TermSave` allocate a term rather than automatically interning all equal syntax. Two separate constructions need not match by `URef` even when mathematically equal. The generator must reuse the actual object or furnish the ordinary conversion/equality proof needed by its surrounding use. Hash equality is not the implementation's identity relation. The report states these restrictions correctly.

`Thm`/`ThmSave` at lines 479–517 require a theorem index below `g_num_thms`, check argument sorts and variable-dependency restrictions, and invoke the theorem's unifier. They do not replay its proof body. `UHyp` at lines 297–316 consumes proof-tagged hypotheses in application mode. Thus bounded schema matching does not eliminate a generic arithmetic theorem's concrete hypotheses. An axiom is also a theorem-table entry, so standard-axioms-only use additionally requires the exact permitted specification and complete prior proof checks. The report's claim presupposes that policy; a table index alone would not establish it.

The theorem boundary at lines 770–790 resets the local store and stacks, checks a single final proof value, matches the declared conclusion and hypotheses, and only then advances the frontier. The stock `Ref` mechanism is not a persistent concrete-instance cache across that reset. The report's cross-block amortization examples must be read with its cited proposed retained-state interface, or with the cost of ordinary re-instantiation. Its text does so.

The completion qualification matters. `Conv` at lines 537–543 and `ConvCut` at lines 600–606 put assertion/proof-shaped data under a pending conversion obligation. A cache or worker cannot publish that data alone. Declaration completion and the final unifier checks at lines 233–239 must discharge the obligations. The cited streaming/parallel designs retain these gates. Nothing in the reviewed report authorizes importing a worker flag, hash or partial proof tag as a theorem.

## Bytes, commands and arithmetic work

`types.c:205–208` defines packed command layouts of 1, 2, 3 and 5 bytes. `cmd_unpack` at `verifier.c:151–161` reads those layouts. These are command sizes in this bounded-index format, not full operation-proof sizes. The author correctly separates term construction, proof commands, declaration/unifier tables and public specification bytes. Unifier execution costs work even when its instruction bytes were stored only once in a generic theorem. A theorem application therefore need not have either the cost of one primitive check or the cost of replaying the theorem body.

The equations for expanded bytes and commands are valid as accounting definitions if every emitted item is assigned exactly once. In particular `D_s` must own declaration/unifier/specification bytes outside the listed proof-command sets, and term construction cannot be counted both inside compiled macro costs and in `I_new_terms`. The author expressly requires this partition. The formulas do not supply unknown compiled macro sizes `c_j`, width histograms or allocation counts.

I checked the quoted rounding model against the signed-dyadic source: its lines 107–119 give one split plus three addition calls for rounding and a further split plus `3n+O(1)` for normalization. The combined `2 Split_b(n)+3 A(n+1)+3n+C_b` is a macro model under its radix/representation assumptions. The 14/14/22 sign counts remain wrapper applications. Neither may be substituted directly for ordinary verifier instruction counts. The separate current-exponent correction is pinned and retained.

Independent integer arithmetic reproduced the four quoted real-operation totals from the stored values of `G`, `A`, `N`. With `H=19N=1890748866878592`, the four-product expressions are `4G+2H=11177572048296984` and `2G+2A+2H=15096375029823604`. The fixed-coefficient expressions are `3G+2H=9328553469662034` and `3G+2A+2H=16945393608458554`. This is a check of composition, not a rederivation of the conductor inventory or evidence that the respective widths/errors have been implemented.

## Compression and remaining evidence

The proposed savings are sound possibilities, not credited measurements. Checked generic lemmas can replace repeated structural derivations. Exact-instance memoization must retain all operands, representation conventions and claimed bounds. A repeated coefficient does not by itself make different products the same fact. Fusing multiplication, split and rounding can avoid duplicate numeral materialization, but still requires the exact product/carry/remainder and signed tie obligations. Archive compression or deterministic regeneration can reduce retained input without reducing the number of expanded instructions checked.

The warning about rounding symmetry is correct: nearest ties toward positive infinity is not an odd function. A conjugate or negative trace requires a separate argument at ties or an enclosure contract that tolerates the changed result. This is a substantive restriction for reusing spectral traces.

No argument here proves an information lower bound of one fresh width-sized witness per arithmetic gate, or proves sublinear verification of the selected circuit. Untrusted outputs may instead be certified by a different exact identity, but every support condition of that identity remains part of the proof. Deterministic polynomial checks require enough points and degree bounds; modular checks require certified moduli and a lifting bound. Sampling cannot be silently substituted.

The remaining practical question is a concrete ordinary-proof implementation: compile a complete representative signed product/split/rounding and block join, count its distinct introduced terms and full command stream, and measure reuse under a defined live-context policy. The report does not claim that work has happened. Seeds, phases, contour/completeness arguments, finite prime/coverage evidence and the analytic foundation remain outside its quoted spectral operation totals.

## Source pins and scope

The C snapshot is the campaign copy of `digama0/mm0` revision `0d414c0bfdaaeb7fea571895127abc1fa5a3d956`, under `work/formal-goldbach-bench/mm0/src/`.

| Source | SHA256 |
|---|---|
| `verifier.c` | `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5` |
| `types.c` | `B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1` |
| `verifier_types.c` | `87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E` |
| Stored spectral composition receipt | `34A6EFE3835098016854040A19F75431AFCF20DE115BD93FF8F6A7117B64B958` |
| Streaming proposal | `53AD15DAE3EE3F19B1ABEA27B26F4ECD593ED7F6C557001FC2BF2A5B7957FE40` |
| Parallel proposal | `4927B1604C4E13A001CDD3C9176F024D11A3FA8ECB0C6EB35F3C70A0B9F100FE` |
| Signed-dyadic proposal | `EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD` |
| Current-exponent clarification | `8400322999DE07ED203F1556EEC5D8771B9E2910533BFF231C96E244C05BDF03` |

This review inspected the relevant source bodies and cited support, rather than proving the C checker correct or re-reviewing its complete parser. It approves no change to the inference rules and no claim of successful spectral production.
