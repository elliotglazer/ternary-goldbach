module

public import ModelRoute

@[expose] public section


open MeasureTheory Real TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

theorem cube_difference {a b : ℂ} {E : ℝ} (h : ‖a-b‖ ≤ E) :
    ‖a^3-b^3‖ ≤ 4.5*E*‖a‖^2 + 2.5*E^3 := by
  have hE := (norm_nonneg _).trans h
  have hb : ‖b‖ ≤ ‖a‖+E := by
    have h' := norm_sub_le a (a-b)
    rw [sub_sub_cancel] at h'
    linarith
  rw [show a^3-b^3=(a-b)*(a^2+a*b+b^2) by ring,norm_mul]
  have ht : ‖a^2+a*b+b^2‖ ≤ ‖a‖^2+‖a‖*‖b‖+‖b‖^2 := by
    calc _ ≤ ‖a^2+a*b‖+‖b^2‖ := norm_add_le _ _
         _ ≤ (‖a^2‖+‖a*b‖)+‖b^2‖ := add_le_add (norm_add_le _ _) (le_refl _)
         _ = _ := by rw [norm_pow,norm_pow,norm_mul]
  calc _ ≤ E*(‖a‖^2+‖a‖*‖b‖+‖b‖^2) := mul_le_mul h ht (norm_nonneg _) hE
       _ ≤ E*(‖a‖^2+‖a‖*(‖a‖+E)+(‖a‖+E)^2) := by gcongr
       _ ≤ _ := by nlinarith only [mul_nonneg hE (sq_nonneg (‖a‖-E))]

/-- A pointwise error of 0.001 N/log N on major arcs consumes under 0.0032 N²
of the integrated budget. The total arc length is bounded in the premise. -/
theorem major_error_of_energy {N : ℝ} (hn : (2*10^19) ≤ N) {S : Set ℝ}
    (hS : MeasurableSet S) (hsub : S ⊆ Set.Ioc 0 1)
    (hlen : volume.real S ≤ 4.4*(Real.log N)^3/N) {P : ℝ → ℂ}
    (hp : ∀ x ∈ S, ‖wave N x-P x‖ ≤ 0.001*N/Real.log N) :
    ‖∫ x in S, ((wave N x)^3-(P x)^3)*e (-N*x)‖ ≤ 0.0032*N^2 := by
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hL : 0<Real.log N := Real.log_pos (by linarith)
  let E := 0.001*N/Real.log N
  have hE : 0≤E := by dsimp [E]; positivity
  have hw := continuous_wave N hn0
  have hi : IntegrableOn (fun x => ‖wave N x‖^2) (Set.Ioc (0:ℝ) 1) volume := (hw.norm.pow 2).integrableOn_Ioc
  have hei := setIntegral_mono_set hi (ae_of_all _ (fun x => sq_nonneg _)) (ae_of_all _ (fun _ hx => hsub hx))
  have hbound := hei.trans (integral_energy_sharp_from_two_e19 N hn)
  have hsfin : volume S ≠ ⊤ := (measure_mono hsub).trans_lt (by simp) |>.ne
  have hk : IntegrableOn (fun _ : ℝ => 2.5*E^3) S volume := integrableOn_const hsfin
  have hi' := (hi.mono_set hsub).const_mul (4.5*E)
  apply (norm_integral_le_of_norm_le (hi'.add hk) ((ae_restrict_mem hS).mono (fun x hx => ?_))).trans
  · simp only [Pi.add_apply]
    rw [integral_add hi' hk, integral_const_mul, setIntegral_const, smul_eq_mul]
    calc _ ≤ 4.5*E*(0.705*N*Real.log N) + (4.4*(Real.log N)^3/N)*(2.5*E^3) := by gcongr
         _ ≤ _ := by
           dsimp [E]
           rw [show 4.5*(0.001*N/Real.log N)*(0.705*N*Real.log N)+(4.4*(Real.log N)^3/N)*(2.5*(0.001*N/Real.log N)^3) = 0.003172511*N^2 by field_simp; ring]
           exact mul_le_mul_of_nonneg_right (by norm_num) (sq_nonneg _)
  · rw [norm_mul,norm_e,mul_one]
    exact cube_difference (hp x hx)

#print axioms major_error_of_energy
end GoldbachEnergy
