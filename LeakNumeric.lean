module

public import LocalLeak
public import Mathlib.Analysis.Complex.ExponentialBounds

@[expose] public section


namespace GrhGoldbach.LocalLeak

theorem exp_101249_div_10000_lower : (24915 : ℝ) ≤ Real.exp (10 * (1 + 0.01249)) := by
  have he : 2.71828 ≤ Real.exp 1 := by linarith only [Real.exp_one_gt_d9]
  have hsmall : (1.01249 : ℝ) ≤ Real.exp 0.01249 := by
    linarith only [Real.add_one_le_exp (0.01249 : ℝ)]
  have hbase : (2.71828 * 1.01249 : ℝ) ≤ Real.exp (1 + 0.01249) := by
    rw [Real.exp_add]
    exact mul_le_mul he hsmall (by norm_num) (Real.exp_pos _).le
  calc
    _ ≤ ((2.71828 * 1.01249 : ℝ) ^ 10) := by norm_num
    _ ≤ (Real.exp (1 + 0.01249)) ^ 10 := pow_le_pow_left₀ (by norm_num) hbase 10
    _ = _ := by rw [← Real.exp_nat_mul]; norm_num

/-- The Chernoff error for K=4.5, w=101/v and δ=2.8/v, once the
representation has height v=√x≥10^6. -/
theorem leak_factor_le {v δ : ℝ} (hv : 1000000 ≤ v) (hd : δ ≤ 0.0000028) :
    126 * (101 * v + 1) * Real.exp (2 * δ ^ 2 - (4.5 - 2 * δ) ^ 2 / 2) ≤ 0.511 * v := by
  have hex : 2 * δ ^ 2 - (4.5 - 2 * δ) ^ 2 / 2 ≤ -(10 * (1 + 0.01249)) := by
    nlinarith only [hd]
  have hfactor : Real.exp (2 * δ ^ 2 - (4.5 - 2 * δ) ^ 2 / 2) ≤ 1 / 24915 := by
    refine (Real.exp_le_exp.mpr hex).trans ?_
    rw [Real.exp_neg, one_div]
    exact inv_anti₀ (by norm_num) exp_101249_div_10000_lower
  calc
    _ ≤ 126 * (101 * v + 1) * (1 / 24915) :=
      mul_le_mul_of_nonneg_left hfactor (by linarith only [hv])
    _ ≤ _ := by linarith only [hv]

end GrhGoldbach.LocalLeak

#print axioms GrhGoldbach.LocalLeak.leak_factor_le
