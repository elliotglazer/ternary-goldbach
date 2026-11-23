import StageCheck

namespace BatchedTransform

/-- Direct integer rounding, used only through a kernel-reduced equality. -/
def computeOne (s half : Int) (x : Input) : Output :=
  let t := x.wr*(x.vr+x.vi)
  let u := x.vi*(x.wr+x.wi)
  let v := x.vr*(x.wi-x.wr)
  let qr := (t-u+half)/s
  let qi := (t+v+half)/s
  ⟨x.ur+qr, x.ui+qi, x.ur-qr, x.ui-qi⟩

def sameOutput (x y : Output) : Bool :=
  decide (x.pr=y.pr ∧ x.pi=y.pi ∧ x.mr=y.mr ∧ x.mi=y.mi)

theorem sameOutput_eq (x y : Output) (h : sameOutput x y = true) : x=y := by
  cases x
  cases y
  simp only [sameOutput, decide_eq_true_eq] at h
  obtain ⟨rfl, rfl, rfl, rfl⟩ := h
  rfl

def checkFast (s half b : Int) (x : Input) (y : Output) : Bool :=
  let t := x.wr*(x.vr+x.vi)
  let u := x.vi*(x.wr+x.wi)
  let v := x.vr*(x.wi-x.wr)
  inputOk s b x && outputOk b y &&
  within (4*b*s) t && within (4*b*s) u && within (4*b*s) v &&
  sameOutput (computeOne s half x) y

theorem round_even (s half n : Int) (hs : 0 < s) (hh : s=2*half) :
    -s ≤ 2*(n-((n+half)/s)*s) ∧ 2*(n-((n+half)/s)*s) < s := by
  have h0 := Int.emod_nonneg (n+half) (Int.ne_of_gt hs)
  have h1 := Int.emod_lt_of_pos (n+half) hs
  have he := Int.ediv_mul_add_emod (n+half) s
  omega

theorem checkFast_implies_checkOne (s half b : Int) (hs : 0 < s)
    (hh : s=2*half) (x : Input) (y : Output)
    (h : checkFast s half b x y = true) : checkOne s b x y = true := by
  simp only [checkFast, Bool.and_eq_true] at h
  obtain ⟨⟨⟨⟨⟨hin, hout⟩, ht⟩, hu⟩, hv⟩, he⟩ := h
  have hy := sameOutput_eq _ _ he
  subst y
  have hr := round_even s half (x.wr*(x.vr+x.vi)-x.vi*(x.wr+x.wi)) hs hh
  have hi := round_even s half (x.wr*(x.vr+x.vi)+x.vr*(x.wi-x.wr)) hs hh
  simp only [checkOne, Bool.and_eq_true, decide_eq_true_eq]
  refine ⟨⟨⟨⟨⟨hin, hout⟩, ht⟩, hu⟩, hv⟩, ?_⟩
  have cancel (a b : Int) : a+b-a=b := by omega
  simp only [computeOne, cancel]
  omega

def checkFastStage (s half b : Int) : List Input → List Output → Bool
  | [], [] => true
  | x::xs, y::ys => checkFast s half b x y && checkFastStage s half b xs ys
  | _, _ => false

theorem checkFastStage_sound (s half b : Int) (hs : 0 < s) (hh : s=2*half)
    (xs : List Input) (ys : List Output) (h : checkFastStage s half b xs ys = true) :
    stage_spec s b xs ys := by
  induction xs generalizing ys with
  | nil => cases ys with
    | nil => exact True.intro
    | cons y ys => simp only [checkFastStage, Bool.false_eq_true] at h
  | cons x xs ih => cases ys with
    | nil => simp only [checkFastStage, Bool.false_eq_true] at h
    | cons y ys =>
      simp only [checkFastStage, Bool.and_eq_true] at h
      exact ⟨checkOne_sound s b x y (checkFast_implies_checkOne s half b hs hh x y h.1),
        ih ys h.2⟩

theorem checkStage_append (s b : Int) (xs xt : List Input) (ys yt : List Output)
    (h : checkStage s b xs ys = true) (ht : checkStage s b xt yt = true) :
    checkStage s b (xs++xt) (ys++yt) = true := by
  induction xs generalizing ys with
  | nil => cases ys with
    | nil => exact ht
    | cons y ys => simp only [checkStage, Bool.false_eq_true] at h
  | cons x xs ih => cases ys with
    | nil => simp only [checkStage, Bool.false_eq_true] at h
    | cons y ys =>
      simp only [checkStage, Bool.and_eq_true] at h
      exact checkStage_cons s b x y _ _ h.1 (ih ys h.2)

end BatchedTransform
