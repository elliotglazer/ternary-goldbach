# Width-resolved spectral workload ledger

This is a count and representation audit for the conditional spectral certificate design behind `work/qrh-blueprint/estimates-20261111/SPECTRAL_COST_ESTIMATE.md`. It supplies inputs for a new forecast; it does not estimate time, certify the spectral values, or select a backend. The counts below are conditional on the saved schedules and their producer contracts. A fixed auxiliary extension is not evidence that the resulting sign/count certificates succeed.

The companion `WIDTH_RESOLVED_LEDGER.json` contains all four scenarios, exact source-file hashes and byte sizes, the five full-20 Horner profiles with their stage widths, and the selected setup records. It was extracted from five saved receipts: summary sums over their existing precision/band fields, ranges over 2,099 saved width classes, and 41 additional final-band source nodes. No conductor inventory, factorization, planner, numerical values or builds were regenerated. The companion is 116,237 bytes, SHA256 `9FF298322516D178D4401DA23C779EEDD6F9E387934EF55BEEB037C250D0459B`.

## Units and selected scope

Use semantic gates when transferring an arithmetic benchmark. A butterfly, a complex product, a real product, an integer scale, a rounded quotient witness and an elementary-function enclosure are different workloads. The campaign's `product_core`, `addition_core`, P and A are **byte-template prices**, not counts of products, proof commands or kernel operations:

\[
A(w)=2\lceil w/8\rceil+1,\qquad
M(a,b)=5mn+2\min(m,n)+1,
\]

where \(m=\lceil a/8\rceil,n=\lceil b/8\rceil\). In particular, neither P/5000 nor one time per butterfly can price every row below. The recorded P/A subtotals also do not supply all signed bridges, source proofs, cache bindings, serialization and library costs.

The matched large schedule retains full P20 source delivery and full K20/b94 residue evaluation, the reviewed combined precision assignment using the old 8,828 error magnitude and 16,384 width magnitude, rounded normalized Bluestein caches, and the additional 41 guard nodes. The four extra-node scenarios are 0, 167, 320 and 640; each table column below includes its own +41 guard. The small schedule is the selected minimal-theta sign-only route with theta in 64..128 and the retained N128-length family. It is not the sum of fixed theta64 and theta128 alternatives.

The later reviewed mean186 assignment has p74..99, 49,750 full node/precision states and 9,052 kernel keys with 369,417,568 entries. It does not come with the matched runtime-factor/width price fold needed to replace the selected ledger. Precision drops and cache counts alone do not determine a time ratio. Its runtime magnitude692 also cannot be substituted by subtracting bits from old ceiling keys. Keep it as a separate potential successor.

## Large transform: semantic gates and widths

Source receipts, relative to `work/qrh-campaign/agents/`:

- `moebius/combined_precision_price_widths_20261111.json`, SHA `51844D5768117F3AA21E9FC8C84FD918D92008E9C51DB41AE742B565FF6F4A2B`.
- `moebius/combined_precision_prices_20261111.json`, SHA `17930450145D8507AE4883D923C76E9F3A0FE3C6ABAD28F4BD700AB5ABFCDA7F`.
- Author `moebius/COMBINED_CONDUCTOR_PRECISION_PRICES_2026-11-11.md`, SHA `C5A2B6B7A7E7688C566D62495A2FD99D68604B9FB8B1C8CC1BD10AC58D0AD41C`; independent review `3C01C900EB797A1A13EDE16E0BEF3BECC27EDD40F3BFED161FEA4345519148E4`.

| Semantic occurrences | Main+41 | +167+41 | +320+41 | +640+41 |
|---|---:|---:|---:|---:|
| Root complex products | 920,122,241,148,146 | 938,838,359,635,744 | 955,985,462,202,226 | 991,848,683,256,306 |
| Kernel complex products | 89,017,934,196,032 | 90,816,295,889,664 | 92,463,896,722,752 | 95,909,859,249,472 |
| Standalone complex add/sub | 2,090,319,798,067,922 | 2,132,818,249,991,771 | 2,171,753,957,442,962 | 2,253,188,116,818,002 |
| Quarter turns | 92,576,511,158,537 | 94,444,870,558,984 | 96,156,601,027,657 | 99,736,690,896,777 |
| Negations | 19,970,124,208 | 20,366,729,168 | 20,730,085,808 | 21,490,047,408 |
| Runtime inverse dyadic scales | 0 | 0 | 0 | 0 |
| Complex residue inputs \(N_R\) | 60,254,515,577,760 | 61,445,729,121,504 | 62,537,080,452,000 | 64,819,645,326,240 |
| Conductor-height cache entries \(N_C\) | 1,528,006,797 | 1,548,948,597 | 1,568,134,797 | 1,608,262,797 |
| Primitive outputs | 36,468,561,640,066 | 37,192,213,862,847 | 37,855,200,629,826 | 39,241,839,619,586 |

