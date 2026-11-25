module

public import PrimeBitmap
public import Mathlib.Data.Nat.Prime.Factorial

@[expose] public section

namespace WideGoldbach
open PrimeCoverage

/-- Bit indices in one small-prime table chunk. -/
def marks : List Nat → Nat
  | [] => 0
  | i :: tail => (1 <<< i) ||| marks tail

def entries (first : Nat) (offsets : List Nat) : List Nat :=
  offsets.map fun i => first + 2 * i

private theorem member_dvd_prod {p : Nat} {xs : List Nat} (hp : p ∈ xs) : p ∣ xs.prod := by
  induction xs with
  | nil => simp at hp
  | cons a xs ih =>
    rw [List.mem_cons] at hp
    rw [List.prod_cons]
    rcases hp with rfl | h
    · exact dvd_mul_right _ _
    · exact dvd_mul_of_dvd_right (ih h) _

private theorem marks_sound (first : Nat) (is : List Nat)
    (hp : ∀ i ∈ is, Nat.Prime (first + 2 * i)) : PrimeBitmap first (marks is) := by
  induction is with
  | nil => exact PrimeBitmap.zero first
  | cons i tail ih =>
    apply PrimeBitmap.union
    · simpa only [Nat.shiftLeft_eq, Nat.one_mul] using
        PrimeBitmap.singleton first i (hp i List.mem_cons_self)
    · exact ih fun j hj => hp j (List.mem_cons_of_mem i hj)

/-- One gcd proves every proposed entry prime once its size is checked. -/
theorem table_chunk (first d : Nat) (is : List Nat)
    (hb : (entries first is).all (fun p => decide (1 < p ∧ p < (d+1)^2)) = true)
    (hc : Nat.Coprime (entries first is).prod d.factorial) :
    PrimeBitmap first (marks is) := by
  apply marks_sound
  intro i hi
  let p := first + 2 * i
  have hmem : p ∈ entries first is := List.mem_map.mpr ⟨i, hi, rfl⟩
  have hs := of_decide_eq_true ((List.all_eq_true.mp hb) _ hmem)
  have hcp := Nat.Coprime.of_dvd_left (member_dvd_prod hmem) hc
  have hm : d < p.minFac := (Nat.coprime_factorial_iff (by omega : p ≠ 1)).mp hcp
  by_contra hn
  have hsq := Nat.minFac_sq_le_self (by omega : 0 < p) hn
  have hlow : (d + 1)^2 ≤ p.minFac ^ 2 := Nat.pow_le_pow_left hm 2
  omega

theorem shift_chunk (first offset bits : Nat)
    (h : PrimeBitmap (first + 2*offset) bits) :
    PrimeBitmap first (bits <<< offset) := by
  intro j hj
  rw [Nat.testBit_shiftLeft, Bool.and_eq_true, decide_eq_true_eq] at hj
  have hp := h (j-offset) hj.2
  have heq : first + 2 * offset + 2 * (j - offset) = first + 2*j := by omega
  exact heq ▸ hp

end WideGoldbach
