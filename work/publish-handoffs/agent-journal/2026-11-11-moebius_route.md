# moebius route — 2026-11-11

## 01:59:00 UTC · Final

Saved the audit and runnable numerical experiment in `work/qrh-campaign/agents/moebius/consumer-tolerances.md` and `consumer_tolerances.py`. Python execution succeeded.

- The Möbius profile below \(10^8+1\) already follows from unconditional finite certificates. It needs no replacement prime estimate.
- Liouville’s existing arithmetic tolerates \(|m(x)|\log x\le 0.36\), comfortably above its current input \(0.14\).
- G2 is much tighter. Keeping the certified \(0.03\) profile below \(10^8+1\), a uniform bound afterward must be at most approximately \(0.09176155\) to preserve existing certificates.
- Recomputing G2 in a floating-point model raises that threshold only to approximately \(0.09235\). This estimate omits certificate rounding and requires exact verification.
- The tail induction’s prime-error coefficient can rise from \(0.00985\) only to approximately \(0.01093079\).

A concrete QRH integration route is to generalize `eps_piece` and `eps_last` to the decreasing relative envelope \(C e^{-L/8}L^2\), then regenerate the existing Schoenfeld cells. Even the experimental coefficient \(C=1\) reaches the current tail target only near \(L=158.55\). The interval between the finite Möbius coverage near \(10^8\) and that crossover remains an unresolved mathematical obligation.

No Lean compilation or newly proved replacement estimate was produced.

## 05:34:50 UTC · Final

Saved work under `work/qrh-campaign/agents/moebius`.

- `FinitePsiCore.lean` and `FiniteBoundary.lean` contain uncompiled candidates removing Platt dependence from the finite boundary chain, preserving \(12 \le Y < 10^9\). The core requires 11 project modules.
- `g2_exact_replay.py` reproduced the original integer certificates exactly. With `tailV = 59100 × 10^16`, it gives \(G2 \le 0.0088846711 < 0.0089\), sufficient to preserve \(T_2 \le 0.37273\).
- `G2RelaxedNumeric.lean` contains the corresponding arithmetic proofs, awaiting compilation. The proposed Möbius bound \(0.10/\log x\) above \(10^8+1\) remains unproved.
- `consumer-tolerances.md` records the calculations and unconditional global bounds. In particular, \(\theta(x)\le x\log4\) is available globally; the global \(1.03883x\) bound for \(\psi\) still uses Platt.

No compiler was launched or source repository modified. Ready for reactivation when the compiler slot becomes available.

## 06:13:11 UTC · Final

Saved [BLUEPRINT_MINOR_FINITE.md](../../../work/qrh-campaign/agents/moebius/BLUEPRINT_MINOR_FINITE.md).

- Profile \(0.10/\log x\) above \(10^8+1\) suffices to preserve \(T_2\le0.37273\), supported by exact external G2 arithmetic.
- Concrete unconditional route identified for retaining \(E\le8\cdot10^{-11}x\).
- Finite psi extraction preserves the full existing boundary-helper range.
- Original binary input \(4\cdot10^{18}\) and final threshold \(10^{27}\) remain unchanged.

The unresolved analytic bridge is explicit. No Lean compilation or source implementation this round.

## 06:19:56 UTC · Final

Completed and independently reviewed [EBOUND_UNCONDITIONAL.md](../../../work/qrh-campaign/agents/moebius/EBOUND_UNCONDITIONAL.md).

The unconditional derivation preserves the exact endpoint and conclusion:
\[
x\ge4.9\cdot10^{26}\implies E(x)\le8\cdot10^{-11}x.
\]

All 17 exact arithmetic checks pass, giving \(E(x)/x\le7.29358256155410\cdot10^{-11}\). Independent review found no mathematical defect.

Remaining work is Lean glue: ψ normalization, two elementary large-range bounds, a separate partial-sum helper, and summability/numeric assembly. No compilation performed.

## 06:24:20 UTC · Final

Saved [BASE_GAP_TYPEII.md](../../../work/qrh-campaign/agents/moebius/BASE_GAP_TYPEII.md) and its numerical script.

The note provides the sharper raw Type I/II envelope, correct \(2\alpha\) denominator reduction, Mellin rescaling conditions, and remaining analytic dependencies.

Diagnostics suggest reduced denominators above roughly \(10^5\) may fit the actual `ghatY` allowance. Mellin integration and uniform certification remain open. No compilation; source `Fact PlattGRH` dependencies remain explicit.

## 06:27:46 UTC · Final

Saved [BASE_GAP_RAW_COMPARISON.md](../../../work/qrh-campaign/agents/moebius/BASE_GAP_RAW_COMPARISON.md), with an exact rational audit script.

The integrated eight-bin envelope improves the broad bound by **12.13% at \(Q=90090\)** and **11.85% at \(Q=120120\)**. The note also gives the raw formula’s monotonicity proof and an affine bound compatible with the major-constants worker’s all-\(y\) comparison.

These results retain the separate Type I/II producer obligations. No Lean compilation performed.

## 06:29:56 UTC · Final

Saved [BASE_GAP_90090_PARAMETERS.md](../../../work/qrh-campaign/agents/moebius/BASE_GAP_90090_PARAMETERS.md).

