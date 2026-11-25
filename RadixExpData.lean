module

public import Std

@[expose] public section


namespace RadixExp
structure Interval where
  lo : Nat
  hi : Nat
  deriving Inhabited, DecidableEq

def unit (scale : Nat) : Interval := ⟨scale,scale⟩

/-- The endpoints have one fixed denominator. Both products are rounded outwards. -/
def mul (scale : Nat) (a b : Interval) : Interval :=
  ⟨a.lo*b.lo/scale, a.hi*b.hi/scale+1⟩

structure DigitRow where
  step : Interval
  digits : Array Interval
  deriving Inhabited, DecidableEq

def digit (scale : Nat) (step : Interval) : Nat → Interval
  | 0 => unit scale
  | n+1 => mul scale (digit scale step n) step

def oneRow (scale : Nat) (step : Interval) : DigitRow :=
  ⟨step,(Array.range 17).map (digit scale step)⟩

def table (scale : Nat) : Nat → Interval → List DigitRow
  | 0,_ => []
  | n+1,step =>
    let row := oneRow scale step
    row :: table scale n row.digits[16]!

def eval (scale : Nat) : List DigitRow → Nat → Interval
  | [],_ => unit scale
  | r::rs,n =>
    if n=0 then unit scale else mul scale (r.digits[n%16]!) (eval scale rs (n/16))

/-- A concrete table is built once. Arithmetic checks on it require no analysis imports. -/
def arithmeticScale := 2^248
def ticks := 2^112
def seed : Interval := ⟨arithmeticScale+arithmeticScale/ticks,arithmeticScale+arithmeticScale/ticks+2^25⟩
def standardRows := table arithmeticScale 31 seed

end RadixExp
