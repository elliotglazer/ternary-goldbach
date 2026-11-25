module

public import CharacterError
public import FullWaveComparison

@[expose] public section


open Real Finset TernaryGoldbach TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

/-- Uniform across the finitely many conductors dividing the approximating denominator. -/
def conductorBudget (q : ℕ) (N δ : ℝ) (g u : ZeroTiling) : ℝ :=
  max (charBudget 1 3 N δ g u)
    ((insert 1 q.divisors).sup' (insert_nonempty _ _) fun d => charBudget d (DN d) N δ g u)

private theorem level_one_eq {d : ℕ} (hd : d=1) (χ : DirichletCharacter ℂ d) (a : ℕ → ℂ) (β : ℝ) :
    Schar χ a β = Schar (1 : DirichletCharacter ℂ 1) a β := by
  subst d
  unfold Schar
  congr 1; ext n
  rw [Subsingleton.elim (n : ZMod 1) 1,map_one,map_one]

theorem rational_wave_error (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {N : ℝ} (hn : 1 ≤ N) {q : ℕ} [NeZero q] (β : ℝ) {b : ZMod q} (hb : IsUnit b)
    (g u : ZeroTiling) :
    let D := (Real.log q/Real.log 2)*(1+Real.log N)
    ‖wave N (b.val/q+β)-principalWave N q β‖ ≤ D+Real.sqrt q*(conductorBudget q N (N*β) g u+D) := by
  apply wave_from_primitive_characters hn β hb
  intro ψ
  classical
  by_cases h : ψ=1
  · subst ψ; rw [if_pos rfl,inv_one,level_one_eq DirichletCharacter.conductor_one]
    exact (principal_wave_error rh hn β g u).trans (le_max_left _ _)
  · rw [if_neg h,sub_zero]
    let ξ := ψ⁻¹
    letI : NeZero ξ.conductor := ⟨ξ.conductor_ne_zero⟩
    have hp := ξ.primitiveCharacter_isPrimitive
    have hξ : ξ.primitiveCharacter ≠ 1 := by
      intro e
      have hd : ξ.conductor = 1 := (DirichletCharacter.isPrimitive_def _).mp hp ▸
        (DirichletCharacter.eq_one_iff_conductor_eq_one.mp e)
      have h' := DirichletCharacter.eq_one_iff_conductor_eq_one.mpr hd
      exact h (by simpa [ξ] using h')
    have hc := nonprincipal_wave_error hp hξ (grh _ _ hp) hn β g u
    apply hc.trans (le_trans _ (le_max_right _ _))
    exact le_sup' (fun d => charBudget d (DN d) N (N*β) g u)
      (mem_insert_of_mem (Nat.mem_divisors.mpr ⟨ξ.conductor_dvd_level,NeZero.ne _⟩))

#print axioms rational_wave_error
end GoldbachEnergy
