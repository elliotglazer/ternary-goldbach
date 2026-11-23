import Lean.Elab.Command
import Fixtures
open Lean

theorem or_extend (a b c d : Nat) (hab : a = b) (hcd : Nat.lor b c = d) :
    Nat.lor a c = d := Eq.trans (congrArg (fun t => Nat.lor t c) hab) hcd

namespace Measure

def eqn (a b : Expr) : Expr := mkApp3 (mkConst ``Eq [Level.succ Level.zero]) (mkConst ``Nat) a b
def refln (a : Expr) : Expr := mkApp2 (mkConst ``Eq.refl [Level.succ Level.zero]) (mkConst ``Nat) a
def op (n : Name) (a b : Expr) : Expr := mkApp2 (mkConst n) a b

def source (w k seed : Nat) : Nat := Id.run do
 let mut x := 0
 let mut s := seed+123456789
 for i in [:(w+k+31)/16] do
  s := (s*6364136223846793005+1442695040888963407)%(2^64)
  x := Nat.lor x (Nat.shiftLeft 1 (16*i+s%16))
 return x

def slices (w src : Nat) (shifts : List Nat) (chunked : Bool) : Array Expr := Id.run do
 let mask := 2^w-1
 let maxShift := shifts.foldl max 0
 let chunks := (Array.range (maxShift/w+2)).map fun i => mkNatLit (Nat.land (Nat.shiftRight src (i*w)) mask)
 let pairs := (Array.range (maxShift/w+1)).map fun i => op ``Nat.lor chunks[i]! (op ``Nat.shiftLeft chunks[i+1]! (mkNatLit w))
 let srcExpr := mkNatLit src
 return shifts.toArray.map fun s =>
  if chunked then op ``Nat.shiftRight pairs[s/w]! (mkNatLit (s%w))
  else op ``Nat.shiftRight srcExpr (mkNatLit s)

def claim (w : Nat) (xs : Array Expr) (once : Bool) : Declaration := Id.run do
 let mask := mkNatLit (2^w-1)
 let mut lhs := mkNatLit 0
 for x in xs do lhs := op ``Nat.lor lhs (if once then x else op ``Nat.land x mask)
 if once then lhs := op ``Nat.land lhs mask
 return .thmDecl {name:=`Measured,levelParams:=[],type:=eqn lhs mask,value:=refln mask}

def loop (ke : Kernel.Environment) (ds : Array Declaration) (reps : Nat) : IO Nat := do
 let mut total := 0
 for i in [:reps] do
  match ke.addDeclCore 0 100000 ds[i%ds.size]! none with
  | .ok _ => total := total+1
  | .error _ => pure ()
 return total

def measure (ke : Kernel.Environment) (label : String) (w k reps : Nat) (ds : Array Declaration) : IO Unit := do
 let accepted ← loop ke ds ds.size
 if accepted != ds.size then throw (IO.userError s!"warm rejection {label} {w} {k}: {accepted}")
 let bad := match ds[0]! with
  | .thmDecl d => Declaration.thmDecl {d with value:=refln (mkNatLit (2^w-2))}
  | _ => ds[0]!
 let rejected := match ke.addDeclCore 0 100000 bad none with | .ok _=>false | .error _=>true
 if !rejected then throw (IO.userError "corruption accepted")
 let t0 ← IO.monoNanosNow
 let ok ← loop ke ds reps
 let t1 ← IO.monoNanosNow
 IO.println s!"RESULT,{label},{w},{k},{reps},{ok},{rejected},{t1-t0}"

-- Each reusable-step theorem has its own kernel-checked local equality, and uses
-- the previous theorem plus or_extend to connect it to the full OR prefix.
def chain (ke : Kernel.Environment) (w src : Nat) (shifts : List Nat) : IO Kernel.Environment := do
 let mut env := ke
 let mask := 2^w-1
 let mut lhs := mkNatLit 0
 let mut actual := 0
 let mut previous := refln (mkNatLit 0)
 for j in [:shifts.length] do
  let xval := Nat.land (Nat.shiftRight src shifts[j]!) mask
  let x := op ``Nat.land (op ``Nat.shiftRight (mkNatLit src) (mkNatLit shifts[j]!)) (mkNatLit mask)
  let next := Nat.lor actual xval
  let nextExpr := op ``Nat.lor lhs x
  let hlocal := refln (mkNatLit next)
  let value := mkAppN (mkConst ``or_extend) #[lhs,mkNatLit actual,x,mkNatLit next,previous,hlocal]
  let name := Name.num `Step j
  let d := Declaration.thmDecl {name,levelParams:=[],type:=eqn nextExpr (mkNatLit next),value}
  match env.addDeclCore 0 100000 d none with
  | .error _ => throw (IO.userError s!"chain rejected at {j}")
  | .ok e => env := e
  previous := mkConst name
  lhs := nextExpr
  actual := next
 if actual != mask then throw (IO.userError "chain did not cover")
 let final := Declaration.thmDecl {name:=`ChainFinal,levelParams:=[],type:=eqn lhs (mkNatLit mask),value:=previous}
 match env.addDeclCore 0 100000 final none with
 | .error _ => throw (IO.userError "chain final target rejected")
 | .ok finalEnv => return finalEnv

def measureBuild (ke : Kernel.Environment) (w : Nat) (xs : Array Expr) (reps : Nat) : IO Unit := do
 let t0 ← IO.monoNanosNow
 let mut accepted := 0
 for _ in [:reps] do
  let d := claim w xs true
  match ke.addDeclCore 0 100000 d none with
  | .ok _ => accepted := accepted+1
  | .error _ => pure ()
 let t1 ← IO.monoNanosNow
 IO.println s!"RESULT,actual_cached_inputs_build_check,{w},{xs.size},{reps},{accepted},true,{t1-t0}"
 (← IO.getStdout).flush

def run (env : Environment) : IO Unit := do
 let ke := env.toKernelEnv
 IO.println s!"TRUST,{env.header.trustLevel}"
 for (w,src,shifts) in actualFixtures do
  if w == 65536 then
   for chunked in [false,true] do
    for once in [false,true] do
     let label := s!"actual_{if chunked then "chunks" else "whole"}_{if once then "once" else "each"}"
     measure ke label w shifts.length 1000 #[claim w (slices w src shifts chunked) once]
     (← IO.getStdout).flush
   measureBuild ke w (slices w src shifts true) 1000
   let t0 ← IO.monoNanosNow
   for _ in [:5] do discard <| chain ke w src shifts
   let t1 ← IO.monoNanosNow
   IO.println s!"RESULT,actual_reusable_steps,{w},{shifts.length},5,5,true,{t1-t0}"
   (← IO.getStdout).flush
end Measure

elab "#run_measurements" : command => do
 let env ← getEnv
 liftM <| Measure.run env

#run_measurements

