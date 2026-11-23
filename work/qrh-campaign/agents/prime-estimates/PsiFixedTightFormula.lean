import TernaryGoldbach.Explicit.PsiLarge
import PsiFixedAux
import ZeroFreeFixedGap
import ZeroSumStrip

open Complex Set Filter MeasureTheory Finset
open scoped Real Interval Topology ArithmeticFunction.vonMangoldt

namespace TernaryGoldbach.Explicit

/-- A fixed-gap replacement of the Gaussian explicit-formula estimate. -/
theorem SsumG_gsm_err_fixed_tight {a b δ x Γ : ℝ}
    (hδ : 0 < δ) (hab : b ≤ a) (hb : b ≤ 0) (hx : 1 < x) (hΓ : 3e12 ≤ Γ)
    (hδa : δ ^ 2 / 2 + |a| ≤ 1e-6) :
    ‖SsumG (1 : DirichletCharacter ℂ 1) (fun u => (gsm a b δ u : ℂ)) x - Mg a b δ 1 * x‖ ≤
      3e10 * x ^ (249 / 250 : ℝ) + x * (MidB0 a δ 1e8 3e10 x + MidBH a δ 3e10 Γ x) +
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
      3e10 * x ^ (249 / 250 : ℝ) + x * (MidB0 a δ 1e8 3e10 x + MidBH a δ 3e10 Γ x) + x * TailBG a δ Γ := by
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
        3e10 * x ^ (249 / 250 : ℝ) := by
      set S := Z.filter (fun u => |u.im| ≤ 1e8) with hS
      have hSZ : S ⊆ Z := Finset.filter_subset _ _
      have hstrip : ∀ u ∈ S, 0 < u.re ∧ u.re ≤ 249 / 250 := by
        intro u hu
        obtain ⟨hz, hr0, hr1, -⟩ := zerosRectD_zetaF_strip (hSZ hu)
        exact ⟨hr0, zeta_zero_re_le_fixed hz hr0 hr1 (Finset.mem_filter.1 hu).2⟩
      have hnorm : ∑ u ∈ S, m u * ‖Mg a b δ u‖ ≤ 3e10 := by
        have hunit : ∀ u ∈ S, ‖Mg a b δ u‖ ≤ 1 := by
          intro u hu
          obtain ⟨hz, hr0, hr1, -⟩ := zerosRectD_zetaF_strip (hSZ hu)
          have him := abs_im_ge_of_nontrivial_zero hz hr0 hr1
          have hMg := norm_Mg_im_le hb hr0 hr1
          have hExp := exp_small_le (t := δ ^ 2 / 2 + |a|) (by positivity)
            (show δ ^ 2 / 2 + |a| ≤ 1 by linarith)
          have hprod := mul_le_mul_of_nonneg_left him (norm_nonneg (Mg a b δ u))
          nlinarith only [hMg, hExp, hprod, hδa]
        calc
          ∑ u ∈ S, m u * ‖Mg a b δ u‖ ≤ ∑ u ∈ S, m u := by
            apply Finset.sum_le_sum
            intro u hu
            simpa only [mul_one] using
              mul_le_mul_of_nonneg_left (hunit u hu) (show 0 ≤ m u from Nat.cast_nonneg _)
          _ ≤ 3e10 := by
            change (∑ u ∈ S, (multRectD zetaF T u : ℝ)) ≤ 3e10
            exact sum_mult_zeta_low_sharp_le S hSZ
              (fun u hu => ⟨by linarith [(hstrip u hu).1], by linarith [(hstrip u hu).2]⟩)
              (fun u hu => (Finset.mem_filter.1 hu).2)
      calc
        ∑ u ∈ S, m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
            ∑ u ∈ S, x ^ (249 / 250 : ℝ) * (m u * ‖Mg a b δ u‖) := by
          apply Finset.sum_le_sum
          intro u hu
          have hp := Real.rpow_le_rpow_of_exponent_le hx.le (hstrip u hu).2
          have hm0 : 0 ≤ m u := Nat.cast_nonneg _
          calc
            m u * (‖Mg a b δ u‖ * x ^ u.re) ≤
                m u * (‖Mg a b δ u‖ * x ^ (249 / 250 : ℝ)) :=
              mul_le_mul_of_nonneg_left
                (mul_le_mul_of_nonneg_left hp (norm_nonneg _)) hm0
            _ = x ^ (249 / 250 : ℝ) * (m u * ‖Mg a b δ u‖) := by ring
        _ = x ^ (249 / 250 : ℝ) * ∑ u ∈ S, m u * ‖Mg a b δ u‖ :=
          (Finset.mul_sum _ _ _).symm
        _ ≤ x ^ (249 / 250 : ℝ) * 3e10 :=
          mul_le_mul_of_nonneg_left hnorm (Real.rpow_nonneg hx0.le _)
        _ = 3e10 * x ^ (249 / 250 : ℝ) := by ring
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
      3e10 * x ^ (249 / 250 : ℝ) + x * (MidB0 a δ 1e8 3e10 x + MidBH a δ 3e10 Γ x) + x * TailBG a δ Γ :=
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


/-- The real smoothed-sum form of the tight fixed-gap estimate. -/
theorem tsum_gsm_le_fixed_tight {a b δ x Γ : ℝ}
    (hδ : 0 < δ) (hab : b ≤ a) (hb : b ≤ 0) (hx : 1 < x) (hΓ : 3e12 ≤ Γ)
    (hδa : δ ^ 2 / 2 + |a| ≤ 1e-6) :
    |∑' n : ℕ, Λ n * gsm a b δ (n / x) -
        Real.exp (δ ^ 2 / 2) * (Real.exp a - Real.exp b) * x| ≤
      3e10 * x ^ (249 / 250 : ℝ) + x * (MidB0 a δ 1e8 3e10 x + MidBH a δ 3e10 Γ x) +
        x * TailBG a δ Γ + x ^ (-(1 / 2) : ℝ) * Vg a b δ / (2 * π) := by
  have h := SsumG_gsm_err_fixed_tight hδ hab hb hx hΓ hδa
  rw [SsumG_one_ofReal, Mg_one] at h
  rw [show ((∑' n : ℕ, Λ n * gsm a b δ (n / x) : ℝ) : ℂ) -
      ((Real.exp (δ ^ 2 / 2) * (Real.exp a - Real.exp b) : ℝ) : ℂ) * (x : ℂ) =
      ((∑' n : ℕ, Λ n * gsm a b δ (n / x) - Real.exp (δ ^ 2 / 2) *
        (Real.exp a - Real.exp b) * x : ℝ) : ℂ) by
      push_cast; ring, Complex.norm_real, Real.norm_eq_abs] at h
  exact h

end TernaryGoldbach.Explicit


