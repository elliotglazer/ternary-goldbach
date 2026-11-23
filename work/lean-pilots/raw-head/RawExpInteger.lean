import RawLogHorner
import RawExpHorner

/-! Internal raw-head pilot: executable signed integer exponential Horner.
The only approximation is the actual `roundDiv` in each coordinate. -/

namespace RawHead

def expIntegerStep (S : ℕ) (p : ℤ) (d k : ℕ) (w : ℤ × ℤ) : ℤ × ℤ :=
  let D : ℤ := (d : ℤ) * ((k + 1 : ℕ) : ℤ)
  (roundDiv D ((S : ℤ) * D - p * w.2), roundDiv D (p * w.1))

def expIntegerHorner (S : ℕ) (p : ℤ) (d : ℕ) : ℕ → ℕ → ℤ × ℤ
  | 0, _ => ((S : ℤ), 0)
  | N + 1, k => expIntegerStep S p d k (expIntegerHorner S p d N (k + 1))

noncomputable def expIntegerValue (S : ℕ) (w : ℤ × ℤ) : ℂ :=
  ⟨(w.1 : ℝ) / (S : ℝ), (w.2 : ℝ) / (S : ℝ)⟩

noncomputable def expPhase (p : ℤ) (d : ℕ) : ℂ :=
  Complex.I * (((p : ℝ) / (d : ℝ) : ℝ) : ℂ)

lemma expIntegerValue_literal (S : ℕ) (w : ℤ × ℤ) :
    expIntegerValue S w =
      (((w.1 : ℝ) / (S : ℝ) : ℝ) : ℂ) +
        Complex.I * (((w.2 : ℝ) / (S : ℝ) : ℝ) : ℂ) := by
  apply Complex.ext <;> simp [expIntegerValue]

lemma roundDiv_scaled_error {S : ℕ} {D r : ℤ} (hS : 0 < S) (hD : 0 < D) :
    |(roundDiv D r : ℝ) / (S : ℝ) - ((r : ℝ) / (D : ℝ)) / (S : ℝ)| ≤
      1 / (2 * (S : ℝ)) := by
  have hSR : (0 : ℝ) < S := by exact_mod_cast hS
  calc
    _ = |(roundDiv D r : ℝ) - (r : ℝ) / (D : ℝ)| / (S : ℝ) := by
      rw [← sub_div, abs_div, abs_of_pos hSR]
    _ ≤ (1 / 2 : ℝ) / (S : ℝ) :=
      div_le_div_of_nonneg_right (roundDiv_error hD) hSR.le
    _ = 1 / (2 * (S : ℝ)) := by ring

lemma expInteger_affine {S d : ℕ} (hS : 0 < S) (hd : 0 < d)
    (p : ℤ) (k : ℕ) (w : ℤ × ℤ) :
    1 + expPhase p d / ((k + 1 : ℕ) : ℂ) * expIntegerValue S w =
      (⟨(((S : ℤ) * ((d : ℤ) * ((k + 1 : ℕ) : ℤ)) - p * w.2 : ℤ) : ℝ) /
          (((d : ℤ) * ((k + 1 : ℕ) : ℤ) : ℤ) : ℝ) / (S : ℝ),
        ((p * w.1 : ℤ) : ℝ) /
          (((d : ℤ) * ((k + 1 : ℕ) : ℤ) : ℤ) : ℝ) / (S : ℝ)⟩ : ℂ) := by
  have hSR : (S : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hS)
  have hdR : (d : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hd)
  have hkR : (k : ℝ) + 1 ≠ 0 := by positivity
  apply Complex.ext <;>
    simp [expPhase, expIntegerValue, Complex.div_re, Complex.div_im, Complex.normSq] <;>
    field_simp [hSR, hdR, hkR]
  all_goals ring

lemma expIntegerStep_error {S d : ℕ} (hS : 0 < S) (hd : 0 < d)
    (p : ℤ) (k : ℕ) (w : ℤ × ℤ) :
    ‖expIntegerValue S (expIntegerStep S p d k w) -
      (1 + expPhase p d / ((k + 1 : ℕ) : ℂ) * expIntegerValue S w)‖ ≤
      1 / (S : ℝ) := by
  let D : ℤ := (d : ℤ) * ((k + 1 : ℕ) : ℤ)
  let r : ℤ := (S : ℤ) * D - p * w.2
  let i : ℤ := p * w.1
  have hD : 0 < D := by dsimp [D]; positivity
  have hr := roundDiv_scaled_error (r := r) hS hD
  have hi := roundDiv_scaled_error (r := i) hS hD
  rw [expInteger_affine hS hd]
  change ‖(⟨(roundDiv D r : ℝ) / (S : ℝ),
      (roundDiv D i : ℝ) / (S : ℝ)⟩ : ℂ) -
      ⟨(r : ℝ) / (D : ℝ) / (S : ℝ), (i : ℝ) / (D : ℝ) / (S : ℝ)⟩‖ ≤ _
  calc
    _ ≤ |(roundDiv D r : ℝ) / (S : ℝ) - (r : ℝ) / (D : ℝ) / (S : ℝ)| +
        |(roundDiv D i : ℝ) / (S : ℝ) - (i : ℝ) / (D : ℝ) / (S : ℝ)| :=
      Complex.norm_le_abs_re_add_abs_im _
    _ ≤ 1 / (2 * (S : ℝ)) + 1 / (2 * (S : ℝ)) := add_le_add hr hi
    _ = 1 / (S : ℝ) := by ring

lemma expIntegerHorner_zero {S : ℕ} (hS : 0 < S) (p : ℤ) (d k : ℕ) :
    expIntegerValue S (expIntegerHorner S p d 0 k) = 1 := by
  have hSR : (S : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hS)
  apply Complex.ext <;> simp [expIntegerHorner, expIntegerValue, hSR]

lemma expIntegerHorner_step {S d : ℕ} (hS : 0 < S) (hd : 0 < d)
    (p : ℤ) (N k : ℕ) :
    ‖expIntegerValue S (expIntegerHorner S p d (N + 1) k) -
      (1 + expPhase p d / ((k + 1 : ℕ) : ℂ) *
        expIntegerValue S (expIntegerHorner S p d N (k + 1)))‖ ≤ 1 / (S : ℝ) :=
  expIntegerStep_error hS hd p k (expIntegerHorner S p d N (k + 1))

/-- The executable 72-update Horner program approximates the literal 73-term polynomial. -/
theorem expIntegerHorner72_error {S d : ℕ} (hS : 0 < S) (hd : 0 < d)
    (p : ℤ) (hp : |(p : ℝ) / (d : ℝ)| ≤ 4) :
    ‖expIntegerValue S (expIntegerHorner S p d 72 0) -
      expPartial 73 (expPhase p d)‖ ≤ 81 / (S : ℝ) := by
  have hz : ‖expPhase p d‖ ≤ 4 := by
    simpa only [expPhase, norm_mul, Complex.norm_I, one_mul,
      Complex.norm_real, Real.norm_eq_abs] using hp
  have h := expHorner72_error (a := fun N k =>
      expIntegerValue S (expIntegerHorner S p d N k)) hz
    (by positivity : (0 : ℝ) ≤ 1 / (S : ℝ))
    (fun k => expIntegerHorner_zero hS p d k)
    (fun N k => expIntegerHorner_step hS hd p N k)
  simpa only [div_eq_mul_inv, one_mul] using h

end RawHead