The main complex product total is 1,009,140,175,344,178. These are product occurrences in the pruned mixed circuit, not all radix-two butterflies. A fixed-coefficient three-real-product implementation adds three real products, one data pre-add, two output add/subs and two coordinate-round witnesses per complex product. Coefficient pre-sums belong to cache setup. A four-product implementation instead has four real products and two output add/subs. Do not add those internal additions twice when transferring a complete complex-product benchmark. Each standalone complex add/sub contributes two real additions. Quarter turns and negations avoid a general product but still require exact sign/permutation/binding work.

For the main scenario the saved classes give the following capacities. Here a,b are the **unsigned magnitude capacities used in the natural-number template**, not fractional precision and not complete signed-object sizes.

| Category | Classes | Fractional p | Data a | Coefficient b | Three-product raw sum a+b+2 |
|---|---:|---:|---:|---:|---:|
| Root | 589 | 80..105 | 99..154 | 81..106 | 182..262 |
| Kernel | 184 | 87..105 | 107..137 | 87..105 | 196..244 |
| Standalone add | 607 | 80..105 | 97..155 | — | — |
| Quarter turn | 571 | 80..105 | 98..154 | — | — |
| Negation | 148 | 91..104 | 108..136 | — | — |

The exact per-class formulas are a=p+14+data_exponent and b=p+coefficient_exponent. Root coefficient exponent is1; normalized-kernel exponent is0. The three real products use capacities (a+1,b), (a,b+1), (a,b+1). The declared conservative standalone addition uses a+1; product post-sums use a+b+2 and round-witness adders a+b+4. Sign representations and proof headers remain additional. The 2,099-class receipt supports a width-weighted transfer without a new campaign inventory. The overall main three-product byte prices, P=3,076,486,625,497,782,230 and A=519,549,455,680,901,010, are cross-checks only, not semantic workload counts.

Cold normalized setup is separate: 8,467 kernel/precision keys, 363,202,368 complex cache entries/rounds, 150,746,135 chirp entries, and 726,404,736 exact real coefficient pre-sums for the three-product formula. Kernel construction contains 2,388,169,382 complex products, 5,865,912,000 complex add/subs and 181,592,717 quarter turns. Price the selected setup receipt, not this plus the older unnormalized setup. Setup enclosures, roots, table/import bindings and their actual construction precision are not established merely by the runtime p range. A cold run and reuse of an already checked cache are different scenarios.

The selected input adapter regrids 54,067,011,555,562 main complex inputs at p<100; 1,954,722,891,838 are p100 identities and 4,232,781,130,360 are exact p>100 embeddings. Each regrid has two coordinate quotient/remainder witnesses and four signed witness adders, with power-of-two shifts rather than general products. The retained conservative capacities are signed source115, destination p+15, raw adder116 and at most20 discarded bits. A later narrowed converter is not adopted here. The companion gives scenario totals; source/export binding is still required even for exact embedding.

## Residue evaluation and raw head are different producers

The saved `integration/guarded_residue_evaluation_frontier_20261111.json` binds the full20 profile in each band. Its five exact stage records are copied into the companion, including the distinction between arithmetic products and byte prices. Author SHA `C24D4CB1338EDDFD46398C5B6D2BB1CA80CA61500B648B1A41039BFEECB6CA8D`; review `31FEFFBA372D36CB37854EC628EC17D257A9B7CAD51BB761E962DFF1D6FF19ED`.

Per complex residue output, full20 uses19 complex Horner stages with a real displacement. Its declared proof schedule has76 natural product instances,152 natural addition instances,76 signed product bridges,114 signed add bridges and38 nearest-range implications. The76 products include the rounding witness products: they are not76 analytic polynomial multiplications. There are38 residual doublings,14 nonzero coordinate alignment shifts totaling58 shifted bits, two top-coordinate copies,40 coefficient-coordinate lookups, and two exact grid94-to100 exports of six bits. Multiply these counts by the corresponding \(N_R\), not by primitive outputs.

