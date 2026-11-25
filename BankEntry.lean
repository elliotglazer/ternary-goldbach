module

public import SampleTransfer

@[expose] public section


namespace ExpLookup
open GoldbachEnergy RadixExp

def entryFits (s : Sample) (e : LookupEntry) :=
  decide ((s.n:ℚ)/ticks ≤ |e.x| ∧ |e.x| ≤ ((s.n+1:Nat):ℚ)/ticks) && fits (s.atSign e.x) e.bound

theorem matches_sound (s : Sample) (ok : s.check=true) (e : LookupEntry) (h : entryFits s e=true) :
    e.Correct := by
  obtain ⟨inside,outer⟩ := Bool.and_eq_true_iff.mp h
  obtain ⟨lo,hi⟩ := of_decide_eq_true inside
  exact fits_sound outer (sample_sound s ok e.x lo hi)

def testBank (entries : Array LookupEntry) (index : Array Nat) (bank : Nat → Sample) :=
  (Array.range entries.size).all fun i => entryFits (bank (index.getD i 0)) (entries.getD i LookupEntry.zero)

theorem bank_table_correct {entries : Array LookupEntry} (index : Array Nat) (bank : Nat → Sample)
    (ok : ∀ i,(bank i).check=true) (pass : testBank entries index bank=true) (i : Nat) :
    (entries.getD i LookupEntry.zero).Correct := by
  by_cases hi : i < entries.size
  · have member : i < (Array.range entries.size).size := by simpa using hi
    have h := (Array.all_eq_true.mp pass) i member
    apply matches_sound (bank (index.getD i 0)) (ok _)
    simpa using h
  · simpa [Array.getD,hi] using LookupEntry.zero_correct

#print axioms bank_table_correct
end ExpLookup
