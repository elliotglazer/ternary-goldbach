/- These Lean 4.35 names were introduced after 4.33.1. The older theorems
have identical argument types, binder order and conclusions. -/
universe u

theorem ite_eq_left {c : Prop} {h : Decidable c} (hc : c) {α : Sort u} {t e : α} :
    (ite c t e) = t := if_pos hc

theorem ite_eq_right {c : Prop} {h : Decidable c} (hnc : ¬c) {α : Sort u} {t e : α} :
    (ite c t e) = e := if_neg hnc
