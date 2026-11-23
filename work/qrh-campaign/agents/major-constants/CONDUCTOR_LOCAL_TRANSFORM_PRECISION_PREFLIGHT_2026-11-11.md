# Conductor-local transform precision: paper rule and bounded fold proposal

2026-11-11. Research preflight only. This derives a sufficient heterogeneous precision rule for the SAME complete-radius ceiling and specifies the saved-data join needed to price it. No inventory was folded, no conductor or factor list was generated, and no function, coefficient, root, zero or transform value was evaluated. No source edit, build, declaration or proof emission occurred. No production precision or method winner is selected.

**Result.** The accepted error theorem already permits a separate precision p(c) for each conductor's complete transform, constant across its characters and sample heights. The rule below preserves even the exact stronger global-p108 radius, not merely the older 691/1024 ceiling. It needs at most nine integer tests, p=100,...,108, per saved conductor row. A row with axis-error sum at most 790257 already admits p100 under the old conservative conductor factor; using the exact factor can admit more. No assertion is made about how many saved rows meet this condition. Cache splitting and new certificate production remain paid.

## 1. Actual error contract and local safety

The accepted mixed-radix proof defines normalized intrinsic coefficients C_n and safety denominators D_n for the selected FULL length-n plan. The computed transforms remain unnormalized. Original-order primitive-output pruning retains a dependency-closed subset of this circuit, so the same sup-error bound covers all retained outputs. It does not replace n by a primitive-output count.

The exact recurrences, restated to identify the saved data consumed, are:

* Identity: C=0,D=1.
* Radix two n=2^k: C=2k+4,D=max(1,2k), with the identity handled separately.
* Direct prime leaf: C=2,D=1.
* Bluestein: P is the least power of two at least 2n-1; R=2 log2(P)+4, A=1+3R, Q=3nPA+1; C=6PA+2R(2n+1)+8, D=max(1,2 log2(P),PA,Q).
* Ordered split n=rm, first length-m then length-r: C=C_m+C_r+2 and D=max(D_m,D_r,1,C_m+C_r(2C_m+1)).

The mixed proof, sections 3–5, retains root and operand cross terms. In particular these are not condition numbers inferred from gate counts. Its cached kernel construction error is included before each runtime use. The rounded normalized-cache theorem preserves the SAME old Bluestein C,D, despite changing centers and removing runtime inverse divisions. Its added scaled-cache error is already paid there. This preflight neither substitutes its optional sharper C_new nor tries to derive a new precision coefficient from narrower intermediate magnitudes.

For the saved ordered outer axes n_i of conductor c, set

    S(c)=sum_i C_mixed(n_i),
    S_old(c)=sum_i C_whole-axis-baseline(n_i),
    D_local(c)=max(1, all saved mixed and baseline axis D values).

Repeated axis lengths are repeated summands. Their occurrence order still governs width contexts even though S is a sum. Each descendant is covered by its root-axis safety maximum; every descendant C is at most its root-axis C. The intermediate-width proof also uses the stronger old-axis sum. A sufficient local hypothesis is

    p>=100,
    2^p>=D_local(c),
    2^p>=2 S_old(c).

Using both mixed and baseline D values avoids relying on an unexpressed real-denominator monotonicity; the accepted comparison only promises a dyadic safety-bit comparison in general. Keeping the old global safety bounds, 29961461170177 and 2*424706204, is an equally valid fallback. Both are already below 2^100, so these safety guards cannot force p above 100 for the saved subfamily. They should nevertheless remain explicit acceptance fields rather than be dropped from the theorem.

Let M bound the exact stored input centers and V0=M+1<=2^14. The exact product of normalized axis operators has sup norm at most one. The mixed proof bounds intrinsic error by `V0[product_i(1+C_i 2^-p)-1]`, at most `2 S(c) V0 2^-p` under the stated safety. Restoring the full group size phi(c), then applying the EXACT conductor factor of magnitude 1/sqrt(c), gives

    epsilon_c(p) = [2 phi(c)/sqrt(c)] S(c) 2^14 2^-p.       (1)

Approximation of the conductor factor is a separate downstream error. Input/source uncertainty is transported separately by the exact transform; it is not multiplied by an artificial intrinsic condition number or counted at every gate. All roots, complex gates, cached kernels and exact normalization bindings must still meet the chosen u=2^-p contract.

## 2. Preserve the complete radius, not an isolated old sub-budget

Keep every non-transform tolerance in the accepted lower-precision allocation. Write

    T = (927193523/10^9) 2^-46,
    R_fixed = T + 135(2^-82+4*2^-63)
                +10*2^-54+10*2^-55+83*2^-55+2^-51.

The complete interpolation radius for conductor c is bounded by

    R_fixed + 135 epsilon_c(p).                            (2)

