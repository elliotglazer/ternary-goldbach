import PackedArithmetic0
import PackedArithmetic1
import PackedWideSource
import FastGoldbach
import PrimeBitmap
namespace PackedWide
open Goldbach.Packed PrimeCoverage
set_option maxRecDepth 65536
set_option exponentiation.threshold 4194304

theorem Block0.of_prime_inputs (hsrc : PrimeBitmap 4097 source)
    (ha : ∀ t ∈ Block0.offsets, (3999999998951426-(4097+2*(1663-t))).Prime) :
    ∀ n : Nat, 3999999998951426 ≤ n → n < 3999999999475714 → n%2=0 →
      ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  have hl : ∀ t ∈ Block0.offsets, 4097+2*(1663-t) ≤ 3999999998951426 := by decide +kernel
  have hcheck : (expansion * anchorPolynomial 8 Block0.offsets +
      windowValue 8 1663 262144 (2^7-1)) &&& windowValue 8 1663 262144 (2^7) =
        windowValue 8 1663 262144 (2^7) := by
    decide +kernel
  exact binary_interval_of_expansion source expansion 7 19 1663 262144 3999999998951426 4097 Block0.offsets
    bound hsrc certified (by decide) (fun t ht => ⟨ha t ht, hl t ht⟩)
    (by decide) (by decide) (by decide) hcheck
#print axioms Block0.of_prime_inputs

theorem Block1.of_prime_inputs (hsrc : PrimeBitmap 4097 source)
    (ha : ∀ t ∈ Block1.offsets, (3999999999475714-(4097+2*(1707-t))).Prime) :
    ∀ n : Nat, 3999999999475714 ≤ n → n < 4000000000000002 → n%2=0 →
      ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  have hl : ∀ t ∈ Block1.offsets, 4097+2*(1707-t) ≤ 3999999999475714 := by decide +kernel
  have hcheck : (expansion * anchorPolynomial 8 Block1.offsets +
      windowValue 8 1707 262144 (2^7-1)) &&& windowValue 8 1707 262144 (2^7) =
        windowValue 8 1707 262144 (2^7) := by
    decide +kernel
  exact binary_interval_of_expansion source expansion 7 19 1707 262144 3999999999475714 4097 Block1.offsets
    bound hsrc certified (by decide) (fun t ht => ⟨ha t ht, hl t ht⟩)
    (by decide) (by decide) (by decide) hcheck
#print axioms Block1.of_prime_inputs
end PackedWide