The coefficient grids are [94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65]. In the first four bands the input-state magnitude Mbits ranges17..98 and quotient Lbits15..96; final-band ranges are8..97 and6..95. The actual narrow product pairs are18×Mbits and20×Lbits, two of each per complex stage. The first-four signed raw products range35..116 bits and doubled residuals37..118; final-band ranges26..115 and28..117. The signed output is108 bits before, and114 after, exact grid100 export. The stage-specific record is preferable to these coarse ranges. Do not carry the predecessor's grid108 embedding into a local-p schedule automatically.

Shared direct conversion from original source centers costs28,734,393,000 coordinate conversions in the main+41 schedule (28,843,844,800 /28,944,121,000 /29,153,849,000 in the other scenarios). These are per selected height/anchor array, not per residue. Their original input widths and cache lifetimes must be retained; a small converted coefficient does not prove a small source conversion operand. Shorter K18/K19 alternatives are separate admissions and are not silently substituted into the full20 ledger.

The raw head is the separate grid100 assembly in `integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`, author `FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE`, review `076A108101A9AC75BF481E9D7E1005E1351ABD2E3DB6221937A8D685F2FFE0BB`. It is not the EM seed's internal head sum.

| Raw-head component | Semantic count | Stored/raw capacities |
|---|---|---|
| Shared B_x height updates | conservative265800×89600=23,815,680,000 complex updates | B grid120 signed122; step grid122 signed124; four real products with magnitude121×123, raw signed245, combination246, round-witness247 |
| Per conductor-height cached scale | \(N_C\) complex real-integer scales | two121×19 magnitude products; raw signed141; accepted cache grid120 signed131 |
| Raw head at each residue | \(N_R\) complex products | four130×121 magnitude real products; raw grid240 signed252, combination253, round-witness254; two post-adds and two coordinate rounds/four witness adders |
| Head plus polynomial assembly | \(N_R\) complex adds | two real adds; head grid100 signed111 and assembled signed115 |

The old candidate \(N_R(5572P+448A)\) is a byte-price expression for the last two rows, not5,572 real products per head. Its semantic replacement is explicit above. The conductor-height cache count is now available; do not replace it with the much larger old generic upper bound unless intentionally modeling that wasteful schedule.

Raw-head setup retains265,800 log certificates (chosen45-term schedule:48 real products,48 adds, one rational division and45 affine rounds each),265,800 inverse-root witnesses at grid98, and265,800 small-phase cis certificates (73 terms,72 affine updates, final grid122 round; inner131/log-inner137). Argument reduction, rational division checks, range bounds and shared constants are additional typed tasks. The receipts do not give a complete operand-width-weighted cost for all those elementary proofs. Sharing with EM argument grids requires an exact identity, enclosure precision and lifetime join; numerical similarity alone earns no discount.

## Shared EM source and recurrences

Use `major-constants/reconciled_nonprincipal_schedule_20261111.json` and author `483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716`, review `712090B83A3C31F58C2642B329B8122661F9AB4D675F0665342D69FAD47E562D`. Its old transform counts are superseded by the normalized schedule above. Its source counts remain usable. The companion adds41 nodes using the exact saved final-band counts divided by their height multiplicity; setup counts are not incremented.

The five source bands are (V,Dsource,N,P,m)=(500,512,220,27,64), (1000,1024,387,27,64), (2000,2048,720,27,64), (5000,4096,1720,27,64), (7000,4096,1500,28,159). The final output scale is Dout8192; first-four endpoint delivery is20 coefficients. Full source generation remains even when a downstream evaluator chooses fewer coefficients.

| Main+41 source category | Count | Semantic meaning |
|---|---:|---|
| Source coefficient slots | 7,543,088,084 | complete endpoint/EM coefficient constructions, not one gate each |
| Head reciprocal scales | 10,969,166,595,220 | real-times-complex scales |
| Head accumulator additions | 11,386,294,892,080 | complex additions |
| E contracting stages | 58,114,704,402 | complex multiply/round stages |
| Bernoulli weighted terms | 703,333,562,176 | real-times-complex scales, plus the same count of complex accumulator adds |
| Source translation updates | 150,847,656,960 | dyadic/rational multiply-add updates |
| Fine state complex updates | 417,288,057,616 | shared complex recurrence multiply/rounds |
| State-to-EM copies/conversions | 417,295,106,833 | grid conversions, not products |
| Shared height R steps | 2,210,506 | per-height recurrence, not per anchor |
| Final coefficient scales and rounds | 6,632,648,000 each | power-of-two postscale and coordinate-object rounding roles |
| P20 fine-anchor coefficient deliveries | 14,367,196,500 | delivery slots, not an additional independent source evaluation |

