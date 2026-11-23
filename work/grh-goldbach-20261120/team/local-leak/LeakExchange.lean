import ShiftCount
import GaussianSource

open Set Finset MeasureTheory Filter
open scoped ArithmeticFunction.vonMangoldt Interval
open GrhGoldbach.GaussianSource

namespace GrhGoldbach.LocalLeak

/-- Exterior Gaussian mass for every finite collection of positive integer
indices. The density and Mellin smoothing in GaussianSource reproduce the
upstream definitions. -/
theorem finite_gaussian_leak {S : Finset ℕ} {x w δ K : ℝ} (hx : 0 < x)
    (hlog : Real.log x ≤ 63) (hw : 0 ≤ w) (hd : 0 < δ) (hK : 2 * δ ≤ K)
    (hpos : ∀ n ∈ S, 0 < n)
    (hout : ∀ n ∈ S, (n : ℝ) ∉ Ioc (x * Real.exp (-(K * δ) - w - K * δ)) x) :
    ∑ n ∈ S, Λ n * gsm (-(K * δ)) (-(K * δ) - w) δ (n / x) ≤
      126 * (x * w + 1) * Real.exp (2 * δ ^ 2 - (K - 2 * δ) ^ 2 / 2) := by
  classical
  let W (n : ℕ) := Ioc ((-(K * δ) - w - Real.log (n / x)) / δ)
                         ((-(K * δ) - Real.log (n / x)) / δ)
  let A := 63 * (x * w + 1) * Real.exp (-(K - 2 * δ) * K)
  have hfun (n : ℕ) : gsm (-(K * δ)) (-(K * δ) - w) δ (n / x) =
      ∫ z, (W n).indicator gpdf z := by
    rw [integral_indicator measurableSet_Ioc, gsm, intervalIntegral.integral_of_le]
    exact div_le_div_of_nonneg_right (by linarith only [hw]) hd.le
  have hint (n : ℕ) : Integrable (fun z => Λ n * (W n).indicator gpdf z) :=
    (integrable_gpdf.indicator measurableSet_Ioc).const_mul _
  have hpoint (z : ℝ) :
      ∑ n ∈ S, Λ n * (W n).indicator gpdf z ≤
      A * (gpdf z * Real.exp (K * z) + gpdf z * Real.exp (-K * z)) := by
    let F := S.filter (fun n => z ∈ W n)
    have hshift : ∀ n ∈ F, (n : ℝ) ∈
        Ioc (x * Real.exp (-(K * δ) - w - δ * z)) (x * Real.exp (-(K * δ) - δ * z)) := by
      intro n hn
      obtain ⟨hnS, hnW⟩ := Finset.mem_filter.mp hn
      exact (mem_log_window_iff hx (by exact_mod_cast hpos n hnS) hd).mp hnW
    have hbound := shifted_outside_sum_le hx hlog hw hd.le hK hshift
      (fun n hn => hout n (Finset.mem_filter.mp hn).1)
    calc
      _ = ∑ n ∈ F, Λ n * gpdf z := by
        dsimp only [F]
        rw [Finset.sum_filter]
        apply Finset.sum_congr rfl
        intro n _
        by_cases hz : z ∈ W n <;> simp [Set.indicator, hz]
      _ = (∑ n ∈ F, Λ n) * gpdf z := (Finset.sum_mul ..).symm
      _ ≤ _ := by
        have hm := mul_le_mul_of_nonneg_right hbound (gpdf_nonneg z)
        dsimp only [A]; convert hm using 1 <;> ring
  have hcalc := integral_mono (integrable_finsetSum _ (fun n _ => hint n))
    (((integrable_gpdf_mul_exp K).add (integrable_gpdf_mul_exp (-K))).const_mul A) hpoint
  rw [integral_finsetSum _ (fun n _ => hint n), integral_const_mul] at hcalc
  simp only [Pi.add_apply] at hcalc
  rw [integral_add (integrable_gpdf_mul_exp K) (integrable_gpdf_mul_exp (-K)),
    integral_gpdf_mul_exp, integral_gpdf_mul_exp, neg_sq] at hcalc
  simp_rw [integral_const_mul, ← hfun] at hcalc
  calc
    _ ≤ A * (Real.exp (K ^ 2 / 2) + Real.exp (K ^ 2 / 2)) := hcalc
    _ = 126 * (x * w + 1) * (Real.exp (-(K - 2 * δ) * K) * Real.exp (K ^ 2 / 2)) := by
      dsimp only [A]; ring
    _ = _ := by rw [chernoff_moment_factor]

end GrhGoldbach.LocalLeak

#print axioms GrhGoldbach.LocalLeak.finite_gaussian_leak
