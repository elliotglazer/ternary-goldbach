# Sharper conductor precision from the unchanged saved plan

2026-11-11. Conditional saved-metadata result, awaiting independent reconstruction. The authorized first execution passed without a failed attempt or rerun. It reproduced the complete legacy coefficients, conductor rows, selector slacks and full-plan cache closure before starting the new selector. No conductor, factor, unit, plan, root, function, transform or zero values were generated. No build, declaration, proof stream, price fold or frozen-file change occurred.

The sharper rule lowers 8,707 of the 125,400 conductor assignments by exactly one bit. The remaining 116,693 are unchanged. It assigns p100 to 108,741 rows; eight rows use p107 and none use p108. These are conductor populations, not runtime-weighted savings.

The complete independent-per-precision cache schedule increases from 7,606 to 7,850 kernel keys and from 364,355,904 to 369,180,928 entries. Thus the lower assignments add 244 keys and 4,825,024 entries under this particular producer schedule. The assignment alone does not establish a complete cost reduction.

## 1. Authorization, source and exact scope

The execution contract is `integration/SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_PREFLIGHT_2026-11-11.md`, SHA256 `2FDA2DDB0D8B0519377D026D1C88B70FD815BECD1C5C9A6E2EA826A75B335610`, independently reviewed in `major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_PREFLIGHT_2026-11-11.md`, `2D21AF2BE4ADE3F8C58F066F1332C66C8A31D933BC5CD838F8D08C51ECE1E171`. The coordinator then authorized the bounded assignment pass and required pre-run source review. Major_constants read and cleared the exact writer pin below before execution. No source correction was requested.

Agent-prefixed paths are relative to `work/qrh-campaign/agents`. The mathematical successor is `audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md`, `08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F`, with independent review `prime-estimates/REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md`, `3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3`. It changes the normalized Bluestein error coefficient and its ordered composition. It does not change the numerical cache producer, primitive-output selection or circuit plan.

The legacy author/review remain `major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, `2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D`, and `independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, `01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C`.

The writer reads exactly six pinned JSON inputs, totaling 50,901,848 bytes:

|Input|Bytes|SHA256|
|---|---:|---|
|`integration/transform_structural_manifest_20261111.json`|25110201|`A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637`|
|`zero-sum/mixed_radix_precision_metadata_20261111.json`|1911933|`8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E`|
|`major-constants/conductor_local_precision_rows_20261111.json`|21933038|`B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7`|
|`major-constants/conductor_local_precision_caches_20261111.json`|1902325|`95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584`|
|`major-constants/conductor_local_precision_metadata_20261111.json`|2686|`7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978`|
|`integration/short_window_guard_ledger_20261111.json`|41665|`C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4`|

Each input is read once for both hash and parsing. Seven supporting Markdown pins are checked separately. No producer module is imported or executed. No fallback input discovery occurs.

## 2. Fixed-plan reconstruction and the legacy gate

The supplied full plan has 37,117 nodes. Its canonical hash is

    fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b.

The writer recomputes this from the actual saved plan and matches the axis receipt and legacy cache. It processes supplied nodes in increasing length. Leaf restrictions and strictly smaller split children are checked. This is evaluation of a fixed finite recurrence, not a planner or factorization.

Both C_mix,D_mix and C_sharp,D_sharp are computed. At a Bluestein leaf, put P=nextPowerOfTwo(2n-1), R=2log2(P)+4 and A=1+3R. Then

    C_mix = 6PA+2R(2n+1)+8,
    C_sharp = 9PA/2+3P/2+3Rn+12R+14,
    D_B = max(1,2log2(P),PA,3nPA+1).

Both pairs use D_B. All halves are exact because P is even. The sharper formula applies to the actual rounded grid-p normalized cache, not an unnormalized or exact finer-grid representation.

At an ordered split n=r*m, the m child is first:

    C(n)=C(m)+C(r)+2,
    D(n)=max(1,D(m),D(r),C(m)+C(r)(2C(m)+1)).

The same recurrence is used separately for the legacy and sharper pairs. Repeated children remain two roles in the coefficient formula; memoizing their node does not delete one role. No runtime line, sample or primitive-output multiplicity enters C or D. The pointwise same-plan comparisons C_sharp<=C_mix and D_sharp<=D_mix pass at every node.

