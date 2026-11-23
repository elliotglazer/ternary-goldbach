import Primes1024Part02
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
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
end FiniteP0N1024
