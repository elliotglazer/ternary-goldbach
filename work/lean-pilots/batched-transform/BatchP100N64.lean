import DataP100N64
open BatchedTransform
open DataP100N64
namespace BatchP100N64
theorem checked : checkStage scale bound inputs outputs = true := by decide +kernel
theorem certified : stage_spec scale bound inputs outputs :=
  checkStage_sound scale bound inputs outputs checked
end BatchP100N64
