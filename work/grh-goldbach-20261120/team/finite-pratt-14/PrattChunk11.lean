import PrattChunk10
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p99999998944273 : Nat.Prime 99999998944273 := by
  apply lucasNat 99999998944273 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944273-1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (4013 * (24721243)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p4013, Nat.prime_dvd_prime_iff_eq hq p24721243] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p99999998944319 : Nat.Prime 99999998944319 := by
  apply lucasNat 99999998944319 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944319-1 = 2 * (11 * (4545454497469)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p4545454497469] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998944361 : Nat.Prime 99999998944361 := by
  apply lucasNat 99999998944361 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944361-1 = 2 * (2 * (2 * (5 * (17 * (31 * (4743832967)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p4743832967] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944369 : Nat.Prime 99999998944369 := by
  apply lucasNat 99999998944369 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944369-1 = 2 * (2 * (2 * (2 * (3 * (3795283 * (548927)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p3795283, Nat.prime_dvd_prime_iff_eq hq p548927] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944379 : Nat.Prime 99999998944379 := by
  apply lucasNat 99999998944379 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944379-1 = 2 * (13 * (137 * (277 * (953 * (106349))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p137, Nat.prime_dvd_prime_iff_eq hq p277, Nat.prime_dvd_prime_iff_eq hq p953, Nat.prime_dvd_prime_iff_eq hq p106349] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944427 : Nat.Prime 99999998944427 := by
  apply lucasNat 99999998944427 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944427-1 = 2 * (7 * (23 * (67 * (311 * (14904209))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p311, Nat.prime_dvd_prime_iff_eq hq p14904209] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944429 : Nat.Prime 99999998944429 := by
  apply lucasNat 99999998944429 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944429-1 = 2 * (2 * (3 * (11 * (11 * (17 * (4051207217)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p4051207217] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944481 : Nat.Prime 99999998944481 := by
  apply lucasNat 99999998944481 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944481-1 = 2 * (2 * (2 * (2 * (2 * (5 * (103 * (197 * (1093 * (28181))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p103, Nat.prime_dvd_prime_iff_eq hq p197, Nat.prime_dvd_prime_iff_eq hq p1093, Nat.prime_dvd_prime_iff_eq hq p28181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p99999998944507 : Nat.Prime 99999998944507 := by
  apply lucasNat 99999998944507 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944507-1 = 2 * (3 * (3 * (15319 * (362657843)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p15319, Nat.prime_dvd_prime_iff_eq hq p362657843] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944511 : Nat.Prime 99999998944511 := by
  apply lucasNat 99999998944511 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944511-1 = 2 * (5 * (7 * (7 * (36997 * (5516167))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p36997, Nat.prime_dvd_prime_iff_eq hq p5516167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944537 : Nat.Prime 99999998944537 := by
  apply lucasNat 99999998944537 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944537-1 = 2 * (2 * (2 * (3 * (83 * (113 * (444254891)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p83, Nat.prime_dvd_prime_iff_eq hq p113, Nat.prime_dvd_prime_iff_eq hq p444254891] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944543 : Nat.Prime 99999998944543 := by
  apply lucasNat 99999998944543 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944543-1 = 2 * (3 * (3 * (691 * (8039877709)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p691, Nat.prime_dvd_prime_iff_eq hq p8039877709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944561 : Nat.Prime 99999998944561 := by
  apply lucasNat 99999998944561 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944561-1 = 2 * (2 * (2 * (2 * (3 * (3 * (5 * (11 * (13 * (67 * (71 * (204173))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p204173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem p99999998944579 : Nat.Prime 99999998944579 := by
  apply lucasNat 99999998944579 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944579-1 = 2 * (3 * (3 * (3 * (92251 * (20074057))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p92251, Nat.prime_dvd_prime_iff_eq hq p20074057] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944603 : Nat.Prime 99999998944603 := by
  apply lucasNat 99999998944603 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944603-1 = 2 * (3 * (109 * (152905197163))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p109, Nat.prime_dvd_prime_iff_eq hq p152905197163] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944607 : Nat.Prime 99999998944607 := by
  apply lucasNat 99999998944607 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944607-1 = 2 * (569 * (733 * (119881939))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p569, Nat.prime_dvd_prime_iff_eq hq p733, Nat.prime_dvd_prime_iff_eq hq p119881939] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944661 : Nat.Prime 99999998944661 := by
  apply lucasNat 99999998944661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944661-1 = 2 * (2 * (5 * (37 * (135135133709)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p135135133709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944663 : Nat.Prime 99999998944663 := by
  apply lucasNat 99999998944663 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944663-1 = 2 * (3 * (29 * (1187 * (484172399)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p1187, Nat.prime_dvd_prime_iff_eq hq p484172399] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944669 : Nat.Prime 99999998944669 := by
  apply lucasNat 99999998944669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944669-1 = 2 * (2 * (3 * (3 * (373 * (7447125331))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p373, Nat.prime_dvd_prime_iff_eq hq p7447125331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944733 : Nat.Prime 99999998944733 := by
  apply lucasNat 99999998944733 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944733-1 = 2 * (2 * (31 * (661 * (1220047813)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p661, Nat.prime_dvd_prime_iff_eq hq p1220047813] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944793 : Nat.Prime 99999998944793 := by
  apply lucasNat 99999998944793 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944793-1 = 2 * (2 * (2 * (1451767 * (8610197)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1451767, Nat.prime_dvd_prime_iff_eq hq p8610197] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944831 : Nat.Prime 99999998944831 := by
  apply lucasNat 99999998944831 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944831-1 = 2 * (3 * (3 * (5 * (43 * (32237 * (801557)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p43, Nat.prime_dvd_prime_iff_eq hq p32237, Nat.prime_dvd_prime_iff_eq hq p801557] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944843 : Nat.Prime 99999998944843 := by
  apply lucasNat 99999998944843 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944843-1 = 2 * (3 * (8527 * (1954575641))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p8527, Nat.prime_dvd_prime_iff_eq hq p1954575641] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944861 : Nat.Prime 99999998944861 := by
  apply lucasNat 99999998944861 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944861-1 = 2 * (2 * (3 * (5 * (7 * (238095235583))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p238095235583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944871 : Nat.Prime 99999998944871 := by
  apply lucasNat 99999998944871 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944871-1 = 2 * (5 * (17 * (2039 * (288492049)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p2039, Nat.prime_dvd_prime_iff_eq hq p288492049] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944877 : Nat.Prime 99999998944877 := by
  apply lucasNat 99999998944877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944877-1 = 2 * (2 * (19 * (397 * (6203 * (534311))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p397, Nat.prime_dvd_prime_iff_eq hq p6203, Nat.prime_dvd_prime_iff_eq hq p534311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944889 : Nat.Prime 99999998944889 := by
  apply lucasNat 99999998944889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944889-1 = 2 * (2 * (2 * (7 * (199 * (2647 * (3390041)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p199, Nat.prime_dvd_prime_iff_eq hq p2647, Nat.prime_dvd_prime_iff_eq hq p3390041] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998944891 : Nat.Prime 99999998944891 := by
  apply lucasNat 99999998944891 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944891-1 = 2 * (3 * (5 * (11 * (1493 * (202967381))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p1493, Nat.prime_dvd_prime_iff_eq hq p202967381] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944897 : Nat.Prime 99999998944897 := by
  apply lucasNat 99999998944897 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944897-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (181 * (1438766099))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p181, Nat.prime_dvd_prime_iff_eq hq p1438766099] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p99999998944943 : Nat.Prime 99999998944943 := by
  apply lucasNat 99999998944943 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944943-1 = 2 * (151 * (881 * (1321 * (284521)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p151, Nat.prime_dvd_prime_iff_eq hq p881, Nat.prime_dvd_prime_iff_eq hq p1321, Nat.prime_dvd_prime_iff_eq hq p284521] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944969 : Nat.Prime 99999998944969 := by
  apply lucasNat 99999998944969 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944969-1 = 2 * (2 * (2 * (3 * (56713 * (73469339))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p56713, Nat.prime_dvd_prime_iff_eq hq p73469339] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944973 : Nat.Prime 99999998944973 := by
  apply lucasNat 99999998944973 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944973-1 = 2 * (2 * (7 * (17 * (53 * (3963849649))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p3963849649] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944997 : Nat.Prime 99999998944997 := by
  apply lucasNat 99999998944997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944997-1 = 2 * (2 * (89 * (164513 * (1707457)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p89, Nat.prime_dvd_prime_iff_eq hq p164513, Nat.prime_dvd_prime_iff_eq hq p1707457] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944999 : Nat.Prime 99999998944999 := by
  apply lucasNat 99999998944999 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944999-1 = 2 * (3 * (1152121 * (14466073))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1152121, Nat.prime_dvd_prime_iff_eq hq p14466073] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
end Pratt14
