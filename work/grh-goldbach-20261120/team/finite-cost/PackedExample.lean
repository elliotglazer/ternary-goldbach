import PackedGoldbach

namespace Goldbach.Packed.Example

def src (j : Nat) : Nat := if j ∈ [0,1,2,4,5,7,8] then 1 else 0

theorem binary_interval : ∀ n : Nat, 16 ≤ n → n < 32 → n % 2 = 0 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n := by
  apply binary_interval_of_packed_product 1 9 1 8 16 3 [0,1] src
  · intro i hi
    simp only [src, List.mem_cons, List.not_mem_nil, or_false]
    split <;> omega
  · intro i
    unfold src
    split <;> decide
  · intro i hi
    simp only [src, List.mem_cons, List.not_mem_nil, or_false] at hi
    split at hi
    next h =>
      rcases h with h|h|h|h|h|h|h <;> subst i <;> decide
    next => omega
  · decide
  · decide
  · decide
  · decide
  · decide
  · decide +kernel

end Goldbach.Packed.Example

#print axioms Goldbach.Packed.witness_of_packed_product
#print axioms Goldbach.Packed.binary_interval_of_packed_product
#print axioms Goldbach.Packed.Example.binary_interval
