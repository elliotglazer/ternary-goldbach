import PackedDigits

/-! Compose a table of cached packed bit chunks using checked arithmetic. -/
namespace Goldbach.Packed

theorem pack_congr (k n : Nat) {f g : Nat → Nat} (h : ∀ j < n, f j = g j) :
    pack k n f = pack k n g := by
  induction n generalizing f g with
  | zero => rfl
  | succ n ih =>
    simp only [pack]
    rw [ih (f := fun j => f (j+1)) (g := fun j => g (j+1))
      (fun j hj => h _ (by omega)), h 0 (by omega)]

/-- The low block occupies the low m digits, the high block the following n. -/
theorem pack_append (k m n : Nat) (f : Nat → Nat) :
    pack k (m+n) f = pack k m f + (2^k)^m * pack k n (fun j => f (m+j)) := by
  induction m generalizing f with
  | zero => simp [pack]
  | succ m ih =>
    rw [show m + 1 + n = (m+n)+1 by omega]
    simp only [pack, ih (fun j => f (j+1)), Nat.mul_add, Nat.pow_succ, Nat.add_succ]
    have he : (fun j => f (m+j+1)) = (fun j => f (m+1+j)) :=
      funext fun j => congrArg f (by omega)
    rw [he]
    simp only [Nat.mul_assoc, Nat.mul_comm, Nat.add_assoc, Nat.add_left_comm, Nat.add_comm,
      Nat.succ_eq_add_one, Nat.add_zero]

def bitValue (bits i : Nat) : Nat := (bits.testBit i).toNat

/-- Join source chunks even if their boundary is not a multiple of the CPU
word width. Together with cached small chunk expansions this avoids recursing
over a large tile at each use. -/
theorem pack_bits_append (k m n low high : Nat) (h : low < 2^m) :
    pack k (m+n) (bitValue (2^m * high + low)) =
      pack k m (bitValue low) + (2^k)^m * pack k n (bitValue high) := by
  rw [pack_append]
  have lo : pack k m (bitValue (2^m * high + low)) = pack k m (bitValue low) := by
    apply pack_congr
    intro i hi
    simp [bitValue, Nat.testBit_two_pow_mul_add high h, hi]
  have hi : (fun j => bitValue (2^m * high + low) (m+j)) = bitValue high := by
    funext j
    simp [bitValue, Nat.testBit_two_pow_mul_add high h, show ¬ m+j < m by omega]
  rw [lo, hi]

end Goldbach.Packed
