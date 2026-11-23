# One-height coefficient conversion schedule

2026-11-11. Proposed source-bound schedule and exact integer metadata. No source coefficient, function, conductor, unit, prime or transform was evaluated or enumerated. No build, declaration or frozen-file edit occurred. This closes a conversion-occurrence count for one specified schedule. It does not establish its ordinary-proof implementation, total memory, runtime, or optimality.

## Bind one converted object to each full-grid source array

The reconciled large-family source schedule delivers twenty finite-polynomial coefficients at every fine anchor k/F, 0<=k<=F. The fine denominators by band are 1024, 2048, 4096, 8192 and 16384. The final source normalization4096 is distinct from output normalization8192 and its fine denominator16384. At the first-four rightmost endpoints, the unshifted source already supplies twenty coefficients; no additional P27 endpoint is requested.

Choose ONE fixed admitted profile and length K_i for each band. All active conductors at a height use that choice. Bind a converted array to the exact source version, positive height, fine anchor, output normalization, retained coefficient prefix, grid vector, nearest rule, original encodings and checked conversion evidence. An array for one shape or precision does not supply another shape for free. A future cell-dependent portfolio must charge the union of all actually retained variants.

Consider this height-major schedule:

1. At a requested height, produce the inherited full fine-anchor layer using the existing source algorithm.
2. Directly convert the first K_i coefficients at every anchor to the chosen profile. This is a full-grid superset, including anchors that no required unit may use.
3. Retain this converted layer while every active large conductor at that height evaluates its required units and performs the relevant character transform.
4. After the final such use, discard the converted layer and proceed to the next height.

Every required unit alpha=a/c has the same inherited ties-down anchor k/F in[0,1]. Its supplied coefficient prefix is therefore present. Height limits only remove conductor consumers; they do not require another source array. The error join remains the accepted true-coarse-jet, finite-translated-vector and stored-center split. Conversion is from the ORIGINAL stored center, not through a differently rounded cache.

This argument concerns the inherited nonnegative height inventory. Its inverse-character and conjugation interfaces remain required for any negative-side consumer. A genuinely different source-sign or normalization object would be an additional admission unless an exact proved symmetry supplies it. No character channel or required output is deleted.

## Exact counts for the specified schedule

For extra-node alternative e in{0,167,320,640}, the five layer counts are

    H = [6401, 6400, 12800, 38400, 20199+e].

Their sum is84200+e. The first includes index0; the final interval is64001 through84199+e. For each band the specified schedule admits (F_i+1)H_i converted arrays and performs 2K_i(F_i+1)H_i coordinate conversions. The two coordinates of a complex coefficient are separate nearest-round witnesses. The count does not assert that every anchor is used or that each array has equal reuse.

| Extra nodes | Full-grid arrays | Coordinate conversions, K20 throughout | Coordinate conversions, K19/19/19/20/18 |
|---:|---:|---:|---:|
|0|717688040|28707521600|27239446690|
|167|720424335|28816973400|27337953310|
|320|722931240|28917249600|27428201890|
|640|728174440|29126977600|27616957090|

The shortened constant lengths have their separate independently reviewed alpha admission and prefix-conversion proof. Final K18 is valid on the actual requested range, not the whole declared V7000 band. This note does not change their numerical errors or confer successful sign acceptance.

The main requested unit-residue count is59962061953248. Thus the full-grid schedule needs about0.000479 coordinate conversions per required residue for full K20, or about0.000455 for the constant prefixes. These ratios refer only to occurrences. Original conversion operands may be wider, and a conversion has a different cost from an evaluation. They do not prove a per-object amortization threshold or justify treating conversion work as zero.

The source algorithm still produces all twenty slots, including unused higher coefficients. Source EM slots, translation updates, final delivery rounds and existing source certification remain charged under their own ledger. In particular the source-coefficient count7538384728 is a different category; it is not a count of converted fine-anchor arrays. This proposal does not subtract its new conversion count from that source count or replace source production by a cache lookup.

## A bounded converted-layer payload

