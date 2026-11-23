import Primes1024Part00
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
theorem prime_787 : Nat.Prime 787 := by
  apply lucasNat 787 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 787 - 1 = 2 * (3 * (131)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_797 : Nat.Prime 797 := by
  apply lucasNat 797 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 797 - 1 = 2 * (2 * (199)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_199] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_809 : Nat.Prime 809 := by
  apply lucasNat 809 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 809 - 1 = 2 * (2 * (2 * (101))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_811 : Nat.Prime 811 := by
  apply lucasNat 811 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 811 - 1 = 2 * (3 * (3 * (3 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_821 : Nat.Prime 821 := by
  apply lucasNat 821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 821 - 1 = 2 * (2 * (5 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
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
theorem prime_853 : Nat.Prime 853 := by
  apply lucasNat 853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 853 - 1 = 2 * (2 * (3 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_857 : Nat.Prime 857 := by
  apply lucasNat 857 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 857 - 1 = 2 * (2 * (2 * (107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_859 : Nat.Prime 859 := by
  apply lucasNat 859 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 859 - 1 = 2 * (3 * (11 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_863 : Nat.Prime 863 := by
  apply lucasNat 863 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 863 - 1 = 2 * (431) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_431] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_883 : Nat.Prime 883 := by
  apply lucasNat 883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 883 - 1 = 2 * (3 * (3 * (7 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_887 : Nat.Prime 887 := by
  apply lucasNat 887 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 887 - 1 = 2 * (443) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_443] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_907 : Nat.Prime 907 := by
  apply lucasNat 907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 907 - 1 = 2 * (3 * (151)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_911 : Nat.Prime 911 := by
  apply lucasNat 911 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 911 - 1 = 2 * (5 * (7 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_919 : Nat.Prime 919 := by
  apply lucasNat 919 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 919 - 1 = 2 * (3 * (3 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_929 : Nat.Prime 929 := by
  apply lucasNat 929 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 929 - 1 = 2 * (2 * (2 * (2 * (2 * (29))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_941 : Nat.Prime 941 := by
  apply lucasNat 941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 941 - 1 = 2 * (2 * (5 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_947 : Nat.Prime 947 := by
  apply lucasNat 947 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 947 - 1 = 2 * (11 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_953 : Nat.Prime 953 := by
  apply lucasNat 953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 953 - 1 = 2 * (2 * (2 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_967 : Nat.Prime 967 := by
  apply lucasNat 967 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 967 - 1 = 2 * (3 * (7 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_977 : Nat.Prime 977 := by
  apply lucasNat 977 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 977 - 1 = 2 * (2 * (2 * (2 * (61)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_983 : Nat.Prime 983 := by
  apply lucasNat 983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 983 - 1 = 2 * (491) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_491] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_991 : Nat.Prime 991 := by
  apply lucasNat 991 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 991 - 1 = 2 * (3 * (3 * (5 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_997 : Nat.Prime 997 := by
  apply lucasNat 997 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 997 - 1 = 2 * (2 * (3 * (83))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1009 : Nat.Prime 1009 := by
  apply lucasNat 1009 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1009 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1013 : Nat.Prime 1013 := by
  apply lucasNat 1013 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1013 - 1 = 2 * (2 * (11 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1021 : Nat.Prime 1021 := by
  apply lucasNat 1021 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1021 - 1 = 2 * (2 * (3 * (5 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1031 : Nat.Prime 1031 := by
  apply lucasNat 1031 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1031 - 1 = 2 * (5 * (103)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1033 : Nat.Prime 1033 := by
  apply lucasNat 1033 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1033 - 1 = 2 * (2 * (2 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1039 : Nat.Prime 1039 := by
  apply lucasNat 1039 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1039 - 1 = 2 * (3 * (173)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1049 : Nat.Prime 1049 := by
  apply lucasNat 1049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1049 - 1 = 2 * (2 * (2 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1061 : Nat.Prime 1061 := by
  apply lucasNat 1061 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1061 - 1 = 2 * (2 * (5 * (53))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1087 : Nat.Prime 1087 := by
  apply lucasNat 1087 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1087 - 1 = 2 * (3 * (181)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1093 : Nat.Prime 1093 := by
  apply lucasNat 1093 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1093 - 1 = 2 * (2 * (3 * (7 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1103 : Nat.Prime 1103 := by
  apply lucasNat 1103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1103 - 1 = 2 * (19 * (29)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1109 : Nat.Prime 1109 := by
  apply lucasNat 1109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1109 - 1 = 2 * (2 * (277)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_277] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1117 : Nat.Prime 1117 := by
  apply lucasNat 1117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1117 - 1 = 2 * (2 * (3 * (3 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1123 : Nat.Prime 1123 := by
  apply lucasNat 1123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1123 - 1 = 2 * (3 * (11 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1129 : Nat.Prime 1129 := by
  apply lucasNat 1129 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1129 - 1 = 2 * (2 * (2 * (3 * (47)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1151 : Nat.Prime 1151 := by
  apply lucasNat 1151 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1151 - 1 = 2 * (5 * (5 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1153 : Nat.Prime 1153 := by
  apply lucasNat 1153 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1153 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1163 : Nat.Prime 1163 := by
  apply lucasNat 1163 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1163 - 1 = 2 * (7 * (83)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1181 : Nat.Prime 1181 := by
  apply lucasNat 1181 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1181 - 1 = 2 * (2 * (5 * (59))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1213 : Nat.Prime 1213 := by
  apply lucasNat 1213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1213 - 1 = 2 * (2 * (3 * (101))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_101] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1217 : Nat.Prime 1217 := by
  apply lucasNat 1217 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1217 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1229 : Nat.Prime 1229 := by
  apply lucasNat 1229 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1229 - 1 = 2 * (2 * (307)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_307] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1237 : Nat.Prime 1237 := by
  apply lucasNat 1237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1237 - 1 = 2 * (2 * (3 * (103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1259 : Nat.Prime 1259 := by
  apply lucasNat 1259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1259 - 1 = 2 * (17 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1277 : Nat.Prime 1277 := by
  apply lucasNat 1277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1277 - 1 = 2 * (2 * (11 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1283 : Nat.Prime 1283 := by
  apply lucasNat 1283 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1283 - 1 = 2 * (641) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_641] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1289 : Nat.Prime 1289 := by
  apply lucasNat 1289 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1289 - 1 = 2 * (2 * (2 * (7 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1301 : Nat.Prime 1301 := by
  apply lucasNat 1301 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1301 - 1 = 2 * (2 * (5 * (5 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1303 : Nat.Prime 1303 := by
  apply lucasNat 1303 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1303 - 1 = 2 * (3 * (7 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1307 : Nat.Prime 1307 := by
  apply lucasNat 1307 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1307 - 1 = 2 * (653) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_653] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1319 : Nat.Prime 1319 := by
  apply lucasNat 1319 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1319 - 1 = 2 * (659) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_659] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1321 : Nat.Prime 1321 := by
  apply lucasNat 1321 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1321 - 1 = 2 * (2 * (2 * (3 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1361 : Nat.Prime 1361 := by
  apply lucasNat 1361 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1361 - 1 = 2 * (2 * (2 * (2 * (5 * (17))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1367 : Nat.Prime 1367 := by
  apply lucasNat 1367 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1367 - 1 = 2 * (683) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_683] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1373 : Nat.Prime 1373 := by
  apply lucasNat 1373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1373 - 1 = 2 * (2 * (7 * (7 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1381 : Nat.Prime 1381 := by
  apply lucasNat 1381 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1381 - 1 = 2 * (2 * (3 * (5 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1423 : Nat.Prime 1423 := by
  apply lucasNat 1423 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1423 - 1 = 2 * (3 * (3 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1427 : Nat.Prime 1427 := by
  apply lucasNat 1427 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1427 - 1 = 2 * (23 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1429 : Nat.Prime 1429 := by
  apply lucasNat 1429 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1429 - 1 = 2 * (2 * (3 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1433 : Nat.Prime 1433 := by
  apply lucasNat 1433 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1433 - 1 = 2 * (2 * (2 * (179))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1439 : Nat.Prime 1439 := by
  apply lucasNat 1439 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1439 - 1 = 2 * (719) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_719] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1451 : Nat.Prime 1451 := by
  apply lucasNat 1451 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1451 - 1 = 2 * (5 * (5 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1453 : Nat.Prime 1453 := by
  apply lucasNat 1453 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1453 - 1 = 2 * (2 * (3 * (11 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1471 : Nat.Prime 1471 := by
  apply lucasNat 1471 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1471 - 1 = 2 * (3 * (5 * (7 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1481 : Nat.Prime 1481 := by
  apply lucasNat 1481 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1481 - 1 = 2 * (2 * (2 * (5 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1489 : Nat.Prime 1489 := by
  apply lucasNat 1489 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1489 - 1 = 2 * (2 * (2 * (2 * (3 * (31))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1493 : Nat.Prime 1493 := by
  apply lucasNat 1493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1493 - 1 = 2 * (2 * (373)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_373] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1499 : Nat.Prime 1499 := by
  apply lucasNat 1499 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1499 - 1 = 2 * (7 * (107)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1543 : Nat.Prime 1543 := by
  apply lucasNat 1543 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1543 - 1 = 2 * (3 * (257)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_257] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1549 : Nat.Prime 1549 := by
  apply lucasNat 1549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1549 - 1 = 2 * (2 * (3 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1553 : Nat.Prime 1553 := by
  apply lucasNat 1553 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1553 - 1 = 2 * (2 * (2 * (2 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1559 : Nat.Prime 1559 := by
  apply lucasNat 1559 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1559 - 1 = 2 * (19 * (41)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1571 : Nat.Prime 1571 := by
  apply lucasNat 1571 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1571 - 1 = 2 * (5 * (157)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1583 : Nat.Prime 1583 := by
  apply lucasNat 1583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1583 - 1 = 2 * (7 * (113)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1597 : Nat.Prime 1597 := by
  apply lucasNat 1597 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1597 - 1 = 2 * (2 * (3 * (7 * (19)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1607 : Nat.Prime 1607 := by
  apply lucasNat 1607 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1607 - 1 = 2 * (11 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1609 : Nat.Prime 1609 := by
  apply lucasNat 1609 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1609 - 1 = 2 * (2 * (2 * (3 * (67)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1613 : Nat.Prime 1613 := by
  apply lucasNat 1613 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1613 - 1 = 2 * (2 * (13 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1619 : Nat.Prime 1619 := by
  apply lucasNat 1619 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1619 - 1 = 2 * (809) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_809] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1657 : Nat.Prime 1657 := by
  apply lucasNat 1657 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1657 - 1 = 2 * (2 * (2 * (3 * (3 * (23))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1697 : Nat.Prime 1697 := by
  apply lucasNat 1697 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1697 - 1 = 2 * (2 * (2 * (2 * (2 * (53))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1709 : Nat.Prime 1709 := by
  apply lucasNat 1709 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1709 - 1 = 2 * (2 * (7 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1721 : Nat.Prime 1721 := by
  apply lucasNat 1721 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1721 - 1 = 2 * (2 * (2 * (5 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1723 : Nat.Prime 1723 := by
  apply lucasNat 1723 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1723 - 1 = 2 * (3 * (7 * (41))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1777 : Nat.Prime 1777 := by
  apply lucasNat 1777 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1777 - 1 = 2 * (2 * (2 * (2 * (3 * (37))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1783 : Nat.Prime 1783 := by
  apply lucasNat 1783 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1783 - 1 = 2 * (3 * (3 * (3 * (3 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1801 : Nat.Prime 1801 := by
  apply lucasNat 1801 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1801 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (5)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1811 : Nat.Prime 1811 := by
  apply lucasNat 1811 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1811 - 1 = 2 * (5 * (181)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1823 : Nat.Prime 1823 := by
  apply lucasNat 1823 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1823 - 1 = 2 * (911) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_911] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1831 : Nat.Prime 1831 := by
  apply lucasNat 1831 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1831 - 1 = 2 * (3 * (5 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1847 : Nat.Prime 1847 := by
  apply lucasNat 1847 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1847 - 1 = 2 * (13 * (71)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1861 : Nat.Prime 1861 := by
  apply lucasNat 1861 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1861 - 1 = 2 * (2 * (3 * (5 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1867 : Nat.Prime 1867 := by
  apply lucasNat 1867 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1867 - 1 = 2 * (3 * (311)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1877 : Nat.Prime 1877 := by
  apply lucasNat 1877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1877 - 1 = 2 * (2 * (7 * (67))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_67] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1889 : Nat.Prime 1889 := by
  apply lucasNat 1889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1889 - 1 = 2 * (2 * (2 * (2 * (2 * (59))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1907 : Nat.Prime 1907 := by
  apply lucasNat 1907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1907 - 1 = 2 * (953) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_953] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1913 : Nat.Prime 1913 := by
  apply lucasNat 1913 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1913 - 1 = 2 * (2 * (2 * (239))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1993 : Nat.Prime 1993 := by
  apply lucasNat 1993 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1993 - 1 = 2 * (2 * (2 * (3 * (83)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1997 : Nat.Prime 1997 := by
  apply lucasNat 1997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1997 - 1 = 2 * (2 * (499)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_499] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2003 : Nat.Prime 2003 := by
  apply lucasNat 2003 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2003 - 1 = 2 * (7 * (11 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2017 : Nat.Prime 2017 := by
  apply lucasNat 2017 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2017 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (7))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2029 : Nat.Prime 2029 := by
  apply lucasNat 2029 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2029 - 1 = 2 * (2 * (3 * (13 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2063 : Nat.Prime 2063 := by
  apply lucasNat 2063 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2063 - 1 = 2 * (1031) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1031] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2081 : Nat.Prime 2081 := by
  apply lucasNat 2081 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2081 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (13)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2099 : Nat.Prime 2099 := by
  apply lucasNat 2099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2099 - 1 = 2 * (1049) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1049] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2131 : Nat.Prime 2131 := by
  apply lucasNat 2131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2131 - 1 = 2 * (3 * (5 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2141 : Nat.Prime 2141 := by
  apply lucasNat 2141 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2141 - 1 = 2 * (2 * (5 * (107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2143 : Nat.Prime 2143 := by
  apply lucasNat 2143 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2143 - 1 = 2 * (3 * (3 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2179 : Nat.Prime 2179 := by
  apply lucasNat 2179 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2179 - 1 = 2 * (3 * (3 * (11 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2237 : Nat.Prime 2237 := by
  apply lucasNat 2237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2237 - 1 = 2 * (2 * (13 * (43))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2281 : Nat.Prime 2281 := by
  apply lucasNat 2281 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2281 - 1 = 2 * (2 * (2 * (3 * (5 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2297 : Nat.Prime 2297 := by
  apply lucasNat 2297 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2297 - 1 = 2 * (2 * (2 * (7 * (41)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2309 : Nat.Prime 2309 := by
  apply lucasNat 2309 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2309 - 1 = 2 * (2 * (577)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_577] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2311 : Nat.Prime 2311 := by
  apply lucasNat 2311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2311 - 1 = 2 * (3 * (5 * (7 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2339 : Nat.Prime 2339 := by
  apply lucasNat 2339 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2339 - 1 = 2 * (7 * (167)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2351 : Nat.Prime 2351 := by
  apply lucasNat 2351 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2351 - 1 = 2 * (5 * (5 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2371 : Nat.Prime 2371 := by
  apply lucasNat 2371 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2371 - 1 = 2 * (3 * (5 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2383 : Nat.Prime 2383 := by
  apply lucasNat 2383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2383 - 1 = 2 * (3 * (397)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_397] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2389 : Nat.Prime 2389 := by
  apply lucasNat 2389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2389 - 1 = 2 * (2 * (3 * (199))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_199] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2417 : Nat.Prime 2417 := by
  apply lucasNat 2417 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2417 - 1 = 2 * (2 * (2 * (2 * (151)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2473 : Nat.Prime 2473 := by
  apply lucasNat 2473 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2473 - 1 = 2 * (2 * (2 * (3 * (103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2477 : Nat.Prime 2477 := by
  apply lucasNat 2477 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2477 - 1 = 2 * (2 * (619)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_619] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
end FiniteP0N1024
