# Whole-family candidate ledger for pruned rounded differences

2026-11-11. Exact fold of accepted, frozen length histograms only. No conductor, unit, prime, coefficient, function, zero or transform scan or evaluation was run. No builds, declarations, source edits or frozen changes. This is a candidate arithmetic ledger, not an adopted replacement or saving estimate.

The existing histogram is sufficient for exact initialization, initial-conversion and pruned-addition counts in every band and all four alternatives. It is already height-weighted. It is not sufficient to assign final unit conversions to exact lengths or precisions: it records unit totals by cohort, but not unit outputs by bucket length. That limitation remains explicit below.

## 1. Exact input and fold

Consume `prime-estimates/large_residue_bucket_occupancy_20261111.json`, SHA `19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB`, with its author99B76FC9 and independent reviewC6096D0C. Consume the new all-cell theorem52136903 and independent review365EA347. Full pins are listed at the end.

Each scenario e in{0,167,320,640} has five bands and separate odd/even conductor cohorts. Its saved histogram H(L) counts bucket-height instances of length L. Multiply H(L) only by the per-length circuit recipe; do not multiply by heights again. The alternatives are separate complete schedules, not four workloads to add together. The fine output grids remain F1024,2048,4096,8192,16384. The final sourceD4096 is not substituted for final Dout8192.

The source retains some L0 empty endpoint slots. They have no state, precision, initialization or output and are excluded from the arithmetic fold. Their exact counts remain a diagnostic field in the new receipt. This is different from a NONEMPTY bucket with no units: every nonempty bucket is retained and charged, including zero-unit buckets. No useful-bucket pruning or unit-run distribution is inferred.

For every L>=1 use

    m=min(20,L),
    G(m)=m(39-m)/2,
    Bsmall(m)=sum_(j=1)^(m-1)(20-j)(popcount(j)-1),
    Tsmall(m)=sum_(j=1)^(m-1)(20-j)popcount(j),
    Ssmall(m)=sum_(j=1)^(m-1)(20-j),
    A(L)=sum_(j=0)^18 max(0,L-1-j),
    p(L)=102+bitlength(sum_(j=0)^(m-1)binom(L-1,j)).

The resulting operation vector per bucket is nineteen coefficient prescales; G general initialization products; G recurrence additions plus Bsmall binary-scale additions; Tsmall shifted-operand occurrences; m wide initial complex conversions; A pruned complex traversal additions; and U_bucket final dyadic complex conversions. Ssmall and the m-1 new-top writes are retained as diagnostic categories, not added a second time to their implemented binary-scale work. Copies, bindings and geometry setup still need prices.

All complex products/scales act on two coordinate integers. A complex conversion requires two signed coordinate witnesses. These units are not verifier opcodes. General initialization products have degree-dependent wide operands; they are not old narrow rounded Horner stages. The unchanged old stage count19U is recorded only as the matched unit-output baseline.

The fold checks, for every saved cohort,

    sum_(L>0)H(L)=nonempty_bucket_heights,
    sum_(L>0)L H(L)=all_numerator_visits,
    sum_(L>0)(L-1)H(L)=old_advance_steps,
    all_numerator_visits-U=skipped_nonunits.

It also reconstructs every scenario's original U and19U exactly. Odd and even cohorts sum to a band; bands sum to a scenario. The stored all-cohort summaries are not added again to their constituent cohorts.

## 2. All twenty band vectors

The table gives the main typed categories. All remaining components, odd/even splits, length/precision rows and order counts are retained in the companion JSON.

