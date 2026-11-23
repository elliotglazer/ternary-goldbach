# Review of the conductor-local price-pass preflight

2026-11-11. APPROVE the bounded mathematical/schema/resource design in `moebius/CONDUCTOR_LOCAL_PRECISION_PRICE_PASS_PREFLIGHT_2026-11-11.md`, SHA256 `C5AAB690B926EC515E8708B2F3CB2B12C20E0ED6FA9C9313EC89803C7406B76E`. No frozen-paper correction is required. Execution still requires the coordinator's separate authorization; this verdict does not approve an unwritten implementation or its results.

Paths are relative to `work/qrh-campaign/agents`. I read the frozen preflight, the first precision-pass sources and reviews, the normalized/guard join and its relevant writer bodies, and the prior normalized price interfaces. All eleven allowlisted input sizes/hashes and all four writer-source pins match. The JSON input sizes sum to 95079543 bytes, below the proposed 128 MiB aggregate limit, with every input below 32 MiB. This review used source, hash and fixed-integer arithmetic only. No JSON inventory was parsed or folded, and no numerical value, proof, declaration or build was produced.

## Row and comparator binding

The proposed join preserves zero-based source row identity, conductor, phi, primitive count, ordered axes and repeated axis occurrences. It consumes the reviewed p assignment and exact slacks; it does not optimize or replace the selector. Guard rows are bound to the same c,J,phi and primitive count. The five band intersections use old indices `[0,J+e)` and added indices `[J+e,J+e+41)`, with the saved inclusive band endpoints converted to half-open intervals. This correctly preserves crossing guards and the closed target endpoint. Old and guard weights travel as forty entries, with four alternative scenarios kept separate.

The global p108 comparator is reconstructable from the allowlist. Summing emissions across p partitions removes only the precision label. The proposal then requires exact equality of every old and guard normalized phase key and all twenty weights against their respective complete frozen histograms. Projection to width classes and forced-p108 prices must reproduce all component/band dictionaries in both product modes, as well as setup. Grand-total agreement alone is insufficient, and the preflight explicitly rejects it as a substitute.

The guard join is already independently reviewed at `47B0B4971E65D79E819DA3717DBEA9058D348CF02411AC6F78F32F4E3CBF489D`, binding author `ADDED6BC91975C40C6029A591F4486782932C92B144D39465AC5E0F3CB597E58`. Those pins match. This second pass need not reconstruct the unnormalized event file again. It must reconstruct both complete normalized histograms, including phases unchanged by normalization.

## Context and resource bounds

The occurrence multiplier remains the retained preceding-axis product times the full following-axis product. The norm factor remains twice the full preceding-axis product. Pruning does not reduce that norm factor. Saved child multiplicities, norm multipliers, request labels and axis order are preserved.

The normalized local bounds match the reviewed context interface: point data `(n+2)a`, kernel exponent zero, exact rational `Z=n(2n-1)/P+2`, inverse product-input factor `2^j Za`, addition factor `2^(j+1)Za`, and postchirp `2na`. Rational factors are formed before the ceiling logarithm. The local and old global safety guards from the first pass retain the hypotheses needed for these bounds at every assigned p. Source grid100 and V<=2^14 remain separate mandatory premises. Raw presum/product/rounding growth is still priced.

Each precision partition is a subset of the original nonnegative context propagation. Guard weights change multiplicities, not geometry. Hence its keys lie in the reviewed full-population set, giving at most 52560 top and 220108 processed/retained contexts per partition. Discarding each partition before the next gives the stated live limit. The separate total bound is 9*220108=1980972. It is not a claim that fewer than one million context-processing steps occur.

The frozen paper correctly allows THREE requested-plan children in the q=n CT case. The actual source at `integration/transform_structural_inventory_20261111.py:140` has a full first child and two second-axis requests. Full-plan cache splits separately have at most two children. I flagged the two-child wording in an earlier draft, but the author independently corrected it before the first freeze. No erratum to C5AAB690 is needed.

All emitted width keys must, after dropping p, belong to the verified 133-key baseline set. Only after that check is the 9*133=1197 bound justified. The old and guard histogram key sets already have the same reviewed geometry. The proposed 125279 global keys, forty weights, 18 symbolic radix levels, 38147 cache states and 7606 kernel records therefore describe bounded structural work, not loops over arithmetic operations or units.

The paper distinguishes serialized-byte limits from Python working memory. Holding forty-weight dictionaries, decoded inputs and the global histogram costs additional memory. Bucket release, one partition at a time and sequential reference comparisons are necessary. The proposed caps are fail-closed requirements, not a proved process-RSS bound. An implementation that cannot meet them must stop rather than omit checks or enlarge the limits. The 2 MiB artifact and 8 MiB aggregate output caps likewise remain checked limits, not inferred from record counts alone.

## Prices and setup

The three- and four-product formulas retain rectangular byte products, the data presum, output additions and both coordinate rounding witnesses. Standalone complex additions retain the same extra-bit convention. All original categories remain visible, with roots and kernels separated. Zero normalized scale counts do not erase positive kernel products. Quarter-turn and negation counts remain available even though the displayed product/adder core assigns them no fee.

The comparison is normalized p108 versus normalized p(c). There is no refund for old unscaled-kernel sums. Baseline setup must first reproduce its 6004 lengths, 337702368 entries and three-product scale-plus-sum core 64162618688. Local setup consumes all 7606 separately p-keyed caches and 364355904 entries. The two cached sums per entry are real sums. Original kernel FFT work is separately inventoried by p, while root/chirp production, enclosure proofs, imports, identities and lifetimes remain additional costs.

The cold comparison subtracts baseline setup once and adds local setup once under the same price functional. When baseline setup is sunk, it is not refunded. Reuse requires a live object with the same exact coefficient/center, enclosure contract, normalization and lifetime; equal n or p alone is insufficient. The independently constructed-per-p schedule is conservative and coherent. The pending high-precision-cache adapter receives no credit, even if reviewed before execution. Named-digit, zero-carry, wider-radix and sharper-error alternatives likewise do not alter this comparator.

The proposed per-p input/output band arrays preserve the information needed to price exact grid100 embedding and downstream transport. They do not justify free conversion or nine independent source computations. Full P20 guard evaluation, shared source layers, completion, inverse-channel samples, interpolation, signs/counts, principal/small-family work and finite coverage remain separate.

## Verdict and evidence boundary

Approve this exact preflight for the coordinator's execution decision. A later writer must enforce its allowlist, typed row/edge checks, complete comparator reconstruction, partition/resource limits and exclusive output policy. Its resulting prices require an independent saved-data reconstruction before adoption. This review supplies neither that execution nor an arithmetic-cost result.

Key accepted predecessors are the precision mathematics review `15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2`, first-pass review `01FFE5405209397C176D193A43DE8436E4F59197C01FF56A172B973CADE5878C`, normalized structural review `49D7AA3C7D292C9A6018B178480BE8E0213C2A0725D6042D8EDC0A8C65F3B86C`, and guard review above. The exact eleven input pins and four writer pins are retained in the frozen author's section 2 and were rehashed in this review. Root decision `work/qrh-blueprint/GUARDED_COSTS_REPRESENTATION_AND_LOCAL_PRECISION_DECISION_2026-11-11.md` also matches its quoted pin `972884F678C29412D66449B8BA961AFB6A3D77CDF8D2CBF151A5F3C79D88F1A6`.