Specific candidate: multiply \(V\) by 16 and divide \(U\) by 16. The existing parameterized lemmas permit this throughout the stated small-twist region.

The full integrated diagnostic drops to **0.05705693**, versus the starting allowance near **0.06027**. Certification of the integration and all-\(y\) comparison remains; no compilation or source edits performed.

## 09:11:24 UTC · Final

Saved the [all-scale derivation](../../../work/qrh-campaign/agents/moebius/RESUME_MINOR_2026-11-11.md) and exact rational certificate.

All 256 cells passed:

- \(q=90090,\ y\ge10^{25},\ u\le33000\): margin at least **0.000351061785**.
- \(u\le26000\): margin at least **0.001305758681**.

The proof uses analytic bounds and finite interval coverage, not scale sampling. Independent review is pending; the original Type I/II producer obligations remain.

The middle interval \(33000<u<26400000/49\) and \(q=1\) remain open. No denominator count increased, and no Lean compilation or canonical source edits occurred.

## 09:27:37 UTC · Final

Saved the [middle-band derivation](../../../work/qrh-campaign/agents/moebius/RESUME_MIDDLE_2026-11-11.md) and exact certificate.

All **1,152 cells passed**, covering \(q=90090\), every \(y\ge10^{25}\), and
\[
33000\le u\le26400000/49.
\]
Minimum certified margin: **0.000139563943**.

Together with the reviewed small- and large-twist bands, this would cover every permitted twist for \(q=90090\). Independent review is pending; the original Type I/II producer obligations remain. No count update, Lean compilation, or canonical source edits were made.

## 09:49:31 UTC · Final

Saved the [coverage extension](../../../work/qrh-campaign/agents/moebius/RESUME_COVERAGE_EXTENSION_2026-11-11.md).

The exact certificate passes all **1,408 cells**, covering:

- Every integer \(90090\le q\le100000\).
- Every permitted twist.
- Every \(y\ge10^{25}\).

Minimum certified margin: **0.000075993793**. Both totient ratios were checked for all 9,911 denominators, including odd \(q\).

Independent review and the coverage-union recount are pending. Original Type I/II producer conditions remain; no Lean compilation or canonical source changes occurred.

## 10:17:43 UTC · Final

Saved the [q1 hybrid proof](../../../work/qrh-campaign/agents/moebius/RESUME_Q1_GAP_2026-11-11.md) and exact certificates.

For every \(y\ge10^{25}\):

- \(u\le190000\): normalized bound **<0.04530054**, using the same unproved shared finite \(\beta\le0.555\) certificate.
- \(u\ge190000\): all 128 exact cells pass, with margin **0.000338635937**.

The branches cover every permitted reduced-\(q=1\) twist. Independent review is pending; spectral and Type I/II producer obligations remain. No major arcs were enlarged, and no Lean or canonical source changes occurred.

## 10:27:32 UTC · Final

Saved the [small-denominator high-twist proof](../../../work/qrh-campaign/agents/moebius/RESUME_SMALL_Q_HIGH_2026-11-11.md).

Both exact all-scale certificates passed:

- \(Q/\varphi(Q)\le2,\ u\ge300000\): margin **0.001018323773**.
- \(Q/\varphi(Q)\le15/4,\ u\ge600000\): margin **0.005696694314**.

All 19 overlaps with the original finite-family bounds checked successfully. The sharper proposed finite profile needs only the first rectangle for \(Q=2,3\).

Independent review is pending. Spectral and Type I/II producer obligations remain; no Lean or canonical source changes occurred.

## 10:42:46 UTC · Final

Independent review passed with no correction required. It reproduces all 12,008 primes, eight subcounts, exact theta margins, and the 6,439-window grid.

[Review report](../../../work/qrh-campaign/agents/moebius/RESUME_PSI_SHORT_GAP_REVIEW_2026-11-11.md)

The PS3 height extension is mathematically valid. New Lean certificates, 6,438 remaining windows, and the separate spectral estimate remain unfinished.

## 10:55:31 UTC · Final

[Review report](../../../work/qrh-campaign/agents/moebius/PLATT_DOMAIN_COMPARISON_REVIEW_2026-11-11.md)

These are limits of the published guarantee, not evidence against the proposed finite strip. No spectral theorem or Lean proof was imported.

## 10:59:55 UTC · Final

Review completed. The rectangle certificate and dynamic height lemma are sound as sufficient conditions.

One correction is needed: at conductor one, the aggregate formula for `zetaF` requires the term `−1/(s−1)`.

[Review report](../../../work/qrh-campaign/agents/moebius/SPECTRAL_CERTIFICATE_STRATEGY_REVIEW_2026-11-11.md)

All 150,000 height checks passed. No finite spectral result or Lean proof was established.

## 11:13:50 UTC · Final

The conductor-three toy certificate passed independent review.

A second evaluator verified every panel, and an independent exact winding calculation returned zero. The result covers the complete rectangle through ±33, supporting the requested height 32.

[Review report](../../../work/qrh-campaign/agents/moebius/C3_RIGHT_RECTANGLE_REVIEW_2026-11-11.md)

This remains an external interval result—not a Lean proof or a production-height certificate.

## 11:22:40 UTC · Final

The height-14 zetaF certificate passed independent review. A second evaluator verified the full contour, with exact winding zero and correct handling of values at zero and one.

