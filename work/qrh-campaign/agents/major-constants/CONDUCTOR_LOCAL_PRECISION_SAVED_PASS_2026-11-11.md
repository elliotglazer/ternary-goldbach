# Conductor-local precision from the saved manifest

2026-11-11. First saved-metadata pass under the reviewed paper rule. No guard or price fold, new conductor/factor/plan enumeration, root/function/transform/zero values, builds, declarations or emitted proofs. All predecessor artifacts are unchanged. Independent review is pending.

The sufficient selector assigns **p100 to 106625 of the 125400 saved large-family conductor rows**. Eight rows retain p108. These are conductor counts, not runtime-weighted savings. The selected cold cache schedule contains **7606 precision-specific Bluestein keys and 364355904 kernel entries**, compared with 6004 keys and 337702368 entries at one common precision. This additional setup is part of any later comparison.

## 1. Exact scope and input binding

The paper rule is `CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md`, SHA256 `1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A`; its independent review is `independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md`, `15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2`. Paths are relative to `work/qrh-campaign/agents` unless stated otherwise.

Only the two approved saved JSON inputs were read by the writer:

| Input | Bytes | SHA256 |
|---|---:|---|
|integration/transform_structural_manifest_20261111.json|25110201|A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637|
|zero-sum/mixed_radix_precision_metadata_20261111.json|1911933|8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E|

Their exact sizes and hashes were checked before parsing. The manifest's ordered seven-field conductor schema, six-field request schema, 125400 conductor rows, 35190 request rows and 37117 full-plan nodes were required. The error input's 13943 axis rows were required, and its plan hash matched both the manifest's recorded hash and a canonical serialization of the actual saved full plan. Schema, hash or bound mismatches raise an assertion before results are written. The saved artifact itself is the source of the conductor domain and all factor/plan choices; no replacement planner is called.

Each output row preserves its source row number, conductor, phi, primitive count and ordered `(n,q)` axes. Repeated axes remain repeated in sums. Product checks compare the supplied phi and primitive counts with their supplied axes; they do not factor a conductor or enumerate its units. Saved weights are bound by row identity, not folded or recalculated. In particular the four auxiliary cases remain alternative old scenarios, and **no +41 interpolation guard is included**.

This is the large branch c>10000 only. It does not change the small-family theta circuits or the principal computation.

## 2. Selector and checked slack

For each supplied axis n, use its saved `new_C,old_C,new_D,old_D` values. Define

    S=sum new_C, S_old=sum old_C,
    D=max(1, all new_D and old_D).

The old and new coefficient and safety maxima were checked against the reviewed global bounds. At each row test p=100,...,108 in increasing order, stopping at the first passing p. Require

    2^p-D >=0,
    2^p-2*S_old >=0,
    c*(1266*202305920)^2
       -(2*phi*S)^2 * 2^(2*(108-p)) >=0.                 (1)

The last condition is exactly the squared nonnegative comparison

    (2*phi/sqrt(c))*S*2^14*2^-p
       <=1266*202305920*2^14*2^-108.

No square-root or analytic evaluation is involved. The source input grid remains100, so p below100 is not considered. The full local precision theorem and complete-radius composition are inherited from the reviewed preflight. The same p applies across all characters and heights of that conductor. The result preserves the stronger exact global-p108 sufficient radius, below `0.653052762*2^-45`, subject to every retained producer hypothesis. It does not claim that any actual error equals its envelope.

All rows passed. There were **180276 selector tests**, at most nine per row. For every chosen p>100, the previous squared test was independently required to fail; the safety bounds already hold at100. Thus the recorded precision is least within this stated finite selector, not among all possible analyses or representations. Each row stores exact integer budget and safety slacks.

| p | Conductors | Precision-specific kernel keys | Kernel entries |
|---:|---:|---:|---:|
|100|106625|672|2399712|
|101|4985|676|4440672|
|102|4084|928|10961120|
|103|3503|1218|25624608|
|104|2472|1243|40730624|
|105|1996|1144|73367552|
|106|807|797|84148224|
|107|920|920|120586240|
|108|8|8|2097152|
|Total|125400|7606|364355904|

The receipt also retains sums of supplied phi and primitive counts by precision. These likewise are not operation-weighted cost projections. No function value, sign, zero count or actual repair workload is inferred.

## 3. Full-plan caches and fixed enclosure contract

