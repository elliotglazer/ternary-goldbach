# mellin strip — 2026-11-11

## 01:59:06 UTC · Final

Saved `work/qrh-campaign/agents/mellin/derivation.md` and executed `check_constants.py`.

- Derived \(|M_{\eta_+}(\sigma+it)|<4.72\) uniformly for \(1/8\le\sigma\le7/8\), independently of modulation.
- Derived a rectangle Sobolev estimate giving low-zero contribution at most \(19.76\,x^{7/8}Z\sqrt L\). Its constant uses explicit elementary moments and exact rational arithmetic checks.
- Derived the modulated etaU convolution formula, yielding pointwise bound \(2.41\) and exponential bound \(216e^{-0.28|t|/(1+|\delta|)}\).
- Tracked etaStar scaling through \(49^{-s}\) and modulation \(\delta/49\).
- Exploratory quadrature improves the Sobolev coefficient to \(8.23808\). This value lacks a numerical error certificate.

The report lists the remaining Lean lemmas. No new analytic Lean proof was compiled. The major-arc worker confirms these estimates exceed the existing \(10^{27}\) error budget substantially.

## 02:12:14 UTC · Final

`GaussianEnvelope.lean` now compiles successfully and proves the stronger bound \(\|M_f(s)\|<3.95\) for \(0\le\Re(s)\le1\) from the explicit Gaussian envelope. Its only axioms are `propext`, `Classical.choice`, and `Quot.sound`.

Plain-source SHA256 is `A63E71F7521B781FC0CCCECDEF6AF43F2297B0A915C273213B36887380F3CDA0`. The checked source, log, and exit code are preserved under `agents/mellin`.

`EtaPlusStrip.lean` applies `norm_fP_le` on the requested strip and concludes \(<4.72\). Its compilation remains pending until `EtaPlusMellin` and the planned `Explicit.QrhMellin` module are available. Compiler slot is released.

## 05:19:21 UTC · Final

Completed both bounded tasks in `work/qrh-campaign/agents/mellin`:

- `EisensteinImportReview.md`: three-import candidate preserves exact declaration-body bytes. Uncompiled; no performance claim.
- `TwistBounds.md`: rigorous signed contour estimate combined with Fourier-tail bound \(\sqrt{184}/B^2\), retaining the bandlimit and all \(|\delta|\le4\).
- `twist_envelopes.py/.json`: exploratory optimization, clearly separated from certified estimates.

The new bound improves moderate and large heights substantially. Small unfavorable-sign heights remain insufficient to close the averaged error budget. Six precise remaining Lean lemmas are listed. No compiler launched.

## 05:31:16 UTC · Final

Saved the uncompiled `Statement.lean` candidate with one import, `Mathlib.NumberTheory.LSeries.DirichletContinuation`. All declaration-body bytes are preserved; hash and consumer analysis are in `StatementImportReview.md`.

No additional `CircleMethod` import was identified as necessary, but compilation and consumer checks remain required. No performance claim or compiler launch.

Also confirmed the pointwise smoothing estimate
\[
|hH_{200}(t)-hBase(t)|<0.00221,
\]
with exact normalization and remaining formalization steps in `PointwiseSmoothingTail.md`.

## 05:55:03 UTC · Final

All **2,750 interval checks passed**, with maximum certified bound **83.571301 < 85**. The complete run took 52.43 seconds on one thread.

Saved `JointPrincipalL2.md`, the Arb/Acb checker, and full certificate records. This closes the numerical gap for the principal lower-energy route. Global QRH and the listed analytic Lean bridges remain required; the full \(10^{27}\) target is not yet proved.

## 06:09:56 UTC · Final

Saved `FORMAL_CERTIFICATE_PLAN.md`.

Recommended path: rational quadrature rules with proved moment-error bounds and a verified interval checker. The first bounded target is the 26-node rule’s exact arithmetic certificate.

Reusing existing results reduced the proposed height cover to 243 centers. Kernel runtime remains unmeasured. No Lean build or full numerical rerun was launched.

## 06:12:40 UTC · Final

Saved [BLUEPRINT_PRINCIPAL.md](../../../work/qrh-campaign/agents/mellin/BLUEPRINT_PRINCIPAL.md).

