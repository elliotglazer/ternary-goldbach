# Semantic audit of the 19 prepared external QRH modules

2026-11-11. **No change to the retained mathematical objects or widening of the inspected QRH-consumer theorem hypotheses was found. This is not full API equivalence and not a successful provider proof check.** The patches remove declarations, change visibility and instance registration, rename interfaces, and restructure proofs. Those changes are recorded below rather than described collectively as “proof-only.”

The two stored patches exactly match their blobs in the pinned OAI repository. All 19 selected prepared modules reconstruct from their pristine pinned Git blobs and 201 patch hunks, after normalizing line endings. No external source, dependency, package configuration, Lean file, or frozen artifact was edited. No Lean/Lake process or installation was run.

## Evidence and precise scope

The workspace is `C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean`. All paths below are relative to it unless stated otherwise.

| Input or output | Pin |
|---|---|
| OAI provider | `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae` |
| PNT pristine Git objects | `work/qrh-dependencies/PrimeNumberTheoremAnd`, commit `c39a751132c88b6e8080b74c74023fd95b3d8be0` |
| Rellich pristine Git objects | `work/qrh-dependencies/rellich-kondrachov`, commit `70f85d4c1bf99c6e7d61e8be4daa6f3664d08d23` |
| Selected closure | `work/qrh-dependencies/patched-module-closure.json`, SHA256 `387D6B1CDA595A0811BB9C8C23CBAEECA44D0EDA82602C54FCCC0B734645945D` |
| PNT patch | `work/qrh-dependencies/PrimeNumberTheoremAnd-lean4341.patch`, SHA256 `0890432340C0025973BCFE070B634355FA366CC831595F68526E4C73C8903D82` |
| Rellich patch | `work/qrh-dependencies/rellich-kondrachov-lean4341.patch`, SHA256 `0C121D8517DFEADC93EF24FE2DEB56BEEC7CB3998E2552DEE8F61C780B1408C8` |

The exact patch blobs are respectively `lean/patches/PrimeNumberTheoremAnd-lean4341.patch` and `lean/patches/rellich-kondrachov-lean4341.patch` in the OAI commit. They were read with `git cat-file blob`, not inferred from the preparation README. The sparse working tree does not expose those files to an ordinary file search.

New adjacent evidence files in `work/qrh-campaign/agents/prime-estimates/`:

| Artifact | SHA256 |
|---|---|
| `qrh_external_patch_semantic_audit_20261111.py` | `C49194A08609F28D2C83E0CC06F8BE76728012D3661E44A801EB73E138836175` |
| `qrh_external_patch_semantic_audit_20261111.json` | `5EB4589A1846CDE7717A0E65F8340143A3034BDD840340AB0FDFB38BE2BC5C49` |
| `qrh_external_selected_diff_20261111.txt` | `2A9355B5C59B6DC55E7734F2B2B9DAF193125CCE976523D899D60AA33FD90A76` |

The JSON records every selected module's absolute path, pristine raw SHA256, prepared raw SHA256, normalized prepared SHA256, exact patch-section hash, hunk count, import lists and source-header inventory. All 19 prepared raw hashes also match the prior static trust inventory. Thus no short hash in this prose is being used instead of an exact source pin.

The PNT patch is 1993197 bytes with 55 file sections; **only four of those modules are in the selected external closure**. The remaining 51 patch sections are not approved by this audit. The Rellich patch is 147331 bytes and all 15 file sections are selected. For selected files, Git reports 541 added/3018 removed PNT lines and 945 added/785 removed Rellich lines. Line counts include comments, movement, spelling changes and actual proof code; they are not semantic-change counts.

The inventory script is not a Lean parser. It preserves a heuristic header listing after removing comments/strings, and records its limitation: an unbracketed `let ... := ...` in a result type can end the extracted prefix early, and section variables are not expanded into binders. The affected local-let results and standing variables were read manually. Exact patch reconstruction is a byte/text fact; no semantic conclusion follows solely from it.

## PNT: preserved meanings, reduced interface

The selected modules are `Wiener`, `Fourier`, `Sobolev`, and `SmoothExistence` under `PrimeNumberTheoremAnd`.

### Chebyshev predicates and the consumed Tauberian theorem

