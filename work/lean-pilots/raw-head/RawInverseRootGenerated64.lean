import RawInverseRootProducer

/-! Fixed saved-fixture comparison using checked Nat.sqrt computation.
No supplied-witness proof module is imported.
Fixture SHA256: BB725A50AB0EC32A07F3516542E2FC3CE59081E75598E7283B686D0AFDBB12C3
-/

namespace RawInverseRootGenerated64

theorem candidate_1 : RawHead.inverseRootCandidate 1 (2 ^ 98) = 316912650057057350374175801344 := by
  decide +kernel

theorem inverse_sqrt_1 :
    0 ≤ (Real.sqrt (1 : ℝ))⁻¹ - (316912650057057350374175801344 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (1 : ℝ))⁻¹ - (316912650057057350374175801344 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 1) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_1, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_2 : RawHead.inverseRootCandidate 2 (2 ^ 98) = 224091083899144559674927752909 := by
  decide +kernel

theorem inverse_sqrt_2 :
    0 ≤ (Real.sqrt (2 : ℝ))⁻¹ - (224091083899144559674927752909 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (2 : ℝ))⁻¹ - (224091083899144559674927752909 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 2) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_2, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_3 : RawHead.inverseRootCandidate 3 (2 ^ 98) = 182969603820039730136647482517 := by
  decide +kernel

theorem inverse_sqrt_3 :
    0 ≤ (Real.sqrt (3 : ℝ))⁻¹ - (182969603820039730136647482517 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (3 : ℝ))⁻¹ - (182969603820039730136647482517 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 3) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_3, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_41 : RawHead.inverseRootCandidate 41 (2 ^ 98) = 49493440749498014082648379236 := by
  decide +kernel

theorem inverse_sqrt_41 :
    0 ≤ (Real.sqrt (41 : ℝ))⁻¹ - (49493440749498014082648379236 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (41 : ℝ))⁻¹ - (49493440749498014082648379236 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 41) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_41, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_61 : RawHead.inverseRootCandidate 61 (2 ^ 98) = 40576506924571330310586784495 := by
  decide +kernel

theorem inverse_sqrt_61 :
    0 ≤ (Real.sqrt (61 : ℝ))⁻¹ - (40576506924571330310586784495 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (61 : ℝ))⁻¹ - (40576506924571330310586784495 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 61) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_61, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_4664 : RawHead.inverseRootCandidate 4664 (2 ^ 98) = 4640452207583157390272626050 := by
  decide +kernel

theorem inverse_sqrt_4664 :
    0 ≤ (Real.sqrt (4664 : ℝ))⁻¹ - (4640452207583157390272626050 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (4664 : ℝ))⁻¹ - (4640452207583157390272626050 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 4664) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_4664, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_9327 : RawHead.inverseRootCandidate 9327 (2 ^ 98) = 3281471122074975169753976205 := by
  decide +kernel

theorem inverse_sqrt_9327 :
    0 ≤ (Real.sqrt (9327 : ℝ))⁻¹ - (3281471122074975169753976205 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (9327 : ℝ))⁻¹ - (3281471122074975169753976205 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 9327) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_9327, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_10004 : RawHead.inverseRootCandidate 10004 (2 ^ 98) = 3168492865354689069166240814 := by
  decide +kernel

theorem inverse_sqrt_10004 :
    0 ≤ (Real.sqrt (10004 : ℝ))⁻¹ - (3168492865354689069166240814 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (10004 : ℝ))⁻¹ - (3168492865354689069166240814 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 10004) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_10004, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_13990 : RawHead.inverseRootCandidate 13990 (2 ^ 98) = 2679357830179360703381976645 := by
  decide +kernel

theorem inverse_sqrt_13990 :
    0 ≤ (Real.sqrt (13990 : ℝ))⁻¹ - (2679357830179360703381976645 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (13990 : ℝ))⁻¹ - (2679357830179360703381976645 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 13990) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_13990, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_18653 : RawHead.inverseRootCandidate 18653 (2 ^ 98) = 2320412679636184380219856694 := by
  decide +kernel

theorem inverse_sqrt_18653 :
    0 ≤ (Real.sqrt (18653 : ℝ))⁻¹ - (2320412679636184380219856694 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (18653 : ℝ))⁻¹ - (2320412679636184380219856694 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 18653) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_18653, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_23316 : RawHead.inverseRootCandidate 23316 (2 ^ 98) = 2075451321672915545390039079 := by
  decide +kernel

