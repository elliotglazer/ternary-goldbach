module

public import ProfileMultiplier

@[expose] public section


open Real
noncomputable section
namespace GoldbachEnergy.Profile

/-- Order and radius bounds in square-root coordinates, including the uniform remainder input. -/
theorem geometry {N δ c M : ℝ} {q : ℕ} (hN : 0 < N) (hl : 44 ≤ Real.log N)
    (hc : 30 ≤ c) (hc' : c ≤ 70) (order : M=c^2*(Real.log N)^4)
    (hq : 0 < q) (ho : (q:ℝ) ≤ M) (hd : |δ| ≤ N/(M*q)) :
    Real.sqrt q ≤ c*(Real.log N)^2 ∧
    Real.sqrt q * Real.sqrt |δ| * (c*(Real.log N)^2) ≤ Real.sqrt N ∧
    (Real.sqrt q)^2* |δ| *(900*(Real.log N)^4) ≤ N := by
  let L := Real.log N
  have hl' : 0 < L := by dsimp [L]; linarith
  have hlog : 0 < Real.log N := hl'
  have hc0 : 0 < c := by linarith
  have hq0 : (0:ℝ) < q := by exact_mod_cast hq
  have ts := Real.sq_sqrt hq0.le
  have ds := Real.sq_sqrt (abs_nonneg δ)
  have ns := Real.sq_sqrt hN.le
  rw [order] at ho hd
  have radius := (le_div_iff₀ (by positivity : 0 < c^2*(Real.log N)^4*(q:ℝ))).mp hd
  constructor
  · apply (sq_le_sq₀ (Real.sqrt_nonneg _) (by positivity)).mp
    rw [ts]; linarith only [ho]
  constructor
  · apply (sq_le_sq₀ (by positivity) (Real.sqrt_nonneg _)).mp
    rw [mul_pow,mul_pow,ts,ds,ns]; linarith only [radius]
  · have cc := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 30) hc 2
    have h := mul_le_mul_of_nonneg_right cc (show 0 ≤ (q:ℝ)* |δ| *(Real.log N)^4 by positivity)
    rw [ts]; linarith only [h,radius]

theorem head_factor {a L N t c : ℝ} {Q : ℕ} (hn : 0 < N) (hlog : Real.log N=L)
    (ha : 6 ≤ a) (haL : a ≤ L) (hc : 0 < c) (ho : t ≤ c*L^2) (hq : t ≤ Real.sqrt Q) :
    t*L/Real.sqrt N ≤ min (c*a^3) (Real.sqrt Q*a)/Real.exp (a/2) := by
  have ha0 : 0 < a := by linarith
  have hl := ha0.trans_le haL
  have root : Real.sqrt N = Real.exp (L/2) := by
    rw [Real.sqrt_eq_rpow,Real.rpow_def_of_pos hn,hlog]; congr 1; ring
  rw [root,←min_div_div_right (Real.exp_pos _).le]
  have bound (k : ℕ) (K : ℝ) (hK : 0 ≤ K) (hk : 2*(k:ℝ) ≤ a) (ht : t*L ≤ K*L^k) :
      t*L/Real.exp (L/2) ≤ K*a^k/Real.exp (a/2) := by
    calc _ ≤ (K*L^k)/Real.exp (L/2) := div_le_div_of_nonneg_right ht (Real.exp_pos _).le
         _ = K*(L^k/Real.exp (L/2)) := by ring
         _ ≤ K*(a^k/Real.exp (a/2)) := mul_le_mul_of_nonneg_left (profile_decay k ha0 hk haL) hK
         _ = _ := by ring
  apply le_min
  · exact bound 3 c hc.le (by norm_num <;> linarith) (by linarith only [mul_le_mul_of_nonneg_right ho hl.le])
  · simpa only [pow_one] using bound 1 (Real.sqrt Q) (Real.sqrt_nonneg _) (by norm_num <;> linarith)
      (by simpa only [pow_one] using mul_le_mul_of_nonneg_right hq hl.le)

#print axioms geometry
#print axioms head_factor
end GoldbachEnergy.Profile
