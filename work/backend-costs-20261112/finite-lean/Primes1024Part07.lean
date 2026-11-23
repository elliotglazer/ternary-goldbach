import Primes1024Part06
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
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
end FiniteP0N1024