The chapter covers the actual etaPlus estimate, all 2,750 certified cells, 243-center compression, kernel replay design, exact source interfaces, and remaining obligations. It also gives a symmetry-averaging argument that handles quartet degeneracies.

No Lean compilation, implementation, or numerical rerun. The principal estimate remains a blueprint, not a kernel-proved theorem.

## 06:20:51 UTC · Final

Saved [MINOR_ENERGY_QRH.md](../../../work/qrh-campaign/agents/mellin/MINOR_ENERGY_QRH.md).

It derives the actual-smoothing kernels \(172w_2\) and \(566w_2\), including scalar bounds and vertical remainders. These support coefficient **0.64621**, hence the proposed relaxed **0.65** target, without a low-zero gap.

Exact-rational checks pass. The analytic argument remains unformalized; it does **not** recover the original 0.640208 coefficient.

## 06:24:51 UTC · Final

Saved [BASE_GAP_HYBRID.md](../../../work/qrh-campaign/agents/mellin/BASE_GAP_HYBRID.md).

The direct route covers reduced denominators \(100000\le Q\le150000\) with \(Q/\varphi(Q)\le1.05\), giving a paper bound below \(0.038y\). This fits the actual `ghatY` budget and removes those moduli from the spectral task.

The report specifies both crossing inequalities, remaining cases, and inherited Type I/II dependencies. No compilation or formal closure claimed.

## 06:27:45 UTC · Final

Saved [BASE_GAP_STATIONARY.md](../../../work/qrh-campaign/agents/mellin/BASE_GAP_STATIONARY.md).

It derives signed contour bounds for actual etaU, an explicit all-height window-sum target, and negligible vertical remainders.

The current absolute local-count approach does **not** close \(Q=1\): the stationary band remains too costly. The report distinguishes rigorous formulas from diagnostic models and identifies the needed density, cancellation, or arithmetic improvement. No compilation performed.

## 06:29:47 UTC · Final

Saved [BASE_GAP_Q1_ALTERNATIVE.md](../../../work/qrh-campaign/agents/mellin/BASE_GAP_Q1_ALTERNATIVE.md).

A relative ψ-error ≤\(1.1\times10^{-8}\) above \(e^{45}\) would yield the uniform Q=1 bound **0.046673 < 0.04712**. Exact rational budget checks pass.

The available published estimate meets this threshold but depends on Platt’s finite-height RH verification. That arithmetic input remains unproved within the campaign; no Lean compilation or canonical source changes were made.

## 06:32:43 UTC · Final

Saved [MAJOR_UPPER_PRINCIPAL.md](../../../work/qrh-campaign/agents/mellin/MAJOR_UPPER_PRINCIPAL.md).

- A weighted finite-window spectral norm **≤21** suffices for \(E_p\le10^{-4}\).
- Strip, mass and source Jensen counts alone allow a model with energy **>0.000135**. This is an obstruction to those bounds, not a counterexample involving actual zeta zeros.
- Exact rational checks passed. No Lean compilation or canonical edits.

## 09:13:43 UTC · Final

Saved [RESUME_PRINCIPAL_2026-11-11.md](../../../work/qrh-campaign/agents/mellin/RESUME_PRINCIPAL_2026-11-11.md).

New paper derivations give a local zero count below 45 and an actual-smoothing Gram bound. They show that proving **no zeros with β>2/3 through height 40 million** would suffice for broad principal \(E_p<10^{-4}\), uniformly in the required x-range.

That finite nonvanishing claim remains unproved. Exact scalar checks passed; no Lean compilation occurred.

## 09:24:27 UTC · Final

Saved [RESUME_HYBRID_REVIEW_2026-11-11.md](../../../work/qrh-campaign/agents/mellin/RESUME_HYBRID_REVIEW_2026-11-11.md).

No mathematical defect found in the audited tail reduction or **\(6\times10^{-9}\)** mixed-norm bound. Exact checks independently passed.

The mixed Gram certificate must use both character/zero indices. Finite aggregates and remaining explicit-formula errors are still unproved. No Lean builds occurred.

## 09:36:38 UTC · Final

Saved [RESUME_P3_REVIEW_2026-11-11.md](../../../work/qrh-campaign/agents/mellin/RESUME_P3_REVIEW_2026-11-11.md).

