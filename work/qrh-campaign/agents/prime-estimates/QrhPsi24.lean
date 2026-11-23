import TernaryGoldbach.Explicit.PsiAsymp
import QrhPsi24Aux
import QrhPsi24Numeric
import QrhPsiMid
import QrhZeta24Bridge
import ZeroSumStrip

open Complex Set Filter MeasureTheory Finset
open scoped Real Interval Topology ArithmeticFunction.vonMangoldt

namespace TernaryGoldbach.Explicit

/-- A QRH replacement of the Gaussian explicit-formula estimate. -/
theorem SsumG_gsm_err_qrh24 {a b δ x Γ : ℝ}
    (hδ : 0 < δ) (hab : b ≤ a) (hb : b ≤ 0) (hx : 1 < x) (hΓ : 3e12 ≤ Γ)
    (hδa : δ ^ 2 / 2 + |a| ≤ 1e-6) :
    ‖SsumG (1 : DirichletCharacter ℂ 1) (fun u => (gsm a b δ u : ℂ)) x - Mg a b δ 1 * x‖ ≤
      1e24 * x ^ (23 / 24 : ℝ) + x * (MidB0 a δ 1e8 3e10 x + MidBH a δ 3e10 Γ x) +
        x * TailBG a δ Γ + x ^ (-(1 / 2) : ℝ) * Vg a b δ / (2 * π) := by
  have hH1 : (1e8 : ℝ) ≤ 1e8 := le_rfl
  have hH₂ : (1e8 : ℝ) ≤ 3e10 := by norm_num
  have hx0 : 0 < x := by linarith
  set φ : ℝ → ℂ := fun u => (gsm a b δ u : ℂ) with hφ
  have hgood := goodSmoothing_gsm hδ hab
  have hM : mellin φ = Mg a b δ := funext (mellin_gsm hδ hab)
  obtain ⟨Tk, -, hlim⟩ := explicit_formula_zeta hgood hx0
  set I0 := ∫ y : ℝ, hZeta φ x (((-1 / 2 : ℝ) : ℂ) + y * I) with hI0
  have hbound : ∀ T : ℝ, ‖∑ u ∈ zerosRectD zetaF T, (multRectD zetaF T u : ℂ) * (mellin φ u * (x : ℂ) ^ u)‖ ≤
      1e24 * x ^ (23 / 24 : ℝ) + x * (MidB0 a δ 1e8 3e10 x + MidBH a δ 3e10 Γ x) + x * TailBG a δ Γ := by
    intro T
    set Z := zerosRectD zetaF T with hZ
    set m : ℂ → ℝ := fun u => (multRectD zetaF T u : ℝ) with hm
    have h1 : ‖∑ u ∈ Z, (multRectD zetaF T u : ℂ) * (mellin φ u * (x : ℂ) ^ u)‖ ≤
        ∑ u ∈ Z, m u * (‖Mg a b δ u‖ * x ^ u.re) := by
      refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun u _ => ?_)
      rw [norm_mul, norm_mul, Complex.norm_natCast, norm_cpow_x hx0, hM]
    refine h1.trans ?_
    set Z1 := Z.filter fun u => ¬ |u.im| ≤ 1e8 with hZ1
    set Z1b := Z1.filter fun u => ¬ |u.im| ≤ 3e10 with hZ1b
    set Z2 := Z1b.filter fun u => ¬ |u.im| ≤ 3e12 with hZ2
    rw [← Finset.sum_filter_add_sum_filter_not Z (fun u => |u.im| ≤ 1e8),
      ← Finset.sum_filter_add_sum_filter_not Z1 (fun u => |u.im| ≤ 3e10),
      ← Finset.sum_filter_add_sum_filter_not Z1b (fun u => |u.im| ≤ 3e12),
      ← Finset.sum_filter_add_sum_filter_not Z2 (fun u => |u.im| ≤ Γ)]
    have hZ1Z : Z1 ⊆ Z := Finset.filter_subset _ _
    have hZ1bZ : Z1b ⊆ Z := (Finset.filter_subset _ _).trans hZ1Z
    have hZ2Z : Z2 ⊆ Z := (Finset.filter_subset _ _).trans hZ1bZ
    have hA : ∑ u ∈ Z.filter (fun u => |u.im| ≤ 1e8), m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
        1e24 * x ^ (23 / 24 : ℝ) := by
      set S := Z.filter (fun u => |u.im| ≤ 1e8) with hS
      have hSZ : S ⊆ Z := Finset.filter_subset _ _
      have hstrip : ∀ u ∈ S, 1 / 24 ≤ u.re ∧ u.re ≤ 23 / 24 := by
        intro u hu
        obtain ⟨hz, hr0, hr1, -⟩ := zerosRectD_zetaF_strip (hSZ hu)
        exact zeta_zero_qrh24_strip hz hr0 hr1
      have hnorm : ∑ u ∈ S, m u * ‖Mg a b δ u‖ ≤
          1e20 * (2 * Real.exp (δ ^ 2 / 2 + |a|)) := by
        change (∑ u ∈ S, (multRectD zetaF T u : ℝ) * ‖Mg a b δ u‖) ≤ _
        apply sum_weight_zeta_low_twenty_four_le (T := T)
          (C := 2 * Real.exp (δ ^ 2 / 2 + |a|)) S hSZ
          (fun u hu => ⟨by linarith [(hstrip u hu).1], by linarith [(hstrip u hu).2]⟩)
          (fun u hu => (Finset.mem_filter.1 hu).2)
          (fun u => ‖Mg a b δ u‖) (fun u _ => norm_nonneg _) (by positivity)
        intro u hu
        exact norm_Mg_qrh24_strip_le hb (hstrip u hu).1 (hstrip u hu).2
      have hexp : Real.exp (δ ^ 2 / 2 + |a|) ≤ 2 := by
        have hsmall := exp_small_le (t := δ ^ 2 / 2 + |a|) (by positivity)
          (show δ ^ 2 / 2 + |a| ≤ 1 by linarith)
        linarith
      calc
        ∑ u ∈ S, m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
            ∑ u ∈ S, x ^ (23 / 24 : ℝ) * (m u * ‖Mg a b δ u‖) := by
          apply Finset.sum_le_sum
          intro u hu
          have hp := Real.rpow_le_rpow_of_exponent_le hx.le (hstrip u hu).2
          have hm0 : 0 ≤ m u := Nat.cast_nonneg _
          calc
            m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
                m u * (‖Mg a b δ u‖ * x ^ (23 / 24 : ℝ)) :=
              mul_le_mul_of_nonneg_left
                (mul_le_mul_of_nonneg_left hp (norm_nonneg _)) hm0
            _ = x ^ (23 / 24 : ℝ) * (m u * ‖Mg a b δ u‖) := by ring
        _ = x ^ (23 / 24 : ℝ) * ∑ u ∈ S, m u * ‖Mg a b δ u‖ :=
          (Finset.mul_sum _ _ _).symm
        _ ≤ x ^ (23 / 24 : ℝ) * (1e20 * (2 * Real.exp (δ ^ 2 / 2 + |a|))) :=
          mul_le_mul_of_nonneg_left hnorm (Real.rpow_nonneg hx0.le _)
        _ ≤ x ^ (23 / 24 : ℝ) * (1e20 * (2 * 2)) := by gcongr
        _ ≤ 1e24 * x ^ (23 / 24 : ℝ) := by
          nlinarith [Real.rpow_nonneg hx0.le (23 / 24 : ℝ)]
    have hB0 : ∑ u ∈ Z1.filter (fun u => |u.im| ≤ 3e10), m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
        x * MidB0 a δ 1e8 3e10 x := by
      refine mid_sum_le hb hx hH1 _ ((Finset.filter_subset _ _).trans hZ1Z) fun u hu => ?_
      exact ⟨not_le.1 (Finset.mem_filter.1 (Finset.mem_filter.1 hu).1).2, (Finset.mem_filter.1 hu).2⟩
    have hB : ∑ u ∈ Z1b.filter (fun u => |u.im| ≤ 3e12), m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
        x * MidB0 a δ 3e10 3e12 x := by
      refine mid_sum_le hb hx (hH1.trans hH₂) _ ((Finset.filter_subset _ _).trans hZ1bZ) fun u hu => ?_
      exact ⟨not_le.1 (Finset.mem_filter.1 (Finset.mem_filter.1 hu).1).2, (Finset.mem_filter.1 hu).2⟩
    have hC : ∑ u ∈ Z2.filter (fun u => |u.im| ≤ Γ), m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
        x * MidB0 a δ 3e12 Γ x := by
      refine mid_sum_le hb hx (by norm_num) _ ((Finset.filter_subset _ _).trans hZ2Z) fun u hu => ?_
      exact ⟨not_le.1 (Finset.mem_filter.1 (Finset.mem_filter.1 hu).1).2, (Finset.mem_filter.1 hu).2⟩
    have hD : ∑ u ∈ Z2.filter (fun u => ¬ |u.im| ≤ Γ), m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
        x * TailBG a δ Γ := by
      have hSZ := (Finset.filter_subset (fun u => ¬ |u.im| ≤ Γ) Z2).trans hZ2Z
      have him : ∀ u ∈ Z2.filter (fun u => ¬ |u.im| ≤ Γ), Γ < |u.im| := fun u hu =>
        not_le.1 (Finset.mem_filter.1 hu).2
      exact tail_sum_gauss (by linarith) hδ hb hx.le _ hSZ him
    rw [MidBH, mul_add, mul_add]
    linarith
  have h1 : ‖mellin φ 1 * x - SsumG (1 : DirichletCharacter ℂ 1) φ x - (1 / (2 * π) : ℂ) * I0‖ ≤
      1e24 * x ^ (23 / 24 : ℝ) + x * (MidB0 a δ 1e8 3e10 x + MidBH a δ 3e10 Γ x) + x * TailBG a δ Γ :=
    le_of_tendsto' ((continuous_norm.tendsto _).comp hlim) fun k => hbound (Tk k)
  have h2 : ‖(1 / (2 * π) : ℂ) * I0‖ ≤ x ^ (-(1 / 2) : ℝ) * Vg a b δ / (2 * π) := by
    rw [norm_mul]
    have : ‖(1 / (2 * π) : ℂ)‖ = 1 / (2 * π) := by
      rw [norm_div, norm_one, norm_mul, Complex.norm_ofNat, Complex.norm_real, Real.norm_eq_abs,
        abs_of_pos Real.pi_pos]
    rw [this, div_mul_eq_mul_div, one_mul]
    exact div_le_div_of_nonneg_right (norm_integral_hZeta_gsm hδ hab hx0) (by positivity)
  have e : SsumG (1 : DirichletCharacter ℂ 1) φ x - Mg a b δ 1 * x =
      -((mellin φ 1 * x - SsumG (1 : DirichletCharacter ℂ 1) φ x - (1 / (2 * π) : ℂ) * I0) +
        (1 / (2 * π) : ℂ) * I0) := by rw [hM]; ring
  rw [e, norm_neg]
  exact (norm_add_le _ _).trans (add_le_add h1 h2)


