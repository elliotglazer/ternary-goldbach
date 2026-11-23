# Independent paper preflight for the small finite-EM batch

2026-11-11. **PASS for the corrected, frozen paper specification and acceptance contract.** No unresolved mathematical correction was found. This is preflight only: no pilot implementation, logarithm/phase evaluation, moment array, transform, model, function image, or build was produced or run. The future producer and independent evaluator still require code review, frozen manifests and separate coordinator authorization.

## Reviewed versions

Paths below are relative to `work/qrh-campaign/agents/`. All five principal input hashes were checked against disk. I read the full main, receipt and scalar notes, inspected the scalar script and receipt, and read the relevant general EM and coefficient derivations.

| Input | SHA256 |
|---|---|
| `moebius/SMALL_EM_BATCH_PILOT_SPECIFICATION_2026-11-11.md` | `3977881D20CFE9F948E850AC9A83CF50084AA1EF7D0B7023E5D1A95DE845B929` |
| `major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md` | `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23` |
| `major-constants/em_small_batch_budget_20261111.py` | `13E200EDFF99D2C44CFA19EEE8CC83C071488362E2DF3997D71E7A79BB65B59D` |
| Its scalar JSON receipt | `41FF7A626495159CCEB34C19ED6426F480DEB9759962784885120E8B4E76E931` |
| `integration/SMALL_EM_BATCH_RECEIPT_CONTRACT_2026-11-11.md` | `DA2740C39148A2F1AB2291E6581B5C55A75BF33456E8006CB148B34B516178AF` |

The generic batching proof is `moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md`, pin `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818`, with my review `B8EE7250B9E2AAEE8099A7109C08FF34FBD70E880182E99E2B3F30970C49717E`. The transform contract is `170C8F976A8AF8B299E4AB737E6924260B3B1D8328FA54C0F2BF7F6E9720F997`, independently reviewed at `F2DC3A12F4474E8469D45C741E0F1A7FBA5A1CAF61AEF6A1509749FDE8BFD406`.

The scalar note previously pinned at `DC321E925C4AEE291301A5181947E92F7AA42E9E17F949E1168898A3E0CE22A3` needed a narrow correction. A coordinate-square error bound was stated for arbitrary complex offsets, although a rotation can enlarge a coordinate projection. The accepted version restricts that coordinate statement to actual purely imaginary offsets and gives the correct Euclidean bound on a general disk. The final numerical norm budget is unchanged. It also replaces generic permission to refine with rejection under this pilot's fixed-attempt limits. Main and receipt now agree on single-process peak working set rather than conflicting process/process-tree metrics. I verified these repairs in the final files; the earlier scalar pin is not the accepted version.

## Exact target and source normalization

N=1024, B=1025, M=16, K=16, p=24, J=8 and L=32 are fixed. Centers are `629/1250+i*(31999/16-j/8)`, j=0,...,7. The closed vertical half-panels have radius 1/16 and cover exactly `[1999,2000]` at real part 629/1250. There are eight panels and nine distinct endpoints. Owner `min(l,7)` gives offset +i/16 for endpoints l=0,...,7 and -i/16 for endpoint l=8. Both incident closed panels already contain a shared endpoint; no polygon or cross-model image intersection is required.

The retained coefficients are normalized complex-s derivatives of finite g, not height derivatives and not derivatives of actual zetaF. The vertical factor i belongs in the local offset z. The independent y=j/8 used in moment contraction must not be confused with that local coordinate.

The finite expression includes n=1,...,1024, the half term inside multiplication by s-1, correction rising-factorial lengths 1,3,...,31, and the separate pole-removal term B^(1-s). The actual EM remainder has length 32. The general source derivation `EM_SOURCE_PROOF_PLAN_2026-11-11.md`, pin `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`, applies to M=16 on Re(s)>-31. Its coefficient derivation uses finite truncated products preserving orders below K. This is legitimate parameter specialization, not reuse of a numerical M=32 model. Actual points here are far from s=1, so division of the pole-cancelled zetaF identity by s-1 yields actual zeta without a totalized-pole ambiguity.

## Domains and complete scalar budgets

Actual target points have Re(s)>1/2, |s|<2002 and |s-1|>=1999>2^10. Radius-one finite-g outer disks have Re(s)>-1/2 and |s|<2003. The finite entire g is bounded on those disks; the actual EM theorem is used only on target points. Factors through shift 31 are bounded by A=2034 in the EM remainder. The correction factors end at shift 30.

I independently reconstructed the scalar comparisons with exact integers and Fractions, without importing or executing the author script. All sixteen Bernoulli coefficient inequalities and the finite correction multiplier below 4/5 pass. The resulting outer bound is exactly `339194823/5<2^27`. The actual zetaF EM allowance is

`E_EM=4*2003*33/(63/2)*(2034/(6*1025))^32<2^-38`.

The finite-g Taylor allowance is `2^27*(1/16)^16/(1-1/16)=2^-33/15`. Both are in predivision g/zetaF units. Neither is inferred from a successful sample evaluation.

For all h<16, the new main-sum bound is `W_h<64*7^h/h!<2^14`. The maximum of the displayed rational weights is 470596/45. The elementary comparisons `exp(1)>65/24>27/10` and `(27/10)^7>1025` prove the log bound used here. Real residuals remain below 1 under the signed-grid bin rule. Thus the per-g-coefficient residual error is below `2002*2^14/24!<2^25/24!<2^-54`.