[Review report](../../../work/qrh-campaign/agents/moebius/ZETA14_RECTANGLE_REVIEW_2026-11-11.md)

This supports the external closed-height-14 exclusion. The Lean checker and higher-height certificates remain unfinished.

## 11:41:58 UTC · Final

The height-1500 head certificate passed independent review:

- All 472 checkpoint counts replayed; \(N(1500)=1069\).
- Exact arithmetic confirms \(Q_{1500}<1.668<2\).
- Independent Taylor checks passed on 132 selected blocks.

[Review report](../../../work/qrh-campaign/agents/moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md)

The wider-strip implication also checks numerically and analytically, but that strip through \(10^6\) remains unproved. No Lean proof is claimed.

## 12:00:46 UTC · Final

Review completed. The Cauchy bound and both local benchmarks pass, including an independent check using the repository’s elementary growth bound.

One correction: \(\sqrt{10^8/(2\pi)}\) lies between 3989 and 3990; only its floor is 3989.

[Review report](../../../work/qrh-campaign/agents/moebius/PRODUCTION_SPECTRAL_EVALUATOR_REVIEW_2026-11-11.md)

RS sample correctness, full contours, and formal verification remain open.

## 12:09:45 UTC · Final

Review passed. [Frozen review](../../../work/qrh-campaign/agents/moebius/FAMILY_EVALUATOR_REVIEW_2026-11-11.md).

- Independently checked every panel using different EM parameters; all three windings are zero.
- Verified character indexing, pole cancellation, topology, and the sharper exact grid-error bounds.
- Recorded the Mathlib \(s=1\) adapter requirement.

No blocking defect found. Scope remains the bounded external conductor-five certificate—not production heights or Lean verification.

## 12:15:36 UTC · Final

[Independent review passed](../../../work/qrh-campaign/agents/moebius/FAMILY_ALPHA_MATERIALIZATION_REVIEW_2026-11-11.md).

Checked 1,536 coefficients, 500 residue evaluations, exact domains, and remainder bounds. No blocking defect found. The report separates the analytic enclosure proof from overlap checks and preserves the \(s=1\) source convention.

Wide-panel conditioning remains poor. No contour, production-height, or Lean claim follows.

## 12:19:24 UTC · Final

[EM proof review passed](../../../work/qrh-campaign/agents/moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md).

No blocking defect found in the signs, indices, remainder bounds, analytic continuation, or correspondence with the two scripts. The paper derivation is complete; Lean adapters and verified interval/checker semantics remain unimplemented.

SHA256: `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1`

## 12:25:54 UTC · Final

[Independent c101 review passed](../../../work/qrh-campaign/agents/moebius/C101_CAUCHY_ALPHA_REVIEW_2026-11-11.md).

The full replay matched, and a separate direct-EM/Cauchy model accepted all 159 panels for all 99 characters. No blocking defect found.

Scope: local nonvanishing on \(.555+i[999.875,1000.125]\) only—not a full contour, production-height result, or Lean proof.

## 13:02:06 UTC · Final

[Principal count proof ledger completed](../../../work/qrh-campaign/agents/moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md).

It fixes the contour’s \(+1\) normalization, multiplicity and closed-height conventions, and lists 12 concrete formalization tasks. A new Bohr–Mollerup route avoids evaluating the real Stirling constant; that derivation still needs independent review.

No Lean builds or numerical regeneration.

## 13:28:55 UTC · Final

Completed the [static trust audit](../../../work/qrh-campaign/agents/moebius/QRH_PROVIDER_STATIC_TRUST_AUDIT_2026-11-11.md).

- Resolved all 8,742 source modules; zero unresolved imports.
- No scanned project-owned axioms, admissions, native computation, or generated declarations.
- No extra visible premises in either public export.
- **Trust remains unverified:** successful elaboration and transitive axiom checks must exclude `sorryAx` and generated native axioms.

No Lean builds or canonical edits. Report, reproducible scanner, receipt, and hashes handed to parent.

## 13:49:46 UTC · Final

Completed the [Mordell special-case derivation](../../../work/qrh-campaign/agents/moebius/MORDELL_SPECIAL_CASES_PROOF_PLAN_2026-11-11.md).

It covers parameters **1, 1/2, and 2**, including closing-edge bounds, residue orientation, removable singularities, and both \(\widetilde F\) representations.

Paper proof awaits independent review. Later Gamma-ray and Riemann–Siegel steps remain open. No Lean builds or frozen edits.

SHA256: `7BA678E0C8D7A25B4598228066B44A0CFADF402606EEFE4F6EB52C1C9F6DB050`.

## 14:01:47 UTC · Final

Completed the [Riemann–Siegel identity derivation](../../../work/qrh-campaign/agents/moebius/RIEMANN_SIEGEL_IDENTITY_PROOF_PLAN_2026-11-11.md), through the exact saddle representation.

It includes absolute-integrability bounds, Gamma branch factors, continuation, residues, and integer-endpoint indentation. Independent review is pending; quantitative remainder estimates remain separate.

SHA256: `724FB84B60B9E3CFD178486BD52950A00709DC0D2CB7AA56C3E4193C426234E5`.

No Lean builds or canonical edits.

## 14:11:07 UTC · Final

