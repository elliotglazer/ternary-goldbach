# Sharper conductor precision: saved-data successor preflight

2026-11-11. Preparation only. No inventory has been parsed or folded for this task, no writer has been run, and no sharper precision assignment or price has been computed. Work consists of reading the frozen mathematical and schema sources, checking file metadata, and coordinating the separate price-pass interface. All prior outputs remain unchanged.

The proposed assignment pass computes the sharper error recurrence on the same saved full plan, reconstructs the complete legacy assignment first, and then records a separately named S_sharp and least admitted p_sharp. It retains the legacy safety and peak guards. A subsequent price pass could compare both assignments in one precision-partitioned propagation with two labeled weight blocks. That extension is not authorized by this preflight or by the existing single-assignment price preflight.

## 1. Mathematical gate and input allowlist

The sharper rule is `audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md`, SHA256 `08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F`, 16,474 bytes. Its independent review is `prime-estimates/REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md`, `3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3`, 8,804 bytes. The review retains the same ordered-plan comparison, repeated roles, old D/peak guards and the actual rounded normalized-cache producer. It supplies no population or runtime-weighted conclusion.

Paths with agent prefixes are relative to `work/qrh-campaign/agents`. A future assignment writer would read only these six JSON files, after exact byte-size and hash checks:

|Input|Bytes|SHA256|
|---|---:|---|
|`integration/transform_structural_manifest_20261111.json`|25110201|`A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637`|
|`zero-sum/mixed_radix_precision_metadata_20261111.json`|1911933|`8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E`|
|`major-constants/conductor_local_precision_rows_20261111.json`|21933038|`B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7`|
|`major-constants/conductor_local_precision_caches_20261111.json`|1902325|`95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584`|
|`major-constants/conductor_local_precision_metadata_20261111.json`|2686|`7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978`|
|`integration/short_window_guard_ledger_20261111.json`|41665|`C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4`|

The aggregate JSON cap is 64 MiB, with 32 MiB per input. One byte read per file supplies both its hash and parsing. These are existing immutable files, not an instruction to discover replacements or execute their generators.

The accepted first-pass author is `major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, `2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D`, 10,174 bytes. Its independent review is `independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, `01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C`, 8,373 bytes. The underlying rule/review are `1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A` and `15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2`.

The +41 guard review is `zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md`, `15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA`. It supplies the unchanged target/guard scope and maximum height 26525/4<7000. This assignment pass reads the compact guard receipt only to bind that scope. It does not read the 12.8 MB guard-row file, fold guard weights, or claim those guards were included in the old assignment artifact. A precision is uniform over all relevant heights of its conductor, so guard applicability follows from the mathematical domain, while guard occurrence counts remain a later join.

Supporting Markdown hashes and their exact selected filenames must be pinned by the future writer. The scalar sharper-rule receipt `audit/sharper_normalized_transform_precision_20261111.json`, `0A1D5A6E57A6D1036CD7916422AE4C51D83ED6C8F642C5C2C7BB65871BC87B30`, is available as a 1,808-byte proof-check reference but is not required as another assignment input. No author module is imported.

## 2. Fixed-plan coefficient reconstruction

Require the saved schema, 125400 conductor rows, 13943 axis coefficient rows, 37117 full-plan nodes and canonical full-plan hash. Recompute that hash from the supplied full-plan object. The recurrence is a topological evaluation in increasing node length, never a circuit planner.

Compute both the legacy mixed pair and the sharper pair at every supplied full node. Identity has (0,1), if encountered as a stated base; the current full-plan table contains n>=2. Radix-two length 2^k keeps `(2k+4,max(1,2k))`. A selected direct leaf keeps (2,1). Check each declared leaf kind and its structural restrictions rather than inferring a different choice from its length.

For a Bluestein node, retain P=nextPowerOfTwo(2n-1), k=log2(P), R=2k+4 and A=1+3R. The old and new coefficients are

    C_mix = 6*P*A + 2*R*(2n+1) + 8,
    C_sharp = (9*P*A)/2 + (3*P)/2 + 3*R*n + 12*R + 14.

P is even, so the halves are exact integers. Both use

    D_B = max(1,2k,P*A,3*n*P*A+1).

This is the actual rounded normalized-cache leaf. The sharper coefficient must not be attached to an old unnormalized leaf or to a finer-grid exact K/P representation.

For saved ordered split n=r*m, m is evaluated first. For either pair use

    C(n)=C(m)+C(r)+2,
    D(n)=max(D(m),D(r),1,C(m)+C(r)*(2*C(m)+1)).

Validate child lengths and products against the supplied plan. Repeated children are two mathematical roles in these formulas, even if a memoized node is evaluated only once. Do not multiply C by runtime line counts, characters, samples, primitive-output counts or request multiplicities.

