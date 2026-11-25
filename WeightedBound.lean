module

public import TernaryGoldbach.Explicit.PsiExplicit
public import TernaryGoldbach.Explicit.WeilLineSum
public import Vertical
public import ZeroBudget

@[expose] public section


/-! The explicit-formula limit argument below is adapted from
calr3/ternary-goldbach, commit 23b2d68ca344203d4384e0aff7affa4ec034bef9,
`Explicit/PsiWeil.lean`, under Apache-2.0. It takes the independently
proved contribution of the low zeros instead of invoking the old bound. -/
open Complex Set Filter MeasureTheory Finset
open scoped Real Interval Topology ArithmeticFunction.vonMangoldt
open GrhGoldbach.LocalAssembly GrhGoldbach.ZeroBudget
namespace TernaryGoldbach.Explicit

/-- The error in the complete smoothed sum when separate bounds on the
line and tail zeros hold uniformly over the rectangles in the formula. -/
theorem tsum_gsm_err_of_line {a b δ x H line tail : ℝ} (hH : 0 < H)
    (hRH : RHBelow H) (hδ : 0 < δ) (hab : b ≤ a) (hb : b ≤ 0) (hx : 1 ≤ x)
    (hline : ∀ T : ℝ, √x * ∑ u ∈ (zerosRectD zetaF T).filter (fun u => |u.im| ≤ H),
      (multRectD zetaF T u : ℝ) * ‖Mg a b δ u‖ ≤ line)
    (htail : x * TailBH a δ H ≤ tail) :
    |(∑' n : ℕ, Λ n * gsm a b δ (n / x)) - Real.exp (δ^2/2) *
      (Real.exp a - Real.exp b) * x| ≤
        line + tail + x ^ (-(1/2):ℝ) * Vg a b δ / (2*π) := by
  have hx0 : 0 < x := by linarith only [hx]
  set φ : ℝ → ℂ := fun u => (gsm a b δ u : ℂ) with hφ
  have hgood := goodSmoothing_gsm hδ hab
  have hM : mellin φ = Mg a b δ := funext (mellin_gsm hδ hab)
  obtain ⟨Tk, -, hlim⟩ := explicit_formula_zeta hgood hx0
  set I0 := ∫ y : ℝ, hZeta φ x (((-1 / 2 : ℝ) : ℂ) + y * I) with hI0
  have hbound (T : ℝ) : ‖∑ u ∈ zerosRectD zetaF T, (multRectD zetaF T u : ℂ) *
      (mellin φ u * (x : ℂ) ^ u)‖ ≤ line + tail := by
    set Z := zerosRectD zetaF T with hZ
    set m : ℂ → ℝ := fun u => (multRectD zetaF T u : ℝ) with hm
    have h1 : ‖∑ u ∈ Z, (multRectD zetaF T u : ℂ) * (mellin φ u * (x:ℂ)^u)‖ ≤
        ∑ u ∈ Z, m u * (‖Mg a b δ u‖ * x ^ u.re) := by
      refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun u _ => ?_)
      rw [norm_mul, norm_mul, Complex.norm_natCast, norm_cpow_x hx0, hM]
    refine h1.trans ?_
    rw [← Finset.sum_filter_add_sum_filter_not Z (fun u => |u.im| ≤ H)]
    refine add_le_add ?_ ?_
    · set S := Z.filter (fun u => |u.im| ≤ H)
      have heq (u) (hu : u ∈ S) :
          m u * (‖Mg a b δ u‖ * x ^ u.re) = √x * (m u * ‖Mg a b δ u‖) := by
        obtain ⟨hr, him⟩ := Finset.mem_filter.1 hu
        obtain ⟨hz, h0, h1, -⟩ := zerosRectD_zetaF_strip hr
        rw [hRH u hz h0 h1 him, ← Real.sqrt_eq_rpow]; ring
      rw [Finset.sum_congr rfl heq, ← Finset.mul_sum]
      exact hline T
    · set S := Z.filter (fun u => ¬ |u.im| ≤ H)
      have hSZ : S ⊆ Z := Finset.filter_subset _ _
      have him : ∀ u ∈ S, H < |u.im| := fun u hu => not_le.1 (Finset.mem_filter.1 hu).2
      exact (tail_sum_gauss hH hδ hb hx S hSZ him).trans htail
  have h1 : ‖mellin φ 1 * x - SsumG (1 : DirichletCharacter ℂ 1) φ x -
        (1 / (2 * π) : ℂ) * I0‖ ≤ line + tail :=
    le_of_tendsto' ((continuous_norm.tendsto _).comp hlim) fun k => hbound (Tk k)
  have h2 : ‖(1 / (2 * π) : ℂ) * I0‖ ≤ x ^ (-(1 / 2) : ℝ) * Vg a b δ / (2 * π) := by
    rw [norm_mul]
    have : ‖(1 / (2 * π) : ℂ)‖ = 1 / (2 * π) := by
      rw [norm_div, norm_one, norm_mul, Complex.norm_ofNat, Complex.norm_real, Real.norm_eq_abs,
        abs_of_pos Real.pi_pos]
    rw [this, div_mul_eq_mul_div, one_mul]
    exact div_le_div_of_nonneg_right (norm_integral_hZeta_gsm hδ hab hx0) (by positivity)
  have e : SsumG (1 : DirichletCharacter ℂ 1) φ x - Mg a b δ 1 * x =
      -((mellin φ 1 * x - SsumG (1 : DirichletCharacter ℂ 1) φ x - (1 / (2 * π) : ℂ) * I0) +
        (1 / (2 * π) : ℂ) * I0) := by rw [hM]; ring
  have h : ‖SsumG (1 : DirichletCharacter ℂ 1) φ x - Mg a b δ 1 * x‖ ≤
      line + tail + x ^ (-(1/2):ℝ) * Vg a b δ / (2*π) := by
    rw [e, norm_neg]
    exact (norm_add_le _ _).trans (add_le_add h1 h2)
  rw [hφ, SsumG_one_ofReal, Mg_one] at h
  rw [show ((∑' n : ℕ, Λ n * gsm a b δ (n / x) : ℝ) : ℂ) -
      ((Real.exp (δ ^ 2 / 2) * (Real.exp a - Real.exp b) : ℝ) : ℂ) * (x : ℂ) =
      ((∑' n : ℕ, Λ n * gsm a b δ (n / x) - Real.exp (δ ^ 2 / 2) * (Real.exp a - Real.exp b) * x : ℝ) : ℂ) by
      push_cast; ring, Complex.norm_real, Real.norm_eq_abs] at h
  exact h

theorem localized_prime_of_low_and_leak {x : ℝ} (hx : 1e15 ≤ x) (hX : x ≤ 1e27)
    (hRH : RHBelow 5e14)
    (hlow : ∀ T : ℝ, √x * ∑ u ∈ (zerosRectD zetaF T).filter (fun u => |u.im| ≤ 2e14),
      (multRectD zetaF T u : ℝ) * ‖Mg (-(12.6/√x)) (-(113.6/√x)) (2.8/√x) u‖ < 98.977*√x)
    (hleak : let f := fun n : ℕ => Λ n * gsm (-(12.6/√x)) (-(113.6/√x)) (2.8/√x) (n/x)
      (∑' n, f n) - ∑ n ∈ Finset.Ioc ⌊x*Real.exp (-(126.2/√x))⌋₊ ⌊x⌋₊, f n ≤ 0.511*√x) :
    ∃ p : ℕ, p.Prime ∧ x - 126.2 * √x < p ∧ (p : ℝ) ≤ x := by
  set v := √x
  set a := -(12.6/v)
  set b := -(113.6/v)
  set δ := 2.8/v
  have hx0 : 0 < x := by linarith only [hx]
  have hv : 0 < v := Real.sqrt_pos.2 hx0
  have ha : a ≤ 0 := by exact neg_nonpos.mpr (by positivity)
  have hb : b ≤ 0 := by exact neg_nonpos.mpr (by positivity)
  have hab : b ≤ a := by dsimp [a,b]; exact neg_le_neg (div_le_div_of_nonneg_right (by norm_num) hv.le)
  have hd : 0 < δ := by dsimp [δ]; positivity
  have hx' : 10^15 ≤ x := by norm_num at hx ⊢; exact hx
  have hX' : x ≤ 10^27 := by norm_num at hX ⊢; exact hX
  obtain ⟨hvlo,hvhi⟩ := sqrt_range hx' hX'
  change 31000000 ≤ v at hvlo
  change v ≤ 31623000000000 at hvhi
  obtain ⟨hdlo,hdhi⟩ := delta_range hvlo hvhi
  have hAa : |a| ≤ 1 := by
    rw [abs_of_nonpos ha]
    change - - (12.6/v) ≤ 1
    rw [neg_neg]
    exact (div_le_iff₀ hv).2 (by linarith only [hvlo])
  have hmid : Real.exp (δ^2/8) * (Real.exp (a/2)+Real.exp (b/2)) *
      Real.exp (-(δ^2*(2e14:ℝ)^2/2)) * LWH 5e14 ≤ 0.001 := mid_le ha hb hdlo hdhi
  have htail : x * TailBH a δ 5e14 ≤ 1 := high_le hAa hdlo hdhi hx0.le hX
  have hvert : x ^ (-(1/2):ℝ) * Vg a b δ / (2*π) ≤ 255 := vertical_at_x hx hX
  have hline (T : ℝ) : v * ∑ u ∈ (zerosRectD zetaF T).filter (fun u => |u.im| ≤ 5e14),
      (multRectD zetaF T u : ℝ) * ‖Mg a b δ u‖ ≤ 98.977*v + 0.001*v := by
    rw [← Finset.sum_filter_add_sum_filter_not _ (fun u => |u.im| ≤ 2e14), mul_add]
    have e : ((zerosRectD zetaF T).filter (fun u => |u.im| ≤ 5e14)).filter (fun u => |u.im| ≤ 2e14) =
        (zerosRectD zetaF T).filter (fun u => |u.im| ≤ 2e14) := by
      rw [Finset.filter_filter]
      exact Finset.filter_congr fun u _ => ⟨fun h => h.2, fun h => ⟨h.trans (by norm_num), h⟩⟩
    rw [e, mul_comm (0.001:ℝ)]
    exact add_le_add (hlow T).le <| mul_le_mul_of_nonneg_left
      ((line_sum_midH hRH (by norm_num) (by norm_num) a b δ T).trans hmid) hv.le
  have hres := tsum_gsm_err_of_line (by norm_num) hRH hd hab hb
    (show 1 ≤ x by linarith only [hx]) hline htail
  have hleft := (abs_le.1 hres).1
  have hmain : 100.9996*v ≤ Real.exp (δ^2/2)*(Real.exp a - Real.exp b)*x := by
    have h := main_lower hvlo
    change 100.9996*√x ≤ (√x)^2*(Real.exp ((2.8/√x)^2/2) *
      (Real.exp (-12.6/√x)-Real.exp (-113.6/√x))) at h
    rw [Real.sq_sqrt hx0.le, mul_comm x] at h
    simpa only [a,b,δ,v,neg_div] using h
  apply prime_of_budgets hx' hX' (fun n => gsm a b δ (n/x)) (fun n => gsm_le_one hd hab (n/x))
    hmain (le_refl (98.977*v)) (le_refl (0.001*v)) (le_refl 1) hvert _ hleak
  linarith only [hleft]

end TernaryGoldbach.Explicit