Fine recurrence uses grid140; copies to EM use122; translation/delivery rounds use110. The final source bounds include stored coefficient norm<27043<2^16; this supports a roughly127-bit signed grid110 coordinate but does not bound every rational intermediate. E center<2, correction sum<14 and loose R<5 give useful stored bounds; pole terms, reciprocal scales, Bernoulli rational numerators, coefficient recurrences and division witnesses still need their own raw-width contracts. It is invalid to price all these slots as one p100 complex butterfly.

Setup has7,049,217 distinct arguments,6,148,097 final active arguments,901,120 retired and zero introduced at the last transition. Initial B, step cis and step-grid counts are each7,049,217, not three independent argument unions and not per-height work. There are960 log anchors and148,013,397 degree21 nonanchor log stages;159 Bernoulli constants through index318. Source log enclosure is2^-144, initial B2^-120, step/update2^-140 and EM copy2^-122. Full endpoint source precision and error proofs remain required. A model needs separate prices for these elementary enclosures and rational correction work; no complete semantic operation/width expansion for them is supplied by the coefficient-slot total.

## Small family: do not price only its butterflies

Source `prime-estimates/sign_only_minimal_theta_nonprincipal_schedule_20261111.json`, SHA `E767EC3B3E14F2A243837DA85C811DE5ED67CE701BDD08998C2329F9C687C24D`; author `C1D2C360A296C961BD2FA46576521FEDB1AFE01527610DF1D21CC145E5565918`, review `1D8FBDA28124B7FEE3CCDF500311809265463ECE38056ACD9E8F2F4053861300`. The companion copies all selected totals and bit ranges for each scenario. Main values follow.

| Small category | Main semantic count |
|---|---:|
| Conductors / primitive labels | 7,499 /18,477,108 |
| Conductor grid nodes / primitive grid outputs | 3,791,945,802 /1,775,431,871,117 |
| Main character butterflies | 128,941,391,789,290 |
| Main character point products | 25,399,177,848,072 |
| Main character inverse dyadic scales | 15,046,227,780,352 |
| Time butterflies | 89,858,217,607,168 |
| Time complex outputs | 9,237,783,904,256 |
| Gaussian terms / unit gates (upper counts) | 4,271,014,086,121 /8,542,028,172,242 |
| Bucket additions / odd integer scales (upper counts) | 7,969,016,316,193 /4,156,411,711,634 |
| Prefactor contraction complex products | 1,202,865,170,991 |
| Radial/prefactor real products | 2,421,291,652,611 |
| Outer complex exp / seed unit contractions (upper counts, each) | 2,605,203,866 |
| Cutoff rational divisions | 2,605,203,866 |
| Real exp seed certificates | 7,499 |
| Gauss character butterflies / point products / inverse scales | 1,005,598,874 /191,293,204 /113,309,696 |
| Bluestein kernel builds / butterflies / entries | 11,067 /163,605,472 /24,654,496 |
| Time root cis upper count | 10,003,939,328 |
| Additive root cis / character root cis upper count | 25,330,722 /41,412,194 |
| Eighth root cis upper count / tilt cis | 59,992 /22,494 |
| Conductor positive roots | 14,998 |
| Phase positive roots / divisions / K products (each) | 18,477,108 |
| Eighth-root undo products upper count | 18,477,108 |
| Fixed setup arithmetic upper count | 221,845,280 |
| Frequency conjugate copies / zero-imaginary projections | 1,202,846,693,883 /18,477,108 |

A saved radix butterfly has one fixed-twiddle complex product and two complex add/subs. Bluestein point products and inverse scales above are separate. A Gaussian unit gate has its own product, two rounding roles and a shrink bound; it is not merely a bare complex product. Bucket additions are rounded; odd integer scales are not general complex multiplies. The sign-only route removes omega scalings, positive-scale updates and final Y products: all three counts are zero here. Do not re-add them from an older normalized-output ledger.

| Selected small category | Required fractional bits |
|---|---:|
| Seed | 302..404 |
| Sigma | 382..484 |
| Radial | 417..523 |
| Setup | 422..527 |
| Character transform | 279..411 |
| Gauss setup | 402..534 |
| Raw sign time transform | 241..343 |

These are fractional bits, not complete operand widths. Raw time samples additionally have magnitude exponent54..69: the conservative maximum signed real capacity is343+69+1=413 bits. The per-row `raw_metadata` carries (c, grid count, N, time bits, w), so an exact paired time-width calculation is possible without a new conductor inventory. A root product involves data and root widths plus raw output/rounding capacities; it is not a343-bit scalar multiplication. Other small categories still need matched magnitude/intermediate bounds. In particular, it would be incorrect to treat the largest ancillary precision as415 or to apply the large branch's100-bit arithmetic rate unchanged.

