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

theorem prime_137 : Nat.Prime 137 := by
  apply lucasNat 137 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 137 - 1 = 2 * (2 * (2 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_151 : Nat.Prime 151 := by
  apply lucasNat 151 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151 - 1 = 2 * (3 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3
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

theorem prime_823 : Nat.Prime 823 := by
  apply lucasNat 823 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 823 - 1 = 2 * (3 * (137)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_137] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_829 : Nat.Prime 829 := by
  apply lucasNat 829 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 829 - 1 = 2 * (2 * (3 * (3 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_2081 : Nat.Prime 2081 := by
  apply lucasNat 2081 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2081 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (13)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_2417 : Nat.Prime 2417 := by
  apply lucasNat 2417 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2417 - 1 = 2 * (2 * (2 * (2 * (151)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_3637 : Nat.Prime 3637 := by
  apply lucasNat 3637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3637 - 1 = 2 * (2 * (3 * (3 * (101)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_4463 : Nat.Prime 4463 := by
  apply lucasNat 4463 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4463 - 1 = 2 * (23 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel

theorem prime_49957 : Nat.Prime 49957 := by
  apply lucasNat 49957 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49957 - 1 = 2 * (2 * (3 * (23 * (181)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_1450201 : Nat.Prime 1450201 := by
  apply lucasNat 1450201 31 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1450201 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (2417)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2417] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel

theorem prime_1939493 : Nat.Prime 1939493 := by
  apply lucasNat 1939493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1939493 - 1 = 2 * (2 * (233 * (2081))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_233, Nat.prime_dvd_prime_iff_eq hq prime_2081] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_2900951 : Nat.Prime 2900951 := by
  apply lucasNat 2900951 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2900951 - 1 = 2 * (5 * (5 * (13 * (4463)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_4463] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_10009133 : Nat.Prime 10009133 := by
  apply lucasNat 10009133 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10009133 - 1 = 2 * (2 * (7 * (7 * (223 * (229))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_53254163 : Nat.Prime 53254163 := by
  apply lucasNat 53254163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 53254163 - 1 = 2 * (13 * (41 * (49957))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_49957] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel

theorem prime_162453257 : Nat.Prime 162453257 := by
  apply lucasNat 162453257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 162453257 - 1 = 2 * (2 * (2 * (7 * (2900951)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2900951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel

theorem prime_9388937323 : Nat.Prime 9388937323 := by
  apply lucasNat 9388937323 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9388937323 - 1 = 2 * (3 * (3 * (173 * (829 * (3637))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_829, Nat.prime_dvd_prime_iff_eq hq prime_3637] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel

theorem prime_171866220913 : Nat.Prime 171866220913 := by
  apply lucasNat 171866220913 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 171866220913 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (823 * (1450201))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_823, Nat.prime_dvd_prime_iff_eq hq prime_1450201] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
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
#check prime_3999999988766605309
#check prime_3999999988766605261
#check prime_3999999988766605193
