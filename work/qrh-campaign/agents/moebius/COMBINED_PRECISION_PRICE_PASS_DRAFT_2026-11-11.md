# Combined conductor precision: proposed single-pass price design

2026-11-11. **DRAFT, NOT FROZEN OR AUTHORIZED FOR EXECUTION.** This is a paper/schema proposal. The combined assignment has a frozen preflight but no produced and independently reviewed data packet yet. Those missing artifacts, their exact sizes and hashes, and two new producer-contract hashes must be filled before this price preflight can be frozen. No metadata fold, assignment scan, evaluator, build or proof emission was run to prepare this draft. Existing frozen files remain unchanged.

The proposal reconstructs the accepted sharper-local and global-p108 comparators, then propagates **one combined assignment with 40 weights**. It does not propagate three assignments with 120 weights. It counts input regridding separately from transform arithmetic and keeps the full P20 source and arithmetic magnitude bound `V_width=16384`. A lower analytic error bound does not shrink these capacities.

## 1. Prerequisites and exact scope

The assignment design is `major-constants/COMBINED_CONDUCTOR_PRECISION_ASSIGNMENT_PREFLIGHT_2026-11-11.md`, SHA256 `B563B8CC28DC1F2BCF08390BCF9385AD504432940A0C22D263BC9002037158B2`. Its independent preflight review, standalone writer, successful output packet and independent output review are prerequisites, not supplied evidence in this draft.

That design combines the tight local chirp bound, tight tensor product, and one input regrid after exact grid100 assembly. It selects p in80..108 while retaining the original local safety and semantic peak guards. Its analytical selector uses

    Q=2^52, B=Q/(Q-1), rho_p=1[p<100],
    E_comb=phi(c)/sqrt(c)*(rho_p+B*S_tight*8828)*2^-p.

The independently reviewed assignment must establish its selector, least-p condition, all old guards and `p_comb<=p_sharp`. This price pass validates and consumes that result; it does not seek another precision, change the source order, or replace source error by a price calculation. Its row and contract checks below must not be described as an independent reconstruction of all analytical constants.

The source is the admitted full P20 evaluator, with all original source/shift production retained. The finite head must actually supply a grid100 center within its retained enclosure, followed by exact common-grid addition. A radius alone does not prove this encoding. The input adapter is one regrid of that assembled center, not independent rounding of its two summands. Error-bound `V_error=8828` and arithmetic bound `V_width=16384` have different roles. Only the latter enters width prices.

Required paper evidence includes the exact mathematical and review pins in the combined assignment packet, notably:

| Input | SHA256 |
|---|---|
| `independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md` | B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266 |
| `independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md` | 39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761 |
| `audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md` | 8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD |
| `audit/REVIEW_SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md` | 56B27935FF994E3F25F735825196076DF72C8DBC33D2A61D4787B61E3BBDD5F0 |

The last review binds `zero-sum/SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md`, SHA256 `E2457D3CA0E4436575DBAEA81413D91601312033AC6086233CFB7977D790225D`, verified by byte hashing. The cost result is124 unsigned addition-template core units per complex input under one stated witness schedule, not124 MMB commands or a complete signed checker.

The immediate comparator is `moebius/SHARPER_PRECISION_DELTA_PRICES_2026-11-11.md`, `D12934F2624BD88564B6E0E19C251D2465B338E34EF08755798180F672F42BB1`, independently reviewed in `prime-estimates/REVIEW_SHARPER_PRECISION_DELTA_PRICES_2026-11-11.md`, `402537CDCA633BD94D4AA2F23FB6334FB0B317541929F30D1B6DD787DAB5F470`. Its accepted840-class table inherits the earlier complete old/guard phase comparisons. This proposed pass does **not** reread or reconstruct those historical phase histograms. It must say so in its receipt and report.

## 2. Proposed data allowlist

Paths below are relative to `work/qrh-campaign/agents/`. Read/hash/parse one file at a time, with bounded reads before allocation and no writer imports. Eight existing inputs total61,226,907 bytes:

| Input | Bytes | SHA256 |
|---|---:|---|
| integration/transform_structural_manifest_20261111.json | 25110201 | A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637 |
| integration/sharper_conductor_precision_rows_20261111.json | 20920838 | 8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085 |
| integration/sharper_conductor_precision_caches_20261111.json | 1871369 | 129ADFCF668378CA94140DB27F3A3D6EF43995E05EB1413D3BE8AC603061D831 |
| integration/sharper_conductor_precision_metadata_20261111.json | 5188 | 8CEA147C264CC963CAE2EBAFE58F32E4CCD53A99378D7403161510993862227F |
| integration/short_window_guard_conductor_rows_20261111.json | 12794207 | A75E4EE6EBBBD5BA82AA91377040228140596989E03667148B55900F53ADE3EA |
| integration/short_window_guard_ledger_20261111.json | 41665 | C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4 |
| moebius/sharper_precision_price_widths_20261111.json | 320815 | 61D422B596A8BA77801CA53CE515A6B94FFE923894FDA931C7593827399A17E4 |
| moebius/sharper_precision_delta_prices_20261111.json | 162624 | 4599278B2CCC3EA5A06EB0BE168D5245C53ADF0AF83D06B4ECD4C96F708321A1 |