Starting from the saved outer axis lengths at their assigned precisions, the pass follows only the saved FULL-plan children. It memoizes `(node,p)` states and never uses primitive-output pruning to remove kernel construction. Each saved split is checked to have the stated product and strictly smaller children. The traversal produces **38147 full-plan precision states**, below the approved334053 cap. After forgetting precision, it recovers exactly the saved32942 active full nodes,12496 top-axis lengths,6004 Bluestein lengths and337702368 baseline kernel entries.

For each active Bluestein `(n,p)`, the saved plan determines the full leaf. Its padded P is computed by the integer dyadic-ceiling formula, not a new plan choice. The cache artifact records `(n,p,P)` under the full plan hash and fixed contract

    local-u-rounded-normalized-blue-v1,
    contract SHA256 22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884.

That contract fixes the grid2^-p, root/chirp and complex-gate norm error at most u=2^-p, original kernel error at most PAu, normalized rounded-kernel error at most `(A+1)u`, the nearest-coordinate rounding policy, the actual new cached real sums, and one cold lifetime. The exact coefficient identity includes the saved full plan, n,P, chirp/sign convention, normalized variant and enclosure contract. A weaker-radius cache or unrelated rounded center cannot satisfy that identity merely because it has the same length.

The resulting duplication is:

| Number of precisions for one kernel length | Kernel lengths |
|---:|---:|
|1|4529|
|2|1349|
|3|125|
|4|1|

Thus the pass adds1602 cache keys and26653536 coefficient entries over a single common-precision cache. These are exact counts for the chosen complete-cache schedule. No finer-cache regrid, cross-precision enclosure adapter, or globally deduplicated rational-angle cache is assumed.

The setup counts implied by this schedule are364355904 complex scaled-cache rounds and728711808 exact **real** cached sums for the three-real-product implementation. Original kernel FFT construction, roots/chirps, all enclosure/proof imports, signed/range bindings, memory, loads and any rebuilds remain additional. The four-product alternative does not need those exact sum caches, but still needs its coefficient construction and scaled rounds. No width-sensitive setup price is computed here.

The full-plan cache artifact retains ordered child relations for each precision state. Root/chirp sharing remains at the declared complete saved-plan set level. The artifact is not a list of distinct rational root angles or actual root values. A later implementation must bind its exact coefficient positions and directions; no arithmetic or proof reuse follows from an unlabeled equal length.

## 4. Files, limits and verification

All owned outputs were created exclusively and stay below64 MiB. Across the conductor, full-state and kernel tables there are171153 records, below one million. No output truncation or fallback occurred.

| Owned artifact | Bytes | SHA256 |
|---|---:|---|
|conductor_local_precision_rows_20261111.json|21933038|B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7|
|conductor_local_precision_caches_20261111.json|1902325|95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584|
|conductor_local_precision_metadata_20261111.json|2686|7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978|

Writer `conductor_local_precision_metadata_20261111.py`, SHA256 `8B0C9764E94A7E35FB071CED0E5731135E11D397B9BA9F582119BAA9005386DA`, made1641707 exact assertions including the final receipt-size check. The receipt records1641706 checks before its own exclusive write. It imports no campaign writer, evaluator or planner. Its built-in integer loops only validate/join supplied rows and follow supplied DAG edges.

The conductor output schema is

    source_row_id, c, phi, primitive, ordered_axes_n_q,
    S_mixed, S_old, D_local, p,
    squared_budget_slack, D_slack, peak_slack.

Both data files mark guards and prices as absent. The full input hashes remain embedded, so source-row ids cannot be interpreted against a different manifest. A future guard or price join must preserve that identity and bring its own authorized input bindings. Full-source7000 magnitude, exact grid100 embedding, local safety, actual completion, kernel/interpolation tolerances and new-center sign checks remain mathematical conditions rather than generated evidence.

## 5. What this pass establishes

This supplies a reproducible per-conductor sufficient precision assignment and its complete-plan cache duplication count. The large p100 population is a reason to examine a matched width-sensitive fold; it is not a runtime forecast. Price comparisons must use the same normalized transform, reconstruct the accepted p108 comparator, retain cheap operations and every actual band/guard weight, and pay setup/lifetime changes. Principal computation, small-family work, head/source production, completion, signs/count closure, binary/ladder certificates and library/proof costs remain outside this pass.

Independent review must still compare these frozen outputs against the two saved inputs. No production choice or end-to-end saving is asserted.
