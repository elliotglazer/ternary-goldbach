# major constants — 2026-11-11

## 01:59:19 UTC · Final

Saved the quantitative audit, executable model, and results under `work/qrh-campaign/agents/major-constants`.

The exact cubic budget is

\[
195.03050755\,r+8.79\,u<0.011670451,
\]

assuming the existing L2 and minor-arc bounds survive.

- A hypothetical uniform primitive error \(Cz^{7/8}\) requires \(C<1.27472\times10^{-4}\) for that budget alone.
- Including \(1/\sqrt{\mathrm{conductor}}\) permits \(C<0.0493695\).
- Preserving current intermediate etaPlus bounds requires much smaller coefficients.
- The base-gap consumer requires uniform primitive error \(E/y\le1.54909\times10^{-6}\).
- The proposed Mellin strip estimate gives normalized weighted error approximately \(53.7174\,Z_{\mathrm{strip}}\), far above the current \(4.25\times10^{-7}\) target.

`REPORT.md` contains source references, exact-width L2 inequalities, numerical sensitivity, and remaining obligations. `qrh_budget_model.py` ran successfully and produced `results.json`.

These are exploratory numerical models. No QRH replacement estimate was proved, and no Lean source was modified.

## 02:07:34 UTC · Final

Prepared `AveragedResidual.lean` with exact Parseval residual identities and correct imprimitive Gauss weights. Independent review found no mathematical defect. Compilation remains pending.

The averaged cubic target is

\[
\sqrt{34.99053338496\,A}+\sqrt{8.79\,V}<0.011670451.
\]

Sufficient conservative caps are \(A<9.73116250079\cdot10^{-7}\) and \(V<3.87370382660\cdot10^{-6}\).

The comparison entries provide an explicit multiplicative large sieve. Their Bombieri–Vinogradov and Heath-Brown endpoints have ineffective constants and do not establish these caps at \(x=4.9\cdot10^{26}\).

The modulus-one calculation isolates a weighted zeta-error integral. Uncertified quadrature suggests its Fourier weight is \(52.117147\), allowing a hypothetical QRH coefficient below \(0.296392\) if allocated half the cubic budget. Modulus two adds a related principal contribution.

Full formulas, source references, open interfaces and reproducible calculations are saved in `AVERAGING.md`, `averaging_model.py` and `averaging_results.json` in the owned directory.

## 02:09:59 UTC · Final

Prepared the full-sum transfer with exact character weights preserved.

For \(t=0.01\), the normalized residuals satisfy the proposed bounds

\[
R_+\le1.01E_+ +3.03\cdot10^{-23},\qquad
R_*\le1.01E_* +3.03\cdot10^{-17}.
\]

Exact rational checks show that coprime spectral targets

\[
A_+\le9.6\cdot10^{-7},\qquad A_*+\mathrm{Cross}\le1.88\cdot10^{-6}
\]

leave enough room for the removal errors, including mixed terms.

Saved `FullResidualTransfer.lean`, updated `AveragedResidual.lean`, and added `FULL_TRANSFER.md` plus reproducible rational checks. Compilation is queued through integration. The spectral estimates and Platt-free \(J\le8.79\) remain open.

## 05:18:37 UTC · Final

Saved the reports and reproducible scripts in the owned directory.

- Uniform primitive errors require \(C<0.03282\) using current Fourier bounds; the optional \(1/\sqrt c\) profile is kept separate.
- Hybrid certificate benchmarks require broad conductor coverage unless transform constants improve substantially.
- The explicit large sieve can address high-conductor second moments. Small-conductor cancellation and `Cross` remain unresolved.
- J≤9/10 budgets and removal-transfer margins passed exact rational checks.

No Lean compilation or new analytic proof was claimed.

## 05:30:49 UTC · Final

Saved `ACTUAL_ENERGY.md` and reproducible arithmetic.

Derived a paper proof of the unconditional etaPlus sieve-energy bound
\[
\mathcal L_+(x)\le 2.8\log(2x),
\]
including the complete Gaussian tail.

This supports only a thin conductor range: \(c\ge149900\) contributes at most \(1.31\cdot10^{-8}\log(2x)+10^{-24}\). The bound for \(c\ge140000\) already exceeds the available budget at the initial threshold.

Lean formalization and the finite totient certificate remain pending. No compiler was run.

## 05:50:17 UTC · Final

Saved `WEIGHTED_ZERO_MOMENTS.md` and `weighted_zero_moments.py`.

Mass-only Gram bounds do not close the cubic budget:

- Exact conductor weights require a weighted kernel constant below approximately **0.182**.
- The proposed local principal constant **85** already gives an \(A_+\) bound about **30 times** the allowance.
- Conjugate-character pairing preserves the \((\log c)^2\) mass loss.
- Cross requires additional control beyond second moments.

The next useful analytic lemma is an explicit weighted Gram-row bound using local zero-density or multiplicity information. The principal \(q=1\) method remains promising for its intended lower-\(L^2\) estimate.

No compiler run; numerical thresholds remain uncertified diagnostics.

## 06:12:21 UTC · Final

Saved `BLUEPRINT_AVERAGES.md`.

- Corrected, independently audited budgets now reserve the nonprime subtraction and preserve the \(10^{27}\) endpoint.
- Developed a second-moment route that retains linear zero counts after weighted Cauchy–Schwarz.
- Identified an unconditional alternative \(J(x)<1.4\log(2x)\), requiring the coefficient-energy bridge lemmas.
- Recorded the unresolved explicit density constants, Mellin kernel bounds, Cross estimate, and separate etaU base-gap input.

