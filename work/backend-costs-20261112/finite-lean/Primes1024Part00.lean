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
end FiniteP0N1024
