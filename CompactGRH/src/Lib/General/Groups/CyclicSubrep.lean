module

public import Lib.Adelic.Unitary.CongruenceLevel

@[expose] public section

/-! General lemmas of group theory (textbook or folklore).

This file: Cyclic subrepresentation of a vector; subrepresentation of smooth vectors. -/

variable {G V} [Group G] [AddCommGroup V] [Module ℂ V] (ρ : Representation ℂ G V)

/-- The subspace V_y spanned by the translates ρ(g)y of the vector y. -/
abbrev cyclicSpan y := Submodule.span ℂ (.range (ρ · y))

lemma self_mem_cyclicSpan {ρ : Representation ℂ G V} {y} : y ∈ cyclicSpan ρ y :=
  Submodule.subset_span ⟨1, by simp⟩

lemma apply_mem_cyclicSpan {ρ : Representation ℂ G V} {y} g : ∀ x ∈ cyclicSpan ρ y,
  ρ g x ∈ cyclicSpan ρ y := Submodule.mapsTo_span fun _ ⟨h, _⟩ ↦ ⟨g * h, by simp [*]⟩

lemma compactMean_mem_cyclicSpan {ρ : Representation ℂ G V} {y} {K : Subgroup G} [TopologicalSpace
  G] [IsTopologicalGroup G] [IsSmoothRep ρ] [CompactSpace K] g {x} (h : x ∈ cyclicSpan ρ y) :
  compactMean ρ K (ρ g x) ∈ cyclicSpan ρ y :=
  (Submodule.ker_mkQ _).le (map_compactMean_of_const _ (by simp_all [apply_mem_cyclicSpan]))

/-- The subrepresentation of ρ on its smooth vectors, those fixed by all g in some neighbourhood
of 1. -/
def smoothVectorRep [TopologicalSpace G] [IsTopologicalGroup G] := ρ.subrepresentation ⟨⟨⟨{x | ∀ᶠ
  g in nhds (1 : G), ρ g x = x}, (·.mp <| ·.mono (by grind))⟩, by simp⟩, fun _ _ ↦ (·.mono (by simp_all))⟩
  fun a x hx ↦ by
    have hc : Filter.Tendsto (fun g : G ↦ a⁻¹ * g * a) (nhds 1) (nhds 1) := by
      simpa using ((continuous_const_mul a⁻¹).mul_const a).tendsto (1 : G)
    change ∀ᶠ g in nhds (1 : G), ρ g x = x at hx
    filter_upwards [hc.eventually hx] with g hg
    simpa [← Module.End.mul_apply, ← map_mul, ← mul_assoc] using congrArg (ρ a) hg

instance [TopologicalSpace G] [IsTopologicalGroup G] : IsSmoothRep (smoothVectorRep ρ) :=
  ⟨fun x ↦ x.2.mono fun g hg ↦ Subtype.ext hg⟩
