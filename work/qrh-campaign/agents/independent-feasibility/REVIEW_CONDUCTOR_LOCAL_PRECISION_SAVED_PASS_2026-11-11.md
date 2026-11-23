# Review of the first conductor-local precision metadata pass

2026-11-11. PASS at the bounded saved-metadata scope, with no correction required. This review binds `major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, SHA256 `2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D`, to the reviewed mathematical contract `15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2`.

All paths below are relative to `work/qrh-campaign/agents`. I read the complete frozen author paper and writer source. The independent program imported no author program. It read the two pinned saved inputs and the author outputs, reconstructed the claimed assignment and cache closure, and wrote only its own compact receipt. No conductor generation, factoring, replacement planning, unit or root enumeration, function/transform values, guard or price fold, builds, declarations or proof emission occurred. All frozen inputs remain unchanged.

## Independent reconstruction

The two mathematical inputs are the manifest `integration/transform_structural_manifest_20261111.json`, SHA256 `A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637`, and the coefficient receipt `zero-sum/mixed_radix_precision_metadata_20261111.json`, SHA256 `8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E`. Their content hashes and the canonical saved-plan hash match. The checks used their 125400 conductor rows, 13943 axis rows and 37117 full-plan nodes, with no replacement for the saved source data.

I rebuilt C and D in increasing saved node length. Each split has strictly shorter children, so this is a topological evaluation of the fixed plan. Its ordered CT term is C_m+C_r(2C_m+1), not its reversed counterpart. Radix, direct and Bluestein bounds use the reviewed formulas. Every saved axis's old and new C,D pair matches this independent reconstruction. This adds a recurrence check to the author's direct use of the pinned coefficient rows; it does not search for a different plan.

Every output conductor record equals the independently reconstructed twelve-field record. The source id is the zero-based index in the pinned manifest. The conductor, phi, primitive count and ordered `(n,q)` pairs match exactly. Repeated axis lengths are repeated in both S sums. The product of lengths gives phi, and the product of the saved retained counts gives the primitive count. The original parity/domain restrictions hold. The twenty weight fields remain bound to the same immutable source row; no new height or weight computation is substituted.

For precision selection, I used a different calculation from the author's increasing nine-test loop. Put A=(2 phi S)^2 and R=c*(1266*202305920)^2. For A>0, integer division and bit length give

    p_budget = max(100, 108-floor(floor(log2(floor(R/A)))/2)).

For A=0 use p_budget=100. This expression uses integer bit lengths only. Combining it with the bit-length bound for max(D,2S_old,1) supplies p. I then checked all three exact slacks and every smaller candidate in 100,...,p-1. All 125400 rows choose the same least p as the author, and every recorded budget/D/peak slack matches. This is minimality within the reviewed sufficient selector, not a claim about actual error or optimal cost.

The retained guards are both local D and 2*S_old, so the inherited peak proof is not replaced by error safety alone. The accepted mathematical review already proves the exact 2 phi/sqrt(c) scaling and full p108 radius. This pass specializes that theorem; its integer slacks are not numerical root, cache or gate certificates.

## Full-plan cache membership

The independent cache algorithm seeded a nine-bit precision mask on each saved outer axis, then propagated masks to children in decreasing node length. It processed each full-plan node once. This differs from the author's memoized `(node,p)` traversal but yields the same set of states. Ordered children, including repeated child lengths, match every output full-state record. Kernel membership depends on full-plan Bluestein leaves, not retained-output counts.

All 38147 full-plan precision states and all 7606 kernel `(n,p,P)` records match. Their padded lengths use the exact integer dyadic ceiling. Forgetting precision recovers the 6004 baseline kernel lengths and their 337702368 entries. The exact new setup totals are 364355904 complex coefficient entries and scaled-cache complex rounds, plus 728711808 exact REAL sum operations for the three-product cache. They add 1602 keys and 26653536 entries relative to one common-precision cache. No two-complex-sums substitution is made.

The complete contract object matches the intended `local-u-rounded-normalized-blue-v1` contract and hashes to `22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884`. Both data files and the receipt bind that same object. It identifies grid p, root/gate error u, the original PAu kernel error, the additional scaling bound (A+1)u, the rounding convention, exact new real sums and one cold lifetime. The saved full-plan identity and coefficient convention are included. Thus the enclosure-contract requirement in the preceding mathematical review is now an explicit serialized field.

This is a conditional cache specification. It does not contain actual enclosures or prove numerical cache construction. Equal lengths alone do not permit sharing across different coefficient conventions, precisions, radii or lifetimes. Root-angle deduplication and finer-cache regridding remain absent. Rebuilds and original kernel FFT/root setup remain separately charged.

## Results and limits

The exact precision population is:

| p | Conductors |
|---:|---:|
|100|106625|
|101|4985|
|102|4084|
|103|3503|
|104|2472|
|105|1996|
|106|807|
|107|920|
|108|8|

All accompanying phi totals, primitive totals, per-precision kernel counts and entries, duplication multiplicities and selector-test totals match the receipt. The latter counts 180276 tests with maximum nine. The author distinguishes 1641706 assertions before its final receipt write from 1641707 including that check; these statements are consistent.

The two data files explicitly mark guards and prices absent. Their combined tables contain 171153 records, below one million; the 38147 node/precision states are below the declared 334053 cap. Each artifact is below 64 MiB, and its byte count and hash match the receipt. Source inspection confirms exclusive output creation, bounded traversal, no author-program import and no output truncation. This is a source/output verification of that behavior, not an independent process-sandbox test.

The high p100 population is not an operation-weighted saving. There is no runtime projection, new guarded transform association or net setup comparison here. A later price pass must reconstruct the same normalized p108 comparator, preserve actual scenario and band weights, add separately bound guard samples and charge cache splitting, exact sums, imports, storage and lifetimes. Small-family and principal work, source/head/completion producers, actual signs/counts, finite coverage and ordinary proof-library construction remain outside this pass.

## Frozen evidence

| Artifact | SHA256 |
|---|---|
|major-constants/conductor_local_precision_metadata_20261111.py|8B0C9764E94A7E35FB071CED0E5731135E11D397B9BA9F582119BAA9005386DA|
|major-constants/conductor_local_precision_rows_20261111.json|B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7|
|major-constants/conductor_local_precision_caches_20261111.json|95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584|
|major-constants/conductor_local_precision_metadata_20261111.json|7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978|
|independent-feasibility/review_conductor_local_metadata_20261111.py|3C37858714F3577FBE911A1841E434ECC0B217D81ABED719650E8D3807EEB45E|
|independent-feasibility/review_conductor_local_metadata_20261111.json|0DCF76085F28AA38F2556518258DD0B381D7600621814BC6784F345F88236E23|

The independent program completed 1784538 exact checks. Its receipt records the reconstructed distribution and summary, source and author bindings, contract identity and method. The verdict accepts the first saved-row assignment and full-plan cache membership only. It does not select production precision or establish standard-axioms theorem closure.
