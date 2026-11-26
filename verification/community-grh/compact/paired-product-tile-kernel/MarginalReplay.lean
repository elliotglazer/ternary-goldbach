import Lean.CoreM
import Lean.Replay
import Lean.Util.FoldConsts

open Lean

private abbrev Constants := Std.HashMap Name ConstantInfo

private partial def collectNew (base : Kernel.Environment) (own : Constants)
    (pending : List Name) (seen : Constants := {}) : IO Constants := do
  match pending with
  | [] => return seen
  | name :: rest =>
    if seen.contains name || (base.find? name).isSome then
      return ← collectNew base own rest seen
    let some ci := own[name]? | throw <| IO.userError s!"unresolved constant {name}"
    if ci.isUnsafe || ci.isPartial then
      throw <| IO.userError s!"unexpected unsafe or partial declaration {name}"
    return ← collectNew base own (ci.getUsedConstantsAsSet.toList ++ rest) (seen.insert name ci)

private unsafe def timeRootClosures (modName : Name) (roots : List Name) : IO Unit := do
  let path ← findOLean modName
  let mut files := #[path]
  let server := OLeanLevel.server.adjustFileName path
  if ← server.pathExists then
    files := files.push server
    let priv := OLeanLevel.private.adjustFileName path
    if ← priv.pathExists then files := files.push priv
  let parts ← readModuleDataParts files
  if h : parts.size = 0 then throw <| IO.userError "module has no data" else
  let (pub, _) := parts[0]
  let (_, state) ← importModulesCore pub.imports |>.run
  let env ← finalizeImport state pub.imports {} 0 false false (isModule := true)
  let data := parts[parts.size-1].1
  let mut own : Constants := {}
  for name in data.constNames, ci in data.constants do own := own.insert name ci
  let mut checked := env.toKernelEnv
  let out ← IO.getStdout
  for root in roots do
    if (checked.find? root).isSome then
      throw <| IO.userError s!"benchmark root {root} already exists before its timed stage"
    let newDecls ← collectNew checked own [root]
    let added := (newDecls.toList.map fun p => p.1.toString).mergeSort (· ≤ ·)
    out.putStrLn s!"READY {root} {String.intercalate "," added}"
    out.flush
    if (← (← IO.getStdin).getLine).trimAscii != "go" then
      throw <| IO.userError "timing supervisor did not acknowledge the phase"
    let start ← IO.monoNanosNow
    checked ← checked.replay newDecls
    let stop ← IO.monoNanosNow
    unless (checked.find? root).isSome do throw <| IO.userError s!"root {root} missing after replay"
    out.putStrLn s!"DONE {root} {stop - start}"
    out.flush
  env.freeRegions

unsafe def main (args : List String) : IO UInt32 := do
  let module :: roots := args | throw <| IO.userError "expected a module and at least one root"
  if roots.isEmpty then throw <| IO.userError "expected a root"
  initSearchPath (← findSysroot)
  timeRootClosures module.toName (roots.map String.toName)
  return 0