**Pass at paper level:** independent rational checks validate the kernel and the final constant \(0.739832361<0.74\), including factorial errors and real endpoints. Combined with the existing finite branch, the argument preserves the original P3 statement.

No LP floats were trusted. Lean implementation remains pending.

## 09:54:15 UTC · Final

Completed [Möbius review](../../../work/qrh-campaign/agents/mellin/RESUME_MOBIUS_REVIEW_2026-11-11.md).

No mathematical defect found in the conditional reduction. Exact replay passed all 214 cells and terminal/tail checks; final bound is below .097127. P2 removes P3 from this tail consumer.

The prime-error envelope remains unproved. No Lean builds or canonical edits.

## 10:04:10 UTC · Final

Saved [cutoff review](../../../work/qrh-campaign/agents/mellin/RESUME_CUTOFF_REVIEW_2026-11-11.md).

No defect found; exact replay passed. The q=1 identity and lower-J corollary hold. Reduced cutoffs support the revised **3e-8** complete mixed norm allowance.

Finite spectral certificates and analytic bridges remain unproved. No Lean builds or canonical edits.

## 10:27:32 UTC · Final

Saved [low-zero refinement](../../../work/qrh-campaign/agents/mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md).

Exact scalar checks pass: a specified low-zeta moment certificate through height \(10^6\) would lower the psi threshold to \(5\times10^9\), leaving \([10^9,5\times10^9)\) for finite prime checks.

The spectral certificate remains unproved. No Lean builds or canonical edits.

## 10:57:57 UTC · Final

Saved the [spectral-leaf note](../../../work/qrh-campaign/agents/mellin/RESUME_PSI_SPECTRAL_LEAF_2026-11-11.md).

A finite strip \((.499,.501)\), height14 exclusion, small reciprocal-head certificate, and analytic count bound imply **W35<23.913<24**. Exact rational scalar checks passed.

The finite spectral certificates and analytic count proof remain unresolved. No Lean builds or frozen-file changes.

## 11:15:00 UTC · Final

Saved [the analytic-count derivation](../../../work/qrh-campaign/agents/mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md).

It derives \(N(t)\le F(t)+5\log t+20\) for \(t\ge1500\), without finite zero data. Combined with the proposed finite strip and head certificate, it gives **W35<23.990<24**.

Exact scalar checks passed. Independent analytic review and Lean formalization remain outstanding.

## 11:35:36 UTC · Final

Completed and replayed the [height-1500 head certificate](../../../work/qrh-campaign/agents/mellin/PSI_HEAD_COUNTS_CERTIFICATE_2026-11-11.md):

- All 472 checkpoint counts completed; \(N(1500)=1069\).
- Exact arithmetic gives \(Q_{1500}<1.668<2\).
- Full replay passed.

Independent review is underway. This remains an external certificate, not a Lean theorem.

## 12:17:32 UTC · Final

Completed the [height-1500 sign certificate](../../../work/qrh-campaign/agents/mellin/PRINCIPAL_SIGNS_1500_CERTIFICATE_2026-11-11.md): all **1069 sign changes** were found, compressed to **1070 rational samples**, and replayed successfully.

Independent review is underway. Combined with the accepted total count, this would certify finite RH and simplicity through 1500 externally; Lean formalization remains pending.

## 12:36:29 UTC · Final

Saved [RS analytic bridge](../../../work/qrh-campaign/agents/mellin/RS_ANALYTIC_SOURCE_BRIDGE_2026-11-11.md).

Mapped exact FLINT coefficients, indexing, phases, reflected errors, and removable points. Scalar checks passed. Original Part I remains inaccessible, so its remainder theorem is explicitly unverified. Found existing Mathlib Hardy-Z interfaces. No Lean builds or frozen-file edits.

## 13:05:04 UTC · Final

Saved the [production plan](../../../work/qrh-campaign/agents/mellin/PRINCIPAL_HIGH_STRIP_PRODUCTION_PLAN_2026-11-11.md).

Found an accessible Gabcke evaluator theorem supporting the sign route: 1,746,077 additional sign changes suffice. Exact workload and error checks passed. Independent source review is underway; no high-zero scan or Lean build occurred.

## 13:15:53 UTC · Final

Saved the [ten-point pilot report](../../../work/qrh-campaign/agents/mellin/GABCKE_BOUNDED_POINT_PILOT_2026-11-11.md).