Independent review **passed**: [Fourier alias review](../../../work/qrh-campaign/agents/moebius/REVIEW_FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md).

Normalization, signs, alias tails, and all nine rational checks passed. Actual FFT data, rounding certificates, sign success, and zero counts remain open.

Review SHA256: `A1B71C24E818CD5628C7A5F5B24105E19BDF5FC4840CCFC47239CAB435A85B33`.

## 14:25:11 UTC · Final

Completed the [finite FFT proof plan](../../../work/qrh-campaign/agents/moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md).

It gives the exact radix-two invariant, centered indexing, twiddle and rounding bounds, and corrected multiplier \( \omega N<16\pi<51 \). All 13 rational checks passed.

No FFT data were computed. Independent review, coefficient packets, and Lean implementation remain open.

SHA256: `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E`.

## 14:43:24 UTC · Final

Independent review **passed**: [arbitrary-height FFT rounding review](../../../work/qrh-campaign/agents/moebius/REVIEW_AUXILIARY_FFT_ROUNDING_EXTENSION_2026-11-11.md).

The universal precision rule and termination arguments hold. All four author rows and eight additional boundary cases passed independent checks, including \(N=2^{37}\).

Actual coefficient packets, FFT traces, signs, and Lean proofs remain open.

SHA256: `2D3A8B62D027353636C656318E587E73DF8860982A11E3EE105F532B03982118`.

## 14:55:18 UTC · Final

Independent review **passed**: [C101 slab review](../../../work/qrh-campaign/agents/moebius/REVIEW_C101_RIGHT_SLAB_CERTIFICATE_2026-11-11.md).

All 16 whole-panel witnesses passed an alternate evaluator; exact winding is zero. The 61-second check covers only the specified closed slab for \(\chi_1\), not a full height range or family.

Review SHA256: `1CB8165A0A6C71F461E27A189B6C0059C220BE17A526459CA7EC6AFE687425AC`.

## 14:59:06 UTC · Final

Review **PASS**; no correction required. All 43 independent exact checks passed.

[Review report](../../../work/qrh-campaign/agents/moebius/REVIEW_OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md)

SHA256: `F9431FA70E33B7FFA3A16B6C12CB254A14D590C8FEEF81CC86E328418A304D0F`

Confirmed normalization, reciprocal conductor factor, asymmetric tails, and conditional error budget. Actual contour data, the \(\sigma=2\) boundary, conductor one, and Lean implementation remain outside this result.

## 15:03:59 UTC · Final

Review **PASS**, with no correction required. All 49 exact checks passed, including independent reconstruction of the four frozen examples and four additional cases.

[Full review](../../../work/qrh-campaign/agents/moebius/REVIEW_FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md)

SHA256: `AE8F8F852F969B6505EE9AC60E5F4D67B7AF686E94F6A9B4E4FED54D8F9ED271`

Accepted scope: paper-level evaluator and whole-panel bounds through \(\sigma=2\). Actual contour nonvanishing, spectral evidence, and Lean implementation remain open.

## 15:07:07 UTC · Final

Revised tilted-slab review **PASS**. The author corrected the DFT scaling ambiguity; all 119 exact checks passed.

[Review report](../../../work/qrh-campaign/agents/moebius/REVIEW_TILTED_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md)

SHA256: `DB9670A184F7CEF9AFA812263EC61592CB288E0F2863B63446D7415E6DA33469`

Accepted scope: paper-level evaluator and panel bounds. Actual contour nonvanishing, spectral evidence, and Lean implementation remain open.

## 15:10:25 UTC · Final

Principal-xi pilot review **PASS**, with no correction required.

[Review report](../../../work/qrh-campaign/agents/moebius/REVIEW_PRINCIPAL_XI_POINT_PILOT_2026-11-11.md)

The frozen replay matched exactly. An independent unshifted calculation produced tighter enclosures at all five points, using no builtin zeta or Gamma evaluations.

SHA256: `FEC2ABB106BFA4AA48F7C195BB746A08FDFD7CD892624E7046212A930318E249`

This certifies point enclosures only; no contour or high-height claim is added.

## 15:28:37 UTC · Final

Modular-bucket pilot review **PASS**, with no correction required.

[Review report](../../../work/qrh-campaign/agents/moebius/REVIEW_NONPRINCIPAL_MODULAR_BUCKET_PILOT_2026-11-11.md)

Independent checks passed all 32 buckets and 10 primitive-character contractions, including modular phases, root branches, rigorous tails, and the parity factor \(1/2\).

SHA256: `BD769E12B182728E97033CDF2218600D67A862179EBC663425289D7490B2F50F`

Scope remains four fixed coefficient inputs; no contour or spectral claim is added.

## 15:34:16 UTC · Final

Node-substitution review **PASS**, with no mathematical correction required.

[Review report](../../../work/qrh-campaign/agents/moebius/REVIEW_NONPRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md)

SHA256: `788059421393EBE8B2390CC2498502228906D94E644A036C4E28930262BDFD94`

Confirmed normalization, reciprocal phases, derivative tails, Taylor domains, and transform scaling. This accepts the paper composition only; actual node data and formal proofs remain open.

## 15:38:35 UTC · Final

Family-product feasibility review **PASS**, with no correction required.