theorem inverse_sqrt_23316 :
    0 ≤ (Real.sqrt (23316 : ℝ))⁻¹ - (2075451321672915545390039079 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (23316 : ℝ))⁻¹ - (2075451321672915545390039079 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 23316) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_23316, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_27979 : RawHead.inverseRootCandidate 27979 (2 ^ 98) = 1894625948037250337644420244 := by
  decide +kernel

theorem inverse_sqrt_27979 :
    0 ≤ (Real.sqrt (27979 : ℝ))⁻¹ - (1894625948037250337644420244 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (27979 : ℝ))⁻¹ - (1894625948037250337644420244 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 27979) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_27979, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_32642 : RawHead.inverseRootCandidate 32642 (2 ^ 98) = 1754087262320185231286794907 := by
  decide +kernel

theorem inverse_sqrt_32642 :
    0 ≤ (Real.sqrt (32642 : ℝ))⁻¹ - (1754087262320185231286794907 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (32642 : ℝ))⁻¹ - (1754087262320185231286794907 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 32642) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_32642, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_37306 : RawHead.inverseRootCandidate 37306 (2 ^ 98) = 1640779540921993829194202696 := by
  decide +kernel

theorem inverse_sqrt_37306 :
    0 ≤ (Real.sqrt (37306 : ℝ))⁻¹ - (1640779540921993829194202696 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (37306 : ℝ))⁻¹ - (1640779540921993829194202696 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 37306) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_37306, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_41969 : RawHead.inverseRootCandidate 41969 (2 ^ 98) = 1546946393811369262477775168 := by
  decide +kernel

theorem inverse_sqrt_41969 :
    0 ≤ (Real.sqrt (41969 : ℝ))⁻¹ - (1546946393811369262477775168 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (41969 : ℝ))⁻¹ - (1546946393811369262477775168 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 41969) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_41969, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_46632 : RawHead.inverseRootCandidate 46632 (2 ^ 98) = 1467565703577501152258152816 := by
  decide +kernel

theorem inverse_sqrt_46632 :
    0 ≤ (Real.sqrt (46632 : ℝ))⁻¹ - (1467565703577501152258152816 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (46632 : ℝ))⁻¹ - (1467565703577501152258152816 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 46632) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_46632, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_51295 : RawHead.inverseRootCandidate 51295 (2 ^ 98) = 1399271723504124967036089935 := by
  decide +kernel

theorem inverse_sqrt_51295 :
    0 ≤ (Real.sqrt (51295 : ℝ))⁻¹ - (1399271723504124967036089935 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (51295 : ℝ))⁻¹ - (1399271723504124967036089935 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 51295) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_51295, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_55958 : RawHead.inverseRootCandidate 55958 (2 ^ 98) = 1339702855669131134614860961 := by
  decide +kernel

theorem inverse_sqrt_55958 :
    0 ≤ (Real.sqrt (55958 : ℝ))⁻¹ - (1339702855669131134614860961 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (55958 : ℝ))⁻¹ - (1339702855669131134614860961 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 55958) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_55958, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_60621 : RawHead.inverseRootCandidate 60621 (2 ^ 98) = 1287146638941031808927232409 := by
  decide +kernel

theorem inverse_sqrt_60621 :
    0 ≤ (Real.sqrt (60621 : ℝ))⁻¹ - (1287146638941031808927232409 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (60621 : ℝ))⁻¹ - (1287146638941031808927232409 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 60621) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_60621, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_65284 : RawHead.inverseRootCandidate 65284 (2 ^ 98) = 1240326997979549406587831074 := by
  decide +kernel

theorem inverse_sqrt_65284 :
    0 ≤ (Real.sqrt (65284 : ℝ))⁻¹ - (1240326997979549406587831074 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (65284 : ℝ))⁻¹ - (1240326997979549406587831074 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 65284) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_65284, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_69948 : RawHead.inverseRootCandidate 69948 (2 ^ 98) = 1198262379257822363718970650 := by
  decide +kernel

