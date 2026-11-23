import Lean.Elab.Command
open Lean

namespace FiniteReplay

partial def collect (env : Environment) (namespacePrefix : String) (name : Name)
    (seen : NameSet) (order : Array Name) : IO (NameSet × Array Name) := do
  if seen.contains name then return (seen, order)
  let seen := seen.insert name
  match env.find? name with
  | some (.thmInfo v) =>
    let deps := v.value.foldConsts #[] (fun n a => a.push n)
    let deps := v.type.foldConsts deps (fun n a => a.push n)
    let mut seen := seen
    let mut order := order
    for dep in deps do
      if dep.toString.startsWith namespacePrefix then
        let (s, o) ← collect env namespacePrefix dep seen order
        seen := s
        order := o
    return (seen, order.push name)
  | _ => throw (IO.userError s!"unhandled local declaration {name}")

def renamed (renames : NameMap Name) (e : Expr) : Expr := e.replace fun x =>
  match x with
  | .const n us => (renames.find? n).map (fun replacement => .const replacement us)
  | _ => none

def pool (env : Environment) (names : Array Name) (namespacePrefix : String) : IO (Array Declaration) := do
  let mut renames : NameMap Name := {}
  for i in [:names.size] do
    renames := renames.insert names[i]! (Name.num `FiniteTrial i)
  let mut ds := #[]
  for i in [:names.size] do
    match env.find? names[i]! with
    | some (.thmInfo v) =>
      let ty := renamed renames v.type
      let val := renamed renames v.value
      let leftover := fun e : Expr => e.foldConsts false fun n b => b || n.toString.startsWith namespacePrefix
      if leftover ty || leftover val then
        throw (IO.userError "original finite certificate reference survived")
      ds := ds.push (.thmDecl {name := Name.num `FiniteTrial i, levelParams := v.levelParams, type := ty, value := val})
    | _ => throw (IO.userError s!"missing theorem {names[i]!}")
  return ds

def checkBundle (base : Kernel.Environment) (ds : Array Declaration)
    (hb depth : USize) : IO Unit := do
  let mut env := base
  for i in [:ds.size] do
    match env.addDeclCore hb depth ds[i]! none with
    | .ok next => env := next
    | .error _ => throw (IO.userError s!"kernel rejected declaration {i}")

def measure (env : Environment) (root : Name) (label namespacePrefix : String)
    (width reps : Nat) (hb depth : USize) : IO Unit := do
  if env.header.trustLevel != 0 then throw (IO.userError "nonzero trust")
  let tgen ← IO.monoNanosNow
  let (_, names) ← collect env namespacePrefix root {} #[]
  let ds ← pool env names namespacePrefix
  let tgenerated ← IO.monoNanosNow
  let base := env.toKernelEnv
  checkBundle base ds hb depth
  let t0 ← IO.monoNanosNow
  for _ in [:reps] do checkBundle base ds hb depth
  let t1 ← IO.monoNanosNow
  IO.println s!"COVER,{label},{width},{reps},{ds.size},{tgenerated-tgen},{t1-t0}"
  (← IO.getStdout).flush

elab "#replay_cover " label:str namespacePrefix:str width:num reps:num root:ident : command => do
  let env ← getEnv
  let opts ← getOptions
  let hb := (Lean.Core.getMaxHeartbeats opts).toUSize
  let depth := (maxRecDepth.get opts).toUSize
  liftM <| IO.println s!"LIMITS,trust={env.header.trustLevel},heartbeats={hb},recdepth={depth}"
  liftM <| measure env root.getId label.getString namespacePrefix.getString width.getNat reps.getNat hb depth

end FiniteReplay
