import Lean.Elab.Command
import Init.Data.Nat.PowMod

open Lean

def modPowDecl (a e p value : Nat) : Declaration :=
  let lhs := mkApp3 (mkConst ``Nat.powMod) (mkNatLit a) (mkNatLit e) (mkNatLit p)
  let rhs := mkNatLit value
  .thmDecl {
    name := `ArithmeticCertificate, levelParams := [],
    type := mkApp3 (mkConst ``Eq [Level.succ Level.zero]) (mkConst ``Nat) lhs rhs,
    value := mkApp2 (mkConst ``Eq.refl [Level.succ Level.zero]) (mkConst ``Nat) rhs }

def modPowTest (env : Lean.Environment) (reps : Nat) : IO Unit := do
  let ke := env.toKernelEnv
  let primes := #[3999999988766605309, 3999999988766605261, 3999999988766605193]
  for p in primes do
    let declaration := modPowDecl 2 (p-1) p 1
    match ke.addDeclCore 0 100000 declaration none with
    | .error _ => throw (IO.userError "valid modular exponentiation rejected")
    | .ok _ => pure ()
    let bad := modPowDecl 2 (p-1) p 2
    let rejected := match ke.addDeclCore 0 100000 bad none with
      | .error _ => true | .ok _ => false
    if !rejected then throw (IO.userError "corrupt modular exponentiation accepted")
    let start ← IO.monoNanosNow
    let mut accepted := 0
    for _ in [:reps] do
      match ke.addDeclCore 0 100000 declaration none with
      | .error _ => throw (IO.userError "valid modular exponentiation rejected in repetition")
      | .ok _ => accepted := accepted + 1
    let stop ← IO.monoNanosNow
    IO.println s!"p={p},reps={reps},accepted={accepted},bad_rejected={rejected},kernel_ns={stop-start}"

elab "#modpow_bench" n:num : command => do
  liftM <| modPowTest (← getEnv) n.getNat

#modpow_bench 100

theorem modpow_sample : Nat.powMod 2 3999999988766605308 3999999988766605309 = 1 := by decide +kernel
#print axioms modpow_sample
