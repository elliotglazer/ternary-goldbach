import Mathlib.NumberTheory.LucasPrimality
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Nat.Bitwise
import Lean.Elab.Tactic.Omega

namespace BinaryPilot

theorem lucasNat (p a : Nat) (hp : 1 < p)
    (ha : Nat.powMod a (p - 1) p = 1)
    (hd : ∀ q : Nat, q.Prime → q ∣ p - 1 → Nat.powMod a ((p - 1) / q) p ≠ 1) :
    p.Prime := by
  have heq (e : Nat) : (a : ZMod p) ^ e = 1 ↔ Nat.powMod a e p = 1 := by
    rw [← Nat.cast_pow, ← Nat.cast_one, ZMod.natCast_eq_natCast_iff',
      ← Nat.powMod_def, Nat.mod_eq_of_lt hp]
  exact lucas_primality p (a : ZMod p) ((heq _).mpr ha)
    (fun q hq hqd hz => hd q hq hqd ((heq _).mp hz))

/-- A real source chunk and anchor, with their primality and exact index connection. -/
structure SliceCertificate (origin width : Nat) where
  sourceBase : Nat
  sourceMask : Nat
  shift : Nat
  anchor : Nat
  shift_bound : shift + width ≤ 128
  source_prime : ∀ j : Nat, j < 128 → sourceMask.testBit j = true →
    Nat.Prime (sourceBase + 2*j)
  anchor_prime : Nat.Prime anchor
  connection : anchor + sourceBase + 2*shift = origin

def sliceMask {origin width : Nat} (s : SliceCertificate origin width) : Nat :=
  (s.sourceMask >>> s.shift) &&& (2^width-1)

theorem slice_sound {origin width : Nat} (s : SliceCertificate origin width)
    (t : Nat) (ht : t < width) (hb : (sliceMask s).testBit t = true) :
    ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ origin + 2*t = p+q := by
  have hs : s.sourceMask.testBit (s.shift+t) = true := by
    simpa only [sliceMask, Nat.testBit_land, Nat.testBit_shiftRight,
      Nat.testBit_two_pow_sub_one, ht, decide_true, Bool.and_true] using hb
  refine ⟨s.anchor, s.sourceBase+2*(s.shift+t), s.anchor_prime,
    s.source_prime _ (by have := s.shift_bound; omega) hs, ?_⟩
  have hc := s.connection
  omega

def unionMasks (xs : List Nat) : Nat := xs.foldr (fun x y => x ||| y) 0

theorem union_bit (xs : List Nat) (t : Nat) (h : (unionMasks xs).testBit t = true) :
    ∃ x ∈ xs, x.testBit t = true := by
  induction xs with
  | nil => simp only [unionMasks, List.foldr_nil, Nat.zero_testBit, Bool.false_eq_true] at h
  | cons x xs ih =>
    have hb : x.testBit t = true ∨ (unionMasks xs).testBit t = true := by
      simpa only [unionMasks, List.foldr_cons, Nat.testBit_lor, Bool.or_eq_true] using h
    rcases hb with hx | hxs
    · exact ⟨x, List.mem_cons_self, hx⟩
    · obtain ⟨y, hy, hb⟩ := ih hxs
      exact ⟨y, List.mem_cons_of_mem x hy, hb⟩

theorem certified_tile {origin width : Nat} (slices : List (SliceCertificate origin width))
    (coverage : unionMasks (slices.map sliceMask) = 2^width-1) :
    ∀ t : Nat, t < width →
      ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ origin+2*t=p+q := by
  intro t ht
  have hb : (unionMasks (slices.map sliceMask)).testBit t = true := by
    rw [coverage, Nat.testBit_two_pow_sub_one]
    exact decide_eq_true ht
  obtain ⟨mask, hm, hb⟩ := union_bit _ _ hb
  obtain ⟨s, _, hs⟩ := List.mem_map.mp hm
  subst mask
  exact slice_sound s t ht hb

end BinaryPilot
