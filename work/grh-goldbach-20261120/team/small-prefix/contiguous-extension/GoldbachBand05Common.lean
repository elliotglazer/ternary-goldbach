import GoldbachBand05FactorLeaves
namespace SmallGoldbach.GoldbachBand05
set_option maxHeartbeats 0
private theorem joinProduct (d a n : Nat) {u v : Nat}
    (hu : u = SmallGoldbach.rangeProduct d a (n/2))
    (hv : v = SmallGoldbach.rangeProduct d (a+n/2) (n-n/2)) :
    u*v = SmallGoldbach.rangeProduct (d+1) a n := congrArg₂ Nat.mul hu hv
def v4 : Nat := v8 * v9
theorem eq4 : v4 = SmallGoldbach.rangeProduct 11 1 64990 := by
  exact joinProduct 10 1 64990 eq8 eq9
def v5 : Nat := v10 * v11
theorem eq5 : v5 = SmallGoldbach.rangeProduct 11 64991 64990 := by
  exact joinProduct 10 64991 64990 eq10 eq11
def v2 : Nat := v4 * v5
theorem eq2 : v2 = SmallGoldbach.rangeProduct 12 1 129980 := by
  exact joinProduct 11 1 129980 eq4 eq5
def v6 : Nat := v12 * v13
theorem eq6 : v6 = SmallGoldbach.rangeProduct 11 129981 64990 := by
  exact joinProduct 10 129981 64990 eq12 eq13
def v7 : Nat := v14 * v15
theorem eq7 : v7 = SmallGoldbach.rangeProduct 11 194971 64990 := by
  exact joinProduct 10 194971 64990 eq14 eq15
def v3 : Nat := v6 * v7
theorem eq3 : v3 = SmallGoldbach.rangeProduct 12 129981 129980 := by
  exact joinProduct 11 129981 129980 eq6 eq7
def fac : Nat := v2 * v3
theorem eq1 : fac = SmallGoldbach.rangeProduct 13 1 259960 := by
  exact joinProduct 12 1 259960 eq2 eq3
theorem fac_eq : fac = Nat.factorial 259960 := SmallGoldbach.factorial_of_product 13 eq1
end SmallGoldbach.GoldbachBand05
