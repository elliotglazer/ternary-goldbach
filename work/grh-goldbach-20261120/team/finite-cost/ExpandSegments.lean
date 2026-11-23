import Expand

namespace Goldbach.Packed

theorem expand_zero (k d : Nat) : expand k d 0 = 0 := by
  induction d with
  | zero => rfl
  | succ d ih => simp [expand, ih]

/-- Check each child separately so the kernel can release the reduction for
one subtable before checking the next. -/
theorem expand_join {k d raw low high packed lowPacked highPacked : Nat}
    (hl : raw % 2^(2^d) = low) (hh : raw / 2^(2^d) = high)
    (cl : expand k d low = lowPacked) (ch : expand k d high = highPacked)
    (hj : lowPacked + (2^k)^(2^d) * highPacked = packed) :
    expand k (d+1) raw = packed := by
  change expand k d (raw % 2^(2^d)) + (2^k)^(2^d) * expand k d (raw / 2^(2^d)) = packed
  rw [hl, hh, cl, ch, hj]

end Goldbach.Packed
