import PackedWideSource
import PackedWindow
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536

namespace Block0
def offsets : List Nat := [1655, 1643, 1620, 1554, 1517, 1512, 1497, 1490, 1460, 1452, 1430, 1404, 1389, 1379, 1362, 1334, 1314, 1313, 1278, 1262, 1259, 1215, 1200, 1199, 1092, 1088, 1035, 1032, 1022, 993, 968, 957, 923, 887, 878, 873, 845, 824, 812, 800, 773, 749, 737, 713, 705, 642, 635, 630, 599, 579, 557, 548, 542, 539, 537, 530, 503, 489, 483, 458, 453, 447, 444, 417, 399, 387, 384, 348, 345, 338, 315, 290, 282, 245, 234, 212, 170, 93, 44, 0]
def high : Nat := (2^8)^1663 * (((2^8)^262144 * (2^7) - (2^7)) / (2^8-1))
def pad : Nat := (2^8)^1663 * (((2^8)^262144 * (2^7-1) - (2^7-1)) / (2^8-1))
theorem check : (expansion * anchorPolynomial 8 offsets + pad) &&& high = high := by decide +kernel
end Block0
end PackedWide
