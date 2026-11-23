import PrattChunk07
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p3795283 : Nat.Prime 3795283 := by
  apply lucasNat 3795283 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3795283-1 = 2 * (3 * (3 * (3 * (67 * (1049))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p1049] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p3932483 : Nat.Prime 3932483 := by
  apply lucasNat 3932483 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3932483-1 = 2 * (1966241) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1966241] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p5516167 : Nat.Prime 5516167 := by
  apply lucasNat 5516167 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5516167-1 = 2 * (3 * (829 * (1109))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p829, Nat.prime_dvd_prime_iff_eq hq p1109] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p6170947 : Nat.Prime 6170947 := by
  apply lucasNat 6170947 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6170947-1 = 2 * (3 * (23 * (97 * (461)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p97, Nat.prime_dvd_prime_iff_eq hq p461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p6261587 : Nat.Prime 6261587 := by
  apply lucasNat 6261587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6261587-1 = 2 * (571 * (5483)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p571, Nat.prime_dvd_prime_iff_eq hq p5483] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6591269 : Nat.Prime 6591269 := by
  apply lucasNat 6591269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6591269-1 = 2 * (2 * (463 * (3559))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p463, Nat.prime_dvd_prime_iff_eq hq p3559] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p7034851 : Nat.Prime 7034851 := by
  apply lucasNat 7034851 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7034851-1 = 2 * (3 * (3 * (3 * (3 * (3 * (3 * (5 * (5 * (193))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p193] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p7217713 : Nat.Prime 7217713 := by
  apply lucasNat 7217713 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7217713-1 = 2 * (2 * (2 * (2 * (3 * (3 * (50123)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p50123] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p8610197 : Nat.Prime 8610197 := by
  apply lucasNat 8610197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8610197-1 = 2 * (2 * (7 * (37 * (8311)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p8311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p8664433 : Nat.Prime 8664433 := by
  apply lucasNat 8664433 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8664433-1 = 2 * (2 * (2 * (2 * (3 * (7 * (107 * (241))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p8812669 : Nat.Prime 8812669 := by
  apply lucasNat 8812669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8812669-1 = 2 * (2 * (3 * (734389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p734389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p9342637 : Nat.Prime 9342637 := by
  apply lucasNat 9342637 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9342637-1 = 2 * (2 * (3 * (778553))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p778553] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p12690571 : Nat.Prime 12690571 := by
  apply lucasNat 12690571 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12690571-1 = 2 * (3 * (5 * (423019))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p423019] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p13182539 : Nat.Prime 13182539 := by
  apply lucasNat 13182539 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13182539-1 = 2 * (6591269) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p6591269] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p14466073 : Nat.Prime 14466073 := by
  apply lucasNat 14466073 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14466073-1 = 2 * (2 * (2 * (3 * (602753)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p602753] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p14904209 : Nat.Prime 14904209 := by
  apply lucasNat 14904209 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14904209-1 = 2 * (2 * (2 * (2 * (11 * (19 * (4457)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p4457] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p19575401 : Nat.Prime 19575401 := by
  apply lucasNat 19575401 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 19575401-1 = 2 * (2 * (2 * (5 * (5 * (13 * (7529)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p7529] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p20074057 : Nat.Prime 20074057 := by
  apply lucasNat 20074057 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20074057-1 = 2 * (2 * (2 * (3 * (107 * (7817))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p7817] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p24721243 : Nat.Prime 24721243 := by
  apply lucasNat 24721243 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24721243-1 = 2 * (3 * (7 * (13 * (19 * (2383))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p2383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p33291541 : Nat.Prime 33291541 := by
  apply lucasNat 33291541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 33291541-1 = 2 * (2 * (3 * (3 * (3 * (5 * (61651)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p61651] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p36734669 : Nat.Prime 36734669 := by
  apply lucasNat 36734669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36734669-1 = 2 * (2 * (521 * (17627))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p521, Nat.prime_dvd_prime_iff_eq hq p17627] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p39150803 : Nat.Prime 39150803 := by
  apply lucasNat 39150803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 39150803-1 = 2 * (19575401) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19575401] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p49619123 : Nat.Prime 49619123 := by
  apply lucasNat 49619123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49619123-1 = 2 * (7 * (47 * (73 * (1033)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p47, Nat.prime_dvd_prime_iff_eq hq p73, Nat.prime_dvd_prime_iff_eq hq p1033] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p51669973 : Nat.Prime 51669973 := by
  apply lucasNat 51669973 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 51669973-1 = 2 * (2 * (3 * (3 * (1435277)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1435277] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p52459291 : Nat.Prime 52459291 := by
  apply lucasNat 52459291 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 52459291-1 = 2 * (3 * (3 * (5 * (13 * (13 * (3449)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p3449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p73465129 : Nat.Prime 73465129 := by
  apply lucasNat 73465129 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73465129-1 = 2 * (2 * (2 * (3 * (3 * (11 * (23 * (37 * (109)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p73469339 : Nat.Prime 73469339 := by
  apply lucasNat 73469339 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 73469339-1 = 2 * (36734669) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p36734669] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p81062633 : Nat.Prime 81062633 := by
  apply lucasNat 81062633 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 81062633-1 = 2 * (2 * (2 * (7 * (1123 * (1289))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p1123, Nat.prime_dvd_prime_iff_eq hq p1289] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p119881939 : Nat.Prime 119881939 := by
  apply lucasNat 119881939 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 119881939-1 = 2 * (3 * (11 * (71 * (25583)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p25583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p202967381 : Nat.Prime 202967381 := by
  apply lucasNat 202967381 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 202967381-1 = 2 * (2 * (5 * (7 * (11 * (131797))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p131797] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p212747849 : Nat.Prime 212747849 := by
  apply lucasNat 212747849 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 212747849-1 = 2 * (2 * (2 * (137 * (194113)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p137, Nat.prime_dvd_prime_iff_eq hq p194113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p230537981 : Nat.Prime 230537981 := by
  apply lucasNat 230537981 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 230537981-1 = 2 * (2 * (5 * (1531 * (7529)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p1531, Nat.prime_dvd_prime_iff_eq hq p7529] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p242086199 : Nat.Prime 242086199 := by
  apply lucasNat 242086199 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 242086199-1 = 2 * (97 * (1247867)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p97, Nat.prime_dvd_prime_iff_eq hq p1247867] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p243763313 : Nat.Prime 243763313 := by
  apply lucasNat 243763313 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 243763313-1 = 2 * (2 * (2 * (2 * (13 * (19 * (61681)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p61681] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
end Pratt14