This follows from the same actual completion amplitude below 27, exact kernel l1 below 5, and inverse-character damping adapter. It retains both sample/kernel errors through the exact split `K(Y-Yhat)+(K-Khat)Yhat`. It does not silently reuse the former intermediate sample radius 2^-51 at the new p. The four 2^-63 L-error terms, completion multiplier error, formation errors, 83 kernel radii and accumulation radius are all unchanged.

Let S_global=202305920 and C_global=1266*S_global*2^14. The simple selected local rule requires

    epsilon_c(p) <= C_global*2^-108.                         (3)

It therefore preserves the exact global-p108 sufficient radius

    R_108 / 2^-45 = 2804840254168152529/4294967296000000000
                  <0.653052762<691/1024.

The phrase SAME ceiling is thus satisfied even if it refers to the newer stronger p108 bound. If only the older ceiling R_old=(691/1024)2^-45 is required, the larger allowance `(R_old-R_fixed)/135` is also valid, but is NOT the selected rule or an additional precision saving credited here. It would require its own explicitly bound scalar choice. The exact R_fixed is an upper allocation, not a lower bound on actual error.

No square-root evaluation is needed for (3). Since all quantities are nonnegative, for integer p between 100 and 108 it is equivalent to

    (2 phi(c) S(c))^2 * 2^(2*(108-p))
        <= c * (1266*S_global)^2.                           (4)

Choose the least p in that nine-element set satisfying (4) and the safety checks. If S=0 the intrinsic transform is exact and p100 suffices under the remaining interface. The global coefficient bound guarantees p108 is available for every valid saved row. Failure of a smaller test means only that this conservative rule does not admit it.

For a transparent sufficient case, `256*790257=202305792<202305920`. Therefore S(c)<=790257 admits p100 even after replacing `2 phi(c)/sqrt(c)` by the OLD 1266 bound. Equation (4) can improve on that replacement. This shows an eight-bit opportunity on qualifying plans without predicting their frequency or cost weight. The input interface prevents this rule from choosing p below 100.

Each conductor's same p is used for every retained character and every sample height, including positive inverse-character samples used by the negative adapter. There is no within-transform precision change or heterogeneous rounding recurrence. An interpolation query uses samples from the same conductor, all satisfying (3), so the existing uniform complete-radius proof applies without a new mixed-precision interpolation lemma.

## 3. Source, guards and widths remain separate gates

Grid100 Horner output centers embed exactly onto p>=100 by a checked integer shift. An accepted coarser Horner result must first use its exact grid100 export. This changes neither its source uncertainty nor its computed center into an older P20 center. Head, assembly, conductor-factor and completion producers retain their own tolerances and grids; their precision does not become p(c) automatically.

The stored-input bridge remains M+1<=2^14. It uses the full-source7000 finite-polynomial magnitude bound and the separately bounded finite head, not actual observed coefficients. New guard samples must actually be produced. The accepted +41 guard geometry has maximum height 26525/4<7000; the new alpha-domain review permits the two stated shortened final-band Horner candidates there. Other bands keep their own admitted evaluators. The old saved O_e event weights do not already contain the +41 extension. Applying (1) to the guards is a mathematical admission, not an inventory or producer-completion claim.

Under local safety the old augmented peak proof and the normalized-cache context proof still apply at p(c). Data capacities are recomputed as `p(c)+14+ceil(log2(local augmented factor))`, with the existing signed, presum, exact-product and rounding-witness additions. Root coefficient exponent 1 and rounded normalized-kernel exponent 0 keep their distinct meanings. Exact additions may have zero arithmetic error on the common grid, but still have ordinary checking and storage costs. The local normalized inverse factors must be repropagated from their exact rational contexts, not obtained by subtracting bits from an old rounded histogram.

## 4. Exact cache identities and lifecycle bill

For a fixed cold-cache schedule, let P_n be the set of selected precisions among conductors whose SAVED FULL-plan descendants use a Bluestein leaf n. Obtain that set by following saved plan children, not a new planner. Full kernel FFTs remain necessary even for pruned outputs. A canonical kernel-cache key is at least

    (full plan identity, n, padded P, chirp/sign convention,
     normalized rounded-cache variant, p, rounding policy, lifetime).

Each key represents exactly P complex coefficient entries, with their enclosures and the two exact REAL sums (C+D and D-C) per entry needed by the three-product implementation. This gives exact chosen-schedule counts

    kernel entries = sum_n |P_n| P(n),
    scaled-cache complex rounds = sum_n |P_n| P(n),
    exact real cached sums = 2 sum_n |P_n| P(n).

Those sums are setup, not per-runtime-use work. The kernel FFT construction and roots/chirps are also repeated or proven reused according to the actual key/lifetime. Existing 6004 kernel lengths and 337702368 entries describe one common-precision cache. Under this nine-precision proposal they supply only coarse upper bounds 54036 kernel keys and nine times that entry count, not actual new counts.

