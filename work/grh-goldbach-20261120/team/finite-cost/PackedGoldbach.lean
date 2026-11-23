import PackedDigits
import Mathlib.Data.Nat.Prime.Basic

/-! Connect the packed convolution certificate to consecutive even inputs.
The input offsets are the exponents of the anchor polynomial: if the producer
uses a right-shift s and maximum shift S, its exponent is S-s. -/

namespace Goldbach.Packed

def inWindow (start width index : Nat) : Bool :=
  decide (start ≤ index ∧ index < start + width)

/-- A complete tile from a certified source, certified anchors and one packed
equality. The returned interval starts at origin and ends just below origin+2w. -/
theorem binary_interval_of_packed_product (b len S width origin first : Nat)
    (offsets : List Nat) (source : Nat → Nat)
    (hzero : ∀ i, len ≤ i → source i = 0) (hbit : ∀ i, source i ≤ 1)
    (hsource : ∀ i, 0 < source i → (first + 2*i).Prime)
    (hoff : ∀ t ∈ offsets, t ≤ S)
    (hanchor : ∀ t ∈ offsets,
      (origin - (first + 2*(S-t))).Prime ∧ first + 2*(S-t) ≤ origin)
    (hcount : offsets.length ≤ 2^b) (hwidth : width ≤ len) (heven : origin % 2 = 0)
    (check : (pack (b+1) len source * anchorPolynomial (b+1) offsets +
        pack (b+1) (len+S) (fun i => if inWindow S width i then 2^b-1 else 0)) &&&
        pack (b+1) (len+S) (fun i => if inWindow S width i then 2^b else 0) =
        pack (b+1) (len+S) (fun i => if inWindow S width i then 2^b else 0)) :
    ∀ n : Nat, origin ≤ n → n < origin + 2*width → n % 2 = 0 →
      ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n := by
  intro n hlo hhi hn
  let j := (n-origin)/2
  have hj : j < width := by dsimp [j]; omega
  have hsum : origin + 2*j = n := by dsimp [j]; omega
  have htarg : inWindow S width (S+j) = true := by
    unfold inWindow
    exact decide_eq_true (by omega)
  obtain ⟨t, ht, hle, hpos⟩ := witness_of_packed_product b len S offsets source
    (inWindow S width) hzero hbit hoff hcount check (S+j) (by omega) htarg
  have htS := hoff t ht
  obtain ⟨hp, horg⟩ := hanchor t ht
  exact ⟨first + 2*(S+j-t), origin-(first+2*(S-t)), hsource _ hpos, hp, by omega⟩

end Goldbach.Packed
