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
theorem p149 : Nat.Prime 149 := by
  apply lucasNat 149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 149-1 = 2 * (2 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p151 : Nat.Prime 151 := by
  apply lucasNat 151 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151-1 = 2 * (3 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p157 : Nat.Prime 157 := by
  apply lucasNat 157 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 157-1 = 2 * (2 * (3 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p163 : Nat.Prime 163 := by
  apply lucasNat 163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 163-1 = 2 * (3 * (3 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p167 : Nat.Prime 167 := by
  apply lucasNat 167 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 167-1 = 2 * (83) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p83] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p173 : Nat.Prime 173 := by
  apply lucasNat 173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 173-1 = 2 * (2 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p179 : Nat.Prime 179 := by
  apply lucasNat 179 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 179-1 = 2 * (89) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p89] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p181 : Nat.Prime 181 := by
  apply lucasNat 181 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 181-1 = 2 * (2 * (3 * (3 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p191 : Nat.Prime 191 := by
  apply lucasNat 191 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191-1 = 2 * (5 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p193 : Nat.Prime 193 := by
  apply lucasNat 193 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 193-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p197 : Nat.Prime 197 := by
  apply lucasNat 197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 197-1 = 2 * (2 * (7 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p199 : Nat.Prime 199 := by
  apply lucasNat 199 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199-1 = 2 * (3 * (3 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p211 : Nat.Prime 211 := by
  apply lucasNat 211 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 211-1 = 2 * (3 * (5 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p223 : Nat.Prime 223 := by
  apply lucasNat 223 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 223-1 = 2 * (3 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p227 : Nat.Prime 227 := by
  apply lucasNat 227 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 227-1 = 2 * (113) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p113] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p233 : Nat.Prime 233 := by
  apply lucasNat 233 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 233-1 = 2 * (2 * (2 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p241 : Nat.Prime 241 := by
  apply lucasNat 241 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 241-1 = 2 * (2 * (2 * (2 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p251 : Nat.Prime 251 := by
  apply lucasNat 251 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 251-1 = 2 * (5 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p257 : Nat.Prime 257 := by
  apply lucasNat 257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 257-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p263 : Nat.Prime 263 := by
  apply lucasNat 263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 263-1 = 2 * (131) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p131] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p269 : Nat.Prime 269 := by
  apply lucasNat 269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 269-1 = 2 * (2 * (67)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p67] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p277 : Nat.Prime 277 := by
  apply lucasNat 277 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 277-1 = 2 * (2 * (3 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p283 : Nat.Prime 283 := by
  apply lucasNat 283 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 283-1 = 2 * (3 * (47)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p47] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p293 : Nat.Prime 293 := by
  apply lucasNat 293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 293-1 = 2 * (2 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p307 : Nat.Prime 307 := by
  apply lucasNat 307 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 307-1 = 2 * (3 * (3 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p311 : Nat.Prime 311 := by
  apply lucasNat 311 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 311-1 = 2 * (5 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p313 : Nat.Prime 313 := by
  apply lucasNat 313 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 313-1 = 2 * (2 * (2 * (3 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p317 : Nat.Prime 317 := by
  apply lucasNat 317 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 317-1 = 2 * (2 * (79)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p79] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p331 : Nat.Prime 331 := by
  apply lucasNat 331 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 331-1 = 2 * (3 * (5 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p337 : Nat.Prime 337 := by
  apply lucasNat 337 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 337-1 = 2 * (2 * (2 * (2 * (3 * (7))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p367 : Nat.Prime 367 := by
  apply lucasNat 367 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 367-1 = 2 * (3 * (61)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p61] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p373 : Nat.Prime 373 := by
  apply lucasNat 373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 373-1 = 2 * (2 * (3 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p389 : Nat.Prime 389 := by
  apply lucasNat 389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389-1 = 2 * (2 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p397 : Nat.Prime 397 := by
  apply lucasNat 397 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 397-1 = 2 * (2 * (3 * (3 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p419 : Nat.Prime 419 := by
  apply lucasNat 419 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 419-1 = 2 * (11 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p421 : Nat.Prime 421 := by
  apply lucasNat 421 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 421-1 = 2 * (2 * (3 * (5 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p431 : Nat.Prime 431 := by
  apply lucasNat 431 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 431-1 = 2 * (5 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p439 : Nat.Prime 439 := by
  apply lucasNat 439 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 439-1 = 2 * (3 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p443 : Nat.Prime 443 := by
  apply lucasNat 443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 443-1 = 2 * (13 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p449 : Nat.Prime 449 := by
  apply lucasNat 449 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 449-1 = 2 * (2 * (2 * (2 * (2 * (2 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p461 : Nat.Prime 461 := by
  apply lucasNat 461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 461-1 = 2 * (2 * (5 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p463 : Nat.Prime 463 := by
  apply lucasNat 463 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 463-1 = 2 * (3 * (7 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p491 : Nat.Prime 491 := by
  apply lucasNat 491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 491-1 = 2 * (5 * (7 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p503 : Nat.Prime 503 := by
  apply lucasNat 503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 503-1 = 2 * (251) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p251] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p509 : Nat.Prime 509 := by
  apply lucasNat 509 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 509-1 = 2 * (2 * (127)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p127] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p521 : Nat.Prime 521 := by
  apply lucasNat 521 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 521-1 = 2 * (2 * (2 * (5 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p523 : Nat.Prime 523 := by
  apply lucasNat 523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 523-1 = 2 * (3 * (3 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p541 : Nat.Prime 541 := by
  apply lucasNat 541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 541-1 = 2 * (2 * (3 * (3 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p557 : Nat.Prime 557 := by
  apply lucasNat 557 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 557-1 = 2 * (2 * (139)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p139] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p569 : Nat.Prime 569 := by
  apply lucasNat 569 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 569-1 = 2 * (2 * (2 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p571 : Nat.Prime 571 := by
  apply lucasNat 571 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 571-1 = 2 * (3 * (5 * (19))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p593 : Nat.Prime 593 := by
  apply lucasNat 593 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 593-1 = 2 * (2 * (2 * (2 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p613 : Nat.Prime 613 := by
  apply lucasNat 613 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 613-1 = 2 * (2 * (3 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p643 : Nat.Prime 643 := by
  apply lucasNat 643 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 643-1 = 2 * (3 * (107)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p659 : Nat.Prime 659 := by
  apply lucasNat 659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 659-1 = 2 * (7 * (47)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p47] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p661 : Nat.Prime 661 := by
  apply lucasNat 661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 661-1 = 2 * (2 * (3 * (5 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p677 : Nat.Prime 677 := by
  apply lucasNat 677 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 677-1 = 2 * (2 * (13 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p683 : Nat.Prime 683 := by
  apply lucasNat 683 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 683-1 = 2 * (11 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p691 : Nat.Prime 691 := by
  apply lucasNat 691 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 691-1 = 2 * (3 * (5 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p733 : Nat.Prime 733 := by
  apply lucasNat 733 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 733-1 = 2 * (2 * (3 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p743 : Nat.Prime 743 := by
  apply lucasNat 743 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 743-1 = 2 * (7 * (53)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p53] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p751 : Nat.Prime 751 := by
  apply lucasNat 751 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 751-1 = 2 * (3 * (5 * (5 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p787 : Nat.Prime 787 := by
  apply lucasNat 787 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 787-1 = 2 * (3 * (131)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p131] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p811 : Nat.Prime 811 := by
  apply lucasNat 811 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 811-1 = 2 * (3 * (3 * (3 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p829 : Nat.Prime 829 := by
  apply lucasNat 829 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 829-1 = 2 * (2 * (3 * (3 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p881 : Nat.Prime 881 := by
  apply lucasNat 881 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 881-1 = 2 * (2 * (2 * (2 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p919 : Nat.Prime 919 := by
  apply lucasNat 919 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 919-1 = 2 * (3 * (3 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p941 : Nat.Prime 941 := by
  apply lucasNat 941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 941-1 = 2 * (2 * (5 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p953 : Nat.Prime 953 := by
  apply lucasNat 953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 953-1 = 2 * (2 * (2 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p977 : Nat.Prime 977 := by
  apply lucasNat 977 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 977-1 = 2 * (2 * (2 * (2 * (61)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p983 : Nat.Prime 983 := by
  apply lucasNat 983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 983-1 = 2 * (491) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p491] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1019 : Nat.Prime 1019 := by
  apply lucasNat 1019 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1019-1 = 2 * (509) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p509] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1033 : Nat.Prime 1033 := by
  apply lucasNat 1033 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1033-1 = 2 * (2 * (2 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1049 : Nat.Prime 1049 := by
  apply lucasNat 1049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1049-1 = 2 * (2 * (2 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1061 : Nat.Prime 1061 := by
  apply lucasNat 1061 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1061-1 = 2 * (2 * (5 * (53))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p53] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1093 : Nat.Prime 1093 := by
  apply lucasNat 1093 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1093-1 = 2 * (2 * (3 * (7 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1103 : Nat.Prime 1103 := by
  apply lucasNat 1103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1103-1 = 2 * (19 * (29)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1109 : Nat.Prime 1109 := by
  apply lucasNat 1109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1109-1 = 2 * (2 * (277)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p277] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1117 : Nat.Prime 1117 := by
  apply lucasNat 1117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1117-1 = 2 * (2 * (3 * (3 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1123 : Nat.Prime 1123 := by
  apply lucasNat 1123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1123-1 = 2 * (3 * (11 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1187 : Nat.Prime 1187 := by
  apply lucasNat 1187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1187-1 = 2 * (593) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p593] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1217 : Nat.Prime 1217 := by
  apply lucasNat 1217 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1217-1 = 2 * (2 * (2 * (2 * (2 * (2 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p1259 : Nat.Prime 1259 := by
  apply lucasNat 1259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1259-1 = 2 * (17 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1279 : Nat.Prime 1279 := by
  apply lucasNat 1279 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1279-1 = 2 * (3 * (3 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1289 : Nat.Prime 1289 := by
  apply lucasNat 1289 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1289-1 = 2 * (2 * (2 * (7 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1319 : Nat.Prime 1319 := by
  apply lucasNat 1319 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1319-1 = 2 * (659) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p659] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1321 : Nat.Prime 1321 := by
  apply lucasNat 1321 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1321-1 = 2 * (2 * (2 * (3 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1367 : Nat.Prime 1367 := by
  apply lucasNat 1367 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1367-1 = 2 * (683) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p683] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1399 : Nat.Prime 1399 := by
  apply lucasNat 1399 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1399-1 = 2 * (3 * (233)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p233] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1409 : Nat.Prime 1409 := by
  apply lucasNat 1409 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1409-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (11))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p1453 : Nat.Prime 1453 := by
  apply lucasNat 1453 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1453-1 = 2 * (2 * (3 * (11 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1487 : Nat.Prime 1487 := by
  apply lucasNat 1487 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1487-1 = 2 * (743) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p743] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1493 : Nat.Prime 1493 := by
  apply lucasNat 1493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1493-1 = 2 * (2 * (373)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p373] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1531 : Nat.Prime 1531 := by
  apply lucasNat 1531 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1531-1 = 2 * (3 * (3 * (5 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1543 : Nat.Prime 1543 := by
  apply lucasNat 1543 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1543-1 = 2 * (3 * (257)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p257] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1549 : Nat.Prime 1549 := by
  apply lucasNat 1549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1549-1 = 2 * (2 * (3 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1579 : Nat.Prime 1579 := by
  apply lucasNat 1579 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1579-1 = 2 * (3 * (263)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p263] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1907 : Nat.Prime 1907 := by
  apply lucasNat 1907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1907-1 = 2 * (953) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p953] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1987 : Nat.Prime 1987 := by
  apply lucasNat 1987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1987-1 = 2 * (3 * (331)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p331] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1999 : Nat.Prime 1999 := by
  apply lucasNat 1999 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999-1 = 2 * (3 * (3 * (3 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p2039 : Nat.Prime 2039 := by
  apply lucasNat 2039 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2039-1 = 2 * (1019) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1019] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p2131 : Nat.Prime 2131 := by
  apply lucasNat 2131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2131-1 = 2 * (3 * (5 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2141 : Nat.Prime 2141 := by
  apply lucasNat 2141 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2141-1 = 2 * (2 * (5 * (107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2347 : Nat.Prime 2347 := by
  apply lucasNat 2347 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2347-1 = 2 * (3 * (17 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2371 : Nat.Prime 2371 := by
  apply lucasNat 2371 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2371-1 = 2 * (3 * (5 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2383 : Nat.Prime 2383 := by
  apply lucasNat 2383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2383-1 = 2 * (3 * (397)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p397] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p2417 : Nat.Prime 2417 := by
  apply lucasNat 2417 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2417-1 = 2 * (2 * (2 * (2 * (151)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p2647 : Nat.Prime 2647 := by
  apply lucasNat 2647 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2647-1 = 2 * (3 * (3 * (3 * (7 * (7))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p2677 : Nat.Prime 2677 := by
  apply lucasNat 2677 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2677-1 = 2 * (2 * (3 * (223))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p223] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2741 : Nat.Prime 2741 := by
  apply lucasNat 2741 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2741-1 = 2 * (2 * (5 * (137))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p137] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p3011 : Nat.Prime 3011 := by
  apply lucasNat 3011 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3011-1 = 2 * (5 * (7 * (43))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p3083 : Nat.Prime 3083 := by
  apply lucasNat 3083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3083-1 = 2 * (23 * (67)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p67] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p3221 : Nat.Prime 3221 := by
  apply lucasNat 3221 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3221-1 = 2 * (2 * (5 * (7 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p3449 : Nat.Prime 3449 := by
  apply lucasNat 3449 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3449-1 = 2 * (2 * (2 * (431))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p431] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p3499 : Nat.Prime 3499 := by
  apply lucasNat 3499 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3499-1 = 2 * (3 * (11 * (53))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p53] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p3559 : Nat.Prime 3559 := by
  apply lucasNat 3559 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3559-1 = 2 * (3 * (593)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p593] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p3709 : Nat.Prime 3709 := by
  apply lucasNat 3709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3709-1 = 2 * (2 * (3 * (3 * (103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p3917 : Nat.Prime 3917 := by
  apply lucasNat 3917 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3917-1 = 2 * (2 * (11 * (89))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p89] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p4013 : Nat.Prime 4013 := by
  apply lucasNat 4013 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4013-1 = 2 * (2 * (17 * (59))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p59] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p4211 : Nat.Prime 4211 := by
  apply lucasNat 4211 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4211-1 = 2 * (5 * (421)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p421] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p4373 : Nat.Prime 4373 := by
  apply lucasNat 4373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4373-1 = 2 * (2 * (1093)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1093] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p4409 : Nat.Prime 4409 := by
  apply lucasNat 4409 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4409-1 = 2 * (2 * (2 * (19 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p4457 : Nat.Prime 4457 := by
  apply lucasNat 4457 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4457-1 = 2 * (2 * (2 * (557))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p557] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p4493 : Nat.Prime 4493 := by
  apply lucasNat 4493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4493-1 = 2 * (2 * (1123)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1123] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p5011 : Nat.Prime 5011 := by
  apply lucasNat 5011 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5011-1 = 2 * (3 * (5 * (167))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p167] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p5483 : Nat.Prime 5483 := by
  apply lucasNat 5483 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5483-1 = 2 * (2741) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p2741] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p5779 : Nat.Prime 5779 := by
  apply lucasNat 5779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5779-1 = 2 * (3 * (3 * (3 * (107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p6131 : Nat.Prime 6131 := by
  apply lucasNat 6131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6131-1 = 2 * (5 * (613)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p613] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6143 : Nat.Prime 6143 := by
  apply lucasNat 6143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6143-1 = 2 * (37 * (83)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p83] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6203 : Nat.Prime 6203 := by
  apply lucasNat 6203 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6203-1 = 2 * (7 * (443)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p443] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6263 : Nat.Prime 6263 := by
  apply lucasNat 6263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6263-1 = 2 * (31 * (101)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p101] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6299 : Nat.Prime 6299 := by
  apply lucasNat 6299 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6299-1 = 2 * (47 * (67)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p47, Nat.prime_dvd_prime_iff_eq hq p67] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6367 : Nat.Prime 6367 := by
  apply lucasNat 6367 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6367-1 = 2 * (3 * (1061)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1061] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6427 : Nat.Prime 6427 := by
  apply lucasNat 6427 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6427-1 = 2 * (3 * (3 * (3 * (7 * (17))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p6551 : Nat.Prime 6551 := by
  apply lucasNat 6551 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6551-1 = 2 * (5 * (5 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p7489 : Nat.Prime 7489 := by
  apply lucasNat 7489 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7489-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (13)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p7529 : Nat.Prime 7529 := by
  apply lucasNat 7529 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7529-1 = 2 * (2 * (2 * (941))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p941] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p7817 : Nat.Prime 7817 := by
  apply lucasNat 7817 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7817-1 = 2 * (2 * (2 * (977))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p977] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p8059 : Nat.Prime 8059 := by
  apply lucasNat 8059 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8059-1 = 2 * (3 * (17 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p8111 : Nat.Prime 8111 := by
  apply lucasNat 8111 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8111-1 = 2 * (5 * (811)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p811] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p8311 : Nat.Prime 8311 := by
  apply lucasNat 8311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8311-1 = 2 * (3 * (5 * (277))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p277] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p8389 : Nat.Prime 8389 := by
  apply lucasNat 8389 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8389-1 = 2 * (2 * (3 * (3 * (233)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p233] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p8423 : Nat.Prime 8423 := by
  apply lucasNat 8423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8423-1 = 2 * (4211) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p4211] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p8527 : Nat.Prime 8527 := by
  apply lucasNat 8527 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8527-1 = 2 * (3 * (7 * (7 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p8719 : Nat.Prime 8719 := by
  apply lucasNat 8719 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8719-1 = 2 * (3 * (1453)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1453] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p8893 : Nat.Prime 8893 := by
  apply lucasNat 8893 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8893-1 = 2 * (2 * (3 * (3 * (13 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p8933 : Nat.Prime 8933 := by
  apply lucasNat 8933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8933-1 = 2 * (2 * (7 * (11 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p9293 : Nat.Prime 9293 := by
  apply lucasNat 9293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9293-1 = 2 * (2 * (23 * (101))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p101] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p9497 : Nat.Prime 9497 := by
  apply lucasNat 9497 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9497-1 = 2 * (2 * (2 * (1187))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1187] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p9601 : Nat.Prime 9601 := by
  apply lucasNat 9601 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9601-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (5))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p10273 : Nat.Prime 10273 := by
  apply lucasNat 10273 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10273-1 = 2 * (2 * (2 * (2 * (2 * (3 * (107)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p10709 : Nat.Prime 10709 := by
  apply lucasNat 10709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10709-1 = 2 * (2 * (2677)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p2677] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p10957 : Nat.Prime 10957 := by
  apply lucasNat 10957 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10957-1 = 2 * (2 * (3 * (11 * (83)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p11443 : Nat.Prime 11443 := by
  apply lucasNat 11443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11443-1 = 2 * (3 * (1907)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1907] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p12073 : Nat.Prime 12073 := by
  apply lucasNat 12073 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12073-1 = 2 * (2 * (2 * (3 * (503)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p503] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p12263 : Nat.Prime 12263 := by
  apply lucasNat 12263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12263-1 = 2 * (6131) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p6131] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p12289 : Nat.Prime 12289 := by
  apply lucasNat 12289 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12289-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3)))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  all_goals subst q; decide +kernel
theorem p12791 : Nat.Prime 12791 := by
  apply lucasNat 12791 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12791-1 = 2 * (5 * (1279)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p1279] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p13103 : Nat.Prime 13103 := by
  apply lucasNat 13103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13103-1 = 2 * (6551) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p6551] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p13291 : Nat.Prime 13291 := by
  apply lucasNat 13291 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13291-1 = 2 * (3 * (5 * (443))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p443] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p14753 : Nat.Prime 14753 := by
  apply lucasNat 14753 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14753-1 = 2 * (2 * (2 * (2 * (2 * (461))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p15319 : Nat.Prime 15319 := by
  apply lucasNat 15319 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15319-1 = 2 * (3 * (3 * (23 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p16567 : Nat.Prime 16567 := by
  apply lucasNat 16567 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16567-1 = 2 * (3 * (11 * (251))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p251] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p17569 : Nat.Prime 17569 := by
  apply lucasNat 17569 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17569-1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (61))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p17627 : Nat.Prime 17627 := by
  apply lucasNat 17627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17627-1 = 2 * (7 * (1259)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p1259] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p20441 : Nat.Prime 20441 := by
  apply lucasNat 20441 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20441-1 = 2 * (2 * (2 * (5 * (7 * (73))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p73] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p20983 : Nat.Prime 20983 := by
  apply lucasNat 20983 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20983-1 = 2 * (3 * (13 * (269))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p269] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p21107 : Nat.Prime 21107 := by
  apply lucasNat 21107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21107-1 = 2 * (61 * (173)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p61, Nat.prime_dvd_prime_iff_eq hq p173] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p22709 : Nat.Prime 22709 := by
  apply lucasNat 22709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22709-1 = 2 * (2 * (7 * (811))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p811] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p25583 : Nat.Prime 25583 := by
  apply lucasNat 25583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25583-1 = 2 * (12791) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p12791] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p28181 : Nat.Prime 28181 := by
  apply lucasNat 28181 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 28181-1 = 2 * (2 * (5 * (1409))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p1409] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p28627 : Nat.Prime 28627 := by
  apply lucasNat 28627 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 28627-1 = 2 * (3 * (13 * (367))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p367] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p32117 : Nat.Prime 32117 := by
  apply lucasNat 32117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32117-1 = 2 * (2 * (7 * (31 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p32237 : Nat.Prime 32237 := by
  apply lucasNat 32237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32237-1 = 2 * (2 * (8059)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p8059] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p36997 : Nat.Prime 36997 := by
  apply lucasNat 36997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36997-1 = 2 * (2 * (3 * (3083))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p3083] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p39209 : Nat.Prime 39209 := by
  apply lucasNat 39209 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 39209-1 = 2 * (2 * (2 * (13 * (13 * (29))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p40883 : Nat.Prime 40883 := by
  apply lucasNat 40883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 40883-1 = 2 * (20441) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p20441] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p42499 : Nat.Prime 42499 := by
  apply lucasNat 42499 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 42499-1 = 2 * (3 * (3 * (3 * (787)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p787] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p43777 : Nat.Prime 43777 := by
  apply lucasNat 43777 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43777-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (19)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem p43991 : Nat.Prime 43991 := by
  apply lucasNat 43991 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43991-1 = 2 * (5 * (53 * (83))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p83] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p44501 : Nat.Prime 44501 := by
  apply lucasNat 44501 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 44501-1 = 2 * (2 * (5 * (5 * (5 * (89))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p89] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p50123 : Nat.Prime 50123 := by
  apply lucasNat 50123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 50123-1 = 2 * (19 * (1319)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p1319] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p51043 : Nat.Prime 51043 := by
  apply lucasNat 51043 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 51043-1 = 2 * (3 * (47 * (181))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p47, Nat.prime_dvd_prime_iff_eq hq p181] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p52579 : Nat.Prime 52579 := by
  apply lucasNat 52579 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 52579-1 = 2 * (3 * (3 * (23 * (127)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p56713 : Nat.Prime 56713 := by
  apply lucasNat 56713 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 56713-1 = 2 * (2 * (2 * (3 * (17 * (139))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p139] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p61651 : Nat.Prime 61651 := by
  apply lucasNat 61651 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 61651-1 = 2 * (3 * (3 * (5 * (5 * (137))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p137] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p61681 : Nat.Prime 61681 := by
  apply lucasNat 61681 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 61681-1 = 2 * (2 * (2 * (2 * (3 * (5 * (257)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p257] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p64921 : Nat.Prime 64921 := by
  apply lucasNat 64921 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 64921-1 = 2 * (2 * (2 * (3 * (5 * (541))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p541] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p65617 : Nat.Prime 65617 := by
  apply lucasNat 65617 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 65617-1 = 2 * (2 * (2 * (2 * (3 * (1367))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1367] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p80191 : Nat.Prime 80191 := by
  apply lucasNat 80191 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 80191-1 = 2 * (3 * (3 * (3 * (3 * (3 * (3 * (5 * (11)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p82469 : Nat.Prime 82469 := by
  apply lucasNat 82469 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 82469-1 = 2 * (2 * (53 * (389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p82811 : Nat.Prime 82811 := by
  apply lucasNat 82811 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 82811-1 = 2 * (5 * (7 * (7 * (13 * (13))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p84751 : Nat.Prime 84751 := by
  apply lucasNat 84751 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 84751-1 = 2 * (3 * (5 * (5 * (5 * (113))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p85091 : Nat.Prime 85091 := by
  apply lucasNat 85091 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 85091-1 = 2 * (5 * (67 * (127))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p127] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p92251 : Nat.Prime 92251 := by
  apply lucasNat 92251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 92251-1 = 2 * (3 * (3 * (5 * (5 * (5 * (41)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p106349 : Nat.Prime 106349 := by
  apply lucasNat 106349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 106349-1 = 2 * (2 * (11 * (2417))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p2417] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p108863 : Nat.Prime 108863 := by
  apply lucasNat 108863 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 108863-1 = 2 * (13 * (53 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p131797 : Nat.Prime 131797 := by
  apply lucasNat 131797 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 131797-1 = 2 * (2 * (3 * (3 * (7 * (523))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p523] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p148361 : Nat.Prime 148361 := by
  apply lucasNat 148361 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 148361-1 = 2 * (2 * (2 * (5 * (3709)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p3709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p164513 : Nat.Prime 164513 := by
  apply lucasNat 164513 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 164513-1 = 2 * (2 * (2 * (2 * (2 * (53 * (97)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p194113 : Nat.Prime 194113 := by
  apply lucasNat 194113 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 194113-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (337)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p337] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p204173 : Nat.Prime 204173 := by
  apply lucasNat 204173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 204173-1 = 2 * (2 * (51043)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p51043] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p218381 : Nat.Prime 218381 := by
  apply lucasNat 218381 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 218381-1 = 2 * (2 * (5 * (61 * (179)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p61, Nat.prime_dvd_prime_iff_eq hq p179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p219959 : Nat.Prime 219959 := by
  apply lucasNat 219959 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 219959-1 = 2 * (71 * (1549)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p1549] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p230389 : Nat.Prime 230389 := by
  apply lucasNat 230389 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 230389-1 = 2 * (2 * (3 * (73 * (263)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p73, Nat.prime_dvd_prime_iff_eq hq p263] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p282409 : Nat.Prime 282409 := by
  apply lucasNat 282409 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 282409-1 = 2 * (2 * (2 * (3 * (7 * (41 * (41)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p284521 : Nat.Prime 284521 := by
  apply lucasNat 284521 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 284521-1 = 2 * (2 * (2 * (3 * (5 * (2371))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p2371] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p338497 : Nat.Prime 338497 := by
  apply lucasNat 338497 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 338497-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (41 * (43)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p41, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p354073 : Nat.Prime 354073 := by
  apply lucasNat 354073 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 354073-1 = 2 * (2 * (2 * (3 * (14753)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p14753] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p380837 : Nat.Prime 380837 := by
  apply lucasNat 380837 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 380837-1 = 2 * (2 * (19 * (5011))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p5011] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p423019 : Nat.Prime 423019 := by
  apply lucasNat 423019 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 423019-1 = 2 * (3 * (3 * (71 * (331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p502259 : Nat.Prime 502259 := by
  apply lucasNat 502259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 502259-1 = 2 * (107 * (2347)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p2347] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p524231 : Nat.Prime 524231 := by
  apply lucasNat 524231 21 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 524231-1 = 2 * (5 * (7 * (7489))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p7489] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p534311 : Nat.Prime 534311 := by
  apply lucasNat 534311 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 534311-1 = 2 * (5 * (7 * (17 * (449)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p548927 : Nat.Prime 548927 := by
  apply lucasNat 548927 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 548927-1 = 2 * (7 * (39209)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p39209] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p602753 : Nat.Prime 602753 := by
  apply lucasNat 602753 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 602753-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (17 * (277)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p277] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p623933 : Nat.Prime 623933 := by
  apply lucasNat 623933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 623933-1 = 2 * (2 * (151 * (1033))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p151, Nat.prime_dvd_prime_iff_eq hq p1033] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p646993 : Nat.Prime 646993 := by
  apply lucasNat 646993 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 646993-1 = 2 * (2 * (2 * (2 * (3 * (3 * (4493)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p4493] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p734389 : Nat.Prime 734389 := by
  apply lucasNat 734389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 734389-1 = 2 * (2 * (3 * (19 * (3221)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p3221] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p778553 : Nat.Prime 778553 := by
  apply lucasNat 778553 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 778553-1 = 2 * (2 * (2 * (307 * (317)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p307, Nat.prime_dvd_prime_iff_eq hq p317] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p801557 : Nat.Prime 801557 := by
  apply lucasNat 801557 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 801557-1 = 2 * (2 * (7 * (28627))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p28627] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p842489 : Nat.Prime 842489 := by
  apply lucasNat 842489 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 842489-1 = 2 * (2 * (2 * (53 * (1987)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p1987] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1019129 : Nat.Prime 1019129 := by
  apply lucasNat 1019129 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1019129-1 = 2 * (2 * (2 * (11 * (37 * (313))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p313] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1152121 : Nat.Prime 1152121 := by
  apply lucasNat 1152121 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1152121-1 = 2 * (2 * (2 * (3 * (5 * (9601))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p9601] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1154567 : Nat.Prime 1154567 := by
  apply lucasNat 1154567 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1154567-1 = 2 * (7 * (82469)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p82469] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1247867 : Nat.Prime 1247867 := by
  apply lucasNat 1247867 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1247867-1 = 2 * (623933) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p623933] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1277113 : Nat.Prime 1277113 := by
  apply lucasNat 1277113 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1277113-1 = 2 * (2 * (2 * (3 * (127 * (419))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p127, Nat.prime_dvd_prime_iff_eq hq p419] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1313311 : Nat.Prime 1313311 := by
  apply lucasNat 1313311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1313311-1 = 2 * (3 * (5 * (43777))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p43777] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1435277 : Nat.Prime 1435277 := by
  apply lucasNat 1435277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1435277-1 = 2 * (2 * (17 * (21107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p21107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1444967 : Nat.Prime 1444967 := by
  apply lucasNat 1444967 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1444967-1 = 2 * (17 * (42499)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p42499] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1451767 : Nat.Prime 1451767 := by
  apply lucasNat 1451767 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1451767-1 = 2 * (3 * (17 * (43 * (331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p43, Nat.prime_dvd_prime_iff_eq hq p331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1684979 : Nat.Prime 1684979 := by
  apply lucasNat 1684979 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1684979-1 = 2 * (842489) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p842489] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1707457 : Nat.Prime 1707457 := by
  apply lucasNat 1707457 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1707457-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (8893))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p8893] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p1716271 : Nat.Prime 1716271 := by
  apply lucasNat 1716271 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1716271-1 = 2 * (3 * (5 * (19 * (3011)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p3011] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1966241 : Nat.Prime 1966241 := by
  apply lucasNat 1966241 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1966241-1 = 2 * (2 * (2 * (2 * (2 * (5 * (12289)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p12289] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p3330659 : Nat.Prime 3330659 := by
  apply lucasNat 3330659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3330659-1 = 2 * (191 * (8719)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p191, Nat.prime_dvd_prime_iff_eq hq p8719] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p3390041 : Nat.Prime 3390041 := by
  apply lucasNat 3390041 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3390041-1 = 2 * (2 * (2 * (5 * (84751)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p84751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p3483617 : Nat.Prime 3483617 := by
  apply lucasNat 3483617 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3483617-1 = 2 * (2 * (2 * (2 * (2 * (108863))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p108863] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p3795283 : Nat.Prime 3795283 := by
  apply lucasNat 3795283 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3795283-1 = 2 * (3 * (3 * (3 * (67 * (1049))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p1049] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p3932483 : Nat.Prime 3932483 := by
  apply lucasNat 3932483 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3932483-1 = 2 * (1966241) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1966241] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p5516167 : Nat.Prime 5516167 := by
  apply lucasNat 5516167 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5516167-1 = 2 * (3 * (829 * (1109))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p829, Nat.prime_dvd_prime_iff_eq hq p1109] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p6170947 : Nat.Prime 6170947 := by
  apply lucasNat 6170947 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6170947-1 = 2 * (3 * (23 * (97 * (461)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p97, Nat.prime_dvd_prime_iff_eq hq p461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p6261587 : Nat.Prime 6261587 := by
  apply lucasNat 6261587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6261587-1 = 2 * (571 * (5483)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p571, Nat.prime_dvd_prime_iff_eq hq p5483] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6591269 : Nat.Prime 6591269 := by
  apply lucasNat 6591269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6591269-1 = 2 * (2 * (463 * (3559))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p463, Nat.prime_dvd_prime_iff_eq hq p3559] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p7034851 : Nat.Prime 7034851 := by
  apply lucasNat 7034851 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7034851-1 = 2 * (3 * (3 * (3 * (3 * (3 * (3 * (5 * (5 * (193))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p193] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p7217713 : Nat.Prime 7217713 := by
  apply lucasNat 7217713 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7217713-1 = 2 * (2 * (2 * (2 * (3 * (3 * (50123)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p50123] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p8610197 : Nat.Prime 8610197 := by
  apply lucasNat 8610197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8610197-1 = 2 * (2 * (7 * (37 * (8311)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p8311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p8664433 : Nat.Prime 8664433 := by
  apply lucasNat 8664433 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8664433-1 = 2 * (2 * (2 * (2 * (3 * (7 * (107 * (241))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p8812669 : Nat.Prime 8812669 := by
  apply lucasNat 8812669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8812669-1 = 2 * (2 * (3 * (734389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p734389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p9342637 : Nat.Prime 9342637 := by
  apply lucasNat 9342637 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9342637-1 = 2 * (2 * (3 * (778553))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p778553] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p12690571 : Nat.Prime 12690571 := by
  apply lucasNat 12690571 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12690571-1 = 2 * (3 * (5 * (423019))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p423019] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p13182539 : Nat.Prime 13182539 := by
  apply lucasNat 13182539 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13182539-1 = 2 * (6591269) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p6591269] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p14466073 : Nat.Prime 14466073 := by
  apply lucasNat 14466073 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14466073-1 = 2 * (2 * (2 * (3 * (602753)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p602753] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p14904209 : Nat.Prime 14904209 := by
  apply lucasNat 14904209 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14904209-1 = 2 * (2 * (2 * (2 * (11 * (19 * (4457)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p4457] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p19575401 : Nat.Prime 19575401 := by
  apply lucasNat 19575401 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19575401-1 = 2 * (2 * (2 * (5 * (5 * (13 * (7529)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p7529] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p20074057 : Nat.Prime 20074057 := by
  apply lucasNat 20074057 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20074057-1 = 2 * (2 * (2 * (3 * (107 * (7817))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p7817] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p24721243 : Nat.Prime 24721243 := by
  apply lucasNat 24721243 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24721243-1 = 2 * (3 * (7 * (13 * (19 * (2383))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p2383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p33291541 : Nat.Prime 33291541 := by
  apply lucasNat 33291541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33291541-1 = 2 * (2 * (3 * (3 * (3 * (5 * (61651)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p61651] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p36734669 : Nat.Prime 36734669 := by
  apply lucasNat 36734669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36734669-1 = 2 * (2 * (521 * (17627))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p521, Nat.prime_dvd_prime_iff_eq hq p17627] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p39150803 : Nat.Prime 39150803 := by
  apply lucasNat 39150803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 39150803-1 = 2 * (19575401) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19575401] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p49619123 : Nat.Prime 49619123 := by
  apply lucasNat 49619123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49619123-1 = 2 * (7 * (47 * (73 * (1033)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p47, Nat.prime_dvd_prime_iff_eq hq p73, Nat.prime_dvd_prime_iff_eq hq p1033] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p51669973 : Nat.Prime 51669973 := by
  apply lucasNat 51669973 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 51669973-1 = 2 * (2 * (3 * (3 * (1435277)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1435277] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p52459291 : Nat.Prime 52459291 := by
  apply lucasNat 52459291 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 52459291-1 = 2 * (3 * (3 * (5 * (13 * (13 * (3449)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p3449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p73465129 : Nat.Prime 73465129 := by
  apply lucasNat 73465129 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73465129-1 = 2 * (2 * (2 * (3 * (3 * (11 * (23 * (37 * (109)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p73469339 : Nat.Prime 73469339 := by
  apply lucasNat 73469339 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73469339-1 = 2 * (36734669) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p36734669] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p81062633 : Nat.Prime 81062633 := by
  apply lucasNat 81062633 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 81062633-1 = 2 * (2 * (2 * (7 * (1123 * (1289))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p1123, Nat.prime_dvd_prime_iff_eq hq p1289] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p119881939 : Nat.Prime 119881939 := by
  apply lucasNat 119881939 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 119881939-1 = 2 * (3 * (11 * (71 * (25583)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p25583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p202967381 : Nat.Prime 202967381 := by
  apply lucasNat 202967381 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 202967381-1 = 2 * (2 * (5 * (7 * (11 * (131797))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p131797] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p212747849 : Nat.Prime 212747849 := by
  apply lucasNat 212747849 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 212747849-1 = 2 * (2 * (2 * (137 * (194113)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p137, Nat.prime_dvd_prime_iff_eq hq p194113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p230537981 : Nat.Prime 230537981 := by
  apply lucasNat 230537981 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 230537981-1 = 2 * (2 * (5 * (1531 * (7529)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p1531, Nat.prime_dvd_prime_iff_eq hq p7529] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p242086199 : Nat.Prime 242086199 := by
  apply lucasNat 242086199 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 242086199-1 = 2 * (97 * (1247867)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p97, Nat.prime_dvd_prime_iff_eq hq p1247867] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p243763313 : Nat.Prime 243763313 := by
  apply lucasNat 243763313 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 243763313-1 = 2 * (2 * (2 * (2 * (13 * (19 * (61681)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p61681] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p288492049 : Nat.Prime 288492049 := by
  apply lucasNat 288492049 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 288492049-1 = 2 * (2 * (2 * (2 * (3 * (3 * (13 * (19 * (8111)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p8111] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p346018363 : Nat.Prime 346018363 := by
  apply lucasNat 346018363 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 346018363-1 = 2 * (3 * (59 * (59 * (16567)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p59, Nat.prime_dvd_prime_iff_eq hq p16567] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p357914927 : Nat.Prime 357914927 := by
  apply lucasNat 357914927 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 357914927-1 = 2 * (29 * (6170947)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p6170947] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p362657843 : Nat.Prime 362657843 := by
  apply lucasNat 362657843 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 362657843-1 = 2 * (2131 * (85091)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p2131, Nat.prime_dvd_prime_iff_eq hq p85091] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p444254891 : Nat.Prime 444254891 := by
  apply lucasNat 444254891 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 444254891-1 = 2 * (5 * (23 * (67 * (127 * (227))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p127, Nat.prime_dvd_prime_iff_eq hq p227] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p484172399 : Nat.Prime 484172399 := by
  apply lucasNat 484172399 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 484172399-1 = 2 * (242086199) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p242086199] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p595429477 : Nat.Prime 595429477 := by
  apply lucasNat 595429477 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 595429477-1 = 2 * (2 * (3 * (49619123))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p49619123] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1192037179 : Nat.Prime 1192037179 := by
  apply lucasNat 1192037179 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1192037179-1 = 2 * (3 * (17 * (953 * (12263)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p953, Nat.prime_dvd_prime_iff_eq hq p12263] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1220047813 : Nat.Prime 1220047813 := by
  apply lucasNat 1220047813 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1220047813-1 = 2 * (2 * (3 * (3 * (3 * (71 * (107 * (1487))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p1487] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p1438766099 : Nat.Prime 1438766099 := by
  apply lucasNat 1438766099 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1438766099-1 = 2 * (7 * (11 * (9342637))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p9342637] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1468860149 : Nat.Prime 1468860149 := by
  apply lucasNat 1468860149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1468860149-1 = 2 * (2 * (7 * (52459291))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p52459291] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1606580537 : Nat.Prime 1606580537 := by
  apply lucasNat 1606580537 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1606580537-1 = 2 * (2 * (2 * (11 * (83 * (219959))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p83, Nat.prime_dvd_prime_iff_eq hq p219959] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1687364993 : Nat.Prime 1687364993 := by
  apply lucasNat 1687364993 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1687364993-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (13182539))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13182539] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p1954575641 : Nat.Prime 1954575641 := by
  apply lucasNat 1954575641 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1954575641-1 = 2 * (2 * (2 * (5 * (29 * (1684979))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p1684979] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p2617663969 : Nat.Prime 2617663969 := by
  apply lucasNat 2617663969 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2617663969-1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (283 * (32117)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p283, Nat.prime_dvd_prime_iff_eq hq p32117] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p2924318603 : Nat.Prime 2924318603 := by
  apply lucasNat 2924318603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2924318603-1 = 2 * (439 * (3330659)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p439, Nat.prime_dvd_prime_iff_eq hq p3330659] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p3963849649 : Nat.Prime 3963849649 := by
  apply lucasNat 3963849649 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3963849649-1 = 2 * (2 * (2 * (2 * (3 * (11 * (11 * (53 * (79 * (163))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p79, Nat.prime_dvd_prime_iff_eq hq p163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p4051207217 : Nat.Prime 4051207217 := by
  apply lucasNat 4051207217 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4051207217-1 = 2 * (2 * (2 * (2 * (7 * (53 * (53 * (79 * (163)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p79, Nat.prime_dvd_prime_iff_eq hq p163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p4743832967 : Nat.Prime 4743832967 := by
  apply lucasNat 4743832967 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4743832967-1 = 2 * (17 * (89 * (137 * (11443)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p89, Nat.prime_dvd_prime_iff_eq hq p137, Nat.prime_dvd_prime_iff_eq hq p11443] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p7447125331 : Nat.Prime 7447125331 := by
  apply lucasNat 7447125331 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7447125331-1 = 2 * (3 * (3 * (5 * (293 * (282409))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p293, Nat.prime_dvd_prime_iff_eq hq p282409] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p8039877709 : Nat.Prime 8039877709 := by
  apply lucasNat 8039877709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8039877709-1 = 2 * (2 * (3 * (107 * (6261587)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p6261587] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p12410027171 : Nat.Prime 12410027171 := by
  apply lucasNat 12410027171 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12410027171-1 = 2 * (5 * (269 * (751 * (6143)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p269, Nat.prime_dvd_prime_iff_eq hq p751, Nat.prime_dvd_prime_iff_eq hq p6143] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p16778523313 : Nat.Prime 16778523313 := by
  apply lucasNat 16778523313 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16778523313-1 = 2 * (2 * (2 * (2 * (3 * (3 * (1453 * (80191))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1453, Nat.prime_dvd_prime_iff_eq hq p80191] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p25484199527 : Nat.Prime 25484199527 := by
  apply lucasNat 25484199527 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25484199527-1 = 2 * (1103 * (1999 * (5779))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1103, Nat.prime_dvd_prime_iff_eq hq p1999, Nat.prime_dvd_prime_iff_eq hq p5779] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p54406963517 : Nat.Prime 54406963517 := by
  apply lucasNat 54406963517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 54406963517-1 = 2 * (2 * (59 * (230537981))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p59, Nat.prime_dvd_prime_iff_eq hq p230537981] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p67114093253 : Nat.Prime 67114093253 := by
  apply lucasNat 67114093253 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 67114093253-1 = 2 * (2 * (16778523313)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p16778523313] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p119047617791 : Nat.Prime 119047617791 := by
  apply lucasNat 119047617791 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 119047617791-1 = 2 * (5 * (22709 * (524231))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p22709, Nat.prime_dvd_prime_iff_eq hq p524231] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p135135133709 : Nat.Prime 135135133709 := by
  apply lucasNat 135135133709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 135135133709-1 = 2 * (2 * (23 * (1468860149))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p1468860149] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p152905197163 : Nat.Prime 152905197163 := by
  apply lucasNat 152905197163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 152905197163-1 = 2 * (3 * (25484199527)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p25484199527] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p238095235583 : Nat.Prime 238095235583 := by
  apply lucasNat 238095235583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 238095235583-1 = 2 * (119047617791) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p119047617791] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p292397657729 : Nat.Prime 292397657729 := by
  apply lucasNat 292397657729 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 292397657729-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (11 * (11 * (11 * (1716271)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p1716271] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem p420168062791 : Nat.Prime 420168062791 := by
  apply lucasNat 420168062791 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 420168062791-1 = 2 * (3 * (3 * (5 * (7 * (10273 * (64921)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p10273, Nat.prime_dvd_prime_iff_eq hq p64921] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p595238088959 : Nat.Prime 595238088959 := by
  apply lucasNat 595238088959 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 595238088959-1 = 2 * (107 * (12073 * (230389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p12073, Nat.prime_dvd_prime_iff_eq hq p230389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1282051268527 : Nat.Prime 1282051268527 := by
  apply lucasNat 1282051268527 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1282051268527-1 = 2 * (3 * (7 * (19 * (1606580537)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p1606580537] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p3333333298177 : Nat.Prime 3333333298177 := by
  apply lucasNat 3333333298177 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3333333298177-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (7 * (51669973))))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p51669973] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13
  all_goals subst q; decide +kernel
theorem p4545454497469 : Nat.Prime 4545454497469 := by
  apply lucasNat 4545454497469 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4545454497469-1 = 2 * (2 * (3 * (59 * (97 * (167 * (251 * (1579))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p59, Nat.prime_dvd_prime_iff_eq hq p97, Nat.prime_dvd_prime_iff_eq hq p167, Nat.prime_dvd_prime_iff_eq hq p251, Nat.prime_dvd_prime_iff_eq hq p1579] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p8333333245331 : Nat.Prime 8333333245331 := by
  apply lucasNat 8333333245331 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8333333245331-1 = 2 * (5 * (3917 * (212747849))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p3917, Nat.prime_dvd_prime_iff_eq hq p212747849] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p9999999895003 : Nat.Prime 9999999895003 := by
  apply lucasNat 9999999895003 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9999999895003-1 = 2 * (3 * (13 * (661 * (4409 * (43991))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p661, Nat.prime_dvd_prime_iff_eq hq p4409, Nat.prime_dvd_prime_iff_eq hq p43991] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p16666666490543 : Nat.Prime 16666666490543 := by
  apply lucasNat 16666666490543 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16666666490543-1 = 2 * (7217713 * (1154567)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7217713, Nat.prime_dvd_prime_iff_eq hq p1154567] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p49999999475423 : Nat.Prime 49999999475423 := by
  apply lucasNat 49999999475423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49999999475423-1 = 2 * (83 * (149 * (1399 * (1444967)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p83, Nat.prime_dvd_prime_iff_eq hq p149, Nat.prime_dvd_prime_iff_eq hq p1399, Nat.prime_dvd_prime_iff_eq hq p1444967] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943259 : Nat.Prime 99999998943259 := by
  apply lucasNat 99999998943259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943259-1 = 2 * (3 * (16666666490543)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p16666666490543] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998943263 : Nat.Prime 99999998943263 := by
  apply lucasNat 99999998943263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943263-1 = 2 * (11 * (227 * (52579 * (380837)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p227, Nat.prime_dvd_prime_iff_eq hq p52579, Nat.prime_dvd_prime_iff_eq hq p380837] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943319 : Nat.Prime 99999998943319 := by
  apply lucasNat 99999998943319 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943319-1 = 2 * (3 * (3 * (19 * (292397657729)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p292397657729] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943331 : Nat.Prime 99999998943331 := by
  apply lucasNat 99999998943331 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943331-1 = 2 * (3 * (5 * (6263 * (6427 * (82811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p6263, Nat.prime_dvd_prime_iff_eq hq p6427, Nat.prime_dvd_prime_iff_eq hq p82811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998943407 : Nat.Prime 99999998943407 := by
  apply lucasNat 99999998943407 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943407-1 = 2 * (113 * (13291 * (33291541))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p113, Nat.prime_dvd_prime_iff_eq hq p13291, Nat.prime_dvd_prime_iff_eq hq p33291541] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998943433 : Nat.Prime 99999998943433 := by
  apply lucasNat 99999998943433 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943433-1 = 2 * (2 * (2 * (3 * (7 * (7 * (7 * (19 * (151 * (241 * (17569)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p151, Nat.prime_dvd_prime_iff_eq hq p241, Nat.prime_dvd_prime_iff_eq hq p17569] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem p99999998943469 : Nat.Prime 99999998943469 := by
  apply lucasNat 99999998943469 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943469-1 = 2 * (2 * (3 * (13 * (127 * (569 * (677 * (13103))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p127, Nat.prime_dvd_prime_iff_eq hq p569, Nat.prime_dvd_prime_iff_eq hq p677, Nat.prime_dvd_prime_iff_eq hq p13103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998943479 : Nat.Prime 99999998943479 := by
  apply lucasNat 99999998943479 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943479-1 = 2 * (1277113 * (39150803)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1277113, Nat.prime_dvd_prime_iff_eq hq p39150803] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998943487 : Nat.Prime 99999998943487 := by
  apply lucasNat 99999998943487 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943487-1 = 2 * (3 * (1313311 * (12690571))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1313311, Nat.prime_dvd_prime_iff_eq hq p12690571] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998943503 : Nat.Prime 99999998943503 := by
  apply lucasNat 99999998943503 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943503-1 = 2 * (7 * (29 * (173 * (211 * (1543 * (4373)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p173, Nat.prime_dvd_prime_iff_eq hq p211, Nat.prime_dvd_prime_iff_eq hq p1543, Nat.prime_dvd_prime_iff_eq hq p4373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943511 : Nat.Prime 99999998943511 := by
  apply lucasNat 99999998943511 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943511-1 = 2 * (3 * (5 * (17 * (17 * (157 * (73465129)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p157, Nat.prime_dvd_prime_iff_eq hq p73465129] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943517 : Nat.Prime 99999998943517 := by
  apply lucasNat 99999998943517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943517-1 = 2 * (2 * (3 * (3 * (7 * (41 * (9497 * (1019129))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p41, Nat.prime_dvd_prime_iff_eq hq p9497, Nat.prime_dvd_prime_iff_eq hq p1019129] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998943643 : Nat.Prime 99999998943643 := by
  apply lucasNat 99999998943643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943643-1 = 2 * (3 * (3 * (7 * (101 * (1117 * (7034851)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p101, Nat.prime_dvd_prime_iff_eq hq p1117, Nat.prime_dvd_prime_iff_eq hq p7034851] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943659 : Nat.Prime 99999998943659 := by
  apply lucasNat 99999998943659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943659-1 = 2 * (11 * (61 * (502259 * (148361)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p61, Nat.prime_dvd_prime_iff_eq hq p502259, Nat.prime_dvd_prime_iff_eq hq p148361] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943701 : Nat.Prime 99999998943701 := by
  apply lucasNat 99999998943701 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943701-1 = 2 * (2 * (5 * (5 * (53 * (2141 * (8812669)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p2141, Nat.prime_dvd_prime_iff_eq hq p8812669] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943727 : Nat.Prime 99999998943727 := by
  apply lucasNat 99999998943727 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943727-1 = 2 * (3 * (7 * (7 * (983 * (346018363))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p983, Nat.prime_dvd_prime_iff_eq hq p346018363] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998943739 : Nat.Prime 99999998943739 := by
  apply lucasNat 99999998943739 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943739-1 = 2 * (3 * (6367 * (2617663969))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p6367, Nat.prime_dvd_prime_iff_eq hq p2617663969] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998943769 : Nat.Prime 99999998943769 := by
  apply lucasNat 99999998943769 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943769-1 = 2 * (2 * (2 * (3 * (3 * (3 * (7 * (11 * (9293 * (646993))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p9293, Nat.prime_dvd_prime_iff_eq hq p646993] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p99999998943919 : Nat.Prime 99999998943919 := by
  apply lucasNat 99999998943919 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943919-1 = 2 * (3 * (17 * (79 * (12410027171)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p79, Nat.prime_dvd_prime_iff_eq hq p12410027171] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943931 : Nat.Prime 99999998943931 := by
  apply lucasNat 99999998943931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943931-1 = 2 * (3 * (3 * (3 * (5 * (269 * (20983 * (65617))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p269, Nat.prime_dvd_prime_iff_eq hq p20983, Nat.prime_dvd_prime_iff_eq hq p65617] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998943961 : Nat.Prime 99999998943961 := by
  apply lucasNat 99999998943961 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943961-1 = 2 * (2 * (2 * (3 * (5 * (3917 * (212747849)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p3917, Nat.prime_dvd_prime_iff_eq hq p212747849] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943973 : Nat.Prime 99999998943973 := by
  apply lucasNat 99999998943973 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943973-1 = 2 * (2 * (3 * (8333333245331))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p8333333245331] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944093 : Nat.Prime 99999998944093 := by
  apply lucasNat 99999998944093 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944093-1 = 2 * (2 * (3 * (3 * (3 * (13 * (199 * (357914927))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p199, Nat.prime_dvd_prime_iff_eq hq p357914927] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998944133 : Nat.Prime 99999998944133 := by
  apply lucasNat 99999998944133 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944133-1 = 2 * (2 * (7 * (293 * (3499 * (3483617))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p293, Nat.prime_dvd_prime_iff_eq hq p3499, Nat.prime_dvd_prime_iff_eq hq p3483617] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944231 : Nat.Prime 99999998944231 := by
  apply lucasNat 99999998944231 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944231-1 = 2 * (3 * (5 * (7 * (11 * (19 * (53 * (127 * (338497)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p127, Nat.prime_dvd_prime_iff_eq hq p338497] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p99999998944243 : Nat.Prime 99999998944243 := by
  apply lucasNat 99999998944243 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944243-1 = 2 * (3 * (23 * (1217 * (595429477)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p1217, Nat.prime_dvd_prime_iff_eq hq p595429477] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944247 : Nat.Prime 99999998944247 := by
  apply lucasNat 99999998944247 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944247-1 = 2 * (919 * (54406963517)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p919, Nat.prime_dvd_prime_iff_eq hq p54406963517] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998944259 : Nat.Prime 99999998944259 := by
  apply lucasNat 99999998944259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944259-1 = 2 * (7 * (17 * (420168062791))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p420168062791] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944273 : Nat.Prime 99999998944273 := by
  apply lucasNat 99999998944273 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944273-1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (4013 * (24721243)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p4013, Nat.prime_dvd_prime_iff_eq hq p24721243] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p99999998944319 : Nat.Prime 99999998944319 := by
  apply lucasNat 99999998944319 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944319-1 = 2 * (11 * (4545454497469)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p4545454497469] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998944361 : Nat.Prime 99999998944361 := by
  apply lucasNat 99999998944361 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944361-1 = 2 * (2 * (2 * (5 * (17 * (31 * (4743832967)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p4743832967] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944369 : Nat.Prime 99999998944369 := by
  apply lucasNat 99999998944369 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944369-1 = 2 * (2 * (2 * (2 * (3 * (3795283 * (548927)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p3795283, Nat.prime_dvd_prime_iff_eq hq p548927] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944379 : Nat.Prime 99999998944379 := by
  apply lucasNat 99999998944379 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944379-1 = 2 * (13 * (137 * (277 * (953 * (106349))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p137, Nat.prime_dvd_prime_iff_eq hq p277, Nat.prime_dvd_prime_iff_eq hq p953, Nat.prime_dvd_prime_iff_eq hq p106349] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944427 : Nat.Prime 99999998944427 := by
  apply lucasNat 99999998944427 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944427-1 = 2 * (7 * (23 * (67 * (311 * (14904209))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p311, Nat.prime_dvd_prime_iff_eq hq p14904209] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944429 : Nat.Prime 99999998944429 := by
  apply lucasNat 99999998944429 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944429-1 = 2 * (2 * (3 * (11 * (11 * (17 * (4051207217)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p4051207217] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944481 : Nat.Prime 99999998944481 := by
  apply lucasNat 99999998944481 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944481-1 = 2 * (2 * (2 * (2 * (2 * (5 * (103 * (197 * (1093 * (28181))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p103, Nat.prime_dvd_prime_iff_eq hq p197, Nat.prime_dvd_prime_iff_eq hq p1093, Nat.prime_dvd_prime_iff_eq hq p28181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p99999998944507 : Nat.Prime 99999998944507 := by
  apply lucasNat 99999998944507 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944507-1 = 2 * (3 * (3 * (15319 * (362657843)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p15319, Nat.prime_dvd_prime_iff_eq hq p362657843] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944511 : Nat.Prime 99999998944511 := by
  apply lucasNat 99999998944511 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944511-1 = 2 * (5 * (7 * (7 * (36997 * (5516167))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p36997, Nat.prime_dvd_prime_iff_eq hq p5516167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944537 : Nat.Prime 99999998944537 := by
  apply lucasNat 99999998944537 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944537-1 = 2 * (2 * (2 * (3 * (83 * (113 * (444254891)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p83, Nat.prime_dvd_prime_iff_eq hq p113, Nat.prime_dvd_prime_iff_eq hq p444254891] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944543 : Nat.Prime 99999998944543 := by
  apply lucasNat 99999998944543 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944543-1 = 2 * (3 * (3 * (691 * (8039877709)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p691, Nat.prime_dvd_prime_iff_eq hq p8039877709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944561 : Nat.Prime 99999998944561 := by
  apply lucasNat 99999998944561 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944561-1 = 2 * (2 * (2 * (2 * (3 * (3 * (5 * (11 * (13 * (67 * (71 * (204173))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p204173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem p99999998944579 : Nat.Prime 99999998944579 := by
  apply lucasNat 99999998944579 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944579-1 = 2 * (3 * (3 * (3 * (92251 * (20074057))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p92251, Nat.prime_dvd_prime_iff_eq hq p20074057] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944603 : Nat.Prime 99999998944603 := by
  apply lucasNat 99999998944603 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944603-1 = 2 * (3 * (109 * (152905197163))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p109, Nat.prime_dvd_prime_iff_eq hq p152905197163] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944607 : Nat.Prime 99999998944607 := by
  apply lucasNat 99999998944607 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944607-1 = 2 * (569 * (733 * (119881939))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p569, Nat.prime_dvd_prime_iff_eq hq p733, Nat.prime_dvd_prime_iff_eq hq p119881939] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944661 : Nat.Prime 99999998944661 := by
  apply lucasNat 99999998944661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944661-1 = 2 * (2 * (5 * (37 * (135135133709)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p135135133709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944663 : Nat.Prime 99999998944663 := by
  apply lucasNat 99999998944663 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944663-1 = 2 * (3 * (29 * (1187 * (484172399)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p1187, Nat.prime_dvd_prime_iff_eq hq p484172399] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944669 : Nat.Prime 99999998944669 := by
  apply lucasNat 99999998944669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944669-1 = 2 * (2 * (3 * (3 * (373 * (7447125331))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p373, Nat.prime_dvd_prime_iff_eq hq p7447125331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944733 : Nat.Prime 99999998944733 := by
  apply lucasNat 99999998944733 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944733-1 = 2 * (2 * (31 * (661 * (1220047813)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p661, Nat.prime_dvd_prime_iff_eq hq p1220047813] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944793 : Nat.Prime 99999998944793 := by
  apply lucasNat 99999998944793 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944793-1 = 2 * (2 * (2 * (1451767 * (8610197)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1451767, Nat.prime_dvd_prime_iff_eq hq p8610197] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944831 : Nat.Prime 99999998944831 := by
  apply lucasNat 99999998944831 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944831-1 = 2 * (3 * (3 * (5 * (43 * (32237 * (801557)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p43, Nat.prime_dvd_prime_iff_eq hq p32237, Nat.prime_dvd_prime_iff_eq hq p801557] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944843 : Nat.Prime 99999998944843 := by
  apply lucasNat 99999998944843 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944843-1 = 2 * (3 * (8527 * (1954575641))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p8527, Nat.prime_dvd_prime_iff_eq hq p1954575641] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944861 : Nat.Prime 99999998944861 := by
  apply lucasNat 99999998944861 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944861-1 = 2 * (2 * (3 * (5 * (7 * (238095235583))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p238095235583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944871 : Nat.Prime 99999998944871 := by
  apply lucasNat 99999998944871 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944871-1 = 2 * (5 * (17 * (2039 * (288492049)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p2039, Nat.prime_dvd_prime_iff_eq hq p288492049] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944877 : Nat.Prime 99999998944877 := by
  apply lucasNat 99999998944877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944877-1 = 2 * (2 * (19 * (397 * (6203 * (534311))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p397, Nat.prime_dvd_prime_iff_eq hq p6203, Nat.prime_dvd_prime_iff_eq hq p534311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944889 : Nat.Prime 99999998944889 := by
  apply lucasNat 99999998944889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944889-1 = 2 * (2 * (2 * (7 * (199 * (2647 * (3390041)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p199, Nat.prime_dvd_prime_iff_eq hq p2647, Nat.prime_dvd_prime_iff_eq hq p3390041] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944891 : Nat.Prime 99999998944891 := by
  apply lucasNat 99999998944891 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944891-1 = 2 * (3 * (5 * (11 * (1493 * (202967381))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p1493, Nat.prime_dvd_prime_iff_eq hq p202967381] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944897 : Nat.Prime 99999998944897 := by
  apply lucasNat 99999998944897 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944897-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (181 * (1438766099))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p181, Nat.prime_dvd_prime_iff_eq hq p1438766099] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p99999998944943 : Nat.Prime 99999998944943 := by
  apply lucasNat 99999998944943 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944943-1 = 2 * (151 * (881 * (1321 * (284521)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p151, Nat.prime_dvd_prime_iff_eq hq p881, Nat.prime_dvd_prime_iff_eq hq p1321, Nat.prime_dvd_prime_iff_eq hq p284521] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944969 : Nat.Prime 99999998944969 := by
  apply lucasNat 99999998944969 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944969-1 = 2 * (2 * (2 * (3 * (56713 * (73469339))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p56713, Nat.prime_dvd_prime_iff_eq hq p73469339] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944973 : Nat.Prime 99999998944973 := by
  apply lucasNat 99999998944973 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944973-1 = 2 * (2 * (7 * (17 * (53 * (3963849649))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p3963849649] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944997 : Nat.Prime 99999998944997 := by
  apply lucasNat 99999998944997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944997-1 = 2 * (2 * (89 * (164513 * (1707457)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p89, Nat.prime_dvd_prime_iff_eq hq p164513, Nat.prime_dvd_prime_iff_eq hq p1707457] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944999 : Nat.Prime 99999998944999 := by
  apply lucasNat 99999998944999 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944999-1 = 2 * (3 * (1152121 * (14466073))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1152121, Nat.prime_dvd_prime_iff_eq hq p14466073] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998945107 : Nat.Prime 99999998945107 := by
  apply lucasNat 99999998945107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945107-1 = 2 * (3 * (13 * (1282051268527))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p1282051268527] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998945113 : Nat.Prime 99999998945113 := by
  apply lucasNat 99999998945113 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945113-1 = 2 * (2 * (2 * (3 * (7 * (595238088959))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p595238088959] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998945137 : Nat.Prime 99999998945137 := by
  apply lucasNat 99999998945137 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945137-1 = 2 * (2 * (2 * (2 * (3 * (3 * (179 * (10957 * (354073)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p179, Nat.prime_dvd_prime_iff_eq hq p10957, Nat.prime_dvd_prime_iff_eq hq p354073] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p99999998945153 : Nat.Prime 99999998945153 := by
  apply lucasNat 99999998945153 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945153-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (463 * (1687364993)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p463, Nat.prime_dvd_prime_iff_eq hq p1687364993] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p99999998945243 : Nat.Prime 99999998945243 := by
  apply lucasNat 99999998945243 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945243-1 = 2 * (11 * (29 * (643 * (243763313)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p643, Nat.prime_dvd_prime_iff_eq hq p243763313] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998945311 : Nat.Prime 99999998945311 := by
  apply lucasNat 99999998945311 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945311-1 = 2 * (3 * (5 * (3333333298177))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p3333333298177] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998945491 : Nat.Prime 99999998945491 := by
  apply lucasNat 99999998945491 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945491-1 = 2 * (3 * (5 * (7 * (7 * (7 * (44501 * (218381))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p44501, Nat.prime_dvd_prime_iff_eq hq p218381] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998945663 : Nat.Prime 99999998945663 := by
  apply lucasNat 99999998945663 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945663-1 = 2 * (31 * (101 * (197 * (81062633)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p101, Nat.prime_dvd_prime_iff_eq hq p197, Nat.prime_dvd_prime_iff_eq hq p81062633] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998945789 : Nat.Prime 99999998945789 := by
  apply lucasNat 99999998945789 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945789-1 = 2 * (2 * (17 * (19 * (8933 * (8664433))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p8933, Nat.prime_dvd_prime_iff_eq hq p8664433] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998945969 : Nat.Prime 99999998945969 := by
  apply lucasNat 99999998945969 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945969-1 = 2 * (2 * (2 * (2 * (11 * (6299 * (8423 * (10709))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p6299, Nat.prime_dvd_prime_iff_eq hq p8423, Nat.prime_dvd_prime_iff_eq hq p10709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998946311 : Nat.Prime 99999998946311 := by
  apply lucasNat 99999998946311 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998946311-1 = 2 * (5 * (8389 * (1192037179))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p8389, Nat.prime_dvd_prime_iff_eq hq p1192037179] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998946971 : Nat.Prime 99999998946971 := by
  apply lucasNat 99999998946971 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998946971-1 = 2 * (5 * (149 * (67114093253))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p149, Nat.prime_dvd_prime_iff_eq hq p67114093253] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998948159 : Nat.Prime 99999998948159 := by
  apply lucasNat 99999998948159 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998948159-1 = 2 * (311 * (40883 * (3932483))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p311, Nat.prime_dvd_prime_iff_eq hq p40883, Nat.prime_dvd_prime_iff_eq hq p3932483] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998948189 : Nat.Prime 99999998948189 := by
  apply lucasNat 99999998948189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998948189-1 = 2 * (2 * (83 * (103 * (2924318603)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p83, Nat.prime_dvd_prime_iff_eq hq p103, Nat.prime_dvd_prime_iff_eq hq p2924318603] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998950031 : Nat.Prime 99999998950031 := by
  apply lucasNat 99999998950031 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998950031-1 = 2 * (5 * (9999999895003)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p9999999895003] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998950847 : Nat.Prime 99999998950847 := by
  apply lucasNat 99999998950847 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998950847-1 = 2 * (49999999475423) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p49999999475423] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
end Pratt14
