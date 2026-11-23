import RawStateFixtureData
import RawLogCases
import RawStepProducer
import RawInverseRootWitness

/-! Generated proof proposal for the fixed matched raw-head experiment.
Fixture SHA256: 01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9
Emitter SHA256: 9995BE5B63C1C30A8EE22F0C486482B0E9BB91215680C9858ADE9D64CC0E164E
All stored integers are literal data. Compilation is separate.
-/

/-! Common setup only. Existing RawLogCases is a charged dependency.
No whole-trace recurrence or approximation is asserted by this module.
Each source equality below has no certificate or error hypothesis.
-/

namespace RawStateSources
open RawStateData

theorem range_checked_1 : 0 < (1 : ℕ) ∧ 0 ≤ (18 : ℕ) ∧
    2 ^ 0 ≤ (1 : ℕ) ∧ (1 : ℕ) ≤ 2 * 2 ^ 0 := by decide

theorem log_checked_1 : RawHead.log129Center 0 1 = logNumerator_1 := by
  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked 0 1).symm.trans
    RawLogCases.center_1

theorem root_checked_1 :
    RawHead.inverseRootCandidate 1 (2 ^ 98) = rootNumerator_1 := by
  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)
  · change (316912650057057350374175801344 : ℕ) * 316912650057057350374175801344 * 1 ≤ (2 ^ 98 : ℕ) * 2 ^ 98
    exact_mod_cast RawLogCases.sqrt_lo_1
  · change (2 ^ 98 : ℕ) * 2 ^ 98 < (316912650057057350374175801344 + 1) * (316912650057057350374175801344 + 1) * 1
    exact_mod_cast RawLogCases.sqrt_hi_1

theorem initial_checked_1 :
    ((RawHead.inverseRootCandidate 1 (2 ^ 98) : ℤ) * 2 ^ 22, 0) =
      initial_1 := by
  rw [root_checked_1]
  decide +kernel

theorem inner_step_checked_1 :
    RawHead.stepInnerFromLog logNumerator_1 = innerStep_1 := by decide +kernel

theorem step_from_log_checked_1 :
    RawHead.stepFromLog logNumerator_1 = step_1 := by
  rw [RawHead.stepFromLog, inner_step_checked_1]
  decide +kernel

theorem step_checked_1 : RawHead.rawStepNumerator 0 1 = step_1 := by
  rw [RawHead.rawStepNumerator, log_checked_1]
  exact step_from_log_checked_1

theorem step_error_1 :
    ‖RawHead.expIntegerValue (2 ^ 122) step_1 -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (1 : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have h := RawHead.rawStepValue_error (x := 1) (k := 0)
    (by decide) (by decide) (by decide) (by decide)
  simpa only [RawHead.rawStepValue, step_checked_1] using h

theorem initial_error_1 :
    ‖RawHead.expIntegerValue (2 ^ 120) initial_1 -
      RawHead.integerPower (1 : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have he : RawHead.expIntegerValue (2 ^ 120) initial_1 =
      (((RawHead.inverseRootCandidate 1 (2 ^ 98) : ℝ) /
        ((2 ^ 98 : ℕ) : ℝ) : ℝ) : ℂ) := by
    rw [root_checked_1]
    apply Complex.ext <;>
      norm_num [RawHead.expIntegerValue, initial_1, rootNumerator_1]
  rw [he]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (RawHead.inverseRootCandidate_initialization_error (x := 1) (S := 2 ^ 98)
      (by decide) (by positivity))

theorem trace_length_1 : trace_1.length = 129 := by decide
theorem trace_head_1 : trace_1.head? = some initial_1 := by rfl

theorem range_checked_2 : 0 < (2 : ℕ) ∧ 1 ≤ (18 : ℕ) ∧
    2 ^ 1 ≤ (2 : ℕ) ∧ (2 : ℕ) ≤ 2 * 2 ^ 1 := by decide

theorem log_checked_2 : RawHead.log129Center 1 2 = logNumerator_2 := by
  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked 1 2).symm.trans
    RawLogCases.center_2

theorem root_checked_2 :
    RawHead.inverseRootCandidate 2 (2 ^ 98) = rootNumerator_2 := by
  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)
  · change (224091083899144559674927752909 : ℕ) * 224091083899144559674927752909 * 2 ≤ (2 ^ 98 : ℕ) * 2 ^ 98
    exact_mod_cast RawLogCases.sqrt_lo_2
  · change (2 ^ 98 : ℕ) * 2 ^ 98 < (224091083899144559674927752909 + 1) * (224091083899144559674927752909 + 1) * 2
    exact_mod_cast RawLogCases.sqrt_hi_2

