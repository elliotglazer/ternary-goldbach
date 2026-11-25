module

public import BoundedGeometry
public import TailCharacter
public import SmallWindow

@[expose] public section


open Real Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

private theorem bounded_major_BP {d : ℕ} [NeZero d] (hd : d ≤ 3450) {y : ℝ} (hy : |y| ≤ 714) :
    Real.log (BP d y/0.355) ≤ 165 := by
  have hc := upper_log_certificate 165 0 (boxBP 3450 714) (by norm_num [boxBP])
    (by norm_num) (by norm_num) (by norm_num [expPoly,boxBP])
  have h := bp_box_upper hd (Y:=714) (by norm_num; exact hy : |y| ≤ ((714:ℚ):ℝ))
  have hq0 : (0:ℝ)<d := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne d)
  exact (Real.log_le_log (by unfold BP; positivity) h).trans (by simpa using hc)

private theorem bounded_major_D {d : ℕ} [NeZero d] (hd : d ≤ 3450) : DN d ≤ 100 := by
  have hq0 : (0:ℝ)<d := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne d)
  let v : ℚ := 512*3450^9*(3450+1)/(355/1000)
  have hc := upper_log_certificate 100 0 v (by norm_num [v]) (by norm_num) (by norm_num) (by norm_num [v,expPoly])
  have hq' : (d:ℝ) ≤ 3450 := by exact_mod_cast hd
  have he : 512*(d:ℝ)^9*((d:ℝ)+1)/0.355 ≤ (v:ℝ) := by dsimp [v]; push_cast; gcongr <;> norm_num
  apply (Real.log_le_log (by positivity : (0:ℝ)<512*(d:ℝ)^9*((d:ℝ)+1)/0.355) he).trans
  simpa using hc

private theorem bounded_major_character {d : ℕ} [NeZero d] (hd : d ≤ 3450) {D N δ : ℝ} (hD : D ≤ 100)
    (hn : 2*10^19 ≤ N) (hl : Real.log N ≤ 56) (hz : ‖twistRate δ‖ ≤ 706) :
    charBudget d D N δ (tailTiling (twistRate δ)) (tailTiling 1) ≤ 
      Real.sqrt N*(1568+68.8*Real.sqrt ‖twistRate δ‖)+20100000 := by
  let z := twistRate δ
  let L := Real.log N
  have h44 : 44 ≤ L := log_two_e19 hn
  have hL56 : L ≤ 56 := hl
  have hz0 : 1 ≤ ‖z‖ := (twist_norm_bounds δ).1
  have hz' : ‖z‖ ≤ 706 := hz
  have hb : Real.log (BP d (8+‖z‖)/0.355) ≤ 165 := bounded_major_BP hd
    (by rw [abs_of_nonneg (by positivity)]; linarith)
  have hu : Real.log (BP d (8+‖(1:ℂ)‖)/0.355) ≤ 165 := bounded_major_BP hd (by norm_num)
  have hg := gamma_of_log_bounds (q:=d) (L:=16) (by norm_num) z hz0 (inverse_norm_le_gap δ) (by linarith) (by linarith)
  have h1 := gamma_of_log_bounds (q:=d) (L:=16) (by norm_num) (1:ℂ) (by simp)
    (by simp; linarith [Real.pi_gt_three]) (by linarith) (by linarith)
  have hb0 := bounded_major_BP hd (y:=0) (by norm_num)
  have hg' : gammaBudget d z (tailTiling z) ≤ 1568+68.8*Real.sqrt ‖z‖ := by linarith only [hg]
  have hu' : gammaBudget d 1 (tailTiling 1) ≤ 1700 := by norm_num at h1; linarith
  have hh := character_envelope (d:=d) (δ:=δ) (by linarith : 1 ≤ N) (log_two_e19 hn)
    (by dsimp [L] at h44; linarith : D ≤ 11*Real.log N) (by linarith) (by dsimp [L] at h44; linarith)
    _ _ _ _ hg' hu'
  change _ ≤ Real.sqrt N*(1568+68.8*Real.sqrt ‖z‖)+33*L^2+1700+500*L*‖z‖+7 at hh
  have hL2 := sq_le_sq' (by linarith : -(56:ℝ) ≤ L) hL56
  have hprod := mul_le_mul hL56 hz' (norm_nonneg _) (by norm_num)
  change _ ≤ Real.sqrt N*(1568+68.8*Real.sqrt ‖z‖)+20100000
  linarith only [hh,hL2,hprod]

