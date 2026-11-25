module

public import ZeroWindow
public import TernaryGoldbach.Explicit.ZeroSumBound

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

private theorem fiber_geometric {ι : Type*} (S : Finset ι) (idx : ι → ℕ) (f : ι → ℝ)
    {a b r : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b) (hr : 0 ≤ r) (hr1 : r < 1)
    (h : ∀ k, ∑ x ∈ S.filter (fun x => idx x=k), f x ≤ (a+b*k)*r^k) :
    ∑ x ∈ S, f x ≤ a/(1-r)+b*r/(1-r)^2 := by
  classical
  have hn : ‖r‖ < 1 := by simpa [Real.norm_eq_abs,abs_of_nonneg hr] using hr1
  have hs := ((hasSum_geometric_of_lt_one hr hr1).mul_left a).add
    ((hasSum_coe_mul_geometric_of_norm_lt_one hn).mul_left b)
  have hsum : HasSum (fun k : ℕ => (a+b*k)*r^k) (a/(1-r)+b*r/(1-r)^2) := by
    simpa only [add_mul,mul_assoc,div_eq_mul_inv] using hs
  rw [← Finset.sum_fiberwise_of_maps_to (fun i hi => mem_image_of_mem idx hi) f]
  exact (sum_le_sum fun k _ => h k).trans
    (hsum.summable.sum_le_tsum _ (fun k _ => by positivity) |>.trans_eq hsum.tsum_eq)

/-- Upper bound for the absolute zero sum on one whole ray of the critical line.
W is the bin width and Y is a free positive anchor for the polynomial growth bound. -/
def rayBound (q : ℕ) (z : ℂ) (dir A W Y : ℝ) : ℝ :=
  let d := π/2-dir*z.arg
  let r := Real.exp (-(d*W))
  let K := Real.sqrt (2*π)/Real.sqrt ‖z‖ * Real.exp (-(d*A)) /
    Real.log (10/Real.sqrt (9/4+(W/2)^2))
  (K*Real.log (BP q Y/0.355))/(1-r) + (K*(11*W/Y))*r/(1-r)^2

