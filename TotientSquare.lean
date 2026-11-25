module

public import Totient
public import Mathlib.Data.Nat.Factorization.Induction

@[expose] public section


namespace GoldbachEnergy

private theorem totient_square_aux (n : ℕ) : n ≤ 2*n.totient^2 ∧ (¬2∣n → n ≤ n.totient^2) := by
  induction n using induction_on_primes with
  | zero => simp
  | one => norm_num
  | prime_mul p n hp ih =>
    by_cases h : p=2
    · subst p
      constructor
      · rw [← timesPhi_eq Nat.prime_two,timesPhi]
        split
        · nlinarith only [ih.1,Nat.zero_le (n.totient^2)]
        · rename_i hd; simp only [Nat.reduceSub,one_mul]; omega
      · exact fun h => False.elim (h (dvd_mul_right _ _))
    · have hp3 : 3 ≤ p := by have := hp.two_le; omega
      have hpm : p ≤ (p-1)^2 := by
        have he : p=p-1+1 := by omega
        nlinarith only [he,Nat.mul_le_mul_right (p-1) (show 2≤p-1 by omega),hp3]
      have hT : (p-1)*n.totient ≤ (p*n).totient := by
        rw [← timesPhi_eq hp,timesPhi]; split
        · exact Nat.mul_le_mul_right _ (Nat.sub_le ..)
        · rfl
      have h₁ := Nat.mul_le_mul_right (n.totient^2) hpm
      have h₂ := Nat.pow_le_pow_left hT 2
      constructor
      · nlinarith only [Nat.mul_le_mul_left p ih.1,h₁,h₂]
      · intro hd
        have h' := ih.2 (fun hh => hd (dvd_mul_of_dvd_right hh _))
        nlinarith only [Nat.mul_le_mul_left p h',h₁,h₂]

theorem totient_square_bound (n : ℕ) : n ≤ 2*n.totient^2 := (totient_square_aux n).1
#print axioms totient_square_bound
end GoldbachEnergy
