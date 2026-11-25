module

public import SingularBase

@[expose] public section


open Finset
namespace GoldbachSingular

private def corePrimes : Finset ℕ := {3,5,7}
private noncomputable def envelope (p : ℕ) : ℝ := 1 / ((p:ℝ)-1)^2

private theorem core_subset {R : ℕ} (hR : 200 ≤ R) : corePrimes ⊆ oddPrimes R := by
  intro p hp
  simp only [corePrimes, mem_insert, mem_singleton] at hp
  rcases hp with rfl|rfl|rfl <;> rw [mem_oddPrimes] <;> exact ⟨⟨by norm_num,by omega⟩,by decide⟩

private theorem sum_odd_lower (N R : ℕ) (hR : 200 ≤ R) :
    0.625 ≤ ∑ q ∈ (Icc 1 R).filter Odd, coefN N q := by
  classical
  rw [sum_odd_coefN_eq]
  let P := (oddPrimes R).powerset
  let S := P.filter (fun t => ∏ p ∈ t, p ≤ R)
  let D := corePrimes.powerset
  let F (t : Finset ℕ) := ∏ p ∈ t, aP N p
  let G (t : Finset ℕ) := ∏ p ∈ t, envelope p
  have dsub : D ⊆ S := by
    intro t ht
    have h := mem_powerset.mp ht
    have prod_le : ∏ p ∈ t, p ≤ ∏ p ∈ corePrimes, p :=
      prod_le_prod_of_subset_of_one_le' h fun p hp _ => by
        have := mem_oddPrimes.mp (core_subset hR hp); omega
    have v : ∏ p ∈ corePrimes, p = 105 := by decide
    exact mem_filter.mpr ⟨mem_powerset.mpr (h.trans (core_subset hR)), by omega⟩
  have sub : S ⊆ P := filter_subset _ _
  have hfg (t : Finset ℕ) (ht : t ∈ P) : |F t| ≤ G t := by
    rw [show |F t| = ∏ p ∈ t, |aP N p| from Finset.abs_prod _ _]
    exact prod_le_prod₀ (fun _ _ => abs_nonneg _) fun p hp =>
      abs_aP_le (three_le_of_mem (mem_powerset.mp ht hp))
  have hr : -(∑ t ∈ P \ D, G t) ≤ ∑ t ∈ S \ D, F t := by
    have hsum : -(∑ t ∈ S \ D, G t) ≤ ∑ t ∈ S \ D, F t := by
      rw [← sum_neg_distrib]
      exact sum_le_sum fun t ht => neg_le_of_abs_le (hfg t (sub (mem_sdiff.mp ht).1))
    have hrest : S \ D ⊆ P \ D := fun t ht =>
      mem_sdiff.mpr ⟨sub (mem_sdiff.mp ht).1,(mem_sdiff.mp ht).2⟩
    exact (neg_le_neg (sum_le_sum_of_subset_of_nonneg hrest
      (fun t _ _ => prod_nonneg (fun p _ => by dsimp [envelope]; positivity)))).trans hsum
  have hwhole : ∑ t ∈ P, G t ≤ 1.4122*1.006 := by
    change ∑ t ∈ (oddPrimes R).powerset, (∏ p ∈ t, envelope p) ≤ _
    rw [← prod_one_add]
    exact (prod_upper_bound hR).trans (mul_le_mul_of_nonneg_left exp_inv199_le (by norm_num))
  have hcoreG : ∑ t ∈ D, G t = (1+1/4:ℝ)*(1+1/16)*(1+1/36) := by
    dsimp only [D,G]; rw [← prod_one_add]; norm_num [corePrimes,envelope]
  have hcoreF : (1-1/4:ℝ)*(1-1/16)*(1-1/36) ≤ ∑ t ∈ D, F t := by
    dsimp only [D,F]; rw [← prod_one_add]
    calc _ = ∏ p ∈ corePrimes, (1-envelope p) := by norm_num [corePrimes,envelope]
         _ ≤ _ := by
           apply prod_le_prod₀
           · intro p hp; simp only [corePrimes,mem_insert,mem_singleton] at hp
             rcases hp with rfl|rfl|rfl <;> norm_num [envelope]
           · intro p hp
             unfold envelope
             linarith only [aP_ge (N := N) (three_le_of_mem (core_subset hR hp))]
  have ha := sum_sdiff (dsub.trans sub) (f := G)
  have hb := sum_sdiff dsub (f := F)
  change _ ≤ ∑ t ∈ S, F t
  linarith