theorem inverse_sqrt_69948 :
    0 ≤ (Real.sqrt (69948 : ℝ))⁻¹ - (1198262379257822363718970650 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (69948 : ℝ))⁻¹ - (1198262379257822363718970650 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 69948) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_69948, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_74611 : RawHead.inverseRootCandidate 74611 (2 ^ 98) = 1160214114827489775045262280 := by
  decide +kernel

theorem inverse_sqrt_74611 :
    0 ≤ (Real.sqrt (74611 : ℝ))⁻¹ - (1160214114827489775045262280 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (74611 : ℝ))⁻¹ - (1160214114827489775045262280 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 74611) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_74611, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_79274 : RawHead.inverseRootCandidate 79274 (2 ^ 98) = 1125574353172571992323330509 := by
  decide +kernel

theorem inverse_sqrt_79274 :
    0 ≤ (Real.sqrt (79274 : ℝ))⁻¹ - (1125574353172571992323330509 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (79274 : ℝ))⁻¹ - (1125574353172571992323330509 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 79274) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_79274, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_83937 : RawHead.inverseRootCandidate 83937 (2 ^ 98) = 1093862801112956398314781241 := by
  decide +kernel

theorem inverse_sqrt_83937 :
    0 ≤ (Real.sqrt (83937 : ℝ))⁻¹ - (1093862801112956398314781241 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (83937 : ℝ))⁻¹ - (1093862801112956398314781241 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 83937) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_83937, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_88600 : RawHead.inverseRootCandidate 88600 (2 ^ 98) = 1064688870110676780904269189 := by
  decide +kernel

theorem inverse_sqrt_88600 :
    0 ≤ (Real.sqrt (88600 : ℝ))⁻¹ - (1064688870110676780904269189 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (88600 : ℝ))⁻¹ - (1064688870110676780904269189 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 88600) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_88600, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_93263 : RawHead.inverseRootCandidate 93263 (2 ^ 98) = 1037731224258603386934088117 := by
  decide +kernel

theorem inverse_sqrt_93263 :
    0 ≤ (Real.sqrt (93263 : ℝ))⁻¹ - (1037731224258603386934088117 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (93263 : ℝ))⁻¹ - (1037731224258603386934088117 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 93263) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_93263, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_97926 : RawHead.inverseRootCandidate 97926 (2 ^ 98) = 1012722753082652645546483183 := by
  decide +kernel

theorem inverse_sqrt_97926 :
    0 ≤ (Real.sqrt (97926 : ℝ))⁻¹ - (1012722753082652645546483183 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (97926 : ℝ))⁻¹ - (1012722753082652645546483183 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 97926) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_97926, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_102590 : RawHead.inverseRootCandidate 102590 (2 ^ 98) = 989434524412354521646417962 := by
  decide +kernel

theorem inverse_sqrt_102590 :
    0 ≤ (Real.sqrt (102590 : ℝ))⁻¹ - (989434524412354521646417962 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (102590 : ℝ))⁻¹ - (989434524412354521646417962 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 102590) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_102590, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_107253 : RawHead.inverseRootCandidate 107253 (2 ^ 98) = 967686875093718153944581384 := by
  decide +kernel

theorem inverse_sqrt_107253 :
    0 ≤ (Real.sqrt (107253 : ℝ))⁻¹ - (967686875093718153944581384 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (107253 : ℝ))⁻¹ - (967686875093718153944581384 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 107253) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_107253, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_111916 : RawHead.inverseRootCandidate 111916 (2 ^ 98) = 947312974018625168822210122 := by
  decide +kernel

theorem inverse_sqrt_111916 :
    0 ≤ (Real.sqrt (111916 : ℝ))⁻¹ - (947312974018625168822210122 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (111916 : ℝ))⁻¹ - (947312974018625168822210122 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 111916) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_111916, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_116579 : RawHead.inverseRootCandidate 116579 (2 ^ 98) = 928174028704915360088159364 := by
  decide +kernel

theorem inverse_sqrt_116579 :
    0 ≤ (Real.sqrt (116579 : ℝ))⁻¹ - (928174028704915360088159364 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (116579 : ℝ))⁻¹ - (928174028704915360088159364 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 116579) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_116579, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_121242 : RawHead.inverseRootCandidate 121242 (2 ^ 98) = 910150116776676270264459311 := by
  decide +kernel

