import Lean.Elab.Tactic.Omega

/-! Timing probe for stock-kernel arithmetic. The packed equality alone does
not prove the pointwise product specification; that positional bridge is a
separate obligation. No full-network saving is claimed by this probe. -/
namespace PackedProbe

def scalarCheck : List (Nat × Nat × Nat) → Bool
  | [] => true
  | (a,b,p)::xs => decide (a*b=p) && scalarCheck xs

def scalarSpec : List (Nat × Nat × Nat) → Prop
  | [] => True
  | (a,b,p)::xs => a*b=p ∧ scalarSpec xs

theorem scalarCheck_sound (xs : List (Nat × Nat × Nat))
    (h : scalarCheck xs = true) : scalarSpec xs := by
  induction xs with
  | nil => trivial
  | cons x xs ih =>
    rcases x with ⟨a,b,p⟩
    simp only [scalarCheck,Bool.and_eq_true,decide_eq_true_eq] at h
    exact ⟨h.1,ih h.2⟩

def packedCheck (a b mask expected : Nat) : Bool := decide (Nat.land (a*b) mask = expected)

theorem packedCheck_sound (a b mask expected : Nat)
    (h : packedCheck a b mask expected = true) : Nat.land (a*b) mask = expected :=
  of_decide_eq_true h

end PackedProbe
