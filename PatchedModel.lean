module

public import ArcDisjoint
public import ArcTranslation

@[expose] public section


open Real MeasureTheory Finset TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

def localModel (N q b : ℕ) (x : ℝ) : ℂ :=
  if q=1 ∧ radius N 1 < x then principalWave N 1 (x-1)
  else principalWave N q (x-(b:ℝ)/q)

def patchedModel (N : ℕ) (x : ℝ) : ℂ :=
  ∑ q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊, ∑ b ∈ arcNumerators q,
    (arcAtom N q b).indicator (localModel N q b) x

theorem patched_on_atom {N : ℕ} (hn : 2*10^19 ≤ N) {q b : ℕ}
    (hq : q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb : b ∈ arcNumerators q)
    {x : ℝ} (hx : x ∈ arcAtom N q b) : patchedModel N x = localModel N q b x := by
  classical
  have hr : (2:ℝ)*10^19 ≤ N := by exact_mod_cast hn
  have vanish {r a : ℕ} (hr' : r ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (ha : a ∈ arcNumerators r)
      (hd : (q,b) ≠ (r,a)) : (arcAtom N r a).indicator (localModel N r a) x=0 := by
    exact Set.indicator_of_notMem (fun h => Set.disjoint_left.mp (indexed_atoms_disjoint hr hq hb hr' ha hd) hx h) _
  unfold patchedModel
  rw [sum_eq_single_of_mem q hq (fun r hr' hne => sum_eq_zero (fun a ha => vanish hr' ha
    (fun he => hne (congrArg Prod.fst he).symm)))]
  rw [sum_eq_single_of_mem b hb (fun a ha hne => vanish hq ha (fun he => hne (congrArg Prod.snd he).symm)),
    Set.indicator_of_mem hx]

private theorem measure_atom (N : ℝ) (q b : ℕ) : MeasurableSet (arcAtom N q b) := by
  unfold arcAtom; split
  · exact measurableSet_Icc.union measurableSet_Icc
  · exact measurableSet_Icc

/-- Integrate a function over the major set by summing the indexed atoms. -/
theorem integral_major_atoms {N : ℕ} (hn : 2*10^19 ≤ N) {F : ℝ → ℂ}
    (hi : ∀ q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊, ∀ b ∈ arcNumerators q,
      IntegrableOn F (Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b) volume) :
    (∫ x in Set.Ioc (0:ℝ) 1 \ minorArcs N, F x) =
      ∑ q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊, ∑ b ∈ arcNumerators q,
        ∫ x in Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b, F x := by
  classical
  have hr : (2:ℝ)*10^19 ≤ N := by exact_mod_cast hn
  let A := fun q b => Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b
  have hm (q b : ℕ) : MeasurableSet (A q b) := measurableSet_Ioc.inter (measure_atom _ _ _)
  have hd {q r b a : ℕ} (hq : q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb : b ∈ arcNumerators q)
      (hr' : r ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (ha : a ∈ arcNumerators r) (hne : (q,b) ≠ (r,a)) :
      Disjoint (A q b) (A r a) :=
    (indexed_atoms_disjoint hr hq hb hr' ha hne).mono Set.inter_subset_right Set.inter_subset_right
  rw [major_eq_atoms hr]
  change (∫ x in ⋃ q ∈ _, ⋃ b ∈ arcNumerators q, A q b, F x) = _
  rw [integral_biUnion_finset]
  · apply sum_congr rfl; intro q hq
    apply integral_biUnion_finset
    · exact fun b _ => hm q b
    · intro b hb a ha hne
      exact hd hq hb hq ha (fun e => hne (congrArg Prod.snd e))
    · exact hi q hq
  · exact fun q _ => (arcNumerators q).measurableSet_biUnion (fun b _ => hm q b)
  · intro q hq r hr' hne
    apply Set.disjoint_left.mpr
    intro x hx hy
    obtain ⟨b,hb⟩ := Set.mem_iUnion.mp hx
    obtain ⟨hb,hx⟩ := Set.mem_iUnion.mp hb
    obtain ⟨a,ha⟩ := Set.mem_iUnion.mp hy
    obtain ⟨ha,hy⟩ := Set.mem_iUnion.mp ha
    exact Set.disjoint_left.mp (hd hq hb hr' ha (fun e => hne (congrArg Prod.fst e))) hx hy
  · exact fun q hq => integrableOn_finset_iUnion.mpr (hi q hq)

#print axioms integral_major_atoms
end GoldbachEnergy
