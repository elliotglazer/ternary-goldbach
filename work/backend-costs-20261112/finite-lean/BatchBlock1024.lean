import BatchValidPart07
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteBatch1024
open BatchPrime BatchData1024

theorem valid : treeValid certificates certificates = true := valid_126

theorem roots_checked : rootsKnown certificates roots = true := by decide +kernel

theorem roots_prime : ∀ p ∈ roots, p.Prime := rootsKnown_sound valid roots_checked

theorem covered : checkedCover target certificates witnesses = true := by decide +kernel

theorem width : witnesses.length = 1024 := by decide +kernel

theorem binary_index : ∀ j < 1024, PrimeCoverage.BinaryGoldbach (target + 2 * j) := by
  intro j hj
  exact checkedCover_sound valid witnesses target covered j (width.symm ▸ hj)

theorem binary_interval : ∀ n : Nat,
  3999999997356537860 ≤ n → n < 3999999997356539908 → n % 2 = 0 →
  ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n :=
  PrimeCoverage.binaryGoldbach_interval target 1024 (by decide) binary_index

theorem complete : (∀ p ∈ roots, p.Prime) ∧ (∀ n : Nat,
  3999999997356537860 ≤ n → n < 3999999997356539908 → n % 2 = 0 →
  ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n) := ⟨roots_prime, binary_interval⟩

end FiniteBatch1024