theorem inverse_sqrt_121242 :
    0 ≤ (Real.sqrt (121242 : ℝ))⁻¹ - (910150116776676270264459311 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (121242 : ℝ))⁻¹ - (910150116776676270264459311 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 121242) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_121242, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_125905 : RawHead.inverseRootCandidate 125905 (2 ^ 98) = 893137010541828390003910857 := by
  decide +kernel

theorem inverse_sqrt_125905 :
    0 ≤ (Real.sqrt (125905 : ℝ))⁻¹ - (893137010541828390003910857 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (125905 : ℝ))⁻¹ - (893137010541828390003910857 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 125905) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_125905, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_130568 : RawHead.inverseRootCandidate 130568 (2 ^ 98) = 877043631160092615643397453 := by
  decide +kernel

theorem inverse_sqrt_130568 :
    0 ≤ (Real.sqrt (130568 : ℝ))⁻¹ - (877043631160092615643397453 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (130568 : ℝ))⁻¹ - (877043631160092615643397453 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 130568) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_130568, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_135232 : RawHead.inverseRootCandidate 135232 (2 ^ 98) = 861786803657492174094026923 := by
  decide +kernel

theorem inverse_sqrt_135232 :
    0 ≤ (Real.sqrt (135232 : ℝ))⁻¹ - (861786803657492174094026923 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (135232 : ℝ))⁻¹ - (861786803657492174094026923 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 135232) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_135232, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_139895 : RawHead.inverseRootCandidate 139895 (2 ^ 98) = 847302482349255202103521182 := by
  decide +kernel

theorem inverse_sqrt_139895 :
    0 ≤ (Real.sqrt (139895 : ℝ))⁻¹ - (847302482349255202103521182 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (139895 : ℝ))⁻¹ - (847302482349255202103521182 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 139895) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_139895, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_144558 : RawHead.inverseRootCandidate 144558 (2 ^ 98) = 833524768474287701741554805 := by
  decide +kernel

theorem inverse_sqrt_144558 :
    0 ≤ (Real.sqrt (144558 : ℝ))⁻¹ - (833524768474287701741554805 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (144558 : ℝ))⁻¹ - (833524768474287701741554805 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 144558) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_144558, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_149221 : RawHead.inverseRootCandidate 149221 (2 ^ 98) = 820398017145248523907191574 := by
  decide +kernel

theorem inverse_sqrt_149221 :
    0 ≤ (Real.sqrt (149221 : ℝ))⁻¹ - (820398017145248523907191574 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (149221 : ℝ))⁻¹ - (820398017145248523907191574 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 149221) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_149221, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_153884 : RawHead.inverseRootCandidate 153884 (2 ^ 98) = 807872531161735814508598232 := by
  decide +kernel

theorem inverse_sqrt_153884 :
    0 ≤ (Real.sqrt (153884 : ℝ))⁻¹ - (807872531161735814508598232 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (153884 : ℝ))⁻¹ - (807872531161735814508598232 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 153884) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_153884, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_158547 : RawHead.inverseRootCandidate 158547 (2 ^ 98) = 795903767839264061356412815 := by
  decide +kernel

theorem inverse_sqrt_158547 :
    0 ≤ (Real.sqrt (158547 : ℝ))⁻¹ - (795903767839264061356412815 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (158547 : ℝ))⁻¹ - (795903767839264061356412815 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 158547) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_158547, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_163210 : RawHead.inverseRootCandidate 163210 (2 ^ 98) = 784451671402887931339788909 := by
  decide +kernel

theorem inverse_sqrt_163210 :
    0 ≤ (Real.sqrt (163210 : ℝ))⁻¹ - (784451671402887931339788909 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (163210 : ℝ))⁻¹ - (784451671402887931339788909 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 163210) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_163210, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_167874 : RawHead.inverseRootCandidate 167874 (2 ^ 98) = 773477804354683213787513985 := by
  decide +kernel

theorem inverse_sqrt_167874 :
    0 ≤ (Real.sqrt (167874 : ℝ))⁻¹ - (773477804354683213787513985 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (167874 : ℝ))⁻¹ - (773477804354683213787513985 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 167874) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_167874, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_172537 : RawHead.inverseRootCandidate 172537 (2 ^ 98) = 762954174932076179114694458 := by
  decide +kernel