No complete proof is claimed. No compilation or implementation performed.

## 06:18:13 UTC · Final

Saved `MINOR_ENERGY_TOLERANCE.md` and the exact rational diagnostic.

The existing cells permit:

- **\(a=0.65\)** safely in \(T(x)\le x(a\log x-0.021095)\).
- Even **\(T(x)\le0.65x\log x\)** without the negative offset.

Cell 0 is the bottleneck. Its exact envelope caps are approximately **0.6527044169** with the offset and **0.6523618655** without it.

All other constants, lower \(J\ge8.6296\), and final minor bound **1.0376** remain fixed. Only the coefficient-dependent `sD` and `tau` bounds need recomputation. Rational checks pass; Lean validation remains outstanding.

## 06:24:02 UTC · Final

Saved `BASE_GAP_VARIABLE_BUDGET.md` and exact rational diagnostic script.

Derived, for every \(y\ge10^{25}\),
\[
\widehat g(y,150000)>0.04712,
\qquad
y^{1/8}\bigl(\widehat g(y,150000)-0.000482098\bigr)>79.
\]

The proof uses the explicit formula, a certified endpoint lower bound, and monotonicity of a lower envelope. Existing minor-arc numerics remain unchanged.

This establishes an allowance for a spectral aggregate; proving that aggregate remains separate. Rational checks pass, independent audit requested, no Lean compilation.

## 06:28:00 UTC · Final

Saved `BASE_GAP_BINNED.md` and exact rational certificates.

The all-\(y\) test now covers, among other cases:

- \(50000\le Q\le150000\), \(Q/\varphi(Q)\le1.6\).
- \(120000\le Q\le150000\), \(Q/\varphi(Q)\le1001/192\), including \(Q=120120\).

It uses fixed integration bins, explicit Gaussian remainder bounds, and an affine comparison valid for every \(y\ge10^{25}\). No minor-arc constants change.

Exact checks pass; independent review is underway. The underlying Type I/II Platt dependencies remain separate obligations.

## 06:29:56 UTC · Final

Package complete and counts independently audited:

- Covered: **73,578** denominators, including **8,715 primes** and **64,863 composites**; minimum \(Q=50003\).
- This includes all **49,034** coarse-classifier cases.
- Remaining: **76,422**, including 5,133 primes, 71,288 composites, and \(Q=1\).

Saved count script/JSON and updated `BASE_GAP_BINNED.md`.

The raw tangent refinement additionally handles \(Q\ge90090\), \(Q/\varphi(Q)\le1001/192\), and \(D\ge13200000/49\), with margin \(>0.000786242533\). Smaller twists remain unresolved, so this does not increase the all-twists count. Type I/II replacement and Lean certification remain open.

## 06:34:56 UTC · Final

Saved [word-costs.md](../../../work/mm0-fermi/word-costs.md).

A selected-shift certificate might reduce coverage from roughly 100 to 15 masks per 64 targets. However, recording each sieve strike still produces enormous costs: illustrative models range from 43,000 to 2.16 million core-years, depending on proof-event accounting.

The report separates arithmetic operations, theorem applications, kernel events, and proof volume. Achieving 3–100× native overhead requires substantial batching beyond word-sized arithmetic; none of these multipliers is currently measured.

## 07:23:50 UTC · Final

Completed [REPORT.md](../../../work/formal-goldbach-bench/lean/REPORT.md), reproducible scripts, raw results, and hash manifest.

- Best observed: **12.97 ns per target**, using 262,144-bit packed multiplication.
- At 65,536 bits: direct checking **1.75–1.80 ms**, packed checking **0.986–1.010 ms**.
- Strict kernel checks accepted valid proofs and rejected corruptions.
- Reported axioms: `[propext]`; no custom axioms or `native_decide`.

These certify numerical coverage calculations. Prime certification, packing correctness, and full Goldbach assembly remain unmeasured and unproved here.

## 09:21:25 UTC · Final

Saved [research report](../../../work/qrh-campaign/agents/major-constants/RESUME_MAJOR_2026-11-11.md) and exact arithmetic script.

A certified conductor-3 zero-free rectangle \(\beta>0.64,\ |\gamma|\le14{,}000{,}000\), with the identified analytic lemmas, would give:
- Entire induced \(A_+\) block \(<7.670\times10^{-8}\).
- Nonprincipal energy block \(N_3<0.029\).

Existing Jensen bounds offer a fallback requiring \(\beta>0.6\). Exact scalar checks passed; the finite certificates and analytic bridges remain unproved. Independent review requested.

## 09:43:18 UTC · Final

Saved [full-family report](../../../work/qrh-campaign/agents/major-constants/RESUME_FAMILY_CAPS_2026-11-11.md) and reproducible exact checks.

The selected finite strip \(\beta\le111/200\), through the conductor-specific heights, suffices on paper for all required second-moment caps. The mixed remainder is \(<2\times10^{-10}\).

New ingredients include the actual etaU Gram bound and \(|P|\le32/35+.00221\). Exact arithmetic passed; independent review found no defect so far. Analytic formalization and complete finite zero certification remain open.

## 09:59:54 UTC · Final

Frozen the [cutoff report](../../../work/qrh-campaign/agents/major-constants/RESUME_CUTOFF_OPTIMIZATION_2026-11-11.md) and exact checks.

