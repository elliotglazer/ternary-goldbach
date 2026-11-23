import PackedDataN16
open PackedProbe PackedDataN16
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace NatScalarP343N16
theorem checked : scalarCheck rows = true := by decide +kernel
theorem certified : scalarSpec rows := scalarCheck_sound rows checked
end NatScalarP343N16
