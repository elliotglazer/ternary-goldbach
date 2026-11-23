# Static trust inventory for the genuine seven-eighths provider

2026-11-11. **Static source inventory complete for the prepared target-version graph; elaborated provider trust remains unverified.** No explicit project-owned trust escape was found among the scanned syntax. This is not a proof of the theorem, its transitive axiom closure, or compatibility with Lean 4.35. No Lean/Lake command, compilation, dependency change, canonical edit, or frozen-file edit was performed.

The final unresolved gate is concrete: compile the genuine public exports in an isolated, pinned target-version environment, inspect their expanded types and actual transitive axioms, reject every axiom outside `propext`, `Classical.choice`, `Quot.sound`, and perform the separate comparator/independent-checker steps specified below. A static scan and the 24 prerequisite receipts do not discharge that gate.

## Exact target and environment distinction

The solution checkout `work/openai-math` has HEAD `4eaee87548250b2682affda7d05d947c05554bae` and a clean working tree. Its package requests Lean 4.34.1, Mathlib `d13f23b723b8a846827a245b89c10fc7d3f11612`, `fixedToolchain=true`, and `autoImplicit=false`.

The prepared compatibility environment instead uses Lean 4.35.0 sources at `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean` and the target Mathlib checkout at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`, HEAD `56a005855ea17e0b0958f73ec801ae140b0a1679`. The scanner resolves the unmodified OAI sources and prepared external patches against this target baseline. It does **not** claim a complete original-4.34.1 baseline audit or successful port. The OAI source layer is pinned exactly; the target baseline's resolved bytes are individually hashed in the receipt.

The prior evidence read first was `integration/PROVIDER_COMPATIBILITY_CUT_2026-11-11.md`, `integration/qrh-modules.json`, the existing read-only build resolver, and `work/qrh-dependencies/module-closure.json` plus `patched-module-closure.json`. No existing successful provider build or final axiom receipt was found or inferred.

## Public exports and visible hypotheses

The selected module is `OAI.NumberTheory.DirichletL.Nonvanishing`, file `work/openai-math/lean/OAI/NumberTheory/DirichletL/Nonvanishing.lean`. Its exact public declarations are:

    OAI.DirichletCharacter.LFunction_ne_zero_of_seven_eighths_lt_re
      {q : Nat} [NeZero q] (chi : DirichletCharacter Complex q) {s : Complex}
      (hs : (7/8 : Real) < s.re) (hpole : not (chi=1 and s=1)) :
      _root_.DirichletCharacter.LFunction chi s != 0

    OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re
      {s : Complex} (hs : (7/8 : Real) < s.re) : riemannZeta s != 0

The first starts at line 19, the second at line 29. The first conclusion explicitly names the actual root Mathlib L-function. There are no namespace section variables in this file. No replacement `riemannZeta` or `DirichletCharacter` definition was found in the scoped source-name search. Expanded elaborated types must still confirm resolution of all names and instances.

The source-level binder table is below. It is not an approved-anchor or elaborated statement-audit result.

| Export | Binder | Classification against the visible challenge/source statement |
|---|---|---|
| Dirichlet | implicit q:Nat | TYPING |
| Dirichlet | instance NeZero q | SOURCE: positive-modulus domain |
| Dirichlet | explicit chi:DirichletCharacter Complex q | TYPING |
| Dirichlet | implicit s:Complex | TYPING |
| Dirichlet | hs:7/8<Re(s) | SOURCE |
| Dirichlet | hpole:not(chi=1 and s=1) | SOURCE |
| zeta | implicit s:Complex | TYPING |
| zeta | hs:7/8<Re(s) | SOURCE |

Dirichlet totals: SOURCE 3, TYPING 3, STANDING/RULED/EXCESS 0. Zeta totals: SOURCE 1, TYPING 1, STANDING/RULED/EXCESS 0. There is no primitivity, conductor bound, height bound, finite spectrum, moment estimate, or nonvanishing premise in either visible export. The pointwise zeta convention at s=1 is Mathlib's convention; this export is not an entire-function definition or a statement removing a meromorphic pole.

### Internal result-shaped interfaces

`Detector/FinalAssemblyUnconditional.lean:15` proves `detector_certified_bands : DetectorCertifiedBands` with no external theorem binder. Its proof introduces the quantified data from that proposition and applies `Energy/CertifiedExistence.terminal_certificate` to explicit parameters, discharging the displayed inequalities from `fixed_parameters`, support/smoothness lemmas, and arithmetic.

`Detector/FinalAssemblyCertifiedBands.lean:30` defines the result-shaped proposition. Its internal assumptions include a hypothetical `7/8<HeckeZeroSupremum.beta`, high data, mesh bounds, source data and a positive parameter; its conclusion is a `CertifiedBand`. The conditional assembly at line 150 takes this proposition as a premise, but `FinalAssemblyUnconditional.dirichlet_nonzero` supplies the proved `detector_certified_bands` term. The public wrapper then supplies q, its nonzero instance, chi, s, hs and hpole. The same discharge occurs for zeta.

`Energy/CertifiedExistence.lean:18,40` builds certified bands inductively and obtains the terminal certificate from that induction and radial transport. Its local finite-type/ideal/group assumptions are theorem parameters supplied by the assembly, not visible final premises. This read establishes the architecture of the premise discharge. It does **not** independently validate the thousands of proof bodies, their elaboration, every instance resolution, or the mathematics of the genuine seven-eighths argument. Result-shaped internal lemmas are not themselves evidence of a hidden axiom when their proofs are supplied; nor does their source spelling prove that those proofs check.

## Fully resolved prepared source inventory

New reproducible scanner: `agents/moebius/qrh_provider_static_audit_20261111.py`; full receipt: same stem `.json`. It is read-only except for that adjacent report. It starts at the actual public module, recursively resolves imports, includes implicit Init unless `prelude` is present, strips nested comments and string/character literals for the lexical scan, and records absolute paths, source hashes, byte sizes and import edges for every resolved module. It treats public/private/meta imports uniformly for dependency inventory.

All **8,742** source modules resolved. There were **zero unresolved imports**, ambiguous path matches, unparsed import tokens or unterminated lexical constructs in the final run. The source-byte total is 104,674,081. The project-owned/prepared-external subset is exactly **2,943** modules and 25,817,691 bytes:

| Prefix | Modules |
|---|---:|
| OAI | 2,924 |
| PrimeNumberTheoremAnd | 4 |
| RellichKondrachov | 15 |
| Mathlib | 3,863 |
| Init / Lean / Std / Lake | 653 / 790 / 208 / 5 |
| Aesop / Batteries / Qq | 132 / 72 / 14 |
| ImportGraph / LeanSearchClient / Plausible / ProofWidgets | 35 / 4 / 13 / 10 |

The 2,924 OAI module set equals the prior `integration/qrh-modules.json` set exactly. The 19 prepared external modules match the selected patched closure. The scanner does not accidentally count every package listed in OAI's broad Lake manifest as a dependency; it follows the public module's imports.

Prepared patch hashes agree with `patched-module-closure.json`: PrimeNumberTheoremAnd patch `0890432340C0025973BCFE070B634355FA366CC831595F68526E4C73C8903D82`; Rellich patch `0C121D8517DFEADC93EF24FE2DEB56BEEC7CB3998E2552DEE8F61C780B1408C8`. The selected source bytes are individually pinned by the scanner. This does not prove patch semantic equivalence or target-version elaboration.

## Project-owned lexical findings

Across all 2,943 project-owned/prepared-external modules, the scan found no code tokens for `axiom`, `axioms`, `opaque`, `sorry`, `admit`, `sorryAx`, `mkSorry`, `mkSyntheticSorry`, `native_decide`, `native`, `nativeEqTrue`, `bv_decide`, `axiomDecl`, `unsafe`, `unsafeCast`, `implemented_by`, `extern`, declaration-generating `elab`/`macro` commands, `initialize`, `run_tac`, `run_elab`, `addDecl`, `addAndCompile`, or `trustLevel`. It found no project-local `set_option` command. The package-level `autoImplicit=false` option was read separately and must be preserved during porting.

The only tracked lexical token present was `constant`, 96 occurrences in seven OAI modules. Inspection shows ordinary mathematical variable names and their uses, such as `(constant : Complex)` and `constant * ...`; these are not global uninterpreted-constant declarations. The receipt retains their exact paths and lines. This classification matters: raw word counts are not axiom counts.

This lexer is not the Lean parser and does not execute imported elaborators. A tactic may generate proof terms or declarations without spelling their final dependencies in the calling file. A parser-complete or kernel claim therefore cannot be inferred from these negative findings. Source files may also fail elaboration; Lean's error recovery can introduce synthetic sorry terms, which must not be accepted as successful artifacts.

## Baseline trust findings, including native computation

The wider imported baseline is not textually free of trust primitives. That is expected and must be classified, not hidden:

- `Init.Prelude` declares `Quot.sound`, `Classical.choice`, `sorryAx`, and unsafe runtime primitives; `Init.Core` declares `propext`. Importing the declarations does not make a theorem depend on each of them. Only the three comparator-approved logical axioms may survive in the final proof closure.
- Lean and tactic sources contain sorry construction, admission, pretty-printing and error-recovery code. Mathlib's conditional-expectation file has a `#guard_msgs in #check ... (sorry : alpha)` syntax-display test. These occurrences are not project theorem proof holes merely because their modules are imported.
- Three `native_decide` uses occur in imported tooling: two anonymous sanity-check examples in `Lean/Data/Lsp/LanguageFeatures.lean:470–503` and one in `Lake/Build/Trace.lean:135–137`. This does not establish that the exported nonvanishing proof uses any of them.
- **Native trust is genuinely different from the allowed logical axioms.** In Lean 4.35, `Lean/Meta/Native.lean:37–86`, `nativeEqTrue` compiles/evaluates a Bool and then constructs a fresh `Declaration.axiomDecl` asserting its equality to true. The name is generated with a `_native ... ax` suffix. This mechanism underlies native_decide/bv_decide. It must not be described as an ordinary kernel-reduced proof or accepted merely because it is shipped with Lean.

