module

public import ProfileLargeTwist
public import ProfileNumbers
public import BoundedBands

@[expose] public section


open Real
noncomputable section
namespace GoldbachEnergy.Profile

private theorem minor_in_band {N δ a b c q₀ : ℝ} {Q q : ℕ} {ps : List Piece}
    (hn : 2*10^19 ≤ N) (hl : 44 ≤ Real.log N) (hu : Real.log N ≤ 56)
    (ha : 6 ≤ a) (haL : a ≤ Real.log N) (hb : Real.log N ≤ b)
    (hc : 30 ≤ c) (hc' : c ≤ 70) (order : minorOrder N=c^2*(Real.log N)^4)
    (hq : 0 < q) (ho : (q:ℝ) ≤ minorOrder N) (hd : |δ| ≤ N/(minorOrder N*q))
    (hq₀ : 0 < q₀ ∧ q₀ ≤ q) (hQ : q ≤ Q) (ok : chain 1125899906842624 0 ps=true)
    (rows : PriceRows a b c q₀ Q ps) :
    ∃ g u : ZeroTiling, twistedBudget N q δ g u+minorPrincipalBudget N q δ ≤ 0.315*N/Real.log N := by
  by_cases outside : 262144 ≤ |δ|
  · exact beyond_intervals hn hl hu hc hc' order hq ho hd outside
  obtain ⟨p,hp,pl,pr,rad,rad9,w,w18,m⟩ := covered ok (by decide)
    (show point 0 ≤ |δ| by simpa [point] using abs_nonneg δ)
    (show |δ| ≤ point 1125899906842624 by norm_num [point]; exact le_of_not_ge outside)
  have hm : 0 < (p.cells:ℝ) := by exact_mod_cast m
  have hh : 0 < (p.radius:ℝ)/p.cells := div_pos (by exact_mod_cast rad) hm
  have h9 : (p.cells:ℝ)*((p.radius:ℝ)/p.cells) ≤ 9 := by
    rw [show (p.cells:ℝ)*((p.radius:ℝ)/p.cells)=(p.radius:ℝ) by field_simp]; exact_mod_cast rad9
  exact on_interval hn hl hu ha haL hb hc hc' order hq ho hd hq₀ hQ ⟨pl,pr⟩
    (by unfold point; positivity) m hh h9 ⟨by exact_mod_cast w,by exact_mod_cast w18⟩ (rows p hp)

theorem bounded_minor
    (v0 : PriceRows 44.44 46.052 30 1 100000000 pieces0)
    (v1 : PriceRows 44.44 46.052 30 100000000 4047962620 pieces1)
    (v2 : PriceRows 46.05 56 70 1 100000000 pieces2)
    (v3 : PriceRows 46.05 56 70 100000000 48189030400 pieces3)
    {N : ℝ} (hn : 2*10^19 ≤ N) (hu : Real.log N ≤ 56) : MinorBudgetAt N := by
  have hN : 0 < N := by linarith
  have hl := GoldbachEnergy.log_floor_two_e19 hn
  have h44 : 44 ≤ Real.log N := by linarith
  intro q hq ho δ hd
  have h1 : (1:ℝ) ≤ q := by exact_mod_cast hq
  by_cases h : N < 10^20
  · have o : minorOrder N=30^2*(Real.log N)^4 := by
      rw [minorOrder, if_pos h] <;> norm_num
    have low : 44.44 ≤ Real.log N := by linarith
    have high := (Real.log_le_log hN h.le).trans GoldbachEnergy.split_log_bounds.2
    by_cases hq' : q ≤ 100000000
    · exact minor_in_band hn h44 hu (by norm_num) low high (by norm_num) (by norm_num) o hq ho hd
        ⟨by norm_num,h1⟩ hq' chained0 v0
    · have upper : q ≤ 4047962620 := by
        rw [o] at ho
        have h' := pow_le_pow_left₀ (show 0 ≤ Real.log N by linarith) high 4
        exact_mod_cast (show (q:ℝ) ≤ 4047962620 by linarith only [ho,h'])
      exact minor_in_band hn h44 hu (by norm_num) low high (by norm_num) (by norm_num) o hq ho hd
        ⟨by norm_num,by exact_mod_cast (Nat.le_of_not_ge hq')⟩ upper chained1 v1
  · have o : minorOrder N=70^2*(Real.log N)^4 := by
      rw [minorOrder, if_neg h] <;> norm_num
    have low' := GoldbachEnergy.split_log_bounds.1.trans (Real.log_le_log (by norm_num) (le_of_not_gt h))
    have low : 46.05 ≤ Real.log N := by linarith
    by_cases hq' : q ≤ 100000000
    · exact minor_in_band hn h44 hu (by norm_num) low hu (by norm_num) (by norm_num) o hq ho hd
        ⟨by norm_num,h1⟩ hq' chained2 v2
    · have upper : q ≤ 48189030400 := by
        rw [o] at ho
        have h' := pow_le_pow_left₀ (show 0 ≤ Real.log N by linarith) hu 4
        exact_mod_cast (show (q:ℝ) ≤ 48189030400 by linarith only [ho,h'])
      exact minor_in_band hn h44 hu (by norm_num) low hu (by norm_num) (by norm_num) o hq ho hd
        ⟨by norm_num,by exact_mod_cast (Nat.le_of_not_ge hq')⟩ upper chained3 v3
#print axioms bounded_minor
end GoldbachEnergy.Profile
