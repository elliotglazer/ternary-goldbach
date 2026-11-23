# Normalized character transforms with the 41-node sample guard

2026-11-11. Conditional saved-metadata and arithmetic-template result, awaiting independent review. This joins the reviewed rounded-kernel transform to the reviewed conservative positive sample guard. It selects no new precision, evaluator, sign outcome or production circuit.

Both complete predecessor histograms match exactly before the successor is written. The reconstruction uses exactly 220,108 saved contexts and at most 18 compressed radix-stage levels per node. It does not generate conductors, factors, unit residues, circuit plans, individual gates, queries, roots or function values. No build, declaration or frozen-file change occurs.

The added guard has 125,279 normalized event classes and 133 width classes. At p108, its three-real-product arithmetic core is 21,951,764,813,119,114 events. Adding this to the main normalized prefix gives 4,391,036,155,239,028,824 events. These are declared product/adder macroevents, not machine instructions or measured checking time. Source production, residue contraction, completion, interpolation and the other costs below remain separate.

## 1. Exact inputs and output identity

Paths in this note are relative to `work/qrh-campaign/agents` unless stated otherwise. The script pins twelve inputs, including the following data and their independent reviews.

|Input|SHA256|
|---|---|
|`integration/transform_structural_manifest_20261111.json`|`A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637`|
|`integration/transform_structural_events_20261111.json`|`06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B`|
|`integration/transform_structural_inventory_20261111.json`|`503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0`|
|`independent-feasibility/normalized_bluestein_events_20261111.json`|`721050210472999DB469728A0426FECDADD4D82F404C6302CA2B635F3551B7B2`|
|`independent-feasibility/normalized_bluestein_structural_costs_20261111.json`|`F91A9966E4905B187DA01583DD993257EA94591B483E148903216158672559C3`|
|`moebius/normalized_transform_precision_costs_20261111.json`|`C3AC1C06BFDCB2931FA24F8EF9AFC7E84A88FA00AF3D5500C7657CC665A219D4`|
|`integration/short_window_guard_conductor_rows_20261111.json`|`A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA`|
|`integration/short_window_guard_ledger_20261111.json`|`C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4`|

The mathematical normalization/context review is `integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md`, `09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA`. The normalized structural review is `major-constants/REVIEW_NORMALIZED_BLUESTEIN_STRUCTURAL_COST_FOLD_2026-11-11.md`, `49D7AA3C7D292C9A6018B178480BE8E0213C2A0725D6042D8EDC0A8C65F3B86C`. The p106/108/112 price review is `prime-estimates/REVIEW_NORMALIZED_TRANSFORM_LOWER_PRECISION_COSTS_2026-11-11.md`, `B2C3D637D9983156620A6940B2C32B65146FAED681DEB2CB36F7D3A2C4D7F4E8`. The guard review is `zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md`, `15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA`.

The selected normalized circuit rounds the scaled cached kernel K/P onto the runtime grid p. An exact K/P represented on grid p+log2(P) is a different representation and does not justify these smaller coefficient widths. The new cache centers, sums and output enclosures require their own bindings. This join does not transfer old successful signs to new centers.

## 2. Guard and band weights

Each saved conductor row supplies J as a sample count. For alternative e in {0,167,320,640}, the old last index is J+e-1. The conservative covered target interval is closed, from zero to `(J+e-1)*Delta`, with Delta=5/64. The floor-centered window uses indices `floor(t/Delta)-41` through `floor(t/Delta)+41`. Its positive guard is precisely the 41 indices

    J+e, ..., J+e+40.

The negative dependencies use positive inverse-character samples at indices 1 through 41, already inside every old prefix. They are not 41 new transforms. They still require the reviewed exact phase sign and attenuating exponential enclosure, with scalar arithmetic, bindings and radii charged separately. The own central sample at zero remains present.

For each saved row the new script independently intersects both prefixes with the five closed index bands ending at 6400, 12800, 25600, 64000 and 128000. Their differences must equal every entry of the saved 20-entry guard vector. It also checks the old vector, the c/J/phi/primitive identity, and all five per-height operation totals reconstructed from the saved ordered axes and request totals. There is no new factorization or height-domain inference.

Many individual guards cross band boundaries. The joint histogram therefore retains scenario-major, band-minor weights rather than putting all guard work in the final band. The shared source prefix grows only in its final band, as separately proved in the guard ledger. The maximum guard index is 84880 in the +640 alternative, giving height 26525/4, strictly below 7000. This is domain compatibility, not evidence that those sample values have been computed.

## 3. Saved-context reconstruction and width proof

