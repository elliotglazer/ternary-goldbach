import StageCheck
import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-! Interpretation of the integer certificate as real error bounds.
The input and coefficient centers denote their literal integer values / scale.
-/
namespace BatchedTransform
noncomputable section

def dyadicValue (s z : Int) : ℝ := (z : ℝ) / (s : ℝ)

theorem scaled_residual_bound (s z : Int) (hs : 0 < s)
    (h : -s ≤ 2*z ∧ 2*z ≤ s) :
    |(z : ℝ) / (s : ℝ)^2| ≤ 1 / (2*(s : ℝ)) := by
  have hs' : (0 : ℝ) < s := by exact_mod_cast hs
  have hz : -(s : ℝ) ≤ 2*(z : ℝ) ∧ 2*(z : ℝ) ≤ s := by exact_mod_cast h
  rw [abs_div, abs_of_pos (sq_pos_of_pos hs')]
  apply (div_le_iff₀ (sq_pos_of_pos hs')).2
  have ha : |(z : ℝ)| ≤ (s : ℝ)/2 := by
    rw [abs_le]
    constructor <;> linarith [hz.1, hz.2]
  calc
    |(z : ℝ)| ≤ (s : ℝ)/2 := ha
    _ = 1 / (2*(s : ℝ)) * (s : ℝ)^2 := by field_simp

theorem coordinate_error (s u a c b d y : Int) (hs : 0 < s)
    (h : -s ≤ 2*(u*s+(a*c+b*d)-y*s) ∧
      2*(u*s+(a*c+b*d)-y*s) ≤ s) :
    |dyadicValue s u +
      (dyadicValue s a * dyadicValue s c + dyadicValue s b * dyadicValue s d) -
      dyadicValue s y| ≤ 1 / (2*(s : ℝ)) := by
  have hh := scaled_residual_bound s (u*s+(a*c+b*d)-y*s) hs h
  have hs' : (s : ℝ) ≠ 0 := by exact_mod_cast (Int.ne_of_gt hs)
  have heq : dyadicValue s u +
      (dyadicValue s a * dyadicValue s c + dyadicValue s b * dyadicValue s d) -
      dyadicValue s y = ((u*s+(a*c+b*d)-y*s : Int) : ℝ) / (s : ℝ)^2 := by
    simp only [dyadicValue, Int.cast_sub, Int.cast_add, Int.cast_mul]
    field_simp
  rw [heq]
  exact hh

def butterfly_real_spec (s : Int) (x : Input) (y : Output) : Prop :=
  let U := dyadicValue s x.ur
  let V := dyadicValue s x.ui
  let A := dyadicValue s x.vr * dyadicValue s x.wr -
    dyadicValue s x.vi * dyadicValue s x.wi
  let B := dyadicValue s x.vr * dyadicValue s x.wi +
    dyadicValue s x.vi * dyadicValue s x.wr
  |U+A-dyadicValue s y.pr| ≤ 1/(2*(s : ℝ)) ∧
  |V+B-dyadicValue s y.pi| ≤ 1/(2*(s : ℝ)) ∧
  |U-A-dyadicValue s y.mr| ≤ 1/(2*(s : ℝ)) ∧
  |V-B-dyadicValue s y.mi| ≤ 1/(2*(s : ℝ))

theorem butterfly_real_of_spec (s b : Int) (hs : 0 < s)
    (x : Input) (y : Output) (h : butterfly_spec s b x y) :
    butterfly_real_spec s x y := by
  obtain ⟨_, _, hpr, hpi, hmr, hmi⟩ := h
  have hp := coordinate_error s x.ur x.vr x.wr (-x.vi) x.wi y.pr hs (by
    simpa only [Int.neg_mul, Int.sub_eq_add_neg] using hpr)
  have hi := coordinate_error s x.ui x.vr x.wi x.vi x.wr y.pi hs hpi
  have hm := coordinate_error s x.ur (-x.vr) x.wr x.vi x.wi y.mr hs (by
    simpa only [Int.neg_mul, Int.sub_eq_add_neg, Int.neg_add, Int.neg_neg,
      Int.add_assoc] using hmr)
  have hn := coordinate_error s x.ui (-x.vr) x.wi (-x.vi) x.wr y.mi hs (by
    simpa only [Int.neg_mul, Int.sub_eq_add_neg, Int.neg_add, Int.add_assoc] using hmi)
  unfold butterfly_real_spec
  simp only [dyadicValue, Int.cast_neg, neg_div, neg_mul] at hp hi hm hn ⊢
  constructor
  · simpa only [sub_eq_add_neg] using hp
  constructor
  · exact hi
  constructor
  · simpa only [sub_eq_add_neg, neg_add, neg_neg, add_assoc] using hm
  · simpa only [sub_eq_add_neg, neg_add, add_assoc] using hn

def stage_real_spec (s : Int) : List Input → List Output → Prop
  | [], [] => True
  | x::xs, y::ys => butterfly_real_spec s x y ∧ stage_real_spec s xs ys
  | _, _ => False

theorem stage_real_of_spec (s b : Int) (hs : 0 < s)
    (xs : List Input) (ys : List Output) (h : stage_spec s b xs ys) :
    stage_real_spec s xs ys := by
  induction xs generalizing ys with
  | nil => cases ys with
    | nil => exact True.intro
    | cons y ys => exact h
  | cons x xs ih => cases ys with
    | nil => exact h
    | cons y ys =>
      exact ⟨butterfly_real_of_spec s b hs x y h.1, ih ys h.2⟩

end
end BatchedTransform
