import StageCheck

/-! The exact integer network from the HOL4 dependent-block experiment.
This is not an FFT: coefficients have no certified root interpretation.
The output checksum is a statistic, not a commitment to an output vector. -/

namespace DependentBlock

abbrev ComplexInt := Int × Int

def roundScaled (s r : Int) : Int := (2*r+s)/(2*s)

theorem roundScaled_residual (s r : Int) (hs : 0 < s) :
    -s ≤ 2*(r-roundScaled s r*s) ∧ 2*(r-roundScaled s r*s) < s := by
  have hd : 0 < 2*s := by omega
  have h0 := Int.emod_nonneg (2*r+s) (Int.ne_of_gt hd)
  have h1 := Int.emod_lt_of_pos (2*r+s) hd
  have he := Int.ediv_mul_add_emod (2*r+s) (2*s)
  rw [Int.mul_left_comm] at he
  unfold roundScaled
  omega

def roundedButterfly (s : Int) (u v w : ComplexInt) : ComplexInt × ComplexInt :=
  let t := w.1*(v.1+v.2)
  let a := v.2*(w.1+w.2)
  let b := v.1*(w.2-w.1)
  let qr := roundScaled s (t-a)
  let qi := roundScaled s (t+b)
  ((u.1+qr,u.2+qi),(u.1-qr,u.2-qi))

def symmetricBound (b x : Int) : Prop := -b ≤ x ∧ x ≤ b

def localResidual (s : Int) (u v w : ComplexInt) (y : ComplexInt × ComplexInt) : Prop :=
  symmetricBound s (2*(u.1*s+(v.1*w.1-v.2*w.2)-y.1.1*s)) ∧
  symmetricBound s (2*(u.2*s+(v.1*w.2+v.2*w.1)-y.1.2*s)) ∧
  symmetricBound s (2*(u.1*s-(v.1*w.1-v.2*w.2)-y.2.1*s)) ∧
  symmetricBound s (2*(u.2*s-(v.1*w.2+v.2*w.1)-y.2.2*s))

theorem roundedButterfly_residual (s : Int) (u v w : ComplexInt) (hs : 0 < s) :
    localResidual s u v w (roundedButterfly s u v w) := by
  have hr := roundScaled_residual s (v.1*w.1-v.2*w.2) hs
  have hi := roundScaled_residual s (v.1*w.2+v.2*w.1) hs
  simp only [localResidual,roundedButterfly,symmetricBound,
    BatchedTransform.three_real,BatchedTransform.three_imag,Int.add_mul,Int.sub_mul]
  omega

def layer (s : Int) : List ComplexInt → List ComplexInt → List ComplexInt
  | [], xs => xs
  | _::_, [] => []
  | _::_, [u] => [u]
  | w::ws, u::v::xs =>
    let (p,m) := roundedButterfly s u v w
    p::m::layer s ws xs

def rotate : List ComplexInt → List ComplexInt
  | [] => []
  | x::xs => xs ++ [x]

def run (s : Int) (ws : List ComplexInt) : Nat → List ComplexInt → List ComplexInt
  | 0, xs => xs
  | n+1, xs => run s ws n (rotate (layer s ws xs))

def layerContract (s : Int) : List ComplexInt → List ComplexInt → List ComplexInt → Prop
  | [], xs, ys => xs = ys
  | _::_, [], _ => False
  | _::_, [_], _ => False
  | w::ws, u::v::xs, ys =>
    ∃ p m zs, ys = p::m::zs ∧ localResidual s u v w (p,m) ∧ layerContract s ws xs zs

def blockContract (s : Int) (ws : List ComplexInt) :
    Nat → List ComplexInt → List ComplexInt → Prop
  | 0, xs, ys => xs = ys
  | n+1, xs, ys =>
    ∃ zs, layerContract s ws xs zs ∧ blockContract s ws n (rotate zs) ys

