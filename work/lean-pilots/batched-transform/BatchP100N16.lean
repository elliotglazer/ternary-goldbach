import DataP100N16
open BatchedTransform
open DataP100N16
namespace BatchP100N16
theorem checked : checkStage scale bound inputs outputs = true := by decide +kernel
theorem certified : stage_spec scale bound inputs outputs :=
  checkStage_sound scale bound inputs outputs checked
end BatchP100N16
