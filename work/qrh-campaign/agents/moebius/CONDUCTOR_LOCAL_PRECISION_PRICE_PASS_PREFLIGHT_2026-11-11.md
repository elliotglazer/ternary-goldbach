# Conductor-local precision price pass: bounded preflight

2026-11-11. Preparation only. This specifies one saved-metadata propagation carrying the original samples and the reviewed +41 guard together. No JSON inventory has been parsed or folded for this task, and no writer or evaluator has been imported or run. Work was limited to reading papers and writer/schema source, inspecting file sizes, and hashing frozen inputs. No numerical value, new conductor, factor, unit, root, gate, transform, proof or build is produced. All predecessors remain unchanged.

The proposed output is a conditional comparison of the same normalized circuit at global p108 and at the already assigned p(c). It is not a precision selection or an end-to-end saving. Execution needs a separate coordinator authorization after independent review of this preflight. In particular, first-pass authorization did not authorize the guard join or the runtime-context propagation below.

## 1. Accepted prerequisites and exact scope

Paths in this note are relative to `work/qrh-campaign/agents` unless explicitly stated otherwise. The mathematical selector is `major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md`, SHA256 `1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A`. Its review is `independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md`, `15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2`.

The frozen first pass is `major-constants/CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, `2F8F93B81BEA0FB4B133B7FEFC6FEDB2BAD2DEEC52FF07837DFA44F05D680A7D`. Its independent review is `independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_SAVED_PASS_2026-11-11.md`, `01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C`. That review reconstructs the error recurrences, all 125400 assigned rows and all cache memberships. The second pass consumes this result; it does not silently rerun its axis-error inventory.

The normalized guard join is `integration/NORMALIZED_TRANSFORM_SHORT_GUARD_JOIN_2026-11-11.md`, `ADDED6BC91975C40C6029A591F4486782932C92B144D39465AC5E0F3CB597E58`, reviewed in `audit/REVIEW_NORMALIZED_TRANSFORM_SHORT_GUARD_JOIN_2026-11-11.md`, `47B0B4971E65D79E819DA3717DBEA9058D348CF02411AC6F78F32F4E3CBF489D`. Root decision `work/qrh-blueprint/GUARDED_COSTS_REPRESENTATION_AND_LOCAL_PRECISION_DECISION_2026-11-11.md`, `972884F678C29412D66449B8BA961AFB6A3D77CDF8D2CBF151A5F3C79D88F1A6`, accepts those scopes but explicitly separates this price pass.

One assigned p in 100 through 108 applies to all characters and all requested heights of its conductor. Both the mixed and old safety bounds, the old peak bound, exact grid100 input embedding, and the complete global-p108 sufficient error ceiling remain required. A large count of p100 conductors alone says nothing about weighted arithmetic or setup cost. Changes in p can change centers and signs.

The domain is exactly the saved large-family rows, c>10000, with the saved parity restrictions. Principal and small-family computation are unchanged. The four auxiliary cases e=0,167,320,640 are alternatives, not four workloads to add together.

## 2. Proposed input allowlist

The following sizes and hashes were checked from the files without parsing their JSON. Before a future read, require the exact byte size and hash, then schema and typed fields. No glob discovery of replacement inputs is permitted.

| Input | Bytes | SHA256 |
|---|---:|---|
|integration/transform_structural_manifest_20261111.json|25110201|A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637|
|major-constants/conductor_local_precision_rows_20261111.json|21933038|B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7|
|major-constants/conductor_local_precision_caches_20261111.json|1902325|95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584|
|major-constants/conductor_local_precision_metadata_20261111.json|2686|7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978|
|independent-feasibility/normalized_bluestein_events_20261111.json|18684197|721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2|
|independent-feasibility/normalized_bluestein_structural_costs_20261111.json|89710|F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3|
|moebius/normalized_transform_precision_costs_20261111.json|107410|C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4|
|integration/short_window_guard_conductor_rows_20261111.json|12794207|A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA|
|integration/short_window_guard_ledger_20261111.json|41665|C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4|
|integration/normalized_transform_short_guard_events_20261111.json|14254909|F26896C955B06006AEBA260FB6605EDE21DDD3EA9CED984E0DD46BADAA855897|
|integration/normalized_transform_short_guard_join_20261111.json|159195|4F6F20570E0E1F35C806E173E2FA13B95CCD084B177F38F359E3F3171F5EB66A|

Proposed read caps are 32 MiB per input and 128 MiB aggregate JSON bytes. Supporting Markdown and writer sources are hash-bound references, not executable imports. The two historical event histograms are compared sequentially after reconstruction so their decoded copies need not coexist. The original unnormalized 138126-class event file is not an input to this pass. Its relation to the normalized circuit has already been independently reviewed. This task will instead check every key and weight in both complete normalized histograms.

Source/schema references inspected are:

| Writer | SHA256 |
|---|---|
|major-constants/conductor_local_precision_metadata_20261111.py|8B0C9764E94A7E35FB071CED0E5731135E11D397B9BA9F582119BAA9005386DA|
|integration/normalized_transform_short_guard_join_20261111.py|2C7D865CFFEA56D693F3DA70E063EFBF1CD50F237594766E9C4229D83FFFBE7A|
|moebius/normalized_transform_precision_costs_20261111.py|81983D037823346DA54553F7DF467A9139983C71DE6568DF9040BDA5677215C0|
|integration/transform_structural_inventory_20261111.py|584A16F00A905AD68C3FE11F4128FE2205F772FB67916EF312B596518F1ADB55|

No producer module is imported. A future standalone writer must copy only the finite integer definitions needed for the declared join, with its own pinned source and explicit checks.

## 3. Row identities and the simultaneous guard join

The manifest has 125400 seven-field conductor rows and 35190 six-field requested-plan rows, together with 37117 full-plan nodes. The twelve-field precision row is

    source_row_id, c, phi, primitive, ordered_axes_n_q,
    S_mixed, S_old, D_local, p, squared_budget_slack, D_slack, peak_slack.

Require its id to be its exact zero-based manifest position. Compare c, phi, primitive and every ordered axis pair, including repeated lengths. Preserve the same manifest and full-plan hashes in all outputs. Validate typed nonnegative slacks and the stated integer selector identities using the saved S values. Do not reselect a cheaper precision or introduce a new profile. The accepted first-pass review supplies the S/D recurrence binding.

The guard row is `[c,J,phi,primitive,per_height_five_operation_vector,twenty_guard_weights]`. Compare the first four fields with the same manifest row. Recompute only the five band intersections for each of the four saved e values. For each e, old samples have indices `[0,J+e)` and the guard has indices `[J+e,J+e+41)`. The manifest band upper indices are `[6400,12800,25600,64000,128000]`. Their inclusive-to-half-open conversion must be explicit. The old weights must equal the manifest weights and the guard weights must equal the pinned guard row; each guard sums to 41.

Carry `old20 || guard20` as one forty-integer vector. This handles band-crossing guards without assuming that all 41 samples lie in the conductor's final old band. It also avoids a second context propagation for guards. The same c, p, axis order and dependency closure serve both vectors. The maximum guard height is 26525/4<7000, within the reviewed common source magnitude domain. The guard samples are not recursively treated as new interpolation targets.

During this already-required join, retain by p and by each of the forty weights the conductor-height count, phi times that count, and primitive-output count. These small arrays supply the input-embedding and output-transport multiplicities for a later symbolic cost model. They do not enumerate input residues or assert that every possible representation operation has the same price. Their p-summed original and guard projections must match the historical metadata. Without these arrays, the grouped runtime event histogram alone would not price source embeddings by precision.

This join requires explicit authorization for the guard files in section 2. The first-pass flags `guards_included=false` and `prices_included=false` must not be rewritten or misread as already covering this step.

## 4. One bounded propagation, partitioned by precision

Partition the saved row ids into nine lists by their already assigned p. Each row is joined and seeded once. Process one precision partition at a time, then discard its context table. Do not retain nine complete context maps.

For an outer axis, its occurrence multiplier is the retained preceding-axis product times the FULL following-axis product. Its incoming augmented magnitude factor is twice the FULL preceding-axis product. These are different: output pruning reduces the count but not the magnitude factor. Check the products against phi and the primitive count. The manifest per-height five-category sum must match the guard's per-height vector before any multiplication by height weights.

The runtime context key within a partition is `(n,q,a)`. Follow only the saved requested-plan edges in decreasing n. A child has strictly smaller length and its saved multiplicity and magnitude multiplier. No planner, factor search, unit enumeration, individual gate loop or actual coefficient is needed. No node's original axis order or pruning choice changes.

Use the normalized emission formulas from the reviewed guard writer. In particular:

- CT bridge magnitude is `2*m*a` for its saved ordered split.
- Bluestein prechirp and forward-radix input factor is `2*a`.
- Its point product has data factor `(n+2)*a` and coefficient exponent zero.
- Its inverse starts with `Z*a`, where `Z=n*(2*n-1)/P+2` is an exact rational and P is the saved dyadic padded length.
- At inverse stage j, product-input factor is `2^j*Z*a` and addition factor is `2^(j+1)*Z*a`; the postchirp factor is `2*n*a`.
- Compute the ceiling exponent from the exact positive rational factor. Never subtract rounded logarithms from old widths.

The root coefficient exponent one bounds its center norm; it is not an augmented coefficient norm. Incoming data uses the separately proved augmented bound V<=2^14. Pre/postchirp counts are recovered by the saved full/requested totals with the reviewed parity and nonnegativity checks. Radix stages are symbolic classes, at most 18 per node.

For each emission, accumulate two objects. First, a global normalized histogram with the original key `(category,phase,n,stage,data_exponent,coefficient_exponent,division_bits)` and forty weights, summing across the precision partitions. Second, a local-width histogram keyed by `(p,category,data_exponent,coefficient_exponent,division_bits)`, also with forty weights. This compression retains the assigned-p class; it does not retain arbitrary conductor-specific splits within that class.

Before publishing local prices, compare all global old keys/weights with `normalized_bluestein_events` and all guard keys/weights with `normalized_transform_short_guard_events`. Both must match exactly, not just in totals. Projecting the verified global histogram must recover the 133 reviewed width keys and all twenty original and guard band vectors. Every emitted local width key, after dropping p, must belong to that verified set. Only then is the bound `9*133=1197` justified.

The five original operation categories remain general complex products, complex additions/subtractions, quarter turns, negations and dyadic scales. General products are further split into roots and kernels. Normalized runtime scales have count zero, but that zero is checked and reported. Quarter turns and negations have zero price in the current arithmetic core only; their representation and proof costs remain separate. No category is erased from the inventory.

## 5. Record and loop limits

| Object or loop | Hard proposed limit |
|---|---:|
|Saved conductor rows joined and partitioned|125400|
|Axes per row, with n>=2 and phi<=265800 checked|18|
|Saved requested nodes|35190|
|Saved full-plan nodes|37117|
|Precision partitions|9|
|Top runtime contexts in one partition|52560|
|Processed or retained runtime contexts in one partition|220108|
|Processed runtime contexts summed over partitions|1980972|
|Radix stages in one context|18|
|Global normalized histogram keys|125279|
|Global width keys|133|
|Local precision/width keys|1197|
|Weights per context or histogram key|40|
|Saved full-plan/precision states validated|38147|
|Saved precision-specific kernel keys validated/folded|7606|
|Baseline distinct kernel lengths checked|6004|

The context bound follows because each p partition is a subset of the original conductor population, propagated through exactly the same nonnegative saved DAG. It can only produce keys present in the reviewed full-population context set. The +41 join changes weights, not contexts. The summed bound is nine times the full-population bound, not a claim that all these contexts occur. The 38147 cache states do not bound the runtime context count.

Enforce limits before new dictionary insertions; maintain the total processed-context counter independently of currently live entries. Check requested-plan edge lists have at most THREE children. The q=n branch of `transform_structural_inventory_20261111.py`, lines 139-140, has a full first child and two distinct second-axis requests. Full-plan cache splits separately have at most two children. Reject an unexpected shape rather than expanding the cap. The top contributions are at most 18 per saved row. Each requested node can emit at most two radix-stage blocks plus bounded local phases; no operation-count-sized loop is allowed.

Proposed new artifacts are a width histogram at most 2 MiB, a summary/price/cache receipt at most 2 MiB, and paper/writer source with all owned output bytes together at most 8 MiB. Output is exclusive: no overwrite, truncation or fallback. Do not serialize per-conductor prices, per-p phase histograms, individual gates or caches of numerical values.

These are record and serialized-byte caps, not a claim that Python's decoded objects fit in the same number of bytes. Forty-weight context vectors, arbitrary-size integers, tuple/dictionary overhead, manifest and row objects are additional working memory. Release processed n buckets and each precision partition; compare reference event files sequentially. If this bounded implementation cannot stay within the available research environment, report that limitation and seek a revised preflight, rather than silently increasing capacities or dropping checks. There is no timing or memory benchmark claim.

## 6. Matched arithmetic price model

Use the original byte core without named-digit, zero-carry-cell, wider-radix, new numeral-binding or adaptive Gauss substitutions. For nonnegative magnitude capacities a,b, let

    A(a)=2*ceil(a/8)+1,
    M(a,b)=5*ceil(a/8)*ceil(b/8)+2*min(ceil(a/8),ceil(b/8))+1.

For each product width key at precision p, set `a=p+14+data_exponent`, `b=p+coefficient_exponent`. Fixed-coefficient three-product mode charges

    product: M(a+1,b)+2*M(a,b+1),
    exact additions: A(a+1)+2*A(a+b+2),
    round-witness additions: 4*A(a+b+4).

Four-product mode charges

    product: 4*M(a,b),
    exact additions: 2*A(a+b+1),
    round-witness additions: 4*A(a+b+3).

A standalone complex addition charges `2*A(a+1)`. Preserve root and kernel product/add/round components separately. Sign, range, numeral encoding, source binding and full ordinary-rule proof work are not inferred from these template prices. A future implementation still needs the proved real arithmetic schedules and their actual witnesses.

First force p108 for every local class and compare the resulting original twenty bands, guard twenty bands and their sums against the frozen lower-price and guard receipts, for both modes and all four scenarios. Compare complete component dictionaries and widths, not only grand totals. Reconstruct normalized p108 setup separately before reporting any new local-p result. Then use the saved p field to price the same classes. Report original, guard and joined views separately; never sum the four scenarios.

The local result should also provide unpriced counts by assigned p and band. This explains why a conductor population proportion cannot replace a weighted price fold. No runtime selection follows even if the conditional core reserve is positive.

## 7. Cache setup and lifetimes

The conservative baseline constructs every recorded `(n,p,P)` kernel independently under the first-pass contract SHA256 `22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884`. Validate all 38147 saved full-node/precision edges against the same full plan and all 7606 kernel keys against those edges. Forgetting p must recover 6004 lengths and 337702368 baseline entries. The local keys contain 364355904 entries. The extra 1602 keys and 26653536 entries cannot be priced as free because their lengths already occur at p108.

For each key, let `e=ceil(log2(2*n+1))`, computed by integer arithmetic. Charge `P*4*A(p+e+2)` for scaled-cache rounding witnesses. Fixed three-product mode also charges `P*2*A(p+1)` for TWO exact REAL cached sums of the actual new rounded center. Four-product mode omits only those sums. First reproduce the p108 setup at all 6004 baseline lengths, including its 64162618688 combined addition-core fee in three-product mode. Then fold the 7606 precision-specific keys. No original-unscaled sum refund belongs in this normalized-versus-normalized comparison.

The original kernel FFT construction remains additional work for every key in this baseline. Report its five operation counts by p using the saved dyadic P and symbolic radix formulas, not per-gate expansion. Its root/chirp enclosures, numeric generation, full checking, coefficient-position binding and imports remain named costs. This pass does not borrow runtime operand widths for setup without a proved setup envelope. Full-node caches may be charged as complete saved-plan sets; they are not an inventory of globally distinct rational angles. Shared root/chirp production requires its own exact identity and lifetime proof.

Each cache identity must retain full-plan hash, length n, padded P, chirp/sign convention, normalized variant, p, rounding rule, enclosure/proof contract and lifetime. Equal lengths or grid denominators are insufficient. The new local p108 keys can share an already available normalized p108 object only after matching this complete identity and the actual enclosing contract. Exact finer-grid storage is not the same narrowed representation; regridding changes the center.

Root's separately proposed one-high-precision-cache-per-length adapter receives no credit in this baseline, even if independently accepted before this pass runs. It changes the producer schedule and must receive a separately labeled successor comparison. All per-p scaled objects and sums would still require explicit accounting there.

Let C108 and CL be the matched main template subtotals for one scenario/mode. Keep known scale/sum setup fees S108 and SL separate from unknown setup generation/checking costs K108 and KL. Let R108 and RL include the other price differences, including imports, storage, transport and source/export representations. A cold one-lifetime comparison can favor local precision only if

    C108-CL > (SL-S108)+(KL-K108)+(RL-R108)

under a declared common price model. With rebuild counts, replace each setup term by its actual lifetime-weighted cost. If the global-p108 cache is already paid, do not subtract it as a refund: compare runtime reserve with the incremental local objects and all additional work. An overlap exemption requires the complete identity test above. These formulas describe conditional break-even boundaries, not seconds or full proof-size totals.

## 8. Source, export and other retained work

The same actual grid100 source centers can be embedded exactly on any p>=100 by an integer shift. The shift, capacity/range proof, binding and transport are work. Avoid either assuming their cost is zero or charging nine complete source computations without an explicit schedule. The saved twenty input and primitive-output counts per view should remain available for symbolic per-input and per-output costs. Local precision does not change the accepted non-transform source, assembly, conductor-factor, completion or interpolation tolerances.

The guard ledger supplies shared source-prefix extension costs, conductor-specific residue work, positive completion, inverse-channel negative adapters and query requirements. Retain its exact source objects and all four distinct band vectors. The source prefix needs 41 extra final global layers, not 41 independently generated shared layers for every conductor. The baseline here retains the full declared-domain P20 guard source/evaluator contract. A shorter/rebased Horner successor needs its own admitted join and pricing; this transform pass does not select it. Any separately priced source-conversion cache retains original-center identity and its own lifetime.

No amplitude or sign certificate is produced by this metadata. Actual source enclosures, kernel construction, final L/Y or raw-sign interfaces, strict signs, interpolation queries, central and complex-cluster repairs, Turing completeness and closed-domain coverage remain required. The principal computation, small-family theta work, binary/ladder evidence, ordinary arithmetic library and full analytic foundations remain outside this subtotal and are not eliminated by it.

## 9. Execution and review gate

The current task stops with this paper. Proposed later basenames are `conductor_local_precision_prices_20261111.py`, `conductor_local_precision_price_widths_20261111.json` and `conductor_local_precision_prices_20261111.json`, all in moebius. No such writer or fold is supplied by this preflight. The coordinator must first approve the section-2 allowlist, the guard join, the 1980972 aggregate context cap and the output limits. A future writer must be source-reviewed for the same constraints before execution if the coordinator requires that additional step.

The assigned independent reviewer is independent_feasibility. Its preflight review should inspect the first-pass and guard schemas, subset-context argument, exact normalized emission formulas, all price components, cold/sunk distinction and omitted-cost interface without executing a fold. After any authorized author pass freezes, an independently implemented bounded checker should reconstruct the row join and context propagation, compare the complete historical histograms, local width classes, all band/component prices and cache setup. It must not import the author's writer or accept total-equality alone. Any cap or identity mismatch stops the pass before publication; it does not trigger a broader scan.

The outcome sought is a reviewable conditional price comparison with actual saved multiplicities and explicit setup duplication. No current theorem, numerical success, production precision or end-to-end saving is asserted.
