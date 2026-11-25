module

public import FourierEnergy

@[expose] public section

open MeasureTheory TernaryGoldbach Real Filter
namespace GoldbachEnergy
/-- The minor-arc integral for the full infinite series, on the period [0,1]. -/
theorem minor_integral_scaled_from_two_e19 {N c : ℝ} (hc : 0 ≤ c) (hn : (2*10^19) ≤ N) {E : Set ℝ}
    (hE : MeasurableSet E) (hsub : E ⊆ Set.Ioc 0 1)
    (hsup : ∀ α ∈ E, ‖wave N α‖ ≤ c*N/Real.log N) :
    ‖∫ α in E, (wave N α)^3 * e (-N*α)‖ ≤ (c*0.705)*N^2 := by
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hL : 0<Real.log N := Real.log_pos (by linarith)
  let B := c*N/Real.log N
  have hb : 0 ≤ B := by dsimp [B]; positivity
  have hw := continuous_wave N hn0
  let v := fun x : ℝ => (wave N x)^3 * e (-N*x)
  have hv : Continuous v := by
    apply (hw.pow 3).mul; exact continuous_e.comp (continuous_const.mul continuous_id)
  have hi : IntegrableOn (fun x => ‖wave N x‖^2) (Set.Ioc (0:ℝ) 1) volume := (hw.norm.pow 2).integrableOn_Ioc
  have him : ∫ x in E, ‖wave N x‖^2 ≤ ∫ x in Set.Ioc (0:ℝ) 1, ‖wave N x‖^2 :=
    setIntegral_mono_set hi (ae_of_all _ (fun x => sq_nonneg _)) (ae_of_all _ (fun _ hx => hsub hx))
  calc ‖∫ x in E, v x‖ ≤ ∫ x in E, ‖v x‖ := norm_integral_le_integral_norm _
       _ ≤ ∫ x in E, B*‖wave N x‖^2 := by
         apply setIntegral_mono_on (hv.norm.integrableOn_Ioc.mono_set hsub)
           ((continuous_const.mul (hw.norm.pow 2)).integrableOn_Ioc.mono_set hsub) hE
         intro x hx
         simp only [v, norm_mul, norm_pow, norm_e, mul_one]
         calc ‖wave N x‖^3 = ‖wave N x‖ * ‖wave N x‖^2 := by ring
              _ ≤ _ := mul_le_mul_of_nonneg_right (hsup x hx) (sq_nonneg _)
       _ = B*(∫ x in E, ‖wave N x‖^2) := integral_const_mul _ _
       _ ≤ B*(0.705*N*Real.log N) := mul_le_mul_of_nonneg_left (him.trans (integral_energy_sharp_from_two_e19 N hn)) hb
       _ = _ := by dsimp [B]; field_simp <;> ring

theorem minor_integral_scaled {N c : ℝ} (hc : 0 ≤ c) (hn : 10^20 ≤ N) {E : Set ℝ}
    (hE : MeasurableSet E) (hsub : E ⊆ Set.Ioc 0 1)
    (hsup : ∀ α ∈ E, ‖wave N α‖ ≤ c*N/Real.log N) :
    ‖∫ α in E, (wave N α)^3 * e (-N*α)‖ ≤ (c*0.705)*N^2 :=
  minor_integral_scaled_from_two_e19 hc ((by norm_num : (2:ℝ)*10^19 ≤ 10^20).trans hn) hE hsub hsup

theorem minor_integral {N : ℝ} (hn : 10^20 ≤ N) {E : Set ℝ}
    (hE : MeasurableSet E) (hsub : E ⊆ Set.Ioc 0 1)
    (hsup : ∀ α ∈ E, ‖wave N α‖ ≤ 0.21*N/Real.log N) :
    ‖∫ α in E, (wave N α)^3 * e (-N*α)‖ ≤ 0.1764*N^2 := by
  exact (minor_integral_scaled (c := 0.21) (by norm_num) hn hE hsub hsup).trans
    (mul_le_mul_of_nonneg_right (by norm_num) (sq_nonneg _))
#print axioms minor_integral_scaled
#print axioms minor_integral
end GoldbachEnergy
