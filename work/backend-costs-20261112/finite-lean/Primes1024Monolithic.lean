import PrimeSupport
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
theorem prime_2 : Nat.Prime 2 := Nat.prime_two
theorem prime_3 : Nat.Prime 3 := by
  apply lucasNat 3 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3 - 1 = 2 by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2] at hd
  subst q
  decide +kernel
theorem prime_5 : Nat.Prime 5 := by
  apply lucasNat 5 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5 - 1 = 2 * (2) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_7 : Nat.Prime 7 := by
  apply lucasNat 7 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7 - 1 = 2 * (3) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_11 : Nat.Prime 11 := by
  apply lucasNat 11 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11 - 1 = 2 * (5) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_13 : Nat.Prime 13 := by
  apply lucasNat 13 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13 - 1 = 2 * (2 * (3)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_17 : Nat.Prime 17 := by
  apply lucasNat 17 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17 - 1 = 2 * (2 * (2 * (2))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_19 : Nat.Prime 19 := by
  apply lucasNat 19 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19 - 1 = 2 * (3 * (3)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_23 : Nat.Prime 23 := by
  apply lucasNat 23 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23 - 1 = 2 * (11) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_29 : Nat.Prime 29 := by
  apply lucasNat 29 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29 - 1 = 2 * (2 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_31 : Nat.Prime 31 := by
  apply lucasNat 31 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31 - 1 = 2 * (3 * (5)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_37 : Nat.Prime 37 := by
  apply lucasNat 37 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37 - 1 = 2 * (2 * (3 * (3))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_41 : Nat.Prime 41 := by
  apply lucasNat 41 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41 - 1 = 2 * (2 * (2 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_43 : Nat.Prime 43 := by
  apply lucasNat 43 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43 - 1 = 2 * (3 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_47 : Nat.Prime 47 := by
  apply lucasNat 47 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 47 - 1 = 2 * (23) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_53 : Nat.Prime 53 := by
  apply lucasNat 53 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53 - 1 = 2 * (2 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_59 : Nat.Prime 59 := by
  apply lucasNat 59 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59 - 1 = 2 * (29) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_61 : Nat.Prime 61 := by
  apply lucasNat 61 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 61 - 1 = 2 * (2 * (3 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_67 : Nat.Prime 67 := by
  apply lucasNat 67 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 67 - 1 = 2 * (3 * (11)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_71 : Nat.Prime 71 := by
  apply lucasNat 71 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 71 - 1 = 2 * (5 * (7)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_73 : Nat.Prime 73 := by
  apply lucasNat 73 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73 - 1 = 2 * (2 * (2 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_79 : Nat.Prime 79 := by
  apply lucasNat 79 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 79 - 1 = 2 * (3 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_83 : Nat.Prime 83 := by
  apply lucasNat 83 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 83 - 1 = 2 * (41) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_89 : Nat.Prime 89 := by
  apply lucasNat 89 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 89 - 1 = 2 * (2 * (2 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_97 : Nat.Prime 97 := by
  apply lucasNat 97 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 97 - 1 = 2 * (2 * (2 * (2 * (2 * (3))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_101 : Nat.Prime 101 := by
  apply lucasNat 101 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 101 - 1 = 2 * (2 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_103 : Nat.Prime 103 := by
  apply lucasNat 103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 103 - 1 = 2 * (3 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_107 : Nat.Prime 107 := by
  apply lucasNat 107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 107 - 1 = 2 * (53) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_109 : Nat.Prime 109 := by
  apply lucasNat 109 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 109 - 1 = 2 * (2 * (3 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_113 : Nat.Prime 113 := by
  apply lucasNat 113 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 113 - 1 = 2 * (2 * (2 * (2 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_127 : Nat.Prime 127 := by
  apply lucasNat 127 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 127 - 1 = 2 * (3 * (3 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_131 : Nat.Prime 131 := by
  apply lucasNat 131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 131 - 1 = 2 * (5 * (13)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_137 : Nat.Prime 137 := by
  apply lucasNat 137 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 137 - 1 = 2 * (2 * (2 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_139 : Nat.Prime 139 := by
  apply lucasNat 139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 139 - 1 = 2 * (3 * (23)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_149 : Nat.Prime 149 := by
  apply lucasNat 149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 149 - 1 = 2 * (2 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_151 : Nat.Prime 151 := by
  apply lucasNat 151 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151 - 1 = 2 * (3 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_157 : Nat.Prime 157 := by
  apply lucasNat 157 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 157 - 1 = 2 * (2 * (3 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_163 : Nat.Prime 163 := by
  apply lucasNat 163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 163 - 1 = 2 * (3 * (3 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_167 : Nat.Prime 167 := by
  apply lucasNat 167 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 167 - 1 = 2 * (83) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_173 : Nat.Prime 173 := by
  apply lucasNat 173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 173 - 1 = 2 * (2 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_179 : Nat.Prime 179 := by
  apply lucasNat 179 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 179 - 1 = 2 * (89) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_181 : Nat.Prime 181 := by
  apply lucasNat 181 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 181 - 1 = 2 * (2 * (3 * (3 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_191 : Nat.Prime 191 := by
  apply lucasNat 191 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191 - 1 = 2 * (5 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_193 : Nat.Prime 193 := by
  apply lucasNat 193 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 193 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_197 : Nat.Prime 197 := by
  apply lucasNat 197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 197 - 1 = 2 * (2 * (7 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_199 : Nat.Prime 199 := by
  apply lucasNat 199 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199 - 1 = 2 * (3 * (3 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_211 : Nat.Prime 211 := by
  apply lucasNat 211 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 211 - 1 = 2 * (3 * (5 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_223 : Nat.Prime 223 := by
  apply lucasNat 223 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 223 - 1 = 2 * (3 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_227 : Nat.Prime 227 := by
  apply lucasNat 227 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 227 - 1 = 2 * (113) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_229 : Nat.Prime 229 := by
  apply lucasNat 229 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 229 - 1 = 2 * (2 * (3 * (19))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_233 : Nat.Prime 233 := by
  apply lucasNat 233 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 233 - 1 = 2 * (2 * (2 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_239 : Nat.Prime 239 := by
  apply lucasNat 239 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 239 - 1 = 2 * (7 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_241 : Nat.Prime 241 := by
  apply lucasNat 241 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 241 - 1 = 2 * (2 * (2 * (2 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_251 : Nat.Prime 251 := by
  apply lucasNat 251 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 251 - 1 = 2 * (5 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_257 : Nat.Prime 257 := by
  apply lucasNat 257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 257 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_263 : Nat.Prime 263 := by
  apply lucasNat 263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 263 - 1 = 2 * (131) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_269 : Nat.Prime 269 := by
  apply lucasNat 269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 269 - 1 = 2 * (2 * (67)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_271 : Nat.Prime 271 := by
  apply lucasNat 271 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 271 - 1 = 2 * (3 * (3 * (3 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_277 : Nat.Prime 277 := by
  apply lucasNat 277 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 277 - 1 = 2 * (2 * (3 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_281 : Nat.Prime 281 := by
  apply lucasNat 281 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 281 - 1 = 2 * (2 * (2 * (5 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_283 : Nat.Prime 283 := by
  apply lucasNat 283 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 283 - 1 = 2 * (3 * (47)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_293 : Nat.Prime 293 := by
  apply lucasNat 293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 293 - 1 = 2 * (2 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_307 : Nat.Prime 307 := by
  apply lucasNat 307 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 307 - 1 = 2 * (3 * (3 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_311 : Nat.Prime 311 := by
  apply lucasNat 311 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 311 - 1 = 2 * (5 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_313 : Nat.Prime 313 := by
  apply lucasNat 313 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 313 - 1 = 2 * (2 * (2 * (3 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_331 : Nat.Prime 331 := by
  apply lucasNat 331 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 331 - 1 = 2 * (3 * (5 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_337 : Nat.Prime 337 := by
  apply lucasNat 337 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 337 - 1 = 2 * (2 * (2 * (2 * (3 * (7))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_347 : Nat.Prime 347 := by
  apply lucasNat 347 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 347 - 1 = 2 * (173) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_349 : Nat.Prime 349 := by
  apply lucasNat 349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 349 - 1 = 2 * (2 * (3 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_353 : Nat.Prime 353 := by
  apply lucasNat 353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 353 - 1 = 2 * (2 * (2 * (2 * (2 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_359 : Nat.Prime 359 := by
  apply lucasNat 359 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 359 - 1 = 2 * (179) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_367 : Nat.Prime 367 := by
  apply lucasNat 367 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 367 - 1 = 2 * (3 * (61)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_373 : Nat.Prime 373 := by
  apply lucasNat 373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 373 - 1 = 2 * (2 * (3 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_379 : Nat.Prime 379 := by
  apply lucasNat 379 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 379 - 1 = 2 * (3 * (3 * (3 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_383 : Nat.Prime 383 := by
  apply lucasNat 383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 383 - 1 = 2 * (191) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_191] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_389 : Nat.Prime 389 := by
  apply lucasNat 389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389 - 1 = 2 * (2 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_397 : Nat.Prime 397 := by
  apply lucasNat 397 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 397 - 1 = 2 * (2 * (3 * (3 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_401 : Nat.Prime 401 := by
  apply lucasNat 401 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 401 - 1 = 2 * (2 * (2 * (2 * (5 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_409 : Nat.Prime 409 := by
  apply lucasNat 409 21 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 409 - 1 = 2 * (2 * (2 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_419 : Nat.Prime 419 := by
  apply lucasNat 419 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 419 - 1 = 2 * (11 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_421 : Nat.Prime 421 := by
  apply lucasNat 421 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 421 - 1 = 2 * (2 * (3 * (5 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_431 : Nat.Prime 431 := by
  apply lucasNat 431 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 431 - 1 = 2 * (5 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_433 : Nat.Prime 433 := by
  apply lucasNat 433 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 433 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (3)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_439 : Nat.Prime 439 := by
  apply lucasNat 439 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 439 - 1 = 2 * (3 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_443 : Nat.Prime 443 := by
  apply lucasNat 443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 443 - 1 = 2 * (13 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_449 : Nat.Prime 449 := by
  apply lucasNat 449 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 449 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_457 : Nat.Prime 457 := by
  apply lucasNat 457 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 457 - 1 = 2 * (2 * (2 * (3 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_461 : Nat.Prime 461 := by
  apply lucasNat 461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 461 - 1 = 2 * (2 * (5 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_463 : Nat.Prime 463 := by
  apply lucasNat 463 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 463 - 1 = 2 * (3 * (7 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_479 : Nat.Prime 479 := by
  apply lucasNat 479 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 479 - 1 = 2 * (239) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_487 : Nat.Prime 487 := by
  apply lucasNat 487 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 487 - 1 = 2 * (3 * (3 * (3 * (3 * (3))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_491 : Nat.Prime 491 := by
  apply lucasNat 491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 491 - 1 = 2 * (5 * (7 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_499 : Nat.Prime 499 := by
  apply lucasNat 499 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 499 - 1 = 2 * (3 * (83)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_503 : Nat.Prime 503 := by
  apply lucasNat 503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 503 - 1 = 2 * (251) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_251] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_509 : Nat.Prime 509 := by
  apply lucasNat 509 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 509 - 1 = 2 * (2 * (127)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_127] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_523 : Nat.Prime 523 := by
  apply lucasNat 523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 523 - 1 = 2 * (3 * (3 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_541 : Nat.Prime 541 := by
  apply lucasNat 541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 541 - 1 = 2 * (2 * (3 * (3 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_547 : Nat.Prime 547 := by
  apply lucasNat 547 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 547 - 1 = 2 * (3 * (7 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_557 : Nat.Prime 557 := by
  apply lucasNat 557 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 557 - 1 = 2 * (2 * (139)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_139] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_563 : Nat.Prime 563 := by
  apply lucasNat 563 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 563 - 1 = 2 * (281) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_281] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_569 : Nat.Prime 569 := by
  apply lucasNat 569 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 569 - 1 = 2 * (2 * (2 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_571 : Nat.Prime 571 := by
  apply lucasNat 571 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 571 - 1 = 2 * (3 * (5 * (19))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_577 : Nat.Prime 577 := by
  apply lucasNat 577 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 577 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_593 : Nat.Prime 593 := by
  apply lucasNat 593 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 593 - 1 = 2 * (2 * (2 * (2 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_599 : Nat.Prime 599 := by
  apply lucasNat 599 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 599 - 1 = 2 * (13 * (23)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_601 : Nat.Prime 601 := by
  apply lucasNat 601 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 601 - 1 = 2 * (2 * (2 * (3 * (5 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_607 : Nat.Prime 607 := by
  apply lucasNat 607 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 607 - 1 = 2 * (3 * (101)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_613 : Nat.Prime 613 := by
  apply lucasNat 613 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 613 - 1 = 2 * (2 * (3 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_619 : Nat.Prime 619 := by
  apply lucasNat 619 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 619 - 1 = 2 * (3 * (103)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_641 : Nat.Prime 641 := by
  apply lucasNat 641 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 641 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (5))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_643 : Nat.Prime 643 := by
  apply lucasNat 643 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 643 - 1 = 2 * (3 * (107)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_653 : Nat.Prime 653 := by
  apply lucasNat 653 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 653 - 1 = 2 * (2 * (163)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_163] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_659 : Nat.Prime 659 := by
  apply lucasNat 659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 659 - 1 = 2 * (7 * (47)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_661 : Nat.Prime 661 := by
  apply lucasNat 661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 661 - 1 = 2 * (2 * (3 * (5 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_673 : Nat.Prime 673 := by
  apply lucasNat 673 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 673 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_677 : Nat.Prime 677 := by
  apply lucasNat 677 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 677 - 1 = 2 * (2 * (13 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_683 : Nat.Prime 683 := by
  apply lucasNat 683 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 683 - 1 = 2 * (11 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_691 : Nat.Prime 691 := by
  apply lucasNat 691 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 691 - 1 = 2 * (3 * (5 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_701 : Nat.Prime 701 := by
  apply lucasNat 701 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 701 - 1 = 2 * (2 * (5 * (5 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_709 : Nat.Prime 709 := by
  apply lucasNat 709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 709 - 1 = 2 * (2 * (3 * (59))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_719 : Nat.Prime 719 := by
  apply lucasNat 719 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 719 - 1 = 2 * (359) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_359] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_727 : Nat.Prime 727 := by
  apply lucasNat 727 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 727 - 1 = 2 * (3 * (11 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_733 : Nat.Prime 733 := by
  apply lucasNat 733 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 733 - 1 = 2 * (2 * (3 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_743 : Nat.Prime 743 := by
  apply lucasNat 743 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 743 - 1 = 2 * (7 * (53)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_751 : Nat.Prime 751 := by
  apply lucasNat 751 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 751 - 1 = 2 * (3 * (5 * (5 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_757 : Nat.Prime 757 := by
  apply lucasNat 757 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 757 - 1 = 2 * (2 * (3 * (3 * (3 * (7))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_761 : Nat.Prime 761 := by
  apply lucasNat 761 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 761 - 1 = 2 * (2 * (2 * (5 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_773 : Nat.Prime 773 := by
  apply lucasNat 773 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 773 - 1 = 2 * (2 * (193)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_787 : Nat.Prime 787 := by
  apply lucasNat 787 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 787 - 1 = 2 * (3 * (131)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_797 : Nat.Prime 797 := by
  apply lucasNat 797 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 797 - 1 = 2 * (2 * (199)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_199] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_809 : Nat.Prime 809 := by
  apply lucasNat 809 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 809 - 1 = 2 * (2 * (2 * (101))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_811 : Nat.Prime 811 := by
  apply lucasNat 811 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 811 - 1 = 2 * (3 * (3 * (3 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_821 : Nat.Prime 821 := by
  apply lucasNat 821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 821 - 1 = 2 * (2 * (5 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_823 : Nat.Prime 823 := by
  apply lucasNat 823 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 823 - 1 = 2 * (3 * (137)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_137] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_827 : Nat.Prime 827 := by
  apply lucasNat 827 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 827 - 1 = 2 * (7 * (59)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_829 : Nat.Prime 829 := by
  apply lucasNat 829 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 829 - 1 = 2 * (2 * (3 * (3 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_853 : Nat.Prime 853 := by
  apply lucasNat 853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 853 - 1 = 2 * (2 * (3 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_857 : Nat.Prime 857 := by
  apply lucasNat 857 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 857 - 1 = 2 * (2 * (2 * (107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_859 : Nat.Prime 859 := by
  apply lucasNat 859 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 859 - 1 = 2 * (3 * (11 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_863 : Nat.Prime 863 := by
  apply lucasNat 863 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 863 - 1 = 2 * (431) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_431] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_883 : Nat.Prime 883 := by
  apply lucasNat 883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 883 - 1 = 2 * (3 * (3 * (7 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_887 : Nat.Prime 887 := by
  apply lucasNat 887 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 887 - 1 = 2 * (443) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_443] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_907 : Nat.Prime 907 := by
  apply lucasNat 907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 907 - 1 = 2 * (3 * (151)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_911 : Nat.Prime 911 := by
  apply lucasNat 911 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 911 - 1 = 2 * (5 * (7 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_919 : Nat.Prime 919 := by
  apply lucasNat 919 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 919 - 1 = 2 * (3 * (3 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_929 : Nat.Prime 929 := by
  apply lucasNat 929 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 929 - 1 = 2 * (2 * (2 * (2 * (2 * (29))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_941 : Nat.Prime 941 := by
  apply lucasNat 941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 941 - 1 = 2 * (2 * (5 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_947 : Nat.Prime 947 := by
  apply lucasNat 947 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 947 - 1 = 2 * (11 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_953 : Nat.Prime 953 := by
  apply lucasNat 953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 953 - 1 = 2 * (2 * (2 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_967 : Nat.Prime 967 := by
  apply lucasNat 967 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 967 - 1 = 2 * (3 * (7 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_977 : Nat.Prime 977 := by
  apply lucasNat 977 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 977 - 1 = 2 * (2 * (2 * (2 * (61)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_983 : Nat.Prime 983 := by
  apply lucasNat 983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 983 - 1 = 2 * (491) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_491] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_991 : Nat.Prime 991 := by
  apply lucasNat 991 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 991 - 1 = 2 * (3 * (3 * (5 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_997 : Nat.Prime 997 := by
  apply lucasNat 997 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 997 - 1 = 2 * (2 * (3 * (83))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1009 : Nat.Prime 1009 := by
  apply lucasNat 1009 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1009 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1013 : Nat.Prime 1013 := by
  apply lucasNat 1013 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1013 - 1 = 2 * (2 * (11 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1021 : Nat.Prime 1021 := by
  apply lucasNat 1021 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1021 - 1 = 2 * (2 * (3 * (5 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1031 : Nat.Prime 1031 := by
  apply lucasNat 1031 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1031 - 1 = 2 * (5 * (103)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1033 : Nat.Prime 1033 := by
  apply lucasNat 1033 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1033 - 1 = 2 * (2 * (2 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1039 : Nat.Prime 1039 := by
  apply lucasNat 1039 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1039 - 1 = 2 * (3 * (173)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1049 : Nat.Prime 1049 := by
  apply lucasNat 1049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1049 - 1 = 2 * (2 * (2 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1061 : Nat.Prime 1061 := by
  apply lucasNat 1061 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1061 - 1 = 2 * (2 * (5 * (53))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1087 : Nat.Prime 1087 := by
  apply lucasNat 1087 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1087 - 1 = 2 * (3 * (181)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1093 : Nat.Prime 1093 := by
  apply lucasNat 1093 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1093 - 1 = 2 * (2 * (3 * (7 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1103 : Nat.Prime 1103 := by
  apply lucasNat 1103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1103 - 1 = 2 * (19 * (29)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1109 : Nat.Prime 1109 := by
  apply lucasNat 1109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1109 - 1 = 2 * (2 * (277)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_277] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1117 : Nat.Prime 1117 := by
  apply lucasNat 1117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1117 - 1 = 2 * (2 * (3 * (3 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1123 : Nat.Prime 1123 := by
  apply lucasNat 1123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1123 - 1 = 2 * (3 * (11 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1129 : Nat.Prime 1129 := by
  apply lucasNat 1129 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1129 - 1 = 2 * (2 * (2 * (3 * (47)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1151 : Nat.Prime 1151 := by
  apply lucasNat 1151 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1151 - 1 = 2 * (5 * (5 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1153 : Nat.Prime 1153 := by
  apply lucasNat 1153 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1153 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1163 : Nat.Prime 1163 := by
  apply lucasNat 1163 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1163 - 1 = 2 * (7 * (83)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1181 : Nat.Prime 1181 := by
  apply lucasNat 1181 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1181 - 1 = 2 * (2 * (5 * (59))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1213 : Nat.Prime 1213 := by
  apply lucasNat 1213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1213 - 1 = 2 * (2 * (3 * (101))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1217 : Nat.Prime 1217 := by
  apply lucasNat 1217 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1217 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1229 : Nat.Prime 1229 := by
  apply lucasNat 1229 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1229 - 1 = 2 * (2 * (307)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_307] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1237 : Nat.Prime 1237 := by
  apply lucasNat 1237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1237 - 1 = 2 * (2 * (3 * (103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1259 : Nat.Prime 1259 := by
  apply lucasNat 1259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1259 - 1 = 2 * (17 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1277 : Nat.Prime 1277 := by
  apply lucasNat 1277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1277 - 1 = 2 * (2 * (11 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1283 : Nat.Prime 1283 := by
  apply lucasNat 1283 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1283 - 1 = 2 * (641) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_641] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1289 : Nat.Prime 1289 := by
  apply lucasNat 1289 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1289 - 1 = 2 * (2 * (2 * (7 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1301 : Nat.Prime 1301 := by
  apply lucasNat 1301 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1301 - 1 = 2 * (2 * (5 * (5 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1303 : Nat.Prime 1303 := by
  apply lucasNat 1303 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1303 - 1 = 2 * (3 * (7 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1307 : Nat.Prime 1307 := by
  apply lucasNat 1307 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1307 - 1 = 2 * (653) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_653] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1319 : Nat.Prime 1319 := by
  apply lucasNat 1319 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1319 - 1 = 2 * (659) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_659] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1321 : Nat.Prime 1321 := by
  apply lucasNat 1321 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1321 - 1 = 2 * (2 * (2 * (3 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1361 : Nat.Prime 1361 := by
  apply lucasNat 1361 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1361 - 1 = 2 * (2 * (2 * (2 * (5 * (17))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1367 : Nat.Prime 1367 := by
  apply lucasNat 1367 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1367 - 1 = 2 * (683) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_683] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1373 : Nat.Prime 1373 := by
  apply lucasNat 1373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1373 - 1 = 2 * (2 * (7 * (7 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1381 : Nat.Prime 1381 := by
  apply lucasNat 1381 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1381 - 1 = 2 * (2 * (3 * (5 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1423 : Nat.Prime 1423 := by
  apply lucasNat 1423 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1423 - 1 = 2 * (3 * (3 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1427 : Nat.Prime 1427 := by
  apply lucasNat 1427 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1427 - 1 = 2 * (23 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1429 : Nat.Prime 1429 := by
  apply lucasNat 1429 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1429 - 1 = 2 * (2 * (3 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1433 : Nat.Prime 1433 := by
  apply lucasNat 1433 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1433 - 1 = 2 * (2 * (2 * (179))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1439 : Nat.Prime 1439 := by
  apply lucasNat 1439 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1439 - 1 = 2 * (719) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_719] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1451 : Nat.Prime 1451 := by
  apply lucasNat 1451 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1451 - 1 = 2 * (5 * (5 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1453 : Nat.Prime 1453 := by
  apply lucasNat 1453 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1453 - 1 = 2 * (2 * (3 * (11 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1471 : Nat.Prime 1471 := by
  apply lucasNat 1471 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1471 - 1 = 2 * (3 * (5 * (7 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1481 : Nat.Prime 1481 := by
  apply lucasNat 1481 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1481 - 1 = 2 * (2 * (2 * (5 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1489 : Nat.Prime 1489 := by
  apply lucasNat 1489 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1489 - 1 = 2 * (2 * (2 * (2 * (3 * (31))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1493 : Nat.Prime 1493 := by
  apply lucasNat 1493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1493 - 1 = 2 * (2 * (373)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_373] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1499 : Nat.Prime 1499 := by
  apply lucasNat 1499 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1499 - 1 = 2 * (7 * (107)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1543 : Nat.Prime 1543 := by
  apply lucasNat 1543 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1543 - 1 = 2 * (3 * (257)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_257] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1549 : Nat.Prime 1549 := by
  apply lucasNat 1549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1549 - 1 = 2 * (2 * (3 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1553 : Nat.Prime 1553 := by
  apply lucasNat 1553 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1553 - 1 = 2 * (2 * (2 * (2 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1559 : Nat.Prime 1559 := by
  apply lucasNat 1559 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1559 - 1 = 2 * (19 * (41)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1571 : Nat.Prime 1571 := by
  apply lucasNat 1571 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1571 - 1 = 2 * (5 * (157)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1583 : Nat.Prime 1583 := by
  apply lucasNat 1583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1583 - 1 = 2 * (7 * (113)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1597 : Nat.Prime 1597 := by
  apply lucasNat 1597 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1597 - 1 = 2 * (2 * (3 * (7 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1607 : Nat.Prime 1607 := by
  apply lucasNat 1607 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1607 - 1 = 2 * (11 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1609 : Nat.Prime 1609 := by
  apply lucasNat 1609 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1609 - 1 = 2 * (2 * (2 * (3 * (67)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1613 : Nat.Prime 1613 := by
  apply lucasNat 1613 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1613 - 1 = 2 * (2 * (13 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1619 : Nat.Prime 1619 := by
  apply lucasNat 1619 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1619 - 1 = 2 * (809) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_809] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1657 : Nat.Prime 1657 := by
  apply lucasNat 1657 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1657 - 1 = 2 * (2 * (2 * (3 * (3 * (23))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1697 : Nat.Prime 1697 := by
  apply lucasNat 1697 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1697 - 1 = 2 * (2 * (2 * (2 * (2 * (53))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1709 : Nat.Prime 1709 := by
  apply lucasNat 1709 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1709 - 1 = 2 * (2 * (7 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1721 : Nat.Prime 1721 := by
  apply lucasNat 1721 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1721 - 1 = 2 * (2 * (2 * (5 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1723 : Nat.Prime 1723 := by
  apply lucasNat 1723 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1723 - 1 = 2 * (3 * (7 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1777 : Nat.Prime 1777 := by
  apply lucasNat 1777 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1777 - 1 = 2 * (2 * (2 * (2 * (3 * (37))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1783 : Nat.Prime 1783 := by
  apply lucasNat 1783 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1783 - 1 = 2 * (3 * (3 * (3 * (3 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1801 : Nat.Prime 1801 := by
  apply lucasNat 1801 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1801 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (5)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1811 : Nat.Prime 1811 := by
  apply lucasNat 1811 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1811 - 1 = 2 * (5 * (181)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1823 : Nat.Prime 1823 := by
  apply lucasNat 1823 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1823 - 1 = 2 * (911) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_911] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1831 : Nat.Prime 1831 := by
  apply lucasNat 1831 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1831 - 1 = 2 * (3 * (5 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1847 : Nat.Prime 1847 := by
  apply lucasNat 1847 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1847 - 1 = 2 * (13 * (71)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1861 : Nat.Prime 1861 := by
  apply lucasNat 1861 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1861 - 1 = 2 * (2 * (3 * (5 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1867 : Nat.Prime 1867 := by
  apply lucasNat 1867 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1867 - 1 = 2 * (3 * (311)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1877 : Nat.Prime 1877 := by
  apply lucasNat 1877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1877 - 1 = 2 * (2 * (7 * (67))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1889 : Nat.Prime 1889 := by
  apply lucasNat 1889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1889 - 1 = 2 * (2 * (2 * (2 * (2 * (59))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1907 : Nat.Prime 1907 := by
  apply lucasNat 1907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1907 - 1 = 2 * (953) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_953] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1913 : Nat.Prime 1913 := by
  apply lucasNat 1913 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1913 - 1 = 2 * (2 * (2 * (239))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1993 : Nat.Prime 1993 := by
  apply lucasNat 1993 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1993 - 1 = 2 * (2 * (2 * (3 * (83)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1997 : Nat.Prime 1997 := by
  apply lucasNat 1997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1997 - 1 = 2 * (2 * (499)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_499] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2003 : Nat.Prime 2003 := by
  apply lucasNat 2003 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2003 - 1 = 2 * (7 * (11 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2017 : Nat.Prime 2017 := by
  apply lucasNat 2017 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2017 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (7))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2029 : Nat.Prime 2029 := by
  apply lucasNat 2029 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2029 - 1 = 2 * (2 * (3 * (13 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2063 : Nat.Prime 2063 := by
  apply lucasNat 2063 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2063 - 1 = 2 * (1031) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1031] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2081 : Nat.Prime 2081 := by
  apply lucasNat 2081 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2081 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (13)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2099 : Nat.Prime 2099 := by
  apply lucasNat 2099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2099 - 1 = 2 * (1049) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1049] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2131 : Nat.Prime 2131 := by
  apply lucasNat 2131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2131 - 1 = 2 * (3 * (5 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2141 : Nat.Prime 2141 := by
  apply lucasNat 2141 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2141 - 1 = 2 * (2 * (5 * (107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2143 : Nat.Prime 2143 := by
  apply lucasNat 2143 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2143 - 1 = 2 * (3 * (3 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2179 : Nat.Prime 2179 := by
  apply lucasNat 2179 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2179 - 1 = 2 * (3 * (3 * (11 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2237 : Nat.Prime 2237 := by
  apply lucasNat 2237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2237 - 1 = 2 * (2 * (13 * (43))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2281 : Nat.Prime 2281 := by
  apply lucasNat 2281 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2281 - 1 = 2 * (2 * (2 * (3 * (5 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2297 : Nat.Prime 2297 := by
  apply lucasNat 2297 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2297 - 1 = 2 * (2 * (2 * (7 * (41)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2309 : Nat.Prime 2309 := by
  apply lucasNat 2309 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2309 - 1 = 2 * (2 * (577)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_577] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2311 : Nat.Prime 2311 := by
  apply lucasNat 2311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2311 - 1 = 2 * (3 * (5 * (7 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2339 : Nat.Prime 2339 := by
  apply lucasNat 2339 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2339 - 1 = 2 * (7 * (167)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2351 : Nat.Prime 2351 := by
  apply lucasNat 2351 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2351 - 1 = 2 * (5 * (5 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2371 : Nat.Prime 2371 := by
  apply lucasNat 2371 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2371 - 1 = 2 * (3 * (5 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2383 : Nat.Prime 2383 := by
  apply lucasNat 2383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2383 - 1 = 2 * (3 * (397)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_397] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2389 : Nat.Prime 2389 := by
  apply lucasNat 2389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2389 - 1 = 2 * (2 * (3 * (199))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_199] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2417 : Nat.Prime 2417 := by
  apply lucasNat 2417 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2417 - 1 = 2 * (2 * (2 * (2 * (151)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2473 : Nat.Prime 2473 := by
  apply lucasNat 2473 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2473 - 1 = 2 * (2 * (2 * (3 * (103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2477 : Nat.Prime 2477 := by
  apply lucasNat 2477 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2477 - 1 = 2 * (2 * (619)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_619] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2521 : Nat.Prime 2521 := by
  apply lucasNat 2521 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2521 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2531 : Nat.Prime 2531 := by
  apply lucasNat 2531 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2531 - 1 = 2 * (5 * (11 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2551 : Nat.Prime 2551 := by
  apply lucasNat 2551 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2551 - 1 = 2 * (3 * (5 * (5 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2617 : Nat.Prime 2617 := by
  apply lucasNat 2617 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2617 - 1 = 2 * (2 * (2 * (3 * (109)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2647 : Nat.Prime 2647 := by
  apply lucasNat 2647 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2647 - 1 = 2 * (3 * (3 * (3 * (7 * (7))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2657 : Nat.Prime 2657 := by
  apply lucasNat 2657 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2657 - 1 = 2 * (2 * (2 * (2 * (2 * (83))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2659 : Nat.Prime 2659 := by
  apply lucasNat 2659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2659 - 1 = 2 * (3 * (443)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_443] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2687 : Nat.Prime 2687 := by
  apply lucasNat 2687 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2687 - 1 = 2 * (17 * (79)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2693 : Nat.Prime 2693 := by
  apply lucasNat 2693 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2693 - 1 = 2 * (2 * (673)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_673] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2699 : Nat.Prime 2699 := by
  apply lucasNat 2699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2699 - 1 = 2 * (19 * (71)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2707 : Nat.Prime 2707 := by
  apply lucasNat 2707 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2707 - 1 = 2 * (3 * (11 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2711 : Nat.Prime 2711 := by
  apply lucasNat 2711 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2711 - 1 = 2 * (5 * (271)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_271] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2713 : Nat.Prime 2713 := by
  apply lucasNat 2713 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2713 - 1 = 2 * (2 * (2 * (3 * (113)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2741 : Nat.Prime 2741 := by
  apply lucasNat 2741 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2741 - 1 = 2 * (2 * (5 * (137))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_137] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2753 : Nat.Prime 2753 := by
  apply lucasNat 2753 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2753 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (43)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2767 : Nat.Prime 2767 := by
  apply lucasNat 2767 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2767 - 1 = 2 * (3 * (461)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_461] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2797 : Nat.Prime 2797 := by
  apply lucasNat 2797 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2797 - 1 = 2 * (2 * (3 * (233))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2843 : Nat.Prime 2843 := by
  apply lucasNat 2843 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2843 - 1 = 2 * (7 * (7 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2851 : Nat.Prime 2851 := by
  apply lucasNat 2851 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2851 - 1 = 2 * (3 * (5 * (5 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2857 : Nat.Prime 2857 := by
  apply lucasNat 2857 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2857 - 1 = 2 * (2 * (2 * (3 * (7 * (17))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2897 : Nat.Prime 2897 := by
  apply lucasNat 2897 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2897 - 1 = 2 * (2 * (2 * (2 * (181)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2903 : Nat.Prime 2903 := by
  apply lucasNat 2903 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2903 - 1 = 2 * (1451) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1451] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2909 : Nat.Prime 2909 := by
  apply lucasNat 2909 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2909 - 1 = 2 * (2 * (727)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_727] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2953 : Nat.Prime 2953 := by
  apply lucasNat 2953 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2953 - 1 = 2 * (2 * (2 * (3 * (3 * (41))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3001 : Nat.Prime 3001 := by
  apply lucasNat 3001 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3001 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (5)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3049 : Nat.Prime 3049 := by
  apply lucasNat 3049 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3049 - 1 = 2 * (2 * (2 * (3 * (127)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3119 : Nat.Prime 3119 := by
  apply lucasNat 3119 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3119 - 1 = 2 * (1559) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1559] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_3121 : Nat.Prime 3121 := by
  apply lucasNat 3121 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3121 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (13)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3169 : Nat.Prime 3169 := by
  apply lucasNat 3169 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3169 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (11))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3181 : Nat.Prime 3181 := by
  apply lucasNat 3181 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3181 - 1 = 2 * (2 * (3 * (5 * (53)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3257 : Nat.Prime 3257 := by
  apply lucasNat 3257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3257 - 1 = 2 * (2 * (2 * (11 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3299 : Nat.Prime 3299 := by
  apply lucasNat 3299 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3299 - 1 = 2 * (17 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3301 : Nat.Prime 3301 := by
  apply lucasNat 3301 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3301 - 1 = 2 * (2 * (3 * (5 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3343 : Nat.Prime 3343 := by
  apply lucasNat 3343 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3343 - 1 = 2 * (3 * (557)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_557] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3413 : Nat.Prime 3413 := by
  apply lucasNat 3413 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3413 - 1 = 2 * (2 * (853)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_853] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3433 : Nat.Prime 3433 := by
  apply lucasNat 3433 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3433 - 1 = 2 * (2 * (2 * (3 * (11 * (13))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3449 : Nat.Prime 3449 := by
  apply lucasNat 3449 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3449 - 1 = 2 * (2 * (2 * (431))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_431] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3461 : Nat.Prime 3461 := by
  apply lucasNat 3461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3461 - 1 = 2 * (2 * (5 * (173))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3469 : Nat.Prime 3469 := by
  apply lucasNat 3469 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3469 - 1 = 2 * (2 * (3 * (17 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3491 : Nat.Prime 3491 := by
  apply lucasNat 3491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3491 - 1 = 2 * (5 * (349)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_349] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3529 : Nat.Prime 3529 := by
  apply lucasNat 3529 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3529 - 1 = 2 * (2 * (2 * (3 * (3 * (7 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3533 : Nat.Prime 3533 := by
  apply lucasNat 3533 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3533 - 1 = 2 * (2 * (883)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_883] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3583 : Nat.Prime 3583 := by
  apply lucasNat 3583 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3583 - 1 = 2 * (3 * (3 * (199))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_199] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3593 : Nat.Prime 3593 := by
  apply lucasNat 3593 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3593 - 1 = 2 * (2 * (2 * (449))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_449] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3617 : Nat.Prime 3617 := by
  apply lucasNat 3617 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3617 - 1 = 2 * (2 * (2 * (2 * (2 * (113))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3637 : Nat.Prime 3637 := by
  apply lucasNat 3637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3637 - 1 = 2 * (2 * (3 * (3 * (101)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3673 : Nat.Prime 3673 := by
  apply lucasNat 3673 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3673 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (17)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3691 : Nat.Prime 3691 := by
  apply lucasNat 3691 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3691 - 1 = 2 * (3 * (3 * (5 * (41)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3709 : Nat.Prime 3709 := by
  apply lucasNat 3709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3709 - 1 = 2 * (2 * (3 * (3 * (103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3719 : Nat.Prime 3719 := by
  apply lucasNat 3719 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3719 - 1 = 2 * (11 * (13 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3739 : Nat.Prime 3739 := by
  apply lucasNat 3739 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3739 - 1 = 2 * (3 * (7 * (89))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3761 : Nat.Prime 3761 := by
  apply lucasNat 3761 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3761 - 1 = 2 * (2 * (2 * (2 * (5 * (47))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3767 : Nat.Prime 3767 := by
  apply lucasNat 3767 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3767 - 1 = 2 * (7 * (269)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_269] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3793 : Nat.Prime 3793 := by
  apply lucasNat 3793 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3793 - 1 = 2 * (2 * (2 * (2 * (3 * (79))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3821 : Nat.Prime 3821 := by
  apply lucasNat 3821 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3821 - 1 = 2 * (2 * (5 * (191))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_191] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3823 : Nat.Prime 3823 := by
  apply lucasNat 3823 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3823 - 1 = 2 * (3 * (7 * (7 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3851 : Nat.Prime 3851 := by
  apply lucasNat 3851 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3851 - 1 = 2 * (5 * (5 * (7 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3877 : Nat.Prime 3877 := by
  apply lucasNat 3877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3877 - 1 = 2 * (2 * (3 * (17 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3881 : Nat.Prime 3881 := by
  apply lucasNat 3881 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3881 - 1 = 2 * (2 * (2 * (5 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3919 : Nat.Prime 3919 := by
  apply lucasNat 3919 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3919 - 1 = 2 * (3 * (653)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_653] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3923 : Nat.Prime 3923 := by
  apply lucasNat 3923 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3923 - 1 = 2 * (37 * (53)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3931 : Nat.Prime 3931 := by
  apply lucasNat 3931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3931 - 1 = 2 * (3 * (5 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4019 : Nat.Prime 4019 := by
  apply lucasNat 4019 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4019 - 1 = 2 * (7 * (7 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4021 : Nat.Prime 4021 := by
  apply lucasNat 4021 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4021 - 1 = 2 * (2 * (3 * (5 * (67)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_4057 : Nat.Prime 4057 := by
  apply lucasNat 4057 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4057 - 1 = 2 * (2 * (2 * (3 * (13 * (13))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4073 : Nat.Prime 4073 := by
  apply lucasNat 4073 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4073 - 1 = 2 * (2 * (2 * (509))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_509] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4099 : Nat.Prime 4099 := by
  apply lucasNat 4099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4099 - 1 = 2 * (3 * (683)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_683] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_4127 : Nat.Prime 4127 := by
  apply lucasNat 4127 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4127 - 1 = 2 * (2063) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2063] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_4157 : Nat.Prime 4157 := by
  apply lucasNat 4157 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4157 - 1 = 2 * (2 * (1039)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1039] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_4231 : Nat.Prime 4231 := by
  apply lucasNat 4231 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4231 - 1 = 2 * (3 * (3 * (5 * (47)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_4349 : Nat.Prime 4349 := by
  apply lucasNat 4349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4349 - 1 = 2 * (2 * (1087)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1087] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_4373 : Nat.Prime 4373 := by
  apply lucasNat 4373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4373 - 1 = 2 * (2 * (1093)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1093] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_4463 : Nat.Prime 4463 := by
  apply lucasNat 4463 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4463 - 1 = 2 * (23 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_4493 : Nat.Prime 4493 := by
  apply lucasNat 4493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4493 - 1 = 2 * (2 * (1123)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1123] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_4513 : Nat.Prime 4513 := by
  apply lucasNat 4513 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4513 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (47)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_4517 : Nat.Prime 4517 := by
  apply lucasNat 4517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4517 - 1 = 2 * (2 * (1129)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1129] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_4519 : Nat.Prime 4519 := by
  apply lucasNat 4519 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4519 - 1 = 2 * (3 * (3 * (251))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_251] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4523 : Nat.Prime 4523 := by
  apply lucasNat 4523 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4523 - 1 = 2 * (7 * (17 * (19))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4637 : Nat.Prime 4637 := by
  apply lucasNat 4637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4637 - 1 = 2 * (2 * (19 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4691 : Nat.Prime 4691 := by
  apply lucasNat 4691 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4691 - 1 = 2 * (5 * (7 * (67))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4703 : Nat.Prime 4703 := by
  apply lucasNat 4703 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4703 - 1 = 2 * (2351) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2351] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_4813 : Nat.Prime 4813 := by
  apply lucasNat 4813 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4813 - 1 = 2 * (2 * (3 * (401))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_401] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4877 : Nat.Prime 4877 := by
  apply lucasNat 4877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4877 - 1 = 2 * (2 * (23 * (53))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4957 : Nat.Prime 4957 := by
  apply lucasNat 4957 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4957 - 1 = 2 * (2 * (3 * (7 * (59)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_4973 : Nat.Prime 4973 := by
  apply lucasNat 4973 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4973 - 1 = 2 * (2 * (11 * (113))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5023 : Nat.Prime 5023 := by
  apply lucasNat 5023 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5023 - 1 = 2 * (3 * (3 * (3 * (3 * (31))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_5101 : Nat.Prime 5101 := by
  apply lucasNat 5101 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5101 - 1 = 2 * (2 * (3 * (5 * (5 * (17))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_5107 : Nat.Prime 5107 := by
  apply lucasNat 5107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5107 - 1 = 2 * (3 * (23 * (37))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5113 : Nat.Prime 5113 := by
  apply lucasNat 5113 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5113 - 1 = 2 * (2 * (2 * (3 * (3 * (71))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_5147 : Nat.Prime 5147 := by
  apply lucasNat 5147 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5147 - 1 = 2 * (31 * (83)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5279 : Nat.Prime 5279 := by
  apply lucasNat 5279 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5279 - 1 = 2 * (7 * (13 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5303 : Nat.Prime 5303 := by
  apply lucasNat 5303 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5303 - 1 = 2 * (11 * (241)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5347 : Nat.Prime 5347 := by
  apply lucasNat 5347 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5347 - 1 = 2 * (3 * (3 * (3 * (3 * (3 * (11)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_5351 : Nat.Prime 5351 := by
  apply lucasNat 5351 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5351 - 1 = 2 * (5 * (5 * (107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5387 : Nat.Prime 5387 := by
  apply lucasNat 5387 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5387 - 1 = 2 * (2693) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2693] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_5399 : Nat.Prime 5399 := by
  apply lucasNat 5399 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5399 - 1 = 2 * (2699) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2699] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_5507 : Nat.Prime 5507 := by
  apply lucasNat 5507 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5507 - 1 = 2 * (2753) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2753] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_5641 : Nat.Prime 5641 := by
  apply lucasNat 5641 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5641 - 1 = 2 * (2 * (2 * (3 * (5 * (47))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_5659 : Nat.Prime 5659 := by
  apply lucasNat 5659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5659 - 1 = 2 * (3 * (23 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5701 : Nat.Prime 5701 := by
  apply lucasNat 5701 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5701 - 1 = 2 * (2 * (3 * (5 * (5 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_5791 : Nat.Prime 5791 := by
  apply lucasNat 5791 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5791 - 1 = 2 * (3 * (5 * (193))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5813 : Nat.Prime 5813 := by
  apply lucasNat 5813 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5813 - 1 = 2 * (2 * (1453)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1453] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5821 : Nat.Prime 5821 := by
  apply lucasNat 5821 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5821 - 1 = 2 * (2 * (3 * (5 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_5953 : Nat.Prime 5953 := by
  apply lucasNat 5953 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5953 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (31))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_6053 : Nat.Prime 6053 := by
  apply lucasNat 6053 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6053 - 1 = 2 * (2 * (17 * (89))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_6131 : Nat.Prime 6131 := by
  apply lucasNat 6131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6131 - 1 = 2 * (5 * (613)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_613] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_6197 : Nat.Prime 6197 := by
  apply lucasNat 6197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6197 - 1 = 2 * (2 * (1549)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1549] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_6229 : Nat.Prime 6229 := by
  apply lucasNat 6229 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6229 - 1 = 2 * (2 * (3 * (3 * (173)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6337 : Nat.Prime 6337 := by
  apply lucasNat 6337 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6337 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (11)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_6343 : Nat.Prime 6343 := by
  apply lucasNat 6343 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6343 - 1 = 2 * (3 * (7 * (151))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_6361 : Nat.Prime 6361 := by
  apply lucasNat 6361 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6361 - 1 = 2 * (2 * (2 * (3 * (5 * (53))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_6397 : Nat.Prime 6397 := by
  apply lucasNat 6397 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6397 - 1 = 2 * (2 * (3 * (13 * (41)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6551 : Nat.Prime 6551 := by
  apply lucasNat 6551 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6551 - 1 = 2 * (5 * (5 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_6553 : Nat.Prime 6553 := by
  apply lucasNat 6553 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6553 - 1 = 2 * (2 * (2 * (3 * (3 * (7 * (13)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_6619 : Nat.Prime 6619 := by
  apply lucasNat 6619 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6619 - 1 = 2 * (3 * (1103)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1103] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_6829 : Nat.Prime 6829 := by
  apply lucasNat 6829 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6829 - 1 = 2 * (2 * (3 * (569))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_569] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_6833 : Nat.Prime 6833 := by
  apply lucasNat 6833 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6833 - 1 = 2 * (2 * (2 * (2 * (7 * (61))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_6841 : Nat.Prime 6841 := by
  apply lucasNat 6841 22 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6841 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_6907 : Nat.Prime 6907 := by
  apply lucasNat 6907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6907 - 1 = 2 * (3 * (1151)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1151] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_6917 : Nat.Prime 6917 := by
  apply lucasNat 6917 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6917 - 1 = 2 * (2 * (7 * (13 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6983 : Nat.Prime 6983 := by
  apply lucasNat 6983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6983 - 1 = 2 * (3491) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3491] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_7127 : Nat.Prime 7127 := by
  apply lucasNat 7127 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7127 - 1 = 2 * (7 * (509)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_509] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_7187 : Nat.Prime 7187 := by
  apply lucasNat 7187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7187 - 1 = 2 * (3593) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3593] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_7211 : Nat.Prime 7211 := by
  apply lucasNat 7211 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7211 - 1 = 2 * (5 * (7 * (103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_7237 : Nat.Prime 7237 := by
  apply lucasNat 7237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7237 - 1 = 2 * (2 * (3 * (3 * (3 * (67))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_7243 : Nat.Prime 7243 := by
  apply lucasNat 7243 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7243 - 1 = 2 * (3 * (17 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_7321 : Nat.Prime 7321 := by
  apply lucasNat 7321 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7321 - 1 = 2 * (2 * (2 * (3 * (5 * (61))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_7331 : Nat.Prime 7331 := by
  apply lucasNat 7331 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7331 - 1 = 2 * (5 * (733)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_733] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_7459 : Nat.Prime 7459 := by
  apply lucasNat 7459 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7459 - 1 = 2 * (3 * (11 * (113))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_7583 : Nat.Prime 7583 := by
  apply lucasNat 7583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7583 - 1 = 2 * (17 * (223)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_223] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_7703 : Nat.Prime 7703 := by
  apply lucasNat 7703 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7703 - 1 = 2 * (3851) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3851] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_7877 : Nat.Prime 7877 := by
  apply lucasNat 7877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7877 - 1 = 2 * (2 * (11 * (179))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_7901 : Nat.Prime 7901 := by
  apply lucasNat 7901 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7901 - 1 = 2 * (2 * (5 * (5 * (79)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8059 : Nat.Prime 8059 := by
  apply lucasNat 8059 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8059 - 1 = 2 * (3 * (17 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8089 : Nat.Prime 8089 := by
  apply lucasNat 8089 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8089 - 1 = 2 * (2 * (2 * (3 * (337)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_337] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8111 : Nat.Prime 8111 := by
  apply lucasNat 8111 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8111 - 1 = 2 * (5 * (811)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_811] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8147 : Nat.Prime 8147 := by
  apply lucasNat 8147 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8147 - 1 = 2 * (4073) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4073] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8167 : Nat.Prime 8167 := by
  apply lucasNat 8167 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8167 - 1 = 2 * (3 * (1361)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1361] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8179 : Nat.Prime 8179 := by
  apply lucasNat 8179 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8179 - 1 = 2 * (3 * (29 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8209 : Nat.Prime 8209 := by
  apply lucasNat 8209 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8209 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (3 * (19))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8237 : Nat.Prime 8237 := by
  apply lucasNat 8237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8237 - 1 = 2 * (2 * (29 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8287 : Nat.Prime 8287 := by
  apply lucasNat 8287 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8287 - 1 = 2 * (3 * (1381)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1381] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8329 : Nat.Prime 8329 := by
  apply lucasNat 8329 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8329 - 1 = 2 * (2 * (2 * (3 * (347)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_347] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8521 : Nat.Prime 8521 := by
  apply lucasNat 8521 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8521 - 1 = 2 * (2 * (2 * (3 * (5 * (71))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8537 : Nat.Prime 8537 := by
  apply lucasNat 8537 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8537 - 1 = 2 * (2 * (2 * (11 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8563 : Nat.Prime 8563 := by
  apply lucasNat 8563 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8563 - 1 = 2 * (3 * (1427)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1427] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8663 : Nat.Prime 8663 := by
  apply lucasNat 8663 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8663 - 1 = 2 * (61 * (71)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8747 : Nat.Prime 8747 := by
  apply lucasNat 8747 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8747 - 1 = 2 * (4373) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4373] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8933 : Nat.Prime 8933 := by
  apply lucasNat 8933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8933 - 1 = 2 * (2 * (7 * (11 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_9199 : Nat.Prime 9199 := by
  apply lucasNat 9199 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9199 - 1 = 2 * (3 * (3 * (7 * (73)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_9239 : Nat.Prime 9239 := by
  apply lucasNat 9239 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9239 - 1 = 2 * (31 * (149)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_149] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_9281 : Nat.Prime 9281 := by
  apply lucasNat 9281 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9281 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (5 * (29))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_9397 : Nat.Prime 9397 := by
  apply lucasNat 9397 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9397 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (29)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_9851 : Nat.Prime 9851 := by
  apply lucasNat 9851 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9851 - 1 = 2 * (5 * (5 * (197))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_197] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_9941 : Nat.Prime 9941 := by
  apply lucasNat 9941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9941 - 1 = 2 * (2 * (5 * (7 * (71)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_10009 : Nat.Prime 10009 := by
  apply lucasNat 10009 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10009 - 1 = 2 * (2 * (2 * (3 * (3 * (139))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_139] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_10091 : Nat.Prime 10091 := by
  apply lucasNat 10091 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10091 - 1 = 2 * (5 * (1009)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1009] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_10151 : Nat.Prime 10151 := by
  apply lucasNat 10151 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10151 - 1 = 2 * (5 * (5 * (7 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_10181 : Nat.Prime 10181 := by
  apply lucasNat 10181 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10181 - 1 = 2 * (2 * (5 * (509))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_509] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_10333 : Nat.Prime 10333 := by
  apply lucasNat 10333 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10333 - 1 = 2 * (2 * (3 * (3 * (7 * (41))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_10487 : Nat.Prime 10487 := by
  apply lucasNat 10487 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10487 - 1 = 2 * (7 * (7 * (107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_10529 : Nat.Prime 10529 := by
  apply lucasNat 10529 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10529 - 1 = 2 * (2 * (2 * (2 * (2 * (7 * (47)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_10597 : Nat.Prime 10597 := by
  apply lucasNat 10597 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10597 - 1 = 2 * (2 * (3 * (883))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_883] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_10657 : Nat.Prime 10657 := by
  apply lucasNat 10657 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10657 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (37))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_10799 : Nat.Prime 10799 := by
  apply lucasNat 10799 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10799 - 1 = 2 * (5399) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5399] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_10847 : Nat.Prime 10847 := by
  apply lucasNat 10847 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10847 - 1 = 2 * (11 * (17 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_10937 : Nat.Prime 10937 := by
  apply lucasNat 10937 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10937 - 1 = 2 * (2 * (2 * (1367))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1367] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_11173 : Nat.Prime 11173 := by
  apply lucasNat 11173 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11173 - 1 = 2 * (2 * (3 * (7 * (7 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_11261 : Nat.Prime 11261 := by
  apply lucasNat 11261 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11261 - 1 = 2 * (2 * (5 * (563))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_563] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_11311 : Nat.Prime 11311 := by
  apply lucasNat 11311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11311 - 1 = 2 * (3 * (5 * (13 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_11321 : Nat.Prime 11321 := by
  apply lucasNat 11321 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11321 - 1 = 2 * (2 * (2 * (5 * (283)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_283] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_11351 : Nat.Prime 11351 := by
  apply lucasNat 11351 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11351 - 1 = 2 * (5 * (5 * (227))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_227] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_11447 : Nat.Prime 11447 := by
  apply lucasNat 11447 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11447 - 1 = 2 * (59 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_11617 : Nat.Prime 11617 := by
  apply lucasNat 11617 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11617 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (11 * (11))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_11633 : Nat.Prime 11633 := by
  apply lucasNat 11633 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11633 - 1 = 2 * (2 * (2 * (2 * (727)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_727] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_11719 : Nat.Prime 11719 := by
  apply lucasNat 11719 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11719 - 1 = 2 * (3 * (3 * (3 * (7 * (31))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_11783 : Nat.Prime 11783 := by
  apply lucasNat 11783 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11783 - 1 = 2 * (43 * (137)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_137] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_11789 : Nat.Prime 11789 := by
  apply lucasNat 11789 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11789 - 1 = 2 * (2 * (7 * (421))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_421] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_11813 : Nat.Prime 11813 := by
  apply lucasNat 11813 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11813 - 1 = 2 * (2 * (2953)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2953] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_11987 : Nat.Prime 11987 := by
  apply lucasNat 11987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11987 - 1 = 2 * (13 * (461)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_461] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_12007 : Nat.Prime 12007 := by
  apply lucasNat 12007 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12007 - 1 = 2 * (3 * (3 * (23 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_12041 : Nat.Prime 12041 := by
  apply lucasNat 12041 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12041 - 1 = 2 * (2 * (2 * (5 * (7 * (43))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_12391 : Nat.Prime 12391 := by
  apply lucasNat 12391 26 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12391 - 1 = 2 * (3 * (5 * (7 * (59)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_12577 : Nat.Prime 12577 := by
  apply lucasNat 12577 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12577 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (131)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_12953 : Nat.Prime 12953 := by
  apply lucasNat 12953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12953 - 1 = 2 * (2 * (2 * (1619))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1619] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_13009 : Nat.Prime 13009 := by
  apply lucasNat 13009 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13009 - 1 = 2 * (2 * (2 * (2 * (3 * (271))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_271] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_13033 : Nat.Prime 13033 := by
  apply lucasNat 13033 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13033 - 1 = 2 * (2 * (2 * (3 * (3 * (181))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_13049 : Nat.Prime 13049 := by
  apply lucasNat 13049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13049 - 1 = 2 * (2 * (2 * (7 * (233)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_13399 : Nat.Prime 13399 := by
  apply lucasNat 13399 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13399 - 1 = 2 * (3 * (7 * (11 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_13441 : Nat.Prime 13441 := by
  apply lucasNat 13441 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13441 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (7))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_13469 : Nat.Prime 13469 := by
  apply lucasNat 13469 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13469 - 1 = 2 * (2 * (7 * (13 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_13553 : Nat.Prime 13553 := by
  apply lucasNat 13553 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13553 - 1 = 2 * (2 * (2 * (2 * (7 * (11 * (11)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_13619 : Nat.Prime 13619 := by
  apply lucasNat 13619 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13619 - 1 = 2 * (11 * (619)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_619] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_13687 : Nat.Prime 13687 := by
  apply lucasNat 13687 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13687 - 1 = 2 * (3 * (2281)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2281] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_14221 : Nat.Prime 14221 := by
  apply lucasNat 14221 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14221 - 1 = 2 * (2 * (3 * (3 * (5 * (79))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_14251 : Nat.Prime 14251 := by
  apply lucasNat 14251 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14251 - 1 = 2 * (3 * (5 * (5 * (5 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_14423 : Nat.Prime 14423 := by
  apply lucasNat 14423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14423 - 1 = 2 * (7211) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7211] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_14431 : Nat.Prime 14431 := by
  apply lucasNat 14431 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14431 - 1 = 2 * (3 * (5 * (13 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_14461 : Nat.Prime 14461 := by
  apply lucasNat 14461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14461 - 1 = 2 * (2 * (3 * (5 * (241)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_14533 : Nat.Prime 14533 := by
  apply lucasNat 14533 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14533 - 1 = 2 * (2 * (3 * (7 * (173)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_14983 : Nat.Prime 14983 := by
  apply lucasNat 14983 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14983 - 1 = 2 * (3 * (11 * (227))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_227] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_15161 : Nat.Prime 15161 := by
  apply lucasNat 15161 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15161 - 1 = 2 * (2 * (2 * (5 * (379)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_379] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_15361 : Nat.Prime 15361 := by
  apply lucasNat 15361 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15361 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_15377 : Nat.Prime 15377 := by
  apply lucasNat 15377 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15377 - 1 = 2 * (2 * (2 * (2 * (31 * (31))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_15661 : Nat.Prime 15661 := by
  apply lucasNat 15661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15661 - 1 = 2 * (2 * (3 * (3 * (3 * (5 * (29)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_15733 : Nat.Prime 15733 := by
  apply lucasNat 15733 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15733 - 1 = 2 * (2 * (3 * (3 * (19 * (23))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_15877 : Nat.Prime 15877 := by
  apply lucasNat 15877 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15877 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (7 * (7))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_15889 : Nat.Prime 15889 := by
  apply lucasNat 15889 21 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15889 - 1 = 2 * (2 * (2 * (2 * (3 * (331))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_16007 : Nat.Prime 16007 := by
  apply lucasNat 16007 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16007 - 1 = 2 * (53 * (151)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_16193 : Nat.Prime 16193 := by
  apply lucasNat 16193 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16193 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (11 * (23))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_16253 : Nat.Prime 16253 := by
  apply lucasNat 16253 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16253 - 1 = 2 * (2 * (17 * (239))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_16447 : Nat.Prime 16447 := by
  apply lucasNat 16447 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16447 - 1 = 2 * (3 * (2741)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2741] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_16693 : Nat.Prime 16693 := by
  apply lucasNat 16693 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16693 - 1 = 2 * (2 * (3 * (13 * (107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_17041 : Nat.Prime 17041 := by
  apply lucasNat 17041 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17041 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (71)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_17077 : Nat.Prime 17077 := by
  apply lucasNat 17077 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17077 - 1 = 2 * (2 * (3 * (1423))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1423] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_17291 : Nat.Prime 17291 := by
  apply lucasNat 17291 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17291 - 1 = 2 * (5 * (7 * (13 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_17351 : Nat.Prime 17351 := by
  apply lucasNat 17351 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17351 - 1 = 2 * (5 * (5 * (347))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_347] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_17581 : Nat.Prime 17581 := by
  apply lucasNat 17581 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17581 - 1 = 2 * (2 * (3 * (5 * (293)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_293] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_17627 : Nat.Prime 17627 := by
  apply lucasNat 17627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17627 - 1 = 2 * (7 * (1259)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1259] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_18047 : Nat.Prime 18047 := by
  apply lucasNat 18047 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 18047 - 1 = 2 * (7 * (1289)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1289] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_19013 : Nat.Prime 19013 := by
  apply lucasNat 19013 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19013 - 1 = 2 * (2 * (7 * (7 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_19073 : Nat.Prime 19073 := by
  apply lucasNat 19073 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19073 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (149))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_149] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_19687 : Nat.Prime 19687 := by
  apply lucasNat 19687 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19687 - 1 = 2 * (3 * (17 * (193))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_20063 : Nat.Prime 20063 := by
  apply lucasNat 20063 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20063 - 1 = 2 * (7 * (1433)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1433] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_20681 : Nat.Prime 20681 := by
  apply lucasNat 20681 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20681 - 1 = 2 * (2 * (2 * (5 * (11 * (47))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_20983 : Nat.Prime 20983 := by
  apply lucasNat 20983 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20983 - 1 = 2 * (3 * (13 * (269))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_269] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_21149 : Nat.Prime 21149 := by
  apply lucasNat 21149 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21149 - 1 = 2 * (2 * (17 * (311))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_21599 : Nat.Prime 21599 := by
  apply lucasNat 21599 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21599 - 1 = 2 * (10799) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_10799] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_21617 : Nat.Prime 21617 := by
  apply lucasNat 21617 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21617 - 1 = 2 * (2 * (2 * (2 * (7 * (193))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_21649 : Nat.Prime 21649 := by
  apply lucasNat 21649 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21649 - 1 = 2 * (2 * (2 * (2 * (3 * (11 * (41)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_21961 : Nat.Prime 21961 := by
  apply lucasNat 21961 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21961 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (61)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_22079 : Nat.Prime 22079 := by
  apply lucasNat 22079 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22079 - 1 = 2 * (7 * (19 * (83))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_22643 : Nat.Prime 22643 := by
  apply lucasNat 22643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22643 - 1 = 2 * (11321) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11321] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_22777 : Nat.Prime 22777 := by
  apply lucasNat 22777 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22777 - 1 = 2 * (2 * (2 * (3 * (13 * (73))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_22807 : Nat.Prime 22807 := by
  apply lucasNat 22807 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22807 - 1 = 2 * (3 * (3 * (7 * (181)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_23087 : Nat.Prime 23087 := by
  apply lucasNat 23087 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23087 - 1 = 2 * (7 * (17 * (97))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_23813 : Nat.Prime 23813 := by
  apply lucasNat 23813 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23813 - 1 = 2 * (2 * (5953)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5953] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_23873 : Nat.Prime 23873 := by
  apply lucasNat 23873 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23873 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (373)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_23917 : Nat.Prime 23917 := by
  apply lucasNat 23917 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23917 - 1 = 2 * (2 * (3 * (1993))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1993] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_23929 : Nat.Prime 23929 := by
  apply lucasNat 23929 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23929 - 1 = 2 * (2 * (2 * (3 * (997)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_997] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_24247 : Nat.Prime 24247 := by
  apply lucasNat 24247 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24247 - 1 = 2 * (3 * (3 * (3 * (449)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_24709 : Nat.Prime 24709 := by
  apply lucasNat 24709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24709 - 1 = 2 * (2 * (3 * (29 * (71)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_24917 : Nat.Prime 24917 := by
  apply lucasNat 24917 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24917 - 1 = 2 * (2 * (6229)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_6229] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_25037 : Nat.Prime 25037 := by
  apply lucasNat 25037 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25037 - 1 = 2 * (2 * (11 * (569))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_569] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_25373 : Nat.Prime 25373 := by
  apply lucasNat 25373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25373 - 1 = 2 * (2 * (6343)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_6343] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_25439 : Nat.Prime 25439 := by
  apply lucasNat 25439 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25439 - 1 = 2 * (7 * (23 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_25733 : Nat.Prime 25733 := by
  apply lucasNat 25733 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25733 - 1 = 2 * (2 * (7 * (919))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_919] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_26053 : Nat.Prime 26053 := by
  apply lucasNat 26053 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26053 - 1 = 2 * (2 * (3 * (13 * (167)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_26083 : Nat.Prime 26083 := by
  apply lucasNat 26083 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26083 - 1 = 2 * (3 * (3 * (3 * (3 * (7 * (23)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_26249 : Nat.Prime 26249 := by
  apply lucasNat 26249 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26249 - 1 = 2 * (2 * (2 * (17 * (193)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_26573 : Nat.Prime 26573 := by
  apply lucasNat 26573 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26573 - 1 = 2 * (2 * (7 * (13 * (73)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_26861 : Nat.Prime 26861 := by
  apply lucasNat 26861 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26861 - 1 = 2 * (2 * (5 * (17 * (79)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_27107 : Nat.Prime 27107 := by
  apply lucasNat 27107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 27107 - 1 = 2 * (13553) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13553] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_27487 : Nat.Prime 27487 := by
  apply lucasNat 27487 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 27487 - 1 = 2 * (3 * (3 * (3 * (509)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_509] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_28597 : Nat.Prime 28597 := by
  apply lucasNat 28597 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 28597 - 1 = 2 * (2 * (3 * (2383))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2383] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_28603 : Nat.Prime 28603 := by
  apply lucasNat 28603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 28603 - 1 = 2 * (3 * (3 * (7 * (227)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_227] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_29389 : Nat.Prime 29389 := by
  apply lucasNat 29389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29389 - 1 = 2 * (2 * (3 * (31 * (79)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_29717 : Nat.Prime 29717 := by
  apply lucasNat 29717 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29717 - 1 = 2 * (2 * (17 * (19 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_29753 : Nat.Prime 29753 := by
  apply lucasNat 29753 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29753 - 1 = 2 * (2 * (2 * (3719))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3719] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_30707 : Nat.Prime 30707 := by
  apply lucasNat 30707 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30707 - 1 = 2 * (13 * (1181)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1181] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_30713 : Nat.Prime 30713 := by
  apply lucasNat 30713 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30713 - 1 = 2 * (2 * (2 * (11 * (349)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_349] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_31123 : Nat.Prime 31123 := by
  apply lucasNat 31123 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31123 - 1 = 2 * (3 * (3 * (7 * (13 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_31541 : Nat.Prime 31541 := by
  apply lucasNat 31541 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31541 - 1 = 2 * (2 * (5 * (19 * (83)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_31643 : Nat.Prime 31643 := by
  apply lucasNat 31643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31643 - 1 = 2 * (13 * (1217)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1217] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_31667 : Nat.Prime 31667 := by
  apply lucasNat 31667 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31667 - 1 = 2 * (71 * (223)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_223] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_31771 : Nat.Prime 31771 := by
  apply lucasNat 31771 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31771 - 1 = 2 * (3 * (3 * (5 * (353)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_353] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_32237 : Nat.Prime 32237 := by
  apply lucasNat 32237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32237 - 1 = 2 * (2 * (8059)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_8059] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_32411 : Nat.Prime 32411 := by
  apply lucasNat 32411 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32411 - 1 = 2 * (5 * (7 * (463))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_463] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_32971 : Nat.Prime 32971 := by
  apply lucasNat 32971 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32971 - 1 = 2 * (3 * (5 * (7 * (157)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_33083 : Nat.Prime 33083 := by
  apply lucasNat 33083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33083 - 1 = 2 * (7 * (17 * (139))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_139] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_33223 : Nat.Prime 33223 := by
  apply lucasNat 33223 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33223 - 1 = 2 * (3 * (7 * (7 * (113)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_33301 : Nat.Prime 33301 := by
  apply lucasNat 33301 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33301 - 1 = 2 * (2 * (3 * (3 * (5 * (5 * (37)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_33403 : Nat.Prime 33403 := by
  apply lucasNat 33403 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33403 - 1 = 2 * (3 * (19 * (293))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_293] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_33461 : Nat.Prime 33461 := by
  apply lucasNat 33461 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33461 - 1 = 2 * (2 * (5 * (7 * (239)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_33941 : Nat.Prime 33941 := by
  apply lucasNat 33941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33941 - 1 = 2 * (2 * (5 * (1697))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1697] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_34019 : Nat.Prime 34019 := by
  apply lucasNat 34019 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 34019 - 1 = 2 * (73 * (233)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_34703 : Nat.Prime 34703 := by
  apply lucasNat 34703 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 34703 - 1 = 2 * (17351) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17351] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_35911 : Nat.Prime 35911 := by
  apply lucasNat 35911 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 35911 - 1 = 2 * (3 * (3 * (3 * (5 * (7 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_36947 : Nat.Prime 36947 := by
  apply lucasNat 36947 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36947 - 1 = 2 * (7 * (7 * (13 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_37273 : Nat.Prime 37273 := by
  apply lucasNat 37273 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37273 - 1 = 2 * (2 * (2 * (3 * (1553)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1553] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_37423 : Nat.Prime 37423 := by
  apply lucasNat 37423 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37423 - 1 = 2 * (3 * (3 * (3 * (3 * (3 * (7 * (11))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_37441 : Nat.Prime 37441 := by
  apply lucasNat 37441 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37441 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (5 * (13))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_37871 : Nat.Prime 37871 := by
  apply lucasNat 37871 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 37871 - 1 = 2 * (5 * (7 * (541))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_541] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_38351 : Nat.Prime 38351 := by
  apply lucasNat 38351 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 38351 - 1 = 2 * (5 * (5 * (13 * (59)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_40037 : Nat.Prime 40037 := by
  apply lucasNat 40037 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 40037 - 1 = 2 * (2 * (10009)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_10009] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_41149 : Nat.Prime 41149 := by
  apply lucasNat 41149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41149 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (127)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_41177 : Nat.Prime 41177 := by
  apply lucasNat 41177 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41177 - 1 = 2 * (2 * (2 * (5147))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5147] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_41333 : Nat.Prime 41333 := by
  apply lucasNat 41333 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41333 - 1 = 2 * (2 * (10333)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_10333] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_41443 : Nat.Prime 41443 := by
  apply lucasNat 41443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41443 - 1 = 2 * (3 * (6907)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_6907] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_41603 : Nat.Prime 41603 := by
  apply lucasNat 41603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41603 - 1 = 2 * (11 * (31 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_41729 : Nat.Prime 41729 := by
  apply lucasNat 41729 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41729 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (163)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_41981 : Nat.Prime 41981 := by
  apply lucasNat 41981 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 41981 - 1 = 2 * (2 * (5 * (2099))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2099] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_42299 : Nat.Prime 42299 := by
  apply lucasNat 42299 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 42299 - 1 = 2 * (21149) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_21149] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_43003 : Nat.Prime 43003 := by
  apply lucasNat 43003 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43003 - 1 = 2 * (3 * (3 * (2389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_43313 : Nat.Prime 43313 := by
  apply lucasNat 43313 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43313 - 1 = 2 * (2 * (2 * (2 * (2707)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2707] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_44273 : Nat.Prime 44273 := by
  apply lucasNat 44273 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 44273 - 1 = 2 * (2 * (2 * (2 * (2767)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_44809 : Nat.Prime 44809 := by
  apply lucasNat 44809 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 44809 - 1 = 2 * (2 * (2 * (3 * (1867)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1867] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_44879 : Nat.Prime 44879 := by
  apply lucasNat 44879 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 44879 - 1 = 2 * (19 * (1181)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_1181] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_45599 : Nat.Prime 45599 := by
  apply lucasNat 45599 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 45599 - 1 = 2 * (7 * (3257)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3257] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_46073 : Nat.Prime 46073 := by
  apply lucasNat 46073 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 46073 - 1 = 2 * (2 * (2 * (13 * (443)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_443] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_46187 : Nat.Prime 46187 := by
  apply lucasNat 46187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 46187 - 1 = 2 * (7 * (3299)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3299] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_46573 : Nat.Prime 46573 := by
  apply lucasNat 46573 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 46573 - 1 = 2 * (2 * (3 * (3881))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3881] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_48121 : Nat.Prime 48121 := by
  apply lucasNat 48121 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 48121 - 1 = 2 * (2 * (2 * (3 * (5 * (401))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_401] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_48731 : Nat.Prime 48731 := by
  apply lucasNat 48731 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 48731 - 1 = 2 * (5 * (11 * (443))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_443] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_49433 : Nat.Prime 49433 := by
  apply lucasNat 49433 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49433 - 1 = 2 * (2 * (2 * (37 * (167)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_49451 : Nat.Prime 49451 := by
  apply lucasNat 49451 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49451 - 1 = 2 * (5 * (5 * (23 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_49481 : Nat.Prime 49481 := by
  apply lucasNat 49481 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49481 - 1 = 2 * (2 * (2 * (5 * (1237)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1237] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_49957 : Nat.Prime 49957 := by
  apply lucasNat 49957 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49957 - 1 = 2 * (2 * (3 * (23 * (181)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_51647 : Nat.Prime 51647 := by
  apply lucasNat 51647 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 51647 - 1 = 2 * (7 * (7 * (17 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_52999 : Nat.Prime 52999 := by
  apply lucasNat 52999 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 52999 - 1 = 2 * (3 * (11 * (11 * (73)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_53101 : Nat.Prime 53101 := by
  apply lucasNat 53101 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53101 - 1 = 2 * (2 * (3 * (3 * (5 * (5 * (59)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_53791 : Nat.Prime 53791 := by
  apply lucasNat 53791 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53791 - 1 = 2 * (3 * (5 * (11 * (163)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_53881 : Nat.Prime 53881 := by
  apply lucasNat 53881 31 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53881 - 1 = 2 * (2 * (2 * (3 * (5 * (449))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_53923 : Nat.Prime 53923 := by
  apply lucasNat 53923 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53923 - 1 = 2 * (3 * (11 * (19 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_54133 : Nat.Prime 54133 := by
  apply lucasNat 54133 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 54133 - 1 = 2 * (2 * (3 * (13 * (347)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_347] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_54167 : Nat.Prime 54167 := by
  apply lucasNat 54167 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 54167 - 1 = 2 * (7 * (53 * (73))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_56591 : Nat.Prime 56591 := by
  apply lucasNat 56591 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 56591 - 1 = 2 * (5 * (5659)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_5659] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_56893 : Nat.Prime 56893 := by
  apply lucasNat 56893 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 56893 - 1 = 2 * (2 * (3 * (11 * (431)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_431] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_57493 : Nat.Prime 57493 := by
  apply lucasNat 57493 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 57493 - 1 = 2 * (2 * (3 * (3 * (1597)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1597] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_58427 : Nat.Prime 58427 := by
  apply lucasNat 58427 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 58427 - 1 = 2 * (131 * (223)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_223] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_59107 : Nat.Prime 59107 := by
  apply lucasNat 59107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59107 - 1 = 2 * (3 * (9851)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_9851] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_59377 : Nat.Prime 59377 := by
  apply lucasNat 59377 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59377 - 1 = 2 * (2 * (2 * (2 * (3 * (1237))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1237] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_59441 : Nat.Prime 59441 := by
  apply lucasNat 59441 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59441 - 1 = 2 * (2 * (2 * (2 * (5 * (743))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_743] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_59999 : Nat.Prime 59999 := by
  apply lucasNat 59999 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59999 - 1 = 2 * (131 * (229)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_229] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_60343 : Nat.Prime 60343 := by
  apply lucasNat 60343 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 60343 - 1 = 2 * (3 * (89 * (113))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_62273 : Nat.Prime 62273 := by
  apply lucasNat 62273 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 62273 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (7 * (139))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_139] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_62819 : Nat.Prime 62819 := by
  apply lucasNat 62819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 62819 - 1 = 2 * (7 * (7 * (641))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_641] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_62989 : Nat.Prime 62989 := by
  apply lucasNat 62989 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 62989 - 1 = 2 * (2 * (3 * (29 * (181)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_63823 : Nat.Prime 63823 := by
  apply lucasNat 63823 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 63823 - 1 = 2 * (3 * (11 * (967))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_967] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_64489 : Nat.Prime 64489 := by
  apply lucasNat 64489 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 64489 - 1 = 2 * (2 * (2 * (3 * (2687)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2687] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_64919 : Nat.Prime 64919 := by
  apply lucasNat 64919 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 64919 - 1 = 2 * (7 * (4637)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_4637] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_65789 : Nat.Prime 65789 := by
  apply lucasNat 65789 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 65789 - 1 = 2 * (2 * (16447)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_16447] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_65899 : Nat.Prime 65899 := by
  apply lucasNat 65899 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 65899 - 1 = 2 * (3 * (3 * (7 * (523)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_523] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_67883 : Nat.Prime 67883 := by
  apply lucasNat 67883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 67883 - 1 = 2 * (33941) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_33941] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_70901 : Nat.Prime 70901 := by
  apply lucasNat 70901 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 70901 - 1 = 2 * (2 * (5 * (5 * (709)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_70979 : Nat.Prime 70979 := by
  apply lucasNat 70979 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 70979 - 1 = 2 * (23 * (1543)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_1543] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_72043 : Nat.Prime 72043 := by
  apply lucasNat 72043 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 72043 - 1 = 2 * (3 * (12007)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_12007] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_73883 : Nat.Prime 73883 := by
  apply lucasNat 73883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73883 - 1 = 2 * (17 * (41 * (53))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_73907 : Nat.Prime 73907 := by
  apply lucasNat 73907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73907 - 1 = 2 * (7 * (5279)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_5279] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_74201 : Nat.Prime 74201 := by
  apply lucasNat 74201 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 74201 - 1 = 2 * (2 * (2 * (5 * (5 * (7 * (53)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_74897 : Nat.Prime 74897 := by
  apply lucasNat 74897 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 74897 - 1 = 2 * (2 * (2 * (2 * (31 * (151))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_75079 : Nat.Prime 75079 := by
  apply lucasNat 75079 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 75079 - 1 = 2 * (3 * (3 * (43 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_75743 : Nat.Prime 75743 := by
  apply lucasNat 75743 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 75743 - 1 = 2 * (37871) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37871] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_81371 : Nat.Prime 81371 := by
  apply lucasNat 81371 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 81371 - 1 = 2 * (5 * (79 * (103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_83231 : Nat.Prime 83231 := by
  apply lucasNat 83231 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 83231 - 1 = 2 * (5 * (7 * (29 * (41)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_83459 : Nat.Prime 83459 := by
  apply lucasNat 83459 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 83459 - 1 = 2 * (41729) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41729] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_85091 : Nat.Prime 85091 := by
  apply lucasNat 85091 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 85091 - 1 = 2 * (5 * (67 * (127))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_127] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_86369 : Nat.Prime 86369 := by
  apply lucasNat 86369 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 86369 - 1 = 2 * (2 * (2 * (2 * (2 * (2699))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2699] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_86501 : Nat.Prime 86501 := by
  apply lucasNat 86501 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 86501 - 1 = 2 * (2 * (5 * (5 * (5 * (173))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_86627 : Nat.Prime 86627 := by
  apply lucasNat 86627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 86627 - 1 = 2 * (43313) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43313] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_86767 : Nat.Prime 86767 := by
  apply lucasNat 86767 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 86767 - 1 = 2 * (3 * (14461)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_14461] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_87211 : Nat.Prime 87211 := by
  apply lucasNat 87211 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 87211 - 1 = 2 * (3 * (3 * (3 * (5 * (17 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_88129 : Nat.Prime 88129 := by
  apply lucasNat 88129 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 88129 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (3 * (3 * (17)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_89759 : Nat.Prime 89759 := by
  apply lucasNat 89759 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 89759 - 1 = 2 * (44879) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_44879] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_90997 : Nat.Prime 90997 := by
  apply lucasNat 90997 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 90997 - 1 = 2 * (2 * (3 * (7583))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7583] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_92317 : Nat.Prime 92317 := by
  apply lucasNat 92317 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 92317 - 1 = 2 * (2 * (3 * (7 * (7 * (157))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_93083 : Nat.Prime 93083 := by
  apply lucasNat 93083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 93083 - 1 = 2 * (11 * (4231)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_4231] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_97381 : Nat.Prime 97381 := by
  apply lucasNat 97381 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 97381 - 1 = 2 * (2 * (3 * (3 * (5 * (541))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_541] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_102499 : Nat.Prime 102499 := by
  apply lucasNat 102499 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 102499 - 1 = 2 * (3 * (11 * (1553))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1553] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_103237 : Nat.Prime 103237 := by
  apply lucasNat 103237 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 103237 - 1 = 2 * (2 * (3 * (7 * (1229)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_103643 : Nat.Prime 103643 := by
  apply lucasNat 103643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 103643 - 1 = 2 * (7 * (11 * (673))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_673] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_107053 : Nat.Prime 107053 := by
  apply lucasNat 107053 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 107053 - 1 = 2 * (2 * (3 * (11 * (811)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_107351 : Nat.Prime 107351 := by
  apply lucasNat 107351 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 107351 - 1 = 2 * (5 * (5 * (19 * (113)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_108011 : Nat.Prime 108011 := by
  apply lucasNat 108011 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 108011 - 1 = 2 * (5 * (7 * (1543))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1543] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_108089 : Nat.Prime 108089 := by
  apply lucasNat 108089 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 108089 - 1 = 2 * (2 * (2 * (59 * (229)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_108131 : Nat.Prime 108131 := by
  apply lucasNat 108131 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 108131 - 1 = 2 * (5 * (11 * (983))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_983] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_108541 : Nat.Prime 108541 := by
  apply lucasNat 108541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 108541 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (5 * (67))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_108943 : Nat.Prime 108943 := by
  apply lucasNat 108943 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 108943 - 1 = 2 * (3 * (67 * (271))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_271] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_110527 : Nat.Prime 110527 := by
  apply lucasNat 110527 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 110527 - 1 = 2 * (3 * (13 * (13 * (109)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_114713 : Nat.Prime 114713 := by
  apply lucasNat 114713 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 114713 - 1 = 2 * (2 * (2 * (13 * (1103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_116819 : Nat.Prime 116819 := by
  apply lucasNat 116819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 116819 - 1 = 2 * (13 * (4493)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_4493] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_124087 : Nat.Prime 124087 := by
  apply lucasNat 124087 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 124087 - 1 = 2 * (3 * (20681)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_20681] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_125639 : Nat.Prime 125639 := by
  apply lucasNat 125639 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 125639 - 1 = 2 * (62819) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_62819] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_129347 : Nat.Prime 129347 := by
  apply lucasNat 129347 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 129347 - 1 = 2 * (7 * (9239)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_9239] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_131441 : Nat.Prime 131441 := by
  apply lucasNat 131441 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 131441 - 1 = 2 * (2 * (2 * (2 * (5 * (31 * (53)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_132469 : Nat.Prime 132469 := by
  apply lucasNat 132469 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 132469 - 1 = 2 * (2 * (3 * (7 * (19 * (83))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_136261 : Nat.Prime 136261 := by
  apply lucasNat 136261 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 136261 - 1 = 2 * (2 * (3 * (3 * (5 * (757))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_757] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_141803 : Nat.Prime 141803 := by
  apply lucasNat 141803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 141803 - 1 = 2 * (70901) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_70901] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_141959 : Nat.Prime 141959 := by
  apply lucasNat 141959 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 141959 - 1 = 2 * (70979) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_70979] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_142169 : Nat.Prime 142169 := by
  apply lucasNat 142169 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 142169 - 1 = 2 * (2 * (2 * (13 * (1367)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1367] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_143239 : Nat.Prime 143239 := by
  apply lucasNat 143239 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 143239 - 1 = 2 * (3 * (23873)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23873] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_145879 : Nat.Prime 145879 := by
  apply lucasNat 145879 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 145879 - 1 = 2 * (3 * (41 * (593))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_593] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_146681 : Nat.Prime 146681 := by
  apply lucasNat 146681 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 146681 - 1 = 2 * (2 * (2 * (5 * (19 * (193))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_193] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_149873 : Nat.Prime 149873 := by
  apply lucasNat 149873 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 149873 - 1 = 2 * (2 * (2 * (2 * (17 * (19 * (29)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_151637 : Nat.Prime 151637 := by
  apply lucasNat 151637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151637 - 1 = 2 * (2 * (167 * (227))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_227] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_152239 : Nat.Prime 152239 := by
  apply lucasNat 152239 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 152239 - 1 = 2 * (3 * (25373)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_25373] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_153151 : Nat.Prime 153151 := by
  apply lucasNat 153151 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 153151 - 1 = 2 * (3 * (5 * (5 * (1021)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1021] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_153641 : Nat.Prime 153641 := by
  apply lucasNat 153641 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 153641 - 1 = 2 * (2 * (2 * (5 * (23 * (167))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_166303 : Nat.Prime 166303 := by
  apply lucasNat 166303 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 166303 - 1 = 2 * (3 * (3 * (9239))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_9239] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_166931 : Nat.Prime 166931 := by
  apply lucasNat 166931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 166931 - 1 = 2 * (5 * (16693)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_16693] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_174649 : Nat.Prime 174649 := by
  apply lucasNat 174649 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 174649 - 1 = 2 * (2 * (2 * (3 * (19 * (383))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_176081 : Nat.Prime 176081 := by
  apply lucasNat 176081 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 176081 - 1 = 2 * (2 * (2 * (2 * (5 * (31 * (71)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_176507 : Nat.Prime 176507 := by
  apply lucasNat 176507 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 176507 - 1 = 2 * (11 * (71 * (113))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_179213 : Nat.Prime 179213 := by
  apply lucasNat 179213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 179213 - 1 = 2 * (2 * (11 * (4073))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_4073] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_185873 : Nat.Prime 185873 := by
  apply lucasNat 185873 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 185873 - 1 = 2 * (2 * (2 * (2 * (11617)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11617] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_187043 : Nat.Prime 187043 := by
  apply lucasNat 187043 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 187043 - 1 = 2 * (41 * (2281)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_2281] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_189961 : Nat.Prime 189961 := by
  apply lucasNat 189961 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 189961 - 1 = 2 * (2 * (2 * (3 * (5 * (1583))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_190243 : Nat.Prime 190243 := by
  apply lucasNat 190243 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 190243 - 1 = 2 * (3 * (3 * (3 * (13 * (271))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_271] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_190667 : Nat.Prime 190667 := by
  apply lucasNat 190667 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 190667 - 1 = 2 * (7 * (13619)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13619] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_191449 : Nat.Prime 191449 := by
  apply lucasNat 191449 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191449 - 1 = 2 * (2 * (2 * (3 * (3 * (2659))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2659] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_191911 : Nat.Prime 191911 := by
  apply lucasNat 191911 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191911 - 1 = 2 * (3 * (5 * (6397))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_6397] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_198841 : Nat.Prime 198841 := by
  apply lucasNat 198841 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 198841 - 1 = 2 * (2 * (2 * (3 * (5 * (1657))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1657] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_199321 : Nat.Prime 199321 := by
  apply lucasNat 199321 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199321 - 1 = 2 * (2 * (2 * (3 * (5 * (11 * (151)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_199637 : Nat.Prime 199637 := by
  apply lucasNat 199637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199637 - 1 = 2 * (2 * (29 * (1721))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_1721] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_210071 : Nat.Prime 210071 := by
  apply lucasNat 210071 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 210071 - 1 = 2 * (5 * (7 * (3001))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3001] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_211997 : Nat.Prime 211997 := by
  apply lucasNat 211997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 211997 - 1 = 2 * (2 * (52999)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_52999] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_216023 : Nat.Prime 216023 := by
  apply lucasNat 216023 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 216023 - 1 = 2 * (108011) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_108011] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_217111 : Nat.Prime 217111 := by
  apply lucasNat 217111 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 217111 - 1 = 2 * (3 * (5 * (7237))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7237] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_224891 : Nat.Prime 224891 := by
  apply lucasNat 224891 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 224891 - 1 = 2 * (5 * (43 * (523))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_523] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_228341 : Nat.Prime 228341 := by
  apply lucasNat 228341 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 228341 - 1 = 2 * (2 * (5 * (7 * (7 * (233))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_234547 : Nat.Prime 234547 := by
  apply lucasNat 234547 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 234547 - 1 = 2 * (3 * (13 * (31 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_235199 : Nat.Prime 235199 := by
  apply lucasNat 235199 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 235199 - 1 = 2 * (23 * (5113)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_5113] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_245963 : Nat.Prime 245963 := by
  apply lucasNat 245963 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 245963 - 1 = 2 * (23 * (5347)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_5347] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_245989 : Nat.Prime 245989 := by
  apply lucasNat 245989 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 245989 - 1 = 2 * (2 * (3 * (3 * (6833)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_6833] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_246271 : Nat.Prime 246271 := by
  apply lucasNat 246271 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 246271 - 1 = 2 * (3 * (5 * (8209))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_8209] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_250889 : Nat.Prime 250889 := by
  apply lucasNat 250889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 250889 - 1 = 2 * (2 * (2 * (11 * (2851)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_2851] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_252913 : Nat.Prime 252913 := by
  apply lucasNat 252913 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 252913 - 1 = 2 * (2 * (2 * (2 * (3 * (11 * (479)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_479] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_258733 : Nat.Prime 258733 := by
  apply lucasNat 258733 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 258733 - 1 = 2 * (2 * (3 * (3 * (7187)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7187] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_261251 : Nat.Prime 261251 := by
  apply lucasNat 261251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 261251 - 1 = 2 * (5 * (5 * (5 * (5 * (11 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_264949 : Nat.Prime 264949 := by
  apply lucasNat 264949 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 264949 - 1 = 2 * (2 * (3 * (22079))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_22079] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_265141 : Nat.Prime 265141 := by
  apply lucasNat 265141 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 265141 - 1 = 2 * (2 * (3 * (3 * (3 * (5 * (491)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_491] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_268637 : Nat.Prime 268637 := by
  apply lucasNat 268637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 268637 - 1 = 2 * (2 * (239 * (281))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_239, Nat.prime_dvd_prime_iff_eq hq prime_281] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_273269 : Nat.Prime 273269 := by
  apply lucasNat 273269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 273269 - 1 = 2 * (2 * (53 * (1289))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_1289] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_275941 : Nat.Prime 275941 := by
  apply lucasNat 275941 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 275941 - 1 = 2 * (2 * (3 * (3 * (3 * (5 * (7 * (73))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_280883 : Nat.Prime 280883 := by
  apply lucasNat 280883 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 280883 - 1 = 2 * (7 * (20063)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_20063] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_283607 : Nat.Prime 283607 := by
  apply lucasNat 283607 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 283607 - 1 = 2 * (141803) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_141803] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_283721 : Nat.Prime 283721 := by
  apply lucasNat 283721 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 283721 - 1 = 2 * (2 * (2 * (5 * (41 * (173))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_299447 : Nat.Prime 299447 := by
  apply lucasNat 299447 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 299447 - 1 = 2 * (7 * (73 * (293))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_293] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_305329 : Nat.Prime 305329 := by
  apply lucasNat 305329 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 305329 - 1 = 2 * (2 * (2 * (2 * (3 * (6361))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_6361] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_315527 : Nat.Prime 315527 := by
  apply lucasNat 315527 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 315527 - 1 = 2 * (79 * (1997)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_1997] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_324847 : Nat.Prime 324847 := by
  apply lucasNat 324847 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 324847 - 1 = 2 * (3 * (3 * (18047))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_18047] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_338293 : Nat.Prime 338293 := by
  apply lucasNat 338293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 338293 - 1 = 2 * (2 * (3 * (3 * (9397)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_9397] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_339389 : Nat.Prime 339389 := by
  apply lucasNat 339389 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 339389 - 1 = 2 * (2 * (7 * (17 * (23 * (31))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_341087 : Nat.Prime 341087 := by
  apply lucasNat 341087 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 341087 - 1 = 2 * (199 * (857)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_199, Nat.prime_dvd_prime_iff_eq hq prime_857] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_341521 : Nat.Prime 341521 := by
  apply lucasNat 341521 21 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 341521 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (1423)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1423] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_348043 : Nat.Prime 348043 := by
  apply lucasNat 348043 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 348043 - 1 = 2 * (3 * (19 * (43 * (71)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_358811 : Nat.Prime 358811 := by
  apply lucasNat 358811 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 358811 - 1 = 2 * (5 * (53 * (677))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_677] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_358877 : Nat.Prime 358877 := by
  apply lucasNat 358877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 358877 - 1 = 2 * (2 * (7 * (7 * (1831)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1831] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_358931 : Nat.Prime 358931 := by
  apply lucasNat 358931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 358931 - 1 = 2 * (5 * (11 * (13 * (251)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_359111 : Nat.Prime 359111 := by
  apply lucasNat 359111 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 359111 - 1 = 2 * (5 * (35911)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_35911] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_359171 : Nat.Prime 359171 := by
  apply lucasNat 359171 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 359171 - 1 = 2 * (5 * (7 * (7 * (733)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_733] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_364289 : Nat.Prime 364289 := by
  apply lucasNat 364289 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 364289 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (1423)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1423] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_369269 : Nat.Prime 369269 := by
  apply lucasNat 369269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 369269 - 1 = 2 * (2 * (92317)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_92317] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_372637 : Nat.Prime 372637 := by
  apply lucasNat 372637 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 372637 - 1 = 2 * (2 * (3 * (3 * (11 * (941))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_941] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_375467 : Nat.Prime 375467 := by
  apply lucasNat 375467 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 375467 - 1 = 2 * (7 * (13 * (2063))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_2063] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_380557 : Nat.Prime 380557 := by
  apply lucasNat 380557 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 380557 - 1 = 2 * (2 * (3 * (3 * (11 * (31 * (31)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_383839 : Nat.Prime 383839 := by
  apply lucasNat 383839 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 383839 - 1 = 2 * (3 * (7 * (13 * (19 * (37))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_389743 : Nat.Prime 389743 := by
  apply lucasNat 389743 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389743 - 1 = 2 * (3 * (17 * (3821))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_3821] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_389849 : Nat.Prime 389849 := by
  apply lucasNat 389849 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389849 - 1 = 2 * (2 * (2 * (48731))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_48731] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_390097 : Nat.Prime 390097 := by
  apply lucasNat 390097 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 390097 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (3 * (3 * (7 * (43))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_392593 : Nat.Prime 392593 := by
  apply lucasNat 392593 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 392593 - 1 = 2 * (2 * (2 * (2 * (3 * (8179))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_8179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_393853 : Nat.Prime 393853 := by
  apply lucasNat 393853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 393853 - 1 = 2 * (2 * (3 * (23 * (1427)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_1427] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_395849 : Nat.Prime 395849 := by
  apply lucasNat 395849 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 395849 - 1 = 2 * (2 * (2 * (49481))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_49481] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_400837 : Nat.Prime 400837 := by
  apply lucasNat 400837 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 400837 - 1 = 2 * (2 * (3 * (33403))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_33403] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_407299 : Nat.Prime 407299 := by
  apply lucasNat 407299 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 407299 - 1 = 2 * (3 * (67883)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67883] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_408461 : Nat.Prime 408461 := by
  apply lucasNat 408461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 408461 - 1 = 2 * (2 * (5 * (13 * (1571)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1571] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_429899 : Nat.Prime 429899 := by
  apply lucasNat 429899 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 429899 - 1 = 2 * (7 * (30707)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_30707] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_449567 : Nat.Prime 449567 := by
  apply lucasNat 449567 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 449567 - 1 = 2 * (13 * (17291)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17291] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_449699 : Nat.Prime 449699 := by
  apply lucasNat 449699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 449699 - 1 = 2 * (37 * (59 * (103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_456523 : Nat.Prime 456523 := by
  apply lucasNat 456523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 456523 - 1 = 2 * (3 * (11 * (6917))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_6917] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_456683 : Nat.Prime 456683 := by
  apply lucasNat 456683 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 456683 - 1 = 2 * (228341) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_228341] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_457679 : Nat.Prime 457679 := by
  apply lucasNat 457679 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 457679 - 1 = 2 * (13 * (29 * (607))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_607] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_474043 : Nat.Prime 474043 := by
  apply lucasNat 474043 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 474043 - 1 = 2 * (3 * (41 * (41 * (47)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_488143 : Nat.Prime 488143 := by
  apply lucasNat 488143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 488143 - 1 = 2 * (3 * (3 * (47 * (577)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_577] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_488227 : Nat.Prime 488227 := by
  apply lucasNat 488227 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 488227 - 1 = 2 * (3 * (81371)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_81371] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_495611 : Nat.Prime 495611 := by
  apply lucasNat 495611 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 495611 - 1 = 2 * (5 * (29 * (1709))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_1709] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_495701 : Nat.Prime 495701 := by
  apply lucasNat 495701 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 495701 - 1 = 2 * (2 * (5 * (5 * (4957)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_4957] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_501451 : Nat.Prime 501451 := by
  apply lucasNat 501451 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 501451 - 1 = 2 * (3 * (5 * (5 * (3343)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3343] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_525893 : Nat.Prime 525893 := by
  apply lucasNat 525893 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 525893 - 1 = 2 * (2 * (73 * (1801))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_1801] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_554977 : Nat.Prime 554977 := by
  apply lucasNat 554977 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 554977 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (41 * (47)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_576119 : Nat.Prime 576119 := by
  apply lucasNat 576119 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 576119 - 1 = 2 * (19 * (15161)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_15161] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_589159 : Nat.Prime 589159 := by
  apply lucasNat 589159 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 589159 - 1 = 2 * (3 * (3 * (71 * (461)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_619139 : Nat.Prime 619139 := by
  apply lucasNat 619139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 619139 - 1 = 2 * (13 * (23813)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23813] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_629987 : Nat.Prime 629987 := by
  apply lucasNat 629987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 629987 - 1 = 2 * (7 * (17 * (2647))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_2647] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_644107 : Nat.Prime 644107 := by
  apply lucasNat 644107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 644107 - 1 = 2 * (3 * (107351)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_107351] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_646573 : Nat.Prime 646573 := by
  apply lucasNat 646573 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 646573 - 1 = 2 * (2 * (3 * (53881))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53881] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_649277 : Nat.Prime 649277 := by
  apply lucasNat 649277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 649277 - 1 = 2 * (2 * (37 * (41 * (107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_656221 : Nat.Prime 656221 := by
  apply lucasNat 656221 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 656221 - 1 = 2 * (2 * (3 * (5 * (10937)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_10937] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_659689 : Nat.Prime 659689 := by
  apply lucasNat 659689 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 659689 - 1 = 2 * (2 * (2 * (3 * (27487)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_27487] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_662309 : Nat.Prime 662309 := by
  apply lucasNat 662309 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 662309 - 1 = 2 * (2 * (23 * (23 * (313)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_313] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_690953 : Nat.Prime 690953 := by
  apply lucasNat 690953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 690953 - 1 = 2 * (2 * (2 * (86369))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_86369] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_737251 : Nat.Prime 737251 := by
  apply lucasNat 737251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 737251 - 1 = 2 * (3 * (5 * (5 * (5 * (983))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_983] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_754297 : Nat.Prime 754297 := by
  apply lucasNat 754297 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 754297 - 1 = 2 * (2 * (2 * (3 * (53 * (593))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_593] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_768881 : Nat.Prime 768881 := by
  apply lucasNat 768881 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 768881 - 1 = 2 * (2 * (2 * (2 * (5 * (7 * (1373)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_782611 : Nat.Prime 782611 := by
  apply lucasNat 782611 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 782611 - 1 = 2 * (3 * (5 * (19 * (1373)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_1373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_791699 : Nat.Prime 791699 := by
  apply lucasNat 791699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 791699 - 1 = 2 * (395849) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_395849] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_794041 : Nat.Prime 794041 := by
  apply lucasNat 794041 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 794041 - 1 = 2 * (2 * (2 * (3 * (5 * (13 * (509)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_509] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_839353 : Nat.Prime 839353 := by
  apply lucasNat 839353 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 839353 - 1 = 2 * (2 * (2 * (3 * (41 * (853))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_853] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_859799 : Nat.Prime 859799 := by
  apply lucasNat 859799 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 859799 - 1 = 2 * (429899) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_429899] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_865049 : Nat.Prime 865049 := by
  apply lucasNat 865049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 865049 - 1 = 2 * (2 * (2 * (108131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_108131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_898153 : Nat.Prime 898153 := by
  apply lucasNat 898153 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 898153 - 1 = 2 * (2 * (2 * (3 * (37423)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37423] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_929647 : Nat.Prime 929647 := by
  apply lucasNat 929647 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 929647 - 1 = 2 * (3 * (3 * (51647))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_51647] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_941879 : Nat.Prime 941879 := by
  apply lucasNat 941879 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 941879 - 1 = 2 * (7 * (7 * (7 * (1373)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_976853 : Nat.Prime 976853 := by
  apply lucasNat 976853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 976853 - 1 = 2 * (2 * (103 * (2371))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_2371] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_987803 : Nat.Prime 987803 := by
  apply lucasNat 987803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 987803 - 1 = 2 * (17 * (17 * (1709))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_1709] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_991223 : Nat.Prime 991223 := by
  apply lucasNat 991223 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 991223 - 1 = 2 * (495611) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_495611] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1013921 : Nat.Prime 1013921 := by
  apply lucasNat 1013921 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1013921 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (6337)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_6337] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1014779 : Nat.Prime 1014779 := by
  apply lucasNat 1014779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1014779 - 1 = 2 * (89 * (5701)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_5701] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1022611 : Nat.Prime 1022611 := by
  apply lucasNat 1022611 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1022611 - 1 = 2 * (3 * (5 * (89 * (383)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1033189 : Nat.Prime 1033189 := by
  apply lucasNat 1033189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1033189 - 1 = 2 * (2 * (3 * (13 * (37 * (179))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1036681 : Nat.Prime 1036681 := by
  apply lucasNat 1036681 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1036681 - 1 = 2 * (2 * (2 * (3 * (5 * (53 * (163)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1105261 : Nat.Prime 1105261 := by
  apply lucasNat 1105261 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1105261 - 1 = 2 * (2 * (3 * (5 * (13 * (13 * (109)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1107773 : Nat.Prime 1107773 := by
  apply lucasNat 1107773 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1107773 - 1 = 2 * (2 * (23 * (12041))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_12041] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1111933 : Nat.Prime 1111933 := by
  apply lucasNat 1111933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1111933 - 1 = 2 * (2 * (3 * (3 * (67 * (461))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1137137 : Nat.Prime 1137137 := by
  apply lucasNat 1137137 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1137137 - 1 = 2 * (2 * (2 * (2 * (7 * (11 * (13 * (71))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1154561 : Nat.Prime 1154561 := by
  apply lucasNat 1154561 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1154561 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (11 * (41))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_1187111 : Nat.Prime 1187111 := by
  apply lucasNat 1187111 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1187111 - 1 = 2 * (5 * (17 * (6983))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_6983] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1193047 : Nat.Prime 1193047 := by
  apply lucasNat 1193047 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1193047 - 1 = 2 * (3 * (198841)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_198841] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1197037 : Nat.Prime 1197037 := by
  apply lucasNat 1197037 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1197037 - 1 = 2 * (2 * (3 * (3 * (41 * (811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1204421 : Nat.Prime 1204421 := by
  apply lucasNat 1204421 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1204421 - 1 = 2 * (2 * (5 * (7 * (7 * (1229))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1226783 : Nat.Prime 1226783 := by
  apply lucasNat 1226783 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1226783 - 1 = 2 * (167 * (3673)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_3673] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1249627 : Nat.Prime 1249627 := by
  apply lucasNat 1249627 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1249627 - 1 = 2 * (3 * (7 * (29753))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29753] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1285099 : Nat.Prime 1285099 := by
  apply lucasNat 1285099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1285099 - 1 = 2 * (3 * (17 * (43 * (293)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_293] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1342177 : Nat.Prime 1342177 := by
  apply lucasNat 1342177 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1342177 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (11 * (31 * (41)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1345541 : Nat.Prime 1345541 := by
  apply lucasNat 1345541 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1345541 - 1 = 2 * (2 * (5 * (7 * (7 * (1373))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1369429 : Nat.Prime 1369429 := by
  apply lucasNat 1369429 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1369429 - 1 = 2 * (2 * (3 * (139 * (821)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_821] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1370503 : Nat.Prime 1370503 := by
  apply lucasNat 1370503 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1370503 - 1 = 2 * (3 * (3 * (7 * (73 * (149))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_149] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1370599 : Nat.Prime 1370599 := by
  apply lucasNat 1370599 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1370599 - 1 = 2 * (3 * (29 * (7877))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_7877] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1381907 : Nat.Prime 1381907 := by
  apply lucasNat 1381907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1381907 - 1 = 2 * (690953) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_690953] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1450201 : Nat.Prime 1450201 := by
  apply lucasNat 1450201 31 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1450201 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (2417)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2417] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1450513 : Nat.Prime 1450513 := by
  apply lucasNat 1450513 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1450513 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (1439))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1439] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1451003 : Nat.Prime 1451003 := by
  apply lucasNat 1451003 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1451003 - 1 = 2 * (7 * (103643)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_103643] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1545041 : Nat.Prime 1545041 := by
  apply lucasNat 1545041 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1545041 - 1 = 2 * (2 * (2 * (2 * (5 * (7 * (31 * (89))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1577293 : Nat.Prime 1577293 := by
  apply lucasNat 1577293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1577293 - 1 = 2 * (2 * (3 * (131441))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_131441] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1579621 : Nat.Prime 1579621 := by
  apply lucasNat 1579621 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1579621 - 1 = 2 * (2 * (3 * (5 * (7 * (3761))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3761] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1616473 : Nat.Prime 1616473 := by
  apply lucasNat 1616473 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1616473 - 1 = 2 * (2 * (2 * (3 * (3 * (11 * (13 * (157))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1678771 : Nat.Prime 1678771 := by
  apply lucasNat 1678771 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1678771 - 1 = 2 * (3 * (3 * (5 * (23 * (811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1701643 : Nat.Prime 1701643 := by
  apply lucasNat 1701643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1701643 - 1 = 2 * (3 * (283607)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_283607] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1760233 : Nat.Prime 1760233 := by
  apply lucasNat 1760233 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1760233 - 1 = 2 * (2 * (2 * (3 * (71 * (1033))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_1033] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1869991 : Nat.Prime 1869991 := by
  apply lucasNat 1869991 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1869991 - 1 = 2 * (3 * (5 * (83 * (751)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1939493 : Nat.Prime 1939493 := by
  apply lucasNat 1939493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1939493 - 1 = 2 * (2 * (233 * (2081))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_233, Nat.prime_dvd_prime_iff_eq hq prime_2081] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1966561 : Nat.Prime 1966561 := by
  apply lucasNat 1966561 46 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1966561 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (5 * (17 * (241)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1988411 : Nat.Prime 1988411 := by
  apply lucasNat 1988411 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1988411 - 1 = 2 * (5 * (198841)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_198841] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1991177 : Nat.Prime 1991177 := by
  apply lucasNat 1991177 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1991177 - 1 = 2 * (2 * (2 * (11 * (11 * (11 * (11 * (17))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2021083 : Nat.Prime 2021083 := by
  apply lucasNat 2021083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2021083 - 1 = 2 * (3 * (7 * (48121))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_48121] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2034779 : Nat.Prime 2034779 := by
  apply lucasNat 2034779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2034779 - 1 = 2 * (31 * (37 * (887))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_887] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2048149 : Nat.Prime 2048149 := by
  apply lucasNat 2048149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2048149 - 1 = 2 * (2 * (3 * (3 * (56893)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_56893] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2121241 : Nat.Prime 2121241 := by
  apply lucasNat 2121241 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2121241 - 1 = 2 * (2 * (2 * (3 * (5 * (11 * (1607)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2154851 : Nat.Prime 2154851 := by
  apply lucasNat 2154851 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2154851 - 1 = 2 * (5 * (5 * (71 * (607)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2162623 : Nat.Prime 2162623 := by
  apply lucasNat 2162623 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2162623 - 1 = 2 * (3 * (7 * (11 * (31 * (151))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2175769 : Nat.Prime 2175769 := by
  apply lucasNat 2175769 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2175769 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (7 * (1439))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1439] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2219621 : Nat.Prime 2219621 := by
  apply lucasNat 2219621 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2219621 - 1 = 2 * (2 * (5 * (13 * (8537)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_8537] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2251031 : Nat.Prime 2251031 := by
  apply lucasNat 2251031 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2251031 - 1 = 2 * (5 * (163 * (1381))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_163, Nat.prime_dvd_prime_iff_eq hq prime_1381] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2297707 : Nat.Prime 2297707 := by
  apply lucasNat 2297707 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2297707 - 1 = 2 * (3 * (293 * (1307))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_293, Nat.prime_dvd_prime_iff_eq hq prime_1307] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2309123 : Nat.Prime 2309123 := by
  apply lucasNat 2309123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2309123 - 1 = 2 * (1154561) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1154561] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2328401 : Nat.Prime 2328401 := by
  apply lucasNat 2328401 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2328401 - 1 = 2 * (2 * (2 * (2 * (5 * (5 * (5821)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_5821] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2346977 : Nat.Prime 2346977 := by
  apply lucasNat 2346977 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2346977 - 1 = 2 * (2 * (2 * (2 * (2 * (71 * (1033)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_1033] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2408843 : Nat.Prime 2408843 := by
  apply lucasNat 2408843 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2408843 - 1 = 2 * (1204421) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1204421] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2452699 : Nat.Prime 2452699 := by
  apply lucasNat 2452699 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2452699 - 1 = 2 * (3 * (3 * (136261))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_136261] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2462711 : Nat.Prime 2462711 := by
  apply lucasNat 2462711 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2462711 - 1 = 2 * (5 * (246271)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_246271] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2465539 : Nat.Prime 2465539 := by
  apply lucasNat 2465539 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2465539 - 1 = 2 * (3 * (163 * (2521))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_163, Nat.prime_dvd_prime_iff_eq hq prime_2521] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2485513 : Nat.Prime 2485513 := by
  apply lucasNat 2485513 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2485513 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (37 * (311))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2499463 : Nat.Prime 2499463 := by
  apply lucasNat 2499463 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2499463 - 1 = 2 * (3 * (3 * (7 * (83 * (239))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2555809 : Nat.Prime 2555809 := by
  apply lucasNat 2555809 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2555809 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (79 * (337))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_337] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2669339 : Nat.Prime 2669339 := by
  apply lucasNat 2669339 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2669339 - 1 = 2 * (7 * (190667)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_190667] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2707909 : Nat.Prime 2707909 := by
  apply lucasNat 2707909 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2707909 - 1 = 2 * (2 * (3 * (7 * (32237)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_32237] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2850097 : Nat.Prime 2850097 := by
  apply lucasNat 2850097 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2850097 - 1 = 2 * (2 * (2 * (2 * (3 * (59377))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59377] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2859391 : Nat.Prime 2859391 := by
  apply lucasNat 2859391 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2859391 - 1 = 2 * (3 * (3 * (5 * (31771)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31771] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2876737 : Nat.Prime 2876737 := by
  apply lucasNat 2876737 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2876737 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (14983))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_14983] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2900951 : Nat.Prime 2900951 := by
  apply lucasNat 2900951 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2900951 - 1 = 2 * (5 * (5 * (13 * (4463)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_4463] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2907899 : Nat.Prime 2907899 := by
  apply lucasNat 2907899 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2907899 - 1 = 2 * (7 * (53 * (3919))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_3919] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2914319 : Nat.Prime 2914319 := by
  apply lucasNat 2914319 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2914319 - 1 = 2 * (11 * (132469)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_132469] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2999639 : Nat.Prime 2999639 := by
  apply lucasNat 2999639 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2999639 - 1 = 2 * (107 * (107 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_107, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3013987 : Nat.Prime 3013987 := by
  apply lucasNat 3013987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3013987 - 1 = 2 * (3 * (103 * (4877))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_4877] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3033169 : Nat.Prime 3033169 := by
  apply lucasNat 3033169 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3033169 - 1 = 2 * (2 * (2 * (2 * (3 * (29 * (2179)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_2179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3103549 : Nat.Prime 3103549 := by
  apply lucasNat 3103549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3103549 - 1 = 2 * (2 * (3 * (7 * (36947)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_36947] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3151259 : Nat.Prime 3151259 := by
  apply lucasNat 3151259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3151259 - 1 = 2 * (11 * (143239)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_143239] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3179389 : Nat.Prime 3179389 := by
  apply lucasNat 3179389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3179389 - 1 = 2 * (2 * (3 * (264949))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_264949] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3392549 : Nat.Prime 3392549 := by
  apply lucasNat 3392549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3392549 - 1 = 2 * (2 * (367 * (2311))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_367, Nat.prime_dvd_prime_iff_eq hq prime_2311] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3526247 : Nat.Prime 3526247 := by
  apply lucasNat 3526247 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3526247 - 1 = 2 * (41 * (43003)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_43003] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3579139 : Nat.Prime 3579139 := by
  apply lucasNat 3579139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3579139 - 1 = 2 * (3 * (3 * (198841))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_198841] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3865859 : Nat.Prime 3865859 := by
  apply lucasNat 3865859 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3865859 - 1 = 2 * (173 * (11173)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_11173] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3904517 : Nat.Prime 3904517 := by
  apply lucasNat 3904517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3904517 - 1 = 2 * (2 * (7 * (7 * (11 * (1811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3954851 : Nat.Prime 3954851 := by
  apply lucasNat 3954851 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3954851 - 1 = 2 * (5 * (5 * (19 * (23 * (181))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4021207 : Nat.Prime 4021207 := by
  apply lucasNat 4021207 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4021207 - 1 = 2 * (3 * (7 * (67 * (1429)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_1429] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_4129777 : Nat.Prime 4129777 := by
  apply lucasNat 4129777 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4129777 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (17 * (241)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_4186129 : Nat.Prime 4186129 := by
  apply lucasNat 4186129 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4186129 - 1 = 2 * (2 * (2 * (2 * (3 * (87211))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_87211] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4338353 : Nat.Prime 4338353 := by
  apply lucasNat 4338353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4338353 - 1 = 2 * (2 * (2 * (2 * (23 * (11789))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_11789] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4711963 : Nat.Prime 4711963 := by
  apply lucasNat 4711963 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4711963 - 1 = 2 * (3 * (19 * (41333))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_41333] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4756333 : Nat.Prime 4756333 := by
  apply lucasNat 4756333 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4756333 - 1 = 2 * (2 * (3 * (7 * (7 * (8089))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_8089] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4823821 : Nat.Prime 4823821 := by
  apply lucasNat 4823821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4823821 - 1 = 2 * (2 * (3 * (3 * (3 * (5 * (8933)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_8933] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_4999961 : Nat.Prime 4999961 := by
  apply lucasNat 4999961 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4999961 - 1 = 2 * (2 * (2 * (5 * (7 * (7 * (2551)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2551] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_5140397 : Nat.Prime 5140397 := by
  apply lucasNat 5140397 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5140397 - 1 = 2 * (2 * (1285099)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1285099] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5480197 : Nat.Prime 5480197 := by
  apply lucasNat 5480197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5480197 - 1 = 2 * (2 * (3 * (456683))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_456683] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5492287 : Nat.Prime 5492287 := by
  apply lucasNat 5492287 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5492287 - 1 = 2 * (3 * (3 * (3 * (3 * (3 * (3 * (3767))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_5621687 : Nat.Prime 5621687 := by
  apply lucasNat 5621687 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5621687 - 1 = 2 * (7 * (281 * (1429))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_1429] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5672833 : Nat.Prime 5672833 := by
  apply lucasNat 5672833 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5672833 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (11 * (17 * (79)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_5679407 : Nat.Prime 5679407 := by
  apply lucasNat 5679407 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5679407 - 1 = 2 * (241 * (11783)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_11783] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5833103 : Nat.Prime 5833103 := by
  apply lucasNat 5833103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5833103 - 1 = 2 * (11 * (265141)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_265141] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5948413 : Nat.Prime 5948413 := by
  apply lucasNat 5948413 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5948413 - 1 = 2 * (2 * (3 * (495701))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_495701] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_6071591 : Nat.Prime 6071591 := by
  apply lucasNat 6071591 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6071591 - 1 = 2 * (5 * (7 * (7 * (12391)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_12391] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6197647 : Nat.Prime 6197647 := by
  apply lucasNat 6197647 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6197647 - 1 = 2 * (3 * (7 * (13 * (11351)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_11351] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6318989 : Nat.Prime 6318989 := by
  apply lucasNat 6318989 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6318989 - 1 = 2 * (2 * (13 * (137 * (887)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_887] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6710887 : Nat.Prime 6710887 := by
  apply lucasNat 6710887 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6710887 - 1 = 2 * (3 * (3 * (7 * (13 * (17 * (241)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_6868201 : Nat.Prime 6868201 := by
  apply lucasNat 6868201 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6868201 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (11447)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11447] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_7122667 : Nat.Prime 7122667 := by
  apply lucasNat 7122667 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7122667 - 1 = 2 * (3 * (1187111)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1187111] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_7479727 : Nat.Prime 7479727 := by
  apply lucasNat 7479727 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7479727 - 1 = 2 * (3 * (73 * (17077))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_17077] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_7913669 : Nat.Prime 7913669 := by
  apply lucasNat 7913669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7913669 - 1 = 2 * (2 * (7 * (137 * (2063)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_2063] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8291443 : Nat.Prime 8291443 := by
  apply lucasNat 8291443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8291443 - 1 = 2 * (3 * (1381907)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1381907] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8365933 : Nat.Prime 8365933 := by
  apply lucasNat 8365933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8365933 - 1 = 2 * (2 * (3 * (3 * (281 * (827))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_827] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8521759 : Nat.Prime 8521759 := by
  apply lucasNat 8521759 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8521759 - 1 = 2 * (3 * (3 * (7 * (47 * (1439))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_1439] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8521763 : Nat.Prime 8521763 := by
  apply lucasNat 8521763 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8521763 - 1 = 2 * (523 * (8147)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_523, Nat.prime_dvd_prime_iff_eq hq prime_8147] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_9061111 : Nat.Prime 9061111 := by
  apply lucasNat 9061111 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9061111 - 1 = 2 * (3 * (3 * (5 * (83 * (1213))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_1213] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_9565627 : Nat.Prime 9565627 := by
  apply lucasNat 9565627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9565627 - 1 = 2 * (3 * (7 * (19 * (11987)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_11987] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_9673351 : Nat.Prime 9673351 := by
  apply lucasNat 9673351 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9673351 - 1 = 2 * (3 * (5 * (5 * (64489)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_64489] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_10009133 : Nat.Prime 10009133 := by
  apply lucasNat 10009133 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10009133 - 1 = 2 * (2 * (7 * (7 * (223 * (229))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_10223237 : Nat.Prime 10223237 := by
  apply lucasNat 10223237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10223237 - 1 = 2 * (2 * (2555809)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2555809] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_10239067 : Nat.Prime 10239067 := by
  apply lucasNat 10239067 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10239067 - 1 = 2 * (3 * (3 * (17 * (33461)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_33461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_11332367 : Nat.Prime 11332367 := by
  apply lucasNat 11332367 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11332367 - 1 = 2 * (59 * (137 * (701))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_701] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_11767033 : Nat.Prime 11767033 := by
  apply lucasNat 11767033 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11767033 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (3 * (3 * (6053)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_6053] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_12132677 : Nat.Prime 12132677 := by
  apply lucasNat 12132677 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12132677 - 1 = 2 * (2 * (3033169)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3033169] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_12167047 : Nat.Prime 12167047 := by
  apply lucasNat 12167047 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12167047 - 1 = 2 * (3 * (3 * (23 * (29389)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_29389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_12271333 : Nat.Prime 12271333 := by
  apply lucasNat 12271333 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12271333 - 1 = 2 * (2 * (3 * (1022611))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1022611] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_12558383 : Nat.Prime 12558383 := by
  apply lucasNat 12558383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12558383 - 1 = 2 * (41 * (153151)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_153151] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_12595213 : Nat.Prime 12595213 := by
  apply lucasNat 12595213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12595213 - 1 = 2 * (2 * (3 * (3 * (7 * (151 * (331)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_13203581 : Nat.Prime 13203581 := by
  apply lucasNat 13203581 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13203581 - 1 = 2 * (2 * (5 * (13 * (43 * (1181))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_1181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_13506187 : Nat.Prime 13506187 := by
  apply lucasNat 13506187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13506187 - 1 = 2 * (3 * (2251031)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2251031] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_13786243 : Nat.Prime 13786243 := by
  apply lucasNat 13786243 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13786243 - 1 = 2 * (3 * (2297707)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2297707] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_14128181 : Nat.Prime 14128181 := by
  apply lucasNat 14128181 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14128181 - 1 = 2 * (2 * (5 * (11 * (149 * (431))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_431] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_14759341 : Nat.Prime 14759341 := by
  apply lucasNat 14759341 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14759341 - 1 = 2 * (2 * (3 * (5 * (245989)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_245989] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_14810233 : Nat.Prime 14810233 := by
  apply lucasNat 14810233 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14810233 - 1 = 2 * (2 * (2 * (3 * (43 * (113 * (127)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_113, Nat.prime_dvd_prime_iff_eq hq prime_127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_15162899 : Nat.Prime 15162899 := by
  apply lucasNat 15162899 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15162899 - 1 = 2 * (2617 * (2897)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2617, Nat.prime_dvd_prime_iff_eq hq prime_2897] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_15167683 : Nat.Prime 15167683 := by
  apply lucasNat 15167683 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15167683 - 1 = 2 * (3 * (3 * (3 * (280883)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_280883] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_15378457 : Nat.Prime 15378457 := by
  apply lucasNat 15378457 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15378457 - 1 = 2 * (2 * (2 * (3 * (79 * (8111))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_8111] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_15618061 : Nat.Prime 15618061 := by
  apply lucasNat 15618061 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15618061 - 1 = 2 * (2 * (3 * (3 * (5 * (86767))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_86767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_15732481 : Nat.Prime 15732481 := by
  apply lucasNat 15732481 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15732481 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (17 * (241))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_16275793 : Nat.Prime 16275793 := by
  apply lucasNat 16275793 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16275793 - 1 = 2 * (2 * (2 * (2 * (3 * (13 * (26083)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_26083] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_16499641 : Nat.Prime 16499641 := by
  apply lucasNat 16499641 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16499641 - 1 = 2 * (2 * (2 * (3 * (5 * (359 * (383)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_359, Nat.prime_dvd_prime_iff_eq hq prime_383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_16909327 : Nat.Prime 16909327 := by
  apply lucasNat 16909327 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16909327 - 1 = 2 * (3 * (3 * (7 * (67 * (2003))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_2003] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_16976153 : Nat.Prime 16976153 := by
  apply lucasNat 16976153 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16976153 - 1 = 2 * (2 * (2 * (79 * (26861)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_26861] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_17452891 : Nat.Prime 17452891 := by
  apply lucasNat 17452891 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17452891 - 1 = 2 * (3 * (3 * (5 * (7 * (13 * (2131)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_2131] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_20602097 : Nat.Prime 20602097 := by
  apply lucasNat 20602097 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20602097 - 1 = 2 * (2 * (2 * (2 * (17 * (75743))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_75743] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_21582749 : Nat.Prime 21582749 := by
  apply lucasNat 21582749 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21582749 - 1 = 2 * (2 * (11 * (499 * (983)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_499, Nat.prime_dvd_prime_iff_eq hq prime_983] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_21691751 : Nat.Prime 21691751 := by
  apply lucasNat 21691751 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21691751 - 1 = 2 * (5 * (5 * (5 * (86767)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_86767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_21913109 : Nat.Prime 21913109 := by
  apply lucasNat 21913109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21913109 - 1 = 2 * (2 * (7 * (782611))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_782611] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_21942623 : Nat.Prime 21942623 := by
  apply lucasNat 21942623 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21942623 - 1 = 2 * (13 * (13 * (64919))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_64919] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_21983483 : Nat.Prime 21983483 := by
  apply lucasNat 21983483 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21983483 - 1 = 2 * (17 * (646573)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_646573] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_22253723 : Nat.Prime 22253723 := by
  apply lucasNat 22253723 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22253723 - 1 = 2 * (31 * (358931)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_358931] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_22605091 : Nat.Prime 22605091 := by
  apply lucasNat 22605091 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22605091 - 1 = 2 * (3 * (5 * (23 * (181 * (181))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_23216041 : Nat.Prime 23216041 := by
  apply lucasNat 23216041 33 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23216041 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (64489)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_64489] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_23860927 : Nat.Prime 23860927 := by
  apply lucasNat 23860927 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23860927 - 1 = 2 * (3 * (3 * (3 * (73 * (6053))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_6053] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_23860931 : Nat.Prime 23860931 := by
  apply lucasNat 23860931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23860931 - 1 = 2 * (5 * (37 * (64489))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_64489] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_26407163 : Nat.Prime 26407163 := by
  apply lucasNat 26407163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26407163 - 1 = 2 * (13203581) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13203581] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_26843549 : Nat.Prime 26843549 := by
  apply lucasNat 26843549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26843549 - 1 = 2 * (2 * (6710887)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_6710887] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_28633127 : Nat.Prime 28633127 := by
  apply lucasNat 28633127 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 28633127 - 1 = 2 * (3469 * (4127)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3469, Nat.prime_dvd_prime_iff_eq hq prime_4127] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_29826157 : Nat.Prime 29826157 := by
  apply lucasNat 29826157 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29826157 - 1 = 2 * (2 * (3 * (2485513))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2485513] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_30246257 : Nat.Prime 30246257 := by
  apply lucasNat 30246257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30246257 - 1 = 2 * (2 * (2 * (2 * (79 * (23929))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_23929] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_30703807 : Nat.Prime 30703807 := by
  apply lucasNat 30703807 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30703807 - 1 = 2 * (3 * (3 * (3 * (7 * (43 * (1889)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_1889] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_31665251 : Nat.Prime 31665251 := by
  apply lucasNat 31665251 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31665251 - 1 = 2 * (5 * (5 * (5 * (23 * (5507))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_5507] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_32292983 : Nat.Prime 32292983 := by
  apply lucasNat 32292983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32292983 - 1 = 2 * (1031 * (15661)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1031, Nat.prime_dvd_prime_iff_eq hq prime_15661] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_32469209 : Nat.Prime 32469209 := by
  apply lucasNat 32469209 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32469209 - 1 = 2 * (2 * (2 * (383 * (10597)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_383, Nat.prime_dvd_prime_iff_eq hq prime_10597] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_33539017 : Nat.Prime 33539017 := by
  apply lucasNat 33539017 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33539017 - 1 = 2 * (2 * (2 * (3 * (7 * (199637))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_199637] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_33818633 : Nat.Prime 33818633 := by
  apply lucasNat 33818633 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33818633 - 1 = 2 * (2 * (2 * (19 * (271 * (821))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_271, Nat.prime_dvd_prime_iff_eq hq prime_821] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_33818639 : Nat.Prime 33818639 := by
  apply lucasNat 33818639 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33818639 - 1 = 2 * (7 * (101 * (23917))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_101, Nat.prime_dvd_prime_iff_eq hq prime_23917] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_34973633 : Nat.Prime 34973633 := by
  apply lucasNat 34973633 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 34973633 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (367 * (1489))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_367, Nat.prime_dvd_prime_iff_eq hq prime_1489] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_35791403 : Nat.Prime 35791403 := by
  apply lucasNat 35791403 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 35791403 - 1 = 2 * (19 * (941879)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_941879] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_35791411 : Nat.Prime 35791411 := by
  apply lucasNat 35791411 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 35791411 - 1 = 2 * (3 * (5 * (1193047))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1193047] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_36709117 : Nat.Prime 36709117 := by
  apply lucasNat 36709117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36709117 - 1 = 2 * (2 * (3 * (599 * (5107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_599, Nat.prime_dvd_prime_iff_eq hq prime_5107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_42101993 : Nat.Prime 42101993 := by
  apply lucasNat 42101993 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 42101993 - 1 = 2 * (2 * (2 * (113 * (46573)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_113, Nat.prime_dvd_prime_iff_eq hq prime_46573] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_42949679 : Nat.Prime 42949679 := by
  apply lucasNat 42949679 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 42949679 - 1 = 2 * (83 * (258733)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_258733] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_44322227 : Nat.Prime 44322227 := by
  apply lucasNat 44322227 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 44322227 - 1 = 2 * (13 * (37 * (46073))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_46073] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_46568021 : Nat.Prime 46568021 := by
  apply lucasNat 46568021 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 46568021 - 1 = 2 * (2 * (5 * (2328401))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2328401] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_46667303 : Nat.Prime 46667303 := by
  apply lucasNat 46667303 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 46667303 - 1 = 2 * (11 * (2121241)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_2121241] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_49367447 : Nat.Prime 49367447 := by
  apply lucasNat 49367447 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49367447 - 1 = 2 * (107 * (349 * (661))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_107, Nat.prime_dvd_prime_iff_eq hq prime_349, Nat.prime_dvd_prime_iff_eq hq prime_661] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_49367449 : Nat.Prime 49367449 := by
  apply lucasNat 49367449 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49367449 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (13 * (17581))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17581] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_53254163 : Nat.Prime 53254163 := by
  apply lucasNat 53254163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53254163 - 1 = 2 * (13 * (41 * (49957))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_49957] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_57607987 : Nat.Prime 57607987 := by
  apply lucasNat 57607987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 57607987 - 1 = 2 * (3 * (167 * (57493))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_57493] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_58040089 : Nat.Prime 58040089 := by
  apply lucasNat 58040089 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 58040089 - 1 = 2 * (2 * (2 * (3 * (53 * (103 * (443)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_443] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_59652323 : Nat.Prime 59652323 := by
  apply lucasNat 59652323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59652323 - 1 = 2 * (4813 * (6197)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4813, Nat.prime_dvd_prime_iff_eq hq prime_6197] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_60899369 : Nat.Prime 60899369 := by
  apply lucasNat 60899369 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 60899369 - 1 = 2 * (2 * (2 * (103 * (73907)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_73907] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_67674169 : Nat.Prime 67674169 := by
  apply lucasNat 67674169 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 67674169 - 1 = 2 * (2 * (2 * (3 * (3 * (29 * (32411)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_32411] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_68134433 : Nat.Prime 68134433 := by
  apply lucasNat 68134433 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 68134433 - 1 = 2 * (2 * (2 * (2 * (2 * (211 * (10091)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_211, Nat.prime_dvd_prime_iff_eq hq prime_10091] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_68174081 : Nat.Prime 68174081 := by
  apply lucasNat 68174081 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 68174081 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (13 * (17 * (241))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_69928301 : Nat.Prime 69928301 := by
  apply lucasNat 69928301 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 69928301 - 1 = 2 * (2 * (5 * (5 * (13 * (53791))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_53791] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_70409309 : Nat.Prime 70409309 := by
  apply lucasNat 70409309 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 70409309 - 1 = 2 * (2 * (17 * (31 * (127 * (263))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_127, Nat.prime_dvd_prime_iff_eq hq prime_263] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_71582779 : Nat.Prime 71582779 := by
  apply lucasNat 71582779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 71582779 - 1 = 2 * (3 * (3 * (3 * (3 * (73 * (6053)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_6053] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_74051177 : Nat.Prime 74051177 := by
  apply lucasNat 74051177 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 74051177 - 1 = 2 * (2 * (2 * (53 * (174649)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_174649] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_75350287 : Nat.Prime 75350287 := by
  apply lucasNat 75350287 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 75350287 - 1 = 2 * (3 * (3 * (11 * (380557)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_380557] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_75350339 : Nat.Prime 75350339 := by
  apply lucasNat 75350339 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 75350339 - 1 = 2 * (7 * (7 * (768881))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_768881] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_75803993 : Nat.Prime 75803993 := by
  apply lucasNat 75803993 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 75803993 - 1 = 2 * (2 * (2 * (11 * (53 * (16253))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_16253] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_79106353 : Nat.Prime 79106353 := by
  apply lucasNat 79106353 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 79106353 - 1 = 2 * (2 * (2 * (2 * (3 * (13 * (331 * (383))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_331, Nat.prime_dvd_prime_iff_eq hq prime_383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_81927691 : Nat.Prime 81927691 := by
  apply lucasNat 81927691 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 81927691 - 1 = 2 * (3 * (5 * (13 * (210071)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_210071] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_84215069 : Nat.Prime 84215069 := by
  apply lucasNat 84215069 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 84215069 - 1 = 2 * (2 * (7 * (19 * (311 * (509))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_311, Nat.prime_dvd_prime_iff_eq hq prime_509] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_85548613 : Nat.Prime 85548613 := by
  apply lucasNat 85548613 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 85548613 - 1 = 2 * (2 * (3 * (547 * (13033)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_547, Nat.prime_dvd_prime_iff_eq hq prime_13033] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_89478503 : Nat.Prime 89478503 := by
  apply lucasNat 89478503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 89478503 - 1 = 2 * (131 * (341521)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_341521] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_91382299 : Nat.Prime 91382299 := by
  apply lucasNat 91382299 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 91382299 - 1 = 2 * (3 * (7 * (2175769))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2175769] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_91446517 : Nat.Prime 91446517 := by
  apply lucasNat 91446517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 91446517 - 1 = 2 * (2 * (3 * (3 * (3 * (7 * (73 * (1657))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_1657] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_92969819 : Nat.Prime 92969819 := by
  apply lucasNat 92969819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 92969819 - 1 = 2 * (23 * (2021083)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_2021083] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_94964029 : Nat.Prime 94964029 := by
  apply lucasNat 94964029 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 94964029 - 1 = 2 * (2 * (3 * (7913669))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7913669] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_95443759 : Nat.Prime 95443759 := by
  apply lucasNat 95443759 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 95443759 - 1 = 2 * (3 * (3 * (3 * (3 * (589159))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_589159] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_102261127 : Nat.Prime 102261127 := by
  apply lucasNat 102261127 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 102261127 - 1 = 2 * (3 * (11 * (31 * (151 * (331))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_110127349 : Nat.Prime 110127349 := by
  apply lucasNat 110127349 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 110127349 - 1 = 2 * (2 * (3 * (3 * (599 * (5107))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_599, Nat.prime_dvd_prime_iff_eq hq prime_5107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_110250781 : Nat.Prime 110250781 := by
  apply lucasNat 110250781 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 110250781 - 1 = 2 * (2 * (3 * (5 * (17 * (108089))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_108089] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_111176159 : Nat.Prime 111176159 := by
  apply lucasNat 111176159 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 111176159 - 1 = 2 * (17 * (23 * (142169))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_142169] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_121302799 : Nat.Prime 121302799 := by
  apply lucasNat 121302799 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 121302799 - 1 = 2 * (3 * (37 * (139 * (3931)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_3931] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_121798739 : Nat.Prime 121798739 := by
  apply lucasNat 121798739 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 121798739 - 1 = 2 * (60899369) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_60899369] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_122713363 : Nat.Prime 122713363 := by
  apply lucasNat 122713363 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 122713363 - 1 = 2 * (3 * (3 * (19 * (358811)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_358811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_124141961 : Nat.Prime 124141961 := by
  apply lucasNat 124141961 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 124141961 - 1 = 2 * (2 * (2 * (5 * (3103549)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3103549] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_125805991 : Nat.Prime 125805991 := by
  apply lucasNat 125805991 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 125805991 - 1 = 2 * (3 * (5 * (613 * (6841)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_613, Nat.prime_dvd_prime_iff_eq hq prime_6841] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_126156299 : Nat.Prime 126156299 := by
  apply lucasNat 126156299 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 126156299 - 1 = 2 * (31 * (2034779)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_2034779] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_126322541 : Nat.Prime 126322541 := by
  apply lucasNat 126322541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 126322541 - 1 = 2 * (2 * (5 * (59 * (107053)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_107053] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_134217779 : Nat.Prime 134217779 := by
  apply lucasNat 134217779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 134217779 - 1 = 2 * (1129 * (59441)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1129, Nat.prime_dvd_prime_iff_eq hq prime_59441] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_143165569 : Nat.Prime 143165569 := by
  apply lucasNat 143165569 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 143165569 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (7 * (13 * (17 * (241))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_143165647 : Nat.Prime 143165647 := by
  apply lucasNat 143165647 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 143165647 - 1 = 2 * (3 * (3 * (13 * (13 * (19 * (2477)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_2477] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_148024693 : Nat.Prime 148024693 := by
  apply lucasNat 148024693 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 148024693 - 1 = 2 * (2 * (3 * (3 * (3 * (1370599))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1370599] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_151607987 : Nat.Prime 151607987 := by
  apply lucasNat 151607987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151607987 - 1 = 2 * (75803993) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_75803993] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_158648591 : Nat.Prime 158648591 := by
  apply lucasNat 158648591 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 158648591 - 1 = 2 * (5 * (17 * (79 * (11813)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_11813] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_159072943 : Nat.Prime 159072943 := by
  apply lucasNat 159072943 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 159072943 - 1 = 2 * (3 * (7 * (433 * (8747)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_433, Nat.prime_dvd_prime_iff_eq hq prime_8747] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_162453257 : Nat.Prime 162453257 := by
  apply lucasNat 162453257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 162453257 - 1 = 2 * (2 * (2 * (7 * (2900951)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2900951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_165191053 : Nat.Prime 165191053 := by
  apply lucasNat 165191053 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 165191053 - 1 = 2 * (2 * (3 * (13 * (461 * (2297))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_461, Nat.prime_dvd_prime_iff_eq hq prime_2297] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_171798749 : Nat.Prime 171798749 := by
  apply lucasNat 171798749 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 171798749 - 1 = 2 * (2 * (11 * (3904517))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_3904517] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_171798761 : Nat.Prime 171798761 := by
  apply lucasNat 171798761 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 171798761 - 1 = 2 * (2 * (2 * (5 * (7 * (19 * (43 * (751))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_178957003 : Nat.Prime 178957003 := by
  apply lucasNat 178957003 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 178957003 - 1 = 2 * (3 * (7 * (523 * (8147)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_523, Nat.prime_dvd_prime_iff_eq hq prime_8147] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_178957007 : Nat.Prime 178957007 := by
  apply lucasNat 178957007 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 178957007 - 1 = 2 * (89478503) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_89478503] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_186737797 : Nat.Prime 186737797 := by
  apply lucasNat 186737797 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 186737797 - 1 = 2 * (2 * (3 * (3 * (7 * (73 * (10151)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_10151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_195225857 : Nat.Prime 195225857 := by
  apply lucasNat 195225857 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 195225857 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (7 * (108943))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_108943] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_204522229 : Nat.Prime 204522229 := by
  apply lucasNat 204522229 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 204522229 - 1 = 2 * (2 * (3 * (3 * (167 * (34019))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_34019] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_214548871 : Nat.Prime 214548871 := by
  apply lucasNat 214548871 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 214548871 - 1 = 2 * (3 * (5 * (1823 * (3923)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1823, Nat.prime_dvd_prime_iff_eq hq prime_3923] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_214748341 : Nat.Prime 214748341 := by
  apply lucasNat 214748341 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 214748341 - 1 = 2 * (2 * (3 * (5 * (3579139)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3579139] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_214748389 : Nat.Prime 214748389 := by
  apply lucasNat 214748389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 214748389 - 1 = 2 * (2 * (3 * (3 * (3 * (1988411))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1988411] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_217145179 : Nat.Prime 217145179 := by
  apply lucasNat 217145179 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 217145179 - 1 = 2 * (3 * (3 * (3 * (4021207)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_4021207] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_238609253 : Nat.Prime 238609253 := by
  apply lucasNat 238609253 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 238609253 - 1 = 2 * (2 * (7 * (8521759))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_8521759] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_268435463 : Nat.Prime 268435463 := by
  apply lucasNat 268435463 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 268435463 - 1 = 2 * (4057 * (33083)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4057, Nat.prime_dvd_prime_iff_eq hq prime_33083] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_272515183 : Nat.Prime 272515183 := by
  apply lucasNat 272515183 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 272515183 - 1 = 2 * (3 * (61 * (71 * (10487)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_10487] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_276624659 : Nat.Prime 276624659 := by
  apply lucasNat 276624659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 276624659 - 1 = 2 * (101 * (1369429)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_101, Nat.prime_dvd_prime_iff_eq hq prime_1369429] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_306783349 : Nat.Prime 306783349 := by
  apply lucasNat 306783349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 306783349 - 1 = 2 * (2 * (3 * (19 * (1345541)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_1345541] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_306783517 : Nat.Prime 306783517 := by
  apply lucasNat 306783517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 306783517 - 1 = 2 * (2 * (3 * (13 * (1966561)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1966561] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_330382121 : Nat.Prime 330382121 := by
  apply lucasNat 330382121 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 330382121 - 1 = 2 * (2 * (2 * (5 * (23 * (359111))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_359111] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_357913909 : Nat.Prime 357913909 := by
  apply lucasNat 357913909 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 357913909 - 1 = 2 * (2 * (3 * (3 * (11 * (607 * (1489)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_607, Nat.prime_dvd_prime_iff_eq hq prime_1489] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_357914083 : Nat.Prime 357914083 := by
  apply lucasNat 357914083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 357914083 - 1 = 2 * (3 * (79 * (103 * (7331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_7331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_357914093 : Nat.Prime 357914093 := by
  apply lucasNat 357914093 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 357914093 - 1 = 2 * (2 * (41 * (97 * (149 * (151))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_389423527 : Nat.Prime 389423527 := by
  apply lucasNat 389423527 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389423527 - 1 = 2 * (3 * (347 * (187043))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_347, Nat.prime_dvd_prime_iff_eq hq prime_187043] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_389630509 : Nat.Prime 389630509 := by
  apply lucasNat 389630509 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389630509 - 1 = 2 * (2 * (3 * (32469209))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_32469209] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_390451483 : Nat.Prime 390451483 := by
  apply lucasNat 390451483 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 390451483 - 1 = 2 * (3 * (3 * (3 * (19 * (380557))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_380557] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_390451741 : Nat.Prime 390451741 := by
  apply lucasNat 390451741 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 390451741 - 1 = 2 * (2 * (3 * (5 * (7 * (929647))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_929647] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_429496889 : Nat.Prime 429496889 := by
  apply lucasNat 429496889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 429496889 - 1 = 2 * (2 * (2 * (37 * (1451003)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_1451003] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_477218561 : Nat.Prime 477218561 := by
  apply lucasNat 477218561 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 477218561 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (7 * (13 * (17 * (241)))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  all_goals subst q; decide +kernel
theorem prime_477218659 : Nat.Prime 477218659 := by
  apply lucasNat 477218659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 477218659 - 1 = 2 * (3 * (7 * (1009 * (11261)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1009, Nat.prime_dvd_prime_iff_eq hq prime_11261] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_530787877 : Nat.Prime 530787877 := by
  apply lucasNat 530787877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 530787877 - 1 = 2 * (2 * (3 * (19 * (439 * (5303))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_439, Nat.prime_dvd_prime_iff_eq hq prime_5303] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_553376963 : Nat.Prime 553376963 := by
  apply lucasNat 553376963 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 553376963 - 1 = 2 * (17 * (16275793)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_16275793] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_613566827 : Nat.Prime 613566827 := by
  apply lucasNat 613566827 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 613566827 - 1 = 2 * (13469 * (22777)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13469, Nat.prime_dvd_prime_iff_eq hq prime_22777] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_617835629 : Nat.Prime 617835629 := by
  apply lucasNat 617835629 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 617835629 - 1 = 2 * (2 * (53 * (2914319))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_2914319] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_708973939 : Nat.Prime 708973939 := by
  apply lucasNat 708973939 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 708973939 - 1 = 2 * (3 * (3 * (3 * (43 * (305329))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_305329] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_715827821 : Nat.Prime 715827821 := by
  apply lucasNat 715827821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715827821 - 1 = 2 * (2 * (5 * (31 * (1154561)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_1154561] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_715828013 : Nat.Prime 715828013 := by
  apply lucasNat 715828013 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715828013 - 1 = 2 * (2 * (178957003)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_178957003] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_715828073 : Nat.Prime 715828073 := by
  apply lucasNat 715828073 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715828073 - 1 = 2 * (2 * (2 * (73 * (271 * (4523))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_271, Nat.prime_dvd_prime_iff_eq hq prime_4523] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_715828093 : Nat.Prime 715828093 := by
  apply lucasNat 715828093 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 715828093 - 1 = 2 * (2 * (3 * (7 * (8521763)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_8521763] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_858993349 : Nat.Prime 858993349 := by
  apply lucasNat 858993349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 858993349 - 1 = 2 * (2 * (3 * (71582779))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_71582779] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_935050807 : Nat.Prime 935050807 := by
  apply lucasNat 935050807 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 935050807 - 1 = 2 * (3 * (3 * (47 * (1105261)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_1105261] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1047173461 : Nat.Prime 1047173461 := by
  apply lucasNat 1047173461 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1047173461 - 1 = 2 * (2 * (3 * (5 * (17452891)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17452891] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1056084511 : Nat.Prime 1056084511 := by
  apply lucasNat 1056084511 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1056084511 - 1 = 2 * (3 * (5 * (13 * (2707909)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_2707909] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1073741939 : Nat.Prime 1073741939 := by
  apply lucasNat 1073741939 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1073741939 - 1 = 2 * (3049 * (176081)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3049, Nat.prime_dvd_prime_iff_eq hq prime_176081] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1073741987 : Nat.Prime 1073741987 := by
  apply lucasNat 1073741987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1073741987 - 1 = 2 * (337 * (353 * (4513))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_337, Nat.prime_dvd_prime_iff_eq hq prime_353, Nat.prime_dvd_prime_iff_eq hq prime_4513] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1073742077 : Nat.Prime 1073742077 := by
  apply lucasNat 1073742077 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1073742077 - 1 = 2 * (2 * (11 * (1163 * (20983)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1163, Nat.prime_dvd_prime_iff_eq hq prime_20983] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1112319149 : Nat.Prime 1112319149 := by
  apply lucasNat 1112319149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1112319149 - 1 = 2 * (2 * (2713 * (102499))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2713, Nat.prime_dvd_prime_iff_eq hq prime_102499] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1165475951 : Nat.Prime 1165475951 := by
  apply lucasNat 1165475951 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1165475951 - 1 = 2 * (5 * (5 * (37 * (629987)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_629987] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1387796897 : Nat.Prime 1387796897 := by
  apply lucasNat 1387796897 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1387796897 - 1 = 2 * (2 * (2 * (2 * (2 * (2281 * (19013)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2281, Nat.prime_dvd_prime_iff_eq hq prime_19013] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1431655517 : Nat.Prime 1431655517 := by
  apply lucasNat 1431655517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431655517 - 1 = 2 * (2 * (23 * (31 * (31 * (16193))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_16193] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1431655637 : Nat.Prime 1431655637 := by
  apply lucasNat 1431655637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431655637 - 1 = 2 * (2 * (357913909)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_357913909] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1431655651 : Nat.Prime 1431655651 := by
  apply lucasNat 1431655651 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431655651 - 1 = 2 * (3 * (3 * (5 * (5 * (59 * (53923)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_53923] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1431655661 : Nat.Prime 1431655661 := by
  apply lucasNat 1431655661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431655661 - 1 = 2 * (2 * (5 * (269 * (281 * (947))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_269, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_947] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1431655777 : Nat.Prime 1431655777 := by
  apply lucasNat 1431655777 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431655777 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (3 * (19 * (87211))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_87211] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_1431656027 : Nat.Prime 1431656027 := by
  apply lucasNat 1431656027 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431656027 - 1 = 2 * (715828013) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_715828013] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1431656333 : Nat.Prime 1431656333 := by
  apply lucasNat 1431656333 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431656333 - 1 = 2 * (2 * (357914083)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_357914083] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1431656351 : Nat.Prime 1431656351 := by
  apply lucasNat 1431656351 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431656351 - 1 = 2 * (5 * (5 * (28633127))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_28633127] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1431656453 : Nat.Prime 1431656453 := by
  apply lucasNat 1431656453 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431656453 - 1 = 2 * (2 * (353 * (1013921))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_353, Nat.prime_dvd_prime_iff_eq hq prime_1013921] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1431656497 : Nat.Prime 1431656497 := by
  apply lucasNat 1431656497 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1431656497 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (17 * (71 * (8237)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_8237] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1513875589 : Nat.Prime 1513875589 := by
  apply lucasNat 1513875589 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1513875589 - 1 = 2 * (2 * (3 * (126156299))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_126156299] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1543048151 : Nat.Prime 1543048151 := by
  apply lucasNat 1543048151 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1543048151 - 1 = 2 * (5 * (5 * (7 * (23 * (103 * (1861)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_1861] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1842085561 : Nat.Prime 1842085561 := by
  apply lucasNat 1842085561 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1842085561 - 1 = 2 * (2 * (2 * (3 * (5 * (7 * (137 * (16007))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_16007] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1845808781 : Nat.Prime 1845808781 := by
  apply lucasNat 1845808781 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1845808781 - 1 = 2 * (2 * (5 * (83 * (1111933)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_1111933] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1863074233 : Nat.Prime 1863074233 := by
  apply lucasNat 1863074233 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1863074233 - 1 = 2 * (2 * (2 * (3 * (3 * (53 * (488227)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_488227] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1946499839 : Nat.Prime 1946499839 := by
  apply lucasNat 1946499839 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1946499839 - 1 = 2 * (757 * (1117 * (1151))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_757, Nat.prime_dvd_prime_iff_eq hq prime_1117, Nat.prime_dvd_prime_iff_eq hq prime_1151] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2147484037 : Nat.Prime 2147484037 := by
  apply lucasNat 2147484037 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2147484037 - 1 = 2 * (2 * (3 * (178957003))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_178957003] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2491306889 : Nat.Prime 2491306889 := by
  apply lucasNat 2491306889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2491306889 - 1 = 2 * (2 * (2 * (7 * (17 * (709 * (3691)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_709, Nat.prime_dvd_prime_iff_eq hq prime_3691] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2933313973 : Nat.Prime 2933313973 := by
  apply lucasNat 2933313973 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2933313973 - 1 = 2 * (2 * (3 * (37 * (43 * (153641))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_153641] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3107295143 : Nat.Prime 3107295143 := by
  apply lucasNat 3107295143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3107295143 - 1 = 2 * (7 * (103 * (2154851))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_2154851] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3691617563 : Nat.Prime 3691617563 := by
  apply lucasNat 3691617563 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3691617563 - 1 = 2 * (1845808781) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1845808781] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_3897559649 : Nat.Prime 3897559649 := by
  apply lucasNat 3897559649 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3897559649 - 1 = 2 * (2 * (2 * (2 * (2 * (121798739))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_121798739] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4294966661 : Nat.Prime 4294966661 := by
  apply lucasNat 4294966661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294966661 - 1 = 2 * (2 * (5 * (37 * (67 * (86627))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_86627] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4294967291 : Nat.Prime 4294967291 := by
  apply lucasNat 4294967291 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294967291 - 1 = 2 * (5 * (19 * (22605091))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_22605091] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4294967681 : Nat.Prime 4294967681 := by
  apply lucasNat 4294967681 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294967681 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (6710887)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_6710887] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_4294967861 : Nat.Prime 4294967861 := by
  apply lucasNat 4294967861 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294967861 - 1 = 2 * (2 * (5 * (19 * (29 * (389743))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_389743] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4294968101 : Nat.Prime 4294968101 := by
  apply lucasNat 4294968101 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294968101 - 1 = 2 * (2 * (5 * (5 * (47 * (277 * (3299)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_277, Nat.prime_dvd_prime_iff_eq hq prime_3299] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_4294968239 : Nat.Prime 4294968239 := by
  apply lucasNat 4294968239 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294968239 - 1 = 2 * (11 * (101 * (173 * (11173)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_101, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_11173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_4294968329 : Nat.Prime 4294968329 := by
  apply lucasNat 4294968329 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294968329 - 1 = 2 * (2 * (2 * (7 * (97 * (761 * (1039)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_761, Nat.prime_dvd_prime_iff_eq hq prime_1039] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_4294968371 : Nat.Prime 4294968371 := by
  apply lucasNat 4294968371 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294968371 - 1 = 2 * (5 * (7 * (11 * (601 * (9281))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_601, Nat.prime_dvd_prime_iff_eq hq prime_9281] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4294968521 : Nat.Prime 4294968521 := by
  apply lucasNat 4294968521 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294968521 - 1 = 2 * (2 * (2 * (5 * (61 * (1760233))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_1760233] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4294968869 : Nat.Prime 4294968869 := by
  apply lucasNat 4294968869 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294968869 - 1 = 2 * (2 * (191 * (5621687))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_191, Nat.prime_dvd_prime_iff_eq hq prime_5621687] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4294968929 : Nat.Prime 4294968929 := by
  apply lucasNat 4294968929 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4294968929 - 1 = 2 * (2 * (2 * (2 * (2 * (134217779))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_134217779] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4454977027 : Nat.Prime 4454977027 := by
  apply lucasNat 4454977027 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4454977027 - 1 = 2 * (3 * (83 * (1907 * (4691)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_1907, Nat.prime_dvd_prime_iff_eq hq prime_4691] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_4518504059 : Nat.Prime 4518504059 := by
  apply lucasNat 4518504059 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4518504059 - 1 = 2 * (10657 * (211997)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_10657, Nat.prime_dvd_prime_iff_eq hq prime_211997] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5485697017 : Nat.Prime 5485697017 := by
  apply lucasNat 5485697017 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5485697017 - 1 = 2 * (2 * (2 * (3 * (5101 * (44809))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5101, Nat.prime_dvd_prime_iff_eq hq prime_44809] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_5908001453 : Nat.Prime 5908001453 := by
  apply lucasNat 5908001453 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5908001453 - 1 = 2 * (2 * (29 * (29 * (31 * (181 * (313)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_181, Nat.prime_dvd_prime_iff_eq hq prime_313] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_6510486119 : Nat.Prime 6510486119 := by
  apply lucasNat 6510486119 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6510486119 - 1 = 2 * (1913 * (1701643)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1913, Nat.prime_dvd_prime_iff_eq hq prime_1701643] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_7113701389 : Nat.Prime 7113701389 := by
  apply lucasNat 7113701389 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7113701389 - 1 = 2 * (2 * (3 * (43 * (13786243)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_13786243] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589932627 : Nat.Prime 8589932627 := by
  apply lucasNat 8589932627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932627 - 1 = 2 * (11 * (390451483)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_390451483] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589932707 : Nat.Prime 8589932707 := by
  apply lucasNat 8589932707 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932707 - 1 = 2 * (3 * (53 * (499 * (54133)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_499, Nat.prime_dvd_prime_iff_eq hq prime_54133] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589932713 : Nat.Prime 8589932713 := by
  apply lucasNat 8589932713 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932713 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (3 * (233 * (56893)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_233, Nat.prime_dvd_prime_iff_eq hq prime_56893] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589932719 : Nat.Prime 8589932719 := by
  apply lucasNat 8589932719 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932719 - 1 = 2 * (3 * (19 * (75350287))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_75350287] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589932723 : Nat.Prime 8589932723 := by
  apply lucasNat 8589932723 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932723 - 1 = 2 * (7 * (47 * (89 * (146681)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_146681] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589932731 : Nat.Prime 8589932731 := by
  apply lucasNat 8589932731 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932731 - 1 = 2 * (3 * (3 * (5 * (3709 * (25733))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3709, Nat.prime_dvd_prime_iff_eq hq prime_25733] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589932753 : Nat.Prime 8589932753 := by
  apply lucasNat 8589932753 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932753 - 1 = 2 * (2 * (2 * (2 * (113 * (181 * (26249)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_113, Nat.prime_dvd_prime_iff_eq hq prime_181, Nat.prime_dvd_prime_iff_eq hq prime_26249] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589932761 : Nat.Prime 8589932761 := by
  apply lucasNat 8589932761 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932761 - 1 = 2 * (2 * (2 * (3 * (5 * (5023 * (14251)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_5023, Nat.prime_dvd_prime_iff_eq hq prime_14251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589932777 : Nat.Prime 8589932777 := by
  apply lucasNat 8589932777 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932777 - 1 = 2 * (2 * (2 * (73 * (97 * (151637))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_151637] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589932783 : Nat.Prime 8589932783 := by
  apply lucasNat 8589932783 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932783 - 1 = 2 * (127 * (33818633)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_127, Nat.prime_dvd_prime_iff_eq hq prime_33818633] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589932789 : Nat.Prime 8589932789 := by
  apply lucasNat 8589932789 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932789 - 1 = 2 * (2 * (17 * (126322541))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_126322541] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589932801 : Nat.Prime 8589932801 := by
  apply lucasNat 8589932801 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932801 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (5 * (1342177)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1342177] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_8589932867 : Nat.Prime 8589932867 := by
  apply lucasNat 8589932867 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932867 - 1 = 2 * (23 * (479 * (389849))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_479, Nat.prime_dvd_prime_iff_eq hq prime_389849] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589932881 : Nat.Prime 8589932881 := by
  apply lucasNat 8589932881 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932881 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (137 * (261251))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_261251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589932891 : Nat.Prime 8589932891 := by
  apply lucasNat 8589932891 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932891 - 1 = 2 * (5 * (7 * (11 * (17 * (656221))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_656221] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589932899 : Nat.Prime 8589932899 := by
  apply lucasNat 8589932899 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932899 - 1 = 2 * (3 * (1259 * (1137137))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1259, Nat.prime_dvd_prime_iff_eq hq prime_1137137] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589932903 : Nat.Prime 8589932903 := by
  apply lucasNat 8589932903 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932903 - 1 = 2 * (1609 * (2669339)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1609, Nat.prime_dvd_prime_iff_eq hq prime_2669339] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589932999 : Nat.Prime 8589932999 := by
  apply lucasNat 8589932999 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589932999 - 1 = 2 * (859 * (4999961)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_859, Nat.prime_dvd_prime_iff_eq hq prime_4999961] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589933047 : Nat.Prime 8589933047 := by
  apply lucasNat 8589933047 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933047 - 1 = 2 * (449 * (9565627)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_449, Nat.prime_dvd_prime_iff_eq hq prime_9565627] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589933097 : Nat.Prime 8589933097 := by
  apply lucasNat 8589933097 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933097 - 1 = 2 * (2 * (2 * (3 * (23 * (31 * (31 * (16193))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_16193] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589933101 : Nat.Prime 8589933101 := by
  apply lucasNat 8589933101 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933101 - 1 = 2 * (2 * (5 * (5 * (7 * (12271333))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_12271333] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589933103 : Nat.Prime 8589933103 := by
  apply lucasNat 8589933103 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933103 - 1 = 2 * (3 * (1431655517)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431655517] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589933109 : Nat.Prime 8589933109 := by
  apply lucasNat 8589933109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933109 - 1 = 2 * (2 * (3 * (3 * (238609253)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_238609253] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933113 : Nat.Prime 8589933113 := by
  apply lucasNat 8589933113 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933113 - 1 = 2 * (2 * (2 * (14533 * (73883)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_14533, Nat.prime_dvd_prime_iff_eq hq prime_73883] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933173 : Nat.Prime 8589933173 := by
  apply lucasNat 8589933173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933173 - 1 = 2 * (2 * (37 * (58040089))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_58040089] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933217 : Nat.Prime 8589933217 := by
  apply lucasNat 8589933217 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933217 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (29826157))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29826157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589933223 : Nat.Prime 8589933223 := by
  apply lucasNat 8589933223 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933223 - 1 = 2 * (3 * (13 * (110127349))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_110127349] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933229 : Nat.Prime 8589933229 := by
  apply lucasNat 8589933229 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933229 - 1 = 2 * (2 * (3 * (79 * (9061111)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_9061111] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933241 : Nat.Prime 8589933241 := by
  apply lucasNat 8589933241 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933241 - 1 = 2 * (2 * (2 * (3 * (5 * (7 * (7 * (223 * (6551)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_6551] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589933271 : Nat.Prime 8589933271 := by
  apply lucasNat 8589933271 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933271 - 1 = 2 * (3 * (3 * (5 * (43 * (2219621))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_2219621] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589933311 : Nat.Prime 8589933311 := by
  apply lucasNat 8589933311 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933311 - 1 = 2 * (5 * (7 * (59 * (131 * (15877))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_15877] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589933323 : Nat.Prime 8589933323 := by
  apply lucasNat 8589933323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933323 - 1 = 2 * (4294966661) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294966661] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589933337 : Nat.Prime 8589933337 := by
  apply lucasNat 8589933337 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933337 - 1 = 2 * (2 * (2 * (3 * (2351 * (152239))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2351, Nat.prime_dvd_prime_iff_eq hq prime_152239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589933347 : Nat.Prime 8589933347 := by
  apply lucasNat 8589933347 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933347 - 1 = 2 * (4157 * (1033189)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4157, Nat.prime_dvd_prime_iff_eq hq prime_1033189] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589933353 : Nat.Prime 8589933353 := by
  apply lucasNat 8589933353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933353 - 1 = 2 * (2 * (2 * (7 * (11 * (13 * (13 * (109 * (757)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_757] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589933377 : Nat.Prime 8589933377 := by
  apply lucasNat 8589933377 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933377 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (151 * (373 * (2383)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_373, Nat.prime_dvd_prime_iff_eq hq prime_2383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589933379 : Nat.Prime 8589933379 := by
  apply lucasNat 8589933379 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933379 - 1 = 2 * (3 * (3 * (13 * (36709117)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_36709117] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933397 : Nat.Prime 8589933397 := by
  apply lucasNat 8589933397 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933397 - 1 = 2 * (2 * (3 * (3 * (11 * (21691751))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_21691751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589933419 : Nat.Prime 8589933419 := by
  apply lucasNat 8589933419 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933419 - 1 = 2 * (11 * (23 * (16976153))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_16976153] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933479 : Nat.Prime 8589933479 := by
  apply lucasNat 8589933479 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933479 - 1 = 2 * (7 * (19 * (32292983))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_32292983] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933491 : Nat.Prime 8589933491 := by
  apply lucasNat 8589933491 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933491 - 1 = 2 * (5 * (858993349)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_858993349] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589933551 : Nat.Prime 8589933551 := by
  apply lucasNat 8589933551 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933551 - 1 = 2 * (5 * (5 * (11 * (15618061)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_15618061] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933581 : Nat.Prime 8589933581 := by
  apply lucasNat 8589933581 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933581 - 1 = 2 * (2 * (5 * (71 * (811 * (7459))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_811, Nat.prime_dvd_prime_iff_eq hq prime_7459] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589933601 : Nat.Prime 8589933601 := by
  apply lucasNat 8589933601 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933601 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (5 * (5 * (3579139)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3579139] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589933619 : Nat.Prime 8589933619 := by
  apply lucasNat 8589933619 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933619 - 1 = 2 * (3 * (7 * (204522229))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_204522229] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933629 : Nat.Prime 8589933629 := by
  apply lucasNat 8589933629 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933629 - 1 = 2 * (2 * (197 * (2711 * (4021)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_197, Nat.prime_dvd_prime_iff_eq hq prime_2711, Nat.prime_dvd_prime_iff_eq hq prime_4021] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933631 : Nat.Prime 8589933631 := by
  apply lucasNat 8589933631 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933631 - 1 = 2 * (3 * (3 * (3 * (5 * (19 * (19 * (88129))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_88129] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589933637 : Nat.Prime 8589933637 := by
  apply lucasNat 8589933637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933637 - 1 = 2 * (2 * (3 * (1993 * (359171)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1993, Nat.prime_dvd_prime_iff_eq hq prime_359171] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933641 : Nat.Prime 8589933641 := by
  apply lucasNat 8589933641 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933641 - 1 = 2 * (2 * (2 * (5 * (214748341)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_214748341] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933647 : Nat.Prime 8589933647 := by
  apply lucasNat 8589933647 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933647 - 1 = 2 * (7 * (211 * (2907899))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_211, Nat.prime_dvd_prime_iff_eq hq prime_2907899] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933683 : Nat.Prime 8589933683 := by
  apply lucasNat 8589933683 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933683 - 1 = 2 * (11 * (10181 * (38351))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_10181, Nat.prime_dvd_prime_iff_eq hq prime_38351] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933721 : Nat.Prime 8589933721 := by
  apply lucasNat 8589933721 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933721 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (23860927)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23860927] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589933731 : Nat.Prime 8589933731 := by
  apply lucasNat 8589933731 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933731 - 1 = 2 * (5 * (7 * (7 * (3881 * (4517))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3881, Nat.prime_dvd_prime_iff_eq hq prime_4517] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589933733 : Nat.Prime 8589933733 := by
  apply lucasNat 8589933733 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933733 - 1 = 2 * (2 * (3 * (3739 * (191449)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3739, Nat.prime_dvd_prime_iff_eq hq prime_191449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933773 : Nat.Prime 8589933773 := by
  apply lucasNat 8589933773 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933773 - 1 = 2 * (2 * (7 * (306783349))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_306783349] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933787 : Nat.Prime 8589933787 := by
  apply lucasNat 8589933787 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933787 - 1 = 2 * (3 * (7 * (23 * (43 * (227 * (911)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_227, Nat.prime_dvd_prime_iff_eq hq prime_911] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589933823 : Nat.Prime 8589933823 := by
  apply lucasNat 8589933823 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933823 - 1 = 2 * (3 * (1431655637)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431655637] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589933827 : Nat.Prime 8589933827 := by
  apply lucasNat 8589933827 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933827 - 1 = 2 * (311 * (1009 * (13687))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_311, Nat.prime_dvd_prime_iff_eq hq prime_1009, Nat.prime_dvd_prime_iff_eq hq prime_13687] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933853 : Nat.Prime 8589933853 := by
  apply lucasNat 8589933853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933853 - 1 = 2 * (2 * (3 * (715827821))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715827821] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589933907 : Nat.Prime 8589933907 := by
  apply lucasNat 8589933907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933907 - 1 = 2 * (3 * (1431655651)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431655651] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589933917 : Nat.Prime 8589933917 := by
  apply lucasNat 8589933917 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933917 - 1 = 2 * (2 * (191 * (487 * (23087)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_191, Nat.prime_dvd_prime_iff_eq hq prime_487, Nat.prime_dvd_prime_iff_eq hq prime_23087] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933931 : Nat.Prime 8589933931 := by
  apply lucasNat 8589933931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933931 - 1 = 2 * (3 * (5 * (727 * (393853)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_727, Nat.prime_dvd_prime_iff_eq hq prime_393853] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933967 : Nat.Prime 8589933967 := by
  apply lucasNat 8589933967 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933967 - 1 = 2 * (3 * (1431655661)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431655661] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589933971 : Nat.Prime 8589933971 := by
  apply lucasNat 8589933971 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933971 - 1 = 2 * (5 * (23 * (907 * (41177)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_907, Nat.prime_dvd_prime_iff_eq hq prime_41177] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589933973 : Nat.Prime 8589933973 := by
  apply lucasNat 8589933973 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589933973 - 1 = 2 * (2 * (3 * (3 * (19 * (12558383))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_12558383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934007 : Nat.Prime 8589934007 := by
  apply lucasNat 8589934007 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934007 - 1 = 2 * (71 * (109 * (554977))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_554977] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589934027 : Nat.Prime 8589934027 := by
  apply lucasNat 8589934027 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934027 - 1 = 2 * (3 * (3 * (31 * (41 * (375467))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_375467] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934049 : Nat.Prime 8589934049 := by
  apply lucasNat 8589934049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934049 - 1 = 2 * (2 * (2 * (2 * (2 * (19 * (14128181)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_14128181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934069 : Nat.Prime 8589934069 := by
  apply lucasNat 8589934069 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934069 - 1 = 2 * (2 * (3 * (211 * (3392549)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_211, Nat.prime_dvd_prime_iff_eq hq prime_3392549] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934091 : Nat.Prime 8589934091 := by
  apply lucasNat 8589934091 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934091 - 1 = 2 * (5 * (73 * (11767033))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_11767033] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589934099 : Nat.Prime 8589934099 := by
  apply lucasNat 8589934099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934099 - 1 = 2 * (3 * (3 * (477218561))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_477218561] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589934103 : Nat.Prime 8589934103 := by
  apply lucasNat 8589934103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934103 - 1 = 2 * (199 * (21582749)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_199, Nat.prime_dvd_prime_iff_eq hq prime_21582749] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589934117 : Nat.Prime 8589934117 := by
  apply lucasNat 8589934117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934117 - 1 = 2 * (2 * (3 * (3 * (3 * (953 * (83459)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_953, Nat.prime_dvd_prime_iff_eq hq prime_83459] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934139 : Nat.Prime 8589934139 := by
  apply lucasNat 8589934139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934139 - 1 = 2 * (1783 * (2408843)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1783, Nat.prime_dvd_prime_iff_eq hq prime_2408843] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589934141 : Nat.Prime 8589934141 := by
  apply lucasNat 8589934141 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934141 - 1 = 2 * (2 * (3 * (5 * (143165569)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_143165569] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934151 : Nat.Prime 8589934151 := by
  apply lucasNat 8589934151 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934151 - 1 = 2 * (5 * (5 * (7 * (31 * (791699))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_791699] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934187 : Nat.Prime 8589934187 := by
  apply lucasNat 8589934187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934187 - 1 = 2 * (379 * (11332367)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_379, Nat.prime_dvd_prime_iff_eq hq prime_11332367] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589934201 : Nat.Prime 8589934201 := by
  apply lucasNat 8589934201 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934201 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (19 * (23 * (181 * (181))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_8589934207 : Nat.Prime 8589934207 := by
  apply lucasNat 8589934207 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934207 - 1 = 2 * (3 * (3 * (7 * (68174081)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_68174081] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934211 : Nat.Prime 8589934211 := by
  apply lucasNat 8589934211 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934211 - 1 = 2 * (5 * (11 * (13 * (653 * (9199))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_653, Nat.prime_dvd_prime_iff_eq hq prime_9199] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934237 : Nat.Prime 8589934237 := by
  apply lucasNat 8589934237 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934237 - 1 = 2 * (2 * (3 * (13 * (73 * (754297))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_754297] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934271 : Nat.Prime 8589934271 := by
  apply lucasNat 8589934271 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934271 - 1 = 2 * (5 * (29 * (229 * (129347)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_229, Nat.prime_dvd_prime_iff_eq hq prime_129347] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934289 : Nat.Prime 8589934289 := by
  apply lucasNat 8589934289 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934289 - 1 = 2 * (2 * (2 * (2 * (13 * (5641 * (7321)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_5641, Nat.prime_dvd_prime_iff_eq hq prime_7321] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934291 : Nat.Prime 8589934291 := by
  apply lucasNat 8589934291 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934291 - 1 = 2 * (3 * (5 * (7 * (71 * (576119))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_576119] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934307 : Nat.Prime 8589934307 := by
  apply lucasNat 8589934307 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934307 - 1 = 2 * (127 * (33818639)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_127, Nat.prime_dvd_prime_iff_eq hq prime_33818639] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589934487 : Nat.Prime 8589934487 := by
  apply lucasNat 8589934487 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934487 - 1 = 2 * (7 * (991 * (619139))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_991, Nat.prime_dvd_prime_iff_eq hq prime_619139] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589934513 : Nat.Prime 8589934513 := by
  apply lucasNat 8589934513 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934513 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (59652323)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59652323] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934543 : Nat.Prime 8589934543 := by
  apply lucasNat 8589934543 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934543 - 1 = 2 * (3 * (7 * (19 * (3121 * (3449))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_3121, Nat.prime_dvd_prime_iff_eq hq prime_3449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934567 : Nat.Prime 8589934567 := by
  apply lucasNat 8589934567 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934567 - 1 = 2 * (3 * (3 * (389 * (1226783)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_389, Nat.prime_dvd_prime_iff_eq hq prime_1226783] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934583 : Nat.Prime 8589934583 := by
  apply lucasNat 8589934583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934583 - 1 = 2 * (4294967291) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294967291] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589934609 : Nat.Prime 8589934609 := by
  apply lucasNat 8589934609 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934609 - 1 = 2 * (2 * (2 * (2 * (3 * (59 * (3033169)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_3033169] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934621 : Nat.Prime 8589934621 := by
  apply lucasNat 8589934621 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934621 - 1 = 2 * (2 * (3 * (3 * (5 * (131 * (364289)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_364289] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934627 : Nat.Prime 8589934627 := by
  apply lucasNat 8589934627 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934627 - 1 = 2 * (3 * (7 * (13 * (15732481)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_15732481] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934631 : Nat.Prime 8589934631 := by
  apply lucasNat 8589934631 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934631 - 1 = 2 * (5 * (26053 * (32971))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_26053, Nat.prime_dvd_prime_iff_eq hq prime_32971] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589934651 : Nat.Prime 8589934651 := by
  apply lucasNat 8589934651 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934651 - 1 = 2 * (3 * (5 * (5 * (11 * (79 * (65899)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_65899] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934663 : Nat.Prime 8589934663 := by
  apply lucasNat 8589934663 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934663 - 1 = 2 * (3 * (1431655777)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431655777] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589934669 : Nat.Prime 8589934669 := by
  apply lucasNat 8589934669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934669 - 1 = 2 * (2 * (3 * (7 * (102261127)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_102261127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934693 : Nat.Prime 8589934693 := by
  apply lucasNat 8589934693 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934693 - 1 = 2 * (2 * (3 * (3 * (17 * (457 * (30713)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_457, Nat.prime_dvd_prime_iff_eq hq prime_30713] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934711 : Nat.Prime 8589934711 := by
  apply lucasNat 8589934711 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934711 - 1 = 2 * (3 * (3 * (3 * (5 * (7 * (7 * (649277))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_649277] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589934721 : Nat.Prime 8589934721 := by
  apply lucasNat 8589934721 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934721 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (53 * (157 * (1613)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_1613] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_8589934741 : Nat.Prime 8589934741 := by
  apply lucasNat 8589934741 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934741 - 1 = 2 * (2 * (3 * (5 * (1319 * (108541))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1319, Nat.prime_dvd_prime_iff_eq hq prime_108541] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934757 : Nat.Prime 8589934757 := by
  apply lucasNat 8589934757 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934757 - 1 = 2 * (2 * (13 * (165191053))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_165191053] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589934807 : Nat.Prime 8589934807 := by
  apply lucasNat 8589934807 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934807 - 1 = 2 * (3 * (15733 * (90997))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_15733, Nat.prime_dvd_prime_iff_eq hq prime_90997] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589934817 : Nat.Prime 8589934817 := by
  apply lucasNat 8589934817 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934817 - 1 = 2 * (2 * (2 * (2 * (2 * (268435463))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_268435463] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934823 : Nat.Prime 8589934823 := by
  apply lucasNat 8589934823 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934823 - 1 = 2 * (7 * (3301 * (185873))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3301, Nat.prime_dvd_prime_iff_eq hq prime_185873] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589934831 : Nat.Prime 8589934831 := by
  apply lucasNat 8589934831 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934831 - 1 = 2 * (3 * (5 * (701 * (408461)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_701, Nat.prime_dvd_prime_iff_eq hq prime_408461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934841 : Nat.Prime 8589934841 := by
  apply lucasNat 8589934841 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934841 - 1 = 2 * (2 * (2 * (5 * (547 * (392593))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_547, Nat.prime_dvd_prime_iff_eq hq prime_392593] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589934889 : Nat.Prime 8589934889 := by
  apply lucasNat 8589934889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934889 - 1 = 2 * (2 * (2 * (1087 * (987803)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1087, Nat.prime_dvd_prime_iff_eq hq prime_987803] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934891 : Nat.Prime 8589934891 := by
  apply lucasNat 8589934891 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934891 - 1 = 2 * (3 * (3 * (5 * (23 * (487 * (8521)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_487, Nat.prime_dvd_prime_iff_eq hq prime_8521] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589934933 : Nat.Prime 8589934933 := by
  apply lucasNat 8589934933 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934933 - 1 = 2 * (2 * (3 * (53 * (13506187)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_13506187] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589934949 : Nat.Prime 8589934949 := by
  apply lucasNat 8589934949 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589934949 - 1 = 2 * (2 * (7 * (37 * (8291443)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_8291443] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589935009 : Nat.Prime 8589935009 := by
  apply lucasNat 8589935009 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935009 - 1 = 2 * (2 * (2 * (2 * (2 * (787 * (341087)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_787, Nat.prime_dvd_prime_iff_eq hq prime_341087] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589935077 : Nat.Prime 8589935077 := by
  apply lucasNat 8589935077 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935077 - 1 = 2 * (2 * (3 * (43 * (1433 * (11617))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_1433, Nat.prime_dvd_prime_iff_eq hq prime_11617] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935141 : Nat.Prime 8589935141 := by
  apply lucasNat 8589935141 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935141 - 1 = 2 * (2 * (5 * (29 * (14810233)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_14810233] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589935147 : Nat.Prime 8589935147 := by
  apply lucasNat 8589935147 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935147 - 1 = 2 * (13 * (330382121)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_330382121] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589935161 : Nat.Prime 8589935161 := by
  apply lucasNat 8589935161 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935161 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (23860931)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23860931] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589935171 : Nat.Prime 8589935171 := by
  apply lucasNat 8589935171 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935171 - 1 = 2 * (5 * (37 * (23216041))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_23216041] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935183 : Nat.Prime 8589935183 := by
  apply lucasNat 8589935183 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935183 - 1 = 2 * (353 * (12167047)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_353, Nat.prime_dvd_prime_iff_eq hq prime_12167047] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589935251 : Nat.Prime 8589935251 := by
  apply lucasNat 8589935251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935251 - 1 = 2 * (3 * (3 * (3 * (5 * (5 * (5 * (13 * (53 * (1847))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_1847] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_8589935267 : Nat.Prime 8589935267 := by
  apply lucasNat 8589935267 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935267 - 1 = 2 * (11 * (31 * (12595213))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_12595213] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935293 : Nat.Prime 8589935293 := by
  apply lucasNat 8589935293 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935293 - 1 = 2 * (2 * (3 * (797 * (898153)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_797, Nat.prime_dvd_prime_iff_eq hq prime_898153] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589935317 : Nat.Prime 8589935317 := by
  apply lucasNat 8589935317 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935317 - 1 = 2 * (2 * (3 * (59 * (12132677)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_12132677] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589935329 : Nat.Prime 8589935329 := by
  apply lucasNat 8589935329 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935329 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (13 * (31 * (239 * (929))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_239, Nat.prime_dvd_prime_iff_eq hq prime_929] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_8589935353 : Nat.Prime 8589935353 := by
  apply lucasNat 8589935353 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935353 - 1 = 2 * (2 * (2 * (3 * (11311 * (31643))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11311, Nat.prime_dvd_prime_iff_eq hq prime_31643] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935363 : Nat.Prime 8589935363 := by
  apply lucasNat 8589935363 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935363 - 1 = 2 * (4294967681) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294967681] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589935399 : Nat.Prime 8589935399 := by
  apply lucasNat 8589935399 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935399 - 1 = 2 * (11 * (2339 * (166931))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_2339, Nat.prime_dvd_prime_iff_eq hq prime_166931] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935407 : Nat.Prime 8589935407 := by
  apply lucasNat 8589935407 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935407 - 1 = 2 * (3 * (13 * (17 * (131 * (49451))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_49451] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935411 : Nat.Prime 8589935411 := by
  apply lucasNat 8589935411 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935411 - 1 = 2 * (5 * (7 * (122713363))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_122713363] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935441 : Nat.Prime 8589935441 := by
  apply lucasNat 8589935441 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935441 - 1 = 2 * (2 * (2 * (2 * (5 * (17 * (17 * (79 * (4703)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_4703] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589935479 : Nat.Prime 8589935479 := by
  apply lucasNat 8589935479 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935479 - 1 = 2 * (3 * (3877 * (369269))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3877, Nat.prime_dvd_prime_iff_eq hq prime_369269] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935513 : Nat.Prime 8589935513 := by
  apply lucasNat 8589935513 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935513 - 1 = 2 * (2 * (2 * (1073741939))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1073741939] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935539 : Nat.Prime 8589935539 := by
  apply lucasNat 8589935539 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935539 - 1 = 2 * (3 * (3 * (601 * (794041)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_601, Nat.prime_dvd_prime_iff_eq hq prime_794041] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589935561 : Nat.Prime 8589935561 := by
  apply lucasNat 8589935561 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935561 - 1 = 2 * (2 * (2 * (5 * (214748389)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_214748389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589935579 : Nat.Prime 8589935579 := by
  apply lucasNat 8589935579 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935579 - 1 = 2 * (7 * (613566827)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_613566827] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589935581 : Nat.Prime 8589935581 := by
  apply lucasNat 8589935581 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935581 - 1 = 2 * (2 * (3 * (5 * (23 * (167 * (37273)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_37273] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589935591 : Nat.Prime 8589935591 := by
  apply lucasNat 8589935591 37 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935591 - 1 = 2 * (5 * (2531 * (339389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2531, Nat.prime_dvd_prime_iff_eq hq prime_339389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935597 : Nat.Prime 8589935597 := by
  apply lucasNat 8589935597 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935597 - 1 = 2 * (2 * (11 * (7901 * (24709)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_7901, Nat.prime_dvd_prime_iff_eq hq prime_24709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589935647 : Nat.Prime 8589935647 := by
  apply lucasNat 8589935647 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935647 - 1 = 2 * (3 * (3 * (277 * (281 * (6131))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_277, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_6131] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935681 : Nat.Prime 8589935681 := by
  apply lucasNat 8589935681 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935681 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (5 * (26843549))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_26843549] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589935689 : Nat.Prime 8589935689 := by
  apply lucasNat 8589935689 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935689 - 1 = 2 * (2 * (2 * (3 * (37 * (9673351))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_9673351] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935699 : Nat.Prime 8589935699 := by
  apply lucasNat 8589935699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935699 - 1 = 2 * (61 * (70409309)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_70409309] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589935723 : Nat.Prime 8589935723 := by
  apply lucasNat 8589935723 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935723 - 1 = 2 * (4294967861) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294967861] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589935773 : Nat.Prime 8589935773 := by
  apply lucasNat 8589935773 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935773 - 1 = 2 * (2 * (3 * (3 * (11 * (179 * (179 * (677))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_179, Nat.prime_dvd_prime_iff_eq hq prime_677] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589935779 : Nat.Prime 8589935779 := by
  apply lucasNat 8589935779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935779 - 1 = 2 * (3 * (29 * (49367447))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_49367447] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935801 : Nat.Prime 8589935801 := by
  apply lucasNat 8589935801 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935801 - 1 = 2 * (2 * (2 * (5 * (5 * (42949679))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_42949679] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935821 : Nat.Prime 8589935821 := by
  apply lucasNat 8589935821 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935821 - 1 = 2 * (2 * (3 * (5 * (61 * (2346977))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_2346977] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935857 : Nat.Prime 8589935857 := by
  apply lucasNat 8589935857 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935857 - 1 = 2 * (2 * (2 * (2 * (3 * (23 * (23 * (338293))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_338293] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589935863 : Nat.Prime 8589935863 := by
  apply lucasNat 8589935863 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935863 - 1 = 2 * (3 * (3 * (477218659))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_477218659] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935897 : Nat.Prime 8589935897 := by
  apply lucasNat 8589935897 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935897 - 1 = 2 * (2 * (2 * (1073741987))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1073741987] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589935909 : Nat.Prime 8589935909 := by
  apply lucasNat 8589935909 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935909 - 1 = 2 * (2 * (103 * (331 * (62989)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_331, Nat.prime_dvd_prime_iff_eq hq prime_62989] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589935911 : Nat.Prime 8589935911 := by
  apply lucasNat 8589935911 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935911 - 1 = 2 * (3 * (5 * (19 * (37 * (407299))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_407299] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935941 : Nat.Prime 8589935941 := by
  apply lucasNat 8589935941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935941 - 1 = 2 * (2 * (3 * (5 * (367 * (390097))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_367, Nat.prime_dvd_prime_iff_eq hq prime_390097] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589935969 : Nat.Prime 8589935969 := by
  apply lucasNat 8589935969 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935969 - 1 = 2 * (2 * (2 * (2 * (2 * (109 * (2462711)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_2462711] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589935999 : Nat.Prime 8589935999 := by
  apply lucasNat 8589935999 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589935999 - 1 = 2 * (7 * (491 * (1249627))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_491, Nat.prime_dvd_prime_iff_eq hq prime_1249627] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589936007 : Nat.Prime 8589936007 := by
  apply lucasNat 8589936007 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936007 - 1 = 2 * (3 * (3 * (3 * (3593 * (44273))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3593, Nat.prime_dvd_prime_iff_eq hq prime_44273] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589936023 : Nat.Prime 8589936023 := by
  apply lucasNat 8589936023 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936023 - 1 = 2 * (43 * (163 * (643 * (953)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_163, Nat.prime_dvd_prime_iff_eq hq prime_643, Nat.prime_dvd_prime_iff_eq hq prime_953] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936049 : Nat.Prime 8589936049 := by
  apply lucasNat 8589936049 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936049 - 1 = 2 * (2 * (2 * (2 * (3 * (4349 * (41149)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_4349, Nat.prime_dvd_prime_iff_eq hq prime_41149] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589936101 : Nat.Prime 8589936101 := by
  apply lucasNat 8589936101 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936101 - 1 = 2 * (2 * (5 * (5 * (19 * (1013 * (4463)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_1013, Nat.prime_dvd_prime_iff_eq hq prime_4463] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589936107 : Nat.Prime 8589936107 := by
  apply lucasNat 8589936107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936107 - 1 = 2 * (47 * (91382299)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_91382299] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589936127 : Nat.Prime 8589936127 := by
  apply lucasNat 8589936127 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936127 - 1 = 2 * (3 * (29 * (49367449))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_49367449] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589936149 : Nat.Prime 8589936149 := by
  apply lucasNat 8589936149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936149 - 1 = 2 * (2 * (2147484037)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2147484037] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589936161 : Nat.Prime 8589936161 := by
  apply lucasNat 8589936161 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936161 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (13 * (4129777))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_4129777] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589936163 : Nat.Prime 8589936163 := by
  apply lucasNat 8589936163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936163 - 1 = 2 * (3 * (1431656027)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431656027] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589936197 : Nat.Prime 8589936197 := by
  apply lucasNat 8589936197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936197 - 1 = 2 * (2 * (31 * (2857 * (24247)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_2857, Nat.prime_dvd_prime_iff_eq hq prime_24247] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936203 : Nat.Prime 8589936203 := by
  apply lucasNat 8589936203 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936203 - 1 = 2 * (4294968101) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294968101] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589936209 : Nat.Prime 8589936209 := by
  apply lucasNat 8589936209 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936209 - 1 = 2 * (2 * (2 * (2 * (7 * (191 * (281 * (1429))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_191, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_1429] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589936253 : Nat.Prime 8589936253 := by
  apply lucasNat 8589936253 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936253 - 1 = 2 * (2 * (3 * (19 * (1481 * (25439))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_1481, Nat.prime_dvd_prime_iff_eq hq prime_25439] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589936259 : Nat.Prime 8589936259 := by
  apply lucasNat 8589936259 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936259 - 1 = 2 * (3 * (3 * (31 * (1777 * (8663))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_1777, Nat.prime_dvd_prime_iff_eq hq prime_8663] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589936263 : Nat.Prime 8589936263 := by
  apply lucasNat 8589936263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936263 - 1 = 2 * (8167 * (525893)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_8167, Nat.prime_dvd_prime_iff_eq hq prime_525893] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589936301 : Nat.Prime 8589936301 := by
  apply lucasNat 8589936301 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936301 - 1 = 2 * (2 * (3 * (5 * (5 * (11 * (29 * (89759))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_89759] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589936337 : Nat.Prime 8589936337 := by
  apply lucasNat 8589936337 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936337 - 1 = 2 * (2 * (2 * (2 * (3 * (178957007))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_178957007] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589936359 : Nat.Prime 8589936359 := by
  apply lucasNat 8589936359 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936359 - 1 = 2 * (17 * (29 * (2903 * (3001)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_2903, Nat.prime_dvd_prime_iff_eq hq prime_3001] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936361 : Nat.Prime 8589936361 := by
  apply lucasNat 8589936361 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936361 - 1 = 2 * (2 * (2 * (3 * (5 * (373 * (191911)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_373, Nat.prime_dvd_prime_iff_eq hq prime_191911] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589936367 : Nat.Prime 8589936367 := by
  apply lucasNat 8589936367 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936367 - 1 = 2 * (3 * (3 * (11 * (19 * (43 * (53101)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_53101] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589936373 : Nat.Prime 8589936373 := by
  apply lucasNat 8589936373 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936373 - 1 = 2 * (2 * (3 * (181 * (3954851)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_181, Nat.prime_dvd_prime_iff_eq hq prime_3954851] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936403 : Nat.Prime 8589936403 := by
  apply lucasNat 8589936403 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936403 - 1 = 2 * (3 * (3 * (67 * (7122667)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_7122667] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936451 : Nat.Prime 8589936451 := by
  apply lucasNat 8589936451 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936451 - 1 = 2 * (3 * (5 * (5 * (673 * (85091))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_673, Nat.prime_dvd_prime_iff_eq hq prime_85091] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589936463 : Nat.Prime 8589936463 := by
  apply lucasNat 8589936463 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936463 - 1 = 2 * (3 * (97 * (14759341))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_14759341] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589936479 : Nat.Prime 8589936479 := by
  apply lucasNat 8589936479 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936479 - 1 = 2 * (4294968239) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294968239] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589936533 : Nat.Prime 8589936533 := by
  apply lucasNat 8589936533 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936533 - 1 = 2 * (2 * (29 * (74051177))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_74051177] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589936571 : Nat.Prime 8589936571 := by
  apply lucasNat 8589936571 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936571 - 1 = 2 * (3 * (5 * (331 * (865049)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_331, Nat.prime_dvd_prime_iff_eq hq prime_865049] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936587 : Nat.Prime 8589936587 := by
  apply lucasNat 8589936587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936587 - 1 = 2 * (7 * (11 * (1877 * (29717)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1877, Nat.prime_dvd_prime_iff_eq hq prime_29717] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936617 : Nat.Prime 8589936617 := by
  apply lucasNat 8589936617 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936617 - 1 = 2 * (2 * (2 * (1073742077))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1073742077] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589936637 : Nat.Prime 8589936637 := by
  apply lucasNat 8589936637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936637 - 1 = 2 * (2 * (3 * (3 * (1061 * (224891))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1061, Nat.prime_dvd_prime_iff_eq hq prime_224891] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589936643 : Nat.Prime 8589936643 := by
  apply lucasNat 8589936643 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936643 - 1 = 2 * (3 * (7 * (683 * (299447)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_683, Nat.prime_dvd_prime_iff_eq hq prime_299447] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936659 : Nat.Prime 8589936659 := by
  apply lucasNat 8589936659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936659 - 1 = 2 * (4294968329) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294968329] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589936671 : Nat.Prime 8589936671 := by
  apply lucasNat 8589936671 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936671 - 1 = 2 * (5 * (7 * (7 * (19 * (47 * (67 * (293))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_293] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589936683 : Nat.Prime 8589936683 := by
  apply lucasNat 8589936683 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936683 - 1 = 2 * (1493 * (2876737)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1493, Nat.prime_dvd_prime_iff_eq hq prime_2876737] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589936709 : Nat.Prime 8589936709 := by
  apply lucasNat 8589936709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936709 - 1 = 2 * (2 * (3 * (3 * (3 * (19 * (4186129)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_4186129] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589936713 : Nat.Prime 8589936713 := by
  apply lucasNat 8589936713 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936713 - 1 = 2 * (2 * (2 * (7 * (571 * (268637))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_571, Nat.prime_dvd_prime_iff_eq hq prime_268637] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589936721 : Nat.Prime 8589936721 := by
  apply lucasNat 8589936721 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936721 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (35791403)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_35791403] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589936743 : Nat.Prime 8589936743 := by
  apply lucasNat 8589936743 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936743 - 1 = 2 * (4294968371) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294968371] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589936763 : Nat.Prime 8589936763 := by
  apply lucasNat 8589936763 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936763 - 1 = 2 * (3 * (3 * (3 * (3 * (3 * (3 * (3 * (3 * (3 * (11 * (83 * (239)))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  all_goals subst q; decide +kernel
theorem prime_8589936769 : Nat.Prime 8589936769 := by
  apply lucasNat 8589936769 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936769 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (7 * (7 * (456523)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_456523] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_8589936833 : Nat.Prime 8589936833 := by
  apply lucasNat 8589936833 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936833 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2237 * (59999))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2237, Nat.prime_dvd_prime_iff_eq hq prime_59999] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589936863 : Nat.Prime 8589936863 := by
  apply lucasNat 8589936863 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936863 - 1 = 2 * (13 * (79 * (1471 * (2843)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_1471, Nat.prime_dvd_prime_iff_eq hq prime_2843] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936869 : Nat.Prime 8589936869 := by
  apply lucasNat 8589936869 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936869 - 1 = 2 * (2 * (17 * (23 * (5492287)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_5492287] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936877 : Nat.Prime 8589936877 := by
  apply lucasNat 8589936877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936877 - 1 = 2 * (2 * (3 * (715828073))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715828073] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589936907 : Nat.Prime 8589936907 := by
  apply lucasNat 8589936907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936907 - 1 = 2 * (3 * (3 * (233 * (2048149)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_233, Nat.prime_dvd_prime_iff_eq hq prime_2048149] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936911 : Nat.Prime 8589936911 := by
  apply lucasNat 8589936911 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936911 - 1 = 2 * (5 * (2143 * (400837))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2143, Nat.prime_dvd_prime_iff_eq hq prime_400837] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589936931 : Nat.Prime 8589936931 := by
  apply lucasNat 8589936931 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936931 - 1 = 2 * (3 * (5 * (3823 * (74897)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3823, Nat.prime_dvd_prime_iff_eq hq prime_74897] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589936989 : Nat.Prime 8589936989 := by
  apply lucasNat 8589936989 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936989 - 1 = 2 * (2 * (71 * (30246257))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_30246257] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589936997 : Nat.Prime 8589936997 := by
  apply lucasNat 8589936997 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589936997 - 1 = 2 * (2 * (3 * (3 * (29 * (29 * (283721)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_283721] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589937039 : Nat.Prime 8589937039 := by
  apply lucasNat 8589937039 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937039 - 1 = 2 * (3 * (17 * (84215069))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_84215069] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589937043 : Nat.Prime 8589937043 := by
  apply lucasNat 8589937043 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937043 - 1 = 2 * (4294968521) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294968521] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589937079 : Nat.Prime 8589937079 := by
  apply lucasNat 8589937079 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937079 - 1 = 2 * (193 * (22253723)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_193, Nat.prime_dvd_prime_iff_eq hq prime_22253723] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589937117 : Nat.Prime 8589937117 := by
  apply lucasNat 8589937117 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937117 - 1 = 2 * (2 * (3 * (715828093))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_715828093] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589937133 : Nat.Prime 8589937133 := by
  apply lucasNat 8589937133 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937133 - 1 = 2 * (2 * (7 * (1213 * (252913)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1213, Nat.prime_dvd_prime_iff_eq hq prime_252913] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589937231 : Nat.Prime 8589937231 := by
  apply lucasNat 8589937231 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937231 - 1 = 2 * (3 * (3 * (5 * (7 * (503 * (27107)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_503, Nat.prime_dvd_prime_iff_eq hq prime_27107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589937241 : Nat.Prime 8589937241 := by
  apply lucasNat 8589937241 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937241 - 1 = 2 * (2 * (2 * (5 * (19 * (19 * (19 * (131 * (239)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589937243 : Nat.Prime 8589937243 := by
  apply lucasNat 8589937243 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937243 - 1 = 2 * (3 * (17 * (37 * (1321 * (1723))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_1321, Nat.prime_dvd_prime_iff_eq hq prime_1723] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589937253 : Nat.Prime 8589937253 := by
  apply lucasNat 8589937253 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937253 - 1 = 2 * (2 * (13 * (7243 * (22807)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_7243, Nat.prime_dvd_prime_iff_eq hq prime_22807] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589937303 : Nat.Prime 8589937303 := by
  apply lucasNat 8589937303 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937303 - 1 = 2 * (3 * (3 * (3 * (73 * (151 * (14431)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_14431] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589937309 : Nat.Prime 8589937309 := by
  apply lucasNat 8589937309 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937309 - 1 = 2 * (2 * (3 * (277 * (643 * (4019))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_277, Nat.prime_dvd_prime_iff_eq hq prime_643, Nat.prime_dvd_prime_iff_eq hq prime_4019] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589937387 : Nat.Prime 8589937387 := by
  apply lucasNat 8589937387 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937387 - 1 = 2 * (3 * (12953 * (110527))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_12953, Nat.prime_dvd_prime_iff_eq hq prime_110527] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589937399 : Nat.Prime 8589937399 := by
  apply lucasNat 8589937399 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937399 - 1 = 2 * (3 * (7 * (43 * (4756333)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_4756333] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589937451 : Nat.Prime 8589937451 := by
  apply lucasNat 8589937451 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937451 - 1 = 2 * (5 * (5 * (171798749))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_171798749] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589937513 : Nat.Prime 8589937513 := by
  apply lucasNat 8589937513 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937513 - 1 = 2 * (2 * (2 * (3 * (13 * (23 * (1197037)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_1197037] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589937523 : Nat.Prime 8589937523 := by
  apply lucasNat 8589937523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937523 - 1 = 2 * (2657 * (1616473)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2657, Nat.prime_dvd_prime_iff_eq hq prime_1616473] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589937561 : Nat.Prime 8589937561 := by
  apply lucasNat 8589937561 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937561 - 1 = 2 * (2 * (2 * (3 * (5 * (31 * (2309123)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_2309123] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589937571 : Nat.Prime 8589937571 := by
  apply lucasNat 8589937571 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937571 - 1 = 2 * (5 * (43 * (313 * (63823)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_313, Nat.prime_dvd_prime_iff_eq hq prime_63823] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589937579 : Nat.Prime 8589937579 := by
  apply lucasNat 8589937579 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937579 - 1 = 2 * (3 * (719 * (1991177))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_719, Nat.prime_dvd_prime_iff_eq hq prime_1991177] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589937583 : Nat.Prime 8589937583 := by
  apply lucasNat 8589937583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937583 - 1 = 2 * (17 * (19 * (53 * (250889)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_250889] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589937621 : Nat.Prime 8589937621 := by
  apply lucasNat 8589937621 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937621 - 1 = 2 * (2 * (3 * (5 * (11 * (11 * (19 * (62273))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_62273] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589937679 : Nat.Prime 8589937679 := by
  apply lucasNat 8589937679 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937679 - 1 = 2 * (7 * (389 * (1577293))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_389, Nat.prime_dvd_prime_iff_eq hq prime_1577293] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589937693 : Nat.Prime 8589937693 := by
  apply lucasNat 8589937693 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937693 - 1 = 2 * (2 * (3 * (7 * (29 * (3526247))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_3526247] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589937709 : Nat.Prime 8589937709 := by
  apply lucasNat 8589937709 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937709 - 1 = 2 * (2 * (11 * (195225857))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_195225857] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589937739 : Nat.Prime 8589937739 := by
  apply lucasNat 8589937739 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937739 - 1 = 2 * (4294968869) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294968869] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589937747 : Nat.Prime 8589937747 := by
  apply lucasNat 8589937747 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937747 - 1 = 2 * (3 * (13 * (13 * (31 * (273269))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_273269] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589937781 : Nat.Prime 8589937781 := by
  apply lucasNat 8589937781 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937781 - 1 = 2 * (2 * (5 * (429496889))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_429496889] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589937793 : Nat.Prime 8589937793 := by
  apply lucasNat 8589937793 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937793 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (1129 * (59441)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1129, Nat.prime_dvd_prime_iff_eq hq prime_59441] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589937801 : Nat.Prime 8589937801 := by
  apply lucasNat 8589937801 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937801 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (3469 * (4127))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3469, Nat.prime_dvd_prime_iff_eq hq prime_4127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589937817 : Nat.Prime 8589937817 := by
  apply lucasNat 8589937817 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937817 - 1 = 2 * (2 * (2 * (5387 * (199321)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5387, Nat.prime_dvd_prime_iff_eq hq prime_199321] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589937823 : Nat.Prime 8589937823 := by
  apply lucasNat 8589937823 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937823 - 1 = 2 * (41603 * (103237)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41603, Nat.prime_dvd_prime_iff_eq hq prime_103237] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589937859 : Nat.Prime 8589937859 := by
  apply lucasNat 8589937859 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937859 - 1 = 2 * (4294968929) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4294968929] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_8589937861 : Nat.Prime 8589937861 := by
  apply lucasNat 8589937861 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937861 - 1 = 2 * (2 * (3 * (3 * (5 * (7 * (157 * (173 * (251)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589937877 : Nat.Prime 8589937877 := by
  apply lucasNat 8589937877 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937877 - 1 = 2 * (2 * (13 * (67 * (2465539)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_2465539] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589937879 : Nat.Prime 8589937879 := by
  apply lucasNat 8589937879 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937879 - 1 = 2 * (3 * (3 * (2029 * (235199)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2029, Nat.prime_dvd_prime_iff_eq hq prime_235199] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589937969 : Nat.Prime 8589937969 := by
  apply lucasNat 8589937969 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937969 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (79 * (103 * (7331)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_7331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589937987 : Nat.Prime 8589937987 := by
  apply lucasNat 8589937987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937987 - 1 = 2 * (3 * (3 * (7 * (47 * (1450513))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_1450513] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589937999 : Nat.Prime 8589937999 := by
  apply lucasNat 8589937999 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589937999 - 1 = 2 * (3 * (1431656333)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431656333] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589938051 : Nat.Prime 8589938051 := by
  apply lucasNat 8589938051 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938051 - 1 = 2 * (5 * (5 * (171798761))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_171798761] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938101 : Nat.Prime 8589938101 := by
  apply lucasNat 8589938101 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938101 - 1 = 2 * (2 * (3 * (5 * (5 * (28633127))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_28633127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938107 : Nat.Prime 8589938107 := by
  apply lucasNat 8589938107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938107 - 1 = 2 * (3 * (1431656351)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431656351] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589938113 : Nat.Prime 8589938113 := by
  apply lucasNat 8589938113 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938113 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (3 * (7 * (53 * (13399))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_13399] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_8589938117 : Nat.Prime 8589938117 := by
  apply lucasNat 8589938117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938117 - 1 = 2 * (2 * (127 * (16909327))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_127, Nat.prime_dvd_prime_iff_eq hq prime_16909327] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938153 : Nat.Prime 8589938153 := by
  apply lucasNat 8589938153 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938153 - 1 = 2 * (2 * (2 * (19 * (859 * (65789))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_859, Nat.prime_dvd_prime_iff_eq hq prime_65789] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938183 : Nat.Prime 8589938183 := by
  apply lucasNat 8589938183 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938183 - 1 = 2 * (7 * (181 * (827 * (4099)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_181, Nat.prime_dvd_prime_iff_eq hq prime_827, Nat.prime_dvd_prime_iff_eq hq prime_4099] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589938233 : Nat.Prime 8589938233 := by
  apply lucasNat 8589938233 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938233 - 1 = 2 * (2 * (2 * (3 * (357914093)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_357914093] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589938267 : Nat.Prime 8589938267 := by
  apply lucasNat 8589938267 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938267 - 1 = 2 * (7 * (13 * (19 * (59 * (71 * (593)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_593] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589938303 : Nat.Prime 8589938303 := by
  apply lucasNat 8589938303 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938303 - 1 = 2 * (11 * (390451741)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_390451741] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589938311 : Nat.Prime 8589938311 := by
  apply lucasNat 8589938311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938311 - 1 = 2 * (3 * (3 * (5 * (95443759)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_95443759] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589938351 : Nat.Prime 8589938351 := by
  apply lucasNat 8589938351 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938351 - 1 = 2 * (5 * (5 * (7 * (613 * (40037))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_613, Nat.prime_dvd_prime_iff_eq hq prime_40037] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938353 : Nat.Prime 8589938353 := by
  apply lucasNat 8589938353 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938353 - 1 = 2 * (2 * (2 * (2 * (3 * (37 * (37 * (37 * (3533)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_3533] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_8589938431 : Nat.Prime 8589938431 := by
  apply lucasNat 8589938431 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938431 - 1 = 2 * (3 * (5 * (43 * (53 * (125639))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_125639] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938477 : Nat.Prime 8589938477 := by
  apply lucasNat 8589938477 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938477 - 1 = 2 * (2 * (7 * (306783517))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_306783517] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938519 : Nat.Prime 8589938519 := by
  apply lucasNat 8589938519 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938519 - 1 = 2 * (7 * (619 * (991223))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_619, Nat.prime_dvd_prime_iff_eq hq prime_991223] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938549 : Nat.Prime 8589938549 := by
  apply lucasNat 8589938549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938549 - 1 = 2 * (2 * (28603 * (75079))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_28603, Nat.prime_dvd_prime_iff_eq hq prime_75079] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938557 : Nat.Prime 8589938557 := by
  apply lucasNat 8589938557 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938557 - 1 = 2 * (2 * (3 * (331 * (2162623)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_331, Nat.prime_dvd_prime_iff_eq hq prime_2162623] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589938573 : Nat.Prime 8589938573 := by
  apply lucasNat 8589938573 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938573 - 1 = 2 * (2 * (9941 * (216023))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_9941, Nat.prime_dvd_prime_iff_eq hq prime_216023] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938587 : Nat.Prime 8589938587 := by
  apply lucasNat 8589938587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938587 - 1 = 2 * (3 * (103 * (167 * (83231)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_83231] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589938603 : Nat.Prime 8589938603 := by
  apply lucasNat 8589938603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938603 - 1 = 2 * (7 * (17 * (43 * (839353)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_839353] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589938641 : Nat.Prime 8589938641 := by
  apply lucasNat 8589938641 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938641 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (35791411)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_35791411] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589938647 : Nat.Prime 8589938647 := by
  apply lucasNat 8589938647 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938647 - 1 = 2 * (3 * (19 * (75350339))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_75350339] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938663 : Nat.Prime 8589938663 := by
  apply lucasNat 8589938663 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938663 - 1 = 2 * (23 * (186737797)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_186737797] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589938699 : Nat.Prime 8589938699 := by
  apply lucasNat 8589938699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938699 - 1 = 2 * (11 * (101 * (3865859))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_101, Nat.prime_dvd_prime_iff_eq hq prime_3865859] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938713 : Nat.Prime 8589938713 := by
  apply lucasNat 8589938713 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938713 - 1 = 2 * (2 * (2 * (3 * (353 * (1013921))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_353, Nat.prime_dvd_prime_iff_eq hq prime_1013921] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938719 : Nat.Prime 8589938719 := by
  apply lucasNat 8589938719 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938719 - 1 = 2 * (3 * (1431656453)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431656453] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589938729 : Nat.Prime 8589938729 := by
  apply lucasNat 8589938729 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938729 - 1 = 2 * (2 * (2 * (7 * (7 * (21913109))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_21913109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938743 : Nat.Prime 8589938743 := by
  apply lucasNat 8589938743 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938743 - 1 = 2 * (3 * (3 * (7 * (11 * (6197647))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_6197647] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938767 : Nat.Prime 8589938767 := by
  apply lucasNat 8589938767 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938767 - 1 = 2 * (3 * (1381 * (1036681))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1381, Nat.prime_dvd_prime_iff_eq hq prime_1036681] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_8589938803 : Nat.Prime 8589938803 := by
  apply lucasNat 8589938803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938803 - 1 = 2 * (3 * (109 * (157 * (269 * (311))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_269, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938821 : Nat.Prime 8589938821 := by
  apply lucasNat 8589938821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938821 - 1 = 2 * (2 * (3 * (5 * (143165647)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_143165647] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589938827 : Nat.Prime 8589938827 := by
  apply lucasNat 8589938827 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938827 - 1 = 2 * (3 * (7 * (7 * (3793 * (7703))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3793, Nat.prime_dvd_prime_iff_eq hq prime_7703] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589938867 : Nat.Prime 8589938867 := by
  apply lucasNat 8589938867 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938867 - 1 = 2 * (37441 * (114713)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37441, Nat.prime_dvd_prime_iff_eq hq prime_114713] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589938897 : Nat.Prime 8589938897 := by
  apply lucasNat 8589938897 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938897 - 1 = 2 * (2 * (2 * (2 * (7 * (11 * (1303 * (5351))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1303, Nat.prime_dvd_prime_iff_eq hq prime_5351] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_8589938923 : Nat.Prime 8589938923 := by
  apply lucasNat 8589938923 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938923 - 1 = 2 * (3 * (3 * (3 * (159072943)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_159072943] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8589938941 : Nat.Prime 8589938941 := by
  apply lucasNat 8589938941 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938941 - 1 = 2 * (2 * (3 * (3 * (5 * (11 * (4338353)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_4338353] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_8589938977 : Nat.Prime 8589938977 := by
  apply lucasNat 8589938977 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938977 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (3 * (17 * (71 * (8237)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_8237] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_8589938983 : Nat.Prime 8589938983 := by
  apply lucasNat 8589938983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589938983 - 1 = 2 * (3 * (1431656497)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1431656497] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8589939023 : Nat.Prime 8589939023 := by
  apply lucasNat 8589939023 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589939023 - 1 = 2 * (7 * (7 * (7 * (397 * (31541))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_397, Nat.prime_dvd_prime_iff_eq hq prime_31541] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589939037 : Nat.Prime 8589939037 := by
  apply lucasNat 8589939037 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589939037 - 1 = 2 * (2 * (3 * (7 * (701 * (145879))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_701, Nat.prime_dvd_prime_iff_eq hq prime_145879] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8589939091 : Nat.Prime 8589939091 := by
  apply lucasNat 8589939091 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8589939091 - 1 = 2 * (3 * (5 * (2017 * (141959)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2017, Nat.prime_dvd_prime_iff_eq hq prime_141959] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8593181671 : Nat.Prime 8593181671 := by
  apply lucasNat 8593181671 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8593181671 - 1 = 2 * (3 * (5 * (823 * (348043)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_823, Nat.prime_dvd_prime_iff_eq hq prime_348043] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8848003459 : Nat.Prime 8848003459 := by
  apply lucasNat 8848003459 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8848003459 - 1 = 2 * (3 * (7 * (1109 * (189961)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1109, Nat.prime_dvd_prime_iff_eq hq prime_189961] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_9350508071 : Nat.Prime 9350508071 := by
  apply lucasNat 9350508071 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9350508071 - 1 = 2 * (5 * (935050807)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_935050807] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_9388937323 : Nat.Prime 9388937323 := by
  apply lucasNat 9388937323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9388937323 - 1 = 2 * (3 * (3 * (173 * (829 * (3637))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_829, Nat.prime_dvd_prime_iff_eq hq prime_3637] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_9890938723 : Nat.Prime 9890938723 := by
  apply lucasNat 9890938723 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9890938723 - 1 = 2 * (3 * (7 * (23 * (10239067)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_10239067] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_10909654253 : Nat.Prime 10909654253 := by
  apply lucasNat 10909654253 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10909654253 - 1 = 2 * (2 * (7 * (389630509))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_389630509] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_10988274623 : Nat.Prime 10988274623 := by
  apply lucasNat 10988274623 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10988274623 - 1 = 2 * (13 * (1301 * (324847))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1301, Nat.prime_dvd_prime_iff_eq hq prime_324847] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_12139421219 : Nat.Prime 12139421219 := by
  apply lucasNat 12139421219 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12139421219 - 1 = 2 * (59 * (137 * (151 * (4973)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_4973] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_12355406267 : Nat.Prime 12355406267 := by
  apply lucasNat 12355406267 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12355406267 - 1 = 2 * (7 * (2797 * (315527))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2797, Nat.prime_dvd_prime_iff_eq hq prime_315527] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_13297068467 : Nat.Prime 13297068467 := by
  apply lucasNat 13297068467 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13297068467 - 1 = 2 * (11 * (17 * (2017 * (17627)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_2017, Nat.prime_dvd_prime_iff_eq hq prime_17627] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_13397325173 : Nat.Prime 13397325173 := by
  apply lucasNat 13397325173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13397325173 - 1 = 2 * (2 * (7 * (11 * (59 * (737251))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_737251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_15123316997 : Nat.Prime 15123316997 := by
  apply lucasNat 15123316997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15123316997 - 1 = 2 * (2 * (3413 * (1107773))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3413, Nat.prime_dvd_prime_iff_eq hq prime_1107773] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_15685854823 : Nat.Prime 15685854823 := by
  apply lucasNat 15685854823 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15685854823 - 1 = 2 * (3 * (3 * (3 * (11 * (26407163))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_26407163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_16670247389 : Nat.Prime 16670247389 := by
  apply lucasNat 16670247389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16670247389 - 1 = 2 * (2 * (271 * (15378457))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_271, Nat.prime_dvd_prime_iff_eq hq prime_15378457] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_16884866371 : Nat.Prime 16884866371 := by
  apply lucasNat 16884866371 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16884866371 - 1 = 2 * (3 * (5 * (1153 * (488143)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1153, Nat.prime_dvd_prime_iff_eq hq prime_488143] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_17819908109 : Nat.Prime 17819908109 := by
  apply lucasNat 17819908109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17819908109 - 1 = 2 * (2 * (4454977027)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4454977027] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_23476629331 : Nat.Prime 23476629331 := by
  apply lucasNat 23476629331 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23476629331 - 1 = 2 * (3 * (3 * (3 * (3 * (5 * (7 * (11 * (11 * (19 * (1801)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_1801] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_26444456993 : Nat.Prime 26444456993 := by
  apply lucasNat 26444456993 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26444456993 - 1 = 2 * (2 * (2 * (2 * (2 * (1283 * (644107)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1283, Nat.prime_dvd_prime_iff_eq hq prime_644107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_28532019251 : Nat.Prime 28532019251 := by
  apply lucasNat 28532019251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 28532019251 - 1 = 2 * (5 * (5 * (5 * (7 * (353 * (46187)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_353, Nat.prime_dvd_prime_iff_eq hq prime_46187] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_31075696331 : Nat.Prime 31075696331 := by
  apply lucasNat 31075696331 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 31075696331 - 1 = 2 * (5 * (7 * (181 * (2452699)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_181, Nat.prime_dvd_prime_iff_eq hq prime_2452699] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_35108170633 : Nat.Prime 35108170633 := by
  apply lucasNat 35108170633 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 35108170633 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (199 * (409 * (1997)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_199, Nat.prime_dvd_prime_iff_eq hq prime_409, Nat.prime_dvd_prime_iff_eq hq prime_1997] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_45237520379 : Nat.Prime 45237520379 := by
  apply lucasNat 45237520379 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 45237520379 - 1 = 2 * (83 * (272515183)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_272515183] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_51559090027 : Nat.Prime 51559090027 := by
  apply lucasNat 51559090027 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 51559090027 - 1 = 2 * (3 * (8593181671)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_8593181671] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_60555023561 : Nat.Prime 60555023561 := by
  apply lucasNat 60555023561 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 60555023561 - 1 = 2 * (2 * (2 * (5 * (1513875589)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1513875589] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_62151392663 : Nat.Prime 62151392663 := by
  apply lucasNat 62151392663 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 62151392663 - 1 = 2 * (31075696331) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31075696331] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_64532907407 : Nat.Prime 64532907407 := by
  apply lucasNat 64532907407 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 64532907407 - 1 = 2 * (11 * (2933313973)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_2933313973] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_68319389951 : Nat.Prime 68319389951 := by
  apply lucasNat 68319389951 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 68319389951 - 1 = 2 * (5 * (5 * (7 * (157 * (347 * (3583)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_347, Nat.prime_dvd_prime_iff_eq hq prime_3583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_69773080303 : Nat.Prime 69773080303 := by
  apply lucasNat 69773080303 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 69773080303 - 1 = 2 * (3 * (3 * (2309 * (1678771)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2309, Nat.prime_dvd_prime_iff_eq hq prime_1678771] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_122927896297 : Nat.Prime 122927896297 := by
  apply lucasNat 122927896297 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 122927896297 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (179 * (3179389))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_179, Nat.prime_dvd_prime_iff_eq hq prime_3179389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_163603196347 : Nat.Prime 163603196347 := by
  apply lucasNat 163603196347 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 163603196347 - 1 = 2 * (3 * (2417 * (3119 * (3617)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2417, Nat.prime_dvd_prime_iff_eq hq prime_3119, Nat.prime_dvd_prime_iff_eq hq prime_3617] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_171866220913 : Nat.Prime 171866220913 := by
  apply lucasNat 171866220913 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 171866220913 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (823 * (1450201))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_823, Nat.prime_dvd_prime_iff_eq hq prime_1450201] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_185276896729 : Nat.Prime 185276896729 := by
  apply lucasNat 185276896729 26 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 185276896729 - 1 = 2 * (2 * (2 * (3 * (7 * (11 * (17 * (31 * (190243)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_190243] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_279098533279 : Nat.Prime 279098533279 := by
  apply lucasNat 279098533279 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 279098533279 - 1 = 2 * (3 * (3 * (3 * (691 * (7479727))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_691, Nat.prime_dvd_prime_iff_eq hq prime_7479727] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_318916804553 : Nat.Prime 318916804553 := by
  apply lucasNat 318916804553 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 318916804553 - 1 = 2 * (2 * (2 * (23 * (37 * (401 * (116819)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_401, Nat.prime_dvd_prime_iff_eq hq prime_116819] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_331786433449 : Nat.Prime 331786433449 := by
  apply lucasNat 331786433449 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 331786433449 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (3 * (37 * (59 * (234547))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_234547] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_361900163033 : Nat.Prime 361900163033 := by
  apply lucasNat 361900163033 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 361900163033 - 1 = 2 * (2 * (2 * (45237520379))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_45237520379] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_713140612211 : Nat.Prime 713140612211 := by
  apply lucasNat 713140612211 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 713140612211 - 1 = 2 * (5 * (13 * (5485697017))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_5485697017] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_743200733087 : Nat.Prime 743200733087 := by
  apply lucasNat 743200733087 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 743200733087 - 1 = 2 * (7 * (571 * (92969819))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_571, Nat.prime_dvd_prime_iff_eq hq prime_92969819] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_752374680479 : Nat.Prime 752374680479 := by
  apply lucasNat 752374680479 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 752374680479 - 1 = 2 * (151 * (2491306889)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_2491306889] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_820375499971 : Nat.Prime 820375499971 := by
  apply lucasNat 820375499971 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 820375499971 - 1 = 2 * (3 * (3 * (5 * (13 * (37 * (2659 * (7127))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_2659, Nat.prime_dvd_prime_iff_eq hq prime_7127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_975309072707 : Nat.Prime 975309072707 := by
  apply lucasNat 975309072707 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 975309072707 - 1 = 2 * (43 * (2351 * (4823821))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_2351, Nat.prime_dvd_prime_iff_eq hq prime_4823821] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1089253422643 : Nat.Prime 1089253422643 := by
  apply lucasNat 1089253422643 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1089253422643 - 1 = 2 * (3 * (7 * (11 * (11 * (31 * (71 * (97381))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_97381] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1216435499957 : Nat.Prime 1216435499957 := by
  apply lucasNat 1216435499957 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1216435499957 - 1 = 2 * (2 * (149 * (1321 * (1545041)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_1321, Nat.prime_dvd_prime_iff_eq hq prime_1545041] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1961643969841 : Nat.Prime 1961643969841 := by
  apply lucasNat 1961643969841 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1961643969841 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (977 * (8365933))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_977, Nat.prime_dvd_prime_iff_eq hq prime_8365933] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1988844565217 : Nat.Prime 1988844565217 := by
  apply lucasNat 1988844565217 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1988844565217 - 1 = 2 * (2 * (2 * (2 * (2 * (62151392663))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_62151392663] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2710434759677 : Nat.Prime 2710434759677 := by
  apply lucasNat 2710434759677 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2710434759677 - 1 = 2 * (2 * (7 * (61 * (433 * (811 * (4519)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_433, Nat.prime_dvd_prime_iff_eq hq prime_811, Nat.prime_dvd_prime_iff_eq hq prime_4519] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2780187265607 : Nat.Prime 2780187265607 := by
  apply lucasNat 2780187265607 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2780187265607 - 1 = 2 * (53 * (173 * (151607987))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_151607987] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2803951881919 : Nat.Prime 2803951881919 := by
  apply lucasNat 2803951881919 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2803951881919 - 1 = 2 * (3 * (3 * (11 * (773 * (1153 * (15889)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_773, Nat.prime_dvd_prime_iff_eq hq prime_1153, Nat.prime_dvd_prime_iff_eq hq prime_15889] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2907450041843 : Nat.Prime 2907450041843 := by
  apply lucasNat 2907450041843 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2907450041843 - 1 = 2 * (4231 * (5813 * (59107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4231, Nat.prime_dvd_prime_iff_eq hq prime_5813, Nat.prime_dvd_prime_iff_eq hq prime_59107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4432918842971 : Nat.Prime 4432918842971 := by
  apply lucasNat 4432918842971 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4432918842971 - 1 = 2 * (5 * (10529 * (42101993))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_10529, Nat.prime_dvd_prime_iff_eq hq prime_42101993] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4578167621329 : Nat.Prime 4578167621329 := by
  apply lucasNat 4578167621329 31 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4578167621329 - 1 = 2 * (2 * (2 * (2 * (3 * (7 * (7 * (1946499839))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1946499839] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_7814758931813 : Nat.Prime 7814758931813 := by
  apply lucasNat 7814758931813 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7814758931813 - 1 = 2 * (2 * (7 * (279098533279))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_279098533279] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_15378700456619 : Nat.Prime 15378700456619 := by
  apply lucasNat 15378700456619 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15378700456619 - 1 = 2 * (47 * (163603196347)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_163603196347] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_15629517863627 : Nat.Prime 15629517863627 := by
  apply lucasNat 15629517863627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15629517863627 - 1 = 2 * (7814758931813) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7814758931813] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_26597513057827 : Nat.Prime 26597513057827 := by
  apply lucasNat 26597513057827 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26597513057827 - 1 = 2 * (3 * (4432918842971)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_4432918842971] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_32615785948847 : Nat.Prime 32615785948847 := by
  apply lucasNat 32615785948847 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32615785948847 - 1 = 2 * (241 * (6619 * (10223237))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_6619, Nat.prime_dvd_prime_iff_eq hq prime_10223237] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_38344293302849 : Nat.Prime 38344293302849 := by
  apply lucasNat 38344293302849 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 38344293302849 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (13 * (2237 * (20602097)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_2237, Nat.prime_dvd_prime_iff_eq hq prime_20602097] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_56641177977437 : Nat.Prime 56641177977437 := by
  apply lucasNat 56641177977437 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 56641177977437 - 1 = 2 * (2 * (13 * (1089253422643))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1089253422643] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_85167993628723 : Nat.Prime 85167993628723 := by
  apply lucasNat 85167993628723 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 85167993628723 - 1 = 2 * (3 * (79 * (3119 * (57607987)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_3119, Nat.prime_dvd_prime_iff_eq hq prime_57607987] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_96181590573401 : Nat.Prime 96181590573401 := by
  apply lucasNat 96181590573401 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 96181590573401 - 1 = 2 * (2 * (2 * (5 * (5 * (23 * (449 * (46568021))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_449, Nat.prime_dvd_prime_iff_eq hq prime_46568021] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_120670930033987 : Nat.Prime 120670930033987 := by
  apply lucasNat 120670930033987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 120670930033987 - 1 = 2 * (3 * (157 * (21961 * (5833103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_21961, Nat.prime_dvd_prime_iff_eq hq prime_5833103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_130064381503759 : Nat.Prime 130064381503759 := by
  apply lucasNat 130064381503759 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 130064381503759 - 1 = 2 * (3 * (3 * (3 * (13 * (185276896729))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_185276896729] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_148312939887527 : Nat.Prime 148312939887527 := by
  apply lucasNat 148312939887527 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 148312939887527 - 1 = 2 * (23 * (37 * (15361 * (5672833)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_15361, Nat.prime_dvd_prime_iff_eq hq prime_5672833] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_161407472712719 : Nat.Prime 161407472712719 := by
  apply lucasNat 161407472712719 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 161407472712719 - 1 = 2 * (223 * (361900163033)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_361900163033] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_291205590329543 : Nat.Prime 291205590329543 := by
  apply lucasNat 291205590329543 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 291205590329543 - 1 = 2 * (7 * (151 * (358877 * (383839)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_358877, Nat.prime_dvd_prime_iff_eq hq prime_383839] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_411184209371567 : Nat.Prime 411184209371567 := by
  apply lucasNat 411184209371567 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 411184209371567 - 1 = 2 * (163 * (677 * (1863074233))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_163, Nat.prime_dvd_prime_iff_eq hq prime_677, Nat.prime_dvd_prime_iff_eq hq prime_1863074233] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_533333331835547 : Nat.Prime 533333331835547 := by
  apply lucasNat 533333331835547 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 533333331835547 - 1 = 2 * (11 * (1997 * (12139421219))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1997, Nat.prime_dvd_prime_iff_eq hq prime_12139421219] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_593119808535973 : Nat.Prime 593119808535973 := by
  apply lucasNat 593119808535973 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 593119808535973 - 1 = 2 * (2 * (3 * (17 * (2907450041843)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_2907450041843] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_652315718976941 : Nat.Prime 652315718976941 := by
  apply lucasNat 652315718976941 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 652315718976941 - 1 = 2 * (2 * (5 * (32615785948847))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_32615785948847] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_729128689166351 : Nat.Prime 729128689166351 := by
  apply lucasNat 729128689166351 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 729128689166351 - 1 = 2 * (5 * (5 * (11 * (19 * (69773080303))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_69773080303] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_885347496406951 : Nat.Prime 885347496406951 := by
  apply lucasNat 885347496406951 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 885347496406951 - 1 = 2 * (3 * (5 * (5 * (72043 * (81927691))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_72043, Nat.prime_dvd_prime_iff_eq hq prime_81927691] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_980392154109461 : Nat.Prime 980392154109461 := by
  apply lucasNat 980392154109461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 980392154109461 - 1 = 2 * (2 * (5 * (12577 * (3897559649)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_12577, Nat.prime_dvd_prime_iff_eq hq prime_3897559649] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1036269427141607 : Nat.Prime 1036269427141607 := by
  apply lucasNat 1036269427141607 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1036269427141607 - 1 = 2 * (7 * (31 * (37 * (64532907407)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_64532907407] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1163467128786097 : Nat.Prime 1163467128786097 := by
  apply lucasNat 1163467128786097 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1163467128786097 - 1 = 2 * (2 * (2 * (2 * (3 * (131 * (2339 * (79106353))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_2339, Nat.prime_dvd_prime_iff_eq hq prime_79106353] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_5050505036321471 : Nat.Prime 5050505036321471 := by
  apply lucasNat 5050505036321471 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5050505036321471 - 1 = 2 * (5 * (11 * (86501 * (530787877)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_86501, Nat.prime_dvd_prime_iff_eq hq prime_530787877] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_5847953199951173 : Nat.Prime 5847953199951173 := by
  apply lucasNat 5847953199951173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5847953199951173 - 1 = 2 * (2 * (1499 * (975309072707))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1499, Nat.prime_dvd_prime_iff_eq hq prime_975309072707] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_7272727252302913 : Nat.Prime 7272727252302913 := by
  apply lucasNat 7272727252302913 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7272727252302913 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (83 * (13049 * (34973633))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_13049, Nat.prime_dvd_prime_iff_eq hq prime_34973633] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_12903225770214847 : Nat.Prime 12903225770214847 := by
  apply lucasNat 12903225770214847 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12903225770214847 - 1 = 2 * (3 * (3 * (3 * (11 * (67 * (307 * (1056084511))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_307, Nat.prime_dvd_prime_iff_eq hq prime_1056084511] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_24691357955349409 : Nat.Prime 24691357955349409 := by
  apply lucasNat 24691357955349409 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24691357955349409 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (23 * (113 * (127 * (25037 * (31123)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_113, Nat.prime_dvd_prime_iff_eq hq prime_127, Nat.prime_dvd_prime_iff_eq hq prime_25037, Nat.prime_dvd_prime_iff_eq hq prime_31123] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_38461538353525013 : Nat.Prime 38461538353525013 := by
  apply lucasNat 38461538353525013 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 38461538353525013 - 1 = 2 * (2 * (11 * (1579621 * (553376963)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1579621, Nat.prime_dvd_prime_iff_eq hq prime_553376963] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_46511627776355831 : Nat.Prime 46511627776355831 := by
  apply lucasNat 46511627776355831 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 46511627776355831 - 1 = 2 * (5 * (11 * (37 * (853 * (13397325173))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_853, Nat.prime_dvd_prime_iff_eq hq prime_13397325173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_60606060435857653 : Nat.Prime 60606060435857653 := by
  apply lucasNat 60606060435857653 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 60606060435857653 - 1 = 2 * (2 * (3 * (5050505036321471))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5050505036321471] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_166666666198608437 : Nat.Prime 166666666198608437 := by
  apply lucasNat 166666666198608437 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 166666666198608437 - 1 = 2 * (2 * (7 * (2141 * (2780187265607)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2141, Nat.prime_dvd_prime_iff_eq hq prime_2780187265607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_199999999438330103 : Nat.Prime 199999999438330103 := by
  apply lucasNat 199999999438330103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199999999438330103 - 1 = 2 * (11 * (14221 * (14423 * (44322227)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_14221, Nat.prime_dvd_prime_iff_eq hq prime_14423, Nat.prime_dvd_prime_iff_eq hq prime_44322227] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_249999999297912583 : Nat.Prime 249999999297912583 := by
  apply lucasNat 249999999297912583 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 249999999297912583 - 1 = 2 * (3 * (58427 * (713140612211))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_58427, Nat.prime_dvd_prime_iff_eq hq prime_713140612211] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_285714284911900139 : Nat.Prime 285714284911900139 := by
  apply lucasNat 285714284911900139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 285714284911900139 - 1 = 2 * (7 * (59 * (61 * (83 * (68319389951))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_68319389951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_333333332397216779 : Nat.Prime 333333332397216779 := by
  apply lucasNat 333333332397216779 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 333333332397216779 - 1 = 2 * (11 * (11 * (23 * (73 * (820375499971))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_820375499971] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_666666664794434023 : Nat.Prime 666666664794434023 := by
  apply lucasNat 666666664794434023 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 666666664794434023 - 1 = 2 * (3 * (43 * (43 * (887 * (49433 * (1370503)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_887, Nat.prime_dvd_prime_iff_eq hq prime_49433, Nat.prime_dvd_prime_iff_eq hq prime_1370503] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_999999997191650569 : Nat.Prime 999999997191650569 := by
  apply lucasNat 999999997191650569 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 999999997191650569 - 1 = 2 * (2 * (2 * (3 * (2499463 * (16670247389))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2499463, Nat.prime_dvd_prime_iff_eq hq prime_16670247389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_999999997191650629 : Nat.Prime 999999997191650629 := by
  apply lucasNat 999999997191650629 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 999999997191650629 - 1 = 2 * (2 * (3 * (3 * (17 * (149 * (13441 * (19687 * (41443)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_13441, Nat.prime_dvd_prime_iff_eq hq prime_19687, Nat.prime_dvd_prime_iff_eq hq prime_41443] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1999999994383300901 : Nat.Prime 1999999994383300901 := by
  apply lucasNat 1999999994383300901 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999994383300901 - 1 = 2 * (2 * (5 * (5 * (19 * (8563 * (122927896297)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_8563, Nat.prime_dvd_prime_iff_eq hq prime_122927896297] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1999999994383300961 : Nat.Prime 1999999994383300961 := by
  apply lucasNat 1999999994383300961 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999994383300961 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (53 * (73 * (457 * (821 * (2707 * (3181))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_457, Nat.prime_dvd_prime_iff_eq hq prime_821, Nat.prime_dvd_prime_iff_eq hq prime_2707, Nat.prime_dvd_prime_iff_eq hq prime_3181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_3999999988766600789 : Nat.Prime 3999999988766600789 := by
  apply lucasNat 3999999988766600789 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600789 - 1 = 2 * (2 * (37 * (281 * (96181590573401)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_96181590573401] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766600881 : Nat.Prime 3999999988766600881 := by
  apply lucasNat 3999999988766600881 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600881 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (17 * (980392154109461))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_980392154109461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766600941 : Nat.Prime 3999999988766600941 := by
  apply lucasNat 3999999988766600941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600941 - 1 = 2 * (2 * (3 * (5 * (11 * (107 * (56641177977437)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_107, Nat.prime_dvd_prime_iff_eq hq prime_56641177977437] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766600977 : Nat.Prime 3999999988766600977 := by
  apply lucasNat 3999999988766600977 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600977 - 1 = 2 * (2 * (2 * (2 * (3 * (3151259 * (26444456993)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3151259, Nat.prime_dvd_prime_iff_eq hq prime_26444456993] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766601041 : Nat.Prime 3999999988766601041 := by
  apply lucasNat 3999999988766601041 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601041 - 1 = 2 * (2 * (2 * (2 * (5 * (13 * (19 * (21649 * (9350508071)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_21649, Nat.prime_dvd_prime_iff_eq hq prime_9350508071] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766601077 : Nat.Prime 3999999988766601077 := by
  apply lucasNat 3999999988766601077 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601077 - 1 = 2 * (2 * (8287 * (120670930033987))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_8287, Nat.prime_dvd_prime_iff_eq hq prime_120670930033987] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601107 : Nat.Prime 3999999988766601107 := by
  apply lucasNat 3999999988766601107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601107 - 1 = 2 * (7 * (23 * (59 * (17041 * (12355406267))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_17041, Nat.prime_dvd_prime_iff_eq hq prime_12355406267] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766601181 : Nat.Prime 3999999988766601181 := by
  apply lucasNat 3999999988766601181 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601181 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (3 * (5 * (6829 * (19073 * (6318989)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_6829, Nat.prime_dvd_prime_iff_eq hq prime_19073, Nat.prime_dvd_prime_iff_eq hq prime_6318989] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766601217 : Nat.Prime 3999999988766601217 := by
  apply lucasNat 3999999988766601217 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601217 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (643 * (1777 * (94964029)))))))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_643, Nat.prime_dvd_prime_iff_eq hq prime_1777, Nat.prime_dvd_prime_iff_eq hq prime_94964029] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14 | h15 | h16
  all_goals subst q; decide +kernel
theorem prime_3999999988766601233 : Nat.Prime 3999999988766601233 := by
  apply lucasNat 3999999988766601233 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601233 - 1 = 2 * (2 * (2 * (2 * (7 * (37 * (54167 * (17819908109))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_54167, Nat.prime_dvd_prime_iff_eq hq prime_17819908109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766601319 : Nat.Prime 3999999988766601319 := by
  apply lucasNat 3999999988766601319 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601319 - 1 = 2 * (3 * (214548871 * (3107295143))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_214548871, Nat.prime_dvd_prime_iff_eq hq prime_3107295143] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601329 : Nat.Prime 3999999988766601329 := by
  apply lucasNat 3999999988766601329 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601329 - 1 = 2 * (2 * (2 * (2 * (249999999297912583)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_249999999297912583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601349 : Nat.Prime 3999999988766601349 := by
  apply lucasNat 3999999988766601349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601349 - 1 = 2 * (2 * (3 * (333333332397216779))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_333333332397216779] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601353 : Nat.Prime 3999999988766601353 := by
  apply lucasNat 3999999988766601353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601353 - 1 = 2 * (2 * (2 * (13 * (38461538353525013)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_38461538353525013] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601467 : Nat.Prime 3999999988766601467 := by
  apply lucasNat 3999999988766601467 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601467 - 1 = 2 * (43 * (46511627776355831)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_46511627776355831] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766601481 : Nat.Prime 3999999988766601481 := by
  apply lucasNat 3999999988766601481 22 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601481 - 1 = 2 * (2 * (2 * (3 * (5 * (419 * (501451 * (158648591))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_419, Nat.prime_dvd_prime_iff_eq hq prime_501451, Nat.prime_dvd_prime_iff_eq hq prime_158648591] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766601487 : Nat.Prime 3999999988766601487 := by
  apply lucasNat 3999999988766601487 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601487 - 1 = 2 * (3 * (3 * (191 * (1163467128786097)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_191, Nat.prime_dvd_prime_iff_eq hq prime_1163467128786097] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601503 : Nat.Prime 3999999988766601503 := by
  apply lucasNat 3999999988766601503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601503 - 1 = 2 * (3793 * (474043 * (1112319149))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3793, Nat.prime_dvd_prime_iff_eq hq prime_474043, Nat.prime_dvd_prime_iff_eq hq prime_1112319149] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601511 : Nat.Prime 3999999988766601511 := by
  apply lucasNat 3999999988766601511 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601511 - 1 = 2 * (3 * (5 * (5679407 * (23476629331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_5679407, Nat.prime_dvd_prime_iff_eq hq prime_23476629331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601527 : Nat.Prime 3999999988766601527 := by
  apply lucasNat 3999999988766601527 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601527 - 1 = 2 * (7 * (17 * (157 * (331 * (2909 * (111176159)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_331, Nat.prime_dvd_prime_iff_eq hq prime_2909, Nat.prime_dvd_prime_iff_eq hq prime_111176159] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766601587 : Nat.Prime 3999999988766601587 := by
  apply lucasNat 3999999988766601587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601587 - 1 = 2 * (13 * (211 * (729128689166351))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_211, Nat.prime_dvd_prime_iff_eq hq prime_729128689166351] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601607 : Nat.Prime 3999999988766601607 := by
  apply lucasNat 3999999988766601607 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601607 - 1 = 2 * (3 * (251 * (449567 * (5908001453)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_449567, Nat.prime_dvd_prime_iff_eq hq prime_5908001453] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601731 : Nat.Prime 3999999988766601731 := by
  apply lucasNat 3999999988766601731 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601731 - 1 = 2 * (5 * (17 * (45599 * (275941 * (1869991))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_45599, Nat.prime_dvd_prime_iff_eq hq prime_275941, Nat.prime_dvd_prime_iff_eq hq prime_1869991] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766601803 : Nat.Prime 3999999988766601803 := by
  apply lucasNat 3999999988766601803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601803 - 1 = 2 * (1999999994383300901) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1999999994383300901] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_3999999988766601889 : Nat.Prime 3999999988766601889 := by
  apply lucasNat 3999999988766601889 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601889 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (23 * (31 * (3461 * (16884866371))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_3461, Nat.prime_dvd_prime_iff_eq hq prime_16884866371] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_3999999988766601901 : Nat.Prime 3999999988766601901 := by
  apply lucasNat 3999999988766601901 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601901 - 1 = 2 * (2 * (3 * (3 * (5 * (5 * (17 * (17 * (15378700456619)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_15378700456619] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766601913 : Nat.Prime 3999999988766601913 := by
  apply lucasNat 3999999988766601913 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601913 - 1 = 2 * (2 * (2 * (3 * (281 * (593119808535973))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_593119808535973] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766601923 : Nat.Prime 3999999988766601923 := by
  apply lucasNat 3999999988766601923 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601923 - 1 = 2 * (1999999994383300961) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1999999994383300961] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_3999999988766601947 : Nat.Prime 3999999988766601947 := by
  apply lucasNat 3999999988766601947 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601947 - 1 = 2 * (7 * (285714284911900139)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_285714284911900139] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766601983 : Nat.Prime 3999999988766601983 := by
  apply lucasNat 3999999988766601983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601983 - 1 = 2 * (43 * (1213 * (38344293302849))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_1213, Nat.prime_dvd_prime_iff_eq hq prime_38344293302849] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766602061 : Nat.Prime 3999999988766602061 := by
  apply lucasNat 3999999988766602061 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602061 - 1 = 2 * (2 * (5 * (199999999438330103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_199999999438330103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766602081 : Nat.Prime 3999999988766602081 := by
  apply lucasNat 3999999988766602081 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602081 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (5 * (13 * (293 * (929 * (13009 * (60343)))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_293, Nat.prime_dvd_prime_iff_eq hq prime_929, Nat.prime_dvd_prime_iff_eq hq prime_13009, Nat.prime_dvd_prime_iff_eq hq prime_60343] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  all_goals subst q; decide +kernel
theorem prime_3999999988766602147 : Nat.Prime 3999999988766602147 := by
  apply lucasNat 3999999988766602147 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602147 - 1 = 2 * (3 * (29 * (11719 * (1961643969841)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_11719, Nat.prime_dvd_prime_iff_eq hq prime_1961643969841] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602151 : Nat.Prime 3999999988766602151 := by
  apply lucasNat 3999999988766602151 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602151 - 1 = 2 * (5 * (5 * (11 * (7272727252302913)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_7272727252302913] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602169 : Nat.Prime 3999999988766602169 := by
  apply lucasNat 3999999988766602169 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602169 - 1 = 2 * (2 * (2 * (59 * (26573 * (318916804553))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_26573, Nat.prime_dvd_prime_iff_eq hq prime_318916804553] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602213 : Nat.Prime 3999999988766602213 := by
  apply lucasNat 3999999988766602213 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602213 - 1 = 2 * (2 * (3 * (7 * (73 * (652315718976941))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_652315718976941] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602241 : Nat.Prime 3999999988766602241 := by
  apply lucasNat 3999999988766602241 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602241 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (7 * (17 * (43 * (131 * (1165475951))))))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_1165475951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14 | h15
  all_goals subst q; decide +kernel
theorem prime_3999999988766602243 : Nat.Prime 3999999988766602243 := by
  apply lucasNat 3999999988766602243 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602243 - 1 = 2 * (3 * (3 * (421 * (74201 * (7113701389))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_421, Nat.prime_dvd_prime_iff_eq hq prime_74201, Nat.prime_dvd_prime_iff_eq hq prime_7113701389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602259 : Nat.Prime 3999999988766602259 := by
  apply lucasNat 3999999988766602259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602259 - 1 = 2 * (12391 * (161407472712719)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_12391, Nat.prime_dvd_prime_iff_eq hq prime_161407472712719] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766602277 : Nat.Prime 3999999988766602277 := by
  apply lucasNat 3999999988766602277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602277 - 1 = 2 * (2 * (999999997191650569)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_999999997191650569] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766602307 : Nat.Prime 3999999988766602307 := by
  apply lucasNat 3999999988766602307 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602307 - 1 = 2 * (3529 * (5140397 * (110250781))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3529, Nat.prime_dvd_prime_iff_eq hq prime_5140397, Nat.prime_dvd_prime_iff_eq hq prime_110250781] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766602333 : Nat.Prime 3999999988766602333 := by
  apply lucasNat 3999999988766602333 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602333 - 1 = 2 * (2 * (3 * (3 * (19 * (5847953199951173))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_5847953199951173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602343 : Nat.Prime 3999999988766602343 := by
  apply lucasNat 3999999988766602343 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602343 - 1 = 2 * (17 * (37 * (68134433 * (46667303)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_68134433, Nat.prime_dvd_prime_iff_eq hq prime_46667303] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602489 : Nat.Prime 3999999988766602489 := by
  apply lucasNat 3999999988766602489 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602489 - 1 = 2 * (2 * (2 * (3 * (166666666198608437)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_166666666198608437] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602501 : Nat.Prime 3999999988766602501 := by
  apply lucasNat 3999999988766602501 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602501 - 1 = 2 * (2 * (3 * (5 * (5 * (5 * (5 * (533333331835547))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_533333331835547] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766602507 : Nat.Prime 3999999988766602507 := by
  apply lucasNat 3999999988766602507 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602507 - 1 = 2 * (3 * (7 * (6071591 * (15685854823)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_6071591, Nat.prime_dvd_prime_iff_eq hq prime_15685854823] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602517 : Nat.Prime 3999999988766602517 := by
  apply lucasNat 3999999988766602517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602517 - 1 = 2 * (2 * (999999997191650629)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_999999997191650629] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766602531 : Nat.Prime 3999999988766602531 := by
  apply lucasNat 3999999988766602531 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602531 - 1 = 2 * (3 * (3 * (3 * (5 * (557 * (26597513057827)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_557, Nat.prime_dvd_prime_iff_eq hq prime_26597513057827] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766602543 : Nat.Prime 3999999988766602543 := by
  apply lucasNat 3999999988766602543 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602543 - 1 = 2 * (3 * (61 * (139 * (859799 * (91446517))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_859799, Nat.prime_dvd_prime_iff_eq hq prime_91446517] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602571 : Nat.Prime 3999999988766602571 := by
  apply lucasNat 3999999988766602571 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602571 - 1 = 2 * (5 * (31 * (12903225770214847))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_12903225770214847] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766602621 : Nat.Prime 3999999988766602621 := by
  apply lucasNat 3999999988766602621 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602621 - 1 = 2 * (2 * (3 * (3 * (5 * (71 * (197 * (809 * (34703 * (56591))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_197, Nat.prime_dvd_prime_iff_eq hq prime_809, Nat.prime_dvd_prime_iff_eq hq prime_34703, Nat.prime_dvd_prime_iff_eq hq prime_56591] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_3999999988766602649 : Nat.Prime 3999999988766602649 := by
  apply lucasNat 3999999988766602649 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602649 - 1 = 2 * (2 * (2 * (17 * (101 * (291205590329543))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_101, Nat.prime_dvd_prime_iff_eq hq prime_291205590329543] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602657 : Nat.Prime 3999999988766602657 := by
  apply lucasNat 3999999988766602657 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602657 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (11 * (311 * (3877 * (1047173461)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_311, Nat.prime_dvd_prime_iff_eq hq prime_3877, Nat.prime_dvd_prime_iff_eq hq prime_1047173461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766602819 : Nat.Prime 3999999988766602819 := by
  apply lucasNat 3999999988766602819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602819 - 1 = 2 * (3 * (3 * (17 * (31 * (199 * (449699 * (4711963))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_199, Nat.prime_dvd_prime_iff_eq hq prime_449699, Nat.prime_dvd_prime_iff_eq hq prime_4711963] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766602957 : Nat.Prime 3999999988766602957 := by
  apply lucasNat 3999999988766602957 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602957 - 1 = 2 * (2 * (3 * (79 * (33539017 * (125805991))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_33539017, Nat.prime_dvd_prime_iff_eq hq prime_125805991] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602963 : Nat.Prime 3999999988766602963 := by
  apply lucasNat 3999999988766602963 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602963 - 1 = 2 * (3 * (3 * (3 * (3 * (33223 * (743200733087)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_33223, Nat.prime_dvd_prime_iff_eq hq prime_743200733087] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766603021 : Nat.Prime 3999999988766603021 := by
  apply lucasNat 3999999988766603021 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603021 - 1 = 2 * (2 * (5 * (193 * (1036269427141607)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_193, Nat.prime_dvd_prime_iff_eq hq prime_1036269427141607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766603093 : Nat.Prime 3999999988766603093 := by
  apply lucasNat 3999999988766603093 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603093 - 1 = 2 * (2 * (19 * (5948413 * (8848003459)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_5948413, Nat.prime_dvd_prime_iff_eq hq prime_8848003459] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766603099 : Nat.Prime 3999999988766603099 := by
  apply lucasNat 3999999988766603099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603099 - 1 = 2 * (139 * (241 * (503 * (179213 * (662309))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_503, Nat.prime_dvd_prime_iff_eq hq prime_179213, Nat.prime_dvd_prime_iff_eq hq prime_662309] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603113 : Nat.Prime 3999999988766603113 := by
  apply lucasNat 3999999988766603113 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603113 - 1 = 2 * (2 * (2 * (3 * (59 * (251 * (166303 * (67674169))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_166303, Nat.prime_dvd_prime_iff_eq hq prime_67674169] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603123 : Nat.Prime 3999999988766603123 := by
  apply lucasNat 3999999988766603123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603123 - 1 = 2 * (7 * (103 * (8329 * (10847 * (30703807))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_8329, Nat.prime_dvd_prime_iff_eq hq prime_10847, Nat.prime_dvd_prime_iff_eq hq prime_30703807] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603189 : Nat.Prime 3999999988766603189 := by
  apply lucasNat 3999999988766603189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603189 - 1 = 2 * (2 * (71 * (109 * (28597 * (4518504059))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_28597, Nat.prime_dvd_prime_iff_eq hq prime_4518504059] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603191 : Nat.Prime 3999999988766603191 := by
  apply lucasNat 3999999988766603191 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603191 - 1 = 2 * (3 * (5 * (29 * (31 * (148312939887527))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_148312939887527] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603249 : Nat.Prime 3999999988766603249 := by
  apply lucasNat 3999999988766603249 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603249 - 1 = 2 * (2 * (2 * (2 * (7 * (29 * (269 * (4578167621329))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_269, Nat.prime_dvd_prime_iff_eq hq prime_4578167621329] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603273 : Nat.Prime 3999999988766603273 := by
  apply lucasNat 3999999988766603273 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603273 - 1 = 2 * (2 * (2 * (11 * (11 * (43 * (79 * (1216435499957))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_1216435499957] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603281 : Nat.Prime 3999999988766603281 := by
  apply lucasNat 3999999988766603281 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603281 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (863 * (1277 * (15123316997)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_863, Nat.prime_dvd_prime_iff_eq hq prime_1277, Nat.prime_dvd_prime_iff_eq hq prime_15123316997] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766603477 : Nat.Prime 3999999988766603477 := by
  apply lucasNat 3999999988766603477 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603477 - 1 = 2 * (2 * (21617 * (372637 * (124141961)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_21617, Nat.prime_dvd_prime_iff_eq hq prime_372637, Nat.prime_dvd_prime_iff_eq hq prime_124141961] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766603501 : Nat.Prime 3999999988766603501 := by
  apply lucasNat 3999999988766603501 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603501 - 1 = 2 * (2 * (5 * (5 * (5 * (7 * (7 * (7 * (31 * (752374680479))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_752374680479] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_3999999988766603539 : Nat.Prime 3999999988766603539 := by
  apply lucasNat 3999999988766603539 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603539 - 1 = 2 * (3 * (3 * (29 * (41 * (353 * (176507 * (2999639))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_353, Nat.prime_dvd_prime_iff_eq hq prime_176507, Nat.prime_dvd_prime_iff_eq hq prime_2999639] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603603 : Nat.Prime 3999999988766603603 := by
  apply lucasNat 3999999988766603603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603603 - 1 = 2 * (11 * (11633 * (15629517863627))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_11633, Nat.prime_dvd_prime_iff_eq hq prime_15629517863627] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766603699 : Nat.Prime 3999999988766603699 := by
  apply lucasNat 3999999988766603699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603699 - 1 = 2 * (33301 * (217111 * (276624659))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_33301, Nat.prime_dvd_prime_iff_eq hq prime_217111, Nat.prime_dvd_prime_iff_eq hq prime_276624659] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766603707 : Nat.Prime 3999999988766603707 := by
  apply lucasNat 3999999988766603707 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603707 - 1 = 2 * (3 * (245963 * (2710434759677))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_245963, Nat.prime_dvd_prime_iff_eq hq prime_2710434759677] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766603737 : Nat.Prime 3999999988766603737 := by
  apply lucasNat 3999999988766603737 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603737 - 1 = 2 * (2 * (2 * (3 * (3 * (17 * (93083 * (35108170633))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_93083, Nat.prime_dvd_prime_iff_eq hq prime_35108170633] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603777 : Nat.Prime 3999999988766603777 := by
  apply lucasNat 3999999988766603777 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603777 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (19 * (411184209371567)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_411184209371567] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766603791 : Nat.Prime 3999999988766603791 := by
  apply lucasNat 3999999988766603791 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603791 - 1 = 2 * (3 * (3 * (5 * (223 * (2850097 * (69928301)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_2850097, Nat.prime_dvd_prime_iff_eq hq prime_69928301] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766603803 : Nat.Prime 3999999988766603803 := by
  apply lucasNat 3999999988766603803 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603803 - 1 = 2 * (3 * (197 * (491 * (1867 * (3691617563))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_197, Nat.prime_dvd_prime_iff_eq hq prime_491, Nat.prime_dvd_prime_iff_eq hq prime_1867, Nat.prime_dvd_prime_iff_eq hq prime_3691617563] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603819 : Nat.Prime 3999999988766603819 := by
  apply lucasNat 3999999988766603819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603819 - 1 = 2 * (73 * (509 * (2473 * (3169 * (6868201))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_509, Nat.prime_dvd_prime_iff_eq hq prime_2473, Nat.prime_dvd_prime_iff_eq hq prime_3169, Nat.prime_dvd_prime_iff_eq hq prime_6868201] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603837 : Nat.Prime 3999999988766603837 := by
  apply lucasNat 3999999988766603837 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603837 - 1 = 2 * (2 * (7 * (21942623 * (6510486119)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_21942623, Nat.prime_dvd_prime_iff_eq hq prime_6510486119] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766603867 : Nat.Prime 3999999988766603867 := by
  apply lucasNat 3999999988766603867 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603867 - 1 = 2 * (11 * (23 * (41 * (463 * (3433 * (121302799)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_463, Nat.prime_dvd_prime_iff_eq hq prime_3433, Nat.prime_dvd_prime_iff_eq hq prime_121302799] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766603929 : Nat.Prime 3999999988766603929 := by
  apply lucasNat 3999999988766603929 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603929 - 1 = 2 * (2 * (2 * (3 * (19 * (659689 * (13297068467)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_659689, Nat.prime_dvd_prime_iff_eq hq prime_13297068467] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766603977 : Nat.Prime 3999999988766603977 := by
  apply lucasNat 3999999988766603977 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603977 - 1 = 2 * (2 * (2 * (3 * (7 * (11 * (41981 * (51559090027))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41981, Nat.prime_dvd_prime_iff_eq hq prime_51559090027] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766604001 : Nat.Prime 3999999988766604001 := by
  apply lucasNat 3999999988766604001 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604001 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (5 * (5 * (5 * (21983483 * (15162899)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_21983483, Nat.prime_dvd_prime_iff_eq hq prime_15162899] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766604139 : Nat.Prime 3999999988766604139 := by
  apply lucasNat 3999999988766604139 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604139 - 1 = 2 * (3 * (666666664794434023)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_666666664794434023] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766604167 : Nat.Prime 3999999988766604167 := by
  apply lucasNat 3999999988766604167 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604167 - 1 = 2 * (21599 * (149873 * (617835629))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_21599, Nat.prime_dvd_prime_iff_eq hq prime_149873, Nat.prime_dvd_prime_iff_eq hq prime_617835629] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604187 : Nat.Prime 3999999988766604187 := by
  apply lucasNat 3999999988766604187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604187 - 1 = 2 * (3 * (3 * (7 * (7 * (7 * (13 * (823 * (60555023561)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_823, Nat.prime_dvd_prime_iff_eq hq prime_60555023561] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766604191 : Nat.Prime 3999999988766604191 := by
  apply lucasNat 3999999988766604191 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604191 - 1 = 2 * (5 * (217145179 * (1842085561))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_217145179, Nat.prime_dvd_prime_iff_eq hq prime_1842085561] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604197 : Nat.Prime 3999999988766604197 := by
  apply lucasNat 3999999988766604197 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604197 - 1 = 2 * (2 * (11 * (197 * (42299 * (10909654253))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_197, Nat.prime_dvd_prime_iff_eq hq prime_42299, Nat.prime_dvd_prime_iff_eq hq prime_10909654253] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604217 : Nat.Prime 3999999988766604217 := by
  apply lucasNat 3999999988766604217 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604217 - 1 = 2 * (2 * (2 * (3 * (15167683 * (10988274623))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_15167683, Nat.prime_dvd_prime_iff_eq hq prime_10988274623] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604259 : Nat.Prime 3999999988766604259 := by
  apply lucasNat 3999999988766604259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604259 - 1 = 2 * (3 * (3 * (3 * (3 * (24691357955349409))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_24691357955349409] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604271 : Nat.Prime 3999999988766604271 := by
  apply lucasNat 3999999988766604271 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604271 - 1 = 2 * (3 * (5 * (7 * (19 * (67 * (271 * (373 * (148024693)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_271, Nat.prime_dvd_prime_iff_eq hq prime_373, Nat.prime_dvd_prime_iff_eq hq prime_148024693] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766604287 : Nat.Prime 3999999988766604287 := by
  apply lucasNat 3999999988766604287 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604287 - 1 = 2 * (15377 * (130064381503759)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_15377, Nat.prime_dvd_prime_iff_eq hq prime_130064381503759] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766604307 : Nat.Prime 3999999988766604307 := by
  apply lucasNat 3999999988766604307 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604307 - 1 = 2 * (3 * (11 * (31 * (983 * (1988844565217))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_983, Nat.prime_dvd_prime_iff_eq hq prime_1988844565217] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604353 : Nat.Prime 3999999988766604353 := by
  apply lucasNat 3999999988766604353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604353 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (157 * (397 * (31667 * (31665251))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_397, Nat.prime_dvd_prime_iff_eq hq prime_31667, Nat.prime_dvd_prime_iff_eq hq prime_31665251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_3999999988766604359 : Nat.Prime 3999999988766604359 := by
  apply lucasNat 3999999988766604359 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604359 - 1 = 2 * (41 * (53 * (103 * (5791 * (1543048151))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_5791, Nat.prime_dvd_prime_iff_eq hq prime_1543048151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604373 : Nat.Prime 3999999988766604373 := by
  apply lucasNat 3999999988766604373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604373 - 1 = 2 * (2 * (3 * (11 * (23 * (61 * (757 * (28532019251))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_757, Nat.prime_dvd_prime_iff_eq hq prime_28532019251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766604419 : Nat.Prime 3999999988766604419 := by
  apply lucasNat 3999999988766604419 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604419 - 1 = 2 * (23 * (1021 * (85167993628723))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_1021, Nat.prime_dvd_prime_iff_eq hq prime_85167993628723] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604503 : Nat.Prime 3999999988766604503 := by
  apply lucasNat 3999999988766604503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604503 - 1 = 2 * (124087 * (976853 * (16499641))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_124087, Nat.prime_dvd_prime_iff_eq hq prime_976853, Nat.prime_dvd_prime_iff_eq hq prime_16499641] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604619 : Nat.Prime 3999999988766604619 := by
  apply lucasNat 3999999988766604619 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604619 - 1 = 2 * (3 * (3 * (251 * (885347496406951)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_885347496406951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766604649 : Nat.Prime 3999999988766604649 := by
  apply lucasNat 3999999988766604649 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604649 - 1 = 2 * (2 * (2 * (3 * (7 * (23 * (23 * (43 * (349 * (6553 * (457679)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_349, Nat.prime_dvd_prime_iff_eq hq prime_6553, Nat.prime_dvd_prime_iff_eq hq prime_457679] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766604653 : Nat.Prime 3999999988766604653 := by
  apply lucasNat 3999999988766604653 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604653 - 1 = 2 * (2 * (3013987 * (331786433449))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3013987, Nat.prime_dvd_prime_iff_eq hq prime_331786433449] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604803 : Nat.Prime 3999999988766604803 := by
  apply lucasNat 3999999988766604803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604803 - 1 = 2 * (7 * (19 * (31 * (173 * (2803951881919))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_2803951881919] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604817 : Nat.Prime 3999999988766604817 := by
  apply lucasNat 3999999988766604817 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604817 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (2859391 * (1387796897)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2859391, Nat.prime_dvd_prime_iff_eq hq prime_1387796897] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766604853 : Nat.Prime 3999999988766604853 := by
  apply lucasNat 3999999988766604853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604853 - 1 = 2 * (2 * (3 * (3 * (3 * (79 * (5480197 * (85548613))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_5480197, Nat.prime_dvd_prime_iff_eq hq prime_85548613] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766605027 : Nat.Prime 3999999988766605027 := by
  apply lucasNat 3999999988766605027 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605027 - 1 = 2 * (3 * (7 * (241 * (1014779 * (389423527))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_1014779, Nat.prime_dvd_prime_iff_eq hq prime_389423527] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766605091 : Nat.Prime 3999999988766605091 := by
  apply lucasNat 3999999988766605091 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605091 - 1 = 2 * (5 * (22643 * (24917 * (708973939)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_22643, Nat.prime_dvd_prime_iff_eq hq prime_24917, Nat.prime_dvd_prime_iff_eq hq prime_708973939] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766605097 : Nat.Prime 3999999988766605097 := by
  apply lucasNat 3999999988766605097 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605097 - 1 = 2 * (2 * (2 * (7 * (13 * (17 * (41 * (797 * (9890938723)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_797, Nat.prime_dvd_prime_iff_eq hq prime_9890938723] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766605099 : Nat.Prime 3999999988766605099 := by
  apply lucasNat 3999999988766605099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605099 - 1 = 2 * (3 * (11 * (60606060435857653))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_60606060435857653] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766605193 : Nat.Prime 3999999988766605193 := by
  apply lucasNat 3999999988766605193 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605193 - 1 = 2 * (2 * (2 * (53254163 * (9388937323)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53254163, Nat.prime_dvd_prime_iff_eq hq prime_9388937323] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766605261 : Nat.Prime 3999999988766605261 := by
  apply lucasNat 3999999988766605261 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605261 - 1 = 2 * (2 * (3 * (5 * (41 * (10009133 * (162453257)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_10009133, Nat.prime_dvd_prime_iff_eq hq prime_162453257] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766605309 : Nat.Prime 3999999988766605309 := by
  apply lucasNat 3999999988766605309 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605309 - 1 = 2 * (2 * (3 * (1939493 * (171866220913)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1939493, Nat.prime_dvd_prime_iff_eq hq prime_171866220913] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
end FiniteP0N1024