private theorem split_at_half (Q : ℕ) (f : ℕ → ℝ)
    (hf : ∀ k, f (2*k) = if Odd k then f k else 0) :
    ∑ q ∈ Icc 1 Q, f q =
      (∑ q ∈ (Icc 1 Q).filter Odd, f q) +
      ∑ q ∈ (Icc 1 (Q/2)).filter Odd, f q := by
  classical
  have heven : ((Icc 1 Q).filter (fun n => ¬Odd n)) =
      (Icc 1 (Q/2)).image (fun k => 2*k) := by
    ext i
    simp only [mem_image, mem_filter, mem_Icc]
    constructor
    · rintro ⟨⟨hl,hh⟩,ho'⟩
      obtain ⟨k,hk⟩ := Nat.not_odd_iff_even.mp ho'
      exact ⟨k,⟨by omega,by omega⟩,by omega⟩
    · rintro ⟨k,⟨hl,hh⟩,rfl⟩
      exact ⟨⟨by omega,by omega⟩,fun ⟨j,h⟩ => by omega⟩
  have hpart := sum_filter_add_sum_filter_not (Icc 1 Q) Odd f
  rw [heven, sum_image (fun a _ b _ h => by omega)] at hpart
  simp_rw [hf] at hpart
  rw [← sum_filter] at hpart
  exact hpart.symm

/-- Uniform singular-series lower bound when all moduli up to Q are included. -/
theorem truncated_lower {N Q : ℕ} (ho : Odd N) (hQ : 400 ≤ Q) :
    1.25 ≤ ∑ q ∈ Icc 1 Q, coefN N q := by
  rw [split_at_half Q _ (coefN_two_mul ho)]
  linarith [sum_odd_lower N Q (by omega),sum_odd_lower N (Q/2) (by omega)]

private theorem abs_odd_upper (N R : ℕ) (hR : 200 ≤ R) :
    ∑ q ∈ (Icc 1 R).filter Odd, |coefN N q| ≤ 1.4122*1.006 := by
  classical
  have h (q : ℕ) : |coefN N q| =
      if Squarefree q then ∏ p ∈ q.primeFactors, |aP N p| else 0 := by
    by_cases hs : Squarefree q <;> simp [coefN,hs,Finset.abs_prod]
  simp_rw [h]
  rw [sum_odd_sqfree_eq]
  calc _ ≤ ∑ t ∈ (oddPrimes R).powerset, ∏ p ∈ t, |aP N p| :=
         sum_le_sum_of_subset_of_nonneg (filter_subset _ _) fun t _ _ => prod_nonneg fun _ _ => abs_nonneg _
       _ = ∏ p ∈ oddPrimes R, (1+|aP N p|) := (prod_one_add _).symm
       _ ≤ ∏ p ∈ oddPrimes R, (1+envelope p) := by
          apply prod_le_prod₀ (fun p _ => by positivity)
          exact fun p hp => add_le_add_right (abs_aP_le (three_le_of_mem hp)) _
       _ ≤ _ := (prod_upper_bound hR).trans (mul_le_mul_of_nonneg_left exp_inv199_le (by norm_num))

theorem summable_coefficient {N : ℕ} (ho : Odd N) : Summable (fun j => coefN N (j+1)) := by
  apply Summable.of_norm
  apply summable_of_sum_range_le (fun j => norm_nonneg _) (c := 3)
  intro k
  have hchange : (∑ j ∈ range k, ‖coefN N (j+1)‖) = ∑ q ∈ Icc 1 k, |coefN N q| := by
    rw [← Finset.Ico_add_one_right_eq_Icc 1 k, sum_Ico_eq_sum_range]
    simp [Nat.add_comm,Real.norm_eq_abs]
  rw [hchange]
  let K := max k 400
  have hK : 400 ≤ K := le_max_right _ _
  have h := split_at_half K (fun q => |coefN N q|) (by
    intro q; rw [coefN_two_mul ho]; split_ifs <;> simp)
  have hsub : Icc 1 k ⊆ Icc 1 K := Icc_subset_Icc le_rfl (le_max_left _ _)
  apply (sum_le_sum_of_subset_of_nonneg hsub (fun a _ _ => abs_nonneg (coefN N a))).trans
  linarith [abs_odd_upper N K (by omega),abs_odd_upper N (K/2) (by omega)]

theorem singular_series_lower {N : ℕ} (ho : Odd N) :
    1.25 ≤ ∑' j : ℕ, coefN N (j+1) := by
  apply ge_of_tendsto (summable_coefficient ho).hasSum.tendsto_sum_nat
  filter_upwards [Filter.eventually_ge_atTop 400] with k hk
  have h := truncated_lower ho hk
  rw [← Finset.Ico_add_one_right_eq_Icc 1 k, sum_Ico_eq_sum_range] at h
  simpa [Nat.add_comm] using h

#print axioms truncated_lower
#print axioms singular_series_lower
end GoldbachSingular
