import TernaryGoldbach.MinorArcs.Bombieri

/-!
Exact character averages for a constant main term on a rational arc.

The squared Gauss norm remains explicit. This applies to imprimitive characters.
This scratch file has a complete proposed proof and has not been compiled.
-/

open Finset
open TernaryGoldbach (expTsum Schar)

namespace TernaryGoldbach.QRHResearch

private theorem sum_character_eq {q : ℕ} [NeZero q]
    (ψ : DirichletCharacter ℂ q) :
    ∑ b : ZMod q, ψ b = if ψ = 1 then (q.totient : ℂ) else 0 := by
  classical
  by_cases hψ : ψ = 1
  · subst ψ
    rw [if_pos rfl, TernaryGoldbach.sum_zmod_eq_sum_range]
    have hterm : ∀ b ∈ range q,
        (1 : DirichletCharacter ℂ q) (b : ZMod q) =
          if Nat.Coprime q b then (1 : ℂ) else 0 := by
      intro b hb
      by_cases hcop : Nat.Coprime q b
      · rw [if_pos hcop, MulChar.one_apply
          ((ZMod.isUnit_iff_coprime b q).2 hcop.symm)]
      · rw [if_neg hcop, MulChar.map_nonunit]
        intro hu
        exact hcop ((ZMod.isUnit_iff_coprime b q).1 hu).symm
    rw [sum_congr rfl hterm, ← sum_filter, sum_const, nsmul_eq_mul,
      Nat.totient_eq_card_coprime, mul_one]
  · rw [if_neg hψ]
    exact MulChar.sum_eq_zero_of_ne_one hψ

/-- Parseval after subtracting any constant main term on the units. -/
theorem totient_mul_sum_units_sub_const {q : ℕ} [NeZero q]
    {a : ℕ → ℂ} (ha : Summable fun n => ‖a n‖)
    (hcop : ∀ n, a n ≠ 0 → Nat.Coprime n q) (β : ℝ) (c : ℂ) :
    (q.totient : ℝ) *
        ∑ b ∈ (univ : Finset (ZMod q)).filter IsUnit,
          ‖expTsum a ((b.val : ℝ) / q + β) - c‖ ^ 2 =
      ∑ ψ : DirichletCharacter ℂ q,
        ‖gaussSum ψ ZMod.stdAddChar * Schar ψ⁻¹ a β -
          (if ψ = 1 then (q.totient : ℂ) * c else 0)‖ ^ 2 := by
  classical
  rw [← TernaryGoldbach.parseval_chars]
  refine sum_congr rfl fun ψ _ => ?_
  simp_rw [mul_sub]
  rw [sum_sub_distrib, TernaryGoldbach.sum_char_mul_S ψ ha hcop β,
    ← sum_mul, sum_character_eq]
  by_cases hψ : ψ = 1
  · rw [if_pos hψ, if_pos hψ]
  · rw [if_neg hψ, if_neg hψ, zero_mul]

/-- The residual has the exact spectral average, including the principal error.

The source identifies the principal Gauss sum with the Möbius function.
The statement retains that Gauss sum to use only the core Bombieri import.
-/
theorem totient_mul_sum_units_sub_main {q : ℕ} [NeZero q]
    {a : ℕ → ℂ} (ha : Summable fun n => ‖a n‖)
    (hcop : ∀ n, a n ≠ 0 → Nat.Coprime n q) (β : ℝ) (A : ℂ) :
    (q.totient : ℝ) *
        ∑ b ∈ (univ : Finset (ZMod q)).filter IsUnit,
          ‖expTsum a ((b.val : ℝ) / q + β) -
            gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar /
              (q.totient : ℂ) * A‖ ^ 2 =
      ∑ ψ : DirichletCharacter ℂ q,
        ‖gaussSum ψ ZMod.stdAddChar‖ ^ 2 *
          ‖Schar ψ⁻¹ a β - (if ψ = 1 then A else 0)‖ ^ 2 := by
  classical
  rw [totient_mul_sum_units_sub_const ha hcop β]
  refine sum_congr rfl fun ψ _ => ?_
  by_cases hψ : ψ = 1
  · subst ψ
    have hφ : (q.totient : ℂ) ≠ 0 := by
      exact_mod_cast Nat.ne_of_gt
        (Nat.totient_pos.2 (Nat.pos_of_ne_zero (NeZero.ne q)))
    have hc : (q.totient : ℂ) *
        (gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar /
          (q.totient : ℂ) * A) =
        gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar * A := by
      field_simp
    simp only [ite_true]
    rw [hc, ← mul_sub, norm_mul, mul_pow]
  · simp only [if_neg hψ, sub_zero, norm_mul, mul_pow]

/-- Exact imprimitive weights, as supplied by the source Gauss-sum theorem. -/
theorem totient_mul_sum_units_sub_main_conductors {q : ℕ} [NeZero q]
    {a : ℕ → ℂ} (ha : Summable fun n => ‖a n‖)
    (hcop : ∀ n, a n ≠ 0 → Nat.Coprime n q) (β : ℝ) (A : ℂ) :
    (q.totient : ℝ) *
        ∑ b ∈ (univ : Finset (ZMod q)).filter IsUnit,
          ‖expTsum a ((b.val : ℝ) / q + β) -
            gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar /
              (q.totient : ℂ) * A‖ ^ 2 =
      ∑ ψ : DirichletCharacter ℂ q,
        (if Squarefree (q / ψ.conductor) ∧
          Nat.Coprime (q / ψ.conductor) ψ.conductor
        then (ψ.conductor : ℝ) else 0) *
          ‖Schar ψ⁻¹ a β - (if ψ = 1 then A else 0)‖ ^ 2 := by
  simpa only [TernaryGoldbach.norm_sq_gaussSum] using
    totient_mul_sum_units_sub_main ha hcop β A


