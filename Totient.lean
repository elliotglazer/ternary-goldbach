module

public import Mathlib.Data.Nat.Totient
public import Mathlib.Tactic

@[expose] public section

namespace GoldbachEnergy
def timesPhi (p u v : ℕ) := if p ∣ u then p*v else (p-1)*v

theorem timesPhi_eq {p u : ℕ} (hp : p.Prime) :
    timesPhi p u u.totient = (p*u).totient := by
  by_cases hd : p ∣ u
  · simp only [timesPhi, if_pos hd, Nat.totient_mul_of_dvd hd]
  · simp only [timesPhi, if_neg hd, Nat.totient_mul_of_prime_of_not_dvd hp hd]

def ok (u v : ℕ) : Bool :=
  decide (u ≤ 2*v^2) && (List.range 257).all (fun p =>
    decide ((p=2 ∨ p%2=1) → 2331 ≤ p*u → 120*(p*u) < (timesPhi p u v)^2))

theorem small_lift {u v p : ℕ} (ho : ok u v = true) (hp : p.Prime)
    (hq : 2331 ≤ p*u) : 120*(p*u) < (timesPhi p u v)^2 := by
  simp only [ok, Bool.and_eq_true, decide_eq_true_eq] at ho
  by_cases h : p < 257
  · exact (of_decide_eq_true (List.all_eq_true.mp ho.2 p (List.mem_range.mpr h))) hp.eq_two_or_odd hq
  · have hp' : 257 ≤ p := by omega
    have h1 : (p-1)^2 > 240*p := by
      have hh : p = (p-1)+1 := by omega
      nlinarith [Nat.mul_le_mul (show 256 ≤ p-1 by omega) (show 1 ≤ p-1 by omega),
        Nat.mul_le_mul_right (p-1) (show 256 ≤ p-1 by omega)]
    have hv : 0 < v^2 := by
      by_contra! hz
      have := ho.1
      have hu : u = 0 := by omega
      simp [hu] at hq
    have h2 := Nat.mul_lt_mul_of_pos_right h1 hv
    have h3 := Nat.mul_le_mul_left (120*p) ho.1
    have ha : (p-1)*v ≤ timesPhi p u v := by
      unfold timesPhi; split
      · exact Nat.mul_le_mul_right _ (Nat.sub_le ..)
      · rfl
    have hb := Nat.pow_le_pow_left ha 2
    nlinarith only [h2,h3,hb]

theorem stable {u p : ℕ} (heu : 2 ∣ u) (hp : p.Prime) (h : 120*u < u.totient^2) :
    120*(p*u) < (timesPhi p u u.totient)^2 := by
  have h1 := Nat.mul_lt_mul_of_pos_left h hp.pos
  by_cases hd : p ∣ u
  · rw [timesPhi, if_pos hd, mul_pow]
    have h2 := Nat.mul_le_mul_right (u.totient^2) (show p ≤ p^2 by nlinarith [hp.two_le])
    nlinarith only [h1,h2]
  · rw [timesPhi, if_neg hd, mul_pow]
    have hge : 3 ≤ p := by
      by_contra! hh
      have he : p=2 := by have := hp.two_le; omega
      exact hd (he.symm ▸ heu)
    have h2 := Nat.mul_le_mul_right (u.totient^2) (show p ≤ (p-1)^2 by
      have : p = p-1+1 := by omega
      nlinarith [Nat.mul_le_mul_right (p-1) (show 2 ≤ p-1 by omega)])
    nlinarith only [h1,h2]

theorem all_totient (table : ∀ m, 1 ≤ m → m ≤ 1165 → ok (2*m) (2*m).totient = true) :
    ∀ n, 2331 ≤ n → 120*n < n.totient^2 := by
  have evenCase (m : ℕ) : 2331 ≤ 2*m → 120*(2*m) < (2*m).totient^2 := by
    induction m using Nat.strong_induction_on with
    | ind m ih =>
      intro hhigh
      let p := m.minFac
      have hp : p.Prime := Nat.minFac_prime (by omega)
      obtain ⟨b,hb⟩ := Nat.minFac_dvd m
      change m = p*b at hb
      have hb0 : 0 < b := by
        by_contra! hz
        have hbz : b=0 := by omega
        rw [hbz, mul_zero] at hb
        omega
      have hb' : b < m := by nlinarith [Nat.mul_le_mul_right b hp.two_le]
      have he : 2*m = p*(2*b) := by rw [hb]; ring
      rw [he, ← timesPhi_eq hp]
      by_cases hbig : 2331 ≤ 2*b
      · exact stable (dvd_mul_right ..) hp (ih b hb' hbig)
      · exact small_lift (table b hb0 (by omega)) hp (he ▸ hhigh)
  intro n hn
  by_cases h : 2 ∣ n
  · obtain ⟨m,rfl⟩ := h
    exact evenCase m hn
  · have hh := evenCase n (by omega)
    rw [Nat.totient_mul_of_prime_of_not_dvd Nat.prime_two h] at hh
    simp only [Nat.reduceSub, one_mul] at hh
    omega
end GoldbachEnergy