/-- The real smoothed-sum form of the QRH estimate. -/
theorem tsum_gsm_le_qrh24 {a b δ x Γ : ℝ}
    (hδ : 0 < δ) (hab : b ≤ a) (hb : b ≤ 0) (hx : 1 < x) (hΓ : 3e12 ≤ Γ)
    (hδa : δ ^ 2 / 2 + |a| ≤ 1e-6) :
    |∑' n : ℕ, Λ n * gsm a b δ (n / x) -
        Real.exp (δ ^ 2 / 2) * (Real.exp a - Real.exp b) * x| ≤
      1e24 * x ^ (23 / 24 : ℝ) + x * (MidB0 a δ 1e8 3e10 x + MidBH a δ 3e10 Γ x) +
        x * TailBG a δ Γ + x ^ (-(1 / 2) : ℝ) * Vg a b δ / (2 * π) := by
  have h := SsumG_gsm_err_qrh24 hδ hab hb hx hΓ hδa
  rw [SsumG_one_ofReal, Mg_one] at h
  rw [show ((∑' n : ℕ, Λ n * gsm a b δ (n / x) : ℝ) : ℂ) -
      ((Real.exp (δ ^ 2 / 2) * (Real.exp a - Real.exp b) : ℝ) : ℂ) * (x : ℂ) =
      ((∑' n : ℕ, Λ n * gsm a b δ (n / x) - Real.exp (δ ^ 2 / 2) *
        (Real.exp a - Real.exp b) * x : ℝ) : ℂ) by
      push_cast; ring, Complex.norm_real, Real.norm_eq_abs] at h
  exact h

/-- The far-asymptotic psi bound with the proven QRH input. -/
theorem psi_asymp_qrh24 {x : ℝ} (hx : Real.exp 35000 ≤ x) :
    |psiR x - x| ≤ 0.2 * x / Real.log x ^ 3 := by
  have hx0 : 0 < x := lt_of_lt_of_le (Real.exp_pos _) hx
  have hx1 : 1 < x := lt_of_lt_of_le
    (by have := Real.add_one_le_exp (35000 : ℝ); linarith) hx
  have hL : 35000 ≤ Real.log x := (Real.le_log_iff_exp_le hx0).2 hx
  apply psi_asymp_of hx
  intro a b δ Γ hδ hab hb hΓ hδa
  have h := tsum_gsm_le_qrh24 hδ hab hb hx1 hΓ hδa
  have hLow := qrh24_low_rpow_absorb hx
  have hMid := mul_le_mul_of_nonneg_left (MidB0_8_asymp_half_le hδa hL) hx0.le
  have hZ : 0 ≤ ZLg BPz2 3e10 := by
    unfold ZLg
    exact div_nonneg (polyDatum_zeta2.log_pos _).le
      (log_ratio_pos (by norm_num) (by norm_num)).le
  have hJ : 0 ≤ Real.log (Jl 3e10) := by
    apply Real.log_nonneg
    unfold Jl
    norm_num
  have hLine : 0 ≤ √x * LineB a δ := by
    unfold LineB
    positivity
  have hMidEq : MidBH a δ 3e10 Γ x = MidB a δ Γ x := rfl
  rw [hMidEq] at h
  have hBudget : 5e-5 * x / Real.log x ^ 3 + x * (5e-5 / Real.log x ^ 3) =
      x * (1e-4 / Real.log x ^ 3) := by ring
  nlinarith only [h, hLow, hMid, hLine, hBudget]
end TernaryGoldbach.Explicit