The reviewed stored bounds give every coefficient norm below8192 even after adding3/4, which bounds coordinate-nearest conversion error for every nonnegative fractional precision. With 0<=b_j<=100, a converted numerator has magnitude below8192*2^100=2^113. Signed114 bits suffice. A fixed signed128-bit payload is therefore a valid conservative encoding for every converted coordinate in the existing profiles and their proposed common downward shifts. This is a proved capacity implication, not an assumption that Lean or MM0 uses native128-bit arithmetic.

At one height the converted numerators alone occupy

    32*K_i*(F_i+1) bytes

under that declared payload format. The largest full-K20 layer is10486400 bytes; the largest K19/19/19/20/18 layer is9437760 bytes. Grid exponents are known from the band/profile and need not be duplicated inside every coordinate record, but their framing and interpretation must be checked.

These figures exclude original source encodings, decoded arithmetic objects, magnitude/range proofs, conversion witnesses, theorem handles, lookup structures, allocator overhead, elementary recurrence state, transform kernels and state, output arrays, transposition, worker copies and transport. They are not whole-pipeline or checker peak-memory bounds. An arbitrary finer original encoding is not bounded by the new converted payload. The original source must remain available or be streamed until the conversions that consume it have been checked.

## Ordinary proof reuse and order constraints

One mathematical source object may have one checked conversion proof and many checked references in a retained proof context. The references still cost lookup, argument binding and association with the actual residue output. Hashes locate artifacts but do not prove their contents. An implementation must demonstrate that its retained object has the exact source/height/anchor/grid meaning required by each use.

The one-admission count is a conditional implementation schedule. If a worker split, theorem boundary, eviction or independent replay reconstructs an object, replace its multiplier1 by its actual admission count r_o. Stock MM0 store/format limits may require a different packing or a same-rule implementation change; this note does not assume that the numerical payload alone fits its proof state. Lean data structures and kernel reduction likewise require a concrete indexed representation. No mutable native-array execution is accepted as a theorem merely because it computed the proposed numerators.

The existing elementary recurrence already progresses by height, but that fact alone does not make the entire proof pipeline fit into one layer. Character outputs needed for later height interpolation or count closure may require retained arrays, transposition, external storage or another pass. Source production, transform-kernel reuse and output handling must be jointly scheduled and fully priced. A conductor-major implementation that redoes all conversions for every conductor is a different schedule, with its own actual r_o.

Parallel workers may share immutable numerical payloads, but sharing checked mathematical facts across processes needs the explicit admitted proof-composition mechanism. Replication of source and conversion proofs, retained statements and parsing cannot be silently assigned zero. The total common source work remains common only when the chosen comparison really shares the same objects and their checked lifetime.

For the proposed schedule a complete conversion cost is

    sum_(height,anchor) [sum_(j<K,coord) Conv(original,j,grid)
                        + object binding + admission]
      + all evaluation lookup/reference costs
      + retention, transport and any reconstruction costs.

Use the exact counts above with width-sensitive conversion prices or declared upper prices. This gives a concrete upper schedule even though the exact used-source union is unknown. It does not license subtracting unrelated upper bounds as a measured saving. Multiple profile variants, attempted conversions later rejected by policy, and repeated admissions must be included when they occur.

## Evidence and review boundary

The companion coefficient_layer_cache_metadata_20261111.py checks eight frozen input hashes, reconstructs the stored rational envelopes, proves the signed128 capacity for grids0..100, and derives all four schedules from the existing band heights and saved unit totals. It passed233 exact assertions. It reads only saved reports and metadata; no predecessor producer is run and no conductor/unit loop occurs. Its JSON retains all per-band counts, exact ratios, payload bounds and excluded memory categories.

The complete pins are in that receipt. They bind the reconciled schedule483B6F4D, stored source9B777E02/review10281561, fixed-prefix author716B9E5F/data99671C58/review1F536DA2, and signed-cost author531DD233/review40AE12EE. Hashes for this new note, script and receipt are provided to the independent reviewer after writing. Independent review is required before root adoption.

No actual array, conversion proof, successful strict sign or complete ordinary-proof cache implementation is supplied. The new contribution is the specified shared-conversion occurrence count and a separate raw-payload bound, with all proof and scheduling obligations retained.
