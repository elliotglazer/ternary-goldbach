# Exact-source review of the mean186 assignment writer

2026-11-11. CLEARED at source/static scope for `major-constants/mean186_exact_tensor_assignment_20261111_v2.py`, SHA256 `CCDAA894518AD2FFFA73F8B1504C09B6DDE9F422F92831D5BD19C10F1D7D057D`,31766 bytes. No remaining source correction requested. This is not execution authorization, an observed successful run, or acceptance of any resulting assignment.

The governing preflight is `MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md`, hash `D804D1A6CEBBDB812A35132CC05A79B9FA8A6B3D510CCF49A9ACCFCC588F1A64`, with paper/schema review `4BCA651C7D6914243BF3F8D6BA21172B0C0E7FA8C5C750D7FB25F703A9DAAD25`. Its mean/tight and p50 mathematical premises retain their external reviews. This source review does not independently reattribute those component proofs; I authored the p50 component and consumed integration's372F685F review in the preflight review.

## Preserved first-version history

The original source `mean186_exact_tensor_assignment_20261111.py`, hash `0E50324BFB8E2C823479D4D585F547774CF0FBD9C7535B2E66D961CE23814A5C`,30958 bytes, was read in full but NOT CLEARED. Its wrapper/per-record serialization checks and exceptions during complete serialization could report only a generic phase/label, without identifying the current artifact and cap. This did not meet the inherited failure-reporting requirement following the earlier opaque encoded-size stop.

The coordinator accepted this narrow correction and directed a versioned successor. The original hash remains unchanged. Neither version was executed during this review. The corrected source changes only serialization/publication diagnostic context and its output fields; mathematical formulas, input set, schemas and caps are unchanged. The reviewed diff and AST comparison support that limited scope.

## Allowlist, parsing and reconstruction

Lines27 and102 define the exact seven pinned JSON inputs and the read gate. Each is read once through that function. It checks the stated size,32 MiB individual cap, cumulative64 MiB cap and SHA256 before parsing. Parsed integer literals are limited to310 characters and1024 bits. The exact byte sum is39,456,593. Paper support pins are read separately under a1 MiB per-paper check. No new numerical or historical inventory is imported, and no factorization, residue enumeration or planner is called.

The structural phase at line155 checks the frozen manifest schema, row/request field meanings, four alternative labels, band endpoints, cardinalities and canonical full-plan hash. Saved split nodes are reconstructed in ascending length, with their ordered children already present. Radix/direct/Bluestein leaves and CT recurrences are evaluated from those saved choices. The tight Bluestein D includes2*C_mix. Every inherited coefficient tuple is compared; the axis rows bind the old baseline and mixed meanings.

The row gate at line251 matches every thirteen-field predecessor row to its exact source ID and order. It checks conductor domain/uniqueness, axes, supplied phi and primitive products, all coefficient sums and both old guards. It reconstructs mixed/sharp squared-budget tests and the combined predecessor's OLD Q52/V8828 test. The p100 rho transition is handled by reevaluating the old numerator at the predecessor precision. Immediate failure is tested except at the declared old floor.

These minimality checks use a budget failure rather than a disjunction of budget/guard failures. That is valid here: the checked global D and2*S_base caps are far below every old candidate, so neither guard can cause the relevant predecessor failure. The same fact justifies the new selector's negative previous-budget check at p>=50. It is not a generic implementation for unrelated guard ranges.

The mask phase at line283 reconstructs the legacy, sharp and combined full-plan closures from their respective precisions. Descending propagation preserves ordered saved child dependencies and unions demand masks only for cache membership. Repeated outer axes still contributed separately to the coefficient sum. The code never uses the pruned request DAG as a cache planner. It matches every stored node mask and kernel row, plus producer-contract hashes, projected fields, setup counts, distributions, transitions and referenced artifact hashes. Aggregate agreement is additional to, not a replacement for, exact key/row agreement.

The guard receipt is used only to check its four alternatives and common maximum26525/4<7000. It introduces no guard weighting into the assignment. The gate also verifies that all and only the seven allowed JSON inputs have been read.

## New selector and closure

The new selection phase starts only after those predecessor gates, at line342. For each row the loop is `range(50,po-4)`, which includes50 through po-5. It enforces51 tests per row and6,395,400 overall. It computes

    gap=T-S_t,
    W=rho*gap+186*S_t*T,
    slack=c*Cg^2*gap^2-phi^2*W^2*2^(2*(108-p)),

