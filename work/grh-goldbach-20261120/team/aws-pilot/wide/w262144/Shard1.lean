import Anchors
import Shared
import Cover
namespace UpperShard1
open UpperShared UpperAnchors WideGoldbach
set_option maxHeartbeats 0
def shifts : List Nat := [0, 2, 24, 42, 45, 59, 104, 150, 188, 209, 210, 237, 245, 260, 278, 299, 300, 332, 345, 359, 360, 425, 443, 455, 462, 482, 489, 500, 525, 533, 579, 594, 614, 624, 635, 642, 644, 645, 654, 678, 707, 719, 720, 722, 737, 764, 768, 849, 864, 869, 908, 915, 918, 959, 962, 968, 972, 1002, 1004, 1073, 1080, 1094, 1125, 1134, 1137, 1157, 1163, 1185, 1214, 1272, 1280, 1287, 1307, 1314, 1323, 1445, 1464, 1479, 1493, 1542, 1599, 1608, 1665, 1707]
theorem verified : ∀ n, 3999999999475714 ≤ n → n < 4000000000000002 → n % 2 = 0 → PrimeCoverage.BinaryGoldbach n :=
  block (origin := 3999999999475714) (width := 262144) (ss := shifts) valid source_sound
    (by decide +kernel) (by decide +kernel) (by decide)
end UpperShard1