- Proposed floors: plus500, star250; all budgets still fit with mixed remainder \(<3\times10^{-8}\).
- Weighted-height proxies fall below55.5% and25.1% of their previous values.
- Separately verified: the original profile’s \(E_p\) estimate supplies lower \(J>8.6296\), eliminating the separate local kernel certificate in that route.

Mellin is reviewing the frozen files. The original profile remains selected; no finite zeros are certified.

## 10:15:05 UTC · Final

Independent review passed; no mathematical defect found.

The weighted alternative preserves all reviewed major-arc caps uniformly for \(x\ge4.9\times10^{26}\), while retaining the conductor-one condition needed elsewhere. Exact replay passed.

Saved [review and frozen hashes](../../../work/qrh-campaign/agents/major-constants/RESUME_WEIGHTED_REVIEW_2026-11-11.md). Finite spectral certification, analytic Lean bridges, and computational savings remain unproved.

## 10:32:23 UTC · Final

The psi refinement passes independent review. Exact replay gives \(0.009798011781002001<0.00981\), with a valid transition to the existing bound at \(\exp(35)\).

Saved [review](../../../work/qrh-campaign/agents/major-constants/RESUME_PSI_LOW_REVIEW_2026-11-11.md). The conditional route leaves \([10^9,5\times10^9)\) unresolved. Low-zero certification and analytic formalization remain open; optional \(W_9\) feasibility is unproved.

## 10:51:44 UTC · Final

Saved the [domain report and exact exception artifacts](../../../work/qrh-campaign/agents/major-constants/PLATT_DOMAIN_COMPARISON_2026-11-11.md); independent review requested. These exceptions concern published coverage, not the truth of the finite \(.555\) assertion.

## 11:13:50 UTC · Final

The minimum profile
\[
H_{\rm cert}(c)=\min(H_{+,\rm old}(c),10^8/c)
\]
preserves every selected major-arc budget, conditional on the finite \(\beta\le.555\) certificate and listed analytic bridges.

- Added plus-tail energy \(<.025\).
- Mixed remainder norm \(<.000160001\).
- Full Cross \(<4.357\times10^{-7}\).
- \(A_\star+\mathrm{Cross}<9.5\times10^{-7}\).
- Upper \(J\le10\) and lower \(J>8.6296\) remain available.

Independent review reproduced all 5,303 rational cells and weighted aggregates. No zeros were certified; no Lean builds or canonical changes were made.

[Report](../../../work/qrh-campaign/agents/major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md) · [Exact script](../../../work/qrh-campaign/agents/major-constants/resume_common_height_major_20261111.py)

Final report SHA256: `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7`.

## 11:24:21 UTC · Final

Review passes with no required correction.

- The exact counting identity has no finite-count calibration.
- Jensen multiplicities, argument branches, Gamma normalization and closed-height limits are sound.
- Independent rational arithmetic gives \(W_{35}\le23.989158676444<24\).

The finite spectral certificates and listed analytic Lean bridges remain open.

[Review](../../../work/qrh-campaign/agents/major-constants/RESUME_PSI_ANALYTIC_COUNT_REVIEW_2026-11-11.md)

SHA256: `82B2A416EAE9E4F16F8147C92776AB7D5063355E3EABE828615281AA64D8C418`.

## 11:52:25 UTC · Final

Created the [source ledger](../../../work/qrh-campaign/agents/major-constants/RECTANGLE_CHECKER_SOURCE_LEDGER_2026-11-11.md).

The pinned source already proves the generic rectangle argument principle. The recommended missing bridge uses local logarithms and shared-vertex telescoping, followed by an exact half-open ray-crossing theorem. This avoids the moving-basepoint problem in a direct homotopy approach.

The ledger separates existing APIs from the remaining evaluator, Euler–Maclaurin, Taylor-coefficient, crossing and carrier proofs. Arb outputs remain external evidence.

SHA256: `93A2B60572F8D02E1EF47BD6672DA01D21F70927C1D8DB3EF36930E2436EA91A`.

## 12:03:47 UTC · Final

Saved [the complete paper proof](../../../work/qrh-campaign/agents/major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md).

It covers exact half-open crossings, degenerate edges, logarithm cancellation, rectangle orientation, and analytic multiplicity counts. Formalization and numerical enclosure proofs remain open.

SHA256: `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B`

## 12:13:09 UTC · Final

Saved [EM_SOURCE_PROOF_PLAN_2026-11-11.md](../../../work/qrh-campaign/agents/major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md).

It derives the actual head and c5 formulas, remainder bounds, continuation domains, and common-pole cancellation at \(s=1\), separating existing APIs from new proof obligations.

SHA256: `A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`

The expanded polygon proof also passed independent review without corrections.

## 12:30:25 UTC · Final

Exact replay passed. The remaining strip can widen to **[0.4968, 0.5032]** for \(1500<|\gamma|\le10^6\), giving \(W_{35}<23.980532761132<24\).

Saved [the proof and results](../../../work/qrh-campaign/agents/major-constants/PRINCIPAL_HIGH_STRIP_REFINEMENT_2026-11-11.md) and sent them for independent review. The higher strip remains unproved; no exact count at \(10^6\) was assumed.

## 13:06:05 UTC · Final

Independent review passed for the count identity, auxiliary-weight bound, integer saturation, and closed-endpoint addendum.

