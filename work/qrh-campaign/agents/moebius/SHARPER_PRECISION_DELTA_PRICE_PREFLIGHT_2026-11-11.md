# Sharper precision pricing by an exact changed-row update

2026-11-11. Preparation only. This proposes a bounded successor to the accepted conservative price pass. No new assignment, context or price fold has been executed for this preflight. Only frozen papers and writer/schema source were read; file sizes and hashes were inspected. No numerical values, new conductor/factor/unit inventory, individual gates, builds, declarations or proof emission are authorized here.

The proposed method uses the fact that every changed row in the independently reviewed sharper assignment drops exactly one bit. Propagate only those 8707 rows, grouped by their old precision, with forty old/guard weights. Subtract their old precision contributions from the accepted full histogram and insert the identical structural contributions at one lower precision. Unchanged rows need no second context propagation. This is a new proposed authorization, not an implicit extension of the earlier forty-weight pass or an eighty-weight dual pass.

## 1. Frozen prerequisites

All agent paths are relative to `work/qrh-campaign/agents`.

The conservative full price result is `moebius/CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_2026-11-11.md`, SHA256 `F177AF35A1B8062AC649BB9877A24ADD8A8C22D59547AB8FC5AD156B9D0A5CDE`. Its independent review is `independent-feasibility/REVIEW_CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_2026-11-11.md`, `A38579F31FB684517AE4CAA83256E70C9A4CB862D7CE17750FE7A4F5898F15D1`. The author writer `moebius/conductor_local_precision_prices_20261111.py` has hash `3F3F3A19521E45EF5D5914DFDBA12C1705F9F2FFA2A080D4DF171D7F3E9C8031`.

That packet and independent reconstruction checked every old and guard normalized phase key, all 936 precision/width classes, complete p108 and local component prices, and complete old cache membership/setup. It supplies the full-workload comparator for this successor. This preflight does not claim to rerun those two 125279-key historical phase comparisons.

The sharper assignment is `integration/SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md`, `62D619E84704F6A9D9DA949AF769419E4F4110A9F07C6BFC56EBED127B0DEC57`, reviewed in `major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md`, `F213CB6BC227DFE0C5A25DD92B3DE6405165E7281678EA9224596EE7704FCF39`. Its writer `integration/sharper_conductor_precision_metadata_20261111.py` is `6F41270DAF009B151432DD7619B69C46737598C8B3C8194D80FA719AE52864AE`.

The sharper mathematical rule is `audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md`, `08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F`, reviewed at `3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3`. It retains the saved circuit, grid100 input, old safety/peak guards and complete p108 sufficient radius. Its node-coefficient proof is inherited through the accepted assignment review; the new node-coefficient JSON is not an input to this price pass.

The normalized width factors, source magnitude domain and guard contract remain those consumed in F177AF35. Sharper coefficients change the sufficient p assignment; they do not change these structural width classes. Changed p can change actual centers and signs. Neither sign transfer nor new numerical success is inferred.

## 2. Ten proposed JSON inputs

The exact files below were stat/hash checked for this preflight without parsing them. The proposed input total is **85036369 bytes**. Require exact sizes and hashes before parsing, at most 32 MiB per file and 128 MiB aggregate. No input discovery or replacement version is permitted.

| Input | Bytes | SHA256 |
|---|---:|---|
|integration/transform_structural_manifest_20261111.json|25110201|A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637|
|major-constants/conductor_local_precision_rows_20261111.json|21933038|B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7|
|major-constants/conductor_local_precision_caches_20261111.json|1902325|95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584|
|integration/sharper_conductor_precision_rows_20261111.json|20920838|8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085|
|integration/sharper_conductor_precision_caches_20261111.json|1871369|129ADFCF668378CA94140DB27F3A3D6EF43995E05EB1413D3BE8AC603061D831|
|integration/sharper_conductor_precision_metadata_20261111.json|5188|8CEA147C264CC963CAE2EBAFE58F32E4CCD53A99378D7403161510993862227F|
|integration/short_window_guard_conductor_rows_20261111.json|12794207|A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA|
|integration/short_window_guard_ledger_20261111.json|41665|C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4|
|moebius/conductor_local_precision_price_widths_20261111.json|353684|588474ECF8B628607ADC279BC429BC7CBAA3125CC2AEAB5D7F9708E66CDD48FB|
|moebius/conductor_local_precision_prices_20261111.json|103854|B1684F0328BC70E2B59D88975489D31161081A3082F1AFF176D527E7741E9D53|

The two large historical phase histograms, the mixed/sharp coefficient tables and the original full conductor-generation writers are excluded. Supporting Markdown and source pins are read/hash references only. Do not import any author program. A new standalone writer would implement the finite integer definitions required below.

## 3. Full row validation before selecting the changed subset

Read the same 125400 manifest rows in their original order. Compare each old twelve-field precision row against its exact id, conductor, phi, primitive count and ordered axes. Compare the new fourteen-field row

    source_row_id,c,phi,primitive,S_mix,S_sharp,S_base,D_local_old,
    p_mix,p_sharp,budget_slack,D_slack,peak_slack,
    previous_budget_slack_or_null

