# Sparse auxiliary certificates with bounded discovery and fallback

2026-11-11. Paper research only. No values, signs, zeros, transforms or builds were evaluated. This proposes a concrete finite certificate algorithm and conditional cost bounds for the R132900 large branch. It supplies no spectral data or distribution of sign success.

A sparse auxiliary certificate can save checking and sometimes generation. An unconditional expected saving over dense h30/h50 does not follow from the available inputs. The exact obstruction is the union of same-conductor requests: one unresolved orbit can keep an entire late character-transform row alive. The proposed algorithm limits that effect by switching the last few unresolved channels to direct repairs, with all dependencies and failed work charged.

## 1. The exact acceptance target

Fix one actual nonprincipal conjugation orbit, its rational main top T>=H(c), T>50, and one fixed h>0. Write H=T+h. Retain the actual critical-line main lower count K, canonical integral upper bound Abar and a valid single-channel Turing allowance b. Let d=1 for exact saturation, or d=2 only when the separately reviewed finite-RH-only theorem is explicitly supplied. Define the rational target

    R=Abar+2b-h(K+d).

The accepted closure is precisely W>R. A smaller Turing allowance may change R, but this algorithm neither supplies that theorem nor assumes a proposed allowance or measured deficit. If R<0, W=0 already suffices. If R=0, the strict test still requires positive evidence or a tightened bound.

For each positive channel maintain disjoint open sign intervals (u_i,v_i) with T<u_i<v_i<H. Their certified strict endpoint signs are opposite and their complete source errors are included. Set

    W=sum_i lambda_i(H-v_i),

where lambda_i=2 for the one channel of a real character and lambda_i=1 for each channel of a nonreal pair. Exact inverse identification is required. Main and auxiliary intervals are separate; no interval or multiplicity is counted twice. A central lower contribution of zero is valid, but does not discard central zeros from the total count.

Each bracket supplies a distinct actual zero gamma_i<v_i, counted at least once with its true multiplicity. Therefore its integrated contribution is at least H-v_i. This proves W is a lower bound without knowledge of the root locations, simplicity or completeness of the auxiliary list. Unrepresented and even-order zeros simply contribute no sign evidence. The closure inequality still uses the full zero count. An unresolved sign enclosure supplies nothing.

An elementary useful stopping certificate is the following. If a selected set has weighted count kappa=sum lambda_i and all v_i<=T+L, where 0<L<h, then

    W>=kappa(h-L).

Thus kappa(h-L)>R is sufficient. This is a bound on actual supplied intervals, not a density prediction. Conversely every bracket has weight less than lambda_i*h. If R>=0, any such successful list necessarily has kappa>R/h. This exposes a minimum weighted bracket requirement for this certificate form without asserting that enough brackets exist.

Refining an already certified bracket can increase W safely. Replace its parent only by verified, disjoint child brackets inside it. If both parent endpoint signs were opposite and a midpoint has a strict sign, at least one child has opposite signs. The retained child's right endpoint is no later than the parent's, so its weight is no smaller. If a same-sign parent obtains an opposite-sign midpoint, both children become valid brackets. If the midpoint remains unresolved, keep the old certified parent, if any. Never retain a parent and its overlapping children simultaneously. This gives monotone W at fixed H even though successive approximation centers need not be monotone.

## 2. One explicit finite producer/checker schedule

Choose h30 or h50 and freeze a finite fallback schedule, evaluator/error contracts, precision levels, interpolation orders and a maximum refinement depth. These are choices for one attempt. No fixed pilot precision becomes a global requirement. The baseline may itself return INCOMPLETE.

1. Validate K,Abar,b and the exact orbit manifest. Close any orbit with R<0 immediately. Initialize W=0 and retain the main endpoint cache.
2. Process the auxiliary window from left to right in blocks of at most eight coarse steps. Request only heights needed by still-open orbits. Begin with coarse endpoints. Search for strict sign runs and add all valid nonoverlapping brackets to W. Candidate intervals are kept strictly inside (T,H); endpoint guards and exclusions are checked exactly. Left-first ordering gives larger weight to an otherwise equal bracket, but is a heuristic because signs and margins are unknown.
3. At each unresolved interval, use a fixed dyadic midpoint tree. A strict midpoint either refines a bracket or creates new brackets as above. An interval with no sign change is not declared zero-free. Its refinement frontier remains available until the cap or closure. Share each exact endpoint once per character, phase, source function and precision.
4. Group pending source requests by exact conductor, height and precision. Compare the complete circuit cost of a fixed-order primitive transform with the cost of direct requested rows or a sound direct actual-function evaluator. Select a proved circuit whose dependencies and error allocations fit the requested endpoints. Do not invent a smaller transform by assuming the number of active rows scales its cost linearly.
5. After each accepted bracket or count-bound improvement, recompute the exact rational W>R test. Closed orbits issue no further requests. Their retained signs and source dependencies are kept for the checker. The final global manifest must account for every required orbit.
6. On the exploration budget or depth limit, preserve every accepted bracket and switch to the frozen dense fallback for remaining orbits. Reuse already certified identical nodes. Complete its prescribed finite work or stop with INCOMPLETE and the exact remaining deficit/requests. A resource cap, exhausted precision or dense failure never becomes a spectral result.

