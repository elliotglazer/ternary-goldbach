# Post-131 obligation map

Research synthesis, 2026-11-11. This document changes no frozen package, generator, canonical Lean source, or `CURRENT_STRATEGY`. No Lean build was run. Source references are to `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, with Mathlib revision `56a005855ea17e0b0958f73ec801ae140b0a1679`.

## Root contract and status vocabulary

The target remains the existing large theorem for every odd natural `N>=10^27`, with no mathematical premise, and the full existing `Statement` with only `BinaryGoldbachInput`. No spectral assertion, psi envelope, numerical library, certificate file, or checker-soundness assumption may remain in either root. An unused `Fact PlattGRH` binder also fails this contract.

“Source API” below means an existing theorem with proof in the pinned source; it does not assert that its current local compiled dependency closure has been checked. “Reviewed paper” means an independently reviewed mathematical implication, still requiring Lean formalization. “External data” means completed numerical evidence with the stated replay/review scope. None of these labels means a new Lean theorem has been proved.

## What the new accepted evidence changes

The complete head certificate now externally establishes the contour counts at472 rational checkpoints from14 to1500, including `N(14)=0`, `N(1500)=1069`, and the exact positive-ordinate head bound `Q1500<1.668<2`. The accepted review covers the finite-expression Taylor wrapper, EM and Cauchy remainders, shared geometry, exact winding, multiplicity, and rational head sum. It ran the full frozen numeric replay, a fully independent rational/topological replay, and an alternate evaluator on132 selected blocks. The selected alternate evaluator was not a second full numeric replay.

This supersedes “head data unproduced” as an external-evidence status. It does not supply any Lean count theorem or locate the zeros. It also does not prove the remaining narrow strip. Together with the separately reviewed analytic count theorem `N(t)<=F(t)+5 log(t)+20` for all real `t>=1500`, it permits the sufficient remaining strip `0.4975<beta<0.5025` through inclusive height `10^6`, yielding `W35<23.953<24`. Adoption of that wider sufficient strip is a separately reviewed implication, not a silent edit of earlier frozen targets.

The pure-kernel finite-psi replay architecture has also passed independent source/math and structural-data review. It specifies ordinary checked decisions, literal masks with separately checked specifications, complete prime-base enumeration, exact subcell cardinalities, log boxes, theta recurrence, and interpolation. No generic theorem, mask equation, count equation, or new finite-psi theorem has yet been implemented. Its syntactic operation counts are not dynamic kernel-work or runtime bounds.

## Next-stage obligation ledger

| Component | Existing or accepted evidence | Next required result and acceptance gate |
|---|---|---|
| Global7/8 provider | Pinned provider source and source-level integration assessment | Build the genuine export in the compatible target environment; audit actual L-function meaning, principal-pole exception, theorem type, and transitive axioms. Add reflection and multiplicity adapters. The23/24 export cannot replace it. |
| Actual zeta function | Source `Explicit/ZetaGrowth.lean:17–30` defines entire `zetaF`, equal to `(s-1)zeta(s)` away from1 and1 at1 | Prove each evaluator's identity/enclosure for this actual continuation, including pole cancellation. A raw product at the pole is insufficient. |
| Rectangle multiplicity count | Source `Explicit/RectResidue.lean:391`, `rectInt_logDeriv_mul`, gives the weighted rectangle argument principle | Supply entire-function proof, positive radius, nonzero reference value, ordered corners, strict enclosing-ball containment, and nonvanishing on all closed sides. For h=1 it counts actual analytic orders. Build the new exact polygon-to-boundary-integral bridge; source theorem existence alone does not verify the Boolean checker. |
| Head and height14 certificates | Complete accepted external interval data; head count/moment review passed | Formalize rational complex enclosure arithmetic, EM/Bernoulli error, finite Taylor coefficients, Cauchy remainder, whole-panel half-planes, shared vertices, ray crossings and contour assembly. Replay actual data and identify the finite divisor carrier. All boundaries and multiplicities remain explicit. |
| Analytic large-height count | Reviewed Jensen/Binet/argument-principle proof with no historical low-zero computation | Prove the analytic theorem for full counts at every real t>=1500, including right-limit passage at zero ordinates. This is an analytic formalization task, not missing finite data. |
| Principal strip through one million | Reviewed sufficiency of strip(.4975,.5025), accepted head data and analytic count imply W35<24 | Produce a complete nonvanishing/completeness certificate, then formally replay it. Existing head counts and two high local panels establish no such strip. Use closed height and auxiliary larger divisor radii for strict source carrier lemmas. |
| Shared primitive family | Reviewed common minimum profile `Hcert(c)=min(Hp_old(c),10^8/c)`, beta<=.555, plus separately reviewed base-gap height containment | Produce exhaustive certificates for all active primitive characters and their exact inclusive heights. No family-scale spectral certificate exists. Exact parity, conductor, induction, conjugation and principal treatment are necessary. |
| Finite psi interval[1e9,5e9] | All6439 candidate macro counts, independent full external recount, exact chain/log/checkpoint evidence; pure-kernel replay design reviewed | Prove the guarded prime-base predicate through70710, all literal-mask equations and bit specifications, balanced OR semantics,125271 closed count equations, certified logs, seeded theta recurrence, and relaxed checkpoints. Prove the final range-only finite envelope with no data hypotheses. |
| Finite psi workload | Reviewed sizing and endpoint/carrier checks | Run only an authorized bounded implementation pilot first: small/large prime masks and representative full-size subcells. Measure normalization sharing and memory. No dynamic kernel bound or default-limit success is established. Avoid generating all approximately200.8MB hexadecimal mask source before that evidence. |
| Analytic psi above5e9 | Reviewed smoothing/desmoothing implication from shared principal spectrum, global7/8 and low-zero moment | Formalize true-multiplicity mass, Gaussian explicit formula, tails, sharper vertical integral and desmoothing; join at5e9. This yields E, the integer all-range .01*x/log x envelope, rather than adding E as an assumption. |
| Elementary prime repairs | Reviewed P2/P3/P6 paper proofs and existing finite source APIs | Prove these independently of E; then E and finite sources give P1/P4/P5/P7 with the reviewed real-floor allowance. Avoid a P6-to-E-to-P6 cycle. |
| Möbius and Type I/II | Reviewed E/P2-to-profile(.03,.10), M1 coefficient2.8 and M2 coefficient.37273 adapters | Formalize the changed214-cell/tail and G2 soundness, including internal.0089 allowance. Rebuild actual first/second-choice consumers; do not assert old.0082 or.09 intermediates. |
| Totient and quotient sieve | Reviewed finite q<=2^1000, first-choice fourth-root, remote second-choice H correction; separate elementary regionS repair | Prove consumer replacements with their actual ranges. Retain off-arc envelope increment and integrated correction<1e-24. This does not prove the unrestricted old sharp totient theorem. |
| Major arcs and lower J | Reviewed low Gram/fourth-moment estimates and common-height weighted tails; complete mixed remainder<.000160001 | Prove actual smoothing/Fourier L1 split, character/Gauss weights, both-character mixed space, full transfers and limits. Recover Aplus<5e-7, Astar+Cross<9.5e-7, N<1.23, Ep<1e-4, sharper principal J>8.6296 and J<=10 without circularity. |
| Minor energy and base gap | Reviewed energy<=.65*x*log x, elementary residual energy, full parity-sensitive base-gap joins | Prove actual etaU GoodSmoothing/explicit formula and strengthened parity adapter, preserving original m, reduced q, y=x/49 and u=2q|delta|. Integrated major moment caps do not imply the pointwise gap estimate. High-twist small-q branches still depend on repaired Type I/II. |
| Final roots | Existing circle identity, nonprime estimate and finite binary bridge; reviewed numerical budget | Rebuild major/minor consumers and final arithmetic with1.0404−1.0376−.00271=.00009. Audit exact expanded root types and transitive axioms after all implementation. |

## Production algorithm gaps, separate from mathematical sufficiency

The low-height/head EM-Taylor evaluator is implemented externally and reviewed for its completed data. It is not yet a rational Lean checker, and its successful runtime does not predict million-height or whole-family performance. The principal million-height strip and the complete primitive family are the remaining large finite spectral evidence tasks.

`zero-sum/PRODUCTION_SPECTRAL_EVALUATOR_2026-11-11.md` is awaiting independent review in this map. It proposes RS point values plus a discrete Cauchy model and reports two local blocks at height1e6. The external experiment trusts FLINT's RS implementation; it is neither a complete contour nor a winding certificate. Outstanding production work includes the exact RS analytic remainder/coefficient normalization, removable singularities, gamma/phase interval rules, adaptive complete contour coverage, and a stable complex-s Dirichlet-family evaluator. Zeta RS is not a nonprincipal evaluator. A suggestive square-root AFE term count is not an implemented, stable or certified family algorithm.

`major-constants/RECTANGLE_CHECKER_SOURCE_LEDGER_2026-11-11.md` is also awaiting independent review in this map. It identifies existing rectangle/multiplicity APIs and proposes local-log connector and rational crossing bridges. The key existing rectangle theorem was read directly for this synthesis, but the ledger's complete proposed implementation route has not thereby been accepted. Prove boundary-integral equality for the actual function and then consume the existing argument principle; do not build a checker whose soundness statement simply assumes the intended count.

For finite psi, the production algorithm gap is different: complete external data already exist, and a pure-kernel architecture is accepted. What remains is implementation and measured feasibility of proof replay. Reusing literal masks avoids regenerating patterns, but does not establish cross-declaration memoization of shifted composite OR expressions. The reviewed architecture explicitly sets `dynamic_kernel_work_bound_claimed=false`.

## Evidence pins and review scope

All paths below are relative to `work/qrh-campaign/agents/`.

| Evidence | SHA256 | Disposition |
|---|---|---|
| `mellin/PSI_HEAD_COUNTS_CERTIFICATE_2026-11-11.md` | `ED9250BD7A7DE3395543FBC06DD88FFC9227AF352D690CAA70F621C20A5F975B` | Accepted by independent review; author note's earlier “review required” paragraph is historical status. |
| `mellin/psi_head_counts_20261111_h1500.json` | `82AD7ACDFFBCAC24D190A98ACB78BF66471249D09BFE2C43051ADD2AAEC0D030` | Complete external head data; no Lean replay. |
| `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md` | `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491` | Full frozen numeric replay, independent rational replay, selected alternate Taylor check; conditional wider-strip consequence accepted. |
| `prime-estimates/RESUME_PSI_KERNEL_REPLAY_ARCHITECTURE_2026-11-11.md` | `A610492380F798E3C369F052AF33662E60546180936956DA78F721E42A900D97` | Proposed pure-kernel architecture, not an implementation. |
| `independent-feasibility/REVIEW_PSI_KERNEL_ARCHITECTURE_2026-11-11.md` | `C94A37170290EA9B789E37B6BC498E3ABB805DD52856135C5EDB8DC5CDD9AA66` | Accepted final corrected architecture and structural replay; no new prime classifications or kernel proofs. |
| `zero-sum/PRODUCTION_SPECTRAL_EVALUATOR_2026-11-11.md` | `8494E089BB937B0595DEC607EEE0D49B4F549134A9371230D3A74A67C74DAF9A` | Pending independent review; local external experiments only. |
| `major-constants/RECTANGLE_CHECKER_SOURCE_LEDGER_2026-11-11.md` | `93A2B60572F8D02E1EF47BD6672DA01D21F70927C1D8DB3EF36930E2436EA91A` | Pending independent review; source/interface proposal only. |

## Immediate order and completion gates

First finish the two pending reviews without promoting their proposals to accepted facts. Separately design the bounded pure-kernel psi pilot and the rational spectral checker core; this note authorizes no build. The latter should first replay the existing height14/head evidence against actual zetaF, before attempting the million-height or family production workload. Keep analytical count formalization and elementary P2/P3/P6 work independent of the expensive certificates.

Then prove and replay the outstanding principal strip and full family evidence, assemble W35 and E, and follow the reviewed producer/major/minor dependency order. No actual spectral certificate may be replaced by its external PASS string, published computation, file hash, or an unproved “checker accepts” premise. The preserved24 prerequisite receipts through ZetaDatum establish neither new certificate nor analytic closure. Completion requires ordinary Lean terms for all selected interfaces and the exact final root audit.
