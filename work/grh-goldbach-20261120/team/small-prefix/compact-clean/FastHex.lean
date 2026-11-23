import Lean

namespace SmallGoldbach
open Lean Elab Term

private partial def decodeHex (bytes : ByteArray) (offset count : Nat) : Option Nat := do
  if count ≤ 16 then
    let mut value := 0
    for i in [offset:offset+count] do
      let c := bytes[i]!.toNat
      let digit ← if 48 ≤ c && c ≤ 57 then some (c-48)
        else if 97 ≤ c && c ≤ 102 then some (c-87) else none
      value := (value <<< 4) + digit
    return value
  else
    let leftCount := count / 2
    let rightCount := count - leftCount
    let left ← decodeHex bytes offset leftCount
    let right ← decodeHex bytes (offset + leftCount) rightCount
    return (left <<< (4 * rightCount)) + right

/-- Elaborate a long lowercase hexadecimal string to an ordinary natural-number literal. -/
elab "packedHex% " s:str : term => do
  let bytes := s.getString.toUTF8
  if bytes.size = 0 then throwErrorAt s "expected hexadecimal digits"
  let some value := decodeHex bytes 0 bytes.size | throwErrorAt s "invalid hexadecimal digits"
  return mkNatLit value

example : packedHex% "1000000000000000100000" = 0x1000000000000000100000 := rfl
example : packedHex% "0000010" = 16 := rfl
end SmallGoldbach
