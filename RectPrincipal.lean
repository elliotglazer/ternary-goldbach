module

public import MinorNumerics
public import TotientSquare

@[expose] public section


open Real
noncomputable section
namespace GoldbachEnergy

theorem inv_totient_box {q : ℕ} (hq : 0 < q) {q₀ : ℝ} (h₀ : 0 < q₀) (hq₀ : q₀ ≤ q) :
    (q.totient:ℝ)⁻¹ ≤ Real.sqrt (2/q₀) := by
  have hp : 0 < (q.totient:ℝ) := by exact_mod_cast Nat.totient_pos.mpr hq
  have hq' : (q:ℝ) ≤ 2*(q.totient:ℝ)^2 := by exact_mod_cast totient_square_bound q
  apply Real.le_sqrt_of_sq_le
  rw [inv_pow,inv_eq_one_div,div_le_div_iff₀ (by positivity) h₀]
  linarith

theorem principal_on_box {N δ B c U q₀ : ℝ} {q : ℕ} (hq : 0 < q)
    (hn : 1 < N) (hB : Real.log N ≤ B) (hc : minorConstant N ≤ c)
    (hU : 0 < U) (hu : U ≤ ‖twistRate δ‖) (h₀ : 0 < q₀) (hq₀ : q₀ ≤ q) :
    Real.log N / N * minorPrincipalBudget N q δ ≤ min c (B*Real.sqrt (2/q₀)/U) := by
  have hN : 0<N := by linarith
  have hL := Real.log_pos hn
  have hB0 := hL.le.trans hB
  have ht := inv_totient_box hq h₀ hq₀
  have hp : 0 < (q.totient:ℝ) := by exact_mod_cast Nat.totient_pos.mpr hq
  have hz := lt_of_lt_of_le hU hu
  have hk : 0 ≤ Real.log N/N := by positivity
  apply le_min
  · apply (mul_le_mul_of_nonneg_left (min_le_left _ _) hk).trans
    calc _ = minorConstant N := by field_simp
         _ ≤ _ := hc
  · apply (mul_le_mul_of_nonneg_left (min_le_right _ _) hk).trans
    calc _ = Real.log N*(q.totient:ℝ)⁻¹/‖twistRate δ‖ := by field_simp
         _ ≤ _ := by gcongr

#print axioms inv_totient_box
#print axioms principal_on_box
end GoldbachEnergy
