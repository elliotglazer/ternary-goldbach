module

public import Lean
public import ScaledData

@[expose] public section


open Lean Meta Elab Term
namespace ScaledGrid

private def numeralI (s : String) : Option Expr := do
  match ← s.toInt? with
  | .ofNat n => return mkApp (Lean.mkConst ``Int.ofNat) (mkRawNatLit n)
  | .negSucc n => return mkApp (Lean.mkConst ``Int.negSucc) (mkRawNatLit n)

private def numeralN (s : String) : Option Expr := do return mkRawNatLit (←s.toNat?)

private def boundLiteral (l h : String) : Option Expr := do
  return mkApp2 (Lean.mkConst ``Bounds.mk) (←numeralI l) (←numeralI h)

private def entryLiteral (row : String) : Option Expr := do
  let [x,l,h] := row.splitOn "," | none
  return mkApp2 (Lean.mkConst ``Entry.mk) (←numeralI x) (←boundLiteral l h)

private def nodeLiteral (row : String) : Option Expr := do
  let [tag,il,ih,a,b,l,h] := row.splitOn "," | none
  let op ← match tag with
    | "lit" => pure (Lean.mkConst ``Op.lit) | "pi" => pure (Lean.mkConst ``Op.pi)
    | "add" => pure (Lean.mkConst ``Op.add) | "neg" => pure (Lean.mkConst ``Op.neg)
    | "mul" => pure (Lean.mkConst ``Op.mul) | "inv" => pure (Lean.mkConst ``Op.inv)
    | "min" => pure (Lean.mkConst ``Op.min) | "max" => pure (Lean.mkConst ``Op.max)
    | "sqrt" => pure (Lean.mkConst ``Op.sqrt)
    | "exp" => do pure (mkApp2 (Lean.mkConst ``Op.exp) (←numeralN il) (←numeralN ih))
    | "log" => do pure (mkApp2 (Lean.mkConst ``Op.log) (←numeralN il) (←numeralN ih))
    | "atan" => do pure (mkApp2 (Lean.mkConst ``Op.atan) (←numeralN il) (←numeralN ih))
    | _ => none
  return mkApp4 (Lean.mkConst ``Node.mk) op (←numeralN a) (←numeralN b) (←boundLiteral l h)

private def records (type : Name) (parse : String → Option Expr) (s : TSyntax `str) : TermElabM Expr := do
  let fields := s.getString.splitOn ";"
  let some rows := fields.mapM parse | throwErrorAt s "Invalid numerical record"
  let ty := Lean.mkConst type
  return mkApp2 (Lean.mkConst ``Array.mk [.zero]) ty (← mkListLit ty rows)

elab "scaledNodes% " s:str : term => records ``Node nodeLiteral s
elab "scaledEntries% " s:str : term => records ``Entry entryLiteral s
elab "scaledIds% " s:str : term => records ``Nat numeralN s

private def exampleNodes : Array Node := scaledNodes% "lit,0,0,0,0,-3,-3;exp,4,6,0,0,5,9"
example : (exampleNodes.getD 0 default).b.lo = -3 := by decide +kernel
example : (exampleNodes.getD 1 default).b.hi = 9 := by decide +kernel
end ScaledGrid
