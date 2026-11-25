module

public import MajorIdentity
public import RationalCoordinates

@[expose] public section


open Real MeasureTheory Finset TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

def MajorBudgetAt (N : ℝ) : Prop :=
  ∀ q : ℕ, 0<q → (q:ℝ) ≤ modulusCutoff N → ∀ δ : ℝ, |δ| ≤ 2*Real.log N/q.totient →
    ∃ g u : ZeroTiling, twistedBudget N q δ g u ≤ 0.001*N/Real.log N

theorem major_of_numeric (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {N : ℕ} (hn : 2*10^19 ≤ N) (hnum : MajorBudgetAt N) :
    (restrictedModel N).re - 0.0032*(N:ℝ)^2 ≤
      (∫ x in Set.Ioc (0:ℝ) 1 \ minorArcs N, integrand N x).re := by
  have hn' : (2:ℝ)*10^19 ≤ N := by exact_mod_cast hn
  have h1 : (1:ℝ)≤N := le_trans (by norm_num) hn'
  have hpos : (0:ℝ)<N := lt_of_lt_of_le zero_lt_one h1
  apply major_of_local_errors hn
  intro q hq b hb x hx
  have hq0 : 0<q := (Finset.mem_Icc.mp hq).1
  have hlim : (q:ℝ)≤ modulusCutoff N := (Nat.le_floor_iff (by unfold modulusCutoff; positivity)).mp (Finset.mem_Icc.mp hq).2
  have hl (r : ℚ) (hr : r.den=q) (hw : |x-(r:ℝ)| ≤ radius N q) :
      ‖wave N x-principalWave N q (x-r)‖ ≤ 0.001*N/Real.log N := by
    let β := x-(r:ℝ)
    have hφ : (q.totient:ℝ)≠0 := by exact_mod_cast (Nat.totient_pos.mpr hq0).ne'
    have hs : |(N:ℝ)*β| ≤ 2*Real.log N/q.totient := by
      rw [abs_mul,abs_of_pos hpos]
      apply (mul_le_mul_of_nonneg_left hw hpos.le).trans_eq
      unfold radius; field_simp [hpos.ne',hφ]
    obtain ⟨g,u,hu⟩ := hnum q hq0 hlim _ hs
    have hh := error_at_rational rh grh h1 r β g u
    rw [hr,show (r:ℝ)+β=x by dsimp [β]; ring] at hh
    exact hh.trans hu
  have ha := hx.2
  by_cases h : q=1
  · subst q
    have hb0 : b < 1 := mem_range.mp (mem_filter.mp hb).1
    have : b=0 := by omega
    subst b; rw [arcAtom,if_pos rfl] at ha
    rcases ha with ha|ha
    · have hh := hl 0 rfl (by simpa [abs_of_nonneg ha.1] using ha.2)
      simpa [localModel,not_lt.mpr ha.2] using hh
    · have hs := radius_one_small hn'
      have he : radius N 1 < x := by linarith [ha.1]
      have hh := hl 1 rfl (by rw [Rat.cast_one,abs_of_nonpos (by linarith [ha.2])]; linarith [ha.1])
      simpa [localModel,he] using hh
  · let r := reducedCentre q b hq0 (mem_filter.mp hb).2
    have hr : (r:ℝ)=(b:ℝ)/q := by rw [Rat.cast_def]; simp [r,reducedCentre]
    rw [arcAtom,if_neg h] at ha
    have hh := hl r rfl (by rw [hr,abs_le]; constructor <;> linarith [ha.1,ha.2])
    simpa only [localModel,h,false_and,if_false,hr] using hh

#print axioms major_of_numeric
end GoldbachEnergy
