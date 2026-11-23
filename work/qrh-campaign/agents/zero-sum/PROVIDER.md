The smaller provider is `OAI.NumberTheory.DirichletL.RowCompletion.ZeroFreeRegion` at OpenAI/math revision `4eaee87548250b2682affda7d05d947c05554bae`. Its source project pins Lean v4.34.1 and sets `autoImplicit=false`. The receiving ternary-goldbach project pins v4.35.0, so compatibility still needs actual validation.

The exported zeta declaration at lines 210–214 is

```lean
theorem OAI.ShortDraft.riemannZeta_ne_zero_of_re_gt (s : ℂ)
    (hs : (23 / 24 : ℝ) < s.re) (hs1 : s ≠ 1) :
    riemannZeta s ≠ 0
```

The exported Dirichlet declaration at lines 204–208 is

```lean
theorem OAI.ShortDraft.dirichlet_LFunction_ne_zero
    (q : ℕ) [NeZero q] (χ : DirichletCharacter ℂ q) (s : ℂ)
    (hs : (23 / 24 : ℝ) < s.re) (hpole : ¬ (χ = 1 ∧ s = 1)) :
    DirichletCharacter.LFunction χ s ≠ 0
```

Source inspection found no additional section hypothesis on either export. The variable commands at lines 84–87 are inside the earlier `CanonicalRowCompletion.ActualFiber` namespace and section, which closes before the exported declarations. The source uses the actual Mathlib zeta and Dirichlet L-functions. Searches found no replacement definition with either name in this DirichletL source tree.

`ShortDraft.DirichletTarget`, defined in `Arithmetic/EisensteinCoordinates.lean` at line 253, unfolds to the exact quantified Dirichlet statement above. `CanonicalRowCompletion.dirichletTarget_unconditional`, at line 197 of the provider file, applies `dirichletTarget_of_reflection_shells` to `exists_actual_fixedShellModels`. The latter supplies explicit ray-count and scale witnesses from `actual_fixedShellModels`, at lines 174–195. Its proof invokes `fixedShellModels_of_actual_fiber_identity` and supplies the required identity using `ActualFiber.completedT_eq_reflectedFiber_idealValue`.

The internal model predicates were inspected. `HasFixedShellModels`, at line 410 of `RowCompletion/RowAmplitudes.lean`, quantifies over twists, nonzero moduli, compactly supported smooth weights and positive scales, and concludes the concrete completed-model identity predicate. `HasCanonicalThetaModels`, at line 104 of `RowCompletion/CompletedEnergy.lean`, quantifies over the same class of weights and bounded arithmetic parameters, with explicit model and coefficient-bound witnesses. These are proof premises of intermediate lemmas. The public provider supplies their witnesses.

The consumer chain is `hasCanonicalThetaModels_of_fixed_shell_models`, then `dirichletTarget_of_theta_models` in `RowCompletion/ThetaNonvanishing.lean` at line 145. The open-strip step at line 105 builds an analytic Mellin identity and invokes `pair_zero_free_of_identity_gt_two` with the concrete compact weight whose Mellin transform is nonzero. The zeta export specializes the completed Dirichlet target to modulus one via `DirichletCharacter.LFunction_modOne_eq`, in `RowCompletion/ReflectedFibers.lean` at line 636.

The reproducible scan is `scan_row_completion.py`, and its complete module lists are saved in `row-completion-closure.json`. The smaller root has 286 OAI modules and 190290 source lines, with external roots Mathlib and RellichKondrachov. The main `DirichletL.Nonvanishing` root has 2924 OAI modules and 486490 lines, with 2638 additional OAI modules and an additional PrimeNumberTheoremAnd dependency. These counts exclude external package modules. Both scans found zero missing OAI modules and zero lexical occurrences of the scanned placeholder words. That scan does not establish the axioms of the compiled proof terms.

The smaller provider has not yet been compiled in this campaign. Its elaborated declaration types and `#print axioms` remain outstanding, including the external RellichKondrachov dependency. This source inspection supports trying the smaller import closure. It does not establish a completed unconditional prime estimate or Goldbach theorem.

For the far-asymptotic prime estimate, `ZeroSumStrip.lean` now also contains `sum_weight_zeta_low_twenty_four_le`. It assumes the same finite zeta zero set and multiplicities as the existing helper, with `g(rho)*max(1/24,|Im(rho)|)<=C`, and concludes the same `1e20*C` bound. The proof uses `g<=24*C` and the existing total-multiplicity bound `1e18`. This new variant and the earlier helpers await the shared project import build before compilation.

The bounded search for an existing classical low-height substitute found no ready effective theorem in the inspected sources. The target's `ZetaLowZeroFree` only establishes the small-height result on the critical line and then assumes `RHBelow` to apply it to every zero. Its `ZeroFreeRegion.zero_free` begins at height `1e8`. The comparison StrongPNT and DirichletZF results use existential constants without numerical lower bounds. The explicit constants in dependency `IEANTN/ZetaSummary.lean`, including `MT_theorem_1`, `MT_R0_55666305`, `MTY_theorem`, and `BTY_theorem`, have placeholder proof bodies. No such statement has been used as a proved input here.