theorem inverse_sqrt_172537 :
    0 ≤ (Real.sqrt (172537 : ℝ))⁻¹ - (762954174932076179114694458 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (172537 : ℝ))⁻¹ - (762954174932076179114694458 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 172537) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_172537, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_177200 : RawHead.inverseRootCandidate 177200 (2 ^ 98) = 752848719909102845252938945 := by
  decide +kernel

theorem inverse_sqrt_177200 :
    0 ≤ (Real.sqrt (177200 : ℝ))⁻¹ - (752848719909102845252938945 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (177200 : ℝ))⁻¹ - (752848719909102845252938945 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 177200) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_177200, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_181863 : RawHead.inverseRootCandidate 181863 (2 ^ 98) = 743134458479126755466268682 := by
  decide +kernel

theorem inverse_sqrt_181863 :
    0 ≤ (Real.sqrt (181863 : ℝ))⁻¹ - (743134458479126755466268682 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (181863 : ℝ))⁻¹ - (743134458479126755466268682 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 181863) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_181863, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_186526 : RawHead.inverseRootCandidate 186526 (2 ^ 98) = 733786785722276343369560416 := by
  decide +kernel

theorem inverse_sqrt_186526 :
    0 ≤ (Real.sqrt (186526 : ℝ))⁻¹ - (733786785722276343369560416 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (186526 : ℝ))⁻¹ - (733786785722276343369560416 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 186526) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_186526, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_191189 : RawHead.inverseRootCandidate 191189 (2 ^ 98) = 724783210207490314417604740 := by
  decide +kernel

theorem inverse_sqrt_191189 :
    0 ≤ (Real.sqrt (191189 : ℝ))⁻¹ - (724783210207490314417604740 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (191189 : ℝ))⁻¹ - (724783210207490314417604740 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 191189) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_191189, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_195852 : RawHead.inverseRootCandidate 195852 (2 ^ 98) = 716103126166653261625484134 := by
  decide +kernel

theorem inverse_sqrt_195852 :
    0 ≤ (Real.sqrt (195852 : ℝ))⁻¹ - (716103126166653261625484134 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (195852 : ℝ))⁻¹ - (716103126166653261625484134 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 195852) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_195852, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_200516 : RawHead.inverseRootCandidate 200516 (2 ^ 98) = 707725850215287844004037584 := by
  decide +kernel

theorem inverse_sqrt_200516 :
    0 ≤ (Real.sqrt (200516 : ℝ))⁻¹ - (707725850215287844004037584 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (200516 : ℝ))⁻¹ - (707725850215287844004037584 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 200516) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_200516, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_205179 : RawHead.inverseRootCandidate 205179 (2 ^ 98) = 699637566690212303982761712 := by
  decide +kernel

theorem inverse_sqrt_205179 :
    0 ≤ (Real.sqrt (205179 : ℝ))⁻¹ - (699637566690212303982761712 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (205179 : ℝ))⁻¹ - (699637566690212303982761712 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 205179) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_205179, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_209842 : RawHead.inverseRootCandidate 209842 (2 ^ 98) = 691820404064112314445821542 := by
  decide +kernel

theorem inverse_sqrt_209842 :
    0 ≤ (Real.sqrt (209842 : ℝ))⁻¹ - (691820404064112314445821542 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (209842 : ℝ))⁻¹ - (691820404064112314445821542 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 209842) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_209842, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_214505 : RawHead.inverseRootCandidate 214505 (2 ^ 98) = 684259546411829858624415962 := by
  decide +kernel

theorem inverse_sqrt_214505 :
    0 ≤ (Real.sqrt (214505 : ℝ))⁻¹ - (684259546411829858624415962 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (214505 : ℝ))⁻¹ - (684259546411829858624415962 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 214505) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_214505, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_219168 : RawHead.inverseRootCandidate 219168 (2 ^ 98) = 676941287085158574662625836 := by
  decide +kernel

theorem inverse_sqrt_219168 :
    0 ≤ (Real.sqrt (219168 : ℝ))⁻¹ - (676941287085158574662625836 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (219168 : ℝ))⁻¹ - (676941287085158574662625836 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 219168) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_219168, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_223831 : RawHead.inverseRootCandidate 223831 (2 ^ 98) = 669852924165904098904788370 := by
  decide +kernel

theorem inverse_sqrt_223831 :
    0 ≤ (Real.sqrt (223831 : ℝ))⁻¹ - (669852924165904098904788370 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (223831 : ℝ))⁻¹ - (669852924165904098904788370 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 223831) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_223831, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_228494 : RawHead.inverseRootCandidate 228494 (2 ^ 98) = 662982667715046929929214168 := by
  decide +kernel