An implementation can choose another finite priority order with the same acceptance proof. The above schedule is concrete enough to count every request and failure. It does not require an unproved rule predicting the next zero. Complex count boxes may be added as a distinct auxiliary backend, with actual multiplicities, disjointness and ordinate weights, but their argument-principle costs are not included for free.

The final checker verifies the retained prime-independent analytic arithmetic DAG, strict signs, bracket ordering, weights and closure. It need not replay discarded native guesses. Native generation pays every evaluated guess, failed refinement and abandoned circuit, including shared computations later unused. If native search already computed the entire dense grid, sparse emission saves only checking/storage downstream of its retained dependencies, not that generation.

## 3. Precision and refinability

A sign gate consumes an enclosure of the actual Hardy function or a proved sign-equivalent proxy. For the reviewed proxy its complete radius is

    r_L+M[e(1+f)+f]+r_arithmetic,

where M>=|Lhat|, e is root-phase error and f is elementary-phase error. A strict sign requires the center's absolute real value to exceed this radius. Fixed error floors in alpha, EM or interpolation are not removed by raising arithmetic precision. Their orders/domains must be retuned if they dominate.

For a chosen interpolation sum, source-radius propagation is bounded by sum |K_j|r_j, with kernel and arithmetic errors added. Thus a hard requested output may need tighter shared input nodes. Only the transitive dependency union can be refined. A direct repair of that output can avoid forcing every easy output to a higher precision, but its own elementary, phase and source-tail work must be paid.

Conditionally, suppose a node has true nonzero margin m, an analytic floor tau<m, and arithmetic error at most C*2^-p. Then any p with C*2^-p<m-tau is sufficient. This explains a possible precision schedule; m is not given by the current source and may be arbitrarily small. If the node is exactly zero, no precision can certify its strict sign. The finite algorithm returns unresolved or changes the rational endpoint. It makes no general termination claim.

Record each actual precision tier, analytic order and new cache. Reusing a value at lower precision is free only after a valid outward conversion. Reusing a high-precision result across compatible consumers is valid, but does not erase the cost of producing it. A root-phase cache is orbit-shared only under the exact inverse-phase convention; arbitrary independent branch choices need their constant sign adapter.

## 4. Conductor transforms and interpolation costs

Let Q_c be the union of required coarse height indices for conductor c. A coarse index is included if any retained sign or interpolation neighborhood needs it. Let Q_global be their union across conductors. The checked source work has the structure

    sum_(j in Q_global) Seed(j)
      +sum_c sum_(j in Q_c) [Residue(c,j)+ChosenRows(c,j)]
      +phase/interpolation/direct-repair/count/coverage costs.

Seed sharing occurs across conductors; character sharing occurs only at the same conductor and height. Identical heights relative to different main tops need not be identical global heights. A full chosen transform provides all its output rows once. No per-character duplication of that source work is needed.

For a set A of remaining primitive rows at (c,j), a direct contraction over all v=phi(c) source residues has at most v|A| complex terms, plus character-coefficient setup and normalization. Its complete error must be certified, including all common residue errors. A useful crossover compares

    Residue+DirectRows(A)  versus  Residue+FixedPrunedTransform(c).

The common residue cost cancels only if both circuits actually use the same validated residue inputs at the same precision. A different direct EM backend can have different prerequisites. The minimum is over supplied sound circuits, not numerical approximations with unmatched error budgets. This switches a few difficult late channels away from a whole transform only when the charged direct cost really is smaller.

For R_I selected interpolation outputs with w kernel terms, direct interpolation pays R_I*w products/accumulations. A dense polyphase circuit pays its forward data FFT, the chosen inverse phases, point products, normalization and kernel cache. Its crossover is the one in the selected-sign supplement, applied to the actual neighborhood union and widths. Tiny R_I need not imply tiny Q_c. An interpolation kernel can require guard nodes outside h30/h50; those additional domains and costs must be included before either circuit is admitted.

The fixed-order auxiliary inventory gives the dense comparison exactly. Each additional grid step across the large branch costs 122841198690 G and 254481748047 A, besides the three other operation categories and all residue/seed work. h30 uses 384 added steps; h50 uses 640. These are two distinct closure attempts with different Abar, W and R, not interchangeable success guarantees.

