import PackedDataN32
open PackedProbe PackedDataN32
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace PackedP343N32
theorem checked : packedCheck left right mask expected = true := by decide +kernel
theorem certified : Nat.land (left*right) mask = expected := packedCheck_sound left right mask expected checked
end PackedP343N32
