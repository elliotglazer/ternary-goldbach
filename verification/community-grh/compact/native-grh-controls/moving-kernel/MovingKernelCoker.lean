module
public import Lib.Cohomology.Hodge.WitnessCocycles

@[expose] public section
open CategoryTheory
variable {C : Type} [Category C] {F G : C ⥤ Ab}
noncomputable def checkedCokernelMap (ℓ : ℕ) (i : F ⟶ G)
    (w : (ℓ • 𝟙 G) ≫ abCoker.π (ℓ • 𝟙 G) = 0) :
    abCoker (ℓ • 𝟙 F) ⟶ abCoker (ℓ • 𝟙 G) :=
  abCoker.desc (i ≫ abCoker.π (ℓ • 𝟙 G)) (by
    simpa only [Preadditive.nsmul_comp, Preadditive.comp_nsmul, Category.id_comp, Limits.comp_zero]
      using i ≫= w)
#print axioms checkedCokernelMap
