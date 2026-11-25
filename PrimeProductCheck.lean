module

public import PrefixFactorial
public import GoldbachNatPowMod
public import Mathlib.Data.ZMod.Basic

@[expose] public section

namespace SmallGoldbach
open PrimeCoverage WideGoldbach

/-- One modular powering certificate is amortized over every row that uses M. -/
theorem factorial_dvd_power {d M e : Nat} (depth : Nat)
    (h : Nat.powMod M e (rangeProduct depth 1 d) = 0) : d.factorial ∣ M^e := by
  rw [Nat.powMod_def,factorial_of_product depth (rfl : rangeProduct depth 1 d = _)] at h
  exact Nat.dvd_of_mod_eq_zero h

private theorem reencode {bits M d e halo origin : Nat} (hM : d.factorial ∣ M^e)
    (r : Row) (hc : checkRow bits M d halo origin r = true) :
    ∃ v : Nat, checkRow bits d.factorial d halo origin {r with inv := v} = true := by
  let a := baseAt halo origin
  let ss := unpack r.count r.code
  let n := (entries a ss).prod
  obtain ⟨hprime,hcover⟩ := splitAnd hc
  by_cases ha : a=3
  · exact ⟨r.inv,by simpa only [checkRow,show baseAt halo origin=3 from ha,if_true] using hc⟩
  · change (if a=3 then _ else _ && decide (M*r.inv % n=1%n)) = true at hprime
    rw [if_neg ha] at hprime
    obtain ⟨hbound,hres⟩ := splitAnd hprime
    have hg := Nat.coprime_of_mul_modEq_one r.inv (a:=M) (n:=n) (of_decide_eq_true hres)
    have hf := Nat.Coprime.coprime_dvd_left hM (hg.pow_left e)
    let v := ((d.factorial : ZMod n)⁻¹).val
    have hv : d.factorial*v % n=1%n := (ZMod.natCast_eq_natCast_iff' _ _ _).mp
      (by simpa only [Nat.cast_mul,Nat.cast_one] using ZMod.mul_val_inv hf)
    refine ⟨v,Bool.and_eq_true_iff.mpr ⟨?_,hcover⟩⟩
    change (if a=3 then _ else _ && decide (d.factorial*v % n=1%n)) = true
    rw [if_neg ha]
    exact Bool.and_eq_true_iff.mpr ⟨hbound,decide_eq_true hv⟩

private theorem reencode_rows {bits M d e halo : Nat} (hM : d.factorial ∣ M^e)
    (rs : List Row) (lo : Nat) (hc : checkRows bits M d halo lo rs = true) :
    ∃ ws, span ws = span rs ∧ checkRows bits d.factorial d halo lo ws = true := by
  induction rs generalizing lo with
  | nil => exact ⟨[],rfl,rfl⟩
  | cons r rs ih =>
    obtain ⟨hr,hrest⟩ := splitAnd hc
    obtain ⟨v,hv⟩ := reencode hM r hr
    obtain ⟨ws,hw,hh⟩ := ih _ hrest
    exact ⟨{r with inv := v}::ws,by simpa only [span,hw],Bool.and_eq_true_iff.mpr ⟨hv,hh⟩⟩

theorem checked_prime_product_interval {bits M d e halo lo hi : Nat} (hs : PrimeBitmap 3 bits)
    (hM : d.factorial ∣ M^e) (rs : List Row) (ho : 6≤lo) (he : lo%2=0)
    (hc : checkRows bits M d halo lo rs=true) (hl : hi≤lo+2*span rs) : Covered lo hi := by
  obtain ⟨ws,hw,hh⟩ := reencode_rows hM rs lo hc
  exact checked_interval hs rfl ws ho he hh (hw ▸ hl)

#print axioms checked_prime_product_interval
end SmallGoldbach
