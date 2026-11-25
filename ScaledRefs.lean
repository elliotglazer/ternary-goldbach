module

public import ScaledData

@[expose] public section


namespace ScaledGrid
inductive Tag where
  | literal (x : Int) | input (j : Nat) | pi | add | neg | mul | inv | min | max | sqrt | atan | exp | log
  deriving Inhabited, DecidableEq

def Tag.fill (f : Nat → Int) : Tag → Tag
  | .input j => .literal (f j)
  | k => k

def Op.tag (x : Int) : Op → Tag
  | .lit => .literal x | .pi => .pi | .add => .add | .neg => .neg | .mul => .mul | .inv => .inv
  | .min => .min | .max => .max | .sqrt => .sqrt | .atan .. => .atan | .exp .. => .exp | .log .. => .log

def Tag.leftUsed : Tag → Bool
  | .literal .. | .input .. | .pi => false
  | _ => true

def Tag.rightUsed : Tag → Bool
  | .add | .mul | .min | .max => true
  | _ => false

structure Step where
  tag : Tag
  left : Nat
  right : Nat
  deriving Inhabited

def WireOK (ids : Nat → Nat) (localRef globalRef loc glob : Nat) :=
  localRef < loc ∧ globalRef < glob ∧ ids localRef=globalRef

def wire (ids : Nat → Nat) (localRef globalRef loc glob : Nat) :=
  decide (localRef < loc ∧ globalRef < glob ∧ ids localRef=globalRef)

def binding (pool : Nat → Node) (size : Nat) (f : Nat → Int) (tape : Nat → Step) (ids : Nat → Nat) (j : Nat) :=
  let g := ids j
  let n := pool g
  let s := tape j
  decide (g < size ∧ s.tag.fill f=n.op.tag n.b.lo) &&
    (!s.tag.leftUsed || wire ids s.left n.left j g) &&
    (!s.tag.rightUsed || wire ids s.right n.right j g)

def entryRefs (ne na : Nat) : Op → Bool
  | .log l h | .exp l h => decide (l < ne ∧ h < ne)
  | .atan l h => decide (l < na ∧ h < na)
  | _ => true

end ScaledGrid
