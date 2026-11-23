import DataP100N16
open BatchedTransform
open DataP100N16
namespace ScalarP100N16
theorem row_0 : checkOne scale bound x0 y0 = true := by decide +kernel
theorem row_1 : checkOne scale bound x1 y1 = true := by decide +kernel
theorem row_2 : checkOne scale bound x2 y2 = true := by decide +kernel
theorem row_3 : checkOne scale bound x3 y3 = true := by decide +kernel
theorem row_4 : checkOne scale bound x4 y4 = true := by decide +kernel
theorem row_5 : checkOne scale bound x5 y5 = true := by decide +kernel
theorem row_6 : checkOne scale bound x6 y6 = true := by decide +kernel
theorem row_7 : checkOne scale bound x7 y7 = true := by decide +kernel
theorem row_8 : checkOne scale bound x8 y8 = true := by decide +kernel
theorem row_9 : checkOne scale bound x9 y9 = true := by decide +kernel
theorem row_10 : checkOne scale bound x10 y10 = true := by decide +kernel
theorem row_11 : checkOne scale bound x11 y11 = true := by decide +kernel
theorem row_12 : checkOne scale bound x12 y12 = true := by decide +kernel
theorem row_13 : checkOne scale bound x13 y13 = true := by decide +kernel
theorem row_14 : checkOne scale bound x14 y14 = true := by decide +kernel
theorem row_15 : checkOne scale bound x15 y15 = true := by decide +kernel
theorem checked : checkStage scale bound inputs outputs = true := (checkStage_cons scale bound x0 y0 _ _ row_0 (checkStage_cons scale bound x1 y1 _ _ row_1 (checkStage_cons scale bound x2 y2 _ _ row_2 (checkStage_cons scale bound x3 y3 _ _ row_3 (checkStage_cons scale bound x4 y4 _ _ row_4 (checkStage_cons scale bound x5 y5 _ _ row_5 (checkStage_cons scale bound x6 y6 _ _ row_6 (checkStage_cons scale bound x7 y7 _ _ row_7 (checkStage_cons scale bound x8 y8 _ _ row_8 (checkStage_cons scale bound x9 y9 _ _ row_9 (checkStage_cons scale bound x10 y10 _ _ row_10 (checkStage_cons scale bound x11 y11 _ _ row_11 (checkStage_cons scale bound x12 y12 _ _ row_12 (checkStage_cons scale bound x13 y13 _ _ row_13 (checkStage_cons scale bound x14 y14 _ _ row_14 (checkStage_cons scale bound x15 y15 _ _ row_15 rfl))))))))))))))))
theorem certified : stage_spec scale bound inputs outputs :=
  checkStage_sound scale bound inputs outputs checked
end ScalarP100N16
