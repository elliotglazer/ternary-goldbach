import Lean
open Lean Elab Command

/-! Data elaboration only. This code constructs literal Nat definitions.
It never constructs a theorem asserting an externally computed result. Every
arithmetic theorem still goes through ordinary kernel checking. -/
namespace PackedLoader

private def nibble (c : Char) : Nat :=
  if c ≤ '9' then c.toNat - '0'.toNat else c.toNat - 'a'.toNat + 10

private partial def parseRange (chars : Array Char) (start count : Nat) : Nat :=
  if count ≤ 16 then Id.run do
    let mut value := 0
    for i in [:count] do
      value := (value <<< 4) + nibble chars[start+i]!
    return value
  else
    let left := count/2
    let right := count-left
    (parseRange chars start left <<< (4*right)) + parseRange chars (start+left) right

private def parseHex (text : String) : Except String Nat := do
  let chars := text.toList.toArray
  if chars.isEmpty then throw "empty hexadecimal input"
  unless chars.all (fun c => ('0' ≤ c && c ≤ '9') || ('a' ≤ c && c ≤ 'f')) do
    throw "invalid hexadecimal input"
  return parseRange chars 0 chars.size

private partial def toBytes (value count : Nat) : ByteArray :=
  if count ≤ 8 then Id.run do
    let mut bytes := ByteArray.empty
    for i in [:count] do
      bytes := bytes.push ((value >>> (8*i)).toUInt8)
    return bytes
  else
    let low := count/2
    let mask := (1 <<< (8*low))-1
    toBytes (value &&& mask) low ++ toBytes (value >>> (8*low)) (count-low)

private def literalValue (e : Expr) : Option Nat :=
  match e with
  | .lit (.natVal value) => some value
  | _ =>
    let args := e.getAppArgs
    if e.isAppOfArity ``OfNat.ofNat 3 && args[0]!.isConstOf ``Nat &&
        args[2]! == mkInstOfNatNat args[1]! then
      args[1]!.rawNatLit?
    else none

elab "#load_packed_literals " path:str : command => do
  let text ← IO.FS.readFile path.getString
  let json ← match Json.parse text with
    | .ok value => pure value
    | .error error => throwError "{error}"
  let ns ← getCurrNamespace
  for key in ["left","right","mask","expected"] do
    let hex ← match json.getObjValAs? String key with
      | .ok value => pure value
      | .error error => throwError "{error}"
    let t0 ← IO.monoNanosNow
    let value ← match parseHex hex with
      | .ok value => pure value
      | .error error => throwError "{error}"
    let t1 ← IO.monoNanosNow
    IO.println s!"LITERAL_PHASE,{key},parse,{t1-t0}"
    (← IO.getStdout).flush
    let name := ns ++ Name.mkSimple key
    liftCoreM <| addDecl (.defnDecl {
      name := name, levelParams := [], type := mkConst ``Nat,
      value := mkNatLit value, hints := .regular 0, safety := .safe })
    let t2 ← IO.monoNanosNow
    IO.println s!"LITERAL_PHASE,{key},declare,{t2-t1}"
    (← IO.getStdout).flush
    IO.FS.writeBinFile (path.getString ++ "." ++ key ++ ".bin")
      (toBytes value ((hex.utf8ByteSize+1)/2))
    let t3 ← IO.monoNanosNow
    IO.println s!"LITERAL_PHASE,{key},dump,{t3-t2}"
    (← IO.getStdout).flush
  logInfo "Loaded four Nat literal definitions; no arithmetic theorem was added."

elab "#audit_packed_literals " ns:ident path:str : command => do
  let json ← match Json.parse (← IO.FS.readFile path.getString) with
    | .ok value => pure value
    | .error error => throwError "{error}"
  for key in ["left","right","mask","expected"] do
    let name := ns.getId ++ Name.mkSimple key
    let info ← getConstInfo name
    let value ← match info with
      | .defnInfo d => match literalValue d.value with
        | some value => pure value
        | none => throwError "{name} is not a literal Nat definition"
      | _ => throwError "{name} is not a definition"
    let hex ← match json.getObjValAs? String key with
      | .ok value => pure value
      | .error error => throwError "{error}"
    unless value >>> (8*((hex.utf8ByteSize+1)/2)) == 0 do
      throwError "{name} has nonzero bits beyond its source payload"
    IO.FS.writeBinFile (path.getString ++ "." ++ key ++ ".imported.bin")
      (toBytes value ((hex.utf8ByteSize+1)/2))
  logInfo "Dumped the actual imported Nat declaration values."

end PackedLoader