[Review note](../../../work/qrh-campaign/agents/major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md)

SHA256: `3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58`

The explicit Turing bound and full-family numerical certificates remain unresolved.

## 13:18:18 UTC · Final

Saved [EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md](../../../work/qrh-campaign/agents/major-constants/EM_FINITE_COEFFICIENT_SEMANTICS_2026-11-11.md).

It derives the exact coefficient recurrences, analytic Taylor identification, and outward-rounded interval enclosure proof for both producers. No numerical rerun or Lean build occurred.

SHA256: `ADE7149EE7D5C3586A2AA7267C39363828747D801DE5EF1F4508A21B737F69D3`

## 13:39:55 UTC · Final

Saved [the blueprint](../../../work/qrh-campaign/agents/major-constants/GABCKE_K0_ANALYTIC_BLUEPRINT_2026-11-11.md).

New paper reduction gives \(0.45t^{-3/4}<0.47t^{-3/4}\) for \(t\ge1500\), using only the first-order remainder. Exact rational checks pass.

This avoids R10 and high-order coefficient tables. Contour identities, Gaussian bounds, Gamma-phase control, and Lean formalization remain open. Frozen hashes sent for independent review.

## 13:56:21 UTC · Final

Saved the [simple-phase evaluator plan](../../../work/qrh-campaign/agents/major-constants/SIMPLE_PHASE_K0_EVALUATOR_2026-11-11.md) and exact scalar receipts.

The paper assembly gives error \(<.451t^{-3/4}<.47t^{-3/4}\) for every \(t\ge1500\), without the sharp Gamma-phase estimate. Mordell parameter 2 is included.

Sent frozen artifacts for independent review. Analytic formalization and checker soundness remain open.

## 14:14:57 UTC · Final

Saved [the K1 remainder proof plan](../../../work/qrh-campaign/agents/major-constants/K1_REMAINDER_PROOF_PLAN_2026-11-11.md) and sent it for independent review.

The paper derivation gives \(|RS_1|<4.2\tau^2\) for all \(t\ge1500\), including endpoint cancellation and explicit Gaussian tails. Upstream contour identities and Lean formalization remain separate obligations.

## 14:23:03 UTC · Final

Saved the [coefficient contour join](../../../work/qrh-campaign/agents/major-constants/K0_COEFFICIENT_CONTOUR_JOIN_2026-11-11.md) and sent it for review.

It preserves the nonzero B0 endpoint arc, matches both fixed coefficients to the source contour, then removes the residual arc after subtraction. No frozen files changed.

## 14:34:45 UTC · Final

Independent FFT review **PASS; no corrections required**.

Saved [the review](../../../work/qrh-campaign/agents/major-constants/REVIEW_FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md). Sixteen exact scalar checks passed.

The \(d\le36\) cap remains restricted to the fixed-Hcert example. Actual packets, checked traces, and Lean implementation remain open.

## 14:43:24 UTC · Final

Saved the [arbitrary-height rounding extension](../../../work/qrh-campaign/agents/major-constants/AUXILIARY_FFT_ROUNDING_EXTENSION_2026-11-11.md), exact constructor, and receipt.

The rule terminates for every finite stage count and positive rational tolerance. For \(N=2^{37}\), it selects 147-bit rounding, 32 Machin terms, and Taylor degree 53.

Sent for independent review. No FFT or spectral data were generated.

## 14:52:03 UTC · Final

Saved the [slab assembly proof plan](../../../work/qrh-campaign/agents/major-constants/FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md) and sent it for review.

It covers closed seams, exact finite coverage, multiplicity counts, character labels, and shared-polygon cancellation. It makes no full-strip claim from the isolated conductor-101 pilot.

## 14:55:18 UTC · Final

Independent review passed without corrections.

Saved [review](../../../work/qrh-campaign/agents/major-constants/REVIEW_DIRECT_STRIP_EVALUATOR_CONVERGENCE_2026-11-11.md), SHA256 `B357FCAC4F2FFFE9349A7872DB0EC0B86B02870EDA29FA5379C1749D98C4BD5E`.

Checked the complete source, Abel boundary term, derivative bound, rational cutoff, and shared-vertex convergence. Exact arithmetic confirms the illustrative cutoff `N=2^107`.

This establishes a paper convergence argument, not spectral truth or a Lean implementation.

## 15:03:16 UTC · Final

Saved the [full-family workload model](../../../work/qrh-campaign/agents/major-constants/FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md).

It includes exact counts, height-weighted sums, parameterized sampling costs, a shared-transform design, and memory/sharding requirements. Unknown spectral margins and required precision prevent a throughput estimate.

SHA256: `3A5444AB295112E86DF0740DB8F4533EC37510A66E41EB0DF0340D16CF82A4E1`

Sent to mellin_strip for independent review.

## 15:07:43 UTC · Final

Saved the [joint batching plan](../../../work/qrh-campaign/agents/major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md), SHA256 `3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D`.

It derives off-critical normalization, shared theta buckets across characters and σ, correct negative-frequency factors, both transform-error budgets, and conditional workload counts. All 32 tiny exact algebra checks passed.

Sent to mellin_strip for independent review. No spectral values or production FFTs were computed.

## 15:11:10 UTC · Final

Independent review passed without required corrections.

Saved [review](../../../work/qrh-campaign/agents/major-constants/REVIEW_NONPRINCIPAL_THETA_MODULAR_BUCKETS_2026-11-11.md), SHA256 `FB6A7BD014A4417CD4D3AD2460C0785EDE3838226AA6F9013248863FB3135E70`.

