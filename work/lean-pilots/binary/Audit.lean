import CompleteBinaryPilot

#print axioms BinaryPilot.binary_interval
#check BinaryPilot.binary_interval
example : ∀ n : Nat, 3999999997356523524 ≤ n → n ≤ 3999999997356523650 →
    Even n → ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ n = p+q :=
  BinaryPilot.binary_interval
