module

public import Mathlib.Analysis.Real.Pi.Bounds
public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

@[expose] public section


namespace GrhGoldbach.LocalWindow

/-- The numerical majorant from the project's Weil archimedean calculation. -/
theorem density_le {s : ℝ} (hs : 0 ≤ s) (ht : s ≤ 2e14 + 13) :
    0.24567 / max 1 (0.173*s) ^ 4 + 0.16385 * Real.log (s+13) - 0.23516 +
      (1 / Real.pi) * (1 / (2*(s+13)) + 1 / (16*(s+13)^2)) ≤ 5.5 := by
  have hs0 : 0 < s+13 := by linarith only [hs]
  have hl : Real.log (s+13) ≤ 33 := by
    apply (Real.log_le_iff_le_exp hs0).2
    have h1 : (2.718 : ℝ) ≤ Real.exp 1 := by
      have h := Real.sum_le_exp_of_nonneg (by norm_num : (0:ℝ) ≤ 1) 7
      norm_num [Finset.sum_range_succ, Nat.factorial] at h
      linarith only [h]
    have hpow := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 2.718) h1 33
    rw [Real.exp_one_pow] at hpow
    norm_num only [Nat.cast_ofNat] at hpow
    have hx : (200000000000026 : ℝ) ≤ 2.718 ^ 33 := by norm_num
    linarith only [hpow, hx, ht]
  have hmax := le_max_left 1 (0.173*s)
  have hm0 : 0 < max 1 (0.173*s) := zero_lt_one.trans_le hmax
  have hpow := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 1) hmax 4
  norm_num at hpow
  have hp : 0.24567 / max 1 (0.173*s) ^ 4 ≤ (0.24567 : ℝ) := by
    apply (div_le_iff₀ (pow_pos hm0 _)).2
    linarith only [hpow]
  have h1 := one_div_le_one_div_of_le (by norm_num : (0:ℝ) < 26)
    (show 26 ≤ 2*(s+13) by linarith only [hs])
  have h2 := one_div_le_one_div_of_le (by norm_num : (0:ℝ) < 2704)
    (show 2704 ≤ 16*(s+13)^2 by nlinarith only [hs, sq_nonneg s])
  have hpi := one_div_le_one_div_of_le (by norm_num : (0:ℝ) < 3) Real.pi_gt_three.le
  have hsmall := mul_le_mul hpi (add_le_add h1 h2)
    (show 0 ≤ 1/(2*(s+13)) + 1/(16*(s+13)^2) by positivity)
    (show (0:ℝ) ≤ 1/3 by norm_num)
  linarith only [hp, hl, hsmall]

end GrhGoldbach.LocalWindow
