# Combined conductor precision assignment preflight

2026-11-11. Frozen proposal with all mathematical component reviews bound below. Independent review of this combined design and execution approval remain required. This is a paper and schema proposal only. No inventory has been parsed or folded for this task, no assignment writer is supplied or run, and no values, builds, declarations or proof objects are produced. Frozen predecessors remain unchanged.

The proposed pass reconstructs the two accepted assignments and their complete cache closures, then computes one new candidate on the same saved plan. That candidate combines the tighter normalized Bluestein leaf, the tensor factor for a declared precision floor of 80, and a charged single regrid of the actual assembled grid100 input. It uses the proved augmented input bound 8828 for errors and retains 16384 for all existing width bounds. It does not run separate assignment searches for intermediate combinations.

## 1. Mathematical inputs and composition

Paths with agent prefixes are relative to `work/qrh-campaign/agents`.

|Frozen paper or review|SHA256|
|---|---|
|`prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md`|`5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F`|
|`major-constants/REVIEW_TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md`|`E7482930B1A6B57FD6C186AD4612E655379D0978DD6C5EDA9C4D4D6D247920F5`|
|`integration/TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md`|`DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C`|
|`zero-sum/REVIEW_TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md`|`EC2FD8569DF2D74B758F6FDD9DC58153BD0FF6B662919ECE43B014C0E064BC26`|
|`independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md`|`B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266`|
|`independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md`|`39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761`|
|`audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md`|`8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD`|

The input-regrid review accepts both its base and magnitude companion. The tensor paper's selected p100 rule is not itself a subgrid admission. Its general finite-product lemma supplies the factor below; the separate input papers supply the changed-center and magnitude contracts. This section gives their explicit composition for independent review.

At a saved Bluestein node define m=2n-1, P the least power of two at least m, k=log2(P), R=2k+4, A=1+3R, q=3nA+n+2 and E=Pq+R*(n*m+2P). Use

    C_tight = ceil(E/n)+2,
    D_tight = max(D_B,2*C_mix).

The local theorem requires the explicit OLD semantic peak condition C_mix*u<=1/2. D_B alone does not imply it. At saved ordered CT splits, m first, use C=C_m+C_r+2 and D=max(D_m,D_r,1,C_m+C_r*(2*C_m+1)). Other leaves retain the accepted coefficients. The reviewed induction gives C_tight<=C_sharp<=C_mix and D_tight<=max(D_mix,2*C_mix). This does not assert D_tight<=D_mix.

For a conductor retain every occurrence of every ordered outer axis. Let S_t be the sum of its tight full-plan coefficients, S_mix the mixed sum, S_base the old whole-axis sum, and D_local_old the existing maximum over old and mixed axis D values. Keep

    2^p >= D_local_old,          2^p >= 2*S_base.

These old guards cover the tighter local D and semantic peak premises by the accepted source composition. Do not replace them by 2*S_t or D_tight alone. The family bounds D_local_old<=29961461170177 and 2*S_base<=849412408 imply safety already at p80, but every output row must retain and check its exact guards.

The numerical input contract is explicit. The selected full P20 evaluator supplies the admitted grid100 polynomial center of norm below8192 throughout |t|<=7000. A raw finite-head center of norm below634 must have an actual grid100 representation and the separately retained head radius. Their exact sum has norm below8826. For p<100 apply one checked coordinate-nearest conversion to the assembled sum, with complex error at most u=2^-p. For p>=100 embed exactly. Write rho_p=1 below100 and zero otherwise. The new stored vector satisfies

    M_new+1 < 8827+2^-80 < V_error=8828 < V_width=16384.

A small head error is not evidence of its grid. A shortened evaluator needs its own admitted magnitude and representation join. This assignment candidate uses the sufficient full P20 source contract and does not silently choose a shortened-source production schedule.

The tight constants satisfy S_t<=S_mix<=202305920<2^28. For p>=80, put Q=2^52 and B=Q/(Q-1). The reviewed finite-product induction gives normalized intrinsic error at most B*S_t*V_error*u. After the actual unnormalized character transform and conductor normalization, exact input transport and intrinsic error together give

    E_comb(c,p) = phi(c)/sqrt(c) * [rho_p+B*S_t*8828]*2^-p.

The first term has no S factor. It is charged even if S_t=0. It is counted once, not again inside the old assembly radius. The tensor factor is B52, not the smaller factor proved for floor100.