Checked characteristic phases, odd-moment signs, branches, tails, and parity reconstruction. All 2,266 exact algebra checks passed. No numerical theta values or performance claims were certified.

## 15:29:04 UTC · Final

Saved [review](../../../work/qrh-campaign/agents/major-constants/REVIEW_PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md), SHA256 `FB75E5919ECFD5F7800290C64DD1C0DFFCA7EA4FDFAE4B5FB4BFBBF4B3B27DAD`.

Checked fixed-b normalization, signed nodes, error substitution, derivative thresholds, Taylor factorials, panel bounds, and recovery scaling. All 99 exact algebra checks passed. Actual node certificates and Lean adapters remain open.

## 15:34:16 UTC · Final

[Review report](../../../work/qrh-campaign/agents/major-constants/REVIEW_COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md)

SHA256: `2BD81A05B6C84A27149C1BEE5827B4918DD4F7F454AB799B1DEA8E954398F9DC`

Verified source APIs, compact comparison, cancellation, signed rounding and arithmetic witnesses. Independent exact tests passed. Acceptance covers the paper plan only; Lean implementation and actual receipt replay remain open.

## 15:39:37 UTC · Final

Both reviews are frozen:

- [Compact receipt review](../../../work/qrh-campaign/agents/major-constants/REVIEW_COMPACT_DYADIC_RECEIPT_PILOT_2026-11-11.md): confirms partial status, including 14 translation and 3 quotient failures.
- [First-edge diagnosis review](../../../work/qrh-campaign/agents/major-constants/REVIEW_MODULAR_ENDPOINT_EXPORT_DIAGNOSIS_2026-11-11.md): independently confirms export rounding explains that one translation failure.

The full receipt remains unrepaired. No analytic enclosure or Lean acceptance is claimed.

## 15:52:27 UTC · Final

The weighted-excess alternative passed independent review.

It retains uniform `.555` control for `c≤100000` and permits weighted excess `K≤6` above that threshold. All selected bounds still fit, including `Astar+Cross<9.388e-7` and the base gap.

[Research note](../../../work/qrh-campaign/agents/major-constants/WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md)

This weakens the required spectral information but does not yet establish cheaper certification or justify skipping whole character rows. The selected strategy remains unchanged.

## 15:57:38 UTC · Final

Saved the [density feasibility report](../../../work/qrh-campaign/agents/major-constants/WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md) and exact arithmetic checker.

The inspected explicit estimates do **not** establish \(K\le6\). Ramaré’s additive term alone produces a comparison bound above \(3.69\times10^{15}\). This limits those estimates, not all possible analytic approaches.

Exact density integral, endpoint conventions, dependencies, and necessary count thresholds are recorded. Frozen pins sent to the independent reviewer; selected strategy unchanged.

## 16:00:08 UTC · Final

The proposed tail bound is valid for all \(\operatorname{Im}(v)\ge2/5\) and derivative orders \(0,1,2\).

Saved the [source-supported proof](../../../work/qrh-campaign/agents/major-constants/THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md), including exact indices, zero modes, termwise differentiation, and a terminating rational cutoff rule.

SHA256: `478DEDD2DC613670A5B2E6ECA18317733006D82CDE06860719302301B80FFE88`

Sent to mellin_strip for independent review. No builds or numerical theta evaluations.

## 16:20:40 UTC · Final

Saved the [production-scaling note](../../../work/qrh-campaign/agents/major-constants/PRINCIPAL_PILOT_PRODUCTION_SCALING_2026-11-11.md) and sent findings to root and integration.

The first obstruction is precise: the pilot’s unchanged quadrature error bound exceeds 1 for work heights \(T\ge2048\). Retuning also requires new spatial-tail, Taylor-degree, and modular-transport budgets.

This does not rule out a redesigned evaluator. No production computation or timing estimate was made.

## 16:32:01 UTC · Final

Saved the [complete scalar production plan](../../../work/qrh-campaign/agents/major-constants/PRINCIPAL_PRODUCTION_SCALAR_PLAN_2026-11-11.md), script, and receipt.

Both heights have a conditional disk-error bound below \(1/63<0.1\). The conservative choices require 625,000,626 and 56,119,044,871 nonnegative nodes, respectively.

Actual node/weight certificates and spectral margins remain unproved. No production evaluation or runtime estimate was made. Sent to root, integration, and the independent reviewer.

## 16:44:24 UTC · Final

Exact scalar checks pass. The analytic quotient-error bound remains below \(2^{-42}\), including the square-box \(\sqrt2\) factor.

Saved the [supporting note](../../../work/qrh-campaign/agents/major-constants/HIGH_PRINCIPAL_SLAB_SCALAR_SUPPORT_2026-11-11.md), checker, and receipt; sent pins to root and moebius_route.

No function values or spectral margins were evaluated.

## 17:24:49 UTC · Final

Saved the [vertical-batching scalar support](../../../work/qrh-campaign/agents/major-constants/EM_VERTICAL_BATCH_SCALAR_SUPPORT_2026-11-11.md), exact checker, and receipt.

With 32 residual terms, the weighted panel quotient error is below \(2^{-100}\), including an explicit conditional transform-error allocation. With 48 terms, each individual jet tail is below \(2^{-120}\).

Counts and normalization requirements are recorded. No transforms, function values, or spectral margins were computed.