Four future inputs are exclusively the independently reviewed combined output files under major-constants:

| Future basename | Maximum encoded size | Actual size/hash |
|---|---:|---|
| combined_conductor_precision_rows_20261111.json |32 MiB|PENDING|
| combined_conductor_precision_nodes_20261111.json |8 MiB|PENDING|
| combined_conductor_precision_caches_20261111.json |4 MiB|PENDING|
| combined_conductor_precision_summary_20261111.json |1 MiB|PENDING|

Their prospective45 MiB cap makes the twelve-input upper bound108,412,827 bytes, below128 MiB. Individual input limit32 MiB. This is an encoded-byte bound, not a bound on decoded Python memory. Final preflight must replace prospective entries by exact bytes/hashes and verify the actual aggregate. The author/review/writer pins and canonical input/kernel contract hashes are additional small support-file pins, separately capped at1 MiB total. No historical event file, new axis table, producer values or unit-residue list is implicitly authorized.

## 3. Gates before the combined propagation

Check typed schemas, canonical integers, exact row counts/order, source IDs and all support pins. Bind the manifest's canonical plan hash `fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b`,37117 full nodes,35190 requested nodes,125400 conductor rows and exact saved ordered axes. Do not choose plans, factor conductors, regenerate units or enumerate transform gates.

Join every combined row to the same manifest, sharper row and guard row. Check c,phi,primitive count, axes reference, p_sharp, p_comb, rho, source/guard heights and old40 weights. The combined seventeen-field row schema is the one frozen by its actual producer. Check p range, analytical square selector and supplied slacks from its certified S_tight, immediate predecessor failure, and both old safety guards. These arithmetic checks validate supplied assignments without another search. Bind all per-node C/D values to the reviewed output hash; do not silently replace old semantic-peak guards by a smaller local D.

Reconstruct all840 accepted sharper width rows and both three-/four-product prices, including root/kernel split, every band, every e scenario, old-only/guard-only/joined views and all separately typed components. Forget p to construct the exact133-key global table; force every event to p108 and match the stored global-p108 prices in both modes. Reconstruct the complete sharper37522-state/7850-kernel cache schedule and the precision-forgotten global108 schedule (6004 lengths,337702368 entries). Match all baseline setup components, by-p counts and saved summary quantities. The conservative936-class schedule is not an additional arm; its prior acceptance remains inherited.

Independently regroup sharper row input/output counts into its saved40-vectors and match them. Check the guard bands from exact interval intersections, not merely their sum41. Check all supplied per-height operation counts against the saved requested plan. Only after these comparator and source-binding checks succeed may the new combined propagation start. A mismatch stops the pass rather than allowing a revised baseline.

## 4. Single combined40 propagation

Use p partitions80,...,108 sequentially. Each conductor seeds only its selected p. Weights are `old20 || guard20`, with scenario order e=0,167,320,640 and five band ends6400,12800,25600,64000,128000. These scenarios are alternatives. Old and guard views are disjoint; their joined view overlaps both and is not another workload to add.

At each saved ordered axis use the accepted retained-prefix/full-suffix multiplicity and the full-prefix incoming norm factor. Repeated axes remain repeated. Propagate only the saved requested DAG with exact children, multiplicities and norm factors. Full requested CT may have THREE children; compare the actual saved list rather than accepting an arbitrary list of length at most three. The separate full-cache DAG has at most two children. Preserve normalized Bluestein point factor `(n+2)a`, inverse factor `(n*(2n-1)/P+2)a`, radix-stage factors and postchirp factor `2na`. Exact rational ceiling calculations must agree with the accepted precision-forgotten width keys. Root coefficient exponent1 bounds its center magnitude, not its augmented norm.

Emit directly into `(p,category,de,ce,division_bits)` with40 weights. Categories split general products into root/kernel; retain additions, quarter turns, negations and dyadic scales. Thus all five operation categories remain represented. Even if scales are zero, verify and serialize that fact. There is no full per-phase event output. After each partition discard its context map; retain only the small width histogram and grouped metadata.