At every node verify C_sharp<=C_mix and D_sharp<=D_mix. At every saved axis compare reconstructed C_mix,D_mix to its existing `new_C,new_D` fields. Those field names retain their historical meaning. They must never be rewritten to mean sharp coefficients. The baseline `old_C,old_D` fields remain the saved whole-axis comparison; this task does not assert the generally false pointwise mixed-D versus whole-axis-D inequality.

## 3. Legacy reconstruction before the new selector

For each row, check the exact source-row id, conductor, phi, primitive count and every ordered `(n,q)` pair against the manifest. Repeated outer axes remain repeated in sums. Validate the supplied phi and primitive products from these axes, without factoring c or enumerating residues.

Reconstruct

    S_mix=sum_axis C_mix(n),
    S_base=sum_axis old_C(n),
    D_local_old=max(1, every axis new_D and old_D).

These must equal the frozen first-pass row. Preserve its selected p_mix and reproduce all three exact stored slacks. Require the chosen squared test to pass; if p_mix>100, require its immediate predecessor to fail. Since all retained safety/peak guards already hold at100, this proves minimum within the nine-point selector. This reconstruction costs at most two squared tests per legacy row; it is not counted inside the new selector's separate nine-test limit.

Reconstruct the legacy complete full-plan cache closure as well and compare every frozen full-node/precision and kernel record, its contract and summary totals. The expected legacy values are 38147 full-plan precision states and 7606 kernel keys, with 364355904 entries. Failure of any legacy identity stops the task before new results are published. No numerical generation is used to repair a mismatch.

Only after these checks, compute S_sharp from the same repeated outer axes. Test p=100,...,108 in order, retaining exactly

    2^p >= D_local_old,
    2^p >= 2*S_base,
    (2*phi*S_sharp)^2 * 2^(2*(108-p))
        <= c*(1266*202305920)^2.

The new row records S_sharp and p_sharp explicitly. Check p_sharp<=p_mix, all three new slacks, and immediate-predecessor failure whenever p_sharp>100. The S_sharp=0 case requires no division. There is no precision below100 and no silent replacement of peak guards by D_sharp or S_sharp.

The reviewed theorem preserves the same complete sufficient output-radius ceiling as global p108, subject to all its source, input, cache and consumer hypotheses. This metadata pass does not evaluate that error, actual signs or repairs. Population results are to include a p_mix-by-p_sharp table, p_changed count, bit-drop counts and separately labeled sums of saved phi/primitive counts. None is a workload-weighted saving.

## 4. New cache closure and immutable output schema

The new cache closure starts with every saved outer axis at its p_sharp. Follow only full-plan splits. A nine-bit precision mask per node is sufficient; each split copies the mask to its two children. Shared child nodes deduplicate cache membership, while the coefficient recurrence above retains repeated roles. Expanding the completed masks into `(node,p_sharp)` states is bounded by 9*37117=334053. Bluestein keys are bounded by 9*6004=54036.

Forgetting precision must reproduce the same 32942 active full nodes, 12496 top-axis lengths, 6004 Bluestein lengths and 337702368 one-precision kernel entries. Preserve the fixed enclosure contract exactly, SHA256 `22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884`. Equal old/new `(n,p)` keys under this complete identity denote the same possible numerical producer; replacing the analytical C coefficient alone does not create a new numerical cache variant. Different p still requires a separate bound producer or a separately proved adapter.

Report the new cache distribution and old/new intersections and differences by complete key. These are comparisons between two alternative complete-cache schedules. They do not grant free sharing across separate checker runs or imply that a production portfolio constructs their union. Scaled complex rounds equal the chosen entry count; three-product cached sums are twice that many exact REAL sums. Original kernel FFT, roots/chirps, enclosures, numerical production, imports, traffic and actual lifetimes remain additional.

Proposed new owned basenames are:

- `sharper_conductor_precision_metadata_20261111.py`, a standalone writer, not supplied or run by this preflight.
- `sharper_conductor_precision_nodes_20261111.json`, rows `[n,C_mix,D_mix,C_sharp,D_sharp]`, binding the exact full-plan hash.
- `sharper_conductor_precision_rows_20261111.json`, rows `[source_row_id,c,phi,primitive,S_mix,S_sharp,S_base,D_local_old,p_mix,p_sharp,budget_slack,D_slack,peak_slack,previous_budget_slack_or_null]`.
- `sharper_conductor_precision_caches_20261111.json`, the sharp full-node/precision closure, kernel keys and the unchanged contract, with both assignment-source hashes.
- `sharper_conductor_precision_metadata_20261111.json`, compact checks, distributions, comparisons, output hashes and explicit scope flags.