/-- A pointwise perturbation of size D transfers a finite residual mean square. -/
theorem sum_norm_sub_main_le {ι : Type*} [DecidableEq ι] (s : Finset ι)
    (f g : ι → ℂ) (A : ℂ) {D t : ℝ} (ht : 0 < t)
    (hD : ∀ i ∈ s, ‖f i - g i‖ ≤ D) :
    ∑ i ∈ s, ‖f i - A‖ ^ 2 ≤
      (1 + t) * ∑ i ∈ s, ‖g i - A‖ ^ 2 +
        (1 + 1 / t) * s.card * D ^ 2 := by
  have hpoint : ∀ i ∈ s, ‖f i - A‖ ^ 2 ≤
      (1 + t) * ‖g i - A‖ ^ 2 + (1 + 1 / t) * D ^ 2 := by
    intro i hi
    have he : f i - A = (g i - A) + (f i - g i) := by ring
    have hnorm : ‖f i - A‖ ≤ ‖g i - A‖ + ‖f i - g i‖ := by
      rw [he]
      exact norm_add_le _ _
    have hsq := pow_le_pow_left₀ (norm_nonneg _) hnorm 2
    have hprod : 2 * ‖g i - A‖ * ‖f i - g i‖ ≤
        t * ‖g i - A‖ ^ 2 + (1 / t) * ‖f i - g i‖ ^ 2 := by
      rw [← sub_nonneg]
      have heq :
          t * ‖g i - A‖ ^ 2 + (1 / t) * ‖f i - g i‖ ^ 2 -
            2 * ‖g i - A‖ * ‖f i - g i‖ =
          (t * ‖g i - A‖ - ‖f i - g i‖) ^ 2 / t := by
        field_simp
        <;> ring
      rw [heq]
      positivity
    have hperturb := mul_le_mul_of_nonneg_left
      (pow_le_pow_left₀ (norm_nonneg _) (hD i hi) 2)
      (show 0 ≤ 1 + 1 / t by positivity)
    nlinarith
  calc
    ∑ i ∈ s, ‖f i - A‖ ^ 2 ≤
        ∑ i ∈ s, ((1 + t) * ‖g i - A‖ ^ 2 + (1 + 1 / t) * D ^ 2) :=
      sum_le_sum hpoint
    _ = (1 + t) * ∑ i ∈ s, ‖g i - A‖ ^ 2 +
        (1 + 1 / t) * s.card * D ^ 2 := by
      rw [sum_add_distrib, ← mul_sum, sum_const, nsmul_eq_mul]
      ring

/-- Transfer the exact character average to a perturbed exponential sum. -/
theorem sum_units_perturbed_sub_main_le {q : ℕ} [NeZero q]
    {a : ℕ → ℂ} (ha : Summable fun n => ‖a n‖)
    (hcop : ∀ n, a n ≠ 0 → Nat.Coprime n q)
    (F : ℝ → ℂ) (β : ℝ) (A : ℂ) {D t : ℝ}
    (ht : 0 < t)
    (hD : ∀ α, ‖F α - expTsum a α‖ ≤ D) :
    ∑ b ∈ (univ : Finset (ZMod q)).filter IsUnit,
        ‖F ((b.val : ℝ) / q + β) -
          gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar /
            (q.totient : ℂ) * A‖ ^ 2 ≤
      (1 + t) / (q.totient : ℝ) *
        ∑ ψ : DirichletCharacter ℂ q,
          ‖gaussSum ψ ZMod.stdAddChar‖ ^ 2 *
            ‖Schar ψ⁻¹ a β - (if ψ = 1 then A else 0)‖ ^ 2 +
      (1 + 1 / t) * ((univ : Finset (ZMod q)).filter IsUnit).card * D ^ 2 := by
  classical
  have hφ : (q.totient : ℝ) ≠ 0 := by
    exact_mod_cast Nat.ne_of_gt
      (Nat.totient_pos.2 (Nat.pos_of_ne_zero (NeZero.ne q)))
  have htransfer := sum_norm_sub_main_le
    ((univ : Finset (ZMod q)).filter IsUnit)
    (fun b => F ((b.val : ℝ) / q + β))
    (fun b => expTsum a ((b.val : ℝ) / q + β))
    (gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar /
      (q.totient : ℂ) * A) ht (fun b _ => hD _)
  have hspectrum := totient_mul_sum_units_sub_main ha hcop β A
  have hrewrite :
      (1 + t) *
          ∑ b ∈ (univ : Finset (ZMod q)).filter IsUnit,
            ‖expTsum a ((b.val : ℝ) / q + β) -
              gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar /
                (q.totient : ℂ) * A‖ ^ 2 =
        (1 + t) / (q.totient : ℝ) *
          ∑ ψ : DirichletCharacter ℂ q,
            ‖gaussSum ψ ZMod.stdAddChar‖ ^ 2 *
              ‖Schar ψ⁻¹ a β - (if ψ = 1 then A else 0)‖ ^ 2 := by
    rw [← hspectrum]
    field_simp
  rw [hrewrite] at htransfer
  exact htransfer

end TernaryGoldbach.QRHResearch