Every one of the 13,943 saved axis records matches the reconstructed legacy mixed pair. Its existing `new_C,new_D` fields retain that historical meaning. Its `old_C,old_D` remain the whole-axis baseline values. The new files name sharp fields explicitly and do not mutate either predecessor.

For every conductor the writer checks the exact manifest row identity, c/phi/primitive values and all ordered `(n,q)` axes, including repeats. Products of supplied axes reproduce phi and the primitive count. It then reconstructs S_mix, S_base and D_local_old, all twelve legacy output fields and all three chosen slacks. Chosen and immediate-predecessor tests establish the same least legacy p, with the retained safety already valid at100. There are 144,175 such legacy tests, below the separate 250,800 cap.

The legacy complete-cache closure is also rebuilt from the saved full-plan splits using descending nine-bit masks. Every one of its 38,147 full-node/precision records and 7,606 kernel records matches, not merely their totals. Its fixed contract and precision distributions match as well. Only after this entire gate succeeds does the writer begin new selection.

## 3. Sharper selector under unchanged guards

For each conductor use the same repeated outer axes and define S_sharp=sum C_sharp. Retain D_local_old and S_base from the legacy row. Test p=100,...,108 in order against

    2^p >= D_local_old,
    2^p >= 2*S_base,
    (2*phi*S_sharp)^2 * 2^(2*(108-p))
        <= c*(1266*202305920)^2.

The new loop performs 171,569 tests, below the 1,128,600 cap. When p>100, the final predecessor check reuses the immediately preceding slack already computed by that loop. It does not introduce a tenth test. The zero-S case is defined without division. Every row satisfies p_sharp<=p_mix.

These are exact nonnegative integer comparisons. They preserve the reviewed complete global-p108 sufficient radius, subject to its unchanged producer and actual-input hypotheses. They do not compute actual arithmetic errors or sign margins. In particular D_sharp is evidence about the new recurrence, not a replacement for the selected old peak guard. The input grid100 and p>=100 remain fixed.

|p|Legacy conductors|Sharper conductors|Sharper kernel keys|Sharper kernel entries|
|---:|---:|---:|---:|---:|
|100|106625|108741|779|3231200|
|101|4985|4890|902|7860768|
|102|4084|3783|1022|13549792|
|103|3503|2816|1236|29573152|
|104|2472|2017|1310|50724864|
|105|1996|1729|1186|77725696|
|106|807|1416|1407|184418304|
|107|920|8|8|2097152|
|108|8|0|0|0|
|Total|125400|125400|7850|369180928|

The exact one-bit changes are 2,116 rows from101 to100; 2,021 from102 to101; 1,720 from103 to102; 1,033 from104 to103; 578 from105 to104; 311 from106 to105; 920 from107 to106; and eight from108 to107. The full transition table, saved phi sums and primitive-count sums are in the receipt. None is a proxy for height-weighted operation counts.

One p applies to every character and relevant height of its conductor. The compact guard receipt binds all four alternatives and verifies their largest positive dependency at 26525/4<7000. Therefore the output marks guard-domain applicability, while explicitly marking guard weights and prices as not folded. The original/+41 per-band workload still needs its separately authorized price join. No guard sample is produced here.

## 4. Complete-cache closure and extra setup

The new full-plan precision closure contains 37,522 states and 7,850 Bluestein `(n,p,P)` keys. It follows full-plan splits, never requested-output pruning. Forgetting precision recovers exactly 32,942 active nodes, 12,496 top-axis lengths, 6,004 kernel lengths and 337,702,368 single-precision entries.

The numerical producer contract is unchanged:

    local-u-rounded-normalized-blue-v1
    22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884.

It binds common grid p, root/chirp and complex-gate error u, the original PAu kernel producer, the additional scaled-cache round, exact sums of the NEW centers, rounding policy, coefficient convention and one cold lifetime. A new analytical coefficient alone does not change an otherwise identical numerical producer. Equal `(n,p,P)` keys can identify the same possible object only under this full contract, plan and actual lifetime.

