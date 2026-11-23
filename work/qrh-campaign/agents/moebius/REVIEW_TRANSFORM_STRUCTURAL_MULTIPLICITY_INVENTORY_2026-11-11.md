# Review of the current transform structural inventory

2026-11-11. PASS at the stated source/structural-metadata scope, with no correction requested. The serialized circuit, original axis order, primitive-output pruning, height bands and local norm envelopes support the exported histogram. No precision, arithmetic circuit implementation, sign success, spectral result or runtime claim follows from this verdict.

The review read the author source and note, the pinned original pruning and combined-height sources, the intermediate-width proof and the saved-multiplicity evidence map. The independent companion reads frozen JSON, reconstructs bounded integer metadata and writes only its own receipt. It imports no author generator, enumerates no unit residues or individual gates, and evaluates no root, character, transform, source coefficient, L-function or zero. No builds or declarations were made. The separate MMB arithmetic-expansion report is not an implementation prerequisite silently supplied by this review.

## 1. Exact reviewed packet

All author paths below are under `work/qrh-campaign/agents/integration/`.

|Artifact|SHA256|
|---|---|
|TRANSFORM_STRUCTURAL_MULTIPLICITY_INVENTORY_2026-11-11.md|01F1446FF10D2EFD690DF06552F35DAD26C1453A49F4BB4F84D794D997FD55BB|
|transform_structural_inventory_20261111.py|584A16F00A905AD68C3FE11F4128FE2205F772FB67916EF312B596518F1ADB55|
|transform_structural_manifest_20261111.json|A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637|
|transform_structural_events_20261111.json|06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B|
|transform_structural_inventory_20261111.json|503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0|

The independent script `moebius/review_transform_structure_20261111.py` has SHA256 `3961E6ACC77755549CBDA923A2EFD29091A9063AA839CD9BC53E0E4631975D6D`; its receipt `review_transform_structure_20261111.json` has SHA256 `E2CE7B37F5BA8A073DD07DD729FC97C1F5B4C3779C85C7EE84803CF0C6518295`. It passes 2,617,127 checks and retains all five author pins and ten upstream pins. No frozen bytes changed.

## 2. Circuit and conductor reconstruction

The full-plan canonical hash is exactly `fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b`. It agrees with the accepted precision receipt. The review checks all 37,117 serialized plan nodes, all selected split children and vectors, every radix/direct/Bluestein leaf vector, and the canonical dictionary binding. Rejected CT alternatives need not occur in the active dictionary: identity with the original selected plan is supplied by that canonical hash and the pinned selection source, not a claim that this review optimized the choices again.

The 35,190 request rows are unique `(n,q)` keys. Each child has smaller `n`, and every referenced child is present. The review independently reconstructs their local vectors, restrictions, multiplicities and norm factors. Full requests, `q=n` requests and `q<n` requests have distinct branches. In particular, `q=n` keeps all first transforms and the full bridge, followed by `m-1` full second transforms and one pruned second transform. A Bluestein request always keeps both full padded transforms, every padded point product and every inverse scale; only the final chirp output set is reduced. Direct-prime and pruned-length-two cases match the actual source branches.

Cheap chirps are classified by the exact divisibility condition `n | 2j^2`. If `d` is the least positive divisor-step satisfying that condition, the multiples `j=d*t` have only two parity classes modulo four. Restricted requests subtract the multiples of `lcm(d,q)`. Cross bridges count divisor pairs of `hn/4`, `h=1,2,3`, with the exact row/column and output-restriction inequalities. This validates the compressed counts without evaluating coefficients or looping over residues.

The manifest contains exactly the 125,400 conductors `c>10000` with either odd `c<=132900` or `4|c<=265800`. Independent factor metadata gives both phi(c) and the primitive-character count. The latter is the product of `p-2` for exponent one and `(p-1)^2*p^(e-2)` for higher prime powers. The ordered axes agree with the source factor order. For `2^e`, exponent two gives `(2,2)`; exponent at least three gives `(2,0),(2^(e-2),2)`. No `v2(c)=1` family or principal label is inserted.

The per-axis invocation count is the retained preceding-output product times the full following-axis product. It is not the full tensor multiplicity after earlier pruning. All 125,400 exact height formulas, endpoint counts and primitive/unit output counts were checked. The slope uses `D=1063200/qt`, with `qt=2c` for odd c and `qt=c` for even c. Thus the even slope is not silently halved. The current plus height dominates the reviewed base and star maxima at each saved conductor.

For each extra-node scenario 0, 167, 320 and 640, bands partition the closed grid index prefix `0,...,J+extra-1` at 6400,12800,25600,64000,128000. This is checked by direct interval-length formulas. All twenty phi-weighted band totals agree with the saved occupancy receipt. The fifth band label remains 10000 as in this structural source schedule; it is not an assertion that every conductor reaches that height or that new analytic data there have been admitted.

