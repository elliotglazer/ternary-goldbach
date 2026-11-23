import Anchors
import Shared
import Cover
namespace UpperShard0
open UpperShared UpperAnchors WideGoldbach
set_option maxHeartbeats 0
def shifts : List Nat := [8, 20, 43, 109, 146, 151, 166, 173, 203, 211, 233, 259, 274, 284, 301, 329, 349, 350, 385, 401, 404, 448, 463, 464, 571, 575, 628, 631, 641, 670, 695, 706, 740, 776, 785, 790, 818, 839, 851, 863, 890, 914, 926, 950, 958, 1021, 1028, 1033, 1064, 1084, 1106, 1115, 1121, 1124, 1126, 1133, 1160, 1174, 1180, 1205, 1210, 1216, 1219, 1246, 1264, 1276, 1279, 1315, 1318, 1325, 1348, 1373, 1381, 1418, 1429, 1451, 1493, 1570, 1619, 1663]
theorem verified : ∀ n, 3999999998951426 ≤ n → n < 3999999999475714 → n % 2 = 0 → PrimeCoverage.BinaryGoldbach n :=
  block (origin := 3999999998951426) (width := 262144) (ss := shifts) valid source_sound
    (by decide +kernel) (by decide +kernel) (by decide)
end UpperShard0