theorem inverse_sqrt_228494 :
    0 ≤ (Real.sqrt (228494 : ℝ))⁻¹ - (662982667715046929929214168 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (228494 : ℝ))⁻¹ - (662982667715046929929214168 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 228494) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_228494, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_233158 : RawHead.inverseRootCandidate 233158 (2 ^ 98) = 656318149818482866417454458 := by
  decide +kernel

theorem inverse_sqrt_233158 :
    0 ≤ (Real.sqrt (233158 : ℝ))⁻¹ - (656318149818482866417454458 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (233158 : ℝ))⁻¹ - (656318149818482866417454458 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 233158) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_233158, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_237821 : RawHead.inverseRootCandidate 237821 (2 ^ 98) = 649852022055722598985821520 := by
  decide +kernel

theorem inverse_sqrt_237821 :
    0 ≤ (Real.sqrt (237821 : ℝ))⁻¹ - (649852022055722598985821520 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (237821 : ℝ))⁻¹ - (649852022055722598985821520 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 237821) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_237821, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_242484 : RawHead.inverseRootCandidate 242484 (2 ^ 98) = 643573319470515904463616204 := by
  decide +kernel

theorem inverse_sqrt_242484 :
    0 ≤ (Real.sqrt (242484 : ℝ))⁻¹ - (643573319470515904463616204 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (242484 : ℝ))⁻¹ - (643573319470515904463616204 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 242484) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_242484, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_247147 : RawHead.inverseRootCandidate 247147 (2 ^ 98) = 637473159164970006966175563 := by
  decide +kernel

theorem inverse_sqrt_247147 :
    0 ≤ (Real.sqrt (247147 : ℝ))⁻¹ - (637473159164970006966175563 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (247147 : ℝ))⁻¹ - (637473159164970006966175563 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 247147) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_247147, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_251810 : RawHead.inverseRootCandidate 251810 (2 ^ 98) = 631543236682807836977426903 := by
  decide +kernel

theorem inverse_sqrt_251810 :
    0 ≤ (Real.sqrt (251810 : ℝ))⁻¹ - (631543236682807836977426903 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (251810 : ℝ))⁻¹ - (631543236682807836977426903 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 251810) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_251810, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_256473 : RawHead.inverseRootCandidate 256473 (2 ^ 98) = 625775778463918243076049191 := by
  decide +kernel

theorem inverse_sqrt_256473 :
    0 ≤ (Real.sqrt (256473 : ℝ))⁻¹ - (625775778463918243076049191 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (256473 : ℝ))⁻¹ - (625775778463918243076049191 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 256473) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_256473, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_261136 : RawHead.inverseRootCandidate 261136 (2 ^ 98) = 620163498989774703293915537 := by
  decide +kernel

theorem inverse_sqrt_261136 :
    0 ≤ (Real.sqrt (261136 : ℝ))⁻¹ - (620163498989774703293915537 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (261136 : ℝ))⁻¹ - (620163498989774703293915537 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 261136) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_261136, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_262144 : RawHead.inverseRootCandidate 262144 (2 ^ 98) = 618970019642690137449562112 := by
  decide +kernel

theorem inverse_sqrt_262144 :
    0 ≤ (Real.sqrt (262144 : ℝ))⁻¹ - (618970019642690137449562112 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (262144 : ℝ))⁻¹ - (618970019642690137449562112 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 262144) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_262144, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

theorem candidate_265800 : RawHead.inverseRootCandidate 265800 (2 ^ 98) = 614698405761597740186252768 := by
  decide +kernel

theorem inverse_sqrt_265800 :
    0 ≤ (Real.sqrt (265800 : ℝ))⁻¹ - (614698405761597740186252768 : ℝ) / 2 ^ 98 ∧
    (Real.sqrt (265800 : ℝ))⁻¹ - (614698405761597740186252768 : ℝ) / 2 ^ 98 < 1 / (2 ^ 98 : ℝ) := by
  have h := RawHead.inverseRootCandidate_error (x := 265800) (S := 2 ^ 98)
    (by decide) (by decide)
  simpa only [candidate_265800, Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] using h

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

end RawInverseRootGenerated64
