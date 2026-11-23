import DependentFixture
import Replay
open DependentBlock DependentFixture
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace DependentControls
def good : Prop := accept scale coefficients 8 inputs bound8 expected8 = true
#kernel_control DependentControls.good accept
def checksumClaim : Prop := accept scale coefficients 8 inputs bound8 (expected8+1) = true
#kernel_control DependentControls.checksumClaim reject
theorem rejected_checksum : accept scale coefficients 8 inputs bound8 (expected8+1) = false := by decide +kernel
def boundClaim : Prop := accept scale coefficients 8 inputs 0 expected8 = true
#kernel_control DependentControls.boundClaim reject
theorem rejected_bound : accept scale coefficients 8 inputs 0 expected8 = false := by decide +kernel
def depthClaim : Prop := accept scale coefficients 7 inputs bound8 expected8 = true
#kernel_control DependentControls.depthClaim reject
theorem rejected_depth : accept scale coefficients 7 inputs bound8 expected8 = false := by decide +kernel
def inputClaim : Prop := accept scale coefficients 8 changedInputs bound8 expected8 = true
#kernel_control DependentControls.inputClaim reject
theorem rejected_input : accept scale coefficients 8 changedInputs bound8 expected8 = false := by decide +kernel
def coefficientClaim : Prop := accept scale changedCoefficients 8 inputs bound8 expected8 = true
#kernel_control DependentControls.coefficientClaim reject
theorem rejected_coefficient : accept scale changedCoefficients 8 inputs bound8 expected8 = false := by decide +kernel
end DependentControls
