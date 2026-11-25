module

public import ProductPrefix138580583424
public import ProductExtension138580583424To152539227136

@[expose] public section
namespace SmallGoldbach.ProductPrefix152539227136
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 152539227136 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 ht
  by_cases small : n ≤ 138580583424
  · exact ProductPrefix138580583424.binaryGoldbachUpTo n he h4 small
  · obtain ⟨k,hk⟩ := he
    exact ProductExtension138580583424To152539227136.covered n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.ProductPrefix152539227136
