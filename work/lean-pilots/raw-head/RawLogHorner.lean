import RawLogTail
import Lean.Elab.Tactic.Omega

/-! Internal raw-head pilot: integer round-to-nearest and fixed-grid logarithm Horner.
All bounds concern the actual integer division algorithm. -/

namespace RawHead

/-- Nearest integer to `r / d` for positive `d`, with ties toward positive infinity. -/
def roundDiv (d r : ℤ) : ℤ := (2 * r + d) / (2 * d)

lemma roundDiv_error {d r : ℤ} (hd : 0 < d) :
    |(roundDiv d r : ℝ) - (r : ℝ) / (d : ℝ)| ≤ 1 / 2 := by
  have h2d : 0 < 2 * d := by omega
  have hm0 := Int.emod_nonneg (2 * r + d) (ne_of_gt h2d)
  have hm1 := Int.emod_lt_of_pos (2 * r + d) h2d
  have he : (2 * d) * roundDiv d r + (2 * r + d) % (2 * d) = 2 * r + d := by
    exact Int.mul_ediv_add_emod (2 * r + d) (2 * d)
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd
  have hm0R : (0 : ℝ) ≤ ((2 * r + d) % (2 * d) : ℤ) := by exact_mod_cast hm0
  have hm1R : (((2 * r + d) % (2 * d) : ℤ) : ℝ) < 2 * (d : ℝ) := by
    exact_mod_cast hm1
  have heR : 2 * (d : ℝ) * (roundDiv d r : ℝ) +
      (((2 * r + d) % (2 * d) : ℤ) : ℝ) = 2 * (r : ℝ) + (d : ℝ) := by
    exact_mod_cast he
  have hb : |(d : ℝ) * (roundDiv d r : ℝ) - (r : ℝ)| ≤ (d : ℝ) / 2 := by
    apply abs_le.mpr
    constructor <;> nlinarith only [heR, hm0R, hm1R]
  calc
    |(roundDiv d r : ℝ) - (r : ℝ) / (d : ℝ)| =
        |((d : ℝ) * (roundDiv d r : ℝ) - (r : ℝ)) / (d : ℝ)| := by
      congr 1
      field_simp [ne_of_gt hdR]
    _ = |(d : ℝ) * (roundDiv d r : ℝ) - (r : ℝ)| / (d : ℝ) := by
      rw [abs_div, abs_of_pos hdR]
    _ ≤ ((d : ℝ) / 2) / (d : ℝ) :=
      div_le_div_of_nonneg_right hb hdR.le
    _ = 1 / 2 := by field_simp [ne_of_gt hdR]

/-- Each recursive step performs one integer rounding on the fixed grid `S`. -/
def logHorner (S A B : ℕ) : ℕ → ℕ → ℤ
  | 0, _ => 0
  | N + 1, k =>
      roundDiv ((2 * (k : ℤ) + 1) * (B : ℤ) ^ 2)
        ((S : ℤ) * (B : ℤ) ^ 2 +
          (2 * (k : ℤ) + 1) * (A : ℤ) ^ 2 * logHorner S A B N (k + 1))

/-- Final multiplication by the exact rational `2*A/B`, followed by one rounding. -/
def logCenter (S A B N : ℕ) : ℤ :=
  roundDiv (B : ℤ) (2 * (A : ℤ) * logHorner S A B N 0)

noncomputable def logHornerIdeal (v : ℝ) : ℕ → ℕ → ℝ
  | 0, _ => 0
  | N + 1, k => 1 / (2 * (k : ℝ) + 1) + v ^ 2 * logHornerIdeal v N (k + 1)

