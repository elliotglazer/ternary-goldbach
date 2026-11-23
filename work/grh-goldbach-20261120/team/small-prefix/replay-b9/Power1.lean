import PrefixSource
namespace SmallGoldbach.Power1
open PrimeCoverage SmallGoldbach
set_option maxRecDepth 20000
set_option maxHeartbeats 0
def segmentsPart0 : List Segment := [⟨0, 2, 3, 0x200010000⟩]
def segments : List Segment := segmentsPart0
def bits : Nat := 0x7
theorem certifiedSource : PrimeBitmap 3 bits := by
  have h : sourceBits segments = bits := by decide +kernel
  exact h ▸ source_sound segments (by decide +kernel)
def fac : Nat := 0x6
theorem fac_eq : fac = Nat.factorial 3 := by decide +kernel
def rowsPart0 : List Row := [⟨3, 1, 0x0, 0x0⟩]
def rows : List Row := rowsPart0
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^1 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n :=
  prefix_of_rows (halo := 1) certifiedSource fac_eq rows (by decide +kernel) (by decide +kernel)
end SmallGoldbach.Power1
