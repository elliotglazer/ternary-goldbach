module

public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

@[expose] public section


/-! A localized Gaussian majorant for the low zeros of zeta. -/

open MeasureTheory Set
open scoped Interval

namespace GrhGoldbach.LocalWindow

/-- Nonsingular at zero, where the reciprocal factor is the width. -/
noncomputable def weight (w δ t : ℝ) : ℝ :=
  Real.exp (-(δ ^ 2 * t ^ 2 / 2)) * (2 / max t (2 / w))

theorem weight_continuous {w : ℝ} (hw : 0 < w) (δ : ℝ) : Continuous (weight w δ) := by
  unfold weight
  refine (by fun_prop : Continuous fun t : ℝ => Real.exp (-(δ ^ 2 * t ^ 2 / 2))).mul ?_
  exact continuous_const.div (continuous_id.max continuous_const) fun t =>
    (lt_of_lt_of_le (by positivity : (0 : ℝ) < 2 / w) (le_max_right t _)).ne'

theorem weight_nonneg {w : ℝ} (hw : 0 < w) (δ t : ℝ) : 0 ≤ weight w δ t := by
  have : 0 < max t (2 / w) := lt_of_lt_of_le (by positivity) (le_max_right _ _)
  unfold weight
  positivity

theorem weight_antitone {w : ℝ} (hw : 0 < w) (δ : ℝ) : AntitoneOn (weight w δ) (Ici 0) := by
  intro s hs t ht hst
  have hse : s ^ 2 ≤ t ^ 2 := pow_le_pow_left₀ hs hst 2
  have he : Real.exp (-(δ ^ 2 * t ^ 2 / 2)) ≤ Real.exp (-(δ ^ 2 * s ^ 2 / 2)) := by
    apply Real.exp_le_exp.2
    linarith only [mul_le_mul_of_nonneg_left hse (sq_nonneg δ)]
  have hm : 0 < max s (2 / w) := lt_of_lt_of_le (by positivity) (le_max_right _ _)
  have hd : 2 / max t (2 / w) ≤ 2 / max s (2 / w) :=
    div_le_div_of_nonneg_left (by norm_num) hm (max_le_max hst le_rfl)
  have hm' : 0 < max t (2 / w) := hm.trans_le (max_le_max hst le_rfl)
  exact mul_le_mul he hd (by positivity) (Real.exp_pos _).le

theorem weight_le_width {w : ℝ} (hw : 0 < w) (δ t : ℝ) : weight w δ t ≤ w := by
  have hm : 0 < max t (2 / w) := lt_of_lt_of_le (by positivity) (le_max_right _ _)
  have he : Real.exp (-(δ ^ 2 * t ^ 2 / 2)) ≤ 1 :=
    Real.exp_le_one_iff.mpr (neg_nonpos.mpr (by positivity))
  have hd := div_le_div_of_nonneg_left (by norm_num : (0 : ℝ) ≤ 2)
    (by positivity : (0 : ℝ) < 2 / w) (le_max_right t (2 / w))
  calc weight w δ t ≤ 1 * (2 / max t (2 / w)) := mul_le_mul_of_nonneg_right he (by positivity)
    _ ≤ 2 / (2 / w) := by simpa only [one_mul] using hd
    _ = w := by field_simp

private theorem integral_gaussian_derivative {δ : ℝ} (hδ : 0 < δ) (a b : ℝ) :
    ∫ u in a..b, u * Real.exp (-(δ ^ 2 * u ^ 2 / 2)) =
      (Real.exp (-(δ ^ 2 * a ^ 2 / 2)) - Real.exp (-(δ ^ 2 * b ^ 2 / 2))) / δ ^ 2 := by
  have hd : ∀ u ∈ [[a,b]], HasDerivAt (fun u : ℝ => -(Real.exp (-(δ ^ 2 * u ^ 2 / 2)) / δ ^ 2))
      (u * Real.exp (-(δ ^ 2 * u ^ 2 / 2))) u := by
    intro u _
    have h := ((((hasDerivAt_pow 2 u).const_mul (δ ^ 2)).div_const 2).neg.exp.div_const (δ ^ 2)).neg
    change HasDerivAt (fun z : ℝ => -(Real.exp (-(δ^2*z^2/2)) / δ^2))
      (-(Real.exp (-(δ^2*u^2/2)) * -(δ^2*((2:ℕ)*u^(2-1))/2) / δ^2)) u at h
    have he : -(Real.exp (-(δ^2*u^2/2)) * -(δ^2*((2:ℕ)*u^(2-1))/2) / δ^2) =
        u * Real.exp (-(δ^2*u^2/2)) := by
      push_cast <;> norm_num <;> field_simp <;> ring
    rwa [he] at h
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hd (by apply Continuous.intervalIntegrable; fun_prop)]
  ring