All ten strict signs matched independent EM reference enclosures, including removable-point and cutoff-transition cases. Run time: 2.046 seconds. Independent review has the frozen artifacts. The high strip remains unproved.

## 13:30:59 UTC · Final

Produced the [complete 1500–2000 chunk candidate](../../../work/qrh-campaign/agents/mellin/PRINCIPAL_SIGNS_2000_CHUNK_2026-11-11.md): 448 sign changes, 449 retained points, no fallbacks or unresolved signs.

All 449 alternate EM checks reportedly passed; the independent review report is being finalized. No Lean proof or higher-strip closure claimed.

## 14:05:30 UTC · Final

Saved [K0 Gaussian moment proof](../../../work/qrh-campaign/agents/mellin/K0_GAUSSIAN_MOMENT_PROOF_PLAN_2026-11-11.md).

Proves all four bounds on the closed source ranges, with explicit domination, endpoint continuation, and derivative normalization. SHA256: `A3BD9C855E57DD70D828E093E83E760B2832AD4B8E6E00CED608629A087CE97A`.

No Lean execution. Mordell identity review and the separate saddle, remainder, and phase proofs remain open dependencies.

## 14:25:51 UTC · Final

Saved [canonical Littlewood proof](../../../work/qrh-campaign/agents/mellin/LITTLEWOOD_CANONICAL_LOG_PROOF_PLAN_2026-11-11.md).

Derives \(\pi\int S_\chi=I_\chi(t_2)-I_\chi(t_1)\), including zero endpoints, with exact Euler-log normalization, multiplicities, branch jumps, and right-edge limits. No RH or simplicity assumption.

SHA256: `6BB683D71E4B96A593E93699B3EEF52CF5443289DED3B1CEE06B3C232B7253D9`. Independent review and Lean implementation remain.

## 14:41:09 UTC · Final

PASS. [Independent review](../../../work/qrh-campaign/agents/mellin/REVIEW_ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md) requests no correction.

Verified canonical arguments, exceptional endpoints, both character channels, exact constants, and closed-count saturation logic. The checker passed 16 rational checks and 13 file pins.

SHA256: `2238E4C56B808F9034DCE86ECA834A785BA5DF4E09F2F68935C287BD9CA5AAE3`.

Lean formalization, scalar-certificate replay, and actual family saturation remain open.

## 14:45:07 UTC · Final

PASS. [Independent review](../../../work/qrh-campaign/agents/mellin/REVIEW_TURING_AUXILIARY_MARGIN_DESIGN_2026-11-11.md) requests no correction.

All 24 rational witnesses and 10 file pins passed. The deficit formula, strict margins, family heights, enlarged evaluator range, and both-channel factors are sound.

Measured \(D\), actual signs, and saturation remain unproved; selecting \(h\) supplies none of them.

SHA256: `D0BDFD871D73E77EE0386D6E94136136E77364B6512802E08E626E8ABFB1D5C8`.

## 14:52:56 UTC · Final

PASS. [Independent slab-assembly review](../../../work/qrh-campaign/agents/mellin/REVIEW_FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md) requests no correction.

Verified closed seams, multiplicity counts, polygon-cancellation assumptions, exact labels, inverse reflection, and inclusive height coverage. Complete family data and Lean proofs remain open; the pending evaluator note was not used.

SHA256: `C4A41C85540F6B64E53FD04B485AA879F326D98AD5B049A0CFD5FEC634CA6BC7`.

## 15:05:10 UTC · Final

Both reviews passed without mathematical corrections.

- [Block-wave error review](../../../work/qrh-campaign/agents/mellin/REVIEW_PRINCIPAL_BLOCK_WAVE_ERROR_2026-11-11.md): recurrence, allocations, saddle handling, and `.019` reserve verified.
- [Family workload review](../../../work/qrh-campaign/agents/mellin/REVIEW_FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md): all receipt fields independently reconstructed, including 149,999 conductor rows.

Neither establishes actual signs, spectral coverage, throughput, or Lean closure.

## 15:09:27 UTC · Final

Review **PASS** at paper and exact-algebra scope; no correction required.

[Review report](../../../work/qrh-campaign/agents/mellin/REVIEW_JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md)

