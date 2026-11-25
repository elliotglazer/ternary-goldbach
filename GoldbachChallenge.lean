module

public import Mathlib.Data.Nat.Prime.Defs
public import Mathlib.Algebra.Ring.Parity

public section

namespace PalomarTernaryGoldbach

/-- Challenge stub for the trusted side of Comparator. -/
theorem ternary_goldbach :
    ∀ n : ℕ, Odd n → 5 < n →
      ∃ p q r : ℕ, Nat.Prime p ∧ Nat.Prime q ∧ Nat.Prime r ∧ p + q + r = n := by
  sorry

end PalomarTernaryGoldbach
