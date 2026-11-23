import TreeChunk16P343N256

namespace BatchedTransform
deriving instance DecidableEq for Input
deriving instance DecidableEq for Output
theorem tree_inputs_eq : TreeDataP343N256.xs_n0_256 = DataP343N256.inputs := by decide +kernel
theorem tree_outputs_eq : TreeDataP343N256.ys_n0_256 = DataP343N256.outputs := by decide +kernel
end BatchedTransform
