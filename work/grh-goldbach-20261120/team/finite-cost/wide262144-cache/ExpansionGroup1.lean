import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_32768r : Nat := fixtureNat% "seg12_32768r.bin"
def seg12_32768p : Nat := fixtureNat% "seg12_32768p.bin"
theorem seg12_32768 : expand 8 12 seg12_32768r = seg12_32768p := by
  decide +kernel
def seg12_36864r : Nat := fixtureNat% "seg12_36864r.bin"
def seg12_36864p : Nat := fixtureNat% "seg12_36864p.bin"
theorem seg12_36864 : expand 8 12 seg12_36864r = seg12_36864p := by
  decide +kernel
def seg12_40960r : Nat := fixtureNat% "seg12_40960r.bin"
def seg12_40960p : Nat := fixtureNat% "seg12_40960p.bin"
theorem seg12_40960 : expand 8 12 seg12_40960r = seg12_40960p := by
  decide +kernel
def seg12_45056r : Nat := fixtureNat% "seg12_45056r.bin"
def seg12_45056p : Nat := fixtureNat% "seg12_45056p.bin"
theorem seg12_45056 : expand 8 12 seg12_45056r = seg12_45056p := by
  decide +kernel
def seg12_49152r : Nat := fixtureNat% "seg12_49152r.bin"
def seg12_49152p : Nat := fixtureNat% "seg12_49152p.bin"
theorem seg12_49152 : expand 8 12 seg12_49152r = seg12_49152p := by
  decide +kernel
def seg12_53248r : Nat := fixtureNat% "seg12_53248r.bin"
def seg12_53248p : Nat := fixtureNat% "seg12_53248p.bin"
theorem seg12_53248 : expand 8 12 seg12_53248r = seg12_53248p := by
  decide +kernel
def seg12_57344r : Nat := fixtureNat% "seg12_57344r.bin"
def seg12_57344p : Nat := fixtureNat% "seg12_57344p.bin"
theorem seg12_57344 : expand 8 12 seg12_57344r = seg12_57344p := by
  decide +kernel
def seg12_61440r : Nat := fixtureNat% "seg12_61440r.bin"
def seg12_61440p : Nat := fixtureNat% "seg12_61440p.bin"
theorem seg12_61440 : expand 8 12 seg12_61440r = seg12_61440p := by
  decide +kernel
def seg13_32768r : Nat := fixtureNat% "seg13_32768r.bin"
def seg13_32768p : Nat := fixtureNat% "seg13_32768p.bin"
theorem seg13_32768 : expand 8 13 seg13_32768r = seg13_32768p := by
  exact expand_join (d:=12) (low:=seg12_32768r) (high:=seg12_36864r) (by decide +kernel) (by decide +kernel) seg12_32768 seg12_36864 (by decide +kernel)
def seg13_40960r : Nat := fixtureNat% "seg13_40960r.bin"
def seg13_40960p : Nat := fixtureNat% "seg13_40960p.bin"
theorem seg13_40960 : expand 8 13 seg13_40960r = seg13_40960p := by
  exact expand_join (d:=12) (low:=seg12_40960r) (high:=seg12_45056r) (by decide +kernel) (by decide +kernel) seg12_40960 seg12_45056 (by decide +kernel)
def seg13_49152r : Nat := fixtureNat% "seg13_49152r.bin"
def seg13_49152p : Nat := fixtureNat% "seg13_49152p.bin"
theorem seg13_49152 : expand 8 13 seg13_49152r = seg13_49152p := by
  exact expand_join (d:=12) (low:=seg12_49152r) (high:=seg12_53248r) (by decide +kernel) (by decide +kernel) seg12_49152 seg12_53248 (by decide +kernel)
def seg13_57344r : Nat := fixtureNat% "seg13_57344r.bin"
def seg13_57344p : Nat := fixtureNat% "seg13_57344p.bin"
theorem seg13_57344 : expand 8 13 seg13_57344r = seg13_57344p := by
  exact expand_join (d:=12) (low:=seg12_57344r) (high:=seg12_61440r) (by decide +kernel) (by decide +kernel) seg12_57344 seg12_61440 (by decide +kernel)
def seg14_32768r : Nat := fixtureNat% "seg14_32768r.bin"
def seg14_32768p : Nat := fixtureNat% "seg14_32768p.bin"
theorem seg14_32768 : expand 8 14 seg14_32768r = seg14_32768p := by
  exact expand_join (d:=13) (low:=seg13_32768r) (high:=seg13_40960r) (by decide +kernel) (by decide +kernel) seg13_32768 seg13_40960 (by decide +kernel)
def seg14_49152r : Nat := fixtureNat% "seg14_49152r.bin"
def seg14_49152p : Nat := fixtureNat% "seg14_49152p.bin"
theorem seg14_49152 : expand 8 14 seg14_49152r = seg14_49152p := by
  exact expand_join (d:=13) (low:=seg13_49152r) (high:=seg13_57344r) (by decide +kernel) (by decide +kernel) seg13_49152 seg13_57344 (by decide +kernel)
def seg15_32768r : Nat := fixtureNat% "seg15_32768r.bin"
def seg15_32768p : Nat := fixtureNat% "seg15_32768p.bin"
theorem seg15_32768 : expand 8 15 seg15_32768r = seg15_32768p := by
  exact expand_join (d:=14) (low:=seg14_32768r) (high:=seg14_49152r) (by decide +kernel) (by decide +kernel) seg14_32768 seg14_49152 (by decide +kernel)
end PackedWide