Compared with the legacy assignment, 30,035 full-node/precision states are common, 7,487 are sharp-only and 8,112 are legacy-only. Kernel keys have an intersection of 5,574, with 2,276 sharp-only and 2,032 legacy-only. These compare alternative schedules; they do not assert free checked-object sharing across separate proof runs.

The new schedule requires 369,180,928 complex scaled-cache rounds and 738,361,856 exact REAL cached sums in the three-product variant. Relative to the legacy local assignment this adds 4,825,024 complex rounds and 9,650,048 real sums. Relative to one common-precision cache it has 1,846 additional keys and 31,478,560 additional entries. The four-product variant omits the real sum cache only.

Original kernel FFT construction, root/chirp generation, coefficient certificates, enclosure/proof imports, signs/ranges, storage and rebuilds remain separate setup costs. No shared-high-precision producer, regrid adapter or root-angle deduplication is adopted. The reduced number of full-node states and increased kernel entries are different counts; neither alone determines cost.

## 5. Artifacts, schemas and limits

Writer `integration/sharper_conductor_precision_metadata_20261111.py` has SHA256 `6F41270DAF009B151432DD7619B69C46737598C8B3C8194D80FA719AE52864AE`, 15,108 bytes. This exact pin received pre-run clearance and was checked again immediately before the authorized execution.

|Artifact|Bytes|SHA256|
|---|---:|---|
|`sharper_conductor_precision_rows_20261111.json`|20920838|`8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085`|
|`sharper_conductor_precision_nodes_20261111.json`|1720100|`29A7C789AD3B5BC34D2177567FECEFB1FBBE7CFF432943150FCF18B868E7C9D6`|
|`sharper_conductor_precision_caches_20261111.json`|1871369|`129ADFCF668378CA94140DB27F3A3D6EF43995E05EB1413D3BE8AC603061D831`|
|`sharper_conductor_precision_metadata_20261111.json`|5188|`8CEA147C264CC963CAE2EBAFE58F32E4CCD53A99378D7403161510993862227F`|

These files are in integration. The node table stores `[n,C_mix,D_mix,C_sharp,D_sharp]`. The new row schema is

    source_row_id,c,phi,primitive,S_mix,S_sharp,S_base,D_local_old,
    p_mix,p_sharp,budget_slack,D_slack,peak_slack,
    previous_budget_slack_or_null.

Ordered axes and weights are bound through the exact manifest hash and row id after full comparison, rather than copied into the new table. The cache artifact references both the old assignment hash and the newly written sharp row hash, plus the unchanged complete contract. The row file is written before the cache file. No circular artifact-hash dependency occurs.

There are 207,889 substantive new records, below the one-million cap. All four JSON outputs total 24,517,495 bytes. The row/node/cache/summary caps of32/8/20/1 MiB pass; an additional1 MiB reserve for writer/report was checked under the aggregate64 MiB limit. All paths were required absent and all serialized sizes were checked before exclusive writes. Decoded memory is not claimed equal to these byte counts.

The run passed 2,269,869 assertions. The summary records 2,269,864 before its four file/path caps and final aggregate cap. Legacy closure has its own hard38,147-state/7,606-kernel bounds; sharp closure retains the authorized334,053-state/54,036-kernel bounds. No failure, fallback, truncation, retry or capacity increase occurred.

## 6. Acceptance boundary and next dependency

This packet establishes a reproducible sufficient assignment and full-cache schedule on the same saved domain. The new population is a reason to price its weighted runtime and additional setup, not a substitute for that price. The independently scoped conservative local-price calculation remains unchanged.

A dual-assignment runtime pass must bind these new files, retain each arm's original/+41 band weights and compare complete phase projections. It needs its own reviewed vector/memory/output limits and authorization. The proposed80-weight interface in the preflight was not executed here. Neither was a shared-high cache producer.

Actual per-p source/kernel/root enclosures, ordinary-rule arithmetic/proof construction, new strict signs, interpolation and zero-count completeness remain unestablished. Principal, small-conductor, finite-coverage/ladder and analytic-library work remains outside this assignment pass. Independent result reconstruction is pending; no production precision or end-to-end saving is claimed.
