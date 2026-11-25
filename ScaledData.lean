module

public import Std

@[expose] public section


namespace ScaledGrid

/-- All recorded rational endpoints for this strip are exactly representable at this scale. -/
def scale : Int := 9134385233318143238773030204476768872849578393600000000000000000000
def piLo : Int := (314159265358979323846 : Int)*(scale/10^20)
def piHi : Int := (314159265358979323847 : Int)*(scale/10^20)

structure Bounds where
  lo : Int
  hi : Int
  deriving Inhabited, DecidableEq

structure Entry where
  x : Int
  b : Bounds
  deriving Inhabited

inductive Op where
  | lit | pi | add | neg | mul | inv | min | max | sqrt
  | atan (lo hi : Nat) | exp (lo hi : Nat) | log (lo hi : Nat)
  deriving Inhabited

structure Node where
  op : Op
  left : Nat
  right : Nat
  b : Bounds
  deriving Inhabited

inductive Table (α : Type) where
  | leaf (a : Array α)
  | branch (cut : Nat) (l r : Table α)
  deriving Inhabited

def Table.fetch [Inhabited α] : Table α → Nat → α
  | .leaf a, i => a.getD i default
  | .branch k l r, i => if i < k then l.fetch i else r.fetch (i-k)

def inside (b : Bounds) (l h : Int) : Bool := decide (b.lo ≤ l ∧ h ≤ b.hi)

def oneProduct (b : Bounds) (a c : Int) : Bool :=
  decide (b.lo*scale ≤ a*c ∧ a*c ≤ b.hi*scale)

def unaryTable (t : Nat → Entry) (l h : Nat) (s a : Bounds) :=
  decide ((t l).x=a.lo ∧ (t h).x=a.hi ∧ s.lo ≤ (t l).b.lo ∧ (t h).b.hi ≤ s.hi)

def Op.test (op : Op) (expT atanT : Nat → Entry) (s a b : Bounds) : Bool :=
  match op with
  | .lit => decide (s.lo=s.hi)
  | .pi => inside s piLo piHi
  | .add => inside s (a.lo+b.lo) (a.hi+b.hi)
  | .neg => inside s (-a.hi) (-a.lo)
  | .mul => oneProduct s a.lo b.lo && oneProduct s a.lo b.hi &&
      oneProduct s a.hi b.lo && oneProduct s a.hi b.hi
  | .inv => decide (0 < a.lo ∧ s.lo*a.hi ≤ scale*scale ∧ scale*scale ≤ s.hi*a.lo)
  | .min => inside s (Min.min a.lo b.lo) (Min.min a.hi b.hi)
  | .max => inside s (Max.max a.lo b.lo) (Max.max a.hi b.hi)
  | .sqrt => decide (0 ≤ s.hi ∧ s.lo*s.lo ≤ a.lo*scale ∧ a.hi*scale ≤ s.hi*s.hi)
  | .exp l h => unaryTable expT l h s a
  | .atan l h => unaryTable atanT l h s a
  | .log l h => decide ((expT l).x=s.lo ∧ (expT h).x=s.hi ∧
      (expT l).b.hi ≤ a.lo ∧ a.hi ≤ (expT h).b.lo)

def prior (pool : Nat → Node) (i j : Nat) : Bounds :=
  if j < i then (pool j).b else ⟨0,0⟩

def testAt (pool : Nat → Node) (expT atanT : Nat → Entry) (i : Nat) :=
  let n := pool i
  n.op.test expT atanT n.b (prior pool i n.left) (prior pool i n.right)

def segment (test : Nat → Bool) (start count : Nat) :=
  (Array.range count).all fun j => test (start+j)

def Checked (test : Nat → Bool) (lo hi : Nat) := ∀ i, lo ≤ i → i < hi → test i=true

theorem segment_sound {test : Nat → Bool} {lo size : Nat} (h : segment test lo size=true) :
    Checked test lo (lo+size) := by
  intro i hl hh
  have mem : i-lo < (Array.range size).size := by simp; omega
  have q := (Array.all_eq_true.mp h) (i-lo) mem
  simpa [Nat.add_sub_of_le hl] using q

theorem Checked.join {test : Nat → Bool} {a b c : Nat}
    (l : Checked test a b) (r : Checked test b c) : Checked test a c := by
  intro i lo hi
  by_cases h : i < b
  · exact l i lo h
  · exact r i (Nat.le_of_not_lt h) hi

#print axioms segment_sound
end ScaledGrid
