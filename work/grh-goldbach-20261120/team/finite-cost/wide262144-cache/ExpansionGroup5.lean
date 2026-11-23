import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_163840r : Nat := fixtureNat% "seg12_163840r.bin"
def seg12_163840p : Nat := fixtureNat% "seg12_163840p.bin"
theorem seg12_163840 : expand 8 12 seg12_163840r = seg12_163840p := by
  decide +kernel
def seg12_167936r : Nat := fixtureNat% "seg12_167936r.bin"
def seg12_167936p : Nat := fixtureNat% "seg12_167936p.bin"
theorem seg12_167936 : expand 8 12 seg12_167936r = seg12_167936p := by
  decide +kernel
def seg12_172032r : Nat := fixtureNat% "seg12_172032r.bin"
def seg12_172032p : Nat := fixtureNat% "seg12_172032p.bin"
theorem seg12_172032 : expand 8 12 seg12_172032r = seg12_172032p := by
  decide +kernel
def seg12_176128r : Nat := fixtureNat% "seg12_176128r.bin"
def seg12_176128p : Nat := fixtureNat% "seg12_176128p.bin"
theorem seg12_176128 : expand 8 12 seg12_176128r = seg12_176128p := by
  decide +kernel
def seg12_180224r : Nat := fixtureNat% "seg12_180224r.bin"
def seg12_180224p : Nat := fixtureNat% "seg12_180224p.bin"
theorem seg12_180224 : expand 8 12 seg12_180224r = seg12_180224p := by
  decide +kernel
def seg12_184320r : Nat := fixtureNat% "seg12_184320r.bin"
def seg12_184320p : Nat := fixtureNat% "seg12_184320p.bin"
theorem seg12_184320 : expand 8 12 seg12_184320r = seg12_184320p := by
  decide +kernel
def seg12_188416r : Nat := fixtureNat% "seg12_188416r.bin"
def seg12_188416p : Nat := fixtureNat% "seg12_188416p.bin"
theorem seg12_188416 : expand 8 12 seg12_188416r = seg12_188416p := by
  decide +kernel
def seg12_192512r : Nat := fixtureNat% "seg12_192512r.bin"
def seg12_192512p : Nat := fixtureNat% "seg12_192512p.bin"
theorem seg12_192512 : expand 8 12 seg12_192512r = seg12_192512p := by
  decide +kernel
def seg13_163840r : Nat := fixtureNat% "seg13_163840r.bin"
def seg13_163840p : Nat := fixtureNat% "seg13_163840p.bin"
theorem seg13_163840 : expand 8 13 seg13_163840r = seg13_163840p := by
  exact expand_join (d:=12) (low:=seg12_163840r) (high:=seg12_167936r) (by decide +kernel) (by decide +kernel) seg12_163840 seg12_167936 (by decide +kernel)
def seg13_172032r : Nat := fixtureNat% "seg13_172032r.bin"
def seg13_172032p : Nat := fixtureNat% "seg13_172032p.bin"
theorem seg13_172032 : expand 8 13 seg13_172032r = seg13_172032p := by
  exact expand_join (d:=12) (low:=seg12_172032r) (high:=seg12_176128r) (by decide +kernel) (by decide +kernel) seg12_172032 seg12_176128 (by decide +kernel)
def seg13_180224r : Nat := fixtureNat% "seg13_180224r.bin"
def seg13_180224p : Nat := fixtureNat% "seg13_180224p.bin"
theorem seg13_180224 : expand 8 13 seg13_180224r = seg13_180224p := by
  exact expand_join (d:=12) (low:=seg12_180224r) (high:=seg12_184320r) (by decide +kernel) (by decide +kernel) seg12_180224 seg12_184320 (by decide +kernel)
def seg13_188416r : Nat := fixtureNat% "seg13_188416r.bin"
def seg13_188416p : Nat := fixtureNat% "seg13_188416p.bin"
theorem seg13_188416 : expand 8 13 seg13_188416r = seg13_188416p := by
  exact expand_join (d:=12) (low:=seg12_188416r) (high:=seg12_192512r) (by decide +kernel) (by decide +kernel) seg12_188416 seg12_192512 (by decide +kernel)
def seg14_163840r : Nat := fixtureNat% "seg14_163840r.bin"
def seg14_163840p : Nat := fixtureNat% "seg14_163840p.bin"
theorem seg14_163840 : expand 8 14 seg14_163840r = seg14_163840p := by
  exact expand_join (d:=13) (low:=seg13_163840r) (high:=seg13_172032r) (by decide +kernel) (by decide +kernel) seg13_163840 seg13_172032 (by decide +kernel)
def seg14_180224r : Nat := fixtureNat% "seg14_180224r.bin"
def seg14_180224p : Nat := fixtureNat% "seg14_180224p.bin"
theorem seg14_180224 : expand 8 14 seg14_180224r = seg14_180224p := by
  exact expand_join (d:=13) (low:=seg13_180224r) (high:=seg13_188416r) (by decide +kernel) (by decide +kernel) seg13_180224 seg13_188416 (by decide +kernel)
def seg15_163840r : Nat := fixtureNat% "seg15_163840r.bin"
def seg15_163840p : Nat := fixtureNat% "seg15_163840p.bin"
theorem seg15_163840 : expand 8 15 seg15_163840r = seg15_163840p := by
  exact expand_join (d:=14) (low:=seg14_163840r) (high:=seg14_180224r) (by decide +kernel) (by decide +kernel) seg14_163840 seg14_180224 (by decide +kernel)
end PackedWide