theorem initial_checked_2 :
    ((RawHead.inverseRootCandidate 2 (2 ^ 98) : ℤ) * 2 ^ 22, 0) =
      initial_2 := by
  rw [root_checked_2]
  decide +kernel

theorem inner_step_checked_2 :
    RawHead.stepInnerFromLog logNumerator_2 = innerStep_2 := by decide +kernel

theorem step_from_log_checked_2 :
    RawHead.stepFromLog logNumerator_2 = step_2 := by
  rw [RawHead.stepFromLog, inner_step_checked_2]
  decide +kernel

theorem step_checked_2 : RawHead.rawStepNumerator 1 2 = step_2 := by
  rw [RawHead.rawStepNumerator, log_checked_2]
  exact step_from_log_checked_2

theorem step_error_2 :
    ‖RawHead.expIntegerValue (2 ^ 122) step_2 -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (2 : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have h := RawHead.rawStepValue_error (x := 2) (k := 1)
    (by decide) (by decide) (by decide) (by decide)
  simpa only [RawHead.rawStepValue, step_checked_2] using h

theorem initial_error_2 :
    ‖RawHead.expIntegerValue (2 ^ 120) initial_2 -
      RawHead.integerPower (2 : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have he : RawHead.expIntegerValue (2 ^ 120) initial_2 =
      (((RawHead.inverseRootCandidate 2 (2 ^ 98) : ℝ) /
        ((2 ^ 98 : ℕ) : ℝ) : ℝ) : ℂ) := by
    rw [root_checked_2]
    apply Complex.ext <;>
      norm_num [RawHead.expIntegerValue, initial_2, rootNumerator_2]
  rw [he]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (RawHead.inverseRootCandidate_initialization_error (x := 2) (S := 2 ^ 98)
      (by decide) (by positivity))

theorem trace_length_2 : trace_2.length = 129 := by decide
theorem trace_head_2 : trace_2.head? = some initial_2 := by rfl

theorem range_checked_3 : 0 < (3 : ℕ) ∧ 1 ≤ (18 : ℕ) ∧
    2 ^ 1 ≤ (3 : ℕ) ∧ (3 : ℕ) ≤ 2 * 2 ^ 1 := by decide

theorem log_checked_3 : RawHead.log129Center 1 3 = logNumerator_3 := by
  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked 1 3).symm.trans
    RawLogCases.center_3

theorem root_checked_3 :
    RawHead.inverseRootCandidate 3 (2 ^ 98) = rootNumerator_3 := by
  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)
  · change (182969603820039730136647482517 : ℕ) * 182969603820039730136647482517 * 3 ≤ (2 ^ 98 : ℕ) * 2 ^ 98
    exact_mod_cast RawLogCases.sqrt_lo_3
  · change (2 ^ 98 : ℕ) * 2 ^ 98 < (182969603820039730136647482517 + 1) * (182969603820039730136647482517 + 1) * 3
    exact_mod_cast RawLogCases.sqrt_hi_3

theorem initial_checked_3 :
    ((RawHead.inverseRootCandidate 3 (2 ^ 98) : ℤ) * 2 ^ 22, 0) =
      initial_3 := by
  rw [root_checked_3]
  decide +kernel

theorem inner_step_checked_3 :
    RawHead.stepInnerFromLog logNumerator_3 = innerStep_3 := by decide +kernel

theorem step_from_log_checked_3 :
    RawHead.stepFromLog logNumerator_3 = step_3 := by
  rw [RawHead.stepFromLog, inner_step_checked_3]
  decide +kernel

theorem step_checked_3 : RawHead.rawStepNumerator 1 3 = step_3 := by
  rw [RawHead.rawStepNumerator, log_checked_3]
  exact step_from_log_checked_3

