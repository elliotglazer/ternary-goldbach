import Lean.Replay
import LeanExport.Basic
import LeanExport.Parse

open Lean

namespace GoldbachExport

abbrev Constants := Std.HashMap Name ConstantInfo

def readConstants (path : String) : IO Constants :=
  IO.FS.withFile path .read fun h => do
    return (← LeanExport.parseStream (.ofHandle h)).constMap

/-- Compare every declaration reachable from the provider's proposition across the
    two exports. The challenge supplies the reference type for this check. -/
partial def checkInterfaceClosure (left right : Constants) (pending : List Name) (seen : NameSet) :
    IO Nat := do
  match pending with
  | [] => return seen.size
  | n :: rest =>
    if seen.contains n then return ← checkInterfaceClosure left right rest seen
    let some a := left[n]? | throw <| IO.userError s!"Missing provider interface dependency {n}"
    let some b := right[n]? | throw <| IO.userError s!"Missing consumer interface dependency {n}"
    unless a == b do throw <| IO.userError s!"Different interface declaration {n}"
    let extra := match a with
      | .inductInfo v => v.ctors ++ v.all
      | _ => []
    checkInterfaceClosure left right (extra ++ a.getUsedConstantsAsSet.toList ++ rest) (seen.insert n)

def checkInterface (left right : Constants) (provider consumer : Name) : IO Unit := do
  let some p := left[provider]? | throw <| IO.userError s!"Unknown provider {provider}"
  let some (.thmInfo rule) := right[consumer]? | throw <| IO.userError s!"Unknown consumer theorem {consumer}"
  let .forallE _ domain _ _ := rule.type | throw <| IO.userError "Expected a consumer with one argument"
  unless p.levelParams.isEmpty && rule.levelParams.isEmpty && p.type == domain do
    throw <| IO.userError "The exported types differ"
  let count ← checkInterfaceClosure left right p.type.getUsedConstants.toList {}
  IO.println s!"Interface agrees on {domain} and {count} declarations in its dependency closure."

/-- Audit the actual checked constants reachable from the new theorem. -/
partial def checkAxioms (env : Kernel.Environment) (pending : List Name) (seen axioms : NameSet) :
    IO NameSet := do
  match pending with
  | [] => return axioms
  | n :: ns =>
    if seen.contains n then return ← checkAxioms env ns seen axioms
    let some ci := env.find? n | throw <| IO.userError s!"Missing checked constant {n}"
    let deps := match ci with
      | .quotInfo _ => []
      | .inductInfo v => v.ctors ++ v.type.getUsedConstants.toList
      | .defnInfo v => v.value.getUsedConstants.toList ++ v.type.getUsedConstants.toList
      | .thmInfo v => v.value.getUsedConstants.toList ++ v.type.getUsedConstants.toList
      | .opaqueInfo v => v.value.getUsedConstants.toList ++ v.type.getUsedConstants.toList
      | _ => ci.type.getUsedConstants.toList
    let mut axs := axioms
    if ci.isAxiom then
      unless [`propext, `Classical.choice, `Quot.sound].contains n do
        throw <| IO.userError s!"Additional reachable axiom {n}"
      axs := axs.insert n
    checkAxioms env (deps ++ ns) (seen.insert n) axs

/-- The input files keep their own name, universe, and expression indices.
    Their decoded constants meet by Lean name. Every shared declaration must agree. -/
def join (left right : Constants) (provider consumer target : Name)
    (output? : Option System.FilePath := none) : IO Unit := do
  let some (.thmInfo fact) := left[provider]? | throw <| IO.userError s!"Missing theorem {provider}"
  let some (.thmInfo rule) := right[consumer]? | throw <| IO.userError s!"Missing theorem {consumer}"
  unless fact.levelParams.isEmpty && rule.levelParams.isEmpty do
    throw <| IO.userError "The expected application is monomorphic"
  let .forallE _ _ conclusion _ := rule.type | throw <| IO.userError "Consumer must take an argument"
  let mut table := left
  for (name, ci) in right do
    if let some prior := table[name]? then
      unless prior == ci do throw <| IO.userError s!"Conflicting declarations for {name}"
    else table := table.insert name ci
  if table.contains target then throw <| IO.userError s!"Target {target} is already declared"
  let arg := mkConst provider
  let ty := conclusion.instantiate1 arg
  let term := mkApp (mkConst consumer) arg
  let ti : TheoremVal := { name := target, levelParams := [], type := ty, value := term }
  table := table.insert target (.thmInfo ti)
  let quotient := [`Quot.mk, `Quot.lift, `Quot.ind]
  let env ← mkEmptyEnvironment
  let checked ← env.toKernelEnv.replay (quotient.foldl (fun m k => m.erase k) table)
  for n in `Quot :: quotient do
    if let some original := table[n]? then
      unless checked.find? n == some original do throw <| IO.userError s!"Quotient mismatch at {n}"
  unless checked.find? target == some (.thmInfo ti) do
    throw <| IO.userError "The final kernel environment differs from the submitted theorem"
  let axioms ← checkAxioms checked [target] {} {}
  if let some out := output? then
    IO.FS.withFile out .writeNew fun h =>
      IO.withStdout (.ofHandle h) (LeanExport.dumpEnv (.ofKernelEnv checked) (some [target]))
  IO.println s!"Lean kernel accepted {target} : {ty}"
  IO.println s!"Proof term: {term}. Axioms: {axioms.toList}."

end GoldbachExport

def main (args : List String) : IO Unit := do
  if let ["--interface", left, right, provider, consumer] := args then
    return ← GoldbachExport.checkInterface (← GoldbachExport.readConstants left)
      (← GoldbachExport.readConstants right) provider.toName consumer.toName
  let (args, output?) := match args with
    | "--export" :: path :: rest => (rest, some (System.FilePath.mk path))
    | rest => (rest, none)
  let [left, right, provider, consumer, target] := args |
    throw <| IO.userError "Expected two export files and the provider, consumer, and new theorem names"
  GoldbachExport.join (← GoldbachExport.readConstants left) (← GoldbachExport.readConstants right)
    provider.toName consumer.toName target.toName output?
