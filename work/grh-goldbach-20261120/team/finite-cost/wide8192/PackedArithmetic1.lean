import PackedWideSource
import PackedWindow
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536

namespace Block1
def offsets : List Nat := [779, 774, 761, 752, 747, 744, 725, 689, 675, 674, 660, 657, 656, 654, 650, 636, 630, 620, 614, 609, 594, 572, 546, 536, 521, 504, 440, 399, 362, 360, 306, 305, 272, 269, 245, 186, 177, 95, 77, 21, 0]
def high : Nat := (2^7)^781 * (((2^7)^8192 * (2^6) - (2^6)) / (2^7-1))
def pad : Nat := (2^7)^781 * (((2^7)^8192 * (2^6-1) - (2^6-1)) / (2^7-1))
theorem check : (expansion * anchorPolynomial 7 offsets + pad) &&& high = high := by decide +kernel
end Block1
end PackedWide
