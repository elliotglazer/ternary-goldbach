import RawLogAssembly
import RawInverseRoot

namespace RawLogData

def logTwo137 : ℤ := 120763270771462806598627401095247096012418
end RawLogData

namespace RawLogCases
open RawLogData

theorem logTwo_checked : logTwo137 = RawHead.logCenter (2 ^ 137) 1 3 45 := by decide +kernel

theorem center_1 : RawHead.log129WithLogTwo logTwo137 0 1 = 0 := by decide +kernel
theorem log_1 : |Real.log (1 : ℝ) - (0 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 0 1
  have hc : RawHead.log129Center 0 1 = 0 := he.symm.trans center_1
  have h := RawHead.log129Center_error (x := 1) (k := 0) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_one, Int.cast_zero] using h

theorem sqrt_lo_1 : (316912650057057350374175801344 : ℤ) * 316912650057057350374175801344 * 1 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_1 : (2 ^ 98 : ℤ) * 2 ^ 98 < (316912650057057350374175801344 + 1) * (316912650057057350374175801344 + 1) * 1 := by decide +kernel
theorem inverse_sqrt_1 :
    0 ≤ (Real.sqrt (1 : ℝ))⁻¹ - (316912650057057350374175801344 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (1 : ℝ))⁻¹ - (316912650057057350374175801344 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 1) (S := 2 ^ 98) (m := 316912650057057350374175801344)
    (by decide) (by decide) sqrt_lo_1 sqrt_hi_1
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one, Int.cast_ofNat] using h

