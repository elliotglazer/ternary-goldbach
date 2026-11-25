module

public import RadixEndpoints
public import ScalarTemplate

@[expose] public section

namespace GoldbachEnergy
open ExpLookup

/-- Certificate for one exponential endpoint, shared by any number of rows. -/
structure LookupEntry where
  x : ℚ
  n : Nat
  bound : RatBounds

def LookupEntry.zero : LookupEntry := ⟨0,0,⟨1,1⟩⟩

def LookupEntry.test (e : LookupEntry) := valid e.x e.n && fits (enclosure e.x e.n) e.bound
def LookupEntry.Correct (e : LookupEntry) : Prop := e.bound.Contains (Real.exp (e.x:ℝ))

theorem LookupEntry.zero_correct : LookupEntry.zero.Correct := by
  simp [LookupEntry.zero,LookupEntry.Correct,RatBounds.Contains]

theorem entry_correct (e : LookupEntry) (h : e.test=true) : e.Correct := by
  obtain ⟨tick,fit⟩ := Bool.and_eq_true_iff.mp h
  exact fits_sound fit (enclosure_sound _ _ tick)

theorem table_correct (t : Array LookupEntry) (h : t.all LookupEntry.test=true) (j : Nat) :
    (t.getD j LookupEntry.zero).Correct := by
  by_cases hj : j<t.size
  · simpa [Array.getD,hj] using entry_correct t[j] ((Array.all_eq_true.mp h) j hj)
  · simpa [Array.getD,hj] using LookupEntry.zero_correct

inductive LookupOp where
  | ordinary (op : ScalarOp)
  | exp (lo hi : Nat)
  | log (lo hi : Nat)

def LookupOp.code : LookupOp → OpCode
  | .ordinary op => op.code | .exp .. => .exp | .log .. => .log

def LookupOp.test (op : LookupOp) (table : Nat → LookupEntry) (inputs : Nat → RatBounds)
    (s a b : RatBounds) : Bool :=
  match op with
  | .ordinary f => f.check inputs s a b
  | .exp l h =>
    decide ((table l).x = a.lo ∧ (table h).x = a.hi) &&
      fits ⟨(table l).bound.lo,(table h).bound.hi⟩ s
  | .log l h =>
    decide ((table l).x=s.lo ∧ (table h).x=s.hi ∧ (table l).bound.hi ≤ a.lo ∧ a.hi ≤ (table h).bound.lo)

theorem LookupOp.correct (op : LookupOp) {table : Nat → LookupEntry} (cert : ∀ i,(table i).Correct)
    {inputs : ℕ → RatBounds} {input : ℕ → ℝ} (hi : ∀ i,(inputs i).Contains (input i))
    {s a b : RatBounds} {x y : ℝ} (hx : a.Contains x) (hy : b.Contains y) (hc : op.test table inputs s a b=true) :
    s.Contains (op.code.value input x y) := by
  cases op with
  | ordinary f => simpa [LookupOp.code,code_value] using f.sound hi hx hy hc
  | exp l h =>
    obtain ⟨coords,fit⟩ := Bool.and_eq_true_iff.mp hc
    obtain ⟨hl,hh⟩ := of_decide_eq_true coords
    have low := (cert l).1
    have high := (cert h).2
    rw [hl] at low; rw [hh] at high
    exact fits_sound fit ⟨low.trans (Real.exp_le_exp.mpr hx.1),(Real.exp_le_exp.mpr hx.2).trans high⟩
  | log l h =>
    obtain ⟨hl,hh,ls,hs⟩ := of_decide_eq_true hc
    have low := (cert l).2
    have high := (cert h).1
    rw [hl] at low; rw [hh] at high
    exact log_by_exp (low.trans ((by exact_mod_cast ls : ((table l).bound.hi:ℝ) ≤ a.lo).trans hx.1))
      (hx.2.trans ((by exact_mod_cast hs : (a.hi:ℝ) ≤ (table h).bound.lo).trans high))

#print axioms LookupOp.correct
end GoldbachEnergy
