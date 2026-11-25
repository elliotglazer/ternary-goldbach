module

public import ProfileMultiplier

@[expose] public section


open Real
namespace GoldbachEnergy.Profile
/-- Uniform contribution of the two elementary errors after multiplying by log(N)/N. -/
theorem remainder {N L t d : ℝ} (hn : 2*10^19 ≤ N) (hl : 44 ≤ L) (hu : L ≤ 56)
    (ht : 1 ≤ t) (hd : 0 ≤ d) (hq : t ≤ 70*L^2) (rad : t^2*d*(900*L^4) ≤ N) :
    t*(57*L^2+3150*L*d)*L ≤ 0.003*N := by
  have hL : 0≤L := by linarith
  have hq' := mul_le_mul_of_nonneg_right hq (pow_nonneg hL 3)
  have hb := pow_le_pow_left₀ hL hu 5
  have hc : t*(57*L^2)*L ≤ 0.001*N := by nlinarith only [hq',hb,hn]
  have ht' : t≤t^2 := by nlinarith only [mul_le_mul_of_nonneg_right ht (show 0≤t by linarith)]
  have h2 := pow_le_pow_left₀ (by norm_num : (0:ℝ)≤44) hl 2
  have hcomp : 3150*L^2 ≤ 0.002*(900*L^4) := by
    nlinarith only [mul_le_mul_of_nonneg_right h2 (sq_nonneg L),sq_nonneg L]
  have he := mul_le_mul hcomp (mul_le_mul_of_nonneg_right ht' hd)
    (mul_nonneg (show 0≤t by linarith) hd) (by positivity)
  nlinarith only [hc,he,rad]
#print axioms remainder
end GoldbachEnergy.Profile