[Review report](../../../work/qrh-campaign/agents/moebius/REVIEW_FAMILY_PRODUCT_CERTIFICATION_FEASIBILITY_2026-11-11.md)

The global inverse-residual certificate is valid. A reduction in computation remains unproved; no actual spectral certificate was produced.

SHA256: `5A2DD26E445829214DEEA92A6EB0C1527533EC6F1064FCF0F3CA9AE5C0C9929C`

## 15:43:38 UTC · Final

Reviewed: no full-rectangle certificate was obtained. All 19,015 retained panel bounds replayed successfully; independent alternate-parameter checks also passed.

[Review](../../../work/qrh-campaign/agents/moebius/REVIEW_C5_GLOBAL_INVERSE_COMPARISON_2026-11-11.md)

SHA256: `BDFFF3F9E8D49CBFD848B1851BD2E908BE5EB5E073C35803BB581D64BBEDD8A4`

Only a wording erratum: exprel has 19 terms, degree18. Ready to review the frozen four-panel follow-up.

## 15:45:25 UTC · Final

The four-panel Taylor review passed with no correction required. Independent calculations also certify both residual tests on the same four panels.

[Review](../../../work/qrh-campaign/agents/moebius/REVIEW_C5_RESIDUAL_TAYLOR_PANELS_2026-11-11.md)

SHA256: `EAB2CD5C2F08E7400C8565DB2B4C4361F50E7A2F7C58D39F67F1C7333CA23CFA`

The full boundary remains uncertified.

## 15:48:39 UTC · Final

The 32-panel width review passed with no correction required. Both author replays matched; independent geometry and analytic checks passed.

[Review](../../../work/qrh-campaign/agents/moebius/REVIEW_C5_RESIDUAL_WIDTH_LADDER_2026-11-11.md)

SHA256: `CD6C1183D32EFBF301BB352163FD36C077ABB7B209F98CA7C90A7D35F3BC787F`

## 15:54:46 UTC · Final

The complete conductor-5 review passed with no correction required. Both full replays verified all 1,630 panels and the closed boundary.

[Review](../../../work/qrh-campaign/agents/moebius/REVIEW_C5_CENTERED_COMPLETE_ATTEMPT_2026-11-11.md)

SHA256: `E5CD912A809951BCF1BFD63C051C318DA50CE376BB28C904A6912ED42753A0CB`

Scope: the external certificate through height12 only; no production-height or Lean proof claim.

## 15:58:22 UTC · Final

Scaling review passed. Exact counts and source bounds check out; the note correctly avoids claiming lower bounds for optimized algorithms.

Two minor qualifications: the divided Taylor rule needs \(W>0\), and the logarithmic moment rule needs \(0<\eta<1\).

[Review](../../../work/qrh-campaign/agents/moebius/REVIEW_GLOBAL_INVERSE_SCALING_LIMITS_2026-11-11.md)

SHA256: `761C72C0F5033212A567A40F099A583F79CA384412A18F365DAA54F75081D390`

## 16:30:40 UTC · Final

Yes—these address two genuine bottlenecks, provided their scopes remain separate.

- The [arithmetic preflight](../../../work/qrh-campaign/agents/integration/NEXT_AFTER_RATIONAL_PANEL_2026-11-11.md) targets missing kernel acceptance and representation costs. Its three fixed fixtures are a sensible test. Arithmetic acceptance must remain distinct from proving that the expressions equal actual theta, P and xi values.
- The production scalar allocation addresses the diagnosed failure of literal low-height parameters. Its current node counts describe one conservative construction—not runtime lower bounds or successful numerical evaluation. The allocation remains pending independent review.

Neither closes the actual spectral obligations: the principal narrow strip through \(10^6\), the shared family including conductor one through \(60{,}343{,}058\), and compatible validation of the global \(7/8\) provider. Those feed the psi envelope and then the Möbius/Type I–II consumers; another accurate low-height value does not advance that coverage.

**The next mathematical production-risk question is:** can the actual normalized function be certified zero-free on one complete slab at a required high height, with quantitative margins after all errors—using either a verified contour count or one holomorphic inverse candidate with residual below one?

This tests the missing conditioning and spectral margin. Evaluation accuracy supplies neither. A zero on an allowed strip boundary could obstruct a stronger closed-exclusion producer without falsifying the selected target; it must not become an added exclusion assumption.

No new report or target change is needed from this audit.

## 16:51:09 UTC · Final

Frozen [high-endpoint slab design](../../../work/qrh-campaign/agents/moebius/PRINCIPAL_HIGH_ENDPOINT_SLAB_DESIGN_2026-11-11.md).

SHA256: `5163C4208A5FC6F670FF0EDBC149A43C38FA5246F1D6CA567C75E055DD7EA2C8`

Seven new EM models cover the proposed slab, reusing six accepted top models. Independent scalar and source checks support the design. Strict boundary margins and zero winding remain untested; no new numerical evaluations or builds ran.

## 17:09:46 UTC · Final

Independent review **passed**, with no correction required.

[Review](../../../work/qrh-campaign/agents/moebius/REVIEW_HIGH_SLAB_RECIPROCAL_CONDITIONING_2026-11-11.md)  
SHA256: `688763591953CD9DA1C20BA24FDF356C0495D0AF571B087DBBA6C5EF52AFFB96`