with integer capacity checks and positive gap. It independently retains T-D and T-2*S_base. The first passing candidate must satisfy chosen<=po-5<=100; a missing candidate raises a hard failure. No wider retry exists. The immediate previous budget must be negative unless the floor50 passes.

The new mask uses p-50. Every full node remains in the output, including zero masks, and bits51..58 are checked zero. The code verifies the same precision-forgotten active-node/top-axis/kernel closure and its one-precision entries. The per-alternative edges, new membership totals and aggregate alternative membership limits retain the reviewed caps. Alternatives are compared as separate schedules, not summed into one selected execution.

The new input contract at line367 binds full K20/grid94/min65, actual grid100 head/assembly, nonnegative H/J0 radius sums, the single regrid and exact embedding branches, source/height/unit identities and lifetime. It explicitly separates V_error_mean186 from V_width_pointwise692. The conservative115/p+15/116 converter remains selected. No narrower converter or shared-high root/kernel adapter is imported.

The direct per-p rounded normalized-kernel contract has an explicit50..108 domain and new hash. Its mathematical enclosure fields are compared to the pinned predecessor projection, without identifying changed input objects. Exact cached sums belong to the actual new low centers. These contract records express required producers; the writer does not create their numerical values or proofs.

## Serialization, limits and corrected diagnostics

The new minimal rows are `[source_row_id,p_new]`, `[predecessor_node_row_id,mask]` and `[predecessor_kernel_row_id,mask]`. Counts and IDs are generated in the checked predecessor order. Source and predecessor hashes provide the inherited data binding. Per-record encodings are checked against13/27/26 bytes, and each empty-table wrapper against1 MiB. Complete encoded JSON sizes are then checked against3/3/2/1 MiB caps before any output is opened. The aggregate check retains a3 MiB source/report reserve within12 MiB. All destinations are fixed local filenames and are checked absent both initially and immediately before publication.

The source monitors private memory around reads, phases, major loops and serialization. It stops above the observed1 GiB threshold. It does not pretend to control an unobserved allocation peak inside a parser or serializer. Integer/count/byte limits are explicit; there is no automatic cap enlargement or rerun.

The corrected version installs context before wrapper, record and full-artifact serialization at lines410 onward. It records artifact filename, full artifact cap, stage name and stage cap. `CURRENT_ENCODED_BYTES` is reset to None before each serialization and set only after an encoded length is known. Consequently a pre-size exception reports unknown bytes rather than a stale size from a previous object. The summary receives its own context before serialization at line463. The outer failure record at line487 includes all these fields.

Publication sets the correct artifact context for each file at line475, opens exclusively with `xb`, and appends its name to WRITTEN immediately after opening and before writing. Short writes, write/close exceptions and subsequent failures therefore retain the owned partial path list. There is no deletion or overwrite of predecessor artifacts. An exception during failure reporting itself cannot be guaranteed away under arbitrary process exhaustion; the source nevertheless supplies the required context for ordinary exceptions and controlled stops.

The final PASS record is reachable only after the exclusive writes return. Its `independent_reconstruction_pending` status and assignment-only/no-values/no-prices flags preserve the result-review gate. A successful future writer run would still require independent reconstruction before its metadata is accepted as a result.

## Static evidence and scope

Owned static inspector `zero-sum/review_mean186_writer_static_20261111.py`, SHA256 `8425F599BF7101790F0D17EBBA8829EF2BE05C059A138D651A6E282F0BC9B1CA`, passed62 source/hash checks. Its3973-byte receipt `zero-sum/review_mean186_writer_static_20261111.json` has SHA256 `5621B185A836FAACE553E0283BA5D9CB13F3F3089ED49DFF6D3A02C9E92A7352`.

The inspector parses Python source into ASTs, extracts literal declarations, checks the seven fixed read indices and unchanged helpers/contracts, and checks the corrected diagnostic fields. It neither imports nor executes a writer. The complete original source and successor diff were also read directly. These static checks do not substitute for independent reconstruction of a future result.

The exact successor CCDAA894 is cleared for the separately authorized bounded experiment described by the preflight. Root execution authorization remains required. No inventory input was parsed, assignment computed, price folded, analytic value evaluated, build performed, declaration added or proof emitted by this review. Actual source/cache production, signs, repairs, completeness, principal and finite-coverage work remain outside the writer and this clearance.
