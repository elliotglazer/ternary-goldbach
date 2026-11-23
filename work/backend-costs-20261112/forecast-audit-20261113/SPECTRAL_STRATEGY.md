# Strategy for reducing the complete spectral computation

Prepared 13 November 2026 UTC from saved source and reports. This is a research recommendation, not a new workload inventory, proof, benchmark or adopted production schedule. No build, numerical evaluation, conductor scan or price fold was run. Only this note was written.

## Decision

Implement a compact, output-producing source-to-sign block. Its inputs should describe the actual mathematical source and requested indices. Its checked execution should construct the elementary powers, retain the shared coefficient state, execute the relevant transform, and return a short proposition about actual signs. Do not serialize an independent certificate for every intermediate product or export the entire computed array as the final proposition.

The first reusable implementation target should be the shared positive-integer power producer from `RAW_HEAD_GRID100_PRODUCER_AUDIT`, with its actual grid100 head and error-sum export. It has a complete reviewed paper contract, a smaller analytic dependency chain than the full Hurwitz seed producer, and consumers throughout the large family. Prove its indexed recurrence once and keep the generated states inside the same checked block that consumes them. This targets the observed source-conversion and representation cost while closing a real production gap. It does not make the remaining source arithmetic free.

The clearest already derived reduction in mathematical arithmetic is the Hermitian half-length time transform for the small family. Implement its finite identity and error theorem alongside the compact block interface, then substitute it for the full time transform after actual coefficient/root binding is available. It reduces work even if literal translation becomes negligible. The source producer and half transform are complementary; neither is a replacement for family-wide zero completeness.

Do not spend the next implementation cycle on another isolated multiply checker, another unpriced grid selector, or another proposed backend-wide speed ratio. The missing result is a complete generated spectral block with a source-faithful analytic conclusion and measured setup, execution and assembly.

## What the current evidence establishes

`backend-costs-20261112/REPORT.md` and `NEXT_BLOCK_PLAN.md` separate the existing arithmetic network from an actual FFT. The network has dependent layers, proved signed floor rounding, local residuals, lengths and a final bound/checksum. It does not yet have certified roots, exact Fourier indexing, an input-function enclosure or a propagated spectral error. A checksum is not an injective commitment to a computed vector and cannot stand in for sign correctness.

The saved 8192-butterfly comparison reports 73.960 ms HOL4 acceptance and 3.747830 ms native GMP execution, with a separate 4.269485 s median literal translation cost. Stock Lean's matching replay is 13.464615 s elapsed. These are different execution mechanisms and clocks. They identify a real representation bottleneck; they do not price independently generated spectral data or prove a universal ratio. The raw-HOL conversion profile also distinguishes its roughly 34.5 ms internal conversion from the roughly 1.43 s reconstruction of the original integer proposition. A compact output theorem addresses this boundary directly.

The completed actual sign pilot proves strict positive real part and exact reality of

`4^(s/2) * SpectralPilot.chi4.completedLFunction s`, with `s=1/2+I*(5/64)`.

Its finite input, Abel tail, Gamma factor and normalization obligations are discharged. Its final full source compiled under strict Lean checking and only the usual three axioms. This gives a semantic integration example. It uses an eight-term direct sum at one low height, not the production P20 source, a character transform, a small-theta time transform or Turing completeness. Its fixed eight-term logarithm and sixteen-term exponential helpers are not the variable-precision production leaves.

The older full estimate is useful as a typed workload map, not as a current backend forecast. It includes about 2.188e14 small-family character/time butterflies with wide operands, about 6.025e13 large-family main-plus41 residue inputs in the e=0 scenario, the shared EM source, completion, repair and principal work. Its byte-event conversion factors and full-library allowances were provisional. Do not apply the recent block ratio to their grand total. The accepted mean186/runtime692 assignment also remains distinct from the older combined8828 exact prices.

## Changes that remove work, and changes that relocate it

