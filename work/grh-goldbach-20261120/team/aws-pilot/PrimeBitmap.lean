import PrimeSupport
import Mathlib.Data.Nat.Bitwise
import Lean.Elab.Tactic.Omega

namespace PrimeCoverage

/-- Every set bit denotes an odd-slot source value that is prime. -/
def PrimeBitmap (first bits : Nat) : Prop :=
  ∀ i, bits.testBit i = true → Nat.Prime (first + 2 * i)

theorem PrimeBitmap.zero (first : Nat) : PrimeBitmap first 0 := by
  intro i hi
  simp only [Nat.zero_testBit] at hi
  contradiction

theorem PrimeBitmap.singleton (first i : Nat) (hp : Nat.Prime (first + 2 * i)) :
    PrimeBitmap first (2 ^ i) := by
  intro j hj
  rw [Nat.testBit_two_pow] at hj
  have hij : i = j := of_decide_eq_true hj
  subst j
  exact hp

theorem PrimeBitmap.union {first a b : Nat}
    (ha : PrimeBitmap first a) (hb : PrimeBitmap first b) :
    PrimeBitmap first (a ||| b) := by
  intro j hj
  rw [Nat.testBit_or, Bool.or_eq_true] at hj
  rcases hj with h | h
  · exact ha j h
  · exact hb j h

/-- Shift a common source bitmap for each proposed anchor. -/
def shiftedUnion (bits : Nat) : List Nat → Nat
  | [] => 0
  | s :: ss => (bits >>> s) ||| shiftedUnion bits ss

theorem shiftedUnion_witness (bits : Nat) (ss : List Nat) (j : Nat)
    (h : (shiftedUnion bits ss).testBit j = true) :
    ∃ s ∈ ss, bits.testBit (s + j) = true := by
  induction ss with
  | nil =>
      simp only [shiftedUnion, Nat.zero_testBit] at h
      contradiction
  | cons s ss ih =>
      rw [shiftedUnion, Nat.testBit_or, Bool.or_eq_true] at h
      rcases h with h | h
      · exact ⟨s, List.mem_cons_self, by simpa only [Nat.testBit_shiftRight] using h⟩
      · obtain ⟨t, ht, hb⟩ := ih h
        exact ⟨t, List.mem_cons_of_mem s ht, hb⟩

/-- Binary Goldbach, with both summands proved prime. -/
def BinaryGoldbach (n : Nat) : Prop :=
  ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n

/-- The complete semantic interface for a finite shifted-prime bitmap cover. -/
theorem binaryGoldbach_of_bitmap
    (first bits target width : Nat) (ss : List Nat)
    (hsource : PrimeBitmap first bits)
    (hanchors : ∀ s ∈ ss, (target - (first + 2 * s)).Prime ∧ first + 2 * s ≤ target)
    (hcover : (shiftedUnion bits ss &&& (2 ^ width - 1)) = 2 ^ width - 1) :
    ∀ j < width, BinaryGoldbach (target + 2 * j) := by
  intro j hj
  have h := congrArg (fun n : Nat => n.testBit j) hcover
  rw [Nat.testBit_and, Nat.testBit_two_pow_sub_one] at h
  simp only [hj, decide_true, Bool.and_true] at h
  obtain ⟨s, hs, hb⟩ := shiftedUnion_witness bits ss j h
  obtain ⟨hp, hle⟩ := hanchors s hs
  exact ⟨first + 2 * (s + j), target - (first + 2 * s), hsource _ hb, hp, by omega⟩

theorem binaryGoldbach_interval
    (target width : Nat) (heven : target % 2 = 0)
    (h : ∀ j < width, BinaryGoldbach (target + 2 * j)) :
    ∀ n, target ≤ n → n < target + 2 * width → n % 2 = 0 → BinaryGoldbach n := by
  intro n hlo hhi hn
  have hj : (n - target) / 2 < width := by omega
  have heq : target + 2 * ((n - target) / 2) = n := by omega
  exact heq ▸ h _ hj

end PrimeCoverage
