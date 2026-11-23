# Review of the capped binary-clause compiler

2026-11-11. PASS for the stated finite algorithm, independent certificate interface and conditional cost guard. No mathematical correction requested. The qualifications on partial-tile equivalence and implementation memory below are part of this review. No actual prime data, build, production scan or compression measurement was used.

The frozen author is `major-constants/BOUNDED_BINARY_CLAUSE_PROOF_REPRESENTATION_2026-11-11.md`, SHA256 `A43E9F4B180D0406BE0BC147DD793BD4DEE8F83F44BF86E57BA1479BB19279E3`. Its script is `04996317A13CC000EC173870F51A666C67B2D95CAC6C012E934B531C7F8C60C5` and receipt is `4B6B7C4BB7572F0F636E812F12E2A5ABC4875F1D3AB4C7CD2F354FDF63FC17E6`. All paths here are relative to `work/qrh-campaign/agents/`.

## Exact versus sufficient clauses

Fix the actual source P, palette, tile origin a and positive width W, with a+W<=L. Every clause is a nonempty subset of the M palette indices, and its witness tau lies below W. Two independent certificate properties are needed:

1. Each clause equals the entire source row at its witness tau.
2. Every source row in the tile contains at least one clause.

The second property alone proves the sound Goldbach implication. A hit on its chosen clause is a hit on the target row. The first property gives the opposite coverage implication: if an availability set hits every source row, it hits every clause by looking at the clause's witness row. Thus their conjunction proves equivalence for every availability set A, including A chosen after compilation. The theorem need not know which anchors will later be prime.

Actual-row equality is stronger than the sufficient-clause relation in the predecessor. For example, a row {0,1} may contain the sufficient clause {0}, but A={1} hits the row and not that clause. The new equality check excludes this loss. No assertion that the retained clauses are inclusion-minimal is needed for certificate soundness or equivalence.

The positive anchor theorem still has to establish primality for every set bit of A. A may omit other prime anchors; no proof of their compositeness is needed. The independent source theorem establishes primality only for actual set bits of P. With t<W and s<=D, the source index is at most L+D-1. With r>=1 and L>=D+2, the anchor is at least3, so natural subtraction is exact and the displayed two-prime identity holds. All of these bounds survive changing A or r. They do not make the anchor-primality premise true automatically.

## Compiler invariant and cap

I reconstructed the invariant through each update. If an old clause C is contained in the new row H, leaving the list unchanged dominates H and preserves all earlier rows. Otherwise delete every old clause containing H and insert H with its current index. Every earlier row whose dominator was deleted still contains H by transitivity. No survivor is below H, because the first test failed; none is above H, because those were deleted. Thus the result is an antichain of actual rows dominating every visited row.

The first matching clause and stable survivor order make the declared output deterministic. Equal rows are caught by the first test. An empty source row correctly blocks all availability sets on this palette. With W>=1, a zero cap never yields a successful empty certificate.

Before any new row the successful active list has at most Kcap entries. The two searches therefore perform at most2Kcap subset tests. Insertion can create at most Kcap+1 entries, after which overflow stops the attempt. This proves the stated2W Kcap comparison and W(Kcap+1) copy bounds. With positive word width w and b=ceil(M/w), each comparison examines at most b words. The raw source extraction bound WM and fresh-row bound Wb are independent of source values.

The `(Kcap+2)b` active-mask memory bound applies to the specified in-place stable compaction with a separate new-row buffer. Witness indices, source cache and palette storage are additional. The Python diagnostic uses a new survivor list; it is an abstract algorithm check, not an implementation attaining the smaller memory bound. The author explicitly separates copying implementations, so there is no uncharged implementation claim.

Overflow does not imply a large final antichain. For example, the rows {0,1},{0,2},{0,3},{0} overflow cap2 before the last row, although the completed uncapped antichain has one member. This supports the author's stated limitation. The fallback cannot infer a negative mathematical result from overflow.

## Independent verification and full coverage