against that same id and the old fields. Require exact old/sharp row and manifest hashes in the schema bindings. Check the saved integer budget and safety slacks and S_sharp<=S_mix, without generating any new recurrence or optimizing p. The accepted assignment review supplies the S_sharp source meaning.

Require exactly 116693 unchanged rows and 8707 changed rows, with every changed row satisfying `p_sharp=p_mix-1`, `101<=p_mix<=108`. Require the complete eight transition counts from the frozen sharper receipt, not only the total. Any different transition stops this specialized delta method; it does not trigger a general dual-arm pass.

Join the guard row by c,J,phi,primitive. Recompute the old twenty and guard twenty weights from the same five index bands and e=0,167,320,640. The guard remains `[J+e,J+e+41)`. Compare exact stored weights, each 41-sample total, and each per-height five-operation vector using the saved requested totals. These loops validate supplied rows; they do not enumerate conductors, factors or residues.

During the row join, reconstruct all old per-p conductor-height, residue-input and primitive-output forty-vectors and match the accepted old width artifact. Form analogous changed-subset vectors and sharp vectors. Each old entry minus its changed-subset entry must be nonnegative. Sum over p to prove all three full-workload metadata quantities unchanged. This also preserves source-grid embedding and output-transport multiplicities for later prices.

The full old row join is necessary even though only 8707 rows receive new context propagation. No changed row can be silently missed because the selector file, old file and manifest are joined by exact position and identity.

## 4. Why a changed-row fold suffices

Fix the saved requested DAG, ordered outer axes, original pruning and reviewed normalized incoming factors. Let `E(c,k)` be the nonnegative structural multiplicity for conductor c and width key k, where k consists of category, data-ceiling exponent, coefficient exponent and division bits. Let `w(c,i)` be one of its forty exact height weights.

Neither E nor w depends on the assigned p. The same V<=2^14 width proof is retained throughout p100..108. Precision enters the arithmetic price through the capacities `p+14+data_exponent` and `p+coefficient_exponent`; it is not used to choose a different plan, phase, pruning, sample set or incoming-factor bound. Therefore the old histogram is

    W(r,k,i) = sum_{c: p_mix(c)=r} E(c,k)*w(c,i).

For the changed subset define

    D(r,k,i) = sum_{c: p_mix(c)=r and p_sharp(c)=r-1}
                         E(c,k)*w(c,i),      r=101,...,108.

Use zero D outside those eight labels. The new full histogram is exactly

    Wsharp(r,k,i) = W(r,k,i)-D(r,k,i)+D(r+1,k,i).

First check `D(r,k,i)<=W(r,k,i)` for every key and component. Missing keys in the old table count as zero. Compute the nonnegative retained part before reinsertion, rather than relying on a later total to hide a negative component. Summing over r gives the old complete width histogram exactly. This identity is a finite linear sum over the unchanged actual source rows, not an approximation based on population percentages.

The saved full old histogram was independently reconstructed from complete phase contexts. The successor reconstructs the actual changed subset using the same phase formulas, then projects those emissions to widths. It does not claim a new full-phase-file comparison. The mathematical finite-linearity identity above and exact subset association justify reuse of the unchanged part. The independent successor review must check that the implementation really follows the saved contexts, not merely move arbitrary old aggregate weights between p labels.

## 5. Bounded changed-context propagation

Partition only the changed row ids by their old p. Use forty weights, not eighty. For each axis seed the retained preceding-axis times full following-axis count and the twice-full-preceding-axis magnitude factor. Follow the fixed requested edges in decreasing length. Requested q=n CT edges may have three children; full-plan cache splits separately have two. No new plan, different axis order, unit or per-gate expansion is allowed.

Use exactly the phase formulas accepted in F177AF35: CT `2*m*a`; Bluestein prechirp and forward factor `2*a`; point factor `(n+2)*a` with coefficient exponent zero; inverse `Z*a`, where `Z=n*(2*n-1)/P+2`; stage product/add factors `2^j*Z*a` and `2^(j+1)*Z*a`; postchirp `2*n*a`. Derive each ceiling exponent from its exact positive rational. Keep the same pre/postchirp parity and nonnegativity checks. Radix stage count remains at most 18.

Each partition is a subset of an independently reconstructed old-p partition. All propagation coefficients are nonnegative and its key geometry is unchanged. Its set of created contexts must therefore be a subset of that old partition's set. The accepted exact old counts give the following tighter hard bounds:

| Old p | Changed rows | Top-context cap | Processed/retained-context cap |
|---:|---:|---:|---:|
|101|2116|3678|20378|
|102|2021|3232|17621|
|103|1720|3060|15680|
|104|1033|2256|11681|
|105|578|1905|8485|
|106|311|808|3851|
|107|920|920|3687|
|108|8|8|32|

The total processed delta-context cap is **81415**, and the maximum retained cap for any one partition is **20378**. Enforce the relevant per-p cap before creating a context and an aggregate processed cap independently. Retain only one partition at a time. These caps follow from the accepted full result; they are not predictions of the delta's actual size.

