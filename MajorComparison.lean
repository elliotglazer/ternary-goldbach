module

public import ArcMeasure

@[expose] public section


open MeasureTheory Real TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

/-- The integrated major-arc estimate follows from a pointwise approximation,
the identity identifying the piecewise rational model, and its integrability. -/
theorem major_from_pointwise {N : ℕ} (hn : (2*10^19) ≤ N) (P : ℝ → ℂ)
    (hp : ∀ x ∈ Set.Ioc (0:ℝ) 1 \ minorArcs N,
      ‖wave N x - P x‖ ≤ 0.001*N/Real.log N)
    (hi : IntegrableOn (fun x => (P x)^3*e (-(N*x))) (Set.Ioc (0:ℝ) 1 \ minorArcs N) volume)
    (hid : (∫ x in Set.Ioc (0:ℝ) 1 \ minorArcs N, (P x)^3*e (-(N*x))) = restrictedModel N) :
    (restrictedModel N).re - 0.0032*(N:ℝ)^2 ≤
      (∫ x in Set.Ioc (0:ℝ) 1 \ minorArcs N, integrand N x).re := by
  let S := Set.Ioc (0:ℝ) 1 \ minorArcs N
  have hn' : (2*(10:ℝ)^19) ≤ N := by exact_mod_cast hn
  have hc : Continuous (integrand N) := ((continuous_wave N (lt_of_lt_of_le (by norm_num) hn')).pow 3).mul
    (continuous_e.comp (continuous_const.mul continuous_id).neg)
  have hif : IntegrableOn (integrand N) S volume := hc.integrableOn_Ioc.mono_set Set.sdiff_subset
  have h := major_error_of_energy hn' (measurableSet_Ioc.diff (measurable_minorArcs N))
    Set.sdiff_subset (major_length hn') hp
  simp only [sub_mul,neg_mul] at h
  change ‖∫ x in S, integrand N x - (P x)^3*e (-(N*x))‖ ≤ _ at h
  rw [integral_sub hif hi,hid] at h
  have hv := neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans h)
  rw [Complex.sub_re] at hv; linarith only [hv]

#print axioms major_from_pointwise
end GoldbachEnergy
