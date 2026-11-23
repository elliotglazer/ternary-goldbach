import DataP415N64
open BatchedTransform
open DataP415N64
namespace BatchP415N64
theorem checked : checkStage scale bound inputs outputs = true := by decide +kernel
theorem certified : stage_spec scale bound inputs outputs :=
  checkStage_sound scale bound inputs outputs checked
end BatchP415N64