theorem step_error_3 :
    ‖RawHead.expIntegerValue (2 ^ 122) step_3 -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (3 : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have h := RawHead.rawStepValue_error (x := 3) (k := 1)
    (by decide) (by decide) (by decide) (by decide)
  simpa only [RawHead.rawStepValue, step_checked_3] using h

theorem initial_error_3 :
    ‖RawHead.expIntegerValue (2 ^ 120) initial_3 -
      RawHead.integerPower (3 : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have he : RawHead.expIntegerValue (2 ^ 120) initial_3 =
      (((RawHead.inverseRootCandidate 3 (2 ^ 98) : ℝ) /
        ((2 ^ 98 : ℕ) : ℝ) : ℝ) : ℂ) := by
    rw [root_checked_3]
    apply Complex.ext <;>
      norm_num [RawHead.expIntegerValue, initial_3, rootNumerator_3]
  rw [he]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (RawHead.inverseRootCandidate_initialization_error (x := 3) (S := 2 ^ 98)
      (by decide) (by positivity))

theorem trace_length_3 : trace_3.length = 129 := by decide
theorem trace_head_3 : trace_3.head? = some initial_3 := by rfl

theorem range_checked_41 : 0 < (41 : ℕ) ∧ 5 ≤ (18 : ℕ) ∧
    2 ^ 5 ≤ (41 : ℕ) ∧ (41 : ℕ) ≤ 2 * 2 ^ 5 := by decide

theorem log_checked_41 : RawHead.log129Center 5 41 = logNumerator_41 := by
  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked 5 41).symm.trans
    RawLogCases.center_41

theorem root_checked_41 :
    RawHead.inverseRootCandidate 41 (2 ^ 98) = rootNumerator_41 := by
  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)
  · change (49493440749498014082648379236 : ℕ) * 49493440749498014082648379236 * 41 ≤ (2 ^ 98 : ℕ) * 2 ^ 98
    exact_mod_cast RawLogCases.sqrt_lo_41
  · change (2 ^ 98 : ℕ) * 2 ^ 98 < (49493440749498014082648379236 + 1) * (49493440749498014082648379236 + 1) * 41
    exact_mod_cast RawLogCases.sqrt_hi_41

theorem initial_checked_41 :
    ((RawHead.inverseRootCandidate 41 (2 ^ 98) : ℤ) * 2 ^ 22, 0) =
      initial_41 := by
  rw [root_checked_41]
  decide +kernel

theorem inner_step_checked_41 :
    RawHead.stepInnerFromLog logNumerator_41 = innerStep_41 := by decide +kernel

theorem step_from_log_checked_41 :
    RawHead.stepFromLog logNumerator_41 = step_41 := by
  rw [RawHead.stepFromLog, inner_step_checked_41]
  decide +kernel

theorem step_checked_41 : RawHead.rawStepNumerator 5 41 = step_41 := by
  rw [RawHead.rawStepNumerator, log_checked_41]
  exact step_from_log_checked_41

theorem step_error_41 :
    ‖RawHead.expIntegerValue (2 ^ 122) step_41 -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (41 : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have h := RawHead.rawStepValue_error (x := 41) (k := 5)
    (by decide) (by decide) (by decide) (by decide)
  simpa only [RawHead.rawStepValue, step_checked_41] using h

theorem initial_error_41 :
    ‖RawHead.expIntegerValue (2 ^ 120) initial_41 -
      RawHead.integerPower (41 : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have he : RawHead.expIntegerValue (2 ^ 120) initial_41 =
      (((RawHead.inverseRootCandidate 41 (2 ^ 98) : ℝ) /
        ((2 ^ 98 : ℕ) : ℝ) : ℝ) : ℂ) := by
    rw [root_checked_41]
    apply Complex.ext <;>
      norm_num [RawHead.expIntegerValue, initial_41, rootNumerator_41]
  rw [he]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (RawHead.inverseRootCandidate_initialization_error (x := 41) (S := 2 ^ 98)
      (by decide) (by positivity))

theorem trace_length_41 : trace_41.length = 129 := by decide
theorem trace_head_41 : trace_41.head? = some initial_41 := by rfl

theorem range_checked_61 : 0 < (61 : ℕ) ∧ 5 ≤ (18 : ℕ) ∧
    2 ^ 5 ≤ (61 : ℕ) ∧ (61 : ℕ) ≤ 2 * 2 ^ 5 := by decide

theorem log_checked_61 : RawHead.log129Center 5 61 = logNumerator_61 := by
  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked 5 61).symm.trans
    RawLogCases.center_61

theorem root_checked_61 :
    RawHead.inverseRootCandidate 61 (2 ^ 98) = rootNumerator_61 := by
  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)
  · change (40576506924571330310586784495 : ℕ) * 40576506924571330310586784495 * 61 ≤ (2 ^ 98 : ℕ) * 2 ^ 98
    exact_mod_cast RawLogCases.sqrt_lo_61
  · change (2 ^ 98 : ℕ) * 2 ^ 98 < (40576506924571330310586784495 + 1) * (40576506924571330310586784495 + 1) * 61
    exact_mod_cast RawLogCases.sqrt_hi_61

