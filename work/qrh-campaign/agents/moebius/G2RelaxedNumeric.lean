import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum

/-! Exact arithmetic for a relaxed internal G2 budget.
These declarations prove numeric inequalities only. The new Möbius profile
and the modified G2 integer-checker equality are separate obligations.
-/

namespace TernaryGoldbach.QrhResearch

theorem relaxed_profile_arithmetic :
    (1.00001 : ℝ) * (0.0009 / 9.377 + 0.0091 / 18.42) ≤ 0.000591 := by
  norm_num

theorem relaxed_g2_arithmetic :
    (83880895988858868494442540089180897636298467585444092347657730 : ℝ) / 10 ^ 64 +
      (549755813888 / 10 ^ 12) * (1483444053877 / 10 ^ 12) *
        (4 * 1.2338 ^ 2) / 10000 ≤ 0.0089 := by
  norm_num

theorem relaxed_t2_arithmetic :
    (1.4423050431 : ℝ) / 4 + 9.2185538 / 10000 + (5 / 4) * 0.0089 ≤ 0.37273 := by
  norm_num

#print axioms relaxed_profile_arithmetic
#print axioms relaxed_g2_arithmetic
#print axioms relaxed_t2_arithmetic

end TernaryGoldbach.QrhResearch