The retained time lengths range2^18..2^30. Dense arrays are full transform arrays, not merely requested sign prefixes. Per-conductor root production and a proved global shared root cache are alternative schedules; do not add both or assume cross-branch sharing. Theta's outer exponentials include argument reduction and high-precision constants; one arbitrary elementary-function microprice is an explicit forecast assumption, not a measured transfer.

## Completion, interpolation, count closure and principal work

These remain required and cannot be inferred from the main transform totals.

| Required category | Best available count/width interface | What remains assumed |
|---|---|---|
| Large output phase/completion | Up to the primitive-output occurrences above; source requires completion multiplier error2^-66, formation error2^-54; multiplier center<28, transform center<2^21, completed sample center<2^17 | Actual cached phases, Gamma/elementary enclosure production, head/scale conversion formats and per-output proof costs |
| Negative-height sample adapter | Full guard superset177,663,120,563 positive inverse-channel partner applications; damping radius2^-72, final real-product round2^-55 | Which are produced/reused; inverse-character channels are not deleted |
| Large local repair query |83 real products,82 real adds and one serialization round; kernels radius2^-72, samples radius2^-51, each arithmetic round at most2^-59; product magnitude<2^18, sum<2^20 | Actual query count, output fixed-grid format, raw witnesses, successful signs |
| Large dyadic kernel cache | For all offsets through depth R,42(2^R−1) noninteger distance keys;21·2^R new keys at level R; integer-offset cases exact | Actual queried offsets, precision lifetimes and setup reuse. Gaussian/sinc enclosure and recurrence proof costs remain explicit |
| Small off-grid queries | Variable local stencil lengths182..260; half-polyphase is an alternative full-class schedule | Actual query set and local/dense switching, normalization/source-grid padding, dense retained outputs and cache lifetimes |
| Nonprincipal completeness |4,333,246,843 large labels plus18,477,108 small labels; interval/count ledger and critical-line support/multiplicity evidence | Actual located intervals, central/boundary handling, Turing surplus, further repairs and additional guards |
| Principal RH through1e8 | An illustrative250,000,001-sample plan with at most4,095 Riemann–Siegel terms each gives1,023,750,004,095 terms | This is not an accepted complete sign schedule or a width profile. Phase/term generation, remainder proof, repair and count closure need independent allowances |
| Formal and proof infrastructure | Ordinary arithmetic/range templates; source-to-transform bridges; analytic libraries; checked import/export and serialization | No measured full project build or complete proof-size/runtime model; explicit nonzero reserves required |

Large interpolation sources are `audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md` (6F856467...) and its reviewed shorter-window/kernel companions. The +41 guard is compatible with the admitted height cap; it is not a sign-success theorem. Small interpolation's illustrative all-seven-class workload contains315,177,493,507,002 complex half-polyphase products versus2,439,308,097,734,074 local real products. Those are different units and optional query workloads, not an automatic saving or mandatory full-dense forecast. The old average220 local terms is a Fermi assumption.

The original finite-RH comparator has no separate mandatory principal N1500/Q1500 reciprocal-head obligation. Do not add that to the principal1e8 completeness task or confuse seed truncation N1500 with principal zero-head data. Shared generic arithmetic/analytic library reserves belong once to the spectral model; the finite model may separately own finite-only decoders and assembly.

## How to use this ledger in a forecast

1. Price large root/kernel products by the saved joint width classes; add standalone adds, exact permutations and setup separately. A complete dependent butterfly calibration includes operations that a bare complex-product row does not.
2. Price Horner's narrow-by-wide arithmetic and quotient witnesses from its actual stage record. Do not price it as an equal-width complex transform product.
3. Price raw heads, recurrent source updates, rational EM work and elementary enclosures separately. Their counts are not interchangeable and their source pools overlap only when a proved cache identity says so.
4. Give the small branch its own high-precision prices, retaining point products, inverse scales, prefactors, Gaussian gates and elementary setup. State which missing magnitude/raw-width details are covered by judgment factors.
5. Keep completion, successful repair/count closure, principal work, proof generation/import/export and libraries as visible nonzero assumptions. A count upper bound, an unpriced source slot and an observed arithmetic benchmark are different evidence.

A provisional low/central/high forecast is useful if these transfers and reserves are stated. It is an estimate for this explicit certificate architecture, not a lower bound on proving Goldbach or a prediction for an optimized implementation. None of the count extraction validates a universal throughput, a required second acceptance pass, successful sign margins, or a method winner.
