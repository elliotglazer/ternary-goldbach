import PrefixSource
namespace SmallGoldbach.Power2
open PrimeCoverage SmallGoldbach
set_option maxRecDepth 20000
set_option maxHeartbeats 0
def segmentsPart0 : List Segment := [⟨0, 2, 3, 0x200010000⟩,
  ⟨3, 8, 18, 0x230020001f001d001a00190016001300110010000e000b000a00070005000400020001⟩,
  ⟨39, 12, 12, 0x1d001c001900170010000e000d000b000a000800040001⟩]
def segments : List Segment := segmentsPart0
def bits : Nat := 0x1940b6894d325a65b7
theorem certifiedSource : PrimeBitmap 3 bits := by
  have h : sourceBits segments = bits := by decide +kernel
  exact h ▸ source_sound segments (by decide +kernel)
def fac : Nat := 0x375f00
theorem fac_eq : fac = Nat.factorial 10 := by decide +kernel
def rowsPart0 : List Row := [⟨48, 4, 0x8000200010000, 0x0⟩]
def rows : List Row := rowsPart0
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^2 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n :=
  prefix_of_rows (halo := 24) certifiedSource fac_eq rows (by decide +kernel) (by decide +kernel)
end SmallGoldbach.Power2