| Change | Actual reduction available | Work and proof that remain |
|---|---|---|
| Compute sources and intermediate arrays within one checked invocation | Avoid repeated literal construction, external intermediate witnesses, repeated residual tests when outputs are computed by a proved rounding function, and large final array propositions | Elementary/source computation, sound execution, index binding, range/error induction, initial inputs, output signs and export |
| Shared integer powers across conductors and heights | Replace repeated log/cis evaluations for each raw residue input by shared setup and recurrence; reuse the same conductor factor when its exact contract matches | Every recurrence update, actual per-residue head multiplication, error accumulation, starts/restarts and state storage |
| Height-major shared coefficient conversion | Admit one conversion per actual source/anchor/profile object and reference it across consumers | Source generation still delivers its required coefficients; lookups, proof references, cache lifetimes, transposition and replicated worker admissions |
| Hermitian half time transform | Remove a specified set of time-transform products, additions, rounds and complex workspace slots | Character transforms, both inverse-character channels, packing/root work, the same N real outputs and analytic errors |
| Strict-sign-only output and finite-RH surplus | Remove the two final positive amplitude scalings from the selected small time-array contract; avoid demanding an exact zero list when only finite RH is needed | Internal centers/radii, canonical phase and upper-count arithmetic, critical-only lower count, repairs and principal certification |
| Sparse interpolation versus dense polyphase | Avoid paying dense refinement when few actual queries arrive; replace repeated local contractions when sufficiently many arrive | Actual request sequence, setup and persistent storage, already spent local work, refinements and failed signs |
| Lower precision, shared-high kernels or narrower widths | Reduce appropriate arithmetic widths or redundant setup under their separate accepted contracts | Regrids, coefficient error, changed cache unions and identity, source and completion costs; no free universal precision reduction |

Several of these reductions are already present in the accepted baseline. Raw-sign output, shared P27/P28-to-P20 coefficients and height sharing cannot be deducted again as new savings. The full-time small-family comparator intentionally did not adopt the half-transform arithmetic replacement; that remains a genuine alternative to implement and compare.

For the saved theta128 main inventory, the accepted half-transform paper changes time complex-product count from 89,858,217,607,168 to 43,822,509,521,403, including packing. This is roughly half of the time category, not half of all small-family work. The same ledger retains 128,941,391,789,290 character butterflies, other products, Gaussian work and source preparation. Packed input magnitudes and root/source grids change capacities, so even the typed time-product reduction is not a measured time factor. Minimal-theta alternatives require their own matched rows; the theta128 count is not relabeled as an optimized selector result.

## A concrete next implementation

### 1. Prove the shared raw-head producer as an indexed executable block

Use the reviewed identity, for `1 <= a < c <= 265800`,

`B_x(t) = x^(-1/2) * cis(-t*log x)` and
`c * conj(B_c(t)) * B_a(t) = (a/c)^(-1/2-it)`.

Choose the existing conservative integer pool and coarse time grid `t_j=5*j/64`. The paper bounds at most 90000 recurrence steps and the proposed source prefix needs at most 89600 through height7000. The production source is an indexed family of actual positive-base powers, not a table of unbound complex numbers.

Implement these ordinary lemmas and functions, reusing actual Mathlib definitions:

1. A parameterized real-log series and complex-exponential remainder. Generalize the pilot's proven analytic method rather than treating its fixed-degree constants as a production certificate. Bind exact range reduction, rational coefficients and signed rounding.
2. The positive inverse-square-root bracket `m^2*x <= 2^196 < (m+1)^2*x`, with the input and candidate bounds checked. It supplies the initial grid98 value embedded on grid120. Discovering `m` is still producer work.
3. An executable step producer with the paper's log error below `2^-128`, phase `-(5/64)*log x`, step error below `2^-120` and grid122 center. This phase is below2 in magnitude; this particular producer needs no large-angle period reduction.
4. A generic rounded unit-step recurrence with `e_next <= (1+eps)*e + eps + u`, including its cross term and exact height index. The grid120 state and grid122 step yield `e_j < 2^-96` under the admitted step count. A low-grid exported head is never fed back into the state.
5. Exact conductor-cache formation, head product and signed grid100 rounding. Prove the actual head radius below `2^-75`, then the nonnegative sum `H <= (phi(c)/sqrt(c))*2^-75 < 2^-63`. Exact head-plus-polynomial addition on grid100 gives `J0=0`; any extra inexact step must be charged instead.
6. A block soundness theorem about every produced source index, with explicit initialization and final-state objects. The theorem must connect the executable representation to the actual complex functions, not just to the recurrence equations.

