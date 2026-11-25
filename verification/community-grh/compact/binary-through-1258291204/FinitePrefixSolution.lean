module
public import Power10Block00
public section
namespace FinitePrefixAudit
theorem binary_goldbach_through_1258291204 : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 1258291204 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n :=
  SmallGoldbach.prefix_of_covered SmallGoldbach.Power10.block0 (by decide)
end FinitePrefixAudit
#print axioms SmallGoldbach.Power10.block0
#print axioms FinitePrefixAudit.binary_goldbach_through_1258291204
