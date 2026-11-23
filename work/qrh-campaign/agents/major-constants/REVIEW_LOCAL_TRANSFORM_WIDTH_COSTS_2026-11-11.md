# Independent review of local transform-width pricing

2026-11-11. PASS within the stated conditional arithmetic-template scope, with no correction. I read the author note and script and independently folded its saved histogram. I did not execute or import the author program, regenerate the structural inventory, enumerate conductors or units, evaluate values, generate proofs, build software or add declarations.

Root author: work/qrh-blueprint/LOCAL_TRANSFORM_WIDTH_COSTS_2026-11-11.md, SHA2561A3DC2D8A7593ADD30DCBCE77FAAA3C93A902AC8FE2D98D73F3905DE4A13AF3B. Its script923F4FBE4AA2BF691CA1457C4A440E41E6C2E3B430E70F0DF9B3F4C0EB8F3A73 and receipt5D4C79F0958F69577D250B35F7FF5C81B7C25E4AC755C8CB3517D699F2891DA1 match the frozen bytes.

## 1. Width semantics and unchanged precision

The histogram's data key d bounds a stored-center augmented norm relative to V. With V<=2^14 and coordinate grid2^-p, a=p+14+d is a sufficient MAGNITUDE capacity. The extra one in the augmented norm leaves strict room for the center. Signed integer representation needs a separate sign allocation; a is not a signed word width or an observed operand length.

Roots/chirps have center norm below2, giving coefficient capacity b=p+1. A kernel key uses ceil(log2(2n+1)), not the unit-root bound. I checked that exponent against every kernel row's local n and confirmed the saved maximum18. The kernel enclosure, correlation and setup remain the inherited ones. The new fold does not replace a nonunit kernel by a unit root.

The p112/134/152 choices and their intrinsic allowances are copied exactly from the reviewed arithmetic model. Safety and input-error hypotheses are unchanged. Reducing an integer's allocated capacity is an exact representation change requiring a width proof; it is not an extra numerical rounding or permission to discard nonzero high digits. The same common p is used by every event within a candidate. No local adaptive precision or new sign radius is established here.

The structural source was reviewed separately by moebius in REVIEW_TRANSFORM_STRUCTURAL_MULTIPLICITY_INVENTORY_2026-11-11.md, SHA2562D5CE1CDB699A0026E5B84F51FB2C05F4C09928C0B062B2E95B6DDBE8F8B748D. That review supplies the circuit, pruning and norm-context reconstruction. My fold review consumes its frozen data and does not duplicate the inventory generation. In particular, operation multiplicities use retained prefixes while magnitude envelopes use full prefixes; the price fold must not interchange them.

## 2. Product, addition and rounding capacities

For integer coordinate bounds |A|,|B|<2^a and |C|,|D|<2^b, the four-product identity has individual products below2^(a+b) and raw output sums below2^(a+b+1). Thus r4=a+b+1 is a magnitude capacity, with signed capacity r4+1.

For the fixed three-product identity, exact data and coefficient presums have capacities a+1 and b+1. The three rectangular products have shapes (a+1,b),(a,b+1),(a,b+1). Each is below2^(a+b+1), so the final two sums fit r3=a+b+2. Its signed raw allocation is r3+1. These are conservative pre-cancellation bounds, independent of any smaller semantic output norm.

The implemented price formula therefore charges three products, one data-presum adder, two raw-output adders and four dyadic-witness adders. The four-product alternative charges four products, two output adders and the same four witness adders. Coefficient sums C+D and D-C are cached EXACT sums and retain their construction/binding costs in setup. An independently rounded cache would be a different error and cost model.

The inherited rounding witness N+2^(p-1)=Q2^p+t, 0<=t<2^p, has two signed additions per scalar output. From |N|<2^r, its unverified shifted-product and residual sides fit r+2 magnitude bits. The fold prices four A(r+2) adders per complex round, not a general quotient multiplication. Signed capacities for those raw witness additions are one bit larger. The range, sign, shift, numeral equality and nearest-round implications remain additional proof work.

For a standalone complex addition, the incoming structural key already bounds both operands and sum. Retaining one additional bit and charging two A(a+1) adders is conservative and agrees with the previous template convention. It introduces no omitted addition error because common-grid additions are exact. For inverse scale by2^k, I checked every saved k lies in1..18 and k<=a. The same two-addition witness per coordinate gives four A(a+2). Each exact k is retained; no d0 half-integer witness is instantiated.

