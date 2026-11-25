module

public import LookupSamples

@[expose] public section

open ExpLookup RadixExp

namespace ExpLookup

def fallback : Sample := ⟨0,arithmeticScale,arithmeticScale+arithmeticScale/ticks+2^25+2⟩

theorem fallback_checked : fallback.check=true := by decide +kernel

def sampleAt (samples : Array Sample) (i : Nat) := samples.getD i fallback

theorem sampleAt_checked (samples : Array Sample) (h : samples.all Sample.check=true) (i : Nat) :
    (sampleAt samples i).check=true := by
  by_cases hi : i < samples.size
  · simpa [sampleAt,Array.getD,hi] using (Array.all_eq_true.mp h) i hi
  · simpa [sampleAt,Array.getD,hi] using fallback_checked

inductive BankTree where
  | leaf (samples : Array Sample)
  | branch (splitAt : Nat) (left right : BankTree)

def BankTree.checked : BankTree → Prop
  | .leaf arr => arr.all Sample.check=true
  | .branch _ left right => left.checked ∧ right.checked

def BankTree.fetch : BankTree → Nat → Sample
  | .leaf arr,i => sampleAt arr i
  | .branch k l r,i => if i < k then l.fetch i else r.fetch (i-k)

theorem BankTree.fetch_checked (b : BankTree) (hb : b.checked) (i : Nat) : (b.fetch i).check=true := by
  induction b generalizing i with
  | leaf a => exact sampleAt_checked _ hb _
  | branch k l r il ir =>
    by_cases h : i < k
    · simpa only [fetch,if_pos h] using il hb.1 i
    · simpa only [fetch,if_neg h] using ir hb.2 (i-k)

#print axioms BankTree.fetch_checked
end ExpLookup
