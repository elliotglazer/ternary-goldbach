# Current transform structure and width-keyed multiplicities

2026-11-11. Newly authorized bounded integer metadata reconstruction. No root, character, transform, source-coefficient, L-function, zero or Goldbach-prime value was generated. No unit residues or individual gates were enumerated. No build, declaration or frozen-file change was made.

The missing structural information is now exported. The selected full-plan hash matches the frozen source, and the new event histogram projects exactly to all five operation categories in all four current large-family scenarios. It also matches every saved bandwise unit-output total. This supplies conservative local-width keys for subsequent arithmetic pricing; it does not select precision, evaluate a circuit, or claim a saving.

## 1. Scope and bounded execution

The preflight sent to the coordinator specified: at most 300000 integer factor metadata entries; reconstruct the full plan using the 13943 already saved axis lengths; enumerate only the 125400 current large conductors; aggregate recursive contexts and events, not gates; stop at one million context/classes or 64 MiB per output. The completed run stayed within those limits:

|Object|Count|
|---|---:|
|Saved full-family axis lengths|13943|
|Canonical selected full-plan nodes|37117|
|Current large conductors|125400|
|Current pruned/full request nodes `(n,q)`|35190|
|Top-level weighted norm contexts|52560|
|Expanded structural norm contexts|220108|
|Aggregated event classes|138126|
|Exact checks recorded before final receipt serialization|2186798|

The 35,190 request nodes include full child requests explicitly. They are not meant to equal the old pruning script's smaller memo/request-set statistic, which returned a full circuit directly for q=0. Both are projections of the same selected circuit.

The script is a new self-contained implementation of the pinned integer definitions. It does not import or execute earlier generators, extract their executable prefixes, or invoke their writers. A smallest-factor table supports conductor/axis metadata. Cheap chirp counts use divisibility and parity classes; cheap cross-twiddle counts use divisors of three target integers. There is no loop over unit residues, output characters, height samples, transform entries or the roughly 10^15 runtime products.

## 2. Exported schema and reproducibility

Three exclusive-write outputs are bound together by hashes.

**Structural manifest:** `transform_structural_manifest_20261111.json`.

- `plan`: the selected full-circuit dictionary keyed by n, including choice and all five operation counts. Canonical sorted compact serialization reconstructs exactly `fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b`.
- `requests`: rows `[n,q,kind,children,local_counts,total_counts]`. A child is `[child_n,child_q,multiplicity,augmented_input_factor]`. Here q=0 means full output; otherwise the retained set is exactly k mod q nonzero, with q dividing n. Children have smaller n, so the representation is a finite DAG.
- `conductors`: rows `[c,phi,primitive,H,J,ordered_axes,band_weights]`. The axis order is the frozen factor order, including the two standard axes for powers of two; each axis retains its exact primitive restriction. No proposed axis reordering is used.
- `band_weights`: 20 integers, scenario-major order for extra nodes 0,167,320,640 and band-minor order for upper heights 500,1000,2000,5000,10000. They partition indices 0 through J+extra-1 using closed upper endpoints 6400,12800,25600,64000,128000. This is a prefix count, not evidence of sign success.
- `unchanged_setup`: separately reconstructed full-cache setup, checked against the frozen combined-height receipt.

**Event histogram:** `transform_structural_events_20261111.json`, binding the manifest hash. Each row consists of seven keys and the same 20-weight vector:

    category, phase, local_length, radix_stage,
    data_factor_ceillog2, coefficient_ceillog2, dyadic_division_bits.

Categories are root, kernel, add, quarter, neg, scale. A phase distinguishes direct leaves, CT bridges, radix stages, Blue pre-chirp, forward transform, point products, inverse transform, division and post-chirp. A root's coefficient exponent is 1; a kernel uses ceil(log2(2n+1)). Zero coefficient-exponent fields on nonproducts are placeholders, not coefficient claims. The data field is an upper envelope relative to V=input-center supremum+1, not an observed norm. A chosen grid p and bound V<=2^b turn it into the conservative magnitude capacity p+b+data exponent.

