module

public import ScaledEval
public import ScaledRefs
public import BankEntry
public import BankAccess

@[expose] public section


open GoldbachEnergy ExpLookup
namespace ScaledGrid

def Bounds.toRat (b : Bounds) : RatBounds := ⟨rational b.lo,rational b.hi⟩

theorem toRat_iff (b : Bounds) (x : ℝ) : b.toRat.Contains x ↔ b.Holds x := by
  simp [Bounds.toRat,RatBounds.Contains,Bounds.Holds]

def Entry.asLookup (e : Entry) : LookupEntry := ⟨rational e.x,0,e.b.toRat⟩

def expTest (bank : Nat → Sample) (index : Nat → Nat) (table : Nat → Entry) (i : Nat) :=
  let e := table i
  if e.x=0 then inside e.b scale scale else entryFits (bank (index i)) e.asLookup

theorem expTest_sound {bank : Nat → Sample} (valid : ∀ i,(bank i).check=true) (index : Nat → Nat)
    (table : Nat → Entry) (i : Nat) (p : expTest bank index table i=true) : ExpEntry (table i) := by
  by_cases hz : (table i).x=0
  · have pass : inside (table i).b scale scale=true := by simpa [expTest,hz] using p
    unfold ExpEntry
    rw [hz,val_zero,Real.exp_zero]
    exact interval_of_inside _ _ _ pass (by simp) (by simp)
  · have pass : entryFits (bank (index i)) (table i).asLookup=true := by simpa [expTest,hz] using p
    have h := matches_sound _ (valid _) _ pass
    apply (toRat_iff _ _).mp
    simpa [LookupEntry.Correct,Entry.asLookup,ExpEntry] using h

def atanTest (table : Nat → Entry) (i : Nat) :=
  let e := table i
  decide (0 ≤ e.x) && fits (atanPos (rational e.x)) e.b.toRat

theorem atanTest_sound (table : Nat → Entry) (i : Nat) (p : atanTest table i=true) : AtanEntry (table i) := by
  obtain ⟨pos,pass⟩ := Bool.and_eq_true_iff.mp p
  have hz : 0 ≤ (table i).x := of_decide_eq_true pos
  have hq : 0 ≤ rational (table i).x := div_nonneg (by exact_mod_cast hz) (by norm_num [scale])
  have h := fits_sound pass (atanPos_sound _ hq)
  apply (toRat_iff _ _).mp
  simpa [AtanEntry] using h

theorem checked_refs (op : Op) {ne na : Nat} {e a : Nat → Entry}
    (he : ∀ i, i < ne → ExpEntry (e i)) (ha : ∀ i, i < na → AtanEntry (a i))
    (ref : entryRefs ne na op=true) : op.Lookups e a := by
  cases op <;> try trivial
  case atan l h =>
    obtain ⟨p,q⟩ := of_decide_eq_true ref
    exact ⟨ha l p,ha h q⟩
  case exp l h =>
    obtain ⟨p,q⟩ := of_decide_eq_true ref
    exact ⟨he l p,he h q⟩
  case log l h =>
    obtain ⟨p,q⟩ := of_decide_eq_true ref
    exact ⟨he l p,he h q⟩

#print axioms expTest_sound
#print axioms atanTest_sound
#print axioms checked_refs
end ScaledGrid
