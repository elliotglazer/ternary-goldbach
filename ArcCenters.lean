module

public import ArcSeparation

@[expose] public section


open Real Set Finset
noncomputable section
namespace GoldbachEnergy

def window (N : ℝ) (r : ℚ) : Set ℝ :=
  Icc ((r:ℝ)-radius N r.den) ((r:ℝ)+radius N r.den)

theorem radius_nonneg {N : ℝ} (hn : 1 ≤ N) (q : ℕ) : 0 ≤ radius N q :=
  div_nonneg (mul_nonneg (by norm_num) (Real.log_nonneg hn))
    (mul_nonneg (Nat.cast_nonneg _) (by linarith))

private theorem one_below_cutoff {N : ℝ} (hn : (2*10^19) ≤ N) : 1 ≤ modulusCutoff N := by
  have h := log_two_e19 hn
  unfold modulusCutoff; nlinarith [sq_nonneg (Real.log N-44)]

theorem centre_in_unit {N α : ℝ} (hn : (2*10^19) ≤ N) {r : ℚ}
    (hr : (r.den:ℝ) ≤ modulusCutoff N) (hx : α ∈ Set.Icc (0:ℝ) 1) (ha : α ∈ window N r) :
    0 ≤ r ∧ r ≤ 1 := by
  have hn1 : 1≤N := le_trans (by norm_num) hn
  have hR := radius_nonneg hn1 r.den
  have hR0 := radius_nonneg hn1 1
  constructor
  · by_contra! h
    have h' : (r:ℝ)<0 := by exact_mod_cast h
    exact Set.disjoint_left.mp (disjoint_central_windows_from_two_e19 hn h.ne hr (s:=0) (by simpa using one_below_cutoff hn))
      (show (0:ℝ) ∈ window N r from ⟨by linarith,le_trans hx.1 ha.2⟩) (by simpa using hR0)
  · by_contra! h
    have h' : 1<(r:ℝ) := by exact_mod_cast h
    exact Set.disjoint_left.mp (disjoint_central_windows_from_two_e19 hn h.ne' hr (s:=1) (by simpa using one_below_cutoff hn))
      (show (1:ℝ) ∈ window N r from ⟨ha.1.trans hx.2,by linarith⟩) (by simpa using hR0)

/-- A reduced fraction strictly between the endpoints has its whole window inside one period. -/
theorem interior_window {N : ℝ} (hn : (2*10^19) ≤ N) {r : ℚ}
    (hr : (r.den:ℝ) ≤ modulusCutoff N) (h0 : 0 < r) (h1 : r < 1) :
    window N r ⊆ Ioo 0 1 := by
  have hR := radius_nonneg (le_trans (by norm_num) hn : 1≤N)
  have hd0 := Set.disjoint_left.mp (disjoint_central_windows_from_two_e19 hn h0.ne' hr (s:=0) (by simpa using one_below_cutoff hn))
  have hd1 := Set.disjoint_left.mp (disjoint_central_windows_from_two_e19 hn h1.ne hr (s:=1) (by simpa using one_below_cutoff hn))
  have hr0 : 0<(r:ℝ) := by exact_mod_cast h0
  have hr1 : (r:ℝ)<1 := by exact_mod_cast h1
  intro x hx
  constructor
  · by_contra! h
    exact hd0 (show (0:ℝ) ∈ window N r from ⟨hx.1.trans h,by linarith [hR r.den]⟩)
      (by simp [radius_nonneg (le_trans (by norm_num) hn : 1≤N)])
  · by_contra! h
    exact hd1 (show (1:ℝ) ∈ window N r from ⟨by linarith [hR r.den],h.trans hx.2⟩)
      (by simp [radius_nonneg (le_trans (by norm_num) hn : 1≤N)])

#print axioms centre_in_unit
#print axioms interior_window
end GoldbachEnergy
