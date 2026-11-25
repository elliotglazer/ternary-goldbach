module

public import Budget

@[expose] public section

open Real
namespace GoldbachEnergy
namespace LowerDenominators
private theorem step {p m u w v : Nat} (hp : p.Prime) (he : p*m=u) (hm : m.totient=w)
    (hv : timesPhi p m w = v) : u.totient = v := by
  rw [← he, ← timesPhi_eq hp, hm, hv]
private theorem phi1 : Nat.totient 1=1 := Nat.totient_one
private def Covered (lo hi : ℕ) := ∀ k, lo ≤ k → k < hi → 99*k < k.totient^2
private theorem one {i : ℕ} (h : 99*i < i.totient^2) : Covered i (i+1) := by
  intro j hlo hhi; have e : j=i := by omega
  exact e ▸ h
private theorem join {a b c : ℕ} (h : Covered a b) (h' : Covered b c) : Covered a c := by
  intro j hlo hhi; by_cases hj : j < b
  · exact h j hlo hj
  · exact h' j (by omega) hhi
private theorem phi7 : Nat.totient 7 = 6 := step (p := 7) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi35 : Nat.totient 35 = 24 := step (p := 5) (m := 7) (by decide +kernel) (by decide) phi7 (by decide +kernel)
private theorem phi175 : Nat.totient 175 = 120 := step (p := 5) (m := 35) (by decide +kernel) (by decide) phi35 (by decide +kernel)
private theorem phi525 : Nat.totient 525 = 240 := step (p := 3) (m := 175) (by decide +kernel) (by decide) phi175 (by decide +kernel)
private theorem phi1050 : Nat.totient 1050 = 240 := step (p := 2) (m := 525) (by decide +kernel) (by decide) phi525 (by decide +kernel)
private theorem phi2100 : Nat.totient 2100 = 480 := step (p := 2) (m := 1050) (by decide +kernel) (by decide) phi1050 (by decide +kernel)
private theorem c2100 : Covered 2100 2101 := one (i := 2100) (by rw [phi2100]; decide)
private theorem phi191 : Nat.totient 191 = 190 := step (p := 191) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2101 : Nat.totient 2101 = 1900 := step (p := 11) (m := 191) (by decide +kernel) (by decide) phi191 (by decide +kernel)
private theorem c2101 : Covered 2101 2102 := one (i := 2101) (by rw [phi2101]; decide)
private theorem phi1051 : Nat.totient 1051 = 1050 := step (p := 1051) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2102 : Nat.totient 2102 = 1050 := step (p := 2) (m := 1051) (by decide +kernel) (by decide) phi1051 (by decide +kernel)
private theorem c2102 : Covered 2102 2103 := one (i := 2102) (by rw [phi2102]; decide)
private theorem j2101x2103 : Covered 2101 2103 := join c2101 c2102
private theorem j2100x2103 : Covered 2100 2103 := join c2100 j2101x2103
private theorem phi701 : Nat.totient 701 = 700 := step (p := 701) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2103 : Nat.totient 2103 = 1400 := step (p := 3) (m := 701) (by decide +kernel) (by decide) phi701 (by decide +kernel)
private theorem c2103 : Covered 2103 2104 := one (i := 2103) (by rw [phi2103]; decide)
private theorem phi263 : Nat.totient 263 = 262 := step (p := 263) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi526 : Nat.totient 526 = 262 := step (p := 2) (m := 263) (by decide +kernel) (by decide) phi263 (by decide +kernel)
private theorem phi1052 : Nat.totient 1052 = 524 := step (p := 2) (m := 526) (by decide +kernel) (by decide) phi526 (by decide +kernel)
private theorem phi2104 : Nat.totient 2104 = 1048 := step (p := 2) (m := 1052) (by decide +kernel) (by decide) phi1052 (by decide +kernel)
private theorem c2104 : Covered 2104 2105 := one (i := 2104) (by rw [phi2104]; decide)
private theorem j2103x2105 : Covered 2103 2105 := join c2103 c2104
private theorem phi421 : Nat.totient 421 = 420 := step (p := 421) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2105 : Nat.totient 2105 = 1680 := step (p := 5) (m := 421) (by decide +kernel) (by decide) phi421 (by decide +kernel)
private theorem c2105 : Covered 2105 2106 := one (i := 2105) (by rw [phi2105]; decide)
private theorem phi13 : Nat.totient 13 = 12 := step (p := 13) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi39 : Nat.totient 39 = 24 := step (p := 3) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi117 : Nat.totient 117 = 72 := step (p := 3) (m := 39) (by decide +kernel) (by decide) phi39 (by decide +kernel)
private theorem phi351 : Nat.totient 351 = 216 := step (p := 3) (m := 117) (by decide +kernel) (by decide) phi117 (by decide +kernel)
private theorem phi1053 : Nat.totient 1053 = 648 := step (p := 3) (m := 351) (by decide +kernel) (by decide) phi351 (by decide +kernel)
private theorem phi2106 : Nat.totient 2106 = 648 := step (p := 2) (m := 1053) (by decide +kernel) (by decide) phi1053 (by decide +kernel)
private theorem c2106 : Covered 2106 2107 := one (i := 2106) (by rw [phi2106]; decide)
private theorem j2105x2107 : Covered 2105 2107 := join c2105 c2106
private theorem j2103x2107 : Covered 2103 2107 := join j2103x2105 j2105x2107
private theorem j2100x2107 : Covered 2100 2107 := join j2100x2103 j2103x2107
private theorem phi43 : Nat.totient 43 = 42 := step (p := 43) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi301 : Nat.totient 301 = 252 := step (p := 7) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi2107 : Nat.totient 2107 = 1764 := step (p := 7) (m := 301) (by decide +kernel) (by decide) phi301 (by decide +kernel)
private theorem c2107 : Covered 2107 2108 := one (i := 2107) (by rw [phi2107]; decide)
private theorem phi31 : Nat.totient 31 = 30 := step (p := 31) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi527 : Nat.totient 527 = 480 := step (p := 17) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi1054 : Nat.totient 1054 = 480 := step (p := 2) (m := 527) (by decide +kernel) (by decide) phi527 (by decide +kernel)
private theorem phi2108 : Nat.totient 2108 = 960 := step (p := 2) (m := 1054) (by decide +kernel) (by decide) phi1054 (by decide +kernel)
private theorem c2108 : Covered 2108 2109 := one (i := 2108) (by rw [phi2108]; decide)
private theorem phi37 : Nat.totient 37 = 36 := step (p := 37) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi703 : Nat.totient 703 = 648 := step (p := 19) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi2109 : Nat.totient 2109 = 1296 := step (p := 3) (m := 703) (by decide +kernel) (by decide) phi703 (by decide +kernel)
private theorem c2109 : Covered 2109 2110 := one (i := 2109) (by rw [phi2109]; decide)
private theorem j2108x2110 : Covered 2108 2110 := join c2108 c2109
private theorem j2107x2110 : Covered 2107 2110 := join c2107 j2108x2110
private theorem phi211 : Nat.totient 211 = 210 := step (p := 211) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1055 : Nat.totient 1055 = 840 := step (p := 5) (m := 211) (by decide +kernel) (by decide) phi211 (by decide +kernel)
private theorem phi2110 : Nat.totient 2110 = 840 := step (p := 2) (m := 1055) (by decide +kernel) (by decide) phi1055 (by decide +kernel)
private theorem c2110 : Covered 2110 2111 := one (i := 2110) (by rw [phi2110]; decide)
private theorem phi2111 : Nat.totient 2111 = 2110 := step (p := 2111) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2111 : Covered 2111 2112 := one (i := 2111) (by rw [phi2111]; decide)
private theorem j2110x2112 : Covered 2110 2112 := join c2110 c2111
private theorem phi11 : Nat.totient 11 = 10 := step (p := 11) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi33 : Nat.totient 33 = 20 := step (p := 3) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem phi66 : Nat.totient 66 = 20 := step (p := 2) (m := 33) (by decide +kernel) (by decide) phi33 (by decide +kernel)
private theorem phi132 : Nat.totient 132 = 40 := step (p := 2) (m := 66) (by decide +kernel) (by decide) phi66 (by decide +kernel)
private theorem phi264 : Nat.totient 264 = 80 := step (p := 2) (m := 132) (by decide +kernel) (by decide) phi132 (by decide +kernel)
private theorem phi528 : Nat.totient 528 = 160 := step (p := 2) (m := 264) (by decide +kernel) (by decide) phi264 (by decide +kernel)
private theorem phi1056 : Nat.totient 1056 = 320 := step (p := 2) (m := 528) (by decide +kernel) (by decide) phi528 (by decide +kernel)
private theorem phi2112 : Nat.totient 2112 = 640 := step (p := 2) (m := 1056) (by decide +kernel) (by decide) phi1056 (by decide +kernel)
private theorem c2112 : Covered 2112 2113 := one (i := 2112) (by rw [phi2112]; decide)
private theorem phi2113 : Nat.totient 2113 = 2112 := step (p := 2113) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2113 : Covered 2113 2114 := one (i := 2113) (by rw [phi2113]; decide)
private theorem j2112x2114 : Covered 2112 2114 := join c2112 c2113
private theorem j2110x2114 : Covered 2110 2114 := join j2110x2112 j2112x2114
private theorem j2107x2114 : Covered 2107 2114 := join j2107x2110 j2110x2114
private theorem j2100x2114 : Covered 2100 2114 := join j2100x2107 j2107x2114
private theorem phi151 : Nat.totient 151 = 150 := step (p := 151) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1057 : Nat.totient 1057 = 900 := step (p := 7) (m := 151) (by decide +kernel) (by decide) phi151 (by decide +kernel)
private theorem phi2114 : Nat.totient 2114 = 900 := step (p := 2) (m := 1057) (by decide +kernel) (by decide) phi1057 (by decide +kernel)
private theorem c2114 : Covered 2114 2115 := one (i := 2114) (by rw [phi2114]; decide)
private theorem phi47 : Nat.totient 47 = 46 := step (p := 47) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi235 : Nat.totient 235 = 184 := step (p := 5) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi705 : Nat.totient 705 = 368 := step (p := 3) (m := 235) (by decide +kernel) (by decide) phi235 (by decide +kernel)
private theorem phi2115 : Nat.totient 2115 = 1104 := step (p := 3) (m := 705) (by decide +kernel) (by decide) phi705 (by decide +kernel)
private theorem c2115 : Covered 2115 2116 := one (i := 2115) (by rw [phi2115]; decide)
private theorem phi23 : Nat.totient 23 = 22 := step (p := 23) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi529 : Nat.totient 529 = 506 := step (p := 23) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi1058 : Nat.totient 1058 = 506 := step (p := 2) (m := 529) (by decide +kernel) (by decide) phi529 (by decide +kernel)
private theorem phi2116 : Nat.totient 2116 = 1012 := step (p := 2) (m := 1058) (by decide +kernel) (by decide) phi1058 (by decide +kernel)
private theorem c2116 : Covered 2116 2117 := one (i := 2116) (by rw [phi2116]; decide)
private theorem j2115x2117 : Covered 2115 2117 := join c2115 c2116
private theorem j2114x2117 : Covered 2114 2117 := join c2114 j2115x2117
private theorem phi73 : Nat.totient 73 = 72 := step (p := 73) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2117 : Nat.totient 2117 = 2016 := step (p := 29) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem c2117 : Covered 2117 2118 := one (i := 2117) (by rw [phi2117]; decide)
private theorem phi353 : Nat.totient 353 = 352 := step (p := 353) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1059 : Nat.totient 1059 = 704 := step (p := 3) (m := 353) (by decide +kernel) (by decide) phi353 (by decide +kernel)
private theorem phi2118 : Nat.totient 2118 = 704 := step (p := 2) (m := 1059) (by decide +kernel) (by decide) phi1059 (by decide +kernel)
private theorem c2118 : Covered 2118 2119 := one (i := 2118) (by rw [phi2118]; decide)
private theorem j2117x2119 : Covered 2117 2119 := join c2117 c2118
private theorem phi163 : Nat.totient 163 = 162 := step (p := 163) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2119 : Nat.totient 2119 = 1944 := step (p := 13) (m := 163) (by decide +kernel) (by decide) phi163 (by decide +kernel)
private theorem c2119 : Covered 2119 2120 := one (i := 2119) (by rw [phi2119]; decide)
private theorem phi53 : Nat.totient 53 = 52 := step (p := 53) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi265 : Nat.totient 265 = 208 := step (p := 5) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi530 : Nat.totient 530 = 208 := step (p := 2) (m := 265) (by decide +kernel) (by decide) phi265 (by decide +kernel)
private theorem phi1060 : Nat.totient 1060 = 416 := step (p := 2) (m := 530) (by decide +kernel) (by decide) phi530 (by decide +kernel)
private theorem phi2120 : Nat.totient 2120 = 832 := step (p := 2) (m := 1060) (by decide +kernel) (by decide) phi1060 (by decide +kernel)
private theorem c2120 : Covered 2120 2121 := one (i := 2120) (by rw [phi2120]; decide)
private theorem j2119x2121 : Covered 2119 2121 := join c2119 c2120
private theorem j2117x2121 : Covered 2117 2121 := join j2117x2119 j2119x2121
private theorem j2114x2121 : Covered 2114 2121 := join j2114x2117 j2117x2121
private theorem phi101 : Nat.totient 101 = 100 := step (p := 101) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi707 : Nat.totient 707 = 600 := step (p := 7) (m := 101) (by decide +kernel) (by decide) phi101 (by decide +kernel)
private theorem phi2121 : Nat.totient 2121 = 1200 := step (p := 3) (m := 707) (by decide +kernel) (by decide) phi707 (by decide +kernel)
private theorem c2121 : Covered 2121 2122 := one (i := 2121) (by rw [phi2121]; decide)
private theorem phi1061 : Nat.totient 1061 = 1060 := step (p := 1061) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2122 : Nat.totient 2122 = 1060 := step (p := 2) (m := 1061) (by decide +kernel) (by decide) phi1061 (by decide +kernel)
private theorem c2122 : Covered 2122 2123 := one (i := 2122) (by rw [phi2122]; decide)
private theorem phi193 : Nat.totient 193 = 192 := step (p := 193) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2123 : Nat.totient 2123 = 1920 := step (p := 11) (m := 193) (by decide +kernel) (by decide) phi193 (by decide +kernel)
private theorem c2123 : Covered 2123 2124 := one (i := 2123) (by rw [phi2123]; decide)
private theorem j2122x2124 : Covered 2122 2124 := join c2122 c2123
private theorem j2121x2124 : Covered 2121 2124 := join c2121 j2122x2124
private theorem phi59 : Nat.totient 59 = 58 := step (p := 59) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi177 : Nat.totient 177 = 116 := step (p := 3) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi531 : Nat.totient 531 = 348 := step (p := 3) (m := 177) (by decide +kernel) (by decide) phi177 (by decide +kernel)
private theorem phi1062 : Nat.totient 1062 = 348 := step (p := 2) (m := 531) (by decide +kernel) (by decide) phi531 (by decide +kernel)
private theorem phi2124 : Nat.totient 2124 = 696 := step (p := 2) (m := 1062) (by decide +kernel) (by decide) phi1062 (by decide +kernel)
private theorem c2124 : Covered 2124 2125 := one (i := 2124) (by rw [phi2124]; decide)
private theorem phi17 : Nat.totient 17 = 16 := step (p := 17) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi85 : Nat.totient 85 = 64 := step (p := 5) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi425 : Nat.totient 425 = 320 := step (p := 5) (m := 85) (by decide +kernel) (by decide) phi85 (by decide +kernel)
private theorem phi2125 : Nat.totient 2125 = 1600 := step (p := 5) (m := 425) (by decide +kernel) (by decide) phi425 (by decide +kernel)
private theorem c2125 : Covered 2125 2126 := one (i := 2125) (by rw [phi2125]; decide)
private theorem j2124x2126 : Covered 2124 2126 := join c2124 c2125
private theorem phi1063 : Nat.totient 1063 = 1062 := step (p := 1063) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2126 : Nat.totient 2126 = 1062 := step (p := 2) (m := 1063) (by decide +kernel) (by decide) phi1063 (by decide +kernel)
private theorem c2126 : Covered 2126 2127 := one (i := 2126) (by rw [phi2126]; decide)
private theorem phi709 : Nat.totient 709 = 708 := step (p := 709) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2127 : Nat.totient 2127 = 1416 := step (p := 3) (m := 709) (by decide +kernel) (by decide) phi709 (by decide +kernel)
private theorem c2127 : Covered 2127 2128 := one (i := 2127) (by rw [phi2127]; decide)
private theorem j2126x2128 : Covered 2126 2128 := join c2126 c2127
private theorem j2124x2128 : Covered 2124 2128 := join j2124x2126 j2126x2128
private theorem j2121x2128 : Covered 2121 2128 := join j2121x2124 j2124x2128
private theorem j2114x2128 : Covered 2114 2128 := join j2114x2121 j2121x2128
private theorem j2100x2128 : Covered 2100 2128 := join j2100x2114 j2114x2128
private theorem phi19 : Nat.totient 19 = 18 := step (p := 19) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi133 : Nat.totient 133 = 108 := step (p := 7) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi266 : Nat.totient 266 = 108 := step (p := 2) (m := 133) (by decide +kernel) (by decide) phi133 (by decide +kernel)
private theorem phi532 : Nat.totient 532 = 216 := step (p := 2) (m := 266) (by decide +kernel) (by decide) phi266 (by decide +kernel)
private theorem phi1064 : Nat.totient 1064 = 432 := step (p := 2) (m := 532) (by decide +kernel) (by decide) phi532 (by decide +kernel)
private theorem phi2128 : Nat.totient 2128 = 864 := step (p := 2) (m := 1064) (by decide +kernel) (by decide) phi1064 (by decide +kernel)
private theorem c2128 : Covered 2128 2129 := one (i := 2128) (by rw [phi2128]; decide)
private theorem phi2129 : Nat.totient 2129 = 2128 := step (p := 2129) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2129 : Covered 2129 2130 := one (i := 2129) (by rw [phi2129]; decide)
private theorem phi71 : Nat.totient 71 = 70 := step (p := 71) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi355 : Nat.totient 355 = 280 := step (p := 5) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem phi1065 : Nat.totient 1065 = 560 := step (p := 3) (m := 355) (by decide +kernel) (by decide) phi355 (by decide +kernel)
private theorem phi2130 : Nat.totient 2130 = 560 := step (p := 2) (m := 1065) (by decide +kernel) (by decide) phi1065 (by decide +kernel)
private theorem c2130 : Covered 2130 2131 := one (i := 2130) (by rw [phi2130]; decide)
private theorem j2129x2131 : Covered 2129 2131 := join c2129 c2130
private theorem j2128x2131 : Covered 2128 2131 := join c2128 j2129x2131
private theorem phi2131 : Nat.totient 2131 = 2130 := step (p := 2131) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2131 : Covered 2131 2132 := one (i := 2131) (by rw [phi2131]; decide)
private theorem phi41 : Nat.totient 41 = 40 := step (p := 41) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi533 : Nat.totient 533 = 480 := step (p := 13) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi1066 : Nat.totient 1066 = 480 := step (p := 2) (m := 533) (by decide +kernel) (by decide) phi533 (by decide +kernel)
private theorem phi2132 : Nat.totient 2132 = 960 := step (p := 2) (m := 1066) (by decide +kernel) (by decide) phi1066 (by decide +kernel)
private theorem c2132 : Covered 2132 2133 := one (i := 2132) (by rw [phi2132]; decide)
private theorem j2131x2133 : Covered 2131 2133 := join c2131 c2132
private theorem phi79 : Nat.totient 79 = 78 := step (p := 79) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi237 : Nat.totient 237 = 156 := step (p := 3) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem phi711 : Nat.totient 711 = 468 := step (p := 3) (m := 237) (by decide +kernel) (by decide) phi237 (by decide +kernel)
private theorem phi2133 : Nat.totient 2133 = 1404 := step (p := 3) (m := 711) (by decide +kernel) (by decide) phi711 (by decide +kernel)
private theorem c2133 : Covered 2133 2134 := one (i := 2133) (by rw [phi2133]; decide)
private theorem phi97 : Nat.totient 97 = 96 := step (p := 97) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1067 : Nat.totient 1067 = 960 := step (p := 11) (m := 97) (by decide +kernel) (by decide) phi97 (by decide +kernel)
private theorem phi2134 : Nat.totient 2134 = 960 := step (p := 2) (m := 1067) (by decide +kernel) (by decide) phi1067 (by decide +kernel)
private theorem c2134 : Covered 2134 2135 := one (i := 2134) (by rw [phi2134]; decide)
private theorem j2133x2135 : Covered 2133 2135 := join c2133 c2134
private theorem j2131x2135 : Covered 2131 2135 := join j2131x2133 j2133x2135
private theorem j2128x2135 : Covered 2128 2135 := join j2128x2131 j2131x2135
private theorem phi61 : Nat.totient 61 = 60 := step (p := 61) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi427 : Nat.totient 427 = 360 := step (p := 7) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi2135 : Nat.totient 2135 = 1440 := step (p := 5) (m := 427) (by decide +kernel) (by decide) phi427 (by decide +kernel)
private theorem c2135 : Covered 2135 2136 := one (i := 2135) (by rw [phi2135]; decide)
private theorem phi89 : Nat.totient 89 = 88 := step (p := 89) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi267 : Nat.totient 267 = 176 := step (p := 3) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem phi534 : Nat.totient 534 = 176 := step (p := 2) (m := 267) (by decide +kernel) (by decide) phi267 (by decide +kernel)
private theorem phi1068 : Nat.totient 1068 = 352 := step (p := 2) (m := 534) (by decide +kernel) (by decide) phi534 (by decide +kernel)
private theorem phi2136 : Nat.totient 2136 = 704 := step (p := 2) (m := 1068) (by decide +kernel) (by decide) phi1068 (by decide +kernel)
private theorem c2136 : Covered 2136 2137 := one (i := 2136) (by rw [phi2136]; decide)
private theorem phi2137 : Nat.totient 2137 = 2136 := step (p := 2137) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2137 : Covered 2137 2138 := one (i := 2137) (by rw [phi2137]; decide)
private theorem j2136x2138 : Covered 2136 2138 := join c2136 c2137
private theorem j2135x2138 : Covered 2135 2138 := join c2135 j2136x2138
private theorem phi1069 : Nat.totient 1069 = 1068 := step (p := 1069) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2138 : Nat.totient 2138 = 1068 := step (p := 2) (m := 1069) (by decide +kernel) (by decide) phi1069 (by decide +kernel)
private theorem c2138 : Covered 2138 2139 := one (i := 2138) (by rw [phi2138]; decide)
private theorem phi713 : Nat.totient 713 = 660 := step (p := 23) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi2139 : Nat.totient 2139 = 1320 := step (p := 3) (m := 713) (by decide +kernel) (by decide) phi713 (by decide +kernel)
private theorem c2139 : Covered 2139 2140 := one (i := 2139) (by rw [phi2139]; decide)
private theorem j2138x2140 : Covered 2138 2140 := join c2138 c2139
private theorem phi107 : Nat.totient 107 = 106 := step (p := 107) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi535 : Nat.totient 535 = 424 := step (p := 5) (m := 107) (by decide +kernel) (by decide) phi107 (by decide +kernel)
private theorem phi1070 : Nat.totient 1070 = 424 := step (p := 2) (m := 535) (by decide +kernel) (by decide) phi535 (by decide +kernel)
private theorem phi2140 : Nat.totient 2140 = 848 := step (p := 2) (m := 1070) (by decide +kernel) (by decide) phi1070 (by decide +kernel)
private theorem c2140 : Covered 2140 2141 := one (i := 2140) (by rw [phi2140]; decide)
private theorem phi2141 : Nat.totient 2141 = 2140 := step (p := 2141) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2141 : Covered 2141 2142 := one (i := 2141) (by rw [phi2141]; decide)
private theorem j2140x2142 : Covered 2140 2142 := join c2140 c2141
private theorem j2138x2142 : Covered 2138 2142 := join j2138x2140 j2140x2142
private theorem j2135x2142 : Covered 2135 2142 := join j2135x2138 j2138x2142
private theorem j2128x2142 : Covered 2128 2142 := join j2128x2135 j2135x2142
private theorem phi119 : Nat.totient 119 = 96 := step (p := 7) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi357 : Nat.totient 357 = 192 := step (p := 3) (m := 119) (by decide +kernel) (by decide) phi119 (by decide +kernel)
private theorem phi1071 : Nat.totient 1071 = 576 := step (p := 3) (m := 357) (by decide +kernel) (by decide) phi357 (by decide +kernel)
private theorem phi2142 : Nat.totient 2142 = 576 := step (p := 2) (m := 1071) (by decide +kernel) (by decide) phi1071 (by decide +kernel)
private theorem c2142 : Covered 2142 2143 := one (i := 2142) (by rw [phi2142]; decide)
private theorem phi2143 : Nat.totient 2143 = 2142 := step (p := 2143) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2143 : Covered 2143 2144 := one (i := 2143) (by rw [phi2143]; decide)
private theorem phi67 : Nat.totient 67 = 66 := step (p := 67) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi134 : Nat.totient 134 = 66 := step (p := 2) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi268 : Nat.totient 268 = 132 := step (p := 2) (m := 134) (by decide +kernel) (by decide) phi134 (by decide +kernel)
private theorem phi536 : Nat.totient 536 = 264 := step (p := 2) (m := 268) (by decide +kernel) (by decide) phi268 (by decide +kernel)
private theorem phi1072 : Nat.totient 1072 = 528 := step (p := 2) (m := 536) (by decide +kernel) (by decide) phi536 (by decide +kernel)
private theorem phi2144 : Nat.totient 2144 = 1056 := step (p := 2) (m := 1072) (by decide +kernel) (by decide) phi1072 (by decide +kernel)
private theorem c2144 : Covered 2144 2145 := one (i := 2144) (by rw [phi2144]; decide)
private theorem j2143x2145 : Covered 2143 2145 := join c2143 c2144
private theorem j2142x2145 : Covered 2142 2145 := join c2142 j2143x2145
private theorem phi143 : Nat.totient 143 = 120 := step (p := 11) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi715 : Nat.totient 715 = 480 := step (p := 5) (m := 143) (by decide +kernel) (by decide) phi143 (by decide +kernel)
private theorem phi2145 : Nat.totient 2145 = 960 := step (p := 3) (m := 715) (by decide +kernel) (by decide) phi715 (by decide +kernel)
private theorem c2145 : Covered 2145 2146 := one (i := 2145) (by rw [phi2145]; decide)
private theorem phi1073 : Nat.totient 1073 = 1008 := step (p := 29) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi2146 : Nat.totient 2146 = 1008 := step (p := 2) (m := 1073) (by decide +kernel) (by decide) phi1073 (by decide +kernel)
private theorem c2146 : Covered 2146 2147 := one (i := 2146) (by rw [phi2146]; decide)
private theorem j2145x2147 : Covered 2145 2147 := join c2145 c2146
private theorem phi113 : Nat.totient 113 = 112 := step (p := 113) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2147 : Nat.totient 2147 = 2016 := step (p := 19) (m := 113) (by decide +kernel) (by decide) phi113 (by decide +kernel)
private theorem c2147 : Covered 2147 2148 := one (i := 2147) (by rw [phi2147]; decide)
private theorem phi179 : Nat.totient 179 = 178 := step (p := 179) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi537 : Nat.totient 537 = 356 := step (p := 3) (m := 179) (by decide +kernel) (by decide) phi179 (by decide +kernel)
private theorem phi1074 : Nat.totient 1074 = 356 := step (p := 2) (m := 537) (by decide +kernel) (by decide) phi537 (by decide +kernel)
private theorem phi2148 : Nat.totient 2148 = 712 := step (p := 2) (m := 1074) (by decide +kernel) (by decide) phi1074 (by decide +kernel)
private theorem c2148 : Covered 2148 2149 := one (i := 2148) (by rw [phi2148]; decide)
private theorem j2147x2149 : Covered 2147 2149 := join c2147 c2148
private theorem j2145x2149 : Covered 2145 2149 := join j2145x2147 j2147x2149
private theorem j2142x2149 : Covered 2142 2149 := join j2142x2145 j2145x2149
private theorem phi307 : Nat.totient 307 = 306 := step (p := 307) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2149 : Nat.totient 2149 = 1836 := step (p := 7) (m := 307) (by decide +kernel) (by decide) phi307 (by decide +kernel)
private theorem c2149 : Covered 2149 2150 := one (i := 2149) (by rw [phi2149]; decide)
private theorem phi215 : Nat.totient 215 = 168 := step (p := 5) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi1075 : Nat.totient 1075 = 840 := step (p := 5) (m := 215) (by decide +kernel) (by decide) phi215 (by decide +kernel)
private theorem phi2150 : Nat.totient 2150 = 840 := step (p := 2) (m := 1075) (by decide +kernel) (by decide) phi1075 (by decide +kernel)
private theorem c2150 : Covered 2150 2151 := one (i := 2150) (by rw [phi2150]; decide)
private theorem j2149x2151 : Covered 2149 2151 := join c2149 c2150
private theorem phi239 : Nat.totient 239 = 238 := step (p := 239) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi717 : Nat.totient 717 = 476 := step (p := 3) (m := 239) (by decide +kernel) (by decide) phi239 (by decide +kernel)
private theorem phi2151 : Nat.totient 2151 = 1428 := step (p := 3) (m := 717) (by decide +kernel) (by decide) phi717 (by decide +kernel)
private theorem c2151 : Covered 2151 2152 := one (i := 2151) (by rw [phi2151]; decide)
private theorem phi269 : Nat.totient 269 = 268 := step (p := 269) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi538 : Nat.totient 538 = 268 := step (p := 2) (m := 269) (by decide +kernel) (by decide) phi269 (by decide +kernel)
private theorem phi1076 : Nat.totient 1076 = 536 := step (p := 2) (m := 538) (by decide +kernel) (by decide) phi538 (by decide +kernel)
private theorem phi2152 : Nat.totient 2152 = 1072 := step (p := 2) (m := 1076) (by decide +kernel) (by decide) phi1076 (by decide +kernel)
private theorem c2152 : Covered 2152 2153 := one (i := 2152) (by rw [phi2152]; decide)
private theorem j2151x2153 : Covered 2151 2153 := join c2151 c2152
private theorem j2149x2153 : Covered 2149 2153 := join j2149x2151 j2151x2153
private theorem phi2153 : Nat.totient 2153 = 2152 := step (p := 2153) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2153 : Covered 2153 2154 := one (i := 2153) (by rw [phi2153]; decide)
private theorem phi359 : Nat.totient 359 = 358 := step (p := 359) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1077 : Nat.totient 1077 = 716 := step (p := 3) (m := 359) (by decide +kernel) (by decide) phi359 (by decide +kernel)
private theorem phi2154 : Nat.totient 2154 = 716 := step (p := 2) (m := 1077) (by decide +kernel) (by decide) phi1077 (by decide +kernel)
private theorem c2154 : Covered 2154 2155 := one (i := 2154) (by rw [phi2154]; decide)
private theorem j2153x2155 : Covered 2153 2155 := join c2153 c2154
private theorem phi431 : Nat.totient 431 = 430 := step (p := 431) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2155 : Nat.totient 2155 = 1720 := step (p := 5) (m := 431) (by decide +kernel) (by decide) phi431 (by decide +kernel)
private theorem c2155 : Covered 2155 2156 := one (i := 2155) (by rw [phi2155]; decide)
private theorem phi77 : Nat.totient 77 = 60 := step (p := 7) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem phi539 : Nat.totient 539 = 420 := step (p := 7) (m := 77) (by decide +kernel) (by decide) phi77 (by decide +kernel)
private theorem phi1078 : Nat.totient 1078 = 420 := step (p := 2) (m := 539) (by decide +kernel) (by decide) phi539 (by decide +kernel)
private theorem phi2156 : Nat.totient 2156 = 840 := step (p := 2) (m := 1078) (by decide +kernel) (by decide) phi1078 (by decide +kernel)
private theorem c2156 : Covered 2156 2157 := one (i := 2156) (by rw [phi2156]; decide)
private theorem j2155x2157 : Covered 2155 2157 := join c2155 c2156
private theorem j2153x2157 : Covered 2153 2157 := join j2153x2155 j2155x2157
private theorem j2149x2157 : Covered 2149 2157 := join j2149x2153 j2153x2157
private theorem j2142x2157 : Covered 2142 2157 := join j2142x2149 j2149x2157
private theorem j2128x2157 : Covered 2128 2157 := join j2128x2142 j2142x2157
private theorem j2100x2157 : Covered 2100 2157 := join j2100x2128 j2128x2157
private theorem phi719 : Nat.totient 719 = 718 := step (p := 719) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2157 : Nat.totient 2157 = 1436 := step (p := 3) (m := 719) (by decide +kernel) (by decide) phi719 (by decide +kernel)
private theorem c2157 : Covered 2157 2158 := one (i := 2157) (by rw [phi2157]; decide)
private theorem phi83 : Nat.totient 83 = 82 := step (p := 83) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1079 : Nat.totient 1079 = 984 := step (p := 13) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem phi2158 : Nat.totient 2158 = 984 := step (p := 2) (m := 1079) (by decide +kernel) (by decide) phi1079 (by decide +kernel)
private theorem c2158 : Covered 2158 2159 := one (i := 2158) (by rw [phi2158]; decide)
private theorem phi127 : Nat.totient 127 = 126 := step (p := 127) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2159 : Nat.totient 2159 = 2016 := step (p := 17) (m := 127) (by decide +kernel) (by decide) phi127 (by decide +kernel)
private theorem c2159 : Covered 2159 2160 := one (i := 2159) (by rw [phi2159]; decide)
private theorem j2158x2160 : Covered 2158 2160 := join c2158 c2159
private theorem j2157x2160 : Covered 2157 2160 := join c2157 j2158x2160
private theorem phi5 : Nat.totient 5 = 4 := step (p := 5) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi15 : Nat.totient 15 = 8 := step (p := 3) (m := 5) (by decide +kernel) (by decide) phi5 (by decide +kernel)
private theorem phi45 : Nat.totient 45 = 24 := step (p := 3) (m := 15) (by decide +kernel) (by decide) phi15 (by decide +kernel)
private theorem phi135 : Nat.totient 135 = 72 := step (p := 3) (m := 45) (by decide +kernel) (by decide) phi45 (by decide +kernel)
private theorem phi270 : Nat.totient 270 = 72 := step (p := 2) (m := 135) (by decide +kernel) (by decide) phi135 (by decide +kernel)
private theorem phi540 : Nat.totient 540 = 144 := step (p := 2) (m := 270) (by decide +kernel) (by decide) phi270 (by decide +kernel)
private theorem phi1080 : Nat.totient 1080 = 288 := step (p := 2) (m := 540) (by decide +kernel) (by decide) phi540 (by decide +kernel)
private theorem phi2160 : Nat.totient 2160 = 576 := step (p := 2) (m := 1080) (by decide +kernel) (by decide) phi1080 (by decide +kernel)
private theorem c2160 : Covered 2160 2161 := one (i := 2160) (by rw [phi2160]; decide)
private theorem phi2161 : Nat.totient 2161 = 2160 := step (p := 2161) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2161 : Covered 2161 2162 := one (i := 2161) (by rw [phi2161]; decide)
private theorem j2160x2162 : Covered 2160 2162 := join c2160 c2161
private theorem phi1081 : Nat.totient 1081 = 1012 := step (p := 23) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi2162 : Nat.totient 2162 = 1012 := step (p := 2) (m := 1081) (by decide +kernel) (by decide) phi1081 (by decide +kernel)
private theorem c2162 : Covered 2162 2163 := one (i := 2162) (by rw [phi2162]; decide)
private theorem phi103 : Nat.totient 103 = 102 := step (p := 103) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi721 : Nat.totient 721 = 612 := step (p := 7) (m := 103) (by decide +kernel) (by decide) phi103 (by decide +kernel)
private theorem phi2163 : Nat.totient 2163 = 1224 := step (p := 3) (m := 721) (by decide +kernel) (by decide) phi721 (by decide +kernel)
private theorem c2163 : Covered 2163 2164 := one (i := 2163) (by rw [phi2163]; decide)
private theorem j2162x2164 : Covered 2162 2164 := join c2162 c2163
private theorem j2160x2164 : Covered 2160 2164 := join j2160x2162 j2162x2164
private theorem j2157x2164 : Covered 2157 2164 := join j2157x2160 j2160x2164
private theorem phi541 : Nat.totient 541 = 540 := step (p := 541) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1082 : Nat.totient 1082 = 540 := step (p := 2) (m := 541) (by decide +kernel) (by decide) phi541 (by decide +kernel)
private theorem phi2164 : Nat.totient 2164 = 1080 := step (p := 2) (m := 1082) (by decide +kernel) (by decide) phi1082 (by decide +kernel)
private theorem c2164 : Covered 2164 2165 := one (i := 2164) (by rw [phi2164]; decide)
private theorem phi433 : Nat.totient 433 = 432 := step (p := 433) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2165 : Nat.totient 2165 = 1728 := step (p := 5) (m := 433) (by decide +kernel) (by decide) phi433 (by decide +kernel)
private theorem c2165 : Covered 2165 2166 := one (i := 2165) (by rw [phi2165]; decide)
private theorem phi361 : Nat.totient 361 = 342 := step (p := 19) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi1083 : Nat.totient 1083 = 684 := step (p := 3) (m := 361) (by decide +kernel) (by decide) phi361 (by decide +kernel)
private theorem phi2166 : Nat.totient 2166 = 684 := step (p := 2) (m := 1083) (by decide +kernel) (by decide) phi1083 (by decide +kernel)
private theorem c2166 : Covered 2166 2167 := one (i := 2166) (by rw [phi2166]; decide)
private theorem j2165x2167 : Covered 2165 2167 := join c2165 c2166
private theorem j2164x2167 : Covered 2164 2167 := join c2164 j2165x2167
private theorem phi197 : Nat.totient 197 = 196 := step (p := 197) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2167 : Nat.totient 2167 = 1960 := step (p := 11) (m := 197) (by decide +kernel) (by decide) phi197 (by decide +kernel)
private theorem c2167 : Covered 2167 2168 := one (i := 2167) (by rw [phi2167]; decide)
private theorem phi271 : Nat.totient 271 = 270 := step (p := 271) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi542 : Nat.totient 542 = 270 := step (p := 2) (m := 271) (by decide +kernel) (by decide) phi271 (by decide +kernel)
private theorem phi1084 : Nat.totient 1084 = 540 := step (p := 2) (m := 542) (by decide +kernel) (by decide) phi542 (by decide +kernel)
private theorem phi2168 : Nat.totient 2168 = 1080 := step (p := 2) (m := 1084) (by decide +kernel) (by decide) phi1084 (by decide +kernel)
private theorem c2168 : Covered 2168 2169 := one (i := 2168) (by rw [phi2168]; decide)
private theorem j2167x2169 : Covered 2167 2169 := join c2167 c2168
private theorem phi241 : Nat.totient 241 = 240 := step (p := 241) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi723 : Nat.totient 723 = 480 := step (p := 3) (m := 241) (by decide +kernel) (by decide) phi241 (by decide +kernel)
private theorem phi2169 : Nat.totient 2169 = 1440 := step (p := 3) (m := 723) (by decide +kernel) (by decide) phi723 (by decide +kernel)
private theorem c2169 : Covered 2169 2170 := one (i := 2169) (by rw [phi2169]; decide)
private theorem phi217 : Nat.totient 217 = 180 := step (p := 7) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi1085 : Nat.totient 1085 = 720 := step (p := 5) (m := 217) (by decide +kernel) (by decide) phi217 (by decide +kernel)
private theorem phi2170 : Nat.totient 2170 = 720 := step (p := 2) (m := 1085) (by decide +kernel) (by decide) phi1085 (by decide +kernel)
private theorem c2170 : Covered 2170 2171 := one (i := 2170) (by rw [phi2170]; decide)
private theorem j2169x2171 : Covered 2169 2171 := join c2169 c2170
private theorem j2167x2171 : Covered 2167 2171 := join j2167x2169 j2169x2171
private theorem j2164x2171 : Covered 2164 2171 := join j2164x2167 j2167x2171
private theorem j2157x2171 : Covered 2157 2171 := join j2157x2164 j2164x2171
private theorem phi167 : Nat.totient 167 = 166 := step (p := 167) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2171 : Nat.totient 2171 = 1992 := step (p := 13) (m := 167) (by decide +kernel) (by decide) phi167 (by decide +kernel)
private theorem c2171 : Covered 2171 2172 := one (i := 2171) (by rw [phi2171]; decide)
private theorem phi181 : Nat.totient 181 = 180 := step (p := 181) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi543 : Nat.totient 543 = 360 := step (p := 3) (m := 181) (by decide +kernel) (by decide) phi181 (by decide +kernel)
private theorem phi1086 : Nat.totient 1086 = 360 := step (p := 2) (m := 543) (by decide +kernel) (by decide) phi543 (by decide +kernel)
private theorem phi2172 : Nat.totient 2172 = 720 := step (p := 2) (m := 1086) (by decide +kernel) (by decide) phi1086 (by decide +kernel)
private theorem c2172 : Covered 2172 2173 := one (i := 2172) (by rw [phi2172]; decide)
private theorem phi2173 : Nat.totient 2173 = 2080 := step (p := 41) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem c2173 : Covered 2173 2174 := one (i := 2173) (by rw [phi2173]; decide)
private theorem j2172x2174 : Covered 2172 2174 := join c2172 c2173
private theorem j2171x2174 : Covered 2171 2174 := join c2171 j2172x2174
private theorem phi1087 : Nat.totient 1087 = 1086 := step (p := 1087) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2174 : Nat.totient 2174 = 1086 := step (p := 2) (m := 1087) (by decide +kernel) (by decide) phi1087 (by decide +kernel)
private theorem c2174 : Covered 2174 2175 := one (i := 2174) (by rw [phi2174]; decide)
private theorem phi29 : Nat.totient 29 = 28 := step (p := 29) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi145 : Nat.totient 145 = 112 := step (p := 5) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi725 : Nat.totient 725 = 560 := step (p := 5) (m := 145) (by decide +kernel) (by decide) phi145 (by decide +kernel)
private theorem phi2175 : Nat.totient 2175 = 1120 := step (p := 3) (m := 725) (by decide +kernel) (by decide) phi725 (by decide +kernel)
private theorem c2175 : Covered 2175 2176 := one (i := 2175) (by rw [phi2175]; decide)
private theorem j2174x2176 : Covered 2174 2176 := join c2174 c2175
private theorem phi34 : Nat.totient 34 = 16 := step (p := 2) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi68 : Nat.totient 68 = 32 := step (p := 2) (m := 34) (by decide +kernel) (by decide) phi34 (by decide +kernel)
private theorem phi136 : Nat.totient 136 = 64 := step (p := 2) (m := 68) (by decide +kernel) (by decide) phi68 (by decide +kernel)
private theorem phi272 : Nat.totient 272 = 128 := step (p := 2) (m := 136) (by decide +kernel) (by decide) phi136 (by decide +kernel)
private theorem phi544 : Nat.totient 544 = 256 := step (p := 2) (m := 272) (by decide +kernel) (by decide) phi272 (by decide +kernel)
private theorem phi1088 : Nat.totient 1088 = 512 := step (p := 2) (m := 544) (by decide +kernel) (by decide) phi544 (by decide +kernel)
private theorem phi2176 : Nat.totient 2176 = 1024 := step (p := 2) (m := 1088) (by decide +kernel) (by decide) phi1088 (by decide +kernel)
private theorem c2176 : Covered 2176 2177 := one (i := 2176) (by rw [phi2176]; decide)
private theorem phi311 : Nat.totient 311 = 310 := step (p := 311) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2177 : Nat.totient 2177 = 1860 := step (p := 7) (m := 311) (by decide +kernel) (by decide) phi311 (by decide +kernel)
private theorem c2177 : Covered 2177 2178 := one (i := 2177) (by rw [phi2177]; decide)
private theorem j2176x2178 : Covered 2176 2178 := join c2176 c2177
private theorem j2174x2178 : Covered 2174 2178 := join j2174x2176 j2176x2178
private theorem j2171x2178 : Covered 2171 2178 := join j2171x2174 j2174x2178
private theorem phi121 : Nat.totient 121 = 110 := step (p := 11) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem phi363 : Nat.totient 363 = 220 := step (p := 3) (m := 121) (by decide +kernel) (by decide) phi121 (by decide +kernel)
private theorem phi1089 : Nat.totient 1089 = 660 := step (p := 3) (m := 363) (by decide +kernel) (by decide) phi363 (by decide +kernel)
private theorem phi2178 : Nat.totient 2178 = 660 := step (p := 2) (m := 1089) (by decide +kernel) (by decide) phi1089 (by decide +kernel)
private theorem c2178 : Covered 2178 2179 := one (i := 2178) (by rw [phi2178]; decide)
private theorem phi2179 : Nat.totient 2179 = 2178 := step (p := 2179) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2179 : Covered 2179 2180 := one (i := 2179) (by rw [phi2179]; decide)
private theorem j2178x2180 : Covered 2178 2180 := join c2178 c2179
private theorem phi109 : Nat.totient 109 = 108 := step (p := 109) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi545 : Nat.totient 545 = 432 := step (p := 5) (m := 109) (by decide +kernel) (by decide) phi109 (by decide +kernel)
private theorem phi1090 : Nat.totient 1090 = 432 := step (p := 2) (m := 545) (by decide +kernel) (by decide) phi545 (by decide +kernel)
private theorem phi2180 : Nat.totient 2180 = 864 := step (p := 2) (m := 1090) (by decide +kernel) (by decide) phi1090 (by decide +kernel)
private theorem c2180 : Covered 2180 2181 := one (i := 2180) (by rw [phi2180]; decide)
private theorem phi727 : Nat.totient 727 = 726 := step (p := 727) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2181 : Nat.totient 2181 = 1452 := step (p := 3) (m := 727) (by decide +kernel) (by decide) phi727 (by decide +kernel)
private theorem c2181 : Covered 2181 2182 := one (i := 2181) (by rw [phi2181]; decide)
private theorem j2180x2182 : Covered 2180 2182 := join c2180 c2181
private theorem j2178x2182 : Covered 2178 2182 := join j2178x2180 j2180x2182
private theorem phi1091 : Nat.totient 1091 = 1090 := step (p := 1091) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2182 : Nat.totient 2182 = 1090 := step (p := 2) (m := 1091) (by decide +kernel) (by decide) phi1091 (by decide +kernel)
private theorem c2182 : Covered 2182 2183 := one (i := 2182) (by rw [phi2182]; decide)
private theorem phi2183 : Nat.totient 2183 = 2088 := step (p := 37) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem c2183 : Covered 2183 2184 := one (i := 2183) (by rw [phi2183]; decide)
private theorem j2182x2184 : Covered 2182 2184 := join c2182 c2183
private theorem phi91 : Nat.totient 91 = 72 := step (p := 7) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi273 : Nat.totient 273 = 144 := step (p := 3) (m := 91) (by decide +kernel) (by decide) phi91 (by decide +kernel)
private theorem phi546 : Nat.totient 546 = 144 := step (p := 2) (m := 273) (by decide +kernel) (by decide) phi273 (by decide +kernel)
private theorem phi1092 : Nat.totient 1092 = 288 := step (p := 2) (m := 546) (by decide +kernel) (by decide) phi546 (by decide +kernel)
private theorem phi2184 : Nat.totient 2184 = 576 := step (p := 2) (m := 1092) (by decide +kernel) (by decide) phi1092 (by decide +kernel)
private theorem c2184 : Covered 2184 2185 := one (i := 2184) (by rw [phi2184]; decide)
private theorem phi437 : Nat.totient 437 = 396 := step (p := 19) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi2185 : Nat.totient 2185 = 1584 := step (p := 5) (m := 437) (by decide +kernel) (by decide) phi437 (by decide +kernel)
private theorem c2185 : Covered 2185 2186 := one (i := 2185) (by rw [phi2185]; decide)
private theorem j2184x2186 : Covered 2184 2186 := join c2184 c2185
private theorem j2182x2186 : Covered 2182 2186 := join j2182x2184 j2184x2186
private theorem j2178x2186 : Covered 2178 2186 := join j2178x2182 j2182x2186
private theorem j2171x2186 : Covered 2171 2186 := join j2171x2178 j2178x2186
private theorem j2157x2186 : Covered 2157 2186 := join j2157x2171 j2171x2186
private theorem phi1093 : Nat.totient 1093 = 1092 := step (p := 1093) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2186 : Nat.totient 2186 = 1092 := step (p := 2) (m := 1093) (by decide +kernel) (by decide) phi1093 (by decide +kernel)
private theorem c2186 : Covered 2186 2187 := one (i := 2186) (by rw [phi2186]; decide)
private theorem phi3 : Nat.totient 3 = 2 := step (p := 3) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi9 : Nat.totient 9 = 6 := step (p := 3) (m := 3) (by decide +kernel) (by decide) phi3 (by decide +kernel)
private theorem phi27 : Nat.totient 27 = 18 := step (p := 3) (m := 9) (by decide +kernel) (by decide) phi9 (by decide +kernel)
private theorem phi81 : Nat.totient 81 = 54 := step (p := 3) (m := 27) (by decide +kernel) (by decide) phi27 (by decide +kernel)
private theorem phi243 : Nat.totient 243 = 162 := step (p := 3) (m := 81) (by decide +kernel) (by decide) phi81 (by decide +kernel)
private theorem phi729 : Nat.totient 729 = 486 := step (p := 3) (m := 243) (by decide +kernel) (by decide) phi243 (by decide +kernel)
private theorem phi2187 : Nat.totient 2187 = 1458 := step (p := 3) (m := 729) (by decide +kernel) (by decide) phi729 (by decide +kernel)
private theorem c2187 : Covered 2187 2188 := one (i := 2187) (by rw [phi2187]; decide)
private theorem phi547 : Nat.totient 547 = 546 := step (p := 547) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1094 : Nat.totient 1094 = 546 := step (p := 2) (m := 547) (by decide +kernel) (by decide) phi547 (by decide +kernel)
private theorem phi2188 : Nat.totient 2188 = 1092 := step (p := 2) (m := 1094) (by decide +kernel) (by decide) phi1094 (by decide +kernel)
private theorem c2188 : Covered 2188 2189 := one (i := 2188) (by rw [phi2188]; decide)
private theorem j2187x2189 : Covered 2187 2189 := join c2187 c2188
private theorem j2186x2189 : Covered 2186 2189 := join c2186 j2187x2189
private theorem phi199 : Nat.totient 199 = 198 := step (p := 199) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2189 : Nat.totient 2189 = 1980 := step (p := 11) (m := 199) (by decide +kernel) (by decide) phi199 (by decide +kernel)
private theorem c2189 : Covered 2189 2190 := one (i := 2189) (by rw [phi2189]; decide)
private theorem phi365 : Nat.totient 365 = 288 := step (p := 5) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem phi1095 : Nat.totient 1095 = 576 := step (p := 3) (m := 365) (by decide +kernel) (by decide) phi365 (by decide +kernel)
private theorem phi2190 : Nat.totient 2190 = 576 := step (p := 2) (m := 1095) (by decide +kernel) (by decide) phi1095 (by decide +kernel)
private theorem c2190 : Covered 2190 2191 := one (i := 2190) (by rw [phi2190]; decide)
private theorem j2189x2191 : Covered 2189 2191 := join c2189 c2190
private theorem phi313 : Nat.totient 313 = 312 := step (p := 313) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2191 : Nat.totient 2191 = 1872 := step (p := 7) (m := 313) (by decide +kernel) (by decide) phi313 (by decide +kernel)
private theorem c2191 : Covered 2191 2192 := one (i := 2191) (by rw [phi2191]; decide)
private theorem phi137 : Nat.totient 137 = 136 := step (p := 137) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi274 : Nat.totient 274 = 136 := step (p := 2) (m := 137) (by decide +kernel) (by decide) phi137 (by decide +kernel)
private theorem phi548 : Nat.totient 548 = 272 := step (p := 2) (m := 274) (by decide +kernel) (by decide) phi274 (by decide +kernel)
private theorem phi1096 : Nat.totient 1096 = 544 := step (p := 2) (m := 548) (by decide +kernel) (by decide) phi548 (by decide +kernel)
private theorem phi2192 : Nat.totient 2192 = 1088 := step (p := 2) (m := 1096) (by decide +kernel) (by decide) phi1096 (by decide +kernel)
private theorem c2192 : Covered 2192 2193 := one (i := 2192) (by rw [phi2192]; decide)
private theorem j2191x2193 : Covered 2191 2193 := join c2191 c2192
private theorem j2189x2193 : Covered 2189 2193 := join j2189x2191 j2191x2193
private theorem j2186x2193 : Covered 2186 2193 := join j2186x2189 j2189x2193
private theorem phi731 : Nat.totient 731 = 672 := step (p := 17) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi2193 : Nat.totient 2193 = 1344 := step (p := 3) (m := 731) (by decide +kernel) (by decide) phi731 (by decide +kernel)
private theorem c2193 : Covered 2193 2194 := one (i := 2193) (by rw [phi2193]; decide)
private theorem phi1097 : Nat.totient 1097 = 1096 := step (p := 1097) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2194 : Nat.totient 2194 = 1096 := step (p := 2) (m := 1097) (by decide +kernel) (by decide) phi1097 (by decide +kernel)
private theorem c2194 : Covered 2194 2195 := one (i := 2194) (by rw [phi2194]; decide)
private theorem phi439 : Nat.totient 439 = 438 := step (p := 439) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2195 : Nat.totient 2195 = 1752 := step (p := 5) (m := 439) (by decide +kernel) (by decide) phi439 (by decide +kernel)
private theorem c2195 : Covered 2195 2196 := one (i := 2195) (by rw [phi2195]; decide)
private theorem j2194x2196 : Covered 2194 2196 := join c2194 c2195
private theorem j2193x2196 : Covered 2193 2196 := join c2193 j2194x2196
private theorem phi183 : Nat.totient 183 = 120 := step (p := 3) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi549 : Nat.totient 549 = 360 := step (p := 3) (m := 183) (by decide +kernel) (by decide) phi183 (by decide +kernel)
private theorem phi1098 : Nat.totient 1098 = 360 := step (p := 2) (m := 549) (by decide +kernel) (by decide) phi549 (by decide +kernel)
private theorem phi2196 : Nat.totient 2196 = 720 := step (p := 2) (m := 1098) (by decide +kernel) (by decide) phi1098 (by decide +kernel)
private theorem c2196 : Covered 2196 2197 := one (i := 2196) (by rw [phi2196]; decide)
private theorem phi169 : Nat.totient 169 = 156 := step (p := 13) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi2197 : Nat.totient 2197 = 2028 := step (p := 13) (m := 169) (by decide +kernel) (by decide) phi169 (by decide +kernel)
private theorem c2197 : Covered 2197 2198 := one (i := 2197) (by rw [phi2197]; decide)
private theorem j2196x2198 : Covered 2196 2198 := join c2196 c2197
private theorem phi157 : Nat.totient 157 = 156 := step (p := 157) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1099 : Nat.totient 1099 = 936 := step (p := 7) (m := 157) (by decide +kernel) (by decide) phi157 (by decide +kernel)
private theorem phi2198 : Nat.totient 2198 = 936 := step (p := 2) (m := 1099) (by decide +kernel) (by decide) phi1099 (by decide +kernel)
private theorem c2198 : Covered 2198 2199 := one (i := 2198) (by rw [phi2198]; decide)
private theorem phi733 : Nat.totient 733 = 732 := step (p := 733) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2199 : Nat.totient 2199 = 1464 := step (p := 3) (m := 733) (by decide +kernel) (by decide) phi733 (by decide +kernel)
private theorem c2199 : Covered 2199 2200 := one (i := 2199) (by rw [phi2199]; decide)
private theorem j2198x2200 : Covered 2198 2200 := join c2198 c2199
private theorem j2196x2200 : Covered 2196 2200 := join j2196x2198 j2198x2200
private theorem j2193x2200 : Covered 2193 2200 := join j2193x2196 j2196x2200
private theorem j2186x2200 : Covered 2186 2200 := join j2186x2193 j2193x2200
private theorem phi55 : Nat.totient 55 = 40 := step (p := 5) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem phi275 : Nat.totient 275 = 200 := step (p := 5) (m := 55) (by decide +kernel) (by decide) phi55 (by decide +kernel)
private theorem phi550 : Nat.totient 550 = 200 := step (p := 2) (m := 275) (by decide +kernel) (by decide) phi275 (by decide +kernel)
private theorem phi1100 : Nat.totient 1100 = 400 := step (p := 2) (m := 550) (by decide +kernel) (by decide) phi550 (by decide +kernel)
private theorem phi2200 : Nat.totient 2200 = 800 := step (p := 2) (m := 1100) (by decide +kernel) (by decide) phi1100 (by decide +kernel)
private theorem c2200 : Covered 2200 2201 := one (i := 2200) (by rw [phi2200]; decide)
private theorem phi2201 : Nat.totient 2201 = 2100 := step (p := 31) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem c2201 : Covered 2201 2202 := one (i := 2201) (by rw [phi2201]; decide)
private theorem phi367 : Nat.totient 367 = 366 := step (p := 367) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1101 : Nat.totient 1101 = 732 := step (p := 3) (m := 367) (by decide +kernel) (by decide) phi367 (by decide +kernel)
private theorem phi2202 : Nat.totient 2202 = 732 := step (p := 2) (m := 1101) (by decide +kernel) (by decide) phi1101 (by decide +kernel)
private theorem c2202 : Covered 2202 2203 := one (i := 2202) (by rw [phi2202]; decide)
private theorem j2201x2203 : Covered 2201 2203 := join c2201 c2202
private theorem j2200x2203 : Covered 2200 2203 := join c2200 j2201x2203
private theorem phi2203 : Nat.totient 2203 = 2202 := step (p := 2203) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2203 : Covered 2203 2204 := one (i := 2203) (by rw [phi2203]; decide)
private theorem phi551 : Nat.totient 551 = 504 := step (p := 19) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi1102 : Nat.totient 1102 = 504 := step (p := 2) (m := 551) (by decide +kernel) (by decide) phi551 (by decide +kernel)
private theorem phi2204 : Nat.totient 2204 = 1008 := step (p := 2) (m := 1102) (by decide +kernel) (by decide) phi1102 (by decide +kernel)
private theorem c2204 : Covered 2204 2205 := one (i := 2204) (by rw [phi2204]; decide)
private theorem j2203x2205 : Covered 2203 2205 := join c2203 c2204
private theorem phi49 : Nat.totient 49 = 42 := step (p := 7) (m := 7) (by decide +kernel) (by decide) phi7 (by decide +kernel)
private theorem phi245 : Nat.totient 245 = 168 := step (p := 5) (m := 49) (by decide +kernel) (by decide) phi49 (by decide +kernel)
private theorem phi735 : Nat.totient 735 = 336 := step (p := 3) (m := 245) (by decide +kernel) (by decide) phi245 (by decide +kernel)
private theorem phi2205 : Nat.totient 2205 = 1008 := step (p := 3) (m := 735) (by decide +kernel) (by decide) phi735 (by decide +kernel)
private theorem c2205 : Covered 2205 2206 := one (i := 2205) (by rw [phi2205]; decide)
private theorem phi1103 : Nat.totient 1103 = 1102 := step (p := 1103) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2206 : Nat.totient 2206 = 1102 := step (p := 2) (m := 1103) (by decide +kernel) (by decide) phi1103 (by decide +kernel)
private theorem c2206 : Covered 2206 2207 := one (i := 2206) (by rw [phi2206]; decide)
private theorem j2205x2207 : Covered 2205 2207 := join c2205 c2206
private theorem j2203x2207 : Covered 2203 2207 := join j2203x2205 j2205x2207
private theorem j2200x2207 : Covered 2200 2207 := join j2200x2203 j2203x2207
private theorem phi2207 : Nat.totient 2207 = 2206 := step (p := 2207) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2207 : Covered 2207 2208 := one (i := 2207) (by rw [phi2207]; decide)
private theorem phi69 : Nat.totient 69 = 44 := step (p := 3) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi138 : Nat.totient 138 = 44 := step (p := 2) (m := 69) (by decide +kernel) (by decide) phi69 (by decide +kernel)
private theorem phi276 : Nat.totient 276 = 88 := step (p := 2) (m := 138) (by decide +kernel) (by decide) phi138 (by decide +kernel)
private theorem phi552 : Nat.totient 552 = 176 := step (p := 2) (m := 276) (by decide +kernel) (by decide) phi276 (by decide +kernel)
private theorem phi1104 : Nat.totient 1104 = 352 := step (p := 2) (m := 552) (by decide +kernel) (by decide) phi552 (by decide +kernel)
private theorem phi2208 : Nat.totient 2208 = 704 := step (p := 2) (m := 1104) (by decide +kernel) (by decide) phi1104 (by decide +kernel)
private theorem c2208 : Covered 2208 2209 := one (i := 2208) (by rw [phi2208]; decide)
private theorem j2207x2209 : Covered 2207 2209 := join c2207 c2208
private theorem phi2209 : Nat.totient 2209 = 2162 := step (p := 47) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem c2209 : Covered 2209 2210 := one (i := 2209) (by rw [phi2209]; decide)
private theorem phi221 : Nat.totient 221 = 192 := step (p := 13) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi1105 : Nat.totient 1105 = 768 := step (p := 5) (m := 221) (by decide +kernel) (by decide) phi221 (by decide +kernel)
private theorem phi2210 : Nat.totient 2210 = 768 := step (p := 2) (m := 1105) (by decide +kernel) (by decide) phi1105 (by decide +kernel)
private theorem c2210 : Covered 2210 2211 := one (i := 2210) (by rw [phi2210]; decide)
private theorem j2209x2211 : Covered 2209 2211 := join c2209 c2210
private theorem j2207x2211 : Covered 2207 2211 := join j2207x2209 j2209x2211
private theorem phi737 : Nat.totient 737 = 660 := step (p := 11) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi2211 : Nat.totient 2211 = 1320 := step (p := 3) (m := 737) (by decide +kernel) (by decide) phi737 (by decide +kernel)
private theorem c2211 : Covered 2211 2212 := one (i := 2211) (by rw [phi2211]; decide)
private theorem phi553 : Nat.totient 553 = 468 := step (p := 7) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem phi1106 : Nat.totient 1106 = 468 := step (p := 2) (m := 553) (by decide +kernel) (by decide) phi553 (by decide +kernel)
private theorem phi2212 : Nat.totient 2212 = 936 := step (p := 2) (m := 1106) (by decide +kernel) (by decide) phi1106 (by decide +kernel)
private theorem c2212 : Covered 2212 2213 := one (i := 2212) (by rw [phi2212]; decide)
private theorem j2211x2213 : Covered 2211 2213 := join c2211 c2212
private theorem phi2213 : Nat.totient 2213 = 2212 := step (p := 2213) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2213 : Covered 2213 2214 := one (i := 2213) (by rw [phi2213]; decide)
private theorem phi123 : Nat.totient 123 = 80 := step (p := 3) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi369 : Nat.totient 369 = 240 := step (p := 3) (m := 123) (by decide +kernel) (by decide) phi123 (by decide +kernel)
private theorem phi1107 : Nat.totient 1107 = 720 := step (p := 3) (m := 369) (by decide +kernel) (by decide) phi369 (by decide +kernel)
private theorem phi2214 : Nat.totient 2214 = 720 := step (p := 2) (m := 1107) (by decide +kernel) (by decide) phi1107 (by decide +kernel)
private theorem c2214 : Covered 2214 2215 := one (i := 2214) (by rw [phi2214]; decide)
private theorem j2213x2215 : Covered 2213 2215 := join c2213 c2214
private theorem j2211x2215 : Covered 2211 2215 := join j2211x2213 j2213x2215
private theorem j2207x2215 : Covered 2207 2215 := join j2207x2211 j2211x2215
private theorem j2200x2215 : Covered 2200 2215 := join j2200x2207 j2207x2215
private theorem j2186x2215 : Covered 2186 2215 := join j2186x2200 j2200x2215
private theorem j2157x2215 : Covered 2157 2215 := join j2157x2186 j2186x2215
private theorem j2100x2215 : Covered 2100 2215 := join j2100x2157 j2157x2215
private theorem phi443 : Nat.totient 443 = 442 := step (p := 443) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2215 : Nat.totient 2215 = 1768 := step (p := 5) (m := 443) (by decide +kernel) (by decide) phi443 (by decide +kernel)
private theorem c2215 : Covered 2215 2216 := one (i := 2215) (by rw [phi2215]; decide)
private theorem phi277 : Nat.totient 277 = 276 := step (p := 277) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi554 : Nat.totient 554 = 276 := step (p := 2) (m := 277) (by decide +kernel) (by decide) phi277 (by decide +kernel)
private theorem phi1108 : Nat.totient 1108 = 552 := step (p := 2) (m := 554) (by decide +kernel) (by decide) phi554 (by decide +kernel)
private theorem phi2216 : Nat.totient 2216 = 1104 := step (p := 2) (m := 1108) (by decide +kernel) (by decide) phi1108 (by decide +kernel)
private theorem c2216 : Covered 2216 2217 := one (i := 2216) (by rw [phi2216]; decide)
private theorem phi739 : Nat.totient 739 = 738 := step (p := 739) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2217 : Nat.totient 2217 = 1476 := step (p := 3) (m := 739) (by decide +kernel) (by decide) phi739 (by decide +kernel)
private theorem c2217 : Covered 2217 2218 := one (i := 2217) (by rw [phi2217]; decide)
private theorem j2216x2218 : Covered 2216 2218 := join c2216 c2217
private theorem j2215x2218 : Covered 2215 2218 := join c2215 j2216x2218
private theorem phi1109 : Nat.totient 1109 = 1108 := step (p := 1109) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2218 : Nat.totient 2218 = 1108 := step (p := 2) (m := 1109) (by decide +kernel) (by decide) phi1109 (by decide +kernel)
private theorem c2218 : Covered 2218 2219 := one (i := 2218) (by rw [phi2218]; decide)
private theorem phi317 : Nat.totient 317 = 316 := step (p := 317) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2219 : Nat.totient 2219 = 1896 := step (p := 7) (m := 317) (by decide +kernel) (by decide) phi317 (by decide +kernel)
private theorem c2219 : Covered 2219 2220 := one (i := 2219) (by rw [phi2219]; decide)
private theorem j2218x2220 : Covered 2218 2220 := join c2218 c2219
private theorem phi185 : Nat.totient 185 = 144 := step (p := 5) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi555 : Nat.totient 555 = 288 := step (p := 3) (m := 185) (by decide +kernel) (by decide) phi185 (by decide +kernel)
private theorem phi1110 : Nat.totient 1110 = 288 := step (p := 2) (m := 555) (by decide +kernel) (by decide) phi555 (by decide +kernel)
private theorem phi2220 : Nat.totient 2220 = 576 := step (p := 2) (m := 1110) (by decide +kernel) (by decide) phi1110 (by decide +kernel)
private theorem c2220 : Covered 2220 2221 := one (i := 2220) (by rw [phi2220]; decide)
private theorem phi2221 : Nat.totient 2221 = 2220 := step (p := 2221) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2221 : Covered 2221 2222 := one (i := 2221) (by rw [phi2221]; decide)
private theorem j2220x2222 : Covered 2220 2222 := join c2220 c2221
private theorem j2218x2222 : Covered 2218 2222 := join j2218x2220 j2220x2222
private theorem j2215x2222 : Covered 2215 2222 := join j2215x2218 j2218x2222
private theorem phi1111 : Nat.totient 1111 = 1000 := step (p := 11) (m := 101) (by decide +kernel) (by decide) phi101 (by decide +kernel)
private theorem phi2222 : Nat.totient 2222 = 1000 := step (p := 2) (m := 1111) (by decide +kernel) (by decide) phi1111 (by decide +kernel)
private theorem c2222 : Covered 2222 2223 := one (i := 2222) (by rw [phi2222]; decide)
private theorem phi247 : Nat.totient 247 = 216 := step (p := 13) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi741 : Nat.totient 741 = 432 := step (p := 3) (m := 247) (by decide +kernel) (by decide) phi247 (by decide +kernel)
private theorem phi2223 : Nat.totient 2223 = 1296 := step (p := 3) (m := 741) (by decide +kernel) (by decide) phi741 (by decide +kernel)
private theorem c2223 : Covered 2223 2224 := one (i := 2223) (by rw [phi2223]; decide)
private theorem phi139 : Nat.totient 139 = 138 := step (p := 139) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi278 : Nat.totient 278 = 138 := step (p := 2) (m := 139) (by decide +kernel) (by decide) phi139 (by decide +kernel)
private theorem phi556 : Nat.totient 556 = 276 := step (p := 2) (m := 278) (by decide +kernel) (by decide) phi278 (by decide +kernel)
private theorem phi1112 : Nat.totient 1112 = 552 := step (p := 2) (m := 556) (by decide +kernel) (by decide) phi556 (by decide +kernel)
private theorem phi2224 : Nat.totient 2224 = 1104 := step (p := 2) (m := 1112) (by decide +kernel) (by decide) phi1112 (by decide +kernel)
private theorem c2224 : Covered 2224 2225 := one (i := 2224) (by rw [phi2224]; decide)
private theorem j2223x2225 : Covered 2223 2225 := join c2223 c2224
private theorem j2222x2225 : Covered 2222 2225 := join c2222 j2223x2225
private theorem phi445 : Nat.totient 445 = 352 := step (p := 5) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem phi2225 : Nat.totient 2225 = 1760 := step (p := 5) (m := 445) (by decide +kernel) (by decide) phi445 (by decide +kernel)
private theorem c2225 : Covered 2225 2226 := one (i := 2225) (by rw [phi2225]; decide)
private theorem phi371 : Nat.totient 371 = 312 := step (p := 7) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi1113 : Nat.totient 1113 = 624 := step (p := 3) (m := 371) (by decide +kernel) (by decide) phi371 (by decide +kernel)
private theorem phi2226 : Nat.totient 2226 = 624 := step (p := 2) (m := 1113) (by decide +kernel) (by decide) phi1113 (by decide +kernel)
private theorem c2226 : Covered 2226 2227 := one (i := 2226) (by rw [phi2226]; decide)
private theorem j2225x2227 : Covered 2225 2227 := join c2225 c2226
private theorem phi131 : Nat.totient 131 = 130 := step (p := 131) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2227 : Nat.totient 2227 = 2080 := step (p := 17) (m := 131) (by decide +kernel) (by decide) phi131 (by decide +kernel)
private theorem c2227 : Covered 2227 2228 := one (i := 2227) (by rw [phi2227]; decide)
private theorem phi557 : Nat.totient 557 = 556 := step (p := 557) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1114 : Nat.totient 1114 = 556 := step (p := 2) (m := 557) (by decide +kernel) (by decide) phi557 (by decide +kernel)
private theorem phi2228 : Nat.totient 2228 = 1112 := step (p := 2) (m := 1114) (by decide +kernel) (by decide) phi1114 (by decide +kernel)
private theorem c2228 : Covered 2228 2229 := one (i := 2228) (by rw [phi2228]; decide)
private theorem j2227x2229 : Covered 2227 2229 := join c2227 c2228
private theorem j2225x2229 : Covered 2225 2229 := join j2225x2227 j2227x2229
private theorem j2222x2229 : Covered 2222 2229 := join j2222x2225 j2225x2229
private theorem j2215x2229 : Covered 2215 2229 := join j2215x2222 j2222x2229
private theorem phi743 : Nat.totient 743 = 742 := step (p := 743) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2229 : Nat.totient 2229 = 1484 := step (p := 3) (m := 743) (by decide +kernel) (by decide) phi743 (by decide +kernel)
private theorem c2229 : Covered 2229 2230 := one (i := 2229) (by rw [phi2229]; decide)
private theorem phi223 : Nat.totient 223 = 222 := step (p := 223) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1115 : Nat.totient 1115 = 888 := step (p := 5) (m := 223) (by decide +kernel) (by decide) phi223 (by decide +kernel)
private theorem phi2230 : Nat.totient 2230 = 888 := step (p := 2) (m := 1115) (by decide +kernel) (by decide) phi1115 (by decide +kernel)
private theorem c2230 : Covered 2230 2231 := one (i := 2230) (by rw [phi2230]; decide)
private theorem phi2231 : Nat.totient 2231 = 2112 := step (p := 23) (m := 97) (by decide +kernel) (by decide) phi97 (by decide +kernel)
private theorem c2231 : Covered 2231 2232 := one (i := 2231) (by rw [phi2231]; decide)
private theorem j2230x2232 : Covered 2230 2232 := join c2230 c2231
private theorem j2229x2232 : Covered 2229 2232 := join c2229 j2230x2232
private theorem phi93 : Nat.totient 93 = 60 := step (p := 3) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi279 : Nat.totient 279 = 180 := step (p := 3) (m := 93) (by decide +kernel) (by decide) phi93 (by decide +kernel)
private theorem phi558 : Nat.totient 558 = 180 := step (p := 2) (m := 279) (by decide +kernel) (by decide) phi279 (by decide +kernel)
private theorem phi1116 : Nat.totient 1116 = 360 := step (p := 2) (m := 558) (by decide +kernel) (by decide) phi558 (by decide +kernel)
private theorem phi2232 : Nat.totient 2232 = 720 := step (p := 2) (m := 1116) (by decide +kernel) (by decide) phi1116 (by decide +kernel)
private theorem c2232 : Covered 2232 2233 := one (i := 2232) (by rw [phi2232]; decide)
private theorem phi319 : Nat.totient 319 = 280 := step (p := 11) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi2233 : Nat.totient 2233 = 1680 := step (p := 7) (m := 319) (by decide +kernel) (by decide) phi319 (by decide +kernel)
private theorem c2233 : Covered 2233 2234 := one (i := 2233) (by rw [phi2233]; decide)
private theorem j2232x2234 : Covered 2232 2234 := join c2232 c2233
private theorem phi1117 : Nat.totient 1117 = 1116 := step (p := 1117) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2234 : Nat.totient 2234 = 1116 := step (p := 2) (m := 1117) (by decide +kernel) (by decide) phi1117 (by decide +kernel)
private theorem c2234 : Covered 2234 2235 := one (i := 2234) (by rw [phi2234]; decide)
private theorem phi149 : Nat.totient 149 = 148 := step (p := 149) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi745 : Nat.totient 745 = 592 := step (p := 5) (m := 149) (by decide +kernel) (by decide) phi149 (by decide +kernel)
private theorem phi2235 : Nat.totient 2235 = 1184 := step (p := 3) (m := 745) (by decide +kernel) (by decide) phi745 (by decide +kernel)
private theorem c2235 : Covered 2235 2236 := one (i := 2235) (by rw [phi2235]; decide)
private theorem j2234x2236 : Covered 2234 2236 := join c2234 c2235
private theorem j2232x2236 : Covered 2232 2236 := join j2232x2234 j2234x2236
private theorem j2229x2236 : Covered 2229 2236 := join j2229x2232 j2232x2236
private theorem phi559 : Nat.totient 559 = 504 := step (p := 13) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi1118 : Nat.totient 1118 = 504 := step (p := 2) (m := 559) (by decide +kernel) (by decide) phi559 (by decide +kernel)
private theorem phi2236 : Nat.totient 2236 = 1008 := step (p := 2) (m := 1118) (by decide +kernel) (by decide) phi1118 (by decide +kernel)
private theorem c2236 : Covered 2236 2237 := one (i := 2236) (by rw [phi2236]; decide)
private theorem phi2237 : Nat.totient 2237 = 2236 := step (p := 2237) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2237 : Covered 2237 2238 := one (i := 2237) (by rw [phi2237]; decide)
private theorem j2236x2238 : Covered 2236 2238 := join c2236 c2237
private theorem phi373 : Nat.totient 373 = 372 := step (p := 373) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1119 : Nat.totient 1119 = 744 := step (p := 3) (m := 373) (by decide +kernel) (by decide) phi373 (by decide +kernel)
private theorem phi2238 : Nat.totient 2238 = 744 := step (p := 2) (m := 1119) (by decide +kernel) (by decide) phi1119 (by decide +kernel)
private theorem c2238 : Covered 2238 2239 := one (i := 2238) (by rw [phi2238]; decide)
private theorem phi2239 : Nat.totient 2239 = 2238 := step (p := 2239) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2239 : Covered 2239 2240 := one (i := 2239) (by rw [phi2239]; decide)
private theorem j2238x2240 : Covered 2238 2240 := join c2238 c2239
private theorem j2236x2240 : Covered 2236 2240 := join j2236x2238 j2238x2240
private theorem phi70 : Nat.totient 70 = 24 := step (p := 2) (m := 35) (by decide +kernel) (by decide) phi35 (by decide +kernel)
private theorem phi140 : Nat.totient 140 = 48 := step (p := 2) (m := 70) (by decide +kernel) (by decide) phi70 (by decide +kernel)
private theorem phi280 : Nat.totient 280 = 96 := step (p := 2) (m := 140) (by decide +kernel) (by decide) phi140 (by decide +kernel)
private theorem phi560 : Nat.totient 560 = 192 := step (p := 2) (m := 280) (by decide +kernel) (by decide) phi280 (by decide +kernel)
private theorem phi1120 : Nat.totient 1120 = 384 := step (p := 2) (m := 560) (by decide +kernel) (by decide) phi560 (by decide +kernel)
private theorem phi2240 : Nat.totient 2240 = 768 := step (p := 2) (m := 1120) (by decide +kernel) (by decide) phi1120 (by decide +kernel)
private theorem c2240 : Covered 2240 2241 := one (i := 2240) (by rw [phi2240]; decide)
private theorem phi249 : Nat.totient 249 = 164 := step (p := 3) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem phi747 : Nat.totient 747 = 492 := step (p := 3) (m := 249) (by decide +kernel) (by decide) phi249 (by decide +kernel)
private theorem phi2241 : Nat.totient 2241 = 1476 := step (p := 3) (m := 747) (by decide +kernel) (by decide) phi747 (by decide +kernel)
private theorem c2241 : Covered 2241 2242 := one (i := 2241) (by rw [phi2241]; decide)
private theorem j2240x2242 : Covered 2240 2242 := join c2240 c2241
private theorem phi1121 : Nat.totient 1121 = 1044 := step (p := 19) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi2242 : Nat.totient 2242 = 1044 := step (p := 2) (m := 1121) (by decide +kernel) (by decide) phi1121 (by decide +kernel)
private theorem c2242 : Covered 2242 2243 := one (i := 2242) (by rw [phi2242]; decide)
private theorem phi2243 : Nat.totient 2243 = 2242 := step (p := 2243) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2243 : Covered 2243 2244 := one (i := 2243) (by rw [phi2243]; decide)
private theorem j2242x2244 : Covered 2242 2244 := join c2242 c2243
private theorem j2240x2244 : Covered 2240 2244 := join j2240x2242 j2242x2244
private theorem j2236x2244 : Covered 2236 2244 := join j2236x2240 j2240x2244
private theorem j2229x2244 : Covered 2229 2244 := join j2229x2236 j2236x2244
private theorem j2215x2244 : Covered 2215 2244 := join j2215x2229 j2229x2244
private theorem phi187 : Nat.totient 187 = 160 := step (p := 11) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi561 : Nat.totient 561 = 320 := step (p := 3) (m := 187) (by decide +kernel) (by decide) phi187 (by decide +kernel)
private theorem phi1122 : Nat.totient 1122 = 320 := step (p := 2) (m := 561) (by decide +kernel) (by decide) phi561 (by decide +kernel)
private theorem phi2244 : Nat.totient 2244 = 640 := step (p := 2) (m := 1122) (by decide +kernel) (by decide) phi1122 (by decide +kernel)
private theorem c2244 : Covered 2244 2245 := one (i := 2244) (by rw [phi2244]; decide)
private theorem phi449 : Nat.totient 449 = 448 := step (p := 449) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2245 : Nat.totient 2245 = 1792 := step (p := 5) (m := 449) (by decide +kernel) (by decide) phi449 (by decide +kernel)
private theorem c2245 : Covered 2245 2246 := one (i := 2245) (by rw [phi2245]; decide)
private theorem phi1123 : Nat.totient 1123 = 1122 := step (p := 1123) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2246 : Nat.totient 2246 = 1122 := step (p := 2) (m := 1123) (by decide +kernel) (by decide) phi1123 (by decide +kernel)
private theorem c2246 : Covered 2246 2247 := one (i := 2246) (by rw [phi2246]; decide)
private theorem j2245x2247 : Covered 2245 2247 := join c2245 c2246
private theorem j2244x2247 : Covered 2244 2247 := join c2244 j2245x2247
private theorem phi749 : Nat.totient 749 = 636 := step (p := 7) (m := 107) (by decide +kernel) (by decide) phi107 (by decide +kernel)
private theorem phi2247 : Nat.totient 2247 = 1272 := step (p := 3) (m := 749) (by decide +kernel) (by decide) phi749 (by decide +kernel)
private theorem c2247 : Covered 2247 2248 := one (i := 2247) (by rw [phi2247]; decide)
private theorem phi281 : Nat.totient 281 = 280 := step (p := 281) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi562 : Nat.totient 562 = 280 := step (p := 2) (m := 281) (by decide +kernel) (by decide) phi281 (by decide +kernel)
private theorem phi1124 : Nat.totient 1124 = 560 := step (p := 2) (m := 562) (by decide +kernel) (by decide) phi562 (by decide +kernel)
private theorem phi2248 : Nat.totient 2248 = 1120 := step (p := 2) (m := 1124) (by decide +kernel) (by decide) phi1124 (by decide +kernel)
private theorem c2248 : Covered 2248 2249 := one (i := 2248) (by rw [phi2248]; decide)
private theorem j2247x2249 : Covered 2247 2249 := join c2247 c2248
private theorem phi173 : Nat.totient 173 = 172 := step (p := 173) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2249 : Nat.totient 2249 = 2064 := step (p := 13) (m := 173) (by decide +kernel) (by decide) phi173 (by decide +kernel)
private theorem c2249 : Covered 2249 2250 := one (i := 2249) (by rw [phi2249]; decide)
private theorem phi25 : Nat.totient 25 = 20 := step (p := 5) (m := 5) (by decide +kernel) (by decide) phi5 (by decide +kernel)
private theorem phi125 : Nat.totient 125 = 100 := step (p := 5) (m := 25) (by decide +kernel) (by decide) phi25 (by decide +kernel)
private theorem phi375 : Nat.totient 375 = 200 := step (p := 3) (m := 125) (by decide +kernel) (by decide) phi125 (by decide +kernel)
private theorem phi1125 : Nat.totient 1125 = 600 := step (p := 3) (m := 375) (by decide +kernel) (by decide) phi375 (by decide +kernel)
private theorem phi2250 : Nat.totient 2250 = 600 := step (p := 2) (m := 1125) (by decide +kernel) (by decide) phi1125 (by decide +kernel)
private theorem c2250 : Covered 2250 2251 := one (i := 2250) (by rw [phi2250]; decide)
private theorem j2249x2251 : Covered 2249 2251 := join c2249 c2250
private theorem j2247x2251 : Covered 2247 2251 := join j2247x2249 j2249x2251
private theorem j2244x2251 : Covered 2244 2251 := join j2244x2247 j2247x2251
private theorem phi2251 : Nat.totient 2251 = 2250 := step (p := 2251) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2251 : Covered 2251 2252 := one (i := 2251) (by rw [phi2251]; decide)
private theorem phi563 : Nat.totient 563 = 562 := step (p := 563) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1126 : Nat.totient 1126 = 562 := step (p := 2) (m := 563) (by decide +kernel) (by decide) phi563 (by decide +kernel)
private theorem phi2252 : Nat.totient 2252 = 1124 := step (p := 2) (m := 1126) (by decide +kernel) (by decide) phi1126 (by decide +kernel)
private theorem c2252 : Covered 2252 2253 := one (i := 2252) (by rw [phi2252]; decide)
private theorem phi751 : Nat.totient 751 = 750 := step (p := 751) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2253 : Nat.totient 2253 = 1500 := step (p := 3) (m := 751) (by decide +kernel) (by decide) phi751 (by decide +kernel)
private theorem c2253 : Covered 2253 2254 := one (i := 2253) (by rw [phi2253]; decide)
private theorem j2252x2254 : Covered 2252 2254 := join c2252 c2253
private theorem j2251x2254 : Covered 2251 2254 := join c2251 j2252x2254
private theorem phi161 : Nat.totient 161 = 132 := step (p := 7) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi1127 : Nat.totient 1127 = 924 := step (p := 7) (m := 161) (by decide +kernel) (by decide) phi161 (by decide +kernel)
private theorem phi2254 : Nat.totient 2254 = 924 := step (p := 2) (m := 1127) (by decide +kernel) (by decide) phi1127 (by decide +kernel)
private theorem c2254 : Covered 2254 2255 := one (i := 2254) (by rw [phi2254]; decide)
private theorem phi451 : Nat.totient 451 = 400 := step (p := 11) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi2255 : Nat.totient 2255 = 1600 := step (p := 5) (m := 451) (by decide +kernel) (by decide) phi451 (by decide +kernel)
private theorem c2255 : Covered 2255 2256 := one (i := 2255) (by rw [phi2255]; decide)
private theorem j2254x2256 : Covered 2254 2256 := join c2254 c2255
private theorem phi141 : Nat.totient 141 = 92 := step (p := 3) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi282 : Nat.totient 282 = 92 := step (p := 2) (m := 141) (by decide +kernel) (by decide) phi141 (by decide +kernel)
private theorem phi564 : Nat.totient 564 = 184 := step (p := 2) (m := 282) (by decide +kernel) (by decide) phi282 (by decide +kernel)
private theorem phi1128 : Nat.totient 1128 = 368 := step (p := 2) (m := 564) (by decide +kernel) (by decide) phi564 (by decide +kernel)
private theorem phi2256 : Nat.totient 2256 = 736 := step (p := 2) (m := 1128) (by decide +kernel) (by decide) phi1128 (by decide +kernel)
private theorem c2256 : Covered 2256 2257 := one (i := 2256) (by rw [phi2256]; decide)
private theorem phi2257 : Nat.totient 2257 = 2160 := step (p := 37) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem c2257 : Covered 2257 2258 := one (i := 2257) (by rw [phi2257]; decide)
private theorem j2256x2258 : Covered 2256 2258 := join c2256 c2257
private theorem j2254x2258 : Covered 2254 2258 := join j2254x2256 j2256x2258
private theorem j2251x2258 : Covered 2251 2258 := join j2251x2254 j2254x2258
private theorem j2244x2258 : Covered 2244 2258 := join j2244x2251 j2251x2258
private theorem phi1129 : Nat.totient 1129 = 1128 := step (p := 1129) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2258 : Nat.totient 2258 = 1128 := step (p := 2) (m := 1129) (by decide +kernel) (by decide) phi1129 (by decide +kernel)
private theorem c2258 : Covered 2258 2259 := one (i := 2258) (by rw [phi2258]; decide)
private theorem phi251 : Nat.totient 251 = 250 := step (p := 251) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi753 : Nat.totient 753 = 500 := step (p := 3) (m := 251) (by decide +kernel) (by decide) phi251 (by decide +kernel)
private theorem phi2259 : Nat.totient 2259 = 1500 := step (p := 3) (m := 753) (by decide +kernel) (by decide) phi753 (by decide +kernel)
private theorem c2259 : Covered 2259 2260 := one (i := 2259) (by rw [phi2259]; decide)
private theorem phi565 : Nat.totient 565 = 448 := step (p := 5) (m := 113) (by decide +kernel) (by decide) phi113 (by decide +kernel)
private theorem phi1130 : Nat.totient 1130 = 448 := step (p := 2) (m := 565) (by decide +kernel) (by decide) phi565 (by decide +kernel)
private theorem phi2260 : Nat.totient 2260 = 896 := step (p := 2) (m := 1130) (by decide +kernel) (by decide) phi1130 (by decide +kernel)
private theorem c2260 : Covered 2260 2261 := one (i := 2260) (by rw [phi2260]; decide)
private theorem j2259x2261 : Covered 2259 2261 := join c2259 c2260
private theorem j2258x2261 : Covered 2258 2261 := join c2258 j2259x2261
private theorem phi323 : Nat.totient 323 = 288 := step (p := 17) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi2261 : Nat.totient 2261 = 1728 := step (p := 7) (m := 323) (by decide +kernel) (by decide) phi323 (by decide +kernel)
private theorem c2261 : Covered 2261 2262 := one (i := 2261) (by rw [phi2261]; decide)
private theorem phi377 : Nat.totient 377 = 336 := step (p := 13) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi1131 : Nat.totient 1131 = 672 := step (p := 3) (m := 377) (by decide +kernel) (by decide) phi377 (by decide +kernel)
private theorem phi2262 : Nat.totient 2262 = 672 := step (p := 2) (m := 1131) (by decide +kernel) (by decide) phi1131 (by decide +kernel)
private theorem c2262 : Covered 2262 2263 := one (i := 2262) (by rw [phi2262]; decide)
private theorem j2261x2263 : Covered 2261 2263 := join c2261 c2262
private theorem phi2263 : Nat.totient 2263 = 2160 := step (p := 31) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem c2263 : Covered 2263 2264 := one (i := 2263) (by rw [phi2263]; decide)
private theorem phi283 : Nat.totient 283 = 282 := step (p := 283) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi566 : Nat.totient 566 = 282 := step (p := 2) (m := 283) (by decide +kernel) (by decide) phi283 (by decide +kernel)
private theorem phi1132 : Nat.totient 1132 = 564 := step (p := 2) (m := 566) (by decide +kernel) (by decide) phi566 (by decide +kernel)
private theorem phi2264 : Nat.totient 2264 = 1128 := step (p := 2) (m := 1132) (by decide +kernel) (by decide) phi1132 (by decide +kernel)
private theorem c2264 : Covered 2264 2265 := one (i := 2264) (by rw [phi2264]; decide)
private theorem j2263x2265 : Covered 2263 2265 := join c2263 c2264
private theorem j2261x2265 : Covered 2261 2265 := join j2261x2263 j2263x2265
private theorem j2258x2265 : Covered 2258 2265 := join j2258x2261 j2261x2265
private theorem phi755 : Nat.totient 755 = 600 := step (p := 5) (m := 151) (by decide +kernel) (by decide) phi151 (by decide +kernel)
private theorem phi2265 : Nat.totient 2265 = 1200 := step (p := 3) (m := 755) (by decide +kernel) (by decide) phi755 (by decide +kernel)
private theorem c2265 : Covered 2265 2266 := one (i := 2265) (by rw [phi2265]; decide)
private theorem phi1133 : Nat.totient 1133 = 1020 := step (p := 11) (m := 103) (by decide +kernel) (by decide) phi103 (by decide +kernel)
private theorem phi2266 : Nat.totient 2266 = 1020 := step (p := 2) (m := 1133) (by decide +kernel) (by decide) phi1133 (by decide +kernel)
private theorem c2266 : Covered 2266 2267 := one (i := 2266) (by rw [phi2266]; decide)
private theorem j2265x2267 : Covered 2265 2267 := join c2265 c2266
private theorem phi2267 : Nat.totient 2267 = 2266 := step (p := 2267) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2267 : Covered 2267 2268 := one (i := 2267) (by rw [phi2267]; decide)
private theorem phi21 : Nat.totient 21 = 12 := step (p := 3) (m := 7) (by decide +kernel) (by decide) phi7 (by decide +kernel)
private theorem phi63 : Nat.totient 63 = 36 := step (p := 3) (m := 21) (by decide +kernel) (by decide) phi21 (by decide +kernel)
private theorem phi189 : Nat.totient 189 = 108 := step (p := 3) (m := 63) (by decide +kernel) (by decide) phi63 (by decide +kernel)
private theorem phi567 : Nat.totient 567 = 324 := step (p := 3) (m := 189) (by decide +kernel) (by decide) phi189 (by decide +kernel)
private theorem phi1134 : Nat.totient 1134 = 324 := step (p := 2) (m := 567) (by decide +kernel) (by decide) phi567 (by decide +kernel)
private theorem phi2268 : Nat.totient 2268 = 648 := step (p := 2) (m := 1134) (by decide +kernel) (by decide) phi1134 (by decide +kernel)
private theorem c2268 : Covered 2268 2269 := one (i := 2268) (by rw [phi2268]; decide)
private theorem j2267x2269 : Covered 2267 2269 := join c2267 c2268
private theorem j2265x2269 : Covered 2265 2269 := join j2265x2267 j2267x2269
private theorem phi2269 : Nat.totient 2269 = 2268 := step (p := 2269) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2269 : Covered 2269 2270 := one (i := 2269) (by rw [phi2269]; decide)
private theorem phi227 : Nat.totient 227 = 226 := step (p := 227) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1135 : Nat.totient 1135 = 904 := step (p := 5) (m := 227) (by decide +kernel) (by decide) phi227 (by decide +kernel)
private theorem phi2270 : Nat.totient 2270 = 904 := step (p := 2) (m := 1135) (by decide +kernel) (by decide) phi1135 (by decide +kernel)
private theorem c2270 : Covered 2270 2271 := one (i := 2270) (by rw [phi2270]; decide)
private theorem j2269x2271 : Covered 2269 2271 := join c2269 c2270
private theorem phi757 : Nat.totient 757 = 756 := step (p := 757) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2271 : Nat.totient 2271 = 1512 := step (p := 3) (m := 757) (by decide +kernel) (by decide) phi757 (by decide +kernel)
private theorem c2271 : Covered 2271 2272 := one (i := 2271) (by rw [phi2271]; decide)
private theorem phi142 : Nat.totient 142 = 70 := step (p := 2) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem phi284 : Nat.totient 284 = 140 := step (p := 2) (m := 142) (by decide +kernel) (by decide) phi142 (by decide +kernel)
private theorem phi568 : Nat.totient 568 = 280 := step (p := 2) (m := 284) (by decide +kernel) (by decide) phi284 (by decide +kernel)
private theorem phi1136 : Nat.totient 1136 = 560 := step (p := 2) (m := 568) (by decide +kernel) (by decide) phi568 (by decide +kernel)
private theorem phi2272 : Nat.totient 2272 = 1120 := step (p := 2) (m := 1136) (by decide +kernel) (by decide) phi1136 (by decide +kernel)
private theorem c2272 : Covered 2272 2273 := one (i := 2272) (by rw [phi2272]; decide)
private theorem j2271x2273 : Covered 2271 2273 := join c2271 c2272
private theorem j2269x2273 : Covered 2269 2273 := join j2269x2271 j2271x2273
private theorem j2265x2273 : Covered 2265 2273 := join j2265x2269 j2269x2273
private theorem j2258x2273 : Covered 2258 2273 := join j2258x2265 j2265x2273
private theorem j2244x2273 : Covered 2244 2273 := join j2244x2258 j2258x2273
private theorem j2215x2273 : Covered 2215 2273 := join j2215x2244 j2244x2273
private theorem phi2273 : Nat.totient 2273 = 2272 := step (p := 2273) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2273 : Covered 2273 2274 := one (i := 2273) (by rw [phi2273]; decide)
private theorem phi379 : Nat.totient 379 = 378 := step (p := 379) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1137 : Nat.totient 1137 = 756 := step (p := 3) (m := 379) (by decide +kernel) (by decide) phi379 (by decide +kernel)
private theorem phi2274 : Nat.totient 2274 = 756 := step (p := 2) (m := 1137) (by decide +kernel) (by decide) phi1137 (by decide +kernel)
private theorem c2274 : Covered 2274 2275 := one (i := 2274) (by rw [phi2274]; decide)
private theorem phi455 : Nat.totient 455 = 288 := step (p := 5) (m := 91) (by decide +kernel) (by decide) phi91 (by decide +kernel)
private theorem phi2275 : Nat.totient 2275 = 1440 := step (p := 5) (m := 455) (by decide +kernel) (by decide) phi455 (by decide +kernel)
private theorem c2275 : Covered 2275 2276 := one (i := 2275) (by rw [phi2275]; decide)
private theorem j2274x2276 : Covered 2274 2276 := join c2274 c2275
private theorem j2273x2276 : Covered 2273 2276 := join c2273 j2274x2276
private theorem phi569 : Nat.totient 569 = 568 := step (p := 569) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1138 : Nat.totient 1138 = 568 := step (p := 2) (m := 569) (by decide +kernel) (by decide) phi569 (by decide +kernel)
private theorem phi2276 : Nat.totient 2276 = 1136 := step (p := 2) (m := 1138) (by decide +kernel) (by decide) phi1138 (by decide +kernel)
private theorem c2276 : Covered 2276 2277 := one (i := 2276) (by rw [phi2276]; decide)
private theorem phi253 : Nat.totient 253 = 220 := step (p := 11) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi759 : Nat.totient 759 = 440 := step (p := 3) (m := 253) (by decide +kernel) (by decide) phi253 (by decide +kernel)
private theorem phi2277 : Nat.totient 2277 = 1320 := step (p := 3) (m := 759) (by decide +kernel) (by decide) phi759 (by decide +kernel)
private theorem c2277 : Covered 2277 2278 := one (i := 2277) (by rw [phi2277]; decide)
private theorem j2276x2278 : Covered 2276 2278 := join c2276 c2277
private theorem phi1139 : Nat.totient 1139 = 1056 := step (p := 17) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi2278 : Nat.totient 2278 = 1056 := step (p := 2) (m := 1139) (by decide +kernel) (by decide) phi1139 (by decide +kernel)
private theorem c2278 : Covered 2278 2279 := one (i := 2278) (by rw [phi2278]; decide)
private theorem phi2279 : Nat.totient 2279 = 2184 := step (p := 43) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem c2279 : Covered 2279 2280 := one (i := 2279) (by rw [phi2279]; decide)
private theorem j2278x2280 : Covered 2278 2280 := join c2278 c2279
private theorem j2276x2280 : Covered 2276 2280 := join j2276x2278 j2278x2280
private theorem j2273x2280 : Covered 2273 2280 := join j2273x2276 j2276x2280
private theorem phi95 : Nat.totient 95 = 72 := step (p := 5) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi285 : Nat.totient 285 = 144 := step (p := 3) (m := 95) (by decide +kernel) (by decide) phi95 (by decide +kernel)
private theorem phi570 : Nat.totient 570 = 144 := step (p := 2) (m := 285) (by decide +kernel) (by decide) phi285 (by decide +kernel)
private theorem phi1140 : Nat.totient 1140 = 288 := step (p := 2) (m := 570) (by decide +kernel) (by decide) phi570 (by decide +kernel)
private theorem phi2280 : Nat.totient 2280 = 576 := step (p := 2) (m := 1140) (by decide +kernel) (by decide) phi1140 (by decide +kernel)
private theorem c2280 : Covered 2280 2281 := one (i := 2280) (by rw [phi2280]; decide)
private theorem phi2281 : Nat.totient 2281 = 2280 := step (p := 2281) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2281 : Covered 2281 2282 := one (i := 2281) (by rw [phi2281]; decide)
private theorem phi1141 : Nat.totient 1141 = 972 := step (p := 7) (m := 163) (by decide +kernel) (by decide) phi163 (by decide +kernel)
private theorem phi2282 : Nat.totient 2282 = 972 := step (p := 2) (m := 1141) (by decide +kernel) (by decide) phi1141 (by decide +kernel)
private theorem c2282 : Covered 2282 2283 := one (i := 2282) (by rw [phi2282]; decide)
private theorem j2281x2283 : Covered 2281 2283 := join c2281 c2282
private theorem j2280x2283 : Covered 2280 2283 := join c2280 j2281x2283
private theorem phi761 : Nat.totient 761 = 760 := step (p := 761) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2283 : Nat.totient 2283 = 1520 := step (p := 3) (m := 761) (by decide +kernel) (by decide) phi761 (by decide +kernel)
private theorem c2283 : Covered 2283 2284 := one (i := 2283) (by rw [phi2283]; decide)
private theorem phi571 : Nat.totient 571 = 570 := step (p := 571) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1142 : Nat.totient 1142 = 570 := step (p := 2) (m := 571) (by decide +kernel) (by decide) phi571 (by decide +kernel)
private theorem phi2284 : Nat.totient 2284 = 1140 := step (p := 2) (m := 1142) (by decide +kernel) (by decide) phi1142 (by decide +kernel)
private theorem c2284 : Covered 2284 2285 := one (i := 2284) (by rw [phi2284]; decide)
private theorem j2283x2285 : Covered 2283 2285 := join c2283 c2284
private theorem phi457 : Nat.totient 457 = 456 := step (p := 457) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2285 : Nat.totient 2285 = 1824 := step (p := 5) (m := 457) (by decide +kernel) (by decide) phi457 (by decide +kernel)
private theorem c2285 : Covered 2285 2286 := one (i := 2285) (by rw [phi2285]; decide)
private theorem phi381 : Nat.totient 381 = 252 := step (p := 3) (m := 127) (by decide +kernel) (by decide) phi127 (by decide +kernel)
private theorem phi1143 : Nat.totient 1143 = 756 := step (p := 3) (m := 381) (by decide +kernel) (by decide) phi381 (by decide +kernel)
private theorem phi2286 : Nat.totient 2286 = 756 := step (p := 2) (m := 1143) (by decide +kernel) (by decide) phi1143 (by decide +kernel)
private theorem c2286 : Covered 2286 2287 := one (i := 2286) (by rw [phi2286]; decide)
private theorem j2285x2287 : Covered 2285 2287 := join c2285 c2286
private theorem j2283x2287 : Covered 2283 2287 := join j2283x2285 j2285x2287
private theorem j2280x2287 : Covered 2280 2287 := join j2280x2283 j2283x2287
private theorem j2273x2287 : Covered 2273 2287 := join j2273x2280 j2280x2287
private theorem phi2287 : Nat.totient 2287 = 2286 := step (p := 2287) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2287 : Covered 2287 2288 := one (i := 2287) (by rw [phi2287]; decide)
private theorem phi286 : Nat.totient 286 = 120 := step (p := 2) (m := 143) (by decide +kernel) (by decide) phi143 (by decide +kernel)
private theorem phi572 : Nat.totient 572 = 240 := step (p := 2) (m := 286) (by decide +kernel) (by decide) phi286 (by decide +kernel)
private theorem phi1144 : Nat.totient 1144 = 480 := step (p := 2) (m := 572) (by decide +kernel) (by decide) phi572 (by decide +kernel)
private theorem phi2288 : Nat.totient 2288 = 960 := step (p := 2) (m := 1144) (by decide +kernel) (by decide) phi1144 (by decide +kernel)
private theorem c2288 : Covered 2288 2289 := one (i := 2288) (by rw [phi2288]; decide)
private theorem phi763 : Nat.totient 763 = 648 := step (p := 7) (m := 109) (by decide +kernel) (by decide) phi109 (by decide +kernel)
private theorem phi2289 : Nat.totient 2289 = 1296 := step (p := 3) (m := 763) (by decide +kernel) (by decide) phi763 (by decide +kernel)
private theorem c2289 : Covered 2289 2290 := one (i := 2289) (by rw [phi2289]; decide)
private theorem j2288x2290 : Covered 2288 2290 := join c2288 c2289
private theorem j2287x2290 : Covered 2287 2290 := join c2287 j2288x2290
private theorem phi229 : Nat.totient 229 = 228 := step (p := 229) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1145 : Nat.totient 1145 = 912 := step (p := 5) (m := 229) (by decide +kernel) (by decide) phi229 (by decide +kernel)
private theorem phi2290 : Nat.totient 2290 = 912 := step (p := 2) (m := 1145) (by decide +kernel) (by decide) phi1145 (by decide +kernel)
private theorem c2290 : Covered 2290 2291 := one (i := 2290) (by rw [phi2290]; decide)
private theorem phi2291 : Nat.totient 2291 = 2184 := step (p := 29) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem c2291 : Covered 2291 2292 := one (i := 2291) (by rw [phi2291]; decide)
private theorem j2290x2292 : Covered 2290 2292 := join c2290 c2291
private theorem phi573 : Nat.totient 573 = 380 := step (p := 3) (m := 191) (by decide +kernel) (by decide) phi191 (by decide +kernel)
private theorem phi1146 : Nat.totient 1146 = 380 := step (p := 2) (m := 573) (by decide +kernel) (by decide) phi573 (by decide +kernel)
private theorem phi2292 : Nat.totient 2292 = 760 := step (p := 2) (m := 1146) (by decide +kernel) (by decide) phi1146 (by decide +kernel)
private theorem c2292 : Covered 2292 2293 := one (i := 2292) (by rw [phi2292]; decide)
private theorem phi2293 : Nat.totient 2293 = 2292 := step (p := 2293) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2293 : Covered 2293 2294 := one (i := 2293) (by rw [phi2293]; decide)
private theorem j2292x2294 : Covered 2292 2294 := join c2292 c2293
private theorem j2290x2294 : Covered 2290 2294 := join j2290x2292 j2292x2294
private theorem j2287x2294 : Covered 2287 2294 := join j2287x2290 j2290x2294
private theorem phi1147 : Nat.totient 1147 = 1080 := step (p := 31) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi2294 : Nat.totient 2294 = 1080 := step (p := 2) (m := 1147) (by decide +kernel) (by decide) phi1147 (by decide +kernel)
private theorem c2294 : Covered 2294 2295 := one (i := 2294) (by rw [phi2294]; decide)
private theorem phi255 : Nat.totient 255 = 128 := step (p := 3) (m := 85) (by decide +kernel) (by decide) phi85 (by decide +kernel)
private theorem phi765 : Nat.totient 765 = 384 := step (p := 3) (m := 255) (by decide +kernel) (by decide) phi255 (by decide +kernel)
private theorem phi2295 : Nat.totient 2295 = 1152 := step (p := 3) (m := 765) (by decide +kernel) (by decide) phi765 (by decide +kernel)
private theorem c2295 : Covered 2295 2296 := one (i := 2295) (by rw [phi2295]; decide)
private theorem j2294x2296 : Covered 2294 2296 := join c2294 c2295
private theorem phi287 : Nat.totient 287 = 240 := step (p := 7) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi574 : Nat.totient 574 = 240 := step (p := 2) (m := 287) (by decide +kernel) (by decide) phi287 (by decide +kernel)
private theorem phi1148 : Nat.totient 1148 = 480 := step (p := 2) (m := 574) (by decide +kernel) (by decide) phi574 (by decide +kernel)
private theorem phi2296 : Nat.totient 2296 = 960 := step (p := 2) (m := 1148) (by decide +kernel) (by decide) phi1148 (by decide +kernel)
private theorem c2296 : Covered 2296 2297 := one (i := 2296) (by rw [phi2296]; decide)
private theorem phi2297 : Nat.totient 2297 = 2296 := step (p := 2297) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2297 : Covered 2297 2298 := one (i := 2297) (by rw [phi2297]; decide)
private theorem j2296x2298 : Covered 2296 2298 := join c2296 c2297
private theorem j2294x2298 : Covered 2294 2298 := join j2294x2296 j2296x2298
private theorem phi383 : Nat.totient 383 = 382 := step (p := 383) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1149 : Nat.totient 1149 = 764 := step (p := 3) (m := 383) (by decide +kernel) (by decide) phi383 (by decide +kernel)
private theorem phi2298 : Nat.totient 2298 = 764 := step (p := 2) (m := 1149) (by decide +kernel) (by decide) phi1149 (by decide +kernel)
private theorem c2298 : Covered 2298 2299 := one (i := 2298) (by rw [phi2298]; decide)
private theorem phi209 : Nat.totient 209 = 180 := step (p := 11) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi2299 : Nat.totient 2299 = 1980 := step (p := 11) (m := 209) (by decide +kernel) (by decide) phi209 (by decide +kernel)
private theorem c2299 : Covered 2299 2300 := one (i := 2299) (by rw [phi2299]; decide)
private theorem j2298x2300 : Covered 2298 2300 := join c2298 c2299
private theorem phi115 : Nat.totient 115 = 88 := step (p := 5) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi575 : Nat.totient 575 = 440 := step (p := 5) (m := 115) (by decide +kernel) (by decide) phi115 (by decide +kernel)
private theorem phi1150 : Nat.totient 1150 = 440 := step (p := 2) (m := 575) (by decide +kernel) (by decide) phi575 (by decide +kernel)
private theorem phi2300 : Nat.totient 2300 = 880 := step (p := 2) (m := 1150) (by decide +kernel) (by decide) phi1150 (by decide +kernel)
private theorem c2300 : Covered 2300 2301 := one (i := 2300) (by rw [phi2300]; decide)
private theorem phi767 : Nat.totient 767 = 696 := step (p := 13) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi2301 : Nat.totient 2301 = 1392 := step (p := 3) (m := 767) (by decide +kernel) (by decide) phi767 (by decide +kernel)
private theorem c2301 : Covered 2301 2302 := one (i := 2301) (by rw [phi2301]; decide)
private theorem j2300x2302 : Covered 2300 2302 := join c2300 c2301
private theorem j2298x2302 : Covered 2298 2302 := join j2298x2300 j2300x2302
private theorem j2294x2302 : Covered 2294 2302 := join j2294x2298 j2298x2302
private theorem j2287x2302 : Covered 2287 2302 := join j2287x2294 j2294x2302
private theorem j2273x2302 : Covered 2273 2302 := join j2273x2287 j2287x2302
private theorem phi1151 : Nat.totient 1151 = 1150 := step (p := 1151) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2302 : Nat.totient 2302 = 1150 := step (p := 2) (m := 1151) (by decide +kernel) (by decide) phi1151 (by decide +kernel)
private theorem c2302 : Covered 2302 2303 := one (i := 2302) (by rw [phi2302]; decide)
private theorem phi329 : Nat.totient 329 = 276 := step (p := 7) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi2303 : Nat.totient 2303 = 1932 := step (p := 7) (m := 329) (by decide +kernel) (by decide) phi329 (by decide +kernel)
private theorem c2303 : Covered 2303 2304 := one (i := 2303) (by rw [phi2303]; decide)
private theorem phi18 : Nat.totient 18 = 6 := step (p := 2) (m := 9) (by decide +kernel) (by decide) phi9 (by decide +kernel)
private theorem phi36 : Nat.totient 36 = 12 := step (p := 2) (m := 18) (by decide +kernel) (by decide) phi18 (by decide +kernel)
private theorem phi72 : Nat.totient 72 = 24 := step (p := 2) (m := 36) (by decide +kernel) (by decide) phi36 (by decide +kernel)
private theorem phi144 : Nat.totient 144 = 48 := step (p := 2) (m := 72) (by decide +kernel) (by decide) phi72 (by decide +kernel)
private theorem phi288 : Nat.totient 288 = 96 := step (p := 2) (m := 144) (by decide +kernel) (by decide) phi144 (by decide +kernel)
private theorem phi576 : Nat.totient 576 = 192 := step (p := 2) (m := 288) (by decide +kernel) (by decide) phi288 (by decide +kernel)
private theorem phi1152 : Nat.totient 1152 = 384 := step (p := 2) (m := 576) (by decide +kernel) (by decide) phi576 (by decide +kernel)
private theorem phi2304 : Nat.totient 2304 = 768 := step (p := 2) (m := 1152) (by decide +kernel) (by decide) phi1152 (by decide +kernel)
private theorem c2304 : Covered 2304 2305 := one (i := 2304) (by rw [phi2304]; decide)
private theorem j2303x2305 : Covered 2303 2305 := join c2303 c2304
private theorem j2302x2305 : Covered 2302 2305 := join c2302 j2303x2305
private theorem phi461 : Nat.totient 461 = 460 := step (p := 461) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2305 : Nat.totient 2305 = 1840 := step (p := 5) (m := 461) (by decide +kernel) (by decide) phi461 (by decide +kernel)
private theorem c2305 : Covered 2305 2306 := one (i := 2305) (by rw [phi2305]; decide)
private theorem phi1153 : Nat.totient 1153 = 1152 := step (p := 1153) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2306 : Nat.totient 2306 = 1152 := step (p := 2) (m := 1153) (by decide +kernel) (by decide) phi1153 (by decide +kernel)
private theorem c2306 : Covered 2306 2307 := one (i := 2306) (by rw [phi2306]; decide)
private theorem j2305x2307 : Covered 2305 2307 := join c2305 c2306
private theorem phi769 : Nat.totient 769 = 768 := step (p := 769) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2307 : Nat.totient 2307 = 1536 := step (p := 3) (m := 769) (by decide +kernel) (by decide) phi769 (by decide +kernel)
private theorem c2307 : Covered 2307 2308 := one (i := 2307) (by rw [phi2307]; decide)
private theorem phi577 : Nat.totient 577 = 576 := step (p := 577) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1154 : Nat.totient 1154 = 576 := step (p := 2) (m := 577) (by decide +kernel) (by decide) phi577 (by decide +kernel)
private theorem phi2308 : Nat.totient 2308 = 1152 := step (p := 2) (m := 1154) (by decide +kernel) (by decide) phi1154 (by decide +kernel)
private theorem c2308 : Covered 2308 2309 := one (i := 2308) (by rw [phi2308]; decide)
private theorem j2307x2309 : Covered 2307 2309 := join c2307 c2308
private theorem j2305x2309 : Covered 2305 2309 := join j2305x2307 j2307x2309
private theorem j2302x2309 : Covered 2302 2309 := join j2302x2305 j2305x2309
private theorem phi2309 : Nat.totient 2309 = 2308 := step (p := 2309) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2309 : Covered 2309 2310 := one (i := 2309) (by rw [phi2309]; decide)
private theorem phi385 : Nat.totient 385 = 240 := step (p := 5) (m := 77) (by decide +kernel) (by decide) phi77 (by decide +kernel)
private theorem phi1155 : Nat.totient 1155 = 480 := step (p := 3) (m := 385) (by decide +kernel) (by decide) phi385 (by decide +kernel)
private theorem phi2310 : Nat.totient 2310 = 480 := step (p := 2) (m := 1155) (by decide +kernel) (by decide) phi1155 (by decide +kernel)
private theorem c2310 : Covered 2310 2311 := one (i := 2310) (by rw [phi2310]; decide)
private theorem phi2311 : Nat.totient 2311 = 2310 := step (p := 2311) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem c2311 : Covered 2311 2312 := one (i := 2311) (by rw [phi2311]; decide)
private theorem j2310x2312 : Covered 2310 2312 := join c2310 c2311
private theorem j2309x2312 : Covered 2309 2312 := join c2309 j2310x2312
private theorem phi289 : Nat.totient 289 = 272 := step (p := 17) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi578 : Nat.totient 578 = 272 := step (p := 2) (m := 289) (by decide +kernel) (by decide) phi289 (by decide +kernel)
private theorem phi1156 : Nat.totient 1156 = 544 := step (p := 2) (m := 578) (by decide +kernel) (by decide) phi578 (by decide +kernel)
private theorem phi2312 : Nat.totient 2312 = 1088 := step (p := 2) (m := 1156) (by decide +kernel) (by decide) phi1156 (by decide +kernel)
private theorem c2312 : Covered 2312 2313 := one (i := 2312) (by rw [phi2312]; decide)
private theorem phi257 : Nat.totient 257 = 256 := step (p := 257) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi771 : Nat.totient 771 = 512 := step (p := 3) (m := 257) (by decide +kernel) (by decide) phi257 (by decide +kernel)
private theorem phi2313 : Nat.totient 2313 = 1536 := step (p := 3) (m := 771) (by decide +kernel) (by decide) phi771 (by decide +kernel)
private theorem c2313 : Covered 2313 2314 := one (i := 2313) (by rw [phi2313]; decide)
private theorem j2312x2314 : Covered 2312 2314 := join c2312 c2313
private theorem phi1157 : Nat.totient 1157 = 1056 := step (p := 13) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem phi2314 : Nat.totient 2314 = 1056 := step (p := 2) (m := 1157) (by decide +kernel) (by decide) phi1157 (by decide +kernel)
private theorem c2314 : Covered 2314 2315 := one (i := 2314) (by rw [phi2314]; decide)
private theorem phi463 : Nat.totient 463 = 462 := step (p := 463) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2315 : Nat.totient 2315 = 1848 := step (p := 5) (m := 463) (by decide +kernel) (by decide) phi463 (by decide +kernel)
private theorem c2315 : Covered 2315 2316 := one (i := 2315) (by rw [phi2315]; decide)
private theorem j2314x2316 : Covered 2314 2316 := join c2314 c2315
private theorem j2312x2316 : Covered 2312 2316 := join j2312x2314 j2314x2316
private theorem j2309x2316 : Covered 2309 2316 := join j2309x2312 j2312x2316
private theorem j2302x2316 : Covered 2302 2316 := join j2302x2309 j2309x2316
private theorem phi579 : Nat.totient 579 = 384 := step (p := 3) (m := 193) (by decide +kernel) (by decide) phi193 (by decide +kernel)
private theorem phi1158 : Nat.totient 1158 = 384 := step (p := 2) (m := 579) (by decide +kernel) (by decide) phi579 (by decide +kernel)
private theorem phi2316 : Nat.totient 2316 = 768 := step (p := 2) (m := 1158) (by decide +kernel) (by decide) phi1158 (by decide +kernel)
private theorem c2316 : Covered 2316 2317 := one (i := 2316) (by rw [phi2316]; decide)
private theorem phi331 : Nat.totient 331 = 330 := step (p := 331) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2317 : Nat.totient 2317 = 1980 := step (p := 7) (m := 331) (by decide +kernel) (by decide) phi331 (by decide +kernel)
private theorem c2317 : Covered 2317 2318 := one (i := 2317) (by rw [phi2317]; decide)
private theorem phi1159 : Nat.totient 1159 = 1080 := step (p := 19) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi2318 : Nat.totient 2318 = 1080 := step (p := 2) (m := 1159) (by decide +kernel) (by decide) phi1159 (by decide +kernel)
private theorem c2318 : Covered 2318 2319 := one (i := 2318) (by rw [phi2318]; decide)
private theorem j2317x2319 : Covered 2317 2319 := join c2317 c2318
private theorem j2316x2319 : Covered 2316 2319 := join c2316 j2317x2319
private theorem phi773 : Nat.totient 773 = 772 := step (p := 773) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2319 : Nat.totient 2319 = 1544 := step (p := 3) (m := 773) (by decide +kernel) (by decide) phi773 (by decide +kernel)
private theorem c2319 : Covered 2319 2320 := one (i := 2319) (by rw [phi2319]; decide)
private theorem phi290 : Nat.totient 290 = 112 := step (p := 2) (m := 145) (by decide +kernel) (by decide) phi145 (by decide +kernel)
private theorem phi580 : Nat.totient 580 = 224 := step (p := 2) (m := 290) (by decide +kernel) (by decide) phi290 (by decide +kernel)
private theorem phi1160 : Nat.totient 1160 = 448 := step (p := 2) (m := 580) (by decide +kernel) (by decide) phi580 (by decide +kernel)
private theorem phi2320 : Nat.totient 2320 = 896 := step (p := 2) (m := 1160) (by decide +kernel) (by decide) phi1160 (by decide +kernel)
private theorem c2320 : Covered 2320 2321 := one (i := 2320) (by rw [phi2320]; decide)
private theorem j2319x2321 : Covered 2319 2321 := join c2319 c2320
private theorem phi2321 : Nat.totient 2321 = 2100 := step (p := 11) (m := 211) (by decide +kernel) (by decide) phi211 (by decide +kernel)
private theorem c2321 : Covered 2321 2322 := one (i := 2321) (by rw [phi2321]; decide)
private theorem phi129 : Nat.totient 129 = 84 := step (p := 3) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi387 : Nat.totient 387 = 252 := step (p := 3) (m := 129) (by decide +kernel) (by decide) phi129 (by decide +kernel)
private theorem phi1161 : Nat.totient 1161 = 756 := step (p := 3) (m := 387) (by decide +kernel) (by decide) phi387 (by decide +kernel)
private theorem phi2322 : Nat.totient 2322 = 756 := step (p := 2) (m := 1161) (by decide +kernel) (by decide) phi1161 (by decide +kernel)
private theorem c2322 : Covered 2322 2323 := one (i := 2322) (by rw [phi2322]; decide)
private theorem j2321x2323 : Covered 2321 2323 := join c2321 c2322
private theorem j2319x2323 : Covered 2319 2323 := join j2319x2321 j2321x2323
private theorem j2316x2323 : Covered 2316 2323 := join j2316x2319 j2319x2323
private theorem phi2323 : Nat.totient 2323 = 2200 := step (p := 23) (m := 101) (by decide +kernel) (by decide) phi101 (by decide +kernel)
private theorem c2323 : Covered 2323 2324 := one (i := 2323) (by rw [phi2323]; decide)
private theorem phi581 : Nat.totient 581 = 492 := step (p := 7) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem phi1162 : Nat.totient 1162 = 492 := step (p := 2) (m := 581) (by decide +kernel) (by decide) phi581 (by decide +kernel)
private theorem phi2324 : Nat.totient 2324 = 984 := step (p := 2) (m := 1162) (by decide +kernel) (by decide) phi1162 (by decide +kernel)
private theorem c2324 : Covered 2324 2325 := one (i := 2324) (by rw [phi2324]; decide)
private theorem j2323x2325 : Covered 2323 2325 := join c2323 c2324
private theorem phi155 : Nat.totient 155 = 120 := step (p := 5) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi775 : Nat.totient 775 = 600 := step (p := 5) (m := 155) (by decide +kernel) (by decide) phi155 (by decide +kernel)
private theorem phi2325 : Nat.totient 2325 = 1200 := step (p := 3) (m := 775) (by decide +kernel) (by decide) phi775 (by decide +kernel)
private theorem c2325 : Covered 2325 2326 := one (i := 2325) (by rw [phi2325]; decide)
private theorem phi1163 : Nat.totient 1163 = 1162 := step (p := 1163) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2326 : Nat.totient 2326 = 1162 := step (p := 2) (m := 1163) (by decide +kernel) (by decide) phi1163 (by decide +kernel)
private theorem c2326 : Covered 2326 2327 := one (i := 2326) (by rw [phi2326]; decide)
private theorem j2325x2327 : Covered 2325 2327 := join c2325 c2326
private theorem j2323x2327 : Covered 2323 2327 := join j2323x2325 j2325x2327
private theorem phi2327 : Nat.totient 2327 = 2136 := step (p := 13) (m := 179) (by decide +kernel) (by decide) phi179 (by decide +kernel)
private theorem c2327 : Covered 2327 2328 := one (i := 2327) (by rw [phi2327]; decide)
private theorem phi291 : Nat.totient 291 = 192 := step (p := 3) (m := 97) (by decide +kernel) (by decide) phi97 (by decide +kernel)
private theorem phi582 : Nat.totient 582 = 192 := step (p := 2) (m := 291) (by decide +kernel) (by decide) phi291 (by decide +kernel)
private theorem phi1164 : Nat.totient 1164 = 384 := step (p := 2) (m := 582) (by decide +kernel) (by decide) phi582 (by decide +kernel)
private theorem phi2328 : Nat.totient 2328 = 768 := step (p := 2) (m := 1164) (by decide +kernel) (by decide) phi1164 (by decide +kernel)
private theorem c2328 : Covered 2328 2329 := one (i := 2328) (by rw [phi2328]; decide)
private theorem j2327x2329 : Covered 2327 2329 := join c2327 c2328
private theorem phi2329 : Nat.totient 2329 = 2176 := step (p := 17) (m := 137) (by decide +kernel) (by decide) phi137 (by decide +kernel)
private theorem c2329 : Covered 2329 2330 := one (i := 2329) (by rw [phi2329]; decide)
private theorem phi233 : Nat.totient 233 = 232 := step (p := 233) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1165 : Nat.totient 1165 = 928 := step (p := 5) (m := 233) (by decide +kernel) (by decide) phi233 (by decide +kernel)
private theorem phi2330 : Nat.totient 2330 = 928 := step (p := 2) (m := 1165) (by decide +kernel) (by decide) phi1165 (by decide +kernel)
private theorem c2330 : Covered 2330 2331 := one (i := 2330) (by rw [phi2330]; decide)
private theorem j2329x2331 : Covered 2329 2331 := join c2329 c2330
private theorem j2327x2331 : Covered 2327 2331 := join j2327x2329 j2329x2331
private theorem j2323x2331 : Covered 2323 2331 := join j2323x2327 j2327x2331
private theorem j2316x2331 : Covered 2316 2331 := join j2316x2323 j2323x2331
private theorem j2302x2331 : Covered 2302 2331 := join j2302x2316 j2316x2331
private theorem j2273x2331 : Covered 2273 2331 := join j2273x2302 j2302x2331
private theorem j2215x2331 : Covered 2215 2331 := join j2215x2273 j2273x2331
private theorem j2100x2331 : Covered 2100 2331 := join j2100x2215 j2215x2331
theorem lower_phi_ratio (q : ℕ) (hq : 2100 ≤ q) : 99*q < q.totient^2 := by
  by_cases h : q < 2331
  · exact j2100x2331 q hq h
  · have hh := phi_ratio q (by omega); omega
end LowerDenominators

theorem lower_principal_ratio {N : ℝ} (hn : 2*10^19 ≤ N) (q : ℕ)
    (hq : 1.1*(Real.log N)^2 < q) : Real.log N/(q.totient:ℝ) < 0.096 := by
  have hn0 : 0 < N := lt_of_lt_of_le (by norm_num) hn
  have hL : 44 ≤ Real.log N := by
    apply (Real.le_log_iff_exp_le hn0).mpr
    calc Real.exp 44 = Real.exp 1^44 := by rw [← Real.exp_nat_mul]; norm_num
         _ ≤ (2.7182818286:ℝ)^44 := pow_le_pow_left₀ (Real.exp_pos 1).le Real.exp_one_lt_d9.le _
         _ ≤ 2*10^19 := by norm_num
         _ ≤ _ := hn
  have hqi : 2100 ≤ q := by
    by_contra! hc
    have h' : (q:ℝ) ≤ 2099 := by exact_mod_cast (show q ≤ 2099 by omega)
    nlinarith [sq_nonneg (Real.log N-44)]
  have hφ : (99:ℝ)*q < (q.totient:ℝ)^2 := by exact_mod_cast LowerDenominators.lower_phi_ratio q hqi
  have hf : (0:ℝ)<q.totient := by exact_mod_cast (Nat.totient_pos.mpr (show 0<q by omega))
  rw [div_lt_iff₀ hf]
  by_contra! hu
  have hs := sq_le_sq' (show -(Real.log N) ≤ 0.096*(q.totient:ℝ) by linarith) hu
  nlinarith
#print axioms lower_principal_ratio
end GoldbachEnergy