Ordered axes and weights are referenced by the exact immutable manifest row and hash rather than copied into the new row table. The writer must check them before emitting that reference. New flags should distinguish `guard_domain_applicable=true` from `guard_weights_folded=false` and `prices_included=false`. The old artifacts retain their original flags and bytes.

## 5. Assignment-pass limits and stop conditions

|Object or loop|Hard proposed cap|
|---|---:|
|Full-plan coefficient nodes|37117|
|Saved axis checks|13943|
|Conductor joins/new assignments|125400|
|Axes per conductor after phi/product checks|18|
|Legacy chosen/predecessor tests|250800|
|New selector tests|1128600|
|Legacy full-plan precision states matched|38147|
|Sharp full-plan precision states|334053|
|Sharp kernel keys|54036|
|New data records, all tables together|1000000|

The substantive new table maximum is 37117+125400+334053+54036=550606 records. Full-plan splits have at most two children. A fixed node-order mask closure gives at most two propagation edges per node per assignment; it does not walk a runtime operation tree. The proposed output caps are 32 MiB for rows, 8 MiB for nodes, 20 MiB for caches and 1 MiB for the summary, with all new artifacts together below64 MiB. The per-file sums leave room for the writer and report. These are serialized-byte caps, not claims about decoded-object memory.

Use exclusive output creation. Check insertions/records and encoded byte sizes before publication. Any hash, schema, exact legacy match, selector or cap failure stops and reports the discrepancy. It must not trigger broader factorization, a replacement planner, larger precision search or a silent cap increase. No new source/function/character/root/zero values, build or proof stream is permitted.

## 6. Coordinated future price join, not an expansion of current scope

Moebius's current single-assignment preflight is `moebius/CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_PREFLIGHT_2026-11-11.md`, SHA256 `C5AAB690B926EC515E8708B2F3CB2B12C20E0ED6FA9C9313EC89803C7406B76E`. It carries forty weights per context, old20 followed by guard20, through at most nine precision partitions. Its limits include 220108 contexts per partition, 1980972 in total, 125279 global normalized phase keys, 133 width keys and 1197 precision/width keys. That frozen preflight remains independent and unchanged. This note neither runs nor enlarges it.

A separately authorized successor could compare p_mix and p_sharp without two enormous histogram files:

1. Join each conductor once against both frozen assignments and the existing exact +41 row. Seed its old40 weights in partition p_mix and its sharp40 weights in partition p_sharp. If the two p values agree, both blocks enter the same context.
2. Within each p partition, carry eighty weights, explicitly `legacy_assignment40 || sharp_assignment40`, under the same `(n,q,a)` key. The union of the two conductor subsets is still a subset of the original full population. Thus the 220108 per-partition and 1980972 aggregate context caps need not increase. The top-context cap stays52560 per partition. Row-to-axis contributions can double from at most18 to at most36 per row and must be counted separately.
3. Follow only saved requested-DAG edges and emit the same compressed normalized stage classes, at most18 stages per block. Requested CT nodes may have THREE children for the q=n case; do not apply the two-child FULL-cache bound to this different DAG.
4. Accumulate one global phase-key map with eighty weights and one `(p,category,de,ce,db)` width map with eighty weights. The latter has at most1197 shared keys, equivalently at most2394 assignment-labeled forty-weight records. Compare each assignment block against the same complete frozen old/guard histograms. Fold only the small precision/width map into both price schedules. There is no need to serialize two phase histograms or any per-gate objects.
5. Bind each arm to its own full-plan cache closure and preserved contract. Price cold/lifetime changes separately; report equal complete keys as possible overlap, not automatic proof reuse.

The subset argument preserves the number of context KEYS, not memory or arithmetic work. Weight vectors double from40 to80, some contexts occur in a different partition, and two arm-price/setup calculations are required. The future allowlist must add the frozen sharper assignment/cache files, and all vector, working-memory and output limits need explicit new approval. A global phase map with80 entries per key has different memory requirements even if no large output file is written. Current limits cannot silently authorize that cost.

Moebius confirmed this as a possible future interface while retaining its frozen forty-weight baseline. Its future writer/reviewer must choose final storage and byte caps and validate both projections; this preflight supplies no such execution. If the current baseline runs first, it remains useful independent evidence rather than being mutated into the successor.

## 7. Execution gate

The assigned paper/schema reviewer is major_constants. The sharper mathematical review is already frozen, but this preflight still needs its independent review and coordinator approval before an assignment writer or any saved-data fold runs. The future dual-assignment price extension requires a separate reviewed authorization. Neither step may be inferred from acceptance of the other.

The intended deliverable after authorization is an independently identified sufficient p_sharp assignment, p_changed count and complete cache closure under the same guards. Any price or end-to-end conclusion must wait for its matched workload, setup and omitted-cost join. This task stops with this preflight.
