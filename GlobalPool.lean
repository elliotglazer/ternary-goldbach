module

public import LookupOperation

@[expose] public section


open Real
namespace GoldbachEnergy

structure PoolNode where
  op : LookupOp
  left : Nat
  right : Nat
  bound : RatBounds

def PoolNode.zero : PoolNode := ⟨.ordinary (.lit 0),0,0,zeroBounds⟩
abbrev Pool := Array PoolNode

def Pool.node (p : Pool) (i : Nat) := p.getD i PoolNode.zero
def Pool.prior (p : Pool) (i j : Nat) := if j < i then (p.node j).bound else zeroBounds

def Pool.test (p : Pool) (t : Nat → LookupEntry) (i : Nat) : Bool :=
  let n := p.node i
  n.op.test t (fun _ => zeroBounds) n.bound (p.prior i n.left) (p.prior i n.right)

noncomputable def Pool.value (p : Pool) (i : Nat) : ℝ :=
  let n := p.node i
  n.op.code.value (fun _ => 0) (if h : n.left < i then p.value n.left else 0)
    (if h : n.right < i then p.value n.right else 0)
termination_by i

theorem Pool.correct (p : Pool) {t : Nat → LookupEntry} (ht : ∀ j,(t j).Correct)
    (hc : ∀ i,i < p.size → p.test t i=true) (i : Nat) (hi : i < p.size) : (p.node i).bound.Contains (p.value i) := by
  induction i using Nat.strong_induction_on with
  | h i ih =>
    have prior (j : Nat) : (p.prior i j).Contains (if j < i then p.value j else 0) := by
      by_cases hj : j < i
      · simpa [Pool.prior,hj] using ih j hj (hj.trans hi)
      · simp [Pool.prior,hj,zeroBounds,RatBounds.Contains]
    rw [Pool.value]
    exact (p.node i).op.correct ht (fun _ => (show zeroBounds.Contains (0:ℝ) by simp [zeroBounds,RatBounds.Contains]))
      (prior _) (prior _) (hc i hi)

#print axioms Pool.correct
end GoldbachEnergy