theorem critical_ray_of_count {q : ℕ} [NeZero q] {Z : Finset ℂ} {ord : ℂ → ℕ}
    (cnt : JensenCount q Z ord) (S : Finset ℂ) (hS : S ⊆ Z)
    {z : ℂ} (hz : z ≠ 0) (hzarg : |z.arg| < π/2) {dir A W Y : ℝ}
    (hdir : dir=1 ∨ dir= -1) (hA : 0 ≤ A) (hW : 0 < W) (hW18 : W ≤ 18)
    (hY : A+W/2 ≤ Y) (hline : ∀ s ∈ S, s.re=1/2 ∧ A ≤ dir*s.im) :
    ∑ s ∈ S, (ord s : ℝ)*‖Complex.Gamma s*z^(-s)‖ ≤ rayBound q z dir A W Y := by
  classical
  let d := π/2-dir*z.arg
  let r := Real.exp (-(d*W))
  let L := Real.log (10/Real.sqrt (9/4+(W/2)^2))
  let F := Real.sqrt (2*π)/Real.sqrt ‖z‖
  let K := F*Real.exp (-(d*A))/L
  have hd : 0 < d := by rcases hdir with h|h <;> simp [d,h] <;> linarith [abs_lt.mp hzarg]
  have hr : 0 ≤ r := (Real.exp_pos _).le
  have hr1 : r < 1 := Real.exp_lt_one_iff.mpr (by nlinarith [mul_pos hd hW])
  have hYpos : 0 < Y := by linarith
  have hL : 0 < L := by
    apply log_ratio_pos (by positivity)
    apply (Real.sqrt_lt' (by norm_num)).mpr
    nlinarith [mul_self_le_mul_self hW.le hW18]
  have hF : 0 ≤ F := by dsimp [F]; positivity
  have hK : 0 ≤ K := div_nonneg (mul_nonneg hF (Real.exp_pos _).le) hL.le
  let idx := fun s : ℂ => ⌊(dir*s.im-A)/W⌋₊
  apply fiber_geometric S idx _ (mul_nonneg hK (log_BP_pos q Y).le)
    (mul_nonneg hK (by positivity : 0 ≤ 11*W/Y)) hr hr1
  intro k
  let V := A+(k:ℝ)*W
  let v := V+W/2
  have hV : 0 ≤ V := by dsimp [V]; positivity
  have hv : 0 ≤ v := by dsimp [v]; positivity
  have hloc (s : ℂ) (hs : s ∈ S.filter fun s => idx s=k) :
      s.re=1/2 ∧ |s.im-dir*v| ≤ W/2 := by
    obtain ⟨hs,hidx⟩ := mem_filter.mp hs
    obtain ⟨hre,ht⟩ := hline s hs
    change ⌊(dir*s.im-A)/W⌋₊=k at hidx
    have h1 := Nat.floor_le (div_nonneg (sub_nonneg.mpr ht) hW.le)
    have h2 := Nat.lt_floor_add_one ((dir*s.im-A)/W)
    rw [hidx,le_div_iff₀ hW] at h1
    rw [hidx,div_lt_iff₀ hW] at h2
    refine ⟨hre,abs_le.mpr ?_⟩
    dsimp [v,V]; rcases hdir with e|e <;> subst dir <;> constructor <;> linarith
  have hwin := critical_window_of_count cnt _ ((filter_subset _ S).trans hS) (dir*v)
    (show 0≤W/2 by linarith) (show W/2≤9 by linarith) hloc hz hzarg
  have harg : (π/2-z.arg)*max (dir*v-W/2) 0+(π/2+z.arg)*max (-(dir*v+W/2)) 0 = d*V := by
    dsimp only [v,d]
    rcases hdir with e|e <;> subst dir <;> simp only [one_mul,neg_one_mul]
    · rw [max_eq_left (by linarith),max_eq_right (by linarith)]; ring
    · rw [max_eq_right (by linarith),max_eq_left (by linarith)]; ring
  have hbp : BP q (dir*v)=BP q v := by rcases hdir with h|h <;> simp [h,BP_neg]
  rw [harg,hbp] at hwin
  have hg := log_BP_growth q hYpos (mul_nonneg (Nat.cast_nonneg k) hW.le)
  have hm := log_BP_mono q (c := v) (c' := Y+(k:ℝ)*W) (by
    rw [abs_of_nonneg hv,abs_of_nonneg (by positivity)]
    dsimp [v,V]; linarith)
  have hlog : Real.log (BP q v/0.355) ≤ Real.log (BP q Y/0.355)+(11*W/Y)*k :=
    (hm.trans hg).trans_eq (by ring)
  have hpow : Real.exp (-(d*V)) = Real.exp (-(d*A))*r^k := by
    dsimp [V,r]; rw [← Real.exp_nat_mul,← Real.exp_add]; congr 1; ring
  apply hwin.trans
  change Real.log (BP q v/0.355)/L*(F*Real.exp (-(d*V))) ≤ _
  rw [hpow]
  calc _ = (K*Real.log (BP q v/0.355))*r^k := by dsimp [K]; ring
       _ ≤ (K*(Real.log (BP q Y/0.355)+(11*W/Y)*k))*r^k :=
         mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hlog hK) (pow_nonneg hr _)
       _ = _ := by ring

theorem critical_ray {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1) {T : ℝ} (S : Finset ℂ) (hS : S ⊆ zerosRect χ T)
    {z : ℂ} (hz : z ≠ 0) (hzarg : |z.arg| < π/2) {dir A W Y : ℝ}
    (hdir : dir=1 ∨ dir= -1) (hA : 0 ≤ A) (hW : 0 < W) (hW18 : W ≤ 18)
    (hY : A+W/2 ≤ Y) (hline : ∀ s ∈ S, s.re=1/2 ∧ A ≤ dir*s.im) :
    ∑ s ∈ S, (multRect χ T s : ℝ)*‖Complex.Gamma s*z^(-s)‖ ≤ rayBound q z dir A W Y :=
  critical_ray_of_count (character_count hp hχ T) S hS hz hzarg hdir hA hW hW18 hY hline

#print axioms critical_ray
end GoldbachEnergy
