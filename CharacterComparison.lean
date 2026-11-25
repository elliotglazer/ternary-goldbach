module

public import TernaryGoldbach.MinorArcs.Bombieri
public import TernaryGoldbach.MinorArcs.Montgomery
public import PrincipalWave

@[expose] public section


/- The character inversion and passage to the inducing primitive character use
Charlie Reams' BaseGap.lean and MajorTotal.lean at the revision in sources.json,
Apache-2.0. The comparison here retains the phase of the principal term. -/
open Finset Real TernaryGoldbach ArithmeticFunction
open scoped ArithmeticFunction.Moebius
noncomputable section
namespace GoldbachEnergy

theorem gaussSum_one_eq {q : ℕ} [NeZero q] :
    gaussSum (1 : DirichletCharacter ℂ q) ZMod.stdAddChar = (μ q : ℂ) := by
  have hq1 : 1 ≤ q := Nat.pos_of_ne_zero (NeZero.ne q)
  rw [← TernaryGoldbach.ramanujan_coprime q 1 hq1 (Nat.coprime_one_left q), gaussSum,
    TernaryGoldbach.sum_zmod_eq_sum_range, sum_filter]
  refine sum_congr rfl fun c hc => ?_
  have hcq := mem_range.1 hc
  by_cases h : q.Coprime c
  · have hu : IsUnit (c : ZMod q) := (ZMod.isUnit_iff_coprime c q).2 (Nat.Coprime.symm h)
    rw [if_pos h, MulChar.one_apply hu, one_mul, TernaryGoldbach.stdAddChar_natCast_eq_e]
    congr 1; push_cast; ring
  · have hu : ¬IsUnit (c : ZMod q) := fun hu =>
      h (Nat.Coprime.symm ((ZMod.isUnit_iff_coprime c q).1 hu))
    rw [if_neg h, MulChar.map_nonunit _ hu, zero_mul]

theorem character_inversion {q : ℕ} [NeZero q] {a : ℕ → ℂ}
    (ha : Summable fun n => ‖a n‖) (hcop : ∀ n, a n ≠ 0 → Nat.Coprime n q) (β : ℝ)
    {b : ZMod q} (hb : IsUnit b) : ∑ ψ : DirichletCharacter ℂ q, ψ b⁻¹ * (gaussSum ψ ZMod.stdAddChar * Schar ψ⁻¹ a β) =
      (q.totient : ℂ) * expTsum a ((b.val : ℝ) / q + β) := by
    simp_rw [← sum_char_mul_S _ ha hcop β, mul_sum]
    rw [sum_comm]
    have : ∀ c : ZMod q, ∑ ψ : DirichletCharacter ℂ q, ψ b⁻¹ * (ψ c * expTsum a (c.val / q + β)) =
        if b = c then (q.totient : ℂ) * expTsum a (c.val / q + β) else 0 := by
      intro c
      simp_rw [← mul_assoc, ← sum_mul, DirichletCharacter.sum_char_inv_mul_char_eq ℂ hb c]
      split_ifs <;> simp
    rw [sum_congr rfl fun c _ => this c, sum_ite_eq]
    simp

theorem norm_Schar_le {d : ℕ} (χ : DirichletCharacter ℂ d) {a : ℕ → ℂ}
    (ha : Summable fun n => ‖a n‖) (β : ℝ) : ‖Schar χ a β‖ ≤ ∑' n, ‖a n‖ := by
  have hle : ∀ n : ℕ, ‖a n * χ (n : ZMod d) * e (n * β)‖ ≤ ‖a n‖ := fun n => by
    rw [norm_mul, norm_mul, norm_e, mul_one]
    exact mul_le_of_le_one_right (norm_nonneg _) (DirichletCharacter.norm_le_one χ _)
  have hs : Summable fun n : ℕ => ‖a n * χ (n : ZMod d) * e (n * β)‖ :=
    ha.of_nonneg_of_le (fun n => norm_nonneg _) hle
  exact (norm_tsum_le_tsum_norm hs).trans (Summable.tsum_le_tsum hle hs ha)

theorem summable_Schar {d : ℕ} (χ : DirichletCharacter ℂ d) {a : ℕ → ℂ}
    (ha : Summable fun n => ‖a n‖) (β : ℝ) :
    Summable fun n : ℕ => a n * χ (n : ZMod d) * e (n * β) := by
  refine Summable.of_norm (ha.of_nonneg_of_le (fun n => norm_nonneg _) fun n => ?_)
  rw [norm_mul, norm_mul, norm_e, mul_one]
  exact mul_le_of_le_one_right (norm_nonneg _) (DirichletCharacter.norm_le_one χ _)

theorem Schar_sub {d : ℕ} (χ : DirichletCharacter ℂ d) {a b : ℕ → ℂ}
    (ha : Summable fun n => ‖a n‖) (hb : Summable fun n => ‖b n‖) (β : ℝ) :
    Schar χ (a - b) β = Schar χ a β - Schar χ b β := by
  unfold Schar
  rw [← (summable_Schar χ ha β).tsum_sub (summable_Schar χ hb β)]
  congr 1; ext n; simp only [Pi.sub_apply]; ring

