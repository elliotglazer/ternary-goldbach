import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_65536r : Nat := fixtureNat% "seg12_65536r.bin"
def seg12_65536p : Nat := fixtureNat% "seg12_65536p.bin"
theorem seg12_65536 : expand 8 12 seg12_65536r = seg12_65536p := by
  decide +kernel
def seg12_69632r : Nat := fixtureNat% "seg12_69632r.bin"
def seg12_69632p : Nat := fixtureNat% "seg12_69632p.bin"
theorem seg12_69632 : expand 8 12 seg12_69632r = seg12_69632p := by
  decide +kernel
def seg12_73728r : Nat := fixtureNat% "seg12_73728r.bin"
def seg12_73728p : Nat := fixtureNat% "seg12_73728p.bin"
theorem seg12_73728 : expand 8 12 seg12_73728r = seg12_73728p := by
  decide +kernel
def seg12_77824r : Nat := fixtureNat% "seg12_77824r.bin"
def seg12_77824p : Nat := fixtureNat% "seg12_77824p.bin"
theorem seg12_77824 : expand 8 12 seg12_77824r = seg12_77824p := by
  decide +kernel
def seg12_81920r : Nat := fixtureNat% "seg12_81920r.bin"
def seg12_81920p : Nat := fixtureNat% "seg12_81920p.bin"
theorem seg12_81920 : expand 8 12 seg12_81920r = seg12_81920p := by
  decide +kernel
def seg12_86016r : Nat := fixtureNat% "seg12_86016r.bin"
def seg12_86016p : Nat := fixtureNat% "seg12_86016p.bin"
theorem seg12_86016 : expand 8 12 seg12_86016r = seg12_86016p := by
  decide +kernel
def seg12_90112r : Nat := fixtureNat% "seg12_90112r.bin"
def seg12_90112p : Nat := fixtureNat% "seg12_90112p.bin"
theorem seg12_90112 : expand 8 12 seg12_90112r = seg12_90112p := by
  decide +kernel
def seg12_94208r : Nat := fixtureNat% "seg12_94208r.bin"
def seg12_94208p : Nat := fixtureNat% "seg12_94208p.bin"
theorem seg12_94208 : expand 8 12 seg12_94208r = seg12_94208p := by
  decide +kernel
def seg13_65536r : Nat := fixtureNat% "seg13_65536r.bin"
def seg13_65536p : Nat := fixtureNat% "seg13_65536p.bin"
theorem seg13_65536 : expand 8 13 seg13_65536r = seg13_65536p := by
  exact expand_join (d:=12) (low:=seg12_65536r) (high:=seg12_69632r) (by decide +kernel) (by decide +kernel) seg12_65536 seg12_69632 (by decide +kernel)
def seg13_73728r : Nat := fixtureNat% "seg13_73728r.bin"
def seg13_73728p : Nat := fixtureNat% "seg13_73728p.bin"
theorem seg13_73728 : expand 8 13 seg13_73728r = seg13_73728p := by
  exact expand_join (d:=12) (low:=seg12_73728r) (high:=seg12_77824r) (by decide +kernel) (by decide +kernel) seg12_73728 seg12_77824 (by decide +kernel)
def seg13_81920r : Nat := fixtureNat% "seg13_81920r.bin"
def seg13_81920p : Nat := fixtureNat% "seg13_81920p.bin"
theorem seg13_81920 : expand 8 13 seg13_81920r = seg13_81920p := by
  exact expand_join (d:=12) (low:=seg12_81920r) (high:=seg12_86016r) (by decide +kernel) (by decide +kernel) seg12_81920 seg12_86016 (by decide +kernel)
def seg13_90112r : Nat := fixtureNat% "seg13_90112r.bin"
def seg13_90112p : Nat := fixtureNat% "seg13_90112p.bin"
theorem seg13_90112 : expand 8 13 seg13_90112r = seg13_90112p := by
  exact expand_join (d:=12) (low:=seg12_90112r) (high:=seg12_94208r) (by decide +kernel) (by decide +kernel) seg12_90112 seg12_94208 (by decide +kernel)
def seg14_65536r : Nat := fixtureNat% "seg14_65536r.bin"
def seg14_65536p : Nat := fixtureNat% "seg14_65536p.bin"
theorem seg14_65536 : expand 8 14 seg14_65536r = seg14_65536p := by
  exact expand_join (d:=13) (low:=seg13_65536r) (high:=seg13_73728r) (by decide +kernel) (by decide +kernel) seg13_65536 seg13_73728 (by decide +kernel)
def seg14_81920r : Nat := fixtureNat% "seg14_81920r.bin"
def seg14_81920p : Nat := fixtureNat% "seg14_81920p.bin"
theorem seg14_81920 : expand 8 14 seg14_81920r = seg14_81920p := by
  exact expand_join (d:=13) (low:=seg13_81920r) (high:=seg13_90112r) (by decide +kernel) (by decide +kernel) seg13_81920 seg13_90112 (by decide +kernel)
def seg15_65536r : Nat := fixtureNat% "seg15_65536r.bin"
def seg15_65536p : Nat := fixtureNat% "seg15_65536p.bin"
theorem seg15_65536 : expand 8 15 seg15_65536r = seg15_65536p := by
  exact expand_join (d:=14) (low:=seg14_65536r) (high:=seg14_81920r) (by decide +kernel) (by decide +kernel) seg14_65536 seg14_81920 (by decide +kernel)
end PackedWide