The latest source error and runtime norm bounds must be joined through their own reviewed contracts. In particular this note does not replace a runtime sup norm by an average magnitude. It proposes an implementation of the existing raw-head producer, not a new precision allocation.

Measure a small but genuinely dependent tile with several bases and consecutive heights, then consume those same generated objects inside the block. Reproduce the existing chi4 sign certificate as a semantic regression where its domain fits, but do not use that one small success as the production-rate benchmark. The decisive next tile must feed a finite Fourier computation with certified roots, source enclosure and a proved error bound. A tile that ends at a numerical checksum has not met this objective.

### 2. Close the first actual transform-to-sign interface

The current `DependentBlock.roundScaled_residual` and `roundedButterfly_residual` prove useful integer facts. Its rotating network is not a radix-two Fourier algorithm. Add an indexed radix-two circuit theorem with exact positive-sign Fourier semantics, then prove its global norm/error invariant from certified input and root balls. Extend to the required CT/Bluestein domain only after this bounded interface works.

For the small branch, implement the accepted Hermitian packing:

`C_j = (A_j + A_(j+m)) + i*zeta^j*(A_j - A_(j+m))`, with `m=N/2`.

Its positive DFT gives `U(2r*Delta) + i*U((2r+1)*Delta)`. The actual sparse form needs only J packing products and explicit `C_0`; there is no Nyquist term to invent or omit. A normalized transform requires the exact final m shift and the corresponding error scaling. Prove the row-specific root, packing and time tolerance, source-grid conversions and target-index extraction before consuming a sign. This replaces the finite arithmetic portion, not the Gaussian approximation of the L-function.

The first family-level source bridge still needs the Gaussian or Hurwitz identity, every admitted truncation/error domain, primitive-character indexing, canonical unit phase, and the sign predicate for the actual completed function. The large-branch source additionally needs the full Hurwitz EM and translated-jet proof, including the selected final m159 remainder. The old m64 seed note is not the current final-band producer. Implementing only elementary powers does not discharge that EM obligation.

### 3. Return signs and then a count consequence, with bounded lifetimes

A useful block result states strict signs at specified rational endpoints of the actual canonical real function. It may return unresolved queries explicitly. The numerical arrays can remain internal, while source/index identities and a checked interval partition connect the block to its consumers. A short theorem does not justify an untrusted external execution; actual evaluation must be accepted by the chosen proof system.

For each conductor orbit, retain enough endpoint and auxiliary information to form disjoint critical-line lower intervals and exact auxiliary weights. Then check the existing closed-count inequality. Only after the ordinary Turing/functional-equation/count proofs are implemented can an accepted block end in `GRHUpTo chi T`. Until then, export the genuine sign theorem and leave completeness explicit. Do not label one successful sign as a finite-RH block.

## Shared lifetime is part of the algorithm

Height-major production is the natural order for the large shared Hurwitz coefficients. The accepted conversion schedule uses `2*K_i*(F_i+1)*H_i` coordinate conversions, once per retained profile and height layer. Its full-K20 converted layer has a declared raw payload at most 10,486,400 bytes, excluding original source, proof objects, kernels, states and outputs. That is not a full memory cap.

The small time transform is organized around a conductor/channel frequency array. It has a different lifetime from a shared large-family height layer. A practical design may use height tiles and conductor groups, but must pay spill, transposition, reload and any repeated proof admission. Shared log or coefficient facts in one process do not become free checked objects in another process. Root and kernel caches likewise need exact source, precision and normalization keys.

Use the following comparison, with the common consumer arithmetic charged once:

`T_literal = T_external_source + T_source_acceptance + T_encode/transport + T_literal_translation + T_consumer + T_final_assembly`.

