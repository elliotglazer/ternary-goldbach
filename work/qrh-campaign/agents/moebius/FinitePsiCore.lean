import TernaryGoldbach.Prelim.SmallPsiTableMain
import TernaryGoldbach.Prelim.SmallPsi700

/-! Finite prime bounds for testing independently of the analytic prime estimates. -/

open Finset
open scoped ArithmeticFunction.vonMangoldt

namespace TernaryGoldbach.Prelim

theorem thS_add_ppS_finite (n : ℕ) :
    SmallTab.thS n + SmallTab.ppS n = ∑ m ∈ Icc 1 n, (Λ m : ℝ) := by
  unfold SmallTab.thS SmallTab.ppS
  rw [Finset.sum_filter, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun m _ => ?_
  split_ifs with h
  · rw [ArithmeticFunction.vonMangoldt_apply_prime h]
    ring
  · ring

theorem psi_small_two_sided_sum_finite {n : ℕ} (h1 : 12 ≤ n) (h2 : n < 1000000) :
    |(∑ m ∈ Icc 1 n, (Λ m : ℝ)) - n| ≤ √(n : ℝ) := by
  obtain ⟨r1, r2, -, -⟩ := SmallTab.small_table (t := (n : ℝ))
    (by exact_mod_cast h1) (by exact_mod_cast h2)
  rw [Nat.floor_natCast, thS_add_ppS_finite] at r1 r2
  norm_num at r1 r2
  rw [abs_le]
  constructor <;> linarith

theorem psi_small_linear_sum_finite {n : ℕ} (h2 : n < 1000000) :
    (∑ m ∈ Icc 1 n, (Λ m : ℝ)) ≤ 1.03883 * n := by
  by_cases hn : n = 0
  · subst n
    simp
  rcases le_or_gt n 700 with h | h
  · exact (Small.psi_lt_small_700 (by omega) h).le
  have hB := (abs_le.1 (psi_small_two_sided_sum_finite (by omega) h2)).2
  have hss := Real.mul_self_sqrt (Nat.cast_nonneg n : (0 : ℝ) ≤ n)
  have hs : (26.47 : ℝ) ≤ √(n : ℝ) := Real.le_sqrt_of_sq_le (by
    have hn701 : 701 ≤ n := by omega
    have : (701 : ℝ) ≤ n := by exact_mod_cast hn701
    linarith)
  nlinarith

#print axioms psi_small_two_sided_sum_finite
#print axioms psi_small_linear_sum_finite

end TernaryGoldbach.Prelim

