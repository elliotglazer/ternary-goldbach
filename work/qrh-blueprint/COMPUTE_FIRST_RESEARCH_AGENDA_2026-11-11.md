# Research objective: minimize the full checked proof

The user's latest instruction makes removing PlattGRH an instrumental objective. The objective for today's research is to put the complete proof in the state expected to minimize end-to-end Lean and MM0 compute estimates. No choice earns credit merely by renaming a hypothesis, weakening a finite spectral assertion, or shifting work into an uncounted certificate. The final mathematical conclusion remains full ternary Goldbach with no extra mathematical assumptions.

This is a research plan, not a frozen Lean declaration or a claim that any new theorem has been proved. Previous selected-route files remain historical, unchanged artifacts. Their selection does not exclude a cheaper complete route. Existing research-only restrictions remain in effect: no Lean/Lake builds, numerical analytic evaluations, production scans or new Lean declarations in this phase.

## Cost accounting and the eventual estimates

For proof system S, analytic route R, analytic threshold N, binary cutoff B and certificate architecture A, model cumulative work as

    W_S = G(R,N,B,A) + V_S(R,N,B,A) + L_S(R,A) + I_S(R,N,B,A).

G is certificate discovery and production, V is formal checking including proof construction, L is the shared library and analytic proof build, and I is serialization and import work not already counted. Keep the categories disjoint in measured totals. Also report peak memory, stored bytes, dependency critical path and wall time at a stated core count. Human formalization effort and the risk of an unproved analytic ingredient are separate feasibility constraints, not invented CPU multipliers.

The eventual Fermi estimates must give explicit assumptions and ranges, with source-reported measurements distinguished from our measurements and unmeasured extrapolations. The withdrawn 2,500-core-year Lean scenario and incompatible MM0 scenarios are not calibration data. Research should reduce the required work; it must not reduce an estimate by choosing more optimistic constants.

Use a shared mathematical certificate design where useful, then allow each proof system its own efficient implementation. Do not force MM0 into a per-witness expansion while crediting Lean with a batch checker. Equally, do not assume that Lean's primitive arithmetic reduction is available at the same cost in MM0. Count how each arithmetic operation is justified, the proof bytes it produces and the sharing its checker actually supports.

For an end-to-end MM0 estimate, explicitly state the foundational theory and supporting library. The earlier PA-library discussion does not supply a translation of the Lean analytic proof into PA. A finite-certificate benchmark alone cannot price or establish that translation. Retain this as an open route obligation rather than silently treating the analytic part as free.

## First priority: optimize the finite range jointly with the analytic range

The current proof separately assumes binary Goldbach through 4e18 and proves the large-odd range beginning at 1e27. Full formalization must discharge the binary input or replace the finite-range argument. Study B and N as variables rather than preserving 4e18 by default.

For a ladder reduction, a prime p with 4 <= n-p <= B covers an odd n using binary Goldbach through B. Coverage of all odd n needs parity, the first and last intervals, inclusive endpoints and every gap proved. The idealized rung count is of order N/B. If binary checking had cost a*B and ladder checking b*N/B, their sum would be minimized near sqrt(b*N/a). This is only a sensitivity model; a, b and even the scaling laws remain to be established for actual certificate designs.

The existing ladder is important evidence that formal checking can preserve batching. Its README reports approximately 55 microseconds per rung and about four core-hours of kernel checking, with about five core-hours including search. We have not reproduced those measurements. Its fixed 2^45 candidate lattice and 2048-candidate windows mean the same cost cannot simply be extended to arbitrarily smaller B. The finite-range research must derive when this construction still covers every interval, when another Proth parameter is possible, and when a fallback primality certificate is needed.

Compare a generalized batched Proth ladder and adaptive certified prime gaps with a binary block checker. A binary checker should share primality information, and may prove coverage of a whole block by the union of shifts of certified prime sets. It must still justify the prime set and prove that no even integer was omitted. Bit packing by itself is not a proof of that coverage or a runtime estimate. Reject a proposal whose required certificate generation or checked arithmetic merely reconstructs the full expensive computation elsewhere.

Deliverable: a complete coverage argument parameterized by admissible cutoffs, a certificate layout, symbolic operation and bit-size counts, and the remaining existence/search obligations. This work is assigned to independent_feasibility; the coordinator owns integration with analytic thresholds.

