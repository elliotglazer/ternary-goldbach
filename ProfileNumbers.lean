module

public import ProfilePieces
public import ProfileFormula

@[expose] public section


namespace GoldbachEnergy.Profile

def Piece.Price (a b c q₀ : ℝ) (Q : ℕ) (p : Piece) :=
  profilePrice a b c q₀ Q p.cells ((p.radius:ℝ)/p.cells) p.width (point p.low) (point p.high) ≤ 0.315

def PriceRows (a b c q₀ : ℝ) (Q : ℕ) (ps : List Piece) :=
  ∀ p ∈ ps, p.Price a b c q₀ Q

def Between (P : Piece → Prop) (ps : List Piece) (lo hi : Nat) : Prop :=
  ∀ i : Nat, lo ≤ i → i < hi → P ps[i]!

theorem Between.one {P : Piece → Prop} {ps : List Piece} {i : Nat} (h : P ps[i]!) :
    Between P ps i (i+1) := by
  intro j l u; have e : j=i := by omega
  subst j; exact h

theorem Between.join {P : Piece → Prop} {ps : List Piece} {a b c : Nat}
    (l : Between P ps a b) (r : Between P ps b c) : Between P ps a c := by
  intro i lo hi
  by_cases h : i < b
  · exact l i lo h
  · exact r i (Nat.le_of_not_lt h) hi

theorem Between.all {a b c q₀ : ℝ} {Q : Nat} {ps : List Piece} {n : Nat}
    (size : ps.length=n) (h : Between (Piece.Price a b c q₀ Q) ps 0 n) : PriceRows a b c q₀ Q ps := by
  intro p hp
  obtain ⟨i,hi,eq⟩ := List.getElem_of_mem hp
  have v := h i (Nat.zero_le _) (by omega)
  rwa [getElem!_pos ps i hi,eq] at v
#print axioms Between.all
end GoldbachEnergy.Profile
