module

public import ProductPrefix152539227136
public import ProductExtension152539227136To180456514560

@[expose] public section
namespace SmallGoldbach.ProductPrefix180456514560
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 180456514560 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 ht
  by_cases small : n ≤ 152539227136
  · exact ProductPrefix152539227136.binaryGoldbachUpTo n he h4 small
  · obtain ⟨k,hk⟩ := he
    exact ProductExtension152539227136To180456514560.covered n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.ProductPrefix180456514560
