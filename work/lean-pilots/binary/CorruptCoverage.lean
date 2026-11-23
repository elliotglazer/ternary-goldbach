import CompleteBinaryPilot
-- A deliberately false union certificate must be rejected.
example : BinaryPilot.unionMasks (BinaryPilot.slices_0.map BinaryPilot.sliceMask) = 2^32-2 := rfl
