module

public import FormulaMesh

@[expose] public section


open Real Finset TernaryGoldbach.Explicit
namespace GoldbachEnergy.MathExpr

def sumExpr (f : ℕ → MathExpr) : ℕ → MathExpr
  | 0 => C 0
  | n+1 => plus (sumExpr f n) (f n)

theorem real_sum (v : ℕ → ℝ) (f : ℕ → MathExpr) (n : ℕ) :
    (sumExpr f n).real v = ∑ j ∈ range n, (f j).real v := by
  induction n with
  | zero => simp [sumExpr,C,real]
  | succ n ih => simp [sumExpr,plus,real,OpCode.value,ih,sum_range_succ]

theorem real_diskInv (v : ℕ → ℝ) (w : MathExpr) : (diskInvExpr w).real v = invDisk (w.real v) := by
  simp [diskInvExpr,log',sqrt',divide,times,plus,C,real_power,real,OpCode.value,invDisk,div_eq_mul_inv]
  <;> norm_num

def clippedExpr (m i : ℕ) (st θ d : MathExpr) := if i < m then cellExpr st θ d i else C 0

theorem clippedExpr_real (v : ℕ → ℝ) (m i : ℕ) (st θ d : MathExpr) :
    (clippedExpr m i st θ d).real v = meshAt m i (st.real v) (θ.real v) (d.real v) := by
  unfold clippedExpr; split
  · exact cellExpr_real _ _ _ _ (by assumption)
  · rename_i h; simp [meshAt,h,C,real]

def coeffExpr (m : ℕ) (st θ₀ θ₁ d₀ d₁ : MathExpr) :=
  sumExpr (fun j => times
    (maximum (minus (clippedExpr m j st θ₁ d₁) (clippedExpr m (j+1) st θ₀ d₀)) (C 0))
    (diskInvExpr (times (C ((j+1:ℕ):ℚ)) st))) m

theorem coeff_real (v : ℕ → ℝ) (m : ℕ) (st θ₀ θ₁ d₀ d₁ : MathExpr) :
    (coeffExpr m st θ₀ θ₁ d₀ d₁).real v =
      meshCoeff m (st.real v) (θ₀.real v) (θ₁.real v) (d₀.real v) (d₁.real v) := by
  simp only [coeffExpr,real_sum,meshCoeff]
  apply sum_congr rfl
  intro j _
  simp [times,maximum,minus,plus,C,real,OpCode.value,real_diskInv,clippedExpr_real,sub_eq_add_neg]

def jExpr (Q Y : MathExpr) :=
  log' (divide (times (times (times (times (C 1400) (power Q 9)) (plus Q (C 1))) (plus Y (C 22)))
    (power (times (C (5/4)) (plus Y (C 11))) 10)) (C (355/1000)))

theorem jExpr_real (v : ℕ → ℝ) (q y : MathExpr) (Q : ℕ) (hq : q.real v = Q) (hy : 0 ≤ y.real v) :
    (jExpr q y).real v = logBP Q (y.real v) := by
  rw [logBP_arithmetic Q _ hy]
  simp [jExpr,log',divide,times,plus,C,real_power,real,OpCode.value,hq,div_eq_mul_inv]
  <;> norm_num

def rayExpr (q d A W Y : MathExpr) :=
  let r := exp' (unary .neg (times d W))
  let u := unary .inv (minus (C 1) r)
  let k := times (times (sqrt' (times (C 2) pi)) (exp' (unary .neg (times d A)))) (diskInvExpr (divide W (C 2)))
  times (times k u) (plus (jExpr q Y) (times (times (divide (times (C 11) W) Y) r) u))

theorem rayExpr_real (v : ℕ → ℝ) (q d A W Y : MathExpr) (Q : ℕ) (hq : q.real v=Q) (hy : 0≤Y.real v) :
    (rayExpr q d A W Y).real v = rayCore (logBP Q (Y.real v)) (d.real v) (A.real v) (W.real v) (Y.real v) := by
  simp [rayExpr,rayCore,real_diskInv,jExpr_real v q Y Q hq hy,exp',sqrt',divide,minus,plus,times,C,real,OpCode.value,
    sub_eq_add_neg,div_eq_mul_inv]

#print axioms coeff_real
#print axioms rayExpr_real
end GoldbachEnergy.MathExpr
