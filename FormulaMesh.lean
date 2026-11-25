module

public import CalcLanguage
public import RectProfile
public import MeshCosh
public import CellFormula

@[expose] public section


open Real Finset
namespace GoldbachEnergy
namespace MathExpr

def C (q : ℚ) := rational q
def plus := binary OpCode.add
def times := binary OpCode.mul
def minus (a b : MathExpr) := plus a (unary .neg b)
def divide (a b : MathExpr) := times a (unary .inv b)
def minimum := binary OpCode.min
def maximum := binary OpCode.max
def abs' (a : MathExpr) := maximum a (unary .neg a)

def power (a : MathExpr) (n : ℕ) : MathExpr :=
  if h : n < 2 then if n=0 then C 1 else a
  else
    let half := power a (n/2)
    let sq := times half half
    if n%2=0 then sq else times sq a
termination_by n
decreasing_by omega

theorem real_power (v : ℕ → ℝ) (a : MathExpr) (n : ℕ) : (power a n).real v=(a.real v)^n := by
  induction n using Nat.strong_induction_on with
  | h n ih =>
    rw [power]; split
    · rename_i h
      have : n=0 ∨ n=1 := by omega
      rcases this with rfl|rfl <;> simp [C,real]
    · rename_i h
      have hr := ih (n/2) (by omega)
      split
      · rename_i he
        have hn : n=n/2+n/2 := by omega
        simp only [times,real,OpCode.value,hr]; conv_rhs => rw [hn,pow_add]
      · rename_i he
        have hn : n=n/2+n/2+1 := by omega
        simp only [times,real,OpCode.value,hr]; conv_rhs => rw [hn,pow_succ,pow_add]

def sqrt' := unary OpCode.sqrt
def exp' := unary OpCode.exp
def log' := unary OpCode.log
def atan' := unary OpCode.atan

def diskInvExpr (w : MathExpr) :=
  unary .inv (log' (divide (C 10) (sqrt' (plus (C (9/4)) (power w 2)))))

def cellExpr (st θ gap : MathExpr) (i : ℕ) :=
  let down := exp' (unary .neg (times gap st))
  let up := exp' (times θ st)
  let mesh := exp' (times pi st)
  let ch := divide (plus (power mesh i) (power (unary .inv mesh) i)) (C 2)
  minimum (times (sqrt' (times (C 2) pi)) (power down i))
    (times (sqrt' (divide pi ch)) (power up (i+1)))

theorem cellExpr_real (v : ℕ → ℝ) (st θ gap : MathExpr) {i m : ℕ} (hi : i < m) :
    (cellExpr st θ gap i).real v = meshAt m i (st.real v) (θ.real v) (gap.real v) := by
  simp only [cellExpr,real_power,real,C,minimum,times,divide,plus,sqrt',exp',OpCode.value,
    meshAt,if_pos hi,mesh_cosh_series]
  simp only [div_eq_mul_inv,Rat.cast_ofNat]

#print axioms real_power
#print axioms cellExpr_real
end MathExpr
end GoldbachEnergy
