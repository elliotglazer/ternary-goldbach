import PrefixFactorial

namespace SmallGoldbach.BatchWitness
open PrimeCoverage WideGoldbach

def rowModulus (halo lo : Nat) (r : Row) : Nat :=
  (entries (baseAt halo lo) (unpack r.count r.code)).prod

def modulus (halo : Nat) : Nat → List Row → Nat
  | _, [] => 1
  | lo, r :: rs => rowModulus halo lo r * modulus halo (lo+2*r.width) rs

def withInverse (z : Nat) (r : Row) : Row := {r with inv := z}

def rowChecks (bits d halo lo : Nat) (r : Row) : Bool :=
  let a := baseAt halo lo
  let offsets := unpack r.count r.code
  (decide (a ≠ 3) && (entries a offsets).all (fun p => decide (1 < p ∧ p < (d+1)^2))) &&
    decide (((translates bits offsets >>> skipAt halo lo) &&& (2^r.width-1)) = 2^r.width-1)

def checks (bits d halo : Nat) : Nat → List Row → Bool
  | _, [] => true
  | lo, r :: rs => rowChecks bits d halo lo r && checks bits d halo (lo+2*r.width) rs

private theorem checkRow_of_witness {bits fac d halo lo z : Nat} {r : Row}
    (hc : rowChecks bits d halo lo r = true)
    (hm : Nat.ModEq (rowModulus halo lo r) (fac*z) 1) :
    checkRow bits fac d halo lo (withInverse z r) = true := by
  obtain ⟨hprime, htile⟩ := splitAnd hc
  obtain ⟨hbase, hbounds⟩ := splitAnd hprime
  have hne : baseAt halo lo ≠ 3 := of_decide_eq_true hbase
  simp only [checkRow, withInverse, ite_eq_right hne, Bool.and_eq_true]
  exact ⟨⟨hbounds, decide_eq_true hm⟩, htile⟩

private theorem checkRows_of_witness {bits fac d halo lo z : Nat} (rs : List Row)
    (hc : checks bits d halo lo rs = true) (hm : Nat.ModEq (modulus halo lo rs) (fac*z) 1) :
    checkRows bits fac d halo lo (rs.map (withInverse z)) = true := by
  induction rs generalizing lo with
  | nil => rfl
  | cons r rs ih =>
    obtain ⟨hr, ht⟩ := splitAnd hc
    have hleft : rowModulus halo lo r ∣ modulus halo lo (r :: rs) :=
      dvd_mul_right _ _
    have hright : modulus halo (lo+2*r.width) rs ∣ modulus halo lo (r :: rs) :=
      dvd_mul_left _ _
    simp only [List.map_cons, checkRows, Bool.and_eq_true]
    exact ⟨checkRow_of_witness hr (Nat.ModEq.of_dvd hleft hm), ih ht (Nat.ModEq.of_dvd hright hm)⟩

private theorem span_map (z : Nat) (rs : List Row) : span (rs.map (withInverse z)) = span rs := by
  induction rs with
  | nil => rfl
  | cons r rs ih => simp only [List.map_cons, span, withInverse, ih]

/-- One modular inverse certifies all anchor primes in a consecutive group of rows. -/
theorem interval {bits fac d halo lo hi : Nat} (hs : PrimeBitmap 3 bits) (hf : fac = d.factorial)
    (rs : List Row) (z : Nat) (hlo : 6 ≤ lo) (he : lo % 2 = 0)
    (hc : checks bits d halo lo rs = true)
    (hm : Nat.ModEq (modulus halo lo rs) (fac*z) 1) (hh : hi ≤ lo+2*span rs) :
    Covered lo hi :=
  checked_interval hs hf (rs.map (withInverse z)) hlo he
    (checkRows_of_witness rs hc hm) (by simpa only [span_map] using hh)

end SmallGoldbach.BatchWitness
