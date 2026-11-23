# Resumed QRH provider and dependency state

Research-only reconciliation, 2026-11-11. No Lean/Lake process was launched, no canonical source was edited, and no declaration or mathematical assumption was added. This note uses the current `outputs/qrh-blueprint/README.md`, not the old campaign STATUS. Later paper repairs are recorded separately from checked proof terms.

## Authoritative source and validation state

The target remains `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`, Lean v4.35.0, Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. `git status --short` shows exactly two additional untracked source files, `Explicit/QrhNumeric.lean` and `Explicit/QrhMellin.lean`. No original theorem source is modified.

The provider checkout `work/openai-math` remains clean at `4eaee87548250b2682affda7d05d947c05554bae`, Lean v4.34.1, Mathlib `d13f23b723b8a846827a245b89c10fc7d3f11612`. Thus a v4.35 port or another explicit environment strategy is still required; v4.34.1 oleans cannot simply be imported into the target compiler.

The read-only replay `resume_audit_2026_11_11.py` checked **all 24 success receipts** against their current source hashes, artifact hashes, project-manifest hash, and exact dependency-receipt hashes. All matched. Evidence is saved in `RESUME_EVIDENCE_2026-11-11.json`. The reviewed driver hash remains `d70b96192b3cccd9fb6e43095082cd35aff8f0ce1f4f16915a730d9304f23704`.

These are prerequisite compilation receipts, not proofs that Platt has been removed. They include `ZeroSumGen`, whose generic theorem still takes the relevant zero-location hypothesis. `Statement` has explicit successful-import evidence through checked `CircleMethod`; its old standalone exit status was unavailable after the pause. Other receipts record successful compiler exits. The last completed module is `Explicit.ZetaDatum`; `ZetaExplicit` has no success receipt. Interrupted staging files do not count as validated artifacts. This replay did not rehash all external Mathlib artifacts or rerun kernel checking.

Saved audit logs support exactly three new helper declarations:

| Declaration | Existing evidence | Scope |
|---|---|---|
| `Explicit.qrh_low_exp_absorb` | `agents/prime-estimates/numeric-audit.log` | Elementary absorption for `L ≥ 35000`. |
| `Explicit.qrh_low_rpow_absorb` | Same log | Equivalent positive-real power estimate for `x ≥ exp 35000`. |
| `QRH.norm_mellin_lt_of_gaussian_envelope` | `agents/mellin/GaussianEnvelope.log` | Generic Mellin norm `<3.95`, conditional on the explicit Gaussian envelope and `0≤Re(s)≤1`. |

Each log prints only `propext`, `Classical.choice`, and `Quot.sound`. None proves the provider, the etaPlus envelope application, a prime-estimate replacement, or a Goldbach theorem. Scratch fixed-gap/psi, zero-sum, finite-boundary, energy, and totient arguments remain unchecked here. An audit `.lean` file containing `#print axioms` is not evidence that its commands ran.

`work/qrh-build` contains its source driver but no provider success receipts. The locally pinned 7/8 provider has not been compiled or transitively audited in this workspace. The older provider driver also needs the reviewed receipt/staging protocol before persistent compilation; do not treat its presence as a verified build system.

## Exact provider required

At the pinned provider source, `OAI/NumberTheory/DirichletL/Nonvanishing.lean:19–24` exports:

```text
{q : Nat} [NeZero q] (χ : DirichletCharacter Complex q) {s : Complex}
  (7/8 : Real) < s.re
  not (χ = 1 and s = 1)
  -> DirichletCharacter.LFunction χ s ≠ 0.
```

`Nonvanishing.lean:29–31` exports `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re` with only the strict real-part premise. The latter has no separate `s≠1` binder because Mathlib defines a value at the pole. For analytic zero adapters, retain the actual nontrivial-zero conditions rather than relying on a pole convention.

The saved source closure is 2,924 OAI modules plus 19 patched external modules, **2,943 total**. Its imported external entry points are `PrimeNumberTheoremAnd.Wiener` and the Rellich theorem. The prepared dependency pins are `c39a751132c88b6e8080b74c74023fd95b3d8be0` and `70f85d4c1bf99c6e7d61e8be4daa6f3664d08d23`. Their upstream compatibility-patch hashes and module provenance remain in `work/qrh-dependencies/patched-module-closure.json` and `BLUEPRINT_QRH_PROVIDER.md`. These are source-closure counts, not a number of successfully checked modules.

The alternative `RowCompletion.ZeroFreeRegion` gives only `23/24`, with a 301-module total source closure. It does not imply the required `7/8` result. Likewise the local draft `249/250` gap below height `10^8` is useful for far prime estimates, but cannot replace global 7/8 in the principal Mellin proposal. The small internal theorems named `seven_eighths_of_uniform_margin` or `beta_le_seven_eighths` take substantial uniform-margin/common-probe hypotheses; importing them does not discharge those premises.

### Alternative published providers

A bounded primary-source search found useful packaging/validation evidence, but **no established smaller unconditional 7/8 closure**:

