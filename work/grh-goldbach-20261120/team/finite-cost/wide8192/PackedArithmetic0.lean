import PackedWideSource
import PackedWindow
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536

namespace Block0
def offsets : List Nat := [819, 818, 803, 767, 740, 725, 699, 677, 650, 582, 579, 575, 558, 500, 494, 489, 477, 467, 458, 440, 438, 417, 383, 363, 333, 329, 285, 234, 210, 164, 152, 137, 117, 99, 87, 77, 8, 0]
def high : Nat := (2^7)^857 * (((2^7)^8192 * (2^6) - (2^6)) / (2^7-1))
def pad : Nat := (2^7)^857 * (((2^7)^8192 * (2^6-1) - (2^6-1)) / (2^7-1))
theorem check : (expansion * anchorPolynomial 7 offsets + pad) &&& high = high := by decide +kernel
end Block0
end PackedWide
