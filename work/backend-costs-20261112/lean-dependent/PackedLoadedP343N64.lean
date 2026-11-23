import LoadedPackedDataN64
open PackedProbe LoadedPackedDataN64
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace PackedLoadedP343N64
theorem checked : packedCheck left right mask expected = true := by decide +kernel
theorem certified : Nat.land (left*right) mask = expected :=
  packedCheck_sound left right mask expected checked
end PackedLoadedP343N64
