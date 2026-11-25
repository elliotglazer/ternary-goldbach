module

public import ScaledSound
public import CalcLanguage

@[expose] public section


open GoldbachEnergy
namespace ScaledGrid

def Op.code (lit : Int) : Op → OpCode
  | .lit => .lit (rational lit) | .pi => .pi | .add => .add | .neg => .neg | .mul => .mul
  | .min => .min | .max => .max | .inv => .inv | .sqrt => .sqrt
  | .exp .. => .exp | .log .. => .log | .atan .. => .atan

def ExpEntry (e : Entry) := e.b.Holds (Real.exp (val e.x))
def AtanEntry (e : Entry) := e.b.Holds (Real.arctan (val e.x))

def Op.Lookups (e t : Nat → Entry) : Op → Prop
  | .exp l h | .log l h => ExpEntry (e l) ∧ ExpEntry (e h)
  | .atan l h => AtanEntry (t l) ∧ AtanEntry (t h)
  | _ => True

theorem unary_sound {f : ℝ → ℝ} (hf : Monotone f) (t : Nat → Entry) (l h : Nat) (s a : Bounds)
    {x : ℝ} (hx : a.Holds x)
    (lo : (t l).b.Holds (f (val (t l).x))) (hi : (t h).b.Holds (f (val (t h).x)))
    (p : unaryTable t l h s a=true) : s.Holds (f x) := by
  obtain ⟨pl,ph,cl,ch⟩ := of_decide_eq_true p
  rw [pl] at lo
  rw [ph] at hi
  exact ⟨(val_mono cl).trans (lo.1.trans (hf hx.1)),(hf hx.2).trans (hi.2.trans (val_mono ch))⟩

theorem eval_one (op : Op) {e t : Nat → Entry} {s a b : Bounds} {x y : ℝ}
    (hs : op.Lookups e t) (hx : a.Holds x) (hy : b.Holds y) (p : op.test e t s a b=true) :
    s.Holds ((op.code s.lo).value (fun _ => 0) x y) := by
  cases op with
  | lit =>
    have eqn : s.lo=s.hi := of_decide_eq_true p
    simp [Op.code,OpCode.value,Bounds.Holds,rational_cast,eqn]
  | pi =>
    change s.Holds Real.pi
    apply interval_of_inside _ _ _ p
    · convert pi_endpoint_bounds.1 using 1 <;> norm_num [val,piLo,scale,piLower]
    · convert pi_endpoint_bounds.2 using 1 <;> norm_num [val,piHi,scale,piUpper]
  | add =>
    apply interval_of_inside _ _ _ p
    · simpa [Op.code,OpCode.value] using add_le_add hx.1 hy.1
    · simpa [Op.code,OpCode.value] using add_le_add hx.2 hy.2
  | neg =>
    apply interval_of_inside _ _ _ p
    · simpa [Op.code,OpCode.value] using neg_le_neg hx.2
    · simpa [Op.code,OpCode.value] using neg_le_neg hx.1
  | min =>
    apply interval_of_inside _ _ _ p
    · simpa [Op.code,OpCode.value] using min_le_min hx.1 hy.1
    · simpa [Op.code,OpCode.value] using min_le_min hx.2 hy.2
  | max =>
    apply interval_of_inside _ _ _ p
    · simpa [Op.code,OpCode.value] using max_le_max hx.1 hy.1
    · simpa [Op.code,OpCode.value] using max_le_max hx.2 hy.2
  | mul => exact interval_mul hx hy p
  | inv => exact interval_inv hx p
  | sqrt => exact interval_sqrt hx p
  | exp l h => exact unary_sound Real.exp_monotone e l h s a hx hs.1 hs.2 p
  | atan l h => exact unary_sound (fun _ _ h => Real.arctan_le_arctan_iff.mpr h) t l h s a hx hs.1 hs.2 p
  | log l h =>
    obtain ⟨coordsL,coordsH,low,high⟩ := of_decide_eq_true p
    have left := hs.1.2
    have right := hs.2.1
    rw [coordsL] at left
    rw [coordsH] at right
    exact log_by_exp (left.trans ((val_mono low).trans hx.1)) (hx.2.trans ((val_mono high).trans right))

noncomputable def nodeValue (pool : Nat → Node) (i : Nat) : ℝ :=
  let n := pool i
  (n.op.code n.b.lo).value (fun _ => 0) (if _h : n.left < i then nodeValue pool n.left else 0)
    (if _h : n.right < i then nodeValue pool n.right else 0)
termination_by i

theorem table_holds (pool : Nat → Node) (e t : Nat → Entry) {size : Nat}
    (valid : ∀ i, i < size → (pool i).op.Lookups e t)
    (checked : Checked (testAt pool e t) 0 size) (i : Nat) (hi : i < size) :
    (pool i).b.Holds (nodeValue pool i) := by
  induction i using Nat.strong_induction_on with
  | h i ih =>
    have prior_holds (j : Nat) : (prior pool i j).Holds (if j < i then nodeValue pool j else 0) := by
      by_cases hj : j < i
      · simpa [prior,hj] using ih j hj (hj.trans hi)
      · simp [prior,hj,Bounds.Holds]
    rw [nodeValue]
    exact eval_one _ (valid i hi) (prior_holds _) (prior_holds _) (checked i (Nat.zero_le _) hi)

#print axioms table_holds
end ScaledGrid
