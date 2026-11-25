module

public import RealBoxEval

@[expose] public section


open Real
namespace GoldbachEnergy

structure Instruction where
  op : ScalarOp
  left : Nat
  right : Nat
  bound : RatBounds

def zeroBounds : RatBounds := ⟨0,0⟩

noncomputable def values (input : ℕ → ℝ) : List Instruction → Array ℝ → Array ℝ
  | [], v => v
  | i::is, v =>
      let t := i.op.value input (v.getD i.left 0) (v.getD i.right 0)
      values input is (v.push t)

def checkProgram (input : ℕ → RatBounds) : List Instruction → Array RatBounds → Bool
  | [], _ => true
  | i::is, b =>
      i.op.check input i.bound (b.getD i.left zeroBounds) (b.getD i.right zeroBounds) &&
        checkProgram input is (b.push i.bound)

def programBounds : List Instruction → Array RatBounds → Array RatBounds
  | [], b => b
  | i::is, b => programBounds is (b.push i.bound)

def Consistent (b : Array RatBounds) (v : Array ℝ) : Prop :=
  b.size=v.size ∧ ∀ j, (b.getD j zeroBounds).Contains (v.getD j 0)

private theorem push_consistent {b : Array RatBounds} {v : Array ℝ} (hc : Consistent b v)
    {s : RatBounds} {x : ℝ} (hx : s.Contains x) : Consistent (b.push s) (v.push x) := by
  obtain ⟨hs,h⟩ := hc
  constructor
  · simp [hs]
  intro j
  by_cases hj : j < b.size
  · have hv : j < v.size := hs ▸ hj
    simpa [Array.getD,hj,hv,hj.le,hv.le,Array.getElem_push] using h j
  by_cases he : j=b.size
  · subst j; simpa [Array.getD,hs,Array.getElem_push] using hx
  · have hb : ¬j < (b.push s).size := by simp; omega
    have hv : ¬j < (v.push x).size := by simp; omega
    have hnb : ¬j ≤ b.size := by omega
    have hnv : ¬j ≤ v.size := by omega
    simp [Array.getD,hnb,hnv,zeroBounds,RatBounds.Contains]

theorem checkProgram_sound (is : List Instruction) {inputs : ℕ → RatBounds} {input : ℕ → ℝ}
    (hi : ∀ j, (inputs j).Contains (input j)) {b : Array RatBounds} {v : Array ℝ}
    (hc : Consistent b v) (h : checkProgram inputs is b=true) :
    Consistent (programBounds is b) (values input is v) := by
  induction is generalizing b v with
  | nil => exact hc
  | cons i is ih =>
    obtain ⟨h1,h2⟩ := Bool.and_eq_true_iff.mp h
    exact ih (push_consistent hc (i.op.sound hi (hc.2 _) (hc.2 _) h1)) h2

theorem program_from_empty (is : List Instruction) {inputs : ℕ → RatBounds} {input : ℕ → ℝ}
    (hi : ∀ j, (inputs j).Contains (input j)) (hc : checkProgram inputs is #[]=true) (j : ℕ) :
    ((programBounds is #[]).getD j zeroBounds).Contains ((values input is #[]).getD j 0) :=
  (checkProgram_sound is hi ⟨rfl,by simp [Array.getD,zeroBounds,RatBounds.Contains]⟩ hc).2 j

#print axioms program_from_empty
end GoldbachEnergy
