module

public import CharacterComparison
public import BadPrimes

@[expose] public section


open Real TernaryGoldbach ArithmeticFunction
open scoped ArithmeticFunction ArithmeticFunction.Moebius
noncomputable section
namespace GoldbachEnergy

theorem primitive_character_error {q : ℕ} [NeZero q] {c : ℕ → ℂ}
    (hc : Summable fun n => ‖c n‖) (β : ℝ) {b : ZMod q} (hb : IsUnit b) {M : ℂ} {E D : ℝ}
    (hD : ∑' n, ‖c n - coprimePart q c n‖ ≤ D)
    (hchar : ∀ ψ : DirichletCharacter ℂ q,
      ‖Schar ψ⁻¹.primitiveCharacter c β - (if ψ = 1 then M else 0)‖ ≤ E) :
    ‖expTsum c (b.val/q+β)-((μ q:ℂ)/q.totient)*M‖ ≤ D+√q*(E+D) := by
  classical
  set a := coprimePart q c with ha_def
  have ha : Summable fun n => ‖a n‖ :=
    hc.of_nonneg_of_le (fun n => norm_nonneg _) (norm_coprimePart_le q c)
  have hca : Summable fun n => ‖c n - a n‖ := (hc.add ha).of_nonneg_of_le (fun n => norm_nonneg _)
    fun n => norm_sub_le _ _
  have hcop : ∀ n, a n ≠ 0 → Nat.Coprime n q := fun n hn => by
    by_contra h; exact hn (by simp [ha_def, coprimePart, h])
  have hD0 : 0 ≤ D := (tsum_nonneg fun n => norm_nonneg _).trans hD
  have hE0 : 0 ≤ E := (norm_nonneg _).trans (hchar 1)
  have hφ : (0 : ℝ) < q.totient := by exact_mod_cast Nat.totient_pos.2 (Nat.pos_of_ne_zero (NeZero.ne q))
  -- split `c = a + (c - a)`
  have hsplit : expTsum c ((b.val : ℝ) / q + β) =
      expTsum a ((b.val : ℝ) / q + β) + expTsum (c - a) ((b.val : ℝ) / q + β) := by
    unfold expTsum
    have s1 : Summable fun n : ℕ => a n * e (n * ((b.val : ℝ) / q + β)) :=
      Summable.of_norm (ha.congr fun n => by rw [norm_mul_e])
    have s2 : Summable fun n : ℕ => (c - a) n * e (n * ((b.val : ℝ) / q + β)) :=
      Summable.of_norm (hca.congr fun n => by rw [norm_mul_e]; rfl)
    rw [← s1.tsum_add s2]
    congr 1; ext n; simp only [Pi.sub_apply]; ring
  have hrest : ‖expTsum (c - a) ((b.val : ℝ) / q + β)‖ ≤ D := by
    refine (norm_tsum_le_tsum_norm ?_).trans ?_
    · exact hca.congr fun n => by rw [norm_mul_e]; rfl
    · refine le_trans (le_of_eq ?_) hD
      congr 1; ext n; rw [norm_mul_e]; rfl
  have hψ (ψ : DirichletCharacter ℂ q) : ‖Schar ψ⁻¹ a β-(if ψ=1 then M else 0)‖ ≤ E+D := by
    rw [ha_def,Schar_primitive,← ha_def]
    let ξ := ψ⁻¹.primitiveCharacter
    have hs := Schar_sub ξ hc ha β
    have hh : Schar ξ a β - (if ψ=1 then M else 0) =
        (Schar ξ c β-(if ψ=1 then M else 0))-Schar ξ (c-a) β := by rw [hs]; ring
    change ‖Schar ξ a β-(if ψ=1 then M else 0)‖ ≤ _
    rw [hh]
    exact (norm_sub_le _ _).trans (add_le_add (hchar ψ) ((norm_Schar_le ξ hca β).trans hD))
  have hcop' := coprime_character_error ha hcop β hb M hψ
  rw [hsplit,add_sub_right_comm]
  exact (norm_add_le _ _).trans ((add_le_add hcop' hrest).trans_eq (add_comm _ _))

theorem wave_from_primitive_characters {N : ℝ} (hn : 1≤N) {q : ℕ} [NeZero q]
    (β : ℝ) {b : ZMod q} (hb : IsUnit b) {E : ℝ}
    (hchar : ∀ ψ : DirichletCharacter ℂ q,
      ‖Schar ψ⁻¹.primitiveCharacter (fun n => (amp N n:ℂ)) β -
        (if ψ=1 then principalWave N 1 β else 0)‖ ≤ E) :
    let D := (Real.log q/Real.log 2)*(1+Real.log N)
    ‖wave N (b.val/q+β)-principalWave N q β‖ ≤ D+√q*(E+D) := by
  let c := fun n => (amp N n:ℂ)
  have hnn (n : ℕ) : 0 ≤ amp N n := mul_nonneg vonMangoldt_nonneg (Real.exp_pos _).le
  have hc : Summable fun n => ‖c n‖ := by
    simpa [c,Real.norm_eq_abs,abs_of_nonneg (hnn _)] using amp_summable N (by linarith)
  have hd (n : ℕ) : ‖c n-coprimePart q c n‖ = badLambda q n*Real.exp (-(n:ℝ)/N) := by
    by_cases h : n.Coprime q
    · rw [coprimePart,badLambda,if_pos h,if_pos h,sub_self,norm_zero,zero_mul]
    · rw [coprimePart,badLambda,if_neg h,if_neg h,sub_zero]
      exact (Complex.norm_real _).trans ((Real.norm_eq_abs _).trans (abs_of_nonneg (hnn n)))
  have hD := bad_mass q (Nat.pos_of_ne_zero (NeZero.ne q)) hn
  simp_rw [← hd] at hD
  have h := primitive_character_error (c := c) hc β hb hD hchar
  have hm : ((μ q:ℂ)/q.totient)*principalWave N 1 β=principalWave N q β := by
    unfold principalWave; push_cast; simp [ArithmeticFunction.moebius_apply_one]; ring
  rwa [hm] at h

#print axioms wave_from_primitive_characters
end GoldbachEnergy
