import PackedWideInputs
import ExpandSegments
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg12_131072r : Nat := fixtureNat% "seg12_131072r.bin"
def seg12_131072p : Nat := fixtureNat% "seg12_131072p.bin"
theorem seg12_131072 : expand 8 12 seg12_131072r = seg12_131072p := by
  decide +kernel
def seg12_135168r : Nat := fixtureNat% "seg12_135168r.bin"
def seg12_135168p : Nat := fixtureNat% "seg12_135168p.bin"
theorem seg12_135168 : expand 8 12 seg12_135168r = seg12_135168p := by
  decide +kernel
def seg12_139264r : Nat := fixtureNat% "seg12_139264r.bin"
def seg12_139264p : Nat := fixtureNat% "seg12_139264p.bin"
theorem seg12_139264 : expand 8 12 seg12_139264r = seg12_139264p := by
  decide +kernel
def seg12_143360r : Nat := fixtureNat% "seg12_143360r.bin"
def seg12_143360p : Nat := fixtureNat% "seg12_143360p.bin"
theorem seg12_143360 : expand 8 12 seg12_143360r = seg12_143360p := by
  decide +kernel
def seg12_147456r : Nat := fixtureNat% "seg12_147456r.bin"
def seg12_147456p : Nat := fixtureNat% "seg12_147456p.bin"
theorem seg12_147456 : expand 8 12 seg12_147456r = seg12_147456p := by
  decide +kernel
def seg12_151552r : Nat := fixtureNat% "seg12_151552r.bin"
def seg12_151552p : Nat := fixtureNat% "seg12_151552p.bin"
theorem seg12_151552 : expand 8 12 seg12_151552r = seg12_151552p := by
  decide +kernel
def seg12_155648r : Nat := fixtureNat% "seg12_155648r.bin"
def seg12_155648p : Nat := fixtureNat% "seg12_155648p.bin"
theorem seg12_155648 : expand 8 12 seg12_155648r = seg12_155648p := by
  decide +kernel
def seg12_159744r : Nat := fixtureNat% "seg12_159744r.bin"
def seg12_159744p : Nat := fixtureNat% "seg12_159744p.bin"
theorem seg12_159744 : expand 8 12 seg12_159744r = seg12_159744p := by
  decide +kernel
def seg13_131072r : Nat := fixtureNat% "seg13_131072r.bin"
def seg13_131072p : Nat := fixtureNat% "seg13_131072p.bin"
theorem seg13_131072 : expand 8 13 seg13_131072r = seg13_131072p := by
  exact expand_join (d:=12) (low:=seg12_131072r) (high:=seg12_135168r) (by decide +kernel) (by decide +kernel) seg12_131072 seg12_135168 (by decide +kernel)
def seg13_139264r : Nat := fixtureNat% "seg13_139264r.bin"
def seg13_139264p : Nat := fixtureNat% "seg13_139264p.bin"
theorem seg13_139264 : expand 8 13 seg13_139264r = seg13_139264p := by
  exact expand_join (d:=12) (low:=seg12_139264r) (high:=seg12_143360r) (by decide +kernel) (by decide +kernel) seg12_139264 seg12_143360 (by decide +kernel)
def seg13_147456r : Nat := fixtureNat% "seg13_147456r.bin"
def seg13_147456p : Nat := fixtureNat% "seg13_147456p.bin"
theorem seg13_147456 : expand 8 13 seg13_147456r = seg13_147456p := by
  exact expand_join (d:=12) (low:=seg12_147456r) (high:=seg12_151552r) (by decide +kernel) (by decide +kernel) seg12_147456 seg12_151552 (by decide +kernel)
def seg13_155648r : Nat := fixtureNat% "seg13_155648r.bin"
def seg13_155648p : Nat := fixtureNat% "seg13_155648p.bin"
theorem seg13_155648 : expand 8 13 seg13_155648r = seg13_155648p := by
  exact expand_join (d:=12) (low:=seg12_155648r) (high:=seg12_159744r) (by decide +kernel) (by decide +kernel) seg12_155648 seg12_159744 (by decide +kernel)
def seg14_131072r : Nat := fixtureNat% "seg14_131072r.bin"
def seg14_131072p : Nat := fixtureNat% "seg14_131072p.bin"
theorem seg14_131072 : expand 8 14 seg14_131072r = seg14_131072p := by
  exact expand_join (d:=13) (low:=seg13_131072r) (high:=seg13_139264r) (by decide +kernel) (by decide +kernel) seg13_131072 seg13_139264 (by decide +kernel)
def seg14_147456r : Nat := fixtureNat% "seg14_147456r.bin"
def seg14_147456p : Nat := fixtureNat% "seg14_147456p.bin"
theorem seg14_147456 : expand 8 14 seg14_147456r = seg14_147456p := by
  exact expand_join (d:=13) (low:=seg13_147456r) (high:=seg13_155648r) (by decide +kernel) (by decide +kernel) seg13_147456 seg13_155648 (by decide +kernel)
def seg15_131072r : Nat := fixtureNat% "seg15_131072r.bin"
def seg15_131072p : Nat := fixtureNat% "seg15_131072p.bin"
theorem seg15_131072 : expand 8 15 seg15_131072r = seg15_131072p := by
  exact expand_join (d:=14) (low:=seg14_131072r) (high:=seg14_147456r) (by decide +kernel) (by decide +kernel) seg14_131072 seg14_147456 (by decide +kernel)
end PackedWide
