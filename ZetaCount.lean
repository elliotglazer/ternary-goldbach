module

public import ZeroWindow
public import PrincipalFormula
public import TernaryGoldbach.Explicit.ZetaBound

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

/-- The common polynomial at conductor one also dominates the Jensen datum for regularized zeta. -/
theorem zeta_growth_le_conductor_one (t : ℝ) : BPz2 t ≤ BP 1 t := by
  let a := |t|+22
  let b := 1.25*(|t|+11)
  have hab : a ≤ 2*b := by dsimp [a,b]; linarith [abs_nonneg t]
  have ha : 0≤a := by dsimp [a]; positivity
  have hb : 10≤b := by dsimp [b]; linarith [abs_nonneg t]
  have hb1 : 1≤b := by linarith
  have hsq := pow_le_pow_left₀ ha hab 2
  have h49 : b^4 ≤ b^9 := pow_le_pow_right₀ hb1 (by decide)
  have hcoeff : 9280 ≤ 2800*b := by linarith
  unfold BPz2 BP
  simp only [Nat.cast_one, one_pow, mul_one, Real.rpow_ofNat]
  change 9200*a*b^9+20*a^3*b^2 ≤ 1400*(1+1)*a*b^10
  calc _ ≤ 9200*a*b^9+20*a*(2*b)^2*b^2 := by
           rw [show 20*a^3=20*a*a^2 by ring]; gcongr
       _ = 9200*a*b^9 + 80*a*b^4 := by ring
       _ ≤ 9200*a*b^9 + 80*a*b^9 := by gcongr
       _ = 9280*(a*b^9) := by ring
       _ ≤ (2800*b)*(a*b^9) := mul_le_mul_of_nonneg_right hcoeff (by positivity)
       _ = _ := by ring

theorem zeta_count (T : ℝ) : JensenCount 1 (zerosRectD zetaF T) (multRectD zetaF T) := by
  intro S hS c r hr hr10 hball
  refine (sum_multRectD_le polyDatum_zeta2 S hS c hr hr10 hball).trans ?_
  apply div_le_div_of_nonneg_right _ (log_ratio_pos hr hr10).le
  apply Real.log_le_log (by unfold BPz2; positivity)
  exact div_le_div_of_nonneg_right (zeta_growth_le_conductor_one c) (by norm_num)

theorem zeta_critical_or_zero (rh : RiemannHypothesis) {T : ℝ} {s : ℂ}
    (hs : s ∈ zerosRectD zetaF T) : s=0 ∨ s.re=1/2 := by
  obtain ⟨hz,h0|⟨ha,hb⟩⟩ := zerosRectD_zetaF_cases hs
  · exact Or.inl h0
  · have hn : s ≠ 1 := by intro h; subst s; norm_num at hb
    rw [zetaF_of_ne hn] at hz
    apply Or.inr (rh s ((mul_eq_zero.mp hz).resolve_left (sub_ne_zero.mpr hn)) _ hn)
    rintro ⟨k,h⟩
    rw [h] at ha; push_cast at ha; norm_num [Complex.mul_re] at ha
    linarith [Nat.cast_nonneg (α := ℝ) k]

#print axioms zeta_count
end GoldbachEnergy
