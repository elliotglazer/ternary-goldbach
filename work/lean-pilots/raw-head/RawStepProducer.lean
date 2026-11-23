import RawExpInteger
import RawStepAssembly

/-! Internal concrete step producer. Both the logarithm and exponential are literal
integer programs; the final source theorem has only the integer range premises. -/

namespace RawHead

/-- The inner exponential program on grid131, reusable for a certified log center. -/
def stepInnerFromLog (q : ℤ) : ℤ × ℤ :=
  expIntegerHorner (2 ^ 131) (-5 * q) (2 ^ 135) 72 0

/-- Stored grid122 step, with one actual nearest rounding per coordinate. -/
def stepFromLog (q : ℤ) : ℤ × ℤ :=
  let w := stepInnerFromLog q
  (roundDiv 512 w.1, roundDiv 512 w.2)

def rawStepNumerator (k x : ℕ) : ℤ × ℤ :=
  stepFromLog (log129Center k x)

noncomputable def rawStepValue (k x : ℕ) : ℂ :=
  expIntegerValue (2 ^ 122) (rawStepNumerator k x)

lemma step_regrid_coordinate (r : ℤ) :
    |(roundDiv 512 r : ℝ) / (2 : ℝ) ^ 122 - (r : ℝ) / (2 : ℝ) ^ 131| ≤
      1 / (2 * (2 : ℝ) ^ 122) := by
  have h := roundDiv_scaled_error (S := 2 ^ 122) (D := 512) (r := r)
    (by positivity) (by norm_num)
  simp only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] at h
  simpa only [div_div,
    show (512 : ℝ) * 2 ^ 122 = 2 ^ 131 by norm_num] using h

/-- This rounding bound concerns the actual stored pair, with no certificate premise. -/
lemma stepFromLog_regrid_error (q : ℤ) :
    ‖expIntegerValue (2 ^ 122) (stepFromLog q) -
      expIntegerValue (2 ^ 131) (stepInnerFromLog q)‖ ≤ 1 / (2 : ℝ) ^ 122 := by
  let w := stepInnerFromLog q
  have hr := step_regrid_coordinate w.1
  have hi := step_regrid_coordinate w.2
  change ‖(⟨(roundDiv 512 w.1 : ℝ) / ((2 ^ 122 : ℕ) : ℝ),
      (roundDiv 512 w.2 : ℝ) / ((2 ^ 122 : ℕ) : ℝ)⟩ : ℂ) -
      ⟨(w.1 : ℝ) / ((2 ^ 131 : ℕ) : ℝ),
        (w.2 : ℝ) / ((2 ^ 131 : ℕ) : ℝ)⟩‖ ≤ _
  simp only [Nat.cast_pow, Nat.cast_ofNat]
  calc
    _ ≤ |(roundDiv 512 w.1 : ℝ) / (2 : ℝ) ^ 122 - (w.1 : ℝ) / (2 : ℝ) ^ 131| +
        |(roundDiv 512 w.2 : ℝ) / (2 : ℝ) ^ 122 - (w.2 : ℝ) / (2 : ℝ) ^ 131| :=
      Complex.norm_le_abs_re_add_abs_im _
    _ ≤ 1 / (2 * (2 : ℝ) ^ 122) + 1 / (2 * (2 : ℝ) ^ 122) := add_le_add hr hi
    _ = 1 / (2 : ℝ) ^ 122 := by ring

lemma rawStep_phase_ratio (k x : ℕ) :
    ((-5 * log129Center k x : ℤ) : ℝ) / ((2 ^ 135 : ℕ) : ℝ) =
      rawStepPhase k x := by
  norm_num [rawStepPhase]
  ring

lemma rawStep_expPhase (k x : ℕ) :
    expPhase (-5 * log129Center k x) (2 ^ 135) =
      Complex.I * rawStepPhase k x := by
  unfold expPhase
  rw [rawStep_phase_ratio]

theorem rawStep_polynomial_error {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    ‖rawStepValue k x - expPartial 73 (Complex.I * rawStepPhase k x)‖ ≤
      81 / (2 : ℝ) ^ 131 + 1 / (2 : ℝ) ^ 122 := by
  have hp : |((-5 * log129Center k x : ℤ) : ℝ) / ((2 ^ 135 : ℕ) : ℝ)| ≤ 4 := by
    rw [rawStep_phase_ratio]
    exact rawStepPhase_abs_le_four hx hk hlo hhi
  have he := expIntegerHorner72_error (S := 2 ^ 131) (d := 2 ^ 135)
    (by positivity) (by positivity) (-5 * log129Center k x) hp
  rw [rawStep_expPhase] at he
  simp only [Nat.cast_pow, Nat.cast_ofNat] at he
  have hr := stepFromLog_regrid_error (log129Center k x)
  have ht := norm_sub_le_norm_sub_add_norm_sub (rawStepValue k x)
    (expIntegerValue (2 ^ 131) (stepInnerFromLog (log129Center k x)))
    (expPartial 73 (Complex.I * rawStepPhase k x))
  change ‖rawStepValue k x -
    expIntegerValue (2 ^ 131) (stepInnerFromLog (log129Center k x))‖ ≤ _ at hr
  change ‖expIntegerValue (2 ^ 131) (stepInnerFromLog (log129Center k x)) -
    expPartial 73 (Complex.I * rawStepPhase k x)‖ ≤ _ at he
  exact (ht.trans (add_le_add hr he)).trans_eq (add_comm _ _)

/-- Actual stored-step error: all arithmetic approximation premises are discharged. -/
theorem rawStepValue_error {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    ‖rawStepValue k x -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (x : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 :=
  raw_step_error_of_polynomial_error hx hk hlo hhi
    (rawStep_polynomial_error hx hk hlo hhi)

end RawHead
