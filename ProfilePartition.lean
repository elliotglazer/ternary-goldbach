module

public import Mathlib.Data.Real.Basic
public import Mathlib.Tactic.NormNum

@[expose] public section


namespace GoldbachEnergy.Profile
structure Piece where
  low : ℕ
  high : ℕ
  radius : ℕ
  width : ℕ
  cells : ℕ
  deriving Inhabited, DecidableEq

noncomputable def point (tick : ℕ) : ℝ := tick/4294967296

def chain (last : ℕ) (initial : ℕ) : List Piece → Bool
  | [] => decide (initial=last)
  | p::ps => decide (initial=p.low ∧ p.low<p.high ∧ 0<p.radius ∧ p.radius≤9 ∧
      0<p.width ∧ p.width≤18 ∧ 0<p.cells) && chain last p.high ps

theorem covered {ps : List Piece} {last initial : ℕ} (ok : chain last initial ps=true)
    (start : initial<last) {x : ℝ} (lo : point initial≤x) (hi : x≤point last) :
    ∃ p∈ps, point p.low≤x ∧ x≤point p.high ∧ 0<p.radius ∧ p.radius≤9 ∧
      0<p.width ∧ p.width≤18 ∧ 0<p.cells := by
  induction ps generalizing initial with
  | nil => simp [chain] at ok; exact (Nat.ne_of_lt start ok).elim
  | cons p ps ih =>
    simp only [chain,Bool.and_eq_true,decide_eq_true_eq] at ok
    obtain ⟨⟨e,_,ha,ha9,hw,hw18,hm⟩,rest⟩ := ok
    by_cases h : x≤point p.high
    · exact ⟨p,List.mem_cons_self, e ▸ lo,h,ha,ha9,hw,hw18,hm⟩
    · have h' : p.high<last := by
        apply Nat.lt_of_not_ge
        intro hv
        have ge : point last≤point p.high := div_le_div_of_nonneg_right (by exact_mod_cast hv) (by norm_num)
        exact h (hi.trans ge)
      obtain ⟨q,hq,good⟩ := ih rest h' (le_of_not_ge h)
      exact ⟨q,List.mem_cons_of_mem _ hq,good⟩
#print axioms covered
end GoldbachEnergy.Profile
