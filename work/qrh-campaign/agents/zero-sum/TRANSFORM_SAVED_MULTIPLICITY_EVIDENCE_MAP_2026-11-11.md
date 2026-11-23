# Retained transform evidence for width-sensitive pricing

2026-11-11. This bounded inspection reads frozen receipts and their generating source without executing any inventory. The companion performs only saved-field joins and integer subtraction. No conductor enumeration, transform schedule reconstruction, numerical value or build was run. This supplements integration's arithmetic pricing model; it does not supply new gate prices.

One useful exact split is recoverable now. In this particular circuit, the stored `dyadic_scales` count equals the number of runtime cached-Bluestein-kernel complex products. Therefore the remaining general products multiply data by unit roots/chirps. The receipts do not retain the joint padded-length/stage/height information needed to price those products at their individual widths.

## 1. Recoverable product types

In `zero-sum/mixed_radix_character_inventory_20261111.py:29-51`, a radix-two circuit has no dyadic scales. A Bluestein node of padded length `P` contributes two full radix-two transforms, `P` cached-kernel point products, chirp products, and exactly `P` inverse scales. Direct-prime leaves and CT bridges contribute no dyadic scales, and CT composition adds child vectors with multiplicity. The paper's section 3 explicitly places only the convolution's division by `P` in this category; there is no extra axis normalization.

Pruning preserves the invariant. `primitive_output_pruning_inventory_20261111.py:137-160` keeps both full padded transforms, all `P` point products and all `P` inverse scales, deleting only unused final chirps. Tensor multiplicities preserve the equality. These are fixed-coefficient products: the kernels are cached, not a second variable input. Their coefficients need not have unit norm. The unit-root category refers to the exact coefficient type; its stored approximant and uncertainty still require the accepted error contract.

Write `G` for `general_complex_products` and `D` for `dyadic_scales`. The exact runtime split is

```
kernel products = D,
unit-root/chirp products = G-D.
```

It is specific to this frozen circuit and must not be inferred from an arbitrary FFT ledger using the same field name. Cheap quarter turns/negations remain separate, and setup kernel FFTs are not runtime point products.

The selected current large-branch receipts agree on all five operation fields. Their four alternative scenarios give:

| Extra coarse nodes | Runtime kernel products | Runtime unit-root/chirp products |
|---:|---:|---:|
|0|88576420247296|915527265950592|
|167|90374781940928|934243384438190|
|320|92022382774016|951390487004672|
|640|95468345300736|987253708058752|

One extra node at every included conductor contributes exactly 10768632896 kernel products and 112072565794 unit-root products. This is a common-height extension count, not a count at one particular absolute height or a new auxiliary sufficiency claim. Do not sum the four scenarios.

## 2. Finest fields actually saved

Paths below are relative to `work/qrh-campaign/agents/`. Array indices refer to JSON fields, not a promise of unstored rows.

| Receipt | Exact retained fields | What can be priced from them |
|---|---|---|
|`major-constants/reconciled_nonprincipal_schedule_20261111.json`|`scenarios[].extra_nodes`; `scenarios[].large.transform_operations`; `large.residue_inputs`, `primitive_outputs`, `conductor_height_nodes`, `global_nodes`; `setup.large_transform_unchanged`|Current four aggregate runtime vectors and the exact product-type split above; seed/small branches remain separate.|
|`major-constants/combined_odd_even_height_inventory_20261111.json`|`scenarios[].operations`; `per_extra_node_operations`; `combined_main`; seven `examples`; `transform_setup_unchanged`|Independent provenance for the same vectors and linear extra-node increments. Examples do not constitute a conductor-height table.|
|`zero-sum/conditional_r132900_pruning_inventory_20261111.json`|`rows.all`, `.large`, `.small`, each with `whole_axis`, `full`, `same_order`, `G_order`, `between_axes_only`; twelve `examples`; `large_setup`|Old-height comparator aggregates, and exact axes/order for the examples only. Current pricing uses fixed original order, not `G_order`.|
|`zero-sum/mixed_radix_character_inventory_20261111.json`|Five `rows` by conductor range; nine `examples`; `choices_count`, `active_plan_count`, `canonical_plan_sha256`; aggregate `mixed_setup`|Historical full-circuit totals and setup; no serialized CT tree despite its plan hash.|
|`zero-sum/mixed_radix_precision_metadata_20261111.json`|13943 `axis_rows`, each `n,old_C,new_C,old_D,new_D`; maxima and five examples|An exact lookup of conservative error/safety constants by whole axis length, without occurrence weights or selected bit precision.|
|`independent-feasibility/mixed_radix_width_metadata_20261111.json`|13943 `axis_rows`, each `n,old_peak,mixed_peak,old_bits,mixed_bits`; unweighted axis/conductor histograms, maxima and five examples|An exact lookup of conservative whole-axis peak factors by length. Histograms describe the older 149999-conductor family and are not current runtime-weighted distributions.|

