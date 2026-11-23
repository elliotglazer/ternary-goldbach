import CentralChi4

/-! Internal pilot: actual completed chi4 function is real on the critical line. -/
noncomputable section
open Complex MeasureTheory Set
open scoped ComplexConjugate
open TernaryGoldbach.Explicit SpectralPilot

namespace SpectralRealityPilot

lemma chi4_odd : chi4.Odd := by
  change chi4 (-1) = -1
  rw [show (-1 : ZMod 4) = (3 : ℕ) by decide, chi4_nat]
  norm_num

lemma chi4_inverse : chi4⁻¹ = chi4 := by
  apply MulChar.ext'
  intro x
  rw [MulChar.inv_apply_eq_inv']
  have h := chi4_nat x.val
  rw [ZMod.natCast_zmod_val] at h
  rw [h]
  split_ifs <;> norm_num

lemma chi4_primitive : chi4.IsPrimitive := by
  have hd := DirichletCharacter.conductor_dvd_level chi4
  have hp := DirichletCharacter.conductor_ne_zero chi4
  have hle : chi4.conductor ≤ 4 := Nat.le_of_dvd (by decide) hd
  have h1 : chi4.conductor ≠ 1 := by
    intro h
    exact chi4_ne_one (DirichletCharacter.eq_one_iff_conductor_eq_one.mpr h)
  have h2 : chi4.conductor ≠ 2 := by
    intro h
    have hf : chi4.FactorsThrough 2 := h ▸ DirichletCharacter.factorsThrough_conductor chi4
    obtain ⟨hd2, ψ, hψ⟩ := hf
    have he : chi4 (-1) = ψ (-1) := by
      rw [hψ]
      exact DirichletCharacter.changeLevel_eq_cast_of_dvd' ψ hd2 (a := -1) (by norm_num)
    rw [chi4_odd, show (-1 : ZMod 2) = 1 by decide, map_one] at he
    norm_num at he
  change chi4.conductor = 4
  interval_cases h : chi4.conductor <;> omega

lemma chi4_completed_central_ne_zero : chi4.completedLFunction (1 / 2) ≠ 0 := by
  intro hz
  have h := DirichletCharacter.LFunction_eq_completed_div_gammaFactor chi4 (1 / 2)
    (Or.inr (by decide))
  rw [hz, zero_div] at h
  have hp := central_chi4_certificate.1
  rw [h] at hp
  norm_num at hp

lemma chi4_rootNumber : chi4.rootNumber = 1 := by
  have h := chi4_primitive.completedLFunction_one_sub (1 / 2)
  rw [chi4_inverse, show (1 : ℂ) - 1 / 2 = 1 / 2 by ring,
    sub_self, Complex.cpow_zero, one_mul] at h
  apply mul_right_cancel₀ chi4_completed_central_ne_zero
  simpa only [one_mul] using h.symm

lemma real_cpow_conjugate {t : ℝ} (ht : 0 < t) (z : ℂ) :
    (t : ℂ) ^ conj z = conj ((t : ℂ) ^ z) := by
  have ha : (t : ℂ).arg ≠ Real.pi := by
    rw [Complex.arg_ofReal_of_nonneg ht.le]
    exact Real.pi_pos.ne
  simpa only [Complex.conj_ofReal] using Complex.cpow_conj (t : ℂ) z ha

lemma chi4_LFunction_conjugate {s : ℂ} (hs : 0 < s.re) :
    chi4.LFunction (conj s) = conj (chi4.LFunction s) := by
  rw [LFunction_eq_mul_Iint chi4_ne_one (by simpa using hs),
    LFunction_eq_mul_Iint chi4_ne_one hs, map_mul]
  congr 1
  rw [Iint, Iint, ← integral_conj]
  apply setIntegral_congr_fun measurableSet_Ioi
  intro t ht
  dsimp only
  have hp : conj (psum chi4 ⌊t⌋₊) = psum chi4 ⌊t⌋₊ := by
    rw [psum_chi4_real]
    simp only [Complex.conj_ofReal]
  rw [map_mul, hp]
  congr 1
  simpa only [map_neg, map_add, map_one] using
    real_cpow_conjugate (lt_trans zero_lt_one ht) (-(s + 1))

lemma chi4_completed_eq {s : ℂ} (hs : 0 < s.re) :
    chi4.completedLFunction s = chi4.LFunction s * Complex.Gammaℝ (s + 1) := by
  have h := DirichletCharacter.LFunction_eq_completed_div_gammaFactor chi4 s
    (Or.inr (by decide))
  rw [chi4_odd.gammaFactor_def] at h
  have hg : Complex.Gammaℝ (s + 1) ≠ 0 :=
    Complex.Gammaℝ_ne_zero_of_re_pos (by
      simp only [Complex.add_re, Complex.one_re]
      linarith only [hs])
  exact ((eq_div_iff hg).mp h).symm

lemma chi4_completed_conjugate {s : ℂ} (hs : 0 < s.re) :
    chi4.completedLFunction (conj s) = conj (chi4.completedLFunction s) := by
  rw [chi4_completed_eq (by simpa using hs), chi4_completed_eq hs,
    map_mul, chi4_LFunction_conjugate hs]
  congr 1
  rw [show conj s + 1 = conj (s + 1) by simp only [map_add, map_one], Complex.Gammaℝ_conj]

theorem normalized_completed_chi4_real (t : ℝ) :
    ((4 : ℂ) ^ (((1 / 2 : ℂ) + I * t) / 2) *
      chi4.completedLFunction ((1 / 2 : ℂ) + I * t)).im = 0 := by
  let s : ℂ := 1 / 2 + I * t
  have hs : 0 < s.re := by simp [s]
  have hsc : conj s = 1 - s := by
    apply Complex.ext <;> norm_num [s]
  have hf := chi4_primitive.completedLFunction_one_sub s
  rw [chi4_inverse, chi4_rootNumber, mul_one] at hf
  norm_num only [Nat.cast_ofNat] at hf
  have hpow : (4 : ℂ) ^ conj (s / 2) = conj ((4 : ℂ) ^ (s / 2)) := by
    simpa only [Complex.ofReal_ofNat] using
      real_cpow_conjugate (by norm_num : (0 : ℝ) < 4) (s / 2)
  have hc : conj ((4 : ℂ) ^ (s / 2) * chi4.completedLFunction s) =
      (4 : ℂ) ^ (s / 2) * chi4.completedLFunction s := by
    rw [map_mul, ← chi4_completed_conjugate hs, ← hpow]
    rw [map_div₀, map_ofNat, hsc, hf]
    rw [← mul_assoc, ← Complex.cpow_add _ _ (by norm_num : (4 : ℂ) ≠ 0)]
    congr 2
    ring
  have him := congrArg Complex.im hc
  simp only [Complex.conj_im] at him
  change ((4 : ℂ) ^ (s / 2) * chi4.completedLFunction s).im = 0
  linarith only [him]

end SpectralRealityPilot
