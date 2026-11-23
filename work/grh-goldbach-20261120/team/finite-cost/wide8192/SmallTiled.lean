import TiledGoldbach
import PackedArithmetic0
import Shared
import Anchors

namespace PackedWide.SmallTiled
open Goldbach.Packed PrimeCoverage
set_option maxRecDepth 65536

def bits (i : Nat) := (PackedWide.source >>> (i*4096)) % 2^8192
def value (i : Nat) := (PackedWide.expansion >>> (7*(i*4096))) % 2^(7*8192)

theorem sourcePrime (i : Nat) :
    PrimeBitmap (4097+2*(i*4096)) (bits i) :=
  UpperShared.source_sound.window (i*4096) 8192

theorem expanded (i : Nat) (hi : i < 2) : expand 7 13 (bits i) = value i := by
  have h : i = 0 ∨ i = 1 := by omega
  rcases h with rfl | rfl <;> decide +kernel

theorem checks (i : Nat) (hi : i < 2) :
    (value i * anchorPolynomial 7 Block0.offsets + windowValue 7 857 4096 (2^6-1)) &&&
        windowValue 7 857 4096 (2^6) = windowValue 7 857 4096 (2^6) := by
  have h : i = 0 ∨ i = 1 := by omega
  rcases h with rfl | rfl <;> decide +kernel

theorem anchors : ∀ t ∈ Block0.offsets,
    (3999999999967234-(4097+2*(857-t))).Prime ∧ 4097+2*(857-t) ≤ 3999999999967234 := by
  have ha : ∀ t ∈ Block0.offsets,
      BatchPrime.contains (3999999999967234-(4097+2*(857-t))) UpperAnchors.cert = true ∧
      4097+2*(857-t) ≤ 3999999999967234 := by decide +kernel
  intro t ht
  obtain ⟨hm, hl⟩ := ha t ht
  exact ⟨BatchPrime.contains_prime UpperAnchors.valid hm, hl⟩

theorem verified : ∀ n : Nat, 3999999999967234 ≤ n → n < 3999999999983618 →
    n%2 = 0 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n :=
  binary_block_of_packed_tiles 6 13 857 4096 2 3999999999967234 4097 Block0.offsets bits value
    (by decide) (by decide) (by decide) (by decide) (by decide) anchors
    (fun i _ => Nat.mod_lt _ (Nat.two_pow_pos _)) (fun i _ => sourcePrime i) expanded checks

end PackedWide.SmallTiled
#print axioms PackedWide.SmallTiled.verified