theorem center_2 : RawHead.log129WithLogTwo logTwo137 1 2 = 471731526451026588275888285528308968799 := by decide +kernel
theorem log_2 : |Real.log (2 : ℝ) - (471731526451026588275888285528308968799 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 1 2
  have hc : RawHead.log129Center 1 2 = 471731526451026588275888285528308968799 := he.symm.trans center_2
  have h := RawHead.log129Center_error (x := 2) (k := 1) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_2 : (224091083899144559674927752909 : ℤ) * 224091083899144559674927752909 * 2 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_2 : (2 ^ 98 : ℤ) * 2 ^ 98 < (224091083899144559674927752909 + 1) * (224091083899144559674927752909 + 1) * 2 := by decide +kernel
theorem inverse_sqrt_2 :
    0 ≤ (Real.sqrt (2 : ℝ))⁻¹ - (224091083899144559674927752909 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (2 : ℝ))⁻¹ - (224091083899144559674927752909 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 2) (S := 2 ^ 98) (m := 224091083899144559674927752909)
    (by decide) (by decide) sqrt_lo_2 sqrt_hi_2
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_3 : RawHead.log129WithLogTwo logTwo137 1 3 = 747676779832827335206988369320941648235 := by decide +kernel
theorem log_3 : |Real.log (3 : ℝ) - (747676779832827335206988369320941648235 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 1 3
  have hc : RawHead.log129Center 1 3 = 747676779832827335206988369320941648235 := he.symm.trans center_3
  have h := RawHead.log129Center_error (x := 3) (k := 1) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_3 : (182969603820039730136647482517 : ℤ) * 182969603820039730136647482517 * 3 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_3 : (2 ^ 98 : ℤ) * 2 ^ 98 < (182969603820039730136647482517 + 1) * (182969603820039730136647482517 + 1) * 3 := by decide +kernel
theorem inverse_sqrt_3 :
    0 ≤ (Real.sqrt (3 : ℝ))⁻¹ - (182969603820039730136647482517 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (3 : ℝ))⁻¹ - (182969603820039730136647482517 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 3) (S := 2 ^ 98) (m := 182969603820039730136647482517)
    (by decide) (by decide) sqrt_lo_3 sqrt_hi_3
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_41 : RawHead.log129WithLogTwo logTwo137 5 41 = 2527326185179246069926439784579921922813 := by decide +kernel
theorem log_41 : |Real.log (41 : ℝ) - (2527326185179246069926439784579921922813 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 5 41
  have hc : RawHead.log129Center 5 41 = 2527326185179246069926439784579921922813 := he.symm.trans center_41
  have h := RawHead.log129Center_error (x := 41) (k := 5) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_41 : (49493440749498014082648379236 : ℤ) * 49493440749498014082648379236 * 41 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_41 : (2 ^ 98 : ℤ) * 2 ^ 98 < (49493440749498014082648379236 + 1) * (49493440749498014082648379236 + 1) * 41 := by decide +kernel
theorem inverse_sqrt_41 :
    0 ≤ (Real.sqrt (41 : ℝ))⁻¹ - (49493440749498014082648379236 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (41 : ℝ))⁻¹ - (49493440749498014082648379236 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 41) (S := 2 ^ 98) (m := 49493440749498014082648379236)
    (by decide) (by decide) sqrt_lo_41 sqrt_hi_41
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_61 : RawHead.log129WithLogTwo logTwo137 5 61 = 2797715777228637691486103639917651953077 := by decide +kernel
theorem log_61 : |Real.log (61 : ℝ) - (2797715777228637691486103639917651953077 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 5 61
  have hc : RawHead.log129Center 5 61 = 2797715777228637691486103639917651953077 := he.symm.trans center_61
  have h := RawHead.log129Center_error (x := 61) (k := 5) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_61 : (40576506924571330310586784495 : ℤ) * 40576506924571330310586784495 * 61 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_61 : (2 ^ 98 : ℤ) * 2 ^ 98 < (40576506924571330310586784495 + 1) * (40576506924571330310586784495 + 1) * 61 := by decide +kernel
theorem inverse_sqrt_61 :
    0 ≤ (Real.sqrt (61 : ℝ))⁻¹ - (40576506924571330310586784495 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (61 : ℝ))⁻¹ - (40576506924571330310586784495 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 61) (S := 2 ^ 98) (m := 40576506924571330310586784495)
    (by decide) (by decide) sqrt_lo_61 sqrt_hi_61
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_10004 : RawHead.log129WithLogTwo logTwo137 13 10004 = 6268505015309936937964319995554191813487 := by decide +kernel
theorem log_10004 : |Real.log (10004 : ℝ) - (6268505015309936937964319995554191813487 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 13 10004
  have hc : RawHead.log129Center 13 10004 = 6268505015309936937964319995554191813487 := he.symm.trans center_10004
  have h := RawHead.log129Center_error (x := 10004) (k := 13) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_10004 : (3168492865354689069166240814 : ℤ) * 3168492865354689069166240814 * 10004 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_10004 : (2 ^ 98 : ℤ) * 2 ^ 98 < (3168492865354689069166240814 + 1) * (3168492865354689069166240814 + 1) * 10004 := by decide +kernel
theorem inverse_sqrt_10004 :
    0 ≤ (Real.sqrt (10004 : ℝ))⁻¹ - (3168492865354689069166240814 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (10004 : ℝ))⁻¹ - (3168492865354689069166240814 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 10004) (S := 2 ^ 98) (m := 3168492865354689069166240814)
    (by decide) (by decide) sqrt_lo_10004 sqrt_hi_10004
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_262144 : RawHead.log129WithLogTwo logTwo137 18 262144 = 8491167476118478588965989139509561438373 := by decide +kernel
theorem log_262144 : |Real.log (262144 : ℝ) - (8491167476118478588965989139509561438373 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 18 262144
  have hc : RawHead.log129Center 18 262144 = 8491167476118478588965989139509561438373 := he.symm.trans center_262144
  have h := RawHead.log129Center_error (x := 262144) (k := 18) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_262144 : (618970019642690137449562112 : ℤ) * 618970019642690137449562112 * 262144 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_262144 : (2 ^ 98 : ℤ) * 2 ^ 98 < (618970019642690137449562112 + 1) * (618970019642690137449562112 + 1) * 262144 := by decide +kernel
theorem inverse_sqrt_262144 :
    0 ≤ (Real.sqrt (262144 : ℝ))⁻¹ - (618970019642690137449562112 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (262144 : ℝ))⁻¹ - (618970019642690137449562112 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 262144) (S := 2 ^ 98) (m := 618970019642690137449562112)
    (by decide) (by decide) sqrt_lo_262144 sqrt_hi_262144
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_265800 : RawHead.log129WithLogTwo logTwo137 18 265800 = 8500593416905061116206355418484978263797 := by decide +kernel
theorem log_265800 : |Real.log (265800 : ℝ) - (8500593416905061116206355418484978263797 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 18 265800
  have hc : RawHead.log129Center 18 265800 = 8500593416905061116206355418484978263797 := he.symm.trans center_265800
  have h := RawHead.log129Center_error (x := 265800) (k := 18) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_265800 : (614698405761597740186252768 : ℤ) * 614698405761597740186252768 * 265800 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_265800 : (2 ^ 98 : ℤ) * 2 ^ 98 < (614698405761597740186252768 + 1) * (614698405761597740186252768 + 1) * 265800 := by decide +kernel
theorem inverse_sqrt_265800 :
    0 ≤ (Real.sqrt (265800 : ℝ))⁻¹ - (614698405761597740186252768 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (265800 : ℝ))⁻¹ - (614698405761597740186252768 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 265800) (S := 2 ^ 98) (m := 614698405761597740186252768)
    (by decide) (by decide) sqrt_lo_265800 sqrt_hi_265800
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem all_logs :
    |Real.log (1 : ℝ) - (0 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (2 : ℝ) - (471731526451026588275888285528308968799 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (3 : ℝ) - (747676779832827335206988369320941648235 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (41 : ℝ) - (2527326185179246069926439784579921922813 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (61 : ℝ) - (2797715777228637691486103639917651953077 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (10004 : ℝ) - (6268505015309936937964319995554191813487 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (262144 : ℝ) - (8491167476118478588965989139509561438373 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (265800 : ℝ) - (8500593416905061116206355418484978263797 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  exact ⟨log_1, log_2, log_3, log_41, log_61, log_10004, log_262144, log_265800⟩

theorem all_inverse_roots :
    (0 ≤ (Real.sqrt (1 : ℝ))⁻¹ - (316912650057057350374175801344 : ℝ) / 2 ^ 98 ∧ (Real.sqrt (1 : ℝ))⁻¹ - (316912650057057350374175801344 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ)) ∧
    (0 ≤ (Real.sqrt (2 : ℝ))⁻¹ - (224091083899144559674927752909 : ℝ) / 2 ^ 98 ∧ (Real.sqrt (2 : ℝ))⁻¹ - (224091083899144559674927752909 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ)) ∧
    (0 ≤ (Real.sqrt (3 : ℝ))⁻¹ - (182969603820039730136647482517 : ℝ) / 2 ^ 98 ∧ (Real.sqrt (3 : ℝ))⁻¹ - (182969603820039730136647482517 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ)) ∧
    (0 ≤ (Real.sqrt (41 : ℝ))⁻¹ - (49493440749498014082648379236 : ℝ) / 2 ^ 98 ∧ (Real.sqrt (41 : ℝ))⁻¹ - (49493440749498014082648379236 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ)) ∧
    (0 ≤ (Real.sqrt (61 : ℝ))⁻¹ - (40576506924571330310586784495 : ℝ) / 2 ^ 98 ∧ (Real.sqrt (61 : ℝ))⁻¹ - (40576506924571330310586784495 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ)) ∧
    (0 ≤ (Real.sqrt (10004 : ℝ))⁻¹ - (3168492865354689069166240814 : ℝ) / 2 ^ 98 ∧ (Real.sqrt (10004 : ℝ))⁻¹ - (3168492865354689069166240814 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ)) ∧
    (0 ≤ (Real.sqrt (262144 : ℝ))⁻¹ - (618970019642690137449562112 : ℝ) / 2 ^ 98 ∧ (Real.sqrt (262144 : ℝ))⁻¹ - (618970019642690137449562112 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ)) ∧
    (0 ≤ (Real.sqrt (265800 : ℝ))⁻¹ - (614698405761597740186252768 : ℝ) / 2 ^ 98 ∧ (Real.sqrt (265800 : ℝ))⁻¹ - (614698405761597740186252768 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ)) := by
  exact ⟨inverse_sqrt_1, inverse_sqrt_2, inverse_sqrt_3, inverse_sqrt_41, inverse_sqrt_61, inverse_sqrt_10004, inverse_sqrt_262144, inverse_sqrt_265800⟩

end RawLogCases
