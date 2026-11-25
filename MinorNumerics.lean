module

public import RationalCoordinates
public import LowerRatio
public import ArcSeparation

@[expose] public section


open Real TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

def minorOrder (N : ℝ) := (if N < 10^20 then 900 else 4900)*(Real.log N)^4
def minorConstant (N : ℝ) := if N < 10^20 then (0.096:ℝ) else 0.088

theorem lower_principal_on_minor {N α : ℝ} (hn : 2*10^19 ≤ N)
    (hα : α ∈ minorArcs N) (r : ℚ) :
    ‖principalWave N r.den (α-r)‖ ≤ minorConstant N*N/Real.log N := by
  unfold minorConstant; split
  · have hn1 : 1<N := lt_of_lt_of_le (by norm_num) hn
    have hn0 : 0<N := lt_trans zero_lt_one hn1
    have hl := Real.log_pos hn1
    by_cases hq : (r.den:ℝ) ≤ modulusCutoff N
    · exact (principal_small_q hn1 hα.2 hq).trans
        (div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_right (by norm_num) hn0.le) hl.le)
    · have hratio := lower_principal_ratio hn r.den (lt_of_not_ge hq)
      have hφ : (0:ℝ)<r.den.totient := by exact_mod_cast Nat.totient_pos.mpr r.pos
      rw [div_lt_iff₀ hφ] at hratio
      apply (norm_principal N _ _ hn0 r.pos).trans
      rw [le_div_iff₀ hl,div_mul_eq_mul_div,div_le_iff₀ hφ]
      nlinarith only [mul_le_mul_of_nonneg_left hratio.le hn0.le]
  · exact principal_on_minor (by linarith) hα r

theorem norm_principal_twist {N : ℝ} (hn : 0<N) {q : ℕ} (hq : 0<q) (β : ℝ) :
    ‖principalWave N q β‖ ≤ (N/q.totient)/‖twistRate (N*β)‖ := by
  have hpos : 0 < ‖twistRate (N*β)‖ := by
    apply norm_pos_iff.mpr; intro h; have hr := congrArg Complex.re h; simp [twistRate] at hr
  apply norm_principal_of_den hq hn hpos
  have hv : twistRate (N*β) = (((1/N:ℝ):ℂ)-((2*π*β:ℝ):ℂ)*Complex.I)*(N:ℂ) := by
    unfold twistRate; push_cast; field_simp [show (N:ℂ) ≠ 0 by exact_mod_cast hn.ne']
  rw [hv,norm_mul,Complex.norm_real,Real.norm_eq_abs,abs_of_pos hn,mul_div_cancel_right₀ _ hn.ne']

def minorPrincipalBudget (N : ℝ) (q : ℕ) (δ : ℝ) :=
  min (minorConstant N*N/Real.log N) ((N/q.totient)/‖twistRate δ‖)

def MinorBudgetAt (N : ℝ) : Prop :=
  ∀ q : ℕ, 0<q → (q:ℝ) ≤ minorOrder N → ∀ δ : ℝ, |δ| ≤ N/(minorOrder N*q) →
    ∃ g u : ZeroTiling, twistedBudget N q δ g u + minorPrincipalBudget N q δ ≤ 0.315*N/Real.log N

theorem minor_of_numeric (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {N : ℝ} (hn : 2*10^19 ≤ N) (hnum : MinorBudgetAt N) :
    ∀ α ∈ minorArcs N, ‖wave N α‖ ≤ 0.315*N/Real.log N := by
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hL := log_two_e19 hn
  have h4 := pow_le_pow_left₀ (by norm_num : (0:ℝ)≤44) hL 4
  have ht : 1 ≤ minorOrder N := by unfold minorOrder; split <;> linarith
  intro α hα
  obtain ⟨r,hq,hβ⟩ := rational_cover (x := α) ht
  let β := α-(r:ℝ)
  have hd : |N*β| ≤ N/(minorOrder N*r.den) := by
    rw [abs_mul,abs_of_pos hn0]
    simpa only [mul_one_div] using mul_le_mul_of_nonneg_left hβ hn0.le
  obtain ⟨g,u,hu⟩ := hnum r.den r.pos hq _ hd
  have h := error_at_rational rh grh (le_trans (by norm_num) hn : 1≤N) r β g u
  rw [show (r:ℝ)+β=α by dsimp [β]; ring] at h
  have hp : ‖principalWave N r.den β‖ ≤ minorPrincipalBudget N r.den (N*β) :=
    le_min (lower_principal_on_minor hn hα r) (norm_principal_twist hn0 r.pos β)
  have htri := norm_add_le (wave N α-principalWave N r.den β) (principalWave N r.den β)
  rw [sub_add_cancel] at htri
  exact htri.trans ((add_le_add h hp).trans hu)

#print axioms minor_of_numeric
end GoldbachEnergy
