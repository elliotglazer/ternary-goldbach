module

public import ScalarProgram

@[expose] public section


open Real
namespace GoldbachEnergy

inductive OpCode where
  | lit (r : ℚ) | input (i : ℕ) | pi | add | neg | mul | inv | min | max | sqrt | atan | exp | log
  deriving DecidableEq

def ScalarOp.code : ScalarOp → OpCode
  | .lit r => .lit r | .input i => .input i | .pi => .pi
  | .add => .add | .neg => .neg | .mul => .mul | .inv => .inv | .min => .min | .max => .max
  | .sqrt => .sqrt | .atan => .atan | .exp .. => .exp | .log .. => .log

noncomputable def OpCode.value (op : OpCode) (input : ℕ → ℝ) (x y : ℝ) : ℝ :=
  match op with
  | .lit r => r | .input i => input i | .pi => π
  | .add => x+y | .neg => -x | .mul => x*y | .inv => x⁻¹ | .min => Min.min x y | .max => Max.max x y
  | .sqrt => Real.sqrt x | .atan => Real.arctan x | .exp => Real.exp x | .log => Real.log x

theorem code_value (op : ScalarOp) (input : ℕ → ℝ) (x y : ℝ) :
    op.code.value input x y = op.value input x y := by cases op <;> rfl

structure TemplateStep where
  code : OpCode
  left : Nat
  right : Nat
  deriving DecidableEq

def Instruction.shape (s : Instruction) : TemplateStep := ⟨s.op.code,s.left,s.right⟩

noncomputable def templateValues (input : ℕ → ℝ) : List TemplateStep → Array ℝ → Array ℝ
  | [], v => v
  | i::is,v => templateValues input is (v.push (i.code.value input (v.getD i.left 0) (v.getD i.right 0)))

theorem same_scalar_formula (is : List Instruction) (input : ℕ → ℝ) (v : Array ℝ) :
    templateValues input (is.map Instruction.shape) v = values input is v := by
  induction is generalizing v with
  | nil => rfl
  | cons i is ih =>
      simp only [List.map_cons,templateValues,Instruction.shape,values,code_value,ih]

/-- Every witness file with the same list of operations checks the same real
formula. The table inputs may vary independently from one rectangle to the next. -/
theorem template_from_witness (is : List Instruction) (ts : List TemplateStep) (hs : is.map Instruction.shape=ts)
    {inputs : ℕ → RatBounds} {input : ℕ → ℝ} (hi : ∀ j, (inputs j).Contains (input j))
    (hc : checkProgram inputs is #[]=true) (j : ℕ) :
    ((programBounds is #[]).getD j zeroBounds).Contains ((templateValues input ts #[]).getD j 0) := by
  rw [← hs,same_scalar_formula]
  exact program_from_empty is hi hc j

#print axioms template_from_witness
end GoldbachEnergy