theorem layer_length (s : Int) (ws xs : List ComplexInt) :
    (layer s ws xs).length = xs.length := by
  induction ws generalizing xs with
  | nil => rfl
  | cons w ws ih =>
    cases xs with
    | nil => rfl
    | cons u xs => cases xs with
      | nil => rfl
      | cons v xs =>
        cases h : roundedButterfly s u v w with
        | mk p m => simp only [layer,h,List.length_cons,ih]

theorem rotate_length (xs : List ComplexInt) : (rotate xs).length = xs.length := by
  cases xs with
  | nil => rfl
  | cons x xs => simp only [rotate,List.length_append,List.length_cons,List.length_nil]

theorem run_length (s : Int) (ws : List ComplexInt) (n : Nat) (xs : List ComplexInt) :
    (run s ws n xs).length = xs.length := by
  induction n generalizing xs with
  | zero => rfl
  | succ n ih => simp only [run,ih,rotate_length,layer_length]

theorem layer_sound (s : Int) (hs : 0 < s) (ws xs : List ComplexInt)
    (hl : xs.length = 2*ws.length) : layerContract s ws xs (layer s ws xs) := by
  induction ws generalizing xs with
  | nil => rfl
  | cons w ws ih =>
    cases xs with
    | nil => simp only [List.length_nil,List.length_cons] at hl; omega
    | cons u xs => cases xs with
      | nil => simp only [List.length_nil,List.length_cons] at hl; omega
      | cons v xs =>
        have ht : xs.length = 2*ws.length := by
          simp only [List.length_cons] at hl
          omega
        cases h : roundedButterfly s u v w with
        | mk p m =>
          simp only [layer,h,layerContract]
          exact ⟨p,m,layer s ws xs,rfl,
            by simpa only [h] using roundedButterfly_residual s u v w hs,ih xs ht⟩

theorem run_sound (s : Int) (hs : 0 < s) (ws : List ComplexInt)
    (n : Nat) (xs : List ComplexInt) (hl : xs.length = 2*ws.length) :
    blockContract s ws n xs (run s ws n xs) := by
  induction n generalizing xs with
  | zero => rfl
  | succ n ih =>
    refine ⟨layer s ws xs,layer_sound s hs ws xs hl,?_⟩
    apply ih
    simpa only [rotate_length,layer_length] using hl

def checkBound (b : Int) : List ComplexInt → Bool
  | [] => true
  | (r,i)::xs => BatchedTransform.within b r && BatchedTransform.within b i && checkBound b xs

def boundSpec (b : Int) : List ComplexInt → Prop
  | [] => True
  | (r,i)::xs => symmetricBound b r ∧ symmetricBound b i ∧ boundSpec b xs

theorem checkBound_sound (b : Int) (xs : List ComplexInt) (h : checkBound b xs = true) :
    boundSpec b xs := by
  induction xs with
  | nil => trivial
  | cons x xs ih =>
    rcases x with ⟨r,i⟩
    simp only [checkBound,Bool.and_eq_true,BatchedTransform.within,decide_eq_true_eq] at h
    exact ⟨h.1.1,h.1.2,ih h.2⟩

def checksum : List ComplexInt → Int
  | [] => 0
  | (r,i)::xs => r + 3*i + 9*checksum xs

def accept (s : Int) (ws : List ComplexInt) (n : Nat) (xs : List ComplexInt)
    (b expected : Int) : Bool :=
  decide (0<s ∧ xs.length=2*ws.length) &&
  let ys := run s ws n xs
  checkBound b ys && decide (checksum ys = expected)

theorem accept_sound (s : Int) (ws : List ComplexInt) (n : Nat) (xs : List ComplexInt)
    (b expected : Int) (h : accept s ws n xs b expected = true) :
    ∃ ys, ys.length = xs.length ∧ blockContract s ws n xs ys ∧
      boundSpec b ys ∧ checksum ys = expected := by
  simp only [accept,Bool.and_eq_true,decide_eq_true_eq] at h
  exact ⟨run s ws n xs,run_length s ws n xs,run_sound s h.1.1 ws n xs h.1.2,
    checkBound_sound b _ h.2.1,h.2.2⟩

end DependentBlock
