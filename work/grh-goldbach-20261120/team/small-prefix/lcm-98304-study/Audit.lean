import Power8
example : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^8 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := SmallGoldbach.Power8.binaryGoldbachUpTo
#print axioms SmallGoldbach.Power8.binaryGoldbachUpTo
