import Block1024
import Replay
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace CoverageControls1024
def good_cover : Prop := ((PrimeCoverage.shiftedUnion FiniteData1024.source FiniteData1024.shifts &&& (2 ^ 1024 - 1)) == (2 ^ 1024 - 1)) = true
#kernel_control CoverageControls1024.good_cover accept
def empty_source : Prop := ((PrimeCoverage.shiftedUnion 0 FiniteData1024.shifts &&& (2 ^ 1024 - 1)) == (2 ^ 1024 - 1)) = true
#kernel_control CoverageControls1024.empty_source reject
def empty_anchors : Prop := ((PrimeCoverage.shiftedUnion FiniteData1024.source [] &&& (2 ^ 1024 - 1)) == (2 ^ 1024 - 1)) = true
#kernel_control CoverageControls1024.empty_anchors reject
def wrong_mask : Prop := ((PrimeCoverage.shiftedUnion FiniteData1024.source FiniteData1024.shifts &&& (2 ^ 1024 - 1)) == ((2 ^ 1024 - 1) - 1)) = true
#kernel_control CoverageControls1024.wrong_mask reject
def wrong_origin : Prop := ((FiniteData1024.first + 2 * 0 + 3999999988766605309) == (FiniteData1024.target + 2)) = true
#kernel_control CoverageControls1024.wrong_origin reject
def bad_lucas_base : Prop := (decide (Nat.powMod 1 ((3999999988766605309 - 1) / 2) 3999999988766605309 ≠ 1)) = true
#kernel_control CoverageControls1024.bad_lucas_base reject
end CoverageControls1024
