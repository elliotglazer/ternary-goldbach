import PrimeSamples32
import Lean.Elab.Command

open Lean

def sampleParentCPU : IO Nat := do
  let pid ← IO.Process.getPID
  let output ← IO.Process.output {cmd := "python", args := #["sample_parent_cpu.py", toString pid]}
  if output.exitCode != 0 then throw (IO.userError output.stderr)
  match output.stdout.trimAscii.toString.toNat? with
  | some n => return n
  | none => throw (IO.userError s!"invalid CPU sample: {output.stdout}")

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
  let cpuStart ← sampleParentCPU
  let start ← IO.monoNanosNow
  let mut accepted := 0
  for _ in [:reps] do
    for declaration in declarations do
      match ke.addDeclCore 0 100000 declaration none with
      | .error _ => throw (IO.userError "valid certificate replay rejected in timed loop")
      | .ok _ => accepted := accepted + 1
  let stop ← IO.monoNanosNow
  let cpuStop ← sampleParentCPU
  IO.println s!"label={label},nodes={declarations.size},reps={reps},accepted={accepted},bad_rejected={rejected},kernel_ns={stop-start},process_cpu_ns={cpuStop-cpuStart}"

elab "#prime_bench32" n:num : command => do
  let env ← getEnv
  liftM <| IO.println s!"environment_trust_level={env.header.trustLevel}"
  let roots := #[`prime_3999999988766605309, `prime_3999999988766605261, `prime_3999999988766605193, `prime_3999999988766605099, `prime_3999999988765673297, `prime_3999999988766107327, `prime_3999999988766040709, `prime_3999999988765879447, `prime_3999999980176670707, `prime_3999999980176670627, `prime_3999999980176670623, `prime_3999999980176670593, `prime_3999999980175864121, `prime_3999999980176594789, `prime_3999999980176195003, `prime_3999999980176382437, `prime_3999999928637063159, `prime_3999999928637063129, `prime_3999999928637063093, `prime_3999999928637063089, `prime_3999999928636075751, `prime_3999999928636623547, `prime_3999999928636585183, `prime_3999999928636925483, `prime_1999999985793368063, `prime_1999999985793368059, `prime_1999999985793367949, `prime_1999999985793367889, `prime_1999999985792685463, `prime_1999999985793146801, `prime_1999999985792775139, `prime_1999999985793034427]
  let names := env.constants.toList.toArray.filterMap fun (name, _) =>
    if name.toString.startsWith "prime_" &&
        (((name.toString.splitOn ".").head!).toList.drop 6).all Char.isDigit then some name else none
  let namedNodes := names.filter fun name => (name.toString.toList.drop 6).all Char.isDigit
  liftM <| IO.println s!"named_pratt_nodes={namedNodes.size},all_local_declarations={names.size},roots={roots.size}"
  let rootProofs := names.filter fun name => roots.any fun root => root.isPrefixOf name
  liftM <| replayPrimes env roots "roots_named_bodies_only" n.getNat
  liftM <| replayPrimes env rootProofs "roots_with_all_auxiliaries" n.getNat
  liftM <| replayPrimes env names "full_shared_closure" n.getNat

#prime_bench32 10
