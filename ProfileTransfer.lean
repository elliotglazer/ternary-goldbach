module

public import ProfileTail
public import ProfileGeometry
public import ProfileFormula
public import ProfilePositive

@[expose] public section


open Real
noncomputable section
namespace GoldbachEnergy.Profile

/-- Combine the zero budget, the two elementary errors, and the principal term. -/
theorem of_normalized {N δ c G P V : ℝ} {q : ℕ} (g : ZeroTiling)
    (hn : 2*10^19 ≤ N) (hl : 44 ≤ Real.log N) (hu : Real.log N ≤ 56)
    (hc : 30 ≤ c) (hc' : c ≤ 70) (order : minorOrder N=c^2*(Real.log N)^4)
    (hq : 0 < q) (ho : (q:ℝ) ≤ minorOrder N) (hd : |δ| ≤ N/(minorOrder N*q))
    (hg : ∀ (d : ℕ) [NeZero d], d ≤ q → gammaBudget d (twistRate δ) g ≤ G)
    (hp : Real.log N/N*minorPrincipalBudget N q δ ≤ P)
    (hV : (Real.sqrt q*Real.log N/Real.sqrt N)*G ≤ V) (total : P+0.003+V ≤ 0.315) :
    ∃ g u : ZeroTiling, twistedBudget N q δ g u+minorPrincipalBudget N q δ ≤ 0.315*N/Real.log N := by
  let L := Real.log N
  let R := Real.sqrt N
  let t := Real.sqrt q
  have hN : 0 < N := by linarith
  have hl' : 0 < L := by dsimp [L]; linarith
  have hr : 0 < R := Real.sqrt_pos.mpr hN
  have hs : R^2=N := Real.sq_sqrt hN.le
  have ht1 : 1 ≤ t := by simpa [t] using Real.sqrt_le_sqrt (show (1:ℝ) ≤ q by exact_mod_cast hq)
  have geo := geometry hN hl hc hc' order hq ho hd
  have hrem := remainder hn hl hu ht1 (abs_nonneg δ)
    (geo.1.trans (mul_le_mul_of_nonneg_right hc' (sq_nonneg _))) geo.2.2
  have hprod := (product_limit hn hl hu hq ho hd).trans (show (3000000000000000:ℝ) ≤ N by linarith only [hn])
  have twistB := twist (by linarith only [hn]) hl q hq hprod g G hg
  have hmain : t*R*G*L ≤ V*N := by
    calc _ = (t*L/R*G)*R^2 := by field_simp <;> ring
         _ ≤ V*R^2 := mul_le_mul_of_nonneg_right hV (sq_nonneg _)
         _ = _ := by rw [hs]
  have hprincipal : L*minorPrincipalBudget N q δ ≤ P*N := by
    apply (div_le_iff₀ hN).mp
    simpa only [div_mul_eq_mul_div] using hp
  refine ⟨g,tailTiling 1,?_⟩
  rw [le_div_iff₀ hl']
  nlinarith only [mul_le_mul_of_nonneg_right twistB hl'.le,hrem,hmain,hprincipal,mul_le_mul_of_nonneg_right total hN.le]

theorem on_interval {N δ a b c q₀ h W l r : ℝ} {q Q m : ℕ}
    (hn : 2*10^19 ≤ N) (hl : 44 ≤ Real.log N) (hu : Real.log N ≤ 56)
    (ha : 6 ≤ a) (haL : a ≤ Real.log N) (hb : Real.log N ≤ b)
    (hc : 30 ≤ c) (hc' : c ≤ 70) (order : minorOrder N=c^2*(Real.log N)^4)
    (hq : 0 < q) (ho : (q:ℝ) ≤ minorOrder N) (hd : |δ| ≤ N/(minorOrder N*q))
    (hq₀ : 0 < q₀ ∧ q₀ ≤ q) (hQ : q ≤ Q) (hδ : l ≤ |δ| ∧ |δ| ≤ r)
    (hlo : 0 ≤ l) (hm : 0 < m) (hh : 0 < h) (hmh : m*h ≤ 9) (hw : 0 < W ∧ W ≤ 18)
    (budget : profilePrice a b c q₀ Q m h W l r ≤ 0.315) :
    ∃ g u : ZeroTiling, twistedBudget N q δ g u+minorPrincipalBudget N q δ ≤ 0.315*N/Real.log N := by
  let z := twistRate δ
  let L := Real.log N
  let t := Real.sqrt q
  let G := boxProfile Q m h W l r
  have hN : 0 < N := by linarith
  have h0 : 0 < L := by dsimp [L]; linarith
  have hc0 : 0 < c := by linarith
  have ha0 : 0 < a := by linarith
  letI : NeZero Q := ⟨(hq.trans_le hQ).ne'⟩
  have hrl := hδ.1.trans hδ.2
  have top := top_nonneg_on_box Q m hh.le hmh hw hlo (hlo.trans hrl)
  have hG : 0 ≤ G := div_nonneg top (Real.sqrt_nonneg _)
  have hnz : ‖z‖=twistSize |δ| := twist_norm_exact δ
  have hθ : |z.arg|=twistAngle |δ| := twist_angle_exact δ
  have hz : twistSize l ≤ ‖z‖ := hnz ▸ twistSize_mono hlo hδ.1
  obtain ⟨g,hg⟩ := choose_box_tiling hm hh hmh hw hlo hrl
    (hθ ▸ twistAngle_mono hδ.1) (hθ ▸ twistAngle_mono hδ.2) hz top
  have pc : minorConstant N ≤ 0.096 := by unfold minorConstant; split <;> norm_num
  have hp := principal_on_box (q:=q) (δ:=δ) hq (by linarith only [hn]) hb pc (twistSize_pos l) hz hq₀.1 hq₀.2
  have geo := geometry hN hl hc hc' order hq ho hd
  let k := min (c*a^3) (Real.sqrt Q*a)/Real.exp (a/2)
  let f := if l=0 then k else min k (1/(c*a*Real.sqrt l))
  have hhead : t*L/Real.sqrt N ≤ k := head_factor hN rfl ha haL hc0 geo.1 (Real.sqrt_le_sqrt (by exact_mod_cast hQ))
  have hmult : t*L/Real.sqrt N ≤ f := by
    dsimp only [f]; split
    · exact hhead
    · rename_i he
      have hsmall := mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt hδ.1) (Real.sqrt_nonneg (q:ℝ))
      have rad := (mul_le_mul_of_nonneg_right hsmall (show 0 ≤ c*L^2 by positivity)).trans geo.2.1
      exact le_min hhead ((profile_multiplier hN rfl ha haL hc0 (Real.sqrt_nonneg _) (Real.sqrt_pos.mpr (lt_of_le_of_ne hlo (Ne.symm he))) geo.1 rad).trans (min_le_right _ _))
  exact of_normalized g hn hl hu hc hc' order hq ho hd (fun d _ h => hg d (h.trans hQ))
    hp (mul_le_mul_of_nonneg_right hmult hG) budget

#print axioms of_normalized
#print axioms on_interval
end GoldbachEnergy.Profile
