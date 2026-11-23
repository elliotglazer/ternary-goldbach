import Lean.Elab.Command
import PackedFixtures
open Lean
namespace Packed

def eqn (a b : Expr) : Expr := mkApp3 (mkConst ``Eq [Level.succ Level.zero]) (mkConst ``Nat) a b
def refln (a : Expr) : Expr := mkApp2 (mkConst ``Eq.refl [Level.succ Level.zero]) (mkConst ``Nat) a
def op (n : Name) (a b : Expr) : Expr := mkApp2 (mkConst n) a b

def claim (p a k h : Expr) : Declaration :=
 .thmDecl {name:=`PackedCheck,levelParams:=[],type:=eqn (op ``Nat.land (op ``Nat.add (op ``Nat.mul p a) k) h) h,value:=refln h}

def run (env : Environment) : IO Unit := do
 let ke := env.toKernelEnv
 IO.println s!"TRUST,{env.header.trustLevel}"
 for (w,m,p,a,k,h) in packedFixtures do
  let pe := mkNatLit p
  let ae := mkNatLit a
  let ke_ := mkNatLit k
  let he := mkNatLit h
  let d := claim pe ae ke_ he
  let bad := claim (mkNatLit 0) ae ke_ he
  let rejected := match ke.addDeclCore 0 100000 bad none with | .error _=>true | .ok _=>false
  if !rejected then throw (IO.userError "corrupt packed source accepted")
  let reps := if w<=1024 then 10000 else 2000
  for build in [false,true] do
   let t0 ← IO.monoNanosNow
   let mut accepted := 0
   for _ in [:reps] do
    let current := if build then claim pe ae ke_ he else d
    match ke.addDeclCore 0 100000 current none with
    | .ok _=>accepted:=accepted+1
    | .error _=>pure ()
   let t1 ← IO.monoNanosNow
   if accepted != reps then throw (IO.userError "packed valid proof rejected")
   IO.println s!"RESULT,{if build then "packed_build_check" else "packed_check"},{w},{m},{reps},{accepted},{rejected},{t1-t0}"
   (← IO.getStdout).flush
end Packed

elab "#packed_bench" : command => do
 let env ← getEnv
 liftM <| Packed.run env

#packed_bench

elab "#install_packed" : command => do
 let mut env ← getEnv
 for (w,_,p,a,k,h) in packedFixtures do
  if w==65536 then
   let d := match Packed.claim (mkNatLit p) (mkNatLit a) (mkNatLit k) (mkNatLit h) with
    | .thmDecl v => Declaration.thmDecl {v with name:=`packed_actual_cover}
    | d => d
   match env.addDeclCore 0 100000 d none true with
   | .ok e=>env:=e
   | .error _=>throwError "packed theorem rejected"
 setEnv env

#install_packed
#print axioms packed_actual_cover

