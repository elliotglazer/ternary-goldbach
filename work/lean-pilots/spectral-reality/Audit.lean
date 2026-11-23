import Chi4Reality

#check SpectralRealityPilot.normalized_completed_chi4_real
#print axioms SpectralRealityPilot.chi4_odd
#print axioms SpectralRealityPilot.chi4_inverse
#print axioms SpectralRealityPilot.chi4_primitive
#print axioms SpectralRealityPilot.chi4_completed_central_ne_zero
#print axioms SpectralRealityPilot.chi4_rootNumber
#print axioms SpectralRealityPilot.chi4_LFunction_conjugate
#print axioms SpectralRealityPilot.chi4_completed_conjugate
#print axioms SpectralRealityPilot.normalized_completed_chi4_real

example :
    ((4 : ℂ) ^ (((1 / 2 : ℂ) + Complex.I * (5 / 64 : ℝ)) / 2) *
      SpectralPilot.chi4.completedLFunction
        ((1 / 2 : ℂ) + Complex.I * (5 / 64 : ℝ))).im = 0 :=
  SpectralRealityPilot.normalized_completed_chi4_real (5 / 64)
