module

public import CompletedGoldbach

public section

namespace PalomarTernaryGoldbach

theorem ternary_goldbach :
    ∀ n : ℕ, Odd n → 5 < n →
      ∃ p q r : ℕ, Nat.Prime p ∧ Nat.Prime q ∧ Nat.Prime r ∧ p + q + r = n :=
  CompletedGoldbach.ternary_goldbach

#print axioms ternary_goldbach
end PalomarTernaryGoldbach
