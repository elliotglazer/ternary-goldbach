import DataP343N64
open BatchedTransform
open DataP343N64
namespace BatchP343N64
theorem checked : checkStage scale bound inputs outputs = true := by decide +kernel
theorem certified : stage_spec scale bound inputs outputs :=
  checkStage_sound scale bound inputs outputs checked
end BatchP343N64
