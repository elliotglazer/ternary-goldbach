import Primes1024Part08
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
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
end FiniteP0N1024