## 17:26:05 UTC · Final

Corrected \(128/63\) to \(16/7\) for \(\rho\le1/8\). Exact checks still give batching error below \(2^{-100}\) and combined slab error below \(2^{-42}\).

Updated pins sent to root, moebius_route, and zero_sum for review.

## 17:43:30 UTC · Final

Frozen scalar plan and receipt sent to root, moebius, integration, and independent reviewer.

The eight-center pilot’s complete quotient-error budget is **<2⁻⁴⁴**, within the requested 2⁻⁴⁰ allowance. All correction terms and coordinate-box losses are included. No function or FFT evaluations were run; independent review is pending.

## 17:48:15 UTC · Final

Corrected and re-frozen the note: `47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23`.

The coordinate bound now applies to vertical offsets; fixed-pilot failures require rejection. Script, receipt, and numerical budgets are unchanged. All four collaborators received the updated pin.

## 18:02:49 UTC · Final

Frozen the uniform finite-\(U\) scalar derivation and sent it for independent review.

For \(c\le300000\), \(cT\le10^8\), the rule \(M=16\), \(N=\lceil T\rceil+36\), \(K=30\) gives full-disk EM-plus-Taylor error **<\(2^{-69}\)**. All 57 exact checks pass. Numerical coefficient certification and spectral margins remain open.

## 18:42:07 UTC · Final

Frozen the rational elementary budget and sent it for independent review. All 29 exact scalar checks pass.

The specified log, pi, exponential, FFT, and correction bounds meet the fixed pilot’s tolerances. This requires exact rational arithmetic between named rounding gates. Actual receipt containment and checker costs remain unproved.

## 19:22:39 UTC · Final

Completed and froze the c8 independent pole-jet plan. All 15 exact scalar checks pass.

The separate recurrence has amplification below \(2^{88}\). The specified accuracy gates give pole error below \(2^{-134}\) and complete independent coefficient error below \(2^{-128}\). Independent review is pending; no values were evaluated or saved data accepted.

## 19:28:28 UTC · Final

Completed the inner-rounding allocation and sent it for independent review. All 25 exact checks pass.

It preserves the accepted elementary error interfaces while bounding the specified pre-gate denominators below 2,100 bits. No function values were evaluated, and no runtime improvement is claimed.

## 19:40:57 UTC · Final

Static arithmetic review passed for the frozen producer and independent checker. No corrections required.

[Review](../../../work/qrh-campaign/agents/major-constants/REVIEW_RATIONAL_DIRECT_G_J7_ARITHMETIC_CODE_2026-11-11.md)

SHA256: `CA2693F85775FEB9244F74AEE698000FFA57EF844EB613C982DCC8D436859AAD`

No evaluator was imported or run. Executed containment checks, negative controls, and resource certification remain outstanding.

## 19:47:24 UTC · Final

Derived and independently reviewed the full operand bound. Both frozen programs fit the 65,536-bit cap on intended inputs:

- Raw helper arithmetic: at most 52,001 bits.
- Rounding witnesses: below 27,090 bits.

[Proof note](../../../work/qrh-campaign/agents/major-constants/RATIONAL_J7_FULL_OPERAND_BOUND_2026-11-11.md)

Independent review passed without correction. No evaluator was run; runtime and containment remain unproved.

## 20:01:34 UTC · Final

Frozen schema review passed after repairs.

[Review](../../../work/qrh-campaign/agents/major-constants/REVIEW_RATIONAL_J7_SUPERVISOR_RESULT_SCHEMA_2026-11-11.md)  
SHA256: `1924FE111A11261E919C847906C6CB9A955464AEED56948CFBDE7BF423FE280F`

Bound to common module `FA073C19…`. No code was executed. Arithmetic truth and full process supervision remain separate obligations.

## 20:04:53 UTC · Final

Completed both reviews.

- **P4 reduction: PASS**, conditional on the stated open analytic and finite-certificate obligations. All 22 independent rational checks passed.
- **Supervisor schema:** rebound to `0BB49255…`; the sole added PID assertion leaves the reviewed result-schema functions unchanged.

P4 review SHA256: `1C7975F10CB8EE7F4F8D755F9DFC284D439D788C01496D598D9EC7A9500349FB`.

No Lean builds or evaluator runs.

## 20:08:41 UTC · Final

Saved the [smoothing continuity join](../../../work/qrh-campaign/agents/major-constants/ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md) and sent it for independent review.

It supplies explicit Mellin moment bounds, parameter continuity, derivative formulas, and the etaU Fubini/admissibility argument. Sharp numerical bounds remain unchanged.

SHA256: `DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D`. No builds or numerical evaluations.

## 20:23:18 UTC · Final

Saved and sent the frozen consumption join for independent review.

It derives the actual coprime-to-full transfer and cubic lower bound **1.040492451 > 1.0404**, preserving the nonprime reserve. A new bound, `∫Estar < 10001`, removes the older transfer’s dependence on `MinorTotal`’s uniform-star estimate.

All 17 rational checks passed. Spectral inputs and Lean implementation remain open.

SHA256: `280FDC53E61066E050DD98D4A004A9435510CC67686A59354750E0F7DE188F64`.

## 20:23:51 UTC · Final

Confirmed: the shared `[.445,.555]` strip suffices for the P4 smoothing argument.

