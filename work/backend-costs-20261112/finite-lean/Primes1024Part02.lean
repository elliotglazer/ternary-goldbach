import Primes1024Part01
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
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
end FiniteP0N1024