SHA256: `2F5645939D0F3EB3B90860B07BE4A343082F2E8EAE7578888998DB7661117F56`

Checked 12 artifact hashes, replayed 32 author assertions, and passed 120 independent exact-algebra checks. Spectral coverage, certified transform execution, and Lean formalization remain open.

## 15:27:04 UTC · Final

Saved the [consumer frontier](../../../work/qrh-campaign/agents/mellin/CURRENT_CONSUMER_OBLIGATION_FRONTIER_2026-11-11.md) and handed it to `statement_audit`.

SHA256: `517D24E49F9F2DD8AA4E339C6EEF440070937FD94D2C9EB5ADE366A89604FF5B`

All 25 links checked. The report distinguishes actual source consumers, numerical joins, spectral obligations, and the original binary-Goldbach premise. No builds or source edits.

## 15:34:16 UTC · Final

Created the [rectangle adapter](../../../work/qrh-campaign/agents/mellin/PRINCIPAL_MODULAR_RECTANGLE_ADAPTER_2026-11-11.md) and exact receipt.

Checks passed: disk containment, `Re(F_b)>14.1`, four counterclockwise panels, and zero crossings. Independent review is pending. No analytic evaluations or Lean builds were run.

## 15:38:11 UTC · Final

Diagnosed the first failure: the internal translation is exact, but endpoint export widens the input interval by `133693435 × 2⁻²⁸³` on each side. The output export adds no width, so interval replay correctly rejects containment.

[Diagnosis and lossless export proposal](../../../work/qrh-campaign/agents/mellin/MODULAR_ENDPOINT_EXPORT_DIAGNOSIS_2026-11-11.md)

Other failed operations remain unresolved; frozen receipts were unchanged.

## 15:42:52 UTC · Final

Independent seed review **PASS**, no correction.

[Review](../../../work/qrh-campaign/agents/mellin/REVIEW_LOSSLESS_SEED_TAYLOR_2026-11-11.md)  
SHA256: `A842B04F0C18005A89C48F2F377A063E1B9F98B47CFCC9B9CFA1FE579DFD102A`

Exact arithmetic confirms all 14 Taylor terms and four strict containment margins. This closes the local seed obligation at paper/external-certificate scope; no Lean or full modular computation claim.

## 15:45:25 UTC · Final

Independent review **PASS**, no correction: the actual one-node kernel satisfies \(|P|\le2^{-408}\).

[Review report](../../../work/qrh-campaign/agents/mellin/REVIEW_PRINCIPAL_ONE_NODE_BOUND_2026-11-11.md)

SHA256: `6ABD86362059F5BFED71A5DA72D59DC6774ED2B338E9E9189899E79C425254B9`

All guards, theta selection, derivative prefactors and rational inequalities checked. Paper/external-certificate scope only; no Lean or broader spectral claim.

## 15:47:52 UTC · Final

Independent review **PASS, conditional on the new seed enclosure**.

[Review report](../../../work/qrh-campaign/agents/mellin/REVIEW_LOSSLESS_MODULAR_WORD_R1OVER8_2026-11-11.md)

All 87 gates/constants and 43 domain checks pass, including all five full-input root-v divisions. Earlier receipt failures remain unchanged. No seed, P-value, spectral, or Lean proof claim.

SHA256: `5F6D22F549CF251EC44DAC4D436DAD0FF5A077902C22B81978F359AECAAC6C28`

## 15:54:09 UTC · Final

Independent review **PASS**, no correction.

The alternate rational computation confirms the actual \(r=1/8\) P-node within \(2^{-128}\) of the reported center, including all tails, phases and derivative transport.

[Review report](../../../work/qrh-campaign/agents/mellin/REVIEW_R1OVER8_P_NODE_EXACT_2026-11-11.md)

SHA256: `3F6684C81A95E2ACC9A4BA7EEDC449E0D4D95F0375ABE5AE0A01346AB894C09A`

Single-node paper/external certificate only; no Lean or spectral claim.

## 15:55:51 UTC · Final

Saved the ordered [node-to-contour frontier](../../../work/qrh-campaign/agents/mellin/PRINCIPAL_NODE_TO_CONTOUR_FRONTIER_2026-11-11.md).