## 3. Norm propagation is a conditional upper bound

The inherited width proof is independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md, SHA256 `5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A`. Its assumptions include the accepted common-u safety conditions, the summed error bound and a bound on the stored input centers. Write `V=B+1` and incoming augmented bound `|z|+1<=aV`.

The top-level magnitude factor is twice the product of preceding FULL axis lengths. It must not use the retained-output product used for operation counts. The code uses these separately. Recursive CT first children receive `aV`; the first child's semantic output and the next approximate twiddle give at most `2m*aV` to the second children. The bridge uses this conservative bound too. A pruned request is a dependency-closed part of the same circuit, so the full child's semantic error bound remains valid; no new reduced error constant is assumed.

For radix stage j in length `P=2^k`, the recurrence gives an augmented pre-stage bound `(2+u)^(j-1)aV`. Its rounded root product fits `2^j*aV`: under `2ku<=1`,

    (1+u)(1+u/2)^(j-1)
      <= (1+u/2)^(j+1) <= (1+u/2)^(2k) <= 2.

The last estimate follows from the finite binomial sum bounded by `1/(1-ku)<=2`. The stage output fits `2^(j+1)*aV`. The histogram deliberately assigns that output bound to addition events, so it also covers the two inputs and their sum. Its data field is not always the sharp literal input norm of an individual gate.

For Bluestein, the pre-chirp and forward input factors 2, point-data factor `n+2`, inverse factor `Z=2n(n+1)+2`, inverse-division factor `2PZ`, and post-chirp factor `4Z+4` follow the accepted peak proof. The kernel center norm is at most `2n`; it is not a unit coefficient. The kernel exponent `ceil(log2(2n+1))` and root exponent 1 bound coefficient CENTER magnitudes. In particular, the root exponent 1 does not claim that root center norm plus one is below 2. Data bounds are augmented; coefficient bounds are not. The author's final wording supports this distinction.

Direct leaves use `2n*aV` for their products and partial sums; the isolated pruned-two addition uses `4aV`. All these are deliberately sufficient, not minimum widths. The histogram is usable only with a proved input bound and precision/error admission satisfying the inherited assumptions. Exact product presums, signed temporaries, rounding, cheap-operation representations and output binding remain separate arithmetic obligations.

## 4. Complete histogram fold and setup

The review independently rebuilds 52,560 top contexts from the retained conductor rows, propagates all 220,108 compressed contexts, and reconstructs all 138,126 event classes. Every seven-component key and every twenty-component weight vector agrees exactly with the saved event file. This checks the local-length, stage, data-envelope exponent, coefficient exponent and inverse-division exponent together, rather than accepting matching marginal totals alone.

The resulting projections match the source totals in all five operation categories and all four scenarios:

|Extra nodes|General complex products|Complex add/sub|Quarter turns|Negations|Dyadic scales|
|---:|---:|---:|---:|---:|---:|
|0|1004103686197888|2079886046397995|92117812144056|19872754128|88576420247296|
|167|1024618166379118|2122384498321844|93986171544503|20269359088|90374781940928|
|320|1043412869778688|2161320205773035|95697902013176|20632715728|92022382774016|
|640|1082722053359488|2242754365148075|99277991882296|21392677328|95468345300736|

The exact root/kernel split is also checked. Kernel products equal dyadic scales because the full padded convolution retains P of each; no other node contributes either category. Root/chirp products are the difference from general products. This identity is specific to this circuit and does not make setup roots or kernels free.

The separate setup fold agrees exactly: 12,496 top axis lengths, 32,942 active full nodes, 6,004 kernel lengths, 337,702,368 padded kernel entries, 140,276,846 chirp entries, maximum padded length 262144, CT root-table upper count 1,116,142,487, and kernel-forward vector `(2244782056,5502647200,168845180,0,0)`. It traverses the full selected cache dependencies, not the runtime pruned event weights. Actual cache lifetime, rebuild count, coefficient generation and proof admission remain unpriced.

## 5. Limits of acceptance

This review accepts a source-bound structural inventory and conservative envelope keys. It does not accept any new bit precision, coordinate-rounding implementation, theorem-level arithmetic template, input numerical data, sign margin, contour or Turing success. The four scenarios remain alternatives. No function values, original author script execution or per-gate records were needed for the review.

A later cost fold may use the histogram for a common or bandwise precision after proving the required input/error assumptions. A conductor-specific rule needs enough correlation from the manifest rather than an unproved reconstruction from the aggregated histogram. The omitted setup/cache, proof serialization, source conversions, transport and full analytic foundations remain in the end-to-end comparison. The new integer counts alone establish neither runtime dominance nor a completed formal proof.
