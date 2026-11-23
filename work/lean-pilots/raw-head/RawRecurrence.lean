import Mathlib.Analysis.Complex.Norm
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Positivity

/-!
Internal error lemmas for the persistent raw-head powers, following section 4 of
`RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`.

These lemmas consume local step and rounding bounds. They do not construct the
elementary certificates, establish a stored-grid identity, or certify a complete
raw-head producer. The numerical corollary uses a linear bootstrap, avoiding any
evaluation of a power with exponent 90000.
-/

namespace RawHead

/-- One rounded update, including the product of step and state errors. -/
theorem rounded_mul_error_le
    {b w z v z' : ℂ} {eps u : ℝ}
    (heps : 0 ≤ eps) (hb : ‖b‖ ≤ 1) (hw : ‖w‖ = 1)
    (hv : ‖v - w‖ ≤ eps) (hr : ‖z' - z * v‖ ≤ u) :
    ‖z' - b * w‖ ≤ (1 + eps) * ‖z - b‖ + eps + u := by
  have hvnorm : ‖v‖ ≤ 1 + eps := by
    calc
      ‖v‖ = ‖(v - w) + w‖ := by congr 1; ring
      _ ≤ ‖v - w‖ + ‖w‖ := norm_add_le _ _
      _ ≤ 1 + eps := by rw [hw]; linarith only [hv]
  have hfirst : ‖z - b‖ * ‖v‖ ≤ ‖z - b‖ * (1 + eps) :=
    mul_le_mul_of_nonneg_left hvnorm (norm_nonneg _)
  have hsecond : ‖b‖ * ‖v - w‖ ≤ eps := by
    calc
      ‖b‖ * ‖v - w‖ ≤ 1 * eps :=
        mul_le_mul hb hv (norm_nonneg _) (by norm_num)
      _ = eps := one_mul _
  calc
    ‖z' - b * w‖ = ‖(z' - z * v) + ((z - b) * v + b * (v - w))‖ := by
      congr 1; ring
    _ ≤ ‖z' - z * v‖ + ‖(z - b) * v + b * (v - w)‖ := norm_add_le _ _
    _ ≤ ‖z' - z * v‖ + (‖(z - b) * v‖ + ‖b * (v - w)‖) :=
      add_le_add le_rfl (norm_add_le _ _)
    _ = ‖z' - z * v‖ + (‖z - b‖ * ‖v‖ + ‖b‖ * ‖v - w‖) := by
      rw [Complex.norm_mul, Complex.norm_mul]
    _ ≤ (1 + eps) * ‖z - b‖ + eps + u := by
      nlinarith only [hr, hfirst, hsecond]

/-- A finite-prefix geometric bound for the scalar error recurrence. -/
theorem recurrence_prefix_le
    {e : ℕ → ℝ} {eps u e0 : ℝ} {N : ℕ}
    (heps : 0 ≤ eps) (hu : 0 ≤ u) (h0 : e 0 ≤ e0)
    (hstep : ∀ j < N, e (j + 1) ≤ (1 + eps) * e j + eps + u) :
    ∀ j ≤ N, e j ≤ (1 + eps) ^ j * (e0 + (j : ℝ) * (eps + u)) := by
  intro j
  induction j with
  | zero =>
    intro _
    simpa using h0
  | succ j ih =>
    intro hj
    have hjN : j < N := Nat.lt_of_succ_le hj
    have hi := ih (Nat.le_of_lt hjN)
    have ha : 0 ≤ 1 + eps := by linarith only [heps]
    have hp : 1 ≤ (1 + eps) ^ (j + 1) :=
      one_le_pow₀ (by linarith only [heps])
    have hb : 0 ≤ eps + u := add_nonneg heps hu
    have hscaled := mul_le_mul_of_nonneg_left hi ha
    have hlast : eps + u ≤ (1 + eps) ^ (j + 1) * (eps + u) := by
      simpa only [one_mul] using mul_le_mul_of_nonneg_right hp hb
    calc
      e (j + 1) ≤ (1 + eps) * e j + eps + u := hstep j hjN
      _ ≤ (1 + eps) * ((1 + eps) ^ j * (e0 + (j : ℝ) * (eps + u))) +
          (1 + eps) ^ (j + 1) * (eps + u) := by
        linarith only [hscaled, hlast]
      _ = (1 + eps) ^ (j + 1) * (e0 + ((j + 1 : ℕ) : ℝ) * (eps + u)) := by
        rw [pow_succ, Nat.cast_add, Nat.cast_one]
        ring

/-- If the proposed linear envelope stays below one, it closes the bootstrap.
The local additive error is two copies of `delta`, one for the step and one for
the update round. The multiplicative `delta * e j` term is retained. -/
theorem recurrence_linear_prefix_le
    {e : ℕ → ℝ} {delta e0 : ℝ} {N : ℕ}
    (hd : 0 ≤ delta) (h0 : e 0 ≤ e0)
    (hcap : e0 + 3 * (N : ℝ) * delta ≤ 1)
    (hstep : ∀ j < N, e (j + 1) ≤ (1 + delta) * e j + delta + delta) :
    ∀ j ≤ N, e j ≤ e0 + 3 * (j : ℝ) * delta := by
  intro j
  induction j with
  | zero =>
    intro _
    simpa using h0
  | succ j ih =>
    intro hj
    have hjN : j < N := Nat.lt_of_succ_le hj
    have hi := ih (Nat.le_of_lt hjN)
    have hjR : (j : ℝ) ≤ (N : ℝ) := by exact_mod_cast Nat.le_of_lt hjN
    have hprod : 3 * (j : ℝ) * delta ≤ 3 * (N : ℝ) * delta := by
      gcongr
    have he : e j ≤ 1 := by linarith only [hi, hprod, hcap]
    have hcross : delta * e j ≤ delta := by
      simpa only [mul_one] using mul_le_mul_of_nonneg_left he hd
    have hs := hstep j hjN
    push_cast
    nlinarith only [hs, hcross, hi]

/-- The persistent-power recurrence has the required scalar error recurrence. -/
theorem power_state_error_step
    {b w v : ℂ} {z : ℕ → ℂ} {eps u : ℝ} {j : ℕ}
    (heps : 0 ≤ eps) (hb : ‖b‖ ≤ 1) (hw : ‖w‖ = 1)
    (hv : ‖v - w‖ ≤ eps) (hr : ‖z (j + 1) - z j * v‖ ≤ u) :
    ‖z (j + 1) - b * w ^ (j + 1)‖ ≤
      (1 + eps) * ‖z j - b * w ^ j‖ + eps + u := by
  have htrue : ‖b * w ^ j‖ ≤ 1 := by
    simpa only [Complex.norm_mul, Complex.norm_pow, hw, one_pow, mul_one] using hb
  have h := rounded_mul_error_le heps htrue hw hv hr
  simpa only [pow_succ, mul_assoc] using h

/-- Explicit error bound for a finite prefix of approximate complex powers. -/
theorem power_state_error_prefix
    {b w v : ℂ} {z : ℕ → ℂ} {eps u e0 : ℝ} {N : ℕ}
    (heps : 0 ≤ eps) (hu : 0 ≤ u) (hb : ‖b‖ ≤ 1) (hw : ‖w‖ = 1)
    (hv : ‖v - w‖ ≤ eps) (h0 : ‖z 0 - b‖ ≤ e0)
    (hr : ∀ j < N, ‖z (j + 1) - z j * v‖ ≤ u) :
    ∀ j ≤ N, ‖z j - b * w ^ j‖ ≤
      (1 + eps) ^ j * (e0 + (j : ℝ) * (eps + u)) := by
  apply recurrence_prefix_le heps hu
  · simpa only [pow_zero, mul_one] using h0
  · intro j hj
    exact power_state_error_step heps hb hw hv (hr j hj)

/-- Section 4's uniform persistent-state bound. Local source and rounding
certificates remain hypotheses; no concrete producer is asserted here. -/
theorem power_state_error_lt_dyadic96
    {b w v : ℂ} {z : ℕ → ℂ}
    (hb : ‖b‖ ≤ 1) (hw : ‖w‖ = 1)
    (hv : ‖v - w‖ ≤ 1 / (2 : ℝ) ^ 120)
    (h0 : ‖z 0 - b‖ ≤ 1 / (2 : ℝ) ^ 98)
    (hr : ∀ j < 90000, ‖z (j + 1) - z j * v‖ ≤ 1 / (2 : ℝ) ^ 120) :
    ∀ j ≤ 90000, ‖z j - b * w ^ j‖ < 1 / (2 : ℝ) ^ 96 := by
  have hd : (0 : ℝ) ≤ 1 / (2 : ℝ) ^ 120 := by positivity
  have hinit : ‖z 0 - b * w ^ 0‖ ≤ 1 / (2 : ℝ) ^ 98 := by
    simpa only [pow_zero, mul_one] using h0
  have hcap : (1 / (2 : ℝ) ^ 98) + 3 * (90000 : ℝ) * (1 / (2 : ℝ) ^ 120) ≤ 1 := by
    norm_num
  have hlin := recurrence_linear_prefix_le (e := fun j => ‖z j - b * w ^ j‖)
    (N := 90000) hd hinit hcap
    (fun j hj => power_state_error_step hd hb hw hv (hr j hj))
  intro j hj
  have hjR : (j : ℝ) ≤ 90000 := by exact_mod_cast hj
  have hprod : 3 * (j : ℝ) * (1 / (2 : ℝ) ^ 120) ≤
      3 * (90000 : ℝ) * (1 / (2 : ℝ) ^ 120) := by gcongr
  calc
    ‖z j - b * w ^ j‖ ≤ 1 / (2 : ℝ) ^ 98 + 3 * (j : ℝ) * (1 / (2 : ℝ) ^ 120) :=
      hlin j hj
    _ ≤ 1 / (2 : ℝ) ^ 98 + 3 * (90000 : ℝ) * (1 / (2 : ℝ) ^ 120) :=
      add_le_add le_rfl hprod
    _ < 1 / (2 : ℝ) ^ 96 := by norm_num

end RawHead