Each actual moment has claimed Euclidean radius 2^-110, and each consumed normalized transform of its exact rational centers has a separate arithmetic radius 2^-110. Final contraction and L-scaling contribute at most 2^-100. Hence main-jet arithmetic is `32*24*2^-109+2^-100=(5/2)*2^-100<2^-98`. Source moment error and transform arithmetic are neither conflated nor counted twice.

The complete correction block, including B phases, multiplication by s_j-1 and H=B^(1-s), has its own 2^-80 allowance. Main/correction assembly and exported-midpoint rounding have another 2^-80. The resulting full finite-g midpoint error is below `2^25/24!+2002*2^-98+2*2^-80<2^-53`. Fixed coordinate halfwidth 2^-52 therefore leaves room for independent full-box containment. These are obligations for a future computed enclosure; setting precision192 does not establish them.

The complete optional norm allowance reconstructed independently is

`(3/2)*[2^-38+2^-33/15+(16/15)*2^-52]/2^10+2^-64`

`=1540133/92233720368547758080<2^-44`.

The coefficient/final-arithmetic part alone is `37/92233720368547758080<2^-60`. These fractions agree with the frozen scalar receipt. The exact-rational image schedule has no final rounding, so its reserved 2^-64 is unused and must not be inserted as another pad. Coefficient uncertainty already enters Horner. EM and Taylor padding are added once before division. The norm allowance concerns pointwise approximation error, not total interval-image width or a nonvanishing margin.

## Required independent acceptance

The proposed independent run uses 224-bit elementary interval arithmetic and separately coded formulas. It must not import the producer implementation or use a builtin zeta, L, Gamma, theta, Riemann-Siegel or zero oracle. Complete acceptance has four distinct checks:

1. Revalidate all 1024 signed bin witnesses and the finite partition. Rebuild all 12,288 actual moment entries, including exact zeros, and prove the independent boxes lie wholly in their claimed disks. Full q is used in residuals; q modulo32 is only a label. Checking a floating midpoint or choosing new labels is insufficient.
2. Directly compute the positive normalized DFT of every exact stored rational moment-center line at all eight consumed labels. This is 3,072 output checks and 98,304 terms. It is independent of the producer's radix-two schedule. Prove full containment in each arithmetic-output disk. This check concerns exact center transforms; step1 separately supplies actual-moment correctness.
3. Recompute all 128 normalized finite-g coefficients directly at all eight centers, using manual exponential-coefficient recurrence and complete finite corrections, without bins or FFTs. Every independent box must be contained in the fixed producer square. Overlap, printed-digit agreement, or a subset of derivative orders is insufficient.
4. Reconstruct all eight complete panel images and nine canonical endpoints from those independently certified fixed coefficient boxes, with exact rational Horner, the two analytic pads, and division by the full nonzero denominator rectangle. Require exact equality of the serialized rational endpoints and exact geometry. This is a whole-panel inclusion argument, not a sample comparison.

Moment and transform radii are Euclidean; coordinate radii require a proved conversion. Sufficient disk containment can use the sum of maximal coordinate deviations, with no unproved square-root rounding. The claimed 2^-110 disks and 2^-52 coefficient squares deliberately provide slack, but successful containment remains unproduced. Internal unused FFT outputs are not additional consumed claims. Complete correction/source inspection remains necessary even though the separate direct-g path validates the final coefficient target independently.

The serialization distinction is sound. Internal FLINT balls use exact dyadic mid/rad values. Exact rational parameters, analytic pads and final interval endpoints use reduced numerator/positive-denominator pairs; division need not preserve dyadic denominators. The parser must reject nonfinite values, negative radii, malformed shapes, parameter changes and resource-exceeding payloads. Lossless export proves what was stored, not the correctness of the external numerical library. Deterministic rational interval operations and parser/telemetry guards must be concrete in the future frozen code before execution; this preflight does not claim those implementations exist.

## Work, caps and remaining gates

The independently checked structural counts are 393,216 moment contributions, 376,832 residual updates, 15,360 log-weight updates, 384 length-32 transforms, 30,720 butterflies, 2,944 Horner steps, 128 scales and at most 7,488 correction/assembly multiplications and additions each. The declared main workspace is 2,088 complex slots, with 768 streamed moment slots; inputs, twiddles, witnesses and serialization are additional. Direct reference construction has 131,072 coefficient contributions and 8,192 main phases, in addition to rebuilding moments and checking transforms. These are loop/slot counts, not equal-cost operations or byte/time forecasts. At this small J the batched moment count exceeds direct coefficient construction, as the author explicitly acknowledges.

The proposed limits are one 192-bit producer attempt capped at 180 seconds and one 224-bit independent attempt capped at 360 seconds, each with 512 MiB evaluator-process peak working set and 64 MiB receipt size. No child evaluators or delegated work are allowed; serialization is included. Actual OS telemetry, guard points and external termination need implementation review. Observed overshoot or inadequate telemetry prevents complete PASS. No automatic retries, retuning, center replacement or panel refinement are authorized by this specification.

There is no remaining paper-level blocker in the corrected versions. Before execution, code, exact schedules, schema, all source/spec/review pins and run manifests must be frozen and independently checked, followed by coordinator authorization. A later PASS would establish this bounded evaluator experiment at external FLINT interval plus reviewed paper-analysis scope. It would not be a rational-only elementary certificate, Lean proof, new closed contour, new zero-free region, production provider, or speed result. An honest whole-panel enclosure containing zero is allowed and must not be hidden as an unsuccessful sign test.
