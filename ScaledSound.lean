module

public import ScaledData
public import RealBoxEval

@[expose] public section


open Real GoldbachEnergy
namespace ScaledGrid

def rational (x : Int) : ℚ := (x:ℚ)/(scale:ℚ)
noncomputable def val (x : Int) : ℝ := (x:ℝ)/(scale:ℝ)
def Bounds.Holds (b : Bounds) (x : ℝ) := val b.lo ≤ x ∧ x ≤ val b.hi

private theorem spos : (0:ℝ) < (scale:ℝ) := by norm_num [scale]
@[simp] theorem rational_cast (x : Int) : (rational x : ℝ)=val x := by simp [rational,val]
@[simp] theorem val_zero : val 0=0 := by simp [val]
@[simp] theorem val_scale : val scale=1 := div_self spos.ne'
@[simp] theorem val_neg (a : Int) : val (-a)= -(val a) := by simp [val,neg_div]
@[simp] theorem val_add (a b : Int) : val (a+b)=val a+val b := by simp [val,add_div]
theorem val_mono {a b : Int} (h : a ≤ b) : val a ≤ val b :=
  div_le_div_of_nonneg_right (by exact_mod_cast h) spos.le
theorem val_strict {a b : Int} (h : a < b) : val a < val b :=
  div_lt_div_of_pos_right (by exact_mod_cast h) spos
@[simp] theorem val_min (a b : Int) : val (min a b)=min (val a) (val b) :=
  (show Monotone val from fun _ _ h => val_mono h).map_min
@[simp] theorem val_max (a b : Int) : val (max a b)=max (val a) (val b) :=
  (show Monotone val from fun _ _ h => val_mono h).map_max

private theorem product_le {a b c d : Int} (h : a*b ≤ c*d) :
    val a*val b ≤ val c*val d := by
  unfold val
  rw [div_mul_div_comm,div_mul_div_comm]
  exact div_le_div_of_nonneg_right (by exact_mod_cast h) (mul_nonneg spos.le spos.le)

theorem interval_of_inside (s : Bounds) (l h : Int) (p : inside s l h=true)
    {x : ℝ} (low : val l ≤ x) (high : x ≤ val h) : s.Holds x := by
  obtain ⟨a,b⟩ := of_decide_eq_true p
  exact ⟨(val_mono a).trans low,high.trans (val_mono b)⟩

private theorem corner (s : Bounds) {a b : Int} (h : oneProduct s a b=true) :
    s.Holds (val a*val b) := by
  obtain ⟨l,u⟩ := of_decide_eq_true h
  exact ⟨by simpa using product_le l,by simpa using product_le u⟩

private theorem interpolate {a b t z l u : ℝ}
    (ht : a ≤ t ∧ t ≤ b) (ha : l ≤ a*z ∧ a*z ≤ u) (hb : l ≤ b*z ∧ b*z ≤ u) :
    l ≤ t*z ∧ t*z ≤ u := by
  rcases le_total 0 z with h|h
  · exact ⟨ha.1.trans (mul_le_mul_of_nonneg_right ht.1 h),(mul_le_mul_of_nonneg_right ht.2 h).trans hb.2⟩
  · exact ⟨hb.1.trans (mul_le_mul_of_nonpos_right ht.2 h),(mul_le_mul_of_nonpos_right ht.1 h).trans ha.2⟩

theorem interval_mul {s a b : Bounds} {x y : ℝ} (hx : a.Holds x) (hy : b.Holds y)
    (p : Op.mul.test e t s a b=true) : s.Holds (x*y) := by
  obtain ⟨⟨⟨ll,lh⟩,hl⟩,hh⟩ := (by simpa only [Op.test,Bool.and_eq_true_iff] using p :
    ((oneProduct s a.lo b.lo=true ∧ oneProduct s a.lo b.hi=true) ∧ oneProduct s a.hi b.lo=true) ∧ oneProduct s a.hi b.hi=true)
  have lb := interpolate hx (corner s ll) (corner s hl)
  have ub := interpolate hx (corner s lh) (corner s hh)
  rw [mul_comm] at lb ub ⊢
  exact interpolate hy lb ub

theorem interval_inv {s a b : Bounds} {x : ℝ} (hx : a.Holds x)
    (p : Op.inv.test e t s a b=true) : s.Holds x⁻¹ := by
  obtain ⟨pos,l,h⟩ := of_decide_eq_true p
  have ap : 0 < val a.lo := by simpa using val_strict pos
  have xp := ap.trans_le hx.1
  have bp := xp.trans_le hx.2
  have lower : val s.lo * val a.hi ≤ 1 := by simpa using product_le l
  have upper : 1 ≤ val s.hi * val a.lo := by simpa using product_le h
  have le : val s.lo ≤ 1/val a.hi := (le_div_iff₀ bp).2 lower
  have ge : 1/val a.lo ≤ val s.hi := (div_le_iff₀ ap).2 upper
  simp only [one_div] at le ge
  exact ⟨le.trans (inv_anti₀ xp hx.2),(inv_anti₀ ap hx.1).trans ge⟩

theorem interval_sqrt {s a b : Bounds} {x : ℝ} (hx : a.Holds x)
    (p : Op.sqrt.test e t s a b=true) : s.Holds (Real.sqrt x) := by
  obtain ⟨hp,hl,hh⟩ := of_decide_eq_true p
  have h0 : 0 ≤ val s.hi := by simpa using val_mono hp
  have h1 : val s.lo*val s.lo ≤ val a.lo := by simpa using product_le hl
  have h2 : val a.hi ≤ val s.hi*val s.hi := by simpa using product_le hh
  exact sqrt_by_squares h0 ⟨h1.trans hx.1,hx.2.trans h2⟩

#print axioms interval_mul
#print axioms interval_inv
#print axioms interval_sqrt
end ScaledGrid
