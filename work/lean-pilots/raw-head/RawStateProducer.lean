import RawInverseRootProducer
import RawStepProducer
import RawDyadicProduct
import RawRecurrence

/-!
Actual integer raw-power states, initialized at height zero and advanced by the
literal rounded product. The final error theorem has only positive-base,
range-reduction and finite-height premises. It does not provide a literal trace
or a closed source-to-sign spectral certificate; those are separate consumers.
-/

namespace RawHead

/-- The actual inverse-root candidate on grid98, embedded exactly on grid120. -/
def rawStateInitial (x : ℕ) : ℤ × ℤ :=
  ((inverseRootCandidate x (2 ^ 98) : ℤ) * 2 ^ 22, 0)

/-- Persistent integer states; no lower-precision export feeds back into them. -/
def rawStateNumerator (k x : ℕ) : ℕ → ℤ × ℤ
  | 0 => rawStateInitial x
  | j + 1 => mulStep (2 ^ 122) (rawStateNumerator k x j) (rawStepNumerator k x)

noncomputable def rawStateValue (k x j : ℕ) : ℂ :=
  expIntegerValue (2 ^ 120) (rawStateNumerator k x j)

/-- The exact unit step used in the analytic comparison. -/
noncomputable def rawTrueStep (x : ℕ) : ℂ :=
  Complex.exp (Complex.I * (((-(5 / 64 : ℝ)) * Real.log (x : ℝ) : ℝ) : ℂ))

lemma rawStateInitial_value (x : ℕ) :
    expIntegerValue (2 ^ 120) (rawStateInitial x) =
      (((inverseRootCandidate x (2 ^ 98) : ℝ) / (2 : ℝ) ^ 98 : ℝ) : ℂ) := by
  apply Complex.ext <;> norm_num [expIntegerValue, rawStateInitial]
  all_goals ring

lemma rawStateValue_zero_error {x : ℕ} (hx : 0 < x) (k : ℕ) :
    ‖rawStateValue k x 0 - integerPower (x : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have h := inverseRootCandidate_initialization_error (S := 2 ^ 98) hx (by positivity)
  change ‖expIntegerValue (2 ^ 120) (rawStateInitial x) - integerPower (x : ℝ) 0‖ < _
  rw [rawStateInitial_value]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using h

lemma rawTrueStep_norm (x : ℕ) : ‖rawTrueStep x‖ = 1 := by
  unfold rawTrueStep
  exact Complex.norm_exp_I_mul_ofReal _

lemma rawStepValue_true_error {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    ‖rawStepValue k x - rawTrueStep x‖ < 1 / (2 : ℝ) ^ 120 := by
  simpa only [rawTrueStep, Complex.ofReal_mul, Complex.ofReal_neg] using
    rawStepValue_error hx hk hlo hhi

/-- Each stored update obtains its error from the actual two integer divisions. -/
lemma rawStateValue_update_error (k x j : ℕ) :
    ‖rawStateValue k x (j + 1) - rawStateValue k x j * rawStepValue k x‖ ≤
      1 / (2 : ℝ) ^ 120 := by
  have h := mulStep_error (S := 2 ^ 120) (T := 2 ^ 122)
    (by positivity) (by positivity) (rawStateNumerator k x j) (rawStepNumerator k x)
  simpa only [rawStateValue, rawStateNumerator, rawStepValue,
    Nat.cast_pow, Nat.cast_ofNat] using h

/-- The repeated true step has the actual grid-time meaning, including index zero. -/
lemma rawTrueStep_power (x j : ℕ) :
    integerPower (x : ℝ) 0 * rawTrueStep x ^ j =
      integerPower (x : ℝ) ((j : ℝ) * 5 / 64) := by
  induction j with
  | zero => simp
  | succ j ih =>
    rw [pow_succ, ← mul_assoc, ih]
    have ht : ((j + 1 : ℕ) : ℝ) * 5 / 64 = (j : ℝ) * 5 / 64 + 5 / 64 := by
      push_cast
      ring
    rw [ht, integerPower_time_step]
    unfold rawTrueStep
    congr 1
    congr 1
    push_cast
    ring

/-- Actual source-to-state error, with no approximation, rounding or recurrence
premises. A concrete block must additionally bind its entire literal output
trace to `rawStateNumerator`; this theorem alone does not compute that trace. -/
theorem rawStateValue_error {x k j : ℕ}
    (hx : 0 < x) (hk : k ≤ 18) (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k)
    (hj : j ≤ 90000) :
    ‖rawStateValue k x j - integerPower (x : ℝ) ((j : ℝ) * 5 / 64)‖ <
      1 / (2 : ℝ) ^ 96 := by
  have hxR : (1 : ℝ) ≤ x := by exact_mod_cast (Nat.succ_le_iff.mpr hx)
  have hb : ‖integerPower (x : ℝ) 0‖ ≤ 1 := integerPower_norm_le_one hxR 0
  have hs := rawStepValue_true_error hx hk hlo hhi
  have hi := rawStateValue_zero_error hx k
  have h := power_state_error_lt_dyadic96
    (b := integerPower (x : ℝ) 0) (w := rawTrueStep x)
    (v := rawStepValue k x) (z := rawStateValue k x)
    hb (rawTrueStep_norm x) hs.le hi.le
    (fun n _ => rawStateValue_update_error k x n) j hj
  rwa [rawTrueStep_power] at h

end RawHead
