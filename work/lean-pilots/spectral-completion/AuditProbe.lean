import CompletionFactor

example : (3/4:ℝ) ≤ SpectralCompletion.gammaPhase.re ∧
    |SpectralCompletion.gammaPhase.im| ≤ 1/4 :=
  SpectralCompletion.gammaPhase_enclosure

example :
    (4:ℂ)^(((1/2:ℂ)+Complex.I*(5/64))/2) *
      Complex.Gammaℝ (((1/2:ℂ)+Complex.I*(5/64))+1) =
    ((Real.exp (Real.log 4/4 - 3*Real.log Real.pi/4):ℝ):ℂ) *
      (Complex.exp (Complex.I * (((5/128)*Real.log (4/Real.pi):ℝ):ℂ)) *
        Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))) :=
  SpectralCompletion.completion_factor_eq

#print axioms SpectralCompletion.gammaPhase_enclosure
#print axioms SpectralCompletion.completion_factor_eq
#print axioms SpectralCompletion.completed_product_positive
#check SpectralCompletion.completed_product_positive
