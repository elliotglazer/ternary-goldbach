module

public import Mathlib.Data.Nat.Prime.Defs
public import Mathlib.Algebra.Ring.Parity

public section

namespace SmallGoldbach.Power10

theorem binaryGoldbachUpTo :
    ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10 ^ 10 →
      ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ p + q = n := by
  sorry

end SmallGoldbach.Power10
