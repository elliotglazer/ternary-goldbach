module

public import RationalArcs

@[expose] public section


open Real MeasureTheory TernaryGoldbach GoldbachEnergy
namespace GoldbachRoute

/-- The minor arcs require the remainder on some rational approximation at each point. -/
def TwistedEstimate (N : ℕ) : Prop :=
  ∀ α ∈ minorArcs N, ∃ r : ℚ, (r.den:ℝ) ≤ approximationOrder N ∧
    |α-r| ≤ 1/(approximationOrder N*r.den) ∧
    ‖wave N α - principalWave N r.den (α-r)‖ ≤ 0.1795*N/Real.log N

def CentralExpansion (N : ℕ) : Prop :=
  ∃ θ₁ θ₂ : ℝ, |θ₁| ≤ 1 ∧ |θ₂| ≤ 1 ∧
    (∫ x in Set.Ioc (0:ℝ) 1 \ minorArcs N, integrand N x).re =
      (∑ q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊, GoldbachSingular.fourierCoefficient N q).re /
      exp 1 * ((N:ℝ)^2/2+8*θ₁*N) + 0.04*θ₂*(N:ℝ)^2

/-- Sufficient pointwise bound for the full wave on the paper's minor arcs. -/
def MinorEstimate (N : ℕ) : Prop :=
  ∀ α ∈ minorArcs N, ‖wave N α‖ ≤ 0.2675*N/Real.log N

theorem large_of_pointwise
    (h : ∀ N : ℕ, Odd N → 10^20 ≤ N → CentralExpansion N ∧ MinorEstimate N) :
    TernaryGoldbachFrom (10^20) := by
  intro N ho hn
  obtain ⟨hmajor,hminor⟩ := h N ho hn
  have hn' : (10:ℝ)^20 ≤ N := by exact_mod_cast hn
  have hL := LeanLab.Zinoviev1997.log_1e20_ge.trans (Real.log_le_log (by norm_num) hn')
  have hQ : 400 ≤ ⌊modulusCutoff N⌋₊ := by
    apply Nat.le_floor
    unfold modulusCutoff
    nlinarith only [sq_nonneg (Real.log N-46),hL]
  exact three_primes_from_expansion ho hn hQ (measurable_minorArcs N) Set.sdiff_subset hminor hmajor

theorem large_on_rational_arcs
    (h : ∀ N : ℕ, Odd N → 10^20 ≤ N → CentralExpansion N ∧ TwistedEstimate N) :
    TernaryGoldbachFrom (10^20) := by
  apply large_of_pointwise
  intro N ho hn
  obtain ⟨hmajor,hminor⟩ := h N ho hn
  have hn' : (10:ℝ)^20 ≤ N := by exact_mod_cast hn
  refine ⟨hmajor,?_⟩
  intro α hα
  obtain ⟨r,_,_,hr⟩ := hminor α hα
  have hp := principal_on_minor hn' hα r
  have ht := norm_add_le (wave N α-principalWave N r.den (α-r)) (principalWave N r.den (α-r))
  rw [sub_add_cancel] at ht
  calc _ ≤ _ := ht.trans (add_le_add hr hp)
       _ = _ := by ring

#print axioms large_of_pointwise
#print axioms large_on_rational_arcs
end GoldbachRoute