Forgetting p from the complete new histogram must equal **every weight of every one of the accepted133 global width keys**. Also match operation totals, per-band U totals, metadata input/output totals and all four scenarios. This is exact aggregate conservation and comparator reconstruction; it is not a new historical phase-histogram check. A key outside the133-key set is a failure, not permission to increase the3857-class cap.

The inherited220108 full-family contexts bound every selected-p subset. Consequently the proposed29-partition total cap is6,383,132 contexts, not the sharper changed-row cap81415. At most52560 distinct top contexts per partition are permitted. At most18 saved axes per conductor give at most2,257,200 raw top-axis contributions across the entire single assignment. No precision label multiplies a conductor's seed count.

## 5. Input regrid, embedding and sample identity

Retain per-p40-vectors for `conductor_height_nodes`, `residue_inputs` and `primitive_outputs`. At each row/band multiply the actual sample count by phi(c) for residue inputs, and separately by the primitive count for outputs. No unit enumeration is needed. Regrid counts use the former, never the latter.

The selected source sample union is old indices `[0,J+e)` and guard indices `[J+e,J+e+41)`. Restrict these intervals to each band and verify exact saved weights. Their sum has no overlap. Negative inverse-character samples whose positive partners already occur are not another set of input conversions, but their damping/phase proofs remain paid. A repair, new auxiliary target or extra domain outside this admitted union requires a separate sample-union amendment; it cannot be hidden in the current tally. Reuse of a sample across consumers needs its exact conductor, height, source object, unit order and lifetime identity.

For each p<100 and each view/scenario, let N_p be the recorded residue-input count. Report N_p complex conversions,2N_p coordinate witnesses and4N_p signed witness additions. With d=100-p the witness is

    n+2^(d-1)=Qout*2^d+t,  0<=t<2^d.

Ranges precede raw arithmetic: source115 signed bits, destination p+15 signed bits, raw additions116 signed bits and remainder d<=20 magnitude bits. Nearest ties are toward positive infinity, including negative inputs. Source magnitude completeness uses the actual input bound8826, not only a loose source-integer range.

The reviewed unsigned magnitude core is4*A(115)=124 per complex conversion, where A(w)=2*ceil(w/8)+1. Record `regrid_unsigned_addition_core=124*sum_(p<100)N_p` separately from transform-runtime addition core. It is not a complete signed price. Retain per-p coefficients for four signed wrappers, two shifts, two remainder-range proofs (including partial high digits), source/destination ranges, equalities, grid/complex embedding, term/cache bindings and witness production. The mathematical uncertainty is already in the combined selector; do not charge it a second time as source error.

At p100 record identity/copy occurrences. At p101..108 record exact shift/copy occurrences with shift p-100; no rounding witness or124 charge applies. Keep the predecessor's exact embedding work as a separate matched cost, not a refund from unpriced work. Original grid100 polynomial/head production and exact assembly are unchanged bills.

The root supplied main+guard all-residue bound60254515577760 as an optional conservative ceiling on conversion occurrences before the p split. This draft does not adopt that as an actual regrid count or multiply it into an executed price. The final pass derives actual N_p from the pinned row weights and may check that ceiling against the reconstructed main totals.

## 6. Matched runtime and full cache prices

Keep the original byte core, without named-digit, zero-carry, Gauss, wider-radix or Karatsuba substitutions:

    A(w)=2*ceil(w/8)+1,
    M(a,b)=5*m*n+2*min(m,n)+1,
    m=ceil(a/8), n=ceil(b/8).

For data capacity a=p+14+de and coefficient capacity b=p+ce, fixed three-product runtime has product core `M(a+1,b)+2*M(a,b+1)`, exact-add core `A(a+1)+2*A(a+b+2)` and round-witness core `4*A(a+b+4)`. Four-product runtime has `4*M(a,b)`, `2*A(a+b+1)` and `4*A(a+b+3)`. Standalone complex addition uses `2*A(a+1)`. Quarter/negation/scaling event counts remain separate roles even when their arithmetic price is not supplied. Preserve typed runtime components, both modes and all views; no center-equality claim follows from changing p or adding an input regrid.

Build the full cache masks from selected row axes on all37117 saved full nodes, propagating29-bit masks downward once. Compare every combined node mask and every `[n,P,mask]` kernel row. Do not use requested-output pruning for cache setup. Check zero masks too, exact child identities and the precision-forgotten active32942 nodes/6004 kernels. Expand only bounded membership counters, never individual coefficients or gates.

