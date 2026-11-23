import TernaryGoldbach.Explicit.LGrowth
import Mathlib.NumberTheory.LegendreSymbol.ZModChar
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.IntervalCases
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

/-! Internal pilot milestone: actual nonprincipal central L-value. -/
noncomputable section
open Complex MeasureTheory Set
open TernaryGoldbach.Explicit
namespace SpectralPilot

def chi4 : DirichletCharacter ℂ 4 :=
  ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)

lemma chi4_nat (n : ℕ) : chi4 (n : ZMod 4) =
    if n % 2 = 0 then 0 else if n % 4 = 1 then 1 else -1 := by
  change ((ZMod.χ₄ (n : ZMod 4) : ℤ) : ℂ) = _
  rw [ZMod.χ₄_nat_eq_if_mod_four]
  split_ifs <;> norm_num

lemma chi4_ne_one : chi4 ≠ 1 := by
  intro h
  have hh := congrArg (fun f : DirichletCharacter ℂ 4 => f (3 : ZMod 4)) h
  have hc : chi4 (3 : ZMod 4) = -1 := by simpa using chi4_nat 3
  rw [hc] at hh
  rw [show (3 : ZMod 4) = -1 by decide] at hh
  norm_num [MulChar.one_apply] at hh

lemma sum_range_chi4 (n : ℕ) :
    (∑ k ∈ Finset.range n, chi4 (k : ZMod 4)) =
      if n % 4 = 2 ∨ n % 4 = 3 then 1 else 0 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih, chi4_nat]
    have hn : n % 4 < 4 := Nat.mod_lt _ (by decide)
    interval_cases h : n % 4 <;>
      have h2 : n % 2 = (n % 4) % 2 := by omega
    all_goals simp only [h] at h2
    all_goals have h4 : (n + 1) % 4 = (n % 4 + 1) % 4 := by omega
    all_goals norm_num [h, h2, h4]

