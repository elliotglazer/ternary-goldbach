import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_0r : Nat := fixtureNat% "seg12_0r.bin"
def seg12_0p : Nat := fixtureNat% "seg12_0p.bin"
theorem seg12_0 : expand 8 12 seg12_0r = seg12_0p := by
  decide +kernel
def seg12_4096r : Nat := fixtureNat% "seg12_4096r.bin"
def seg12_4096p : Nat := fixtureNat% "seg12_4096p.bin"
theorem seg12_4096 : expand 8 12 seg12_4096r = seg12_4096p := by
  decide +kernel
def seg12_8192r : Nat := fixtureNat% "seg12_8192r.bin"
def seg12_8192p : Nat := fixtureNat% "seg12_8192p.bin"
theorem seg12_8192 : expand 8 12 seg12_8192r = seg12_8192p := by
  decide +kernel
def seg12_12288r : Nat := fixtureNat% "seg12_12288r.bin"
def seg12_12288p : Nat := fixtureNat% "seg12_12288p.bin"
theorem seg12_12288 : expand 8 12 seg12_12288r = seg12_12288p := by
  decide +kernel
def seg12_16384r : Nat := fixtureNat% "seg12_16384r.bin"
def seg12_16384p : Nat := fixtureNat% "seg12_16384p.bin"
theorem seg12_16384 : expand 8 12 seg12_16384r = seg12_16384p := by
  decide +kernel
def seg12_20480r : Nat := fixtureNat% "seg12_20480r.bin"
def seg12_20480p : Nat := fixtureNat% "seg12_20480p.bin"
theorem seg12_20480 : expand 8 12 seg12_20480r = seg12_20480p := by
  decide +kernel
def seg12_24576r : Nat := fixtureNat% "seg12_24576r.bin"
def seg12_24576p : Nat := fixtureNat% "seg12_24576p.bin"
theorem seg12_24576 : expand 8 12 seg12_24576r = seg12_24576p := by
  decide +kernel
def seg12_28672r : Nat := fixtureNat% "seg12_28672r.bin"
def seg12_28672p : Nat := fixtureNat% "seg12_28672p.bin"
theorem seg12_28672 : expand 8 12 seg12_28672r = seg12_28672p := by
  decide +kernel
def seg13_0r : Nat := fixtureNat% "seg13_0r.bin"
def seg13_0p : Nat := fixtureNat% "seg13_0p.bin"
theorem seg13_0 : expand 8 13 seg13_0r = seg13_0p := by
  exact expand_join (d:=12) (low:=seg12_0r) (high:=seg12_4096r) (by decide +kernel) (by decide +kernel) seg12_0 seg12_4096 (by decide +kernel)
def seg13_8192r : Nat := fixtureNat% "seg13_8192r.bin"
def seg13_8192p : Nat := fixtureNat% "seg13_8192p.bin"
theorem seg13_8192 : expand 8 13 seg13_8192r = seg13_8192p := by
  exact expand_join (d:=12) (low:=seg12_8192r) (high:=seg12_12288r) (by decide +kernel) (by decide +kernel) seg12_8192 seg12_12288 (by decide +kernel)
def seg13_16384r : Nat := fixtureNat% "seg13_16384r.bin"
def seg13_16384p : Nat := fixtureNat% "seg13_16384p.bin"
theorem seg13_16384 : expand 8 13 seg13_16384r = seg13_16384p := by
  exact expand_join (d:=12) (low:=seg12_16384r) (high:=seg12_20480r) (by decide +kernel) (by decide +kernel) seg12_16384 seg12_20480 (by decide +kernel)
def seg13_24576r : Nat := fixtureNat% "seg13_24576r.bin"
def seg13_24576p : Nat := fixtureNat% "seg13_24576p.bin"
theorem seg13_24576 : expand 8 13 seg13_24576r = seg13_24576p := by
  exact expand_join (d:=12) (low:=seg12_24576r) (high:=seg12_28672r) (by decide +kernel) (by decide +kernel) seg12_24576 seg12_28672 (by decide +kernel)
def seg14_0r : Nat := fixtureNat% "seg14_0r.bin"
def seg14_0p : Nat := fixtureNat% "seg14_0p.bin"
theorem seg14_0 : expand 8 14 seg14_0r = seg14_0p := by
  exact expand_join (d:=13) (low:=seg13_0r) (high:=seg13_8192r) (by decide +kernel) (by decide +kernel) seg13_0 seg13_8192 (by decide +kernel)
def seg14_16384r : Nat := fixtureNat% "seg14_16384r.bin"
def seg14_16384p : Nat := fixtureNat% "seg14_16384p.bin"
theorem seg14_16384 : expand 8 14 seg14_16384r = seg14_16384p := by
  exact expand_join (d:=13) (low:=seg13_16384r) (high:=seg13_24576r) (by decide +kernel) (by decide +kernel) seg13_16384 seg13_24576 (by decide +kernel)
def seg15_0r : Nat := fixtureNat% "seg15_0r.bin"
def seg15_0p : Nat := fixtureNat% "seg15_0p.bin"
theorem seg15_0 : expand 8 15 seg15_0r = seg15_0p := by
  exact expand_join (d:=14) (low:=seg14_0r) (high:=seg14_16384r) (by decide +kernel) (by decide +kernel) seg14_0 seg14_16384 (by decide +kernel)
end PackedWide
