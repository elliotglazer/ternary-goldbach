import Lean.Elab.Tactic.Omega

/-! Kernel-only certificates for a complete radix-two butterfly stage.
The integer grid is explicit. The coefficients are exact dyadic numbers;
identification with roots of unity is a separate obligation.
-/
namespace BatchedTransform

structure Input where
  ur : Int
  ui : Int
  vr : Int
  vi : Int
  wr : Int
  wi : Int
  deriving Repr

structure Output where
  pr : Int
  pi : Int
  mr : Int
  mi : Int
  deriving Repr

def within (b x : Int) : Bool := decide (-b ≤ x ∧ x ≤ b)

def inputOk (s b : Int) (x : Input) : Bool :=
  within b x.ur && within b x.ui && within b x.vr && within b x.vi &&
  within s x.wr && within s x.wi

def outputOk (b : Int) (y : Output) : Bool :=
  within (4*b) y.pr && within (4*b) y.pi &&
  within (4*b) y.mr && within (4*b) y.mi

/-- Three-product complex multiplication, including both butterfly outputs.
The residual inequalities specify nearest rounding, with positive half ties.
No division, transcendental evaluation, or native proof acceptance occurs here. -/
def checkOne (s b : Int) (x : Input) (y : Output) : Bool :=
  let t := x.wr * (x.vr + x.vi)
  let u := x.vi * (x.wr + x.wi)
  let v := x.vr * (x.wi - x.wr)
  let rr := t-u
  let ii := t+v
  inputOk s b x && outputOk b y &&
  within (4*b*s) t && within (4*b*s) u && within (4*b*s) v &&
  decide (y.pr + y.mr = 2*x.ur ∧ y.pi + y.mi = 2*x.ui ∧
    -s ≤ 2*(rr-(y.pr-x.ur)*s) ∧ 2*(rr-(y.pr-x.ur)*s) < s ∧
    -s ≤ 2*(ii-(y.pi-x.ui)*s) ∧ 2*(ii-(y.pi-x.ui)*s) < s)

/-- A mismatched list length is rejected, including an omitted last output. -/
def checkStage (s b : Int) : List Input → List Output → Bool
  | [], [] => true
  | x::xs, y::ys => checkOne s b x y && checkStage s b xs ys
  | _, _ => false

def butterfly_spec (s b : Int) (x : Input) (y : Output) : Prop :=
  inputOk s b x = true ∧ outputOk b y = true ∧
  (-s ≤ 2*(x.ur*s + (x.vr*x.wr-x.vi*x.wi) - y.pr*s) ∧
    2*(x.ur*s + (x.vr*x.wr-x.vi*x.wi) - y.pr*s) ≤ s) ∧
  (-s ≤ 2*(x.ui*s + (x.vr*x.wi+x.vi*x.wr) - y.pi*s) ∧
    2*(x.ui*s + (x.vr*x.wi+x.vi*x.wr) - y.pi*s) ≤ s) ∧
  (-s ≤ 2*(x.ur*s - (x.vr*x.wr-x.vi*x.wi) - y.mr*s) ∧
    2*(x.ur*s - (x.vr*x.wr-x.vi*x.wi) - y.mr*s) ≤ s) ∧
  (-s ≤ 2*(x.ui*s - (x.vr*x.wi+x.vi*x.wr) - y.mi*s) ∧
    2*(x.ui*s - (x.vr*x.wi+x.vi*x.wr) - y.mi*s) ≤ s)

theorem three_real (a b c d : Int) : c*(a+b)-b*(c+d)=a*c-b*d := by
  rw [Int.mul_add, Int.mul_add, Int.mul_comm c a, Int.mul_comm c b]
  omega

theorem three_imag (a b c d : Int) : c*(a+b)+a*(d-c)=a*d+b*c := by
  rw [Int.mul_add, Int.mul_sub, Int.mul_comm c a, Int.mul_comm c b]
  omega

theorem checkOne_sound (s b : Int) (x : Input) (y : Output)
    (h : checkOne s b x y = true) : butterfly_spec s b x y := by
  simp only [checkOne, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨⟨⟨⟨hin, hout⟩, _⟩, _⟩, _⟩, hp, hi, hr0, hr1, hi0, hi1⟩ := h
  rw [three_real] at hr0 hr1
  rw [three_imag] at hi0 hi1
  rw [Int.sub_mul] at hr0 hr1 hi0 hi1
  have hpr := congrArg (fun z : Int => z*s) hp
  have hpi := congrArg (fun z : Int => z*s) hi
  simp only [Int.add_mul, Int.mul_assoc] at hpr hpi
  refine ⟨hin, hout, ?_, ?_, ?_, ?_⟩ <;> omega

def stage_spec (s b : Int) : List Input → List Output → Prop
  | [], [] => True
  | x::xs, y::ys => butterfly_spec s b x y ∧ stage_spec s b xs ys
  | _, _ => False

theorem checkStage_cons (s b : Int) (x : Input) (y : Output)
    (xs : List Input) (ys : List Output)
    (h : checkOne s b x y = true) (ht : checkStage s b xs ys = true) :
    checkStage s b (x::xs) (y::ys) = true := by
  simp only [checkStage, h, ht, Bool.and_true]

theorem checkStage_sound (s b : Int) (xs : List Input) (ys : List Output)
    (h : checkStage s b xs ys = true) :
    stage_spec s b xs ys := by
  induction xs generalizing ys with
  | nil => cases ys with
    | nil => exact True.intro
    | cons y ys => simp only [checkStage, Bool.false_eq_true] at h
  | cons x xs ih => cases ys with
    | nil => simp only [checkStage, Bool.false_eq_true] at h
    | cons y ys =>
      simp only [checkStage, Bool.and_eq_true] at h
      exact ⟨checkOne_sound s b x y h.1, ih ys h.2⟩

end BatchedTransform
