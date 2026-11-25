module

public import ArcUnion

@[expose] public section


open Real Set Finset
noncomputable section
namespace GoldbachEnergy

/-- Parts of wrapped endpoint atoms belong to one of the rational windows 0 or 1.
For every other atom the rational window is its unique reduced fraction. -/
private theorem atom_witness {N x : ℝ} (hn : 2*10^19 ≤ N) {q b : ℕ}
    (hq : q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb : b ∈ arcNumerators q)
    (hx : x ∈ arcAtom N q b) :
    ∃ r : ℚ, r.den=q ∧ (r.num.natAbs % q)=b ∧ x ∈ window N r := by
  have hp : 0<q := (Finset.mem_Icc.mp hq).1
  obtain ⟨hbr,hc⟩ := mem_filter.mp hb
  have hl := mem_range.mp hbr
  have hR := radius_nonneg (le_trans (by norm_num) hn : 1≤N) q
  by_cases h : q=1
  · subst q
    have he : b=0 := by omega
    subst b; rw [arcAtom,if_pos rfl] at hx
    rcases hx with h|h
    · refine ⟨0,by decide,by decide,?_⟩
      change x ∈ Set.Icc ((0:ℚ)-radius N (0:ℚ).den) ((0:ℚ)+radius N (0:ℚ).den)
      simp only [Rat.cast_zero,Rat.den_zero,zero_sub,zero_add,Set.mem_Icc]
      exact ⟨by linarith [h.1],h.2⟩
    · refine ⟨1,by decide,by decide,?_⟩
      change x ∈ Set.Icc ((1:ℚ)-radius N (1:ℚ).den) ((1:ℚ)+radius N (1:ℚ).den)
      simp only [Rat.cast_one,Rat.den_one,Set.mem_Icc]
      exact ⟨h.1,by linarith [h.2]⟩
  · refine ⟨reducedCentre q b hp hc,rfl,?_,?_⟩
    · simpa [reducedCentre] using Nat.mod_eq_of_lt hl
    · simpa only [window,reducedCentre,Rat.cast_def,Int.cast_natCast,arcAtom,if_neg h] using hx

theorem indexed_atoms_disjoint {N : ℝ} (hn : 2*10^19 ≤ N) {q q' b b' : ℕ}
    (hq : q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb : b ∈ arcNumerators q)
    (hq' : q' ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb' : b' ∈ arcNumerators q')
    (hne : (q,b) ≠ (q',b')) : Disjoint (arcAtom N q b) (arcAtom N q' b') := by
  apply Set.disjoint_left.mpr
  intro x ha ha'
  obtain ⟨r,hr,hb1,hx⟩ := atom_witness hn hq hb ha
  obtain ⟨s,hs,hb2,hy⟩ := atom_witness hn hq' hb' ha'
  have hrs : r ≠ s := by
    rintro rfl; apply hne; subst q; subst q'; rw [← hb1,← hb2]
  have hQ : 0 ≤ modulusCutoff N := by unfold modulusCutoff; positivity
  refine Set.disjoint_left.mp (disjoint_central_windows_from_two_e19 hn hrs ?_ ?_) hx hy
  · rw [hr]; exact (Nat.le_floor_iff hQ).mp (Finset.mem_Icc.mp hq).2
  · rw [hs]; exact (Nat.le_floor_iff hQ).mp (Finset.mem_Icc.mp hq').2

#print axioms indexed_atoms_disjoint
end GoldbachEnergy