For a saved conductor with ordered axes, the multiplicity of an axis request is its retained preceding-axis product times the full following-axis product. Its incoming augmented norm factor is twice the full preceding-axis product. This separates multiplicity pruning from the full-transform norm envelope. The same construction is used for the old and guard weights, concatenated into one 40-entry vector.

The 52,560 top contexts propagate through the unchanged 35,190-node saved request DAG. Every edge supplies its child request, multiplicity and exact augmented norm factor. The final count is exactly 220,108 weighted contexts, including 26,064 Bluestein contexts. The hard cap is 220,108; no automatic increase is allowed. Each radix node contributes only its at-most-18 stage classes. No object represents an individual butterfly or point product.

The script reconstructs every original event phase, not just changed phases. For Bluestein, it obtains prechirp and requested postchirp vectors algebraically from the saved full/requested counts after subtracting the two padded radix transforms, point products and original inverse divisions. Every subtraction is checked for parity and nonnegativity. This avoids regenerating any chirp or circuit plan.

For padded length P and local length n, define

    Z_old = 2*n*(n+1)+2,
    Z_new = n*(2*n-1)/P+2.

The normalized point product retains data factor `(n+2)*a` and uses coefficient exponent zero, meaning its stored coefficient center has norm below one. At one-based inverse stage j, root-data and quarter-turn factors are `2^j*Z_new*a`; addition/output factors are `2^(j+1)*Z_new*a`. Postchirp data uses `2*n*a`. The final inverse division is absent. Unchanged forward, direct, CT and radix phases keep their accepted factors. All rational factors are formed before taking the ceiling logarithm.

These factors consume the reviewed inherited common-u/local C,D and global S_old*u<=1/2 hypotheses. With V=input_sup+1<=2^14, the data magnitude width is p+14+ceil(log2 factor). Root coefficient exponent one bounds its approximate center, not center norm plus one. A data key may conservatively cover an output sum as well as an input; it is not asserted to be a minimal measured operand width. Signed storage, raw product growth and round witnesses remain separate capacities.

The script requires exact dictionary equality of all original 138,126 event keys and twenty-entry vectors, then all normalized 125,279 keys and vectors, before successor output. It also reproduces the old 133 width classes and every old band/component price at p106/108/112 in both arithmetic modes. No subtraction from an old rounded exponent is used.

## 4. Guard projections and joined prices

Every scenario has the same total 41 added samples per conductor, although band allocations differ. The original-circuit guard projection is:

|Quantity|Exact added count|
|---|---:|
|Conductor-height nodes|5,141,400|
|Residue inputs|292,453,624,512|
|Primitive outputs|177,663,120,563|
|General complex products|5,036,489,146,290|
|Complex additions/subtractions|10,433,751,669,927|
|Quarter turns|458,699,014,481|
|Negations|97,370,080|
|Original inverse scales|441,513,948,736|
|Kernel products|441,513,948,736|
|Root products|4,594,975,197,554|

All five categories are checked in every band and alternative against the guard ledger. Normalization preserves root, kernel, addition, quarter-turn and negation counts and removes the runtime scales. In particular, kernel counts remain positive; the old kernel-count-equals-scale-count identity is not asserted for the normalized circuit.

The unchanged ordinary-arithmetic template uses

    A(w)=2*ceil(w/8)+1,
    M(a,b)=5*ceil(a/8)*ceil(b/8)+2*min(ceil(a/8),ceil(b/8))+1.

For data magnitude width a and coefficient magnitude width b, the three-product circuit pays `M(a+1,b)+2M(a,b+1)`, data presum A(a+1), two raw-output additions at width a+b+2 and four round-witness additions at width a+b+4. The four-product circuit pays 4M(a,b), two output additions at a+b+1 and four witness additions at a+b+3. Standalone complex addition costs 2A(a+1). Cached coefficient sums are setup. Sign, range, encoding, shifts and ordinary inference expansion are not free merely because they are outside this product/adder core.

|p|Mode|Guard product core|Guard addition core|Guard total core|
|---:|---|---:|---:|---:|
|106|three|18,781,247,741,834,270|2,840,782,699,248,172|21,622,030,441,082,442|
|106|four|24,976,713,848,504,040|2,652,731,831,448,554|27,629,445,679,952,594|
|108|three|19,066,857,553,807,630|2,884,907,259,311,484|21,951,764,813,119,114|
|108|four|25,361,371,018,510,520|2,693,402,782,268,066|28,054,773,800,778,586|
|112|three|20,903,432,242,087,748|2,971,606,280,520,064|23,875,038,522,607,812|
|112|four|27,697,438,936,167,312|2,775,497,705,347,690|30,472,936,641,515,002|