|Extra|Band|Nonempty buckets|General initialization products|Initial complex conversions|Pruned complex additions|Unit outputs/final dyadic conversions|Maximum p|
|---:|---:|---:|---:|---:|---:|---:|---:|
|0|1|812309501875|153556611285520|15980451434330|1417215886871000|44637243437690|197|
|0|2|725285829066|127308965699000|12200673800066|257075612359047|10919369148972|171|
|0|3|967359258753|97195364994008|6333363693155|23138545175937|3364154098594|122|
|0|4|1087509289700|39189482513986|2133797966456|1352678848678|1007584876992|107|
|0|5|83135221033|1579569199627|83135221033|0|33710391000|103|
|167|1|816367501475|154327631209520|16061611426330|1430147406872796|45025549919846|197|
|167|2|748848413163|131785739031660|12671873979777|277063690918169|11616394228382|172|
|167|3|982751048621|99371286234763|6496987971354|24071485220963|3452729611768|122|
|167|4|1100520499183|39766399883987|2165708433760|1382060357453|1024238648084|107|
|167|5|84745149868|1610157847492|84745149868|0|34363088912|103|
|320|1|819322956750|154889167711770|16120720531830|1439777733681552|45314009913208|197|
|320|2|771757321182|136138328980740|13130017711772|297372754617652|12319025747444|173|
|320|3|997178732449|101424294679712|6652393186030|24971184630768|3536856397630|122|
|320|4|1112586644982|40303674369346|2195438752687|1409661931707|1039766491894|107|
|320|5|86237954924|1638521143556|86237954924|0|34968277312|103|
|640|1|822634111625|155518287138020|16186943629330|1450696252245524|45646121092426|197|
|640|2|824755316784|146207748091350|14189909137552|348274928355378|14049044900428|177|
|640|3|1028414158024|105912164457882|6995480295391|27004944099561|3722665567810|122|
|640|4|1138283279357|41455118069403|2259195208323|1469590888734|1073103787432|107|
|640|5|89415431629|1698893200951|89415431629|0|36256353632|103|

These maxima concern nonempty buckets, not a claim that a unit output attains every maximum. The fifth band has length1 throughout, so it has no traversal. Its initialization/conversion cost remains, including on its nonempty zero-unit buckets. Removing the old conductor/grid guard admits the circuit there mathematically, but does not make it profitable there.

## 3. Complete scenario totals

The scalar additions in the following table are complex-coordinate additions. The initializer-add column includes both the G recurrence additions and the binary small-scale additions. The separate shifted-operand column must still be priced; it is not already an addition or a free operation.

|Extra|Prescale products|General initialization products|Initialization additions|Shifted operand occurrences|Pruned additions|Initial complex conversions|Final dyadic conversions|
|---:|---:|---:|---:|---:|---:|---:|---:|
|0|69836382908113|418829993692141|698436179615681|661655619722181|1698782723254662|36731422115040|59962061953248|
|167|70931419633890|426861214207422|712492116182482|675308390897371|1732664643369381|37480926961089|61153275496992|
|320|71954588595453|434393986885124|725686136939845|688129272871348|1763531334861679|38184808137243|62244626827488|
|640|74166543650961|450792210957606|754452092174987|716102989928832|1827445715589197|39720943702225|64527191701728|

For the main alternative, the total initialization-plus-traversal additions are2397218902870343. Original unit Horner has1139279177111712 stages on59962061953248 units. Comparing these two integers is not a cost comparison: the new products, prescales, additions, wide initial rounds, dyadic final rounds and old rational product witnesses have different widths and arithmetic contracts.

The new ledger keeps all111453300891937 main all-numerator visits, of which51491238938689 are nonunits. These counts are inherited, not newly scanned. Initial state count is36731422115040 complex differences, not twenty times every bucket and not a count of source coefficients. The source conversion obligation remains twenty ORIGINAL coefficient conversions per distinct shared source array.

## 4. Exact order distributions and conservative widths

The receipt retains the height-weighted count T_j of buckets with L>=j+1 for every j0..19. This reconstructs the entire degree/order initialization vector:

    degree i, general product at order j0..i-1: T_j occurrences,
    degree i, small scale at order j1..i: T_j occurrences.

Thus general products at a fixed order j total(19-j)T_j and small scales at j>=1 total(20-j)T_j. Popcount(j) specifies each small-scale shifted operand and binary addition. Initial conversions at order j occur T_j times. Pruned additions at order j0..18 occur exactly sum_L H(L)max(0,L-1-j) times. The receipt checks these identities independently against the direct per-L fold.

For width-sensitive use, the receipt also retains each positive L, its H(L), m,p, and its exact count of initial conversions and pruned additions. This keeps the correlation between p(L), order support and operation count. One must reconstruct the per-order width within that row rather than price all operations at its maximum.

This ledger uses the conservative UNREDUCED representation v=2c and generic coefficient bound2^16. No power-of-two, factorial, Stirling, sharper per-degree coefficient or other normalization width saving is credited. Let ell_i=bitlength(v^i). The all-cell theorem supplies:

    coefficient prescale at degree i: 100+ell_i+17 signed bits;
    exact initialization order j at degree i: 100+ell_i+18+j;
    rounded traversal order j: p+18+j;
    raw pruned addition at order j: p+20+j;
    initial-round shifted input/product at order j: p+ell_19+18+j;
    initial-round doubled residual at order j: p+ell_19+20+j.

