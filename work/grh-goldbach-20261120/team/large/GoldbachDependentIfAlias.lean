/- Lean 4.35 renamed `dif_pos`. The dependent-if binder types and result
are the same in Lean 4.33.1. The Goldbach trigonometric-sum proof uses this name. -/
universe u

theorem dite_eq_left {c : Prop} {h : Decidable c} (hc : c) {α : Sort u} {t : c → α} {e : ¬c → α} :
    dite c t e = t hc := dif_pos hc