Keep Cg=1266*202305920*16384=4196258524692480. Clearing the positive denominator and squaring nonnegative sides gives the exact test

    phi(c)^2 * [(Q-1)*rho_p+Q*S_t*8828]^2
      * 2^(2*(108-p)) <= c*[(Q-1)*Cg]^2.                 (1)

Choose the least p in80..108 satisfying (1) and both old guards. At p>=100 the regrid term vanishes. Since B*8828<2*16384 and S_t<=S_sharp, every previously admitted p_sharp passes (1). Thus p_comb<=p_sharp<=p_mix, and p108 remains an exact fallback. The error coefficient is nonincreasing in p, including the downward jump in rho at100. A passing selected p and failing immediate predecessor prove leastness on the declared range. There is no division by S_t.

The exact same complete sufficient ceiling follows:

    R_comb <= R_fixed+135*E_comb <= R_fixed+135*Cg*2^-108,
    R_fixed = (927193523/10^9)*2^-46
            +135*(2^-82+4*2^-63)+10*2^-54+93*2^-55+2^-51.

The ceiling divided by2^-45 is 2804840254168152529/4294967296000000000. Source alpha, head, original assembly, conductor-factor error, completion, inverse-character adapter, all83 kernel errors and accumulation remain separately paid. Exact positive-transform conventions and the closed guard domain are unchanged. New centers confer no old sign, bracket or completeness certificate.

## 2. Immutable saved-data allowlist

The future writer may read precisely the following ten JSON inputs after exact byte-size and SHA256 checks. Their total is75,419,343 bytes. The new aggregate input-byte cap is96 MiB, with32 MiB per file. This is an explicit increase from the earlier six-input proposal; it is not a claim that decoded objects occupy96 MiB.

|Input|Bytes|SHA256|
|---|---:|---|
|`integration/transform_structural_manifest_20261111.json`|25110201|`A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637`|
|`zero-sum/mixed_radix_precision_metadata_20261111.json`|1911933|`8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E`|
|`major-constants/conductor_local_precision_rows_20261111.json`|21933038|`B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7`|
|`major-constants/conductor_local_precision_caches_20261111.json`|1902325|`95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584`|
|`major-constants/conductor_local_precision_metadata_20261111.json`|2686|`7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978`|
|`integration/short_window_guard_ledger_20261111.json`|41665|`C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4`|
|`integration/sharper_conductor_precision_rows_20261111.json`|20920838|`8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085`|
|`integration/sharper_conductor_precision_nodes_20261111.json`|1720100|`29A7C789AD3B5BC34D2177567FECEFB1FBBE7CFF432943150FCF18B868E7C9D6`|
|`integration/sharper_conductor_precision_caches_20261111.json`|1871369|`129ADFCF668378CA94140DB27F3A3D6EF43995E05EB1413D3BE8AC603061D831`|
|`integration/sharper_conductor_precision_metadata_20261111.json`|5188|`8CEA147C264CC963CAE2EBAFE58F32E4CCD53A99378D7403161510993862227F`|

Require the existing manifest schema and canonical full-plan hash `fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b`,37117 full nodes,13943 saved axes and125400 ordered conductor rows. Do not factor conductors, regenerate unit sets, choose plans, regenerate heights or modify row order. Verify supplied phi/primitive products from the saved axes, retaining repeated occurrences.

The compact guard receipt binds the admitted sample domain and maximum height26525/4<7000. Its review is `zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md`, SHA256 `15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA`. No guard-row file or guard weight is read or folded here.

## 3. Exact predecessor gates

The first-pass author/review are `major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, `2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D`, and `independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, `01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C`.

The sharper author/review are `integration/SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md`, `62D619E84704F6A9D9DA949AF769419E4F4110A9F07C6BFC56EBED127B0DEC57`, and `major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md`, `F213CB6BC227DFE0C5A25DD92B3DE6405165E7281678EA9224596EE7704FCF39`.

Rebuild legacy mixed and sharp C/D on every saved full node from its fixed choice, including ordered children. Match all sharp node rows, all saved axis new_C/new_D fields in their ORIGINAL mixed meaning, and both assignments row by row. Check row identity, axes, all sums, precisions, slacks and immediate-predecessor failure. At most two selector checks per row per predecessor are needed. Do not replace this with aggregate agreement.