Pristine `Wiener.lean:910–912` defines

```
chebyWith C f := forall n, cumsum (fun k => norm (f k)) n <= C*n
cheby f := exists C, chebyWith C f
```

These two named definitions are removed. Retained theorem statements expand those same quantifiers and bounds explicitly. In particular, prepared `WienerIkeharaTheorem'` at line 2050 still assumes nonnegative real coefficients, absolute summability on every real abscissa greater than one, the same Chebyshev bound, continuity of the remainder on `Re(s)>=1`, and equality to `LSeries f s-A/(s-1)` on `Re(s)>1`. Its conclusion remains `cumsum f N/N -> A`. Real coefficients are cast to complex numbers inside the norm exactly as under the old function coercion. There is no new nonvanishing, prime-number-theorem, or compactness assumption in this interface.

Prepared `vonMangoldt_cheby:2067` still proves the expanded predicate with the explicit witness `log 4+4` and Mathlib's unconditional Chebyshev estimate. Prepared `WeakPNT:2080` retains its old limit statement and derives it from the same Tauberian theorem and Mathlib residue-class auxiliary function. Removing an unused local `hnv` does not strengthen an assumption or supply a new nonvanishing theorem.

Other retained Wiener headers that change mathematically relevant-looking text use the same predicate expansion, theorem/lemma spelling, or explicit coercion/formatting. The hcheby expansion is a statement-syntax change with the same mathematical content, not a weakening of the condition.

### Definitions and proof packaging

- `nterm`, `cumsum`, `nabla`, `nnabla`, `shift`, `pp`, `pp'`, `hh`, `hh'`, `gg`, and the final normalized finite sum `S` keep their actual formulas. In particular, `cumsum` remains the strict `Finset.range n` sum, not an inclusive endpoint sum.
- The `CS`, `trunc`, `W1`, and `W21` data and conditions are unchanged. The W21 norm remains the L1 norm plus `(4*pi^2)^(-1)` times the L1 norm of the second derivative. `of_Schwartz` is renamed `ofSchwartz`; its underlying function is still the supplied Schwartz function. The coercion points to the renamed constructor.
- `@[ext] structure CS` is replaced by the same structure and an explicit protected extensionality theorem. This changes generated/registered proof interfaces, not the fields of the structure.
- `toSchwartz` is reconstructed through `HasCompactSupport.toSchwartzMap`. The target Mathlib body at `Analysis/Distribution/SchwartzSpace/Basic.lean:546` has `toFun := f` and supplies smoothness/decay proofs. The prepared constructor therefore still represents exactly f. Its proof term is different; no definitional-equality claim about all proof fields is needed.
- The surviving `smooth_urysohn_support_Ioo` statement is unchanged. It uses the vector-space `exists_contDiff_zero_iff_one_iff_of_isClosed` instead of the manifold version followed by conversion. The target API at `Geometry/Manifold/PartitionOfUnity.lean:810` supplies the required same zero/one and range conditions.
- `W21_approximation` and the retained Wiener chain have many proof adaptations: explicit derivatives, coercions, finite-index cases, support bounds, sum/integral rearrangements and named Mathlib operations. These are proof changes which still require elaboration. Their syntactic presence is not a proof-success receipt.

### Removed declarations and import effects

The heuristic named inventory finds 36 removed Wiener declarations, 11 removed Fourier declarations, one renamed Sobolev constructor, and removal of the separate `SmoothExistence` bump-normalization theorem. The complete names and source locations are in the JSON.

Notable Wiener removals include `AbsolutelyContinuous`, `prelim_decay_2`, `prelim_decay_3`, `decay_alt`, the auto-Chebyshev/bootstrap branch, the double-prime Wiener theorem, and `WeakPNT_character`/`WeakPNT_AP` branches. The two `prelim_decay` lemmas contain `sorry` in the pristine source; the prepared module removes those declarations rather than replacing them by stronger axioms or claiming their proofs are fixed. The retained W21 decay route uses its separate proven-form Fourier/derivative argument. Deleting admitted unused declarations is relevant to trust, but does not establish the final export's axiom closure.

