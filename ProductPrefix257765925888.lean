module

public import ProductPrefix180456514560
public import ProductExtension180456514560To257765925888

@[expose] public section
namespace SmallGoldbach.ProductPrefix257765925888
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 257765925888 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 ht
  by_cases small : n ≤ 180456514560
  · exact ProductPrefix180456514560.binaryGoldbachUpTo n he h4 small
  · obtain ⟨k,hk⟩ := he
    exact ProductExtension180456514560To257765925888.covered n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.ProductPrefix257765925888