lemma logHornerIdeal_eq_sum (v : ℝ) (N k : ℕ) :
    logHornerIdeal v N k =
      ∑ j ∈ Finset.range N, v ^ (2 * j) / (2 * ((k : ℝ) + (j : ℝ)) + 1) := by
  induction N generalizing k with
  | zero => simp [logHornerIdeal]
  | succ N ih =>
    rw [logHornerIdeal, ih, Finset.sum_range_succ']
    simp only [Nat.cast_zero, add_zero, mul_zero, pow_zero]
    rw [Finset.mul_sum]
    have hs :
        (∑ j ∈ Finset.range N,
          v ^ 2 * (v ^ (2 * j) / (2 * (((k + 1 : ℕ) : ℝ) + (j : ℝ)) + 1))) =
        ∑ j ∈ Finset.range N,
          v ^ (2 * (j + 1)) / (2 * ((k : ℝ) + ((j + 1 : ℕ) : ℝ)) + 1) := by
      apply Finset.sum_congr rfl
      intro j hj
      have hp : 2 * (j + 1) = 2 * j + 2 := by omega
      rw [hp, pow_add]
      push_cast
      have hden : 2 * ((k : ℝ) + 1 + (j : ℝ)) + 1 =
          2 * ((k : ℝ) + ((j : ℝ) + 1)) + 1 := by ring
      rw [hden]
      ring
    rw [hs]
    ring

lemma logPartial_eq_horner (N : ℕ) (v : ℝ) :
    logPartial N v = 2 * v * logHornerIdeal v N 0 := by
  rw [logPartial, logHornerIdeal_eq_sum]
  simp only [Nat.cast_zero, zero_add]
  rw [mul_assoc]
  congr 1
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  rw [pow_add, pow_one]
  ring

lemma logHorner_error {S A B : ℕ} (hB : 0 < B) (hAB : 3 * A ≤ B)
    (N k : ℕ) :
    |(logHorner S A B N k : ℝ) -
      (S : ℝ) * logHornerIdeal ((A : ℝ) / (B : ℝ)) N k| ≤ 1 := by
  have hBR : (0 : ℝ) < B := by exact_mod_cast hB
  have hBI : (0 : ℤ) < B := by exact_mod_cast hB
  have hABR : 3 * (A : ℝ) ≤ (B : ℝ) := by exact_mod_cast hAB
  let v : ℝ := (A : ℝ) / (B : ℝ)
  have hv0 : 0 ≤ v := by dsimp [v]; positivity
  have hv1 : v ≤ 1 / 3 := by
    dsimp [v]
    apply (div_le_iff₀ hBR).mpr
    linarith only [hABR]
  have hv2 : v ^ 2 ≤ 1 / 9 := by
    have hp := mul_nonneg (sub_nonneg.mpr hv1) (show 0 ≤ 1 / 3 + v by linarith)
    nlinarith only [hp]
  change |(logHorner S A B N k : ℝ) - (S : ℝ) * logHornerIdeal v N k| ≤ 1
  induction N generalizing k with
  | zero => simp [logHorner, logHornerIdeal]
  | succ N ih =>
    let d : ℤ := (2 * (k : ℤ) + 1) * (B : ℤ) ^ 2
    let r : ℤ := (S : ℤ) * (B : ℤ) ^ 2 +
      (2 * (k : ℤ) + 1) * (A : ℤ) ^ 2 * logHorner S A B N (k + 1)
    have hd : 0 < d := by dsimp [d]; positivity
    have hk : (2 * (k : ℝ) + 1) ≠ 0 := by positivity
    have hq : (r : ℝ) / (d : ℝ) =
        (S : ℝ) / (2 * (k : ℝ) + 1) +
          v ^ 2 * (logHorner S A B N (k + 1) : ℝ) := by
      dsimp [r, d, v]
      push_cast
      field_simp [ne_of_gt hBR, hk]
    have hr := roundDiv_error (r := r) hd
    rw [hq] at hr
    have ht : |v ^ 2 * ((logHorner S A B N (k + 1) : ℝ) -
        (S : ℝ) * logHornerIdeal v N (k + 1))| ≤ v ^ 2 := by
      rw [abs_mul, abs_of_nonneg (sq_nonneg v)]
      simpa using mul_le_mul_of_nonneg_left (ih (k + 1)) (sq_nonneg v)
    change |(roundDiv d r : ℝ) - (S : ℝ) *
      (1 / (2 * (k : ℝ) + 1) + v ^ 2 * logHornerIdeal v N (k + 1))| ≤ 1
    calc
      _ = |((roundDiv d r : ℝ) - ((S : ℝ) / (2 * (k : ℝ) + 1) +
          v ^ 2 * (logHorner S A B N (k + 1) : ℝ))) +
          v ^ 2 * ((logHorner S A B N (k + 1) : ℝ) -
            (S : ℝ) * logHornerIdeal v N (k + 1))| := by congr 1; ring
      _ ≤ |(roundDiv d r : ℝ) - ((S : ℝ) / (2 * (k : ℝ) + 1) +
          v ^ 2 * (logHorner S A B N (k + 1) : ℝ))| +
          |v ^ 2 * ((logHorner S A B N (k + 1) : ℝ) -
            (S : ℝ) * logHornerIdeal v N (k + 1))| := abs_add_le _ _
      _ ≤ 1 / 2 + v ^ 2 := add_le_add hr ht
      _ ≤ 1 := by linarith only [hv2]

lemma logCenter_error {S A B : ℕ} (hS : 0 < S) (hB : 0 < B)
    (hAB : 3 * A ≤ B) (N : ℕ) :
    |(logCenter S A B N : ℝ) / (S : ℝ) -
      logPartial N ((A : ℝ) / (B : ℝ))| ≤ 7 / (4 * (S : ℝ)) := by
  have hSR : (0 : ℝ) < S := by exact_mod_cast hS
  have hBR : (0 : ℝ) < B := by exact_mod_cast hB
  have hBI : (0 : ℤ) < B := by exact_mod_cast hB
  let v : ℝ := (A : ℝ) / (B : ℝ)
  have hv0 : 0 ≤ v := by dsimp [v]; positivity
  have hv1 : v ≤ 1 / 3 := by
    dsimp [v]
    apply (div_le_iff₀ hBR).mpr
    have hh : 3 * (A : ℝ) ≤ (B : ℝ) := by exact_mod_cast hAB
    linarith only [hh]
  have hr := roundDiv_error (r := 2 * (A : ℤ) * logHorner S A B N 0) hBI
  simp only [Int.cast_natCast] at hr
  have hq : (((2 * (A : ℤ) * logHorner S A B N 0 : ℤ) : ℝ) / (B : ℝ)) =
      2 * v * (logHorner S A B N 0 : ℝ) := by
    dsimp [v]
    push_cast
    ring
  rw [hq] at hr
  have ht : |2 * v * ((logHorner S A B N 0 : ℝ) -
      (S : ℝ) * logHornerIdeal v N 0)| ≤ 2 * v := by
    rw [abs_mul, abs_of_nonneg (by positivity : 0 ≤ 2 * v)]
    simpa [v] using mul_le_mul_of_nonneg_left (logHorner_error (S := S) hB hAB N 0)
      (by positivity : 0 ≤ 2 * v)
  have hb : |(logCenter S A B N : ℝ) - (S : ℝ) * logPartial N v| ≤ 7 / 4 := by
    rw [logPartial_eq_horner]
    calc
      _ = |((logCenter S A B N : ℝ) - 2 * v * (logHorner S A B N 0 : ℝ)) +
          2 * v * ((logHorner S A B N 0 : ℝ) - (S : ℝ) * logHornerIdeal v N 0)| := by
        congr 1
        ring
      _ ≤ |(logCenter S A B N : ℝ) - 2 * v * (logHorner S A B N 0 : ℝ)| +
          |2 * v * ((logHorner S A B N 0 : ℝ) - (S : ℝ) * logHornerIdeal v N 0)| :=
        abs_add_le _ _
      _ ≤ 1 / 2 + 2 * v := add_le_add hr ht
      _ ≤ 7 / 4 := by linarith only [hv1]
  change |(logCenter S A B N : ℝ) / (S : ℝ) - logPartial N v| ≤ _
  calc
    _ = |((logCenter S A B N : ℝ) - (S : ℝ) * logPartial N v) / (S : ℝ)| := by
      congr 1
      field_simp [ne_of_gt hSR]
    _ = |(logCenter S A B N : ℝ) - (S : ℝ) * logPartial N v| / (S : ℝ) := by
      rw [abs_div, abs_of_pos hSR]
    _ ≤ (7 / 4) / (S : ℝ) := div_le_div_of_nonneg_right hb hSR.le
    _ = 7 / (4 * (S : ℝ)) := by ring

end RawHead
