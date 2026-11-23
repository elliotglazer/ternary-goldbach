import Lean.Elab.Command
open Lean

namespace StageReplay

/-- Include generated proof helpers, not merely their cheap public wrappers. -/
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

def renamed (names : Array Name) (e : Expr) : Expr := e.replace fun x =>
  match x with
  | .const n us => match names.findIdx? (fun old => old == n) with
    | some i => some (.const (Name.num `StageTrial i) us)
    | none => none
  | _ => none

def pool (env : Environment) (names : Array Name) (namespacePrefix : String) : IO (Array Declaration) := do
  let mut ds := #[]
  for i in [:names.size] do
    match env.find? names[i]! with
    | some (.thmInfo v) =>
      let ty := renamed names v.type
      let val := renamed names v.value
      let leftover := fun e : Expr => e.foldConsts false fun n b =>
        b || n.toString.startsWith namespacePrefix
      if leftover ty || leftover val then
        throw (IO.userError "original certificate reference survived")
      ds := ds.push (.thmDecl {name := Name.num `StageTrial i, levelParams := v.levelParams, type := ty, value := val})
    | _ => throw (IO.userError s!"missing theorem {names[i]!}")
  return ds

def checkBundle (base : Kernel.Environment) (ds : Array Declaration)
    (hb depth : USize) : IO Unit := do
  let mut env := base
  for i in [:ds.size] do
    match env.addDeclCore hb depth ds[i]! none with
    | .ok next => env := next
    | .error _ => throw (IO.userError s!"kernel rejected declaration {i}")

def measure (env : Environment) (names : Array Name) (variant : String)
    (p n reps : Nat) (hb depth : USize) : IO Unit := do
  if env.header.trustLevel != 0 then throw (IO.userError "nonzero trust")
  let namespacePrefix := s!"{variant}P{p}N{n}."
  let mut seen : NameSet := {}
  let mut closure := #[]
  for name in names do
    let (s, o) ← collect env namespacePrefix name seen closure
    seen := s
    closure := o
  let ds ← pool env closure namespacePrefix
  let base := env.toKernelEnv
  checkBundle base ds hb depth
  let t0 ← IO.monoNanosNow
  for _ in [:reps] do checkBundle base ds hb depth
  let t1 ← IO.monoNanosNow
  IO.println s!"STAGE,{variant},{p},{n},{reps},{ds.size},{t1-t0}"
  (← IO.getStdout).flush

elab "#replay_stage " variant:str p:num n:num reps:num "[" names:ident,* "]" : command => do
  let env ← getEnv
  let opts ← getOptions
  let ns := names.getElems.map (fun x => x.getId)
  let hb := (Lean.Core.getMaxHeartbeats opts).toUSize
  let depth := (maxRecDepth.get opts).toUSize
  liftM <| IO.println s!"LIMITS,trust={env.header.trustLevel},heartbeats={hb},recdepth={depth}"
  liftM <| measure env ns variant.getString p.getNat n.getNat reps.getNat hb depth

/-- Submit an arithmetic Boolean equality directly to the kernel with a reflexive
proof. A false claim must fail definitional equality, not merely a Python test. -/
elab "#kernel_control " claim:ident expected:ident : command => do
  let env ← getEnv
  let opts ← getOptions
  let some (.defnInfo v) := env.find? claim.getId
    | throwError "expected a definition of the tested proposition"
  let proof := mkApp2 (mkConst ``Eq.refl [Level.succ Level.zero])
    (mkConst ``Bool) (mkConst ``Bool.true)
  let decl := Declaration.thmDecl {name := Name.str `Control claim.getId.toString, levelParams := [], type := v.value, value := proof}
  let accepted := match env.toKernelEnv.addDeclCore
      (Lean.Core.getMaxHeartbeats opts).toUSize (maxRecDepth.get opts).toUSize decl none with
    | .ok _ => true
    | .error _ => false
  let want := expected.getId == `accept
  unless accepted == want do throwError "unexpected kernel control outcome"
  liftM <| IO.println s!"CONTROL,{claim.getId},accepted={accepted},expected={want}"
end StageReplay
