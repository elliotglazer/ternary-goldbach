import UpperBinaryPilot

example : ∀ n : ℕ, 9999999999997954 ≤ n → n ≤ 10000000000000000 →
    n % 2 = 0 → ∃ p q, Nat.Prime p ∧ Nat.Prime q ∧ p + q = n := by
  intro n h₁ h₂ heven
  exact UpperBinaryPilot.binary_interval n h₁ (by omega) heven

#print UpperBinaryPilot.binary_interval
#print axioms UpperBinaryPilot.binary_interval