For each admitted (n,p) kernel key, P is its saved FFT length. Let ell=ceil(log2(2n+1)). Price scale rounds by `P*4*A(p+ell+2)` and, only in fixed-three mode, its two exact REAL cached sums by `P*2*A(p+1)`. Report full kernel FFT products/additions/quarter turns/negations/scales separately using the accepted radix formula, plus full root-table/chirp memberships. Complex FFT operation counts are not byte prices. Root/chirp generation, exact enclosures, setup-FFT widths, proof checking and lifetimes remain named costs.

The new p80..108 kernel contract and assembled-input contract must be canonical, separately hashed objects. The old hash22FFC752 is not the new domain-bearing contract. An overlap with a prior (n,p) key at p>=100 is only a possible reusable object after all producer fields, actual center/enclosure/proof and lifetime are identified. A matching key alone grants no free import. Full schedule inputs differ even where a projected kernel contract coincides. Shared-high generation is excluded.

Cold comparison pays one complete combined lifetime versus one complete specified predecessor lifetime. Sunk comparison never refunds old setup; conservatively charge all newly constructed combined objects. A separately evidenced reusable subset may later reduce that bill, but is not credited here. Retain scale/sum subtotals and full kernel/root/chirp costs separately in either comparison.

For each mode/view, a conditional decision is

    lambda_M*(P_prior-P_comb)+lambda_A*(A_prior-A_comb)
      > lambda_A*124*N_regrid
        + Delta_exact_embedding + Delta_cache_scale_and_sums
        + Delta_setup_FFT_roots_chirps
        + C_regrid_signed_shift_range_binding_generation
        + Delta_source_export_transport_proof_storage.

Each term needs a matched declared price; generation and checking are distinct. A role included in one term must not be charged twice, and an unpriced role must not disappear. Supply cold and sunk forms, retaining negative differences rather than clipping inconvenient costs. No event subtotal proves an end-to-end winner.

## 7. Proposed caps, outputs and approval gates

| Resource | Proposed limit |
|---|---:|
| Data files /encoded aggregate /individual |12 /128 MiB /32 MiB|
| Support files aggregate |1 MiB|
| Conductor rows /saved axes per row |125400 /18|
| Precision partitions /weights |29 /40|
| Live contexts per partition /processed total |220108 /6383132|
| Distinct top contexts per partition |52560|
| Requested children /full-cache children |3 /2|
| Radix stages |18|
| Global width keys /combined width keys |133 /3857|
| Full nodes /mask propagation edges |37117 /74234|
| Node-bit /kernel-bit membership iterations |1076393 /174116|
| Kernel length rows |6004|
| Metadata integers |1024 bits maximum|
| Width output /summary output |8 MiB /2 MiB|
| All owned outputs, writer and report |12 MiB|
| Observed private-process memory stop threshold |2 GiB, provisional|

These are new proposed limits, not an extension of an old execution authorization. The width-file cap is deliberately larger than the earlier2 MiB cap to cover3857 rows with40 weights. Actual assignment distributions may justify lower caps before finalization; they do not justify silently increasing any cap. Keep only one context partition, compact row assignments and small histograms. Release parsed predecessor arrays and raw buffers after complete matching. Process-memory checks at parses, partition boundaries, periodic propagation and serialization are observed limits, not a proof of an absolute allocation peak; an OS hard limit is a separate runner prerequisite if required.

Proposed new files under moebius are `combined_precision_prices_20261111.py`, `combined_precision_price_widths_20261111.json`, `combined_precision_prices_20261111.json`, and a final author report. The width output uses rows `[p,category,de,ce,division_bits,weights40]`, with by-p input/output metadata and all-category counts. The summary binds every exact input/support/contract hash; records comparator reconstruction, conservation and all resource gates; includes both-mode runtime components/bands/views, input-conversion counts and typed costs, complete cache/setup and cold/sunk comparisons. Flags must distinguish inherited historical phase validation from fresh width conservation. No per-context, per-gate, unit or numerical-value output is allowed.

Publication is exclusive and size-checked. On a hash/schema/context/width/contract/comparator/conservation/cap failure, stop and preserve/report the failure. No automatic retry, range extension, precision search, producer substitution or extra input is permitted. An incomplete exclusive write is not a successful packet.

Before any run: receive the actual independently accepted combined assignment; fill and verify all pending pins, sizes and canonical producer identities; obtain independent review of this completed preflight; obtain coordinator execution authorization; write and independently inspect the standalone bounded writer. After execution, an independent checker must reconstruct the comparator and combined40 propagation without importing the writer, including sample-union counts, masks and all prices. The present draft supplies neither run authorization nor that evidence. Numerical enclosures, strict signs, repairs, Turing completion, principal/binary work and the full analytic/MM0 foundations remain outside a successful metadata result.
