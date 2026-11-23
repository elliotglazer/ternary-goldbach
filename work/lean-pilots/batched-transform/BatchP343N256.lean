import DataP343N256
open BatchedTransform
open DataP343N256
namespace BatchP343N256
theorem checked : checkStage scale bound inputs outputs = true := by decide +kernel
theorem certified : stage_spec scale bound inputs outputs :=
  checkStage_sound scale bound inputs outputs checked
end BatchP343N256
