import PackedDataN64
open PackedProbe PackedDataN64
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace PackedP343N64
theorem checked : packedCheck left right mask expected = true := by decide +kernel
theorem certified : Nat.land (left*right) mask = expected := packedCheck_sound left right mask expected checked
end PackedP343N64