lemma psum_chi4 (n : ℕ) : psum chi4 n =
    if n % 4 = 1 ∨ n % 4 = 2 then 1 else 0 := by
  have h : (∑ k ∈ Finset.range (n + 1), chi4 (k : ZMod 4)) =
      chi4 (0 : ZMod 4) + psum chi4 n := by
    rw [Finset.sum_range_succ', add_comm, psum]
    congr 1
    rw [Finset.range_eq_Ico, Finset.sum_Ico_add' (fun k : ℕ => chi4 (k : ZMod 4)),
      zero_add, Finset.Ico_add_one_right_eq_Icc]
  have hz : chi4 (0 : ZMod 4) = 0 := by simpa using chi4_nat 0
  rw [hz, zero_add, sum_range_chi4] at h
  rw [← h]
  have hc : ((n + 1) % 4 = 2 ∨ (n + 1) % 4 = 3) ↔
      (n % 4 = 1 ∨ n % 4 = 2) := by omega
  simp only [hc]

def centralIntegrand (t : ℝ) : ℝ :=
  (psum chi4 ⌊t⌋₊).re * t ^ (-(3 / 2 : ℝ))

lemma psum_chi4_real (n : ℕ) :
    psum chi4 n = ((psum chi4 n).re : ℂ) := by
  rw [psum_chi4]
  split_ifs <;> norm_num

lemma psum_chi4_bounds (n : ℕ) :
    0 ≤ (psum chi4 n).re ∧ (psum chi4 n).re ≤ 1 := by
  rw [psum_chi4]
  split_ifs <;> norm_num

lemma centralIntegrand_nonneg {t : ℝ} (ht : 0 ≤ t) :
    0 ≤ centralIntegrand t :=
  mul_nonneg (psum_chi4_bounds _).1 (Real.rpow_nonneg ht _)

lemma centralIntegrand_le {t : ℝ} (ht : 0 ≤ t) :
    centralIntegrand t ≤ t ^ (-(3 / 2 : ℝ)) := by
  exact mul_le_of_le_one_left (Real.rpow_nonneg ht _) (psum_chi4_bounds _).2

lemma central_integrand_complex {t : ℝ} (ht : 0 ≤ t) :
    psum chi4 ⌊t⌋₊ * (t : ℂ) ^ (-((1 / 2 : ℂ) + 1)) =
      (centralIntegrand t : ℂ) := by
  rw [psum_chi4_real]
  unfold centralIntegrand
  rw [Complex.ofReal_mul, Complex.ofReal_cpow ht]
  congr 2
  norm_num

lemma centralIntegrand_integrable : IntegrableOn centralIntegrand (Ioi 1) := by
  have h := (integrableOn_integrand chi4_ne_one (by norm_num : 0 < (1 / 2 : ℂ).re)).re
  apply h.congr
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  rw [central_integrand_complex (le_of_lt (lt_trans zero_lt_one ht))]
  rfl

lemma actual_central_integral : chi4.LFunction (1 / 2) =
    ((1 / 2 * ∫ t in Ioi (1 : ℝ), centralIntegrand t : ℝ) : ℂ) := by
  rw [LFunction_eq_mul_Iint chi4_ne_one (by norm_num)]
  unfold Iint
  have he : (∫ t in Ioi (1 : ℝ), psum chi4 ⌊t⌋₊ * (t : ℂ) ^ (-((1 / 2 : ℂ) + 1))) =
      ∫ t in Ioi (1 : ℝ), (centralIntegrand t : ℂ) := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro t ht
    exact central_integrand_complex (le_of_lt (lt_trans zero_lt_one ht))
  rw [he, integral_complex_ofReal, Complex.ofReal_mul]
  norm_num

lemma centralIntegrand_on_initial {t : ℝ} (ht : t ∈ Icc (1 : ℝ) 2) :
    centralIntegrand t = t ^ (-(3 / 2 : ℝ)) := by
  have hf1 : 1 ≤ ⌊t⌋₊ := (Nat.le_floor_iff (by linarith [ht.1])).2 (by simpa using ht.1)
  have hf2 : ⌊t⌋₊ ≤ 2 := Nat.floor_le_of_le ht.2
  have hf : ⌊t⌋₊ = 1 ∨ ⌊t⌋₊ = 2 := by omega
  rcases hf with hf | hf <;> norm_num [centralIntegrand, hf, psum_chi4]

lemma initial_integral : (1 / 2 : ℝ) * ∫ t in (1 : ℝ)..2, centralIntegrand t =
    1 - 1 / Real.sqrt 2 := by
  have he : (∫ t in (1 : ℝ)..2, centralIntegrand t) =
      ∫ t in (1 : ℝ)..2, t ^ (-(3 / 2 : ℝ)) := by
    apply intervalIntegral.integral_congr
    intro t ht
    apply centralIntegrand_on_initial
    simpa only [uIcc_of_le (by norm_num : (1 : ℝ) ≤ 2)] using ht
  rw [he, integral_rpow (Or.inr ⟨by norm_num, by norm_num [uIcc_of_le]⟩)]
  norm_num
  rw [Real.rpow_neg (by norm_num : (0 : ℝ) ≤ 2), ← Real.sqrt_eq_rpow]
  ring

def centralTail : ℝ := (1 / 2) * ∫ t in Ioi (2 : ℝ), centralIntegrand t

lemma central_tail_nonneg : 0 ≤ centralTail := by
  unfold centralTail
  apply mul_nonneg (by norm_num)
  apply integral_nonneg_of_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  exact centralIntegrand_nonneg (le_trans (by norm_num : (0 : ℝ) ≤ 2) ht.le)

lemma central_tail_le : centralTail ≤ 1 / Real.sqrt 2 := by
  have hi : IntegrableOn centralIntegrand (Ioi 2) :=
    centralIntegrand_integrable.mono_set (Ioi_subset_Ioi (by norm_num))
  have hp : IntegrableOn (fun t : ℝ => t ^ (-(3 / 2 : ℝ))) (Ioi 2) :=
    integrableOn_Ioi_rpow_of_lt (by norm_num) (by norm_num)
  have hm := setIntegral_mono_on hi hp measurableSet_Ioi
    (fun t ht => centralIntegrand_le (le_trans (by norm_num : (0 : ℝ) ≤ 2) ht.le))
  have hr := integral_Ioi_rpow_of_lt (by norm_num : -(3 / 2 : ℝ) < -1)
    (by norm_num : (0 : ℝ) < 2)
  rw [hr] at hm
  norm_num at hm
  have he : (2 : ℝ) ^ (-(1 / 2 : ℝ)) = 1 / Real.sqrt 2 := by
    rw [Real.rpow_neg (by norm_num : (0 : ℝ) ≤ 2), ← Real.sqrt_eq_rpow, one_div]
  norm_num [he, div_eq_mul_inv] at hm
  unfold centralTail
  simp only [one_div]
  linarith

lemma actual_central_finite_approximation : chi4.LFunction (1 / 2) =
    ((1 - 1 / Real.sqrt 2 + centralTail : ℝ) : ℂ) := by
  rw [actual_central_integral]
  congr 1
  have hi : IntegrableOn centralIntegrand (Ioi 2) :=
    centralIntegrand_integrable.mono_set (Ioi_subset_Ioi (by norm_num))
  have he := intervalIntegral.integral_interval_add_Ioi centralIntegrand_integrable hi
  rw [← he, mul_add, initial_integral]
  rfl

lemma certified_sqrt_two : (4 / 3 : ℝ) < Real.sqrt 2 := by
  have hs := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)
  have hn := Real.sqrt_nonneg (2 : ℝ)
  nlinarith only [hs, hn]

/-- A genuine central analytic L-value certificate, not a positive-height throughput pilot. -/
theorem central_chi4_certificate :
    (1 / 4 : ℝ) < (chi4.LFunction (1 / 2)).re ∧
      (chi4.LFunction (1 / 2)).re ≤ 1 ∧ (chi4.LFunction (1 / 2)).im = 0 := by
  rw [actual_central_finite_approximation]
  simp only [Complex.ofReal_re, Complex.ofReal_im]
  have hs := certified_sqrt_two
  have hsp : 0 < Real.sqrt 2 := by linarith
  have hinv : 1 / Real.sqrt 2 < (3 / 4 : ℝ) := (div_lt_iff₀ hsp).2 (by linarith)
  exact ⟨by linarith [central_tail_nonneg], by linarith [central_tail_le], trivial⟩

end SpectralPilot