Reconstruct both complete FULL-plan cache closures and compare every stored key, ordered child reference, kernel row, producer contract and summary field. The legacy closure has38147 node/precision states,7606 kernels and364355904 entries; the sharp closure has37522 states,7850 kernels and369180928 entries. Their shared precision-forgotten closure has32942 active full nodes,12496 top-axis lengths,6004 Bluestein lengths and337702368 one-precision kernel entries. Both must match before combined outputs may be published.

The old cache contract hash is `22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884`. Its p100..108 domain and exact-grid100 input language remain immutable. New computation cannot be inserted into that object under the old identifier.

## 4. New producer identities and cache closure

Define a versioned input producer contract, `assembled-grid100-single-regrid-p80-v1`. It binds the original source/head/assembly objects, conductor, exact height, unit ordering, p, tie rule, coordinate witness, complex radius rho_p*2^-p and lifetime. Below100 it uses n+2^(d-1)=Qout*2^d+t with0<=t<2^d, d=100-p. At p=100 it keeps the exact same coordinate integer; for p>100 it shifts that integer by p-100 bits. Both exact branches have radius zero. The guard-domain and magnitude proofs are part of the contract, as are the retained source radii. Its hash must be computed from a canonical serialized contract, not a free description.

Define a separate versioned kernel contract for p80..108 with the same direct rounded-normalized producer mathematics: roots/gates at u=2^-p; raw kernel enclosure PAu; normalized center Round_u(Khat/P) with radius(A+1)u and norm<1; exact cached REAL sums C+D and D-C. Include full plan, n/P, sign, phase identities, tie rule, enclosure proof contract and lifetime. Hash this new domain-bearing object. It is not the old contract hash, and the shared-high adapter is excluded. At p>=100, any projected cache overlap with an old schedule requires explicit equality of these producer fields; equal `(n,p)` alone is insufficient. Old and new full-schedule input identities differ even where kernel producers can coincide.

Seed one29-bit precision mask per full-plan node from every saved outer axis at p_comb. Bit p-80 has its literal meaning. Propagate masks once in descending full-node order to the at most two saved children. Repeated axes remain repeated in S; masks deduplicate only cache membership. All children must be smaller and present. No requested/pruned-runtime DAG is used for this closure.

Store masks compactly. A full expansion has at most29*37117=1076393 node/precision memberships and29*6004=174116 kernel memberships. Those are bounded counting/validation iterations, not serialized records. The actual active-node mask count cannot exceed32942 after the predecessor gate. Summing popcount(mask) and P*popcount(mask) gives complete node states, kernel keys and kernel entries. For each p, count only the corresponding bit. Scaled complex rounds equal entries and exact cached REAL sums equal twice entries, as one stated setup schedule. No kernel/roots/value production is performed.

Report baseline/sharp/combined population distributions, changed-row counts and exact precision differences. Report kernel membership intersections through explicitly comparable producer projections and label all three arms as alternative schedules. These are not runtime weights or guaranteed shared imports. No old one-bit theorem is imposed on the combined candidate.

## 5. Output schema and execution bounds

Proposed new basenames under major-constants are `combined_conductor_precision_assignment_20261111.py`, `combined_conductor_precision_nodes_20261111.json`, `combined_conductor_precision_rows_20261111.json`, `combined_conductor_precision_caches_20261111.json`, and `combined_conductor_precision_summary_20261111.json`. This preflight supplies no writer.

Node rows, in canonical saved node order, are `[n,C_mix,D_mix,C_sharp,D_sharp,C_tight,D_tight,combined_mask]`. All37117 nodes remain, including zero masks. Row records preserve source order and contain `[source_row_id,c,phi,primitive,S_mix,S_sharp,S_tight,S_base,D_local_old,p_mix,p_sharp,p_comb,rho,budget_slack,D_slack,peak_slack,previous_budget_slack_or_null]`. Ordered axes and workload rows are referenced through the immutable manifest hash and source_row_id after exact binding.

The cache table contains6004 sorted records `[n,P,mask]`, including all active kernel lengths. It binds the node-output hash, both new contracts and their canonical hashes. Full child identity is supplied by the pinned plan; no per-precision child list is duplicated. A checked consumer must reconstruct the mask implication on each saved edge. The summary records hashes, gates, fixed limits, distributions, memberships, setup fields, memory observations and scope flags.