Fourier also removes the bounded exponential function `e` and its derivative/helper/oscillatory-bound interfaces. PNT drops Architect, blueprint annotations, the lemma-command option and several local options/imports. It adds an ordinary Circle measure import and an iterated-derivative import where needed. Thus the whole library is not API-equivalent, and these changes are not all necessary compatibility fixes.

The removed PNT `instMeasurableSpace` and `instBorelSpace` for Circle are supplied instead by target `Mathlib.MeasureTheory.Group.Circle:29–32`. I read the actual bodies: they use the identical subtype measurable structure and Borel proof. The Fourier local function coercion is also removed. These are elaboration-environment changes that must be tested on actual consumers; they do not justify claiming that all name resolution is automatically identical.

## Rellich: module-by-module changes

Abbreviate `RellichKondrachov.Analysis.FunctionalSpaces.Sobolev.Euclidean` by E, and its `L2Compactness` namespace by C. All paths and exact hashes remain in the JSON.

| Selected module | Semantic/API classification |
|---|---|
| E.H1 | Names the same local Borel instances; makes `L2ℝ`, `L2E`, `H1Target` public; renames the completeness instance. C1c, grad, toL2, toL2Grad, graph and h1 retain their actual data. Proof fields and tactics change. |
| E.Translation | Same `x+a` translation and measure-preserving L2 map. Local instances renamed. Gradient proof now explicitly transports the derivative equality through the Riesz map. |
| E.TranslationEstimate | Same segment and gradient inequality; `Icc` qualified as `Set.Icc`; operator-enorm API renamed; local instances renamed. |
| E.TranslationEstimateL2 | Extracts the former local squared-integral estimate into private `lintegral_enorm_sub_sq_le`; its proof retains the segment Cauchy–Schwarz, Tonelli, translation-invariance and mass-one steps. Uses explicit ENNReal top/rpow/norm APIs. |
| E.TranslationEstimateH1 | Same H1 translation bound by `norm a * norm gradient`; closure-continuity proof cleanup and local-instance renames. |
| E.Rellich | Same compact-operator statement for the supported H1 inclusion. Compact operator import becomes `.Basic`; opNorm notation becomes the same norm; local instances renamed; large heartbeat/linter overrides removed. |
| C.Smoothing | Same extension-by-zero, convolution and L2 representatives. Anonymous local instances are named; proof applications quote the argument name `«L»`; local instance-binding syntax changes. |
| C.Compactness | Makes `smoothOn` public without changing its continuous-map function. Same K-plus-support domain and BCF construction. Local-instance names and proof APIs change. |
| C.ArzelaAscoli | Extracts private range-bound and uniform-equicontinuity lemmas. Public compactness result retains its hypotheses and conclusion. Zero-measure and nonpositive-radius cases remain handled. |
| C.Transfer | Extracts private `dist_smoothL2_le_mul_dist_smoothBCF`, using the same finite-support square-root-volume factor, a.e. identities and extension-by-zero isometry. Public compactness conclusion unchanged. |
| C.Approximation | Same kernel measure `volume.withDensity(ofReal ∘ psi)` and smoothing-error inequalities. Conditional probability instance becomes explicit lemma `isProbabilityMeasure_kernelMeasure`; its four hypotheses remain continuity, compact support, nonnegativity and integral one. Call sites supply them. |
| C.FrechetKolmogorov | Same total-boundedness criterion; instance names, comments and set-membership proof spelling change. |
| C.Kernels | Bound variable `delta` is renamed `deltaLoss`; positivity, support radius, unit integral and nonnegativity all remain identical. |
| C.TranslationIntegral | Same integrated squared translation estimate; `deltaLoss` rename propagated consistently; same supplied kernel-mass proof. |
| `RellichKondrachov.MeasureTheory.Function.LpSpace.Restrict` | Makes `extendByZeroFun` public, with unchanged indicator/toLp definition. Linear/isometric extension proofs use explicit existing a.e. equalities. |

The three largest rearrangements are not treated as harmless merely because they are moves. I read the extracted claims and their bodies: the Arzelà–Ascoli range bound uses `sqrt(volume K)*Cpsi*R`; equicontinuity separately treats zero measure and otherwise uses the modulus of continuity of psi with Cauchy–Schwarz; transfer first bounds the restricted L2 norm by the sup norm and then proves its equality with the global supported norm. The squared translation helper integrates the original pointwise segment inequality, swaps nonnegative integrals, and uses right-invariant translation. No result-shaped new hypothesis replaces these arguments.

