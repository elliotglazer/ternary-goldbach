import NatRowsDataN64
open PackedProbe NatRowsDataN64
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace NatScalarP343N64
theorem checked : scalarCheck rows = true := by decide +kernel
theorem certified : scalarSpec rows := scalarCheck_sound rows checked
end NatScalarP343N64
