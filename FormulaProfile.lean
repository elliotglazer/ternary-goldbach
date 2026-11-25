module

public import FormulaGamma

@[expose] public section


open Real GoldbachEnergy
namespace GoldbachEnergy.MathExpr

def sizeExpr (t : MathExpr) :=
  sqrt' (plus (C 1) (power (times (times (C 2) pi) t) 2))

def angleExpr (t : MathExpr) := atan' (times (times (C 2) pi) t)

def slowExpr (iszero : Bool) (t : MathExpr) :=
  if iszero then divide pi (C 2) else atan' (divide (C 1) (times (times (C 2) pi) t))

def anchorExpr (a w d : MathExpr) := maximum (plus a (divide w (C 2))) (divide (C 1) d)

theorem size_real (v : ℕ → ℝ) (t : MathExpr) : (sizeExpr t).real v = twistSize (t.real v) := by
  simp [sizeExpr,sqrt',plus,times,C,real,OpCode.value,twistSize,real_power]

theorem angle_real (v : ℕ → ℝ) (t : MathExpr) : (angleExpr t).real v = twistAngle (t.real v) := by
  simp [angleExpr,atan',times,C,real,OpCode.value,twistAngle]

theorem slow_real (v : ℕ → ℝ) (t : MathExpr) (iz : Bool) (hz : (iz=true) ↔ t.real v=0) :
    (slowExpr iz t).real v = slowAngle (t.real v) := by
  unfold slowExpr slowAngle
  by_cases ht : t.real v=0
  · simp [ht,hz.mpr ht,divide,times,C,real,OpCode.value,div_eq_mul_inv]
  · have h : iz=false := Bool.eq_false_iff.mpr (fun h => ht (hz.mp h))
    simp [ht,h,atan',divide,times,C,real,OpCode.value,div_eq_mul_inv]

theorem anchor_real (v : ℕ → ℝ) (a w d : MathExpr) :
    (anchorExpr a w d).real v = anchorY (a.real v) (w.real v) (d.real v) := by
  simp [anchorExpr,maximum,plus,divide,times,C,real,OpCode.value,anchorY,div_eq_mul_inv]

def profileExpr (m : ℕ) (q st w l r : MathExpr) (lzero rzero : Bool) :=
  let a := times (C (m:ℚ)) st
  let al := angleExpr l
  let ah := angleExpr r
  let gl := slowExpr lzero l
  let gs := slowExpr rzero r
  let gf := plus (divide pi (C 2)) al
  let ys := anchorExpr a w gs
  let yf := anchorExpr a w gf
  let center := times (coeffExpr m st al ah gl gs) (jExpr q (C 0))
  divide (plus (plus center (rayExpr q gs a w ys)) (rayExpr q gf a w yf)) (sqrt' (sizeExpr l))

theorem profileExpr_real (v : ℕ → ℝ) (m Q : ℕ) (q st w l r : MathExpr) (lzero rzero : Bool)
    (hq : q.real v=Q) (hl : 0 ≤ l.real v) (hr : 0 ≤ r.real v) (hstep : 0 ≤ st.real v) (hw : 0 ≤ w.real v)
    (hzl : lzero=true ↔ l.real v=0) (hzr : rzero=true ↔ r.real v=0) :
    (profileExpr m q st w l r lzero rzero).real v = boxProfile Q m (st.real v) (w.real v) (l.real v) (r.real v) := by
  let a := times (C (m:ℚ)) st
  have ha : a.real v = (m:ℝ)*st.real v := by simp [a,times,C,real,OpCode.value]
  have y0 (d : MathExpr) : 0 ≤ (anchorExpr a w d).real v := by
    rw [anchor_real,ha]
    exact (by positivity : 0 ≤ (m:ℝ)*st.real v+w.real v/2).trans (le_max_left _ _)
  have addEval (x y : MathExpr) : (plus x y).real v = x.real v+y.real v := rfl
  have mulEval (x y : MathExpr) : (times x y).real v = x.real v*y.real v := rfl
  have divEval (x y : MathExpr) : (divide x y).real v = x.real v/y.real v := by
    simp [divide,times,real,OpCode.value,div_eq_mul_inv]
  have sqrtEval (x : MathExpr) : (sqrt' x).real v = Real.sqrt (x.real v) := rfl
  have ray (d : MathExpr) :
      (rayExpr q d a w (anchorExpr a w d)).real v =
        rayCore (logBP Q (anchorY ((m:ℝ)*st.real v) (w.real v) (d.real v)))
          (d.real v) ((m:ℝ)*st.real v) (w.real v) (anchorY ((m:ℝ)*st.real v) (w.real v) (d.real v)) := by
    rw [rayExpr_real v q d a w _ Q hq (y0 d),anchor_real,ha]
  have hj : (jExpr q (C 0)).real v = logBP Q 0 := by
    simpa [C,real] using jExpr_real v q (C 0) Q hq (by simp [C,real])
  dsimp only [a] at ray
  unfold profileExpr boxProfile boxTopAt boxGammaTop
  rw [core_normalized]
  simp only [divEval,addEval,mulEval,sqrtEval,size_real,ray,coeff_real,hj,slow_real v l lzero hzl,
    slow_real v r rzero hzr,angle_real,slow_eq hl,slow_eq hr]
  <;> norm_num [C,real]

#print axioms profileExpr_real
end GoldbachEnergy.MathExpr
