module

public import FormulaProfile

@[expose] public section


open Real
namespace GoldbachEnergy
open MathExpr

noncomputable def profilePrice (a b c q₀ : ℝ) (Q m : ℕ) (h W l r : ℝ) :=
  let initial := min (c*a^3) (Real.sqrt Q*a)/Real.exp (a/2)
  let factor := if l=0 then initial else min initial (1/(c*a*Real.sqrt l))
  min 0.096 (b*Real.sqrt (2/q₀)/twistSize l)+0.003+factor*boxProfile Q m h W l r

def profilePriceExpr (m : Nat) (lz : Bool) : MathExpr :=
  let a := MathExpr.varRef 0
  let b := MathExpr.varRef 1
  let c := MathExpr.varRef 2
  let q₀ := MathExpr.varRef 3
  let q := MathExpr.varRef 4
  let l := MathExpr.varRef 7
  let k := divide (minimum (times c (times (times a a) a)) (times (sqrt' q) a)) (exp' (divide a (C 2)))
  let f := if lz then k else minimum k (divide (C 1) (times (times c a) (sqrt' l)))
  let p := minimum (C (96/1000)) (divide (times b (sqrt' (divide (C 2) q₀))) (sizeExpr l))
  plus (plus p (C (3/1000))) (times f (profileExpr m q (.varRef 5) (.varRef 6) l (.varRef 8) lz false))

theorem profilePriceExpr_real (v : ℕ → ℝ) (m Q : ℕ) (lz : Bool) (hq : v 4=Q)
    (hl : 0≤v 7) (hr : 0<v 8) (hh : 0≤ v 5) (hw : 0≤v 6) (hz : lz=true ↔ v 7=0) :
    (profilePriceExpr m lz).real v = profilePrice (v 0) (v 1) (v 2) (v 3) Q m (v 5) (v 6) (v 7) (v 8) := by
  have hp := profileExpr_real v m Q (.varRef 4) (.varRef 5) (.varRef 6) (.varRef 7) (.varRef 8)
    lz false hq hl hr.le hh hw hz (by simp [MathExpr.real,hr.ne'])
  have c96 : (96:ℝ)*1000⁻¹=0.096 := by norm_num
  have c3 : (3:ℝ)*1000⁻¹=0.003 := by norm_num
  cases lz
  · have hn : v 7 ≠ 0 := by simpa using hz.symm
    simp only [profilePriceExpr, profilePrice, Bool.false_eq_true, if_false, if_neg hn, plus, minimum,
      divide, times, sqrt', exp', size_real, hp, C, MathExpr.real, OpCode.value, hq, div_eq_mul_inv]
    <;> norm_num [pow_succ, div_eq_mul_inv, c96, c3]
  · have he : v 7 = 0 := hz.mp rfl
    simp only [profilePriceExpr, profilePrice, if_true, if_pos he, plus, minimum,
      divide, times, sqrt', exp', size_real, hp, C, MathExpr.real, OpCode.value, hq, div_eq_mul_inv]
    <;> norm_num [pow_succ, div_eq_mul_inv, c96, c3]
#print axioms profilePriceExpr_real
end GoldbachEnergy