|Work or artifact|Proposed cap|
|---|---:|
|Full nodes / axis checks / conductor rows|37117 /13943 /125400|
|Saved axes per conductor|18|
|Old chosen/predecessor checks, both assignments|501600|
|Combined selector tests, at most29 per row|3636600|
|Mask propagation edges per assignment|74234|
|New node-bit membership checks|1076393|
|New kernel-bit membership checks|174116|
|Substantive output rows|168521|
|All serialized records, including summaries/contracts|200000|
|Row /node /cache /summary encoded bytes|32 /8 /4 /1 MiB|
|All new artifacts including source and note|48 MiB|
|Aggregate input bytes /individual input|96 /32 MiB|
|Observed process private-memory stop threshold|1 GiB|

Each candidate test includes both guards and the square test. Reuse the last failed test for the selected predecessor instead of repeating it outside the29 cap. Tight C/D must satisfy the proved inequalities at every node. Validate generated arithmetic integer capacities with a conservative1024-bit maximum; an unexpected larger integer fails closed rather than expanding scope. This is a metadata protection, not a numerical operand-width claim.

Read/hash/parse inputs sequentially. Retain the manifest, compact coefficient arrays, three precision arrays and the required output row buffer. Match each predecessor node/row/cache table completely and release its parsed object before loading the next large predecessor table; release raw input byte buffers immediately after parsing. Preserve old summaries only as compact checked fields. No duplicate full JSON tree is retained merely for reporting. Do not materialize the29-fold node-state expansion.

Check private process memory before and after each bounded parse, at phase boundaries, during row/mask loops and before/after serialization. Stop on an observed threshold breach. These checkpoints do not prove an absolute peak cap during a parser allocation. If the coordinator requires an absolute hard limit, an OS-enforced job memory limit is a separate runner requirement before execution. Byte and record bounds alone are not a decoded-memory theorem.

Check every encoded output size and all output paths before publication. Use exclusive creation and never overwrite predecessors. On any schema/hash/identity/selector/mask/cap failure, stop without publishing a success summary. Do not repair by new enumeration, planning, precision range enlargement or an unreviewed input conversion. A partial exclusive write must be reported as incomplete and cannot masquerade as a frozen successful packet.

## 6. Cost obligations and later joins

This pass contains no height weighting, guard fold, arithmetic-price fold or coefficient generation. The flags must say `assignment_only=true`, `guard_domain_applicable=true`, `guard_weights_folded=false`, `prices_included=false`, `values_generated=false`, `production_selected=false`.

The new regrid is a per-actual-input obligation. A later sample-union join must charge sum(phi(c)*J_actual(c)) over p_comb<100, with J_actual counting actual distinct source heights, guards and auxiliary samples. There are two coordinate witnesses per complex input, four signed witness additions in the stated checker, shifts/ranges/bindings and quotient/remainder generation. Source grid100 production, exact assembly, p>=100 embedding and traffic remain paid. It is not one conversion per output character or one reusable center across heights.

All lower-p root, kernel, scaled-cache-round and cached-sum producers require their exact enclosure and lifetime evidence. No high-cache sharing is assumed. Full P20 source/head costs and the retained completion/kernel/interpolation tolerances remain unchanged by this assignment. Actual guard samples, signs, repairs and Turing closure are still required, as are principal, binary/ladder and library costs.

The current independently approved40-weight price run is unchanged. A later price pass could carry labeled legacy, sharp and combined40-weight blocks together, but29 partitions and120 weights are a different task. Even before storage details, conservative context bounds become29*220108=6383132 processed contexts, and up to54 top-axis contributions per conductor for three assignments. Width-key counts and regrid occurrence accounting must be newly bounded. Requested CT nodes may have three children, unlike this full-cache graph. No such price propagation is authorized here, and no existing nine-partition approval covers it.

## 7. Preflight evidence and approval boundary

The ten JSON inputs were checked by file size and byte hashing only; none was parsed. Ten fixed integer/rational assertions checked the input-byte total, tensor/magnitude fallback comparison, global safety, exact complete-radius ratio and loop/record caps. This arithmetic used no conductor or plan rows and did not execute an author program.

Before execution, this note requires independent review of this combined composition/schema, coordinator authorization, and a separately inspected standalone writer. The writer must bind the exact mathematical pins and all ten data pins listed here. This task stops at the bounded proposal. It claims no precision distribution, cache saving, runtime saving or chosen production method.
