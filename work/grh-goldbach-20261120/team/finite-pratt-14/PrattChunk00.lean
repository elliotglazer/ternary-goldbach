import PrimeSupport
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p2 : Nat.Prime 2 := Nat.prime_two
theorem p3 : Nat.Prime 3 := by
  apply lucasNat 3 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3-1 = 2 by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2] at hd
  subst q
  decide +kernel
theorem p5 : Nat.Prime 5 := by
  apply lucasNat 5 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5-1 = 2 * (2) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p7 : Nat.Prime 7 := by
  apply lucasNat 7 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7-1 = 2 * (3) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p11 : Nat.Prime 11 := by
  apply lucasNat 11 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11-1 = 2 * (5) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p13 : Nat.Prime 13 := by
  apply lucasNat 13 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13-1 = 2 * (2 * (3)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p17 : Nat.Prime 17 := by
  apply lucasNat 17 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17-1 = 2 * (2 * (2 * (2))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p19 : Nat.Prime 19 := by
  apply lucasNat 19 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19-1 = 2 * (3 * (3)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p23 : Nat.Prime 23 := by
  apply lucasNat 23 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23-1 = 2 * (11) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p29 : Nat.Prime 29 := by
  apply lucasNat 29 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29-1 = 2 * (2 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p31 : Nat.Prime 31 := by
  apply lucasNat 31 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31-1 = 2 * (3 * (5)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p37 : Nat.Prime 37 := by
  apply lucasNat 37 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37-1 = 2 * (2 * (3 * (3))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p41 : Nat.Prime 41 := by
  apply lucasNat 41 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41-1 = 2 * (2 * (2 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p43 : Nat.Prime 43 := by
  apply lucasNat 43 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43-1 = 2 * (3 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p47 : Nat.Prime 47 := by
  apply lucasNat 47 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 47-1 = 2 * (23) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p53 : Nat.Prime 53 := by
  apply lucasNat 53 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53-1 = 2 * (2 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p59 : Nat.Prime 59 := by
  apply lucasNat 59 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59-1 = 2 * (29) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p61 : Nat.Prime 61 := by
  apply lucasNat 61 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 61-1 = 2 * (2 * (3 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p67 : Nat.Prime 67 := by
  apply lucasNat 67 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 67-1 = 2 * (3 * (11)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p71 : Nat.Prime 71 := by
  apply lucasNat 71 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 71-1 = 2 * (5 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p73 : Nat.Prime 73 := by
  apply lucasNat 73 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73-1 = 2 * (2 * (2 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p79 : Nat.Prime 79 := by
  apply lucasNat 79 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 79-1 = 2 * (3 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p83 : Nat.Prime 83 := by
  apply lucasNat 83 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 83-1 = 2 * (41) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p41] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p89 : Nat.Prime 89 := by
  apply lucasNat 89 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 89-1 = 2 * (2 * (2 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p97 : Nat.Prime 97 := by
  apply lucasNat 97 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 97-1 = 2 * (2 * (2 * (2 * (2 * (3))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p101 : Nat.Prime 101 := by
  apply lucasNat 101 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 101-1 = 2 * (2 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p103 : Nat.Prime 103 := by
  apply lucasNat 103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 103-1 = 2 * (3 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p107 : Nat.Prime 107 := by
  apply lucasNat 107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 107-1 = 2 * (53) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p53] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p109 : Nat.Prime 109 := by
  apply lucasNat 109 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 109-1 = 2 * (2 * (3 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p113 : Nat.Prime 113 := by
  apply lucasNat 113 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 113-1 = 2 * (2 * (2 * (2 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p127 : Nat.Prime 127 := by
  apply lucasNat 127 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 127-1 = 2 * (3 * (3 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p131 : Nat.Prime 131 := by
  apply lucasNat 131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 131-1 = 2 * (5 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p137 : Nat.Prime 137 := by
  apply lucasNat 137 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 137-1 = 2 * (2 * (2 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p139 : Nat.Prime 139 := by
  apply lucasNat 139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 139-1 = 2 * (3 * (23)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
end Pratt14