A delta width key is `(old_p,category,data_exponent,coefficient_exponent,division_bits)`. Its unlabelled part must belong to the accepted 133-key global width set, so at most `8*133=1064` delta rows are allowed. The final sharp histogram has at most `9*133=1197` rows, even if its actual support changes from the old 936. Preserve all forty weights and all five original operation categories, with root/kernel products separate and runtime scale explicitly zero. Quarter turns and negations retain counts despite their zero core arithmetic fee.

No full phase histogram is written or retained by this delta method. Phase identity and factors are checked during emission into the compressed delta histogram. There is no loop over the enormous gate counts. Full manifest validation remains bounded by 35190 requested nodes, 37117 full-plan nodes and at most 18 axes per supplied row.

## 6. Baseline gates and price outputs

Before reporting a new price, reconstruct both arithmetic modes directly from all 936 accepted old width rows. Match every local-price component, all old/guard/joined views, all bands and all four alternatives against B1684F03. Force p108 on those rows and match every global-p108 component in the same receipt. Reconstruct the old normalized setup from the saved 7606 cache keys, and the global setup from their 6004-length union, before comparing a sharp setup.

Then apply the exact nonnegative delta update. Report new prices against both global p108 and conservative local p. Use the same original byte M/A templates, fixed-coefficient three-product and four-product modes, exact-add and round-witness components as F177AF35. No Gauss, wider radix, named-digit, zero-carry, new binding or other arithmetic substitutions enter this comparison. Every mode/scenario keeps separate product and addition prices.

The old/guard/joined views overlap, and the four e choices remain alternatives. Do not add their setup charges or infer a query count. No assumption is made that a one-bit drop saves a byte-template event: byte-boundary effects must be calculated from the actual width classes. Population changes are not weighted price savings.

The old and sharp per-p forty-vectors for source inputs/outputs must be retained. They can support a later class-uniform upward precision map, but this pass executes no portfolio policy. Arbitrary conductor-specific choices within a compressed class are not supported without additional associations.

## 7. Full sharp setup and cold/sunk costs

Validate the sharp cache artifact's full contract/hash, sharp and legacy assignment references, 37522 full-plan/precision states, ordered children and 7850 kernel keys against the same full plan. The cache record sets, not output pruning, determine setup. Forgetting p must still recover 32942 full nodes, 6004 kernel lengths and 337702368 one-precision entries. The sharp independent-per-p schedule has 369180928 entries. Check all stated legacy/sharp intersections and differences against the two actual saved cache sets.

Recompute the scaled-round and exact-real-sum fees at each sharp key's own p. Retain the same formula and complete producer/enclosure contract `22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884`. The two exact REAL sums belong to the actual new rounded center. Report full kernel FFT operation counts by p, chirp entries and full-plan root-table upper counts separately. No setup FFT receives runtime operand widths without a proved setup envelope.

This baseline still constructs every `(n,p)` kernel independently. The accepted shared-high adapter is excluded. Its producer identity, conversion schedule and reuse costs require another matched comparison. Neither same length nor the analytical sharper rule grants free actual cached-object reuse.

For each comparison keep main product/addition reserve, cold setup difference and conservative sunk setup separate. Cold cost compares one complete sharp lifetime with one chosen predecessor lifetime. If the predecessor cache is already paid, it is not refunded: charge the new sharp objects conservatively, or explicitly prove full-identity overlap and lifetime continuity before excluding them. Set intersections alone are possible identities, not existing live certificates.

Root/chirp generation and proof, actual kernel setup arithmetic, source grid100 embeddings, output conversions, imports, storage and rebuilds remain named costs. The same formal break-even inequality holds with separately declared units. No byte-event reserve implies an end-to-end generation or checking improvement.

## 8. Output limits and approval boundary

Proposed files under moebius are `sharper_precision_delta_prices_20261111.py`, `sharper_precision_delta_widths_20261111.json`, `sharper_precision_price_widths_20261111.json` and `sharper_precision_delta_prices_20261111.json`. Each JSON is capped at 2 MiB and all owned outputs including source/report at 8 MiB. Use exclusive creation after all comparator and cap checks. No per-gate output or duplicated full event histogram is permitted.

These are record and serialized-byte limits, not decoded-memory measurements. The input rows, forty-weight dictionaries and arbitrary-size integers have additional Python overhead. Release each processed partition and do not retain eight full context tables. Any cap, transition, historical comparator, subtraction or cache-identity mismatch stops the attempt. No broader pass or capacity increase is an automatic fallback.

The next required actions are independent review of this delta proof/schema/caps and explicit coordinator approval of its ten-file allowlist and execution. The existing forty-weight full-pass approval does not authorize this successor. An independent result checker should reconstruct the changed subset from the pinned rows, inspect or independently implement the finite-linearity update, reproduce both predecessor price/setup gates and compare all sharp classes, components and caches. It must not import the author's writer.

This preflight preserves the whole source/error/export domain, guard obligations, actual new-center sign tests, interpolation and Turing completeness, principal/small-family work, finite arithmetic and full analytic foundations. It promises neither a new numerical certificate nor a production choice. No successor fold has been performed.
