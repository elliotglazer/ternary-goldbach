module

public import ArcCenters
public import MajorEnergy

@[expose] public section


open Real Set Finset MeasureTheory
noncomputable section
namespace GoldbachEnergy

def arcNumerators (q : ℕ) := (range q).filter (fun b => q.Coprime b)

def arcAtom (N : ℝ) (q b : ℕ) : Set ℝ :=
  if q=1 then Icc (0:ℝ) (radius N 1) ∪ Icc (1-radius N 1) 1
  else Icc ((b:ℝ)/q-radius N q) ((b:ℝ)/q+radius N q)

theorem major_in_atoms {N : ℝ} (hn : (2*10^19) ≤ N) :
    Set.Ioc (0:ℝ) 1 \ minorArcs N ⊆
      ⋃ q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊, ⋃ b ∈ arcNumerators q, arcAtom N q b := by
  intro α hα
  have hh : α ∈ centralArcs N := by
    by_contra h; exact hα.2 ⟨hα.1,h⟩
  obtain ⟨⟨r,hr⟩,hx⟩ := mem_iUnion.mp hh
  have hxu : α ∈ Set.Icc (0:ℝ) 1 := ⟨hα.1.1.le,hα.1.2⟩
  have hc := centre_in_unit hn hr hxu hx
  have hq : r.den ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊ := Finset.mem_Icc.mpr ⟨r.pos,Nat.le_floor hr⟩
  refine mem_iUnion.mpr ⟨r.den,mem_iUnion.mpr ⟨hq,?_⟩⟩
  have hn0 := Rat.num_nonneg.mpr hc.1
  have hcoef : ((r.num.natAbs:ℕ):ℝ) = r.num := by
    have h := congrArg (fun a : ℤ => (a:ℝ)) (Int.natAbs_of_nonneg hn0)
    simpa only [Int.cast_natCast] using h
  have hfrac : (r:ℝ) = (r.num.natAbs:ℝ)/r.den := by rw [Rat.cast_def,hcoef]
  by_cases hd : r.den = 1
  · refine mem_iUnion.mpr ⟨0,mem_iUnion.mpr ⟨by simp [arcNumerators,hd],?_⟩⟩
    simp only [arcAtom,hd,if_true]
    have hnum : r.num.natAbs ≤ 1 := by
      have h' : (r:ℝ)≤1 := by exact_mod_cast hc.2
      rw [hfrac,hd,Nat.cast_one,div_one] at h'; exact_mod_cast h'
    have hv : r.num.natAbs = 0 ∨ r.num.natAbs = 1 := by omega
    obtain hh|hh := hv
    · left; refine ⟨hxu.1,?_⟩; simpa [hd,hfrac,hh] using hx.2
    · right; refine ⟨?_,hxu.2⟩; simpa [hd,hfrac,hh] using hx.1
  · have hr1 : r<1 := lt_of_le_of_ne hc.2 (fun e => hd (by simp [e]))
    have hbound : r.num.natAbs < r.den := by
      have h' : (r:ℝ)<1 := by exact_mod_cast hr1
      rw [hfrac,div_lt_iff₀ (by exact_mod_cast r.pos),one_mul] at h'
      exact_mod_cast h'
    refine mem_iUnion.mpr ⟨r.num.natAbs,mem_iUnion.mpr ⟨mem_filter.mpr ⟨mem_range.mpr hbound,r.reduced.symm⟩,?_⟩⟩
    simpa only [arcAtom,if_neg hd,← hfrac] using hx

theorem major_length {N : ℝ} (hn : (2*10^19) ≤ N) :
    volume.real (Set.Ioc (0:ℝ) 1 \ minorArcs N) ≤ 4.4*(Real.log N)^3/N := by
  let Q := ⌊modulusCutoff N⌋₊
  let Iq := Finset.Icc 1 Q
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hR := radius_nonneg (le_trans (by norm_num) hn : 1≤N)
  have hfin (q b : ℕ) : volume (arcAtom N q b) < ⊤ := by
    unfold arcAtom; split
    · exact measure_union_lt_top measure_Icc_lt_top measure_Icc_lt_top
    · exact measure_Icc_lt_top
  have hlen (q b : ℕ) : volume.real (arcAtom N q b) ≤ 2*radius N q := by
    unfold arcAtom; split
    · rename_i h; subst q
      apply (measureReal_union_le _ _).trans
      rw [Real.volume_real_Icc_of_le (hR _),Real.volume_real_Icc_of_le (by linarith [hR 1])]
      linarith
    · rw [Real.volume_real_Icc_of_le (by linarith [hR q])]; linarith
  have heach (q : ℕ) (hq : q ∈ Iq) : volume.real (⋃ b ∈ arcNumerators q, arcAtom N q b) ≤ 4*Real.log N/N := by
    apply (measureReal_biUnion_finset_le _ _).trans
    apply (sum_le_sum (fun b _ => hlen q b)).trans_eq
    rw [sum_const,nsmul_eq_mul,show (arcNumerators q).card=q.totient from rfl]
    have hf : (q.totient:ℝ)≠0 := by exact_mod_cast (Nat.totient_pos.mpr (Finset.mem_Icc.mp hq).1).ne'
    unfold radius; field_simp; ring
  apply (measureReal_mono (major_in_atoms hn) (by
    apply ne_of_lt; apply measure_biUnion_lt_top Iq.finite_toSet; intro q _
    exact measure_biUnion_lt_top (arcNumerators q).finite_toSet (fun b _ => hfin q b))).trans
  apply (measureReal_biUnion_finset_le _ _).trans
  apply (sum_le_sum heach).trans
  rw [sum_const,nsmul_eq_mul]
  have hQ : (Q:ℝ) ≤ 1.1*(Real.log N)^2 := Nat.floor_le (by unfold modulusCutoff; positivity)
  have hL := Real.log_pos (show 1<N by linarith)
  simp only [Iq,Nat.card_Icc,Nat.add_sub_cancel]
  calc _ ≤ (1.1*(Real.log N)^2)*(4*Real.log N/N) := mul_le_mul_of_nonneg_right hQ (by positivity)
       _ = _ := by ring

#print axioms major_length
end GoldbachEnergy