theorem initial_checked_61 :
    ((RawHead.inverseRootCandidate 61 (2 ^ 98) : ℤ) * 2 ^ 22, 0) =
      initial_61 := by
  rw [root_checked_61]
  decide +kernel

theorem inner_step_checked_61 :
    RawHead.stepInnerFromLog logNumerator_61 = innerStep_61 := by decide +kernel

theorem step_from_log_checked_61 :
    RawHead.stepFromLog logNumerator_61 = step_61 := by
  rw [RawHead.stepFromLog, inner_step_checked_61]
  decide +kernel

theorem step_checked_61 : RawHead.rawStepNumerator 5 61 = step_61 := by
  rw [RawHead.rawStepNumerator, log_checked_61]
  exact step_from_log_checked_61

theorem step_error_61 :
    ‖RawHead.expIntegerValue (2 ^ 122) step_61 -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (61 : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have h := RawHead.rawStepValue_error (x := 61) (k := 5)
    (by decide) (by decide) (by decide) (by decide)
  simpa only [RawHead.rawStepValue, step_checked_61] using h

theorem initial_error_61 :
    ‖RawHead.expIntegerValue (2 ^ 120) initial_61 -
      RawHead.integerPower (61 : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have he : RawHead.expIntegerValue (2 ^ 120) initial_61 =
      (((RawHead.inverseRootCandidate 61 (2 ^ 98) : ℝ) /
        ((2 ^ 98 : ℕ) : ℝ) : ℝ) : ℂ) := by
    rw [root_checked_61]
    apply Complex.ext <;>
      norm_num [RawHead.expIntegerValue, initial_61, rootNumerator_61]
  rw [he]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (RawHead.inverseRootCandidate_initialization_error (x := 61) (S := 2 ^ 98)
      (by decide) (by positivity))

theorem trace_length_61 : trace_61.length = 129 := by decide
theorem trace_head_61 : trace_61.head? = some initial_61 := by rfl

theorem range_checked_10004 : 0 < (10004 : ℕ) ∧ 13 ≤ (18 : ℕ) ∧
    2 ^ 13 ≤ (10004 : ℕ) ∧ (10004 : ℕ) ≤ 2 * 2 ^ 13 := by decide

theorem log_checked_10004 : RawHead.log129Center 13 10004 = logNumerator_10004 := by
  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked 13 10004).symm.trans
    RawLogCases.center_10004

theorem root_checked_10004 :
    RawHead.inverseRootCandidate 10004 (2 ^ 98) = rootNumerator_10004 := by
  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)
  · change (3168492865354689069166240814 : ℕ) * 3168492865354689069166240814 * 10004 ≤ (2 ^ 98 : ℕ) * 2 ^ 98
    exact_mod_cast RawLogCases.sqrt_lo_10004
  · change (2 ^ 98 : ℕ) * 2 ^ 98 < (3168492865354689069166240814 + 1) * (3168492865354689069166240814 + 1) * 10004
    exact_mod_cast RawLogCases.sqrt_hi_10004

theorem initial_checked_10004 :
    ((RawHead.inverseRootCandidate 10004 (2 ^ 98) : ℤ) * 2 ^ 22, 0) =
      initial_10004 := by
  rw [root_checked_10004]
  decide +kernel

theorem inner_step_checked_10004 :
    RawHead.stepInnerFromLog logNumerator_10004 = innerStep_10004 := by decide +kernel