Consequently, the final axiom gate must reject any generated native axiom or sorryAx in the **actual export proof-term closure**, even if its originating module is a standard dependency. The source graph contains runtime/unsafe/metaprogram infrastructure, but a theorem's elaborated dependency graph is the decisive object. No final native-dependency absence is claimed here.

## Comparator quarantine and exact acceptance gate

`ComparatorChallenges/DirichletSevenEighths.lean` deliberately states the matching theorem with `by sorry`. It is the challenge specification, not the implementation. The recursive solution import inventory does **not** include that module. Its presence elsewhere in the checkout is not a solution proof hole, but importing it as a provider would invalidate the audit.

The comparator JSON selects the actual solution module and Dirichlet export, permits only `propext`, `Quot.sound`, `Classical.choice`, and has `enable_nanoda=false`. It does not select the zeta corollary, so that corollary needs its own type/axiom inspection. Nor does this setting establish an independent-kernel run.

The unresolved production gate is:

1. Preserve exact source/options/patch pins in the isolated target-version port. Record every compatibility edit and compile the genuine 2,943-module provider closure against the target baseline with successful, error-free receipts. No mixed 4.34/4.35 oleans and no stale-success inference.
2. Inspect fully elaborated public types with explicit binders/instances and root constants. Confirm the exact global seven-eighths statements above, not the weaker 23/24 substitute or a conditional interface.
3. Compute transitive axioms for **both** public declarations and the selected assembly proof. Require the resulting set to be a subset of `{propext, Classical.choice, Quot.sound}`. Explicitly reject sorryAx, generated native axioms and every other custom axiom. Retain machine-readable proof-dependency evidence tied to the successful artifacts.
4. Run the comparator in its separate challenge/solution role. Never import the challenge's sorry proof into the solution environment as a dependency. An independent proof-object checker, if required for production, is an additional step because this comparator configuration does not enable one.
5. Only after those checks may the actual-zero strip adapters consume the provider without an additional hypothesis. The final Goldbach root must not acquire a permanent seven-eighths, detector-band or numerical certificate axiom in place of these proofs.

No explicit project-owned source obstruction was found in this bounded audit. The significant unresolved obstacle is successful elaboration and transitive proof-term trust for the genuine global result, not a missing import path or a clean-looking final signature. The 24 target prerequisites and this 8,742-module inventory are not substitutes for that verification.
