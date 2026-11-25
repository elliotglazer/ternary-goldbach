module

public import PatchedModel
public import AtomIntegral
public import MajorComparison

@[expose] public section


open Real MeasureTheory Finset TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

private def modelCube (N q b : ℕ) (x : ℝ) := localModel N q b x ^ 3 * e (-(N*x))
private def patchedCube (N : ℕ) (x : ℝ) := patchedModel N x ^ 3 * e (-(N*x))

private theorem measurable_atom' (N : ℝ) (q b : ℕ) : MeasurableSet (arcAtom N q b) := by
  unfold arcAtom; split
  · exact measurableSet_Icc.union measurableSet_Icc
  · exact measurableSet_Icc

private theorem integrable_modelCube {N : ℕ} (hn : 0<N) (q b : ℕ) {u v : ℝ} :
    IntegrableOn (modelCube N q b) (Set.Ioc u v) volume := by
  classical
  let s := {x : ℝ | q=1 ∧ radius N 1 < x}
  have hs : MeasurableSet s := by
    by_cases h : q=1
    · rw [show s = Set.Ioi (radius N 1) by ext x; simp only [s,Set.mem_ofPred_eq,h,true_and,Set.mem_Ioi]]
      exact measurableSet_Ioi
    · simp [s,h]
  have h : modelCube N q b = s.piecewise (translatedCube N 1 1) (translatedCube N q ((b:ℝ)/q)) := by
    funext x; by_cases hx : x∈s <;> simp [modelCube,localModel,translatedCube,s,Set.piecewise] at hx ⊢
  rw [h]
  exact Integrable.piecewise hs ((continuous_translatedCube hn 1 1).integrableOn_Ioc.integrableOn)
    ((continuous_translatedCube hn q _).integrableOn_Ioc.integrableOn)

private theorem model_atom_integral {N : ℕ} (hn : 2*10^19 ≤ N) {q b : ℕ}
    (hq : q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb : b ∈ arcNumerators q) :
    (∫ x in Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b, modelCube N q b x) =
    e (-(N*((b:ℝ)/q)))* ∫ x in Set.Ioc (-radius N q) (radius N q), localCube N q x := by
  have hr : (2:ℝ)*10^19 ≤ N := by exact_mod_cast hn
  have hn0 : 0<N := by omega
  have hR := radius_nonneg (le_trans (by norm_num) hr : (1:ℝ)≤N) q
  by_cases h : q=1
  · subst q
    have hb0 : b < 1 := mem_range.mp (mem_filter.mp hb).1
    have : b=0 := by omega
    subst b
    simp only [Nat.cast_zero,zero_div,mul_zero,neg_zero,e_zero,one_mul,endpoint_atom_period hr]
    let R := radius N 1
    have hsmall : R < 1/2 := radius_one_small hr
    have hdis : Disjoint (Set.Ioc 0 R) (Set.Icc (1-R) 1) := by
      exact Set.disjoint_left.mpr fun x hx hy => by linarith [hx.2,hy.1]
    rw [setIntegral_union hdis measurableSet_Icc (integrable_modelCube hn0 1 0)
      ((integrableOn_Icc_iff_integrableOn_Ioc (by finiteness)).mpr (integrable_modelCube hn0 1 0)),integral_Icc_eq_integral_Ioc]
    convert endpoint_halves hR hn0 using 1
    congr 1
    · apply setIntegral_congr_fun measurableSet_Ioc; intro x hx
      have he : ¬radius N 1 < x := not_lt.mpr hx.2
      simp [modelCube,localModel,translatedCube,he]
    · apply setIntegral_congr_fun measurableSet_Ioc; intro x hx
      have hh : radius N 1 < x := by dsimp [R] at hsmall; linarith [hx.1]
      simp [modelCube,localModel,translatedCube,hh]
  · rw [interior_atom_period hr hq hb h,arcAtom,if_neg h,integral_Icc_eq_integral_Ioc]
    simp only [modelCube,localModel,h,false_and,if_false]
    simpa only [← sub_eq_add_neg,translatedCube] using
      (translated_integral (lo := -radius N q) (hi := radius N q) (by linarith) N q ((b:ℝ)/q))

private theorem patched_atom {N : ℕ} (hn : 2*10^19 ≤ N) {q b : ℕ}
    (hq : q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb : b ∈ arcNumerators q) :
    Set.EqOn (patchedCube N) (modelCube N q b) (Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b) := by
  intro x hx; simp only [patchedCube,modelCube,patched_on_atom hn hq hb hx.2]

private theorem patched_atom_integrable {N : ℕ} (hn : 2*10^19 ≤ N) {q b : ℕ}
    (hq : q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb : b ∈ arcNumerators q) :
    IntegrableOn (patchedCube N) (Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b) volume :=
  ((integrable_modelCube (by omega : 0<N) q b).mono_set Set.inter_subset_left).congr_fun
    (patched_atom hn hq hb).symm (measurableSet_Ioc.inter (measurable_atom' _ _ _))

theorem patched_model_identity {N : ℕ} (hn : 2*10^19 ≤ N) :
    (∫ x in Set.Ioc (0:ℝ) 1 \ minorArcs N, (patchedModel N x)^3*e (-(N*x))) = restrictedModel N := by
  classical
  change (∫ x in _, patchedCube N x) = _
  rw [integral_major_atoms hn (fun _ hq _ hb => patched_atom_integrable hn hq hb)]
  unfold restrictedModel
  apply sum_congr rfl; intro q hq
  unfold centrePhase; rw [sum_mul]
  have he : arcNumerators q = (range q).filter (fun b => Nat.Coprime b q) := by
    unfold arcNumerators; ext b; simp [Nat.coprime_comm]
  rw [← he]
  apply sum_congr rfl; intro b hb
  rw [setIntegral_congr_fun (measurableSet_Ioc.inter (measurable_atom' _ _ _)) (patched_atom hn hq hb)]
  exact model_atom_integral hn hq hb

theorem major_of_local_errors {N : ℕ} (hn : 2*10^19 ≤ N)
    (he : ∀ q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊, ∀ b ∈ arcNumerators q,
      ∀ x ∈ Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b, ‖wave N x-localModel N q b x‖ ≤ 0.001*N/Real.log N) :
    (restrictedModel N).re - 0.0032*(N:ℝ)^2 ≤
      (∫ x in Set.Ioc (0:ℝ) 1 \ minorArcs N, integrand N x).re := by
  have hr : (2:ℝ)*10^19 ≤ N := by exact_mod_cast hn
  apply major_from_pointwise hn _ _ _ (patched_model_identity hn)
  · intro x hx
    rw [major_eq_atoms hr] at hx
    simp only [Set.mem_iUnion] at hx
    obtain ⟨q,hq,b,hb,hx⟩ := hx
    rw [patched_on_atom hn hq hb hx.2]
    exact he q hq b hb x hx
  · rw [major_eq_atoms hr]
    apply integrableOn_finset_iUnion.mpr; intro q hq
    exact integrableOn_finset_iUnion.mpr fun b hb => patched_atom_integrable hn hq hb

#print axioms patched_model_identity
#print axioms major_of_local_errors
end GoldbachEnergy
