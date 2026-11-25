module

public import CellEnvelope
public import AtanCertificate
public import LeftIntegral

@[expose] public section


open Real Complex
noncomputable section
namespace GoldbachEnergy

theorem twist_angle_exact (δ : ℝ) : |(twistRate δ).arg| = Real.arctan (2*π*|δ|) := by
  let z := twistRate δ
  have hr : z.re=1 := by simp [z,twistRate]
  have hi : z.im= -(2*π*δ) := by simp [z,twistRate]
  have ha := Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl (by rw [hr]; norm_num) : 0 < z.re ∨ _)
  have ht : Real.tan z.arg= -(2*π*δ) := by rw [Complex.tan_arg,hr,hi,div_one]
  have he := Real.arctan_eq_of_tan_eq ht (abs_lt.mp ha)
  change |z.arg| = _
  rw [← he,Real.arctan_neg,abs_neg]
  by_cases hd : 0 ≤ δ
  · rw [abs_of_nonneg hd,abs_of_nonneg (Real.arctan_nonneg.mpr (by positivity))]
  · have ht' : 2*π*δ = -(2*π*|δ|) := by rw [abs_of_neg (lt_of_not_ge hd)]; ring
    rw [ht',Real.arctan_neg,abs_neg,abs_of_nonneg (Real.arctan_nonneg.mpr (by positivity))]

theorem twist_norm_exact (δ : ℝ) : ‖twistRate δ‖ = Real.sqrt (1+(2*π*|δ|)^2) := by
  have h := Complex.sq_norm (twistRate δ)
  rw [Complex.normSq_apply] at h
  simp [twistRate] at h
  have e : (2*π*|δ|)^2=(2*π*δ)^2 := by simp only [mul_pow,sq_abs]
  rw [e,← Real.sqrt_sq (norm_nonneg (twistRate δ))]
  congr 1
  simp only [twistRate]
  convert h using 1 <;> push_cast <;> ring

theorem gap_exact {δ : ℝ} (hδ : δ ≠ 0) :
    gapAngle (twistRate δ) = Real.arctan (2*π*|δ|)⁻¹ := by
  rw [gapAngle,twist_angle_exact,Real.arctan_inv_of_pos (by positivity : 0 < 2*π*|δ|)]

#print axioms twist_angle_exact
#print axioms twist_norm_exact
#print axioms gap_exact
end GoldbachEnergy
