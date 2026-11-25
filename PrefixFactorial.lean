module

public import PrefixJoin

@[expose] public section

namespace SmallGoldbach

/-- Split a consecutive product a bounded number of times before reducing its short leaves. -/
def rangeProduct : Nat → Nat → Nat → Nat
  | 0, a, n => a.ascFactorial n
  | k+1, a, n =>
    let m := n/2
    rangeProduct k a m * rangeProduct k (a+m) (n-m)

theorem rangeProduct_eq (depth a n : Nat) : rangeProduct depth a n = a.ascFactorial n := by
  induction depth generalizing a n with
  | zero => rfl
  | succ k ih =>
    simp only [rangeProduct, ih, Nat.ascFactorial_mul_ascFactorial]
    congr 1
    omega

theorem factorial_of_product {n fac : Nat} (depth : Nat) (h : fac = rangeProduct depth 1 n) :
    fac = n.factorial := h.trans ((rangeProduct_eq _ _ _).trans (Nat.one_ascFactorial _))

end SmallGoldbach
