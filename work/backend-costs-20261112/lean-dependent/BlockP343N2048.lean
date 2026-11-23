import DependentFixture
open DependentBlock DependentFixture
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace BlockP343N2048
theorem accepted : accept scale coefficients 32 inputs bound32 expected32 = true := by
  decide +kernel
theorem certified : ∃ ys, ys.length = inputs.length ∧
    blockContract scale coefficients 32 inputs ys ∧
    boundSpec bound32 ys ∧ checksum ys = expected32 :=
  accept_sound scale coefficients 32 inputs bound32 expected32 accepted
end BlockP343N2048
