import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_262144r : Nat := fixtureNat% "seg12_262144r.bin"
def seg12_262144p : Nat := fixtureNat% "seg12_262144p.bin"
theorem seg12_262144 : expand 8 12 seg12_262144r = seg12_262144p := by
  decide +kernel
def seg12_266240r : Nat := 0
def seg12_266240p : Nat := 0
theorem seg12_266240 : expand 8 12 seg12_266240r = seg12_266240p := by
  exact expand_zero 8 12
def seg12_270336r : Nat := 0
def seg12_270336p : Nat := 0
theorem seg12_270336 : expand 8 12 seg12_270336r = seg12_270336p := by
  exact expand_zero 8 12
def seg12_274432r : Nat := 0
def seg12_274432p : Nat := 0
theorem seg12_274432 : expand 8 12 seg12_274432r = seg12_274432p := by
  exact expand_zero 8 12
def seg12_278528r : Nat := 0
def seg12_278528p : Nat := 0
theorem seg12_278528 : expand 8 12 seg12_278528r = seg12_278528p := by
  exact expand_zero 8 12
def seg12_282624r : Nat := 0
def seg12_282624p : Nat := 0
theorem seg12_282624 : expand 8 12 seg12_282624r = seg12_282624p := by
  exact expand_zero 8 12
def seg12_286720r : Nat := 0
def seg12_286720p : Nat := 0
theorem seg12_286720 : expand 8 12 seg12_286720r = seg12_286720p := by
  exact expand_zero 8 12
def seg12_290816r : Nat := 0
def seg12_290816p : Nat := 0
theorem seg12_290816 : expand 8 12 seg12_290816r = seg12_290816p := by
  exact expand_zero 8 12
def seg13_262144r : Nat := fixtureNat% "seg13_262144r.bin"
def seg13_262144p : Nat := fixtureNat% "seg13_262144p.bin"
theorem seg13_262144 : expand 8 13 seg13_262144r = seg13_262144p := by
  exact expand_join (d:=12) (low:=seg12_262144r) (high:=seg12_266240r) (by decide +kernel) (by decide +kernel) seg12_262144 seg12_266240 (by decide +kernel)
def seg13_270336r : Nat := 0
def seg13_270336p : Nat := 0
theorem seg13_270336 : expand 8 13 seg13_270336r = seg13_270336p := by
  exact expand_zero 8 13
def seg13_278528r : Nat := 0
def seg13_278528p : Nat := 0
theorem seg13_278528 : expand 8 13 seg13_278528r = seg13_278528p := by
  exact expand_zero 8 13
def seg13_286720r : Nat := 0
def seg13_286720p : Nat := 0
theorem seg13_286720 : expand 8 13 seg13_286720r = seg13_286720p := by
  exact expand_zero 8 13
def seg14_262144r : Nat := fixtureNat% "seg14_262144r.bin"
def seg14_262144p : Nat := fixtureNat% "seg14_262144p.bin"
theorem seg14_262144 : expand 8 14 seg14_262144r = seg14_262144p := by
  exact expand_join (d:=13) (low:=seg13_262144r) (high:=seg13_270336r) (by decide +kernel) (by decide +kernel) seg13_262144 seg13_270336 (by decide +kernel)
def seg14_278528r : Nat := 0
def seg14_278528p : Nat := 0
theorem seg14_278528 : expand 8 14 seg14_278528r = seg14_278528p := by
  exact expand_zero 8 14
def seg15_262144r : Nat := fixtureNat% "seg15_262144r.bin"
def seg15_262144p : Nat := fixtureNat% "seg15_262144p.bin"
theorem seg15_262144 : expand 8 15 seg15_262144r = seg15_262144p := by
  exact expand_join (d:=14) (low:=seg14_262144r) (high:=seg14_278528r) (by decide +kernel) (by decide +kernel) seg14_262144 seg14_278528 (by decide +kernel)
end PackedWide
