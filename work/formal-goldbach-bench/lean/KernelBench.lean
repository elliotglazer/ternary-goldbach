import Lean.Elab.Command
open Lean

def mkEqNat (lhs rhs : Expr) : Expr :=
  mkApp3 (mkConst ``Eq [Level.succ Level.zero]) (mkConst ``Nat) lhs rhs

def mkReflNat (rhs : Expr) : Expr :=
  mkApp2 (mkConst ``Eq.refl [Level.succ Level.zero]) (mkConst ``Nat) rhs

def nbin (name : Name) (a b : Expr) : Expr := mkApp2 (mkConst name) a b

def sourceMask (w seed : Nat) : Nat := Id.run do
  let mut src := 0
  let mut s := seed + 123456789
  for i in [: (w + 63) / 16] do
    s := (s * 6364136223846793005 + 1442695040888963407) % (2^64)
    src := Nat.lor src (Nat.shiftLeft 1 (16*i + s % 16))
  return src

def coverExpr (w seed : Nat) : Expr × Nat := Id.run do
  let full := 2^w-1
  let src := mkNatLit (sourceMask w seed)
  let mask := mkNatLit full
  let mut acc := mkNatLit 0
  for j in [:32] do
    let slice := nbin ``Nat.land (nbin ``Nat.shiftRight src (mkNatLit j)) mask
    acc := nbin ``Nat.lor acc slice
  return (acc,full)

def declFor (lhs : Expr) (rhs : Nat) : Declaration :=
  .thmDecl {name := `MaskProof, levelParams := [], type := mkEqNat lhs (mkNatLit rhs), value := mkReflNat (mkNatLit rhs)}

def kernelLoop (env : Kernel.Environment) (pool : Array Declaration) (reps : Nat) : IO Nat := do
  let mut accepted := 0
  for i in [:reps] do
    match env.addDeclCore 0 100000 pool[i % pool.size]! none with
    | .ok _ => accepted := accepted+1
    | .error _ => pure ()
  return accepted

def runBench (env : Lean.Environment) (reps : Nat) : IO Unit := do



  IO.eprintln "stage:imported"
  let ke := env.toKernelEnv

  for w in [64,256,1024,4096,16384,65536,262144] do
    IO.eprintln s!"stage:width={w}"
    let pool := (Array.range 8).map fun seed =>
      let (lhs,rhs) := coverExpr w seed
      declFor lhs rhs
    let warm ← kernelLoop ke pool 8
    if warm != 8 then throw (IO.userError s!"valid proof rejected: width={w}, accepted={warm}")
    let (lhs,rhs) := coverExpr w 0
    let bad := declFor lhs (rhs-1)
    let rejected := match ke.addDeclCore 0 100000 bad none with | .error _ => true | .ok _ => false
    if !rejected then throw (IO.userError "corrupt proof accepted")
    let t0 ← IO.monoNanosNow
    let accepted ← kernelLoop ke pool reps
    let t1 ← IO.monoNanosNow
    IO.println s!"width={w},reps={reps},accepted={accepted},bad_rejected={rejected},kernel_ns={t1-t0},mask_ops={reps*32}"


elab "#mask_bench" n:num : command => do
  let env ← getEnv
  liftM <| runBench env n.getNat

#mask_bench 100


