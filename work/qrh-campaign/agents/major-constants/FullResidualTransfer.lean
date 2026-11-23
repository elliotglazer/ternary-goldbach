import AveragedResidual
import TernaryGoldbach.MajorArcs.ArcCharsStar

/-!
The actual etaPlus and etaStar removal bounds, with the full character average.
These proposed proof scripts have not been compiled.
-/

open Finset
open TernaryGoldbach (expTsum Schar)
open TernaryGoldbach.MinorArcs (coprimePart norm_coprimePart_le)
open TernaryGoldbach.MajorArcs
open TernaryGoldbach.Helfgott (S etaPlus etaStar κ)

namespace TernaryGoldbach.QRHResearch

private theorem card_units_le_modulus {q : ℕ} [NeZero q] :
    (((univ : Finset (ZMod q)).filter IsUnit).card : ℝ) ≤ q := by
  have h : ((univ : Finset (ZMod q)).filter IsUnit).card ≤ q := by
    simpa only [card_univ, ZMod.card] using
      (Finset.card_le_card (Finset.filter_subset IsUnit (univ : Finset (ZMod q))))
  exact_mod_cast h

/-- Full etaPlus residual with the unchanged spectral Gauss weights. -/
theorem sum_units_etaPlus_sub_main_le {x : ℝ} (hx : 4.9e26 ≤ x)
    {q : ℕ} [NeZero q] (hq1 : 1 ≤ q) (hq : q ≤ 300000)
    (β : ℝ) (A : ℂ) {t : ℝ} (ht : 0 < t) :
    ∑ b ∈ (univ : Finset (ZMod q)).filter IsUnit,
        ‖S etaPlus x ((b.val : ℝ) / q + β) -
          gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar /
            (q.totient : ℂ) * A‖ ^ 2 ≤
      (1 + t) / (q.totient : ℝ) *
        ∑ ψ : DirichletCharacter ℂ q,
          ‖gaussSum ψ ZMod.stdAddChar‖ ^ 2 *
            ‖Schar ψ⁻¹ (coprimePart q (cP x)) β -
              (if ψ = 1 then A else 0)‖ ^ 2 +
      (1 + 1 / t) * 300000 * (1e-15 * x) ^ 2 := by
  have hx0 : 0 < x := by linarith
  have ha : Summable fun n => ‖coprimePart q (cP x) n‖ :=
    (summable_cP hx0).of_nonneg_of_le (fun n => norm_nonneg _)
      (norm_coprimePart_le q (cP x))
  have hcop : ∀ n, coprimePart q (cP x) n ≠ 0 → Nat.Coprime n q := by
    intro n hn
    by_contra h
    exact hn (by simp only [coprimePart, if_neg h])
  have hbound := sum_units_perturbed_sub_main_le ha hcop (S etaPlus x) β A
    (D := 1e-15 * x) ht (norm_S_sub_coprime_le hx hq1 hq)
  refine hbound.trans ?_
  have hcard : (((univ : Finset (ZMod q)).filter IsUnit).card : ℝ) ≤ 300000 :=
    card_units_le_modulus.trans (by exact_mod_cast hq)
  exact add_le_add_left
    (mul_le_mul_of_nonneg_right
      (mul_le_mul_of_nonneg_left hcard (by positivity)) (sq_nonneg _)) _

/-- Full etaStar residual with y=x/49 and the unchanged spectral Gauss weights. -/
theorem sum_units_etaStar_sub_main_le {x : ℝ} (hx : 4.9e26 ≤ x)
    {q : ℕ} [NeZero q] (hq1 : 1 ≤ q) (hq : q ≤ 300000)
    (β : ℝ) (A : ℂ) {t : ℝ} (ht : 0 < t) :
    ∑ b ∈ (univ : Finset (ZMod q)).filter IsUnit,
        ‖S etaStar x ((b.val : ℝ) / q + β) -
          gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar /
            (q.totient : ℂ) * A‖ ^ 2 ≤
      (1 + t) / (q.totient : ℝ) *
        ∑ ψ : DirichletCharacter ℂ q,
          ‖gaussSum ψ ZMod.stdAddChar‖ ^ 2 *
            ‖Schar ψ⁻¹ (coprimePart q (cU (x / κ))) β -
              (if ψ = 1 then A else 0)‖ ^ 2 +
      (1 + 1 / t) * 300000 * (1e-12 * (x / κ)) ^ 2 := by
  have hx0 : 0 < x := by linarith
  have hy0 : 0 < x / κ := div_pos hx0 kappa_pos
  have ha : Summable fun n => ‖coprimePart q (cU (x / κ)) n‖ :=
    (summable_cU hy0).of_nonneg_of_le (fun n => norm_nonneg _)
      (norm_coprimePart_le q (cU (x / κ)))
  have hcop : ∀ n, coprimePart q (cU (x / κ)) n ≠ 0 → Nat.Coprime n q := by
    intro n hn
    by_contra h
    exact hn (by simp only [coprimePart, if_neg h])
  have hbound := sum_units_perturbed_sub_main_le ha hcop (S etaStar x) β A
    (D := 1e-12 * (x / κ)) ht (norm_S_star_sub_coprime_le hx hq1 hq)
  refine hbound.trans ?_
  have hcard : (((univ : Finset (ZMod q)).filter IsUnit).card : ℝ) ≤ 300000 :=
    card_units_le_modulus.trans (by exact_mod_cast hq)
  exact add_le_add_left
    (mul_le_mul_of_nonneg_right
      (mul_le_mul_of_nonneg_left hcard (by positivity)) (sq_nonneg _)) _

end TernaryGoldbach.QRHResearch

