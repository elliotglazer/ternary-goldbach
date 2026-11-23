import TernaryGoldbach.Explicit.PsiLarge

open Complex Set Filter MeasureTheory Finset
open scoped Real Interval Topology

namespace TernaryGoldbach.Explicit

theorem MidB0_8_asymp_half_le {a δ x : ℝ} (hδa : δ ^ 2 / 2 + |a| ≤ 1e-6) (hx : 35000 ≤ Real.log x) :
    MidB0 a δ 1e8 3e10 x ≤ 5e-5 / Real.log x ^ 3 := by
  set L := Real.log x with hL
  have hL0 : 0 < L := by linarith
  unfold MidB0
  have he : Real.exp (δ ^ 2 / 2 + |a|) ≤ 1.000003 := by
    have h := exp_small_le (t := δ ^ 2 / 2 + |a|) (by positivity) (by linarith)
    linarith
  have hlg : Real.log 3e10 ≤ 24.1245 := (Real.log_le_log (by norm_num) (by norm_num)).trans log_3e10_le
  have hlg0 : 0 < Real.log 3e10 := Real.log_pos (by norm_num)
  -- `log L ≤ L/1500`
  have h15 : Real.log 15000 ≤ 9.62 := by
    refine log_le_of_le_exp'' (by norm_num) ?_
    have h := exp_split_ge' 9 (u := 0.62) (by norm_num) 10
    norm_num [Finset.sum_range_succ, Nat.factorial] at h ⊢; linarith
  have hlL : Real.log L ≤ L / 1500 := by
    have h1 := Real.log_le_sub_one_of_pos (x := L / 15000) (by positivity)
    rw [Real.log_div hL0.ne' (by norm_num)] at h1
    have : L / 15000 - 1 + 9.62 ≤ L / 1500 := by
      rw [show L / 15000 - 1 + 9.62 = L / 15000 + 8.62 by ring]
      have : 8.62 ≤ L / 1500 - L / 15000 := by
        rw [show L / 1500 - L / 15000 = L * 6e-4 by ring]; nlinarith
      linarith
    linarith
  have hzf : L ^ 3 * Real.exp (-(L / (11 * Real.log 3e10))) ≤ Real.exp (-60) := by
    have hL3 : L ^ 3 = Real.exp (3 * Real.log L) := by
      rw [show (3 : ℝ) * Real.log L = ((3 : ℕ) : ℝ) * Real.log L by norm_num, Real.exp_nat_mul,
        Real.exp_log hL0]
    rw [hL3, ← Real.exp_add]
    apply Real.exp_le_exp.2
    have h1 : L / (26537 / 100) ≤ L / (11 * Real.log 3e10) :=
      div_le_div_of_nonneg_left hL0.le (by positivity) (by linarith)
    have e1 : L / (26537 / 100) = L * 100 / 26537 := by ring
    rw [e1] at h1
    linarith
  have he60 : Real.exp (-60) ≤ 1e-26 := by
    rw [Real.exp_neg, inv_le_comm₀ (Real.exp_pos _) (by norm_num)]
    have := exp_nat_ge' 60
    norm_num at this ⊢; linarith
  have hK : ((⌊((3e10 : ℝ) - 1e8) / 4.4⌋₊ : ℕ) : ℝ) + 1 ≤ 6.8e9 := by
    have := Nat.floor_le (show (0:ℝ) ≤ ((3e10 : ℝ) - 1e8) / 4.4 by norm_num)
    norm_num at this ⊢
  have hl := log_10_3_ge
  have hZ : Z3g BPz2 1e8 ≤ 210.6 := by
    refine le_trans ?_ Z3g_H_le
    unfold Z3g
    refine div_le_div_of_nonneg_right (polyDatum_zeta2.log_mono ?_) (log_ratio_pos (by norm_num) (by norm_num)).le
    rw [abs_of_pos (by norm_num : (0 : ℝ) < 1e8), abs_of_pos (by norm_num : (0 : ℝ) < 3e10)]; norm_num
  have hZ0 : 0 ≤ Z3g BPz2 1e8 :=
    div_nonneg (polyDatum_zeta2.log_pos _).le (lt_of_lt_of_le (by norm_num) hl).le
  have hc : c3g 10 1e8 ≤ 3.66e-7 := by
    unfold c3g
    rw [div_le_iff₀ (lt_of_lt_of_le (by norm_num) hl)]
    nlinarith
  have hc0 : 0 ≤ c3g 10 1e8 := by
    unfold c3g; exact div_nonneg (by norm_num) (lt_of_lt_of_le (by norm_num) hl).le
  have hK0 : (0:ℝ) ≤ ((⌊((3e10 : ℝ) - 1e8) / 4.4⌋₊ : ℕ) : ℝ) + 1 := by positivity
  set E := Real.exp (-(L / (11 * Real.log 3e10))) with hE
  have hE0 : 0 ≤ E := (Real.exp_pos _).le
  set C := (((⌊((3e10 : ℝ) - 1e8) / 4.4⌋₊ : ℕ) : ℝ) + 1) * (2 * Z3g BPz2 1e8 + 2 * c3g 10 1e8 *
      (((⌊((3e10 : ℝ) - 1e8) / 4.4⌋₊ : ℕ) : ℝ) + 1)) with hC
  have hCb : C ≤ 6.8e9 * (2 * 210.6 + 2 * 3.66e-7 * 6.8e9) := by rw [hC]; gcongr
  have hC0 : 0 ≤ C := by rw [hC]; positivity
  rw [le_div_iff₀ (by positivity)]
  calc 2 * Real.exp (δ ^ 2 / 2 + |a|) / 1e8 * E * C * L ^ 3
      = 2 * Real.exp (δ ^ 2 / 2 + |a|) / 1e8 * C * (L ^ 3 * E) := by ring
    _ ≤ 2 * 1.000003 / 1e8 * (6.8e9 * (2 * 210.6 + 2 * 3.66e-7 * 6.8e9)) * 1e-26 := by
        gcongr
        exact hzf.trans he60
    _ ≤ 5e-5 := by norm_num


end TernaryGoldbach.Explicit


