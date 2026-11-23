import PrattChunk08
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p288492049 : Nat.Prime 288492049 := by
  apply lucasNat 288492049 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 288492049-1 = 2 * (2 * (2 * (2 * (3 * (3 * (13 * (19 * (8111)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p8111] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p346018363 : Nat.Prime 346018363 := by
  apply lucasNat 346018363 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 346018363-1 = 2 * (3 * (59 * (59 * (16567)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p59, Nat.prime_dvd_prime_iff_eq hq p16567] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p357914927 : Nat.Prime 357914927 := by
  apply lucasNat 357914927 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 357914927-1 = 2 * (29 * (6170947)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p6170947] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p362657843 : Nat.Prime 362657843 := by
  apply lucasNat 362657843 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 362657843-1 = 2 * (2131 * (85091)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p2131, Nat.prime_dvd_prime_iff_eq hq p85091] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p444254891 : Nat.Prime 444254891 := by
  apply lucasNat 444254891 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 444254891-1 = 2 * (5 * (23 * (67 * (127 * (227))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p127, Nat.prime_dvd_prime_iff_eq hq p227] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p484172399 : Nat.Prime 484172399 := by
  apply lucasNat 484172399 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 484172399-1 = 2 * (242086199) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p242086199] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p595429477 : Nat.Prime 595429477 := by
  apply lucasNat 595429477 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 595429477-1 = 2 * (2 * (3 * (49619123))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p49619123] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1192037179 : Nat.Prime 1192037179 := by
  apply lucasNat 1192037179 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1192037179-1 = 2 * (3 * (17 * (953 * (12263)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p953, Nat.prime_dvd_prime_iff_eq hq p12263] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1220047813 : Nat.Prime 1220047813 := by
  apply lucasNat 1220047813 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1220047813-1 = 2 * (2 * (3 * (3 * (3 * (71 * (107 * (1487))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p1487] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p1438766099 : Nat.Prime 1438766099 := by
  apply lucasNat 1438766099 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1438766099-1 = 2 * (7 * (11 * (9342637))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p9342637] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1468860149 : Nat.Prime 1468860149 := by
  apply lucasNat 1468860149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1468860149-1 = 2 * (2 * (7 * (52459291))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p52459291] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1606580537 : Nat.Prime 1606580537 := by
  apply lucasNat 1606580537 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1606580537-1 = 2 * (2 * (2 * (11 * (83 * (219959))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p83, Nat.prime_dvd_prime_iff_eq hq p219959] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1687364993 : Nat.Prime 1687364993 := by
  apply lucasNat 1687364993 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1687364993-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (13182539))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13182539] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p1954575641 : Nat.Prime 1954575641 := by
  apply lucasNat 1954575641 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1954575641-1 = 2 * (2 * (2 * (5 * (29 * (1684979))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p1684979] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p2617663969 : Nat.Prime 2617663969 := by
  apply lucasNat 2617663969 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2617663969-1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (283 * (32117)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p283, Nat.prime_dvd_prime_iff_eq hq p32117] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p2924318603 : Nat.Prime 2924318603 := by
  apply lucasNat 2924318603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2924318603-1 = 2 * (439 * (3330659)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p439, Nat.prime_dvd_prime_iff_eq hq p3330659] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p3963849649 : Nat.Prime 3963849649 := by
  apply lucasNat 3963849649 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3963849649-1 = 2 * (2 * (2 * (2 * (3 * (11 * (11 * (53 * (79 * (163))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p79, Nat.prime_dvd_prime_iff_eq hq p163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p4051207217 : Nat.Prime 4051207217 := by
  apply lucasNat 4051207217 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4051207217-1 = 2 * (2 * (2 * (2 * (7 * (53 * (53 * (79 * (163)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p79, Nat.prime_dvd_prime_iff_eq hq p163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p4743832967 : Nat.Prime 4743832967 := by
  apply lucasNat 4743832967 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4743832967-1 = 2 * (17 * (89 * (137 * (11443)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p89, Nat.prime_dvd_prime_iff_eq hq p137, Nat.prime_dvd_prime_iff_eq hq p11443] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p7447125331 : Nat.Prime 7447125331 := by
  apply lucasNat 7447125331 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7447125331-1 = 2 * (3 * (3 * (5 * (293 * (282409))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p293, Nat.prime_dvd_prime_iff_eq hq p282409] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p8039877709 : Nat.Prime 8039877709 := by
  apply lucasNat 8039877709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8039877709-1 = 2 * (2 * (3 * (107 * (6261587)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p6261587] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p12410027171 : Nat.Prime 12410027171 := by
  apply lucasNat 12410027171 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12410027171-1 = 2 * (5 * (269 * (751 * (6143)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p269, Nat.prime_dvd_prime_iff_eq hq p751, Nat.prime_dvd_prime_iff_eq hq p6143] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p16778523313 : Nat.Prime 16778523313 := by
  apply lucasNat 16778523313 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16778523313-1 = 2 * (2 * (2 * (2 * (3 * (3 * (1453 * (80191))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1453, Nat.prime_dvd_prime_iff_eq hq p80191] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p25484199527 : Nat.Prime 25484199527 := by
  apply lucasNat 25484199527 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25484199527-1 = 2 * (1103 * (1999 * (5779))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1103, Nat.prime_dvd_prime_iff_eq hq p1999, Nat.prime_dvd_prime_iff_eq hq p5779] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p54406963517 : Nat.Prime 54406963517 := by
  apply lucasNat 54406963517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 54406963517-1 = 2 * (2 * (59 * (230537981))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p59, Nat.prime_dvd_prime_iff_eq hq p230537981] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p67114093253 : Nat.Prime 67114093253 := by
  apply lucasNat 67114093253 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 67114093253-1 = 2 * (2 * (16778523313)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p16778523313] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p119047617791 : Nat.Prime 119047617791 := by
  apply lucasNat 119047617791 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 119047617791-1 = 2 * (5 * (22709 * (524231))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p22709, Nat.prime_dvd_prime_iff_eq hq p524231] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p135135133709 : Nat.Prime 135135133709 := by
  apply lucasNat 135135133709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 135135133709-1 = 2 * (2 * (23 * (1468860149))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p1468860149] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p152905197163 : Nat.Prime 152905197163 := by
  apply lucasNat 152905197163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 152905197163-1 = 2 * (3 * (25484199527)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p25484199527] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p238095235583 : Nat.Prime 238095235583 := by
  apply lucasNat 238095235583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 238095235583-1 = 2 * (119047617791) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p119047617791] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p292397657729 : Nat.Prime 292397657729 := by
  apply lucasNat 292397657729 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 292397657729-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (11 * (11 * (11 * (1716271)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p1716271] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem p420168062791 : Nat.Prime 420168062791 := by
  apply lucasNat 420168062791 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 420168062791-1 = 2 * (3 * (3 * (5 * (7 * (10273 * (64921)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p10273, Nat.prime_dvd_prime_iff_eq hq p64921] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p595238088959 : Nat.Prime 595238088959 := by
  apply lucasNat 595238088959 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 595238088959-1 = 2 * (107 * (12073 * (230389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p12073, Nat.prime_dvd_prime_iff_eq hq p230389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1282051268527 : Nat.Prime 1282051268527 := by
  apply lucasNat 1282051268527 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1282051268527-1 = 2 * (3 * (7 * (19 * (1606580537)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p1606580537] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
end Pratt14
