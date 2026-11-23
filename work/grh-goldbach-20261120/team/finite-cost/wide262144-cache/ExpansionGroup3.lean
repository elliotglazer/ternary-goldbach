import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_98304r : Nat := fixtureNat% "seg12_98304r.bin"
def seg12_98304p : Nat := fixtureNat% "seg12_98304p.bin"
theorem seg12_98304 : expand 8 12 seg12_98304r = seg12_98304p := by
  decide +kernel
def seg12_102400r : Nat := fixtureNat% "seg12_102400r.bin"
def seg12_102400p : Nat := fixtureNat% "seg12_102400p.bin"
theorem seg12_102400 : expand 8 12 seg12_102400r = seg12_102400p := by
  decide +kernel
def seg12_106496r : Nat := fixtureNat% "seg12_106496r.bin"
def seg12_106496p : Nat := fixtureNat% "seg12_106496p.bin"
theorem seg12_106496 : expand 8 12 seg12_106496r = seg12_106496p := by
  decide +kernel
def seg12_110592r : Nat := fixtureNat% "seg12_110592r.bin"
def seg12_110592p : Nat := fixtureNat% "seg12_110592p.bin"
theorem seg12_110592 : expand 8 12 seg12_110592r = seg12_110592p := by
  decide +kernel
def seg12_114688r : Nat := fixtureNat% "seg12_114688r.bin"
def seg12_114688p : Nat := fixtureNat% "seg12_114688p.bin"
theorem seg12_114688 : expand 8 12 seg12_114688r = seg12_114688p := by
  decide +kernel
def seg12_118784r : Nat := fixtureNat% "seg12_118784r.bin"
def seg12_118784p : Nat := fixtureNat% "seg12_118784p.bin"
theorem seg12_118784 : expand 8 12 seg12_118784r = seg12_118784p := by
  decide +kernel
def seg12_122880r : Nat := fixtureNat% "seg12_122880r.bin"
def seg12_122880p : Nat := fixtureNat% "seg12_122880p.bin"
theorem seg12_122880 : expand 8 12 seg12_122880r = seg12_122880p := by
  decide +kernel
def seg12_126976r : Nat := fixtureNat% "seg12_126976r.bin"
def seg12_126976p : Nat := fixtureNat% "seg12_126976p.bin"
theorem seg12_126976 : expand 8 12 seg12_126976r = seg12_126976p := by
  decide +kernel
def seg13_98304r : Nat := fixtureNat% "seg13_98304r.bin"
def seg13_98304p : Nat := fixtureNat% "seg13_98304p.bin"
theorem seg13_98304 : expand 8 13 seg13_98304r = seg13_98304p := by
  exact expand_join (d:=12) (low:=seg12_98304r) (high:=seg12_102400r) (by decide +kernel) (by decide +kernel) seg12_98304 seg12_102400 (by decide +kernel)
def seg13_106496r : Nat := fixtureNat% "seg13_106496r.bin"
def seg13_106496p : Nat := fixtureNat% "seg13_106496p.bin"
theorem seg13_106496 : expand 8 13 seg13_106496r = seg13_106496p := by
  exact expand_join (d:=12) (low:=seg12_106496r) (high:=seg12_110592r) (by decide +kernel) (by decide +kernel) seg12_106496 seg12_110592 (by decide +kernel)
def seg13_114688r : Nat := fixtureNat% "seg13_114688r.bin"
def seg13_114688p : Nat := fixtureNat% "seg13_114688p.bin"
theorem seg13_114688 : expand 8 13 seg13_114688r = seg13_114688p := by
  exact expand_join (d:=12) (low:=seg12_114688r) (high:=seg12_118784r) (by decide +kernel) (by decide +kernel) seg12_114688 seg12_118784 (by decide +kernel)
def seg13_122880r : Nat := fixtureNat% "seg13_122880r.bin"
def seg13_122880p : Nat := fixtureNat% "seg13_122880p.bin"
theorem seg13_122880 : expand 8 13 seg13_122880r = seg13_122880p := by
  exact expand_join (d:=12) (low:=seg12_122880r) (high:=seg12_126976r) (by decide +kernel) (by decide +kernel) seg12_122880 seg12_126976 (by decide +kernel)
def seg14_98304r : Nat := fixtureNat% "seg14_98304r.bin"
def seg14_98304p : Nat := fixtureNat% "seg14_98304p.bin"
theorem seg14_98304 : expand 8 14 seg14_98304r = seg14_98304p := by
  exact expand_join (d:=13) (low:=seg13_98304r) (high:=seg13_106496r) (by decide +kernel) (by decide +kernel) seg13_98304 seg13_106496 (by decide +kernel)
def seg14_114688r : Nat := fixtureNat% "seg14_114688r.bin"
def seg14_114688p : Nat := fixtureNat% "seg14_114688p.bin"
theorem seg14_114688 : expand 8 14 seg14_114688r = seg14_114688p := by
  exact expand_join (d:=13) (low:=seg13_114688r) (high:=seg13_122880r) (by decide +kernel) (by decide +kernel) seg13_114688 seg13_122880 (by decide +kernel)
def seg15_98304r : Nat := fixtureNat% "seg15_98304r.bin"
def seg15_98304p : Nat := fixtureNat% "seg15_98304p.bin"
theorem seg15_98304 : expand 8 15 seg15_98304r = seg15_98304p := by
  exact expand_join (d:=14) (low:=seg14_98304r) (high:=seg14_114688r) (by decide +kernel) (by decide +kernel) seg14_98304 seg14_114688 (by decide +kernel)
end PackedWide