Quarter turns and negations keep their width-keyed and phase-keyed counts. Their zero natural-arithmetic subtotal is not a claim that signs, canonical zero, permutation/index binding or representation operations are free. Raw capacities and sign allocations are kept separate throughout this review.

## 3. Independent fold and all scenario joins

I checked all138126 saved histogram rows for field types, nonnegative20-entry weight vectors, category/exponent domains and kernel/scale constraints. Independent accumulation reproduces all400 width/category/division classes and every phase multiplicity. No runtime gate, conductor or unit list was regenerated.

For each of three p values and both product identities, I reconstructed the gate charge from its individual product shapes and adder widths. I then recomputed every one of the twenty scenario-band component dictionaries. All capacity rows, product components, exact-add components, round-witness components and inverse-scale components match the author receipt exactly.

The four scenarios remain alternatives with extra-node counts0,167,320,640. The twenty-vector order agrees with the manifest's scenario-major/five-band order. Each scenario projects back to the independent saved root/kernel/add/quarter/negation/scale totals, including G_root+G_kernel=G and G_kernel=scale for this particular circuit. I also reconstructed the OLD padded totals from the same type counts at a=p+68, rather than accepting the saved old total without a check.

At p134 the resulting totals are:

|Extra nodes|Local three-product core|Old three-product core|Local four-product core|
|---:|---:|---:|---:|
|0|6305051715366094514|7674906601984255182|8109639171812104218|
|167|6434074075305064674|7831695771321147020|8275596873157919720|
|320|6552280189500648114|7975340938438179662|8427641952834026138|
|640|6799508663635201714|8275775274892104142|8745644733855948058|

The main p112 and p152 local three-product cores also match4902779373472954330 and8010753159428325350. Exact rational comparisons verify the stated percentage intervals19.27–19.28%,17.84–17.85%,15.94–15.95%. These compare two specified padded arithmetic schedules. They are not complexity lower bounds or end-to-end savings.

At p134 the actual saved root-data capacity range is150..201 magnitude bits, and kernel-data range153..167. The old common data capacity202 remains a safe alternative. The new bound does not assert that every product has the minimum or even its allocated exact width. No data-dependent operand information was used.

## 4. Setup and complete-price boundary

I compared setup objects directly across the structural manifest, structural summary and old arithmetic receipt; they are identical. This includes6004 kernels,337702368 kernel entries,140276846 chirp entries,262144 maximum padded length, CT root-table upper count1116142487 and the kernel-forward vector G2244782056/A5502647200/quarter168845180. These setup counts were not subtracted from runtime, repriced as local runtime gates or silently deleted.

Root certification, kernel enclosures, cache-sum construction, admission/reloading, source conversion and source-to-transform binding remain necessary. The new local proof administration, integer representation, statement traffic, signs/ranges/shifts and storage can cost more than the old global-width proofs. At equal event prices the main p134 arithmetic-core difference is1369854886618160668; a complete saving requires the actual additional remaining cost to fit within the corresponding weighted reserve. Different product/adder/width prices require reapplying the saved typed data.

The source and arithmetic reviews do not supply an implemented ordinary-PA byte library. Macroevents are not MMB commands, Lean reductions or seconds. Input error, conductor/Hardy normalization, sign tests, Turing completeness, principal work and finite-range/library costs remain outside this subtotal. The separate scaled-kernel circuit is not included. No method, precision or production campaign is selected by this review.

## 5. Frozen independent evidence

Owned script review_local_transform_width_costs_20261111.py SHA256320EFCC7E5AEF7EBDA8751B379061234DCEBBA5DEE2BC8D0727931937B7D64AA; receipt C5A6A0B168610791157B6235BFBD35AB6B139F76381E03D184CA6BB12F0D7939. All695117 exact assertions pass. The receipt retains all24 p/model/scenario rows, their exact component totals and unchanged setup. It imports no author program.

The seven input pins are independently matched: structural histogram06CD20AAC9B0A0E8E40C798543193DA1E80404BBF4FA325B0F7F9E104B1FA30B; summary503FB2C859473372990408464F4F333E1C67FF1FBC83E8585F05AED44B836CC0; manifestA41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637; inventory author01F1446FF10D2EFD690DF06552F35DAD26C1453A49F4BB4F84D794D997FD55BB; old arithmetic receiptB13699002FCB232B67FD9F973C8E2497D8984A14179C7D7ABCA6D306890CFFB5; arithmetic authorDAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C; arithmetic review1A0DE2B920A63B27D7E0AB8E6C0DF38F9DCD56872C290C9333783D99A461004E. Exact paths are recorded in the receipt. The separate structural review pin above was also read and hash-checked before this verdict.
