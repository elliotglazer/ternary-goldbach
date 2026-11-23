import DependentFixture
open DependentBlock DependentFixture
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace BlockP343N64
theorem accepted : accept scale coefficients 1 inputs bound1 expected1 = true := by
  decide +kernel
theorem certified : ∃ ys, ys.length = inputs.length ∧
    blockContract scale coefficients 1 inputs ys ∧
    boundSpec bound1 ys ∧ checksum ys = expected1 :=
  accept_sound scale coefficients 1 inputs bound1 expected1 accepted
end BlockP343N64