`T_compact = T_compact_setup + T_checked_source_execution + T_state_transport/restarts + T_consumer + T_compact_assembly`.

The improvement is established only if the second complete measured sum is smaller. If the old checker already recomputes sources, count that work in `T_source_acceptance`; do not claim its removal twice. If it accepts short certificates for expensive leaves, computing them internally can be slower. Conversely, retaining already generated values between dependent layers can remove real duplicate work and reification without changing the mathematics. Peak memory, permanent output and total bytes moved remain separate measurements.

## What can be eliminated from the mathematical obligation

The selected small branch needs strict signs, not amplitude-valued Y exports. This already supports removing the two final positive scalings through a new typed raw-U API. Internal amplitudes and error radii remain necessary for interpolation and sign acceptance. Gamma/logarithmic Turing arithmetic is a separate producer and is not removed.

The accepted paper rule is a full closed count upper bound `U < K+2`, with `K` a critical-line-only lower count. Reflection would otherwise give a distinct off-line pair. It can avoid exact count saturation and allows stopping auxiliary collection when the strict inequality succeeds. It does not promise that a fixed auxiliary width succeeds. General complex clusters do not enter `K` merely because they are certified zeros. Central lower contribution zero is safe, but is not a central nonvanishing theorem. No exact zero list or simplicity assertion follows.

This can remove unnecessary exact-list obligations for the finite-RH consumer, but it has already been accepted in the plan. There is no supported further deletion of the principal RH-through-10^8 task, both positive inverse-character channels, closed-boundary treatment or general failed-sign repairs. The attempted lower-principal-height route did not complete all finite psi/Mertens obligations; the chi4 pilot supplies no substitute.

`Chi4Reality` is useful implementation evidence for the actual completion and conjugation APIs. Its root-number-one proof cancels a separately proved nonzero central value for chi4. That argument must not be reused for arbitrary characters whose central value may vanish. The general family needs primitive functional equations, conjugation and canonical unit-phase/root-number handling without a nonvanishing-at-center premise. Its character-dependent phase also prevents sharing one completed real function across all labels.

## Polyphase and precision are follow-on decisions

Do not eagerly compute every refinement class. The accepted sparse-to-dense rule compares the same realized query sequence, precision, coefficient array and output contract. With nonnegative incremental rent and persistent dense storage, switch before the next local cost would cross the dense setup price. Its additive guarantee retains common work, per-query work, prior local expenditure and controller cost. It gives neither a sign-success probability nor a global factor-two optimum with evictions, changing precision or cross-class cache interactions.

Use actual query/margin data from a complete spectral block to choose the initial strategy. Count rejected or inconclusive work and retain valid cache identities across retries. Arithmetic refinement cannot repair an analytic radius that already crosses zero. Similarly, the accepted mean186/runtime692 precision assignment is a worthwhile later price replacement, but a changed precision histogram alone does not determine exact runtime, setup or repair behavior.

## Backend choice and stopping condition

Keep a source-faithful Lean specification and small semantic regression while testing the compact executable block through an existing proved evaluator. HOL4 and Candle already demonstrate the execution mechanism; they do not supply the complete TG analytic library or a bridge back to stock Lean. A soundness theorem for an interpreter in Lean does not turn an arbitrary native run into a Lean proof. A faster Lean acceptance mechanism is a separate verified implementation deliverable. Ordinary PA MM0 still needs the complex-analysis development and matching signed network, beyond its now-real scalar product fixture.

The next decision should be made on one complete block report that includes source production/acceptance, roots, transform, error propagation, actual endpoint signs, repair requests, input construction, memory and short-result assembly. Report generation and first acceptance separately from optional independent replay. Preserve the unchanged-stock-Lean and different-foundation outcomes as separate results. Only then replace corresponding rows of the end-to-end cost ledger. No new full-cost total or method winner follows from this note.

## Source record

Paths below are workspace-relative. Hashes identify the exact local source/report snapshots read for this recommendation, including evolving backend reports. They do not imply that the paper-only circuits have kernel proofs. The first two reports and the existing Lean bodies were inspected directly; large numerical inventories were not read or regenerated. The source list deliberately distinguishes actual Lean proofs from accepted paper schedules.

