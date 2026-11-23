import Primes1024Part07
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
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
end FiniteP0N1024