Exact incoming factors are retained while expanding contexts; only the final event class rounds the factor upward to its binary exponent. The manifest still retains enough conductor and DAG information to reproduce the propagation. Events can be priced by a common p, by the five bands, or by another rule proved compatible with these classes. A conductor-specific precision rule may require a further fold from the manifest; this histogram does not pretend to retain conductor identities after aggregation.

**Summary:** `transform_structural_inventory_20261111.json` records pins, dimensions, exact projections, setup and artifact hashes. It intentionally contains no selected arithmetic price, sign tolerance, precision or runtime estimate.

## 3. Why the structural projections are exact

The full selection rule is unchanged: radix two for powers of two; direct primes through 11; otherwise the frozen smallest-prime CT candidate is selected only when both its G and A counts are no worse than whole-axis Bluestein. The reconstructed plan dictionary matches the canonical original hash, not merely a few example counts.

For a CT node n=rm, the full circuit uses r first length-m transforms, the cross bridge, then m length-r transforms. The q=n pruning case retains all first transforms and the full bridge, m-1 full second transforms and one nonzero-output r transform. The q<n case has q|m: r pruned first transforms, the restricted bridge and m-m/q full second transforms. Direct and n=2 cases use their explicit frozen counts. A Blue request retains both complete padded transforms, every padded point product and every inverse scale, removing only unused final chirps.

For a conductor axis, the count multiplicity is

    (product of preceding retained output sizes)
      * (product of following full axis lengths).

The script sums each request vector with that multiplicity and the exact height count. It then independently expands the structural requests into phase/stage events and projects the event totals back to the same vectors. Thus a missing child, repeated height multiplier or confused full/retained prefix would fail the projection.

For a radix-two transform of length P at stage j, there are P/2^j copies. Each copy has 2^(j-1) butterflies, one identity multiplier and, when j>=2, one quarter-turn multiplier. Consequently the stage contributes

    G=(P/2^j)*(2^(j-1)-1-[j>=2]),
    A=P, quarter=(P/2^j)*[j>=2].

Their finite sums reproduce the frozen radix formula. CT/direct/cheap-chirp counts are also exact integer metadata. These are compressed counts of the prescribed circuit, not executed gates.

The current height is reconstructed using the original rational formulas: qt=2c for odd c and qt=c otherwise, D=1063200/qt, upper pi=3927/1250, plus coefficient 96/5 for odd c and 191/10 otherwise, floor 240 or 255, and additive 200. The base-gap and star maxima are checked against this height for every conductor. J=ceil(64H/5)+1, including the endpoint. All four extra-node choices remain alternatives, not summed campaigns.

## 4. Conservative incoming-norm and width keys

The width proof consumed here is `MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md`, hash `5327CD06...`, with its accepted common-u safety and summed error hypotheses. In particular the stored input is bounded, V is positive, all local safety conditions hold, and each semantic full-child output satisfies

    |computed D_n|+1 <= (3/2)n * incoming_augmented_bound.

Pruning takes a dependency-closed part of the same full circuit, so these bounds remain available without asserting a new smaller error constant. The new histogram does not itself discharge the precision hypotheses.

There are two different prefixes. **Operation counts use retained preceding output sizes; magnitudes use the product of full preceding axis lengths.** At a top-level axis the incoming bound is `aV=2*full_prefix*V`, exactly as in the accepted peak proof. Using the smaller retained prefix for a magnitude would be invalid; the script keeps them separate.

At a recursive CT node, first children receive aV. Their semantic output and a cross twiddle give the second children at most 2m*aV. The bridge is charged that same conservative data bound. In a pruned power-of-two request the CT decomposition can give looser factors than a specially optimized radix-stage bound; these are safe envelopes, not claims of minimal widths.

For radix stages, if input augmented norm is aV, the accepted recurrence `L_next+1 <=(2+u)(L+1)` and common safety give stage-j input bounded by 2^j*aV and stage-j output bounded by 2^(j+1)*aV. Root and quarter operands receive the former key; additions receive the latter, deliberately enough to cover both their inputs and sum. These factors are conservative at the first stage.

