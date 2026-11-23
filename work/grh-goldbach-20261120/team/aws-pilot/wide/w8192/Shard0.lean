import Anchors
import Shared
import Cover
namespace UpperShard0
open UpperShared UpperAnchors WideGoldbach
set_option maxHeartbeats 0
def shifts : List Nat := [38, 39, 54, 90, 117, 132, 158, 180, 207, 275, 278, 282, 299, 357, 363, 368, 380, 390, 399, 417, 419, 440, 474, 494, 524, 528, 572, 623, 647, 693, 705, 720, 740, 758, 770, 780, 849, 857]
theorem verified : ∀ n, 3999999999967234 ≤ n → n < 3999999999983618 → n % 2 = 0 → PrimeCoverage.BinaryGoldbach n :=
  block (origin := 3999999999967234) (width := 8192) (ss := shifts) valid source_sound
    (by decide +kernel) (by decide +kernel) (by decide)
end UpperShard0