- The endpoint factor remains `<1.002` by a new elementary bound.
- The Gaussian prefactor only needs `0<β<1`.
- Intermediate, high-tail, vertical and desmoothing estimates need no narrower strip.
- The argument for `x≥exp(35)` already uses the shared strip.

Given the proposed reciprocal bound `151/3`, the weighted moment is `<18271/48<381`. That new reciprocal bound itself was not independently checked in this pass.

## 20:29:00 UTC · Final

Frozen [scalar budget](../../../work/qrh-campaign/agents/major-constants/PSI_DAMPED_SCALAR_BUDGET_2026-11-11.md).

The uniform bound closes at **0.009569927135481 < 0.0096**, using RH through 1500, the shared `[.445,.555]` strip, and existing tail assumptions. The proof covers the continuum analytically; no sampled zeta values or new spectral claims.

Exact script/receipt passed. Frozen hashes sent to root, prime_estimates, and independent_feasibility for review.

## 20:36:51 UTC · Final

Saved [formalization plan](../../../work/qrh-campaign/agents/major-constants/DAMPED_PSI_FORMALIZATION_PLAN_2026-11-11.md), hash `E76C233D…707B01E`.

It supplies the finite real-abscissa Abel proof, replaces improper Gaussian integrals with finite bounds, and orders the source joins through the actual psi sandwiches. Sent to independent_feasibility for review. No builds or evaluations.

## 20:41:18 UTC · Final

Frozen [high-conductor profile](../../../work/qrh-campaign/agents/major-constants/HIGH_CONDUCTOR_REAL_PART_PROFILE_2026-11-11.md).

At unchanged heights, `.565` above conductor 100000 is sufficient:

- `Astar + Cross < 9.36859032001e-7 < 9.5e-7`.
- Affected pointwise base-gap bound `< .0026`.
- Updated removal bounds preserve both J bounds and major `1.0404`.

Exact scalar checks passed; independent review requested. No spectral certification or runtime saving is claimed.

## 20:49:54 UTC · Final

Saved the [bounded audit](../../../work/qrh-campaign/agents/major-constants/QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md).

No defect found in the inspected induction or exponent accounting. Exact unresolved analytic dependencies are listed; global QRH remains unvalidated. Sent frozen hash `C04D05F9…8D695` for independent review. No builds or evaluators run.

## 20:54:17 UTC · Final

Saved [prime-bin audit](../../../work/qrh-campaign/agents/major-constants/QRH_PRIME_BIN_ANALYTIC_AUDIT_2026-11-11.md).

No defect found in the inspected chain. The estimate uses the actual zero supremum without assuming `beta ≤ 7/8`. Deeper analytic foundations remain explicitly unvalidated.

SHA256: `17767311F6AD4213FFD9A8A2C9678CC2AE73F1829CC27672128CF10211B49C7E`

Sent to independent review. No builds or numerical evaluations.

## 21:03:19 UTC · Final

Saved [canonical rank audit](../../../work/qrh-campaign/agents/major-constants/QRH_CANONICAL_RANK_ANALYTIC_AUDIT_2026-11-11.md).

No local defect found in the actual child-rank decrease, margin transport, or induction budget. The underlying short-energy saving and two-pass analytic estimates remain unvalidated.

SHA256: `2767A7CC08CC13239EFDBC5242D47505FC44028016251407B21A542CDC98FF4B`

Sent for independent review. No builds or numerical evaluations.

## 21:10:28 UTC · Final

Frozen [short-energy audit](../../../work/qrh-campaign/agents/major-constants/QRH_SHORT_ENERGY_ANALYTIC_AUDIT_2026-11-11.md).

SHA-256: `F45A59471E8A762710AF1F25CD74576E87C9061E4AE592A9B8682ABC6FCF1420`

Reconstructed the actual hybrid estimate, initial `cstar/4` gain, and paid losses yielding `cstar/256`. No mismatch found within scope. Deeper sieve, Fourier/Mellin, local arithmetic and rapid-tail estimates remain unvalidated. Independent review requested; no builds or analytic evaluations performed.

## 21:12:15 UTC · Final

Frozen [cubic-improvement audit](../../../work/qrh-campaign/agents/major-constants/QRH_CUBIC_IMPROVEMENT_ANALYTIC_AUDIT_2026-11-11.md).

SHA-256: `1727E899339761F828A0D5B56F776884C63E9BB810EF5E0606C9E88E85AC10BD`

Reconstructed the improvement through cube extraction, Poisson summation, dyadic decay and divisor losses. No local defect found. Deeper analytic inputs remain explicit; independent review is pending. No builds or analytic evaluations performed.

## 21:14:47 UTC · Final

Frozen [quadratic audit](work/qrh-campaign/agents/major-constants/QRH_QUADRATIC_PRODUCT_COLUMN_AUDIT_2026-11-11.md), sent for independent review.

No local defect found. Repeated products cost one divisor factor; bad-prime sectors cost four. The sharp sieve’s masked-Poisson and scalar-majorant foundations remain unvalidated.

SHA256: `9E4A104441FA0B154132CF3F1AAE9E560EBD34EC368BB77484EAB38F3EEF758B`.

## 21:32:52 UTC · Final

Review frozen: [principal-residue review](../../../work/qrh-campaign/agents/major-constants/REVIEW_QRH_PRINCIPAL_RESIDUE_AUDIT_2026-11-11.md).

PASS within bounded source/math scope; no corrections. All 13 author source hashes match. Residue sign, period cancellation, trivial quotient, and poleRemoved normalization check out. No provider-validation claim.

