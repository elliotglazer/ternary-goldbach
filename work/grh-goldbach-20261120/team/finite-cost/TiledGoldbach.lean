import FastGoldbach
import PrimeBitmap

namespace PrimeCoverage

/-- A shard may take a bounded window of any previously certified source bitmap. -/
theorem PrimeBitmap.window {first bits : Nat} (h : PrimeBitmap first bits) (skip len : Nat) :
    PrimeBitmap (first+2*skip) ((bits >>> skip) % 2^len) := by
  intro i hi
  rw [Nat.testBit_mod_two_pow, Bool.and_eq_true, Nat.testBit_shiftRight] at hi
  have hp := h (skip+i) hi.2
  exact (show first+2*(skip+i) = first+2*skip+2*i by omega) ▸ hp

end PrimeCoverage

namespace Goldbach.Packed
open PrimeCoverage

/-- Use one certified anchor list for an entire block of equal-sized tiles.
The local source table starts at the corresponding translated source slot. -/
theorem binary_block_of_packed_tiles
    (b depth S width count origin first : Nat) (offsets : List Nat)
    (bits expanded : Nat → Nat)
    (hw : 0 < width) (hwidth : width ≤ 2^depth)
    (he : origin % 2 = 0) (hoff : ∀ t ∈ offsets, t ≤ S)
    (hlen : offsets.length ≤ 2^b)
    (ha : ∀ t ∈ offsets, (origin-(first+2*(S-t))).Prime ∧ first+2*(S-t) ≤ origin)
    (hbits : ∀ i < count, bits i < 2^(2^depth))
    (hsrc : ∀ i < count, PrimeBitmap (first+2*(i*width)) (bits i))
    (hexp : ∀ i < count, expand (b+1) depth (bits i) = expanded i)
    (hc : ∀ i < count,
      (expanded i * anchorPolynomial (b+1) offsets + windowValue (b+1) S width (2^b-1)) &&&
        windowValue (b+1) S width (2^b) = windowValue (b+1) S width (2^b)) :
    ∀ n : Nat, origin ≤ n → n < origin+2*(count*width) → n%2 = 0 →
      ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n hl hr hn
  let j := (n-origin)/2
  let i := j / width
  have hj : j < count*width := by dsimp [j]; omega
  have hi : i < count := (Nat.div_lt_iff_lt_mul hw).2 hj
  have hleft : i*width ≤ j := Nat.div_mul_le_self j width
  have hright : j < i*width+width := Nat.lt_div_mul_add hw
  have htarget : origin+2*j = n := by dsimp [j]; omega
  have hlocal : ∀ t ∈ offsets,
      (origin+2*(i*width)-(first+2*(i*width)+2*(S-t))).Prime ∧
        first+2*(i*width)+2*(S-t) ≤ origin+2*(i*width) := by
    intro t ht
    obtain ⟨hp, hle⟩ := ha t ht
    have eq : origin+2*(i*width)-(first+2*(i*width)+2*(S-t)) = origin-(first+2*(S-t)) := by omega
    exact ⟨eq ▸ hp, by omega⟩
  exact binary_interval_of_expansion (bits i) (expanded i) b depth S width
      (origin+2*(i*width)) (first+2*(i*width)) offsets
      (hbits i hi) (hsrc i hi) (hexp i hi) hoff hlocal hlen hwidth
      (by omega) (hc i hi) n (by omega) (by omega) hn

end Goldbach.Packed

#print axioms Goldbach.Packed.binary_block_of_packed_tiles
