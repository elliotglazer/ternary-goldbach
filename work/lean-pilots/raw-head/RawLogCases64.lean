import RawLogAssembly
import RawInverseRoot

namespace RawLogData64

def logTwo137 : ℤ := 120763270771462806598627401095247096012418
end RawLogData64

namespace RawLogCases64
open RawLogData64

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

theorem center_4664 : RawHead.log129WithLogTwo logTwo137 12 4664 = 5749158196886953713159301303219076447387 := by decide +kernel
theorem log_4664 : |Real.log (4664 : ℝ) - (5749158196886953713159301303219076447387 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 12 4664
  have hc : RawHead.log129Center 12 4664 = 5749158196886953713159301303219076447387 := he.symm.trans center_4664
  have h := RawHead.log129Center_error (x := 4664) (k := 12) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_4664 : (4640452207583157390272626050 : ℤ) * 4640452207583157390272626050 * 4664 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_4664 : (2 ^ 98 : ℤ) * 2 ^ 98 < (4640452207583157390272626050 + 1) * (4640452207583157390272626050 + 1) * 4664 := by decide +kernel
theorem inverse_sqrt_4664 :
    0 ≤ (Real.sqrt (4664 : ℝ))⁻¹ - (4640452207583157390272626050 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (4664 : ℝ))⁻¹ - (4640452207583157390272626050 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 4664) (S := 2 ^ 98) (m := 4640452207583157390272626050)
    (by decide) (by decide) sqrt_lo_4664 sqrt_hi_4664
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_9327 : RawHead.log129WithLogTwo logTwo137 13 9327 = 6220816760085823373860640099499356620994 := by decide +kernel
theorem log_9327 : |Real.log (9327 : ℝ) - (6220816760085823373860640099499356620994 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 13 9327
  have hc : RawHead.log129Center 13 9327 = 6220816760085823373860640099499356620994 := he.symm.trans center_9327
  have h := RawHead.log129Center_error (x := 9327) (k := 13) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_9327 : (3281471122074975169753976205 : ℤ) * 3281471122074975169753976205 * 9327 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_9327 : (2 ^ 98 : ℤ) * 2 ^ 98 < (3281471122074975169753976205 + 1) * (3281471122074975169753976205 + 1) * 9327 := by decide +kernel
theorem inverse_sqrt_9327 :
    0 ≤ (Real.sqrt (9327 : ℝ))⁻¹ - (3281471122074975169753976205 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (9327 : ℝ))⁻¹ - (3281471122074975169753976205 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 9327) (S := 2 ^ 98) (m := 3281471122074975169753976205)
    (by decide) (by decide) sqrt_lo_9327 sqrt_hi_9327
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

theorem center_13990 : RawHead.log129WithLogTwo logTwo137 13 13990 = 6496737690645161537323658921227865348830 := by decide +kernel
theorem log_13990 : |Real.log (13990 : ℝ) - (6496737690645161537323658921227865348830 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 13 13990
  have hc : RawHead.log129Center 13 13990 = 6496737690645161537323658921227865348830 := he.symm.trans center_13990
  have h := RawHead.log129Center_error (x := 13990) (k := 13) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_13990 : (2679357830179360703381976645 : ℤ) * 2679357830179360703381976645 * 13990 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_13990 : (2 ^ 98 : ℤ) * 2 ^ 98 < (2679357830179360703381976645 + 1) * (2679357830179360703381976645 + 1) * 13990 := by decide +kernel
theorem inverse_sqrt_13990 :
    0 ≤ (Real.sqrt (13990 : ℝ))⁻¹ - (2679357830179360703381976645 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (13990 : ℝ))⁻¹ - (2679357830179360703381976645 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 13990) (S := 2 ^ 98) (m := 2679357830179360703381976645)
    (by decide) (by decide) sqrt_lo_13990 sqrt_hi_13990
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_18653 : RawHead.log129WithLogTwo logTwo137 14 18653 = 6692511801977169212175747126022131584826 := by decide +kernel
theorem log_18653 : |Real.log (18653 : ℝ) - (6692511801977169212175747126022131584826 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 14 18653
  have hc : RawHead.log129Center 14 18653 = 6692511801977169212175747126022131584826 := he.symm.trans center_18653
  have h := RawHead.log129Center_error (x := 18653) (k := 14) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_18653 : (2320412679636184380219856694 : ℤ) * 2320412679636184380219856694 * 18653 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_18653 : (2 ^ 98 : ℤ) * 2 ^ 98 < (2320412679636184380219856694 + 1) * (2320412679636184380219856694 + 1) * 18653 := by decide +kernel
theorem inverse_sqrt_18653 :
    0 ≤ (Real.sqrt (18653 : ℝ))⁻¹ - (2320412679636184380219856694 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (18653 : ℝ))⁻¹ - (2320412679636184380219856694 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 18653) (S := 2 ^ 98) (m := 2320412679636184380219856694)
    (by decide) (by decide) sqrt_lo_18653 sqrt_hi_18653
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_23316 : RawHead.log129WithLogTwo logTwo137 14 23316 = 6844368136439204407178328053929940755075 := by decide +kernel
theorem log_23316 : |Real.log (23316 : ℝ) - (6844368136439204407178328053929940755075 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 14 23316
  have hc : RawHead.log129Center 14 23316 = 6844368136439204407178328053929940755075 := he.symm.trans center_23316
  have h := RawHead.log129Center_error (x := 23316) (k := 14) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_23316 : (2075451321672915545390039079 : ℤ) * 2075451321672915545390039079 * 23316 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_23316 : (2 ^ 98 : ℤ) * 2 ^ 98 < (2075451321672915545390039079 + 1) * (2075451321672915545390039079 + 1) * 23316 := by decide +kernel
theorem inverse_sqrt_23316 :
    0 ≤ (Real.sqrt (23316 : ℝ))⁻¹ - (2075451321672915545390039079 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (23316 : ℝ))⁻¹ - (2075451321672915545390039079 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 23316) (S := 2 ^ 98) (m := 2075451321672915545390039079)
    (by decide) (by decide) sqrt_lo_23316 sqrt_hi_23316
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_27979 : RawHead.log129WithLogTwo logTwo137 14 27979 = 6968444893404416852992574140032324220268 := by decide +kernel
theorem log_27979 : |Real.log (27979 : ℝ) - (6968444893404416852992574140032324220268 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 14 27979
  have hc : RawHead.log129Center 14 27979 = 6968444893404416852992574140032324220268 := he.symm.trans center_27979
  have h := RawHead.log129Center_error (x := 27979) (k := 14) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_27979 : (1894625948037250337644420244 : ℤ) * 1894625948037250337644420244 * 27979 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_27979 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1894625948037250337644420244 + 1) * (1894625948037250337644420244 + 1) * 27979 := by decide +kernel
theorem inverse_sqrt_27979 :
    0 ≤ (Real.sqrt (27979 : ℝ))⁻¹ - (1894625948037250337644420244 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (27979 : ℝ))⁻¹ - (1894625948037250337644420244 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 27979) (S := 2 ^ 98) (m := 1894625948037250337644420244)
    (by decide) (by decide) sqrt_lo_27979 sqrt_hi_27979
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_32642 : RawHead.log129WithLogTwo logTwo137 14 32642 = 7073350934908521507857802870273973580843 := by decide +kernel
theorem log_32642 : |Real.log (32642 : ℝ) - (7073350934908521507857802870273973580843 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 14 32642
  have hc : RawHead.log129Center 14 32642 = 7073350934908521507857802870273973580843 := he.symm.trans center_32642
  have h := RawHead.log129Center_error (x := 32642) (k := 14) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_32642 : (1754087262320185231286794907 : ℤ) * 1754087262320185231286794907 * 32642 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_32642 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1754087262320185231286794907 + 1) * (1754087262320185231286794907 + 1) * 32642 := by decide +kernel
theorem inverse_sqrt_32642 :
    0 ≤ (Real.sqrt (32642 : ℝ))⁻¹ - (1754087262320185231286794907 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (32642 : ℝ))⁻¹ - (1754087262320185231286794907 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 32642) (S := 2 ^ 98) (m := 1754087262320185231286794907)
    (by decide) (by decide) sqrt_lo_32642 sqrt_hi_32642
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_37306 : RawHead.log129WithLogTwo logTwo137 15 37306 = 7164243328428195800451635411550440553624 := by decide +kernel
theorem log_37306 : |Real.log (37306 : ℝ) - (7164243328428195800451635411550440553624 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 15 37306
  have hc : RawHead.log129Center 15 37306 = 7164243328428195800451635411550440553624 := he.symm.trans center_37306
  have h := RawHead.log129Center_error (x := 37306) (k := 15) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_37306 : (1640779540921993829194202696 : ℤ) * 1640779540921993829194202696 * 37306 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_37306 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1640779540921993829194202696 + 1) * (1640779540921993829194202696 + 1) * 37306 := by decide +kernel
theorem inverse_sqrt_37306 :
    0 ≤ (Real.sqrt (37306 : ℝ))⁻¹ - (1640779540921993829194202696 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (37306 : ℝ))⁻¹ - (1640779540921993829194202696 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 37306) (S := 2 ^ 98) (m := 1640779540921993829194202696)
    (by decide) (by decide) sqrt_lo_37306 sqrt_hi_37306
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_41969 : RawHead.log129WithLogTwo logTwo137 15 41969 = 7244398254780068380880468637234054925435 := by decide +kernel
theorem log_41969 : |Real.log (41969 : ℝ) - (7244398254780068380880468637234054925435 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 15 41969
  have hc : RawHead.log129Center 15 41969 = 7244398254780068380880468637234054925435 := he.symm.trans center_41969
  have h := RawHead.log129Center_error (x := 41969) (k := 15) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_41969 : (1546946393811369262477775168 : ℤ) * 1546946393811369262477775168 * 41969 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_41969 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1546946393811369262477775168 + 1) * (1546946393811369262477775168 + 1) * 41969 := by decide +kernel
theorem inverse_sqrt_41969 :
    0 ≤ (Real.sqrt (41969 : ℝ))⁻¹ - (1546946393811369262477775168 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (41969 : ℝ))⁻¹ - (1546946393811369262477775168 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 41969) (S := 2 ^ 98) (m := 1546946393811369262477775168)
    (by decide) (by decide) sqrt_lo_41969 sqrt_hi_41969
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_46632 : RawHead.log129WithLogTwo logTwo137 15 46632 = 7316099662890230995454216339458249723873 := by decide +kernel
theorem log_46632 : |Real.log (46632 : ℝ) - (7316099662890230995454216339458249723873 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 15 46632
  have hc : RawHead.log129Center 15 46632 = 7316099662890230995454216339458249723873 := he.symm.trans center_46632
  have h := RawHead.log129Center_error (x := 46632) (k := 15) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_46632 : (1467565703577501152258152816 : ℤ) * 1467565703577501152258152816 * 46632 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_46632 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1467565703577501152258152816 + 1) * (1467565703577501152258152816 + 1) * 46632 := by decide +kernel
theorem inverse_sqrt_46632 :
    0 ≤ (Real.sqrt (46632 : ℝ))⁻¹ - (1467565703577501152258152816 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (46632 : ℝ))⁻¹ - (1467565703577501152258152816 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 46632) (S := 2 ^ 98) (m := 1467565703577501152258152816)
    (by decide) (by decide) sqrt_lo_46632 sqrt_hi_46632
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_51295 : RawHead.log129WithLogTwo logTwo137 15 51295 = 7380961756513910805024645818797896950983 := by decide +kernel
theorem log_51295 : |Real.log (51295 : ℝ) - (7380961756513910805024645818797896950983 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 15 51295
  have hc : RawHead.log129Center 15 51295 = 7380961756513910805024645818797896950983 := he.symm.trans center_51295
  have h := RawHead.log129Center_error (x := 51295) (k := 15) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_51295 : (1399271723504124967036089935 : ℤ) * 1399271723504124967036089935 * 51295 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_51295 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1399271723504124967036089935 + 1) * (1399271723504124967036089935 + 1) * 51295 := by decide +kernel
theorem inverse_sqrt_51295 :
    0 ≤ (Real.sqrt (51295 : ℝ))⁻¹ - (1399271723504124967036089935 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (51295 : ℝ))⁻¹ - (1399271723504124967036089935 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 51295) (S := 2 ^ 98) (m := 1399271723504124967036089935)
    (by decide) (by decide) sqrt_lo_51295 sqrt_hi_51295
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_55958 : RawHead.log129WithLogTwo logTwo137 15 55958 = 7440176419855443441268462425560633189066 := by decide +kernel
theorem log_55958 : |Real.log (55958 : ℝ) - (7440176419855443441268462425560633189066 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 15 55958
  have hc : RawHead.log129Center 15 55958 = 7440176419855443441268462425560633189066 := he.symm.trans center_55958
  have h := RawHead.log129Center_error (x := 55958) (k := 15) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_55958 : (1339702855669131134614860961 : ℤ) * 1339702855669131134614860961 * 55958 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_55958 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1339702855669131134614860961 + 1) * (1339702855669131134614860961 + 1) * 55958 := by decide +kernel
theorem inverse_sqrt_55958 :
    0 ≤ (Real.sqrt (55958 : ℝ))⁻¹ - (1339702855669131134614860961 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (55958 : ℝ))⁻¹ - (1339702855669131134614860961 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 55958) (S := 2 ^ 98) (m := 1339702855669131134614860961)
    (by decide) (by decide) sqrt_lo_55958 sqrt_hi_55958
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_60621 : RawHead.log129WithLogTwo logTwo137 15 60621 = 7494648792810045093353647265138289412912 := by decide +kernel
theorem log_60621 : |Real.log (60621 : ℝ) - (7494648792810045093353647265138289412912 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 15 60621
  have hc : RawHead.log129Center 15 60621 = 7494648792810045093353647265138289412912 := he.symm.trans center_60621
  have h := RawHead.log129Center_error (x := 60621) (k := 15) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_60621 : (1287146638941031808927232409 : ℤ) * 1287146638941031808927232409 * 60621 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_60621 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1287146638941031808927232409 + 1) * (1287146638941031808927232409 + 1) * 60621 := by decide +kernel
theorem inverse_sqrt_60621 :
    0 ≤ (Real.sqrt (60621 : ℝ))⁻¹ - (1287146638941031808927232409 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (60621 : ℝ))⁻¹ - (1287146638941031808927232409 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 60621) (S := 2 ^ 98) (m := 1287146638941031808927232409)
    (by decide) (by decide) sqrt_lo_60621 sqrt_hi_60621
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_65284 : RawHead.log129WithLogTwo logTwo137 15 65284 = 7545082461359548096133691155802282549642 := by decide +kernel
theorem log_65284 : |Real.log (65284 : ℝ) - (7545082461359548096133691155802282549642 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 15 65284
  have hc : RawHead.log129Center 15 65284 = 7545082461359548096133691155802282549642 := he.symm.trans center_65284
  have h := RawHead.log129Center_error (x := 65284) (k := 15) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_65284 : (1240326997979549406587831074 : ℤ) * 1240326997979549406587831074 * 65284 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_65284 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1240326997979549406587831074 + 1) * (1240326997979549406587831074 + 1) * 65284 := by decide +kernel
theorem inverse_sqrt_65284 :
    0 ≤ (Real.sqrt (65284 : ℝ))⁻¹ - (1240326997979549406587831074 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (65284 : ℝ))⁻¹ - (1240326997979549406587831074 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 65284) (S := 2 ^ 98) (m := 1240326997979549406587831074)
    (by decide) (by decide) sqrt_lo_65284 sqrt_hi_65284
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_69948 : RawHead.log129WithLogTwo logTwo137 16 69948 = 7592044916272031742385316423250882403310 := by decide +kernel
theorem log_69948 : |Real.log (69948 : ℝ) - (7592044916272031742385316423250882403310 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 69948
  have hc : RawHead.log129Center 16 69948 = 7592044916272031742385316423250882403310 := he.symm.trans center_69948
  have h := RawHead.log129Center_error (x := 69948) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_69948 : (1198262379257822363718970650 : ℤ) * 1198262379257822363718970650 * 69948 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_69948 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1198262379257822363718970650 + 1) * (1198262379257822363718970650 + 1) * 69948 := by decide +kernel
theorem inverse_sqrt_69948 :
    0 ≤ (Real.sqrt (69948 : ℝ))⁻¹ - (1198262379257822363718970650 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (69948 : ℝ))⁻¹ - (1198262379257822363718970650 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 69948) (S := 2 ^ 98) (m := 1198262379257822363718970650)
    (by decide) (by decide) sqrt_lo_69948 sqrt_hi_69948
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_74611 : RawHead.log129WithLogTwo logTwo137 16 74611 = 7635965733433683134528924791566292013469 := by decide +kernel
theorem log_74611 : |Real.log (74611 : ℝ) - (7635965733433683134528924791566292013469 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 74611
  have hc : RawHead.log129Center 16 74611 = 7635965733433683134528924791566292013469 := he.symm.trans center_74611
  have h := RawHead.log129Center_error (x := 74611) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_74611 : (1160214114827489775045262280 : ℤ) * 1160214114827489775045262280 * 74611 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_74611 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1160214114827489775045262280 + 1) * (1160214114827489775045262280 + 1) * 74611 := by decide +kernel
theorem inverse_sqrt_74611 :
    0 ≤ (Real.sqrt (74611 : ℝ))⁻¹ - (1160214114827489775045262280 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (74611 : ℝ))⁻¹ - (1160214114827489775045262280 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 74611) (S := 2 ^ 98) (m := 1160214114827489775045262280)
    (by decide) (by decide) sqrt_lo_74611 sqrt_hi_74611
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_79274 : RawHead.log129WithLogTwo logTwo137 16 79274 = 7677223103364899038100670194832002734534 := by decide +kernel
theorem log_79274 : |Real.log (79274 : ℝ) - (7677223103364899038100670194832002734534 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 79274
  have hc : RawHead.log129Center 16 79274 = 7677223103364899038100670194832002734534 := he.symm.trans center_79274
  have h := RawHead.log129Center_error (x := 79274) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_79274 : (1125574353172571992323330509 : ℤ) * 1125574353172571992323330509 * 79274 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_79274 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1125574353172571992323330509 + 1) * (1125574353172571992323330509 + 1) * 79274 := by decide +kernel
theorem inverse_sqrt_79274 :
    0 ≤ (Real.sqrt (79274 : ℝ))⁻¹ - (1125574353172571992323330509 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (79274 : ℝ))⁻¹ - (1125574353172571992323330509 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 79274) (S := 2 ^ 98) (m := 1125574353172571992323330509)
    (by decide) (by decide) sqrt_lo_79274 sqrt_hi_79274
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_83937 : RawHead.log129WithLogTwo logTwo137 16 83937 = 7716121673237244188199562509353265868503 := by decide +kernel
theorem log_83937 : |Real.log (83937 : ℝ) - (7716121673237244188199562509353265868503 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 83937
  have hc : RawHead.log129Center 16 83937 = 7716121673237244188199562509353265868503 := he.symm.trans center_83937
  have h := RawHead.log129Center_error (x := 83937) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_83937 : (1093862801112956398314781241 : ℤ) * 1093862801112956398314781241 * 83937 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_83937 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1093862801112956398314781241 + 1) * (1093862801112956398314781241 + 1) * 83937 := by decide +kernel
theorem inverse_sqrt_83937 :
    0 ≤ (Real.sqrt (83937 : ℝ))⁻¹ - (1093862801112956398314781241 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (83937 : ℝ))⁻¹ - (1093862801112956398314781241 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 83937) (S := 2 ^ 98) (m := 1093862801112956398314781241)
    (by decide) (by decide) sqrt_lo_83937 sqrt_hi_83937
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_88600 : RawHead.log129WithLogTwo logTwo137 16 88600 = 7752916637072233780999367049164036615561 := by decide +kernel
theorem log_88600 : |Real.log (88600 : ℝ) - (7752916637072233780999367049164036615561 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 88600
  have hc : RawHead.log129Center 16 88600 = 7752916637072233780999367049164036615561 := he.symm.trans center_88600
  have h := RawHead.log129Center_error (x := 88600) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_88600 : (1064688870110676780904269189 : ℤ) * 1064688870110676780904269189 * 88600 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_88600 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1064688870110676780904269189 + 1) * (1064688870110676780904269189 + 1) * 88600 := by decide +kernel
theorem inverse_sqrt_88600 :
    0 ≤ (Real.sqrt (88600 : ℝ))⁻¹ - (1064688870110676780904269189 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (88600 : ℝ))⁻¹ - (1064688870110676780904269189 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 88600) (S := 2 ^ 98) (m := 1064688870110676780904269189)
    (by decide) (by decide) sqrt_lo_88600 sqrt_hi_88600
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_93263 : RawHead.log129WithLogTwo logTwo137 16 93263 = 7787823892116364153854699498064069386958 := by decide +kernel
theorem log_93263 : |Real.log (93263 : ℝ) - (7787823892116364153854699498064069386958 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 93263
  have hc : RawHead.log129Center 16 93263 = 7787823892116364153854699498064069386958 := he.symm.trans center_93263
  have h := RawHead.log129Center_error (x := 93263) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_93263 : (1037731224258603386934088117 : ℤ) * 1037731224258603386934088117 * 93263 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_93263 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1037731224258603386934088117 + 1) * (1037731224258603386934088117 + 1) * 93263 := by decide +kernel
theorem inverse_sqrt_93263 :
    0 ≤ (Real.sqrt (93263 : ℝ))⁻¹ - (1037731224258603386934088117 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (93263 : ℝ))⁻¹ - (1037731224258603386934088117 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 93263) (S := 2 ^ 98) (m := 1037731224258603386934088117)
    (by decide) (by decide) sqrt_lo_93263 sqrt_hi_93263
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_97926 : RawHead.log129WithLogTwo logTwo137 16 97926 = 7821027714741348843064791239594915229079 := by decide +kernel
theorem log_97926 : |Real.log (97926 : ℝ) - (7821027714741348843064791239594915229079 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 97926
  have hc : RawHead.log129Center 16 97926 = 7821027714741348843064791239594915229079 := he.symm.trans center_97926
  have h := RawHead.log129Center_error (x := 97926) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_97926 : (1012722753082652645546483183 : ℤ) * 1012722753082652645546483183 * 97926 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_97926 : (2 ^ 98 : ℤ) * 2 ^ 98 < (1012722753082652645546483183 + 1) * (1012722753082652645546483183 + 1) * 97926 := by decide +kernel
theorem inverse_sqrt_97926 :
    0 ≤ (Real.sqrt (97926 : ℝ))⁻¹ - (1012722753082652645546483183 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (97926 : ℝ))⁻¹ - (1012722753082652645546483183 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 97926) (S := 2 ^ 98) (m := 1012722753082652645546483183)
    (by decide) (by decide) sqrt_lo_97926 sqrt_hi_97926
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_102590 : RawHead.log129WithLogTwo logTwo137 16 102590 = 7852693282964937393300534104326205919781 := by decide +kernel
theorem log_102590 : |Real.log (102590 : ℝ) - (7852693282964937393300534104326205919781 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 102590
  have hc : RawHead.log129Center 16 102590 = 7852693282964937393300534104326205919781 := he.symm.trans center_102590
  have h := RawHead.log129Center_error (x := 102590) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_102590 : (989434524412354521646417962 : ℤ) * 989434524412354521646417962 * 102590 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_102590 : (2 ^ 98 : ℤ) * 2 ^ 98 < (989434524412354521646417962 + 1) * (989434524412354521646417962 + 1) * 102590 := by decide +kernel
theorem inverse_sqrt_102590 :
    0 ≤ (Real.sqrt (102590 : ℝ))⁻¹ - (989434524412354521646417962 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (102590 : ℝ))⁻¹ - (989434524412354521646417962 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 102590) (S := 2 ^ 98) (m := 989434524412354521646417962)
    (by decide) (by decide) sqrt_lo_102590 sqrt_hi_102590
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_107253 : RawHead.log129WithLogTwo logTwo137 16 107253 = 7882944431217022617786996608568723449405 := by decide +kernel
theorem log_107253 : |Real.log (107253 : ℝ) - (7882944431217022617786996608568723449405 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 107253
  have hc : RawHead.log129Center 16 107253 = 7882944431217022617786996608568723449405 := he.symm.trans center_107253
  have h := RawHead.log129Center_error (x := 107253) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_107253 : (967686875093718153944581384 : ℤ) * 967686875093718153944581384 * 107253 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_107253 : (2 ^ 98 : ℤ) * 2 ^ 98 < (967686875093718153944581384 + 1) * (967686875093718153944581384 + 1) * 107253 := by decide +kernel
theorem inverse_sqrt_107253 :
    0 ≤ (Real.sqrt (107253 : ℝ))⁻¹ - (967686875093718153944581384 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (107253 : ℝ))⁻¹ - (967686875093718153944581384 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 107253) (S := 2 ^ 98) (m := 967686875093718153944581384)
    (by decide) (by decide) sqrt_lo_107253 sqrt_hi_107253
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_111916 : RawHead.log129WithLogTwo logTwo137 16 111916 = 7911907946306470029544350711088942157865 := by decide +kernel
theorem log_111916 : |Real.log (111916 : ℝ) - (7911907946306470029544350711088942157865 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 111916
  have hc : RawHead.log129Center 16 111916 = 7911907946306470029544350711088942157865 := he.symm.trans center_111916
  have h := RawHead.log129Center_error (x := 111916) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_111916 : (947312974018625168822210122 : ℤ) * 947312974018625168822210122 * 111916 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_111916 : (2 ^ 98 : ℤ) * 2 ^ 98 < (947312974018625168822210122 + 1) * (947312974018625168822210122 + 1) * 111916 := by decide +kernel
theorem inverse_sqrt_111916 :
    0 ≤ (Real.sqrt (111916 : ℝ))⁻¹ - (947312974018625168822210122 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (111916 : ℝ))⁻¹ - (947312974018625168822210122 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 111916) (S := 2 ^ 98) (m := 947312974018625168822210122)
    (by decide) (by decide) sqrt_lo_111916 sqrt_hi_111916
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_116579 : RawHead.log129WithLogTwo logTwo137 16 116579 = 7939688983176288669638485719525247651078 := by decide +kernel
theorem log_116579 : |Real.log (116579 : ℝ) - (7939688983176288669638485719525247651078 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 116579
  have hc : RawHead.log129Center 16 116579 = 7939688983176288669638485719525247651078 := he.symm.trans center_116579
  have h := RawHead.log129Center_error (x := 116579) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_116579 : (928174028704915360088159364 : ℤ) * 928174028704915360088159364 * 116579 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_116579 : (2 ^ 98 : ℤ) * 2 ^ 98 < (928174028704915360088159364 + 1) * (928174028704915360088159364 + 1) * 116579 := by decide +kernel
theorem inverse_sqrt_116579 :
    0 ≤ (Real.sqrt (116579 : ℝ))⁻¹ - (928174028704915360088159364 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (116579 : ℝ))⁻¹ - (928174028704915360088159364 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 116579) (S := 2 ^ 98) (m := 928174028704915360088159364)
    (by decide) (by decide) sqrt_lo_116579 sqrt_hi_116579
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_121242 : RawHead.log129WithLogTwo logTwo137 16 121242 = 7966380319261071681629535550666598381710 := by decide +kernel
theorem log_121242 : |Real.log (121242 : ℝ) - (7966380319261071681629535550666598381710 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 121242
  have hc : RawHead.log129Center 16 121242 = 7966380319261071681629535550666598381710 := he.symm.trans center_121242
  have h := RawHead.log129Center_error (x := 121242) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_121242 : (910150116776676270264459311 : ℤ) * 910150116776676270264459311 * 121242 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_121242 : (2 ^ 98 : ℤ) * 2 ^ 98 < (910150116776676270264459311 + 1) * (910150116776676270264459311 + 1) * 121242 := by decide +kernel
theorem inverse_sqrt_121242 :
    0 ≤ (Real.sqrt (121242 : ℝ))⁻¹ - (910150116776676270264459311 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (121242 : ℝ))⁻¹ - (910150116776676270264459311 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 121242) (S := 2 ^ 98) (m := 910150116776676270264459311)
    (by decide) (by decide) sqrt_lo_121242 sqrt_hi_121242
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_125905 : RawHead.log129WithLogTwo logTwo137 16 125905 = 7992064223932962175391315295807523734159 := by decide +kernel
theorem log_125905 : |Real.log (125905 : ℝ) - (7992064223932962175391315295807523734159 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 125905
  have hc : RawHead.log129Center 16 125905 = 7992064223932962175391315295807523734159 := he.symm.trans center_125905
  have h := RawHead.log129Center_error (x := 125905) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_125905 : (893137010541828390003910857 : ℤ) * 893137010541828390003910857 * 125905 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_125905 : (2 ^ 98 : ℤ) * 2 ^ 98 < (893137010541828390003910857 + 1) * (893137010541828390003910857 + 1) * 125905 := by decide +kernel
theorem inverse_sqrt_125905 :
    0 ≤ (Real.sqrt (125905 : ℝ))⁻¹ - (893137010541828390003910857 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (125905 : ℝ))⁻¹ - (893137010541828390003910857 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 125905) (S := 2 ^ 98) (m := 893137010541828390003910857)
    (by decide) (by decide) sqrt_lo_125905 sqrt_hi_125905
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_130568 : RawHead.log129WithLogTwo logTwo137 16 130568 = 8016813987810574684409579441330591518440 := by decide +kernel
theorem log_130568 : |Real.log (130568 : ℝ) - (8016813987810574684409579441330591518440 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 16 130568
  have hc : RawHead.log129Center 16 130568 = 8016813987810574684409579441330591518440 := he.symm.trans center_130568
  have h := RawHead.log129Center_error (x := 130568) (k := 16) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_130568 : (877043631160092615643397453 : ℤ) * 877043631160092615643397453 * 130568 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_130568 : (2 ^ 98 : ℤ) * 2 ^ 98 < (877043631160092615643397453 + 1) * (877043631160092615643397453 + 1) * 130568 := by decide +kernel
theorem inverse_sqrt_130568 :
    0 ≤ (Real.sqrt (130568 : ℝ))⁻¹ - (877043631160092615643397453 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (130568 : ℝ))⁻¹ - (877043631160092615643397453 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 130568) (S := 2 ^ 98) (m := 877043631160092615643397453)
    (by decide) (by decide) sqrt_lo_130568 sqrt_hi_130568
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_135232 : RawHead.log129WithLogTwo logTwo137 17 135232 = 8040700216184633725882708420416546748170 := by decide +kernel
theorem log_135232 : |Real.log (135232 : ℝ) - (8040700216184633725882708420416546748170 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 135232
  have hc : RawHead.log129Center 17 135232 = 8040700216184633725882708420416546748170 := he.symm.trans center_135232
  have h := RawHead.log129Center_error (x := 135232) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_135232 : (861786803657492174094026923 : ℤ) * 861786803657492174094026923 * 135232 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_135232 : (2 ^ 98 : ℤ) * 2 ^ 98 < (861786803657492174094026923 + 1) * (861786803657492174094026923 + 1) * 135232 := by decide +kernel
theorem inverse_sqrt_135232 :
    0 ≤ (Real.sqrt (135232 : ℝ))⁻¹ - (861786803657492174094026923 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (135232 : ℝ))⁻¹ - (861786803657492174094026923 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 135232) (S := 2 ^ 98) (m := 861786803657492174094026923)
    (by decide) (by decide) sqrt_lo_135232 sqrt_hi_135232
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_139895 : RawHead.log129WithLogTwo logTwo137 17 139895 = 8063771577915156398327362819910909991252 := by decide +kernel
theorem log_139895 : |Real.log (139895 : ℝ) - (8063771577915156398327362819910909991252 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 139895
  have hc : RawHead.log129Center 17 139895 = 8063771577915156398327362819910909991252 := he.symm.trans center_139895
  have h := RawHead.log129Center_error (x := 139895) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_139895 : (847302482349255202103521182 : ℤ) * 847302482349255202103521182 * 139895 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_139895 : (2 ^ 98 : ℤ) * 2 ^ 98 < (847302482349255202103521182 + 1) * (847302482349255202103521182 + 1) * 139895 := by decide +kernel
theorem inverse_sqrt_139895 :
    0 ≤ (Real.sqrt (139895 : ℝ))⁻¹ - (847302482349255202103521182 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (139895 : ℝ))⁻¹ - (847302482349255202103521182 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 139895) (S := 2 ^ 98) (m := 847302482349255202103521182)
    (by decide) (by decide) sqrt_lo_139895 sqrt_hi_139895
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_144558 : RawHead.log129WithLogTwo logTwo137 17 144558 = 8086086390307714950967463105150079518144 := by decide +kernel
theorem log_144558 : |Real.log (144558 : ℝ) - (8086086390307714950967463105150079518144 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 144558
  have hc : RawHead.log129Center 17 144558 = 8086086390307714950967463105150079518144 := he.symm.trans center_144558
  have h := RawHead.log129Center_error (x := 144558) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_144558 : (833524768474287701741554805 : ℤ) * 833524768474287701741554805 * 144558 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_144558 : (2 ^ 98 : ℤ) * 2 ^ 98 < (833524768474287701741554805 + 1) * (833524768474287701741554805 + 1) * 144558 := by decide +kernel
theorem inverse_sqrt_144558 :
    0 ≤ (Real.sqrt (144558 : ℝ))⁻¹ - (833524768474287701741554805 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (144558 : ℝ))⁻¹ - (833524768474287701741554805 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 144558) (S := 2 ^ 98) (m := 833524768474287701741554805)
    (by decide) (by decide) sqrt_lo_144558 sqrt_hi_144558
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_149221 : RawHead.log129WithLogTwo logTwo137 17 149221 = 8107692699116094982811540726012471803539 := by decide +kernel
theorem log_149221 : |Real.log (149221 : ℝ) - (8107692699116094982811540726012471803539 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 149221
  have hc : RawHead.log129Center 17 149221 = 8107692699116094982811540726012471803539 := he.symm.trans center_149221
  have h := RawHead.log129Center_error (x := 149221) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_149221 : (820398017145248523907191574 : ℤ) * 820398017145248523907191574 * 149221 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_149221 : (2 ^ 98 : ℤ) * 2 ^ 98 < (820398017145248523907191574 + 1) * (820398017145248523907191574 + 1) * 149221 := by decide +kernel
theorem inverse_sqrt_149221 :
    0 ≤ (Real.sqrt (149221 : ℝ))⁻¹ - (820398017145248523907191574 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (149221 : ℝ))⁻¹ - (820398017145248523907191574 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 149221) (S := 2 ^ 98) (m := 820398017145248523907191574)
    (by decide) (by decide) sqrt_lo_149221 sqrt_hi_149221
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_153884 : RawHead.log129WithLogTwo logTwo137 17 153884 = 8128634113778293337331485762921008025384 := by decide +kernel
theorem log_153884 : |Real.log (153884 : ℝ) - (8128634113778293337331485762921008025384 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 153884
  have hc : RawHead.log129Center 17 153884 = 8128634113778293337331485762921008025384 := he.symm.trans center_153884
  have h := RawHead.log129Center_error (x := 153884) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_153884 : (807872531161735814508598232 : ℤ) * 807872531161735814508598232 * 153884 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_153884 : (2 ^ 98 : ℤ) * 2 ^ 98 < (807872531161735814508598232 + 1) * (807872531161735814508598232 + 1) * 153884 := by decide +kernel
theorem inverse_sqrt_153884 :
    0 ≤ (Real.sqrt (153884 : ℝ))⁻¹ - (807872531161735814508598232 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (153884 : ℝ))⁻¹ - (807872531161735814508598232 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 153884) (S := 2 ^ 98) (m := 807872531161735814508598232)
    (by decide) (by decide) sqrt_lo_153884 sqrt_hi_153884
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_158547 : RawHead.log129WithLogTwo logTwo137 17 158547 = 8148950337318511008466567199666155142503 := by decide +kernel
theorem log_158547 : |Real.log (158547 : ℝ) - (8148950337318511008466567199666155142503 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 158547
  have hc : RawHead.log129Center 17 158547 = 8148950337318511008466567199666155142503 := he.symm.trans center_158547
  have h := RawHead.log129Center_error (x := 158547) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_158547 : (795903767839264061356412815 : ℤ) * 795903767839264061356412815 * 158547 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_158547 : (2 ^ 98 : ℤ) * 2 ^ 98 < (795903767839264061356412815 + 1) * (795903767839264061356412815 + 1) * 158547 := by decide +kernel
theorem inverse_sqrt_158547 :
    0 ≤ (Real.sqrt (158547 : ℝ))⁻¹ - (795903767839264061356412815 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (158547 : ℝ))⁻¹ - (795903767839264061356412815 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 158547) (S := 2 ^ 98) (m := 795903767839264061356412815)
    (by decide) (by decide) sqrt_lo_158547 sqrt_hi_158547
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_163210 : RawHead.log129WithLogTwo logTwo137 17 163210 = 8168677619419261053192591550152559351828 := by decide +kernel
theorem log_163210 : |Real.log (163210 : ℝ) - (8168677619419261053192591550152559351828 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 163210
  have hc : RawHead.log129Center 17 163210 = 8168677619419261053192591550152559351828 := he.symm.trans center_163210
  have h := RawHead.log129Center_error (x := 163210) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_163210 : (784451671402887931339788909 : ℤ) * 784451671402887931339788909 * 163210 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_163210 : (2 ^ 98 : ℤ) * 2 ^ 98 < (784451671402887931339788909 + 1) * (784451671402887931339788909 + 1) * 163210 := by decide +kernel
theorem inverse_sqrt_163210 :
    0 ≤ (Real.sqrt (163210 : ℝ))⁻¹ - (784451671402887931339788909 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (163210 : ℝ))⁻¹ - (784451671402887931339788909 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 163210) (S := 2 ^ 98) (m := 784451671402887931339788909)
    (by decide) (by decide) sqrt_lo_163210 sqrt_hi_163210
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_167874 : RawHead.log129WithLogTwo logTwo137 17 167874 = 8187853199688270776475450794881574837302 := by decide +kernel
theorem log_167874 : |Real.log (167874 : ℝ) - (8187853199688270776475450794881574837302 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 167874
  have hc : RawHead.log129Center 17 167874 = 8187853199688270776475450794881574837302 := he.symm.trans center_167874
  have h := RawHead.log129Center_error (x := 167874) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_167874 : (773477804354683213787513985 : ℤ) * 773477804354683213787513985 * 167874 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_167874 : (2 ^ 98 : ℤ) * 2 ^ 98 < (773477804354683213787513985 + 1) * (773477804354683213787513985 + 1) * 167874 := by decide +kernel
theorem inverse_sqrt_167874 :
    0 ≤ (Real.sqrt (167874 : ℝ))⁻¹ - (773477804354683213787513985 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (167874 : ℝ))⁻¹ - (773477804354683213787513985 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 167874) (S := 2 ^ 98) (m := 773477804354683213787513985)
    (by decide) (by decide) sqrt_lo_167874 sqrt_hi_167874
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_172537 : RawHead.log129WithLogTwo logTwo137 17 172537 = 8206499317855004943776317250290928271319 := by decide +kernel
theorem log_172537 : |Real.log (172537 : ℝ) - (8206499317855004943776317250290928271319 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 172537
  have hc : RawHead.log129Center 17 172537 = 8206499317855004943776317250290928271319 := he.symm.trans center_172537
  have h := RawHead.log129Center_error (x := 172537) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_172537 : (762954174932076179114694458 : ℤ) * 762954174932076179114694458 * 172537 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_172537 : (2 ^ 98 : ℤ) * 2 ^ 98 < (762954174932076179114694458 + 1) * (762954174932076179114694458 + 1) * 172537 := by decide +kernel
theorem inverse_sqrt_172537 :
    0 ≤ (Real.sqrt (172537 : ℝ))⁻¹ - (762954174932076179114694458 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (172537 : ℝ))⁻¹ - (762954174932076179114694458 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 172537) (S := 2 ^ 98) (m := 762954174932076179114694458)
    (by decide) (by decide) sqrt_lo_172537 sqrt_hi_172537
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_177200 : RawHead.log129WithLogTwo logTwo137 17 177200 = 8224648163523260369275255334692345584360 := by decide +kernel
theorem log_177200 : |Real.log (177200 : ℝ) - (8224648163523260369275255334692345584360 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 177200
  have hc : RawHead.log129Center 17 177200 = 8224648163523260369275255334692345584360 := he.symm.trans center_177200
  have h := RawHead.log129Center_error (x := 177200) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_177200 : (752848719909102845252938945 : ℤ) * 752848719909102845252938945 * 177200 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_177200 : (2 ^ 98 : ℤ) * 2 ^ 98 < (752848719909102845252938945 + 1) * (752848719909102845252938945 + 1) * 177200 := by decide +kernel
theorem inverse_sqrt_177200 :
    0 ≤ (Real.sqrt (177200 : ℝ))⁻¹ - (752848719909102845252938945 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (177200 : ℝ))⁻¹ - (752848719909102845252938945 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 177200) (S := 2 ^ 98) (m := 752848719909102845252938945)
    (by decide) (by decide) sqrt_lo_177200 sqrt_hi_177200
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_181863 : RawHead.log129WithLogTwo logTwo137 17 181863 = 8242325572642872428560635634459231061147 := by decide +kernel
theorem log_181863 : |Real.log (181863 : ℝ) - (8242325572642872428560635634459231061147 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 181863
  have hc : RawHead.log129Center 17 181863 = 8242325572642872428560635634459231061147 := he.symm.trans center_181863
  have h := RawHead.log129Center_error (x := 181863) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_181863 : (743134458479126755466268682 : ℤ) * 743134458479126755466268682 * 181863 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_181863 : (2 ^ 98 : ℤ) * 2 ^ 98 < (743134458479126755466268682 + 1) * (743134458479126755466268682 + 1) * 181863 := by decide +kernel
theorem inverse_sqrt_181863 :
    0 ≤ (Real.sqrt (181863 : ℝ))⁻¹ - (743134458479126755466268682 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (181863 : ℝ))⁻¹ - (743134458479126755466268682 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 181863) (S := 2 ^ 98) (m := 743134458479126755466268682)
    (by decide) (by decide) sqrt_lo_181863 sqrt_hi_181863
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_186526 : RawHead.log129WithLogTwo logTwo137 17 186526 = 8259555418567390742130587783592378355757 := by decide +kernel
theorem log_186526 : |Real.log (186526 : ℝ) - (8259555418567390742130587783592378355757 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 186526
  have hc : RawHead.log129Center 17 186526 = 8259555418567390742130587783592378355757 := he.symm.trans center_186526
  have h := RawHead.log129Center_error (x := 186526) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_186526 : (733786785722276343369560416 : ℤ) * 733786785722276343369560416 * 186526 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_186526 : (2 ^ 98 : ℤ) * 2 ^ 98 < (733786785722276343369560416 + 1) * (733786785722276343369560416 + 1) * 186526 := by decide +kernel
theorem inverse_sqrt_186526 :
    0 ≤ (Real.sqrt (186526 : ℝ))⁻¹ - (733786785722276343369560416 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (186526 : ℝ))⁻¹ - (733786785722276343369560416 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 186526) (S := 2 ^ 98) (m := 733786785722276343369560416)
    (by decide) (by decide) sqrt_lo_186526 sqrt_hi_186526
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_191189 : RawHead.log129WithLogTwo logTwo137 17 191189 = 8276359805936460596894769647763500225782 := by decide +kernel
theorem log_191189 : |Real.log (191189 : ℝ) - (8276359805936460596894769647763500225782 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 191189
  have hc : RawHead.log129Center 17 191189 = 8276359805936460596894769647763500225782 := he.symm.trans center_191189
  have h := RawHead.log129Center_error (x := 191189) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_191189 : (724783210207490314417604740 : ℤ) * 724783210207490314417604740 * 191189 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_191189 : (2 ^ 98 : ℤ) * 2 ^ 98 < (724783210207490314417604740 + 1) * (724783210207490314417604740 + 1) * 191189 := by decide +kernel
theorem inverse_sqrt_191189 :
    0 ≤ (Real.sqrt (191189 : ℝ))⁻¹ - (724783210207490314417604740 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (191189 : ℝ))⁻¹ - (724783210207490314417604740 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 191189) (S := 2 ^ 98) (m := 724783210207490314417604740)
    (by decide) (by decide) sqrt_lo_191189 sqrt_hi_191189
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_195852 : RawHead.log129WithLogTwo logTwo137 17 195852 = 8292759241192375431340679525123224197877 := by decide +kernel
theorem log_195852 : |Real.log (195852 : ℝ) - (8292759241192375431340679525123224197877 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 195852
  have hc : RawHead.log129Center 17 195852 = 8292759241192375431340679525123224197877 := he.symm.trans center_195852
  have h := RawHead.log129Center_error (x := 195852) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_195852 : (716103126166653261625484134 : ℤ) * 716103126166653261625484134 * 195852 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_195852 : (2 ^ 98 : ℤ) * 2 ^ 98 < (716103126166653261625484134 + 1) * (716103126166653261625484134 + 1) * 195852 := by decide +kernel
theorem inverse_sqrt_195852 :
    0 ≤ (Real.sqrt (195852 : ℝ))⁻¹ - (716103126166653261625484134 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (195852 : ℝ))⁻¹ - (716103126166653261625484134 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 195852) (S := 2 ^ 98) (m := 716103126166653261625484134)
    (by decide) (by decide) sqrt_lo_195852 sqrt_hi_195852
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_200516 : RawHead.log129WithLogTwo logTwo137 17 200516 = 8308776177105994635734772258842621000254 := by decide +kernel
theorem log_200516 : |Real.log (200516 : ℝ) - (8308776177105994635734772258842621000254 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 200516
  have hc : RawHead.log129Center 17 200516 = 8308776177105994635734772258842621000254 := he.symm.trans center_200516
  have h := RawHead.log129Center_error (x := 200516) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_200516 : (707725850215287844004037584 : ℤ) * 707725850215287844004037584 * 200516 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_200516 : (2 ^ 98 : ℤ) * 2 ^ 98 < (707725850215287844004037584 + 1) * (707725850215287844004037584 + 1) * 200516 := by decide +kernel
theorem inverse_sqrt_200516 :
    0 ≤ (Real.sqrt (200516 : ℝ))⁻¹ - (707725850215287844004037584 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (200516 : ℝ))⁻¹ - (707725850215287844004037584 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 200516) (S := 2 ^ 98) (m := 707725850215287844004037584)
    (by decide) (by decide) sqrt_lo_200516 sqrt_hi_200516
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_205179 : RawHead.log129WithLogTwo logTwo137 17 205179 = 8324421492492324713403479770499366250808 := by decide +kernel
theorem log_205179 : |Real.log (205179 : ℝ) - (8324421492492324713403479770499366250808 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 205179
  have hc : RawHead.log129Center 17 205179 = 8324421492492324713403479770499366250808 := he.symm.trans center_205179
  have h := RawHead.log129Center_error (x := 205179) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_205179 : (699637566690212303982761712 : ℤ) * 699637566690212303982761712 * 205179 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_205179 : (2 ^ 98 : ℤ) * 2 ^ 98 < (699637566690212303982761712 + 1) * (699637566690212303982761712 + 1) * 205179 := by decide +kernel
theorem inverse_sqrt_205179 :
    0 ≤ (Real.sqrt (205179 : ℝ))⁻¹ - (699637566690212303982761712 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (205179 : ℝ))⁻¹ - (699637566690212303982761712 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 205179) (S := 2 ^ 98) (m := 699637566690212303982761712)
    (by decide) (by decide) sqrt_lo_205179 sqrt_hi_205179
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_209842 : RawHead.log129WithLogTwo logTwo137 17 209842 = 8339715209686595451655489979564302134662 := by decide +kernel
theorem log_209842 : |Real.log (209842 : ℝ) - (8339715209686595451655489979564302134662 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 209842
  have hc : RawHead.log129Center 17 209842 = 8339715209686595451655489979564302134662 := he.symm.trans center_209842
  have h := RawHead.log129Center_error (x := 209842) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_209842 : (691820404064112314445821542 : ℤ) * 691820404064112314445821542 * 209842 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_209842 : (2 ^ 98 : ℤ) * 2 ^ 98 < (691820404064112314445821542 + 1) * (691820404064112314445821542 + 1) * 209842 := by decide +kernel
theorem inverse_sqrt_209842 :
    0 ≤ (Real.sqrt (209842 : ℝ))⁻¹ - (691820404064112314445821542 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (209842 : ℝ))⁻¹ - (691820404064112314445821542 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 209842) (S := 2 ^ 98) (m := 691820404064112314445821542)
    (by decide) (by decide) sqrt_lo_209842 sqrt_hi_209842
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_214505 : RawHead.log129WithLogTwo logTwo137 17 214505 = 8354672784953438890199206894606497930174 := by decide +kernel
theorem log_214505 : |Real.log (214505 : ℝ) - (8354672784953438890199206894606497930174 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 214505
  have hc : RawHead.log129Center 17 214505 = 8354672784953438890199206894606497930174 := he.symm.trans center_214505
  have h := RawHead.log129Center_error (x := 214505) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_214505 : (684259546411829858624415962 : ℤ) * 684259546411829858624415962 * 214505 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_214505 : (2 ^ 98 : ℤ) * 2 ^ 98 < (684259546411829858624415962 + 1) * (684259546411829858624415962 + 1) * 214505 := by decide +kernel
theorem inverse_sqrt_214505 :
    0 ≤ (Real.sqrt (214505 : ℝ))⁻¹ - (684259546411829858624415962 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (214505 : ℝ))⁻¹ - (684259546411829858624415962 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 214505) (S := 2 ^ 98) (m := 684259546411829858624415962)
    (by decide) (by decide) sqrt_lo_214505 sqrt_hi_214505
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_219168 : RawHead.log129WithLogTwo logTwo137 17 219168 = 8369308677252364026544793457326795809119 := by decide +kernel
theorem log_219168 : |Real.log (219168 : ℝ) - (8369308677252364026544793457326795809119 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 219168
  have hc : RawHead.log129Center 17 219168 = 8369308677252364026544793457326795809119 := he.symm.trans center_219168
  have h := RawHead.log129Center_error (x := 219168) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_219168 : (676941287085158574662625836 : ℤ) * 676941287085158574662625836 * 219168 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_219168 : (2 ^ 98 : ℤ) * 2 ^ 98 < (676941287085158574662625836 + 1) * (676941287085158574662625836 + 1) * 219168 := by decide +kernel
theorem inverse_sqrt_219168 :
    0 ≤ (Real.sqrt (219168 : ℝ))⁻¹ - (676941287085158574662625836 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (219168 : ℝ))⁻¹ - (676941287085158574662625836 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 219168) (S := 2 ^ 98) (m := 676941287085158574662625836)
    (by decide) (by decide) sqrt_lo_219168 sqrt_hi_219168
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_223831 : RawHead.log129WithLogTwo logTwo137 17 223831 = 8383636432234898846689163826041563415153 := by decide +kernel
theorem log_223831 : |Real.log (223831 : ℝ) - (8383636432234898846689163826041563415153 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 223831
  have hc : RawHead.log129Center 17 223831 = 8383636432234898846689163826041563415153 := he.symm.trans center_223831
  have h := RawHead.log129Center_error (x := 223831) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_223831 : (669852924165904098904788370 : ℤ) * 669852924165904098904788370 * 223831 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_223831 : (2 ^ 98 : ℤ) * 2 ^ 98 < (669852924165904098904788370 + 1) * (669852924165904098904788370 + 1) * 223831 := by decide +kernel
theorem inverse_sqrt_223831 :
    0 ≤ (Real.sqrt (223831 : ℝ))⁻¹ - (669852924165904098904788370 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (223831 : ℝ))⁻¹ - (669852924165904098904788370 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 223831) (S := 2 ^ 98) (m := 669852924165904098904788370)
    (by decide) (by decide) sqrt_lo_223831 sqrt_hi_223831
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_228494 : RawHead.log129WithLogTwo logTwo137 17 228494 = 8397668757580557865940434469087191905464 := by decide +kernel
theorem log_228494 : |Real.log (228494 : ℝ) - (8397668757580557865940434469087191905464 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 228494
  have hc : RawHead.log129Center 17 228494 = 8397668757580557865940434469087191905464 := he.symm.trans center_228494
  have h := RawHead.log129Center_error (x := 228494) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_228494 : (662982667715046929929214168 : ℤ) * 662982667715046929929214168 * 228494 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_228494 : (2 ^ 98 : ℤ) * 2 ^ 98 < (662982667715046929929214168 + 1) * (662982667715046929929214168 + 1) * 228494 := by decide +kernel
theorem inverse_sqrt_228494 :
    0 ≤ (Real.sqrt (228494 : ℝ))⁻¹ - (662982667715046929929214168 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (228494 : ℝ))⁻¹ - (662982667715046929929214168 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 228494) (S := 2 ^ 98) (m := 662982667715046929929214168)
    (by decide) (by decide) sqrt_lo_228494 sqrt_hi_228494
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_233158 : RawHead.log129WithLogTwo logTwo137 17 233158 = 8411420509627315257914374005053556619876 := by decide +kernel
theorem log_233158 : |Real.log (233158 : ℝ) - (8411420509627315257914374005053556619876 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 233158
  have hc : RawHead.log129Center 17 233158 = 8411420509627315257914374005053556619876 := he.symm.trans center_233158
  have h := RawHead.log129Center_error (x := 233158) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_233158 : (656318149818482866417454458 : ℤ) * 656318149818482866417454458 * 233158 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_233158 : (2 ^ 98 : ℤ) * 2 ^ 98 < (656318149818482866417454458 + 1) * (656318149818482866417454458 + 1) * 233158 := by decide +kernel
theorem inverse_sqrt_233158 :
    0 ≤ (Real.sqrt (233158 : ℝ))⁻¹ - (656318149818482866417454458 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (233158 : ℝ))⁻¹ - (656318149818482866417454458 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 233158) (S := 2 ^ 98) (m := 656318149818482866417454458)
    (by decide) (by decide) sqrt_lo_233158 sqrt_hi_233158
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_237821 : RawHead.log129WithLogTwo logTwo137 17 237821 = 8424897021535791506696938137982060946043 := by decide +kernel
theorem log_237821 : |Real.log (237821 : ℝ) - (8424897021535791506696938137982060946043 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 237821
  have hc : RawHead.log129Center 17 237821 = 8424897021535791506696938137982060946043 := he.symm.trans center_237821
  have h := RawHead.log129Center_error (x := 237821) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_237821 : (649852022055722598985821520 : ℤ) * 649852022055722598985821520 * 237821 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_237821 : (2 ^ 98 : ℤ) * 2 ^ 98 < (649852022055722598985821520 + 1) * (649852022055722598985821520 + 1) * 237821 := by decide +kernel
theorem inverse_sqrt_237821 :
    0 ≤ (Real.sqrt (237821 : ℝ))⁻¹ - (649852022055722598985821520 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (237821 : ℝ))⁻¹ - (649852022055722598985821520 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 237821) (S := 2 ^ 98) (m := 649852022055722598985821520)
    (by decide) (by decide) sqrt_lo_237821 sqrt_hi_237821
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_242484 : RawHead.log129WithLogTwo logTwo137 17 242484 = 8438111845712098269905423836194907350509 := by decide +kernel
theorem log_242484 : |Real.log (242484 : ℝ) - (8438111845712098269905423836194907350509 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 242484
  have hc : RawHead.log129Center 17 242484 = 8438111845712098269905423836194907350509 := he.symm.trans center_242484
  have h := RawHead.log129Center_error (x := 242484) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_242484 : (643573319470515904463616204 : ℤ) * 643573319470515904463616204 * 242484 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_242484 : (2 ^ 98 : ℤ) * 2 ^ 98 < (643573319470515904463616204 + 1) * (643573319470515904463616204 + 1) * 242484 := by decide +kernel
theorem inverse_sqrt_242484 :
    0 ≤ (Real.sqrt (242484 : ℝ))⁻¹ - (643573319470515904463616204 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (242484 : ℝ))⁻¹ - (643573319470515904463616204 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 242484) (S := 2 ^ 98) (m := 643573319470515904463616204)
    (by decide) (by decide) sqrt_lo_242484 sqrt_hi_242484
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_247147 : RawHead.log129WithLogTwo logTwo137 17 247147 = 8451074951808940237751689379306558346736 := by decide +kernel
theorem log_247147 : |Real.log (247147 : ℝ) - (8451074951808940237751689379306558346736 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 247147
  have hc : RawHead.log129Center 17 247147 = 8451074951808940237751689379306558346736 := he.symm.trans center_247147
  have h := RawHead.log129Center_error (x := 247147) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_247147 : (637473159164970006966175563 : ℤ) * 637473159164970006966175563 * 247147 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_247147 : (2 ^ 98 : ℤ) * 2 ^ 98 < (637473159164970006966175563 + 1) * (637473159164970006966175563 + 1) * 247147 := by decide +kernel
theorem inverse_sqrt_247147 :
    0 ≤ (Real.sqrt (247147 : ℝ))⁻¹ - (637473159164970006966175563 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (247147 : ℝ))⁻¹ - (637473159164970006966175563 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 247147) (S := 2 ^ 98) (m := 637473159164970006966175563)
    (by decide) (by decide) sqrt_lo_247147 sqrt_hi_247147
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_251810 : RawHead.log129WithLogTwo logTwo137 17 251810 = 8463795750383988763667203581335832702957 := by decide +kernel
theorem log_251810 : |Real.log (251810 : ℝ) - (8463795750383988763667203581335832702957 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 251810
  have hc : RawHead.log129Center 17 251810 = 8463795750383988763667203581335832702957 := he.symm.trans center_251810
  have h := RawHead.log129Center_error (x := 251810) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_251810 : (631543236682807836977426903 : ℤ) * 631543236682807836977426903 * 251810 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_251810 : (2 ^ 98 : ℤ) * 2 ^ 98 < (631543236682807836977426903 + 1) * (631543236682807836977426903 + 1) * 251810 := by decide +kernel
theorem inverse_sqrt_251810 :
    0 ≤ (Real.sqrt (251810 : ℝ))⁻¹ - (631543236682807836977426903 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (251810 : ℝ))⁻¹ - (631543236682807836977426903 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 251810) (S := 2 ^ 98) (m := 631543236682807836977426903)
    (by decide) (by decide) sqrt_lo_251810 sqrt_hi_251810
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_256473 : RawHead.log129WithLogTwo logTwo137 17 256473 = 8476283133939067832633074738390124261180 := by decide +kernel
theorem log_256473 : |Real.log (256473 : ℝ) - (8476283133939067832633074738390124261180 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 256473
  have hc : RawHead.log129Center 17 256473 = 8476283133939067832633074738390124261180 := he.symm.trans center_256473
  have h := RawHead.log129Center_error (x := 256473) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_256473 : (625775778463918243076049191 : ℤ) * 625775778463918243076049191 * 256473 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_256473 : (2 ^ 98 : ℤ) * 2 ^ 98 < (625775778463918243076049191 + 1) * (625775778463918243076049191 + 1) * 256473 := by decide +kernel
theorem inverse_sqrt_256473 :
    0 ≤ (Real.sqrt (256473 : ℝ))⁻¹ - (625775778463918243076049191 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (256473 : ℝ))⁻¹ - (625775778463918243076049191 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 256473) (S := 2 ^ 98) (m := 625775778463918243076049191)
    (by decide) (by decide) sqrt_lo_256473 sqrt_hi_256473
  simpa only [Nat.cast_pow, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem center_261136 : RawHead.log129WithLogTwo logTwo137 17 261136 = 8488545514261601272685467726858900487239 := by decide +kernel
theorem log_261136 : |Real.log (261136 : ℝ) - (8488545514261601272685467726858900487239 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  have he := RawHead.log129WithLogTwo_eq logTwo_checked 17 261136
  have hc : RawHead.log129Center 17 261136 = 8488545514261601272685467726858900487239 := he.symm.trans center_261136
  have h := RawHead.log129Center_error (x := 261136) (k := 17) (by decide) (by decide) (by decide) (by decide)
  simpa only [hc, Nat.cast_ofNat, Int.cast_ofNat] using h

theorem sqrt_lo_261136 : (620163498989774703293915537 : ℤ) * 620163498989774703293915537 * 261136 ≤ (2 ^ 98 : ℤ) * 2 ^ 98 := by decide +kernel
theorem sqrt_hi_261136 : (2 ^ 98 : ℤ) * 2 ^ 98 < (620163498989774703293915537 + 1) * (620163498989774703293915537 + 1) * 261136 := by decide +kernel
theorem inverse_sqrt_261136 :
    0 ≤ (Real.sqrt (261136 : ℝ))⁻¹ - (620163498989774703293915537 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (261136 : ℝ))⁻¹ - (620163498989774703293915537 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverse_sqrt_sub_div_bounds (x := 261136) (S := 2 ^ 98) (m := 620163498989774703293915537)
    (by decide) (by decide) sqrt_lo_261136 sqrt_hi_261136
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
    |Real.log (4664 : ℝ) - (5749158196886953713159301303219076447387 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (9327 : ℝ) - (6220816760085823373860640099499356620994 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (10004 : ℝ) - (6268505015309936937964319995554191813487 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (13990 : ℝ) - (6496737690645161537323658921227865348830 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (18653 : ℝ) - (6692511801977169212175747126022131584826 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (23316 : ℝ) - (6844368136439204407178328053929940755075 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (27979 : ℝ) - (6968444893404416852992574140032324220268 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (32642 : ℝ) - (7073350934908521507857802870273973580843 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (37306 : ℝ) - (7164243328428195800451635411550440553624 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (41969 : ℝ) - (7244398254780068380880468637234054925435 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (46632 : ℝ) - (7316099662890230995454216339458249723873 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (51295 : ℝ) - (7380961756513910805024645818797896950983 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (55958 : ℝ) - (7440176419855443441268462425560633189066 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (60621 : ℝ) - (7494648792810045093353647265138289412912 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (65284 : ℝ) - (7545082461359548096133691155802282549642 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (69948 : ℝ) - (7592044916272031742385316423250882403310 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (74611 : ℝ) - (7635965733433683134528924791566292013469 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (79274 : ℝ) - (7677223103364899038100670194832002734534 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (83937 : ℝ) - (7716121673237244188199562509353265868503 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (88600 : ℝ) - (7752916637072233780999367049164036615561 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (93263 : ℝ) - (7787823892116364153854699498064069386958 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (97926 : ℝ) - (7821027714741348843064791239594915229079 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (102590 : ℝ) - (7852693282964937393300534104326205919781 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (107253 : ℝ) - (7882944431217022617786996608568723449405 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (111916 : ℝ) - (7911907946306470029544350711088942157865 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (116579 : ℝ) - (7939688983176288669638485719525247651078 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (121242 : ℝ) - (7966380319261071681629535550666598381710 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (125905 : ℝ) - (7992064223932962175391315295807523734159 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (130568 : ℝ) - (8016813987810574684409579441330591518440 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (135232 : ℝ) - (8040700216184633725882708420416546748170 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (139895 : ℝ) - (8063771577915156398327362819910909991252 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (144558 : ℝ) - (8086086390307714950967463105150079518144 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (149221 : ℝ) - (8107692699116094982811540726012471803539 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (153884 : ℝ) - (8128634113778293337331485762921008025384 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (158547 : ℝ) - (8148950337318511008466567199666155142503 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (163210 : ℝ) - (8168677619419261053192591550152559351828 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (167874 : ℝ) - (8187853199688270776475450794881574837302 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (172537 : ℝ) - (8206499317855004943776317250290928271319 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (177200 : ℝ) - (8224648163523260369275255334692345584360 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (181863 : ℝ) - (8242325572642872428560635634459231061147 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (186526 : ℝ) - (8259555418567390742130587783592378355757 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (191189 : ℝ) - (8276359805936460596894769647763500225782 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (195852 : ℝ) - (8292759241192375431340679525123224197877 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (200516 : ℝ) - (8308776177105994635734772258842621000254 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (205179 : ℝ) - (8324421492492324713403479770499366250808 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (209842 : ℝ) - (8339715209686595451655489979564302134662 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (214505 : ℝ) - (8354672784953438890199206894606497930174 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (219168 : ℝ) - (8369308677252364026544793457326795809119 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (223831 : ℝ) - (8383636432234898846689163826041563415153 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (228494 : ℝ) - (8397668757580557865940434469087191905464 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (233158 : ℝ) - (8411420509627315257914374005053556619876 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (237821 : ℝ) - (8424897021535791506696938137982060946043 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (242484 : ℝ) - (8438111845712098269905423836194907350509 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (247147 : ℝ) - (8451074951808940237751689379306558346736 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (251810 : ℝ) - (8463795750383988763667203581335832702957 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (256473 : ℝ) - (8476283133939067832633074738390124261180 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (261136 : ℝ) - (8488545514261601272685467726858900487239 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (262144 : ℝ) - (8491167476118478588965989139509561438373 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) ∧
    |Real.log (265800 : ℝ) - (8500593416905061116206355418484978263797 : ℝ) / 2 ^ 129| < 1 / (2 ^ 128 : ℝ) := by
  refine And.intro log_1 ?_
  refine And.intro log_2 ?_
  refine And.intro log_3 ?_
  refine And.intro log_41 ?_
  refine And.intro log_61 ?_
  refine And.intro log_4664 ?_
  refine And.intro log_9327 ?_
  refine And.intro log_10004 ?_
  refine And.intro log_13990 ?_
  refine And.intro log_18653 ?_
  refine And.intro log_23316 ?_
  refine And.intro log_27979 ?_
  refine And.intro log_32642 ?_
  refine And.intro log_37306 ?_
  refine And.intro log_41969 ?_
  refine And.intro log_46632 ?_
  refine And.intro log_51295 ?_
  refine And.intro log_55958 ?_
  refine And.intro log_60621 ?_
  refine And.intro log_65284 ?_
  refine And.intro log_69948 ?_
  refine And.intro log_74611 ?_
  refine And.intro log_79274 ?_
  refine And.intro log_83937 ?_
  refine And.intro log_88600 ?_
  refine And.intro log_93263 ?_
  refine And.intro log_97926 ?_
  refine And.intro log_102590 ?_
  refine And.intro log_107253 ?_
  refine And.intro log_111916 ?_
  refine And.intro log_116579 ?_
  refine And.intro log_121242 ?_
  refine And.intro log_125905 ?_
  refine And.intro log_130568 ?_
  refine And.intro log_135232 ?_
  refine And.intro log_139895 ?_
  refine And.intro log_144558 ?_
  refine And.intro log_149221 ?_
  refine And.intro log_153884 ?_
  refine And.intro log_158547 ?_
  refine And.intro log_163210 ?_
  refine And.intro log_167874 ?_
  refine And.intro log_172537 ?_
  refine And.intro log_177200 ?_
  refine And.intro log_181863 ?_
  refine And.intro log_186526 ?_
  refine And.intro log_191189 ?_
  refine And.intro log_195852 ?_
  refine And.intro log_200516 ?_
  refine And.intro log_205179 ?_
  refine And.intro log_209842 ?_
  refine And.intro log_214505 ?_
  refine And.intro log_219168 ?_
  refine And.intro log_223831 ?_
  refine And.intro log_228494 ?_
  refine And.intro log_233158 ?_
  refine And.intro log_237821 ?_
  refine And.intro log_242484 ?_
  refine And.intro log_247147 ?_
  refine And.intro log_251810 ?_
  refine And.intro log_256473 ?_
  refine And.intro log_261136 ?_
  refine And.intro log_262144 ?_
  exact log_265800

theorem all_inverse_roots :
    (type_of% inverse_sqrt_1) ∧
    (type_of% inverse_sqrt_2) ∧
    (type_of% inverse_sqrt_3) ∧
    (type_of% inverse_sqrt_41) ∧
    (type_of% inverse_sqrt_61) ∧
    (type_of% inverse_sqrt_4664) ∧
    (type_of% inverse_sqrt_9327) ∧
    (type_of% inverse_sqrt_10004) ∧
    (type_of% inverse_sqrt_13990) ∧
    (type_of% inverse_sqrt_18653) ∧
    (type_of% inverse_sqrt_23316) ∧
    (type_of% inverse_sqrt_27979) ∧
    (type_of% inverse_sqrt_32642) ∧
    (type_of% inverse_sqrt_37306) ∧
    (type_of% inverse_sqrt_41969) ∧
    (type_of% inverse_sqrt_46632) ∧
    (type_of% inverse_sqrt_51295) ∧
    (type_of% inverse_sqrt_55958) ∧
    (type_of% inverse_sqrt_60621) ∧
    (type_of% inverse_sqrt_65284) ∧
    (type_of% inverse_sqrt_69948) ∧
    (type_of% inverse_sqrt_74611) ∧
    (type_of% inverse_sqrt_79274) ∧
    (type_of% inverse_sqrt_83937) ∧
    (type_of% inverse_sqrt_88600) ∧
    (type_of% inverse_sqrt_93263) ∧
    (type_of% inverse_sqrt_97926) ∧
    (type_of% inverse_sqrt_102590) ∧
    (type_of% inverse_sqrt_107253) ∧
    (type_of% inverse_sqrt_111916) ∧
    (type_of% inverse_sqrt_116579) ∧
    (type_of% inverse_sqrt_121242) ∧
    (type_of% inverse_sqrt_125905) ∧
    (type_of% inverse_sqrt_130568) ∧
    (type_of% inverse_sqrt_135232) ∧
    (type_of% inverse_sqrt_139895) ∧
    (type_of% inverse_sqrt_144558) ∧
    (type_of% inverse_sqrt_149221) ∧
    (type_of% inverse_sqrt_153884) ∧
    (type_of% inverse_sqrt_158547) ∧
    (type_of% inverse_sqrt_163210) ∧
    (type_of% inverse_sqrt_167874) ∧
    (type_of% inverse_sqrt_172537) ∧
    (type_of% inverse_sqrt_177200) ∧
    (type_of% inverse_sqrt_181863) ∧
    (type_of% inverse_sqrt_186526) ∧
    (type_of% inverse_sqrt_191189) ∧
    (type_of% inverse_sqrt_195852) ∧
    (type_of% inverse_sqrt_200516) ∧
    (type_of% inverse_sqrt_205179) ∧
    (type_of% inverse_sqrt_209842) ∧
    (type_of% inverse_sqrt_214505) ∧
    (type_of% inverse_sqrt_219168) ∧
    (type_of% inverse_sqrt_223831) ∧
    (type_of% inverse_sqrt_228494) ∧
    (type_of% inverse_sqrt_233158) ∧
    (type_of% inverse_sqrt_237821) ∧
    (type_of% inverse_sqrt_242484) ∧
    (type_of% inverse_sqrt_247147) ∧
    (type_of% inverse_sqrt_251810) ∧
    (type_of% inverse_sqrt_256473) ∧
    (type_of% inverse_sqrt_261136) ∧
    (type_of% inverse_sqrt_262144) ∧
    (type_of% inverse_sqrt_265800) :=
  And.intro inverse_sqrt_1 (And.intro inverse_sqrt_2 (And.intro inverse_sqrt_3 (And.intro inverse_sqrt_41 (And.intro inverse_sqrt_61 (And.intro inverse_sqrt_4664 (And.intro inverse_sqrt_9327 (And.intro inverse_sqrt_10004 (And.intro inverse_sqrt_13990 (And.intro inverse_sqrt_18653 (And.intro inverse_sqrt_23316 (And.intro inverse_sqrt_27979 (And.intro inverse_sqrt_32642 (And.intro inverse_sqrt_37306 (And.intro inverse_sqrt_41969 (And.intro inverse_sqrt_46632 (And.intro inverse_sqrt_51295 (And.intro inverse_sqrt_55958 (And.intro inverse_sqrt_60621 (And.intro inverse_sqrt_65284 (And.intro inverse_sqrt_69948 (And.intro inverse_sqrt_74611 (And.intro inverse_sqrt_79274 (And.intro inverse_sqrt_83937 (And.intro inverse_sqrt_88600 (And.intro inverse_sqrt_93263 (And.intro inverse_sqrt_97926 (And.intro inverse_sqrt_102590 (And.intro inverse_sqrt_107253 (And.intro inverse_sqrt_111916 (And.intro inverse_sqrt_116579 (And.intro inverse_sqrt_121242 (And.intro inverse_sqrt_125905 (And.intro inverse_sqrt_130568 (And.intro inverse_sqrt_135232 (And.intro inverse_sqrt_139895 (And.intro inverse_sqrt_144558 (And.intro inverse_sqrt_149221 (And.intro inverse_sqrt_153884 (And.intro inverse_sqrt_158547 (And.intro inverse_sqrt_163210 (And.intro inverse_sqrt_167874 (And.intro inverse_sqrt_172537 (And.intro inverse_sqrt_177200 (And.intro inverse_sqrt_181863 (And.intro inverse_sqrt_186526 (And.intro inverse_sqrt_191189 (And.intro inverse_sqrt_195852 (And.intro inverse_sqrt_200516 (And.intro inverse_sqrt_205179 (And.intro inverse_sqrt_209842 (And.intro inverse_sqrt_214505 (And.intro inverse_sqrt_219168 (And.intro inverse_sqrt_223831 (And.intro inverse_sqrt_228494 (And.intro inverse_sqrt_233158 (And.intro inverse_sqrt_237821 (And.intro inverse_sqrt_242484 (And.intro inverse_sqrt_247147 (And.intro inverse_sqrt_251810 (And.intro inverse_sqrt_256473 (And.intro inverse_sqrt_261136 (And.intro inverse_sqrt_262144 (inverse_sqrt_265800)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

end RawLogCases64