The verifier checks each concrete row equality by fresh source extraction, then checks the OR of clause intersection masks equals the exact width-W target mask. The conjunction of those checks proves both certificate properties without trusting the compiler, its subset tests, its cap counter or its internal source reads. Padding and palette indices must be checked before using the bitset lemmas. Source and clause identities are equalities of the actual fixed objects; a digest is not a substitute.

For the described streaming circuit, the QCsum extraction/AND terms, QK OR terms and Q final equalities have the stated interpretation. A shifted word may need two adjacent source chunks and their checked join. The additional KM bit extractions for row witnesses are distinct work. Two accumulators suffice only in addition to the already retained clause data and source-access buffer.

Per-block intersection checking or sparse witnesses then invokes the generic theorem and retains every required positive prime proof. Repeating a prime reference across clauses is valid; inventing or reusing a different anchor's prime fact is not. Actual compiler success alone cannot certify a block.

A cap failure, failed cost guard or absent certificate can select the original direct branch. If a valid exact clause certificate rejects A, direct coverage of the same full tile by that same A also fails. Recovery requires additional certified anchors, another palette or the complete residual/witness branch. Changing A within the palette does not invalidate the compiled theorem.

The selected branch manifest must still partition each block's actual `[0,w_r)` and include all blocks plus the initial binary interval. The last width may be1. There is one important scope distinction: a full-tile theorem can soundly be restricted to a shorter final prefix, but its full-tile clause test need not be equivalent to a direct test on that prefix. Rows {0},{1} and A={0} show this immediately. The author permits direct fallback or separate selection for the partial tile and does not rely on prefix equivalence. A dedicated prefix compilation could restore it. The direct comparator's true shorter cost remains required.

## Cost guard and ordinary proofs

For a specified direct schedule and price model, the algebra is exact. If E_i<=D_i on the selected set S and the one-time charge satisfies C<=sum_S(D_i-E_i), then

`C+sum_S E_i+sum_notS D_i <= sum_all D_i`.

This is a statement about the charged schedule. D_i cannot be an unrelated upper bound advertised as measured savings. The charge C must include concrete row/cover proofs, representation, lookup and extra decision overhead; E_i includes specialization and its actual intersection or witness checks. Source and anchor costs can cancel only when genuinely common. Independent proof environments that repeat compiled-premise checking pay that cost repeatedly.

The producer's separate cap G bounds search work, not total verification cost or successful compression. Failed search and abandoned proof generation still belong in the producer account. The fallback can omit those failed attempts from the final logical proof because it independently establishes the required direct coverage. This is not an assertion that the failed work took no time. Portfolio restarts and the cost-analysis/decoding procedure need their own bounded total, as the note requires.

Ordinary Lean/MM0 reuse is justified at the logical interface only. The final artifact needs checked concrete premise proofs and actual theorem references. Neither a correctness theorem paired with an unchecked native run nor an unchecked file identifier supplies them. The new note designs those proof objects but does not implement or time them. Its generic theorem can be reused; whether the representation and theorem application are cheaper than direct masks remains unresolved.

## Independent evidence and remaining boundary

I read the full author note and script and verified their hashes and the four prerequisite pins. The new independent set-based script `zero-sum/review_bounded_binary_clause_20261111.py` has SHA256 `F1BC8A553558F592B6D1892C20A9C6CD75C6CA3B0D095A318044C2BAF65E4FCD`. It passed20171 checks over arbitrary three-row families on a three-element palette, caps0 through3, every availability set on successful cases, work bounds, and the two scope examples above. Its receipt SHA256 is `75C03D2707C26EEF83A8366088342FCDB196E1C5BFA3F425D67CA71E6430EDF6`.

The abstract outcomes were801 successes,553 blocked and694 capped attempts. These are finite Boolean cases, not estimates of a prime-data success probability. They do not establish that any useful production clause family exists. General correctness follows from the invariant and certificate proofs above, not extrapolation from the examples.

No author edits are required. Concrete prime provenance, complete residual data, ordinary arithmetic proof generation, implementation memory discipline and valid backend prices remain obligations. The review does not credit any actual compression, prime verification or end-to-end speedup.
