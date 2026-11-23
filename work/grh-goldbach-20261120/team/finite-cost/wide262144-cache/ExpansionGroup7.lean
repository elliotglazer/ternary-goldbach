import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_229376r : Nat := fixtureNat% "seg12_229376r.bin"
def seg12_229376p : Nat := fixtureNat% "seg12_229376p.bin"
theorem seg12_229376 : expand 8 12 seg12_229376r = seg12_229376p := by
  decide +kernel
def seg12_233472r : Nat := fixtureNat% "seg12_233472r.bin"
def seg12_233472p : Nat := fixtureNat% "seg12_233472p.bin"
theorem seg12_233472 : expand 8 12 seg12_233472r = seg12_233472p := by
  decide +kernel
def seg12_237568r : Nat := fixtureNat% "seg12_237568r.bin"
def seg12_237568p : Nat := fixtureNat% "seg12_237568p.bin"
theorem seg12_237568 : expand 8 12 seg12_237568r = seg12_237568p := by
  decide +kernel
def seg12_241664r : Nat := fixtureNat% "seg12_241664r.bin"
def seg12_241664p : Nat := fixtureNat% "seg12_241664p.bin"
theorem seg12_241664 : expand 8 12 seg12_241664r = seg12_241664p := by
  decide +kernel
def seg12_245760r : Nat := fixtureNat% "seg12_245760r.bin"
def seg12_245760p : Nat := fixtureNat% "seg12_245760p.bin"
theorem seg12_245760 : expand 8 12 seg12_245760r = seg12_245760p := by
  decide +kernel
def seg12_249856r : Nat := fixtureNat% "seg12_249856r.bin"
def seg12_249856p : Nat := fixtureNat% "seg12_249856p.bin"
theorem seg12_249856 : expand 8 12 seg12_249856r = seg12_249856p := by
  decide +kernel
def seg12_253952r : Nat := fixtureNat% "seg12_253952r.bin"
def seg12_253952p : Nat := fixtureNat% "seg12_253952p.bin"
theorem seg12_253952 : expand 8 12 seg12_253952r = seg12_253952p := by
  decide +kernel
def seg12_258048r : Nat := fixtureNat% "seg12_258048r.bin"
def seg12_258048p : Nat := fixtureNat% "seg12_258048p.bin"
theorem seg12_258048 : expand 8 12 seg12_258048r = seg12_258048p := by
  decide +kernel
def seg13_229376r : Nat := fixtureNat% "seg13_229376r.bin"
def seg13_229376p : Nat := fixtureNat% "seg13_229376p.bin"
theorem seg13_229376 : expand 8 13 seg13_229376r = seg13_229376p := by
  exact expand_join (d:=12) (low:=seg12_229376r) (high:=seg12_233472r) (by decide +kernel) (by decide +kernel) seg12_229376 seg12_233472 (by decide +kernel)
def seg13_237568r : Nat := fixtureNat% "seg13_237568r.bin"
def seg13_237568p : Nat := fixtureNat% "seg13_237568p.bin"
theorem seg13_237568 : expand 8 13 seg13_237568r = seg13_237568p := by
  exact expand_join (d:=12) (low:=seg12_237568r) (high:=seg12_241664r) (by decide +kernel) (by decide +kernel) seg12_237568 seg12_241664 (by decide +kernel)
def seg13_245760r : Nat := fixtureNat% "seg13_245760r.bin"
def seg13_245760p : Nat := fixtureNat% "seg13_245760p.bin"
theorem seg13_245760 : expand 8 13 seg13_245760r = seg13_245760p := by
  exact expand_join (d:=12) (low:=seg12_245760r) (high:=seg12_249856r) (by decide +kernel) (by decide +kernel) seg12_245760 seg12_249856 (by decide +kernel)
def seg13_253952r : Nat := fixtureNat% "seg13_253952r.bin"
def seg13_253952p : Nat := fixtureNat% "seg13_253952p.bin"
theorem seg13_253952 : expand 8 13 seg13_253952r = seg13_253952p := by
  exact expand_join (d:=12) (low:=seg12_253952r) (high:=seg12_258048r) (by decide +kernel) (by decide +kernel) seg12_253952 seg12_258048 (by decide +kernel)
def seg14_229376r : Nat := fixtureNat% "seg14_229376r.bin"
def seg14_229376p : Nat := fixtureNat% "seg14_229376p.bin"
theorem seg14_229376 : expand 8 14 seg14_229376r = seg14_229376p := by
  exact expand_join (d:=13) (low:=seg13_229376r) (high:=seg13_237568r) (by decide +kernel) (by decide +kernel) seg13_229376 seg13_237568 (by decide +kernel)
def seg14_245760r : Nat := fixtureNat% "seg14_245760r.bin"
def seg14_245760p : Nat := fixtureNat% "seg14_245760p.bin"
theorem seg14_245760 : expand 8 14 seg14_245760r = seg14_245760p := by
  exact expand_join (d:=13) (low:=seg13_245760r) (high:=seg13_253952r) (by decide +kernel) (by decide +kernel) seg13_245760 seg13_253952 (by decide +kernel)
def seg15_229376r : Nat := fixtureNat% "seg15_229376r.bin"
def seg15_229376p : Nat := fixtureNat% "seg15_229376p.bin"
theorem seg15_229376 : expand 8 15 seg15_229376r = seg15_229376p := by
  exact expand_join (d:=14) (low:=seg14_229376r) (high:=seg14_245760r) (by decide +kernel) (by decide +kernel) seg14_229376 seg14_245760 (by decide +kernel)
end PackedWide