Compactness and maximum modulus yield `|ζ|>3/20` and `|1/ζ|<20/3` on the same closed slab, conditional on accepted boundary bounds and zero exclusion. No new values or builds ran.

## 17:26:41 UTC · Final

Frozen [finite EM vertical-batching blueprint](../../../work/qrh-campaign/agents/moebius/FINITE_EM_VERTICAL_BATCHING_2026-11-11.md).

SHA256: `814AD0B3012FDA4FD81B485139257409E81E6EAC8FA44FD6824A7D21F02C8818`

It derives the shared-moment/DFT identity, certified binning, absolute errors, complete EM corrections, and explicit work/storage counts. Independent review is assigned. No evaluations, FFTs, builds, or spectral-margin claims.

## 17:49:38 UTC · Final

Frozen [small pilot specification](../../../work/qrh-campaign/agents/moebius/SMALL_EM_BATCH_PILOT_SPECIFICATION_2026-11-11.md).

SHA256: `3977881D20CFE9F948E850AC9A83CF50084AA1EF7D0B7023E5D1A95DE845B929`

It specifies eight centers, 128 complete jets, eight panels and nine endpoints, with independent full-containment checks and fixed resource caps. Paper preflight is pending. No implementation, evaluations or new coverage claims.

## 18:06:13 UTC · Final

Review **PASS** on the corrected point-input contract.

[Independent review](../../../work/qrh-campaign/agents/moebius/REVIEW_POLE_DIFFERENCE_JET_ENCLOSURE_2026-11-11.md)  
SHA256: `39D7D84D0706FE27A7DEF211684FA1DCA4D9E3544AB1A496AE435DDF4E04F577`

All jet formulas, tails, exceptional cases and counts check out. Precision termination now explicitly requires refinable point inputs. No function evaluations or builds ran.

## 18:44:36 UTC · Final

Paper preflight **PASS** on the revised conductor-8 design.

[Review](../../../work/qrh-campaign/agents/moebius/REVIEW_NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md)  
SHA256: `0046FAEEC56248F33F5AB9CD80E8C8675631FBF77679FE54CE436DD9A56FCFA3`

Containment checks and resource caps were repaired. Mathematical formulas and budgets pass. No implementation or evaluations ran; execution remains a separate gate.

## 19:26:20 UTC · Final

Review **PASS**, with no correction required.

[Independent review](../../../work/qrh-campaign/agents/moebius/REVIEW_C8_INDEPENDENT_POLE_JET_ALLOCATION_2026-11-11.md)  
SHA256: `B50F5AF842E71467E821F97070D6315F08E5921F29E16D5362561B48591D851E`

Signs, factorials, 30-order amplification and complete error allocation check out. Actual arithmetic bounds and saved-data containment still require verification. No evaluations or builds ran.

## 19:36:09 UTC · Final

Saved the [signed dyadic rounding plan](../../../work/qrh-campaign/agents/moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md).

It covers negative ties, exact normalization, error bounds, pinned APIs, and separate comparison-operand sizes. No builds or numerical evaluations.

SHA256: `EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B`

## 19:40:54 UTC · Final

Prepared the independent checker and [source-map note](../../../work/qrh-campaign/agents/moebius/RATIONAL_DIRECT_G_J7_INDEPENDENT_PREPARATION_2026-11-11.md).

- Code SHA256: `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC`
- Note SHA256: `9DFC579D2985F2E7B156CF2E94E4D7888905B32BDEC37893969087E9294D5871`

Syntax-only validation passed. No evaluator import or execution occurred. Static reviews are pending; execution still requires separate authorization and supervision.

## 19:47:24 UTC · Final

Saved the [independent review](../../../work/qrh-campaign/agents/moebius/REVIEW_C8_INTERPRETER_SOURCE_DIAGNOSIS_2026-11-11.md): **PASS within the stated static scope**.

SHA256: `5572B1B52F80DBCCAE5B6C275041D3E9368A8FA99AD022DEE50470EAF1620B50`

The PE/source evidence supports ordinary CPython frontend structure. It does not explain the extra accounting entries or justify changing the capability gate. No inspected binaries or fixtures were executed.

## 19:53:54 UTC · Final

Saved the [independent supervisor-design review](../../../work/qrh-campaign/agents/moebius/REVIEW_RATIONAL_J7_NUMERICAL_SUPERVISOR_DESIGN_2026-11-11.md): **conditional paper/source PASS**, with no corrections.

SHA256: `DC0A0E113DE9FF002C4710EB15865F7067DBAD2D5C7C902BBE81AA60DF769CA0`

The capability gate remains unresolved. No run, process probe, evaluator import, or build occurred.

## 20:02:56 UTC · Final

Completed the [static review](../../../work/qrh-campaign/agents/moebius/REVIEW_RATIONAL_J7_NUMERICAL_SUPERVISOR_CODE_2026-11-11.md).

**Scoped PASS:** final S/R sources, syntax and copied native code checked. No evaluator or native API executed.

H implementation review, added-containment capability evidence and runtime authorization remain required.

Review SHA256: `BBD70AC0FA6D971F31E76152FCF9AECBF644FF28B09263468ED9627597F73CEA`

## 20:05:51 UTC · Final

