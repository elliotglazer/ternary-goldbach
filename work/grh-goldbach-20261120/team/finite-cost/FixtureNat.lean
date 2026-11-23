import Lean.Elab.Term

/-! Read a finite-certificate operand as a numeral at elaboration. All
mathematical assertions involving the operand are still kernel-checked. -/
namespace Goldbach.Fixture
open Lean Elab Term

private partial def readLittleEndian (a : ByteArray) (start len : Nat) : Nat :=
  if len ≤ 8 then Id.run do
    let mut out := 0
    for j in [:len] do
      out := out + (a[start+j]!.toNat <<< (8*j))
    return out
  else
    let mid := len / 2
    readLittleEndian a start mid + (readLittleEndian a (start+mid) (len-mid) <<< (8*mid))

elab "fixtureNat% " name:str : term => do
  let bytes ← IO.FS.readBinFile name.getString
  return mkNatLit (readLittleEndian bytes 0 bytes.size)

end Goldbach.Fixture