* [`Zhang-Liao/quasi-riemann`, commit `8bcf392d0ddc241a87fc8c3371273af704638f9b`](https://github.com/Zhang-Liao/quasi-riemann/tree/8bcf392d0ddc241a87fc8c3371273af704638f9b) is an extracted standalone project. Its README reports a Linux Lean v4.34.1 build and standard-axiom checks, preserving original sources and compiling the same **2,943 modules**. It may simplify packaging and supply external audit logs, but it does not reduce the mathematical closure or solve the v4.35 port. Its reported build was not replayed here; Comparator was not run separately according to its README.
* [`DrMurphyIsIn/real-dirichlet-dbn-lean`, inspected at `41672de34fc7c4aab157ec5f0b5962c18e29227e`](https://github.com/DrMurphyIsIn/real-dirichlet-dbn-lean/tree/41672de34fc7c4aab157ec5f0b5962c18e29227e) reports independent checking of its downstream de Bruijn–Newman result. Its composition imports OpenAI's 7/8 theorem in the OpenAI environment, pinned there to `adc7f1241b42e322a6451854ab7e4b4c146bf78a`. It is a consumer and independent evidence source, not a smaller proof of the provider.
* A stronger bound is advertised with a Lean formalization in [Liu's parameter-optimization paper](https://arxiv.org/abs/2610.12234v2). The paper explicitly follows the original analytic strategy. This bounded review did not establish a smaller unconditional Lean dependency closure for it, so it is not an approved replacement provider.

The inspected repository commits and relevant README text are saved in `RESUME_ALTERNATIVE_PROVIDERS_2026-11-11.json`. External reports must remain distinguished from locally reproduced kernel/type/axiom checks. No source pin was changed.

## Minimal analytic integration interfaces

These are proposed proof obligations, not new declarations or assumptions:

1. **Actual zero upper strip.** For every positive modulus and actual L-function zero with `0<Re(ρ)<1`, prove `Re(ρ)≤7/8` by contradiction from the public export. Supply the pole exclusion from the zero's strip. Preserve arbitrary complex characters; real-character results are insufficient.
2. **Reflected lower strip.** Prove `1/8≤Re(ρ)` through the primitive-character functional equation, including conjugate/inverse character, nonzero gamma/root factors, and zero transfer. For zeta, use `Xi.xiF_one_sub` and `Xi.xiF_eq_zero_iff` at `Explicit/Xi.lean:24–56`; the Dirichlet source use of the functional equation is in `Explicit/LGrowthLeft.lean:251–269`.
3. **Exact carriers and multiplicities.** Transfer these statements to `zetaF`, `zerosRectD` and `multRectD`, preserving multiplicities and exceptional points. See `Explicit/ZetaGrowth.lean:17` and `Explicit/Datum.lean:81–96`. A bare statement about an arbitrary finite set of zeros does not yet match the explicit formula.
4. **Weighted strip estimates.** Replace the low-zero portion of `Explicit/ZeroSumGen.lean:200–269`. The existing argument uses critical-line equality both in `x^Re(ρ)=sqrt(x)` and in its Mellin restriction. QRH cannot inhabit those unchanged RH binders. Supply the actual smoothing bounds, multiplicity-weighted sums, convergence and all-range numerical constants.
5. **Consumer-specific quantitative results.** The primary package still needs `8.6296≤J≤10`, `Aplus'≤5e-7`, and `Astar'+Cross'≤9.5e-7`, with exact character weights and domains. The proposed relaxed minor energy is `T≤.65*x*log(x)`. These are independent quantitative obligations after provider validation, not consequences of importing a half-plane theorem alone.

Later validation must print expanded theorem types as well as axioms. A clean axiom list does not detect an unwanted `Fact PlattGRH` binder or an explicit GRH argument. The intended standard-axiom allowance is the existing three logical axioms. The comparator statement fixture must remain separate from the solution import; source scans and its configuration are not proof checks.

## Every Platt path: inventory and replacement boundaries

The new exhaustive **lexical** inventory covers 84 target source files. `RESUME_PLATT_OCCURRENCES_2026-11-11.txt` records the original Platt/RH occurrences; `RESUME_EVIDENCE_2026-11-11.json` includes file hashes, line numbers and text, also scanning the named direct RH adapters. It includes comments and `omit` directives. It is not an elaborated transitive dependency graph: some declarations in a conditional file are unconditional, while downstream uses can inherit conditionality without repeating the token.

The direct producing edge is `Statement.PlattGRH`, projected by `MajorArcs/GRH.lean:43–66` and `Explicit/ZetaZeroSums.lean:29`. Its non-wrapper analytic uses are:

| Direct source use | Downstream replacement boundary |
|---|---|
| `MajorArcs/Thm714.lean:581,616,649,670` | Plus-smoothed character residuals, ArcChars, lower/upper major energy and cubic major contribution. |
| `MajorArcs/Cor713.lean:827` | Star-smoothed character residuals, ArcCharsStar and the etaStar base-gap estimate. |
| `MajorArcs/Prop715.lean:365` | Actual etaPlus weighted energy used by `MinorTotal.T_le`; relaxed one-sided `.65` route requires new numerical propagation. |
| `Explicit/PsiAsymp.lean:637`, `PsiRange1.lean:431`, `PsiPlateau1e8.lean:138,171`, and generated `PsiRanges1e8` | Global/moderate psi and theta interfaces; local fixed-gap drafts address only far ranges. |
| `Prelim/EOneBound.lean:160`, `MertensProduct.lean:545` | E1/E2 windows, Mertens-product/totient estimates, and associated Möbius estimates. |
| `Explicit/IEANTNBridge.lean:30–32` | Another explicit finite-RH bridge; not an independent unconditional theorem. |

All lexical families are covered by these consumer groups and the final wrappers:

* **Major:** `GRH`, `Thm714`, `Cor713`, `Prop715`, `ArcChars`, `ArcCharsStar`, `L2Major`, `MajorTotal`.
* **Prime/Mertens/Möbius:** `EOneBound/Num/Ranges`, `LambdaMu`, `LiouvilleBound`, `MertensLimit/Product`, `MoebiusBound/Profile/Sch/SchData`, `PsiTwoSided`, `ThetaExplicit`, `SchoenfeldGen/J/Tail/TailAux`, and generated `SchoenfeldCells1` through `11`.
* **Type I/II:** `TypeITotal`, `GcdSums`, `TypeI2Proof/Large/Rest/Sum`, `FirstChoiceTypeI1/TypeI2c/TypeII/Final`, `TypeIIReduction`, `TypeIIS1`, `TypeIITotal`, `TypeIITotalGen`, `TypeIILarge`, `SecondTypeI1/TypeI2/TypeIIa/TypeIIb/Final`, `SecondBridge`, `PointwiseBound`, `G2Bound/Tail`, and `T2Bound`.
* **Other minor/assembly:** `BaseGap2`, `EBound`, `EtaStarBound`, `GBound`, `LargeSieveProof`, `LinftyLevels`, `LSQuot3/6`, `MinorTotal`, `PartIICited`, `Prop1123/Prop1123b`, `Thm1321`, `Helfgott/Inputs`, `Helfgott/Main`, and `MainTheorems`.

The exact Type I/II producer boundary remains the ten interfaces in `TYPEII_REMAINING_INPUTS.md`: seven `LambdaMu` prime/Lambda estimates, `LiouvilleBound.abs_sum_moebius_div_coprime_le_log`, `T2Bound.T2_le'`, and the relevant totient comparisons. In particular, the dyadic prime log-square moment is essential and must not disappear from a shortened list. The separate `LargeSieveProof.cor_12_2_5` path through `LSQuot3.regionS` is not the same large-sieve branch as Type II's S2 estimate.

### Totient and regionS corrections to older status

The finite totient route can reuse **`MertProd.inv_2000` itself** for both the primorial-size bound and the finite product inequality. An additional 303-prime product certificate is unnecessary. `GLOBAL_TOTIENT_FINITE_REVIEW.md` traces its elementary source closure `SmallMertensProd → RamareWalk → LogWalk → RamareHarm → Mathlib`. The proposed restricted interface covers `1≤q≤2^1000`, every `r≥3` with `q≤r`, with **no upper bound on r**. It is source-reviewed but not newly compiled or axiom-audited here.

For `q≤300000`, the elementary six-prime product gives `q/phi(q)≤30030/5760<5.214`, avoiding the global Mertens theorem in the base gap. The global fourth-root envelope `q/phi(q)≤2*q^(1/4)` supplies a paper replacement for the particular `FirstChoiceTypeII:153` comparison. These do not automatically remove calls in `SecondTypeIIa`, `SecondTypeIIb`, `SecondBridge`, or final `GBound`. Later chapters 37–43 and 49 and the current root work supersede the earlier blanket “global totient theorem required” status; each actual consumer still needs its own proved comparison.

The root reports a completed independent **paper review** of `REGION_S_ELEMENTARY.md`: the proposed finite-Mertens plus coarse-totient argument removes the separate `LSQuot3.regionS` Platt route while preserving the quotient constants. Record this as a reviewed replacement plan, **not Lean closure**. It is separate from the seven prime producers and Möbius/T2 inputs. Neither this repair nor the finite totient repair makes `LinftyLevels.norm_S_etaStar_le_ghat` unconditional by itself.

## Final handoff

The current primary numerical package is major `1.0404`, minor `1.0376`, nonprime loss `<.00271`, reserve `.00009`, normalized by `x²/49` at `x≥4.9e26`. Older `1.049`/`.0114` comparisons do not certify the revised package automatically. The large-case theorem must retain `TernaryGoldbachFrom (10^27)` with its inclusive endpoint; the complete theorem must retain exactly `BinaryGoldbachInput` as its external mathematical premise. The instance wrappers and explicit-hypothesis `MainTheorems` wrappers both need final type audits.

Immediate integration conclusions: preserve the 24 receipt-bound artifacts; do not treat interrupted output or unrun audit probes as checked; retain the actual 7/8 provider as an open validation task; use the standalone extraction only as packaging/evidence unless its source and checks are independently validated; and keep paper totient/regionS repairs attached to their exact consumers. No smaller already-validated true-7/8 provider was established in this bounded review.
