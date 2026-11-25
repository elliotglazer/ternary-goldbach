module

public import PrincipalMajor

@[expose] public section


open Real MeasureTheory TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

def translatedCube (N : ℕ) (q : ℕ) (a x : ℝ) : ℂ :=
  principalWave N q (x-a)^3*e (-(N*x))

theorem translated_integral {lo hi : ℝ} (h : lo ≤ hi) (N q : ℕ) (a : ℝ) :
    (∫ x in Set.Ioc (a+lo) (a+hi), translatedCube N q a x) =
      e (-(N*a))*∫ t in Set.Ioc lo hi, localCube N q t := by
  have he (x : ℝ) : translatedCube N q a x = e (-(N*a))*localCube N q (x-a) := by
    unfold translatedCube localCube
    rw [show (-(N*x):ℝ) = -(N*a)+(-N*(x-a)) by ring,e_add]; ring
  simp_rw [he,integral_const_mul]
  congr 1
  rw [← intervalIntegral.integral_of_le (add_le_add (le_refl a) h), ← intervalIntegral.integral_of_le h]
  rw [intervalIntegral.integral_comp_sub_right]
  congr 1 <;> ring

theorem endpoint_phase (N : ℕ) : e (-(N*(1:ℝ)))=1 := by
  rw [mul_one]
  rw [e,show 2*(π:ℂ)*Complex.I*((-(N:ℝ):ℝ):ℂ) = (-(N:ℤ):ℤ)*(2*π*Complex.I) by push_cast; ring]
  exact Complex.exp_int_mul_two_pi_mul_I (-(N:ℤ))

/-- The two endpoint half-windows make exactly one copy of the q=1 window. -/
theorem endpoint_halves {R : ℝ} (hr : 0≤R) {N : ℕ} (hn : 0<N) :
    (∫ x in Set.Ioc 0 R, translatedCube N 1 0 x) +
    (∫ x in Set.Ioc (1-R) 1, translatedCube N 1 1 x) =
    ∫ x in Set.Ioc (-R) R, localCube N 1 x := by
  have hpos := translated_integral (lo := 0) (hi := R) hr N 1 0
  have hneg := translated_integral (lo := -R) (hi := 0) (neg_nonpos.mpr hr) N 1 1
  simp only [zero_add,mul_zero,neg_zero,e_zero,one_mul] at hpos
  simp only [add_zero,← sub_eq_add_neg,endpoint_phase,one_mul] at hneg
  rw [hpos,hneg,add_comm,← intervalIntegral.integral_of_le (neg_nonpos.mpr hr),
    ← intervalIntegral.integral_of_le hr,← intervalIntegral.integral_of_le (by linarith : -R≤R)]
  exact intervalIntegral.integral_add_adjacent_intervals
    (integrable_localCube (by exact_mod_cast hn) 1).intervalIntegrable
    (integrable_localCube (by exact_mod_cast hn) 1).intervalIntegrable

#print axioms translated_integral
#print axioms endpoint_halves
end GoldbachEnergy
