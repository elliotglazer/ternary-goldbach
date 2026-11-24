import FiniteGaussian

open Real TernaryGoldbach
namespace GoldbachFinite

/-- Price a change of the ternary cutoff using the checked square-root window. -/
theorem through_height_of_rh (rh : RiemannHypothesis) {H B : ℕ}
    (ht : H ≤ 10^27) (hb : 100328530944 ≤ B) (hbe : Even B)
    (hw : 126.2 * Real.sqrt (H:ℝ) + 2 ≤ (B:ℝ))
    (bg : BinaryGoldbachUpTo B) : TernaryGoldbachUpTo H := by
  intro n hn h5 htop
  by_cases hs : n ≤ 10^15+4
  · exact through_quadrillion (fun m he hm1 hm2 => bg m he hm1 (hm2.trans hb)) n hn h5 hs
  let x : ℝ := n-4
  have hx : (10:ℝ)^15 ≤ x := by
    have h : (10:ℝ)^15 + 4 < n := by exact_mod_cast lt_of_not_ge hs
    dsimp [x]; linarith
  have hX : x ≤ (H:ℝ) := by
    have h : (n:ℝ) ≤ H := by exact_mod_cast htop
    dsimp [x]; linarith
  obtain ⟨p,hp,hl,hu⟩ := Explicit.exists_prime_in_sqrt_interval rh
    (show 1e15 ≤ x by norm_num at hx ⊢; exact hx)
    (show x ≤ 1e27 by norm_num; exact hX.trans (by exact_mod_cast ht))
  have h4 : p+4 ≤ n := by exact_mod_cast (show (p:ℝ)+4 ≤ n by dsimp [x] at hu; linarith)
  have hdiff : n < p+B+2 := by
    have hroot := Real.sqrt_le_sqrt hX
    exact_mod_cast (show (n:ℝ)<p+B+2 by dsimp [x] at hl hroot; linarith)
  have hop : Odd p := hp.odd_of_ne_two (by
    intro hp2; subst p
    have hnn : 126.2*Real.sqrt x ≤ x-3 := by
      have hroot : (1000:ℝ) ≤ Real.sqrt x := Real.le_sqrt_of_sq_le (by linarith)
      have hsq := Real.sq_sqrt (show 0≤x by linarith)
      nlinarith [mul_nonneg (show 0≤Real.sqrt x-1000 by linarith) (Real.sqrt_nonneg x)]
    norm_num at hl
    linarith)
  have he := Nat.Odd.sub_odd hn hop
  obtain ⟨q,r,hq,hr,h⟩ := bg (n-p) he (by omega) (by
    obtain ⟨a,ha⟩ := he; obtain ⟨b,hb⟩ := hbe; omega)
  exact ⟨p,q,r,hp,hq,hr,by omega⟩

#print axioms through_height_of_rh
end GoldbachFinite
