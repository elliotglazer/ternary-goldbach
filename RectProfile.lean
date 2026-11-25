module

public import RectGamma
public import BoxGeometry
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def twistSize (t : ℝ) := Real.sqrt (1+(2*π*t)^2)
def twistAngle (t : ℝ) := Real.arctan (2*π*t)
def slowAngle (t : ℝ) := if t=0 then π/2 else Real.arctan (2*π*t)⁻¹

theorem slow_eq {t : ℝ} (ht : 0 ≤ t) : slowAngle t = π/2-twistAngle t := by
  unfold slowAngle twistAngle
  split
  · rename_i h; simp [h]
  · rename_i h; exact Real.arctan_inv_of_pos (mul_pos (by positivity) (lt_of_le_of_ne ht (Ne.symm h)))

theorem twistSize_pos (t : ℝ) : 0 < twistSize t := by unfold twistSize; positivity

theorem twistSize_mono {s t : ℝ} (hs : 0 ≤ s) (hst : s ≤ t) : twistSize s ≤ twistSize t := by
  apply Real.sqrt_le_sqrt
  gcongr

theorem twistAngle_mono {s t : ℝ} (hst : s ≤ t) : twistAngle s ≤ twistAngle t :=
  Real.arctan_le_arctan_iff.mpr (mul_le_mul_of_nonneg_left hst (by positivity))

def anchorY (A W d : ℝ) := max (A+W/2) (1/d)
def boxTopAt (Q m : ℕ) (h W l r : ℝ) :=
  let ds := slowAngle r
  let df := π/2+twistAngle l
  boxGammaTop Q m h W (twistAngle l) (twistAngle r) ds df (anchorY (m*h) W ds) (anchorY (m*h) W df)
def boxProfile (Q m : ℕ) (h W l r : ℝ) := boxTopAt Q m h W l r / Real.sqrt (twistSize l)

theorem choose_box_tiling {Q m : ℕ} {z : ℂ} {h W l r : ℝ}
    (hm : 0 < m) (hh : 0 < h) (hmh : m*h ≤ 9) (hw : 0 < W ∧ W ≤ 18)
    (hl : 0 ≤ l) (hr : l ≤ r) (hlo : twistAngle l ≤ |z.arg|) (hhi : |z.arg| ≤ twistAngle r)
    (hz : twistSize l ≤ ‖z‖) (htop : 0 ≤ boxTopAt Q m h W l r) :
    ∃ g : ZeroTiling, ∀ (d : ℕ) [NeZero d], d ≤ Q → gammaBudget d z g ≤ boxProfile Q m h W l r := by
  let ds := slowAngle r
  let df := π/2+twistAngle l
  let ys := anchorY (m*h) W ds
  let yf := anchorY (m*h) W df
  have ys' : m*h+W/2 ≤ ys := le_max_left _ _
  have yf' : m*h+W/2 ≤ yf := le_max_left _ _
  have hds : 0 < ds ∧ ds ≤ π/2-|z.arg| := by
    dsimp [ds]; rw [slow_eq (hl.trans hr)]
    exact ⟨sub_pos.mpr (Real.arctan_lt_pi_div_two _),sub_le_sub_left hhi _⟩
  have hal : 0 ≤ twistAngle l := Real.arctan_nonneg.mpr (by positivity)
  have hdf : 0 < df ∧ df ≤ π/2+|z.arg| := by dsimp [df]; exact ⟨by linarith [Real.pi_pos],by linarith⟩
  refine ⟨signedTiling z m h W ys yf hm hh hmh hw ys' yf',?_⟩
  intro d hd0 hd
  have g := gamma_on_box hd z hm hh hmh hw ys' yf' hlo hhi hds hdf
  apply g.trans
  exact div_le_div₀ htop le_rfl (Real.sqrt_pos.mpr (twistSize_pos l)) (Real.sqrt_le_sqrt hz)

#print axioms choose_box_tiling
end GoldbachEnergy
