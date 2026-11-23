import Primes1024Part03
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
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
end FiniteP0N1024
