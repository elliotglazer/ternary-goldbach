module

public import ArcMeasure

@[expose] public section


open Real Set Finset MeasureTheory
noncomputable section
namespace GoldbachEnergy

def reducedCentre (q b : ℕ) (hq : 0 < q) (hb : q.Coprime b) : ℚ :=
  ⟨(b:ℤ),q,hq.ne',by simpa using hb.symm⟩

private theorem real_centre (q b : ℕ) (hq : 0<q) (hb : q.Coprime b) :
    ((reducedCentre q b hq hb : ℚ):ℝ) = (b:ℝ)/q := by
  rw [Rat.cast_def]; simp [reducedCentre]

theorem major_eq_atoms {N : ℝ} (hn : 2*10^19 ≤ N) :
    Set.Ioc (0:ℝ) 1 \ minorArcs N =
      ⋃ q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊, ⋃ b ∈ arcNumerators q, Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b := by
  ext x
  constructor
  · intro hx
    obtain ⟨q,hq⟩ := mem_iUnion.mp (major_in_atoms hn hx)
    obtain ⟨hq,hidx⟩ := mem_iUnion.mp hq
    obtain ⟨b,hb⟩ := mem_iUnion.mp hidx
    obtain ⟨hb,ha⟩ := mem_iUnion.mp hb
    exact mem_iUnion.mpr ⟨q,mem_iUnion.mpr ⟨hq,mem_iUnion.mpr ⟨b,mem_iUnion.mpr ⟨hb,hx.1,ha⟩⟩⟩⟩
  · intro hx
    obtain ⟨q,hq⟩ := mem_iUnion.mp hx
    obtain ⟨hq,hidx⟩ := mem_iUnion.mp hq
    obtain ⟨b,hb⟩ := mem_iUnion.mp hidx
    obtain ⟨hb,hx,ha⟩ := mem_iUnion.mp hb
    have hlim : (q:ℝ) ≤ modulusCutoff N := (Nat.le_floor_iff (by unfold modulusCutoff; positivity)).mp (Finset.mem_Icc.mp hq).2
    have hq0 : 0<q := (Finset.mem_Icc.mp hq).1
    have hred := (mem_filter.mp hb).2
    have take (r : ℚ) (hr : (r.den:ℝ)≤ modulusCutoff N) (hwin : x ∈ window N r) : x ∈ centralArcs N :=
      mem_iUnion.mpr ⟨⟨r,hr⟩,hwin⟩
    refine ⟨hx,fun hm => hm.2 ?_⟩
    by_cases h : q=1
    · subst q; rw [arcAtom,if_pos rfl] at ha
      have hR := radius_nonneg (le_trans (by norm_num) hn : 1≤N) 1
      rcases ha with ha|ha
      · apply take 0 (by simpa using hlim)
        change x ∈ Set.Icc ((0:ℚ)-radius N (0:ℚ).den) ((0:ℚ)+radius N (0:ℚ).den)
        simp only [Rat.cast_zero,Rat.den_zero,zero_sub,zero_add,Set.mem_Icc]
        exact ⟨by linarith [ha.1],ha.2⟩
      · apply take 1 (by simpa using hlim)
        change x ∈ Set.Icc ((1:ℚ)-radius N (1:ℚ).den) ((1:ℚ)+radius N (1:ℚ).den)
        simp only [Rat.cast_one,Rat.den_one,Set.mem_Icc]
        exact ⟨ha.1,by linarith [ha.2]⟩
    · apply take (reducedCentre q b hq0 hred) hlim
      change x ∈ Set.Icc (_-radius N q) (_+radius N q)
      rw [real_centre]
      simpa only [arcAtom,if_neg h] using ha

#print axioms major_eq_atoms
end GoldbachEnergy