/-- Integrate the flat, reciprocal and Gaussian parts to arbitrary finite height. -/
theorem integral_weight_le {w δ Y : ℝ} (hw : 0 < w) (hδ : 0 < δ)
    (hcut : 2 / w ≤ 1 / δ) (hY : 1 / δ ≤ Y) :
    ∫ t in (0 : ℝ)..Y, weight w δ t ≤
      2 + 2 * Real.log (w / (2 * δ)) + 2 * Real.exp (-(1 / 2)) := by
  set A := 2 / w with hA
  set B := 1 / δ with hB
  have hA0 : 0 < A := by dsimp [A]; positivity
  have hB0 : 0 < B := by dsimp [B]; positivity
  have hi : ∀ a b : ℝ, IntervalIntegrable (weight w δ) volume a b :=
    (weight_continuous hw δ).intervalIntegrable
  have hlow : ∫ t in (0 : ℝ)..A, weight w δ t ≤ 2 := by
    calc ∫ t in (0 : ℝ)..A, weight w δ t ≤ ∫ _t in (0 : ℝ)..A, w :=
          intervalIntegral.integral_mono_on hA0.le (hi _ _) (continuous_const.intervalIntegrable _ _)
            fun t _ => weight_le_width hw δ t
      _ = 2 := by rw [intervalIntegral.integral_const]; dsimp [A]; simp; field_simp
  have hmid : ∫ t in A..B, weight w δ t ≤ 2 * Real.log (w / (2 * δ)) := by
    have hc : ContinuousOn (fun t : ℝ => 2 * t⁻¹) [[A,B]] :=
      continuousOn_const.mul (continuousOn_id.inv₀ fun t ht =>
        (lt_of_lt_of_le hA0 (by rw [uIcc_of_le hcut] at ht; exact ht.1)).ne')
    calc ∫ t in A..B, weight w δ t ≤ ∫ t in A..B, 2 * t⁻¹ := by
          refine intervalIntegral.integral_mono_on hcut (hi _ _) hc.intervalIntegrable fun t ht => ?_
          have ht0 : 0 < t := hA0.trans_le ht.1
          unfold weight
          rw [max_eq_left (show 2 / w ≤ t from ht.1), div_eq_mul_inv]
          exact mul_le_of_le_one_left (by positivity)
            (Real.exp_le_one_iff.mpr (neg_nonpos.mpr (by positivity)))
      _ = 2 * Real.log (w / (2 * δ)) := by
          rw [intervalIntegral.integral_const_mul, integral_inv_of_pos hA0 hB0]
          congr 2
          dsimp [A,B]
          field_simp
  have htail : ∫ t in B..Y, weight w δ t ≤ 2 * Real.exp (-(1 / 2)) := by
    have hpoint : ∀ t ∈ Icc B Y, weight w δ t ≤
        (2 * δ ^ 2) * (t * Real.exp (-(δ ^ 2 * t ^ 2 / 2))) := by
      intro t ht
      have ht0 : 0 < t := hB0.trans_le ht.1
      have hdt : 1 ≤ δ * t := by
        have := (div_le_iff₀ hδ).1 (show 1 / δ ≤ t from ht.1)
        linarith
      have hsq : 1 ≤ (δ * t) ^ 2 := by nlinarith [sq_nonneg (δ*t-1)]
      have hrec : 2 / t ≤ 2 * δ ^ 2 * t := by
        apply (div_le_iff₀ ht0).2
        nlinarith only [hsq]
      unfold weight
      rw [max_eq_left (show 2 / w ≤ t from hcut.trans ht.1)]
      calc _ ≤ Real.exp (-(δ ^ 2 * t ^ 2 / 2)) * (2 * δ ^ 2 * t) :=
              mul_le_mul_of_nonneg_left hrec (Real.exp_pos _).le
        _ = _ := by ring
    calc ∫ t in B..Y, weight w δ t ≤ ∫ t in B..Y,
              (2 * δ ^ 2) * (t * Real.exp (-(δ ^ 2 * t ^ 2 / 2))) :=
          intervalIntegral.integral_mono_on hY (hi _ _) (by apply Continuous.intervalIntegrable; fun_prop) hpoint
      _ ≤ 2 * Real.exp (-(1 / 2)) := by
          rw [intervalIntegral.integral_const_mul, integral_gaussian_derivative hδ]
          have he : δ ^ 2 * B ^ 2 = 1 := by dsimp [B]; field_simp
          rw [he]
          have hd : δ ^ 2 ≠ 0 := pow_ne_zero _ hδ.ne'
          field_simp
          nlinarith [Real.exp_pos (-(δ ^ 2 * Y ^ 2 / 2))]
  rw [← intervalIntegral.integral_add_adjacent_intervals (hi 0 B) (hi B Y),
      ← intervalIntegral.integral_add_adjacent_intervals (hi 0 A) (hi A B)]
  linarith

/-- Scalar coefficient at the localized Goldbach parameters. -/
theorem line_coefficient_lt {v : ℝ} (hv : 30000000 ≤ v) :
    Real.exp ((2.8 / v) ^ 2 / 8) * 11 *
      (13 * (101 / v) + 2 + 2 * Real.log (101 / 5.6) + 2 * Real.exp (-(1 / 2))) <
      98.977 := by
  have hv0 : 0 < v := by linarith
  have hw : (101 : ℝ) / v ≤ 0.00000337 := by
    apply (div_le_iff₀ hv0).2
    linarith only [hv]
  have hd : (2.8 : ℝ) / v ≤ 0.0000001 := by
    apply (div_le_iff₀ hv0).2
    linarith only [hv]
  have hd0 : (0 : ℝ) ≤ 2.8 / v := by positivity
  have hs := pow_le_pow_left₀ hd0 hd 2
  have hq : (2.8 / v) ^ 2 / 8 ≤ 0.0000001 := by nlinarith only [hs]
  have hE := Real.exp_bound' (by positivity : (0 : ℝ) ≤ (2.8 / v) ^ 2 / 8)
    (show (2.8 / v) ^ 2 / 8 ≤ 1 by linarith only [hq]) (n := 1) one_pos
  norm_num [Finset.sum_range_succ] at hE
  have hE' : Real.exp ((2.8 / v) ^ 2 / 8) ≤ 1.000001 := by linarith only [hE, hq]
  have hlog : Real.log (101 / 5.6) ≤ 2.89236 := by
    apply (Real.log_le_iff_le_exp (by norm_num : (0 : ℝ) < 101 / 5.6)).2
    have h := Real.sum_le_exp_of_nonneg (by norm_num : (0 : ℝ) ≤ 2.89236) 14
    norm_num [Finset.sum_range_succ, Nat.factorial] at h ⊢
    linarith only [h]
  have hhalf : Real.exp (-(1 / 2)) ≤ 0.606531 := by
    rw [Real.exp_neg, inv_le_iff_one_le_mul₀ (Real.exp_pos _)]
    have h := Real.sum_le_exp_of_nonneg (by norm_num : (0 : ℝ) ≤ 1 / 2) 10
    norm_num [Finset.sum_range_succ, Nat.factorial] at h ⊢
    linarith only [h]
  have hsum' : 13 * (101 / v) + 2 + 2 * Real.log (101 / 5.6) + 2 * Real.exp (-(1 / 2))
      ≤ 8.99784 := by linarith only [hw, hlog, hhalf]
  have hprod := mul_le_mul_of_nonneg_left hsum' (show 0 ≤ Real.exp ((2.8 / v) ^ 2 / 8) * 11 by positivity)
  linarith only [hprod, hE']

end GrhGoldbach.LocalWindow
