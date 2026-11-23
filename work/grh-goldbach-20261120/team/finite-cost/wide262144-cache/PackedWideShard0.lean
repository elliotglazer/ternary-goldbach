import PendingPrimes
import Shared
import Anchors
namespace PackedWide
set_option maxRecDepth 65536
set_option exponentiation.threshold 4194304
theorem Block0.verified : ∀ n : Nat, 3999999998951426 ≤ n → n < 3999999999475714 → n%2=0 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  apply Block0.of_prime_inputs UpperShared.source_sound
  have hm : ∀ t ∈ Block0.offsets, BatchPrime.contains (3999999998951426-(4097+2*(1663-t))) UpperAnchors.cert = true := by
    decide +kernel
  exact fun t ht => BatchPrime.contains_prime UpperAnchors.valid (hm t ht)
end PackedWide
#print axioms PackedWide.Block0.verified
