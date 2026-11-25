module

public import ZeroRay

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def centerCount (q : ℕ) (h : ℝ) :=
  Real.log (BP q 0/0.355) / Real.log (10/Real.sqrt (9/4+h^2))

theorem weighted_center_of_count {q : ℕ} [NeZero q] {Z : Finset ℂ} {ord : ℂ → ℕ}
    (cnt : JensenCount q Z ord) (S : Finset ℂ) (hS : S ⊆ Z)
    (hline : ∀ s ∈ S, s.re=1/2) (weight : ℂ → ℝ) (bands : Finset ℕ)
    (radius increment : ℕ → ℝ) (hr : ∀ i ∈ bands, 0 ≤ radius i ∧ radius i ≤ 9)
    (hi : ∀ i ∈ bands, 0 ≤ increment i)
    (hcover : ∀ s ∈ S, weight s ≤ ∑ i ∈ bands, if |s.im| ≤ radius i then increment i else 0) :
    ∑ s ∈ S, (ord s : ℝ)*weight s ≤
      ∑ i ∈ bands, increment i * centerCount q (radius i) := by
  classical
  have hcount (i : ℕ) (him : i ∈ bands) :
      ∑ s ∈ S.filter (fun s => |s.im| ≤ radius i), (ord s : ℝ) ≤ centerCount q (radius i) := by
    obtain ⟨hr0,hr9⟩ := hr i him
    apply cnt _ ((filter_subset _ S).trans hS) 0 (by positivity)
    · apply (Real.sqrt_lt' (by norm_num)).mpr
      nlinarith [mul_self_le_mul_self hr0 hr9]
    · intro s hs
      obtain ⟨hs,ht⟩ := mem_filter.mp hs
      apply Real.le_sqrt_of_sq_le
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp [hline s hs, pow_two]
      nlinarith [(sq_le_sq₀ (abs_nonneg s.im) hr0).2 ht, sq_abs s.im]
  calc _ ≤ ∑ s ∈ S, (ord s : ℝ) *
           ∑ i ∈ bands, if |s.im| ≤ radius i then increment i else 0 :=
            sum_le_sum fun s hs => mul_le_mul_of_nonneg_left (hcover s hs) (by positivity)
       _ = ∑ i ∈ bands, increment i * ∑ s ∈ S.filter (fun s => |s.im| ≤ radius i), (ord s:ℝ) := by
           simp_rw [mul_sum]; rw [sum_comm]; apply sum_congr rfl; intro i _
           rw [sum_filter]; apply sum_congr rfl; intro s _; split_ifs <;> ring
       _ ≤ _ := sum_le_sum fun i him => mul_le_mul_of_nonneg_left (hcount i him) (hi i him)

theorem weighted_center {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1) {T : ℝ} (S : Finset ℂ) (hS : S ⊆ zerosRect χ T)
    (hline : ∀ s ∈ S, s.re=1/2) (weight : ℂ → ℝ) (bands : Finset ℕ)
    (radius increment : ℕ → ℝ) (hr : ∀ i ∈ bands, 0 ≤ radius i ∧ radius i ≤ 9)
    (hi : ∀ i ∈ bands, 0 ≤ increment i)
    (hcover : ∀ s ∈ S, weight s ≤ ∑ i ∈ bands, if |s.im| ≤ radius i then increment i else 0) :
    ∑ s ∈ S, (multRect χ T s : ℝ)*weight s ≤
      ∑ i ∈ bands, increment i * centerCount q (radius i) :=
  weighted_center_of_count (character_count hp hχ T) S hS hline weight bands radius increment hr hi hcover

/-- The complete weighted critical-line sum, with independently chosen tail parameters. -/
theorem all_critical_zeros_of_count {q : ℕ} [NeZero q] {Z : Finset ℂ} {ord : ℂ → ℕ}
    (cnt : JensenCount q Z ord) (S : Finset ℂ) (hS : S ⊆ Z)
    (hline : ∀ s ∈ S, s.re=1/2) {z : ℂ} (hz : z ≠ 0) (ha : |z.arg| < π/2)
    {A Wp Wm Yp Ym : ℝ} (hA : 0 ≤ A)
    (hpw : 0<Wp ∧ Wp≤18 ∧ A+Wp/2≤Yp) (hmw : 0<Wm ∧ Wm≤18 ∧ A+Wm/2≤Ym)
    (I₀ : Finset ℕ) (r b : ℕ → ℝ) (hr : ∀ i ∈ I₀, 0≤r i ∧ r i≤9) (hb : ∀ i ∈ I₀, 0≤b i)
    (hcenter : ∀ s ∈ S, |s.im| ≤ A → ‖Complex.Gamma s*z^(-s)‖ ≤
      ∑ i ∈ I₀, if |s.im| ≤ r i then b i else 0) :
    ∑ s ∈ S, (ord s:ℝ)*‖Complex.Gamma s*z^(-s)‖ ≤
      (∑ i ∈ I₀, b i*centerCount q (r i)) + rayBound q z 1 A Wp Yp + rayBound q z (-1) A Wm Ym := by
  classical
  let mid := S.filter fun s => |s.im| ≤ A
  let tail := S.filter fun s => ¬ |s.im| ≤ A
  have hmid := weighted_center_of_count cnt mid ((filter_subset _ S).trans hS)
    (fun s hs => hline s (mem_filter.mp hs).1) _ I₀ r b hr hb
    (fun s hs => hcenter s (mem_filter.mp hs).1 (mem_filter.mp hs).2)
  have htail : tail ⊆ Z := (filter_subset _ S).trans hS
  have get {s : ℂ} (hs : s ∈ tail) := mem_filter.mp hs
  have hpos := critical_ray_of_count cnt (tail.filter (fun s => 0 ≤ s.im))
    ((filter_subset _ tail).trans htail) hz ha (Or.inl rfl) hA hpw.1 hpw.2.1 hpw.2.2
    (fun s hs => by
      obtain ⟨ht,hn⟩ := mem_filter.mp hs
      obtain ⟨hm,hout⟩ := get ht
      rw [abs_of_nonneg hn] at hout; exact ⟨hline s hm,by simpa using (lt_of_not_ge hout).le⟩)
  have hneg := critical_ray_of_count cnt (tail.filter (fun s => ¬ 0 ≤ s.im))
    ((filter_subset _ tail).trans htail) hz ha (Or.inr rfl) hA hmw.1 hmw.2.1 hmw.2.2
    (fun s hs => by
      obtain ⟨ht,hn⟩ := mem_filter.mp hs
      obtain ⟨hm,hout⟩ := get ht
      rw [abs_of_neg (lt_of_not_ge hn)] at hout; exact ⟨hline s hm,by simpa using (lt_of_not_ge hout).le⟩)
  let F := fun s : ℂ => (ord s:ℝ)*‖Complex.Gamma s*z^(-s)‖
  change ∑ s ∈ S, F s ≤ _
  rw [← sum_filter_add_sum_filter_not S (fun s => |s.im|≤A)]
  change (∑ s ∈ mid, F s)+(∑ s ∈ tail, F s) ≤ _
  rw [← sum_filter_add_sum_filter_not tail (fun s => 0 ≤ s.im),← add_assoc]
  exact add_le_add (add_le_add hmid hpos) hneg

theorem all_critical_zeros {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1) {T : ℝ} (S : Finset ℂ) (hS : S ⊆ zerosRect χ T)
    (hline : ∀ s ∈ S, s.re=1/2) {z : ℂ} (hz : z ≠ 0) (ha : |z.arg| < π/2)
    {A Wp Wm Yp Ym : ℝ} (hA : 0 ≤ A)
    (hpw : 0<Wp ∧ Wp≤18 ∧ A+Wp/2≤Yp) (hmw : 0<Wm ∧ Wm≤18 ∧ A+Wm/2≤Ym)
    (I₀ : Finset ℕ) (r b : ℕ → ℝ) (hr : ∀ i ∈ I₀, 0≤r i ∧ r i≤9) (hb : ∀ i ∈ I₀, 0≤b i)
    (hcenter : ∀ s ∈ S, |s.im| ≤ A → ‖Complex.Gamma s*z^(-s)‖ ≤
      ∑ i ∈ I₀, if |s.im| ≤ r i then b i else 0) :
    ∑ s ∈ S, (multRect χ T s:ℝ)*‖Complex.Gamma s*z^(-s)‖ ≤
      (∑ i ∈ I₀, b i*centerCount q (r i)) + rayBound q z 1 A Wp Yp + rayBound q z (-1) A Wm Ym :=
  all_critical_zeros_of_count (character_count hp hχ T) S hS hline hz ha hA hpw hmw I₀ r b hr hb hcenter

#print axioms all_critical_zeros
end GoldbachEnergy
