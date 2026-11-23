import PrefixJoin
namespace SmallGoldbach.LcmExperiment
open PrimeCoverage WideGoldbach
def support (d m : Nat) : Bool :=
  (List.range d).all fun j => decide (j+1 ∣ m)

theorem support_coprime {d m x : Nat} (hc : support d m = true)
    (hx : Nat.Coprime x m) : Nat.Coprime x d.factorial := by
  have hall : ∀ j < d, j+1 ∣ m := by
    intro j hj
    exact of_decide_eq_true (List.all_eq_true.mp hc j (List.mem_range.mpr hj))
  have aux : ∀ k, k ≤ d → Nat.Coprime x k.factorial := by
    intro k
    induction k with
    | zero => simp
    | succ k ih =>
      intro hk
      rw [Nat.factorial_succ, Nat.coprime_mul_iff_right]
      exact ⟨Nat.Coprime.of_dvd_right (hall k (by omega)) hx, ih (by omega)⟩
  exact aux d (Nat.le_refl _)

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

private theorem row_sound {bits fac d halo origin : Nat} (r : Row)
    (hs : PrimeBitmap 3 bits) (hf : support d fac = true) (ho : 6 ≤ origin)
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
      have ht := table_chunk a d ss hb (support_coprime hf hg.symm)
      exact fun s hm => ht s (marks_member hm)
  have ht := tile (width := r.width) (skip := skipAt halo origin) hs ha (of_decide_eq_true (splitAnd hc).2)
  have hskip : skipAt halo origin ≤ (origin-6)/2 := Nat.min_le_right _ _
  have eq : 3+a+2*skipAt halo origin = origin := by dsimp [a, baseAt]; omega
  rw [eq] at ht
  exact binaryGoldbach_interval _ _ he ht

theorem rows_sound {bits fac d halo : Nat} (hs : PrimeBitmap 3 bits) (hf : support d fac = true)
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

theorem checked_interval {bits fac d halo lo hi : Nat} (hs : PrimeBitmap 3 bits)
    (hf : support d fac = true) (rs : List Row) (ho : 6 ≤ lo) (he : lo % 2 = 0)
    (hc : checkRows bits fac d halo lo rs = true) (hl : hi ≤ lo+2*span rs) :
    Covered lo hi := by
  intro n hn hh hp
  exact rows_sound hs hf rs lo ho he hc n hn (Nat.lt_of_lt_of_le hh hl) hp


end SmallGoldbach.LcmExperiment
