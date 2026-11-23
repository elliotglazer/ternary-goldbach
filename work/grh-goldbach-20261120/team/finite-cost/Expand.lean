import PackedChunks

namespace Goldbach.Packed

/-- Expand a 2^d-bit source word using balanced splits. High bits beyond
the requested width are ignored. -/
def expand (k : Nat) : Nat → Nat → Nat
  | 0, bits => bitValue bits 0
  | d+1, bits =>
      let m := 2^d
      let lo := bits % 2^m
      let hi := bits / 2^m
      expand k d lo + (2^k)^m * expand k d hi

theorem pack_bits_eq_expand (k d bits : Nat) :
    pack k (2^d) (bitValue bits) = expand k d bits := by
  induction d generalizing bits with
  | zero => simp [pack, expand]
  | succ d ih =>
    let m := 2^d
    have hmod := Nat.mod_lt bits (Nat.two_pow_pos m)
    have h := pack_bits_append k m m (bits%2^m) (bits/2^m) hmod
    rw [Nat.div_add_mod] at h
    rw [show 2^(d+1) = m+m by simp [m, Nat.pow_succ, Nat.mul_two]]
    change _ = expand k d (bits%2^m) + (2^k)^m * expand k d (bits/2^m)
    exact h.trans (by rw [← ih, ← ih])

end Goldbach.Packed