Unit-root/chirp cache identities additionally identify the exact rational angle, transform direction and symbolic coefficient position, with exact conjugation/sign reuse only when a checked adapter supplies it. No root positions are enumerated here. The manifest's full-plan lengths and setup counts are sufficient to retain an explicitly declared complete-set-per-plan cache schedule; they do not by themselves prove a globally deduplicated set of all rational root angles. A later fold must either keep those complete sets and their charged overlaps, or bind an existing exact coefficient-identity manifest. It must not infer root-sharing counts merely from kernel lengths.

All returned cached sums must be sums of the NEW centers. A p108 cache is not automatically a valid p100 common-grid cache: exact reuse keeps a finer denominator and changes arithmetic widths, while rounding changes the center/error and can invalidate a strict norm bound. Either needs a separate adapter. This preflight uses separate p-keyed caches. Shared seeds, exact algebraic facts or finer enclosures may later reduce production, but no refund is included now.

Cache memory is the sum of live entries at their actual signed widths plus enclosure, identity and proof-reference data. Precision batches may lower simultaneous memory only by charging reloads/rebuilds and preserving all dependent lifetimes. A cold comparison constructs both candidates afresh. A sunk-p108 comparison charges every new local-precision cache without subtracting already paid old setup. The ordinary operation-cost interface is runtime local widths plus all root/chirp/kernel generation, scaled rounds, cached sums, bindings, imports, storage/traffic and proof production/checking. A smaller runtime subtotal alone does not prove a net saving.

## 5. Proposed saved-data schema and strict execution boundary

No fold was run. I inspected the saved-schema writer and error-recurrence source, plus file sizes. The proposed first pass uses only:

1. `integration/transform_structural_manifest_20261111.json`, 25,110,201 bytes, pinned A41D70DB below. Its 125400 rows have fields `c,phi,primitive,H,J,ordered_axes_n_q,scenario_major_band_minor_height_nodes`; its 35190 request rows are a saved DAG; its full plan gives child choices. Existing primitive restrictions and axis multiplicities must be preserved.
2. `zero-sum/mixed_radix_precision_metadata_20261111.json`, 1,911,933 bytes, pinned 8BAE81D3 below. Its 13943 axis rows contain `n,old_C,new_C,old_D,new_D`. Join on n only, preserving repeated axes. The saved plan/hash binding is checked; no writer is imported or executed.

First-pass loops: index the saved axis rows once; visit each saved conductor once; perform at most nine exact tests (4); record safety, S, S_old, phi, p and the exact integer slack. Follow each saved full-plan node at most once per selected p to form cache membership. Use at most nine times the accepted full-plan-node bound 37117, or 334053 `(node,p)` states; fail closed if the saved schema or these limits differ. No factoring, conductor-range generation, height recomputation, root enumeration or new plan choice is allowed. Keep artifacts below64 MiB and records below one million; split summaries from rows if needed.

Suggested row fields are `source_row_id,c,ordered_axis_ids,phi,S_mixed,S_old,D_local,p,safety_slacks,squared_budget_slack,cache_plan_ids`. The four old scenario weights remain separate. The output must mark `guards_included=false` unless it additionally binds the separately reviewed guard-row artifact. A later exact guard join requires permission and its own pinned input/size proposal; it is not authorized by this preflight.

A price fold is a SECOND bounded pass, not implicit in the first. It must reconstruct the reviewed global-p108 normalized runtime and setup comparator before substituting p(c), retain all five operation categories and twenty weights, and derive new contexts from the saved per-conductor/DAG association. An already aggregated event histogram cannot recover conductor-local p. Work can stream by precision with bounded class tables; a ninefold expansion exceeding the artifact/context cap must stop rather than silently truncate. No aggregate result is asserted here.

## 6. Source pins and remaining proof boundary

Paths below are relative to `work/qrh-campaign/agents` unless marked blueprint. The relevant error sections and schema source were read; the large JSON inputs were not parsed or folded in this task.

|Input|SHA256|
|---|---|
|zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md|4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4|
|audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md|1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537|
|independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md|5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A|
|independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md|FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9|
|integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md|09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA|
|integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md|DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C|
|blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md|EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39|
|integration/transform_structural_inventory_20261111.py|584A16F00A905AD68C3FE11F4128FE2205F772FB67916EF312B596518F1ADB55|
|integration/transform_structural_manifest_20261111.json|A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637|
|zero-sum/mixed_radix_precision_metadata_20261111.json|8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E|
|major-constants/REVIEW_SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md|4D313FBFEC13EBC9D80490C5CC995228D67E71F211F865113A67969A60BB82E9|

This is a sufficient paper theorem with a concrete fail-closed metadata interface. Formal transform/arithmetic/root enclosures and all actual input values remain unproduced here. Same error ceilings do not transfer old numerical centers or signs. Cache splitting may offset runtime width savings. No count closure, finite-RH success, principal computation, binary coverage, or end-to-end runtime conclusion is supplied. The next authorized step can test whether enough weighted rows reach smaller p to justify the setup and representation bill; this note stops before that fold.
