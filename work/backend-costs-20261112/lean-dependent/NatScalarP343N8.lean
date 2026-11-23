import PackedDataN8
open PackedProbe PackedDataN8
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace NatScalarP343N8
theorem checked : scalarCheck rows = true := by decide +kernel
theorem certified : scalarSpec rows := scalarCheck_sound rows checked
end NatScalarP343N8
