module

public import ArcUnion
public import ArcTranslation

@[expose] public section


open Real MeasureTheory Finset TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

theorem continuous_translatedCube {N : ℕ} (hn : 0<N) (q : ℕ) (a : ℝ) :
    Continuous (translatedCube N q a) := by
  have hp : Continuous (principalWave N q) := by
    unfold principalWave
    apply Continuous.div continuous_const
    · fun_prop
    · intro x h
      have hr := congrArg Complex.re h
      simp [Nat.ne_of_gt hn] at hr
  unfold translatedCube
  exact ((hp.comp (continuous_id.sub continuous_const)).pow 3).mul
    (continuous_e.comp (continuous_const.mul continuous_id).neg)

theorem interior_atom_period {N : ℝ} (hn : 2*10^19 ≤ N) {q b : ℕ}
    (hq : q ∈ Finset.Icc 1 ⌊modulusCutoff N⌋₊) (hb : b ∈ arcNumerators q) (h : q ≠ 1) :
    Set.Ioc (0:ℝ) 1 ∩ arcAtom N q b = arcAtom N q b := by
  have hq0 : 0<q := (Finset.mem_Icc.mp hq).1
  obtain ⟨hbr,hc⟩ := mem_filter.mp hb
  have hbr' := mem_range.mp hbr
  have hb0 : 0<b := by
    by_contra! hh
    have : b=0 := by omega
    subst b; simp_all
  let r := reducedCentre q b hq0 hc
  have hr : (r:ℝ) = (b:ℝ)/q := by rw [Rat.cast_def]; simp [r,reducedCentre]
  have h0 : (0:ℝ)<r := hr.symm ▸ div_pos (by exact_mod_cast hb0) (by exact_mod_cast hq0)
  have h1 : (r:ℝ)<1 := by rw [hr,div_lt_one (by exact_mod_cast hq0)]; exact_mod_cast hbr'
  have hl : (r.den:ℝ) ≤ modulusCutoff N :=
    (Nat.le_floor_iff (by unfold modulusCutoff; positivity)).mp (Finset.mem_Icc.mp hq).2
  have hi := interior_window hn hl (by exact_mod_cast h0 : 0<r) (by exact_mod_cast h1 : r<1)
  apply Set.inter_eq_right.mpr
  intro x hx
  have hx' : x ∈ window N r := by
    unfold window; rw [hr,show r.den=q by rfl]; simpa only [arcAtom,if_neg h] using hx
  exact ⟨(hi hx').1,(hi hx').2.le⟩

theorem radius_one_small {N : ℝ} (hn : 2*10^19 ≤ N) : radius N 1 < 1/2 := by
  have hn' : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hl := log_two_e19 hn
  have hQ : 1 ≤ modulusCutoff N := by unfold modulusCutoff; nlinarith [sq_nonneg (Real.log N-44)]
  have hs := separation_budget_from_two_e19 hn
  have hq2 := pow_le_pow_left₀ zero_le_one hQ 2
  have hh := mul_le_mul_of_nonneg_left hq2 (by linarith : 0≤4*Real.log N)
  simp only [one_pow,mul_one] at hh
  simp only [radius,Nat.totient_one,Nat.cast_one,one_mul]
  apply (div_lt_iff₀ hn').mpr; linarith

theorem endpoint_atom_period {N : ℝ} (hn : 2*10^19 ≤ N) :
    Set.Ioc (0:ℝ) 1 ∩ arcAtom N 1 0 =
    Set.Ioc 0 (radius N 1) ∪ Set.Icc (1-radius N 1) 1 := by
  have h := radius_one_small hn
  ext x
  simp only [arcAtom,if_pos rfl,Set.mem_inter_iff,Set.mem_union,Set.mem_Ioc,Set.mem_Icc]
  constructor
  · rintro ⟨h1,h2|h2⟩
    · exact Or.inl ⟨h1.1,h2.2⟩
    · exact Or.inr h2
  · rintro (h1|h1)
    · exact ⟨⟨h1.1,by linarith [h1.2]⟩,Or.inl ⟨h1.1.le,h1.2⟩⟩
    · exact ⟨⟨by linarith [h1.1],h1.2⟩,Or.inr h1⟩

#print axioms interior_atom_period
#print axioms endpoint_atom_period
end GoldbachEnergy