theorem step_from_log_checked_10004 :
    RawHead.stepFromLog logNumerator_10004 = step_10004 := by
  rw [RawHead.stepFromLog, inner_step_checked_10004]
  decide +kernel

theorem step_checked_10004 : RawHead.rawStepNumerator 13 10004 = step_10004 := by
  rw [RawHead.rawStepNumerator, log_checked_10004]
  exact step_from_log_checked_10004

theorem step_error_10004 :
    ‖RawHead.expIntegerValue (2 ^ 122) step_10004 -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (10004 : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have h := RawHead.rawStepValue_error (x := 10004) (k := 13)
    (by decide) (by decide) (by decide) (by decide)
  simpa only [RawHead.rawStepValue, step_checked_10004] using h

theorem initial_error_10004 :
    ‖RawHead.expIntegerValue (2 ^ 120) initial_10004 -
      RawHead.integerPower (10004 : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have he : RawHead.expIntegerValue (2 ^ 120) initial_10004 =
      (((RawHead.inverseRootCandidate 10004 (2 ^ 98) : ℝ) /
        ((2 ^ 98 : ℕ) : ℝ) : ℝ) : ℂ) := by
    rw [root_checked_10004]
    apply Complex.ext <;>
      norm_num [RawHead.expIntegerValue, initial_10004, rootNumerator_10004]
  rw [he]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (RawHead.inverseRootCandidate_initialization_error (x := 10004) (S := 2 ^ 98)
      (by decide) (by positivity))

theorem trace_length_10004 : trace_10004.length = 129 := by decide
theorem trace_head_10004 : trace_10004.head? = some initial_10004 := by rfl

theorem range_checked_262144 : 0 < (262144 : ℕ) ∧ 18 ≤ (18 : ℕ) ∧
    2 ^ 18 ≤ (262144 : ℕ) ∧ (262144 : ℕ) ≤ 2 * 2 ^ 18 := by decide

theorem log_checked_262144 : RawHead.log129Center 18 262144 = logNumerator_262144 := by
  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked 18 262144).symm.trans
    RawLogCases.center_262144

theorem root_checked_262144 :
    RawHead.inverseRootCandidate 262144 (2 ^ 98) = rootNumerator_262144 := by
  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)
  · change (618970019642690137449562112 : ℕ) * 618970019642690137449562112 * 262144 ≤ (2 ^ 98 : ℕ) * 2 ^ 98
    exact_mod_cast RawLogCases.sqrt_lo_262144
  · change (2 ^ 98 : ℕ) * 2 ^ 98 < (618970019642690137449562112 + 1) * (618970019642690137449562112 + 1) * 262144
    exact_mod_cast RawLogCases.sqrt_hi_262144

theorem initial_checked_262144 :
    ((RawHead.inverseRootCandidate 262144 (2 ^ 98) : ℤ) * 2 ^ 22, 0) =
      initial_262144 := by
  rw [root_checked_262144]
  decide +kernel

theorem inner_step_checked_262144 :
    RawHead.stepInnerFromLog logNumerator_262144 = innerStep_262144 := by decide +kernel

theorem step_from_log_checked_262144 :
    RawHead.stepFromLog logNumerator_262144 = step_262144 := by
  rw [RawHead.stepFromLog, inner_step_checked_262144]
  decide +kernel

theorem step_checked_262144 : RawHead.rawStepNumerator 18 262144 = step_262144 := by
  rw [RawHead.rawStepNumerator, log_checked_262144]
  exact step_from_log_checked_262144

