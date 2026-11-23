import BatchPrime
import Table

namespace WideGoldbach
open PrimeCoverage BatchPrime

def goodShifts (tree : BatchPrime.Tree) (first origin : Nat) (ss : List Nat) : Bool :=
  ss.all fun s => decide (first + 2*s ≤ origin) && contains (origin - (first + 2*s)) tree

theorem block {tree : BatchPrime.Tree} {first bits origin width : Nat} {ss : List Nat}
    (ht : treeValid tree tree = true) (hs : PrimeBitmap first bits)
    (ha : goodShifts tree first origin ss = true)
    (hc : (shiftedUnion bits ss &&& (2^width-1)) = 2^width-1)
    (he : origin % 2 = 0) :
    ∀ n, origin ≤ n → n < origin + 2*width → n % 2 = 0 → BinaryGoldbach n := by
  apply binaryGoldbach_interval origin width he
  apply binaryGoldbach_of_bitmap first bits origin width ss hs _ hc
  intro s hmem
  simp only [goodShifts, List.all_eq_true, Bool.and_eq_true, decide_eq_true_eq] at ha
  have h := ha s hmem
  exact ⟨contains_prime ht h.2, h.1⟩

end WideGoldbach