<!-- Source hashes appended by a read-only file-hash operation. -->
| Source | SHA256 |
|---|---|
| work/backend-costs-20261112/REPORT.md | C923C965BD1DFBDF0DB02BFD374E96A0919012B310B2E89F5E84E323D0F87C60 |
| work/backend-costs-20261112/NEXT_BLOCK_PLAN.md | 5846C827368AB4E22C0A6FF568D0D3A9AA5134047FFAD227647B34D3CA7F28A9 |
| work/backend-costs-20261112/NATIVE_CERTIFICATION_DESIGN.md | 51120417F5706A72ACF5ABE10582F2E89A6AF271B2A134E5718F1AFB9105EF3D |
| work/backend-costs-20261112/lean-dependent/DependentBlock.lean | 82FA4E0F5AFAB34842B4271B8D1CFD9005BB706780785333AB3FC75BAC32C9EB |
| work/lean-pilots/spectral/REPORT.md | 06E423C98CADCB94A372872E8D1CF9D9B7F142F007350C9A08F058D82B064A08 |
| work/lean-pilots/spectral/PositiveHeight.lean | 955866564A49B21DC9B6436B7B830305ED569C167474CB9E592486CB2355309A |
| work/lean-pilots/spectral/Elementary.lean | B5CD458EC4A06171D8BBAA5B7203E0C9C85E9A9E93DB7B36E5BE6F7C5534E085 |
| work/lean-pilots/spectral/FiniteInputs.lean | 7A5CED128210471C8C5A21D6D690762744278FFDDA5428CA4266FA4D418CB01D |
| work/lean-pilots/spectral-reality/Chi4Reality.lean | D1CFC512A3271DF46D961A2E5FAD0FA159CCBC974786CCBDFCEF7D4635555C21 |
| work/qrh-blueprint/estimates-20261111/SPECTRAL_COST_ESTIMATE.md | 48F721494509A7EDF164210C91DA0FDAD8140E05F85E7EA3C01A6E16EA567D43 |
| work/qrh-blueprint/HALF_TRANSFORM_FRONTIER_AND_PRIORITY_DECISIONS_2026-11-11.md | 8DE8D4716F31C590EE2F9DBD7D7736FB3F6EF6D3DAE87A0C20A20E25BF31CD98 |
| work/qrh-blueprint/SELECTED_RAW_SIGN_COMPOSITION_DECISIONS_2026-11-11.md | 6644A91924D11E36382E3EBE31B79869BCE2A5F99AC545CBA456EE92C42FCC7B |
| work/qrh-blueprint/HEIGHT_LAYER_COEFFICIENT_CONVERSION_CACHE_2026-11-11.md | 9471C5D353D459C6C6B22A6DD5C555618C9CFACF9B94950FD5C839FF02771C2B |
| work/qrh-campaign/agents/integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md | FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE |
| work/qrh-campaign/agents/integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md | 1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E |
| work/qrh-campaign/agents/major-constants/RECONCILED_NONPRINCIPAL_OPERATION_SCHEDULE_2026-11-11.md | 483B6F4DC38CE5113ADF33419AEC9187BDA03A080FC7ED87ABB1727BBAAAE716 |
| work/qrh-campaign/agents/major-constants/HERMITIAN_HALF_TIME_TRANSFORM_2026-11-11.md | 16BA0E67BF7B674FD29748303DB44CBF0E43808727D053FCC008B3C22886F8A6 |
| work/qrh-campaign/agents/major-constants/TURING_SPECTRAL_SURPLUS_REDUCTION_2026-11-11.md | 6E7CD152D57679AFBEF754D9A1C0060AAA3F28C6E2DB1F6EFB4BD24A6B15C401 |
| work/qrh-campaign/agents/major-constants/ONLINE_SPARSE_POLYPHASE_SWITCHING_2026-11-11.md | 078A8C9A9DA83888C837F1D13995EF87B2E7D14733587616D793F823AB7C0F52 |
