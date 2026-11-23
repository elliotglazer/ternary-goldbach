import DependentFixture
open DependentBlock DependentFixture
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace BlockP343N8192
theorem accepted : accept scale coefficients 128 inputs bound128 expected128 = true := by
  decide +kernel
theorem certified : ∃ ys, ys.length = inputs.length ∧
    blockContract scale coefficients 128 inputs ys ∧
    boundSpec bound128 ys ∧ checksum ys = expected128 :=
  accept_sound scale coefficients 128 inputs bound128 expected128 accepted
end BlockP343N8192
