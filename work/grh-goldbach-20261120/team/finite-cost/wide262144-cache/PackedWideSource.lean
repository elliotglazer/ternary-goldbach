import ExpansionGroup0
import ExpansionGroup1
import ExpansionGroup2
import ExpansionGroup3
import ExpansionGroup4
import ExpansionGroup5
import ExpansionGroup6
import ExpansionGroup7
import ExpansionGroup8
import ExpansionGroup9
import ExpansionGroup10
import ExpansionGroup11
import ExpansionGroup12
import ExpansionGroup13
import ExpansionGroup14
import ExpansionGroup15
namespace PackedWide
open Goldbach.Packed
set_option maxRecDepth 65536
def seg16_0r : Nat := fixtureNat% "seg16_0r.bin"
def seg16_0p : Nat := fixtureNat% "seg16_0p.bin"
theorem seg16_0 : expand 8 16 seg16_0r = seg16_0p := by
  exact expand_join (d:=15) (low:=seg15_0r) (high:=seg15_32768r) (by decide +kernel) (by decide +kernel) seg15_0 seg15_32768 (by decide +kernel)
def seg16_65536r : Nat := fixtureNat% "seg16_65536r.bin"
def seg16_65536p : Nat := fixtureNat% "seg16_65536p.bin"
theorem seg16_65536 : expand 8 16 seg16_65536r = seg16_65536p := by
  exact expand_join (d:=15) (low:=seg15_65536r) (high:=seg15_98304r) (by decide +kernel) (by decide +kernel) seg15_65536 seg15_98304 (by decide +kernel)
def seg16_131072r : Nat := fixtureNat% "seg16_131072r.bin"
def seg16_131072p : Nat := fixtureNat% "seg16_131072p.bin"
theorem seg16_131072 : expand 8 16 seg16_131072r = seg16_131072p := by
  exact expand_join (d:=15) (low:=seg15_131072r) (high:=seg15_163840r) (by decide +kernel) (by decide +kernel) seg15_131072 seg15_163840 (by decide +kernel)
def seg16_196608r : Nat := fixtureNat% "seg16_196608r.bin"
def seg16_196608p : Nat := fixtureNat% "seg16_196608p.bin"
theorem seg16_196608 : expand 8 16 seg16_196608r = seg16_196608p := by
  exact expand_join (d:=15) (low:=seg15_196608r) (high:=seg15_229376r) (by decide +kernel) (by decide +kernel) seg15_196608 seg15_229376 (by decide +kernel)
def seg16_262144r : Nat := fixtureNat% "seg16_262144r.bin"
def seg16_262144p : Nat := fixtureNat% "seg16_262144p.bin"
theorem seg16_262144 : expand 8 16 seg16_262144r = seg16_262144p := by
  exact expand_join (d:=15) (low:=seg15_262144r) (high:=seg15_294912r) (by decide +kernel) (by decide +kernel) seg15_262144 seg15_294912 (by decide +kernel)
def seg16_327680r : Nat := 0
def seg16_327680p : Nat := 0
theorem seg16_327680 : expand 8 16 seg16_327680r = seg16_327680p := by
  exact expand_zero 8 16
def seg16_393216r : Nat := 0
def seg16_393216p : Nat := 0
theorem seg16_393216 : expand 8 16 seg16_393216r = seg16_393216p := by
  exact expand_zero 8 16
def seg16_458752r : Nat := 0
def seg16_458752p : Nat := 0
theorem seg16_458752 : expand 8 16 seg16_458752r = seg16_458752p := by
  exact expand_zero 8 16
def seg17_0r : Nat := fixtureNat% "seg17_0r.bin"
def seg17_0p : Nat := fixtureNat% "seg17_0p.bin"
theorem seg17_0 : expand 8 17 seg17_0r = seg17_0p := by
  exact expand_join (d:=16) (low:=seg16_0r) (high:=seg16_65536r) (by decide +kernel) (by decide +kernel) seg16_0 seg16_65536 (by decide +kernel)
def seg17_131072r : Nat := fixtureNat% "seg17_131072r.bin"
def seg17_131072p : Nat := fixtureNat% "seg17_131072p.bin"
theorem seg17_131072 : expand 8 17 seg17_131072r = seg17_131072p := by
  exact expand_join (d:=16) (low:=seg16_131072r) (high:=seg16_196608r) (by decide +kernel) (by decide +kernel) seg16_131072 seg16_196608 (by decide +kernel)
def seg17_262144r : Nat := fixtureNat% "seg17_262144r.bin"
def seg17_262144p : Nat := fixtureNat% "seg17_262144p.bin"
theorem seg17_262144 : expand 8 17 seg17_262144r = seg17_262144p := by
  exact expand_join (d:=16) (low:=seg16_262144r) (high:=seg16_327680r) (by decide +kernel) (by decide +kernel) seg16_262144 seg16_327680 (by decide +kernel)
def seg17_393216r : Nat := 0
def seg17_393216p : Nat := 0
theorem seg17_393216 : expand 8 17 seg17_393216r = seg17_393216p := by
  exact expand_zero 8 17
def seg18_0r : Nat := fixtureNat% "seg18_0r.bin"
def seg18_0p : Nat := fixtureNat% "seg18_0p.bin"
theorem seg18_0 : expand 8 18 seg18_0r = seg18_0p := by
  exact expand_join (d:=17) (low:=seg17_0r) (high:=seg17_131072r) (by decide +kernel) (by decide +kernel) seg17_0 seg17_131072 (by decide +kernel)
def seg18_262144r : Nat := fixtureNat% "seg18_262144r.bin"
def seg18_262144p : Nat := fixtureNat% "seg18_262144p.bin"
theorem seg18_262144 : expand 8 18 seg18_262144r = seg18_262144p := by
  exact expand_join (d:=17) (low:=seg17_262144r) (high:=seg17_393216r) (by decide +kernel) (by decide +kernel) seg17_262144 seg17_393216 (by decide +kernel)
def seg19_0r : Nat := fixtureNat% "seg19_0r.bin"
def seg19_0p : Nat := fixtureNat% "seg19_0p.bin"
theorem seg19_0 : expand 8 19 seg19_0r = seg19_0p := by
  exact expand_join (d:=18) (low:=seg18_0r) (high:=seg18_262144r) (by decide +kernel) (by decide +kernel) seg18_0 seg18_262144 (by decide +kernel)
theorem bound : source < 2^(2^19) := by decide +kernel
theorem certified : expand 8 19 source = expansion := seg19_0
end PackedWide
#print axioms PackedWide.certified
