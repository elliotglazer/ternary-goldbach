import RawLogAssembly
import RawExpTail

/-!
Internal phase and budget joins for the raw-head step producer (section 3 of
`RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`). The phase uses the actual
integer log program. The final helper still requires a separately proved
rounded exponential evaluation; it is not a closed step producer.
-/

noncomputable section

namespace RawHead

/-- Exact rational phase formed from the actual grid129 log center. -/
def rawStepPhase (k x : ℕ) : ℝ :=
  -(5 / 64 : ℝ) * ((log129Center k x : ℝ) / 2 ^ 129)

theorem log_lt_nineteen {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hhi : x ≤ 2 * 2 ^ k) : Real.log (x : ℝ) < 19 := by
  have hx19 : x ≤ 2 ^ 19 := by
    calc
      x ≤ 2 * 2 ^ k := hhi
      _ ≤ 2 * 2 ^ 18 := Nat.mul_le_mul_left 2
        (pow_le_pow_right' (by norm_num : 1 ≤ (2 : ℕ)) hk)
      _ = 2 ^ 19 := by norm_num
  have hl := Real.log_le_log (by exact_mod_cast hx : (0 : ℝ) < x)
    (show (x : ℝ) ≤ (2 : ℝ) ^ 19 by exact_mod_cast hx19)
  rw [Real.log_pow] at hl
  have htwo : Real.log 2 < 1 := by
    have h := Real.log_lt_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
      (by norm_num : (2 : ℝ) ≠ 1)
    norm_num at h
    exact h
  norm_num only [Nat.cast_ofNat] at hl
  linarith only [hl, htwo]

/-- The actual log-center phase lies in the small-phase domain, with slack. -/
theorem rawStepPhase_abs_lt_two {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    |rawStepPhase k x| < 2 := by
  have hl := log_lt_nineteen hx hk hhi
  have hn : 0 ≤ Real.log (x : ℝ) :=
    Real.log_nonneg (by exact_mod_cast (Nat.succ_le_iff.mpr hx) : (1 : ℝ) ≤ x)
  have he := log129Center_error hx hk hlo hhi
  rw [abs_sub_comm] at he
  have ht : (1 : ℝ) / 2 ^ 128 < 1 := by norm_num
  have hc : |(log129Center k x : ℝ) / 2 ^ 129| < 20 := by
    calc
      |(log129Center k x : ℝ) / 2 ^ 129| =
          |((log129Center k x : ℝ) / 2 ^ 129 - Real.log (x : ℝ)) +
            Real.log (x : ℝ)| := by congr 1; ring
      _ ≤ |(log129Center k x : ℝ) / 2 ^ 129 - Real.log (x : ℝ)| +
          |Real.log (x : ℝ)| := abs_add_le _ _
      _ < 20 := by rw [abs_of_nonneg hn]; linarith only [he, ht, hl]
  unfold rawStepPhase
  rw [abs_mul]
  rw [show |-(5 / 64 : ℝ)| = (5 / 64 : ℝ) by norm_num]
  linarith only [hc]

theorem rawStepPhase_abs_le_four {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    |rawStepPhase k x| ≤ 4 := by
  exact (rawStepPhase_abs_lt_two hx hk hlo hhi).le.trans (by norm_num)

/-- Error of the exact rational phase, before exponential evaluation. -/
theorem rawStepPhase_error {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    |rawStepPhase k x - (-(5 / 64 : ℝ) * Real.log (x : ℝ))| <
      (5 / 64 : ℝ) * (1 / 2 ^ 128) := by
  have he := log129Center_error hx hk hlo hhi
  have hid : rawStepPhase k x - (-(5 / 64 : ℝ) * Real.log (x : ℝ)) =
      (5 / 64 : ℝ) * (Real.log (x : ℝ) - (log129Center k x : ℝ) / 2 ^ 129) := by
    unfold rawStepPhase
    ring
  rw [hid, abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 5 / 64)]
  exact mul_lt_mul_of_pos_left he (by norm_num)

/-- Unit-circle phase transport for the actual log-center program. -/
theorem rawStepPhase_exp_error {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    ‖Complex.exp (Complex.I * rawStepPhase k x) -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (x : ℝ)))‖ <
        (5 / 64 : ℝ) * (1 / 2 ^ 128) := by
  simpa only [Complex.ofReal_mul, Complex.ofReal_neg] using
    (exp_imag_lipschitz (rawStepPhase k x)
    (-(5 / 64 : ℝ) * Real.log (x : ℝ))).trans_lt
      (rawStepPhase_error hx hk hlo hhi)

/-- The four separately charged step errors fit the persistent-step budget. -/
theorem raw_step_error_budget :
    (5 / 64 : ℝ) * (1 / 2 ^ 128) + 1 / 2 ^ 124 +
      81 / 2 ^ 131 + 1 / 2 ^ 122 < 1 / 2 ^ 120 := by
  norm_num

/-- Internal final join. The local rounded-polynomial bound must be supplied
by the actual arithmetic program; it is not an assumed concrete certificate. -/
theorem raw_step_error_of_polynomial_error {x k : ℕ} {v : ℂ}
    (hx : 0 < x) (hk : k ≤ 18) (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k)
    (hv : ‖v - expPartial 73 (Complex.I * rawStepPhase k x)‖ ≤
      81 / (2 : ℝ) ^ 131 + 1 / (2 : ℝ) ^ 122) :
    ‖v - Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (x : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have ht := expPartial73_imag_error (rawStepPhase_abs_le_four hx hk hlo hhi)
  rw [norm_sub_rev] at ht
  have hp := rawStepPhase_exp_error hx hk hlo hhi
  have h1 := norm_sub_le_norm_sub_add_norm_sub v (expPartial 73 (Complex.I * rawStepPhase k x))
    (Complex.exp (Complex.I * rawStepPhase k x))
  have h2 := norm_sub_le_norm_sub_add_norm_sub v (Complex.exp (Complex.I * rawStepPhase k x))
    (Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (x : ℝ))))
  have hb := raw_step_error_budget
  linarith only [hv, ht, hp, h1, h2, hb]

end RawHead