Completed the [review](../../../work/qrh-campaign/agents/moebius/REVIEW_ZERO_SUM_SOURCE_JOIN_2026-11-11.md): **PASS as a conditional paper argument**.

Carrier stability, measurability, limit signs and mixed-norm constants check. No absolute zero-series convergence or measurable height selection is assumed. All 16 source pins and 10 rational checks passed.

Review SHA256: `ABD7473796D65689D1F4D4C58988B1D252BFA534425E36F99DEE50E1D59711F6`

## 20:19:07 UTC · Final

PASS: the smoothing join is sound as a paper derivation. Review saved at `moebius/REVIEW_ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md`.

SHA256: `D79E28D39B7289BF69D9A7BE9D1368A19960E2E113FE3FC91C724B78979C8952`

No substantive corrections; two minor API clarifications recorded. Lean implementation and sharp numerical/spectral obligations remain open. No evaluations or builds performed.

## 20:24:19 UTC · Final

PASS on the frozen sharp vertical join. The actual etaU convolution proves 900; etaPlus proves 106000 with its required shifted Gaussian argument.

Review SHA256: `84C0986E6C4CB9D9C2FBD155F866274E8D28D981895378EEEBD98FF72B3FCF2E`

27 independent rational checks and seven source hashes passed. No substantive corrections, analytic evaluations, or builds. Spectral and multiplicity obligations remain separate.

## 20:29:54 UTC · Final

PASS on corrected author pin `7574552D…`.

Review: `moebius/REVIEW_PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md`  
SHA256: `8337D4EF50E27F37C20C16C59E04F3664886B21DBCE13CCFDCCC924B3F6C8D20`

Actual multiplicities, Gaussian pairing, and damped head subtraction check out. All 12 pins match. Scalar psi closure and finite spectral certification remain separate; no evaluations or builds performed.

## 20:36:51 UTC · Final

PASS on the shared-strip assembly, as a paper certificate rule.

Review SHA256: `E4E8451DCC8D9236E642F83BC30ED20FC2667790BA6E2238106B4764F16C81DA`

All 25 pins match. Exact boundary deflation, closed coverage, multiplicities, and inverse-character handling check out. No new spectral data, builds, or evaluations; certificate production and formal validation remain open.

## 20:43:04 UTC · Final

Review passed at the source/paper level; no blocking corrections.

[Review](../../../work/qrh-campaign/agents/moebius/REVIEW_CURRENT_ROOT_ASSEMBLY_2026-11-11.md)

SHA256: `1F48A0626E1D35B9CBE882EFB1EDC43F5481D76D75BE36C4C4BBCAFCE004ECD3`

All 42 pins match. Checked the direct branches, scaling, strict `.00009*x²/49` reserve, inclusive `10^27` endpoint and original binary input. Spectral certification, formal implementation and final type/axiom validation remain open.

## 20:50:26 UTC · Final

Completed the [independent review](../../../work/qrh-campaign/agents/moebius/REVIEW_QRH_DETECTOR_CONTRADICTION_MATH_AUDIT_2026-11-11.md).

Scoped PASS; all 31 source hashes match. The author corrected the nonzero-probe overstatement. Deeper analytic estimates and kernel validation remain open.

Review SHA256: `6F5A1D26DAA6B4BCB271694F40BB6D82BE046D879288B4F93E26E980CBFA6505`.

## 20:56:43 UTC · Final

Completed the [independent review](../../../work/qrh-campaign/agents/moebius/REVIEW_QRH_NORMALIZED_CELL_ANALYTIC_AUDIT_2026-11-11.md): scoped PASS.

Corrected the report’s high cutoff to \(3/2\). All 31 source pins and 12 exact algebra checks pass. Deeper analytic inputs remain open; no builds or function evaluations were performed.

SHA256: `73293E0F360C415E6639D6B4227D3246F05C3A1960CA01F68B48FCBA12132107`.

## 21:03:20 UTC · Final

Completed the [independent review](../../../work/qrh-campaign/agents/moebius/REVIEW_QRH_CENTRAL_PRIME_ANALYTIC_AUDIT_2026-11-11.md): scoped **PASS**, no correction required.

Verified phase normalization, capped-bin bounds, repeated-product coupling and final exponent. All 43 author source hashes match. Lower analytic foundations remain explicitly unvalidated; no builds or analytic evaluations performed.

Review SHA-256: `DD489B489A9B51F0AAB2E7A54D24D44E292F16C550036CDEC620F2F50E7CC851`.

## 21:09:01 UTC · Final

Completed the [global-tail review](../../../work/qrh-campaign/agents/moebius/REVIEW_QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md): scoped **PASS**, no correction required.

Verified actual radial decay, lattice summability, coefficient/key losses and the \(16L_{\rm cap}-\tau A\) exponent. All 28 author source hashes and line spans match. Finite-source limits and unreviewed foundations remain explicit.

Review SHA-256: `468EA90C5E52C933700F6E59F1DDB28358B6876D86D6B009103A92E0E6C768CA`.

## 21:11:25 UTC · Final

Scoped PASS. Review saved in [REVIEW_QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md](../../../work/qrh-campaign/agents/moebius/REVIEW_QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md).

SHA-256: `0EC988BEE4AF8EF9A3FB17273AD0DACEF1D642F55F527D608ACF92C9D26D077B`

