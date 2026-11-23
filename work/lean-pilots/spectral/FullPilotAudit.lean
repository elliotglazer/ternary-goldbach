import FullSpectralPilotV2

#check SpectralPilot.positive_height_chi4_certificate
#print axioms SpectralPilot.positive_height_chi4_certificate
#print axioms SpectralPilot.actual_sample_box
#print axioms SpectralAbelPilot.LFunction_finite_abel
#print axioms SpectralCompletion.completed_product_positive
#print axioms SpectralRealityPilot.normalized_completed_chi4_real

example :
    0 < (((4 : ℂ) ^ (((1 / 2 : ℂ) + Complex.I * (5 / 64)) / 2)) *
      DirichletCharacter.completedLFunction
        (ZMod.χ₄.ringHomComp (Int.castRingHom ℂ))
        ((1 / 2 : ℂ) + Complex.I * (5 / 64))).re ∧
    (((4 : ℂ) ^ (((1 / 2 : ℂ) + Complex.I * (5 / 64)) / 2)) *
      DirichletCharacter.completedLFunction
        (ZMod.χ₄.ringHomComp (Int.castRingHom ℂ))
        ((1 / 2 : ℂ) + Complex.I * (5 / 64))).im = 0 :=
  SpectralPilot.positive_height_chi4_certificate