The private-to-public changes alter exported names and reducibility access; the probability instance-to-lemma change alters instance search. Neither is full API equivalence. All inspected measurable-space definitions still explicitly choose `borel E`. The public `isCompactOperator_h1OnToL2` still includes finite dimensionality/completeness through its original standing context and compact/measurable K; those conditions are not silently removed. New private helpers may omit unused standing hypotheses, but the consumed theorem does not acquire or lose its mathematical domain.

## Actual paths into the genuine seven-eighths exports

The selected source endpoint is `OAI.NumberTheory.DirichletL.Nonvanishing`, not the weaker 23/24 alternative. Its lines 19–33 still declare the actual Mathlib L-function nonzero when `7/8<Re(s)`, except for the principal pole, and actual `riemannZeta` nonzero under the same strict bound. The wrappers call `ProbeFinalAssemblyUnconditional.dirichlet_nonzero`/`zeta_nonzero`; the latter supplies the proved `detector_certified_bands` term to the conditional assembly. None of these files is modified by the external patches.

Concrete PNT consumption includes:

- `IdealMangoldt.lean:218–255`: consumes `vonMangoldt_cheby`, `cumsum`, `nterm`, `nterm_eq_norm_term` and `norm_term_eq_nterm_re` for norm-fiber coefficient bounds and summability.
- `PrimeCounting/Progressions.lean:11–40`: constructs the residue-class Chebyshev and summability bounds, then applies `WienerIkeharaTheorem'` with explicit continuity and residue identities.
- `PrimeCounting/RayAsymptotic.lean:188,290`: applies that same theorem to ideal/ray-quotient coefficients, explicitly supplying the already-proved Chebyshev, summability and analytic remainder inputs.

The static import path to IdealMangoldt passes through `Nonvanishing -> Detector.FinalAssemblyUnconditional -> Detector.FinalAssemblyCertifiedBands -> Detector.DetectorInverseFields -> Detector.DetectorInverseRawField -> Detector.DetectorMomentData -> PrimeRows.CanonicalRayCube -> Detector.RayCharacterFamily -> Detector.RayPhaseAmplitude -> Detector.RaySlots -> RayPrimeNormalizer -> Hecke.RayPrimes -> PrimeCounting.IdealPrimeMass -> IdealMangoldt`. The Progressions branch continues through `PrimeCounting.PrimeMass`. Exact verified paths are saved in the JSON.

For Rellich, `Nonvanishing -> Foundation -> CubicSieve.RadialWindows` is a short import path. In `RadialWindows.lean:477–537`, actual C1c functions are mapped to the graph closure h1 and then to the supported h1On space. The compact-family theorem at line 519 applies `isCompactOperator_h1OnToL2` and uses the unchanged product/max norm and explicit support, mass and gradient bounds. `CubicSieve.ReopenedFibers:523` onward also directly uses these C1c/L2/gradient objects and transports their a.e. representative identities. This is why preserving the data definitions, not merely a theorem name, matters.

These are source import paths plus inspected term-level call sites, not an elaborated dependency graph. An import can be broader than the actual proof closure. Conversely a tactic or typeclass can introduce dependencies not visible as a literal theorem call.

## Acceptance and remaining gates

The selected retained mathematical interfaces pass this source-level semantic check. The global claim “the external patches are proof-only/API-equivalent” is rejected: deleted interfaces, renamed data constructors, exposed definitions and changed instance registration make it false. I found no mathematical mismatch that requires widening a QRH export premise or replacing a source object. I do not claim all changes are necessary, that every altered proof elaborates, or that all 55 PNT patch sections are semantically reviewed.

The prepared patches are named for Lean 4.34.1; the contemplated target uses Lean 4.35.0 and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. Successful target elaboration is still required. The final public types must be inspected after elaboration, and the actual transitive proof-term axioms of both genuine 7/8 exports must be a subset of `{propext, Classical.choice, Quot.sound}`. Deleted source admissions, exact patch replay, and a clean-looking final signature do not discharge that gate. The comparator's challenge/solution separation and any independent proof-object checker remain separate requirements from this read-only audit.