The general-product input uses the PREVIOUS partial degree's width, with a narrow factor q0+jF. The nineteen prescales instead multiply a coefficient numerator by a power of v. Their count equality does not make them the same operation. Factors, shifts, signs and residual reconstruction remain required.

The saved length histogram does not retain conductor values jointly with length. For conservative widths the new receipt explicitly uses c<=132900 for the odd cohort and c<=265800 for the even cohort. It stores all ell_i envelopes separately for those cohorts. In particular ell_19 is343 or362. These are bounds, not exact actual operand widths or fresh conductor scans.

For example the main odd/even band1 rounded live maxima are214/234 signed bits, and their initial doubled-residual maxima559/598. The smaller main band4 maxima are125/129 live bits and470/493 initial-comparison bits. The final even band5 has p103,121 live bits and485 initial-comparison bits. Its lack of advances does not remove that initial wide conversion.

The exact U output total is saved, but the number of unit outputs at each L or p is NOT. Final dyadic conversion width pricing therefore has two honest options: leave that distribution unresolved, or use the declared cohort/band maximum over the present positive-length rows. A nondecreasing width-price model may use p_max and the conservative p_max+20 final scratch bound. Without such monotonicity, take the maximum declared price over the retained row set. It is invalid to distribute units in proportion to H(L), substitute all-numerator visits for U, or call that upper price an exact cost.

## 5. Shared work and candidate status

The histogram does not identify the union of source arrays across conductors. Keep twenty complex coefficient conversions per distinct source/height/anchor/normalization object, with original input encoding, signed witnesses and real cache lifetime, as a separate source-union charge. It is neither twenty times nonempty buckets nor m times buckets. The latter count is only the NEW wide conversions of exact initial differences.

Nineteen coefficient prescales per bucket are included. Geometry powers v^i, cell endpoints, unit masks and Newton factors can share across heights with the proper identity and cache schedule. Their construction, checks, references, traffic and rebuilding are not included as zero-cost work in the arithmetic totals. Initial differences themselves change with the actual height's polynomial. The precision/binomial lemma and repeated concrete precision binding, temporary coexistence of wide and narrow states, proof imports and output coverage also remain charged.

For any proposed generator or ordinary Lean/MM0 proof backend, price the exact degree/order/count vector plus those shared-work terms, and compare against the complete matched accepted Horner or normalized-difference schedule. Preserve target cancellation and any equally available proved arithmetic shortcuts. A new-cost upper bound against an unrelated old-cost upper bound is not proof of a saving. Generation, proof construction, checking, proof bytes and peak storage require separate decisions.

No selection is made here. The four schedules still require their own auxiliary-sign and completeness success evidence. The ledger changes no family height, source coefficient, uncertainty, alpha tail, character transform, sign interpolation or count-closure obligation. It supplies exact candidate counts suitable for a later complete inequality.

## 6. Reproducibility and pins

Owned script `all_cell_rounded_histogram_ledger_20261111.py`, SHA `66C0784585FF8311E31880F5475529C7EC1FA99BC4D5E6CAFDF49C11589EE1BF`, and JSON `all_cell_rounded_histogram_ledger_20261111.json`, SHA `ED3000A823FE5E0C522D557B68A9E7BDCC2AC22F2890DBCD23AB6C5E0B8FD717`, pass1080 exact checks. The receipt is1228732 bytes. The script reads only frozen metadata/proof receipts, hashes those inputs, constructs the260-length scalar recipe and folds their saved histograms. No predecessor program is imported or run, and no selected conductor or unit is enumerated.

The first draft assertion exposed saved L0 empty slots; they are now explicitly retained as diagnostic counts and excluded before defining m or p. No source histogram was changed. Nonempty zero-unit cells remain in all arithmetic totals.

|Input relative to work/qrh-campaign/agents|SHA-256|
|---|---|
|prime-estimates/large_residue_bucket_occupancy_20261111.json|19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB|
|prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md|99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1|
|moebius/REVIEW_LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md|C6096D0C677E09F850065EDD2103B0348E28392D482CCEE568136B387768C86E|
|integration/TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md|5213690312A3A4C8BC262439844AF2BE227AF5D13635EEDADD3D720EEDAAAE3F|
|integration/truncated_newton_all_cells_20261111.json|D8E01908E80DEF6EE7DCBA98DFD07F69F42168EFE273EEEACB06240F649A990E|
|zero-sum/REVIEW_TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md|365EA347A51CB0BE346A5C9447DABD0AC406379FB3871DBE224D6D3E7EDC4FF8|