It specifies the missing node manifest, coefficient error budgets, whole-panel bounds, winding checks and closed-height multiplicity transfer. Next bounded milestone: one fully rational coefficient-to-panel packet.

SHA256: `F5E5CE83EC1DD110CFBC9CF75B845C63BE2EAFF0D269297FBA2934D92998CDAD`

## 15:58:15 UTC · Final

Saved the [closed-slab inverse blueprint](../../../work/qrh-campaign/agents/mellin/BLOCK_LOCAL_INVERSE_COVER_2026-11-11.md).

Separate inverse candidates per complete slab are valid; unrelated candidates per boundary panel are not. The cost model removes the forced global-dictionary quadratic factor, while retaining unknown local margins, candidate sizes and high-height evaluation costs.

SHA256: `12DBF3F0AD5F56582C1337F3EAD4239C1013BA379C005E98B8F61A6F4FD55491`

## 16:00:47 UTC · Final

[Review report](../../../work/qrh-campaign/agents/mellin/REVIEW_THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md)

Verified the constant 384, all-index tails, pairing and zero modes, derivatives at \(Y=2/5\), and cutoff termination. No numerical theta evaluations or Lean builds.

SHA256: `8C81655B87AA6855AEE4A28D34A8713FFEC95CABEEE8F538E82888A0409304CD`

## 16:21:57 UTC · Final

Sent the source-linked [minimal analytic slice](../../../work/qrh-campaign/agents/mellin/RATIONAL_DISK_MINIMAL_ANALYTIC_SLICE_2026-11-11.md) to integration and root.

Key simplification: integral moments recover the existing disk remainder without iterated derivatives or Cauchy machinery. Actual xi–P identity, quadrature, theta semantics and kernel-checked arithmetic remain required.

SHA256: `140A7211D82CAE13F7C3315B94F49A407066A6CE983D07435722405903F21B68`

## 16:48:21 UTC · Final

Saved the [source/coverage note](../../../work/qrh-campaign/agents/mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md).

The design needs a local zeta winding identity, then transfer to entire `zetaF`. The source argument principle applies with center \(2+i(T-1/16)\), radius \(4\).

Coverage remains conditional on successful panel and winding checks, and concerns only the closed top slab. No evaluations or builds performed.

SHA256: `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5`.

## 17:08:22 UTC · Final

The corollary holds, conditional on the reviewed boundary bounds and closed-slab zero exclusion. Compactness gives an attained reciprocal boundary maximum strictly below \(20/3\); maximum modulus carries that bound throughout the same closed slab.

[Proof note](../../../work/qrh-campaign/agents/mellin/HIGH_SLAB_RECIPROCAL_CONDITIONING_2026-11-11.md)

SHA256: `14E1D33964DB5098C7D07984DE849BCC3B88D55E00CF08EA1C0345D52C775D6B`.

## 17:31:58 UTC · Final

Saved the [long-rectangle analysis](../../../work/qrh-campaign/agents/mellin/PRINCIPAL_LONG_OUTER_RECTANGLE_2026-11-11.md).

The route is sound and removes internal horizontal crossbars. Both horizontal edges have reusable reviewed models. Remaining work is a complete left-edge certificate, shared polygon vertices, and exact winding zero. No boundary margin or successful outcome is assumed.

SHA256: `5B3F2776C576F9716693EBE0F814D7A5A694BDDAD8637CDE6E7D36CFD5AB59DC`.

## 17:43:30 UTC · Final

Review **PASS**, with no correction requested. Scaling, the removable term at \(s=1\), both transform labels and normalizations, EM domains, error bounds, and operation counts check out.

[Independent review](../../../work/qrh-campaign/agents/mellin/REVIEW_FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md)

SHA256: `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64`.

Paper/source validation only; no numerical or family-nonvanishing claim.

## 18:04:42 UTC · Final

Review **PASS** for all stated bounds, with one harmless wording correction: outer correction factors satisfy \(\le T+33<N\), rather than \(<T+33\). Constants are unchanged.

[Review](../../../work/qrh-campaign/agents/mellin/REVIEW_FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md) records 76 independent exact checks.

SHA256: `2D8AA8B58F64AC7DCF82887F6EECAF973F06EC0DD12EC68592F9DD243314C7CF`.

No function evaluations, builds, or spectral conclusions.