/-- The restriction to `(n, q) = 1`. -/
noncomputable def coprimePart (q : ℕ) (c : ℕ → ℂ) (n : ℕ) : ℂ := if Nat.Coprime n q then c n else 0

theorem norm_coprimePart_le (q : ℕ) (c : ℕ → ℂ) (n : ℕ) : ‖coprimePart q c n‖ ≤ ‖c n‖ := by
  unfold coprimePart; split_ifs <;> simp

/-- For `ψ` mod `q` and `aₙ` supported on `(n, q) = 1`, `S_ψ = S_{χ}` with `χ` the primitive
character inducing `ψ`. -/
theorem Schar_primitive {q : ℕ} [NeZero q] (ψ : DirichletCharacter ℂ q) (c : ℕ → ℂ) (β : ℝ) :
    Schar ψ (coprimePart q c) β = Schar ψ.primitiveCharacter (coprimePart q c) β := by
  unfold Schar
  congr 1; ext n
  have h := changeLevel_apply_natCast (DirichletCharacter.conductor_dvd_level ψ)
    ψ.primitiveCharacter n
  rw [DirichletCharacter.changeLevel_primitiveCharacter] at h
  rw [h]
  unfold coprimePart
  split_ifs <;> simp

private theorem gauss_norm_le {q : ℕ} [NeZero q] (ψ : DirichletCharacter ℂ q) :
    ‖gaussSum ψ ZMod.stdAddChar‖ ≤ √q := by
  rw [← Real.sqrt_sq (norm_nonneg (gaussSum ψ ZMod.stdAddChar)), norm_sq_gaussSum ψ]
  have hle := Nat.le_of_dvd (Nat.pos_of_ne_zero (NeZero.ne q)) (DirichletCharacter.conductor_dvd_level ψ)
  split_ifs
  · exact Real.sqrt_le_sqrt (by exact_mod_cast hle)
  · exact Real.sqrt_le_sqrt (by positivity)

theorem coprime_character_error {q : ℕ} [NeZero q] {a : ℕ → ℂ}
    (ha : Summable fun n => ‖a n‖) (hcop : ∀ n, a n ≠ 0 → Nat.Coprime n q)
    (β : ℝ) {b : ZMod q} (hb : IsUnit b) (M : ℂ) {E : ℝ}
    (hχ : ∀ ψ : DirichletCharacter ℂ q, ‖Schar ψ⁻¹ a β - (if ψ=1 then M else 0)‖ ≤ E) :
    ‖expTsum a (b.val/q+β) - ((μ q:ℂ)/q.totient)*M‖ ≤ √q*E := by
  classical
  let C := fun ψ : DirichletCharacter ℂ q => ψ b⁻¹ * gaussSum ψ ZMod.stdAddChar
  have hid := character_inversion ha hcop β hb
  have hu : IsUnit b⁻¹ := by
    rw [← hb.unit_spec, ZMod.inv_coe_unit]; exact Units.isUnit _
  have hmain : ∑ ψ : DirichletCharacter ℂ q, C ψ*(if ψ=1 then M else 0) = (μ q:ℂ)*M := by
    simp [C, mul_ite, MulChar.one_apply hu,gaussSum_one_eq]
  have hφ : (0:ℝ)<q.totient := by exact_mod_cast Nat.totient_pos.mpr (Nat.pos_of_ne_zero (NeZero.ne q))
  have hφ' : (q.totient:ℂ) ≠ 0 := by exact_mod_cast hφ.ne'
  have herr : (q.totient:ℂ)*(expTsum a (b.val/q+β)-((μ q:ℂ)/q.totient)*M) =
      ∑ ψ : DirichletCharacter ℂ q, C ψ*(Schar ψ⁻¹ a β-(if ψ=1 then M else 0)) := by
    simp_rw [mul_sub]; rw [sum_sub_distrib,hmain]
    simp only [C,mul_assoc]; rw [hid]; field_simp
  have hC (ψ : DirichletCharacter ℂ q) : ‖C ψ‖ ≤ √q := by
    dsimp [C]; rw [norm_mul]
    exact (mul_le_of_le_one_left (norm_nonneg _) (DirichletCharacter.norm_le_one _ _)).trans (gauss_norm_le ψ)
  have he : 0 ≤ E := (norm_nonneg _).trans (hχ 1)
  have hc : Fintype.card (DirichletCharacter ℂ q)=q.totient := by
    rw [← Nat.card_eq_fintype_card,DirichletCharacter.card_eq_totient_of_hasEnoughRootsOfUnity]
  have hn := congrArg norm herr
  rw [norm_mul,Complex.norm_natCast] at hn
  apply (mul_le_mul_iff_right₀ hφ).mp
  rw [hn]
  apply (norm_sum_le ..).trans
  calc _ ≤ ∑ _ : DirichletCharacter ℂ q, √q*E := Finset.sum_le_sum fun ψ _ => by
         rw [norm_mul]; exact mul_le_mul (hC ψ) (hχ ψ) (norm_nonneg _) (Real.sqrt_nonneg _)
       _ = _ := by simp [hc,nsmul_eq_mul]

#print axioms coprime_character_error
end GoldbachEnergy
