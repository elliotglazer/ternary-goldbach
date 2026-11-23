import Anchors
import Shared
import Cover
namespace UpperShard1
open UpperShared UpperAnchors WideGoldbach
set_option maxHeartbeats 0
def shifts : List Nat := [2, 7, 20, 29, 34, 37, 56, 92, 106, 107, 121, 124, 125, 127, 131, 145, 151, 161, 167, 172, 187, 209, 235, 245, 260, 277, 341, 382, 419, 421, 475, 476, 509, 512, 536, 595, 604, 686, 704, 760, 781]
theorem verified : ∀ n, 3999999999983618 ≤ n → n < 4000000000000002 → n % 2 = 0 → PrimeCoverage.BinaryGoldbach n :=
  block (origin := 3999999999983618) (width := 8192) (ss := shifts) valid source_sound
    (by decide +kernel) (by decide +kernel) (by decide)
end UpperShard1
