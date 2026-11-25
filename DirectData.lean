module

public import ScaledRefs

@[expose] public section


namespace ScaledGrid

/-- One enclosure and the pair of lookup indices, in the formula's own instruction order. -/
structure Witness where
  b : Bounds
  l : Nat
  h : Nat
  deriving Inhabited

def Tag.op (l h : Nat) : Tag → Op
  | .literal _ | .input _ => .lit
  | .pi => .pi | .add => .add | .neg => .neg | .mul => .mul | .min => .min | .max => .max
  | .inv => .inv | .sqrt => .sqrt | .atan => .atan l h | .exp => .exp l h | .log => .log l h

def Tag.bounds (v : Nat → Int) (b : Bounds) : Tag → Bounds
  | .literal x => ⟨x,x⟩ | .input j => ⟨v j,v j⟩ | _ => b

def directNode (tape : Nat → Step) (v : Nat → Int) (w : Nat → Witness) (j : Nat) : Node :=
  let s := tape j
  let a := w j
  ⟨s.tag.op a.l a.h,s.left,s.right,s.tag.bounds v a.b⟩

def directTest (tape : Nat → Step) (v : Nat → Int) (w : Nat → Witness)
    (e a : Nat → Entry) (ne na : Nat) (j : Nat) : Bool :=
  let pool := directNode tape v w
  testAt pool e a j && entryRefs ne na (pool j).op

end ScaledGrid