No mathematical defect found. Exact coverage, radial gate, cutoff-independent constants and genuine summability before the infinite limit check out. All 25 author source hashes verified. Two minor line-reference corrections recorded.

Retained-window, zero-mode and Poisson foundations remain separate obligations. No builds or analytic evaluations performed.

## 21:14:26 UTC · Final

Scoped PASS. [Review](../../../work/qrh-campaign/agents/moebius/REVIEW_QRH_MARKED_ZERO_MODE_ANALYTIC_AUDIT_2026-11-11.md) frozen at SHA-256:

`E0E5A316FE5B64E0AF3E33F95CED30F2BABD5220559BE76DD66BBA13D17ED741`

No correction required. All 27 author source hashes verified. Mark uniformity, density cancellation, small-X coverage and normalization check out.

Deeper Gauss conversion and quotient-character identities remain separate foundations. No builds or analytic evaluations performed.

## 21:43:52 UTC · Final

Both reviews are frozen with scoped PASS verdicts and no corrections:

- Quadratic masked Poisson: `D1389E3E…885A69C`
- Middle-frequency estimates: `8BA08F73…8B78579`

All cited source/report hashes matched. The reviews retain explicit lower proof obligations; neither establishes full QRH validity. No builds or analytic evaluations were run.

## 21:48:53 UTC · Final

Scoped PASS; no correction required.

Review: `work/qrh-campaign/agents/moebius/REVIEW_QRH_BASE_FLOOR_ANALYTIC_AUDIT_2026-11-11.md`

SHA256: `C944E03E2E67AD98B18625573AA18348916D7426C6375E1B11F1F48514414412`

Verified all-positive deleted scales, summability, deletion exponents, positive-slot quantifiers and both floor budgets. Primitive analytic foundations, the ray-prime estimate, and high/zero recovery remain explicit boundaries. No builds or analytic evaluations.

## 21:56:58 UTC · Final

Review frozen: **PASS within the bounded source/paper scope**, with no correction required.

SHA256: `0E7CAC0C3DB52B177E33D2CF29160B149C9A0FA8FDBC7171CF01289C73916E8D`

Verified Nlong accounting, live/dead recovery, preserved error terms, summability, and scalar reserve. GrowthAt and the named lower analytic producers remain obligations; no build or full QRH validation claimed.

## 22:34:22 UTC · Final

Saved the [binary coverage design](../../../work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md).

It adds span-normalized convolution and a complete residual-tree checker, with explicit Lean/MM0 work and proof-size accounting. Exact size checks passed. No prime evaluations, builds, or runtime claims.

SHA256: `EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436`

## 22:39:37 UTC · Final

Saved [the joint B/L/span frontier](../../../work/qrh-campaign/agents/moebius/EFFICIENCY_JOINT_BINARY_FRONTIER_2026-11-11.md).

It gives exact break-even inequalities, preserves source and initial-range costs, and names bounded measurements for each uncertainty. Rational checks passed; no builds, prime scans, or new timing claims.

SHA256: `267805788F361419CC46ACE6649384ACAB926AAFEE1DB9A54957B8E2831BB24C`

## 22:46:03 UTC · Final

Saved [the finite-RH coverage and cost interface](../../../work/qrh-campaign/agents/moebius/FINITE_RH_BINARY_COVERAGE_INTERFACE_2026-11-11.md).

A uniform prime-interval theorem can eliminate rung enumeration. The proposed theta route’s low-end patch needs only one small certified prime. Analytic estimates and finite-RH certification remain explicit obligations.

SHA256: `4F222ED5ECDCB822A33D8BD9B58B3373CF5905F688588201C39CF94257CC249E`

## 22:54:53 UTC · Final

Saved [the hybrid height-and-ladder analysis](../../../work/qrh-campaign/agents/moebius/HYBRID_PRINCIPAL_HEIGHT_LADDER_COST_2026-11-11.md).

Key result: when the new theta estimate starts at integer A and B≥2A, proved Bertrand supplies the entire low-range patch without explicit prime records. Exact suffix indices, chunk omission, and conditional endpoint-optimality are also derived.

SHA256: `42EBD3FC0BB2BB00669FCD967C3956B68E67A5A8D4AC26829DB468E1D9D63F8E`

## 22:59:59 UTC · Final

Saved [the Q-frontier selection](../../../work/qrh-campaign/agents/moebius/EFFICIENCY_Q_FRONTIER_SELECTION_2026-11-11.md).

The conservative allocation reaches \(B=2\cdot10^{16}\) at integer **Q=47**. The note gives exact cutoffs and cost-switching bounds; interior Q choices can be optimal under the illustrative model.

All conclusions remain conditional on the pending analytic frontier. No builds or prime evaluations.

SHA256: `9905D47D869D8E6C568C7A1EFA7E4C8D5523FE47B4F4167B9E838C363211F64B`

## 23:20:57 UTC · Final

Saved [the direct-order anchor certificate study](../../../work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_DIRECT_ORDER_CERTIFICATES_2026-11-11.md).

It derives component-root and cyclotomic checks, exact operation bounds, cache-chain obligations, and producer/payload tradeoffs. It makes no speed claim from the old 55 ms benchmark.

SHA256: `98DE51CD347FE90B51E70F946E1A5AAD8FF367C26CFF933EEC5E6A655E3AF959`