theorem step_error_262144 :
    ‖RawHead.expIntegerValue (2 ^ 122) step_262144 -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (262144 : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have h := RawHead.rawStepValue_error (x := 262144) (k := 18)
    (by decide) (by decide) (by decide) (by decide)
  simpa only [RawHead.rawStepValue, step_checked_262144] using h

theorem initial_error_262144 :
    ‖RawHead.expIntegerValue (2 ^ 120) initial_262144 -
      RawHead.integerPower (262144 : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have he : RawHead.expIntegerValue (2 ^ 120) initial_262144 =
      (((RawHead.inverseRootCandidate 262144 (2 ^ 98) : ℝ) /
        ((2 ^ 98 : ℕ) : ℝ) : ℝ) : ℂ) := by
    rw [root_checked_262144]
    apply Complex.ext <;>
      norm_num [RawHead.expIntegerValue, initial_262144, rootNumerator_262144]
  rw [he]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (RawHead.inverseRootCandidate_initialization_error (x := 262144) (S := 2 ^ 98)
      (by decide) (by positivity))

theorem trace_length_262144 : trace_262144.length = 129 := by decide
theorem trace_head_262144 : trace_262144.head? = some initial_262144 := by rfl

theorem range_checked_265800 : 0 < (265800 : ℕ) ∧ 18 ≤ (18 : ℕ) ∧
    2 ^ 18 ≤ (265800 : ℕ) ∧ (265800 : ℕ) ≤ 2 * 2 ^ 18 := by decide

theorem log_checked_265800 : RawHead.log129Center 18 265800 = logNumerator_265800 := by
  exact (RawHead.log129WithLogTwo_eq RawLogCases.logTwo_checked 18 265800).symm.trans
    RawLogCases.center_265800

theorem root_checked_265800 :
    RawHead.inverseRootCandidate 265800 (2 ^ 98) = rootNumerator_265800 := by
  apply RawHead.inverseRootCandidate_eq_of_square_bounds (by decide)
  · change (614698405761597740186252768 : ℕ) * 614698405761597740186252768 * 265800 ≤ (2 ^ 98 : ℕ) * 2 ^ 98
    exact_mod_cast RawLogCases.sqrt_lo_265800
  · change (2 ^ 98 : ℕ) * 2 ^ 98 < (614698405761597740186252768 + 1) * (614698405761597740186252768 + 1) * 265800
    exact_mod_cast RawLogCases.sqrt_hi_265800

theorem initial_checked_265800 :
    ((RawHead.inverseRootCandidate 265800 (2 ^ 98) : ℤ) * 2 ^ 22, 0) =
      initial_265800 := by
  rw [root_checked_265800]
  decide +kernel

theorem inner_step_checked_265800 :
    RawHead.stepInnerFromLog logNumerator_265800 = innerStep_265800 := by decide +kernel

theorem step_from_log_checked_265800 :
    RawHead.stepFromLog logNumerator_265800 = step_265800 := by
  rw [RawHead.stepFromLog, inner_step_checked_265800]
  decide +kernel

theorem step_checked_265800 : RawHead.rawStepNumerator 18 265800 = step_265800 := by
  rw [RawHead.rawStepNumerator, log_checked_265800]
  exact step_from_log_checked_265800

theorem step_error_265800 :
    ‖RawHead.expIntegerValue (2 ^ 122) step_265800 -
      Complex.exp (Complex.I * (-(5 / 64 : ℝ) * Real.log (265800 : ℝ)))‖ <
      1 / (2 : ℝ) ^ 120 := by
  have h := RawHead.rawStepValue_error (x := 265800) (k := 18)
    (by decide) (by decide) (by decide) (by decide)
  simpa only [RawHead.rawStepValue, step_checked_265800] using h

theorem initial_error_265800 :
    ‖RawHead.expIntegerValue (2 ^ 120) initial_265800 -
      RawHead.integerPower (265800 : ℝ) 0‖ < 1 / (2 : ℝ) ^ 98 := by
  have he : RawHead.expIntegerValue (2 ^ 120) initial_265800 =
      (((RawHead.inverseRootCandidate 265800 (2 ^ 98) : ℝ) /
        ((2 ^ 98 : ℕ) : ℝ) : ℝ) : ℂ) := by
    rw [root_checked_265800]
    apply Complex.ext <;>
      norm_num [RawHead.expIntegerValue, initial_265800, rootNumerator_265800]
  rw [he]
  simpa only [Nat.cast_pow, Nat.cast_ofNat] using
    (RawHead.inverseRootCandidate_initialization_error (x := 265800) (S := 2 ^ 98)
      (by decide) (by positivity))

theorem trace_length_265800 : trace_265800.length = 129 := by decide
theorem trace_head_265800 : trace_265800.head? = some initial_265800 := by rfl

theorem base_count : baseOrder.length = 8 := by decide
theorem trace_count : allTraces.length = 8 := by decide

end RawStateSources
