import DependentFixture
open DependentBlock DependentFixture
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace BlockP343N512
theorem accepted : accept scale coefficients 8 inputs bound8 expected8 = true := by
  decide +kernel
theorem certified : ∃ ys, ys.length = inputs.length ∧
    blockContract scale coefficients 8 inputs ys ∧
    boundSpec bound8 ys ∧ checksum ys = expected8 :=
  accept_sound scale coefficients 8 inputs bound8 expected8 accepted
end BlockP343N512
