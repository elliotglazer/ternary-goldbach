module

public import GoldbachBand06Prefix
public import ProductSuffix126232552448

@[expose] public section
namespace SmallGoldbach.ProductPrefix126232552448

theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 126232552448 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 100328530944
  · exact GoldbachBand06.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k,hk⟩ := he
    exact ProductSuffix126232552448.covered n (by omega) (by omega) (by omega)

#print axioms binaryGoldbachUpTo
end SmallGoldbach.ProductPrefix126232552448
