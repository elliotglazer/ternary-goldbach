module

public import ProductPrefix126232552448
public import ProductExtension126232552448To138580583424

@[expose] public section
namespace SmallGoldbach.ProductPrefix138580583424
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 138580583424 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 ht
  by_cases small : n ≤ 126232552448
  · exact ProductPrefix126232552448.binaryGoldbachUpTo n he h4 small
  · obtain ⟨k,hk⟩ := he
    exact ProductExtension126232552448To138580583424.covered n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.ProductPrefix138580583424
