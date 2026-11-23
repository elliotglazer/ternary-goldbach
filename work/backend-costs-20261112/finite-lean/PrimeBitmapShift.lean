import PrimeBitmap

namespace PrimeCoverage

theorem PrimeBitmap.singleton_shift (first i : Nat) (hp : Nat.Prime (first + 2 * i)) :
    PrimeBitmap first (1 <<< i) := by
  simpa only [Nat.shiftLeft_eq, Nat.one_mul] using PrimeBitmap.singleton first i hp

end PrimeCoverage
