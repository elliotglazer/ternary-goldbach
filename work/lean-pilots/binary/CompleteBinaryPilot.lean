/- Owned component: BinarySupport.lean -/
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

/- Owned component: PilotPrimes.lean -/
namespace BinaryPilot

theorem prime_2 : Nat.Prime 2 := Nat.prime_two

theorem prime_3 : Nat.Prime 3 := by
  apply lucasNat 3 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3 - 1 = 2 by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2] at hd
  subst q
  decide +kernel

theorem prime_5 : Nat.Prime 5 := by
  apply lucasNat 5 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5 - 1 = 2 * (2) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_7 : Nat.Prime 7 := by
  apply lucasNat 7 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7 - 1 = 2 * (3) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_11 : Nat.Prime 11 := by
  apply lucasNat 11 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11 - 1 = 2 * (5) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_13 : Nat.Prime 13 := by
  apply lucasNat 13 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13 - 1 = 2 * (2 * (3)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_17 : Nat.Prime 17 := by
  apply lucasNat 17 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17 - 1 = 2 * (2 * (2 * (2))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_19 : Nat.Prime 19 := by
  apply lucasNat 19 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19 - 1 = 2 * (3 * (3)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_23 : Nat.Prime 23 := by
  apply lucasNat 23 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23 - 1 = 2 * (11) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_29 : Nat.Prime 29 := by
  apply lucasNat 29 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29 - 1 = 2 * (2 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_31 : Nat.Prime 31 := by
  apply lucasNat 31 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31 - 1 = 2 * (3 * (5)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_37 : Nat.Prime 37 := by
  apply lucasNat 37 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37 - 1 = 2 * (2 * (3 * (3))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_41 : Nat.Prime 41 := by
  apply lucasNat 41 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41 - 1 = 2 * (2 * (2 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_43 : Nat.Prime 43 := by
  apply lucasNat 43 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43 - 1 = 2 * (3 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_47 : Nat.Prime 47 := by
  apply lucasNat 47 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 47 - 1 = 2 * (23) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_53 : Nat.Prime 53 := by
  apply lucasNat 53 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53 - 1 = 2 * (2 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_59 : Nat.Prime 59 := by
  apply lucasNat 59 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59 - 1 = 2 * (29) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_61 : Nat.Prime 61 := by
  apply lucasNat 61 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 61 - 1 = 2 * (2 * (3 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_67 : Nat.Prime 67 := by
  apply lucasNat 67 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 67 - 1 = 2 * (3 * (11)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_71 : Nat.Prime 71 := by
  apply lucasNat 71 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 71 - 1 = 2 * (5 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_73 : Nat.Prime 73 := by
  apply lucasNat 73 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73 - 1 = 2 * (2 * (2 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_79 : Nat.Prime 79 := by
  apply lucasNat 79 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 79 - 1 = 2 * (3 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_83 : Nat.Prime 83 := by
  apply lucasNat 83 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 83 - 1 = 2 * (41) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_89 : Nat.Prime 89 := by
  apply lucasNat 89 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 89 - 1 = 2 * (2 * (2 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_97 : Nat.Prime 97 := by
  apply lucasNat 97 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 97 - 1 = 2 * (2 * (2 * (2 * (2 * (3))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_101 : Nat.Prime 101 := by
  apply lucasNat 101 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 101 - 1 = 2 * (2 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_103 : Nat.Prime 103 := by
  apply lucasNat 103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 103 - 1 = 2 * (3 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_107 : Nat.Prime 107 := by
  apply lucasNat 107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 107 - 1 = 2 * (53) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_109 : Nat.Prime 109 := by
  apply lucasNat 109 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 109 - 1 = 2 * (2 * (3 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_113 : Nat.Prime 113 := by
  apply lucasNat 113 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 113 - 1 = 2 * (2 * (2 * (2 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_127 : Nat.Prime 127 := by
  apply lucasNat 127 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 127 - 1 = 2 * (3 * (3 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_131 : Nat.Prime 131 := by
  apply lucasNat 131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 131 - 1 = 2 * (5 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_137 : Nat.Prime 137 := by
  apply lucasNat 137 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 137 - 1 = 2 * (2 * (2 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_139 : Nat.Prime 139 := by
  apply lucasNat 139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 139 - 1 = 2 * (3 * (23)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_149 : Nat.Prime 149 := by
  apply lucasNat 149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 149 - 1 = 2 * (2 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_151 : Nat.Prime 151 := by
  apply lucasNat 151 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151 - 1 = 2 * (3 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_157 : Nat.Prime 157 := by
  apply lucasNat 157 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 157 - 1 = 2 * (2 * (3 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_163 : Nat.Prime 163 := by
  apply lucasNat 163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 163 - 1 = 2 * (3 * (3 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_167 : Nat.Prime 167 := by
  apply lucasNat 167 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 167 - 1 = 2 * (83) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_173 : Nat.Prime 173 := by
  apply lucasNat 173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 173 - 1 = 2 * (2 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_179 : Nat.Prime 179 := by
  apply lucasNat 179 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 179 - 1 = 2 * (89) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_181 : Nat.Prime 181 := by
  apply lucasNat 181 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 181 - 1 = 2 * (2 * (3 * (3 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_191 : Nat.Prime 191 := by
  apply lucasNat 191 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191 - 1 = 2 * (5 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_193 : Nat.Prime 193 := by
  apply lucasNat 193 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 193 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_197 : Nat.Prime 197 := by
  apply lucasNat 197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 197 - 1 = 2 * (2 * (7 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_199 : Nat.Prime 199 := by
  apply lucasNat 199 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199 - 1 = 2 * (3 * (3 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_211 : Nat.Prime 211 := by
  apply lucasNat 211 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 211 - 1 = 2 * (3 * (5 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_223 : Nat.Prime 223 := by
  apply lucasNat 223 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 223 - 1 = 2 * (3 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_227 : Nat.Prime 227 := by
  apply lucasNat 227 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 227 - 1 = 2 * (113) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_229 : Nat.Prime 229 := by
  apply lucasNat 229 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 229 - 1 = 2 * (2 * (3 * (19))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_233 : Nat.Prime 233 := by
  apply lucasNat 233 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 233 - 1 = 2 * (2 * (2 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_239 : Nat.Prime 239 := by
  apply lucasNat 239 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 239 - 1 = 2 * (7 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_241 : Nat.Prime 241 := by
  apply lucasNat 241 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 241 - 1 = 2 * (2 * (2 * (2 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_251 : Nat.Prime 251 := by
  apply lucasNat 251 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 251 - 1 = 2 * (5 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_257 : Nat.Prime 257 := by
  apply lucasNat 257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 257 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_263 : Nat.Prime 263 := by
  apply lucasNat 263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 263 - 1 = 2 * (131) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_271 : Nat.Prime 271 := by
  apply lucasNat 271 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 271 - 1 = 2 * (3 * (3 * (3 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_277 : Nat.Prime 277 := by
  apply lucasNat 277 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 277 - 1 = 2 * (2 * (3 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_281 : Nat.Prime 281 := by
  apply lucasNat 281 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 281 - 1 = 2 * (2 * (2 * (5 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_293 : Nat.Prime 293 := by
  apply lucasNat 293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 293 - 1 = 2 * (2 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_307 : Nat.Prime 307 := by
  apply lucasNat 307 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 307 - 1 = 2 * (3 * (3 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_311 : Nat.Prime 311 := by
  apply lucasNat 311 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 311 - 1 = 2 * (5 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_331 : Nat.Prime 331 := by
  apply lucasNat 331 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 331 - 1 = 2 * (3 * (5 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_349 : Nat.Prime 349 := by
  apply lucasNat 349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 349 - 1 = 2 * (2 * (3 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_353 : Nat.Prime 353 := by
  apply lucasNat 353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 353 - 1 = 2 * (2 * (2 * (2 * (2 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_359 : Nat.Prime 359 := by
  apply lucasNat 359 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 359 - 1 = 2 * (179) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_367 : Nat.Prime 367 := by
  apply lucasNat 367 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 367 - 1 = 2 * (3 * (61)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_373 : Nat.Prime 373 := by
  apply lucasNat 373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 373 - 1 = 2 * (2 * (3 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_379 : Nat.Prime 379 := by
  apply lucasNat 379 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 379 - 1 = 2 * (3 * (3 * (3 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_383 : Nat.Prime 383 := by
  apply lucasNat 383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 383 - 1 = 2 * (191) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_191] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_389 : Nat.Prime 389 := by
  apply lucasNat 389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389 - 1 = 2 * (2 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_397 : Nat.Prime 397 := by
  apply lucasNat 397 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 397 - 1 = 2 * (2 * (3 * (3 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_401 : Nat.Prime 401 := by
  apply lucasNat 401 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 401 - 1 = 2 * (2 * (2 * (2 * (5 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_409 : Nat.Prime 409 := by
  apply lucasNat 409 21 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 409 - 1 = 2 * (2 * (2 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_419 : Nat.Prime 419 := by
  apply lucasNat 419 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 419 - 1 = 2 * (11 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_431 : Nat.Prime 431 := by
  apply lucasNat 431 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 431 - 1 = 2 * (5 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_433 : Nat.Prime 433 := by
  apply lucasNat 433 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 433 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (3)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_439 : Nat.Prime 439 := by
  apply lucasNat 439 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 439 - 1 = 2 * (3 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_443 : Nat.Prime 443 := by
  apply lucasNat 443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 443 - 1 = 2 * (13 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_457 : Nat.Prime 457 := by
  apply lucasNat 457 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 457 - 1 = 2 * (2 * (2 * (3 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_487 : Nat.Prime 487 := by
  apply lucasNat 487 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 487 - 1 = 2 * (3 * (3 * (3 * (3 * (3))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_491 : Nat.Prime 491 := by
  apply lucasNat 491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 491 - 1 = 2 * (5 * (7 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_521 : Nat.Prime 521 := by
  apply lucasNat 521 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 521 - 1 = 2 * (2 * (2 * (5 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_523 : Nat.Prime 523 := by
  apply lucasNat 523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 523 - 1 = 2 * (3 * (3 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_541 : Nat.Prime 541 := by
  apply lucasNat 541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 541 - 1 = 2 * (2 * (3 * (3 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_563 : Nat.Prime 563 := by
  apply lucasNat 563 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 563 - 1 = 2 * (281) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_281] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_571 : Nat.Prime 571 := by
  apply lucasNat 571 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 571 - 1 = 2 * (3 * (5 * (19))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_587 : Nat.Prime 587 := by
  apply lucasNat 587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 587 - 1 = 2 * (293) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_293] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_599 : Nat.Prime 599 := by
  apply lucasNat 599 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 599 - 1 = 2 * (13 * (23)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_601 : Nat.Prime 601 := by
  apply lucasNat 601 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 601 - 1 = 2 * (2 * (2 * (3 * (5 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_607 : Nat.Prime 607 := by
  apply lucasNat 607 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 607 - 1 = 2 * (3 * (101)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_619 : Nat.Prime 619 := by
  apply lucasNat 619 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 619 - 1 = 2 * (3 * (103)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_641 : Nat.Prime 641 := by
  apply lucasNat 641 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 641 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (5))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_653 : Nat.Prime 653 := by
  apply lucasNat 653 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 653 - 1 = 2 * (2 * (163)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_163] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_659 : Nat.Prime 659 := by
  apply lucasNat 659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 659 - 1 = 2 * (7 * (47)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_673 : Nat.Prime 673 := by
  apply lucasNat 673 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 673 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_701 : Nat.Prime 701 := by
  apply lucasNat 701 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 701 - 1 = 2 * (2 * (5 * (5 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_709 : Nat.Prime 709 := by
  apply lucasNat 709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 709 - 1 = 2 * (2 * (3 * (59))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_727 : Nat.Prime 727 := by
  apply lucasNat 727 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 727 - 1 = 2 * (3 * (11 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_743 : Nat.Prime 743 := by
  apply lucasNat 743 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 743 - 1 = 2 * (7 * (53)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_751 : Nat.Prime 751 := by
  apply lucasNat 751 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 751 - 1 = 2 * (3 * (5 * (5 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_757 : Nat.Prime 757 := by
  apply lucasNat 757 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 757 - 1 = 2 * (2 * (3 * (3 * (3 * (7))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_761 : Nat.Prime 761 := by
  apply lucasNat 761 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 761 - 1 = 2 * (2 * (2 * (5 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_769 : Nat.Prime 769 := by
  apply lucasNat 769 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 769 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_773 : Nat.Prime 773 := by
  apply lucasNat 773 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 773 - 1 = 2 * (2 * (193)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_821 : Nat.Prime 821 := by
  apply lucasNat 821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 821 - 1 = 2 * (2 * (5 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_827 : Nat.Prime 827 := by
  apply lucasNat 827 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 827 - 1 = 2 * (7 * (59)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_883 : Nat.Prime 883 := by
  apply lucasNat 883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 883 - 1 = 2 * (3 * (3 * (7 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_911 : Nat.Prime 911 := by
  apply lucasNat 911 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 911 - 1 = 2 * (5 * (7 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_929 : Nat.Prime 929 := by
  apply lucasNat 929 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 929 - 1 = 2 * (2 * (2 * (2 * (2 * (29))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_937 : Nat.Prime 937 := by
  apply lucasNat 937 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 937 - 1 = 2 * (2 * (2 * (3 * (3 * (13))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_953 : Nat.Prime 953 := by
  apply lucasNat 953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 953 - 1 = 2 * (2 * (2 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_991 : Nat.Prime 991 := by
  apply lucasNat 991 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 991 - 1 = 2 * (3 * (3 * (5 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_997 : Nat.Prime 997 := by
  apply lucasNat 997 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 997 - 1 = 2 * (2 * (3 * (83))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1009 : Nat.Prime 1009 := by
  apply lucasNat 1009 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1009 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_1039 : Nat.Prime 1039 := by
  apply lucasNat 1039 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1039 - 1 = 2 * (3 * (173)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1063 : Nat.Prime 1063 := by
  apply lucasNat 1063 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1063 - 1 = 2 * (3 * (3 * (59))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1091 : Nat.Prime 1091 := by
  apply lucasNat 1091 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1091 - 1 = 2 * (5 * (109)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_109] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1097 : Nat.Prime 1097 := by
  apply lucasNat 1097 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1097 - 1 = 2 * (2 * (2 * (137))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_137] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1103 : Nat.Prime 1103 := by
  apply lucasNat 1103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1103 - 1 = 2 * (19 * (29)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1129 : Nat.Prime 1129 := by
  apply lucasNat 1129 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1129 - 1 = 2 * (2 * (2 * (3 * (47)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1163 : Nat.Prime 1163 := by
  apply lucasNat 1163 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1163 - 1 = 2 * (7 * (83)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1213 : Nat.Prime 1213 := by
  apply lucasNat 1213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1213 - 1 = 2 * (2 * (3 * (101))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1231 : Nat.Prime 1231 := by
  apply lucasNat 1231 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1231 - 1 = 2 * (3 * (5 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1259 : Nat.Prime 1259 := by
  apply lucasNat 1259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1259 - 1 = 2 * (17 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1289 : Nat.Prime 1289 := by
  apply lucasNat 1289 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1289 - 1 = 2 * (2 * (2 * (7 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1303 : Nat.Prime 1303 := by
  apply lucasNat 1303 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1303 - 1 = 2 * (3 * (7 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1319 : Nat.Prime 1319 := by
  apply lucasNat 1319 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1319 - 1 = 2 * (659) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_659] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_1361 : Nat.Prime 1361 := by
  apply lucasNat 1361 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1361 - 1 = 2 * (2 * (2 * (2 * (5 * (17))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_1381 : Nat.Prime 1381 := by
  apply lucasNat 1381 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1381 - 1 = 2 * (2 * (3 * (5 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1399 : Nat.Prime 1399 := by
  apply lucasNat 1399 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1399 - 1 = 2 * (3 * (233)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1423 : Nat.Prime 1423 := by
  apply lucasNat 1423 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1423 - 1 = 2 * (3 * (3 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1427 : Nat.Prime 1427 := by
  apply lucasNat 1427 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1427 - 1 = 2 * (23 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1459 : Nat.Prime 1459 := by
  apply lucasNat 1459 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1459 - 1 = 2 * (3 * (3 * (3 * (3 * (3 * (3)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_1481 : Nat.Prime 1481 := by
  apply lucasNat 1481 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1481 - 1 = 2 * (2 * (2 * (5 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1487 : Nat.Prime 1487 := by
  apply lucasNat 1487 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1487 - 1 = 2 * (743) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_743] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_1499 : Nat.Prime 1499 := by
  apply lucasNat 1499 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1499 - 1 = 2 * (7 * (107)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1549 : Nat.Prime 1549 := by
  apply lucasNat 1549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1549 - 1 = 2 * (2 * (3 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1571 : Nat.Prime 1571 := by
  apply lucasNat 1571 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1571 - 1 = 2 * (5 * (157)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1609 : Nat.Prime 1609 := by
  apply lucasNat 1609 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1609 - 1 = 2 * (2 * (2 * (3 * (67)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1657 : Nat.Prime 1657 := by
  apply lucasNat 1657 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1657 - 1 = 2 * (2 * (2 * (3 * (3 * (23))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_1669 : Nat.Prime 1669 := by
  apply lucasNat 1669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1669 - 1 = 2 * (2 * (3 * (139))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_139] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1693 : Nat.Prime 1693 := by
  apply lucasNat 1693 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1693 - 1 = 2 * (2 * (3 * (3 * (47)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1709 : Nat.Prime 1709 := by
  apply lucasNat 1709 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1709 - 1 = 2 * (2 * (7 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1723 : Nat.Prime 1723 := by
  apply lucasNat 1723 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1723 - 1 = 2 * (3 * (7 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1783 : Nat.Prime 1783 := by
  apply lucasNat 1783 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1783 - 1 = 2 * (3 * (3 * (3 * (3 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_1823 : Nat.Prime 1823 := by
  apply lucasNat 1823 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1823 - 1 = 2 * (911) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_911] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_1861 : Nat.Prime 1861 := by
  apply lucasNat 1861 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1861 - 1 = 2 * (2 * (3 * (5 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1901 : Nat.Prime 1901 := by
  apply lucasNat 1901 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1901 - 1 = 2 * (2 * (5 * (5 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1931 : Nat.Prime 1931 := by
  apply lucasNat 1931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1931 - 1 = 2 * (5 * (193)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1951 : Nat.Prime 1951 := by
  apply lucasNat 1951 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1951 - 1 = 2 * (3 * (5 * (5 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1973 : Nat.Prime 1973 := by
  apply lucasNat 1973 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1973 - 1 = 2 * (2 * (17 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1987 : Nat.Prime 1987 := by
  apply lucasNat 1987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1987 - 1 = 2 * (3 * (331)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1999 : Nat.Prime 1999 := by
  apply lucasNat 1999 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999 - 1 = 2 * (3 * (3 * (3 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2029 : Nat.Prime 2029 := by
  apply lucasNat 2029 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2029 - 1 = 2 * (2 * (3 * (13 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2069 : Nat.Prime 2069 := by
  apply lucasNat 2069 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2069 - 1 = 2 * (2 * (11 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2161 : Nat.Prime 2161 := by
  apply lucasNat 2161 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2161 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (3 * (5))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_2179 : Nat.Prime 2179 := by
  apply lucasNat 2179 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2179 - 1 = 2 * (3 * (3 * (11 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2269 : Nat.Prime 2269 := by
  apply lucasNat 2269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2269 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_2273 : Nat.Prime 2273 := by
  apply lucasNat 2273 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2273 - 1 = 2 * (2 * (2 * (2 * (2 * (71))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_2351 : Nat.Prime 2351 := by
  apply lucasNat 2351 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2351 - 1 = 2 * (5 * (5 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2383 : Nat.Prime 2383 := by
  apply lucasNat 2383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2383 - 1 = 2 * (3 * (397)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_397] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_2393 : Nat.Prime 2393 := by
  apply lucasNat 2393 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2393 - 1 = 2 * (2 * (2 * (13 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2477 : Nat.Prime 2477 := by
  apply lucasNat 2477 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2477 - 1 = 2 * (2 * (619)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_619] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_2503 : Nat.Prime 2503 := by
  apply lucasNat 2503 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2503 - 1 = 2 * (3 * (3 * (139))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_139] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2579 : Nat.Prime 2579 := by
  apply lucasNat 2579 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2579 - 1 = 2 * (1289) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1289] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_2699 : Nat.Prime 2699 := by
  apply lucasNat 2699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2699 - 1 = 2 * (19 * (71)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_2707 : Nat.Prime 2707 := by
  apply lucasNat 2707 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2707 - 1 = 2 * (3 * (11 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2833 : Nat.Prime 2833 := by
  apply lucasNat 2833 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2833 - 1 = 2 * (2 * (2 * (2 * (3 * (59))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_2917 : Nat.Prime 2917 := by
  apply lucasNat 2917 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2917 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (3 * (3))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_2939 : Nat.Prime 2939 := by
  apply lucasNat 2939 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2939 - 1 = 2 * (13 * (113)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_2963 : Nat.Prime 2963 := by
  apply lucasNat 2963 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2963 - 1 = 2 * (1481) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1481] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_2971 : Nat.Prime 2971 := by
  apply lucasNat 2971 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2971 - 1 = 2 * (3 * (3 * (3 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_2999 : Nat.Prime 2999 := by
  apply lucasNat 2999 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2999 - 1 = 2 * (1499) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1499] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_3083 : Nat.Prime 3083 := by
  apply lucasNat 3083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3083 - 1 = 2 * (23 * (67)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_3121 : Nat.Prime 3121 := by
  apply lucasNat 3121 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3121 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (13)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_3163 : Nat.Prime 3163 := by
  apply lucasNat 3163 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3163 - 1 = 2 * (3 * (17 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3259 : Nat.Prime 3259 := by
  apply lucasNat 3259 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3259 - 1 = 2 * (3 * (3 * (181))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3299 : Nat.Prime 3299 := by
  apply lucasNat 3299 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3299 - 1 = 2 * (17 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_3449 : Nat.Prime 3449 := by
  apply lucasNat 3449 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3449 - 1 = 2 * (2 * (2 * (431))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_431] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3673 : Nat.Prime 3673 := by
  apply lucasNat 3673 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3673 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (17)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_3727 : Nat.Prime 3727 := by
  apply lucasNat 3727 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3727 - 1 = 2 * (3 * (3 * (3 * (3 * (23))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_3797 : Nat.Prime 3797 := by
  apply lucasNat 3797 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3797 - 1 = 2 * (2 * (13 * (73))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3917 : Nat.Prime 3917 := by
  apply lucasNat 3917 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3917 - 1 = 2 * (2 * (11 * (89))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3923 : Nat.Prime 3923 := by
  apply lucasNat 3923 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3923 - 1 = 2 * (37 * (53)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_3929 : Nat.Prime 3929 := by
  apply lucasNat 3929 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3929 - 1 = 2 * (2 * (2 * (491))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_491] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3931 : Nat.Prime 3931 := by
  apply lucasNat 3931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3931 - 1 = 2 * (3 * (5 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3947 : Nat.Prime 3947 := by
  apply lucasNat 3947 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3947 - 1 = 2 * (1973) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1973] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_3989 : Nat.Prime 3989 := by
  apply lucasNat 3989 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3989 - 1 = 2 * (2 * (997)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_997] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_4139 : Nat.Prime 4139 := by
  apply lucasNat 4139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4139 - 1 = 2 * (2069) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2069] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_4157 : Nat.Prime 4157 := by
  apply lucasNat 4157 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4157 - 1 = 2 * (2 * (1039)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1039] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_4271 : Nat.Prime 4271 := by
  apply lucasNat 4271 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4271 - 1 = 2 * (5 * (7 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_4339 : Nat.Prime 4339 := by
  apply lucasNat 4339 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4339 - 1 = 2 * (3 * (3 * (241))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_4363 : Nat.Prime 4363 := by
  apply lucasNat 4363 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4363 - 1 = 2 * (3 * (727)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_727] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_4463 : Nat.Prime 4463 := by
  apply lucasNat 4463 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4463 - 1 = 2 * (23 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_4517 : Nat.Prime 4517 := by
  apply lucasNat 4517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4517 - 1 = 2 * (2 * (1129)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1129] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_4603 : Nat.Prime 4603 := by
  apply lucasNat 4603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4603 - 1 = 2 * (3 * (13 * (59))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_4643 : Nat.Prime 4643 := by
  apply lucasNat 4643 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4643 - 1 = 2 * (11 * (211)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_211] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_4813 : Nat.Prime 4813 := by
  apply lucasNat 4813 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4813 - 1 = 2 * (2 * (3 * (401))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_401] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_5021 : Nat.Prime 5021 := by
  apply lucasNat 5021 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5021 - 1 = 2 * (2 * (5 * (251))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_251] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_5077 : Nat.Prime 5077 := by
  apply lucasNat 5077 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5077 - 1 = 2 * (2 * (3 * (3 * (3 * (47))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_5081 : Nat.Prime 5081 := by
  apply lucasNat 5081 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5081 - 1 = 2 * (2 * (2 * (5 * (127)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_5107 : Nat.Prime 5107 := by
  apply lucasNat 5107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5107 - 1 = 2 * (3 * (23 * (37))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_5297 : Nat.Prime 5297 := by
  apply lucasNat 5297 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5297 - 1 = 2 * (2 * (2 * (2 * (331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_5399 : Nat.Prime 5399 := by
  apply lucasNat 5399 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5399 - 1 = 2 * (2699) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2699] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_5501 : Nat.Prime 5501 := by
  apply lucasNat 5501 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5501 - 1 = 2 * (2 * (5 * (5 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_5503 : Nat.Prime 5503 := by
  apply lucasNat 5503 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5503 - 1 = 2 * (3 * (7 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_5791 : Nat.Prime 5791 := by
  apply lucasNat 5791 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5791 - 1 = 2 * (3 * (5 * (193))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_5879 : Nat.Prime 5879 := by
  apply lucasNat 5879 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5879 - 1 = 2 * (2939) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2939] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_5927 : Nat.Prime 5927 := by
  apply lucasNat 5927 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5927 - 1 = 2 * (2963) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2963] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_5953 : Nat.Prime 5953 := by
  apply lucasNat 5953 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5953 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (31))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_6073 : Nat.Prime 6073 := by
  apply lucasNat 6073 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6073 - 1 = 2 * (2 * (2 * (3 * (11 * (23))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_6197 : Nat.Prime 6197 := by
  apply lucasNat 6197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6197 - 1 = 2 * (2 * (1549)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1549] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_6263 : Nat.Prime 6263 := by
  apply lucasNat 6263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6263 - 1 = 2 * (31 * (101)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_6323 : Nat.Prime 6323 := by
  apply lucasNat 6323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6323 - 1 = 2 * (29 * (109)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_109] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_6343 : Nat.Prime 6343 := by
  apply lucasNat 6343 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6343 - 1 = 2 * (3 * (7 * (151))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_6551 : Nat.Prime 6551 := by
  apply lucasNat 6551 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6551 - 1 = 2 * (5 * (5 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_6599 : Nat.Prime 6599 := by
  apply lucasNat 6599 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6599 - 1 = 2 * (3299) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3299] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_6949 : Nat.Prime 6949 := by
  apply lucasNat 6949 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6949 - 1 = 2 * (2 * (3 * (3 * (193)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_7057 : Nat.Prime 7057 := by
  apply lucasNat 7057 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7057 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (7))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_7211 : Nat.Prime 7211 := by
  apply lucasNat 7211 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7211 - 1 = 2 * (5 * (7 * (103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_7723 : Nat.Prime 7723 := by
  apply lucasNat 7723 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7723 - 1 = 2 * (3 * (3 * (3 * (11 * (13))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_7757 : Nat.Prime 7757 := by
  apply lucasNat 7757 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7757 - 1 = 2 * (2 * (7 * (277))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_277] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8191 : Nat.Prime 8191 := by
  apply lucasNat 8191 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8191 - 1 = 2 * (3 * (3 * (5 * (7 * (13))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8311 : Nat.Prime 8311 := by
  apply lucasNat 8311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8311 - 1 = 2 * (3 * (5 * (277))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_277] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8363 : Nat.Prime 8363 := by
  apply lucasNat 8363 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8363 - 1 = 2 * (37 * (113)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8537 : Nat.Prime 8537 := by
  apply lucasNat 8537 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8537 - 1 = 2 * (2 * (2 * (11 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8821 : Nat.Prime 8821 := by
  apply lucasNat 8821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8821 - 1 = 2 * (2 * (3 * (3 * (5 * (7 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8971 : Nat.Prime 8971 := by
  apply lucasNat 8971 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8971 - 1 = 2 * (3 * (5 * (13 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_9277 : Nat.Prime 9277 := by
  apply lucasNat 9277 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9277 - 1 = 2 * (2 * (3 * (773))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_773] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_9431 : Nat.Prime 9431 := by
  apply lucasNat 9431 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9431 - 1 = 2 * (5 * (23 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_9787 : Nat.Prime 9787 := by
  apply lucasNat 9787 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9787 - 1 = 2 * (3 * (7 * (233))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_9829 : Nat.Prime 9829 := by
  apply lucasNat 9829 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9829 - 1 = 2 * (2 * (3 * (3 * (3 * (7 * (13)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_10301 : Nat.Prime 10301 := by
  apply lucasNat 10301 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10301 - 1 = 2 * (2 * (5 * (5 * (103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_10313 : Nat.Prime 10313 := by
  apply lucasNat 10313 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10313 - 1 = 2 * (2 * (2 * (1289))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1289] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_10597 : Nat.Prime 10597 := by
  apply lucasNat 10597 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10597 - 1 = 2 * (2 * (3 * (883))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_883] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_10799 : Nat.Prime 10799 := by
  apply lucasNat 10799 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10799 - 1 = 2 * (5399) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5399] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_11087 : Nat.Prime 11087 := by
  apply lucasNat 11087 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11087 - 1 = 2 * (23 * (241)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_12647 : Nat.Prime 12647 := by
  apply lucasNat 12647 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12647 - 1 = 2 * (6323) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_6323] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_12653 : Nat.Prime 12653 := by
  apply lucasNat 12653 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12653 - 1 = 2 * (2 * (3163)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3163] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_12703 : Nat.Prime 12703 := by
  apply lucasNat 12703 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12703 - 1 = 2 * (3 * (29 * (73))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_12713 : Nat.Prime 12713 := by
  apply lucasNat 12713 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12713 - 1 = 2 * (2 * (2 * (7 * (227)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_227] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_12907 : Nat.Prime 12907 := by
  apply lucasNat 12907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12907 - 1 = 2 * (3 * (3 * (3 * (239)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_13007 : Nat.Prime 13007 := by
  apply lucasNat 13007 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13007 - 1 = 2 * (7 * (929)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_929] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_13049 : Nat.Prime 13049 := by
  apply lucasNat 13049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13049 - 1 = 2 * (2 * (2 * (7 * (233)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_13297 : Nat.Prime 13297 := by
  apply lucasNat 13297 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13297 - 1 = 2 * (2 * (2 * (2 * (3 * (277))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_277] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_13721 : Nat.Prime 13721 := by
  apply lucasNat 13721 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13721 - 1 = 2 * (2 * (2 * (5 * (7 * (7 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_14221 : Nat.Prime 14221 := by
  apply lucasNat 14221 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14221 - 1 = 2 * (2 * (3 * (3 * (5 * (79))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_14423 : Nat.Prime 14423 := by
  apply lucasNat 14423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14423 - 1 = 2 * (7211) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7211] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_14461 : Nat.Prime 14461 := by
  apply lucasNat 14461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14461 - 1 = 2 * (2 * (3 * (5 * (241)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_14741 : Nat.Prime 14741 := by
  apply lucasNat 14741 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14741 - 1 = 2 * (2 * (5 * (11 * (67)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_15451 : Nat.Prime 15451 := by
  apply lucasNat 15451 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15451 - 1 = 2 * (3 * (5 * (5 * (103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_15877 : Nat.Prime 15877 := by
  apply lucasNat 15877 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15877 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (7 * (7))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_16673 : Nat.Prime 16673 := by
  apply lucasNat 16673 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16673 - 1 = 2 * (2 * (2 * (2 * (2 * (521))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_521] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_17053 : Nat.Prime 17053 := by
  apply lucasNat 17053 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17053 - 1 = 2 * (2 * (3 * (7 * (7 * (29))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_17203 : Nat.Prime 17203 := by
  apply lucasNat 17203 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17203 - 1 = 2 * (3 * (47 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_17431 : Nat.Prime 17431 := by
  apply lucasNat 17431 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17431 - 1 = 2 * (3 * (5 * (7 * (83)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_18413 : Nat.Prime 18413 := by
  apply lucasNat 18413 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 18413 - 1 = 2 * (2 * (4603)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4603] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_19267 : Nat.Prime 19267 := by
  apply lucasNat 19267 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19267 - 1 = 2 * (3 * (13 * (13 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_19861 : Nat.Prime 19861 := by
  apply lucasNat 19861 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19861 - 1 = 2 * (2 * (3 * (5 * (331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_20129 : Nat.Prime 20129 := by
  apply lucasNat 20129 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20129 - 1 = 2 * (2 * (2 * (2 * (2 * (17 * (37)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_20287 : Nat.Prime 20287 := by
  apply lucasNat 20287 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20287 - 1 = 2 * (3 * (3 * (7 * (7 * (23))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_21149 : Nat.Prime 21149 := by
  apply lucasNat 21149 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21149 - 1 = 2 * (2 * (17 * (311))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_21599 : Nat.Prime 21599 := by
  apply lucasNat 21599 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21599 - 1 = 2 * (10799) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_10799] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_21751 : Nat.Prime 21751 := by
  apply lucasNat 21751 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21751 - 1 = 2 * (3 * (5 * (5 * (5 * (29))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_22039 : Nat.Prime 22039 := by
  apply lucasNat 22039 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22039 - 1 = 2 * (3 * (3673)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3673] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_23813 : Nat.Prime 23813 := by
  apply lucasNat 23813 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23813 - 1 = 2 * (2 * (5953)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5953] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_24121 : Nat.Prime 24121 := by
  apply lucasNat 24121 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24121 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (67)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_24841 : Nat.Prime 24841 := by
  apply lucasNat 24841 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24841 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (5 * (23))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_25229 : Nat.Prime 25229 := by
  apply lucasNat 25229 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25229 - 1 = 2 * (2 * (7 * (17 * (53)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_25373 : Nat.Prime 25373 := by
  apply lucasNat 25373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25373 - 1 = 2 * (2 * (6343)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_6343] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_26053 : Nat.Prime 26053 := by
  apply lucasNat 26053 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26053 - 1 = 2 * (2 * (3 * (13 * (167)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_26099 : Nat.Prime 26099 := by
  apply lucasNat 26099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26099 - 1 = 2 * (13049) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13049] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_26261 : Nat.Prime 26261 := by
  apply lucasNat 26261 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26261 - 1 = 2 * (2 * (5 * (13 * (101)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_26861 : Nat.Prime 26861 := by
  apply lucasNat 26861 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26861 - 1 = 2 * (2 * (5 * (17 * (79)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_27061 : Nat.Prime 27061 := by
  apply lucasNat 27061 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 27061 - 1 = 2 * (2 * (3 * (5 * (11 * (41))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_27481 : Nat.Prime 27481 := by
  apply lucasNat 27481 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 27481 - 1 = 2 * (2 * (2 * (3 * (5 * (229))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_30713 : Nat.Prime 30713 := by
  apply lucasNat 30713 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30713 - 1 = 2 * (2 * (2 * (11 * (349)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_349] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_30893 : Nat.Prime 30893 := by
  apply lucasNat 30893 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30893 - 1 = 2 * (2 * (7723)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7723] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_32971 : Nat.Prime 32971 := by
  apply lucasNat 32971 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32971 - 1 = 2 * (3 * (5 * (7 * (157)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_33091 : Nat.Prime 33091 := by
  apply lucasNat 33091 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33091 - 1 = 2 * (3 * (5 * (1103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_33223 : Nat.Prime 33223 := by
  apply lucasNat 33223 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33223 - 1 = 2 * (3 * (7 * (7 * (113)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_34483 : Nat.Prime 34483 := by
  apply lucasNat 34483 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 34483 - 1 = 2 * (3 * (7 * (821))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_821] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_34501 : Nat.Prime 34501 := by
  apply lucasNat 34501 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 34501 - 1 = 2 * (2 * (3 * (5 * (5 * (5 * (23)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_35423 : Nat.Prime 35423 := by
  apply lucasNat 35423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 35423 - 1 = 2 * (89 * (199)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_199] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_36073 : Nat.Prime 36073 := by
  apply lucasNat 36073 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36073 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (167)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_37201 : Nat.Prime 37201 := by
  apply lucasNat 37201 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37201 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (5 * (31))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_37987 : Nat.Prime 37987 := by
  apply lucasNat 37987 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37987 - 1 = 2 * (3 * (13 * (487))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_487] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_38873 : Nat.Prime 38873 := by
  apply lucasNat 38873 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 38873 - 1 = 2 * (2 * (2 * (43 * (113)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_42299 : Nat.Prime 42299 := by
  apply lucasNat 42299 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 42299 - 1 = 2 * (21149) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_21149] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_42923 : Nat.Prime 42923 := by
  apply lucasNat 42923 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 42923 - 1 = 2 * (11 * (1951)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1951] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_43313 : Nat.Prime 43313 := by
  apply lucasNat 43313 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43313 - 1 = 2 * (2 * (2 * (2 * (2707)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2707] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_46073 : Nat.Prime 46073 := by
  apply lucasNat 46073 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 46073 - 1 = 2 * (2 * (2 * (13 * (443)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_443] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_47293 : Nat.Prime 47293 := by
  apply lucasNat 47293 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 47293 - 1 = 2 * (2 * (3 * (7 * (563)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_563] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_48121 : Nat.Prime 48121 := by
  apply lucasNat 48121 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 48121 - 1 = 2 * (2 * (2 * (3 * (5 * (401))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_401] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_49417 : Nat.Prime 49417 := by
  apply lucasNat 49417 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49417 - 1 = 2 * (2 * (2 * (3 * (29 * (71))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_51647 : Nat.Prime 51647 := by
  apply lucasNat 51647 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 51647 - 1 = 2 * (7 * (7 * (17 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_52883 : Nat.Prime 52883 := by
  apply lucasNat 52883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 52883 - 1 = 2 * (137 * (193)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_54979 : Nat.Prime 54979 := by
  apply lucasNat 54979 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 54979 - 1 = 2 * (3 * (7 * (7 * (11 * (17))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_60103 : Nat.Prime 60103 := by
  apply lucasNat 60103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 60103 - 1 = 2 * (3 * (3 * (3 * (3 * (7 * (53)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_61751 : Nat.Prime 61751 := by
  apply lucasNat 61751 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 61751 - 1 = 2 * (5 * (5 * (5 * (13 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_62057 : Nat.Prime 62057 := by
  apply lucasNat 62057 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 62057 - 1 = 2 * (2 * (2 * (7757))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7757] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_62627 : Nat.Prime 62627 := by
  apply lucasNat 62627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 62627 - 1 = 2 * (173 * (181)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_64171 : Nat.Prime 64171 := by
  apply lucasNat 64171 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 64171 - 1 = 2 * (3 * (3 * (5 * (23 * (31))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_65899 : Nat.Prime 65899 := by
  apply lucasNat 65899 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 65899 - 1 = 2 * (3 * (3 * (7 * (523)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_523] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_66751 : Nat.Prime 66751 := by
  apply lucasNat 66751 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 66751 - 1 = 2 * (3 * (5 * (5 * (5 * (89))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_68071 : Nat.Prime 68071 := by
  apply lucasNat 68071 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 68071 - 1 = 2 * (3 * (5 * (2269))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2269] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_68213 : Nat.Prime 68213 := by
  apply lucasNat 68213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 68213 - 1 = 2 * (2 * (17053)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17053] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_68813 : Nat.Prime 68813 := by
  apply lucasNat 68813 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 68813 - 1 = 2 * (2 * (17203)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17203] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_68909 : Nat.Prime 68909 := by
  apply lucasNat 68909 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 68909 - 1 = 2 * (2 * (7 * (23 * (107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_69491 : Nat.Prime 69491 := by
  apply lucasNat 69491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 69491 - 1 = 2 * (5 * (6949)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_6949] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_69809 : Nat.Prime 69809 := by
  apply lucasNat 69809 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 69809 - 1 = 2 * (2 * (2 * (2 * (4363)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4363] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_74449 : Nat.Prime 74449 := by
  apply lucasNat 74449 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 74449 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (11 * (47))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_75941 : Nat.Prime 75941 := by
  apply lucasNat 75941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 75941 - 1 = 2 * (2 * (5 * (3797))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3797] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_78059 : Nat.Prime 78059 := by
  apply lucasNat 78059 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 78059 - 1 = 2 * (31 * (1259)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_1259] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_79357 : Nat.Prime 79357 := by
  apply lucasNat 79357 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 79357 - 1 = 2 * (2 * (3 * (17 * (389)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_86627 : Nat.Prime 86627 := by
  apply lucasNat 86627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 86627 - 1 = 2 * (43313) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43313] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_86767 : Nat.Prime 86767 := by
  apply lucasNat 86767 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 86767 - 1 = 2 * (3 * (14461)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_14461] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_87211 : Nat.Prime 87211 := by
  apply lucasNat 87211 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 87211 - 1 = 2 * (3 * (3 * (3 * (5 * (17 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_122207 : Nat.Prime 122207 := by
  apply lucasNat 122207 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 122207 - 1 = 2 * (7 * (7 * (29 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_123503 : Nat.Prime 123503 := by
  apply lucasNat 123503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 123503 - 1 = 2 * (61751) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_61751] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_126211 : Nat.Prime 126211 := by
  apply lucasNat 126211 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 126211 - 1 = 2 * (3 * (5 * (7 * (601)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_601] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_131489 : Nat.Prime 131489 := by
  apply lucasNat 131489 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 131489 - 1 = 2 * (2 * (2 * (2 * (2 * (7 * (587)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_587] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_132971 : Nat.Prime 132971 := by
  apply lucasNat 132971 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 132971 - 1 = 2 * (5 * (13297)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13297] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_136879 : Nat.Prime 136879 := by
  apply lucasNat 136879 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 136879 - 1 = 2 * (3 * (7 * (3259))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3259] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_139619 : Nat.Prime 139619 := by
  apply lucasNat 139619 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 139619 - 1 = 2 * (69809) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_69809] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_151013 : Nat.Prime 151013 := by
  apply lucasNat 151013 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151013 - 1 = 2 * (2 * (19 * (1987))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_1987] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_151883 : Nat.Prime 151883 := by
  apply lucasNat 151883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151883 - 1 = 2 * (75941) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_75941] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_152239 : Nat.Prime 152239 := by
  apply lucasNat 152239 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 152239 - 1 = 2 * (3 * (25373)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_25373] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_170239 : Nat.Prime 170239 := by
  apply lucasNat 170239 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 170239 - 1 = 2 * (3 * (17 * (1669))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_1669] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_174311 : Nat.Prime 174311 := by
  apply lucasNat 174311 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 174311 - 1 = 2 * (5 * (17431)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17431] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_213287 : Nat.Prime 213287 := by
  apply lucasNat 213287 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 213287 - 1 = 2 * (47 * (2269)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_2269] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_227789 : Nat.Prime 227789 := by
  apply lucasNat 227789 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 227789 - 1 = 2 * (2 * (11 * (31 * (167)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_233143 : Nat.Prime 233143 := by
  apply lucasNat 233143 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 233143 - 1 = 2 * (3 * (7 * (7 * (13 * (61))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_243203 : Nat.Prime 243203 := by
  apply lucasNat 243203 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 243203 - 1 = 2 * (17 * (23 * (311))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_246511 : Nat.Prime 246511 := by
  apply lucasNat 246511 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 246511 - 1 = 2 * (3 * (3 * (3 * (5 * (11 * (83)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_247007 : Nat.Prime 247007 := by
  apply lucasNat 247007 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 247007 - 1 = 2 * (123503) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_123503] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_264631 : Nat.Prime 264631 := by
  apply lucasNat 264631 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 264631 - 1 = 2 * (3 * (5 * (8821))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_8821] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_267649 : Nat.Prime 267649 := by
  apply lucasNat 267649 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 267649 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (17 * (41))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel

theorem prime_274123 : Nat.Prime 274123 := by
  apply lucasNat 274123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 274123 - 1 = 2 * (3 * (3 * (97 * (157)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_277883 : Nat.Prime 277883 := by
  apply lucasNat 277883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 277883 - 1 = 2 * (11 * (17 * (743))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_743] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_294781 : Nat.Prime 294781 := by
  apply lucasNat 294781 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 294781 - 1 = 2 * (2 * (3 * (5 * (17 * (17 * (17)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_294821 : Nat.Prime 294821 := by
  apply lucasNat 294821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 294821 - 1 = 2 * (2 * (5 * (14741))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_14741] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_296503 : Nat.Prime 296503 := by
  apply lucasNat 296503 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 296503 - 1 = 2 * (3 * (49417)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_49417] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_298261 : Nat.Prime 298261 := by
  apply lucasNat 298261 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 298261 - 1 = 2 * (2 * (3 * (3 * (5 * (1657))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1657] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_303767 : Nat.Prime 303767 := by
  apply lucasNat 303767 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 303767 - 1 = 2 * (151883) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151883] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_345143 : Nat.Prime 345143 := by
  apply lucasNat 345143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 345143 - 1 = 2 * (7 * (89 * (277))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_277] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_353611 : Nat.Prime 353611 := by
  apply lucasNat 353611 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 353611 - 1 = 2 * (3 * (3 * (5 * (3929)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3929] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_357199 : Nat.Prime 357199 := by
  apply lucasNat 357199 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 357199 - 1 = 2 * (3 * (37 * (1609))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_1609] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_364289 : Nat.Prime 364289 := by
  apply lucasNat 364289 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 364289 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (1423)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1423] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_388931 : Nat.Prime 388931 := by
  apply lucasNat 388931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 388931 - 1 = 2 * (5 * (19 * (23 * (89)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_391519 : Nat.Prime 391519 := by
  apply lucasNat 391519 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 391519 - 1 = 2 * (3 * (3 * (21751))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_21751] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_439697 : Nat.Prime 439697 := by
  apply lucasNat 439697 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 439697 - 1 = 2 * (2 * (2 * (2 * (27481)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_27481] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_459649 : Nat.Prime 459649 := by
  apply lucasNat 459649 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 459649 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (3 * (7 * (19))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel

theorem prime_489343 : Nat.Prime 489343 := by
  apply lucasNat 489343 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 489343 - 1 = 2 * (3 * (7 * (61 * (191)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_191] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_589643 : Nat.Prime 589643 := by
  apply lucasNat 589643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 589643 - 1 = 2 * (294821) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_294821] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_619139 : Nat.Prime 619139 := by
  apply lucasNat 619139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 619139 - 1 = 2 * (13 * (23813)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23813] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_649277 : Nat.Prime 649277 := by
  apply lucasNat 649277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 649277 - 1 = 2 * (2 * (37 * (41 * (107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_699961 : Nat.Prime 699961 := by
  apply lucasNat 699961 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 699961 - 1 = 2 * (2 * (2 * (3 * (5 * (19 * (307)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_307] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_701791 : Nat.Prime 701791 := by
  apply lucasNat 701791 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 701791 - 1 = 2 * (3 * (5 * (149 * (157)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_892553 : Nat.Prime 892553 := by
  apply lucasNat 892553 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 892553 - 1 = 2 * (2 * (2 * (31 * (59 * (61))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_897401 : Nat.Prime 897401 := by
  apply lucasNat 897401 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 897401 - 1 = 2 * (2 * (2 * (5 * (5 * (7 * (641)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_641] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_902303 : Nat.Prime 902303 := by
  apply lucasNat 902303 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 902303 - 1 = 2 * (109 * (4139)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_4139] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_946861 : Nat.Prime 946861 := by
  apply lucasNat 946861 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 946861 - 1 = 2 * (2 * (3 * (5 * (43 * (367))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_367] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_966029 : Nat.Prime 966029 := by
  apply lucasNat 966029 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 966029 - 1 = 2 * (2 * (7 * (34501))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_34501] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_996973 : Nat.Prime 996973 := by
  apply lucasNat 996973 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 996973 - 1 = 2 * (2 * (3 * (251 * (331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1007497 : Nat.Prime 1007497 := by
  apply lucasNat 1007497 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1007497 - 1 = 2 * (2 * (2 * (3 * (3 * (7 * (1999)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1999] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_1033189 : Nat.Prime 1033189 := by
  apply lucasNat 1033189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1033189 - 1 = 2 * (2 * (3 * (13 * (37 * (179))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_1045003 : Nat.Prime 1045003 := by
  apply lucasNat 1045003 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1045003 - 1 = 2 * (3 * (7 * (139 * (179)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1051913 : Nat.Prime 1051913 := by
  apply lucasNat 1051913 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1051913 - 1 = 2 * (2 * (2 * (131489))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131489] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1226783 : Nat.Prime 1226783 := by
  apply lucasNat 1226783 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1226783 - 1 = 2 * (167 * (3673)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_3673] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1520879 : Nat.Prime 1520879 := by
  apply lucasNat 1520879 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1520879 - 1 = 2 * (307 * (2477)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_307, Nat.prime_dvd_prime_iff_eq hq prime_2477] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_2019257 : Nat.Prime 2019257 := by
  apply lucasNat 2019257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2019257 - 1 = 2 * (2 * (2 * (173 * (1459)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_1459] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2021083 : Nat.Prime 2021083 := by
  apply lucasNat 2021083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2021083 - 1 = 2 * (3 * (7 * (48121))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_48121] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2154851 : Nat.Prime 2154851 := by
  apply lucasNat 2154851 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2154851 - 1 = 2 * (5 * (5 * (71 * (607)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2219621 : Nat.Prime 2219621 := by
  apply lucasNat 2219621 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2219621 - 1 = 2 * (2 * (5 * (13 * (8537)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_8537] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2339303 : Nat.Prime 2339303 := by
  apply lucasNat 2339303 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2339303 - 1 = 2 * (7 * (17 * (9829))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_9829] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2485513 : Nat.Prime 2485513 := by
  apply lucasNat 2485513 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2485513 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (37 * (311))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_2618879 : Nat.Prime 2618879 := by
  apply lucasNat 2618879 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2618879 - 1 = 2 * (103 * (12713)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_12713] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_2763811 : Nat.Prime 2763811 := by
  apply lucasNat 2763811 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2763811 - 1 = 2 * (3 * (3 * (5 * (7 * (41 * (107)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_2900951 : Nat.Prime 2900951 := by
  apply lucasNat 2900951 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2900951 - 1 = 2 * (5 * (5 * (13 * (4463)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_4463] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3033169 : Nat.Prime 3033169 := by
  apply lucasNat 3033169 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3033169 - 1 = 2 * (2 * (2 * (2 * (3 * (29 * (2179)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_2179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_3033971 : Nat.Prime 3033971 := by
  apply lucasNat 3033971 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3033971 - 1 = 2 * (5 * (31 * (9787))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_9787] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3190909 : Nat.Prime 3190909 := by
  apply lucasNat 3190909 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3190909 - 1 = 2 * (2 * (3 * (7 * (37987)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_37987] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3458099 : Nat.Prime 3458099 := by
  apply lucasNat 3458099 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3458099 - 1 = 2 * (7 * (247007)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_247007] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_3579133 : Nat.Prime 3579133 := by
  apply lucasNat 3579133 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3579133 - 1 = 2 * (2 * (3 * (298261))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_298261] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3594113 : Nat.Prime 3594113 := by
  apply lucasNat 3594113 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3594113 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (43 * (653)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_653] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_6700411 : Nat.Prime 6700411 := by
  apply lucasNat 6700411 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6700411 - 1 = 2 * (3 * (3 * (5 * (74449)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_74449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_6916199 : Nat.Prime 6916199 := by
  apply lucasNat 6916199 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6916199 - 1 = 2 * (3458099) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3458099] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_7017911 : Nat.Prime 7017911 := by
  apply lucasNat 7017911 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7017911 - 1 = 2 * (5 * (701791)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_701791] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_7230571 : Nat.Prime 7230571 := by
  apply lucasNat 7230571 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7230571 - 1 = 2 * (3 * (5 * (29 * (8311)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_8311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8196491 : Nat.Prime 8196491 := by
  apply lucasNat 8196491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8196491 - 1 = 2 * (5 * (149 * (5501))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_5501] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8576947 : Nat.Prime 8576947 := by
  apply lucasNat 8576947 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8576947 - 1 = 2 * (3 * (3 * (7 * (68071)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_68071] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_9061111 : Nat.Prime 9061111 := by
  apply lucasNat 9061111 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9061111 - 1 = 2 * (3 * (3 * (5 * (83 * (1213))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_1213] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_9377647 : Nat.Prime 9377647 := by
  apply lucasNat 9377647 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9377647 - 1 = 2 * (3 * (1009 * (1549))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1009, Nat.prime_dvd_prime_iff_eq hq prime_1549] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_10009133 : Nat.Prime 10009133 := by
  apply lucasNat 10009133 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10009133 - 1 = 2 * (2 * (7 * (7 * (223 * (229))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_10226107 : Nat.Prime 10226107 := by
  apply lucasNat 10226107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10226107 - 1 = 2 * (3 * (3 * (11 * (51647)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_51647] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_10349303 : Nat.Prime 10349303 := by
  apply lucasNat 10349303 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10349303 - 1 = 2 * (41 * (126211)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_126211] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_13134439 : Nat.Prime 13134439 := by
  apply lucasNat 13134439 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13134439 - 1 = 2 * (3 * (3 * (17 * (42923)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_42923] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_13174723 : Nat.Prime 13174723 := by
  apply lucasNat 13174723 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13174723 - 1 = 2 * (3 * (3 * (11 * (11 * (23 * (263)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_263] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_13634801 : Nat.Prime 13634801 := by
  apply lucasNat 13634801 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13634801 - 1 = 2 * (2 * (2 * (2 * (5 * (5 * (89 * (383))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_15732481 : Nat.Prime 15732481 := by
  apply lucasNat 15732481 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15732481 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (17 * (241))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel

theorem prime_16392983 : Nat.Prime 16392983 := by
  apply lucasNat 16392983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16392983 - 1 = 2 * (8196491) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_8196491] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_16976153 : Nat.Prime 16976153 := by
  apply lucasNat 16976153 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16976153 - 1 = 2 * (2 * (2 * (79 * (26861)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_26861] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_17459201 : Nat.Prime 17459201 := by
  apply lucasNat 17459201 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17459201 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (5 * (11 * (31)))))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14
  all_goals subst q; decide +kernel

theorem prime_18630809 : Nat.Prime 18630809 := by
  apply lucasNat 18630809 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 18630809 - 1 = 2 * (2 * (2 * (7 * (443 * (751))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_443, Nat.prime_dvd_prime_iff_eq hq prime_751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_21691751 : Nat.Prime 21691751 := by
  apply lucasNat 21691751 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21691751 - 1 = 2 * (5 * (5 * (5 * (86767)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_86767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_22605071 : Nat.Prime 22605071 := by
  apply lucasNat 22605071 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22605071 - 1 = 2 * (5 * (17 * (132971))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_132971] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_22605091 : Nat.Prime 22605091 := by
  apply lucasNat 22605091 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22605091 - 1 = 2 * (3 * (5 * (23 * (181 * (181))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_27012329 : Nat.Prime 27012329 := by
  apply lucasNat 27012329 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 27012329 - 1 = 2 * (2 * (2 * (7 * (7 * (68909))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_68909] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_29826157 : Nat.Prime 29826157 := by
  apply lucasNat 29826157 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29826157 - 1 = 2 * (2 * (3 * (2485513))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2485513] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_30460721 : Nat.Prime 30460721 := by
  apply lucasNat 30460721 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30460721 - 1 = 2 * (2 * (2 * (2 * (5 * (349 * (1091)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_349, Nat.prime_dvd_prime_iff_eq hq prime_1091] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_30678283 : Nat.Prime 30678283 := by
  apply lucasNat 30678283 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30678283 - 1 = 2 * (3 * (3 * (31 * (54979)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_54979] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_32469209 : Nat.Prime 32469209 := by
  apply lucasNat 32469209 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32469209 - 1 = 2 * (2 * (2 * (383 * (10597)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_383, Nat.prime_dvd_prime_iff_eq hq prime_10597] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_34359673 : Nat.Prime 34359673 := by
  apply lucasNat 34359673 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 34359673 - 1 = 2 * (2 * (2 * (3 * (1163 * (1231))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1163, Nat.prime_dvd_prime_iff_eq hq prime_1231] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_35791331 : Nat.Prime 35791331 := by
  apply lucasNat 35791331 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 35791331 - 1 = 2 * (5 * (3579133)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3579133] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_36709117 : Nat.Prime 36709117 := by
  apply lucasNat 36709117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36709117 - 1 = 2 * (2 * (3 * (599 * (5107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_599, Nat.prime_dvd_prime_iff_eq hq prime_5107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_38347901 : Nat.Prime 38347901 := by
  apply lucasNat 38347901 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 38347901 - 1 = 2 * (2 * (5 * (5 * (23 * (16673))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_16673] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_42107447 : Nat.Prime 42107447 := by
  apply lucasNat 42107447 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 42107447 - 1 = 2 * (61 * (345143)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_345143] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_44322227 : Nat.Prime 44322227 := by
  apply lucasNat 44322227 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 44322227 - 1 = 2 * (13 * (37 * (46073))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_46073] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_57266123 : Nat.Prime 57266123 := by
  apply lucasNat 57266123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 57266123 - 1 = 2 * (4339 * (6599)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4339, Nat.prime_dvd_prime_iff_eq hq prime_6599] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_59652323 : Nat.Prime 59652323 := by
  apply lucasNat 59652323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59652323 - 1 = 2 * (4813 * (6197)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4813, Nat.prime_dvd_prime_iff_eq hq prime_6197] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_65075203 : Nat.Prime 65075203 := by
  apply lucasNat 65075203 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 65075203 - 1 = 2 * (3 * (3 * (53 * (68213)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_68213] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_68173993 : Nat.Prime 68173993 := by
  apply lucasNat 68173993 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 68173993 - 1 = 2 * (2 * (2 * (3 * (3 * (946861))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_946861] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_75350237 : Nat.Prime 75350237 := by
  apply lucasNat 75350237 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 75350237 - 1 = 2 * (2 * (13 * (29 * (29 * (1723))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_1723] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_76695803 : Nat.Prime 76695803 := by
  apply lucasNat 76695803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 76695803 - 1 = 2 * (38347901) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_38347901] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_79536311 : Nat.Prime 79536311 := by
  apply lucasNat 79536311 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 79536311 - 1 = 2 * (5 * (7 * (7 * (37 * (41 * (107)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_82595399 : Nat.Prime 82595399 := by
  apply lucasNat 82595399 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 82595399 - 1 = 2 * (59 * (699961)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_699961] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_92969819 : Nat.Prime 92969819 := by
  apply lucasNat 92969819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 92969819 - 1 = 2 * (23 * (2021083)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_2021083] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_102261127 : Nat.Prime 102261127 := by
  apply lucasNat 102261127 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 102261127 - 1 = 2 * (3 * (11 * (31 * (151 * (331))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_104755141 : Nat.Prime 104755141 := by
  apply lucasNat 104755141 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 104755141 - 1 = 2 * (2 * (3 * (3 * (3 * (5 * (7 * (7 * (37 * (107))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel

theorem prime_110127349 : Nat.Prime 110127349 := by
  apply lucasNat 110127349 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 110127349 - 1 = 2 * (2 * (3 * (3 * (599 * (5107))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_599, Nat.prime_dvd_prime_iff_eq hq prime_5107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_119304541 : Nat.Prime 119304541 := by
  apply lucasNat 119304541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 119304541 - 1 = 2 * (2 * (3 * (3 * (5 * (257 * (2579)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_257, Nat.prime_dvd_prime_iff_eq hq prime_2579] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_122713189 : Nat.Prime 122713189 := by
  apply lucasNat 122713189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 122713189 - 1 = 2 * (2 * (3 * (13 * (23 * (23 * (1487)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_1487] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_134217509 : Nat.Prime 134217509 := by
  apply lucasNat 134217509 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 134217509 - 1 = 2 * (2 * (73 * (459649))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_459649] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_138547121 : Nat.Prime 138547121 := by
  apply lucasNat 138547121 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 138547121 - 1 = 2 * (2 * (2 * (2 * (5 * (373 * (4643)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_373, Nat.prime_dvd_prime_iff_eq hq prime_4643] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_162453257 : Nat.Prime 162453257 := by
  apply lucasNat 162453257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 162453257 - 1 = 2 * (2 * (2 * (7 * (2900951)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2900951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_178956733 : Nat.Prime 178956733 := by
  apply lucasNat 178956733 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 178956733 - 1 = 2 * (2 * (3 * (67 * (103 * (2161))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_2161] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_214548871 : Nat.Prime 214548871 := by
  apply lucasNat 214548871 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 214548871 - 1 = 2 * (3 * (5 * (1823 * (3923)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1823, Nat.prime_dvd_prime_iff_eq hq prime_3923] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_252644797 : Nat.Prime 252644797 := by
  apply lucasNat 252644797 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 252644797 - 1 = 2 * (2 * (3 * (3 * (7017911)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7017911] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_268434979 : Nat.Prime 268434979 := by
  apply lucasNat 268434979 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 268434979 - 1 = 2 * (3 * (7 * (23 * (277883)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_277883] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_268435019 : Nat.Prime 268435019 := by
  apply lucasNat 268435019 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 268435019 - 1 = 2 * (134217509) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_134217509] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_286330897 : Nat.Prime 286330897 := by
  apply lucasNat 286330897 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 286330897 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (3 * (257 * (2579)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_257, Nat.prime_dvd_prime_iff_eq hq prime_2579] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_389630509 : Nat.Prime 389630509 := by
  apply lucasNat 389630509 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389630509 - 1 = 2 * (2 * (3 * (32469209))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_32469209] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_390451219 : Nat.Prime 390451219 := by
  apply lucasNat 390451219 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 390451219 - 1 = 2 * (3 * (65075203)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_65075203] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_429496499 : Nat.Prime 429496499 := by
  apply lucasNat 429496499 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 429496499 - 1 = 2 * (883 * (243203)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_883, Nat.prime_dvd_prime_iff_eq hq prime_243203] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_477217687 : Nat.Prime 477217687 := by
  apply lucasNat 477217687 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 477217687 - 1 = 2 * (3 * (11 * (7230571))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_7230571] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_536869891 : Nat.Prime 536869891 := by
  apply lucasNat 536869891 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 536869891 - 1 = 2 * (3 * (3 * (3 * (5 * (19 * (229 * (457))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_229, Nat.prime_dvd_prime_iff_eq hq prime_457] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_605444603 : Nat.Prime 605444603 := by
  apply lucasNat 605444603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 605444603 - 1 = 2 * (7 * (1657 * (26099))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1657, Nat.prime_dvd_prime_iff_eq hq prime_26099] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_715826603 : Nat.Prime 715826603 := by
  apply lucasNat 715826603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715826603 - 1 = 2 * (607 * (589643)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_607, Nat.prime_dvd_prime_iff_eq hq prime_589643] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_715826621 : Nat.Prime 715826621 := by
  apply lucasNat 715826621 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715826621 - 1 = 2 * (2 * (5 * (35791331))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_35791331] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_715826849 : Nat.Prime 715826849 := by
  apply lucasNat 715826849 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715826849 - 1 = 2 * (2 * (2 * (2 * (2 * (11 * (43 * (47293))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_47293] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_715826933 : Nat.Prime 715826933 := by
  apply lucasNat 715826933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715826933 - 1 = 2 * (2 * (178956733)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_178956733] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_715827059 : Nat.Prime 715827059 := by
  apply lucasNat 715827059 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715827059 - 1 = 2 * (17 * (59 * (79 * (4517)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_4517] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_715827239 : Nat.Prime 715827239 := by
  apply lucasNat 715827239 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715827239 - 1 = 2 * (7 * (3931 * (13007))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3931, Nat.prime_dvd_prime_iff_eq hq prime_13007] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_715827491 : Nat.Prime 715827491 := by
  apply lucasNat 715827491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715827491 - 1 = 2 * (5 * (7 * (10226107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_10226107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_858992317 : Nat.Prime 858992317 := by
  apply lucasNat 858992317 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 858992317 - 1 = 2 * (2 * (3 * (7 * (13 * (23 * (23 * (1487))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_1487] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_1073739917 : Nat.Prime 1073739917 := by
  apply lucasNat 1073739917 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1073739917 - 1 = 2 * (2 * (268434979)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_268434979] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1073740391 : Nat.Prime 1073740391 := by
  apply lucasNat 1073740391 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1073740391 - 1 = 2 * (5 * (41 * (2618879))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_2618879] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1073740571 : Nat.Prime 1073740571 := by
  apply lucasNat 1073740571 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1073740571 - 1 = 2 * (5 * (7 * (17 * (902303)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_902303] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1328598443 : Nat.Prime 1328598443 := by
  apply lucasNat 1328598443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1328598443 - 1 = 2 * (37 * (103 * (174311))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_174311] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1431653711 : Nat.Prime 1431653711 := by
  apply lucasNat 1431653711 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431653711 - 1 = 2 * (5 * (541 * (264631))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_541, Nat.prime_dvd_prime_iff_eq hq prime_264631] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1431655777 : Nat.Prime 1431655777 := by
  apply lucasNat 1431655777 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431655777 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (3 * (19 * (87211))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_87211] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel

theorem prime_1543048151 : Nat.Prime 1543048151 := by
  apply lucasNat 1543048151 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1543048151 - 1 = 2 * (5 * (5 * (7 * (23 * (103 * (1861)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_1861] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_3107295143 : Nat.Prime 3107295143 := by
  apply lucasNat 3107295143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3107295143 - 1 = 2 * (7 * (103 * (2154851))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_2154851] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_4294962299 : Nat.Prime 4294962299 := by
  apply lucasNat 4294962299 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294962299 - 1 = 2 * (11 * (41 * (61 * (78059)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_78059] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_4294964969 : Nat.Prime 4294964969 := by
  apply lucasNat 4294964969 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294964969 - 1 = 2 * (2 * (2 * (7 * (76695803)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_76695803] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_4294966661 : Nat.Prime 4294966661 := by
  apply lucasNat 4294966661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294966661 - 1 = 2 * (2 * (5 * (37 * (67 * (86627))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_86627] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_4294967291 : Nat.Prime 4294967291 := by
  apply lucasNat 4294967291 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294967291 - 1 = 2 * (5 * (19 * (22605091))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_22605091] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589918251 : Nat.Prime 8589918251 := by
  apply lucasNat 8589918251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918251 - 1 = 2 * (5 * (5 * (5 * (34359673)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_34359673] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589918257 : Nat.Prime 8589918257 := by
  apply lucasNat 8589918257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918257 - 1 = 2 * (2 * (2 * (2 * (536869891)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_536869891] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589918269 : Nat.Prime 8589918269 := by
  apply lucasNat 8589918269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918269 - 1 = 2 * (2 * (379 * (439 * (12907)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_379, Nat.prime_dvd_prime_iff_eq hq prime_439, Nat.prime_dvd_prime_iff_eq hq prime_12907] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589918277 : Nat.Prime 8589918277 := by
  apply lucasNat 8589918277 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918277 - 1 = 2 * (2 * (3 * (3 * (151 * (311 * (5081)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_311, Nat.prime_dvd_prime_iff_eq hq prime_5081] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589918283 : Nat.Prime 8589918283 := by
  apply lucasNat 8589918283 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918283 - 1 = 2 * (3 * (11 * (41 * (251 * (12647))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_12647] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589918329 : Nat.Prime 8589918329 := by
  apply lucasNat 8589918329 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918329 - 1 = 2 * (2 * (2 * (3917 * (274123)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3917, Nat.prime_dvd_prime_iff_eq hq prime_274123] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589918331 : Nat.Prime 8589918331 := by
  apply lucasNat 8589918331 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918331 - 1 = 2 * (3 * (3 * (5 * (7 * (23 * (307 * (1931))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_307, Nat.prime_dvd_prime_iff_eq hq prime_1931] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_8589918341 : Nat.Prime 8589918341 := by
  apply lucasNat 8589918341 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918341 - 1 = 2 * (2 * (5 * (31 * (47 * (294781))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_294781] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589918367 : Nat.Prime 8589918367 := by
  apply lucasNat 8589918367 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918367 - 1 = 2 * (3 * (3 * (477217687))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_477217687] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589918413 : Nat.Prime 8589918413 := by
  apply lucasNat 8589918413 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918413 - 1 = 2 * (2 * (6073 * (353611))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_6073, Nat.prime_dvd_prime_iff_eq hq prime_353611] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589918437 : Nat.Prime 8589918437 := by
  apply lucasNat 8589918437 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918437 - 1 = 2 * (2 * (11 * (29 * (271 * (24841))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_271, Nat.prime_dvd_prime_iff_eq hq prime_24841] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589918451 : Nat.Prime 8589918451 := by
  apply lucasNat 8589918451 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589918451 - 1 = 2 * (3 * (5 * (5 * (57266123)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_57266123] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589919109 : Nat.Prime 8589919109 := by
  apply lucasNat 8589919109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919109 - 1 = 2 * (2 * (27061 * (79357))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_27061, Nat.prime_dvd_prime_iff_eq hq prime_79357] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589919159 : Nat.Prime 8589919159 := by
  apply lucasNat 8589919159 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919159 - 1 = 2 * (3 * (3 * (3 * (23 * (6916199))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_6916199] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589919187 : Nat.Prime 8589919187 := by
  apply lucasNat 8589919187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919187 - 1 = 2 * (37 * (37 * (47 * (66751)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_66751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589919189 : Nat.Prime 8589919189 := by
  apply lucasNat 8589919189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919189 - 1 = 2 * (2 * (3 * (17 * (42107447)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_42107447] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589919199 : Nat.Prime 8589919199 := by
  apply lucasNat 8589919199 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919199 - 1 = 2 * (7 * (73 * (233 * (36073)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_233, Nat.prime_dvd_prime_iff_eq hq prime_36073] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589919237 : Nat.Prime 8589919237 := by
  apply lucasNat 8589919237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919237 - 1 = 2 * (2 * (3 * (715826603))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715826603] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589919241 : Nat.Prime 8589919241 := by
  apply lucasNat 8589919241 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919241 - 1 = 2 * (2 * (2 * (5 * (7 * (30678283))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_30678283] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589919253 : Nat.Prime 8589919253 := by
  apply lucasNat 8589919253 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919253 - 1 = 2 * (2 * (43 * (3947 * (12653)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_3947, Nat.prime_dvd_prime_iff_eq hq prime_12653] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589919279 : Nat.Prime 8589919279 := by
  apply lucasNat 8589919279 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919279 - 1 = 2 * (3 * (709 * (2019257))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_709, Nat.prime_dvd_prime_iff_eq hq prime_2019257] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589919321 : Nat.Prime 8589919321 := by
  apply lucasNat 8589919321 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919321 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (5 * (127 * (62627)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_127, Nat.prime_dvd_prime_iff_eq hq prime_62627] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_8589919337 : Nat.Prime 8589919337 := by
  apply lucasNat 8589919337 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919337 - 1 = 2 * (2 * (2 * (1073739917))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1073739917] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589919339 : Nat.Prime 8589919339 := by
  apply lucasNat 8589919339 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919339 - 1 = 2 * (3 * (3 * (7 * (11 * (13 * (43 * (11087))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_11087] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_8589919357 : Nat.Prime 8589919357 := by
  apply lucasNat 8589919357 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919357 - 1 = 2 * (2 * (3 * (3 * (1709 * (139619))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1709, Nat.prime_dvd_prime_iff_eq hq prime_139619] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589919369 : Nat.Prime 8589919369 := by
  apply lucasNat 8589919369 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919369 - 1 = 2 * (2 * (2 * (3 * (359 * (996973))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_359, Nat.prime_dvd_prime_iff_eq hq prime_996973] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589919391 : Nat.Prime 8589919391 := by
  apply lucasNat 8589919391 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919391 - 1 = 2 * (5 * (13 * (97 * (727 * (937))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_727, Nat.prime_dvd_prime_iff_eq hq prime_937] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589919397 : Nat.Prime 8589919397 := by
  apply lucasNat 8589919397 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919397 - 1 = 2 * (2 * (163 * (13174723))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_163, Nat.prime_dvd_prime_iff_eq hq prime_13174723] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589919423 : Nat.Prime 8589919423 := by
  apply lucasNat 8589919423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919423 - 1 = 2 * (3 * (7 * (7 * (29 * (1007497))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_1007497] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589919433 : Nat.Prime 8589919433 := by
  apply lucasNat 8589919433 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919433 - 1 = 2 * (2 * (2 * (409 * (1381 * (1901))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_409, Nat.prime_dvd_prime_iff_eq hq prime_1381, Nat.prime_dvd_prime_iff_eq hq prime_1901] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589919453 : Nat.Prime 8589919453 := by
  apply lucasNat 8589919453 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919453 - 1 = 2 * (2 * (3 * (715826621))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715826621] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589919463 : Nat.Prime 8589919463 := by
  apply lucasNat 8589919463 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589919463 - 1 = 2 * (25229 * (170239)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_25229, Nat.prime_dvd_prime_iff_eq hq prime_170239] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589920551 : Nat.Prime 8589920551 := by
  apply lucasNat 8589920551 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920551 - 1 = 2 * (3 * (5 * (5 * (137 * (167 * (2503)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_2503] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589920579 : Nat.Prime 8589920579 := by
  apply lucasNat 8589920579 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920579 - 1 = 2 * (41 * (3989 * (26261))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_3989, Nat.prime_dvd_prime_iff_eq hq prime_26261] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589920593 : Nat.Prime 8589920593 := by
  apply lucasNat 8589920593 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920593 - 1 = 2 * (2 * (2 * (2 * (3 * (11 * (37 * (439697))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_439697] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_8589920609 : Nat.Prime 8589920609 := by
  apply lucasNat 8589920609 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920609 - 1 = 2 * (2 * (2 * (2 * (2 * (268435019))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_268435019] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589920617 : Nat.Prime 8589920617 := by
  apply lucasNat 8589920617 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920617 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (17 * (2339303))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_2339303] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_8589920621 : Nat.Prime 8589920621 := by
  apply lucasNat 8589920621 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920621 - 1 = 2 * (2 * (5 * (227 * (443 * (4271))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_227, Nat.prime_dvd_prime_iff_eq hq prime_443, Nat.prime_dvd_prime_iff_eq hq prime_4271] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589920623 : Nat.Prime 8589920623 := by
  apply lucasNat 8589920623 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920623 - 1 = 2 * (3 * (53 * (27012329))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_27012329] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589920639 : Nat.Prime 8589920639 := by
  apply lucasNat 8589920639 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920639 - 1 = 2 * (13 * (1549 * (213287))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1549, Nat.prime_dvd_prime_iff_eq hq prime_213287] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589920641 : Nat.Prime 8589920641 := by
  apply lucasNat 8589920641 46 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920641 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (7 * (29 * (22039))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_22039] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel

theorem prime_8589920683 : Nat.Prime 8589920683 := by
  apply lucasNat 8589920683 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920683 - 1 = 2 * (3 * (7 * (331 * (433 * (1427))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_331, Nat.prime_dvd_prime_iff_eq hq prime_433, Nat.prime_dvd_prime_iff_eq hq prime_1427] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589920693 : Nat.Prime 8589920693 := by
  apply lucasNat 8589920693 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920693 - 1 = 2 * (2 * (61 * (151 * (233143)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_233143] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589920761 : Nat.Prime 8589920761 := by
  apply lucasNat 8589920761 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589920761 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (397 * (60103))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_397, Nat.prime_dvd_prime_iff_eq hq prime_60103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_8589921467 : Nat.Prime 8589921467 := by
  apply lucasNat 8589921467 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921467 - 1 = 2 * (7 * (17 * (239 * (151013)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_239, Nat.prime_dvd_prime_iff_eq hq prime_151013] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589921491 : Nat.Prime 8589921491 := by
  apply lucasNat 8589921491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921491 - 1 = 2 * (5 * (83 * (10349303))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_10349303] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589921493 : Nat.Prime 8589921493 := by
  apply lucasNat 8589921493 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921493 - 1 = 2 * (2 * (3 * (10301 * (69491)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_10301, Nat.prime_dvd_prime_iff_eq hq prime_69491] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589921497 : Nat.Prime 8589921497 := by
  apply lucasNat 8589921497 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921497 - 1 = 2 * (2 * (2 * (13 * (82595399)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_82595399] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589921503 : Nat.Prime 8589921503 := by
  apply lucasNat 8589921503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921503 - 1 = 2 * (31 * (138547121)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_138547121] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589921541 : Nat.Prime 8589921541 := by
  apply lucasNat 8589921541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921541 - 1 = 2 * (2 * (3 * (5 * (7057 * (20287))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7057, Nat.prime_dvd_prime_iff_eq hq prime_20287] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589921553 : Nat.Prime 8589921553 := by
  apply lucasNat 8589921553 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921553 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (167 * (357199))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_357199] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_8589921559 : Nat.Prime 8589921559 := by
  apply lucasNat 8589921559 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921559 - 1 = 2 * (3 * (1361 * (1051913))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1361, Nat.prime_dvd_prime_iff_eq hq prime_1051913] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589921563 : Nat.Prime 8589921563 := by
  apply lucasNat 8589921563 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921563 - 1 = 2 * (41 * (104755141)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_104755141] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589921577 : Nat.Prime 8589921577 := by
  apply lucasNat 8589921577 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921577 - 1 = 2 * (2 * (2 * (3 * (53 * (2273 * (2971)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_2273, Nat.prime_dvd_prime_iff_eq hq prime_2971] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589921589 : Nat.Prime 8589921589 := by
  apply lucasNat 8589921589 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921589 - 1 = 2 * (2 * (3 * (3 * (3 * (79536311))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79536311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589921643 : Nat.Prime 8589921643 := by
  apply lucasNat 8589921643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921643 - 1 = 2 * (3 * (3 * (3 * (23 * (827 * (8363)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_827, Nat.prime_dvd_prime_iff_eq hq prime_8363] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589921647 : Nat.Prime 8589921647 := by
  apply lucasNat 8589921647 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589921647 - 1 = 2 * (137 * (2029 * (15451))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_2029, Nat.prime_dvd_prime_iff_eq hq prime_15451] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589922189 : Nat.Prime 8589922189 := by
  apply lucasNat 8589922189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922189 - 1 = 2 * (2 * (3 * (715826849))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715826849] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589922199 : Nat.Prime 8589922199 := by
  apply lucasNat 8589922199 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922199 - 1 = 2 * (11 * (13 * (13 * (67 * (34483))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_34483] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589922213 : Nat.Prime 8589922213 := by
  apply lucasNat 8589922213 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922213 - 1 = 2 * (2 * (3 * (53 * (701 * (19267))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_701, Nat.prime_dvd_prime_iff_eq hq prime_19267] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589922223 : Nat.Prime 8589922223 := by
  apply lucasNat 8589922223 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922223 - 1 = 2 * (7 * (19861 * (30893))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19861, Nat.prime_dvd_prime_iff_eq hq prime_30893] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589922261 : Nat.Prime 8589922261 := by
  apply lucasNat 8589922261 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922261 - 1 = 2 * (2 * (3 * (5 * (541 * (264631))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_541, Nat.prime_dvd_prime_iff_eq hq prime_264631] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589922267 : Nat.Prime 8589922267 := by
  apply lucasNat 8589922267 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922267 - 1 = 2 * (3 * (1431653711)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431653711] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589922279 : Nat.Prime 8589922279 := by
  apply lucasNat 8589922279 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922279 - 1 = 2 * (3 * (7 * (61 * (139 * (24121))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_24121] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589922283 : Nat.Prime 8589922283 := by
  apply lucasNat 8589922283 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922283 - 1 = 2 * (17 * (13721 * (18413))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_13721, Nat.prime_dvd_prime_iff_eq hq prime_18413] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589922301 : Nat.Prime 8589922301 := by
  apply lucasNat 8589922301 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922301 - 1 = 2 * (2 * (5 * (5 * (41 * (97 * (21599)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_21599] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589922303 : Nat.Prime 8589922303 := by
  apply lucasNat 8589922303 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922303 - 1 = 2 * (3 * (13 * (2833 * (38873)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_2833, Nat.prime_dvd_prime_iff_eq hq prime_38873] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589922307 : Nat.Prime 8589922307 := by
  apply lucasNat 8589922307 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922307 - 1 = 2 * (7 * (19 * (131 * (246511)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_246511] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589922373 : Nat.Prime 8589922373 := by
  apply lucasNat 8589922373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922373 - 1 = 2 * (2 * (2393 * (897401))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2393, Nat.prime_dvd_prime_iff_eq hq prime_897401] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589922427 : Nat.Prime 8589922427 := by
  apply lucasNat 8589922427 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589922427 - 1 = 2 * (263 * (3083 * (5297))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_263, Nat.prime_dvd_prime_iff_eq hq prime_3083, Nat.prime_dvd_prime_iff_eq hq prime_5297] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589923093 : Nat.Prime 8589923093 := by
  apply lucasNat 8589923093 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923093 - 1 = 2 * (2 * (131 * (16392983))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_16392983] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589923099 : Nat.Prime 8589923099 := by
  apply lucasNat 8589923099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923099 - 1 = 2 * (17 * (252644797)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_252644797] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589923107 : Nat.Prime 8589923107 := by
  apply lucasNat 8589923107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923107 - 1 = 2 * (3 * (109 * (13134439))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_13134439] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589923119 : Nat.Prime 8589923119 := by
  apply lucasNat 8589923119 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923119 - 1 = 2 * (3 * (3 * (7 * (68173993)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_68173993] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589923129 : Nat.Prime 8589923129 := by
  apply lucasNat 8589923129 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923129 - 1 = 2 * (2 * (2 * (1073740391))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1073740391] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589923171 : Nat.Prime 8589923171 := by
  apply lucasNat 8589923171 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923171 - 1 = 2 * (5 * (858992317)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_858992317] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589923191 : Nat.Prime 8589923191 := by
  apply lucasNat 8589923191 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923191 - 1 = 2 * (3 * (3 * (5 * (419 * (227789))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_419, Nat.prime_dvd_prime_iff_eq hq prime_227789] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589923197 : Nat.Prime 8589923197 := by
  apply lucasNat 8589923197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923197 - 1 = 2 * (2 * (3 * (715826933))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715826933] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589923227 : Nat.Prime 8589923227 := by
  apply lucasNat 8589923227 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923227 - 1 = 2 * (3 * (3 * (1571 * (303767)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1571, Nat.prime_dvd_prime_iff_eq hq prime_303767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589923231 : Nat.Prime 8589923231 := by
  apply lucasNat 8589923231 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923231 - 1 = 2 * (5 * (7 * (122713189))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_122713189] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589923261 : Nat.Prime 8589923261 := by
  apply lucasNat 8589923261 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923261 - 1 = 2 * (2 * (5 * (113 * (1303 * (2917))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_113, Nat.prime_dvd_prime_iff_eq hq prime_1303, Nat.prime_dvd_prime_iff_eq hq prime_2917] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589923323 : Nat.Prime 8589923323 := by
  apply lucasNat 8589923323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589923323 - 1 = 2 * (3 * (47 * (30460721))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_30460721] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589924481 : Nat.Prime 8589924481 := by
  apply lucasNat 8589924481 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924481 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (761 * (5879)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_761, Nat.prime_dvd_prime_iff_eq hq prime_5879] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel

theorem prime_8589924559 : Nat.Prime 8589924559 := by
  apply lucasNat 8589924559 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924559 - 1 = 2 * (3 * (3 * (3 * (101 * (167 * (9431)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_9431] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589924569 : Nat.Prime 8589924569 := by
  apply lucasNat 8589924569 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924569 - 1 = 2 * (2 * (2 * (1073740571))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1073740571] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589924587 : Nat.Prime 8589924587 := by
  apply lucasNat 8589924587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924587 - 1 = 2 * (19 * (23 * (953 * (10313)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_953, Nat.prime_dvd_prime_iff_eq hq prime_10313] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589924589 : Nat.Prime 8589924589 := by
  apply lucasNat 8589924589 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924589 - 1 = 2 * (2 * (3 * (7 * (37 * (2763811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_2763811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589924593 : Nat.Prime 8589924593 := by
  apply lucasNat 8589924593 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924593 - 1 = 2 * (2 * (2 * (2 * (353 * (1520879))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_353, Nat.prime_dvd_prime_iff_eq hq prime_1520879] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589924599 : Nat.Prime 8589924599 := by
  apply lucasNat 8589924599 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924599 - 1 = 2 * (4294962299) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294962299] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_8589924631 : Nat.Prime 8589924631 := by
  apply lucasNat 8589924631 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924631 - 1 = 2 * (3 * (3 * (5 * (7 * (13634801))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13634801] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589924653 : Nat.Prime 8589924653 := by
  apply lucasNat 8589924653 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924653 - 1 = 2 * (2 * (229 * (9377647))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_229, Nat.prime_dvd_prime_iff_eq hq prime_9377647] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589924661 : Nat.Prime 8589924661 := by
  apply lucasNat 8589924661 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924661 - 1 = 2 * (2 * (3 * (5 * (137 * (1045003))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_1045003] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589924709 : Nat.Prime 8589924709 := by
  apply lucasNat 8589924709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589924709 - 1 = 2 * (2 * (3 * (715827059))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715827059] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589926791 : Nat.Prime 8589926791 := by
  apply lucasNat 8589926791 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926791 - 1 = 2 * (3 * (3 * (5 * (19 * (73 * (68813)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_68813] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589926801 : Nat.Prime 8589926801 := by
  apply lucasNat 8589926801 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926801 - 1 = 2 * (2 * (2 * (2 * (5 * (5 * (7 * (13 * (47 * (5021))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_5021] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel

theorem prime_8589926819 : Nat.Prime 8589926819 := by
  apply lucasNat 8589926819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926819 - 1 = 2 * (11 * (390451219)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_390451219] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589926827 : Nat.Prime 8589926827 := by
  apply lucasNat 8589926827 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926827 - 1 = 2 * (3 * (3 * (3 * (13 * (1319 * (9277)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1319, Nat.prime_dvd_prime_iff_eq hq prime_9277] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589926857 : Nat.Prime 8589926857 := by
  apply lucasNat 8589926857 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926857 - 1 = 2 * (2 * (2 * (3 * (7 * (3931 * (13007)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3931, Nat.prime_dvd_prime_iff_eq hq prime_13007] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589926861 : Nat.Prime 8589926861 := by
  apply lucasNat 8589926861 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926861 - 1 = 2 * (2 * (5 * (1097 * (391519)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1097, Nat.prime_dvd_prime_iff_eq hq prime_391519] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589926869 : Nat.Prime 8589926869 := by
  apply lucasNat 8589926869 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926869 - 1 = 2 * (2 * (3 * (715827239))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715827239] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589926893 : Nat.Prime 8589926893 := by
  apply lucasNat 8589926893 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926893 - 1 = 2 * (2 * (3 * (41 * (17459201)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_17459201] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589926903 : Nat.Prime 8589926903 := by
  apply lucasNat 8589926903 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926903 - 1 = 2 * (641 * (6700411)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_641, Nat.prime_dvd_prime_iff_eq hq prime_6700411] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589926911 : Nat.Prime 8589926911 := by
  apply lucasNat 8589926911 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926911 - 1 = 2 * (3 * (5 * (286330897))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_286330897] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589926953 : Nat.Prime 8589926953 := by
  apply lucasNat 8589926953 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926953 - 1 = 2 * (2 * (2 * (3 * (3 * (119304541))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_119304541] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589926981 : Nat.Prime 8589926981 := by
  apply lucasNat 8589926981 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589926981 - 1 = 2 * (2 * (5 * (19 * (22605071)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_22605071] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589927007 : Nat.Prime 8589927007 := by
  apply lucasNat 8589927007 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589927007 - 1 = 2 * (3 * (3 * (1783 * (267649)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1783, Nat.prime_dvd_prime_iff_eq hq prime_267649] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589927019 : Nat.Prime 8589927019 := by
  apply lucasNat 8589927019 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589927019 - 1 = 2 * (3 * (19 * (75350237))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_75350237] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589927023 : Nat.Prime 8589927023 := by
  apply lucasNat 8589927023 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589927023 - 1 = 2 * (67 * (131 * (489343))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_489343] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589927029 : Nat.Prime 8589927029 := by
  apply lucasNat 8589927029 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589927029 - 1 = 2 * (2 * (673 * (3190909))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_673, Nat.prime_dvd_prime_iff_eq hq prime_3190909] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589929857 : Nat.Prime 8589929857 := by
  apply lucasNat 8589929857 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929857 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (73 * (181 * (1693)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_181, Nat.prime_dvd_prime_iff_eq hq prime_1693] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel

theorem prime_8589929863 : Nat.Prime 8589929863 := by
  apply lucasNat 8589929863 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929863 - 1 = 2 * (3 * (29 * (5503 * (8971)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_5503, Nat.prime_dvd_prime_iff_eq hq prime_8971] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589929869 : Nat.Prime 8589929869 := by
  apply lucasNat 8589929869 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929869 - 1 = 2 * (2 * (3 * (3 * (13 * (19 * (966029)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_966029] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589929893 : Nat.Prime 8589929893 := by
  apply lucasNat 8589929893 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929893 - 1 = 2 * (2 * (3 * (715827491))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715827491] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589929939 : Nat.Prime 8589929939 := by
  apply lucasNat 8589929939 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929939 - 1 = 2 * (4294964969) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294964969] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_8589929941 : Nat.Prime 8589929941 := by
  apply lucasNat 8589929941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929941 - 1 = 2 * (2 * (3 * (3 * (5 * (769 * (62057)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_769, Nat.prime_dvd_prime_iff_eq hq prime_62057] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589929951 : Nat.Prime 8589929951 := by
  apply lucasNat 8589929951 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929951 - 1 = 2 * (5 * (5 * (7 * (53 * (331 * (1399)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_331, Nat.prime_dvd_prime_iff_eq hq prime_1399] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589929969 : Nat.Prime 8589929969 := by
  apply lucasNat 8589929969 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929969 - 1 = 2 * (2 * (2 * (2 * (23 * (3727 * (6263)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_3727, Nat.prime_dvd_prime_iff_eq hq prime_6263] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589929977 : Nat.Prime 8589929977 := by
  apply lucasNat 8589929977 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929977 - 1 = 2 * (2 * (2 * (3 * (3 * (5927 * (20129)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5927, Nat.prime_dvd_prime_iff_eq hq prime_20129] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589929981 : Nat.Prime 8589929981 := by
  apply lucasNat 8589929981 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589929981 - 1 = 2 * (2 * (5 * (429496499))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_429496499] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589930031 : Nat.Prime 8589930031 := by
  apply lucasNat 8589930031 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589930031 - 1 = 2 * (3 * (3 * (5 * (11 * (71 * (122207)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_122207] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589930061 : Nat.Prime 8589930061 := by
  apply lucasNat 8589930061 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589930061 - 1 = 2 * (2 * (3 * (5 * (23 * (97 * (64171)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_64171] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589930067 : Nat.Prime 8589930067 := by
  apply lucasNat 8589930067 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589930067 - 1 = 2 * (3 * (3 * (3 * (409 * (388931))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_409, Nat.prime_dvd_prime_iff_eq hq prime_388931] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589930071 : Nat.Prime 8589930071 := by
  apply lucasNat 8589930071 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589930071 - 1 = 2 * (5 * (239 * (3594113))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_239, Nat.prime_dvd_prime_iff_eq hq prime_3594113] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589930073 : Nat.Prime 8589930073 := by
  apply lucasNat 8589930073 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589930073 - 1 = 2 * (2 * (2 * (3 * (401 * (892553))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_401, Nat.prime_dvd_prime_iff_eq hq prime_892553] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589933217 : Nat.Prime 8589933217 := by
  apply lucasNat 8589933217 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933217 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (29826157))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29826157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_8589933223 : Nat.Prime 8589933223 := by
  apply lucasNat 8589933223 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933223 - 1 = 2 * (3 * (13 * (110127349))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_110127349] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589933229 : Nat.Prime 8589933229 := by
  apply lucasNat 8589933229 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933229 - 1 = 2 * (2 * (3 * (79 * (9061111)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_9061111] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589933241 : Nat.Prime 8589933241 := by
  apply lucasNat 8589933241 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933241 - 1 = 2 * (2 * (2 * (3 * (5 * (7 * (7 * (223 * (6551)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_6551] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_8589933271 : Nat.Prime 8589933271 := by
  apply lucasNat 8589933271 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933271 - 1 = 2 * (3 * (3 * (5 * (43 * (2219621))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_2219621] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589933311 : Nat.Prime 8589933311 := by
  apply lucasNat 8589933311 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933311 - 1 = 2 * (5 * (7 * (59 * (131 * (15877))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_15877] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589933323 : Nat.Prime 8589933323 := by
  apply lucasNat 8589933323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933323 - 1 = 2 * (4294966661) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294966661] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_8589933337 : Nat.Prime 8589933337 := by
  apply lucasNat 8589933337 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933337 - 1 = 2 * (2 * (2 * (3 * (2351 * (152239))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2351, Nat.prime_dvd_prime_iff_eq hq prime_152239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589933347 : Nat.Prime 8589933347 := by
  apply lucasNat 8589933347 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933347 - 1 = 2 * (4157 * (1033189)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4157, Nat.prime_dvd_prime_iff_eq hq prime_1033189] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589933353 : Nat.Prime 8589933353 := by
  apply lucasNat 8589933353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933353 - 1 = 2 * (2 * (2 * (7 * (11 * (13 * (13 * (109 * (757)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_757] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_8589933377 : Nat.Prime 8589933377 := by
  apply lucasNat 8589933377 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933377 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (151 * (373 * (2383)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_373, Nat.prime_dvd_prime_iff_eq hq prime_2383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_8589933379 : Nat.Prime 8589933379 := by
  apply lucasNat 8589933379 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933379 - 1 = 2 * (3 * (3 * (13 * (36709117)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_36709117] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589933397 : Nat.Prime 8589933397 := by
  apply lucasNat 8589933397 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933397 - 1 = 2 * (2 * (3 * (3 * (11 * (21691751))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_21691751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589933419 : Nat.Prime 8589933419 := by
  apply lucasNat 8589933419 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933419 - 1 = 2 * (11 * (23 * (16976153))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_16976153] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589934487 : Nat.Prime 8589934487 := by
  apply lucasNat 8589934487 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934487 - 1 = 2 * (7 * (991 * (619139))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_991, Nat.prime_dvd_prime_iff_eq hq prime_619139] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589934513 : Nat.Prime 8589934513 := by
  apply lucasNat 8589934513 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934513 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (59652323)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59652323] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589934543 : Nat.Prime 8589934543 := by
  apply lucasNat 8589934543 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934543 - 1 = 2 * (3 * (7 * (19 * (3121 * (3449))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_3121, Nat.prime_dvd_prime_iff_eq hq prime_3449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_8589934567 : Nat.Prime 8589934567 := by
  apply lucasNat 8589934567 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934567 - 1 = 2 * (3 * (3 * (389 * (1226783)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_389, Nat.prime_dvd_prime_iff_eq hq prime_1226783] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589934583 : Nat.Prime 8589934583 := by
  apply lucasNat 8589934583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934583 - 1 = 2 * (4294967291) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294967291] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_8589934609 : Nat.Prime 8589934609 := by
  apply lucasNat 8589934609 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934609 - 1 = 2 * (2 * (2 * (2 * (3 * (59 * (3033169)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_3033169] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589934621 : Nat.Prime 8589934621 := by
  apply lucasNat 8589934621 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934621 - 1 = 2 * (2 * (3 * (3 * (5 * (131 * (364289)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_364289] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589934627 : Nat.Prime 8589934627 := by
  apply lucasNat 8589934627 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934627 - 1 = 2 * (3 * (7 * (13 * (15732481)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_15732481] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589934631 : Nat.Prime 8589934631 := by
  apply lucasNat 8589934631 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934631 - 1 = 2 * (5 * (26053 * (32971))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_26053, Nat.prime_dvd_prime_iff_eq hq prime_32971] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_8589934651 : Nat.Prime 8589934651 := by
  apply lucasNat 8589934651 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934651 - 1 = 2 * (3 * (5 * (5 * (11 * (79 * (65899)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_65899] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589934663 : Nat.Prime 8589934663 := by
  apply lucasNat 8589934663 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934663 - 1 = 2 * (3 * (1431655777)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431655777] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8589934669 : Nat.Prime 8589934669 := by
  apply lucasNat 8589934669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934669 - 1 = 2 * (2 * (3 * (7 * (102261127)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_102261127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_8589934693 : Nat.Prime 8589934693 := by
  apply lucasNat 8589934693 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934693 - 1 = 2 * (2 * (3 * (3 * (17 * (457 * (30713)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_457, Nat.prime_dvd_prime_iff_eq hq prime_30713] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_8589934711 : Nat.Prime 8589934711 := by
  apply lucasNat 8589934711 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934711 - 1 = 2 * (3 * (3 * (3 * (5 * (7 * (7 * (649277))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_649277] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_10909654253 : Nat.Prime 10909654253 := by
  apply lucasNat 10909654253 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10909654253 - 1 = 2 * (2 * (7 * (389630509))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_389630509] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_15813252277 : Nat.Prime 15813252277 := by
  apply lucasNat 15813252277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15813252277 - 1 = 2 * (2 * (3 * (35423 * (37201)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_35423, Nat.prime_dvd_prime_iff_eq hq prime_37201] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_26814235699 : Nat.Prime 26814235699 := by
  apply lucasNat 26814235699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26814235699 - 1 = 2 * (3 * (3 * (491 * (3033971)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_491, Nat.prime_dvd_prime_iff_eq hq prime_3033971] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_182844270107 : Nat.Prime 182844270107 := by
  apply lucasNat 182844270107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 182844270107 - 1 = 2 * (151 * (605444603)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_605444603] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_743200733087 : Nat.Prime 743200733087 := by
  apply lucasNat 743200733087 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 743200733087 - 1 = 2 * (7 * (571 * (92969819))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_571, Nat.prime_dvd_prime_iff_eq hq prime_92969819] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_20146464742511 : Nat.Prime 20146464742511 := by
  apply lucasNat 20146464742511 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20146464742511 - 1 = 2 * (5 * (2999 * (12703 * (52883)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2999, Nat.prime_dvd_prime_iff_eq hq prime_12703, Nat.prime_dvd_prime_iff_eq hq prime_52883] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_376293507880207 : Nat.Prime 376293507880207 := by
  apply lucasNat 376293507880207 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 376293507880207 - 1 = 2 * (3 * (7 * (7 * (7 * (182844270107))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_182844270107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_12738853467409523 : Nat.Prime 12738853467409523 := by
  apply lucasNat 12738853467409523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12738853467409523 - 1 = 2 * (29 * (8191 * (26814235699))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_8191, Nat.prime_dvd_prime_iff_eq hq prime_26814235699] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_47619047485316627 : Nat.Prime 47619047485316627 := by
  apply lucasNat 47619047485316627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 47619047485316627 - 1 = 2 * (11 * (136879 * (15813252277))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_136879, Nat.prime_dvd_prime_iff_eq hq prime_15813252277] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_95238094970633309 : Nat.Prime 95238094970633309 := by
  apply lucasNat 95238094970633309 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 95238094970633309 - 1 = 2 * (2 * (149 * (8576947 * (18630809)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_8576947, Nat.prime_dvd_prime_iff_eq hq prime_18630809] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_199999999438330103 : Nat.Prime 199999999438330103 := by
  apply lucasNat 199999999438330103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199999999438330103 - 1 = 2 * (11 * (14221 * (14423 * (44322227)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_14221, Nat.prime_dvd_prime_iff_eq hq prime_14423, Nat.prime_dvd_prime_iff_eq hq prime_44322227] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3999999988766589007 : Nat.Prime 3999999988766589007 := by
  apply lucasNat 3999999988766589007 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766589007 - 1 = 2 * (3 * (33091 * (20146464742511))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_33091, Nat.prime_dvd_prime_iff_eq hq prime_20146464742511] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999988766590223 : Nat.Prime 3999999988766590223 := by
  apply lucasNat 3999999988766590223 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766590223 - 1 = 2 * (157 * (12738853467409523)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_12738853467409523] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_3999999988766593667 : Nat.Prime 3999999988766593667 := by
  apply lucasNat 3999999988766593667 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766593667 - 1 = 2 * (5077 * (296503 * (1328598443))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5077, Nat.prime_dvd_prime_iff_eq hq prime_296503, Nat.prime_dvd_prime_iff_eq hq prime_1328598443] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999988766596669 : Nat.Prime 3999999988766596669 := by
  apply lucasNat 3999999988766596669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766596669 - 1 = 2 * (2 * (3 * (7 * (47619047485316627)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_47619047485316627] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3999999988766598979 : Nat.Prime 3999999988766598979 := by
  apply lucasNat 3999999988766598979 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766598979 - 1 = 2 * (3 * (7 * (95238094970633309))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_95238094970633309] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999988766600411 : Nat.Prime 3999999988766600411 := by
  apply lucasNat 3999999988766600411 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600411 - 1 = 2 * (5 * (1063 * (376293507880207))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1063, Nat.prime_dvd_prime_iff_eq hq prime_376293507880207] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999988766601319 : Nat.Prime 3999999988766601319 := by
  apply lucasNat 3999999988766601319 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601319 - 1 = 2 * (3 * (214548871 * (3107295143))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_214548871, Nat.prime_dvd_prime_iff_eq hq prime_3107295143] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999988766602061 : Nat.Prime 3999999988766602061 := by
  apply lucasNat 3999999988766602061 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602061 - 1 = 2 * (2 * (5 * (199999999438330103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_199999999438330103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999988766602963 : Nat.Prime 3999999988766602963 := by
  apply lucasNat 3999999988766602963 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602963 - 1 = 2 * (3 * (3 * (3 * (3 * (33223 * (743200733087)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_33223, Nat.prime_dvd_prime_iff_eq hq prime_743200733087] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_3999999988766604197 : Nat.Prime 3999999988766604197 := by
  apply lucasNat 3999999988766604197 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604197 - 1 = 2 * (2 * (11 * (197 * (42299 * (10909654253))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_197, Nat.prime_dvd_prime_iff_eq hq prime_42299, Nat.prime_dvd_prime_iff_eq hq prime_10909654253] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_3999999988766604359 : Nat.Prime 3999999988766604359 := by
  apply lucasNat 3999999988766604359 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604359 - 1 = 2 * (41 * (53 * (103 * (5791 * (1543048151))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_5791, Nat.prime_dvd_prime_iff_eq hq prime_1543048151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_3999999988766605261 : Nat.Prime 3999999988766605261 := by
  apply lucasNat 3999999988766605261 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605261 - 1 = 2 * (2 * (3 * (5 * (41 * (10009133 * (162453257)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_10009133, Nat.prime_dvd_prime_iff_eq hq prime_162453257] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

end BinaryPilot

/- Owned component: BinaryPilot.lean -/
namespace BinaryPilot

def sourcePrimes_0 : List Nat := [8589921467, 8589921491, 8589921493, 8589921497, 8589921503, 8589921541, 8589921553, 8589921559, 8589921563, 8589921577, 8589921589, 8589921643, 8589921647]
theorem sourcePrimes_0_prime : ∀ p ∈ sourcePrimes_0, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_0, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  · subst p; exact prime_8589921467
  · subst p; exact prime_8589921491
  · subst p; exact prime_8589921493
  · subst p; exact prime_8589921497
  · subst p; exact prime_8589921503
  · subst p; exact prime_8589921541
  · subst p; exact prime_8589921553
  · subst p; exact prime_8589921559
  · subst p; exact prime_8589921563
  · subst p; exact prime_8589921577
  · subst p; exact prime_8589921589
  · subst p; exact prime_8589921643
  · subst p; exact prime_8589921647

theorem source_0_membership : ∀ j : Fin 128,
    Nat.testBit 830767498623048963777032631942643712 j.val = true → 8589921409 + 2*j.val ∈ sourcePrimes_0 := by
  decide +kernel

theorem source_0_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 830767498623048963777032631942643712 j = true → Nat.Prime (8589921409+2*j) := by
  intro j hj hb
  exact sourcePrimes_0_prime _ (source_0_membership ⟨j,hj⟩ hb)

def slice_0_0 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589921409
  sourceMask := 830767498623048963777032631942643712
  shift := 27
  anchor := 3999999988766602061
  shift_bound := by decide
  source_prime := source_0_sound
  anchor_prime := prime_3999999988766602061
  connection := by decide

def slice_1_0 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589921409
  sourceMask := 830767498623048963777032631942643712
  shift := 59
  anchor := 3999999988766602061
  shift_bound := by decide
  source_prime := source_0_sound
  anchor_prime := prime_3999999988766602061
  connection := by decide

def sourcePrimes_1 : List Nat := [8589929857, 8589929863, 8589929869, 8589929893, 8589929939, 8589929941, 8589929951, 8589929969, 8589929977, 8589929981, 8589930031, 8589930061, 8589930067, 8589930071, 8589930073]
theorem sourcePrimes_1_prime : ∀ p ∈ sourcePrimes_1, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_1, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14
  · subst p; exact prime_8589929857
  · subst p; exact prime_8589929863
  · subst p; exact prime_8589929869
  · subst p; exact prime_8589929893
  · subst p; exact prime_8589929939
  · subst p; exact prime_8589929941
  · subst p; exact prime_8589929951
  · subst p; exact prime_8589929969
  · subst p; exact prime_8589929977
  · subst p; exact prime_8589929981
  · subst p; exact prime_8589930031
  · subst p; exact prime_8589930061
  · subst p; exact prime_8589930067
  · subst p; exact prime_8589930071
  · subst p; exact prime_8589930073

theorem source_1_membership : ∀ j : Fin 128,
    Nat.testBit 532413406838367096113601339195465 j.val = true → 8589929857 + 2*j.val ∈ sourcePrimes_1 := by
  decide +kernel

theorem source_1_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 532413406838367096113601339195465 j = true → Nat.Prime (8589929857+2*j) := by
  intro j hj hb
  exact sourcePrimes_1_prime _ (source_1_membership ⟨j,hj⟩ hb)

def slice_0_1 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589929857
  sourceMask := 532413406838367096113601339195465
  shift := 0
  anchor := 3999999988766593667
  shift_bound := by decide
  source_prime := source_1_sound
  anchor_prime := prime_3999999988766593667
  connection := by decide

def slice_1_1 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589929857
  sourceMask := 532413406838367096113601339195465
  shift := 32
  anchor := 3999999988766593667
  shift_bound := by decide
  source_prime := source_1_sound
  anchor_prime := prime_3999999988766593667
  connection := by decide

def sourcePrimes_2 : List Nat := [8589924481, 8589924559, 8589924569, 8589924587, 8589924589, 8589924593, 8589924599, 8589924631, 8589924653, 8589924661, 8589924709]
theorem sourcePrimes_2_prime : ∀ p ∈ sourcePrimes_2, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_2, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  · subst p; exact prime_8589924481
  · subst p; exact prime_8589924559
  · subst p; exact prime_8589924569
  · subst p; exact prime_8589924587
  · subst p; exact prime_8589924589
  · subst p; exact prime_8589924593
  · subst p; exact prime_8589924599
  · subst p; exact prime_8589924631
  · subst p; exact prime_8589924653
  · subst p; exact prime_8589924661
  · subst p; exact prime_8589924709

theorem source_2_membership : ∀ j : Fin 128,
    Nat.testBit 20769188749488381862259570606342145 j.val = true → 8589924481 + 2*j.val ∈ sourcePrimes_2 := by
  decide +kernel

theorem source_2_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 20769188749488381862259570606342145 j = true → Nat.Prime (8589924481+2*j) := by
  intro j hj hb
  exact sourcePrimes_2_prime _ (source_2_membership ⟨j,hj⟩ hb)

def slice_0_2 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589924481
  sourceMask := 20769188749488381862259570606342145
  shift := 32
  anchor := 3999999988766598979
  shift_bound := by decide
  source_prime := source_2_sound
  anchor_prime := prime_3999999988766598979
  connection := by decide

def slice_1_2 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589924481
  sourceMask := 20769188749488381862259570606342145
  shift := 64
  anchor := 3999999988766598979
  shift_bound := by decide
  source_prime := source_2_sound
  anchor_prime := prime_3999999988766598979
  connection := by decide

def sourcePrimes_3 : List Nat := [8589920551, 8589920579, 8589920593, 8589920609, 8589920617, 8589920621, 8589920623, 8589920639, 8589920641, 8589920683, 8589920693, 8589920761]
theorem sourcePrimes_3_prime : ∀ p ∈ sourcePrimes_3, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_3, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  · subst p; exact prime_8589920551
  · subst p; exact prime_8589920579
  · subst p; exact prime_8589920593
  · subst p; exact prime_8589920609
  · subst p; exact prime_8589920617
  · subst p; exact prime_8589920621
  · subst p; exact prime_8589920623
  · subst p; exact prime_8589920639
  · subst p; exact prime_8589920641
  · subst p; exact prime_8589920683
  · subst p; exact prime_8589920693
  · subst p; exact prime_8589920761

theorem source_3_membership : ∀ j : Fin 128,
    Nat.testBit 21267647933835279659702906861774176256 j.val = true → 8589920513 + 2*j.val ∈ sourcePrimes_3 := by
  decide +kernel

theorem source_3_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 21267647933835279659702906861774176256 j = true → Nat.Prime (8589920513+2*j) := by
  intro j hj hb
  exact sourcePrimes_3_prime _ (source_3_membership ⟨j,hj⟩ hb)

def slice_0_3 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589920513
  sourceMask := 21267647933835279659702906861774176256
  shift := 24
  anchor := 3999999988766602963
  shift_bound := by decide
  source_prime := source_3_sound
  anchor_prime := prime_3999999988766602963
  connection := by decide

def slice_1_3 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589920513
  sourceMask := 21267647933835279659702906861774176256
  shift := 56
  anchor := 3999999988766602963
  shift_bound := by decide
  source_prime := source_3_sound
  anchor_prime := prime_3999999988766602963
  connection := by decide

def sourcePrimes_4 : List Nat := [8589933217, 8589933223, 8589933229, 8589933241, 8589933271, 8589933311, 8589933323, 8589933337, 8589933347, 8589933353, 8589933377, 8589933379, 8589933397, 8589933419]
theorem sourcePrimes_4_prime : ∀ p ∈ sourcePrimes_4, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_4, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13
  · subst p; exact prime_8589933217
  · subst p; exact prime_8589933223
  · subst p; exact prime_8589933229
  · subst p; exact prime_8589933241
  · subst p; exact prime_8589933271
  · subst p; exact prime_8589933311
  · subst p; exact prime_8589933323
  · subst p; exact prime_8589933337
  · subst p; exact prime_8589933347
  · subst p; exact prime_8589933353
  · subst p; exact prime_8589933377
  · subst p; exact prime_8589933379
  · subst p; exact prime_8589933397
  · subst p; exact prime_8589933419

theorem source_4_membership : ∀ j : Fin 128,
    Nat.testBit 166234866817853455723664883566837760 j.val = true → 8589933185 + 2*j.val ∈ sourcePrimes_4 := by
  decide +kernel

theorem source_4_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 166234866817853455723664883566837760 j = true → Nat.Prime (8589933185+2*j) := by
  intro j hj hb
  exact sourcePrimes_4_prime _ (source_4_membership ⟨j,hj⟩ hb)

def slice_0_4 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589933185
  sourceMask := 166234866817853455723664883566837760
  shift := 58
  anchor := 3999999988766590223
  shift_bound := by decide
  source_prime := source_4_sound
  anchor_prime := prime_3999999988766590223
  connection := by decide

def slice_1_4 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589933185
  sourceMask := 166234866817853455723664883566837760
  shift := 90
  anchor := 3999999988766590223
  shift_bound := by decide
  source_prime := source_4_sound
  anchor_prime := prime_3999999988766590223
  connection := by decide

def sourcePrimes_5 : List Nat := [8589934487, 8589934513, 8589934543, 8589934567, 8589934583, 8589934609, 8589934621, 8589934627, 8589934631, 8589934651, 8589934663, 8589934669, 8589934693, 8589934711]
theorem sourcePrimes_5_prime : ∀ p ∈ sourcePrimes_5, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_5, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13
  · subst p; exact prime_8589934487
  · subst p; exact prime_8589934513
  · subst p; exact prime_8589934543
  · subst p; exact prime_8589934567
  · subst p; exact prime_8589934583
  · subst p; exact prime_8589934609
  · subst p; exact prime_8589934621
  · subst p; exact prime_8589934627
  · subst p; exact prime_8589934631
  · subst p; exact prime_8589934651
  · subst p; exact prime_8589934663
  · subst p; exact prime_8589934669
  · subst p; exact prime_8589934693
  · subst p; exact prime_8589934711

theorem source_5_membership : ∀ j : Fin 128,
    Nat.testBit 10654598868057083847656173322492708864 j.val = true → 8589934465 + 2*j.val ∈ sourcePrimes_5 := by
  decide +kernel

theorem source_5_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 10654598868057083847656173322492708864 j = true → Nat.Prime (8589934465+2*j) := by
  intro j hj hb
  exact sourcePrimes_5_prime _ (source_5_membership ⟨j,hj⟩ hb)

def slice_0_5 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589934465
  sourceMask := 10654598868057083847656173322492708864
  shift := 26
  anchor := 3999999988766589007
  shift_bound := by decide
  source_prime := source_5_sound
  anchor_prime := prime_3999999988766589007
  connection := by decide

def slice_1_5 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589934465
  sourceMask := 10654598868057083847656173322492708864
  shift := 58
  anchor := 3999999988766589007
  shift_bound := by decide
  source_prime := source_5_sound
  anchor_prime := prime_3999999988766589007
  connection := by decide

def sourcePrimes_6 : List Nat := [8589922189, 8589922199, 8589922213, 8589922223, 8589922261, 8589922267, 8589922279, 8589922283, 8589922301, 8589922303, 8589922307, 8589922373, 8589922427]
theorem sourcePrimes_6_prime : ∀ p ∈ sourcePrimes_6, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_6, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  · subst p; exact prime_8589922189
  · subst p; exact prime_8589922199
  · subst p; exact prime_8589922213
  · subst p; exact prime_8589922223
  · subst p; exact prime_8589922261
  · subst p; exact prime_8589922267
  · subst p; exact prime_8589922279
  · subst p; exact prime_8589922283
  · subst p; exact prime_8589922301
  · subst p; exact prime_8589922303
  · subst p; exact prime_8589922307
  · subst p; exact prime_8589922373
  · subst p; exact prime_8589922427

theorem source_6_membership : ∀ j : Fin 128,
    Nat.testBit 42535296182029958040719021087343773760 j.val = true → 8589922177 + 2*j.val ∈ sourcePrimes_6 := by
  decide +kernel

theorem source_6_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 42535296182029958040719021087343773760 j = true → Nat.Prime (8589922177+2*j) := by
  intro j hj hb
  exact sourcePrimes_6_prime _ (source_6_membership ⟨j,hj⟩ hb)

def slice_0_6 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589922177
  sourceMask := 42535296182029958040719021087343773760
  shift := 14
  anchor := 3999999988766601319
  shift_bound := by decide
  source_prime := source_6_sound
  anchor_prime := prime_3999999988766601319
  connection := by decide

def slice_1_6 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589922177
  sourceMask := 42535296182029958040719021087343773760
  shift := 46
  anchor := 3999999988766601319
  shift_bound := by decide
  source_prime := source_6_sound
  anchor_prime := prime_3999999988766601319
  connection := by decide

def sourcePrimes_7 : List Nat := [8589919237, 8589919241, 8589919253, 8589919279, 8589919321, 8589919337, 8589919339, 8589919357, 8589919369, 8589919391, 8589919397, 8589919423, 8589919433, 8589919453, 8589919463]
theorem sourcePrimes_7_prime : ∀ p ∈ sourcePrimes_7, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_7, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14
  · subst p; exact prime_8589919237
  · subst p; exact prime_8589919241
  · subst p; exact prime_8589919253
  · subst p; exact prime_8589919279
  · subst p; exact prime_8589919321
  · subst p; exact prime_8589919337
  · subst p; exact prime_8589919339
  · subst p; exact prime_8589919357
  · subst p; exact prime_8589919369
  · subst p; exact prime_8589919391
  · subst p; exact prime_8589919397
  · subst p; exact prime_8589919423
  · subst p; exact prime_8589919433
  · subst p; exact prime_8589919453
  · subst p; exact prime_8589919463

theorem source_7_membership : ∀ j : Fin 128,
    Nat.testBit 42837756353034279258332308334183444 j.val = true → 8589919233 + 2*j.val ∈ sourcePrimes_7 := by
  decide +kernel

theorem source_7_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 42837756353034279258332308334183444 j = true → Nat.Prime (8589919233+2*j) := by
  intro j hj hb
  exact sourcePrimes_7_prime _ (source_7_membership ⟨j,hj⟩ hb)

def slice_0_7 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589919233
  sourceMask := 42837756353034279258332308334183444
  shift := 47
  anchor := 3999999988766604197
  shift_bound := by decide
  source_prime := source_7_sound
  anchor_prime := prime_3999999988766604197
  connection := by decide

def slice_1_7 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589919233
  sourceMask := 42837756353034279258332308334183444
  shift := 79
  anchor := 3999999988766604197
  shift_bound := by decide
  source_prime := source_7_sound
  anchor_prime := prime_3999999988766604197
  connection := by decide

def sourcePrimes_8 : List Nat := [8589918251, 8589918257, 8589918269, 8589918277, 8589918283, 8589918329, 8589918331, 8589918341, 8589918367, 8589918413, 8589918437, 8589918451]
theorem sourcePrimes_8_prime : ∀ p ∈ sourcePrimes_8, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_8, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  · subst p; exact prime_8589918251
  · subst p; exact prime_8589918257
  · subst p; exact prime_8589918269
  · subst p; exact prime_8589918277
  · subst p; exact prime_8589918283
  · subst p; exact prime_8589918329
  · subst p; exact prime_8589918331
  · subst p; exact prime_8589918341
  · subst p; exact prime_8589918367
  · subst p; exact prime_8589918413
  · subst p; exact prime_8589918437
  · subst p; exact prime_8589918451

theorem source_8_membership : ∀ j : Fin 128,
    Nat.testBit 2679230249606976509394890371647930368 j.val = true → 8589918209 + 2*j.val ∈ sourcePrimes_8 := by
  decide +kernel

theorem source_8_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 2679230249606976509394890371647930368 j = true → Nat.Prime (8589918209+2*j) := by
  intro j hj hb
  exact sourcePrimes_8_prime _ (source_8_membership ⟨j,hj⟩ hb)

def slice_0_8 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589918209
  sourceMask := 2679230249606976509394890371647930368
  shift := 27
  anchor := 3999999988766605261
  shift_bound := by decide
  source_prime := source_8_sound
  anchor_prime := prime_3999999988766605261
  connection := by decide

def slice_1_8 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589918209
  sourceMask := 2679230249606976509394890371647930368
  shift := 59
  anchor := 3999999988766605261
  shift_bound := by decide
  source_prime := source_8_sound
  anchor_prime := prime_3999999988766605261
  connection := by decide

def sourcePrimes_9 : List Nat := [8589919109, 8589919159, 8589919187, 8589919189, 8589919199, 8589919237, 8589919241, 8589919253, 8589919279, 8589919321, 8589919337, 8589919339, 8589919357]
theorem sourcePrimes_9_prime : ∀ p ∈ sourcePrimes_9, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_9, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  · subst p; exact prime_8589919109
  · subst p; exact prime_8589919159
  · subst p; exact prime_8589919187
  · subst p; exact prime_8589919189
  · subst p; exact prime_8589919199
  · subst p; exact prime_8589919237
  · subst p; exact prime_8589919241
  · subst p; exact prime_8589919253
  · subst p; exact prime_8589919279
  · subst p; exact prime_8589919321
  · subst p; exact prime_8589919337
  · subst p; exact prime_8589919339
  · subst p; exact prime_8589919357

theorem source_9_membership : ∀ j : Fin 128,
    Nat.testBit 85320146498152707782051531659591811076 j.val = true → 8589919105 + 2*j.val ∈ sourcePrimes_9 := by
  decide +kernel

theorem source_9_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 85320146498152707782051531659591811076 j = true → Nat.Prime (8589919105+2*j) := by
  intro j hj hb
  exact sourcePrimes_9_prime _ (source_9_membership ⟨j,hj⟩ hb)

def slice_0_9 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589919105
  sourceMask := 85320146498152707782051531659591811076
  shift := 30
  anchor := 3999999988766604359
  shift_bound := by decide
  source_prime := source_9_sound
  anchor_prime := prime_3999999988766604359
  connection := by decide

def slice_1_9 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589919105
  sourceMask := 85320146498152707782051531659591811076
  shift := 62
  anchor := 3999999988766604359
  shift_bound := by decide
  source_prime := source_9_sound
  anchor_prime := prime_3999999988766604359
  connection := by decide

def sourcePrimes_10 : List Nat := [8589923093, 8589923099, 8589923107, 8589923119, 8589923129, 8589923171, 8589923191, 8589923197, 8589923227, 8589923231, 8589923261, 8589923323]
theorem sourcePrimes_10_prime : ∀ p ∈ sourcePrimes_10, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_10, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  · subst p; exact prime_8589923093
  · subst p; exact prime_8589923099
  · subst p; exact prime_8589923107
  · subst p; exact prime_8589923119
  · subst p; exact prime_8589923129
  · subst p; exact prime_8589923171
  · subst p; exact prime_8589923191
  · subst p; exact prime_8589923197
  · subst p; exact prime_8589923227
  · subst p; exact prime_8589923231
  · subst p; exact prime_8589923261
  · subst p; exact prime_8589923323

theorem source_10_membership : ∀ j : Fin 128,
    Nat.testBit 42535295884925104145313879191552402432 j.val = true → 8589923073 + 2*j.val ∈ sourcePrimes_10 := by
  decide +kernel

theorem source_10_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 42535295884925104145313879191552402432 j = true → Nat.Prime (8589923073+2*j) := by
  intro j hj hb
  exact sourcePrimes_10_prime _ (source_10_membership ⟨j,hj⟩ hb)

def slice_0_10 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589923073
  sourceMask := 42535295884925104145313879191552402432
  shift := 20
  anchor := 3999999988766600411
  shift_bound := by decide
  source_prime := source_10_sound
  anchor_prime := prime_3999999988766600411
  connection := by decide

def slice_1_10 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589923073
  sourceMask := 42535295884925104145313879191552402432
  shift := 52
  anchor := 3999999988766600411
  shift_bound := by decide
  source_prime := source_10_sound
  anchor_prime := prime_3999999988766600411
  connection := by decide

def sourcePrimes_11 : List Nat := [8589926791, 8589926801, 8589926819, 8589926827, 8589926857, 8589926861, 8589926869, 8589926893, 8589926903, 8589926911, 8589926953, 8589926981, 8589927007, 8589927019, 8589927023, 8589927029]
theorem sourcePrimes_11_prime : ∀ p ∈ sourcePrimes_11, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_11, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14 | h15
  · subst p; exact prime_8589926791
  · subst p; exact prime_8589926801
  · subst p; exact prime_8589926819
  · subst p; exact prime_8589926827
  · subst p; exact prime_8589926857
  · subst p; exact prime_8589926861
  · subst p; exact prime_8589926869
  · subst p; exact prime_8589926893
  · subst p; exact prime_8589926903
  · subst p; exact prime_8589926911
  · subst p; exact prime_8589926953
  · subst p; exact prime_8589926981
  · subst p; exact prime_8589927007
  · subst p; exact prime_8589927019
  · subst p; exact prime_8589927023
  · subst p; exact prime_8589927029

theorem source_11_membership : ∀ j : Fin 128,
    Nat.testBit 6150275945866496205983409272246108424 j.val = true → 8589926785 + 2*j.val ∈ sourcePrimes_11 := by
  decide +kernel

theorem source_11_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 6150275945866496205983409272246108424 j = true → Nat.Prime (8589926785+2*j) := by
  intro j hj hb
  exact sourcePrimes_11_prime _ (source_11_membership ⟨j,hj⟩ hb)

def slice_0_11 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589926785
  sourceMask := 6150275945866496205983409272246108424
  shift := 35
  anchor := 3999999988766596669
  shift_bound := by decide
  source_prime := source_11_sound
  anchor_prime := prime_3999999988766596669
  connection := by decide

def slice_1_11 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589926785
  sourceMask := 6150275945866496205983409272246108424
  shift := 67
  anchor := 3999999988766596669
  shift_bound := by decide
  source_prime := source_11_sound
  anchor_prime := prime_3999999988766596669
  connection := by decide

def slices_0 : List (SliceCertificate 3999999997356523524 32) :=
  [slice_0_0, slice_0_1, slice_0_2, slice_0_3, slice_0_4, slice_0_5, slice_0_6, slice_0_7, slice_0_8, slice_0_9, slice_0_10, slice_0_11]
theorem tile_0_coverage : unionMasks (slices_0.map sliceMask) = 2^32-1 := rfl

theorem tile_0 : ∀ t : Nat, t < 32 →
    ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ 3999999997356523524+2*t=p+q :=
  certified_tile slices_0 tile_0_coverage

def slices_1 : List (SliceCertificate 3999999997356523588 32) :=
  [slice_1_0, slice_1_1, slice_1_2, slice_1_3, slice_1_4, slice_1_5, slice_1_6, slice_1_7, slice_1_8, slice_1_9, slice_1_10, slice_1_11]
theorem tile_1_coverage : unionMasks (slices_1.map sliceMask) = 2^32-1 := rfl

theorem tile_1 : ∀ t : Nat, t < 32 →
    ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ 3999999997356523588+2*t=p+q :=
  certified_tile slices_1 tile_1_coverage

theorem binary_interval : ∀ n : Nat, 3999999997356523524 ≤ n → n ≤ 3999999997356523650 →
    Even n → ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ n = p+q := by
  intro n hlo hhi heven
  obtain ⟨k, hk⟩ := heven
  by_cases hmid : n < 3999999997356523588
  · have ht : (n-3999999997356523524)/2 < 32 := by omega
    have hn : n = 3999999997356523524+2*((n-3999999997356523524)/2) := by omega
    rw [hn]; exact tile_0 _ ht
  · have ht : (n-3999999997356523588)/2 < 32 := by omega
    have hn : n = 3999999997356523588+2*((n-3999999997356523588)/2) := by omega
    rw [hn]; exact tile_1 _ ht

end BinaryPilot