## 21:34:57 UTC · Final

Frozen [independent review](../../../work/qrh-campaign/agents/major-constants/REVIEW_QRH_RADIAL_FOURIER_ENVELOPE_AUDIT_2026-11-11.md): PASS within bounded source/math scope, no corrections.

All eight source hashes match. Kernel normalization, Euler derivatives, scale uniformity, weighted bounds and shared-window quantifiers check out. No provider-validation claim.

## 21:38:09 UTC · Final

Frozen review: [REVIEW_QRH_DIRICHLET_FAMILY_BRIDGE_AUDIT_2026-11-11.md](../../../work/qrh-campaign/agents/major-constants/REVIEW_QRH_DIRICHLET_FAMILY_BRIDGE_AUDIT_2026-11-11.md).

PASS within bounded source/math scope; no corrections. All 27 author source hashes matched. Global provider validation remains open.

SHA256: `F0F28145AA2232CB9ED5B76BA1C48485763725A0841FD077C0A1E3030DAA07E5`

## 21:40:04 UTC · Final

Frozen review: [REVIEW_QRH_LOCAL_GAUSS_CHARACTER_AUDIT_2026-11-11.md](../../../work/qrh-campaign/agents/major-constants/REVIEW_QRH_LOCAL_GAUSS_CHARACTER_AUDIT_2026-11-11.md).

PASS within bounded source/math scope; no corrections. All 13 author source hashes matched. No builds or evaluations performed.

SHA256: `9AF6579598742F09593A93BBE5F380C54D89A89CCE64DFC94F49893D115C8B7E`

## 21:42:37 UTC · Final

Review frozen: **PASS within bounded source/mathematical scope**, no corrections. All 22 author source hashes matched.

[Review report](../../../work/qrh-campaign/agents/major-constants/REVIEW_QRH_RAY_NORMALIZER_PRODUCTION_AUDIT_2026-11-11.md)

SHA256: `64051835DEA4012784320B9660964910754C2FCB8AE7E5C33D84784B6F0BF2D1`

No builds or evaluations performed; deeper analytic foundations and full-provider validation remain outside scope.

## 21:44:43 UTC · Final

Both independent reviews are frozen: **PASS within bounded source/mathematical scope**, no corrections.

- Whole-product separation: `34369ACB02CDA010DC918B5E96F9D9B2090E0E7E845D882BBBA2F92AF20543DB`
- Live-allocation common energy: `38A1C08D554CBCC09631164ECB604255C4BCFD44D691E89E524AF25B4953E74F`

All source pins matched. Child-energy estimates and deeper foundations remain explicit dependencies; no builds or evaluations were performed.

## 22:36:14 UTC · Final

Frozen [threshold report](../../../work/qrh-campaign/agents/major-constants/EFFICIENCY_ANALYTIC_THRESHOLD_2026-11-11.md).

Raising \(N\) improves nonprime margins but establishes no spectral savings. Halving the original heights already fails an explicit major-arc hypothesis. Extending finite coverage also requires a new ladder design.

Exact scalar checks passed; no builds or analytic evaluations.

## 22:44:35 UTC · Final

Frozen [report](../../../work/qrh-campaign/agents/major-constants/EFFICIENCY_LOWER_ANALYTIC_THRESHOLD_2026-11-11.md), SHA256 `99D06335…B860F786`.

- \(N_0=9.89\times10^{26}\) preserves all existing major/minor scale bounds and nonprime positivity.
- Truncating the ladder removes 684 checking chunks: 2,801,664 checked rungs.
- Larger reductions fail existing scalar envelopes; they require new complete estimates.
- Exact scalar checks passed. Independent review is pending. No Lean builds, source changes, or analytic evaluations.

## 23:04:02 UTC · Final

Frozen [frontier report](../../../work/qrh-campaign/agents/major-constants/EFFICIENCY_JOHNSTON_FINITE_RH_FRONTIER_2026-11-11.md), SHA `0305EF19…617DF`.

Conditional result: \(H=4·10^{10}Q\), theta coefficient \(0.031+2.261/Q\), \(1≤Q≤50\). Existing head data suffice; no new 5000-zero certificate or hidden \(3·10^{12}\) bootstrap.

Independent scalar/continuum review passed. Hidden-input review remains pending. Full RH/checker and Logan formalization costs remain explicit; no net efficiency improvement is claimed.

## 23:12:51 UTC · Final

Frozen [adaptive-chain report](../../../work/qrh-campaign/agents/major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md), SHA `77ADA365…93785`.

It gives exact gap/endpoint coverage, compact adaptive indices, and a 44-square supplied-root batch certificate requiring no progression or gcd checks. It also compares direct roots and indexed batches, including payload, CRT generation and operand-size costs.

Exact geometry checks passed. No primes were searched or certified; independent review is pending.

## 23:20:37 UTC · Final

Frozen [grouped-order report](../../../work/qrh-campaign/agents/major-constants/EFFICIENCY_GROUPED_ORDER_ROOTS_2026-11-11.md), SHA `94CEE16A…8F5C4`.

It proves the lcm-order criterion without assuming \(F\mid n-1\), and gives exact schedule tradeoffs. For the first portfolio modulus, 1/4/10 roots cost 184/92/70 counted modular operations, with increasing witness and CRT costs.

Integer checks passed; independent review is pending. No timing optimum or production success is claimed.