At fixed p these guard totals agree across alternatives because the circuit and conservative width factors depend on conductor/context, not sample height. The twenty band components remain distinct in the receipt. The joined three-product totals are:

|p|Main + guard|+167 + guard|+320 + guard|+640 + guard|
|---:|---:|---:|---:|---:|
|106|4,324,244,909,162,139,872|4,412,315,130,714,841,526|4,493,002,219,921,807,712|4,661,759,530,681,475,552|
|108|4,391,036,155,239,028,824|4,480,449,441,185,148,142|4,562,367,002,560,934,104|4,733,697,849,882,839,384|
|112|4,776,701,691,018,351,726|4,873,948,799,147,022,570|4,963,043,455,097,241,966|5,149,385,219,176,132,206|

All four-product joined totals and every product/addition component are retained in the receipt. The alternatives are separate schedules, not cumulative charges or guaranteed auxiliary-count successes. p106 remains a conditional arithmetic case; this note does not use its lower price to select a complete error budget. At any p, actual input/source uncertainty and full sign/completeness conditions must still be supplied.

## 5. Setup and other work remain charged

Guard extension uses the same ordered axes, requests and kernel dimensions, so it adds no new dimension-dependent transform setup. The script checks identical setup objects across the saved manifest and both normalized price receipts. This does not make setup zero. There remain 6,004 kernel lengths with 337,702,368 entries, the original kernel FFT/root/chirp construction and the newly rounded scaled-cache bindings.

The additional normalized-cache round-plus-sum arithmetic cores per cache lifetime are 64,151,100,736 at p106, 64,162,618,688 at p108 and 68,056,004,800 at p112 for three-product use. Four-product use omits the sum cache and pays respectively 44,564,363,392, 44,575,881,344 and 47,118,457,984. The inherited setup histogram is checked again. Precision changes, discarded caches, imports and repeated checking can incur new lifetimes; this result grants sharing only when the exact same cache is retained and bound.

The complete guard ledger C04F477A remains authoritative for source work. In each scenario its shared source prefix adds 41 final-band heights, 4,703,356 source coefficients, 6,803,068,500 head scales, 7,055,034,000 head additions, 57,784,088 contracting stages, 747,833,604 Bernoulli terms and the same number of additions, 176,332,800 translation updates, and 13,435,700 delivered fine coefficients with their final scales/rounds. Its 252,071,977 fine-state updates/conversions and all remaining source terms are not absorbed into the transform core.

The full P20 guard baseline keeps 5,556,618,865,728 Horner stages before their width-sensitive pricing. The main-prefix shorter-K or grid selection is not silently extended to the new maximum. A separately frozen/reviewed guard-domain evaluator can later replace this baseline without repeating the transform fold. The preliminary K18/b94 extension is not an input here.

There are separately 177,663,120,563 optional full-superset negative sample transports, their 41 attenuation constants and inverse-label/phase bindings. Positive Y completion is also separately charged. Each actual off-grid query uses its own 83-term kernel/arithmetic schedule and complete radius. Neither actual query counts nor actual sign margins are supplied by these histograms. Existing auxiliary/Turing samples are not credited as free guards for another alternative.

For generation, proof production and checking, use separate prices on the recorded product and addition cores plus all remaining terms. This note gives an exact added component under declared conservative templates. It does not prove a total runtime ordering from those upper allocations.

## 6. Frozen evidence

- Script `integration/normalized_transform_short_guard_join_20261111.py`, SHA256 `2C7D865CFFEA56D693F3DA70E063EFBF1CD50F237594766E9C4229D83FFFBE7A`.
- Guard event histogram `integration/normalized_transform_short_guard_events_20261111.json`, SHA256 `F26896C955B06006AEBA260FB6605EDE21DDD3EA9CED984E0DD46BADAA855897`, 14,254,909 bytes.
- Receipt `integration/normalized_transform_short_guard_join_20261111.json`, SHA256 `4F6F20570E0E1F35C806E173E2FA13B95CCD084B177F38F359E3F3171F5EB66A`, 159,195 bytes.

The run passed 5,398,439 exact assertions, including the final output cap. The receipt records 5,398,438 before that last assertion. Its summary is below 1 MiB; both data outputs total 14,414,104 bytes, and all new artifacts together are below the approved 64 MiB cap. The program opens only new output paths for exclusive creation. It neither imports nor executes any predecessor writer.

The present claim is the saved-context and arithmetic-template join. Independent review, actual arithmetic certificates, complete sample enclosures and spectral acceptance remain distinct obligations.
