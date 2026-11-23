import LeakExchange
import LeakNumeric

open Set Finset
open GrhGoldbach.GaussianSource
open scoped ArithmeticFunction.vonMangoldt

namespace GrhGoldbach.LocalLeak

theorem gaussian_leak_tsum {x w δ K : ℝ} (hx : 0 < x)
    (hlog : Real.log x ≤ 63) (hw : 0 ≤ w) (hd : 0 < δ) (hK : 2 * δ ≤ K) :
    (∑' n : ℕ, if 0 < n ∧ (n : ℝ) ∉ Ioc (x * Real.exp (-(K * δ) - w - K * δ)) x
      then Λ n * gsm (-(K * δ)) (-(K * δ) - w) δ (n / x) else 0) ≤
      126 * (x * w + 1) * Real.exp (2 * δ ^ 2 - (K - 2 * δ) ^ 2 / 2) := by
  classical
  apply Real.tsum_le_of_sum_range_le
  · intro n
    split_ifs
    · apply mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
      apply intervalIntegral.integral_nonneg
      · exact div_le_div_of_nonneg_right (by linarith only [hw]) hd.le
      · exact fun z _ => gpdf_nonneg z
    · exact le_rfl
  · intro N
    rw [← Finset.sum_filter]
    refine finite_gaussian_leak hx hlog hw hd hK ?_ ?_
    · exact fun n hn => (Finset.mem_filter.mp hn).2.1
    · exact fun n hn => (Finset.mem_filter.mp hn).2.2

/-- Leakage of the normalized Gaussian sum outside the buffered prime
interval, uniform on the full range used by the localized argument. -/
theorem gaussian_leak_0511 {x : ℝ} (hlo : 10 ^ 15 ≤ x) (hhi : x ≤ 10 ^ 27) :
    let v := Real.sqrt x
    let w := 101 / v
    let δ := 2.8 / v
    let K : ℝ := 4.5
    (∑' n : ℕ, if 0 < n ∧ (n : ℝ) ∉ Ioc (x * Real.exp (-(K * δ) - w - K * δ)) x
      then Λ n * gsm (-(K * δ)) (-(K * δ) - w) δ (n / x) else 0) ≤ 0.511 * v := by
  dsimp only
  have hx : 0 < x := lt_of_lt_of_le (by norm_num) hlo
  have hs : 0 < Real.sqrt x := Real.sqrt_pos.mpr hx
  have hv : 1000000 ≤ Real.sqrt x :=
    Real.le_sqrt_of_sq_le ((by norm_num : (1000000 : ℝ) ^ 2 ≤ 10 ^ 15).trans hlo)
  have hd : 2.8 / Real.sqrt x ≤ 0.0000028 := (div_le_iff₀ hs).mpr (by linarith only [hv])
  have hlog : Real.log x ≤ 63 := by
    have hl := Real.log_le_log hx hhi
    rw [Real.log_pow, Real.log_ten_eq] at hl
    norm_num only [Nat.cast_ofNat] at hl
    linarith only [hl, Real.log_two_lt_d9, Real.log_five_lt_d9]
  have ht := gaussian_leak_tsum (w := 101 / Real.sqrt x) (δ := 2.8 / Real.sqrt x)
    (K := 4.5) hx hlog (by positivity) (by positivity) (by linarith only [hd])
  have he : x * (101 / Real.sqrt x) = 101 * Real.sqrt x := by
    rw [← mul_div_assoc, div_eq_iff hs.ne']
    nlinarith only [Real.sq_sqrt hx.le]
  rw [he] at ht
  exact ht.trans (leak_factor_le hv hd)

end GrhGoldbach.LocalLeak

#print axioms GrhGoldbach.LocalLeak.gaussian_leak_0511
