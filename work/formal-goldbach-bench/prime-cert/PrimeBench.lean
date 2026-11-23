import PrimeSamples
import Lean.Elab.Command

open Lean

def replayPrimes (env : Lean.Environment) (names : Array Name) (label : String) (reps : Nat) : IO Unit := do
  let mut declarations : Array Declaration := #[]
  for name in names do
    match env.find? name with
    | some (.thmInfo v) =>
      declarations := declarations.push (.thmDecl {
        name := `ReplayedCertificate, levelParams := v.levelParams, type := v.type, value := v.value })
    | _ => throw (IO.userError s!"missing theorem body {name}")
  let ke := env.toKernelEnv
  for declaration in declarations do
    match ke.addDeclCore 0 100000 declaration none with
    | .error _ => throw (IO.userError "valid certificate replay rejected")
    | .ok _ => pure ()
  let bad := match declarations[0]! with
    | .thmDecl v => .thmDecl {v with value := mkSort Level.zero}
    | d => d
  let rejected := match ke.addDeclCore 0 100000 bad none with
    | .error _ => true | .ok _ => false
  if !rejected then throw (IO.userError "malformed certificate accepted")
  let start ← IO.monoNanosNow
  let mut accepted := 0
  for _ in [:reps] do
    for declaration in declarations do
      match ke.addDeclCore 0 100000 declaration none with
      | .error _ => throw (IO.userError "valid certificate replay rejected in timed loop")
      | .ok _ => accepted := accepted + 1
  let stop ← IO.monoNanosNow
  IO.println s!"label={label},nodes={declarations.size},reps={reps},accepted={accepted},bad_rejected={rejected},kernel_ns={stop-start}"

elab "#prime_bench" n:num : command => do
  let env ← getEnv
  liftM <| IO.println s!"environment_trust_level={env.header.trustLevel}"
  let roots := #[`prime_3999999988766605309, `prime_3999999988766605261, `prime_3999999988766605193]
  let names := env.constants.toList.toArray.filterMap fun (name, _) =>
    if name.toString.startsWith "prime_" &&
        (((name.toString.splitOn ".").head!).toList.drop 6).all Char.isDigit then some name else none
  for root in roots do
    liftM <| replayPrimes env #[root] (root.toString ++ "_named_body_only") n.getNat
    let localProofs := names.filter fun name => root.isPrefixOf name
    liftM <| replayPrimes env localProofs (root.toString ++ "_with_auxiliaries") n.getNat
  liftM <| replayPrimes env names "full_shared_closure" n.getNat

#prime_bench 20
