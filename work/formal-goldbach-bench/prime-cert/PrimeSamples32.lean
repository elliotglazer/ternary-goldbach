import PrimeSupport

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

theorem prime_277 : Nat.Prime 277 := by
  apply lucasNat 277 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 277 - 1 = 2 * (2 * (3 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_293 : Nat.Prime 293 := by
  apply lucasNat 293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 293 - 1 = 2 * (2 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_317 : Nat.Prime 317 := by
  apply lucasNat 317 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 317 - 1 = 2 * (2 * (79)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_347 : Nat.Prime 347 := by
  apply lucasNat 347 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 347 - 1 = 2 * (173) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_353 : Nat.Prime 353 := by
  apply lucasNat 353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 353 - 1 = 2 * (2 * (2 * (2 * (2 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_389 : Nat.Prime 389 := by
  apply lucasNat 389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389 - 1 = 2 * (2 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_401 : Nat.Prime 401 := by
  apply lucasNat 401 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 401 - 1 = 2 * (2 * (2 * (2 * (5 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_421 : Nat.Prime 421 := by
  apply lucasNat 421 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 421 - 1 = 2 * (2 * (3 * (5 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_439 : Nat.Prime 439 := by
  apply lucasNat 439 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 439 - 1 = 2 * (3 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_457 : Nat.Prime 457 := by
  apply lucasNat 457 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 457 - 1 = 2 * (2 * (2 * (3 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_467 : Nat.Prime 467 := by
  apply lucasNat 467 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 467 - 1 = 2 * (233) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_479 : Nat.Prime 479 := by
  apply lucasNat 479 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 479 - 1 = 2 * (239) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_523 : Nat.Prime 523 := by
  apply lucasNat 523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 523 - 1 = 2 * (3 * (3 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_569 : Nat.Prime 569 := by
  apply lucasNat 569 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 569 - 1 = 2 * (2 * (2 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_601 : Nat.Prime 601 := by
  apply lucasNat 601 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 601 - 1 = 2 * (2 * (2 * (3 * (5 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_643 : Nat.Prime 643 := by
  apply lucasNat 643 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 643 - 1 = 2 * (3 * (107)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_647 : Nat.Prime 647 := by
  apply lucasNat 647 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 647 - 1 = 2 * (17 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2
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

theorem prime_743 : Nat.Prime 743 := by
  apply lucasNat 743 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 743 - 1 = 2 * (7 * (53)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_769 : Nat.Prime 769 := by
  apply lucasNat 769 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 769 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
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

theorem prime_997 : Nat.Prime 997 := by
  apply lucasNat 997 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 997 - 1 = 2 * (2 * (3 * (83))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1013 : Nat.Prime 1013 := by
  apply lucasNat 1013 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1013 - 1 = 2 * (2 * (11 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1049 : Nat.Prime 1049 := by
  apply lucasNat 1049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1049 - 1 = 2 * (2 * (2 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1129 : Nat.Prime 1129 := by
  apply lucasNat 1129 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1129 - 1 = 2 * (2 * (2 * (3 * (47)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1213 : Nat.Prime 1213 := by
  apply lucasNat 1213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1213 - 1 = 2 * (2 * (3 * (101))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1237 : Nat.Prime 1237 := by
  apply lucasNat 1237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1237 - 1 = 2 * (2 * (3 * (103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1459 : Nat.Prime 1459 := by
  apply lucasNat 1459 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1459 - 1 = 2 * (3 * (3 * (3 * (3 * (3 * (3)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_1471 : Nat.Prime 1471 := by
  apply lucasNat 1471 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1471 - 1 = 2 * (3 * (5 * (7 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1559 : Nat.Prime 1559 := by
  apply lucasNat 1559 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1559 - 1 = 2 * (19 * (41)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_1667 : Nat.Prime 1667 := by
  apply lucasNat 1667 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1667 - 1 = 2 * (7 * (7 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1901 : Nat.Prime 1901 := by
  apply lucasNat 1901 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1901 - 1 = 2 * (2 * (5 * (5 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2011 : Nat.Prime 2011 := by
  apply lucasNat 2011 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2011 - 1 = 2 * (3 * (5 * (67))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2027 : Nat.Prime 2027 := by
  apply lucasNat 2027 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2027 - 1 = 2 * (1013) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1013] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_2081 : Nat.Prime 2081 := by
  apply lucasNat 2081 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2081 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (13)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_2131 : Nat.Prime 2131 := by
  apply lucasNat 2131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2131 - 1 = 2 * (3 * (5 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2269 : Nat.Prime 2269 := by
  apply lucasNat 2269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2269 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_2381 : Nat.Prime 2381 := by
  apply lucasNat 2381 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2381 - 1 = 2 * (2 * (5 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2417 : Nat.Prime 2417 := by
  apply lucasNat 2417 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2417 - 1 = 2 * (2 * (2 * (2 * (151)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2917 : Nat.Prime 2917 := by
  apply lucasNat 2917 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2917 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (3 * (3))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_3119 : Nat.Prime 3119 := by
  apply lucasNat 3119 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3119 - 1 = 2 * (1559) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1559] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_3637 : Nat.Prime 3637 := by
  apply lucasNat 3637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3637 - 1 = 2 * (2 * (3 * (3 * (101)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_4049 : Nat.Prime 4049 := by
  apply lucasNat 4049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4049 - 1 = 2 * (2 * (2 * (2 * (11 * (23))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_4201 : Nat.Prime 4201 := by
  apply lucasNat 4201 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4201 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_4211 : Nat.Prime 4211 := by
  apply lucasNat 4211 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4211 - 1 = 2 * (5 * (421)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_421] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_4409 : Nat.Prime 4409 := by
  apply lucasNat 4409 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4409 - 1 = 2 * (2 * (2 * (19 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_4463 : Nat.Prime 4463 := by
  apply lucasNat 4463 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4463 - 1 = 2 * (23 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_4651 : Nat.Prime 4651 := by
  apply lucasNat 4651 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4651 - 1 = 2 * (3 * (5 * (5 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_4967 : Nat.Prime 4967 := by
  apply lucasNat 4967 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4967 - 1 = 2 * (13 * (191)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_191] at hd
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

theorem prime_5437 : Nat.Prime 5437 := by
  apply lucasNat 5437 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5437 - 1 = 2 * (2 * (3 * (3 * (151)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_6121 : Nat.Prime 6121 := by
  apply lucasNat 6121 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6121 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (17)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_6143 : Nat.Prime 6143 := by
  apply lucasNat 6143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6143 - 1 = 2 * (37 * (83)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_8893 : Nat.Prime 8893 := by
  apply lucasNat 8893 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8893 - 1 = 2 * (2 * (3 * (3 * (13 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_10453 : Nat.Prime 10453 := by
  apply lucasNat 10453 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10453 - 1 = 2 * (2 * (3 * (13 * (67)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_10559 : Nat.Prime 10559 := by
  apply lucasNat 10559 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10559 - 1 = 2 * (5279) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5279] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_12049 : Nat.Prime 12049 := by
  apply lucasNat 12049 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12049 - 1 = 2 * (2 * (2 * (2 * (3 * (251))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_15217 : Nat.Prime 15217 := by
  apply lucasNat 15217 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15217 - 1 = 2 * (2 * (2 * (2 * (3 * (317))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_317] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_16339 : Nat.Prime 16339 := by
  apply lucasNat 16339 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16339 - 1 = 2 * (3 * (7 * (389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_16493 : Nat.Prime 16493 := by
  apply lucasNat 16493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16493 - 1 = 2 * (2 * (7 * (19 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_16651 : Nat.Prime 16651 := by
  apply lucasNat 16651 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16651 - 1 = 2 * (3 * (3 * (5 * (5 * (37))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_21121 : Nat.Prime 21121 := by
  apply lucasNat 21121 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21121 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (11))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel

theorem prime_23321 : Nat.Prime 23321 := by
  apply lucasNat 23321 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23321 - 1 = 2 * (2 * (2 * (5 * (11 * (53))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_24097 : Nat.Prime 24097 := by
  apply lucasNat 24097 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24097 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (251)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_24953 : Nat.Prime 24953 := by
  apply lucasNat 24953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24953 - 1 = 2 * (2 * (2 * (3119))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3119] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_26263 : Nat.Prime 26263 := by
  apply lucasNat 26263 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 26263 - 1 = 2 * (3 * (3 * (1459))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1459] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_29023 : Nat.Prime 29023 := by
  apply lucasNat 29023 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29023 - 1 = 2 * (3 * (7 * (691))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_691] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_29191 : Nat.Prime 29191 := by
  apply lucasNat 29191 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29191 - 1 = 2 * (3 * (5 * (7 * (139)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_139] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_30241 : Nat.Prime 30241 := by
  apply lucasNat 30241 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 30241 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (3 * (5 * (7))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel

theorem prime_32987 : Nat.Prime 32987 := by
  apply lucasNat 32987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32987 - 1 = 2 * (16493) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_16493] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_33871 : Nat.Prime 33871 := by
  apply lucasNat 33871 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33871 - 1 = 2 * (3 * (5 * (1129))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1129] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_38039 : Nat.Prime 38039 := by
  apply lucasNat 38039 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 38039 - 1 = 2 * (7 * (11 * (13 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_45841 : Nat.Prime 45841 := by
  apply lucasNat 45841 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 45841 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (191)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_191] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_49957 : Nat.Prime 49957 := by
  apply lucasNat 49957 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49957 - 1 = 2 * (2 * (3 * (23 * (181)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_51539 : Nat.Prime 51539 := by
  apply lucasNat 51539 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 51539 - 1 = 2 * (73 * (353)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_353] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_52807 : Nat.Prime 52807 := by
  apply lucasNat 52807 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 52807 - 1 = 2 * (3 * (13 * (677))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_677] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_59273 : Nat.Prime 59273 := by
  apply lucasNat 59273 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59273 - 1 = 2 * (2 * (2 * (31 * (239)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_60703 : Nat.Prime 60703 := by
  apply lucasNat 60703 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 60703 - 1 = 2 * (3 * (67 * (151))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_66173 : Nat.Prime 66173 := by
  apply lucasNat 66173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 66173 - 1 = 2 * (2 * (71 * (233))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_72287 : Nat.Prime 72287 := by
  apply lucasNat 72287 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 72287 - 1 = 2 * (47 * (769)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_769] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_76079 : Nat.Prime 76079 := by
  apply lucasNat 76079 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 76079 - 1 = 2 * (38039) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_38039] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_86501 : Nat.Prime 86501 := by
  apply lucasNat 86501 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 86501 - 1 = 2 * (2 * (5 * (5 * (5 * (173))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_87511 : Nat.Prime 87511 := by
  apply lucasNat 87511 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 87511 - 1 = 2 * (3 * (5 * (2917))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2917] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_90073 : Nat.Prime 90073 := by
  apply lucasNat 90073 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 90073 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (3 * (139))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_139] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_91303 : Nat.Prime 91303 := by
  apply lucasNat 91303 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 91303 - 1 = 2 * (3 * (15217)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_15217] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_96487 : Nat.Prime 96487 := by
  apply lucasNat 96487 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 96487 - 1 = 2 * (3 * (13 * (1237))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1237] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_103079 : Nat.Prime 103079 := by
  apply lucasNat 103079 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 103079 - 1 = 2 * (51539) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_51539] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_132347 : Nat.Prime 132347 := by
  apply lucasNat 132347 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 132347 - 1 = 2 * (66173) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_66173] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_191791 : Nat.Prime 191791 := by
  apply lucasNat 191791 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191791 - 1 = 2 * (3 * (3 * (5 * (2131)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2131] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_192239 : Nat.Prime 192239 := by
  apply lucasNat 192239 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 192239 - 1 = 2 * (277 * (347)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_277, Nat.prime_dvd_prime_iff_eq hq prime_347] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_199813 : Nat.Prime 199813 := by
  apply lucasNat 199813 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199813 - 1 = 2 * (2 * (3 * (16651))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_16651] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_237287 : Nat.Prime 237287 := by
  apply lucasNat 237287 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 237287 - 1 = 2 * (7 * (17 * (997))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_997] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_275047 : Nat.Prime 275047 := by
  apply lucasNat 275047 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 275047 - 1 = 2 * (3 * (45841)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_45841] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_320149 : Nat.Prime 320149 := by
  apply lucasNat 320149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 320149 - 1 = 2 * (2 * (3 * (3 * (8893)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_8893] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_379699 : Nat.Prime 379699 := by
  apply lucasNat 379699 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 379699 - 1 = 2 * (3 * (11 * (11 * (523)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_523] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_442829 : Nat.Prime 442829 := by
  apply lucasNat 442829 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 442829 - 1 = 2 * (2 * (149 * (743))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_743] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_467587 : Nat.Prime 467587 := by
  apply lucasNat 467587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 467587 - 1 = 2 * (3 * (3 * (3 * (7 * (1237))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1237] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_499181 : Nat.Prime 499181 := by
  apply lucasNat 499181 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 499181 - 1 = 2 * (2 * (5 * (11 * (2269)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_2269] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_525439 : Nat.Prime 525439 := by
  apply lucasNat 525439 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 525439 - 1 = 2 * (3 * (3 * (29191))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29191] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_615187 : Nat.Prime 615187 := by
  apply lucasNat 615187 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 615187 - 1 = 2 * (3 * (3 * (11 * (13 * (239))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_1079963 : Nat.Prime 1079963 := by
  apply lucasNat 1079963 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1079963 - 1 = 2 * (13 * (73 * (569))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_569] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1113197 : Nat.Prime 1113197 := by
  apply lucasNat 1113197 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1113197 - 1 = 2 * (2 * (7 * (83 * (479)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_479] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1450201 : Nat.Prime 1450201 := by
  apply lucasNat 1450201 31 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1450201 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (2417)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2417] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_1574857 : Nat.Prime 1574857 := by
  apply lucasNat 1574857 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1574857 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (23 * (317))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_317] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_1894643 : Nat.Prime 1894643 := by
  apply lucasNat 1894643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1894643 - 1 = 2 * (19 * (73 * (683))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_683] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1900891 : Nat.Prime 1900891 := by
  apply lucasNat 1900891 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1900891 - 1 = 2 * (3 * (3 * (5 * (21121)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_21121] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1939493 : Nat.Prime 1939493 := by
  apply lucasNat 1939493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1939493 - 1 = 2 * (2 * (233 * (2081))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_233, Nat.prime_dvd_prime_iff_eq hq prime_2081] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2434529 : Nat.Prime 2434529 := by
  apply lucasNat 2434529 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2434529 - 1 = 2 * (2 * (2 * (2 * (2 * (76079))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_76079] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_2898029 : Nat.Prime 2898029 := by
  apply lucasNat 2898029 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2898029 - 1 = 2 * (2 * (7 * (29 * (43 * (83))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_2900951 : Nat.Prime 2900951 := by
  apply lucasNat 2900951 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2900951 - 1 = 2 * (5 * (5 * (13 * (4463)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_4463] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_4318081 : Nat.Prime 4318081 := by
  apply lucasNat 4318081 21 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4318081 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (13 * (173)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel

theorem prime_4764493 : Nat.Prime 4764493 := by
  apply lucasNat 4764493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4764493 - 1 = 2 * (2 * (3 * (3 * (132347)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_132347] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_5001001 : Nat.Prime 5001001 := by
  apply lucasNat 5001001 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5001001 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (5 * (1667))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1667] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_5269573 : Nat.Prime 5269573 := by
  apply lucasNat 5269573 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5269573 - 1 = 2 * (2 * (3 * (3 * (7 * (11 * (1901)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1901] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_5321737 : Nat.Prime 5321737 := by
  apply lucasNat 5321737 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5321737 - 1 = 2 * (2 * (2 * (3 * (3 * (7 * (10559)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_10559] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_7236371 : Nat.Prime 7236371 := by
  apply lucasNat 7236371 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7236371 - 1 = 2 * (5 * (29 * (24953))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_24953] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_10009133 : Nat.Prime 10009133 := by
  apply lucasNat 10009133 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10009133 - 1 = 2 * (2 * (7 * (7 * (223 * (229))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_11222089 : Nat.Prime 11222089 := by
  apply lucasNat 11222089 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11222089 - 1 = 2 * (2 * (2 * (3 * (467587)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_467587] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_11673913 : Nat.Prime 11673913 := by
  apply lucasNat 11673913 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11673913 - 1 = 2 * (2 * (2 * (3 * (401 * (1213))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_401, Nat.prime_dvd_prime_iff_eq hq prime_1213] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_29241701 : Nat.Prime 29241701 := by
  apply lucasNat 29241701 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29241701 - 1 = 2 * (2 * (5 * (5 * (17 * (103 * (167)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_29320381 : Nat.Prime 29320381 := by
  apply lucasNat 29320381 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 29320381 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (3 * (3 * (5 * (2011))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2011] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel

theorem prime_34776349 : Nat.Prime 34776349 := by
  apply lucasNat 34776349 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 34776349 - 1 = 2 * (2 * (3 * (2898029))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2898029] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_36911221 : Nat.Prime 36911221 := by
  apply lucasNat 36911221 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36911221 - 1 = 2 * (2 * (3 * (5 * (615187)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_615187] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_45107089 : Nat.Prime 45107089 := by
  apply lucasNat 45107089 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 45107089 - 1 = 2 * (2 * (2 * (2 * (3 * (13 * (72287)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_72287] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_52067263 : Nat.Prime 52067263 := by
  apply lucasNat 52067263 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 52067263 - 1 = 2 * (3 * (13 * (23 * (29023)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_29023] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_53254163 : Nat.Prime 53254163 := by
  apply lucasNat 53254163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53254163 - 1 = 2 * (13 * (41 * (49957))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_49957] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_150030031 : Nat.Prime 150030031 := by
  apply lucasNat 150030031 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 150030031 - 1 = 2 * (3 * (5 * (5001001))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_5001001] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_162453257 : Nat.Prime 162453257 := by
  apply lucasNat 162453257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 162453257 - 1 = 2 * (2 * (2 * (7 * (2900951)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2900951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_180428357 : Nat.Prime 180428357 := by
  apply lucasNat 180428357 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 180428357 - 1 = 2 * (2 * (45107089)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_45107089] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_198271433 : Nat.Prime 198271433 := by
  apply lucasNat 198271433 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 198271433 - 1 = 2 * (2 * (2 * (4049 * (6121)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_4049, Nat.prime_dvd_prime_iff_eq hq prime_6121] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_241911713 : Nat.Prime 241911713 := by
  apply lucasNat 241911713 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 241911713 - 1 = 2 * (2 * (2 * (2 * (2 * (7 * (1079963)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1079963] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_242400359 : Nat.Prime 242400359 := by
  apply lucasNat 242400359 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 242400359 - 1 = 2 * (23 * (5269573)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_5269573] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_414303103 : Nat.Prime 414303103 := by
  apply lucasNat 414303103 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 414303103 - 1 = 2 * (3 * (3 * (97 * (237287)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_97, Nat.prime_dvd_prime_iff_eq hq prime_237287] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_530787877 : Nat.Prime 530787877 := by
  apply lucasNat 530787877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 530787877 - 1 = 2 * (2 * (3 * (19 * (439 * (5303))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_439, Nat.prime_dvd_prime_iff_eq hq prime_5303] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_658048847 : Nat.Prime 658048847 := by
  apply lucasNat 658048847 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 658048847 - 1 = 2 * (7 * (13 * (61 * (59273)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_59273] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_892727881 : Nat.Prime 892727881 := by
  apply lucasNat 892727881 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 892727881 - 1 = 2 * (2 * (2 * (3 * (5 * (11 * (29 * (23321))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_23321] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_1146041453 : Nat.Prime 1146041453 := by
  apply lucasNat 1146041453 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1146041453 - 1 = 2 * (2 * (647 * (442829))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_647, Nat.prime_dvd_prime_iff_eq hq prime_442829] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1376070581 : Nat.Prime 1376070581 := by
  apply lucasNat 1376070581 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1376070581 - 1 = 2 * (2 * (5 * (4211 * (16339)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_4211, Nat.prime_dvd_prime_iff_eq hq prime_16339] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1939202873 : Nat.Prime 1939202873 := by
  apply lucasNat 1939202873 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1939202873 - 1 = 2 * (2 * (2 * (242400359))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_242400359] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_9100653841 : Nat.Prime 9100653841 := by
  apply lucasNat 9100653841 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9100653841 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (5 * (131 * (96487)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_96487] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_9212683859 : Nat.Prime 9212683859 := by
  apply lucasNat 9212683859 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9212683859 - 1 = 2 * (7 * (658048847)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_658048847] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_9388937323 : Nat.Prime 9388937323 := by
  apply lucasNat 9388937323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9388937323 - 1 = 2 * (3 * (3 * (173 * (829 * (3637))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_829, Nat.prime_dvd_prime_iff_eq hq prime_3637] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_10664760949 : Nat.Prime 10664760949 := by
  apply lucasNat 10664760949 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10664760949 - 1 = 2 * (2 * (3 * (167 * (5321737)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_5321737] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_11940040187 : Nat.Prime 11940040187 := by
  apply lucasNat 11940040187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11940040187 - 1 = 2 * (23 * (137 * (1894643))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_1894643] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_14130105589 : Nat.Prime 14130105589 := by
  apply lucasNat 14130105589 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14130105589 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (83 * (525439))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_525439] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_17098868191 : Nat.Prime 17098868191 := by
  apply lucasNat 17098868191 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17098868191 - 1 = 2 * (3 * (5 * (211 * (643 * (4201))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_211, Nat.prime_dvd_prime_iff_eq hq prime_643, Nat.prime_dvd_prime_iff_eq hq prime_4201] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_22737312137 : Nat.Prime 22737312137 := by
  apply lucasNat 22737312137 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22737312137 - 1 = 2 * (2 * (2 * (7 * (11 * (36911221))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_36911221] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_39959240663 : Nat.Prime 39959240663 := by
  apply lucasNat 39959240663 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 39959240663 - 1 = 2 * (11 * (251 * (7236371))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_7236371] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_59406645533 : Nat.Prime 59406645533 := by
  apply lucasNat 59406645533 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 59406645533 - 1 = 2 * (2 * (13 * (601 * (1900891)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_601, Nat.prime_dvd_prime_iff_eq hq prime_1900891] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_70811429389 : Nat.Prime 70811429389 := by
  apply lucasNat 70811429389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 70811429389 - 1 = 2 * (2 * (3 * (7 * (7 * (7 * (191 * (90073))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_191, Nat.prime_dvd_prime_iff_eq hq prime_90073] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_171866220913 : Nat.Prime 171866220913 := by
  apply lucasNat 171866220913 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 171866220913 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (823 * (1450201))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_823, Nat.prime_dvd_prime_iff_eq hq prime_1450201] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_232228478959 : Nat.Prime 232228478959 := by
  apply lucasNat 232228478959 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 232228478959 - 1 = 2 * (3 * (7 * (4967 * (1113197)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_4967, Nat.prime_dvd_prime_iff_eq hq prime_1113197] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_672736086907 : Nat.Prime 672736086907 := by
  apply lucasNat 672736086907 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 672736086907 - 1 = 2 * (3 * (13 * (67 * (1471 * (87511))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_1471, Nat.prime_dvd_prime_iff_eq hq prime_87511] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_6157787093873 : Nat.Prime 6157787093873 := by
  apply lucasNat 6157787093873 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6157787093873 - 1 = 2 * (2 * (2 * (2 * (241 * (30241 * (52807)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_30241, Nat.prime_dvd_prime_iff_eq hq prime_52807] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_12315574187747 : Nat.Prime 12315574187747 := by
  apply lucasNat 12315574187747 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12315574187747 - 1 = 2 * (6157787093873) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_6157787093873] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel

theorem prime_27664813046491 : Nat.Prime 27664813046491 := by
  apply lucasNat 27664813046491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 27664813046491 - 1 = 2 * (3 * (5 * (4651 * (198271433)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_4651, Nat.prime_dvd_prime_iff_eq hq prime_198271433] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_27920482267609 : Nat.Prime 27920482267609 := by
  apply lucasNat 27920482267609 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 27920482267609 - 1 = 2 * (2 * (2 * (3 * (3 * (7 * (229 * (241911713))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_229, Nat.prime_dvd_prime_iff_eq hq prime_241911713] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_103842159402281 : Nat.Prime 103842159402281 := by
  apply lucasNat 103842159402281 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 103842159402281 - 1 = 2 * (2 * (2 * (5 * (13 * (29 * (137 * (157 * (320149)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_320149] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_202531641956257 : Nat.Prime 202531641956257 := by
  apply lucasNat 202531641956257 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 202531641956257 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (229 * (9212683859))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_229, Nat.prime_dvd_prime_iff_eq hq prime_9212683859] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_320204928881423 : Nat.Prime 320204928881423 := by
  apply lucasNat 320204928881423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 320204928881423 - 1 = 2 * (13 * (12315574187747)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_12315574187747] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_655093339115143 : Nat.Prime 655093339115143 := by
  apply lucasNat 655093339115143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 655093339115143 - 1 = 2 * (3 * (47 * (2027 * (1146041453)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_2027, Nat.prime_dvd_prime_iff_eq hq prime_1146041453] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_891265592730923 : Nat.Prime 891265592730923 := by
  apply lucasNat 891265592730923 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 891265592730923 - 1 = 2 * (499181 * (892727881)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_499181, Nat.prime_dvd_prime_iff_eq hq prime_892727881] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_2406738862073333 : Nat.Prime 2406738862073333 := by
  apply lucasNat 2406738862073333 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2406738862073333 - 1 = 2 * (2 * (29 * (293 * (70811429389)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_293, Nat.prime_dvd_prime_iff_eq hq prime_70811429389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_5050505036321471 : Nat.Prime 5050505036321471 := by
  apply lucasNat 5050505036321471 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5050505036321471 - 1 = 2 * (5 * (11 * (86501 * (530787877)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_86501, Nat.prime_dvd_prime_iff_eq hq prime_530787877] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_27777777282201827 : Nat.Prime 27777777282201827 := by
  apply lucasNat 27777777282201827 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 27777777282201827 - 1 = 2 * (11 * (5437 * (232228478959))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_5437, Nat.prime_dvd_prime_iff_eq hq prime_232228478959] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_60606060435857653 : Nat.Prime 60606060435857653 := by
  apply lucasNat 60606060435857653 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 60606060435857653 - 1 = 2 * (2 * (3 * (5050505036321471))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5050505036321471] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_222222218257590197 : Nat.Prime 222222218257590197 := by
  apply lucasNat 222222218257590197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 222222218257590197 - 1 = 2 * (2 * (467 * (1049 * (26263 * (4318081))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_467, Nat.prime_dvd_prime_iff_eq hq prime_1049, Nat.prime_dvd_prime_iff_eq hq prime_26263, Nat.prime_dvd_prime_iff_eq hq prime_4318081] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_333333331681365203 : Nat.Prime 333333331681365203 := by
  apply lucasNat 333333331681365203 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 333333331681365203 - 1 = 2 * (11 * (17 * (891265592730923))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_891265592730923] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1999999985792685463 : Nat.Prime 1999999985792685463 := by
  apply lucasNat 1999999985792685463 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999985792685463 - 1 = 2 * (3 * (3 * (41 * (191791 * (14130105589))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_191791, Nat.prime_dvd_prime_iff_eq hq prime_14130105589] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_1999999985792775139 : Nat.Prime 1999999985792775139 := by
  apply lucasNat 1999999985792775139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999985792775139 - 1 = 2 * (3 * (3 * (23 * (43 * (167 * (672736086907)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_672736086907] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_1999999985793034427 : Nat.Prime 1999999985793034427 := by
  apply lucasNat 1999999985793034427 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999985793034427 - 1 = 2 * (60703 * (91303 * (180428357))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_60703, Nat.prime_dvd_prime_iff_eq hq prime_91303, Nat.prime_dvd_prime_iff_eq hq prime_180428357] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_1999999985793146801 : Nat.Prime 1999999985793146801 := by
  apply lucasNat 1999999985793146801 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999985793146801 - 1 = 2 * (2 * (2 * (2 * (5 * (5 * (107 * (24097 * (1939202873)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_107, Nat.prime_dvd_prime_iff_eq hq prime_24097, Nat.prime_dvd_prime_iff_eq hq prime_1939202873] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel

theorem prime_1999999985793367889 : Nat.Prime 1999999985793367889 := by
  apply lucasNat 1999999985793367889 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999985793367889 - 1 = 2 * (2 * (2 * (2 * (11 * (11 * (37 * (27920482267609))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_27920482267609] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_1999999985793367949 : Nat.Prime 1999999985793367949 := by
  apply lucasNat 1999999985793367949 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999985793367949 - 1 = 2 * (2 * (13 * (41 * (103079 * (9100653841))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_103079, Nat.prime_dvd_prime_iff_eq hq prime_9100653841] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_1999999985793368059 : Nat.Prime 1999999985793368059 := by
  apply lucasNat 1999999985793368059 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999985793368059 - 1 = 2 * (3 * (3 * (347 * (320204928881423)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_347, Nat.prime_dvd_prime_iff_eq hq prime_320204928881423] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1999999985793368063 : Nat.Prime 1999999985793368063 := by
  apply lucasNat 1999999985793368063 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999985793368063 - 1 = 2 * (7 * (10453 * (32987 * (414303103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_10453, Nat.prime_dvd_prime_iff_eq hq prime_32987, Nat.prime_dvd_prime_iff_eq hq prime_414303103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3999999928636075751 : Nat.Prime 3999999928636075751 := by
  apply lucasNat 3999999928636075751 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999928636075751 - 1 = 2 * (5 * (5 * (5 * (79 * (202531641956257))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_202531641956257] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_3999999928636585183 : Nat.Prime 3999999928636585183 := by
  apply lucasNat 3999999928636585183 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999928636585183 - 1 = 2 * (3 * (29320381 * (22737312137))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29320381, Nat.prime_dvd_prime_iff_eq hq prime_22737312137] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999928636623547 : Nat.Prime 3999999928636623547 := by
  apply lucasNat 3999999928636623547 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999928636623547 - 1 = 2 * (3 * (3 * (222222218257590197))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_222222218257590197] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999928636925483 : Nat.Prime 3999999928636925483 := by
  apply lucasNat 3999999928636925483 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999928636925483 - 1 = 2 * (192239 * (199813 * (52067263))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_192239, Nat.prime_dvd_prime_iff_eq hq prime_199813, Nat.prime_dvd_prime_iff_eq hq prime_52067263] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999928637063089 : Nat.Prime 3999999928637063089 := by
  apply lucasNat 3999999928637063089 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999928637063089 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (27777777282201827)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_27777777282201827] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_3999999928637063093 : Nat.Prime 3999999928637063093 := by
  apply lucasNat 3999999928637063093 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999928637063093 - 1 = 2 * (2 * (7 * (79 * (241 * (1574857 * (4764493)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_1574857, Nat.prime_dvd_prime_iff_eq hq prime_4764493] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_3999999928637063129 : Nat.Prime 3999999928637063129 := by
  apply lucasNat 3999999928637063129 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999928637063129 - 1 = 2 * (2 * (2 * (29241701 * (17098868191)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29241701, Nat.prime_dvd_prime_iff_eq hq prime_17098868191] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3999999928637063159 : Nat.Prime 3999999928637063159 := by
  apply lucasNat 3999999928637063159 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999928637063159 - 1 = 2 * (43 * (71 * (655093339115143))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_655093339115143] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999980175864121 : Nat.Prime 3999999980175864121 := by
  apply lucasNat 3999999980175864121 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999980175864121 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (107 * (103842159402281))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_107, Nat.prime_dvd_prime_iff_eq hq prime_103842159402281] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_3999999980176195003 : Nat.Prime 3999999980176195003 := by
  apply lucasNat 3999999980176195003 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999980176195003 - 1 = 2 * (3 * (7 * (29 * (275047 * (11940040187))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_275047, Nat.prime_dvd_prime_iff_eq hq prime_11940040187] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_3999999980176382437 : Nat.Prime 3999999980176382437 := by
  apply lucasNat 3999999980176382437 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999980176382437 - 1 = 2 * (2 * (3 * (333333331681365203))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_333333331681365203] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999980176594789 : Nat.Prime 3999999980176594789 := by
  apply lucasNat 3999999980176594789 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999980176594789 - 1 = 2 * (2 * (3 * (17 * (17 * (2917 * (33871 * (11673913))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_2917, Nat.prime_dvd_prime_iff_eq hq prime_33871, Nat.prime_dvd_prime_iff_eq hq prime_11673913] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_3999999980176670593 : Nat.Prime 3999999980176670593 := by
  apply lucasNat 3999999980176670593 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999980176670593 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (53 * (6143 * (10664760949))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_6143, Nat.prime_dvd_prime_iff_eq hq prime_10664760949] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel

theorem prime_3999999980176670623 : Nat.Prime 3999999980176670623 := by
  apply lucasNat 3999999980176670623 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999980176670623 - 1 = 2 * (3 * (11222089 * (59406645533))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11222089, Nat.prime_dvd_prime_iff_eq hq prime_59406645533] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999980176670627 : Nat.Prime 3999999980176670627 := by
  apply lucasNat 3999999980176670627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999980176670627 - 1 = 2 * (13 * (61 * (191 * (379699 * (34776349))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_191, Nat.prime_dvd_prime_iff_eq hq prime_379699, Nat.prime_dvd_prime_iff_eq hq prime_34776349] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_3999999980176670707 : Nat.Prime 3999999980176670707 := by
  apply lucasNat 3999999980176670707 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999980176670707 - 1 = 2 * (3 * (199 * (2434529 * (1376070581)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_199, Nat.prime_dvd_prime_iff_eq hq prime_2434529, Nat.prime_dvd_prime_iff_eq hq prime_1376070581] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3999999988765673297 : Nat.Prime 3999999988765673297 := by
  apply lucasNat 3999999988765673297 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988765673297 - 1 = 2 * (2 * (2 * (2 * (457 * (827 * (4409 * (150030031))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_457, Nat.prime_dvd_prime_iff_eq hq prime_827, Nat.prime_dvd_prime_iff_eq hq prime_4409, Nat.prime_dvd_prime_iff_eq hq prime_150030031] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel

theorem prime_3999999988765879447 : Nat.Prime 3999999988765879447 := by
  apply lucasNat 3999999988765879447 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988765879447 - 1 = 2 * (3 * (277 * (2406738862073333))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_277, Nat.prime_dvd_prime_iff_eq hq prime_2406738862073333] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_3999999988766040709 : Nat.Prime 3999999988766040709 := by
  apply lucasNat 3999999988766040709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766040709 - 1 = 2 * (2 * (3 * (12049 * (27664813046491)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_12049, Nat.prime_dvd_prime_iff_eq hq prime_27664813046491] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3999999988766107327 : Nat.Prime 3999999988766107327 := by
  apply lucasNat 3999999988766107327 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766107327 - 1 = 2 * (3 * (7 * (7 * (11 * (13 * (2381 * (39959240663))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_2381, Nat.prime_dvd_prime_iff_eq hq prime_39959240663] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
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

#print axioms prime_3999999988766605309
#print axioms prime_3999999988766605261
#print axioms prime_3999999988766605193
#print axioms prime_3999999988766605099
#print axioms prime_3999999988765673297
#print axioms prime_3999999988766107327
#print axioms prime_3999999988766040709
#print axioms prime_3999999988765879447
#print axioms prime_3999999980176670707
#print axioms prime_3999999980176670627
#print axioms prime_3999999980176670623
#print axioms prime_3999999980176670593
#print axioms prime_3999999980175864121
#print axioms prime_3999999980176594789
#print axioms prime_3999999980176195003
#print axioms prime_3999999980176382437
#print axioms prime_3999999928637063159
#print axioms prime_3999999928637063129
#print axioms prime_3999999928637063093
#print axioms prime_3999999928637063089
#print axioms prime_3999999928636075751
#print axioms prime_3999999928636623547
#print axioms prime_3999999928636585183
#print axioms prime_3999999928636925483
#print axioms prime_1999999985793368063
#print axioms prime_1999999985793368059
#print axioms prime_1999999985793367949
#print axioms prime_1999999985793367889
#print axioms prime_1999999985792685463
#print axioms prime_1999999985793146801
#print axioms prime_1999999985792775139
#print axioms prime_1999999985793034427
#check prime_3999999988766605309
#check prime_3999999988766605261
#check prime_3999999988766605193
#check prime_3999999988766605099
#check prime_3999999988765673297
#check prime_3999999988766107327
#check prime_3999999988766040709
#check prime_3999999988765879447
#check prime_3999999980176670707
#check prime_3999999980176670627
#check prime_3999999980176670623
#check prime_3999999980176670593
#check prime_3999999980175864121
#check prime_3999999980176594789
#check prime_3999999980176195003
#check prime_3999999980176382437
#check prime_3999999928637063159
#check prime_3999999928637063129
#check prime_3999999928637063093
#check prime_3999999928637063089
#check prime_3999999928636075751
#check prime_3999999928636623547
#check prime_3999999928636585183
#check prime_3999999928636925483
#check prime_1999999985793368063
#check prime_1999999985793368059
#check prime_1999999985793367949
#check prime_1999999985793367889
#check prime_1999999985792685463
#check prime_1999999985793146801
#check prime_1999999985792775139
#check prime_1999999985793034427
