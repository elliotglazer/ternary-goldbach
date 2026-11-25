module

public import Table
public import Mathlib.Data.Nat.ModEq

@[expose] public section

namespace SmallGoldbach
open PrimeCoverage WideGoldbach

theorem splitAnd {x y : Bool} (h : (x && y) = true) : x = true ∧ y = true := by
  simpa only [Bool.and_eq_true] using h

/-- Decode fixed-width unsigned offsets, starting with the least significant digit. -/
def unpack : Nat → Nat → List Nat
  | 0, _ => []
  | k+1, code => code % 65536 :: unpack k (code >>> 16)

private theorem marks_member {ss : List Nat} {s : Nat} (h : s ∈ ss) :
    (marks ss).testBit s = true := by
  induction ss with
  | nil => simp at h
  | cons a rest ih =>
    rw [marks, Nat.testBit_or, Bool.or_eq_true]
    rcases List.mem_cons.mp h with rfl | hm
    · left
      simp [Nat.testBit_shiftLeft]
    · exact Or.inr (ih hm)

/-- Translate a shared set of source primes once for each anchor offset. -/
def translates (bits : Nat) : List Nat → Nat
  | [] => 0
  | s :: ss => (bits <<< s) ||| translates bits ss

private theorem translates_witness (bits : Nat) (ss : List Nat) (j : Nat)
    (h : (translates bits ss).testBit j = true) :
    ∃ s ∈ ss, s ≤ j ∧ bits.testBit (j-s) = true := by
  induction ss with
  | nil => simp [translates] at h
  | cons s rest ih =>
    rw [translates, Nat.testBit_or, Bool.or_eq_true] at h
    rcases h with h | h
    · rw [Nat.testBit_shiftLeft, Bool.and_eq_true, decide_eq_true_eq] at h
      exact ⟨s, List.mem_cons_self, h.1, h.2⟩
    · obtain ⟨u, hu, hj⟩ := ih h
      exact ⟨u, List.mem_cons_of_mem _ hu, hj⟩

/-- The source and anchor numbers are both odd. Column zero denotes their base sum. -/
private theorem tile {bits a skip width : Nat} {ss : List Nat}
    (hs : PrimeBitmap 3 bits) (ha : ∀ s ∈ ss, (a+2*s).Prime)
    (hc : ((translates bits ss >>> skip) &&& (2^width-1)) = 2^width-1) :
    ∀ j < width, BinaryGoldbach (3+a+2*skip+2*j) := by
  intro j hj
  have ht := congrArg (fun v : Nat => v.testBit j) hc
  rw [Nat.testBit_and, Nat.testBit_two_pow_sub_one] at ht
  simp only [hj, decide_true, Bool.and_true, Nat.testBit_shiftRight] at ht
  obtain ⟨s, hmem, hle, hp⟩ := translates_witness _ _ _ ht
  exact ⟨3+2*(skip+j-s), a+2*s, hs _ hp, ha s hmem, by omega⟩

/-- A producer supplies the width, number of offsets, packed offsets, and a modular inverse. -/
structure Row where
  width : Nat
  count : Nat
  code : Nat
  inv : Nat

def skipAt (halo origin : Nat) := min halo ((origin-6)/2)
def baseAt (halo origin : Nat) := origin-3-2*skipAt halo origin

def checkRow (bits fac d halo origin : Nat) (r : Row) : Bool :=
  let ss := unpack r.count r.code
  let a := baseAt halo origin
  let ps := entries a ss
  let primeCheck := if a = 3 then ss.all (fun s => bits.testBit s) else
    ps.all (fun p => decide (1 < p ∧ p < (d+1)^2)) &&
    decide (fac * r.inv % ps.prod = 1 % ps.prod)
  primeCheck && decide (((translates bits ss >>> skipAt halo origin) &&& (2^r.width-1)) = 2^r.width-1)

private theorem row_sound {bits fac d halo origin : Nat} (r : Row)
    (hs : PrimeBitmap 3 bits) (hf : fac = d.factorial) (ho : 6 ≤ origin)
    (he : origin % 2 = 0) (hc : checkRow bits fac d halo origin r = true) :
    ∀ n, origin ≤ n → n < origin+2*r.width → n % 2 = 0 → BinaryGoldbach n := by
  let ss := unpack r.count r.code
  let a := baseAt halo origin
  have ha : ∀ s ∈ ss, (a+2*s).Prime := by
    have hp := (splitAnd hc).1
    change (if a = 3 then ss.all (fun s => bits.testBit s) else _) = true at hp
    split at hp
    · rename_i h
      intro s hm
      rw [h]
      exact hs s (List.all_eq_true.mp hp s hm)
    · obtain ⟨hb, hi⟩ := splitAnd hp
      have hg := Nat.coprime_of_mul_modEq_one r.inv (a := fac) (n := (entries a ss).prod)
        (of_decide_eq_true hi)
      have ht := table_chunk a d ss hb (by simpa only [hf] using hg.symm)
      exact fun s hm => ht s (marks_member hm)
  have ht := tile (width := r.width) (skip := skipAt halo origin) hs ha (of_decide_eq_true (splitAnd hc).2)
  have hskip : skipAt halo origin ≤ (origin-6)/2 := Nat.min_le_right _ _
  have eq : 3+a+2*skipAt halo origin = origin := by dsimp [a, baseAt]; omega
  rw [eq] at ht
  exact binaryGoldbach_interval _ _ he ht

def span : List Row → Nat
  | [] => 0
  | r :: rs => r.width + span rs

def checkRows (bits fac d halo : Nat) : Nat → List Row → Bool
  | _, [] => true
  | origin, r :: rs =>
    checkRow bits fac d halo origin r && checkRows bits fac d halo (origin+2*r.width) rs

theorem rows_sound {bits fac d halo : Nat} (hs : PrimeBitmap 3 bits) (hf : fac = d.factorial)
    (rs : List Row) (origin : Nat) (ho : 6 ≤ origin) (he : origin % 2 = 0)
    (hc : checkRows bits fac d halo origin rs = true) :
    ∀ n, origin ≤ n → n < origin+2*span rs → n % 2 = 0 → BinaryGoldbach n := by
  induction rs generalizing origin with
  | nil =>
    intro n hlo hhi
    simp [span] at hhi
    omega
  | cons r rs ih =>
    obtain ⟨hr, hrest⟩ := splitAnd hc
    intro n hlo hhi hn
    simp only [span] at hhi
    by_cases h : n < origin+2*r.width
    · exact row_sound r hs hf ho he hr n hlo h hn
    · exact ih _ (by omega) (by omega) hrest n (by omega) (by omega) hn

theorem prefix_of_rows {bits fac d halo bound : Nat} (hs : PrimeBitmap 3 bits)
    (hf : fac = d.factorial) (rs : List Row) (hc : checkRows bits fac d halo 6 rs = true)
    (hwidth : bound < 6+2*span rs) :
    ∀ n : Nat, Even n → 4 ≤ n → n ≤ bound → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hbound
  obtain ⟨k, hk⟩ := he
  by_cases h : n = 4
  · exact ⟨2, 2, Nat.prime_two, Nat.prime_two, by omega⟩
  · exact rows_sound hs hf rs 6 (by decide) (by decide) hc n (by omega) (by omega) (by omega)

end SmallGoldbach
