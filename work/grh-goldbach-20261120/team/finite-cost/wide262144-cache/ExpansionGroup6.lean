import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_196608r : Nat := fixtureNat% "seg12_196608r.bin"
def seg12_196608p : Nat := fixtureNat% "seg12_196608p.bin"
theorem seg12_196608 : expand 8 12 seg12_196608r = seg12_196608p := by
  decide +kernel
def seg12_200704r : Nat := fixtureNat% "seg12_200704r.bin"
def seg12_200704p : Nat := fixtureNat% "seg12_200704p.bin"
theorem seg12_200704 : expand 8 12 seg12_200704r = seg12_200704p := by
  decide +kernel
def seg12_204800r : Nat := fixtureNat% "seg12_204800r.bin"
def seg12_204800p : Nat := fixtureNat% "seg12_204800p.bin"
theorem seg12_204800 : expand 8 12 seg12_204800r = seg12_204800p := by
  decide +kernel
def seg12_208896r : Nat := fixtureNat% "seg12_208896r.bin"
def seg12_208896p : Nat := fixtureNat% "seg12_208896p.bin"
theorem seg12_208896 : expand 8 12 seg12_208896r = seg12_208896p := by
  decide +kernel
def seg12_212992r : Nat := fixtureNat% "seg12_212992r.bin"
def seg12_212992p : Nat := fixtureNat% "seg12_212992p.bin"
theorem seg12_212992 : expand 8 12 seg12_212992r = seg12_212992p := by
  decide +kernel
def seg12_217088r : Nat := fixtureNat% "seg12_217088r.bin"
def seg12_217088p : Nat := fixtureNat% "seg12_217088p.bin"
theorem seg12_217088 : expand 8 12 seg12_217088r = seg12_217088p := by
  decide +kernel
def seg12_221184r : Nat := fixtureNat% "seg12_221184r.bin"
def seg12_221184p : Nat := fixtureNat% "seg12_221184p.bin"
theorem seg12_221184 : expand 8 12 seg12_221184r = seg12_221184p := by
  decide +kernel
def seg12_225280r : Nat := fixtureNat% "seg12_225280r.bin"
def seg12_225280p : Nat := fixtureNat% "seg12_225280p.bin"
theorem seg12_225280 : expand 8 12 seg12_225280r = seg12_225280p := by
  decide +kernel
def seg13_196608r : Nat := fixtureNat% "seg13_196608r.bin"
def seg13_196608p : Nat := fixtureNat% "seg13_196608p.bin"
theorem seg13_196608 : expand 8 13 seg13_196608r = seg13_196608p := by
  exact expand_join (d:=12) (low:=seg12_196608r) (high:=seg12_200704r) (by decide +kernel) (by decide +kernel) seg12_196608 seg12_200704 (by decide +kernel)
def seg13_204800r : Nat := fixtureNat% "seg13_204800r.bin"
def seg13_204800p : Nat := fixtureNat% "seg13_204800p.bin"
theorem seg13_204800 : expand 8 13 seg13_204800r = seg13_204800p := by
  exact expand_join (d:=12) (low:=seg12_204800r) (high:=seg12_208896r) (by decide +kernel) (by decide +kernel) seg12_204800 seg12_208896 (by decide +kernel)
def seg13_212992r : Nat := fixtureNat% "seg13_212992r.bin"
def seg13_212992p : Nat := fixtureNat% "seg13_212992p.bin"
theorem seg13_212992 : expand 8 13 seg13_212992r = seg13_212992p := by
  exact expand_join (d:=12) (low:=seg12_212992r) (high:=seg12_217088r) (by decide +kernel) (by decide +kernel) seg12_212992 seg12_217088 (by decide +kernel)
def seg13_221184r : Nat := fixtureNat% "seg13_221184r.bin"
def seg13_221184p : Nat := fixtureNat% "seg13_221184p.bin"
theorem seg13_221184 : expand 8 13 seg13_221184r = seg13_221184p := by
  exact expand_join (d:=12) (low:=seg12_221184r) (high:=seg12_225280r) (by decide +kernel) (by decide +kernel) seg12_221184 seg12_225280 (by decide +kernel)
def seg14_196608r : Nat := fixtureNat% "seg14_196608r.bin"
def seg14_196608p : Nat := fixtureNat% "seg14_196608p.bin"
theorem seg14_196608 : expand 8 14 seg14_196608r = seg14_196608p := by
  exact expand_join (d:=13) (low:=seg13_196608r) (high:=seg13_204800r) (by decide +kernel) (by decide +kernel) seg13_196608 seg13_204800 (by decide +kernel)
def seg14_212992r : Nat := fixtureNat% "seg14_212992r.bin"
def seg14_212992p : Nat := fixtureNat% "seg14_212992p.bin"
theorem seg14_212992 : expand 8 14 seg14_212992r = seg14_212992p := by
  exact expand_join (d:=13) (low:=seg13_212992r) (high:=seg13_221184r) (by decide +kernel) (by decide +kernel) seg13_212992 seg13_221184 (by decide +kernel)
def seg15_196608r : Nat := fixtureNat% "seg15_196608r.bin"
def seg15_196608p : Nat := fixtureNat% "seg15_196608p.bin"
theorem seg15_196608 : expand 8 15 seg15_196608r = seg15_196608p := by
  exact expand_join (d:=14) (low:=seg14_196608r) (high:=seg14_212992r) (by decide +kernel) (by decide +kernel) seg14_196608 seg14_212992 (by decide +kernel)
end PackedWide