The precision and width `axis_rows[].n` sets coincide and have the same canonical full-plan hash. Joining them is valid as a table of conditional whole-axis envelopes. It supplies no frequency with which an axis occurs, no original-order prefix multiplier, and no input norm `B`. The precision `D` is a safety denominator, not fractional bits. The reported maximum 43 safety bits is not an output precision prescription. The width factors assume the reviewed common-`u` and input-envelope hypotheses.

Current setup is retained as 6004 kernel lengths, 337702368 padded kernel entries, 140276846 chirp entries, maximum padded length 262144, and a CT full-root-table upper count of 1116142487. Its `kernel_forward_operations` is a separate setup vector. These figures do not specify per-length cache contents, chosen precision, actual cache lifetime, root sharing or rebuild multiplicity.

## 3. Information generated earlier but not serialized

The full-circuit source constructs `plan_data[n]={choice,count}` at line 174, hashes it, then exports its hash and aggregate counters rather than that dictionary. The precision source similarly constructs `data` at line 81 and retains only its hash plus whole-axis bounds. The width source constructs `plan` at line 98 and likewise exports only its hash. A hash is not a recoverable manifest.

The R132900 pruning receipt reports 12781 recursive requests and 12523 top-axis restrictions, but does not save their `(n,q)` sets or multiplicities. The earlier R138000 counts are different and must not be substituted. `tensor_cost` in the pruning source uses a live `before*suffix` multiplicity and updates `before` by the retained output size. That per-axis occurrence information is discarded after aggregation. Full-plan recursion and current height formulas remain reproducible from source, but regenerating their joint distribution would be a new inventory, not a fold of saved evidence. It was not done here.

The inspected independent review receipts retain replay verdicts, aggregates, examples and histograms, not a finer joint manifest. This observation is limited to the pinned transform lineage and its associated review files. It is not a claim that no unrelated file anywhere could contain further data.

## 4. Missing correlations and exact next export

A future stage-sensitive fold needs the following *joint* keys, rather than separate unweighted histograms:

- Current conductor or an exactly proved equivalent cohort; scenario height-node multiplier; fixed outer-axis position and original prefix size.
- Axis length, requested primitive restriction, selected CT/direct/radix/Blue node, child dimensions and multiplicity.
- For Blue nodes, padded `P`, root/chirp versus kernel product category, forward/inverse stage, and normalization location.
- The incoming augmented norm bound, chosen dyadic grid, coefficient radius and cached-kernel bound at that occurrence.
- Distinct coefficient/cache keys by precision and checked lifetime, with setup and transport separate from runtime use.

The current tables support uniform conservative category prices, now with a justified kernel/root split, and conservative global peak/error envelopes. They do not support a claimed weighted average of stage widths, a per-`P` kernel histogram, or a per-height precision distribution. Uniform costs may be deliberately pessimistic, but must retain their envelope hypotheses.

A minimal future export would aggregate multiplicities by the above structural keys and prove its projections reproduce the already frozen five-category scenario totals and setup counts. It need not store every gate. Additional width bounds could then join by node/position; actual adaptive precision would still require its own rule and evidence. This is a proposed missing export, not an authorized or completed reconstruction.

## Evidence pins

The companion `transform_saved_evidence_map_20261111.py` has SHA256 `04E9BBE7D7C6B7F2CEC9D61EDFB00181ADBEE322FCF6F4D5C2119D58E5654263`; JSON `4E74C6C9AEA54A42B44EBFB36034AC7AD8663D3A5B0A34F83B410B24EC0E22B4`. It records 24 saved-field consistency checks and exact pins for the inspected receipts, source definitions and existing reviews. It does not import or execute the inventory scripts.

| Receipt key in companion | SHA256 |
|---|---|
|`full`|`2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F`|
|`pruned`|`E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF`|
|`precision`|`8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E`|
|`width`|`364B00C1BA63A06CC5B1C3E0CC777280151BB05E0E5B56063231596B0249B48F`|
|`combined`|`BCBAA29AE9A963A46170C5B7B355C0399EE6A622EDBE355ECD24BFE92042C2EE`|
|`reconciled`|`0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397`|
