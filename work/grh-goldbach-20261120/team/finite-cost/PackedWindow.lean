import PackedChunks

namespace Goldbach.Packed

theorem pack_const_mul (k width c : Nat) :
    (2^k-1) * pack k width (fun _ => c) + c = (2^k)^width * c := by
  have hpos := Nat.two_pow_pos k
  have hc : (2^k-1)*c+c = 2^k*c := by
    calc
      _ = ((2^k-1)+1)*c := (Nat.succ_mul (2^k-1) c).symm
      _ = 2^k*c := congrArg (fun a => a*c) (show (2^k-1)+1 = 2^k by omega)
  induction width with
  | zero => simp [pack]
  | succ w ih =>
    simp only [pack, Nat.mul_add, Nat.pow_succ]
    rw [Nat.add_assoc, hc, Nat.mul_left_comm (2^k-1) (2^k), ← Nat.mul_add, ih]
    ac_rfl

/-- Build each mask from three short integer inputs and one exact division.
The argument proves that this value encodes the selected positions. -/
theorem pack_window (k len S width c : Nat) (hk : k > 0) (hw : width ≤ len) :
    pack k (len+S) (fun j => if decide (S ≤ j ∧ j < S+width) then c else 0) =
      (2^k)^S * (((2^k)^width*c-c)/(2^k-1)) := by
  have eqf : (fun j => if decide (S ≤ j ∧ j < S+width) then c else 0) =
      shifted S (fun j => if j < width then c else 0) := by
    funext j
    simp only [decide_eq_true_eq, shifted]
    split <;> split <;> simp_all <;> omega
  rw [eqf, pack_shifted]
  have hlen : pack k len (fun j => if j < width then c else 0) =
      pack k width (fun _ => c) := by
    rw [show len = width + (len-width) by omega, pack_extend_zero]
    · apply pack_congr
      intro j hj
      simp [hj]
    · intro j hj
      simp [Nat.not_lt.mpr hj]
  rw [hlen]
  congr 1
  have h := pack_const_mul k width c
  have hnum : (2^k)^width*c-c = (2^k-1) * pack k width (fun _ => c) := by omega
  rw [hnum, Nat.mul_div_cancel_left]
  have hgt : 1 < 2^k := Nat.one_lt_two_pow (by omega)
  omega

end Goldbach.Packed
