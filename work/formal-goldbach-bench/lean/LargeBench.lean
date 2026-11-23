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

partial def bytesNat (a : ByteArray) (start size : Nat) : Nat :=
 if size <= 8 then Id.run do
  let mut n := 0
  for j in [:size] do
   n := n + Nat.shiftLeft a[start+j]!.toNat (8*j)
  return n
 else
  let half := size/2
  bytesNat a start half + Nat.shiftLeft (bytesNat a (start+half) (size-half)) (8*half)

def readNat (p : String) : IO Nat := do
 let b ← IO.FS.readBinFile p
 return bytesNat b 0 b.size

def cases : List (Prod Nat (Prod Nat (List Nat))) := [(262144,188,[0,24,58,105,106,109,141,228,246,253,328,330,345,403,445,468,475,478,501,511,519,525,546,556,559,561,571,585,654,666,690,721,736,745,753,759,766,786,801,805,853,885,904,916,1014,1018,1030,1059,1060,1093,1098,1105,1108,1144,1173,1176,1245,1326,1330,1344,1369,1383,1389,1396,1401,1404,1410,1483,1488,1501,1516,1525,1533,1534,1548,1570,1579,1581,1614,1624,1663,1681,1693,1698,1704,1710,1753,1789,1851,1861,1891,1899,1903,1911,1914,1921,1978,1980,1990,1995,2038,2046,2064,2101,2116,2134,2166,2184,2214,2260,2283,2298,2313,2365,2404,2409,2449,2460,2491,2499,2500,2526,2551,2554,2566,2601,2604,2613,2650,2653,2668,2670,2691,2703,2709,2724,2725,2736,2745,2748,2761,2766,2848,2851,2853,2884,2943,3055,3100,3105,3111,3135,3138,3144,3145,3150,3165,3318,3333,3340,3343,3388,3445,3465,3478,3486,3495,3541,3553,3580,3604,3613,3615,3621,3628,3633,3640,3643,3670,3681,3705,3711,3745,3748,3760,3780,3781,3789]),(1048576,250,[0,24,58,105,106,109,141,228,246,253,328,330,345,403,445,468,475,478,501,511,519,525,546,556,559,561,571,585,654,666,690,721,736,745,753,759,766,786,801,805,853,885,904,916,1014,1018,1030,1059,1060,1093,1098,1105,1108,1144,1173,1176,1245,1326,1330,1344,1369,1383,1389,1396,1401,1404,1410,1483,1488,1501,1516,1525,1533,1534,1548,1570,1579,1581,1614,1624,1663,1681,1693,1698,1704,1710,1753,1789,1851,1861,1891,1899,1903,1911,1914,1921,1978,1980,1990,1995,2038,2046,2064,2101,2116,2134,2166,2184,2214,2260,2283,2298,2313,2365,2404,2409,2449,2460,2491,2499,2500,2526,2551,2554,2566,2601,2604,2613,2650,2653,2668,2670,2691,2703,2709,2724,2725,2736,2745,2748,2761,2766,2848,2851,2853,2884,2943,3055,3100,3105,3111,3135,3138,3144,3145,3150,3165,3318,3333,3340,3343,3388,3445,3465,3478,3486,3495,3541,3553,3580,3604,3613,3615,3621,3628,3633,3640,3643,3670,3681,3705,3711,3745,3748,3760,3780,3781,3789,3790,3825,3826,3828,3856,3898,3951,3963,3984,3996,4021,4033,4041,4074,4075,4083,4123,4138,4188,4200,4278,4285,4306,4320,4354,4395,4404,4419,4431,4465,4470,4474,4515,4521,4545,4570,4584,4593,4594,4626,4630,4648,4669,4701,4743,4749,4768,4770,4798,4839,4840,4843,4890,4911,4915,4935,4978,4983,4993,5023,5046,5056])]

def packedClaim (p a k h : Expr) : Declaration :=
 .thmDecl {name:=`PackedCheck,levelParams:=[],type:=eqn (op ``Nat.land (op ``Nat.add (op ``Nat.mul p a) k) h) h,value:=refln h}

def run (env : Environment) : IO Unit := do
 let ke := env.toKernelEnv
 IO.println s!"TRUST,{env.header.trustLevel}"
 for (w,m,shifts) in cases do
  let base := "operands/" ++ toString w ++ "_"
  let src ← readNat (base++"src.bin")
  let p ← readNat (base++"P.bin")
  let a ← readNat (base++"A.bin")
  let k ← readNat (base++"K.bin")
  let h ← readNat (base++"H.bin")
  let reps := if w>=1048576 then 100 else 500
  for chunked in [false,true] do
   measure ke (if chunked then "large_OR_chunks_once" else "large_OR_whole_once") w m reps #[claim w (slices w src shifts chunked) true]
   (← IO.getStdout).flush
  let d := packedClaim (mkNatLit p) (mkNatLit a) (mkNatLit k) (mkNatLit h)
  let bad := packedClaim (mkNatLit 0) (mkNatLit a) (mkNatLit k) (mkNatLit h)
  let rejected := match ke.addDeclCore 0 100000 bad none with | .error _=>true | .ok _=>false
  if !rejected then throw (IO.userError "corrupt packed source accepted")
  let t0 ← IO.monoNanosNow
  let ok ← loop ke #[d] reps
  let t1 ← IO.monoNanosNow
  if ok != reps then throw (IO.userError "packed valid failed")
  IO.println s!"RESULT,large_packed_check,{w},{m},{reps},{ok},{rejected},{t1-t0}"
  (← IO.getStdout).flush
end Measure
elab "#run_large" : command => do
 let env ← getEnv
 liftM <| Measure.run env
#run_large
