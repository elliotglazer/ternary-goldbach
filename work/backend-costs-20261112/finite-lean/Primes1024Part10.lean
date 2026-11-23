import Primes1024Part09
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
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
end FiniteP0N1024
