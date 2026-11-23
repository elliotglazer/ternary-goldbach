import RawLogHorner
import Mathlib.Tactic.FieldSimp

/-! The raw-head logarithm program, with a cached grid137 log2 and grid129 export.
These internal producer lemmas have explicit, checked range-reduction inputs. -/

namespace RawHead

def logInner (k x : ℕ) : ℤ :=
  (k : ℤ) * logCenter (2 ^ 137) 1 3 45 +
    logCenter (2 ^ 137) (x - 2 ^ k) (x + 2 ^ k) 45

def log129Center (k x : ℕ) : ℤ := roundDiv 256 (logInner k x)

/-- The executable path with an explicitly supplied shared grid137 log2 center. -/
def log129WithLogTwo (logTwo137 : ℤ) (k x : ℕ) : ℤ :=
  roundDiv 256 ((k : ℤ) * logTwo137 +
    logCenter (2 ^ 137) (x - 2 ^ k) (x + 2 ^ k) 45)

theorem log129WithLogTwo_eq {l2 : ℤ}
    (h : l2 = logCenter (2 ^ 137) 1 3 45) (k x : ℕ) :
    log129WithLogTwo l2 k x = log129Center k x := by
  subst l2
  rfl

theorem log129_round_error (r : ℤ) :
    |(roundDiv 256 r : ℝ) / 2 ^ 129 - (r : ℝ) / 2 ^ 137| ≤
      1 / (2 ^ 130 : ℝ) := by
  have h := roundDiv_error (d := 256) (r := r) (by norm_num)
  have he : (roundDiv 256 r : ℝ) / 2 ^ 129 - (r : ℝ) / 2 ^ 137 =
      ((roundDiv 256 r : ℝ) - (r : ℝ) / 256) / 2 ^ 129 := by
    norm_num
    ring
  rw [he, abs_div, abs_of_pos (by positivity : (0 : ℝ) < 2 ^ 129)]
  exact (div_le_div_of_nonneg_right h (by positivity)).trans (by norm_num)

theorem logInner_error {x k : ℕ} (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    |(logInner k x : ℝ) / 2 ^ 137 -
      ((k : ℝ) * logPartial 45 (1 / 3) +
        logPartial 45 (((x : ℝ) - 2 ^ k) / (x + 2 ^ k)))| ≤
      19 * 7 / (4 * (2 ^ 137 : ℝ)) := by
  have hB : 0 < x + 2 ^ k := by positivity
  have hAB : 3 * (x - 2 ^ k) ≤ x + 2 ^ k := by omega
  have htwo := logCenter_error (S := 2 ^ 137) (A := 1) (B := 3)
    (by positivity) (by decide) (by decide) 45
  have hx := logCenter_error (S := 2 ^ 137) (A := x - 2 ^ k) (B := x + 2 ^ k)
    (by positivity) hB hAB 45
  have hratio : ((x - 2 ^ k : ℕ) : ℝ) / ((x + 2 ^ k : ℕ) : ℝ) =
      ((x : ℝ) - 2 ^ k) / (x + 2 ^ k) := by
    simp only [Nat.cast_sub hlo, Nat.cast_add, Nat.cast_pow, Nat.cast_ofNat]
  rw [hratio] at hx
  simp only [Nat.cast_pow, Nat.cast_ofNat, Nat.cast_one] at htwo hx
  have he : (logInner k x : ℝ) / 2 ^ 137 -
      ((k : ℝ) * logPartial 45 (1 / 3) +
        logPartial 45 (((x : ℝ) - 2 ^ k) / (x + 2 ^ k))) =
      (k : ℝ) * ((logCenter (2 ^ 137) 1 3 45 : ℝ) / 2 ^ 137 -
        logPartial 45 (1 / 3)) +
      ((logCenter (2 ^ 137) (x - 2 ^ k) (x + 2 ^ k) 45 : ℝ) / 2 ^ 137 -
        logPartial 45 (((x : ℝ) - 2 ^ k) / (x + 2 ^ k))) := by
    simp only [logInner, Int.cast_add, Int.cast_mul, Int.cast_natCast]
    ring
  rw [he]
  calc
    _ ≤ |(k : ℝ) * ((logCenter (2 ^ 137) 1 3 45 : ℝ) / 2 ^ 137 -
          logPartial 45 (1 / 3))| +
        |(logCenter (2 ^ 137) (x - 2 ^ k) (x + 2 ^ k) 45 : ℝ) / 2 ^ 137 -
          logPartial 45 (((x : ℝ) - 2 ^ k) / (x + 2 ^ k))| := abs_add_le _ _
    _ ≤ (k : ℝ) * (7 / (4 * (2 ^ 137 : ℝ))) + 7 / (4 * (2 ^ 137 : ℝ)) := by
      rw [abs_mul, show |(k : ℝ)| = (k : ℝ) from abs_of_nonneg (Nat.cast_nonneg k)]
      exact add_le_add (mul_le_mul_of_nonneg_left htwo (Nat.cast_nonneg k)) hx
    _ ≤ (18 : ℝ) * (7 / (4 * (2 ^ 137 : ℝ))) + 7 / (4 * (2 ^ 137 : ℝ)) := by
      exact add_le_add (mul_le_mul_of_nonneg_right
        (show (k : ℝ) ≤ 18 by exact_mod_cast hk)
        (by positivity : (0 : ℝ) ≤ 7 / (4 * (2 ^ 137 : ℝ)))) le_rfl
    _ = _ := by ring

theorem log129Center_error {x k : ℕ} (hx : 0 < x) (hk : k ≤ 18)
    (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k) :
    |Real.log (x : ℝ) - (log129Center k x : ℝ) / 2 ^ 129| <
      1 / (2 ^ 128 : ℝ) := by
  have ht := logPartial45_range_error (x := (x : ℝ)) (k := k)
    (by exact_mod_cast hx) hk (by exact_mod_cast hlo) (by exact_mod_cast hhi)
  have hi := logInner_error hk hlo hhi
  have hr := log129_round_error (logInner k x)
  rw [abs_sub_comm] at hi hr
  have h := (abs_sub_le (Real.log (x : ℝ))
      ((k : ℝ) * logPartial 45 (1 / 3) +
        logPartial 45 (((x : ℝ) - 2 ^ k) / (x + 2 ^ k)))
      ((logInner k x : ℝ) / 2 ^ 137)).trans (add_le_add ht hi)
  have hfinal := (abs_sub_le (Real.log (x : ℝ)) ((logInner k x : ℝ) / 2 ^ 137)
      ((log129Center k x : ℝ) / 2 ^ 129)).trans (add_le_add h hr)
  exact hfinal.trans_lt (by norm_num)

end RawHead
