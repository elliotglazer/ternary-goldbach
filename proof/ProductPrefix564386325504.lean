import ProductPrefix257765925888
import ProductExtension257765925888To564386325504
namespace SmallGoldbach.ProductPrefix564386325504
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 564386325504 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 ht
  by_cases small : n ≤ 257765925888
  · exact ProductPrefix257765925888.binaryGoldbachUpTo n he h4 small
  · obtain ⟨k,hk⟩ := he
    exact ProductExtension257765925888To564386325504.covered n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.ProductPrefix564386325504
