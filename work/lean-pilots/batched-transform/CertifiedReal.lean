import StageReal
import ScalarP100N64
import FastScalarP343N64
import ScalarP415N64
import TreeBinding

namespace BatchedTransform

/-- All 128 complex outputs, at 100 fractional bits, with no unproved premise. -/
theorem p100_stage_real : stage_real_spec DataP100N64.scale
    DataP100N64.inputs DataP100N64.outputs :=
  stage_real_of_spec _ DataP100N64.bound (by decide)
    _ _ ScalarP100N64.certified

/-- All 128 complex outputs, at 343 fractional bits, with no unproved premise. -/
theorem p343_stage_real : stage_real_spec DataP343N64.scale
    DataP343N64.inputs DataP343N64.outputs :=
  stage_real_of_spec _ DataP343N64.bound (by decide)
    _ _ FastScalarP343N64.certified

/-- All 128 complex outputs, at 415 fractional bits, with no unproved premise. -/
theorem p415_stage_real : stage_real_spec DataP415N64.scale
    DataP415N64.inputs DataP415N64.outputs :=
  stage_real_of_spec _ DataP415N64.bound (by decide)
    _ _ ScalarP415N64.certified

/-- A larger stage with all 512 complex outputs, certified in chunks of 16. -/
theorem p343_large_stage_real : stage_real_spec DataP343N256.scale
    DataP343N256.inputs DataP343N256.outputs := by
  rw [← tree_inputs_eq, ← tree_outputs_eq]
  exact stage_real_of_spec _ DataP343N256.bound (by decide)
    _ _ TreeChunk16P343N256.certified

end BatchedTransform
