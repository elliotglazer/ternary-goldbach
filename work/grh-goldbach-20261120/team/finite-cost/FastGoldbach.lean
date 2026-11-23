import PackedGoldbach
import PackedWindow
import Expand

namespace Goldbach.Packed

/-- The mask and padding share this geometric sum formula. -/
def windowValue (k S width c : Nat) :=
  (2^k)^S * (((2^k)^width*c-c)/(2^k-1))

/-- The producer may share one proved source expansion among many ordered
anchor sets. Binary prime semantics, expansion, anchors, and the numerical
cover check stay separately reusable. -/
theorem binary_interval_of_expansion (bits expansion b depth S width origin first : Nat)
    (offsets : List Nat) (hb : bits < 2^(2^depth))
    (hsrc : ∀ i, bits.testBit i = true → (first + 2*i).Prime)
    (hexp : expand (b+1) depth bits = expansion)
    (hoff : ∀ t ∈ offsets, t ≤ S)
    (hanchor : ∀ t ∈ offsets, (origin-(first+2*(S-t))).Prime ∧ first+2*(S-t) ≤ origin)
    (hcount : offsets.length ≤ 2^b) (hwidth : width ≤ 2^depth) (heven : origin % 2 = 0)
    (hc : (expansion * anchorPolynomial (b+1) offsets + windowValue (b+1) S width (2^b-1)) &&&
      windowValue (b+1) S width (2^b) = windowValue (b+1) S width (2^b)) :
    ∀ n : Nat, origin ≤ n → n < origin+2*width → n%2 = 0 →
      ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n := by
  apply binary_interval_of_packed_product b (2^depth) S width origin first offsets (bitValue bits)
  · intro i hi
    have h := Nat.pow_le_pow_right (by decide : 0<2) hi
    simp [bitValue, Nat.testBit_lt_two_pow (Nat.lt_of_lt_of_le hb h)]
  · intro i
    unfold bitValue
    cases bits.testBit i <;> decide
  · intro i hi
    apply hsrc
    unfold bitValue at hi
    cases hh : bits.testBit i <;> simp [hh] at *
  · exact hoff
  · exact hanchor
  · exact hcount
  · exact hwidth
  · exact heven
  · rw [pack_bits_eq_expand, hexp]
    unfold inWindow
    simp only [pack_window _ _ _ _ _ (by omega : 0<b+1) hwidth]
    exact hc

end Goldbach.Packed
