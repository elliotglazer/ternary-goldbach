import TernaryGoldbach.MajorArcs.ArcChars

/-!
Unconditional structural lemma extracted from ArcChars.sum_units_sq_bounds.
This isolates the principal-character lower bound from the unused upper-error
hypothesis. It is not a proof of the missing q=1 analytic estimate.
Status: proof draft, not compiled.
-/

open MeasureTheory Set Finset Real

namespace TernaryGoldbach.MajorArcs

/-- Principal character energy is at most total reduced-residue energy. -/
theorem principal_le_sum_units_sq {q : ℕ} [NeZero q] {a : ℕ → ℂ}
    (ha : Summable fun n => ‖a n‖)
    (hcop : ∀ n, a n ≠ 0 → Nat.Coprime n q) (β : ℝ) :
    (if Squarefree q then (1 : ℝ) else 0) / q.totient * ‖expTsum a β‖ ^ 2 ≤
      ∑ b ∈ (univ : Finset (ZMod q)).filter IsUnit,
        ‖expTsum a ((b.val : ℝ) / q + β)‖ ^ 2 := by
  classical
  have key := TernaryGoldbach.totient_mul_sum_units ha hcop β
  have hs := Finset.single_le_sum
    (s := (univ : Finset (DirichletCharacter ℂ q)))
    (f := fun ψ => ‖gaussSum ψ ZMod.stdAddChar‖ ^ 2 * ‖Schar ψ⁻¹ a β‖ ^ 2)
    (fun ψ _ => by positivity) (Finset.mem_univ (1 : DirichletCharacter ℂ q))
  rw [inv_one, Schar_one_eq_expTsum hcop, norm_sq_gaussSum_one] at hs
  rw [← key] at hs
  have hφ : (0 : ℝ) < q.totient := by
    exact_mod_cast Nat.totient_pos.2 (Nat.pos_of_ne_zero (NeZero.ne q))
  rw [div_mul_eq_mul_div, div_le_iff₀ hφ]
  nlinarith [hs]

/-- Rational budget used by the proposed principal-only L2 lower bound. -/
theorem principal_l2_lower_numeric :
    (8.6296 : ℝ) < (1 - 1e-6) *
      (13.597558 * ((1 - 0.00354) * 0.6392 -
        8 * (0.001 + 1e-15) ^ 2 / 0.00354)) - 7.2e-19 / 1e-6 := by
  norm_num

end TernaryGoldbach.MajorArcs


-- These are only the arithmetic closing steps for explicit spectral targets;
-- the targets themselves remain unproved analytic obligations.
namespace TernaryGoldbach.MajorArcs

theorem spectral_l2_upper_nine_numeric :
    (1 + 1e-6 : ℝ) * ((1 + 0.0034) * (0.640208 * 13.59756) +
      (1 + 1 / 0.0034) * 1e-4 + 0.23) + (1 + 1 / 1e-6) * 7.2e-19 < 9 := by
  norm_num

theorem spectral_l2_upper_ten_numeric :
    (1 + 1e-6 : ℝ) * ((1 + 0.0034) * (0.640208 * 13.59756) +
      (1 + 1 / 0.0034) * 1e-4 + 1.23) + (1 + 1 / 1e-6) * 7.2e-19 < 10 := by
  norm_num

end TernaryGoldbach.MajorArcs