For a Blue node let `P=nextPowerOfTwo(2n-1)` and `Z=2n(n+1)+2`. The event keys are:

|Phase|Data envelope relative to aV|
|---|---:|
|Pre-chirp|2|
|Forward radix input|2|
|Point-product data|n+2|
|Inverse radix input|Z|
|Inverse division input|2PZ|
|Post-chirp|4Z+4|

The accepted semantic forward-data bound is at most (n+1)aV in norm; n+2 also bounds the augmented quantity. The kernel's stored norm is at most 2n, so ceil(log2(2n+1)) safely bounds its center magnitude. The point product's augmented bound is ZaV. Inverse stages then use the radix rule, and division leaves at most (2Z+2)aV before the last chirp. The post-chirp key is a safe larger bound. No unit-root assumption is applied to the nonunit kernel.

Direct-leaf products and partial sums use 2n*aV. An isolated pruned length-two addition uses 4aV. All these bounds refer to stored centers under the accepted error contract. Original source uncertainty, finite-head error, character amplification and final Hardy/sign normalization remain separate.

For subsequent use of the reviewed arithmetic template, root/kernel multiplication uses the supplied data exponent and coefficient exponent; its exact presums/raw widths and dyadic rounding witnesses are still charged. Additions, cheap rotations, negations and division events also have explicit keys. This replaces the single global peak by local conservative envelopes; it does not infer actual operand bit lengths or discard signed/range/binding costs.

## 5. Projection results and setup separation

Every row below matches both the combined-height and reconciled receipts in all five categories. Bandwise phi(c)-weighted exports independently match all 20 saved occupancy totals, without inspecting any unit residues.

|Extra nodes|G|A|Quarter turns|Negations|Dyadic scales / kernel products|
|---:|---:|---:|---:|---:|---:|
|0|1004103686197888|2079886046397995|92117812144056|19872754128|88576420247296|
|167|1024618166379118|2122384498321844|93986171544503|20269359088|90374781940928|
|320|1043412869778688|2161320205773035|95697902013176|20632715728|92022382774016|
|640|1082722053359488|2242754365148075|99277991882296|21392677328|95468345300736|

The root/chirp product counts are respectively 915527265950592, 934243384438190, 951390487004672 and 987253708058752. Kernel products equal dyadic scales because each runtime Blue node contributes exactly P of each; all other nodes preserve this identity. Setup kernel-forward transforms are not included in those runtime point products.

The unchanged setup projection is exact: 12496 top axis lengths, 32942 active full nodes, 6004 kernels, 337702368 kernel entries, 140276846 chirp entries, maximum P262144, CT root-table upper count1116142487, and the saved kernel-forward vector G2244782056/A5502647200/quarter168845180. These are setup counts, not setup values or lifetime guarantees. Root certification, cache precision, sum-cache construction, rebuild/loading policy and source conversion remain separate.

## 6. Frozen evidence and remaining use conditions

|Artifact|Bytes where applicable|SHA256|
|---|---:|---|
|`transform_structural_inventory_20261111.py`||`584A16F00A905AD68C3FE11F4128FE2205F772FB67916EF312B596518F1ADB55`|
|`transform_structural_manifest_20261111.json`|25110201|`A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637`|
|`transform_structural_events_20261111.json`|20861126|`06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B`|
|`transform_structural_inventory_20261111.json`|3719|`503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0`|

Exact upstream paths and full hashes are in the manifest and receipt. The inventory has no writer access to upstream artifacts and refuses to overwrite any owned output. The guard counts and bounds above were fixed before the run. Independent source/metadata review is requested before adopting this new manifest.

A subsequent width-sensitive price fold can consume the event histogram with an explicit common or bandwise p, V bound and ordinary arithmetic template. It must retain the intrinsic-error conditions, actual input-error contribution, setup/cache/representation costs and separate generation/proof/checking prices. It may not infer spectral success from a matched operation projection. No aggregate arithmetic saving or runtime winner is selected here.