## 5. What expected-cost improvement would require

There is no probabilistic sign-margin or stopping law in the accepted inputs. A deterministic task has an actual cost, not a justified expectation merely because its producer is heuristic. The following formulas state precisely what additional observations or declared probability model would support an expected comparison. They do not assume independence of characters or zeros.

For each conductor/height let I_cj indicate that the selected schedule actually generates a shared transform there. With a fixed full-transform price F_cj, its expected total is

    sum_c,j F_cj Pr(I_cj=1).

For a global seed object j its term is Seed(j) Pr(any conductor requests j). Shared setup has an analogous indicator. Repair and precision-tier costs require their own joint indicators and actual widths. The same linearity applies componentwise to G,A,Q,N,S, so these formulas do not require a runtime conversion.

Let p_o,j bound the probability that orbit o is still requesting a late transform node. The general union bound gives

    Pr(I_cj=1)<=min(1,sum_(o at c) p_o,j).

Without a probability model even these p bounds are absent. A small average fraction of hard characters is insufficient: one persistently hard orbit at every conductor can make every late I_cj equal to one. Independence would give a different product formula, but it is not a proved property of the spectra and is not used here.

There is also a robust budgeted comparison for an entire conductor or finite batch. Choose a positive cost functional paying actual widths, all source prerequisites, native discovery, failed work and checking; compare two attempts with the same required output and the same fixed fallback. Let C_D be the exact charged noncommon cost of that fixed dense schedule. If only an upper budget is available instead, the result below compares against that budget, not the unknown actual dense cost. Cap sparse exploration by alpha*C_D, accounting for indivisible scheduled tasks before launching them. Let E be the event that the sparse route closes completely at total noncommon cost at most beta*C_D, beta<1. On failure, run the fallback, reusing cached work but conservatively charging a full C_D again. Extra adaptive bookkeeping belongs inside these charges; only genuinely common orchestration cancels. Then

    E[C_adaptive]/C_D <=Pr(E)*beta+(1-Pr(E))*(1+alpha).

Consequently a sufficient expected improvement is

    Pr(E)>alpha/(1+alpha-beta).

For example alpha=1/16 and beta=1/2 require Pr(E)>1/9. This is an exact conditional inequality, not an estimated success rate. Its event includes all character closures, normalization and checking costs, not merely finding a few signs. On every failure the bounded cost is at most (1+alpha)C_D under the stated fixed-cost cap. If the dense fallback itself fails, both schedules still report INCOMPLETE; the cost inequality is about attempts and does not turn failure into a certificate. Byte/I/O or memory objectives can be added to the cost contract but are not automatically controlled by arithmetic count.

Alternatively, after a successful concrete packet the exact retained DAG and full search log can demonstrate an actual saving without any probability model. It must compare against a specified dense circuit with the same error and closure requirements. This is the next evidence needed before crediting an expected or realized end-to-end reduction.

## 6. Consequence and frozen inputs

The useful algorithmic change is conductor-aware early stopping plus a costed direct-repair escape for the last few channels. Sparse sign selection alone already has a sound checking contract; the new scheduling rule prevents automatically forcing every late source node or every output precision because of a small unresolved set. Whether it wins depends on the actual request union and repair costs. No source theorem presently bounds them tightly enough to prove an unconditional expected saving over dense h30 or h50.

All current spectral domains remain unchanged. The old main seed packet does not cover every auxiliary endpoint automatically. The separately derived h30/h50 parameter extensions, any interpolation guards and new values must be provided. Principal and small-conductor schedules are outside this large-branch note. No .555 strip certificate is substituted for original RH, and no simplicity or missing central-zero assumption is introduced.

| Input, relative to work/qrh-campaign/agents | SHA256 |
|---|---|
| zero-sum/SELECTED_SIGN_CHECKER_COST_SUPPLEMENT_2026-11-11.md | D4507C3C7F7B513621240AC2BB4B0142B371465FC7AFD5892C2993F0404F4C41 |
| integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md | F718551E44C343FB874AAD919290D002F402760B5B6B44772B534C087AF2D054 |
| zero-sum/REVIEW_R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md | 8A69A2954AB6903557476003A21F967ECCDC93AA47AF5A63BFFEFC9B5C2253F6 |
| zero-sum/AUXILIARY_FIXED_ORDER_SPECTRAL_INVENTORY_2026-11-11.md | 80DB1F3EF97114F332D4A23A96DFE585E234ACA87D01FC50234B95C1B576F186 |

Only this new note was created for the task. No evaluator, metadata script or old artifact was changed.
