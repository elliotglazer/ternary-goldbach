import PackedWideSource
import PackedWindow
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536

namespace Block1
def offsets : List Nat := [1707, 1705, 1683, 1665, 1662, 1648, 1603, 1557, 1519, 1498, 1497, 1470, 1462, 1447, 1429, 1408, 1407, 1375, 1362, 1348, 1347, 1282, 1264, 1252, 1245, 1225, 1218, 1207, 1182, 1174, 1128, 1113, 1093, 1083, 1072, 1065, 1063, 1062, 1053, 1029, 1000, 988, 987, 985, 970, 943, 939, 858, 843, 838, 799, 792, 789, 748, 745, 739, 735, 705, 703, 634, 627, 613, 582, 573, 570, 550, 544, 522, 493, 435, 427, 420, 400, 393, 384, 262, 243, 228, 214, 165, 108, 99, 42, 0]
def high : Nat := (2^8)^1707 * (((2^8)^262144 * (2^7) - (2^7)) / (2^8-1))
def pad : Nat := (2^8)^1707 * (((2^8)^262144 * (2^7-1) - (2^7-1)) / (2^8-1))
theorem check : (expansion * anchorPolynomial 8 offsets + pad) &&& high = high := by decide +kernel
end Block1
end PackedWide
