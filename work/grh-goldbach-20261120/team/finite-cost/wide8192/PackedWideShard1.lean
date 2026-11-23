import PackedArithmetic1
import PackedWideSource
import FastGoldbach
import Anchors
import Shared
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536

namespace Block1
theorem verified : ∀ n : Nat, 3999999999983618 ≤ n → n < 4000000000000002 → n%2=0 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  apply binary_interval_of_expansion source expansion 6 14 781 8192 3999999999983618 4097 offsets
  · exact bound
  · exact UpperShared.source_sound
  · exact certified
  · decide
  · have ha : ∀ t ∈ offsets, BatchPrime.contains (3999999999983618-(4097+2*(781-t))) UpperAnchors.cert = true ∧
        4097+2*(781-t) ≤ 3999999999983618 := by decide +kernel
    intro t ht
    obtain ⟨hm, hl⟩ := ha t ht
    exact ⟨BatchPrime.contains_prime UpperAnchors.valid hm, hl⟩
  · decide
  · decide
  · decide
  · exact check
end Block1
end PackedWide
#print axioms PackedWide.Block1.verified
