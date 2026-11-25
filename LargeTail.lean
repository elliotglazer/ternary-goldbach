module

public import NumericAssembly
public import TailMinor
public import TailMajor

@[expose] public section


open Real TernaryGoldbach GoldbachEnergy
namespace GoldbachFinite

theorem large_from_log56 (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {N : ℕ} (hodd : Odd N) (hn : 2*10^19 ≤ N) (hL : 56 ≤ Real.log N) :
    IsSumOfThreePrimes N := by
  have h : (1:ℝ) ≤ N := by exact_mod_cast (show 1≤N by omega)
  exact large_from_numeric rh grh hodd hn (minor_budget_tail h hL) (major_budget_tail h hL)

theorem large_from_21e23 (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2) :
    TernaryGoldbachFrom (21*10^23) := by
  intro N ho hn
  have he : Real.exp 56 ≤ 21*(10:ℝ)^23 := by
    rw [show (56:ℝ)=(56:ℕ)*(1:ℝ) by norm_num,Real.exp_nat_mul]
    exact (pow_le_pow_left₀ (Real.exp_pos _).le Real.exp_one_lt_d9.le _).trans (by norm_num)
  exact large_from_log56 rh grh ho (by omega) ((Real.le_log_iff_exp_le
    (by exact_mod_cast (show 0<N by omega))).mpr (he.trans (by exact_mod_cast hn)))

theorem original_large_range (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2) :
    TernaryGoldbachFrom (10^27) :=
  fun n ho hn => large_from_21e23 rh grh n ho (le_trans (by norm_num) hn)

/-- Only the bounded strip remains for the cheaper binary cut. -/
theorem ternary_of_bounded_numeric (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    (bg : BinaryGoldbachUpTo 564383557524)
    (hnum : ∀ n : ℕ, Odd n → 2*10^19 ≤ n → Real.log n < 56 → MinorBudgetAt n ∧ MajorBudgetAt n) : Statement := by
  apply ternary_of_numeric rh grh bg
  intro n ho hn
  by_cases hl : Real.log n < 56
  · exact hnum n ho hn hl
  have h : (1:ℝ)≤n := by exact_mod_cast (show 1≤n by omega)
  exact ⟨minor_budget_tail h (le_of_not_gt hl),major_budget_tail h (le_of_not_gt hl)⟩

#print axioms large_from_21e23
#print axioms original_large_range
#print axioms ternary_of_bounded_numeric
end GoldbachFinite