## Second priority: compare complete spectral certificate algorithms

Use the original critical-line/Turing approach as the baseline. Compare it with QRH plus the selected finite strips and with a hybrid that uses cheap critical-line certificates ordinarily and strip certificates for difficult clusters. Count auxiliary heights, completeness, central zeros, multiplicities and closed boundaries in all cases.

The current QRH route still retains 5,543,640,188 primitive-character labels. Its reported 15.392037% improvement is a height proxy relative to an earlier QRH profile, not an advantage over Platt verification. There is no demonstrated end-to-end saving yet. A QRH route also carries the cost and unresolved validation of its global analytic provider.

The important algorithmic question is whether a proved checker preserves shared character transforms, height transforms and elementary enclosures. Independently reevaluating every L-function can lose the speed that makes a numerical algorithm practical. Conversely, an unexplained FFT receipt is not a proof. Derive a complete batch-checking algorithm and compare unique arithmetic operations, bit lengths, witness bytes and hard-case fallback work under equal trust requirements.

Deliverable: representative complete certificate-block specifications and an operation-level A/B comparison, followed by separately authorized performance experiments when implementation is ready. A single easy panel or source-level proof audit cannot establish full-family cost.

## Third priority: spend mathematical effort where it removes bulk work

Seek explicit bounds for the actual smoothed zero contributions needed by the major-arc, mixed-moment and pointwise consumers. Aggregate bounds may allow exceptional zeros and avoid certifying every location. Require the proposed bound to close all relevant budgets, including tails and exceptional cases. Earlier tested density bounds do not close the current budgets; the proposal remains research, not an available replacement.

Jointly vary conductor cutoff, finite heights, smoothing and N. Increasing N may reduce spectral work while increasing finite coverage. Lowering N may do the reverse. An improvement is a reduction in the complete W_S, not simply a larger analytic margin. Prefer structural reductions with explicit constants to extensive searches. The target repository already illustrates this strategy by relaxing a large-sieve constant and reducing a large modulus scan to finitely many divisor cases.

Deliverable: at least one candidate parameter change with a valid mathematical budget and its corresponding change in finite work. Do not count an unproved bound as an achieved saving.

## Selection rules and immediate status

Keep a feasible conservative baseline and distinguish speculative alternatives. A route with fewer arithmetic operations but a major unresolved theorem receives a conditional estimate until that theorem is supplied. Stop further foundational QRH audits unless they settle a dependency of a competitive route or expose a correctness problem that changes its feasibility.

The available researcher completed the spectral comparison and has moved to finite-range cutoff and certificate design. The coordinator owns full-cost accounting and analytic/finite-range integration. Six other agents remain in terminal usage-limit errors; they are not contributing active research. The completed row-count review is received but its coordinator reconciliation is deferred while this higher-priority work proceeds.

Today’s final handoff should identify the best-supported complete plan, remaining mathematical obligations, a cost table for both systems, an optimistic conditional alternative, and the few unknowns controlling the range. It must distinguish blueprint progress from compiled proof progress.

Sources and current supporting artifacts:

- [Spectral comparison](../qrh-campaign/agents/independent-feasibility/COMPUTE_FIRST_SPECTRAL_RESEARCH_2026-11-11.md), SHA256 0776A122BD91DBC1FE651E72DF1CF18F66A5A8D7F426DC61CF5174B6F9525E97.
- [Cost methodology and withdrawal of earlier estimates](COMPUTE_ESTIMATE.md).
- [Pinned target README](https://github.com/calr3/ternary-goldbach/blob/23b2d68ca344203d4384e0aff7affa4ec034bef9/README.md).
- [Helfgott and Platt, prime-ladder verification](https://arxiv.org/pdf/1305.3062).
- [Platt, finite Dirichlet GRH verification](https://arxiv.org/pdf/1305.3087).

No Lean declaration, proof build or new computational certificate was produced by this research update.

    DRAFT_ANCHORS: 0 created
    UNREGISTERED_SORRIES: 0 introduced
    DRAFT_IMPORT_VIOLATIONS: 0 introduced
    SEALED_THIS_TURN: 0
