import FiniteReplay

/-! The same renamed kernel replay, with parent-process CPU sampling at explicit
handshakes. Timing instrumentation has no role in the accepted mathematics. -/

open Lean
namespace RawReplay

def handshake (stage label : String) : IO Unit := do
  let some directory ← IO.getEnv "RAW_REPLAY_HANDSHAKE"
    | throw (IO.userError "missing CPU handshake directory")
  let base := System.FilePath.mk directory
  let key := s!"{stage}.{label}"
  let request := base / s!"{key}.request"
  let temporary := base / s!"{key}.temporary"
  let acknowledgement := base / s!"{key}.ack"
  if (← request.pathExists) || (← acknowledgement.pathExists) then
    throw (IO.userError "duplicate CPU handshake")
  IO.FS.writeFile temporary "ready\n"
  IO.FS.rename temporary request
  while !(← acknowledgement.pathExists) do IO.sleep 2
  let line ← IO.FS.readFile acknowledgement
  unless line == "go\n" do
    throw (IO.userError "missing CPU sampling acknowledgement")

def measure (env : Environment) (root : Name) (label namespacePrefix : String)
    (width reps : Nat) (hb depth : USize) : IO Unit := do
  if env.header.trustLevel != 0 then throw (IO.userError "nonzero trust")
  if reps == 0 then throw (IO.userError "zero replay repetitions")
  unless root.toString.startsWith namespacePrefix do
    throw (IO.userError "root outside replay namespace")
  let tgen ← IO.monoNanosNow
  let (_, names) ← FiniteReplay.collect env namespacePrefix root {} #[]
  let ds ← FiniteReplay.pool env names namespacePrefix
  let tgenerated ← IO.monoNanosNow
  let base := env.toKernelEnv
  FiniteReplay.checkBundle base ds hb depth
  handshake "START" label
  let t0 ← IO.monoNanosNow
  for _ in [:reps] do FiniteReplay.checkBundle base ds hb depth
  let t1 ← IO.monoNanosNow
  handshake "STOP" label
  IO.println s!"COVER,{label},{width},{reps},{ds.size},{tgenerated-tgen},{t1-t0}"
  (← IO.getStdout).flush

elab "#replay_raw " label:str namespacePrefix:str width:num reps:num root:ident : command => do
  let env ← getEnv
  let opts ← getOptions
  let hb := (Lean.Core.getMaxHeartbeats opts).toUSize
  let depth := (maxRecDepth.get opts).toUSize
  liftM <| IO.println s!"LIMITS,trust={env.header.trustLevel},heartbeats={hb},recdepth={depth}"
  liftM <| measure env root.getId label.getString namespacePrefix.getString width.getNat reps.getNat hb depth

end RawReplay