theorem major_budget_bounded {N : ℝ} (hn : 2*10^19 ≤ N) (h56 : Real.log N ≤ 56) : MajorBudgetAt N := by
  intro q hq hlim δ hd
  let z := twistRate δ
  let L := Real.log N
  let R := Real.sqrt N
  let t := Real.sqrt q
  have hl : 44 ≤ L := log_two_e19 hn
  have hl' : L ≤ 56 := h56
  have h0 : 0<L := by linarith
  have hR : 4000000000 ≤ R := Real.le_sqrt_of_sq_le (by linarith)
  have hR0 : 0<R := by linarith
  have hR2 : R^2 = N := Real.sq_sqrt (by linarith)
  have hsc : L^2 ≤ 0.000000455*R := major_scale hn
  have ht0 : 0 ≤ t := Real.sqrt_nonneg _
  have ht1 : 1 ≤ t := by simpa [t] using Real.sqrt_le_sqrt (show (1:ℝ) ≤ q by exact_mod_cast hq)
  obtain ⟨ht,htz⟩ := major_geometry hn q hq hlim hd
  change t ≤ 1.05*L at ht; change t*Real.sqrt ‖z‖ ≤ 4.5*L at htz
  have hqmax : q ≤ 3450 := by
    have hq' : (q:ℝ) ≤ 1.1*L^2 := hlim
    exact_mod_cast (show (q:ℝ) ≤ 3450 by nlinarith only [hq',sq_le_sq' (by linarith : -(56:ℝ) ≤ L) hl'])
  have hφ : (1:ℝ) ≤ q.totient := by exact_mod_cast Nat.totient_pos.mpr hq
  have hδ : |δ| ≤ 112 := by
    apply hd.trans; rw [div_le_iff₀ (by linarith)]; linarith
  have hz : ‖z‖ ≤ 706 := by linarith only [(twist_norm_bounds δ).2,hδ]
  let C := R*(1568+68.8*Real.sqrt ‖z‖)+20100000
  have hC : conductorBudget q N δ (tailTiling z) (tailTiling 1) ≤ C := by
    unfold conductorBudget; apply max_le
    · exact bounded_major_character (by decide) (by norm_num) hn h56 hz
    · apply sup'_le; intro d hd'
      have hp : 0<d := by rcases mem_insert.mp hd' with h|h; omega; exact Nat.pos_of_mem_divisors h
      have hdq : d ≤ q := by rcases mem_insert.mp hd' with h|h; omega; exact Nat.le_of_dvd hq (Nat.mem_divisors.mp h).1
      letI : NeZero d := ⟨hp.ne'⟩
      exact bounded_major_character (hdq.trans hqmax) (bounded_major_D (hdq.trans hqmax)) hn h56 hz
  let D := Real.log q/Real.log 2*(1+L)
  have hh2 : 1/2 ≤ Real.log 2 := by
    have hh := lower_log_certificate 0 (1/2) 2 (by norm_num) (by norm_num) (by norm_num [expPoly]); simpa using hh
  have h9 : Real.log q ≤ 9 := by
    have h := upper_log_certificate 9 0 3450 (by norm_num) (by norm_num) (by norm_num) (by norm_num [expPoly])
    exact (Real.log_le_log (by exact_mod_cast hq) (show (q:ℝ) ≤ 3450 by exact_mod_cast hqmax)).trans (by simpa using h)
  have hD : D ≤ 1026 := by
    have h' : Real.log q/Real.log 2 ≤ 18 := by rw [div_le_iff₀ (by linarith)]; linarith
    dsimp [D]; nlinarith only [mul_le_mul h' (show 1+L ≤ 57 by linarith) (by linarith) (by norm_num)]
  have hw := mul_le_mul_of_nonneg_left (add_le_add hC hD) ht0
  have he : t*(1568+68.8*Real.sqrt ‖z‖) ≤ 1960*L := by linarith only [ht,htz,h0]
  have h2 : 1026+t*(C+1026) ≤ R*(1960*L)+21000000*t := by
    dsimp only [C]
    nlinarith only [mul_le_mul_of_nonneg_right he hR0.le,ht1]
  have h3 := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left ht (by norm_num : (0:ℝ) ≤ 21000000)) h0.le
  have hmain := mul_le_mul_of_nonneg_left hsc hR0.le
  have hextra := mul_le_mul_of_nonneg_right hR hR0.le
  refine ⟨tailTiling z,tailTiling 1,?_⟩
  change D+t*(conductorBudget q N δ (tailTiling z) (tailTiling 1)+D) ≤ 0.001*N/L
  apply ((add_le_add hD hw).trans h2).trans
  rw [le_div_iff₀ h0]; nlinarith only [h3,hmain,hsc,hextra,hR2,hR0]

#print axioms major_budget_bounded
end GoldbachEnergy
