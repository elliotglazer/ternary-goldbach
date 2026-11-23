import FixtureNat
import Expand
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536

def source : Nat := fixtureNat% "bitmap.bin"
def expansion : Nat := fixtureNat% "expanded.bin"
end PackedWide
