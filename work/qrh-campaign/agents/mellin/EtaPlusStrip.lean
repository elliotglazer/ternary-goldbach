import TernaryGoldbach.Explicit.QrhMellin
import TernaryGoldbach.Explicit.EtaPlusMellin

namespace TernaryGoldbach.Explicit

/-- The modulated etaPlus Mellin transform is uniformly bounded throughout the QRH strip. -/
theorem norm_mellin_fP_qrh_strip (δ : ℝ) {s : ℂ}
    (ha : 1 / 8 ≤ s.re) (hb : s.re ≤ 7 / 8) :
    ‖mellin (fP δ) s‖ < 4.72 := by
  have h := TernaryGoldbach.QRH.norm_mellin_lt_of_gaussian_envelope
    (f := fP δ) (fun v hv => norm_fP_le hv.le) (s := s)
    (by linarith) (by linarith)
  linarith

end TernaryGoldbach.Explicit

