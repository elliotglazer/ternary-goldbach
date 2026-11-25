module

public import Totient

@[expose] public section

namespace GoldbachEnergy
set_option maxRecDepth 5000
set_option maxHeartbeats 0
private theorem step {p m u w v : Nat} (hp : p.Prime) (he : p*m=u) (hm : m.totient=w)
    (hv : timesPhi p m w = v) : u.totient = v := by
  rw [← he, ← timesPhi_eq hp, hm, hv]
private def Covered (lo hi : Nat) := ∀ m, lo ≤ m → m < hi → ok (2*m) (2*m).totient = true
private theorem singleton {i : Nat} (h : ok (2*i) (2*i).totient = true) : Covered i (i+1) := by
  intro m h1 h2; have : m = i := by omega
  exact this ▸ h
private theorem pair {l m r : Nat} (a : Covered l m) (b : Covered m r) : Covered l r := by
  intro j hj hk; by_cases h : j < m
  · exact a j hj h
  · exact b j (by omega) hk
private theorem phi1 : Nat.totient 1 = 1 := Nat.totient_one
private theorem phi2 : Nat.totient 2 = 1 := step (p := 2) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem cell1 : Covered 1 2 := singleton (i := 1) (by rw [show 2*1 = 2 by decide, phi2]; decide +kernel)
private theorem phi4 : Nat.totient 4 = 2 := step (p := 2) (m := 2) (by decide +kernel) (by decide) phi2 (by decide +kernel)
private theorem cell2 : Covered 2 3 := singleton (i := 2) (by rw [show 2*2 = 4 by decide, phi4]; decide +kernel)
private theorem grid1x3 : Covered 1 3 := pair cell1 cell2
private theorem phi3 : Nat.totient 3 = 2 := step (p := 3) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi6 : Nat.totient 6 = 2 := step (p := 2) (m := 3) (by decide +kernel) (by decide) phi3 (by decide +kernel)
private theorem cell3 : Covered 3 4 := singleton (i := 3) (by rw [show 2*3 = 6 by decide, phi6]; decide +kernel)
private theorem phi8 : Nat.totient 8 = 4 := step (p := 2) (m := 4) (by decide +kernel) (by decide) phi4 (by decide +kernel)
private theorem cell4 : Covered 4 5 := singleton (i := 4) (by rw [show 2*4 = 8 by decide, phi8]; decide +kernel)
private theorem grid3x5 : Covered 3 5 := pair cell3 cell4
private theorem grid1x5 : Covered 1 5 := pair grid1x3 grid3x5
private theorem phi5 : Nat.totient 5 = 4 := step (p := 5) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi10 : Nat.totient 10 = 4 := step (p := 2) (m := 5) (by decide +kernel) (by decide) phi5 (by decide +kernel)
private theorem cell5 : Covered 5 6 := singleton (i := 5) (by rw [show 2*5 = 10 by decide, phi10]; decide +kernel)
private theorem phi12 : Nat.totient 12 = 4 := step (p := 2) (m := 6) (by decide +kernel) (by decide) phi6 (by decide +kernel)
private theorem cell6 : Covered 6 7 := singleton (i := 6) (by rw [show 2*6 = 12 by decide, phi12]; decide +kernel)
private theorem grid5x7 : Covered 5 7 := pair cell5 cell6
private theorem phi7 : Nat.totient 7 = 6 := step (p := 7) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi14 : Nat.totient 14 = 6 := step (p := 2) (m := 7) (by decide +kernel) (by decide) phi7 (by decide +kernel)
private theorem cell7 : Covered 7 8 := singleton (i := 7) (by rw [show 2*7 = 14 by decide, phi14]; decide +kernel)
private theorem phi16 : Nat.totient 16 = 8 := step (p := 2) (m := 8) (by decide +kernel) (by decide) phi8 (by decide +kernel)
private theorem cell8 : Covered 8 9 := singleton (i := 8) (by rw [show 2*8 = 16 by decide, phi16]; decide +kernel)
private theorem phi9 : Nat.totient 9 = 6 := step (p := 3) (m := 3) (by decide +kernel) (by decide) phi3 (by decide +kernel)
private theorem phi18 : Nat.totient 18 = 6 := step (p := 2) (m := 9) (by decide +kernel) (by decide) phi9 (by decide +kernel)
private theorem cell9 : Covered 9 10 := singleton (i := 9) (by rw [show 2*9 = 18 by decide, phi18]; decide +kernel)
private theorem grid8x10 : Covered 8 10 := pair cell8 cell9
private theorem grid7x10 : Covered 7 10 := pair cell7 grid8x10
private theorem grid5x10 : Covered 5 10 := pair grid5x7 grid7x10
private theorem grid1x10 : Covered 1 10 := pair grid1x5 grid5x10
private theorem phi20 : Nat.totient 20 = 8 := step (p := 2) (m := 10) (by decide +kernel) (by decide) phi10 (by decide +kernel)
private theorem cell10 : Covered 10 11 := singleton (i := 10) (by rw [show 2*10 = 20 by decide, phi20]; decide +kernel)
private theorem phi11 : Nat.totient 11 = 10 := step (p := 11) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi22 : Nat.totient 22 = 10 := step (p := 2) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem cell11 : Covered 11 12 := singleton (i := 11) (by rw [show 2*11 = 22 by decide, phi22]; decide +kernel)
private theorem grid10x12 : Covered 10 12 := pair cell10 cell11
private theorem phi24 : Nat.totient 24 = 8 := step (p := 2) (m := 12) (by decide +kernel) (by decide) phi12 (by decide +kernel)
private theorem cell12 : Covered 12 13 := singleton (i := 12) (by rw [show 2*12 = 24 by decide, phi24]; decide +kernel)
private theorem phi13 : Nat.totient 13 = 12 := step (p := 13) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi26 : Nat.totient 26 = 12 := step (p := 2) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem cell13 : Covered 13 14 := singleton (i := 13) (by rw [show 2*13 = 26 by decide, phi26]; decide +kernel)
private theorem grid12x14 : Covered 12 14 := pair cell12 cell13
private theorem grid10x14 : Covered 10 14 := pair grid10x12 grid12x14
private theorem phi28 : Nat.totient 28 = 12 := step (p := 2) (m := 14) (by decide +kernel) (by decide) phi14 (by decide +kernel)
private theorem cell14 : Covered 14 15 := singleton (i := 14) (by rw [show 2*14 = 28 by decide, phi28]; decide +kernel)
private theorem phi15 : Nat.totient 15 = 8 := step (p := 3) (m := 5) (by decide +kernel) (by decide) phi5 (by decide +kernel)
private theorem phi30 : Nat.totient 30 = 8 := step (p := 2) (m := 15) (by decide +kernel) (by decide) phi15 (by decide +kernel)
private theorem cell15 : Covered 15 16 := singleton (i := 15) (by rw [show 2*15 = 30 by decide, phi30]; decide +kernel)
private theorem grid14x16 : Covered 14 16 := pair cell14 cell15
private theorem phi32 : Nat.totient 32 = 16 := step (p := 2) (m := 16) (by decide +kernel) (by decide) phi16 (by decide +kernel)
private theorem cell16 : Covered 16 17 := singleton (i := 16) (by rw [show 2*16 = 32 by decide, phi32]; decide +kernel)
private theorem phi17 : Nat.totient 17 = 16 := step (p := 17) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi34 : Nat.totient 34 = 16 := step (p := 2) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem cell17 : Covered 17 18 := singleton (i := 17) (by rw [show 2*17 = 34 by decide, phi34]; decide +kernel)
private theorem phi36 : Nat.totient 36 = 12 := step (p := 2) (m := 18) (by decide +kernel) (by decide) phi18 (by decide +kernel)
private theorem cell18 : Covered 18 19 := singleton (i := 18) (by rw [show 2*18 = 36 by decide, phi36]; decide +kernel)
private theorem grid17x19 : Covered 17 19 := pair cell17 cell18
private theorem grid16x19 : Covered 16 19 := pair cell16 grid17x19
private theorem grid14x19 : Covered 14 19 := pair grid14x16 grid16x19
private theorem grid10x19 : Covered 10 19 := pair grid10x14 grid14x19
private theorem grid1x19 : Covered 1 19 := pair grid1x10 grid10x19
private theorem phi19 : Nat.totient 19 = 18 := step (p := 19) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi38 : Nat.totient 38 = 18 := step (p := 2) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem cell19 : Covered 19 20 := singleton (i := 19) (by rw [show 2*19 = 38 by decide, phi38]; decide +kernel)
private theorem phi40 : Nat.totient 40 = 16 := step (p := 2) (m := 20) (by decide +kernel) (by decide) phi20 (by decide +kernel)
private theorem cell20 : Covered 20 21 := singleton (i := 20) (by rw [show 2*20 = 40 by decide, phi40]; decide +kernel)
private theorem grid19x21 : Covered 19 21 := pair cell19 cell20
private theorem phi21 : Nat.totient 21 = 12 := step (p := 3) (m := 7) (by decide +kernel) (by decide) phi7 (by decide +kernel)
private theorem phi42 : Nat.totient 42 = 12 := step (p := 2) (m := 21) (by decide +kernel) (by decide) phi21 (by decide +kernel)
private theorem cell21 : Covered 21 22 := singleton (i := 21) (by rw [show 2*21 = 42 by decide, phi42]; decide +kernel)
private theorem phi44 : Nat.totient 44 = 20 := step (p := 2) (m := 22) (by decide +kernel) (by decide) phi22 (by decide +kernel)
private theorem cell22 : Covered 22 23 := singleton (i := 22) (by rw [show 2*22 = 44 by decide, phi44]; decide +kernel)
private theorem grid21x23 : Covered 21 23 := pair cell21 cell22
private theorem grid19x23 : Covered 19 23 := pair grid19x21 grid21x23
private theorem phi23 : Nat.totient 23 = 22 := step (p := 23) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi46 : Nat.totient 46 = 22 := step (p := 2) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem cell23 : Covered 23 24 := singleton (i := 23) (by rw [show 2*23 = 46 by decide, phi46]; decide +kernel)
private theorem phi48 : Nat.totient 48 = 16 := step (p := 2) (m := 24) (by decide +kernel) (by decide) phi24 (by decide +kernel)
private theorem cell24 : Covered 24 25 := singleton (i := 24) (by rw [show 2*24 = 48 by decide, phi48]; decide +kernel)
private theorem grid23x25 : Covered 23 25 := pair cell23 cell24
private theorem phi25 : Nat.totient 25 = 20 := step (p := 5) (m := 5) (by decide +kernel) (by decide) phi5 (by decide +kernel)
private theorem phi50 : Nat.totient 50 = 20 := step (p := 2) (m := 25) (by decide +kernel) (by decide) phi25 (by decide +kernel)
private theorem cell25 : Covered 25 26 := singleton (i := 25) (by rw [show 2*25 = 50 by decide, phi50]; decide +kernel)
private theorem phi52 : Nat.totient 52 = 24 := step (p := 2) (m := 26) (by decide +kernel) (by decide) phi26 (by decide +kernel)
private theorem cell26 : Covered 26 27 := singleton (i := 26) (by rw [show 2*26 = 52 by decide, phi52]; decide +kernel)
private theorem phi27 : Nat.totient 27 = 18 := step (p := 3) (m := 9) (by decide +kernel) (by decide) phi9 (by decide +kernel)
private theorem phi54 : Nat.totient 54 = 18 := step (p := 2) (m := 27) (by decide +kernel) (by decide) phi27 (by decide +kernel)
private theorem cell27 : Covered 27 28 := singleton (i := 27) (by rw [show 2*27 = 54 by decide, phi54]; decide +kernel)
private theorem grid26x28 : Covered 26 28 := pair cell26 cell27
private theorem grid25x28 : Covered 25 28 := pair cell25 grid26x28
private theorem grid23x28 : Covered 23 28 := pair grid23x25 grid25x28
private theorem grid19x28 : Covered 19 28 := pair grid19x23 grid23x28
private theorem phi56 : Nat.totient 56 = 24 := step (p := 2) (m := 28) (by decide +kernel) (by decide) phi28 (by decide +kernel)
private theorem cell28 : Covered 28 29 := singleton (i := 28) (by rw [show 2*28 = 56 by decide, phi56]; decide +kernel)
private theorem phi29 : Nat.totient 29 = 28 := step (p := 29) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi58 : Nat.totient 58 = 28 := step (p := 2) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem cell29 : Covered 29 30 := singleton (i := 29) (by rw [show 2*29 = 58 by decide, phi58]; decide +kernel)
private theorem grid28x30 : Covered 28 30 := pair cell28 cell29
private theorem phi60 : Nat.totient 60 = 16 := step (p := 2) (m := 30) (by decide +kernel) (by decide) phi30 (by decide +kernel)
private theorem cell30 : Covered 30 31 := singleton (i := 30) (by rw [show 2*30 = 60 by decide, phi60]; decide +kernel)
private theorem phi31 : Nat.totient 31 = 30 := step (p := 31) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi62 : Nat.totient 62 = 30 := step (p := 2) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem cell31 : Covered 31 32 := singleton (i := 31) (by rw [show 2*31 = 62 by decide, phi62]; decide +kernel)
private theorem grid30x32 : Covered 30 32 := pair cell30 cell31
private theorem grid28x32 : Covered 28 32 := pair grid28x30 grid30x32
private theorem phi64 : Nat.totient 64 = 32 := step (p := 2) (m := 32) (by decide +kernel) (by decide) phi32 (by decide +kernel)
private theorem cell32 : Covered 32 33 := singleton (i := 32) (by rw [show 2*32 = 64 by decide, phi64]; decide +kernel)
private theorem phi33 : Nat.totient 33 = 20 := step (p := 3) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem phi66 : Nat.totient 66 = 20 := step (p := 2) (m := 33) (by decide +kernel) (by decide) phi33 (by decide +kernel)
private theorem cell33 : Covered 33 34 := singleton (i := 33) (by rw [show 2*33 = 66 by decide, phi66]; decide +kernel)
private theorem grid32x34 : Covered 32 34 := pair cell32 cell33
private theorem phi68 : Nat.totient 68 = 32 := step (p := 2) (m := 34) (by decide +kernel) (by decide) phi34 (by decide +kernel)
private theorem cell34 : Covered 34 35 := singleton (i := 34) (by rw [show 2*34 = 68 by decide, phi68]; decide +kernel)
private theorem phi35 : Nat.totient 35 = 24 := step (p := 5) (m := 7) (by decide +kernel) (by decide) phi7 (by decide +kernel)
private theorem phi70 : Nat.totient 70 = 24 := step (p := 2) (m := 35) (by decide +kernel) (by decide) phi35 (by decide +kernel)
private theorem cell35 : Covered 35 36 := singleton (i := 35) (by rw [show 2*35 = 70 by decide, phi70]; decide +kernel)
private theorem phi72 : Nat.totient 72 = 24 := step (p := 2) (m := 36) (by decide +kernel) (by decide) phi36 (by decide +kernel)
private theorem cell36 : Covered 36 37 := singleton (i := 36) (by rw [show 2*36 = 72 by decide, phi72]; decide +kernel)
private theorem grid35x37 : Covered 35 37 := pair cell35 cell36
private theorem grid34x37 : Covered 34 37 := pair cell34 grid35x37
private theorem grid32x37 : Covered 32 37 := pair grid32x34 grid34x37
private theorem grid28x37 : Covered 28 37 := pair grid28x32 grid32x37
private theorem grid19x37 : Covered 19 37 := pair grid19x28 grid28x37
private theorem grid1x37 : Covered 1 37 := pair grid1x19 grid19x37
private theorem phi37 : Nat.totient 37 = 36 := step (p := 37) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi74 : Nat.totient 74 = 36 := step (p := 2) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem cell37 : Covered 37 38 := singleton (i := 37) (by rw [show 2*37 = 74 by decide, phi74]; decide +kernel)
private theorem phi76 : Nat.totient 76 = 36 := step (p := 2) (m := 38) (by decide +kernel) (by decide) phi38 (by decide +kernel)
private theorem cell38 : Covered 38 39 := singleton (i := 38) (by rw [show 2*38 = 76 by decide, phi76]; decide +kernel)
private theorem grid37x39 : Covered 37 39 := pair cell37 cell38
private theorem phi39 : Nat.totient 39 = 24 := step (p := 3) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi78 : Nat.totient 78 = 24 := step (p := 2) (m := 39) (by decide +kernel) (by decide) phi39 (by decide +kernel)
private theorem cell39 : Covered 39 40 := singleton (i := 39) (by rw [show 2*39 = 78 by decide, phi78]; decide +kernel)
private theorem phi80 : Nat.totient 80 = 32 := step (p := 2) (m := 40) (by decide +kernel) (by decide) phi40 (by decide +kernel)
private theorem cell40 : Covered 40 41 := singleton (i := 40) (by rw [show 2*40 = 80 by decide, phi80]; decide +kernel)
private theorem grid39x41 : Covered 39 41 := pair cell39 cell40
private theorem grid37x41 : Covered 37 41 := pair grid37x39 grid39x41
private theorem phi41 : Nat.totient 41 = 40 := step (p := 41) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi82 : Nat.totient 82 = 40 := step (p := 2) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem cell41 : Covered 41 42 := singleton (i := 41) (by rw [show 2*41 = 82 by decide, phi82]; decide +kernel)
private theorem phi84 : Nat.totient 84 = 24 := step (p := 2) (m := 42) (by decide +kernel) (by decide) phi42 (by decide +kernel)
private theorem cell42 : Covered 42 43 := singleton (i := 42) (by rw [show 2*42 = 84 by decide, phi84]; decide +kernel)
private theorem grid41x43 : Covered 41 43 := pair cell41 cell42
private theorem phi43 : Nat.totient 43 = 42 := step (p := 43) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi86 : Nat.totient 86 = 42 := step (p := 2) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem cell43 : Covered 43 44 := singleton (i := 43) (by rw [show 2*43 = 86 by decide, phi86]; decide +kernel)
private theorem phi88 : Nat.totient 88 = 40 := step (p := 2) (m := 44) (by decide +kernel) (by decide) phi44 (by decide +kernel)
private theorem cell44 : Covered 44 45 := singleton (i := 44) (by rw [show 2*44 = 88 by decide, phi88]; decide +kernel)
private theorem phi45 : Nat.totient 45 = 24 := step (p := 3) (m := 15) (by decide +kernel) (by decide) phi15 (by decide +kernel)
private theorem phi90 : Nat.totient 90 = 24 := step (p := 2) (m := 45) (by decide +kernel) (by decide) phi45 (by decide +kernel)
private theorem cell45 : Covered 45 46 := singleton (i := 45) (by rw [show 2*45 = 90 by decide, phi90]; decide +kernel)
private theorem grid44x46 : Covered 44 46 := pair cell44 cell45
private theorem grid43x46 : Covered 43 46 := pair cell43 grid44x46
private theorem grid41x46 : Covered 41 46 := pair grid41x43 grid43x46
private theorem grid37x46 : Covered 37 46 := pair grid37x41 grid41x46
private theorem phi92 : Nat.totient 92 = 44 := step (p := 2) (m := 46) (by decide +kernel) (by decide) phi46 (by decide +kernel)
private theorem cell46 : Covered 46 47 := singleton (i := 46) (by rw [show 2*46 = 92 by decide, phi92]; decide +kernel)
private theorem phi47 : Nat.totient 47 = 46 := step (p := 47) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi94 : Nat.totient 94 = 46 := step (p := 2) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem cell47 : Covered 47 48 := singleton (i := 47) (by rw [show 2*47 = 94 by decide, phi94]; decide +kernel)
private theorem grid46x48 : Covered 46 48 := pair cell46 cell47
private theorem phi96 : Nat.totient 96 = 32 := step (p := 2) (m := 48) (by decide +kernel) (by decide) phi48 (by decide +kernel)
private theorem cell48 : Covered 48 49 := singleton (i := 48) (by rw [show 2*48 = 96 by decide, phi96]; decide +kernel)
private theorem phi49 : Nat.totient 49 = 42 := step (p := 7) (m := 7) (by decide +kernel) (by decide) phi7 (by decide +kernel)
private theorem phi98 : Nat.totient 98 = 42 := step (p := 2) (m := 49) (by decide +kernel) (by decide) phi49 (by decide +kernel)
private theorem cell49 : Covered 49 50 := singleton (i := 49) (by rw [show 2*49 = 98 by decide, phi98]; decide +kernel)
private theorem grid48x50 : Covered 48 50 := pair cell48 cell49
private theorem grid46x50 : Covered 46 50 := pair grid46x48 grid48x50
private theorem phi100 : Nat.totient 100 = 40 := step (p := 2) (m := 50) (by decide +kernel) (by decide) phi50 (by decide +kernel)
private theorem cell50 : Covered 50 51 := singleton (i := 50) (by rw [show 2*50 = 100 by decide, phi100]; decide +kernel)
private theorem phi51 : Nat.totient 51 = 32 := step (p := 3) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi102 : Nat.totient 102 = 32 := step (p := 2) (m := 51) (by decide +kernel) (by decide) phi51 (by decide +kernel)
private theorem cell51 : Covered 51 52 := singleton (i := 51) (by rw [show 2*51 = 102 by decide, phi102]; decide +kernel)
private theorem grid50x52 : Covered 50 52 := pair cell50 cell51
private theorem phi104 : Nat.totient 104 = 48 := step (p := 2) (m := 52) (by decide +kernel) (by decide) phi52 (by decide +kernel)
private theorem cell52 : Covered 52 53 := singleton (i := 52) (by rw [show 2*52 = 104 by decide, phi104]; decide +kernel)
private theorem phi53 : Nat.totient 53 = 52 := step (p := 53) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi106 : Nat.totient 106 = 52 := step (p := 2) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem cell53 : Covered 53 54 := singleton (i := 53) (by rw [show 2*53 = 106 by decide, phi106]; decide +kernel)
private theorem phi108 : Nat.totient 108 = 36 := step (p := 2) (m := 54) (by decide +kernel) (by decide) phi54 (by decide +kernel)
private theorem cell54 : Covered 54 55 := singleton (i := 54) (by rw [show 2*54 = 108 by decide, phi108]; decide +kernel)
private theorem grid53x55 : Covered 53 55 := pair cell53 cell54
private theorem grid52x55 : Covered 52 55 := pair cell52 grid53x55
private theorem grid50x55 : Covered 50 55 := pair grid50x52 grid52x55
private theorem grid46x55 : Covered 46 55 := pair grid46x50 grid50x55
private theorem grid37x55 : Covered 37 55 := pair grid37x46 grid46x55
private theorem phi55 : Nat.totient 55 = 40 := step (p := 5) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem phi110 : Nat.totient 110 = 40 := step (p := 2) (m := 55) (by decide +kernel) (by decide) phi55 (by decide +kernel)
private theorem cell55 : Covered 55 56 := singleton (i := 55) (by rw [show 2*55 = 110 by decide, phi110]; decide +kernel)
private theorem phi112 : Nat.totient 112 = 48 := step (p := 2) (m := 56) (by decide +kernel) (by decide) phi56 (by decide +kernel)
private theorem cell56 : Covered 56 57 := singleton (i := 56) (by rw [show 2*56 = 112 by decide, phi112]; decide +kernel)
private theorem grid55x57 : Covered 55 57 := pair cell55 cell56
private theorem phi57 : Nat.totient 57 = 36 := step (p := 3) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi114 : Nat.totient 114 = 36 := step (p := 2) (m := 57) (by decide +kernel) (by decide) phi57 (by decide +kernel)
private theorem cell57 : Covered 57 58 := singleton (i := 57) (by rw [show 2*57 = 114 by decide, phi114]; decide +kernel)
private theorem phi116 : Nat.totient 116 = 56 := step (p := 2) (m := 58) (by decide +kernel) (by decide) phi58 (by decide +kernel)
private theorem cell58 : Covered 58 59 := singleton (i := 58) (by rw [show 2*58 = 116 by decide, phi116]; decide +kernel)
private theorem grid57x59 : Covered 57 59 := pair cell57 cell58
private theorem grid55x59 : Covered 55 59 := pair grid55x57 grid57x59
private theorem phi59 : Nat.totient 59 = 58 := step (p := 59) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi118 : Nat.totient 118 = 58 := step (p := 2) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem cell59 : Covered 59 60 := singleton (i := 59) (by rw [show 2*59 = 118 by decide, phi118]; decide +kernel)
private theorem phi120 : Nat.totient 120 = 32 := step (p := 2) (m := 60) (by decide +kernel) (by decide) phi60 (by decide +kernel)
private theorem cell60 : Covered 60 61 := singleton (i := 60) (by rw [show 2*60 = 120 by decide, phi120]; decide +kernel)
private theorem grid59x61 : Covered 59 61 := pair cell59 cell60
private theorem phi61 : Nat.totient 61 = 60 := step (p := 61) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi122 : Nat.totient 122 = 60 := step (p := 2) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem cell61 : Covered 61 62 := singleton (i := 61) (by rw [show 2*61 = 122 by decide, phi122]; decide +kernel)
private theorem phi124 : Nat.totient 124 = 60 := step (p := 2) (m := 62) (by decide +kernel) (by decide) phi62 (by decide +kernel)
private theorem cell62 : Covered 62 63 := singleton (i := 62) (by rw [show 2*62 = 124 by decide, phi124]; decide +kernel)
private theorem phi63 : Nat.totient 63 = 36 := step (p := 3) (m := 21) (by decide +kernel) (by decide) phi21 (by decide +kernel)
private theorem phi126 : Nat.totient 126 = 36 := step (p := 2) (m := 63) (by decide +kernel) (by decide) phi63 (by decide +kernel)
private theorem cell63 : Covered 63 64 := singleton (i := 63) (by rw [show 2*63 = 126 by decide, phi126]; decide +kernel)
private theorem grid62x64 : Covered 62 64 := pair cell62 cell63
private theorem grid61x64 : Covered 61 64 := pair cell61 grid62x64
private theorem grid59x64 : Covered 59 64 := pair grid59x61 grid61x64
private theorem grid55x64 : Covered 55 64 := pair grid55x59 grid59x64
private theorem phi128 : Nat.totient 128 = 64 := step (p := 2) (m := 64) (by decide +kernel) (by decide) phi64 (by decide +kernel)
private theorem cell64 : Covered 64 65 := singleton (i := 64) (by rw [show 2*64 = 128 by decide, phi128]; decide +kernel)
private theorem phi65 : Nat.totient 65 = 48 := step (p := 5) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi130 : Nat.totient 130 = 48 := step (p := 2) (m := 65) (by decide +kernel) (by decide) phi65 (by decide +kernel)
private theorem cell65 : Covered 65 66 := singleton (i := 65) (by rw [show 2*65 = 130 by decide, phi130]; decide +kernel)
private theorem grid64x66 : Covered 64 66 := pair cell64 cell65
private theorem phi132 : Nat.totient 132 = 40 := step (p := 2) (m := 66) (by decide +kernel) (by decide) phi66 (by decide +kernel)
private theorem cell66 : Covered 66 67 := singleton (i := 66) (by rw [show 2*66 = 132 by decide, phi132]; decide +kernel)
private theorem phi67 : Nat.totient 67 = 66 := step (p := 67) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi134 : Nat.totient 134 = 66 := step (p := 2) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem cell67 : Covered 67 68 := singleton (i := 67) (by rw [show 2*67 = 134 by decide, phi134]; decide +kernel)
private theorem grid66x68 : Covered 66 68 := pair cell66 cell67
private theorem grid64x68 : Covered 64 68 := pair grid64x66 grid66x68
private theorem phi136 : Nat.totient 136 = 64 := step (p := 2) (m := 68) (by decide +kernel) (by decide) phi68 (by decide +kernel)
private theorem cell68 : Covered 68 69 := singleton (i := 68) (by rw [show 2*68 = 136 by decide, phi136]; decide +kernel)
private theorem phi69 : Nat.totient 69 = 44 := step (p := 3) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi138 : Nat.totient 138 = 44 := step (p := 2) (m := 69) (by decide +kernel) (by decide) phi69 (by decide +kernel)
private theorem cell69 : Covered 69 70 := singleton (i := 69) (by rw [show 2*69 = 138 by decide, phi138]; decide +kernel)
private theorem grid68x70 : Covered 68 70 := pair cell68 cell69
private theorem phi140 : Nat.totient 140 = 48 := step (p := 2) (m := 70) (by decide +kernel) (by decide) phi70 (by decide +kernel)
private theorem cell70 : Covered 70 71 := singleton (i := 70) (by rw [show 2*70 = 140 by decide, phi140]; decide +kernel)
private theorem phi71 : Nat.totient 71 = 70 := step (p := 71) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi142 : Nat.totient 142 = 70 := step (p := 2) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem cell71 : Covered 71 72 := singleton (i := 71) (by rw [show 2*71 = 142 by decide, phi142]; decide +kernel)
private theorem phi144 : Nat.totient 144 = 48 := step (p := 2) (m := 72) (by decide +kernel) (by decide) phi72 (by decide +kernel)
private theorem cell72 : Covered 72 73 := singleton (i := 72) (by rw [show 2*72 = 144 by decide, phi144]; decide +kernel)
private theorem grid71x73 : Covered 71 73 := pair cell71 cell72
private theorem grid70x73 : Covered 70 73 := pair cell70 grid71x73
private theorem grid68x73 : Covered 68 73 := pair grid68x70 grid70x73
private theorem grid64x73 : Covered 64 73 := pair grid64x68 grid68x73
private theorem grid55x73 : Covered 55 73 := pair grid55x64 grid64x73
private theorem grid37x73 : Covered 37 73 := pair grid37x55 grid55x73
private theorem grid1x73 : Covered 1 73 := pair grid1x37 grid37x73
private theorem phi73 : Nat.totient 73 = 72 := step (p := 73) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi146 : Nat.totient 146 = 72 := step (p := 2) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem cell73 : Covered 73 74 := singleton (i := 73) (by rw [show 2*73 = 146 by decide, phi146]; decide +kernel)
private theorem phi148 : Nat.totient 148 = 72 := step (p := 2) (m := 74) (by decide +kernel) (by decide) phi74 (by decide +kernel)
private theorem cell74 : Covered 74 75 := singleton (i := 74) (by rw [show 2*74 = 148 by decide, phi148]; decide +kernel)
private theorem grid73x75 : Covered 73 75 := pair cell73 cell74
private theorem phi75 : Nat.totient 75 = 40 := step (p := 3) (m := 25) (by decide +kernel) (by decide) phi25 (by decide +kernel)
private theorem phi150 : Nat.totient 150 = 40 := step (p := 2) (m := 75) (by decide +kernel) (by decide) phi75 (by decide +kernel)
private theorem cell75 : Covered 75 76 := singleton (i := 75) (by rw [show 2*75 = 150 by decide, phi150]; decide +kernel)
private theorem phi152 : Nat.totient 152 = 72 := step (p := 2) (m := 76) (by decide +kernel) (by decide) phi76 (by decide +kernel)
private theorem cell76 : Covered 76 77 := singleton (i := 76) (by rw [show 2*76 = 152 by decide, phi152]; decide +kernel)
private theorem grid75x77 : Covered 75 77 := pair cell75 cell76
private theorem grid73x77 : Covered 73 77 := pair grid73x75 grid75x77
private theorem phi77 : Nat.totient 77 = 60 := step (p := 7) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem phi154 : Nat.totient 154 = 60 := step (p := 2) (m := 77) (by decide +kernel) (by decide) phi77 (by decide +kernel)
private theorem cell77 : Covered 77 78 := singleton (i := 77) (by rw [show 2*77 = 154 by decide, phi154]; decide +kernel)
private theorem phi156 : Nat.totient 156 = 48 := step (p := 2) (m := 78) (by decide +kernel) (by decide) phi78 (by decide +kernel)
private theorem cell78 : Covered 78 79 := singleton (i := 78) (by rw [show 2*78 = 156 by decide, phi156]; decide +kernel)
private theorem grid77x79 : Covered 77 79 := pair cell77 cell78
private theorem phi79 : Nat.totient 79 = 78 := step (p := 79) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi158 : Nat.totient 158 = 78 := step (p := 2) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem cell79 : Covered 79 80 := singleton (i := 79) (by rw [show 2*79 = 158 by decide, phi158]; decide +kernel)
private theorem phi160 : Nat.totient 160 = 64 := step (p := 2) (m := 80) (by decide +kernel) (by decide) phi80 (by decide +kernel)
private theorem cell80 : Covered 80 81 := singleton (i := 80) (by rw [show 2*80 = 160 by decide, phi160]; decide +kernel)
private theorem phi81 : Nat.totient 81 = 54 := step (p := 3) (m := 27) (by decide +kernel) (by decide) phi27 (by decide +kernel)
private theorem phi162 : Nat.totient 162 = 54 := step (p := 2) (m := 81) (by decide +kernel) (by decide) phi81 (by decide +kernel)
private theorem cell81 : Covered 81 82 := singleton (i := 81) (by rw [show 2*81 = 162 by decide, phi162]; decide +kernel)
private theorem grid80x82 : Covered 80 82 := pair cell80 cell81
private theorem grid79x82 : Covered 79 82 := pair cell79 grid80x82
private theorem grid77x82 : Covered 77 82 := pair grid77x79 grid79x82
private theorem grid73x82 : Covered 73 82 := pair grid73x77 grid77x82
private theorem phi164 : Nat.totient 164 = 80 := step (p := 2) (m := 82) (by decide +kernel) (by decide) phi82 (by decide +kernel)
private theorem cell82 : Covered 82 83 := singleton (i := 82) (by rw [show 2*82 = 164 by decide, phi164]; decide +kernel)
private theorem phi83 : Nat.totient 83 = 82 := step (p := 83) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi166 : Nat.totient 166 = 82 := step (p := 2) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem cell83 : Covered 83 84 := singleton (i := 83) (by rw [show 2*83 = 166 by decide, phi166]; decide +kernel)
private theorem grid82x84 : Covered 82 84 := pair cell82 cell83
private theorem phi168 : Nat.totient 168 = 48 := step (p := 2) (m := 84) (by decide +kernel) (by decide) phi84 (by decide +kernel)
private theorem cell84 : Covered 84 85 := singleton (i := 84) (by rw [show 2*84 = 168 by decide, phi168]; decide +kernel)
private theorem phi85 : Nat.totient 85 = 64 := step (p := 5) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi170 : Nat.totient 170 = 64 := step (p := 2) (m := 85) (by decide +kernel) (by decide) phi85 (by decide +kernel)
private theorem cell85 : Covered 85 86 := singleton (i := 85) (by rw [show 2*85 = 170 by decide, phi170]; decide +kernel)
private theorem grid84x86 : Covered 84 86 := pair cell84 cell85
private theorem grid82x86 : Covered 82 86 := pair grid82x84 grid84x86
private theorem phi172 : Nat.totient 172 = 84 := step (p := 2) (m := 86) (by decide +kernel) (by decide) phi86 (by decide +kernel)
private theorem cell86 : Covered 86 87 := singleton (i := 86) (by rw [show 2*86 = 172 by decide, phi172]; decide +kernel)
private theorem phi87 : Nat.totient 87 = 56 := step (p := 3) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi174 : Nat.totient 174 = 56 := step (p := 2) (m := 87) (by decide +kernel) (by decide) phi87 (by decide +kernel)
private theorem cell87 : Covered 87 88 := singleton (i := 87) (by rw [show 2*87 = 174 by decide, phi174]; decide +kernel)
private theorem grid86x88 : Covered 86 88 := pair cell86 cell87
private theorem phi176 : Nat.totient 176 = 80 := step (p := 2) (m := 88) (by decide +kernel) (by decide) phi88 (by decide +kernel)
private theorem cell88 : Covered 88 89 := singleton (i := 88) (by rw [show 2*88 = 176 by decide, phi176]; decide +kernel)
private theorem phi89 : Nat.totient 89 = 88 := step (p := 89) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi178 : Nat.totient 178 = 88 := step (p := 2) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem cell89 : Covered 89 90 := singleton (i := 89) (by rw [show 2*89 = 178 by decide, phi178]; decide +kernel)
private theorem phi180 : Nat.totient 180 = 48 := step (p := 2) (m := 90) (by decide +kernel) (by decide) phi90 (by decide +kernel)
private theorem cell90 : Covered 90 91 := singleton (i := 90) (by rw [show 2*90 = 180 by decide, phi180]; decide +kernel)
private theorem grid89x91 : Covered 89 91 := pair cell89 cell90
private theorem grid88x91 : Covered 88 91 := pair cell88 grid89x91
private theorem grid86x91 : Covered 86 91 := pair grid86x88 grid88x91
private theorem grid82x91 : Covered 82 91 := pair grid82x86 grid86x91
private theorem grid73x91 : Covered 73 91 := pair grid73x82 grid82x91
private theorem phi91 : Nat.totient 91 = 72 := step (p := 7) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi182 : Nat.totient 182 = 72 := step (p := 2) (m := 91) (by decide +kernel) (by decide) phi91 (by decide +kernel)
private theorem cell91 : Covered 91 92 := singleton (i := 91) (by rw [show 2*91 = 182 by decide, phi182]; decide +kernel)
private theorem phi184 : Nat.totient 184 = 88 := step (p := 2) (m := 92) (by decide +kernel) (by decide) phi92 (by decide +kernel)
private theorem cell92 : Covered 92 93 := singleton (i := 92) (by rw [show 2*92 = 184 by decide, phi184]; decide +kernel)
private theorem grid91x93 : Covered 91 93 := pair cell91 cell92
private theorem phi93 : Nat.totient 93 = 60 := step (p := 3) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi186 : Nat.totient 186 = 60 := step (p := 2) (m := 93) (by decide +kernel) (by decide) phi93 (by decide +kernel)
private theorem cell93 : Covered 93 94 := singleton (i := 93) (by rw [show 2*93 = 186 by decide, phi186]; decide +kernel)
private theorem phi188 : Nat.totient 188 = 92 := step (p := 2) (m := 94) (by decide +kernel) (by decide) phi94 (by decide +kernel)
private theorem cell94 : Covered 94 95 := singleton (i := 94) (by rw [show 2*94 = 188 by decide, phi188]; decide +kernel)
private theorem grid93x95 : Covered 93 95 := pair cell93 cell94
private theorem grid91x95 : Covered 91 95 := pair grid91x93 grid93x95
private theorem phi95 : Nat.totient 95 = 72 := step (p := 5) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi190 : Nat.totient 190 = 72 := step (p := 2) (m := 95) (by decide +kernel) (by decide) phi95 (by decide +kernel)
private theorem cell95 : Covered 95 96 := singleton (i := 95) (by rw [show 2*95 = 190 by decide, phi190]; decide +kernel)
private theorem phi192 : Nat.totient 192 = 64 := step (p := 2) (m := 96) (by decide +kernel) (by decide) phi96 (by decide +kernel)
private theorem cell96 : Covered 96 97 := singleton (i := 96) (by rw [show 2*96 = 192 by decide, phi192]; decide +kernel)
private theorem grid95x97 : Covered 95 97 := pair cell95 cell96
private theorem phi97 : Nat.totient 97 = 96 := step (p := 97) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi194 : Nat.totient 194 = 96 := step (p := 2) (m := 97) (by decide +kernel) (by decide) phi97 (by decide +kernel)
private theorem cell97 : Covered 97 98 := singleton (i := 97) (by rw [show 2*97 = 194 by decide, phi194]; decide +kernel)
private theorem phi196 : Nat.totient 196 = 84 := step (p := 2) (m := 98) (by decide +kernel) (by decide) phi98 (by decide +kernel)
private theorem cell98 : Covered 98 99 := singleton (i := 98) (by rw [show 2*98 = 196 by decide, phi196]; decide +kernel)
private theorem phi99 : Nat.totient 99 = 60 := step (p := 3) (m := 33) (by decide +kernel) (by decide) phi33 (by decide +kernel)
private theorem phi198 : Nat.totient 198 = 60 := step (p := 2) (m := 99) (by decide +kernel) (by decide) phi99 (by decide +kernel)
private theorem cell99 : Covered 99 100 := singleton (i := 99) (by rw [show 2*99 = 198 by decide, phi198]; decide +kernel)
private theorem grid98x100 : Covered 98 100 := pair cell98 cell99
private theorem grid97x100 : Covered 97 100 := pair cell97 grid98x100
private theorem grid95x100 : Covered 95 100 := pair grid95x97 grid97x100
private theorem grid91x100 : Covered 91 100 := pair grid91x95 grid95x100
private theorem phi200 : Nat.totient 200 = 80 := step (p := 2) (m := 100) (by decide +kernel) (by decide) phi100 (by decide +kernel)
private theorem cell100 : Covered 100 101 := singleton (i := 100) (by rw [show 2*100 = 200 by decide, phi200]; decide +kernel)
private theorem phi101 : Nat.totient 101 = 100 := step (p := 101) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi202 : Nat.totient 202 = 100 := step (p := 2) (m := 101) (by decide +kernel) (by decide) phi101 (by decide +kernel)
private theorem cell101 : Covered 101 102 := singleton (i := 101) (by rw [show 2*101 = 202 by decide, phi202]; decide +kernel)
private theorem grid100x102 : Covered 100 102 := pair cell100 cell101
private theorem phi204 : Nat.totient 204 = 64 := step (p := 2) (m := 102) (by decide +kernel) (by decide) phi102 (by decide +kernel)
private theorem cell102 : Covered 102 103 := singleton (i := 102) (by rw [show 2*102 = 204 by decide, phi204]; decide +kernel)
private theorem phi103 : Nat.totient 103 = 102 := step (p := 103) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi206 : Nat.totient 206 = 102 := step (p := 2) (m := 103) (by decide +kernel) (by decide) phi103 (by decide +kernel)
private theorem cell103 : Covered 103 104 := singleton (i := 103) (by rw [show 2*103 = 206 by decide, phi206]; decide +kernel)
private theorem grid102x104 : Covered 102 104 := pair cell102 cell103
private theorem grid100x104 : Covered 100 104 := pair grid100x102 grid102x104
private theorem phi208 : Nat.totient 208 = 96 := step (p := 2) (m := 104) (by decide +kernel) (by decide) phi104 (by decide +kernel)
private theorem cell104 : Covered 104 105 := singleton (i := 104) (by rw [show 2*104 = 208 by decide, phi208]; decide +kernel)
private theorem phi105 : Nat.totient 105 = 48 := step (p := 3) (m := 35) (by decide +kernel) (by decide) phi35 (by decide +kernel)
private theorem phi210 : Nat.totient 210 = 48 := step (p := 2) (m := 105) (by decide +kernel) (by decide) phi105 (by decide +kernel)
private theorem cell105 : Covered 105 106 := singleton (i := 105) (by rw [show 2*105 = 210 by decide, phi210]; decide +kernel)
private theorem grid104x106 : Covered 104 106 := pair cell104 cell105
private theorem phi212 : Nat.totient 212 = 104 := step (p := 2) (m := 106) (by decide +kernel) (by decide) phi106 (by decide +kernel)
private theorem cell106 : Covered 106 107 := singleton (i := 106) (by rw [show 2*106 = 212 by decide, phi212]; decide +kernel)
private theorem phi107 : Nat.totient 107 = 106 := step (p := 107) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi214 : Nat.totient 214 = 106 := step (p := 2) (m := 107) (by decide +kernel) (by decide) phi107 (by decide +kernel)
private theorem cell107 : Covered 107 108 := singleton (i := 107) (by rw [show 2*107 = 214 by decide, phi214]; decide +kernel)
private theorem phi216 : Nat.totient 216 = 72 := step (p := 2) (m := 108) (by decide +kernel) (by decide) phi108 (by decide +kernel)
private theorem cell108 : Covered 108 109 := singleton (i := 108) (by rw [show 2*108 = 216 by decide, phi216]; decide +kernel)
private theorem grid107x109 : Covered 107 109 := pair cell107 cell108
private theorem grid106x109 : Covered 106 109 := pair cell106 grid107x109
private theorem grid104x109 : Covered 104 109 := pair grid104x106 grid106x109
private theorem grid100x109 : Covered 100 109 := pair grid100x104 grid104x109
private theorem grid91x109 : Covered 91 109 := pair grid91x100 grid100x109
private theorem grid73x109 : Covered 73 109 := pair grid73x91 grid91x109
private theorem phi109 : Nat.totient 109 = 108 := step (p := 109) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi218 : Nat.totient 218 = 108 := step (p := 2) (m := 109) (by decide +kernel) (by decide) phi109 (by decide +kernel)
private theorem cell109 : Covered 109 110 := singleton (i := 109) (by rw [show 2*109 = 218 by decide, phi218]; decide +kernel)
private theorem phi220 : Nat.totient 220 = 80 := step (p := 2) (m := 110) (by decide +kernel) (by decide) phi110 (by decide +kernel)
private theorem cell110 : Covered 110 111 := singleton (i := 110) (by rw [show 2*110 = 220 by decide, phi220]; decide +kernel)
private theorem grid109x111 : Covered 109 111 := pair cell109 cell110
private theorem phi111 : Nat.totient 111 = 72 := step (p := 3) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi222 : Nat.totient 222 = 72 := step (p := 2) (m := 111) (by decide +kernel) (by decide) phi111 (by decide +kernel)
private theorem cell111 : Covered 111 112 := singleton (i := 111) (by rw [show 2*111 = 222 by decide, phi222]; decide +kernel)
private theorem phi224 : Nat.totient 224 = 96 := step (p := 2) (m := 112) (by decide +kernel) (by decide) phi112 (by decide +kernel)
private theorem cell112 : Covered 112 113 := singleton (i := 112) (by rw [show 2*112 = 224 by decide, phi224]; decide +kernel)
private theorem grid111x113 : Covered 111 113 := pair cell111 cell112
private theorem grid109x113 : Covered 109 113 := pair grid109x111 grid111x113
private theorem phi113 : Nat.totient 113 = 112 := step (p := 113) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi226 : Nat.totient 226 = 112 := step (p := 2) (m := 113) (by decide +kernel) (by decide) phi113 (by decide +kernel)
private theorem cell113 : Covered 113 114 := singleton (i := 113) (by rw [show 2*113 = 226 by decide, phi226]; decide +kernel)
private theorem phi228 : Nat.totient 228 = 72 := step (p := 2) (m := 114) (by decide +kernel) (by decide) phi114 (by decide +kernel)
private theorem cell114 : Covered 114 115 := singleton (i := 114) (by rw [show 2*114 = 228 by decide, phi228]; decide +kernel)
private theorem grid113x115 : Covered 113 115 := pair cell113 cell114
private theorem phi115 : Nat.totient 115 = 88 := step (p := 5) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi230 : Nat.totient 230 = 88 := step (p := 2) (m := 115) (by decide +kernel) (by decide) phi115 (by decide +kernel)
private theorem cell115 : Covered 115 116 := singleton (i := 115) (by rw [show 2*115 = 230 by decide, phi230]; decide +kernel)
private theorem phi232 : Nat.totient 232 = 112 := step (p := 2) (m := 116) (by decide +kernel) (by decide) phi116 (by decide +kernel)
private theorem cell116 : Covered 116 117 := singleton (i := 116) (by rw [show 2*116 = 232 by decide, phi232]; decide +kernel)
private theorem phi117 : Nat.totient 117 = 72 := step (p := 3) (m := 39) (by decide +kernel) (by decide) phi39 (by decide +kernel)
private theorem phi234 : Nat.totient 234 = 72 := step (p := 2) (m := 117) (by decide +kernel) (by decide) phi117 (by decide +kernel)
private theorem cell117 : Covered 117 118 := singleton (i := 117) (by rw [show 2*117 = 234 by decide, phi234]; decide +kernel)
private theorem grid116x118 : Covered 116 118 := pair cell116 cell117
private theorem grid115x118 : Covered 115 118 := pair cell115 grid116x118
private theorem grid113x118 : Covered 113 118 := pair grid113x115 grid115x118
private theorem grid109x118 : Covered 109 118 := pair grid109x113 grid113x118
private theorem phi236 : Nat.totient 236 = 116 := step (p := 2) (m := 118) (by decide +kernel) (by decide) phi118 (by decide +kernel)
private theorem cell118 : Covered 118 119 := singleton (i := 118) (by rw [show 2*118 = 236 by decide, phi236]; decide +kernel)
private theorem phi119 : Nat.totient 119 = 96 := step (p := 7) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi238 : Nat.totient 238 = 96 := step (p := 2) (m := 119) (by decide +kernel) (by decide) phi119 (by decide +kernel)
private theorem cell119 : Covered 119 120 := singleton (i := 119) (by rw [show 2*119 = 238 by decide, phi238]; decide +kernel)
private theorem grid118x120 : Covered 118 120 := pair cell118 cell119
private theorem phi240 : Nat.totient 240 = 64 := step (p := 2) (m := 120) (by decide +kernel) (by decide) phi120 (by decide +kernel)
private theorem cell120 : Covered 120 121 := singleton (i := 120) (by rw [show 2*120 = 240 by decide, phi240]; decide +kernel)
private theorem phi121 : Nat.totient 121 = 110 := step (p := 11) (m := 11) (by decide +kernel) (by decide) phi11 (by decide +kernel)
private theorem phi242 : Nat.totient 242 = 110 := step (p := 2) (m := 121) (by decide +kernel) (by decide) phi121 (by decide +kernel)
private theorem cell121 : Covered 121 122 := singleton (i := 121) (by rw [show 2*121 = 242 by decide, phi242]; decide +kernel)
private theorem grid120x122 : Covered 120 122 := pair cell120 cell121
private theorem grid118x122 : Covered 118 122 := pair grid118x120 grid120x122
private theorem phi244 : Nat.totient 244 = 120 := step (p := 2) (m := 122) (by decide +kernel) (by decide) phi122 (by decide +kernel)
private theorem cell122 : Covered 122 123 := singleton (i := 122) (by rw [show 2*122 = 244 by decide, phi244]; decide +kernel)
private theorem phi123 : Nat.totient 123 = 80 := step (p := 3) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi246 : Nat.totient 246 = 80 := step (p := 2) (m := 123) (by decide +kernel) (by decide) phi123 (by decide +kernel)
private theorem cell123 : Covered 123 124 := singleton (i := 123) (by rw [show 2*123 = 246 by decide, phi246]; decide +kernel)
private theorem grid122x124 : Covered 122 124 := pair cell122 cell123
private theorem phi248 : Nat.totient 248 = 120 := step (p := 2) (m := 124) (by decide +kernel) (by decide) phi124 (by decide +kernel)
private theorem cell124 : Covered 124 125 := singleton (i := 124) (by rw [show 2*124 = 248 by decide, phi248]; decide +kernel)
private theorem phi125 : Nat.totient 125 = 100 := step (p := 5) (m := 25) (by decide +kernel) (by decide) phi25 (by decide +kernel)
private theorem phi250 : Nat.totient 250 = 100 := step (p := 2) (m := 125) (by decide +kernel) (by decide) phi125 (by decide +kernel)
private theorem cell125 : Covered 125 126 := singleton (i := 125) (by rw [show 2*125 = 250 by decide, phi250]; decide +kernel)
private theorem phi252 : Nat.totient 252 = 72 := step (p := 2) (m := 126) (by decide +kernel) (by decide) phi126 (by decide +kernel)
private theorem cell126 : Covered 126 127 := singleton (i := 126) (by rw [show 2*126 = 252 by decide, phi252]; decide +kernel)
private theorem grid125x127 : Covered 125 127 := pair cell125 cell126
private theorem grid124x127 : Covered 124 127 := pair cell124 grid125x127
private theorem grid122x127 : Covered 122 127 := pair grid122x124 grid124x127
private theorem grid118x127 : Covered 118 127 := pair grid118x122 grid122x127
private theorem grid109x127 : Covered 109 127 := pair grid109x118 grid118x127
private theorem phi127 : Nat.totient 127 = 126 := step (p := 127) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi254 : Nat.totient 254 = 126 := step (p := 2) (m := 127) (by decide +kernel) (by decide) phi127 (by decide +kernel)
private theorem cell127 : Covered 127 128 := singleton (i := 127) (by rw [show 2*127 = 254 by decide, phi254]; decide +kernel)
private theorem phi256 : Nat.totient 256 = 128 := step (p := 2) (m := 128) (by decide +kernel) (by decide) phi128 (by decide +kernel)
private theorem cell128 : Covered 128 129 := singleton (i := 128) (by rw [show 2*128 = 256 by decide, phi256]; decide +kernel)
private theorem grid127x129 : Covered 127 129 := pair cell127 cell128
private theorem phi129 : Nat.totient 129 = 84 := step (p := 3) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi258 : Nat.totient 258 = 84 := step (p := 2) (m := 129) (by decide +kernel) (by decide) phi129 (by decide +kernel)
private theorem cell129 : Covered 129 130 := singleton (i := 129) (by rw [show 2*129 = 258 by decide, phi258]; decide +kernel)
private theorem phi260 : Nat.totient 260 = 96 := step (p := 2) (m := 130) (by decide +kernel) (by decide) phi130 (by decide +kernel)
private theorem cell130 : Covered 130 131 := singleton (i := 130) (by rw [show 2*130 = 260 by decide, phi260]; decide +kernel)
private theorem grid129x131 : Covered 129 131 := pair cell129 cell130
private theorem grid127x131 : Covered 127 131 := pair grid127x129 grid129x131
private theorem phi131 : Nat.totient 131 = 130 := step (p := 131) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi262 : Nat.totient 262 = 130 := step (p := 2) (m := 131) (by decide +kernel) (by decide) phi131 (by decide +kernel)
private theorem cell131 : Covered 131 132 := singleton (i := 131) (by rw [show 2*131 = 262 by decide, phi262]; decide +kernel)
private theorem phi264 : Nat.totient 264 = 80 := step (p := 2) (m := 132) (by decide +kernel) (by decide) phi132 (by decide +kernel)
private theorem cell132 : Covered 132 133 := singleton (i := 132) (by rw [show 2*132 = 264 by decide, phi264]; decide +kernel)
private theorem grid131x133 : Covered 131 133 := pair cell131 cell132
private theorem phi133 : Nat.totient 133 = 108 := step (p := 7) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi266 : Nat.totient 266 = 108 := step (p := 2) (m := 133) (by decide +kernel) (by decide) phi133 (by decide +kernel)
private theorem cell133 : Covered 133 134 := singleton (i := 133) (by rw [show 2*133 = 266 by decide, phi266]; decide +kernel)
private theorem phi268 : Nat.totient 268 = 132 := step (p := 2) (m := 134) (by decide +kernel) (by decide) phi134 (by decide +kernel)
private theorem cell134 : Covered 134 135 := singleton (i := 134) (by rw [show 2*134 = 268 by decide, phi268]; decide +kernel)
private theorem phi135 : Nat.totient 135 = 72 := step (p := 3) (m := 45) (by decide +kernel) (by decide) phi45 (by decide +kernel)
private theorem phi270 : Nat.totient 270 = 72 := step (p := 2) (m := 135) (by decide +kernel) (by decide) phi135 (by decide +kernel)
private theorem cell135 : Covered 135 136 := singleton (i := 135) (by rw [show 2*135 = 270 by decide, phi270]; decide +kernel)
private theorem grid134x136 : Covered 134 136 := pair cell134 cell135
private theorem grid133x136 : Covered 133 136 := pair cell133 grid134x136
private theorem grid131x136 : Covered 131 136 := pair grid131x133 grid133x136
private theorem grid127x136 : Covered 127 136 := pair grid127x131 grid131x136
private theorem phi272 : Nat.totient 272 = 128 := step (p := 2) (m := 136) (by decide +kernel) (by decide) phi136 (by decide +kernel)
private theorem cell136 : Covered 136 137 := singleton (i := 136) (by rw [show 2*136 = 272 by decide, phi272]; decide +kernel)
private theorem phi137 : Nat.totient 137 = 136 := step (p := 137) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi274 : Nat.totient 274 = 136 := step (p := 2) (m := 137) (by decide +kernel) (by decide) phi137 (by decide +kernel)
private theorem cell137 : Covered 137 138 := singleton (i := 137) (by rw [show 2*137 = 274 by decide, phi274]; decide +kernel)
private theorem grid136x138 : Covered 136 138 := pair cell136 cell137
private theorem phi276 : Nat.totient 276 = 88 := step (p := 2) (m := 138) (by decide +kernel) (by decide) phi138 (by decide +kernel)
private theorem cell138 : Covered 138 139 := singleton (i := 138) (by rw [show 2*138 = 276 by decide, phi276]; decide +kernel)
private theorem phi139 : Nat.totient 139 = 138 := step (p := 139) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi278 : Nat.totient 278 = 138 := step (p := 2) (m := 139) (by decide +kernel) (by decide) phi139 (by decide +kernel)
private theorem cell139 : Covered 139 140 := singleton (i := 139) (by rw [show 2*139 = 278 by decide, phi278]; decide +kernel)
private theorem phi280 : Nat.totient 280 = 96 := step (p := 2) (m := 140) (by decide +kernel) (by decide) phi140 (by decide +kernel)
private theorem cell140 : Covered 140 141 := singleton (i := 140) (by rw [show 2*140 = 280 by decide, phi280]; decide +kernel)
private theorem grid139x141 : Covered 139 141 := pair cell139 cell140
private theorem grid138x141 : Covered 138 141 := pair cell138 grid139x141
private theorem grid136x141 : Covered 136 141 := pair grid136x138 grid138x141
private theorem phi141 : Nat.totient 141 = 92 := step (p := 3) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi282 : Nat.totient 282 = 92 := step (p := 2) (m := 141) (by decide +kernel) (by decide) phi141 (by decide +kernel)
private theorem cell141 : Covered 141 142 := singleton (i := 141) (by rw [show 2*141 = 282 by decide, phi282]; decide +kernel)
private theorem phi284 : Nat.totient 284 = 140 := step (p := 2) (m := 142) (by decide +kernel) (by decide) phi142 (by decide +kernel)
private theorem cell142 : Covered 142 143 := singleton (i := 142) (by rw [show 2*142 = 284 by decide, phi284]; decide +kernel)
private theorem grid141x143 : Covered 141 143 := pair cell141 cell142
private theorem phi143 : Nat.totient 143 = 120 := step (p := 11) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi286 : Nat.totient 286 = 120 := step (p := 2) (m := 143) (by decide +kernel) (by decide) phi143 (by decide +kernel)
private theorem cell143 : Covered 143 144 := singleton (i := 143) (by rw [show 2*143 = 286 by decide, phi286]; decide +kernel)
private theorem phi288 : Nat.totient 288 = 96 := step (p := 2) (m := 144) (by decide +kernel) (by decide) phi144 (by decide +kernel)
private theorem cell144 : Covered 144 145 := singleton (i := 144) (by rw [show 2*144 = 288 by decide, phi288]; decide +kernel)
private theorem phi145 : Nat.totient 145 = 112 := step (p := 5) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi290 : Nat.totient 290 = 112 := step (p := 2) (m := 145) (by decide +kernel) (by decide) phi145 (by decide +kernel)
private theorem cell145 : Covered 145 146 := singleton (i := 145) (by rw [show 2*145 = 290 by decide, phi290]; decide +kernel)
private theorem grid144x146 : Covered 144 146 := pair cell144 cell145
private theorem grid143x146 : Covered 143 146 := pair cell143 grid144x146
private theorem grid141x146 : Covered 141 146 := pair grid141x143 grid143x146
private theorem grid136x146 : Covered 136 146 := pair grid136x141 grid141x146
private theorem grid127x146 : Covered 127 146 := pair grid127x136 grid136x146
private theorem grid109x146 : Covered 109 146 := pair grid109x127 grid127x146
private theorem grid73x146 : Covered 73 146 := pair grid73x109 grid109x146
private theorem grid1x146 : Covered 1 146 := pair grid1x73 grid73x146
private theorem phi292 : Nat.totient 292 = 144 := step (p := 2) (m := 146) (by decide +kernel) (by decide) phi146 (by decide +kernel)
private theorem cell146 : Covered 146 147 := singleton (i := 146) (by rw [show 2*146 = 292 by decide, phi292]; decide +kernel)
private theorem phi147 : Nat.totient 147 = 84 := step (p := 3) (m := 49) (by decide +kernel) (by decide) phi49 (by decide +kernel)
private theorem phi294 : Nat.totient 294 = 84 := step (p := 2) (m := 147) (by decide +kernel) (by decide) phi147 (by decide +kernel)
private theorem cell147 : Covered 147 148 := singleton (i := 147) (by rw [show 2*147 = 294 by decide, phi294]; decide +kernel)
private theorem grid146x148 : Covered 146 148 := pair cell146 cell147
private theorem phi296 : Nat.totient 296 = 144 := step (p := 2) (m := 148) (by decide +kernel) (by decide) phi148 (by decide +kernel)
private theorem cell148 : Covered 148 149 := singleton (i := 148) (by rw [show 2*148 = 296 by decide, phi296]; decide +kernel)
private theorem phi149 : Nat.totient 149 = 148 := step (p := 149) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi298 : Nat.totient 298 = 148 := step (p := 2) (m := 149) (by decide +kernel) (by decide) phi149 (by decide +kernel)
private theorem cell149 : Covered 149 150 := singleton (i := 149) (by rw [show 2*149 = 298 by decide, phi298]; decide +kernel)
private theorem grid148x150 : Covered 148 150 := pair cell148 cell149
private theorem grid146x150 : Covered 146 150 := pair grid146x148 grid148x150
private theorem phi300 : Nat.totient 300 = 80 := step (p := 2) (m := 150) (by decide +kernel) (by decide) phi150 (by decide +kernel)
private theorem cell150 : Covered 150 151 := singleton (i := 150) (by rw [show 2*150 = 300 by decide, phi300]; decide +kernel)
private theorem phi151 : Nat.totient 151 = 150 := step (p := 151) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi302 : Nat.totient 302 = 150 := step (p := 2) (m := 151) (by decide +kernel) (by decide) phi151 (by decide +kernel)
private theorem cell151 : Covered 151 152 := singleton (i := 151) (by rw [show 2*151 = 302 by decide, phi302]; decide +kernel)
private theorem grid150x152 : Covered 150 152 := pair cell150 cell151
private theorem phi304 : Nat.totient 304 = 144 := step (p := 2) (m := 152) (by decide +kernel) (by decide) phi152 (by decide +kernel)
private theorem cell152 : Covered 152 153 := singleton (i := 152) (by rw [show 2*152 = 304 by decide, phi304]; decide +kernel)
private theorem phi153 : Nat.totient 153 = 96 := step (p := 3) (m := 51) (by decide +kernel) (by decide) phi51 (by decide +kernel)
private theorem phi306 : Nat.totient 306 = 96 := step (p := 2) (m := 153) (by decide +kernel) (by decide) phi153 (by decide +kernel)
private theorem cell153 : Covered 153 154 := singleton (i := 153) (by rw [show 2*153 = 306 by decide, phi306]; decide +kernel)
private theorem phi308 : Nat.totient 308 = 120 := step (p := 2) (m := 154) (by decide +kernel) (by decide) phi154 (by decide +kernel)
private theorem cell154 : Covered 154 155 := singleton (i := 154) (by rw [show 2*154 = 308 by decide, phi308]; decide +kernel)
private theorem grid153x155 : Covered 153 155 := pair cell153 cell154
private theorem grid152x155 : Covered 152 155 := pair cell152 grid153x155
private theorem grid150x155 : Covered 150 155 := pair grid150x152 grid152x155
private theorem grid146x155 : Covered 146 155 := pair grid146x150 grid150x155
private theorem phi155 : Nat.totient 155 = 120 := step (p := 5) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi310 : Nat.totient 310 = 120 := step (p := 2) (m := 155) (by decide +kernel) (by decide) phi155 (by decide +kernel)
private theorem cell155 : Covered 155 156 := singleton (i := 155) (by rw [show 2*155 = 310 by decide, phi310]; decide +kernel)
private theorem phi312 : Nat.totient 312 = 96 := step (p := 2) (m := 156) (by decide +kernel) (by decide) phi156 (by decide +kernel)
private theorem cell156 : Covered 156 157 := singleton (i := 156) (by rw [show 2*156 = 312 by decide, phi312]; decide +kernel)
private theorem grid155x157 : Covered 155 157 := pair cell155 cell156
private theorem phi157 : Nat.totient 157 = 156 := step (p := 157) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi314 : Nat.totient 314 = 156 := step (p := 2) (m := 157) (by decide +kernel) (by decide) phi157 (by decide +kernel)
private theorem cell157 : Covered 157 158 := singleton (i := 157) (by rw [show 2*157 = 314 by decide, phi314]; decide +kernel)
private theorem phi316 : Nat.totient 316 = 156 := step (p := 2) (m := 158) (by decide +kernel) (by decide) phi158 (by decide +kernel)
private theorem cell158 : Covered 158 159 := singleton (i := 158) (by rw [show 2*158 = 316 by decide, phi316]; decide +kernel)
private theorem grid157x159 : Covered 157 159 := pair cell157 cell158
private theorem grid155x159 : Covered 155 159 := pair grid155x157 grid157x159
private theorem phi159 : Nat.totient 159 = 104 := step (p := 3) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi318 : Nat.totient 318 = 104 := step (p := 2) (m := 159) (by decide +kernel) (by decide) phi159 (by decide +kernel)
private theorem cell159 : Covered 159 160 := singleton (i := 159) (by rw [show 2*159 = 318 by decide, phi318]; decide +kernel)
private theorem phi320 : Nat.totient 320 = 128 := step (p := 2) (m := 160) (by decide +kernel) (by decide) phi160 (by decide +kernel)
private theorem cell160 : Covered 160 161 := singleton (i := 160) (by rw [show 2*160 = 320 by decide, phi320]; decide +kernel)
private theorem grid159x161 : Covered 159 161 := pair cell159 cell160
private theorem phi161 : Nat.totient 161 = 132 := step (p := 7) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi322 : Nat.totient 322 = 132 := step (p := 2) (m := 161) (by decide +kernel) (by decide) phi161 (by decide +kernel)
private theorem cell161 : Covered 161 162 := singleton (i := 161) (by rw [show 2*161 = 322 by decide, phi322]; decide +kernel)
private theorem phi324 : Nat.totient 324 = 108 := step (p := 2) (m := 162) (by decide +kernel) (by decide) phi162 (by decide +kernel)
private theorem cell162 : Covered 162 163 := singleton (i := 162) (by rw [show 2*162 = 324 by decide, phi324]; decide +kernel)
private theorem phi163 : Nat.totient 163 = 162 := step (p := 163) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi326 : Nat.totient 326 = 162 := step (p := 2) (m := 163) (by decide +kernel) (by decide) phi163 (by decide +kernel)
private theorem cell163 : Covered 163 164 := singleton (i := 163) (by rw [show 2*163 = 326 by decide, phi326]; decide +kernel)
private theorem grid162x164 : Covered 162 164 := pair cell162 cell163
private theorem grid161x164 : Covered 161 164 := pair cell161 grid162x164
private theorem grid159x164 : Covered 159 164 := pair grid159x161 grid161x164
private theorem grid155x164 : Covered 155 164 := pair grid155x159 grid159x164
private theorem grid146x164 : Covered 146 164 := pair grid146x155 grid155x164
private theorem phi328 : Nat.totient 328 = 160 := step (p := 2) (m := 164) (by decide +kernel) (by decide) phi164 (by decide +kernel)
private theorem cell164 : Covered 164 165 := singleton (i := 164) (by rw [show 2*164 = 328 by decide, phi328]; decide +kernel)
private theorem phi165 : Nat.totient 165 = 80 := step (p := 3) (m := 55) (by decide +kernel) (by decide) phi55 (by decide +kernel)
private theorem phi330 : Nat.totient 330 = 80 := step (p := 2) (m := 165) (by decide +kernel) (by decide) phi165 (by decide +kernel)
private theorem cell165 : Covered 165 166 := singleton (i := 165) (by rw [show 2*165 = 330 by decide, phi330]; decide +kernel)
private theorem grid164x166 : Covered 164 166 := pair cell164 cell165
private theorem phi332 : Nat.totient 332 = 164 := step (p := 2) (m := 166) (by decide +kernel) (by decide) phi166 (by decide +kernel)
private theorem cell166 : Covered 166 167 := singleton (i := 166) (by rw [show 2*166 = 332 by decide, phi332]; decide +kernel)
private theorem phi167 : Nat.totient 167 = 166 := step (p := 167) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi334 : Nat.totient 334 = 166 := step (p := 2) (m := 167) (by decide +kernel) (by decide) phi167 (by decide +kernel)
private theorem cell167 : Covered 167 168 := singleton (i := 167) (by rw [show 2*167 = 334 by decide, phi334]; decide +kernel)
private theorem grid166x168 : Covered 166 168 := pair cell166 cell167
private theorem grid164x168 : Covered 164 168 := pair grid164x166 grid166x168
private theorem phi336 : Nat.totient 336 = 96 := step (p := 2) (m := 168) (by decide +kernel) (by decide) phi168 (by decide +kernel)
private theorem cell168 : Covered 168 169 := singleton (i := 168) (by rw [show 2*168 = 336 by decide, phi336]; decide +kernel)
private theorem phi169 : Nat.totient 169 = 156 := step (p := 13) (m := 13) (by decide +kernel) (by decide) phi13 (by decide +kernel)
private theorem phi338 : Nat.totient 338 = 156 := step (p := 2) (m := 169) (by decide +kernel) (by decide) phi169 (by decide +kernel)
private theorem cell169 : Covered 169 170 := singleton (i := 169) (by rw [show 2*169 = 338 by decide, phi338]; decide +kernel)
private theorem grid168x170 : Covered 168 170 := pair cell168 cell169
private theorem phi340 : Nat.totient 340 = 128 := step (p := 2) (m := 170) (by decide +kernel) (by decide) phi170 (by decide +kernel)
private theorem cell170 : Covered 170 171 := singleton (i := 170) (by rw [show 2*170 = 340 by decide, phi340]; decide +kernel)
private theorem phi171 : Nat.totient 171 = 108 := step (p := 3) (m := 57) (by decide +kernel) (by decide) phi57 (by decide +kernel)
private theorem phi342 : Nat.totient 342 = 108 := step (p := 2) (m := 171) (by decide +kernel) (by decide) phi171 (by decide +kernel)
private theorem cell171 : Covered 171 172 := singleton (i := 171) (by rw [show 2*171 = 342 by decide, phi342]; decide +kernel)
private theorem phi344 : Nat.totient 344 = 168 := step (p := 2) (m := 172) (by decide +kernel) (by decide) phi172 (by decide +kernel)
private theorem cell172 : Covered 172 173 := singleton (i := 172) (by rw [show 2*172 = 344 by decide, phi344]; decide +kernel)
private theorem grid171x173 : Covered 171 173 := pair cell171 cell172
private theorem grid170x173 : Covered 170 173 := pair cell170 grid171x173
private theorem grid168x173 : Covered 168 173 := pair grid168x170 grid170x173
private theorem grid164x173 : Covered 164 173 := pair grid164x168 grid168x173
private theorem phi173 : Nat.totient 173 = 172 := step (p := 173) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi346 : Nat.totient 346 = 172 := step (p := 2) (m := 173) (by decide +kernel) (by decide) phi173 (by decide +kernel)
private theorem cell173 : Covered 173 174 := singleton (i := 173) (by rw [show 2*173 = 346 by decide, phi346]; decide +kernel)
private theorem phi348 : Nat.totient 348 = 112 := step (p := 2) (m := 174) (by decide +kernel) (by decide) phi174 (by decide +kernel)
private theorem cell174 : Covered 174 175 := singleton (i := 174) (by rw [show 2*174 = 348 by decide, phi348]; decide +kernel)
private theorem grid173x175 : Covered 173 175 := pair cell173 cell174
private theorem phi175 : Nat.totient 175 = 120 := step (p := 5) (m := 35) (by decide +kernel) (by decide) phi35 (by decide +kernel)
private theorem phi350 : Nat.totient 350 = 120 := step (p := 2) (m := 175) (by decide +kernel) (by decide) phi175 (by decide +kernel)
private theorem cell175 : Covered 175 176 := singleton (i := 175) (by rw [show 2*175 = 350 by decide, phi350]; decide +kernel)
private theorem phi352 : Nat.totient 352 = 160 := step (p := 2) (m := 176) (by decide +kernel) (by decide) phi176 (by decide +kernel)
private theorem cell176 : Covered 176 177 := singleton (i := 176) (by rw [show 2*176 = 352 by decide, phi352]; decide +kernel)
private theorem grid175x177 : Covered 175 177 := pair cell175 cell176
private theorem grid173x177 : Covered 173 177 := pair grid173x175 grid175x177
private theorem phi177 : Nat.totient 177 = 116 := step (p := 3) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi354 : Nat.totient 354 = 116 := step (p := 2) (m := 177) (by decide +kernel) (by decide) phi177 (by decide +kernel)
private theorem cell177 : Covered 177 178 := singleton (i := 177) (by rw [show 2*177 = 354 by decide, phi354]; decide +kernel)
private theorem phi356 : Nat.totient 356 = 176 := step (p := 2) (m := 178) (by decide +kernel) (by decide) phi178 (by decide +kernel)
private theorem cell178 : Covered 178 179 := singleton (i := 178) (by rw [show 2*178 = 356 by decide, phi356]; decide +kernel)
private theorem grid177x179 : Covered 177 179 := pair cell177 cell178
private theorem phi179 : Nat.totient 179 = 178 := step (p := 179) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi358 : Nat.totient 358 = 178 := step (p := 2) (m := 179) (by decide +kernel) (by decide) phi179 (by decide +kernel)
private theorem cell179 : Covered 179 180 := singleton (i := 179) (by rw [show 2*179 = 358 by decide, phi358]; decide +kernel)
private theorem phi360 : Nat.totient 360 = 96 := step (p := 2) (m := 180) (by decide +kernel) (by decide) phi180 (by decide +kernel)
private theorem cell180 : Covered 180 181 := singleton (i := 180) (by rw [show 2*180 = 360 by decide, phi360]; decide +kernel)
private theorem phi181 : Nat.totient 181 = 180 := step (p := 181) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi362 : Nat.totient 362 = 180 := step (p := 2) (m := 181) (by decide +kernel) (by decide) phi181 (by decide +kernel)
private theorem cell181 : Covered 181 182 := singleton (i := 181) (by rw [show 2*181 = 362 by decide, phi362]; decide +kernel)
private theorem grid180x182 : Covered 180 182 := pair cell180 cell181
private theorem grid179x182 : Covered 179 182 := pair cell179 grid180x182
private theorem grid177x182 : Covered 177 182 := pair grid177x179 grid179x182
private theorem grid173x182 : Covered 173 182 := pair grid173x177 grid177x182
private theorem grid164x182 : Covered 164 182 := pair grid164x173 grid173x182
private theorem grid146x182 : Covered 146 182 := pair grid146x164 grid164x182
private theorem phi364 : Nat.totient 364 = 144 := step (p := 2) (m := 182) (by decide +kernel) (by decide) phi182 (by decide +kernel)
private theorem cell182 : Covered 182 183 := singleton (i := 182) (by rw [show 2*182 = 364 by decide, phi364]; decide +kernel)
private theorem phi183 : Nat.totient 183 = 120 := step (p := 3) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi366 : Nat.totient 366 = 120 := step (p := 2) (m := 183) (by decide +kernel) (by decide) phi183 (by decide +kernel)
private theorem cell183 : Covered 183 184 := singleton (i := 183) (by rw [show 2*183 = 366 by decide, phi366]; decide +kernel)
private theorem grid182x184 : Covered 182 184 := pair cell182 cell183
private theorem phi368 : Nat.totient 368 = 176 := step (p := 2) (m := 184) (by decide +kernel) (by decide) phi184 (by decide +kernel)
private theorem cell184 : Covered 184 185 := singleton (i := 184) (by rw [show 2*184 = 368 by decide, phi368]; decide +kernel)
private theorem phi185 : Nat.totient 185 = 144 := step (p := 5) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi370 : Nat.totient 370 = 144 := step (p := 2) (m := 185) (by decide +kernel) (by decide) phi185 (by decide +kernel)
private theorem cell185 : Covered 185 186 := singleton (i := 185) (by rw [show 2*185 = 370 by decide, phi370]; decide +kernel)
private theorem grid184x186 : Covered 184 186 := pair cell184 cell185
private theorem grid182x186 : Covered 182 186 := pair grid182x184 grid184x186
private theorem phi372 : Nat.totient 372 = 120 := step (p := 2) (m := 186) (by decide +kernel) (by decide) phi186 (by decide +kernel)
private theorem cell186 : Covered 186 187 := singleton (i := 186) (by rw [show 2*186 = 372 by decide, phi372]; decide +kernel)
private theorem phi187 : Nat.totient 187 = 160 := step (p := 11) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi374 : Nat.totient 374 = 160 := step (p := 2) (m := 187) (by decide +kernel) (by decide) phi187 (by decide +kernel)
private theorem cell187 : Covered 187 188 := singleton (i := 187) (by rw [show 2*187 = 374 by decide, phi374]; decide +kernel)
private theorem grid186x188 : Covered 186 188 := pair cell186 cell187
private theorem phi376 : Nat.totient 376 = 184 := step (p := 2) (m := 188) (by decide +kernel) (by decide) phi188 (by decide +kernel)
private theorem cell188 : Covered 188 189 := singleton (i := 188) (by rw [show 2*188 = 376 by decide, phi376]; decide +kernel)
private theorem phi189 : Nat.totient 189 = 108 := step (p := 3) (m := 63) (by decide +kernel) (by decide) phi63 (by decide +kernel)
private theorem phi378 : Nat.totient 378 = 108 := step (p := 2) (m := 189) (by decide +kernel) (by decide) phi189 (by decide +kernel)
private theorem cell189 : Covered 189 190 := singleton (i := 189) (by rw [show 2*189 = 378 by decide, phi378]; decide +kernel)
private theorem phi380 : Nat.totient 380 = 144 := step (p := 2) (m := 190) (by decide +kernel) (by decide) phi190 (by decide +kernel)
private theorem cell190 : Covered 190 191 := singleton (i := 190) (by rw [show 2*190 = 380 by decide, phi380]; decide +kernel)
private theorem grid189x191 : Covered 189 191 := pair cell189 cell190
private theorem grid188x191 : Covered 188 191 := pair cell188 grid189x191
private theorem grid186x191 : Covered 186 191 := pair grid186x188 grid188x191
private theorem grid182x191 : Covered 182 191 := pair grid182x186 grid186x191
private theorem phi191 : Nat.totient 191 = 190 := step (p := 191) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi382 : Nat.totient 382 = 190 := step (p := 2) (m := 191) (by decide +kernel) (by decide) phi191 (by decide +kernel)
private theorem cell191 : Covered 191 192 := singleton (i := 191) (by rw [show 2*191 = 382 by decide, phi382]; decide +kernel)
private theorem phi384 : Nat.totient 384 = 128 := step (p := 2) (m := 192) (by decide +kernel) (by decide) phi192 (by decide +kernel)
private theorem cell192 : Covered 192 193 := singleton (i := 192) (by rw [show 2*192 = 384 by decide, phi384]; decide +kernel)
private theorem grid191x193 : Covered 191 193 := pair cell191 cell192
private theorem phi193 : Nat.totient 193 = 192 := step (p := 193) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi386 : Nat.totient 386 = 192 := step (p := 2) (m := 193) (by decide +kernel) (by decide) phi193 (by decide +kernel)
private theorem cell193 : Covered 193 194 := singleton (i := 193) (by rw [show 2*193 = 386 by decide, phi386]; decide +kernel)
private theorem phi388 : Nat.totient 388 = 192 := step (p := 2) (m := 194) (by decide +kernel) (by decide) phi194 (by decide +kernel)
private theorem cell194 : Covered 194 195 := singleton (i := 194) (by rw [show 2*194 = 388 by decide, phi388]; decide +kernel)
private theorem grid193x195 : Covered 193 195 := pair cell193 cell194
private theorem grid191x195 : Covered 191 195 := pair grid191x193 grid193x195
private theorem phi195 : Nat.totient 195 = 96 := step (p := 3) (m := 65) (by decide +kernel) (by decide) phi65 (by decide +kernel)
private theorem phi390 : Nat.totient 390 = 96 := step (p := 2) (m := 195) (by decide +kernel) (by decide) phi195 (by decide +kernel)
private theorem cell195 : Covered 195 196 := singleton (i := 195) (by rw [show 2*195 = 390 by decide, phi390]; decide +kernel)
private theorem phi392 : Nat.totient 392 = 168 := step (p := 2) (m := 196) (by decide +kernel) (by decide) phi196 (by decide +kernel)
private theorem cell196 : Covered 196 197 := singleton (i := 196) (by rw [show 2*196 = 392 by decide, phi392]; decide +kernel)
private theorem grid195x197 : Covered 195 197 := pair cell195 cell196
private theorem phi197 : Nat.totient 197 = 196 := step (p := 197) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi394 : Nat.totient 394 = 196 := step (p := 2) (m := 197) (by decide +kernel) (by decide) phi197 (by decide +kernel)
private theorem cell197 : Covered 197 198 := singleton (i := 197) (by rw [show 2*197 = 394 by decide, phi394]; decide +kernel)
private theorem phi396 : Nat.totient 396 = 120 := step (p := 2) (m := 198) (by decide +kernel) (by decide) phi198 (by decide +kernel)
private theorem cell198 : Covered 198 199 := singleton (i := 198) (by rw [show 2*198 = 396 by decide, phi396]; decide +kernel)
private theorem phi199 : Nat.totient 199 = 198 := step (p := 199) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi398 : Nat.totient 398 = 198 := step (p := 2) (m := 199) (by decide +kernel) (by decide) phi199 (by decide +kernel)
private theorem cell199 : Covered 199 200 := singleton (i := 199) (by rw [show 2*199 = 398 by decide, phi398]; decide +kernel)
private theorem grid198x200 : Covered 198 200 := pair cell198 cell199
private theorem grid197x200 : Covered 197 200 := pair cell197 grid198x200
private theorem grid195x200 : Covered 195 200 := pair grid195x197 grid197x200
private theorem grid191x200 : Covered 191 200 := pair grid191x195 grid195x200
private theorem grid182x200 : Covered 182 200 := pair grid182x191 grid191x200
private theorem phi400 : Nat.totient 400 = 160 := step (p := 2) (m := 200) (by decide +kernel) (by decide) phi200 (by decide +kernel)
private theorem cell200 : Covered 200 201 := singleton (i := 200) (by rw [show 2*200 = 400 by decide, phi400]; decide +kernel)
private theorem phi201 : Nat.totient 201 = 132 := step (p := 3) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi402 : Nat.totient 402 = 132 := step (p := 2) (m := 201) (by decide +kernel) (by decide) phi201 (by decide +kernel)
private theorem cell201 : Covered 201 202 := singleton (i := 201) (by rw [show 2*201 = 402 by decide, phi402]; decide +kernel)
private theorem grid200x202 : Covered 200 202 := pair cell200 cell201
private theorem phi404 : Nat.totient 404 = 200 := step (p := 2) (m := 202) (by decide +kernel) (by decide) phi202 (by decide +kernel)
private theorem cell202 : Covered 202 203 := singleton (i := 202) (by rw [show 2*202 = 404 by decide, phi404]; decide +kernel)
private theorem phi203 : Nat.totient 203 = 168 := step (p := 7) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi406 : Nat.totient 406 = 168 := step (p := 2) (m := 203) (by decide +kernel) (by decide) phi203 (by decide +kernel)
private theorem cell203 : Covered 203 204 := singleton (i := 203) (by rw [show 2*203 = 406 by decide, phi406]; decide +kernel)
private theorem grid202x204 : Covered 202 204 := pair cell202 cell203
private theorem grid200x204 : Covered 200 204 := pair grid200x202 grid202x204
private theorem phi408 : Nat.totient 408 = 128 := step (p := 2) (m := 204) (by decide +kernel) (by decide) phi204 (by decide +kernel)
private theorem cell204 : Covered 204 205 := singleton (i := 204) (by rw [show 2*204 = 408 by decide, phi408]; decide +kernel)
private theorem phi205 : Nat.totient 205 = 160 := step (p := 5) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi410 : Nat.totient 410 = 160 := step (p := 2) (m := 205) (by decide +kernel) (by decide) phi205 (by decide +kernel)
private theorem cell205 : Covered 205 206 := singleton (i := 205) (by rw [show 2*205 = 410 by decide, phi410]; decide +kernel)
private theorem grid204x206 : Covered 204 206 := pair cell204 cell205
private theorem phi412 : Nat.totient 412 = 204 := step (p := 2) (m := 206) (by decide +kernel) (by decide) phi206 (by decide +kernel)
private theorem cell206 : Covered 206 207 := singleton (i := 206) (by rw [show 2*206 = 412 by decide, phi412]; decide +kernel)
private theorem phi207 : Nat.totient 207 = 132 := step (p := 3) (m := 69) (by decide +kernel) (by decide) phi69 (by decide +kernel)
private theorem phi414 : Nat.totient 414 = 132 := step (p := 2) (m := 207) (by decide +kernel) (by decide) phi207 (by decide +kernel)
private theorem cell207 : Covered 207 208 := singleton (i := 207) (by rw [show 2*207 = 414 by decide, phi414]; decide +kernel)
private theorem phi416 : Nat.totient 416 = 192 := step (p := 2) (m := 208) (by decide +kernel) (by decide) phi208 (by decide +kernel)
private theorem cell208 : Covered 208 209 := singleton (i := 208) (by rw [show 2*208 = 416 by decide, phi416]; decide +kernel)
private theorem grid207x209 : Covered 207 209 := pair cell207 cell208
private theorem grid206x209 : Covered 206 209 := pair cell206 grid207x209
private theorem grid204x209 : Covered 204 209 := pair grid204x206 grid206x209
private theorem grid200x209 : Covered 200 209 := pair grid200x204 grid204x209
private theorem phi209 : Nat.totient 209 = 180 := step (p := 11) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi418 : Nat.totient 418 = 180 := step (p := 2) (m := 209) (by decide +kernel) (by decide) phi209 (by decide +kernel)
private theorem cell209 : Covered 209 210 := singleton (i := 209) (by rw [show 2*209 = 418 by decide, phi418]; decide +kernel)
private theorem phi420 : Nat.totient 420 = 96 := step (p := 2) (m := 210) (by decide +kernel) (by decide) phi210 (by decide +kernel)
private theorem cell210 : Covered 210 211 := singleton (i := 210) (by rw [show 2*210 = 420 by decide, phi420]; decide +kernel)
private theorem grid209x211 : Covered 209 211 := pair cell209 cell210
private theorem phi211 : Nat.totient 211 = 210 := step (p := 211) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi422 : Nat.totient 422 = 210 := step (p := 2) (m := 211) (by decide +kernel) (by decide) phi211 (by decide +kernel)
private theorem cell211 : Covered 211 212 := singleton (i := 211) (by rw [show 2*211 = 422 by decide, phi422]; decide +kernel)
private theorem phi424 : Nat.totient 424 = 208 := step (p := 2) (m := 212) (by decide +kernel) (by decide) phi212 (by decide +kernel)
private theorem cell212 : Covered 212 213 := singleton (i := 212) (by rw [show 2*212 = 424 by decide, phi424]; decide +kernel)
private theorem phi213 : Nat.totient 213 = 140 := step (p := 3) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem phi426 : Nat.totient 426 = 140 := step (p := 2) (m := 213) (by decide +kernel) (by decide) phi213 (by decide +kernel)
private theorem cell213 : Covered 213 214 := singleton (i := 213) (by rw [show 2*213 = 426 by decide, phi426]; decide +kernel)
private theorem grid212x214 : Covered 212 214 := pair cell212 cell213
private theorem grid211x214 : Covered 211 214 := pair cell211 grid212x214
private theorem grid209x214 : Covered 209 214 := pair grid209x211 grid211x214
private theorem phi428 : Nat.totient 428 = 212 := step (p := 2) (m := 214) (by decide +kernel) (by decide) phi214 (by decide +kernel)
private theorem cell214 : Covered 214 215 := singleton (i := 214) (by rw [show 2*214 = 428 by decide, phi428]; decide +kernel)
private theorem phi215 : Nat.totient 215 = 168 := step (p := 5) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi430 : Nat.totient 430 = 168 := step (p := 2) (m := 215) (by decide +kernel) (by decide) phi215 (by decide +kernel)
private theorem cell215 : Covered 215 216 := singleton (i := 215) (by rw [show 2*215 = 430 by decide, phi430]; decide +kernel)
private theorem grid214x216 : Covered 214 216 := pair cell214 cell215
private theorem phi432 : Nat.totient 432 = 144 := step (p := 2) (m := 216) (by decide +kernel) (by decide) phi216 (by decide +kernel)
private theorem cell216 : Covered 216 217 := singleton (i := 216) (by rw [show 2*216 = 432 by decide, phi432]; decide +kernel)
private theorem phi217 : Nat.totient 217 = 180 := step (p := 7) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi434 : Nat.totient 434 = 180 := step (p := 2) (m := 217) (by decide +kernel) (by decide) phi217 (by decide +kernel)
private theorem cell217 : Covered 217 218 := singleton (i := 217) (by rw [show 2*217 = 434 by decide, phi434]; decide +kernel)
private theorem phi436 : Nat.totient 436 = 216 := step (p := 2) (m := 218) (by decide +kernel) (by decide) phi218 (by decide +kernel)
private theorem cell218 : Covered 218 219 := singleton (i := 218) (by rw [show 2*218 = 436 by decide, phi436]; decide +kernel)
private theorem grid217x219 : Covered 217 219 := pair cell217 cell218
private theorem grid216x219 : Covered 216 219 := pair cell216 grid217x219
private theorem grid214x219 : Covered 214 219 := pair grid214x216 grid216x219
private theorem grid209x219 : Covered 209 219 := pair grid209x214 grid214x219
private theorem grid200x219 : Covered 200 219 := pair grid200x209 grid209x219
private theorem grid182x219 : Covered 182 219 := pair grid182x200 grid200x219
private theorem grid146x219 : Covered 146 219 := pair grid146x182 grid182x219
private theorem phi219 : Nat.totient 219 = 144 := step (p := 3) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem phi438 : Nat.totient 438 = 144 := step (p := 2) (m := 219) (by decide +kernel) (by decide) phi219 (by decide +kernel)
private theorem cell219 : Covered 219 220 := singleton (i := 219) (by rw [show 2*219 = 438 by decide, phi438]; decide +kernel)
private theorem phi440 : Nat.totient 440 = 160 := step (p := 2) (m := 220) (by decide +kernel) (by decide) phi220 (by decide +kernel)
private theorem cell220 : Covered 220 221 := singleton (i := 220) (by rw [show 2*220 = 440 by decide, phi440]; decide +kernel)
private theorem grid219x221 : Covered 219 221 := pair cell219 cell220
private theorem phi221 : Nat.totient 221 = 192 := step (p := 13) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi442 : Nat.totient 442 = 192 := step (p := 2) (m := 221) (by decide +kernel) (by decide) phi221 (by decide +kernel)
private theorem cell221 : Covered 221 222 := singleton (i := 221) (by rw [show 2*221 = 442 by decide, phi442]; decide +kernel)
private theorem phi444 : Nat.totient 444 = 144 := step (p := 2) (m := 222) (by decide +kernel) (by decide) phi222 (by decide +kernel)
private theorem cell222 : Covered 222 223 := singleton (i := 222) (by rw [show 2*222 = 444 by decide, phi444]; decide +kernel)
private theorem grid221x223 : Covered 221 223 := pair cell221 cell222
private theorem grid219x223 : Covered 219 223 := pair grid219x221 grid221x223
private theorem phi223 : Nat.totient 223 = 222 := step (p := 223) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi446 : Nat.totient 446 = 222 := step (p := 2) (m := 223) (by decide +kernel) (by decide) phi223 (by decide +kernel)
private theorem cell223 : Covered 223 224 := singleton (i := 223) (by rw [show 2*223 = 446 by decide, phi446]; decide +kernel)
private theorem phi448 : Nat.totient 448 = 192 := step (p := 2) (m := 224) (by decide +kernel) (by decide) phi224 (by decide +kernel)
private theorem cell224 : Covered 224 225 := singleton (i := 224) (by rw [show 2*224 = 448 by decide, phi448]; decide +kernel)
private theorem grid223x225 : Covered 223 225 := pair cell223 cell224
private theorem phi225 : Nat.totient 225 = 120 := step (p := 3) (m := 75) (by decide +kernel) (by decide) phi75 (by decide +kernel)
private theorem phi450 : Nat.totient 450 = 120 := step (p := 2) (m := 225) (by decide +kernel) (by decide) phi225 (by decide +kernel)
private theorem cell225 : Covered 225 226 := singleton (i := 225) (by rw [show 2*225 = 450 by decide, phi450]; decide +kernel)
private theorem phi452 : Nat.totient 452 = 224 := step (p := 2) (m := 226) (by decide +kernel) (by decide) phi226 (by decide +kernel)
private theorem cell226 : Covered 226 227 := singleton (i := 226) (by rw [show 2*226 = 452 by decide, phi452]; decide +kernel)
private theorem phi227 : Nat.totient 227 = 226 := step (p := 227) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi454 : Nat.totient 454 = 226 := step (p := 2) (m := 227) (by decide +kernel) (by decide) phi227 (by decide +kernel)
private theorem cell227 : Covered 227 228 := singleton (i := 227) (by rw [show 2*227 = 454 by decide, phi454]; decide +kernel)
private theorem grid226x228 : Covered 226 228 := pair cell226 cell227
private theorem grid225x228 : Covered 225 228 := pair cell225 grid226x228
private theorem grid223x228 : Covered 223 228 := pair grid223x225 grid225x228
private theorem grid219x228 : Covered 219 228 := pair grid219x223 grid223x228
private theorem phi456 : Nat.totient 456 = 144 := step (p := 2) (m := 228) (by decide +kernel) (by decide) phi228 (by decide +kernel)
private theorem cell228 : Covered 228 229 := singleton (i := 228) (by rw [show 2*228 = 456 by decide, phi456]; decide +kernel)
private theorem phi229 : Nat.totient 229 = 228 := step (p := 229) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi458 : Nat.totient 458 = 228 := step (p := 2) (m := 229) (by decide +kernel) (by decide) phi229 (by decide +kernel)
private theorem cell229 : Covered 229 230 := singleton (i := 229) (by rw [show 2*229 = 458 by decide, phi458]; decide +kernel)
private theorem grid228x230 : Covered 228 230 := pair cell228 cell229
private theorem phi460 : Nat.totient 460 = 176 := step (p := 2) (m := 230) (by decide +kernel) (by decide) phi230 (by decide +kernel)
private theorem cell230 : Covered 230 231 := singleton (i := 230) (by rw [show 2*230 = 460 by decide, phi460]; decide +kernel)
private theorem phi231 : Nat.totient 231 = 120 := step (p := 3) (m := 77) (by decide +kernel) (by decide) phi77 (by decide +kernel)
private theorem phi462 : Nat.totient 462 = 120 := step (p := 2) (m := 231) (by decide +kernel) (by decide) phi231 (by decide +kernel)
private theorem cell231 : Covered 231 232 := singleton (i := 231) (by rw [show 2*231 = 462 by decide, phi462]; decide +kernel)
private theorem grid230x232 : Covered 230 232 := pair cell230 cell231
private theorem grid228x232 : Covered 228 232 := pair grid228x230 grid230x232
private theorem phi464 : Nat.totient 464 = 224 := step (p := 2) (m := 232) (by decide +kernel) (by decide) phi232 (by decide +kernel)
private theorem cell232 : Covered 232 233 := singleton (i := 232) (by rw [show 2*232 = 464 by decide, phi464]; decide +kernel)
private theorem phi233 : Nat.totient 233 = 232 := step (p := 233) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi466 : Nat.totient 466 = 232 := step (p := 2) (m := 233) (by decide +kernel) (by decide) phi233 (by decide +kernel)
private theorem cell233 : Covered 233 234 := singleton (i := 233) (by rw [show 2*233 = 466 by decide, phi466]; decide +kernel)
private theorem grid232x234 : Covered 232 234 := pair cell232 cell233
private theorem phi468 : Nat.totient 468 = 144 := step (p := 2) (m := 234) (by decide +kernel) (by decide) phi234 (by decide +kernel)
private theorem cell234 : Covered 234 235 := singleton (i := 234) (by rw [show 2*234 = 468 by decide, phi468]; decide +kernel)
private theorem phi235 : Nat.totient 235 = 184 := step (p := 5) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi470 : Nat.totient 470 = 184 := step (p := 2) (m := 235) (by decide +kernel) (by decide) phi235 (by decide +kernel)
private theorem cell235 : Covered 235 236 := singleton (i := 235) (by rw [show 2*235 = 470 by decide, phi470]; decide +kernel)
private theorem phi472 : Nat.totient 472 = 232 := step (p := 2) (m := 236) (by decide +kernel) (by decide) phi236 (by decide +kernel)
private theorem cell236 : Covered 236 237 := singleton (i := 236) (by rw [show 2*236 = 472 by decide, phi472]; decide +kernel)
private theorem grid235x237 : Covered 235 237 := pair cell235 cell236
private theorem grid234x237 : Covered 234 237 := pair cell234 grid235x237
private theorem grid232x237 : Covered 232 237 := pair grid232x234 grid234x237
private theorem grid228x237 : Covered 228 237 := pair grid228x232 grid232x237
private theorem grid219x237 : Covered 219 237 := pair grid219x228 grid228x237
private theorem phi237 : Nat.totient 237 = 156 := step (p := 3) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem phi474 : Nat.totient 474 = 156 := step (p := 2) (m := 237) (by decide +kernel) (by decide) phi237 (by decide +kernel)
private theorem cell237 : Covered 237 238 := singleton (i := 237) (by rw [show 2*237 = 474 by decide, phi474]; decide +kernel)
private theorem phi476 : Nat.totient 476 = 192 := step (p := 2) (m := 238) (by decide +kernel) (by decide) phi238 (by decide +kernel)
private theorem cell238 : Covered 238 239 := singleton (i := 238) (by rw [show 2*238 = 476 by decide, phi476]; decide +kernel)
private theorem grid237x239 : Covered 237 239 := pair cell237 cell238
private theorem phi239 : Nat.totient 239 = 238 := step (p := 239) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi478 : Nat.totient 478 = 238 := step (p := 2) (m := 239) (by decide +kernel) (by decide) phi239 (by decide +kernel)
private theorem cell239 : Covered 239 240 := singleton (i := 239) (by rw [show 2*239 = 478 by decide, phi478]; decide +kernel)
private theorem phi480 : Nat.totient 480 = 128 := step (p := 2) (m := 240) (by decide +kernel) (by decide) phi240 (by decide +kernel)
private theorem cell240 : Covered 240 241 := singleton (i := 240) (by rw [show 2*240 = 480 by decide, phi480]; decide +kernel)
private theorem grid239x241 : Covered 239 241 := pair cell239 cell240
private theorem grid237x241 : Covered 237 241 := pair grid237x239 grid239x241
private theorem phi241 : Nat.totient 241 = 240 := step (p := 241) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi482 : Nat.totient 482 = 240 := step (p := 2) (m := 241) (by decide +kernel) (by decide) phi241 (by decide +kernel)
private theorem cell241 : Covered 241 242 := singleton (i := 241) (by rw [show 2*241 = 482 by decide, phi482]; decide +kernel)
private theorem phi484 : Nat.totient 484 = 220 := step (p := 2) (m := 242) (by decide +kernel) (by decide) phi242 (by decide +kernel)
private theorem cell242 : Covered 242 243 := singleton (i := 242) (by rw [show 2*242 = 484 by decide, phi484]; decide +kernel)
private theorem grid241x243 : Covered 241 243 := pair cell241 cell242
private theorem phi243 : Nat.totient 243 = 162 := step (p := 3) (m := 81) (by decide +kernel) (by decide) phi81 (by decide +kernel)
private theorem phi486 : Nat.totient 486 = 162 := step (p := 2) (m := 243) (by decide +kernel) (by decide) phi243 (by decide +kernel)
private theorem cell243 : Covered 243 244 := singleton (i := 243) (by rw [show 2*243 = 486 by decide, phi486]; decide +kernel)
private theorem phi488 : Nat.totient 488 = 240 := step (p := 2) (m := 244) (by decide +kernel) (by decide) phi244 (by decide +kernel)
private theorem cell244 : Covered 244 245 := singleton (i := 244) (by rw [show 2*244 = 488 by decide, phi488]; decide +kernel)
private theorem phi245 : Nat.totient 245 = 168 := step (p := 5) (m := 49) (by decide +kernel) (by decide) phi49 (by decide +kernel)
private theorem phi490 : Nat.totient 490 = 168 := step (p := 2) (m := 245) (by decide +kernel) (by decide) phi245 (by decide +kernel)
private theorem cell245 : Covered 245 246 := singleton (i := 245) (by rw [show 2*245 = 490 by decide, phi490]; decide +kernel)
private theorem grid244x246 : Covered 244 246 := pair cell244 cell245
private theorem grid243x246 : Covered 243 246 := pair cell243 grid244x246
private theorem grid241x246 : Covered 241 246 := pair grid241x243 grid243x246
private theorem grid237x246 : Covered 237 246 := pair grid237x241 grid241x246
private theorem phi492 : Nat.totient 492 = 160 := step (p := 2) (m := 246) (by decide +kernel) (by decide) phi246 (by decide +kernel)
private theorem cell246 : Covered 246 247 := singleton (i := 246) (by rw [show 2*246 = 492 by decide, phi492]; decide +kernel)
private theorem phi247 : Nat.totient 247 = 216 := step (p := 13) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi494 : Nat.totient 494 = 216 := step (p := 2) (m := 247) (by decide +kernel) (by decide) phi247 (by decide +kernel)
private theorem cell247 : Covered 247 248 := singleton (i := 247) (by rw [show 2*247 = 494 by decide, phi494]; decide +kernel)
private theorem grid246x248 : Covered 246 248 := pair cell246 cell247
private theorem phi496 : Nat.totient 496 = 240 := step (p := 2) (m := 248) (by decide +kernel) (by decide) phi248 (by decide +kernel)
private theorem cell248 : Covered 248 249 := singleton (i := 248) (by rw [show 2*248 = 496 by decide, phi496]; decide +kernel)
private theorem phi249 : Nat.totient 249 = 164 := step (p := 3) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem phi498 : Nat.totient 498 = 164 := step (p := 2) (m := 249) (by decide +kernel) (by decide) phi249 (by decide +kernel)
private theorem cell249 : Covered 249 250 := singleton (i := 249) (by rw [show 2*249 = 498 by decide, phi498]; decide +kernel)
private theorem grid248x250 : Covered 248 250 := pair cell248 cell249
private theorem grid246x250 : Covered 246 250 := pair grid246x248 grid248x250
private theorem phi500 : Nat.totient 500 = 200 := step (p := 2) (m := 250) (by decide +kernel) (by decide) phi250 (by decide +kernel)
private theorem cell250 : Covered 250 251 := singleton (i := 250) (by rw [show 2*250 = 500 by decide, phi500]; decide +kernel)
private theorem phi251 : Nat.totient 251 = 250 := step (p := 251) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi502 : Nat.totient 502 = 250 := step (p := 2) (m := 251) (by decide +kernel) (by decide) phi251 (by decide +kernel)
private theorem cell251 : Covered 251 252 := singleton (i := 251) (by rw [show 2*251 = 502 by decide, phi502]; decide +kernel)
private theorem grid250x252 : Covered 250 252 := pair cell250 cell251
private theorem phi504 : Nat.totient 504 = 144 := step (p := 2) (m := 252) (by decide +kernel) (by decide) phi252 (by decide +kernel)
private theorem cell252 : Covered 252 253 := singleton (i := 252) (by rw [show 2*252 = 504 by decide, phi504]; decide +kernel)
private theorem phi253 : Nat.totient 253 = 220 := step (p := 11) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi506 : Nat.totient 506 = 220 := step (p := 2) (m := 253) (by decide +kernel) (by decide) phi253 (by decide +kernel)
private theorem cell253 : Covered 253 254 := singleton (i := 253) (by rw [show 2*253 = 506 by decide, phi506]; decide +kernel)
private theorem phi508 : Nat.totient 508 = 252 := step (p := 2) (m := 254) (by decide +kernel) (by decide) phi254 (by decide +kernel)
private theorem cell254 : Covered 254 255 := singleton (i := 254) (by rw [show 2*254 = 508 by decide, phi508]; decide +kernel)
private theorem grid253x255 : Covered 253 255 := pair cell253 cell254
private theorem grid252x255 : Covered 252 255 := pair cell252 grid253x255
private theorem grid250x255 : Covered 250 255 := pair grid250x252 grid252x255
private theorem grid246x255 : Covered 246 255 := pair grid246x250 grid250x255
private theorem grid237x255 : Covered 237 255 := pair grid237x246 grid246x255
private theorem grid219x255 : Covered 219 255 := pair grid219x237 grid237x255
private theorem phi255 : Nat.totient 255 = 128 := step (p := 3) (m := 85) (by decide +kernel) (by decide) phi85 (by decide +kernel)
private theorem phi510 : Nat.totient 510 = 128 := step (p := 2) (m := 255) (by decide +kernel) (by decide) phi255 (by decide +kernel)
private theorem cell255 : Covered 255 256 := singleton (i := 255) (by rw [show 2*255 = 510 by decide, phi510]; decide +kernel)
private theorem phi512 : Nat.totient 512 = 256 := step (p := 2) (m := 256) (by decide +kernel) (by decide) phi256 (by decide +kernel)
private theorem cell256 : Covered 256 257 := singleton (i := 256) (by rw [show 2*256 = 512 by decide, phi512]; decide +kernel)
private theorem grid255x257 : Covered 255 257 := pair cell255 cell256
private theorem phi257 : Nat.totient 257 = 256 := step (p := 257) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi514 : Nat.totient 514 = 256 := step (p := 2) (m := 257) (by decide +kernel) (by decide) phi257 (by decide +kernel)
private theorem cell257 : Covered 257 258 := singleton (i := 257) (by rw [show 2*257 = 514 by decide, phi514]; decide +kernel)
private theorem phi516 : Nat.totient 516 = 168 := step (p := 2) (m := 258) (by decide +kernel) (by decide) phi258 (by decide +kernel)
private theorem cell258 : Covered 258 259 := singleton (i := 258) (by rw [show 2*258 = 516 by decide, phi516]; decide +kernel)
private theorem grid257x259 : Covered 257 259 := pair cell257 cell258
private theorem grid255x259 : Covered 255 259 := pair grid255x257 grid257x259
private theorem phi259 : Nat.totient 259 = 216 := step (p := 7) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi518 : Nat.totient 518 = 216 := step (p := 2) (m := 259) (by decide +kernel) (by decide) phi259 (by decide +kernel)
private theorem cell259 : Covered 259 260 := singleton (i := 259) (by rw [show 2*259 = 518 by decide, phi518]; decide +kernel)
private theorem phi520 : Nat.totient 520 = 192 := step (p := 2) (m := 260) (by decide +kernel) (by decide) phi260 (by decide +kernel)
private theorem cell260 : Covered 260 261 := singleton (i := 260) (by rw [show 2*260 = 520 by decide, phi520]; decide +kernel)
private theorem grid259x261 : Covered 259 261 := pair cell259 cell260
private theorem phi261 : Nat.totient 261 = 168 := step (p := 3) (m := 87) (by decide +kernel) (by decide) phi87 (by decide +kernel)
private theorem phi522 : Nat.totient 522 = 168 := step (p := 2) (m := 261) (by decide +kernel) (by decide) phi261 (by decide +kernel)
private theorem cell261 : Covered 261 262 := singleton (i := 261) (by rw [show 2*261 = 522 by decide, phi522]; decide +kernel)
private theorem phi524 : Nat.totient 524 = 260 := step (p := 2) (m := 262) (by decide +kernel) (by decide) phi262 (by decide +kernel)
private theorem cell262 : Covered 262 263 := singleton (i := 262) (by rw [show 2*262 = 524 by decide, phi524]; decide +kernel)
private theorem phi263 : Nat.totient 263 = 262 := step (p := 263) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi526 : Nat.totient 526 = 262 := step (p := 2) (m := 263) (by decide +kernel) (by decide) phi263 (by decide +kernel)
private theorem cell263 : Covered 263 264 := singleton (i := 263) (by rw [show 2*263 = 526 by decide, phi526]; decide +kernel)
private theorem grid262x264 : Covered 262 264 := pair cell262 cell263
private theorem grid261x264 : Covered 261 264 := pair cell261 grid262x264
private theorem grid259x264 : Covered 259 264 := pair grid259x261 grid261x264
private theorem grid255x264 : Covered 255 264 := pair grid255x259 grid259x264
private theorem phi528 : Nat.totient 528 = 160 := step (p := 2) (m := 264) (by decide +kernel) (by decide) phi264 (by decide +kernel)
private theorem cell264 : Covered 264 265 := singleton (i := 264) (by rw [show 2*264 = 528 by decide, phi528]; decide +kernel)
private theorem phi265 : Nat.totient 265 = 208 := step (p := 5) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi530 : Nat.totient 530 = 208 := step (p := 2) (m := 265) (by decide +kernel) (by decide) phi265 (by decide +kernel)
private theorem cell265 : Covered 265 266 := singleton (i := 265) (by rw [show 2*265 = 530 by decide, phi530]; decide +kernel)
private theorem grid264x266 : Covered 264 266 := pair cell264 cell265
private theorem phi532 : Nat.totient 532 = 216 := step (p := 2) (m := 266) (by decide +kernel) (by decide) phi266 (by decide +kernel)
private theorem cell266 : Covered 266 267 := singleton (i := 266) (by rw [show 2*266 = 532 by decide, phi532]; decide +kernel)
private theorem phi267 : Nat.totient 267 = 176 := step (p := 3) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem phi534 : Nat.totient 534 = 176 := step (p := 2) (m := 267) (by decide +kernel) (by decide) phi267 (by decide +kernel)
private theorem cell267 : Covered 267 268 := singleton (i := 267) (by rw [show 2*267 = 534 by decide, phi534]; decide +kernel)
private theorem grid266x268 : Covered 266 268 := pair cell266 cell267
private theorem grid264x268 : Covered 264 268 := pair grid264x266 grid266x268
private theorem phi536 : Nat.totient 536 = 264 := step (p := 2) (m := 268) (by decide +kernel) (by decide) phi268 (by decide +kernel)
private theorem cell268 : Covered 268 269 := singleton (i := 268) (by rw [show 2*268 = 536 by decide, phi536]; decide +kernel)
private theorem phi269 : Nat.totient 269 = 268 := step (p := 269) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi538 : Nat.totient 538 = 268 := step (p := 2) (m := 269) (by decide +kernel) (by decide) phi269 (by decide +kernel)
private theorem cell269 : Covered 269 270 := singleton (i := 269) (by rw [show 2*269 = 538 by decide, phi538]; decide +kernel)
private theorem grid268x270 : Covered 268 270 := pair cell268 cell269
private theorem phi540 : Nat.totient 540 = 144 := step (p := 2) (m := 270) (by decide +kernel) (by decide) phi270 (by decide +kernel)
private theorem cell270 : Covered 270 271 := singleton (i := 270) (by rw [show 2*270 = 540 by decide, phi540]; decide +kernel)
private theorem phi271 : Nat.totient 271 = 270 := step (p := 271) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi542 : Nat.totient 542 = 270 := step (p := 2) (m := 271) (by decide +kernel) (by decide) phi271 (by decide +kernel)
private theorem cell271 : Covered 271 272 := singleton (i := 271) (by rw [show 2*271 = 542 by decide, phi542]; decide +kernel)
private theorem phi544 : Nat.totient 544 = 256 := step (p := 2) (m := 272) (by decide +kernel) (by decide) phi272 (by decide +kernel)
private theorem cell272 : Covered 272 273 := singleton (i := 272) (by rw [show 2*272 = 544 by decide, phi544]; decide +kernel)
private theorem grid271x273 : Covered 271 273 := pair cell271 cell272
private theorem grid270x273 : Covered 270 273 := pair cell270 grid271x273
private theorem grid268x273 : Covered 268 273 := pair grid268x270 grid270x273
private theorem grid264x273 : Covered 264 273 := pair grid264x268 grid268x273
private theorem grid255x273 : Covered 255 273 := pair grid255x264 grid264x273
private theorem phi273 : Nat.totient 273 = 144 := step (p := 3) (m := 91) (by decide +kernel) (by decide) phi91 (by decide +kernel)
private theorem phi546 : Nat.totient 546 = 144 := step (p := 2) (m := 273) (by decide +kernel) (by decide) phi273 (by decide +kernel)
private theorem cell273 : Covered 273 274 := singleton (i := 273) (by rw [show 2*273 = 546 by decide, phi546]; decide +kernel)
private theorem phi548 : Nat.totient 548 = 272 := step (p := 2) (m := 274) (by decide +kernel) (by decide) phi274 (by decide +kernel)
private theorem cell274 : Covered 274 275 := singleton (i := 274) (by rw [show 2*274 = 548 by decide, phi548]; decide +kernel)
private theorem grid273x275 : Covered 273 275 := pair cell273 cell274
private theorem phi275 : Nat.totient 275 = 200 := step (p := 5) (m := 55) (by decide +kernel) (by decide) phi55 (by decide +kernel)
private theorem phi550 : Nat.totient 550 = 200 := step (p := 2) (m := 275) (by decide +kernel) (by decide) phi275 (by decide +kernel)
private theorem cell275 : Covered 275 276 := singleton (i := 275) (by rw [show 2*275 = 550 by decide, phi550]; decide +kernel)
private theorem phi552 : Nat.totient 552 = 176 := step (p := 2) (m := 276) (by decide +kernel) (by decide) phi276 (by decide +kernel)
private theorem cell276 : Covered 276 277 := singleton (i := 276) (by rw [show 2*276 = 552 by decide, phi552]; decide +kernel)
private theorem grid275x277 : Covered 275 277 := pair cell275 cell276
private theorem grid273x277 : Covered 273 277 := pair grid273x275 grid275x277
private theorem phi277 : Nat.totient 277 = 276 := step (p := 277) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi554 : Nat.totient 554 = 276 := step (p := 2) (m := 277) (by decide +kernel) (by decide) phi277 (by decide +kernel)
private theorem cell277 : Covered 277 278 := singleton (i := 277) (by rw [show 2*277 = 554 by decide, phi554]; decide +kernel)
private theorem phi556 : Nat.totient 556 = 276 := step (p := 2) (m := 278) (by decide +kernel) (by decide) phi278 (by decide +kernel)
private theorem cell278 : Covered 278 279 := singleton (i := 278) (by rw [show 2*278 = 556 by decide, phi556]; decide +kernel)
private theorem grid277x279 : Covered 277 279 := pair cell277 cell278
private theorem phi279 : Nat.totient 279 = 180 := step (p := 3) (m := 93) (by decide +kernel) (by decide) phi93 (by decide +kernel)
private theorem phi558 : Nat.totient 558 = 180 := step (p := 2) (m := 279) (by decide +kernel) (by decide) phi279 (by decide +kernel)
private theorem cell279 : Covered 279 280 := singleton (i := 279) (by rw [show 2*279 = 558 by decide, phi558]; decide +kernel)
private theorem phi560 : Nat.totient 560 = 192 := step (p := 2) (m := 280) (by decide +kernel) (by decide) phi280 (by decide +kernel)
private theorem cell280 : Covered 280 281 := singleton (i := 280) (by rw [show 2*280 = 560 by decide, phi560]; decide +kernel)
private theorem phi281 : Nat.totient 281 = 280 := step (p := 281) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi562 : Nat.totient 562 = 280 := step (p := 2) (m := 281) (by decide +kernel) (by decide) phi281 (by decide +kernel)
private theorem cell281 : Covered 281 282 := singleton (i := 281) (by rw [show 2*281 = 562 by decide, phi562]; decide +kernel)
private theorem grid280x282 : Covered 280 282 := pair cell280 cell281
private theorem grid279x282 : Covered 279 282 := pair cell279 grid280x282
private theorem grid277x282 : Covered 277 282 := pair grid277x279 grid279x282
private theorem grid273x282 : Covered 273 282 := pair grid273x277 grid277x282
private theorem phi564 : Nat.totient 564 = 184 := step (p := 2) (m := 282) (by decide +kernel) (by decide) phi282 (by decide +kernel)
private theorem cell282 : Covered 282 283 := singleton (i := 282) (by rw [show 2*282 = 564 by decide, phi564]; decide +kernel)
private theorem phi283 : Nat.totient 283 = 282 := step (p := 283) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi566 : Nat.totient 566 = 282 := step (p := 2) (m := 283) (by decide +kernel) (by decide) phi283 (by decide +kernel)
private theorem cell283 : Covered 283 284 := singleton (i := 283) (by rw [show 2*283 = 566 by decide, phi566]; decide +kernel)
private theorem grid282x284 : Covered 282 284 := pair cell282 cell283
private theorem phi568 : Nat.totient 568 = 280 := step (p := 2) (m := 284) (by decide +kernel) (by decide) phi284 (by decide +kernel)
private theorem cell284 : Covered 284 285 := singleton (i := 284) (by rw [show 2*284 = 568 by decide, phi568]; decide +kernel)
private theorem phi285 : Nat.totient 285 = 144 := step (p := 3) (m := 95) (by decide +kernel) (by decide) phi95 (by decide +kernel)
private theorem phi570 : Nat.totient 570 = 144 := step (p := 2) (m := 285) (by decide +kernel) (by decide) phi285 (by decide +kernel)
private theorem cell285 : Covered 285 286 := singleton (i := 285) (by rw [show 2*285 = 570 by decide, phi570]; decide +kernel)
private theorem phi572 : Nat.totient 572 = 240 := step (p := 2) (m := 286) (by decide +kernel) (by decide) phi286 (by decide +kernel)
private theorem cell286 : Covered 286 287 := singleton (i := 286) (by rw [show 2*286 = 572 by decide, phi572]; decide +kernel)
private theorem grid285x287 : Covered 285 287 := pair cell285 cell286
private theorem grid284x287 : Covered 284 287 := pair cell284 grid285x287
private theorem grid282x287 : Covered 282 287 := pair grid282x284 grid284x287
private theorem phi287 : Nat.totient 287 = 240 := step (p := 7) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi574 : Nat.totient 574 = 240 := step (p := 2) (m := 287) (by decide +kernel) (by decide) phi287 (by decide +kernel)
private theorem cell287 : Covered 287 288 := singleton (i := 287) (by rw [show 2*287 = 574 by decide, phi574]; decide +kernel)
private theorem phi576 : Nat.totient 576 = 192 := step (p := 2) (m := 288) (by decide +kernel) (by decide) phi288 (by decide +kernel)
private theorem cell288 : Covered 288 289 := singleton (i := 288) (by rw [show 2*288 = 576 by decide, phi576]; decide +kernel)
private theorem grid287x289 : Covered 287 289 := pair cell287 cell288
private theorem phi289 : Nat.totient 289 = 272 := step (p := 17) (m := 17) (by decide +kernel) (by decide) phi17 (by decide +kernel)
private theorem phi578 : Nat.totient 578 = 272 := step (p := 2) (m := 289) (by decide +kernel) (by decide) phi289 (by decide +kernel)
private theorem cell289 : Covered 289 290 := singleton (i := 289) (by rw [show 2*289 = 578 by decide, phi578]; decide +kernel)
private theorem phi580 : Nat.totient 580 = 224 := step (p := 2) (m := 290) (by decide +kernel) (by decide) phi290 (by decide +kernel)
private theorem cell290 : Covered 290 291 := singleton (i := 290) (by rw [show 2*290 = 580 by decide, phi580]; decide +kernel)
private theorem phi291 : Nat.totient 291 = 192 := step (p := 3) (m := 97) (by decide +kernel) (by decide) phi97 (by decide +kernel)
private theorem phi582 : Nat.totient 582 = 192 := step (p := 2) (m := 291) (by decide +kernel) (by decide) phi291 (by decide +kernel)
private theorem cell291 : Covered 291 292 := singleton (i := 291) (by rw [show 2*291 = 582 by decide, phi582]; decide +kernel)
private theorem grid290x292 : Covered 290 292 := pair cell290 cell291
private theorem grid289x292 : Covered 289 292 := pair cell289 grid290x292
private theorem grid287x292 : Covered 287 292 := pair grid287x289 grid289x292
private theorem grid282x292 : Covered 282 292 := pair grid282x287 grid287x292
private theorem grid273x292 : Covered 273 292 := pair grid273x282 grid282x292
private theorem grid255x292 : Covered 255 292 := pair grid255x273 grid273x292
private theorem grid219x292 : Covered 219 292 := pair grid219x255 grid255x292
private theorem grid146x292 : Covered 146 292 := pair grid146x219 grid219x292
private theorem grid1x292 : Covered 1 292 := pair grid1x146 grid146x292
private theorem phi584 : Nat.totient 584 = 288 := step (p := 2) (m := 292) (by decide +kernel) (by decide) phi292 (by decide +kernel)
private theorem cell292 : Covered 292 293 := singleton (i := 292) (by rw [show 2*292 = 584 by decide, phi584]; decide +kernel)
private theorem phi293 : Nat.totient 293 = 292 := step (p := 293) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi586 : Nat.totient 586 = 292 := step (p := 2) (m := 293) (by decide +kernel) (by decide) phi293 (by decide +kernel)
private theorem cell293 : Covered 293 294 := singleton (i := 293) (by rw [show 2*293 = 586 by decide, phi586]; decide +kernel)
private theorem grid292x294 : Covered 292 294 := pair cell292 cell293
private theorem phi588 : Nat.totient 588 = 168 := step (p := 2) (m := 294) (by decide +kernel) (by decide) phi294 (by decide +kernel)
private theorem cell294 : Covered 294 295 := singleton (i := 294) (by rw [show 2*294 = 588 by decide, phi588]; decide +kernel)
private theorem phi295 : Nat.totient 295 = 232 := step (p := 5) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi590 : Nat.totient 590 = 232 := step (p := 2) (m := 295) (by decide +kernel) (by decide) phi295 (by decide +kernel)
private theorem cell295 : Covered 295 296 := singleton (i := 295) (by rw [show 2*295 = 590 by decide, phi590]; decide +kernel)
private theorem grid294x296 : Covered 294 296 := pair cell294 cell295
private theorem grid292x296 : Covered 292 296 := pair grid292x294 grid294x296
private theorem phi592 : Nat.totient 592 = 288 := step (p := 2) (m := 296) (by decide +kernel) (by decide) phi296 (by decide +kernel)
private theorem cell296 : Covered 296 297 := singleton (i := 296) (by rw [show 2*296 = 592 by decide, phi592]; decide +kernel)
private theorem phi297 : Nat.totient 297 = 180 := step (p := 3) (m := 99) (by decide +kernel) (by decide) phi99 (by decide +kernel)
private theorem phi594 : Nat.totient 594 = 180 := step (p := 2) (m := 297) (by decide +kernel) (by decide) phi297 (by decide +kernel)
private theorem cell297 : Covered 297 298 := singleton (i := 297) (by rw [show 2*297 = 594 by decide, phi594]; decide +kernel)
private theorem grid296x298 : Covered 296 298 := pair cell296 cell297
private theorem phi596 : Nat.totient 596 = 296 := step (p := 2) (m := 298) (by decide +kernel) (by decide) phi298 (by decide +kernel)
private theorem cell298 : Covered 298 299 := singleton (i := 298) (by rw [show 2*298 = 596 by decide, phi596]; decide +kernel)
private theorem phi299 : Nat.totient 299 = 264 := step (p := 13) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi598 : Nat.totient 598 = 264 := step (p := 2) (m := 299) (by decide +kernel) (by decide) phi299 (by decide +kernel)
private theorem cell299 : Covered 299 300 := singleton (i := 299) (by rw [show 2*299 = 598 by decide, phi598]; decide +kernel)
private theorem phi600 : Nat.totient 600 = 160 := step (p := 2) (m := 300) (by decide +kernel) (by decide) phi300 (by decide +kernel)
private theorem cell300 : Covered 300 301 := singleton (i := 300) (by rw [show 2*300 = 600 by decide, phi600]; decide +kernel)
private theorem grid299x301 : Covered 299 301 := pair cell299 cell300
private theorem grid298x301 : Covered 298 301 := pair cell298 grid299x301
private theorem grid296x301 : Covered 296 301 := pair grid296x298 grid298x301
private theorem grid292x301 : Covered 292 301 := pair grid292x296 grid296x301
private theorem phi301 : Nat.totient 301 = 252 := step (p := 7) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi602 : Nat.totient 602 = 252 := step (p := 2) (m := 301) (by decide +kernel) (by decide) phi301 (by decide +kernel)
private theorem cell301 : Covered 301 302 := singleton (i := 301) (by rw [show 2*301 = 602 by decide, phi602]; decide +kernel)
private theorem phi604 : Nat.totient 604 = 300 := step (p := 2) (m := 302) (by decide +kernel) (by decide) phi302 (by decide +kernel)
private theorem cell302 : Covered 302 303 := singleton (i := 302) (by rw [show 2*302 = 604 by decide, phi604]; decide +kernel)
private theorem grid301x303 : Covered 301 303 := pair cell301 cell302
private theorem phi303 : Nat.totient 303 = 200 := step (p := 3) (m := 101) (by decide +kernel) (by decide) phi101 (by decide +kernel)
private theorem phi606 : Nat.totient 606 = 200 := step (p := 2) (m := 303) (by decide +kernel) (by decide) phi303 (by decide +kernel)
private theorem cell303 : Covered 303 304 := singleton (i := 303) (by rw [show 2*303 = 606 by decide, phi606]; decide +kernel)
private theorem phi608 : Nat.totient 608 = 288 := step (p := 2) (m := 304) (by decide +kernel) (by decide) phi304 (by decide +kernel)
private theorem cell304 : Covered 304 305 := singleton (i := 304) (by rw [show 2*304 = 608 by decide, phi608]; decide +kernel)
private theorem grid303x305 : Covered 303 305 := pair cell303 cell304
private theorem grid301x305 : Covered 301 305 := pair grid301x303 grid303x305
private theorem phi305 : Nat.totient 305 = 240 := step (p := 5) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi610 : Nat.totient 610 = 240 := step (p := 2) (m := 305) (by decide +kernel) (by decide) phi305 (by decide +kernel)
private theorem cell305 : Covered 305 306 := singleton (i := 305) (by rw [show 2*305 = 610 by decide, phi610]; decide +kernel)
private theorem phi612 : Nat.totient 612 = 192 := step (p := 2) (m := 306) (by decide +kernel) (by decide) phi306 (by decide +kernel)
private theorem cell306 : Covered 306 307 := singleton (i := 306) (by rw [show 2*306 = 612 by decide, phi612]; decide +kernel)
private theorem grid305x307 : Covered 305 307 := pair cell305 cell306
private theorem phi307 : Nat.totient 307 = 306 := step (p := 307) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi614 : Nat.totient 614 = 306 := step (p := 2) (m := 307) (by decide +kernel) (by decide) phi307 (by decide +kernel)
private theorem cell307 : Covered 307 308 := singleton (i := 307) (by rw [show 2*307 = 614 by decide, phi614]; decide +kernel)
private theorem phi616 : Nat.totient 616 = 240 := step (p := 2) (m := 308) (by decide +kernel) (by decide) phi308 (by decide +kernel)
private theorem cell308 : Covered 308 309 := singleton (i := 308) (by rw [show 2*308 = 616 by decide, phi616]; decide +kernel)
private theorem phi309 : Nat.totient 309 = 204 := step (p := 3) (m := 103) (by decide +kernel) (by decide) phi103 (by decide +kernel)
private theorem phi618 : Nat.totient 618 = 204 := step (p := 2) (m := 309) (by decide +kernel) (by decide) phi309 (by decide +kernel)
private theorem cell309 : Covered 309 310 := singleton (i := 309) (by rw [show 2*309 = 618 by decide, phi618]; decide +kernel)
private theorem grid308x310 : Covered 308 310 := pair cell308 cell309
private theorem grid307x310 : Covered 307 310 := pair cell307 grid308x310
private theorem grid305x310 : Covered 305 310 := pair grid305x307 grid307x310
private theorem grid301x310 : Covered 301 310 := pair grid301x305 grid305x310
private theorem grid292x310 : Covered 292 310 := pair grid292x301 grid301x310
private theorem phi620 : Nat.totient 620 = 240 := step (p := 2) (m := 310) (by decide +kernel) (by decide) phi310 (by decide +kernel)
private theorem cell310 : Covered 310 311 := singleton (i := 310) (by rw [show 2*310 = 620 by decide, phi620]; decide +kernel)
private theorem phi311 : Nat.totient 311 = 310 := step (p := 311) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi622 : Nat.totient 622 = 310 := step (p := 2) (m := 311) (by decide +kernel) (by decide) phi311 (by decide +kernel)
private theorem cell311 : Covered 311 312 := singleton (i := 311) (by rw [show 2*311 = 622 by decide, phi622]; decide +kernel)
private theorem grid310x312 : Covered 310 312 := pair cell310 cell311
private theorem phi624 : Nat.totient 624 = 192 := step (p := 2) (m := 312) (by decide +kernel) (by decide) phi312 (by decide +kernel)
private theorem cell312 : Covered 312 313 := singleton (i := 312) (by rw [show 2*312 = 624 by decide, phi624]; decide +kernel)
private theorem phi313 : Nat.totient 313 = 312 := step (p := 313) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi626 : Nat.totient 626 = 312 := step (p := 2) (m := 313) (by decide +kernel) (by decide) phi313 (by decide +kernel)
private theorem cell313 : Covered 313 314 := singleton (i := 313) (by rw [show 2*313 = 626 by decide, phi626]; decide +kernel)
private theorem grid312x314 : Covered 312 314 := pair cell312 cell313
private theorem grid310x314 : Covered 310 314 := pair grid310x312 grid312x314
private theorem phi628 : Nat.totient 628 = 312 := step (p := 2) (m := 314) (by decide +kernel) (by decide) phi314 (by decide +kernel)
private theorem cell314 : Covered 314 315 := singleton (i := 314) (by rw [show 2*314 = 628 by decide, phi628]; decide +kernel)
private theorem phi315 : Nat.totient 315 = 144 := step (p := 3) (m := 105) (by decide +kernel) (by decide) phi105 (by decide +kernel)
private theorem phi630 : Nat.totient 630 = 144 := step (p := 2) (m := 315) (by decide +kernel) (by decide) phi315 (by decide +kernel)
private theorem cell315 : Covered 315 316 := singleton (i := 315) (by rw [show 2*315 = 630 by decide, phi630]; decide +kernel)
private theorem grid314x316 : Covered 314 316 := pair cell314 cell315
private theorem phi632 : Nat.totient 632 = 312 := step (p := 2) (m := 316) (by decide +kernel) (by decide) phi316 (by decide +kernel)
private theorem cell316 : Covered 316 317 := singleton (i := 316) (by rw [show 2*316 = 632 by decide, phi632]; decide +kernel)
private theorem phi317 : Nat.totient 317 = 316 := step (p := 317) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi634 : Nat.totient 634 = 316 := step (p := 2) (m := 317) (by decide +kernel) (by decide) phi317 (by decide +kernel)
private theorem cell317 : Covered 317 318 := singleton (i := 317) (by rw [show 2*317 = 634 by decide, phi634]; decide +kernel)
private theorem phi636 : Nat.totient 636 = 208 := step (p := 2) (m := 318) (by decide +kernel) (by decide) phi318 (by decide +kernel)
private theorem cell318 : Covered 318 319 := singleton (i := 318) (by rw [show 2*318 = 636 by decide, phi636]; decide +kernel)
private theorem grid317x319 : Covered 317 319 := pair cell317 cell318
private theorem grid316x319 : Covered 316 319 := pair cell316 grid317x319
private theorem grid314x319 : Covered 314 319 := pair grid314x316 grid316x319
private theorem grid310x319 : Covered 310 319 := pair grid310x314 grid314x319
private theorem phi319 : Nat.totient 319 = 280 := step (p := 11) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi638 : Nat.totient 638 = 280 := step (p := 2) (m := 319) (by decide +kernel) (by decide) phi319 (by decide +kernel)
private theorem cell319 : Covered 319 320 := singleton (i := 319) (by rw [show 2*319 = 638 by decide, phi638]; decide +kernel)
private theorem phi640 : Nat.totient 640 = 256 := step (p := 2) (m := 320) (by decide +kernel) (by decide) phi320 (by decide +kernel)
private theorem cell320 : Covered 320 321 := singleton (i := 320) (by rw [show 2*320 = 640 by decide, phi640]; decide +kernel)
private theorem grid319x321 : Covered 319 321 := pair cell319 cell320
private theorem phi321 : Nat.totient 321 = 212 := step (p := 3) (m := 107) (by decide +kernel) (by decide) phi107 (by decide +kernel)
private theorem phi642 : Nat.totient 642 = 212 := step (p := 2) (m := 321) (by decide +kernel) (by decide) phi321 (by decide +kernel)
private theorem cell321 : Covered 321 322 := singleton (i := 321) (by rw [show 2*321 = 642 by decide, phi642]; decide +kernel)
private theorem phi644 : Nat.totient 644 = 264 := step (p := 2) (m := 322) (by decide +kernel) (by decide) phi322 (by decide +kernel)
private theorem cell322 : Covered 322 323 := singleton (i := 322) (by rw [show 2*322 = 644 by decide, phi644]; decide +kernel)
private theorem grid321x323 : Covered 321 323 := pair cell321 cell322
private theorem grid319x323 : Covered 319 323 := pair grid319x321 grid321x323
private theorem phi323 : Nat.totient 323 = 288 := step (p := 17) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi646 : Nat.totient 646 = 288 := step (p := 2) (m := 323) (by decide +kernel) (by decide) phi323 (by decide +kernel)
private theorem cell323 : Covered 323 324 := singleton (i := 323) (by rw [show 2*323 = 646 by decide, phi646]; decide +kernel)
private theorem phi648 : Nat.totient 648 = 216 := step (p := 2) (m := 324) (by decide +kernel) (by decide) phi324 (by decide +kernel)
private theorem cell324 : Covered 324 325 := singleton (i := 324) (by rw [show 2*324 = 648 by decide, phi648]; decide +kernel)
private theorem grid323x325 : Covered 323 325 := pair cell323 cell324
private theorem phi325 : Nat.totient 325 = 240 := step (p := 5) (m := 65) (by decide +kernel) (by decide) phi65 (by decide +kernel)
private theorem phi650 : Nat.totient 650 = 240 := step (p := 2) (m := 325) (by decide +kernel) (by decide) phi325 (by decide +kernel)
private theorem cell325 : Covered 325 326 := singleton (i := 325) (by rw [show 2*325 = 650 by decide, phi650]; decide +kernel)
private theorem phi652 : Nat.totient 652 = 324 := step (p := 2) (m := 326) (by decide +kernel) (by decide) phi326 (by decide +kernel)
private theorem cell326 : Covered 326 327 := singleton (i := 326) (by rw [show 2*326 = 652 by decide, phi652]; decide +kernel)
private theorem phi327 : Nat.totient 327 = 216 := step (p := 3) (m := 109) (by decide +kernel) (by decide) phi109 (by decide +kernel)
private theorem phi654 : Nat.totient 654 = 216 := step (p := 2) (m := 327) (by decide +kernel) (by decide) phi327 (by decide +kernel)
private theorem cell327 : Covered 327 328 := singleton (i := 327) (by rw [show 2*327 = 654 by decide, phi654]; decide +kernel)
private theorem grid326x328 : Covered 326 328 := pair cell326 cell327
private theorem grid325x328 : Covered 325 328 := pair cell325 grid326x328
private theorem grid323x328 : Covered 323 328 := pair grid323x325 grid325x328
private theorem grid319x328 : Covered 319 328 := pair grid319x323 grid323x328
private theorem grid310x328 : Covered 310 328 := pair grid310x319 grid319x328
private theorem grid292x328 : Covered 292 328 := pair grid292x310 grid310x328
private theorem phi656 : Nat.totient 656 = 320 := step (p := 2) (m := 328) (by decide +kernel) (by decide) phi328 (by decide +kernel)
private theorem cell328 : Covered 328 329 := singleton (i := 328) (by rw [show 2*328 = 656 by decide, phi656]; decide +kernel)
private theorem phi329 : Nat.totient 329 = 276 := step (p := 7) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi658 : Nat.totient 658 = 276 := step (p := 2) (m := 329) (by decide +kernel) (by decide) phi329 (by decide +kernel)
private theorem cell329 : Covered 329 330 := singleton (i := 329) (by rw [show 2*329 = 658 by decide, phi658]; decide +kernel)
private theorem grid328x330 : Covered 328 330 := pair cell328 cell329
private theorem phi660 : Nat.totient 660 = 160 := step (p := 2) (m := 330) (by decide +kernel) (by decide) phi330 (by decide +kernel)
private theorem cell330 : Covered 330 331 := singleton (i := 330) (by rw [show 2*330 = 660 by decide, phi660]; decide +kernel)
private theorem phi331 : Nat.totient 331 = 330 := step (p := 331) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi662 : Nat.totient 662 = 330 := step (p := 2) (m := 331) (by decide +kernel) (by decide) phi331 (by decide +kernel)
private theorem cell331 : Covered 331 332 := singleton (i := 331) (by rw [show 2*331 = 662 by decide, phi662]; decide +kernel)
private theorem grid330x332 : Covered 330 332 := pair cell330 cell331
private theorem grid328x332 : Covered 328 332 := pair grid328x330 grid330x332
private theorem phi664 : Nat.totient 664 = 328 := step (p := 2) (m := 332) (by decide +kernel) (by decide) phi332 (by decide +kernel)
private theorem cell332 : Covered 332 333 := singleton (i := 332) (by rw [show 2*332 = 664 by decide, phi664]; decide +kernel)
private theorem phi333 : Nat.totient 333 = 216 := step (p := 3) (m := 111) (by decide +kernel) (by decide) phi111 (by decide +kernel)
private theorem phi666 : Nat.totient 666 = 216 := step (p := 2) (m := 333) (by decide +kernel) (by decide) phi333 (by decide +kernel)
private theorem cell333 : Covered 333 334 := singleton (i := 333) (by rw [show 2*333 = 666 by decide, phi666]; decide +kernel)
private theorem grid332x334 : Covered 332 334 := pair cell332 cell333
private theorem phi668 : Nat.totient 668 = 332 := step (p := 2) (m := 334) (by decide +kernel) (by decide) phi334 (by decide +kernel)
private theorem cell334 : Covered 334 335 := singleton (i := 334) (by rw [show 2*334 = 668 by decide, phi668]; decide +kernel)
private theorem phi335 : Nat.totient 335 = 264 := step (p := 5) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi670 : Nat.totient 670 = 264 := step (p := 2) (m := 335) (by decide +kernel) (by decide) phi335 (by decide +kernel)
private theorem cell335 : Covered 335 336 := singleton (i := 335) (by rw [show 2*335 = 670 by decide, phi670]; decide +kernel)
private theorem phi672 : Nat.totient 672 = 192 := step (p := 2) (m := 336) (by decide +kernel) (by decide) phi336 (by decide +kernel)
private theorem cell336 : Covered 336 337 := singleton (i := 336) (by rw [show 2*336 = 672 by decide, phi672]; decide +kernel)
private theorem grid335x337 : Covered 335 337 := pair cell335 cell336
private theorem grid334x337 : Covered 334 337 := pair cell334 grid335x337
private theorem grid332x337 : Covered 332 337 := pair grid332x334 grid334x337
private theorem grid328x337 : Covered 328 337 := pair grid328x332 grid332x337
private theorem phi337 : Nat.totient 337 = 336 := step (p := 337) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi674 : Nat.totient 674 = 336 := step (p := 2) (m := 337) (by decide +kernel) (by decide) phi337 (by decide +kernel)
private theorem cell337 : Covered 337 338 := singleton (i := 337) (by rw [show 2*337 = 674 by decide, phi674]; decide +kernel)
private theorem phi676 : Nat.totient 676 = 312 := step (p := 2) (m := 338) (by decide +kernel) (by decide) phi338 (by decide +kernel)
private theorem cell338 : Covered 338 339 := singleton (i := 338) (by rw [show 2*338 = 676 by decide, phi676]; decide +kernel)
private theorem grid337x339 : Covered 337 339 := pair cell337 cell338
private theorem phi339 : Nat.totient 339 = 224 := step (p := 3) (m := 113) (by decide +kernel) (by decide) phi113 (by decide +kernel)
private theorem phi678 : Nat.totient 678 = 224 := step (p := 2) (m := 339) (by decide +kernel) (by decide) phi339 (by decide +kernel)
private theorem cell339 : Covered 339 340 := singleton (i := 339) (by rw [show 2*339 = 678 by decide, phi678]; decide +kernel)
private theorem phi680 : Nat.totient 680 = 256 := step (p := 2) (m := 340) (by decide +kernel) (by decide) phi340 (by decide +kernel)
private theorem cell340 : Covered 340 341 := singleton (i := 340) (by rw [show 2*340 = 680 by decide, phi680]; decide +kernel)
private theorem grid339x341 : Covered 339 341 := pair cell339 cell340
private theorem grid337x341 : Covered 337 341 := pair grid337x339 grid339x341
private theorem phi341 : Nat.totient 341 = 300 := step (p := 11) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi682 : Nat.totient 682 = 300 := step (p := 2) (m := 341) (by decide +kernel) (by decide) phi341 (by decide +kernel)
private theorem cell341 : Covered 341 342 := singleton (i := 341) (by rw [show 2*341 = 682 by decide, phi682]; decide +kernel)
private theorem phi684 : Nat.totient 684 = 216 := step (p := 2) (m := 342) (by decide +kernel) (by decide) phi342 (by decide +kernel)
private theorem cell342 : Covered 342 343 := singleton (i := 342) (by rw [show 2*342 = 684 by decide, phi684]; decide +kernel)
private theorem grid341x343 : Covered 341 343 := pair cell341 cell342
private theorem phi343 : Nat.totient 343 = 294 := step (p := 7) (m := 49) (by decide +kernel) (by decide) phi49 (by decide +kernel)
private theorem phi686 : Nat.totient 686 = 294 := step (p := 2) (m := 343) (by decide +kernel) (by decide) phi343 (by decide +kernel)
private theorem cell343 : Covered 343 344 := singleton (i := 343) (by rw [show 2*343 = 686 by decide, phi686]; decide +kernel)
private theorem phi688 : Nat.totient 688 = 336 := step (p := 2) (m := 344) (by decide +kernel) (by decide) phi344 (by decide +kernel)
private theorem cell344 : Covered 344 345 := singleton (i := 344) (by rw [show 2*344 = 688 by decide, phi688]; decide +kernel)
private theorem phi345 : Nat.totient 345 = 176 := step (p := 3) (m := 115) (by decide +kernel) (by decide) phi115 (by decide +kernel)
private theorem phi690 : Nat.totient 690 = 176 := step (p := 2) (m := 345) (by decide +kernel) (by decide) phi345 (by decide +kernel)
private theorem cell345 : Covered 345 346 := singleton (i := 345) (by rw [show 2*345 = 690 by decide, phi690]; decide +kernel)
private theorem grid344x346 : Covered 344 346 := pair cell344 cell345
private theorem grid343x346 : Covered 343 346 := pair cell343 grid344x346
private theorem grid341x346 : Covered 341 346 := pair grid341x343 grid343x346
private theorem grid337x346 : Covered 337 346 := pair grid337x341 grid341x346
private theorem grid328x346 : Covered 328 346 := pair grid328x337 grid337x346
private theorem phi692 : Nat.totient 692 = 344 := step (p := 2) (m := 346) (by decide +kernel) (by decide) phi346 (by decide +kernel)
private theorem cell346 : Covered 346 347 := singleton (i := 346) (by rw [show 2*346 = 692 by decide, phi692]; decide +kernel)
private theorem phi347 : Nat.totient 347 = 346 := step (p := 347) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi694 : Nat.totient 694 = 346 := step (p := 2) (m := 347) (by decide +kernel) (by decide) phi347 (by decide +kernel)
private theorem cell347 : Covered 347 348 := singleton (i := 347) (by rw [show 2*347 = 694 by decide, phi694]; decide +kernel)
private theorem grid346x348 : Covered 346 348 := pair cell346 cell347
private theorem phi696 : Nat.totient 696 = 224 := step (p := 2) (m := 348) (by decide +kernel) (by decide) phi348 (by decide +kernel)
private theorem cell348 : Covered 348 349 := singleton (i := 348) (by rw [show 2*348 = 696 by decide, phi696]; decide +kernel)
private theorem phi349 : Nat.totient 349 = 348 := step (p := 349) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi698 : Nat.totient 698 = 348 := step (p := 2) (m := 349) (by decide +kernel) (by decide) phi349 (by decide +kernel)
private theorem cell349 : Covered 349 350 := singleton (i := 349) (by rw [show 2*349 = 698 by decide, phi698]; decide +kernel)
private theorem grid348x350 : Covered 348 350 := pair cell348 cell349
private theorem grid346x350 : Covered 346 350 := pair grid346x348 grid348x350
private theorem phi700 : Nat.totient 700 = 240 := step (p := 2) (m := 350) (by decide +kernel) (by decide) phi350 (by decide +kernel)
private theorem cell350 : Covered 350 351 := singleton (i := 350) (by rw [show 2*350 = 700 by decide, phi700]; decide +kernel)
private theorem phi351 : Nat.totient 351 = 216 := step (p := 3) (m := 117) (by decide +kernel) (by decide) phi117 (by decide +kernel)
private theorem phi702 : Nat.totient 702 = 216 := step (p := 2) (m := 351) (by decide +kernel) (by decide) phi351 (by decide +kernel)
private theorem cell351 : Covered 351 352 := singleton (i := 351) (by rw [show 2*351 = 702 by decide, phi702]; decide +kernel)
private theorem grid350x352 : Covered 350 352 := pair cell350 cell351
private theorem phi704 : Nat.totient 704 = 320 := step (p := 2) (m := 352) (by decide +kernel) (by decide) phi352 (by decide +kernel)
private theorem cell352 : Covered 352 353 := singleton (i := 352) (by rw [show 2*352 = 704 by decide, phi704]; decide +kernel)
private theorem phi353 : Nat.totient 353 = 352 := step (p := 353) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi706 : Nat.totient 706 = 352 := step (p := 2) (m := 353) (by decide +kernel) (by decide) phi353 (by decide +kernel)
private theorem cell353 : Covered 353 354 := singleton (i := 353) (by rw [show 2*353 = 706 by decide, phi706]; decide +kernel)
private theorem phi708 : Nat.totient 708 = 232 := step (p := 2) (m := 354) (by decide +kernel) (by decide) phi354 (by decide +kernel)
private theorem cell354 : Covered 354 355 := singleton (i := 354) (by rw [show 2*354 = 708 by decide, phi708]; decide +kernel)
private theorem grid353x355 : Covered 353 355 := pair cell353 cell354
private theorem grid352x355 : Covered 352 355 := pair cell352 grid353x355
private theorem grid350x355 : Covered 350 355 := pair grid350x352 grid352x355
private theorem grid346x355 : Covered 346 355 := pair grid346x350 grid350x355
private theorem phi355 : Nat.totient 355 = 280 := step (p := 5) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem phi710 : Nat.totient 710 = 280 := step (p := 2) (m := 355) (by decide +kernel) (by decide) phi355 (by decide +kernel)
private theorem cell355 : Covered 355 356 := singleton (i := 355) (by rw [show 2*355 = 710 by decide, phi710]; decide +kernel)
private theorem phi712 : Nat.totient 712 = 352 := step (p := 2) (m := 356) (by decide +kernel) (by decide) phi356 (by decide +kernel)
private theorem cell356 : Covered 356 357 := singleton (i := 356) (by rw [show 2*356 = 712 by decide, phi712]; decide +kernel)
private theorem grid355x357 : Covered 355 357 := pair cell355 cell356
private theorem phi357 : Nat.totient 357 = 192 := step (p := 3) (m := 119) (by decide +kernel) (by decide) phi119 (by decide +kernel)
private theorem phi714 : Nat.totient 714 = 192 := step (p := 2) (m := 357) (by decide +kernel) (by decide) phi357 (by decide +kernel)
private theorem cell357 : Covered 357 358 := singleton (i := 357) (by rw [show 2*357 = 714 by decide, phi714]; decide +kernel)
private theorem phi716 : Nat.totient 716 = 356 := step (p := 2) (m := 358) (by decide +kernel) (by decide) phi358 (by decide +kernel)
private theorem cell358 : Covered 358 359 := singleton (i := 358) (by rw [show 2*358 = 716 by decide, phi716]; decide +kernel)
private theorem grid357x359 : Covered 357 359 := pair cell357 cell358
private theorem grid355x359 : Covered 355 359 := pair grid355x357 grid357x359
private theorem phi359 : Nat.totient 359 = 358 := step (p := 359) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi718 : Nat.totient 718 = 358 := step (p := 2) (m := 359) (by decide +kernel) (by decide) phi359 (by decide +kernel)
private theorem cell359 : Covered 359 360 := singleton (i := 359) (by rw [show 2*359 = 718 by decide, phi718]; decide +kernel)
private theorem phi720 : Nat.totient 720 = 192 := step (p := 2) (m := 360) (by decide +kernel) (by decide) phi360 (by decide +kernel)
private theorem cell360 : Covered 360 361 := singleton (i := 360) (by rw [show 2*360 = 720 by decide, phi720]; decide +kernel)
private theorem grid359x361 : Covered 359 361 := pair cell359 cell360
private theorem phi361 : Nat.totient 361 = 342 := step (p := 19) (m := 19) (by decide +kernel) (by decide) phi19 (by decide +kernel)
private theorem phi722 : Nat.totient 722 = 342 := step (p := 2) (m := 361) (by decide +kernel) (by decide) phi361 (by decide +kernel)
private theorem cell361 : Covered 361 362 := singleton (i := 361) (by rw [show 2*361 = 722 by decide, phi722]; decide +kernel)
private theorem phi724 : Nat.totient 724 = 360 := step (p := 2) (m := 362) (by decide +kernel) (by decide) phi362 (by decide +kernel)
private theorem cell362 : Covered 362 363 := singleton (i := 362) (by rw [show 2*362 = 724 by decide, phi724]; decide +kernel)
private theorem phi363 : Nat.totient 363 = 220 := step (p := 3) (m := 121) (by decide +kernel) (by decide) phi121 (by decide +kernel)
private theorem phi726 : Nat.totient 726 = 220 := step (p := 2) (m := 363) (by decide +kernel) (by decide) phi363 (by decide +kernel)
private theorem cell363 : Covered 363 364 := singleton (i := 363) (by rw [show 2*363 = 726 by decide, phi726]; decide +kernel)
private theorem grid362x364 : Covered 362 364 := pair cell362 cell363
private theorem grid361x364 : Covered 361 364 := pair cell361 grid362x364
private theorem grid359x364 : Covered 359 364 := pair grid359x361 grid361x364
private theorem grid355x364 : Covered 355 364 := pair grid355x359 grid359x364
private theorem grid346x364 : Covered 346 364 := pair grid346x355 grid355x364
private theorem grid328x364 : Covered 328 364 := pair grid328x346 grid346x364
private theorem grid292x364 : Covered 292 364 := pair grid292x328 grid328x364
private theorem phi728 : Nat.totient 728 = 288 := step (p := 2) (m := 364) (by decide +kernel) (by decide) phi364 (by decide +kernel)
private theorem cell364 : Covered 364 365 := singleton (i := 364) (by rw [show 2*364 = 728 by decide, phi728]; decide +kernel)
private theorem phi365 : Nat.totient 365 = 288 := step (p := 5) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem phi730 : Nat.totient 730 = 288 := step (p := 2) (m := 365) (by decide +kernel) (by decide) phi365 (by decide +kernel)
private theorem cell365 : Covered 365 366 := singleton (i := 365) (by rw [show 2*365 = 730 by decide, phi730]; decide +kernel)
private theorem grid364x366 : Covered 364 366 := pair cell364 cell365
private theorem phi732 : Nat.totient 732 = 240 := step (p := 2) (m := 366) (by decide +kernel) (by decide) phi366 (by decide +kernel)
private theorem cell366 : Covered 366 367 := singleton (i := 366) (by rw [show 2*366 = 732 by decide, phi732]; decide +kernel)
private theorem phi367 : Nat.totient 367 = 366 := step (p := 367) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi734 : Nat.totient 734 = 366 := step (p := 2) (m := 367) (by decide +kernel) (by decide) phi367 (by decide +kernel)
private theorem cell367 : Covered 367 368 := singleton (i := 367) (by rw [show 2*367 = 734 by decide, phi734]; decide +kernel)
private theorem grid366x368 : Covered 366 368 := pair cell366 cell367
private theorem grid364x368 : Covered 364 368 := pair grid364x366 grid366x368
private theorem phi736 : Nat.totient 736 = 352 := step (p := 2) (m := 368) (by decide +kernel) (by decide) phi368 (by decide +kernel)
private theorem cell368 : Covered 368 369 := singleton (i := 368) (by rw [show 2*368 = 736 by decide, phi736]; decide +kernel)
private theorem phi369 : Nat.totient 369 = 240 := step (p := 3) (m := 123) (by decide +kernel) (by decide) phi123 (by decide +kernel)
private theorem phi738 : Nat.totient 738 = 240 := step (p := 2) (m := 369) (by decide +kernel) (by decide) phi369 (by decide +kernel)
private theorem cell369 : Covered 369 370 := singleton (i := 369) (by rw [show 2*369 = 738 by decide, phi738]; decide +kernel)
private theorem grid368x370 : Covered 368 370 := pair cell368 cell369
private theorem phi740 : Nat.totient 740 = 288 := step (p := 2) (m := 370) (by decide +kernel) (by decide) phi370 (by decide +kernel)
private theorem cell370 : Covered 370 371 := singleton (i := 370) (by rw [show 2*370 = 740 by decide, phi740]; decide +kernel)
private theorem phi371 : Nat.totient 371 = 312 := step (p := 7) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi742 : Nat.totient 742 = 312 := step (p := 2) (m := 371) (by decide +kernel) (by decide) phi371 (by decide +kernel)
private theorem cell371 : Covered 371 372 := singleton (i := 371) (by rw [show 2*371 = 742 by decide, phi742]; decide +kernel)
private theorem phi744 : Nat.totient 744 = 240 := step (p := 2) (m := 372) (by decide +kernel) (by decide) phi372 (by decide +kernel)
private theorem cell372 : Covered 372 373 := singleton (i := 372) (by rw [show 2*372 = 744 by decide, phi744]; decide +kernel)
private theorem grid371x373 : Covered 371 373 := pair cell371 cell372
private theorem grid370x373 : Covered 370 373 := pair cell370 grid371x373
private theorem grid368x373 : Covered 368 373 := pair grid368x370 grid370x373
private theorem grid364x373 : Covered 364 373 := pair grid364x368 grid368x373
private theorem phi373 : Nat.totient 373 = 372 := step (p := 373) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi746 : Nat.totient 746 = 372 := step (p := 2) (m := 373) (by decide +kernel) (by decide) phi373 (by decide +kernel)
private theorem cell373 : Covered 373 374 := singleton (i := 373) (by rw [show 2*373 = 746 by decide, phi746]; decide +kernel)
private theorem phi748 : Nat.totient 748 = 320 := step (p := 2) (m := 374) (by decide +kernel) (by decide) phi374 (by decide +kernel)
private theorem cell374 : Covered 374 375 := singleton (i := 374) (by rw [show 2*374 = 748 by decide, phi748]; decide +kernel)
private theorem grid373x375 : Covered 373 375 := pair cell373 cell374
private theorem phi375 : Nat.totient 375 = 200 := step (p := 3) (m := 125) (by decide +kernel) (by decide) phi125 (by decide +kernel)
private theorem phi750 : Nat.totient 750 = 200 := step (p := 2) (m := 375) (by decide +kernel) (by decide) phi375 (by decide +kernel)
private theorem cell375 : Covered 375 376 := singleton (i := 375) (by rw [show 2*375 = 750 by decide, phi750]; decide +kernel)
private theorem phi752 : Nat.totient 752 = 368 := step (p := 2) (m := 376) (by decide +kernel) (by decide) phi376 (by decide +kernel)
private theorem cell376 : Covered 376 377 := singleton (i := 376) (by rw [show 2*376 = 752 by decide, phi752]; decide +kernel)
private theorem grid375x377 : Covered 375 377 := pair cell375 cell376
private theorem grid373x377 : Covered 373 377 := pair grid373x375 grid375x377
private theorem phi377 : Nat.totient 377 = 336 := step (p := 13) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi754 : Nat.totient 754 = 336 := step (p := 2) (m := 377) (by decide +kernel) (by decide) phi377 (by decide +kernel)
private theorem cell377 : Covered 377 378 := singleton (i := 377) (by rw [show 2*377 = 754 by decide, phi754]; decide +kernel)
private theorem phi756 : Nat.totient 756 = 216 := step (p := 2) (m := 378) (by decide +kernel) (by decide) phi378 (by decide +kernel)
private theorem cell378 : Covered 378 379 := singleton (i := 378) (by rw [show 2*378 = 756 by decide, phi756]; decide +kernel)
private theorem grid377x379 : Covered 377 379 := pair cell377 cell378
private theorem phi379 : Nat.totient 379 = 378 := step (p := 379) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi758 : Nat.totient 758 = 378 := step (p := 2) (m := 379) (by decide +kernel) (by decide) phi379 (by decide +kernel)
private theorem cell379 : Covered 379 380 := singleton (i := 379) (by rw [show 2*379 = 758 by decide, phi758]; decide +kernel)
private theorem phi760 : Nat.totient 760 = 288 := step (p := 2) (m := 380) (by decide +kernel) (by decide) phi380 (by decide +kernel)
private theorem cell380 : Covered 380 381 := singleton (i := 380) (by rw [show 2*380 = 760 by decide, phi760]; decide +kernel)
private theorem phi381 : Nat.totient 381 = 252 := step (p := 3) (m := 127) (by decide +kernel) (by decide) phi127 (by decide +kernel)
private theorem phi762 : Nat.totient 762 = 252 := step (p := 2) (m := 381) (by decide +kernel) (by decide) phi381 (by decide +kernel)
private theorem cell381 : Covered 381 382 := singleton (i := 381) (by rw [show 2*381 = 762 by decide, phi762]; decide +kernel)
private theorem grid380x382 : Covered 380 382 := pair cell380 cell381
private theorem grid379x382 : Covered 379 382 := pair cell379 grid380x382
private theorem grid377x382 : Covered 377 382 := pair grid377x379 grid379x382
private theorem grid373x382 : Covered 373 382 := pair grid373x377 grid377x382
private theorem grid364x382 : Covered 364 382 := pair grid364x373 grid373x382
private theorem phi764 : Nat.totient 764 = 380 := step (p := 2) (m := 382) (by decide +kernel) (by decide) phi382 (by decide +kernel)
private theorem cell382 : Covered 382 383 := singleton (i := 382) (by rw [show 2*382 = 764 by decide, phi764]; decide +kernel)
private theorem phi383 : Nat.totient 383 = 382 := step (p := 383) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi766 : Nat.totient 766 = 382 := step (p := 2) (m := 383) (by decide +kernel) (by decide) phi383 (by decide +kernel)
private theorem cell383 : Covered 383 384 := singleton (i := 383) (by rw [show 2*383 = 766 by decide, phi766]; decide +kernel)
private theorem grid382x384 : Covered 382 384 := pair cell382 cell383
private theorem phi768 : Nat.totient 768 = 256 := step (p := 2) (m := 384) (by decide +kernel) (by decide) phi384 (by decide +kernel)
private theorem cell384 : Covered 384 385 := singleton (i := 384) (by rw [show 2*384 = 768 by decide, phi768]; decide +kernel)
private theorem phi385 : Nat.totient 385 = 240 := step (p := 5) (m := 77) (by decide +kernel) (by decide) phi77 (by decide +kernel)
private theorem phi770 : Nat.totient 770 = 240 := step (p := 2) (m := 385) (by decide +kernel) (by decide) phi385 (by decide +kernel)
private theorem cell385 : Covered 385 386 := singleton (i := 385) (by rw [show 2*385 = 770 by decide, phi770]; decide +kernel)
private theorem grid384x386 : Covered 384 386 := pair cell384 cell385
private theorem grid382x386 : Covered 382 386 := pair grid382x384 grid384x386
private theorem phi772 : Nat.totient 772 = 384 := step (p := 2) (m := 386) (by decide +kernel) (by decide) phi386 (by decide +kernel)
private theorem cell386 : Covered 386 387 := singleton (i := 386) (by rw [show 2*386 = 772 by decide, phi772]; decide +kernel)
private theorem phi387 : Nat.totient 387 = 252 := step (p := 3) (m := 129) (by decide +kernel) (by decide) phi129 (by decide +kernel)
private theorem phi774 : Nat.totient 774 = 252 := step (p := 2) (m := 387) (by decide +kernel) (by decide) phi387 (by decide +kernel)
private theorem cell387 : Covered 387 388 := singleton (i := 387) (by rw [show 2*387 = 774 by decide, phi774]; decide +kernel)
private theorem grid386x388 : Covered 386 388 := pair cell386 cell387
private theorem phi776 : Nat.totient 776 = 384 := step (p := 2) (m := 388) (by decide +kernel) (by decide) phi388 (by decide +kernel)
private theorem cell388 : Covered 388 389 := singleton (i := 388) (by rw [show 2*388 = 776 by decide, phi776]; decide +kernel)
private theorem phi389 : Nat.totient 389 = 388 := step (p := 389) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi778 : Nat.totient 778 = 388 := step (p := 2) (m := 389) (by decide +kernel) (by decide) phi389 (by decide +kernel)
private theorem cell389 : Covered 389 390 := singleton (i := 389) (by rw [show 2*389 = 778 by decide, phi778]; decide +kernel)
private theorem phi780 : Nat.totient 780 = 192 := step (p := 2) (m := 390) (by decide +kernel) (by decide) phi390 (by decide +kernel)
private theorem cell390 : Covered 390 391 := singleton (i := 390) (by rw [show 2*390 = 780 by decide, phi780]; decide +kernel)
private theorem grid389x391 : Covered 389 391 := pair cell389 cell390
private theorem grid388x391 : Covered 388 391 := pair cell388 grid389x391
private theorem grid386x391 : Covered 386 391 := pair grid386x388 grid388x391
private theorem grid382x391 : Covered 382 391 := pair grid382x386 grid386x391
private theorem phi391 : Nat.totient 391 = 352 := step (p := 17) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi782 : Nat.totient 782 = 352 := step (p := 2) (m := 391) (by decide +kernel) (by decide) phi391 (by decide +kernel)
private theorem cell391 : Covered 391 392 := singleton (i := 391) (by rw [show 2*391 = 782 by decide, phi782]; decide +kernel)
private theorem phi784 : Nat.totient 784 = 336 := step (p := 2) (m := 392) (by decide +kernel) (by decide) phi392 (by decide +kernel)
private theorem cell392 : Covered 392 393 := singleton (i := 392) (by rw [show 2*392 = 784 by decide, phi784]; decide +kernel)
private theorem grid391x393 : Covered 391 393 := pair cell391 cell392
private theorem phi393 : Nat.totient 393 = 260 := step (p := 3) (m := 131) (by decide +kernel) (by decide) phi131 (by decide +kernel)
private theorem phi786 : Nat.totient 786 = 260 := step (p := 2) (m := 393) (by decide +kernel) (by decide) phi393 (by decide +kernel)
private theorem cell393 : Covered 393 394 := singleton (i := 393) (by rw [show 2*393 = 786 by decide, phi786]; decide +kernel)
private theorem phi788 : Nat.totient 788 = 392 := step (p := 2) (m := 394) (by decide +kernel) (by decide) phi394 (by decide +kernel)
private theorem cell394 : Covered 394 395 := singleton (i := 394) (by rw [show 2*394 = 788 by decide, phi788]; decide +kernel)
private theorem grid393x395 : Covered 393 395 := pair cell393 cell394
private theorem grid391x395 : Covered 391 395 := pair grid391x393 grid393x395
private theorem phi395 : Nat.totient 395 = 312 := step (p := 5) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem phi790 : Nat.totient 790 = 312 := step (p := 2) (m := 395) (by decide +kernel) (by decide) phi395 (by decide +kernel)
private theorem cell395 : Covered 395 396 := singleton (i := 395) (by rw [show 2*395 = 790 by decide, phi790]; decide +kernel)
private theorem phi792 : Nat.totient 792 = 240 := step (p := 2) (m := 396) (by decide +kernel) (by decide) phi396 (by decide +kernel)
private theorem cell396 : Covered 396 397 := singleton (i := 396) (by rw [show 2*396 = 792 by decide, phi792]; decide +kernel)
private theorem grid395x397 : Covered 395 397 := pair cell395 cell396
private theorem phi397 : Nat.totient 397 = 396 := step (p := 397) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi794 : Nat.totient 794 = 396 := step (p := 2) (m := 397) (by decide +kernel) (by decide) phi397 (by decide +kernel)
private theorem cell397 : Covered 397 398 := singleton (i := 397) (by rw [show 2*397 = 794 by decide, phi794]; decide +kernel)
private theorem phi796 : Nat.totient 796 = 396 := step (p := 2) (m := 398) (by decide +kernel) (by decide) phi398 (by decide +kernel)
private theorem cell398 : Covered 398 399 := singleton (i := 398) (by rw [show 2*398 = 796 by decide, phi796]; decide +kernel)
private theorem phi399 : Nat.totient 399 = 216 := step (p := 3) (m := 133) (by decide +kernel) (by decide) phi133 (by decide +kernel)
private theorem phi798 : Nat.totient 798 = 216 := step (p := 2) (m := 399) (by decide +kernel) (by decide) phi399 (by decide +kernel)
private theorem cell399 : Covered 399 400 := singleton (i := 399) (by rw [show 2*399 = 798 by decide, phi798]; decide +kernel)
private theorem grid398x400 : Covered 398 400 := pair cell398 cell399
private theorem grid397x400 : Covered 397 400 := pair cell397 grid398x400
private theorem grid395x400 : Covered 395 400 := pair grid395x397 grid397x400
private theorem grid391x400 : Covered 391 400 := pair grid391x395 grid395x400
private theorem grid382x400 : Covered 382 400 := pair grid382x391 grid391x400
private theorem grid364x400 : Covered 364 400 := pair grid364x382 grid382x400
private theorem phi800 : Nat.totient 800 = 320 := step (p := 2) (m := 400) (by decide +kernel) (by decide) phi400 (by decide +kernel)
private theorem cell400 : Covered 400 401 := singleton (i := 400) (by rw [show 2*400 = 800 by decide, phi800]; decide +kernel)
private theorem phi401 : Nat.totient 401 = 400 := step (p := 401) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi802 : Nat.totient 802 = 400 := step (p := 2) (m := 401) (by decide +kernel) (by decide) phi401 (by decide +kernel)
private theorem cell401 : Covered 401 402 := singleton (i := 401) (by rw [show 2*401 = 802 by decide, phi802]; decide +kernel)
private theorem grid400x402 : Covered 400 402 := pair cell400 cell401
private theorem phi804 : Nat.totient 804 = 264 := step (p := 2) (m := 402) (by decide +kernel) (by decide) phi402 (by decide +kernel)
private theorem cell402 : Covered 402 403 := singleton (i := 402) (by rw [show 2*402 = 804 by decide, phi804]; decide +kernel)
private theorem phi403 : Nat.totient 403 = 360 := step (p := 13) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi806 : Nat.totient 806 = 360 := step (p := 2) (m := 403) (by decide +kernel) (by decide) phi403 (by decide +kernel)
private theorem cell403 : Covered 403 404 := singleton (i := 403) (by rw [show 2*403 = 806 by decide, phi806]; decide +kernel)
private theorem grid402x404 : Covered 402 404 := pair cell402 cell403
private theorem grid400x404 : Covered 400 404 := pair grid400x402 grid402x404
private theorem phi808 : Nat.totient 808 = 400 := step (p := 2) (m := 404) (by decide +kernel) (by decide) phi404 (by decide +kernel)
private theorem cell404 : Covered 404 405 := singleton (i := 404) (by rw [show 2*404 = 808 by decide, phi808]; decide +kernel)
private theorem phi405 : Nat.totient 405 = 216 := step (p := 3) (m := 135) (by decide +kernel) (by decide) phi135 (by decide +kernel)
private theorem phi810 : Nat.totient 810 = 216 := step (p := 2) (m := 405) (by decide +kernel) (by decide) phi405 (by decide +kernel)
private theorem cell405 : Covered 405 406 := singleton (i := 405) (by rw [show 2*405 = 810 by decide, phi810]; decide +kernel)
private theorem grid404x406 : Covered 404 406 := pair cell404 cell405
private theorem phi812 : Nat.totient 812 = 336 := step (p := 2) (m := 406) (by decide +kernel) (by decide) phi406 (by decide +kernel)
private theorem cell406 : Covered 406 407 := singleton (i := 406) (by rw [show 2*406 = 812 by decide, phi812]; decide +kernel)
private theorem phi407 : Nat.totient 407 = 360 := step (p := 11) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi814 : Nat.totient 814 = 360 := step (p := 2) (m := 407) (by decide +kernel) (by decide) phi407 (by decide +kernel)
private theorem cell407 : Covered 407 408 := singleton (i := 407) (by rw [show 2*407 = 814 by decide, phi814]; decide +kernel)
private theorem phi816 : Nat.totient 816 = 256 := step (p := 2) (m := 408) (by decide +kernel) (by decide) phi408 (by decide +kernel)
private theorem cell408 : Covered 408 409 := singleton (i := 408) (by rw [show 2*408 = 816 by decide, phi816]; decide +kernel)
private theorem grid407x409 : Covered 407 409 := pair cell407 cell408
private theorem grid406x409 : Covered 406 409 := pair cell406 grid407x409
private theorem grid404x409 : Covered 404 409 := pair grid404x406 grid406x409
private theorem grid400x409 : Covered 400 409 := pair grid400x404 grid404x409
private theorem phi409 : Nat.totient 409 = 408 := step (p := 409) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi818 : Nat.totient 818 = 408 := step (p := 2) (m := 409) (by decide +kernel) (by decide) phi409 (by decide +kernel)
private theorem cell409 : Covered 409 410 := singleton (i := 409) (by rw [show 2*409 = 818 by decide, phi818]; decide +kernel)
private theorem phi820 : Nat.totient 820 = 320 := step (p := 2) (m := 410) (by decide +kernel) (by decide) phi410 (by decide +kernel)
private theorem cell410 : Covered 410 411 := singleton (i := 410) (by rw [show 2*410 = 820 by decide, phi820]; decide +kernel)
private theorem grid409x411 : Covered 409 411 := pair cell409 cell410
private theorem phi411 : Nat.totient 411 = 272 := step (p := 3) (m := 137) (by decide +kernel) (by decide) phi137 (by decide +kernel)
private theorem phi822 : Nat.totient 822 = 272 := step (p := 2) (m := 411) (by decide +kernel) (by decide) phi411 (by decide +kernel)
private theorem cell411 : Covered 411 412 := singleton (i := 411) (by rw [show 2*411 = 822 by decide, phi822]; decide +kernel)
private theorem phi824 : Nat.totient 824 = 408 := step (p := 2) (m := 412) (by decide +kernel) (by decide) phi412 (by decide +kernel)
private theorem cell412 : Covered 412 413 := singleton (i := 412) (by rw [show 2*412 = 824 by decide, phi824]; decide +kernel)
private theorem grid411x413 : Covered 411 413 := pair cell411 cell412
private theorem grid409x413 : Covered 409 413 := pair grid409x411 grid411x413
private theorem phi413 : Nat.totient 413 = 348 := step (p := 7) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi826 : Nat.totient 826 = 348 := step (p := 2) (m := 413) (by decide +kernel) (by decide) phi413 (by decide +kernel)
private theorem cell413 : Covered 413 414 := singleton (i := 413) (by rw [show 2*413 = 826 by decide, phi826]; decide +kernel)
private theorem phi828 : Nat.totient 828 = 264 := step (p := 2) (m := 414) (by decide +kernel) (by decide) phi414 (by decide +kernel)
private theorem cell414 : Covered 414 415 := singleton (i := 414) (by rw [show 2*414 = 828 by decide, phi828]; decide +kernel)
private theorem grid413x415 : Covered 413 415 := pair cell413 cell414
private theorem phi415 : Nat.totient 415 = 328 := step (p := 5) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem phi830 : Nat.totient 830 = 328 := step (p := 2) (m := 415) (by decide +kernel) (by decide) phi415 (by decide +kernel)
private theorem cell415 : Covered 415 416 := singleton (i := 415) (by rw [show 2*415 = 830 by decide, phi830]; decide +kernel)
private theorem phi832 : Nat.totient 832 = 384 := step (p := 2) (m := 416) (by decide +kernel) (by decide) phi416 (by decide +kernel)
private theorem cell416 : Covered 416 417 := singleton (i := 416) (by rw [show 2*416 = 832 by decide, phi832]; decide +kernel)
private theorem phi417 : Nat.totient 417 = 276 := step (p := 3) (m := 139) (by decide +kernel) (by decide) phi139 (by decide +kernel)
private theorem phi834 : Nat.totient 834 = 276 := step (p := 2) (m := 417) (by decide +kernel) (by decide) phi417 (by decide +kernel)
private theorem cell417 : Covered 417 418 := singleton (i := 417) (by rw [show 2*417 = 834 by decide, phi834]; decide +kernel)
private theorem grid416x418 : Covered 416 418 := pair cell416 cell417
private theorem grid415x418 : Covered 415 418 := pair cell415 grid416x418
private theorem grid413x418 : Covered 413 418 := pair grid413x415 grid415x418
private theorem grid409x418 : Covered 409 418 := pair grid409x413 grid413x418
private theorem grid400x418 : Covered 400 418 := pair grid400x409 grid409x418
private theorem phi836 : Nat.totient 836 = 360 := step (p := 2) (m := 418) (by decide +kernel) (by decide) phi418 (by decide +kernel)
private theorem cell418 : Covered 418 419 := singleton (i := 418) (by rw [show 2*418 = 836 by decide, phi836]; decide +kernel)
private theorem phi419 : Nat.totient 419 = 418 := step (p := 419) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi838 : Nat.totient 838 = 418 := step (p := 2) (m := 419) (by decide +kernel) (by decide) phi419 (by decide +kernel)
private theorem cell419 : Covered 419 420 := singleton (i := 419) (by rw [show 2*419 = 838 by decide, phi838]; decide +kernel)
private theorem grid418x420 : Covered 418 420 := pair cell418 cell419
private theorem phi840 : Nat.totient 840 = 192 := step (p := 2) (m := 420) (by decide +kernel) (by decide) phi420 (by decide +kernel)
private theorem cell420 : Covered 420 421 := singleton (i := 420) (by rw [show 2*420 = 840 by decide, phi840]; decide +kernel)
private theorem phi421 : Nat.totient 421 = 420 := step (p := 421) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi842 : Nat.totient 842 = 420 := step (p := 2) (m := 421) (by decide +kernel) (by decide) phi421 (by decide +kernel)
private theorem cell421 : Covered 421 422 := singleton (i := 421) (by rw [show 2*421 = 842 by decide, phi842]; decide +kernel)
private theorem grid420x422 : Covered 420 422 := pair cell420 cell421
private theorem grid418x422 : Covered 418 422 := pair grid418x420 grid420x422
private theorem phi844 : Nat.totient 844 = 420 := step (p := 2) (m := 422) (by decide +kernel) (by decide) phi422 (by decide +kernel)
private theorem cell422 : Covered 422 423 := singleton (i := 422) (by rw [show 2*422 = 844 by decide, phi844]; decide +kernel)
private theorem phi423 : Nat.totient 423 = 276 := step (p := 3) (m := 141) (by decide +kernel) (by decide) phi141 (by decide +kernel)
private theorem phi846 : Nat.totient 846 = 276 := step (p := 2) (m := 423) (by decide +kernel) (by decide) phi423 (by decide +kernel)
private theorem cell423 : Covered 423 424 := singleton (i := 423) (by rw [show 2*423 = 846 by decide, phi846]; decide +kernel)
private theorem grid422x424 : Covered 422 424 := pair cell422 cell423
private theorem phi848 : Nat.totient 848 = 416 := step (p := 2) (m := 424) (by decide +kernel) (by decide) phi424 (by decide +kernel)
private theorem cell424 : Covered 424 425 := singleton (i := 424) (by rw [show 2*424 = 848 by decide, phi848]; decide +kernel)
private theorem phi425 : Nat.totient 425 = 320 := step (p := 5) (m := 85) (by decide +kernel) (by decide) phi85 (by decide +kernel)
private theorem phi850 : Nat.totient 850 = 320 := step (p := 2) (m := 425) (by decide +kernel) (by decide) phi425 (by decide +kernel)
private theorem cell425 : Covered 425 426 := singleton (i := 425) (by rw [show 2*425 = 850 by decide, phi850]; decide +kernel)
private theorem phi852 : Nat.totient 852 = 280 := step (p := 2) (m := 426) (by decide +kernel) (by decide) phi426 (by decide +kernel)
private theorem cell426 : Covered 426 427 := singleton (i := 426) (by rw [show 2*426 = 852 by decide, phi852]; decide +kernel)
private theorem grid425x427 : Covered 425 427 := pair cell425 cell426
private theorem grid424x427 : Covered 424 427 := pair cell424 grid425x427
private theorem grid422x427 : Covered 422 427 := pair grid422x424 grid424x427
private theorem grid418x427 : Covered 418 427 := pair grid418x422 grid422x427
private theorem phi427 : Nat.totient 427 = 360 := step (p := 7) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi854 : Nat.totient 854 = 360 := step (p := 2) (m := 427) (by decide +kernel) (by decide) phi427 (by decide +kernel)
private theorem cell427 : Covered 427 428 := singleton (i := 427) (by rw [show 2*427 = 854 by decide, phi854]; decide +kernel)
private theorem phi856 : Nat.totient 856 = 424 := step (p := 2) (m := 428) (by decide +kernel) (by decide) phi428 (by decide +kernel)
private theorem cell428 : Covered 428 429 := singleton (i := 428) (by rw [show 2*428 = 856 by decide, phi856]; decide +kernel)
private theorem grid427x429 : Covered 427 429 := pair cell427 cell428
private theorem phi429 : Nat.totient 429 = 240 := step (p := 3) (m := 143) (by decide +kernel) (by decide) phi143 (by decide +kernel)
private theorem phi858 : Nat.totient 858 = 240 := step (p := 2) (m := 429) (by decide +kernel) (by decide) phi429 (by decide +kernel)
private theorem cell429 : Covered 429 430 := singleton (i := 429) (by rw [show 2*429 = 858 by decide, phi858]; decide +kernel)
private theorem phi860 : Nat.totient 860 = 336 := step (p := 2) (m := 430) (by decide +kernel) (by decide) phi430 (by decide +kernel)
private theorem cell430 : Covered 430 431 := singleton (i := 430) (by rw [show 2*430 = 860 by decide, phi860]; decide +kernel)
private theorem phi431 : Nat.totient 431 = 430 := step (p := 431) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi862 : Nat.totient 862 = 430 := step (p := 2) (m := 431) (by decide +kernel) (by decide) phi431 (by decide +kernel)
private theorem cell431 : Covered 431 432 := singleton (i := 431) (by rw [show 2*431 = 862 by decide, phi862]; decide +kernel)
private theorem grid430x432 : Covered 430 432 := pair cell430 cell431
private theorem grid429x432 : Covered 429 432 := pair cell429 grid430x432
private theorem grid427x432 : Covered 427 432 := pair grid427x429 grid429x432
private theorem phi864 : Nat.totient 864 = 288 := step (p := 2) (m := 432) (by decide +kernel) (by decide) phi432 (by decide +kernel)
private theorem cell432 : Covered 432 433 := singleton (i := 432) (by rw [show 2*432 = 864 by decide, phi864]; decide +kernel)
private theorem phi433 : Nat.totient 433 = 432 := step (p := 433) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi866 : Nat.totient 866 = 432 := step (p := 2) (m := 433) (by decide +kernel) (by decide) phi433 (by decide +kernel)
private theorem cell433 : Covered 433 434 := singleton (i := 433) (by rw [show 2*433 = 866 by decide, phi866]; decide +kernel)
private theorem grid432x434 : Covered 432 434 := pair cell432 cell433
private theorem phi868 : Nat.totient 868 = 360 := step (p := 2) (m := 434) (by decide +kernel) (by decide) phi434 (by decide +kernel)
private theorem cell434 : Covered 434 435 := singleton (i := 434) (by rw [show 2*434 = 868 by decide, phi868]; decide +kernel)
private theorem phi435 : Nat.totient 435 = 224 := step (p := 3) (m := 145) (by decide +kernel) (by decide) phi145 (by decide +kernel)
private theorem phi870 : Nat.totient 870 = 224 := step (p := 2) (m := 435) (by decide +kernel) (by decide) phi435 (by decide +kernel)
private theorem cell435 : Covered 435 436 := singleton (i := 435) (by rw [show 2*435 = 870 by decide, phi870]; decide +kernel)
private theorem phi872 : Nat.totient 872 = 432 := step (p := 2) (m := 436) (by decide +kernel) (by decide) phi436 (by decide +kernel)
private theorem cell436 : Covered 436 437 := singleton (i := 436) (by rw [show 2*436 = 872 by decide, phi872]; decide +kernel)
private theorem grid435x437 : Covered 435 437 := pair cell435 cell436
private theorem grid434x437 : Covered 434 437 := pair cell434 grid435x437
private theorem grid432x437 : Covered 432 437 := pair grid432x434 grid434x437
private theorem grid427x437 : Covered 427 437 := pair grid427x432 grid432x437
private theorem grid418x437 : Covered 418 437 := pair grid418x427 grid427x437
private theorem grid400x437 : Covered 400 437 := pair grid400x418 grid418x437
private theorem grid364x437 : Covered 364 437 := pair grid364x400 grid400x437
private theorem grid292x437 : Covered 292 437 := pair grid292x364 grid364x437
private theorem phi437 : Nat.totient 437 = 396 := step (p := 19) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi874 : Nat.totient 874 = 396 := step (p := 2) (m := 437) (by decide +kernel) (by decide) phi437 (by decide +kernel)
private theorem cell437 : Covered 437 438 := singleton (i := 437) (by rw [show 2*437 = 874 by decide, phi874]; decide +kernel)
private theorem phi876 : Nat.totient 876 = 288 := step (p := 2) (m := 438) (by decide +kernel) (by decide) phi438 (by decide +kernel)
private theorem cell438 : Covered 438 439 := singleton (i := 438) (by rw [show 2*438 = 876 by decide, phi876]; decide +kernel)
private theorem grid437x439 : Covered 437 439 := pair cell437 cell438
private theorem phi439 : Nat.totient 439 = 438 := step (p := 439) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi878 : Nat.totient 878 = 438 := step (p := 2) (m := 439) (by decide +kernel) (by decide) phi439 (by decide +kernel)
private theorem cell439 : Covered 439 440 := singleton (i := 439) (by rw [show 2*439 = 878 by decide, phi878]; decide +kernel)
private theorem phi880 : Nat.totient 880 = 320 := step (p := 2) (m := 440) (by decide +kernel) (by decide) phi440 (by decide +kernel)
private theorem cell440 : Covered 440 441 := singleton (i := 440) (by rw [show 2*440 = 880 by decide, phi880]; decide +kernel)
private theorem grid439x441 : Covered 439 441 := pair cell439 cell440
private theorem grid437x441 : Covered 437 441 := pair grid437x439 grid439x441
private theorem phi441 : Nat.totient 441 = 252 := step (p := 3) (m := 147) (by decide +kernel) (by decide) phi147 (by decide +kernel)
private theorem phi882 : Nat.totient 882 = 252 := step (p := 2) (m := 441) (by decide +kernel) (by decide) phi441 (by decide +kernel)
private theorem cell441 : Covered 441 442 := singleton (i := 441) (by rw [show 2*441 = 882 by decide, phi882]; decide +kernel)
private theorem phi884 : Nat.totient 884 = 384 := step (p := 2) (m := 442) (by decide +kernel) (by decide) phi442 (by decide +kernel)
private theorem cell442 : Covered 442 443 := singleton (i := 442) (by rw [show 2*442 = 884 by decide, phi884]; decide +kernel)
private theorem grid441x443 : Covered 441 443 := pair cell441 cell442
private theorem phi443 : Nat.totient 443 = 442 := step (p := 443) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi886 : Nat.totient 886 = 442 := step (p := 2) (m := 443) (by decide +kernel) (by decide) phi443 (by decide +kernel)
private theorem cell443 : Covered 443 444 := singleton (i := 443) (by rw [show 2*443 = 886 by decide, phi886]; decide +kernel)
private theorem phi888 : Nat.totient 888 = 288 := step (p := 2) (m := 444) (by decide +kernel) (by decide) phi444 (by decide +kernel)
private theorem cell444 : Covered 444 445 := singleton (i := 444) (by rw [show 2*444 = 888 by decide, phi888]; decide +kernel)
private theorem phi445 : Nat.totient 445 = 352 := step (p := 5) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem phi890 : Nat.totient 890 = 352 := step (p := 2) (m := 445) (by decide +kernel) (by decide) phi445 (by decide +kernel)
private theorem cell445 : Covered 445 446 := singleton (i := 445) (by rw [show 2*445 = 890 by decide, phi890]; decide +kernel)
private theorem grid444x446 : Covered 444 446 := pair cell444 cell445
private theorem grid443x446 : Covered 443 446 := pair cell443 grid444x446
private theorem grid441x446 : Covered 441 446 := pair grid441x443 grid443x446
private theorem grid437x446 : Covered 437 446 := pair grid437x441 grid441x446
private theorem phi892 : Nat.totient 892 = 444 := step (p := 2) (m := 446) (by decide +kernel) (by decide) phi446 (by decide +kernel)
private theorem cell446 : Covered 446 447 := singleton (i := 446) (by rw [show 2*446 = 892 by decide, phi892]; decide +kernel)
private theorem phi447 : Nat.totient 447 = 296 := step (p := 3) (m := 149) (by decide +kernel) (by decide) phi149 (by decide +kernel)
private theorem phi894 : Nat.totient 894 = 296 := step (p := 2) (m := 447) (by decide +kernel) (by decide) phi447 (by decide +kernel)
private theorem cell447 : Covered 447 448 := singleton (i := 447) (by rw [show 2*447 = 894 by decide, phi894]; decide +kernel)
private theorem grid446x448 : Covered 446 448 := pair cell446 cell447
private theorem phi896 : Nat.totient 896 = 384 := step (p := 2) (m := 448) (by decide +kernel) (by decide) phi448 (by decide +kernel)
private theorem cell448 : Covered 448 449 := singleton (i := 448) (by rw [show 2*448 = 896 by decide, phi896]; decide +kernel)
private theorem phi449 : Nat.totient 449 = 448 := step (p := 449) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi898 : Nat.totient 898 = 448 := step (p := 2) (m := 449) (by decide +kernel) (by decide) phi449 (by decide +kernel)
private theorem cell449 : Covered 449 450 := singleton (i := 449) (by rw [show 2*449 = 898 by decide, phi898]; decide +kernel)
private theorem grid448x450 : Covered 448 450 := pair cell448 cell449
private theorem grid446x450 : Covered 446 450 := pair grid446x448 grid448x450
private theorem phi900 : Nat.totient 900 = 240 := step (p := 2) (m := 450) (by decide +kernel) (by decide) phi450 (by decide +kernel)
private theorem cell450 : Covered 450 451 := singleton (i := 450) (by rw [show 2*450 = 900 by decide, phi900]; decide +kernel)
private theorem phi451 : Nat.totient 451 = 400 := step (p := 11) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi902 : Nat.totient 902 = 400 := step (p := 2) (m := 451) (by decide +kernel) (by decide) phi451 (by decide +kernel)
private theorem cell451 : Covered 451 452 := singleton (i := 451) (by rw [show 2*451 = 902 by decide, phi902]; decide +kernel)
private theorem grid450x452 : Covered 450 452 := pair cell450 cell451
private theorem phi904 : Nat.totient 904 = 448 := step (p := 2) (m := 452) (by decide +kernel) (by decide) phi452 (by decide +kernel)
private theorem cell452 : Covered 452 453 := singleton (i := 452) (by rw [show 2*452 = 904 by decide, phi904]; decide +kernel)
private theorem phi453 : Nat.totient 453 = 300 := step (p := 3) (m := 151) (by decide +kernel) (by decide) phi151 (by decide +kernel)
private theorem phi906 : Nat.totient 906 = 300 := step (p := 2) (m := 453) (by decide +kernel) (by decide) phi453 (by decide +kernel)
private theorem cell453 : Covered 453 454 := singleton (i := 453) (by rw [show 2*453 = 906 by decide, phi906]; decide +kernel)
private theorem phi908 : Nat.totient 908 = 452 := step (p := 2) (m := 454) (by decide +kernel) (by decide) phi454 (by decide +kernel)
private theorem cell454 : Covered 454 455 := singleton (i := 454) (by rw [show 2*454 = 908 by decide, phi908]; decide +kernel)
private theorem grid453x455 : Covered 453 455 := pair cell453 cell454
private theorem grid452x455 : Covered 452 455 := pair cell452 grid453x455
private theorem grid450x455 : Covered 450 455 := pair grid450x452 grid452x455
private theorem grid446x455 : Covered 446 455 := pair grid446x450 grid450x455
private theorem grid437x455 : Covered 437 455 := pair grid437x446 grid446x455
private theorem phi455 : Nat.totient 455 = 288 := step (p := 5) (m := 91) (by decide +kernel) (by decide) phi91 (by decide +kernel)
private theorem phi910 : Nat.totient 910 = 288 := step (p := 2) (m := 455) (by decide +kernel) (by decide) phi455 (by decide +kernel)
private theorem cell455 : Covered 455 456 := singleton (i := 455) (by rw [show 2*455 = 910 by decide, phi910]; decide +kernel)
private theorem phi912 : Nat.totient 912 = 288 := step (p := 2) (m := 456) (by decide +kernel) (by decide) phi456 (by decide +kernel)
private theorem cell456 : Covered 456 457 := singleton (i := 456) (by rw [show 2*456 = 912 by decide, phi912]; decide +kernel)
private theorem grid455x457 : Covered 455 457 := pair cell455 cell456
private theorem phi457 : Nat.totient 457 = 456 := step (p := 457) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi914 : Nat.totient 914 = 456 := step (p := 2) (m := 457) (by decide +kernel) (by decide) phi457 (by decide +kernel)
private theorem cell457 : Covered 457 458 := singleton (i := 457) (by rw [show 2*457 = 914 by decide, phi914]; decide +kernel)
private theorem phi916 : Nat.totient 916 = 456 := step (p := 2) (m := 458) (by decide +kernel) (by decide) phi458 (by decide +kernel)
private theorem cell458 : Covered 458 459 := singleton (i := 458) (by rw [show 2*458 = 916 by decide, phi916]; decide +kernel)
private theorem grid457x459 : Covered 457 459 := pair cell457 cell458
private theorem grid455x459 : Covered 455 459 := pair grid455x457 grid457x459
private theorem phi459 : Nat.totient 459 = 288 := step (p := 3) (m := 153) (by decide +kernel) (by decide) phi153 (by decide +kernel)
private theorem phi918 : Nat.totient 918 = 288 := step (p := 2) (m := 459) (by decide +kernel) (by decide) phi459 (by decide +kernel)
private theorem cell459 : Covered 459 460 := singleton (i := 459) (by rw [show 2*459 = 918 by decide, phi918]; decide +kernel)
private theorem phi920 : Nat.totient 920 = 352 := step (p := 2) (m := 460) (by decide +kernel) (by decide) phi460 (by decide +kernel)
private theorem cell460 : Covered 460 461 := singleton (i := 460) (by rw [show 2*460 = 920 by decide, phi920]; decide +kernel)
private theorem grid459x461 : Covered 459 461 := pair cell459 cell460
private theorem phi461 : Nat.totient 461 = 460 := step (p := 461) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi922 : Nat.totient 922 = 460 := step (p := 2) (m := 461) (by decide +kernel) (by decide) phi461 (by decide +kernel)
private theorem cell461 : Covered 461 462 := singleton (i := 461) (by rw [show 2*461 = 922 by decide, phi922]; decide +kernel)
private theorem phi924 : Nat.totient 924 = 240 := step (p := 2) (m := 462) (by decide +kernel) (by decide) phi462 (by decide +kernel)
private theorem cell462 : Covered 462 463 := singleton (i := 462) (by rw [show 2*462 = 924 by decide, phi924]; decide +kernel)
private theorem phi463 : Nat.totient 463 = 462 := step (p := 463) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi926 : Nat.totient 926 = 462 := step (p := 2) (m := 463) (by decide +kernel) (by decide) phi463 (by decide +kernel)
private theorem cell463 : Covered 463 464 := singleton (i := 463) (by rw [show 2*463 = 926 by decide, phi926]; decide +kernel)
private theorem grid462x464 : Covered 462 464 := pair cell462 cell463
private theorem grid461x464 : Covered 461 464 := pair cell461 grid462x464
private theorem grid459x464 : Covered 459 464 := pair grid459x461 grid461x464
private theorem grid455x464 : Covered 455 464 := pair grid455x459 grid459x464
private theorem phi928 : Nat.totient 928 = 448 := step (p := 2) (m := 464) (by decide +kernel) (by decide) phi464 (by decide +kernel)
private theorem cell464 : Covered 464 465 := singleton (i := 464) (by rw [show 2*464 = 928 by decide, phi928]; decide +kernel)
private theorem phi465 : Nat.totient 465 = 240 := step (p := 3) (m := 155) (by decide +kernel) (by decide) phi155 (by decide +kernel)
private theorem phi930 : Nat.totient 930 = 240 := step (p := 2) (m := 465) (by decide +kernel) (by decide) phi465 (by decide +kernel)
private theorem cell465 : Covered 465 466 := singleton (i := 465) (by rw [show 2*465 = 930 by decide, phi930]; decide +kernel)
private theorem grid464x466 : Covered 464 466 := pair cell464 cell465
private theorem phi932 : Nat.totient 932 = 464 := step (p := 2) (m := 466) (by decide +kernel) (by decide) phi466 (by decide +kernel)
private theorem cell466 : Covered 466 467 := singleton (i := 466) (by rw [show 2*466 = 932 by decide, phi932]; decide +kernel)
private theorem phi467 : Nat.totient 467 = 466 := step (p := 467) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi934 : Nat.totient 934 = 466 := step (p := 2) (m := 467) (by decide +kernel) (by decide) phi467 (by decide +kernel)
private theorem cell467 : Covered 467 468 := singleton (i := 467) (by rw [show 2*467 = 934 by decide, phi934]; decide +kernel)
private theorem grid466x468 : Covered 466 468 := pair cell466 cell467
private theorem grid464x468 : Covered 464 468 := pair grid464x466 grid466x468
private theorem phi936 : Nat.totient 936 = 288 := step (p := 2) (m := 468) (by decide +kernel) (by decide) phi468 (by decide +kernel)
private theorem cell468 : Covered 468 469 := singleton (i := 468) (by rw [show 2*468 = 936 by decide, phi936]; decide +kernel)
private theorem phi469 : Nat.totient 469 = 396 := step (p := 7) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi938 : Nat.totient 938 = 396 := step (p := 2) (m := 469) (by decide +kernel) (by decide) phi469 (by decide +kernel)
private theorem cell469 : Covered 469 470 := singleton (i := 469) (by rw [show 2*469 = 938 by decide, phi938]; decide +kernel)
private theorem grid468x470 : Covered 468 470 := pair cell468 cell469
private theorem phi940 : Nat.totient 940 = 368 := step (p := 2) (m := 470) (by decide +kernel) (by decide) phi470 (by decide +kernel)
private theorem cell470 : Covered 470 471 := singleton (i := 470) (by rw [show 2*470 = 940 by decide, phi940]; decide +kernel)
private theorem phi471 : Nat.totient 471 = 312 := step (p := 3) (m := 157) (by decide +kernel) (by decide) phi157 (by decide +kernel)
private theorem phi942 : Nat.totient 942 = 312 := step (p := 2) (m := 471) (by decide +kernel) (by decide) phi471 (by decide +kernel)
private theorem cell471 : Covered 471 472 := singleton (i := 471) (by rw [show 2*471 = 942 by decide, phi942]; decide +kernel)
private theorem phi944 : Nat.totient 944 = 464 := step (p := 2) (m := 472) (by decide +kernel) (by decide) phi472 (by decide +kernel)
private theorem cell472 : Covered 472 473 := singleton (i := 472) (by rw [show 2*472 = 944 by decide, phi944]; decide +kernel)
private theorem grid471x473 : Covered 471 473 := pair cell471 cell472
private theorem grid470x473 : Covered 470 473 := pair cell470 grid471x473
private theorem grid468x473 : Covered 468 473 := pair grid468x470 grid470x473
private theorem grid464x473 : Covered 464 473 := pair grid464x468 grid468x473
private theorem grid455x473 : Covered 455 473 := pair grid455x464 grid464x473
private theorem grid437x473 : Covered 437 473 := pair grid437x455 grid455x473
private theorem phi473 : Nat.totient 473 = 420 := step (p := 11) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi946 : Nat.totient 946 = 420 := step (p := 2) (m := 473) (by decide +kernel) (by decide) phi473 (by decide +kernel)
private theorem cell473 : Covered 473 474 := singleton (i := 473) (by rw [show 2*473 = 946 by decide, phi946]; decide +kernel)
private theorem phi948 : Nat.totient 948 = 312 := step (p := 2) (m := 474) (by decide +kernel) (by decide) phi474 (by decide +kernel)
private theorem cell474 : Covered 474 475 := singleton (i := 474) (by rw [show 2*474 = 948 by decide, phi948]; decide +kernel)
private theorem grid473x475 : Covered 473 475 := pair cell473 cell474
private theorem phi475 : Nat.totient 475 = 360 := step (p := 5) (m := 95) (by decide +kernel) (by decide) phi95 (by decide +kernel)
private theorem phi950 : Nat.totient 950 = 360 := step (p := 2) (m := 475) (by decide +kernel) (by decide) phi475 (by decide +kernel)
private theorem cell475 : Covered 475 476 := singleton (i := 475) (by rw [show 2*475 = 950 by decide, phi950]; decide +kernel)
private theorem phi952 : Nat.totient 952 = 384 := step (p := 2) (m := 476) (by decide +kernel) (by decide) phi476 (by decide +kernel)
private theorem cell476 : Covered 476 477 := singleton (i := 476) (by rw [show 2*476 = 952 by decide, phi952]; decide +kernel)
private theorem grid475x477 : Covered 475 477 := pair cell475 cell476
private theorem grid473x477 : Covered 473 477 := pair grid473x475 grid475x477
private theorem phi477 : Nat.totient 477 = 312 := step (p := 3) (m := 159) (by decide +kernel) (by decide) phi159 (by decide +kernel)
private theorem phi954 : Nat.totient 954 = 312 := step (p := 2) (m := 477) (by decide +kernel) (by decide) phi477 (by decide +kernel)
private theorem cell477 : Covered 477 478 := singleton (i := 477) (by rw [show 2*477 = 954 by decide, phi954]; decide +kernel)
private theorem phi956 : Nat.totient 956 = 476 := step (p := 2) (m := 478) (by decide +kernel) (by decide) phi478 (by decide +kernel)
private theorem cell478 : Covered 478 479 := singleton (i := 478) (by rw [show 2*478 = 956 by decide, phi956]; decide +kernel)
private theorem grid477x479 : Covered 477 479 := pair cell477 cell478
private theorem phi479 : Nat.totient 479 = 478 := step (p := 479) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi958 : Nat.totient 958 = 478 := step (p := 2) (m := 479) (by decide +kernel) (by decide) phi479 (by decide +kernel)
private theorem cell479 : Covered 479 480 := singleton (i := 479) (by rw [show 2*479 = 958 by decide, phi958]; decide +kernel)
private theorem phi960 : Nat.totient 960 = 256 := step (p := 2) (m := 480) (by decide +kernel) (by decide) phi480 (by decide +kernel)
private theorem cell480 : Covered 480 481 := singleton (i := 480) (by rw [show 2*480 = 960 by decide, phi960]; decide +kernel)
private theorem phi481 : Nat.totient 481 = 432 := step (p := 13) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi962 : Nat.totient 962 = 432 := step (p := 2) (m := 481) (by decide +kernel) (by decide) phi481 (by decide +kernel)
private theorem cell481 : Covered 481 482 := singleton (i := 481) (by rw [show 2*481 = 962 by decide, phi962]; decide +kernel)
private theorem grid480x482 : Covered 480 482 := pair cell480 cell481
private theorem grid479x482 : Covered 479 482 := pair cell479 grid480x482
private theorem grid477x482 : Covered 477 482 := pair grid477x479 grid479x482
private theorem grid473x482 : Covered 473 482 := pair grid473x477 grid477x482
private theorem phi964 : Nat.totient 964 = 480 := step (p := 2) (m := 482) (by decide +kernel) (by decide) phi482 (by decide +kernel)
private theorem cell482 : Covered 482 483 := singleton (i := 482) (by rw [show 2*482 = 964 by decide, phi964]; decide +kernel)
private theorem phi483 : Nat.totient 483 = 264 := step (p := 3) (m := 161) (by decide +kernel) (by decide) phi161 (by decide +kernel)
private theorem phi966 : Nat.totient 966 = 264 := step (p := 2) (m := 483) (by decide +kernel) (by decide) phi483 (by decide +kernel)
private theorem cell483 : Covered 483 484 := singleton (i := 483) (by rw [show 2*483 = 966 by decide, phi966]; decide +kernel)
private theorem grid482x484 : Covered 482 484 := pair cell482 cell483
private theorem phi968 : Nat.totient 968 = 440 := step (p := 2) (m := 484) (by decide +kernel) (by decide) phi484 (by decide +kernel)
private theorem cell484 : Covered 484 485 := singleton (i := 484) (by rw [show 2*484 = 968 by decide, phi968]; decide +kernel)
private theorem phi485 : Nat.totient 485 = 384 := step (p := 5) (m := 97) (by decide +kernel) (by decide) phi97 (by decide +kernel)
private theorem phi970 : Nat.totient 970 = 384 := step (p := 2) (m := 485) (by decide +kernel) (by decide) phi485 (by decide +kernel)
private theorem cell485 : Covered 485 486 := singleton (i := 485) (by rw [show 2*485 = 970 by decide, phi970]; decide +kernel)
private theorem grid484x486 : Covered 484 486 := pair cell484 cell485
private theorem grid482x486 : Covered 482 486 := pair grid482x484 grid484x486
private theorem phi972 : Nat.totient 972 = 324 := step (p := 2) (m := 486) (by decide +kernel) (by decide) phi486 (by decide +kernel)
private theorem cell486 : Covered 486 487 := singleton (i := 486) (by rw [show 2*486 = 972 by decide, phi972]; decide +kernel)
private theorem phi487 : Nat.totient 487 = 486 := step (p := 487) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi974 : Nat.totient 974 = 486 := step (p := 2) (m := 487) (by decide +kernel) (by decide) phi487 (by decide +kernel)
private theorem cell487 : Covered 487 488 := singleton (i := 487) (by rw [show 2*487 = 974 by decide, phi974]; decide +kernel)
private theorem grid486x488 : Covered 486 488 := pair cell486 cell487
private theorem phi976 : Nat.totient 976 = 480 := step (p := 2) (m := 488) (by decide +kernel) (by decide) phi488 (by decide +kernel)
private theorem cell488 : Covered 488 489 := singleton (i := 488) (by rw [show 2*488 = 976 by decide, phi976]; decide +kernel)
private theorem phi489 : Nat.totient 489 = 324 := step (p := 3) (m := 163) (by decide +kernel) (by decide) phi163 (by decide +kernel)
private theorem phi978 : Nat.totient 978 = 324 := step (p := 2) (m := 489) (by decide +kernel) (by decide) phi489 (by decide +kernel)
private theorem cell489 : Covered 489 490 := singleton (i := 489) (by rw [show 2*489 = 978 by decide, phi978]; decide +kernel)
private theorem phi980 : Nat.totient 980 = 336 := step (p := 2) (m := 490) (by decide +kernel) (by decide) phi490 (by decide +kernel)
private theorem cell490 : Covered 490 491 := singleton (i := 490) (by rw [show 2*490 = 980 by decide, phi980]; decide +kernel)
private theorem grid489x491 : Covered 489 491 := pair cell489 cell490
private theorem grid488x491 : Covered 488 491 := pair cell488 grid489x491
private theorem grid486x491 : Covered 486 491 := pair grid486x488 grid488x491
private theorem grid482x491 : Covered 482 491 := pair grid482x486 grid486x491
private theorem grid473x491 : Covered 473 491 := pair grid473x482 grid482x491
private theorem phi491 : Nat.totient 491 = 490 := step (p := 491) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi982 : Nat.totient 982 = 490 := step (p := 2) (m := 491) (by decide +kernel) (by decide) phi491 (by decide +kernel)
private theorem cell491 : Covered 491 492 := singleton (i := 491) (by rw [show 2*491 = 982 by decide, phi982]; decide +kernel)
private theorem phi984 : Nat.totient 984 = 320 := step (p := 2) (m := 492) (by decide +kernel) (by decide) phi492 (by decide +kernel)
private theorem cell492 : Covered 492 493 := singleton (i := 492) (by rw [show 2*492 = 984 by decide, phi984]; decide +kernel)
private theorem grid491x493 : Covered 491 493 := pair cell491 cell492
private theorem phi493 : Nat.totient 493 = 448 := step (p := 17) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi986 : Nat.totient 986 = 448 := step (p := 2) (m := 493) (by decide +kernel) (by decide) phi493 (by decide +kernel)
private theorem cell493 : Covered 493 494 := singleton (i := 493) (by rw [show 2*493 = 986 by decide, phi986]; decide +kernel)
private theorem phi988 : Nat.totient 988 = 432 := step (p := 2) (m := 494) (by decide +kernel) (by decide) phi494 (by decide +kernel)
private theorem cell494 : Covered 494 495 := singleton (i := 494) (by rw [show 2*494 = 988 by decide, phi988]; decide +kernel)
private theorem grid493x495 : Covered 493 495 := pair cell493 cell494
private theorem grid491x495 : Covered 491 495 := pair grid491x493 grid493x495
private theorem phi495 : Nat.totient 495 = 240 := step (p := 3) (m := 165) (by decide +kernel) (by decide) phi165 (by decide +kernel)
private theorem phi990 : Nat.totient 990 = 240 := step (p := 2) (m := 495) (by decide +kernel) (by decide) phi495 (by decide +kernel)
private theorem cell495 : Covered 495 496 := singleton (i := 495) (by rw [show 2*495 = 990 by decide, phi990]; decide +kernel)
private theorem phi992 : Nat.totient 992 = 480 := step (p := 2) (m := 496) (by decide +kernel) (by decide) phi496 (by decide +kernel)
private theorem cell496 : Covered 496 497 := singleton (i := 496) (by rw [show 2*496 = 992 by decide, phi992]; decide +kernel)
private theorem grid495x497 : Covered 495 497 := pair cell495 cell496
private theorem phi497 : Nat.totient 497 = 420 := step (p := 7) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem phi994 : Nat.totient 994 = 420 := step (p := 2) (m := 497) (by decide +kernel) (by decide) phi497 (by decide +kernel)
private theorem cell497 : Covered 497 498 := singleton (i := 497) (by rw [show 2*497 = 994 by decide, phi994]; decide +kernel)
private theorem phi996 : Nat.totient 996 = 328 := step (p := 2) (m := 498) (by decide +kernel) (by decide) phi498 (by decide +kernel)
private theorem cell498 : Covered 498 499 := singleton (i := 498) (by rw [show 2*498 = 996 by decide, phi996]; decide +kernel)
private theorem phi499 : Nat.totient 499 = 498 := step (p := 499) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi998 : Nat.totient 998 = 498 := step (p := 2) (m := 499) (by decide +kernel) (by decide) phi499 (by decide +kernel)
private theorem cell499 : Covered 499 500 := singleton (i := 499) (by rw [show 2*499 = 998 by decide, phi998]; decide +kernel)
private theorem grid498x500 : Covered 498 500 := pair cell498 cell499
private theorem grid497x500 : Covered 497 500 := pair cell497 grid498x500
private theorem grid495x500 : Covered 495 500 := pair grid495x497 grid497x500
private theorem grid491x500 : Covered 491 500 := pair grid491x495 grid495x500
private theorem phi1000 : Nat.totient 1000 = 400 := step (p := 2) (m := 500) (by decide +kernel) (by decide) phi500 (by decide +kernel)
private theorem cell500 : Covered 500 501 := singleton (i := 500) (by rw [show 2*500 = 1000 by decide, phi1000]; decide +kernel)
private theorem phi501 : Nat.totient 501 = 332 := step (p := 3) (m := 167) (by decide +kernel) (by decide) phi167 (by decide +kernel)
private theorem phi1002 : Nat.totient 1002 = 332 := step (p := 2) (m := 501) (by decide +kernel) (by decide) phi501 (by decide +kernel)
private theorem cell501 : Covered 501 502 := singleton (i := 501) (by rw [show 2*501 = 1002 by decide, phi1002]; decide +kernel)
private theorem grid500x502 : Covered 500 502 := pair cell500 cell501
private theorem phi1004 : Nat.totient 1004 = 500 := step (p := 2) (m := 502) (by decide +kernel) (by decide) phi502 (by decide +kernel)
private theorem cell502 : Covered 502 503 := singleton (i := 502) (by rw [show 2*502 = 1004 by decide, phi1004]; decide +kernel)
private theorem phi503 : Nat.totient 503 = 502 := step (p := 503) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1006 : Nat.totient 1006 = 502 := step (p := 2) (m := 503) (by decide +kernel) (by decide) phi503 (by decide +kernel)
private theorem cell503 : Covered 503 504 := singleton (i := 503) (by rw [show 2*503 = 1006 by decide, phi1006]; decide +kernel)
private theorem phi1008 : Nat.totient 1008 = 288 := step (p := 2) (m := 504) (by decide +kernel) (by decide) phi504 (by decide +kernel)
private theorem cell504 : Covered 504 505 := singleton (i := 504) (by rw [show 2*504 = 1008 by decide, phi1008]; decide +kernel)
private theorem grid503x505 : Covered 503 505 := pair cell503 cell504
private theorem grid502x505 : Covered 502 505 := pair cell502 grid503x505
private theorem grid500x505 : Covered 500 505 := pair grid500x502 grid502x505
private theorem phi505 : Nat.totient 505 = 400 := step (p := 5) (m := 101) (by decide +kernel) (by decide) phi101 (by decide +kernel)
private theorem phi1010 : Nat.totient 1010 = 400 := step (p := 2) (m := 505) (by decide +kernel) (by decide) phi505 (by decide +kernel)
private theorem cell505 : Covered 505 506 := singleton (i := 505) (by rw [show 2*505 = 1010 by decide, phi1010]; decide +kernel)
private theorem phi1012 : Nat.totient 1012 = 440 := step (p := 2) (m := 506) (by decide +kernel) (by decide) phi506 (by decide +kernel)
private theorem cell506 : Covered 506 507 := singleton (i := 506) (by rw [show 2*506 = 1012 by decide, phi1012]; decide +kernel)
private theorem grid505x507 : Covered 505 507 := pair cell505 cell506
private theorem phi507 : Nat.totient 507 = 312 := step (p := 3) (m := 169) (by decide +kernel) (by decide) phi169 (by decide +kernel)
private theorem phi1014 : Nat.totient 1014 = 312 := step (p := 2) (m := 507) (by decide +kernel) (by decide) phi507 (by decide +kernel)
private theorem cell507 : Covered 507 508 := singleton (i := 507) (by rw [show 2*507 = 1014 by decide, phi1014]; decide +kernel)
private theorem phi1016 : Nat.totient 1016 = 504 := step (p := 2) (m := 508) (by decide +kernel) (by decide) phi508 (by decide +kernel)
private theorem cell508 : Covered 508 509 := singleton (i := 508) (by rw [show 2*508 = 1016 by decide, phi1016]; decide +kernel)
private theorem phi509 : Nat.totient 509 = 508 := step (p := 509) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1018 : Nat.totient 1018 = 508 := step (p := 2) (m := 509) (by decide +kernel) (by decide) phi509 (by decide +kernel)
private theorem cell509 : Covered 509 510 := singleton (i := 509) (by rw [show 2*509 = 1018 by decide, phi1018]; decide +kernel)
private theorem grid508x510 : Covered 508 510 := pair cell508 cell509
private theorem grid507x510 : Covered 507 510 := pair cell507 grid508x510
private theorem grid505x510 : Covered 505 510 := pair grid505x507 grid507x510
private theorem grid500x510 : Covered 500 510 := pair grid500x505 grid505x510
private theorem grid491x510 : Covered 491 510 := pair grid491x500 grid500x510
private theorem grid473x510 : Covered 473 510 := pair grid473x491 grid491x510
private theorem grid437x510 : Covered 437 510 := pair grid437x473 grid473x510
private theorem phi1020 : Nat.totient 1020 = 256 := step (p := 2) (m := 510) (by decide +kernel) (by decide) phi510 (by decide +kernel)
private theorem cell510 : Covered 510 511 := singleton (i := 510) (by rw [show 2*510 = 1020 by decide, phi1020]; decide +kernel)
private theorem phi511 : Nat.totient 511 = 432 := step (p := 7) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem phi1022 : Nat.totient 1022 = 432 := step (p := 2) (m := 511) (by decide +kernel) (by decide) phi511 (by decide +kernel)
private theorem cell511 : Covered 511 512 := singleton (i := 511) (by rw [show 2*511 = 1022 by decide, phi1022]; decide +kernel)
private theorem grid510x512 : Covered 510 512 := pair cell510 cell511
private theorem phi1024 : Nat.totient 1024 = 512 := step (p := 2) (m := 512) (by decide +kernel) (by decide) phi512 (by decide +kernel)
private theorem cell512 : Covered 512 513 := singleton (i := 512) (by rw [show 2*512 = 1024 by decide, phi1024]; decide +kernel)
private theorem phi513 : Nat.totient 513 = 324 := step (p := 3) (m := 171) (by decide +kernel) (by decide) phi171 (by decide +kernel)
private theorem phi1026 : Nat.totient 1026 = 324 := step (p := 2) (m := 513) (by decide +kernel) (by decide) phi513 (by decide +kernel)
private theorem cell513 : Covered 513 514 := singleton (i := 513) (by rw [show 2*513 = 1026 by decide, phi1026]; decide +kernel)
private theorem grid512x514 : Covered 512 514 := pair cell512 cell513
private theorem grid510x514 : Covered 510 514 := pair grid510x512 grid512x514
private theorem phi1028 : Nat.totient 1028 = 512 := step (p := 2) (m := 514) (by decide +kernel) (by decide) phi514 (by decide +kernel)
private theorem cell514 : Covered 514 515 := singleton (i := 514) (by rw [show 2*514 = 1028 by decide, phi1028]; decide +kernel)
private theorem phi515 : Nat.totient 515 = 408 := step (p := 5) (m := 103) (by decide +kernel) (by decide) phi103 (by decide +kernel)
private theorem phi1030 : Nat.totient 1030 = 408 := step (p := 2) (m := 515) (by decide +kernel) (by decide) phi515 (by decide +kernel)
private theorem cell515 : Covered 515 516 := singleton (i := 515) (by rw [show 2*515 = 1030 by decide, phi1030]; decide +kernel)
private theorem grid514x516 : Covered 514 516 := pair cell514 cell515
private theorem phi1032 : Nat.totient 1032 = 336 := step (p := 2) (m := 516) (by decide +kernel) (by decide) phi516 (by decide +kernel)
private theorem cell516 : Covered 516 517 := singleton (i := 516) (by rw [show 2*516 = 1032 by decide, phi1032]; decide +kernel)
private theorem phi517 : Nat.totient 517 = 460 := step (p := 11) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi1034 : Nat.totient 1034 = 460 := step (p := 2) (m := 517) (by decide +kernel) (by decide) phi517 (by decide +kernel)
private theorem cell517 : Covered 517 518 := singleton (i := 517) (by rw [show 2*517 = 1034 by decide, phi1034]; decide +kernel)
private theorem phi1036 : Nat.totient 1036 = 432 := step (p := 2) (m := 518) (by decide +kernel) (by decide) phi518 (by decide +kernel)
private theorem cell518 : Covered 518 519 := singleton (i := 518) (by rw [show 2*518 = 1036 by decide, phi1036]; decide +kernel)
private theorem grid517x519 : Covered 517 519 := pair cell517 cell518
private theorem grid516x519 : Covered 516 519 := pair cell516 grid517x519
private theorem grid514x519 : Covered 514 519 := pair grid514x516 grid516x519
private theorem grid510x519 : Covered 510 519 := pair grid510x514 grid514x519
private theorem phi519 : Nat.totient 519 = 344 := step (p := 3) (m := 173) (by decide +kernel) (by decide) phi173 (by decide +kernel)
private theorem phi1038 : Nat.totient 1038 = 344 := step (p := 2) (m := 519) (by decide +kernel) (by decide) phi519 (by decide +kernel)
private theorem cell519 : Covered 519 520 := singleton (i := 519) (by rw [show 2*519 = 1038 by decide, phi1038]; decide +kernel)
private theorem phi1040 : Nat.totient 1040 = 384 := step (p := 2) (m := 520) (by decide +kernel) (by decide) phi520 (by decide +kernel)
private theorem cell520 : Covered 520 521 := singleton (i := 520) (by rw [show 2*520 = 1040 by decide, phi1040]; decide +kernel)
private theorem grid519x521 : Covered 519 521 := pair cell519 cell520
private theorem phi521 : Nat.totient 521 = 520 := step (p := 521) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1042 : Nat.totient 1042 = 520 := step (p := 2) (m := 521) (by decide +kernel) (by decide) phi521 (by decide +kernel)
private theorem cell521 : Covered 521 522 := singleton (i := 521) (by rw [show 2*521 = 1042 by decide, phi1042]; decide +kernel)
private theorem phi1044 : Nat.totient 1044 = 336 := step (p := 2) (m := 522) (by decide +kernel) (by decide) phi522 (by decide +kernel)
private theorem cell522 : Covered 522 523 := singleton (i := 522) (by rw [show 2*522 = 1044 by decide, phi1044]; decide +kernel)
private theorem grid521x523 : Covered 521 523 := pair cell521 cell522
private theorem grid519x523 : Covered 519 523 := pair grid519x521 grid521x523
private theorem phi523 : Nat.totient 523 = 522 := step (p := 523) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1046 : Nat.totient 1046 = 522 := step (p := 2) (m := 523) (by decide +kernel) (by decide) phi523 (by decide +kernel)
private theorem cell523 : Covered 523 524 := singleton (i := 523) (by rw [show 2*523 = 1046 by decide, phi1046]; decide +kernel)
private theorem phi1048 : Nat.totient 1048 = 520 := step (p := 2) (m := 524) (by decide +kernel) (by decide) phi524 (by decide +kernel)
private theorem cell524 : Covered 524 525 := singleton (i := 524) (by rw [show 2*524 = 1048 by decide, phi1048]; decide +kernel)
private theorem grid523x525 : Covered 523 525 := pair cell523 cell524
private theorem phi525 : Nat.totient 525 = 240 := step (p := 3) (m := 175) (by decide +kernel) (by decide) phi175 (by decide +kernel)
private theorem phi1050 : Nat.totient 1050 = 240 := step (p := 2) (m := 525) (by decide +kernel) (by decide) phi525 (by decide +kernel)
private theorem cell525 : Covered 525 526 := singleton (i := 525) (by rw [show 2*525 = 1050 by decide, phi1050]; decide +kernel)
private theorem phi1052 : Nat.totient 1052 = 524 := step (p := 2) (m := 526) (by decide +kernel) (by decide) phi526 (by decide +kernel)
private theorem cell526 : Covered 526 527 := singleton (i := 526) (by rw [show 2*526 = 1052 by decide, phi1052]; decide +kernel)
private theorem phi527 : Nat.totient 527 = 480 := step (p := 17) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi1054 : Nat.totient 1054 = 480 := step (p := 2) (m := 527) (by decide +kernel) (by decide) phi527 (by decide +kernel)
private theorem cell527 : Covered 527 528 := singleton (i := 527) (by rw [show 2*527 = 1054 by decide, phi1054]; decide +kernel)
private theorem grid526x528 : Covered 526 528 := pair cell526 cell527
private theorem grid525x528 : Covered 525 528 := pair cell525 grid526x528
private theorem grid523x528 : Covered 523 528 := pair grid523x525 grid525x528
private theorem grid519x528 : Covered 519 528 := pair grid519x523 grid523x528
private theorem grid510x528 : Covered 510 528 := pair grid510x519 grid519x528
private theorem phi1056 : Nat.totient 1056 = 320 := step (p := 2) (m := 528) (by decide +kernel) (by decide) phi528 (by decide +kernel)
private theorem cell528 : Covered 528 529 := singleton (i := 528) (by rw [show 2*528 = 1056 by decide, phi1056]; decide +kernel)
private theorem phi529 : Nat.totient 529 = 506 := step (p := 23) (m := 23) (by decide +kernel) (by decide) phi23 (by decide +kernel)
private theorem phi1058 : Nat.totient 1058 = 506 := step (p := 2) (m := 529) (by decide +kernel) (by decide) phi529 (by decide +kernel)
private theorem cell529 : Covered 529 530 := singleton (i := 529) (by rw [show 2*529 = 1058 by decide, phi1058]; decide +kernel)
private theorem grid528x530 : Covered 528 530 := pair cell528 cell529
private theorem phi1060 : Nat.totient 1060 = 416 := step (p := 2) (m := 530) (by decide +kernel) (by decide) phi530 (by decide +kernel)
private theorem cell530 : Covered 530 531 := singleton (i := 530) (by rw [show 2*530 = 1060 by decide, phi1060]; decide +kernel)
private theorem phi531 : Nat.totient 531 = 348 := step (p := 3) (m := 177) (by decide +kernel) (by decide) phi177 (by decide +kernel)
private theorem phi1062 : Nat.totient 1062 = 348 := step (p := 2) (m := 531) (by decide +kernel) (by decide) phi531 (by decide +kernel)
private theorem cell531 : Covered 531 532 := singleton (i := 531) (by rw [show 2*531 = 1062 by decide, phi1062]; decide +kernel)
private theorem grid530x532 : Covered 530 532 := pair cell530 cell531
private theorem grid528x532 : Covered 528 532 := pair grid528x530 grid530x532
private theorem phi1064 : Nat.totient 1064 = 432 := step (p := 2) (m := 532) (by decide +kernel) (by decide) phi532 (by decide +kernel)
private theorem cell532 : Covered 532 533 := singleton (i := 532) (by rw [show 2*532 = 1064 by decide, phi1064]; decide +kernel)
private theorem phi533 : Nat.totient 533 = 480 := step (p := 13) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi1066 : Nat.totient 1066 = 480 := step (p := 2) (m := 533) (by decide +kernel) (by decide) phi533 (by decide +kernel)
private theorem cell533 : Covered 533 534 := singleton (i := 533) (by rw [show 2*533 = 1066 by decide, phi1066]; decide +kernel)
private theorem grid532x534 : Covered 532 534 := pair cell532 cell533
private theorem phi1068 : Nat.totient 1068 = 352 := step (p := 2) (m := 534) (by decide +kernel) (by decide) phi534 (by decide +kernel)
private theorem cell534 : Covered 534 535 := singleton (i := 534) (by rw [show 2*534 = 1068 by decide, phi1068]; decide +kernel)
private theorem phi535 : Nat.totient 535 = 424 := step (p := 5) (m := 107) (by decide +kernel) (by decide) phi107 (by decide +kernel)
private theorem phi1070 : Nat.totient 1070 = 424 := step (p := 2) (m := 535) (by decide +kernel) (by decide) phi535 (by decide +kernel)
private theorem cell535 : Covered 535 536 := singleton (i := 535) (by rw [show 2*535 = 1070 by decide, phi1070]; decide +kernel)
private theorem phi1072 : Nat.totient 1072 = 528 := step (p := 2) (m := 536) (by decide +kernel) (by decide) phi536 (by decide +kernel)
private theorem cell536 : Covered 536 537 := singleton (i := 536) (by rw [show 2*536 = 1072 by decide, phi1072]; decide +kernel)
private theorem grid535x537 : Covered 535 537 := pair cell535 cell536
private theorem grid534x537 : Covered 534 537 := pair cell534 grid535x537
private theorem grid532x537 : Covered 532 537 := pair grid532x534 grid534x537
private theorem grid528x537 : Covered 528 537 := pair grid528x532 grid532x537
private theorem phi537 : Nat.totient 537 = 356 := step (p := 3) (m := 179) (by decide +kernel) (by decide) phi179 (by decide +kernel)
private theorem phi1074 : Nat.totient 1074 = 356 := step (p := 2) (m := 537) (by decide +kernel) (by decide) phi537 (by decide +kernel)
private theorem cell537 : Covered 537 538 := singleton (i := 537) (by rw [show 2*537 = 1074 by decide, phi1074]; decide +kernel)
private theorem phi1076 : Nat.totient 1076 = 536 := step (p := 2) (m := 538) (by decide +kernel) (by decide) phi538 (by decide +kernel)
private theorem cell538 : Covered 538 539 := singleton (i := 538) (by rw [show 2*538 = 1076 by decide, phi1076]; decide +kernel)
private theorem grid537x539 : Covered 537 539 := pair cell537 cell538
private theorem phi539 : Nat.totient 539 = 420 := step (p := 7) (m := 77) (by decide +kernel) (by decide) phi77 (by decide +kernel)
private theorem phi1078 : Nat.totient 1078 = 420 := step (p := 2) (m := 539) (by decide +kernel) (by decide) phi539 (by decide +kernel)
private theorem cell539 : Covered 539 540 := singleton (i := 539) (by rw [show 2*539 = 1078 by decide, phi1078]; decide +kernel)
private theorem phi1080 : Nat.totient 1080 = 288 := step (p := 2) (m := 540) (by decide +kernel) (by decide) phi540 (by decide +kernel)
private theorem cell540 : Covered 540 541 := singleton (i := 540) (by rw [show 2*540 = 1080 by decide, phi1080]; decide +kernel)
private theorem grid539x541 : Covered 539 541 := pair cell539 cell540
private theorem grid537x541 : Covered 537 541 := pair grid537x539 grid539x541
private theorem phi541 : Nat.totient 541 = 540 := step (p := 541) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1082 : Nat.totient 1082 = 540 := step (p := 2) (m := 541) (by decide +kernel) (by decide) phi541 (by decide +kernel)
private theorem cell541 : Covered 541 542 := singleton (i := 541) (by rw [show 2*541 = 1082 by decide, phi1082]; decide +kernel)
private theorem phi1084 : Nat.totient 1084 = 540 := step (p := 2) (m := 542) (by decide +kernel) (by decide) phi542 (by decide +kernel)
private theorem cell542 : Covered 542 543 := singleton (i := 542) (by rw [show 2*542 = 1084 by decide, phi1084]; decide +kernel)
private theorem grid541x543 : Covered 541 543 := pair cell541 cell542
private theorem phi543 : Nat.totient 543 = 360 := step (p := 3) (m := 181) (by decide +kernel) (by decide) phi181 (by decide +kernel)
private theorem phi1086 : Nat.totient 1086 = 360 := step (p := 2) (m := 543) (by decide +kernel) (by decide) phi543 (by decide +kernel)
private theorem cell543 : Covered 543 544 := singleton (i := 543) (by rw [show 2*543 = 1086 by decide, phi1086]; decide +kernel)
private theorem phi1088 : Nat.totient 1088 = 512 := step (p := 2) (m := 544) (by decide +kernel) (by decide) phi544 (by decide +kernel)
private theorem cell544 : Covered 544 545 := singleton (i := 544) (by rw [show 2*544 = 1088 by decide, phi1088]; decide +kernel)
private theorem phi545 : Nat.totient 545 = 432 := step (p := 5) (m := 109) (by decide +kernel) (by decide) phi109 (by decide +kernel)
private theorem phi1090 : Nat.totient 1090 = 432 := step (p := 2) (m := 545) (by decide +kernel) (by decide) phi545 (by decide +kernel)
private theorem cell545 : Covered 545 546 := singleton (i := 545) (by rw [show 2*545 = 1090 by decide, phi1090]; decide +kernel)
private theorem grid544x546 : Covered 544 546 := pair cell544 cell545
private theorem grid543x546 : Covered 543 546 := pair cell543 grid544x546
private theorem grid541x546 : Covered 541 546 := pair grid541x543 grid543x546
private theorem grid537x546 : Covered 537 546 := pair grid537x541 grid541x546
private theorem grid528x546 : Covered 528 546 := pair grid528x537 grid537x546
private theorem grid510x546 : Covered 510 546 := pair grid510x528 grid528x546
private theorem phi1092 : Nat.totient 1092 = 288 := step (p := 2) (m := 546) (by decide +kernel) (by decide) phi546 (by decide +kernel)
private theorem cell546 : Covered 546 547 := singleton (i := 546) (by rw [show 2*546 = 1092 by decide, phi1092]; decide +kernel)
private theorem phi547 : Nat.totient 547 = 546 := step (p := 547) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1094 : Nat.totient 1094 = 546 := step (p := 2) (m := 547) (by decide +kernel) (by decide) phi547 (by decide +kernel)
private theorem cell547 : Covered 547 548 := singleton (i := 547) (by rw [show 2*547 = 1094 by decide, phi1094]; decide +kernel)
private theorem grid546x548 : Covered 546 548 := pair cell546 cell547
private theorem phi1096 : Nat.totient 1096 = 544 := step (p := 2) (m := 548) (by decide +kernel) (by decide) phi548 (by decide +kernel)
private theorem cell548 : Covered 548 549 := singleton (i := 548) (by rw [show 2*548 = 1096 by decide, phi1096]; decide +kernel)
private theorem phi549 : Nat.totient 549 = 360 := step (p := 3) (m := 183) (by decide +kernel) (by decide) phi183 (by decide +kernel)
private theorem phi1098 : Nat.totient 1098 = 360 := step (p := 2) (m := 549) (by decide +kernel) (by decide) phi549 (by decide +kernel)
private theorem cell549 : Covered 549 550 := singleton (i := 549) (by rw [show 2*549 = 1098 by decide, phi1098]; decide +kernel)
private theorem grid548x550 : Covered 548 550 := pair cell548 cell549
private theorem grid546x550 : Covered 546 550 := pair grid546x548 grid548x550
private theorem phi1100 : Nat.totient 1100 = 400 := step (p := 2) (m := 550) (by decide +kernel) (by decide) phi550 (by decide +kernel)
private theorem cell550 : Covered 550 551 := singleton (i := 550) (by rw [show 2*550 = 1100 by decide, phi1100]; decide +kernel)
private theorem phi551 : Nat.totient 551 = 504 := step (p := 19) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi1102 : Nat.totient 1102 = 504 := step (p := 2) (m := 551) (by decide +kernel) (by decide) phi551 (by decide +kernel)
private theorem cell551 : Covered 551 552 := singleton (i := 551) (by rw [show 2*551 = 1102 by decide, phi1102]; decide +kernel)
private theorem grid550x552 : Covered 550 552 := pair cell550 cell551
private theorem phi1104 : Nat.totient 1104 = 352 := step (p := 2) (m := 552) (by decide +kernel) (by decide) phi552 (by decide +kernel)
private theorem cell552 : Covered 552 553 := singleton (i := 552) (by rw [show 2*552 = 1104 by decide, phi1104]; decide +kernel)
private theorem phi553 : Nat.totient 553 = 468 := step (p := 7) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem phi1106 : Nat.totient 1106 = 468 := step (p := 2) (m := 553) (by decide +kernel) (by decide) phi553 (by decide +kernel)
private theorem cell553 : Covered 553 554 := singleton (i := 553) (by rw [show 2*553 = 1106 by decide, phi1106]; decide +kernel)
private theorem phi1108 : Nat.totient 1108 = 552 := step (p := 2) (m := 554) (by decide +kernel) (by decide) phi554 (by decide +kernel)
private theorem cell554 : Covered 554 555 := singleton (i := 554) (by rw [show 2*554 = 1108 by decide, phi1108]; decide +kernel)
private theorem grid553x555 : Covered 553 555 := pair cell553 cell554
private theorem grid552x555 : Covered 552 555 := pair cell552 grid553x555
private theorem grid550x555 : Covered 550 555 := pair grid550x552 grid552x555
private theorem grid546x555 : Covered 546 555 := pair grid546x550 grid550x555
private theorem phi555 : Nat.totient 555 = 288 := step (p := 3) (m := 185) (by decide +kernel) (by decide) phi185 (by decide +kernel)
private theorem phi1110 : Nat.totient 1110 = 288 := step (p := 2) (m := 555) (by decide +kernel) (by decide) phi555 (by decide +kernel)
private theorem cell555 : Covered 555 556 := singleton (i := 555) (by rw [show 2*555 = 1110 by decide, phi1110]; decide +kernel)
private theorem phi1112 : Nat.totient 1112 = 552 := step (p := 2) (m := 556) (by decide +kernel) (by decide) phi556 (by decide +kernel)
private theorem cell556 : Covered 556 557 := singleton (i := 556) (by rw [show 2*556 = 1112 by decide, phi1112]; decide +kernel)
private theorem grid555x557 : Covered 555 557 := pair cell555 cell556
private theorem phi557 : Nat.totient 557 = 556 := step (p := 557) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1114 : Nat.totient 1114 = 556 := step (p := 2) (m := 557) (by decide +kernel) (by decide) phi557 (by decide +kernel)
private theorem cell557 : Covered 557 558 := singleton (i := 557) (by rw [show 2*557 = 1114 by decide, phi1114]; decide +kernel)
private theorem phi1116 : Nat.totient 1116 = 360 := step (p := 2) (m := 558) (by decide +kernel) (by decide) phi558 (by decide +kernel)
private theorem cell558 : Covered 558 559 := singleton (i := 558) (by rw [show 2*558 = 1116 by decide, phi1116]; decide +kernel)
private theorem grid557x559 : Covered 557 559 := pair cell557 cell558
private theorem grid555x559 : Covered 555 559 := pair grid555x557 grid557x559
private theorem phi559 : Nat.totient 559 = 504 := step (p := 13) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi1118 : Nat.totient 1118 = 504 := step (p := 2) (m := 559) (by decide +kernel) (by decide) phi559 (by decide +kernel)
private theorem cell559 : Covered 559 560 := singleton (i := 559) (by rw [show 2*559 = 1118 by decide, phi1118]; decide +kernel)
private theorem phi1120 : Nat.totient 1120 = 384 := step (p := 2) (m := 560) (by decide +kernel) (by decide) phi560 (by decide +kernel)
private theorem cell560 : Covered 560 561 := singleton (i := 560) (by rw [show 2*560 = 1120 by decide, phi1120]; decide +kernel)
private theorem grid559x561 : Covered 559 561 := pair cell559 cell560
private theorem phi561 : Nat.totient 561 = 320 := step (p := 3) (m := 187) (by decide +kernel) (by decide) phi187 (by decide +kernel)
private theorem phi1122 : Nat.totient 1122 = 320 := step (p := 2) (m := 561) (by decide +kernel) (by decide) phi561 (by decide +kernel)
private theorem cell561 : Covered 561 562 := singleton (i := 561) (by rw [show 2*561 = 1122 by decide, phi1122]; decide +kernel)
private theorem phi1124 : Nat.totient 1124 = 560 := step (p := 2) (m := 562) (by decide +kernel) (by decide) phi562 (by decide +kernel)
private theorem cell562 : Covered 562 563 := singleton (i := 562) (by rw [show 2*562 = 1124 by decide, phi1124]; decide +kernel)
private theorem phi563 : Nat.totient 563 = 562 := step (p := 563) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1126 : Nat.totient 1126 = 562 := step (p := 2) (m := 563) (by decide +kernel) (by decide) phi563 (by decide +kernel)
private theorem cell563 : Covered 563 564 := singleton (i := 563) (by rw [show 2*563 = 1126 by decide, phi1126]; decide +kernel)
private theorem grid562x564 : Covered 562 564 := pair cell562 cell563
private theorem grid561x564 : Covered 561 564 := pair cell561 grid562x564
private theorem grid559x564 : Covered 559 564 := pair grid559x561 grid561x564
private theorem grid555x564 : Covered 555 564 := pair grid555x559 grid559x564
private theorem grid546x564 : Covered 546 564 := pair grid546x555 grid555x564
private theorem phi1128 : Nat.totient 1128 = 368 := step (p := 2) (m := 564) (by decide +kernel) (by decide) phi564 (by decide +kernel)
private theorem cell564 : Covered 564 565 := singleton (i := 564) (by rw [show 2*564 = 1128 by decide, phi1128]; decide +kernel)
private theorem phi565 : Nat.totient 565 = 448 := step (p := 5) (m := 113) (by decide +kernel) (by decide) phi113 (by decide +kernel)
private theorem phi1130 : Nat.totient 1130 = 448 := step (p := 2) (m := 565) (by decide +kernel) (by decide) phi565 (by decide +kernel)
private theorem cell565 : Covered 565 566 := singleton (i := 565) (by rw [show 2*565 = 1130 by decide, phi1130]; decide +kernel)
private theorem grid564x566 : Covered 564 566 := pair cell564 cell565
private theorem phi1132 : Nat.totient 1132 = 564 := step (p := 2) (m := 566) (by decide +kernel) (by decide) phi566 (by decide +kernel)
private theorem cell566 : Covered 566 567 := singleton (i := 566) (by rw [show 2*566 = 1132 by decide, phi1132]; decide +kernel)
private theorem phi567 : Nat.totient 567 = 324 := step (p := 3) (m := 189) (by decide +kernel) (by decide) phi189 (by decide +kernel)
private theorem phi1134 : Nat.totient 1134 = 324 := step (p := 2) (m := 567) (by decide +kernel) (by decide) phi567 (by decide +kernel)
private theorem cell567 : Covered 567 568 := singleton (i := 567) (by rw [show 2*567 = 1134 by decide, phi1134]; decide +kernel)
private theorem grid566x568 : Covered 566 568 := pair cell566 cell567
private theorem grid564x568 : Covered 564 568 := pair grid564x566 grid566x568
private theorem phi1136 : Nat.totient 1136 = 560 := step (p := 2) (m := 568) (by decide +kernel) (by decide) phi568 (by decide +kernel)
private theorem cell568 : Covered 568 569 := singleton (i := 568) (by rw [show 2*568 = 1136 by decide, phi1136]; decide +kernel)
private theorem phi569 : Nat.totient 569 = 568 := step (p := 569) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1138 : Nat.totient 1138 = 568 := step (p := 2) (m := 569) (by decide +kernel) (by decide) phi569 (by decide +kernel)
private theorem cell569 : Covered 569 570 := singleton (i := 569) (by rw [show 2*569 = 1138 by decide, phi1138]; decide +kernel)
private theorem grid568x570 : Covered 568 570 := pair cell568 cell569
private theorem phi1140 : Nat.totient 1140 = 288 := step (p := 2) (m := 570) (by decide +kernel) (by decide) phi570 (by decide +kernel)
private theorem cell570 : Covered 570 571 := singleton (i := 570) (by rw [show 2*570 = 1140 by decide, phi1140]; decide +kernel)
private theorem phi571 : Nat.totient 571 = 570 := step (p := 571) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1142 : Nat.totient 1142 = 570 := step (p := 2) (m := 571) (by decide +kernel) (by decide) phi571 (by decide +kernel)
private theorem cell571 : Covered 571 572 := singleton (i := 571) (by rw [show 2*571 = 1142 by decide, phi1142]; decide +kernel)
private theorem phi1144 : Nat.totient 1144 = 480 := step (p := 2) (m := 572) (by decide +kernel) (by decide) phi572 (by decide +kernel)
private theorem cell572 : Covered 572 573 := singleton (i := 572) (by rw [show 2*572 = 1144 by decide, phi1144]; decide +kernel)
private theorem grid571x573 : Covered 571 573 := pair cell571 cell572
private theorem grid570x573 : Covered 570 573 := pair cell570 grid571x573
private theorem grid568x573 : Covered 568 573 := pair grid568x570 grid570x573
private theorem grid564x573 : Covered 564 573 := pair grid564x568 grid568x573
private theorem phi573 : Nat.totient 573 = 380 := step (p := 3) (m := 191) (by decide +kernel) (by decide) phi191 (by decide +kernel)
private theorem phi1146 : Nat.totient 1146 = 380 := step (p := 2) (m := 573) (by decide +kernel) (by decide) phi573 (by decide +kernel)
private theorem cell573 : Covered 573 574 := singleton (i := 573) (by rw [show 2*573 = 1146 by decide, phi1146]; decide +kernel)
private theorem phi1148 : Nat.totient 1148 = 480 := step (p := 2) (m := 574) (by decide +kernel) (by decide) phi574 (by decide +kernel)
private theorem cell574 : Covered 574 575 := singleton (i := 574) (by rw [show 2*574 = 1148 by decide, phi1148]; decide +kernel)
private theorem grid573x575 : Covered 573 575 := pair cell573 cell574
private theorem phi575 : Nat.totient 575 = 440 := step (p := 5) (m := 115) (by decide +kernel) (by decide) phi115 (by decide +kernel)
private theorem phi1150 : Nat.totient 1150 = 440 := step (p := 2) (m := 575) (by decide +kernel) (by decide) phi575 (by decide +kernel)
private theorem cell575 : Covered 575 576 := singleton (i := 575) (by rw [show 2*575 = 1150 by decide, phi1150]; decide +kernel)
private theorem phi1152 : Nat.totient 1152 = 384 := step (p := 2) (m := 576) (by decide +kernel) (by decide) phi576 (by decide +kernel)
private theorem cell576 : Covered 576 577 := singleton (i := 576) (by rw [show 2*576 = 1152 by decide, phi1152]; decide +kernel)
private theorem phi577 : Nat.totient 577 = 576 := step (p := 577) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1154 : Nat.totient 1154 = 576 := step (p := 2) (m := 577) (by decide +kernel) (by decide) phi577 (by decide +kernel)
private theorem cell577 : Covered 577 578 := singleton (i := 577) (by rw [show 2*577 = 1154 by decide, phi1154]; decide +kernel)
private theorem grid576x578 : Covered 576 578 := pair cell576 cell577
private theorem grid575x578 : Covered 575 578 := pair cell575 grid576x578
private theorem grid573x578 : Covered 573 578 := pair grid573x575 grid575x578
private theorem phi1156 : Nat.totient 1156 = 544 := step (p := 2) (m := 578) (by decide +kernel) (by decide) phi578 (by decide +kernel)
private theorem cell578 : Covered 578 579 := singleton (i := 578) (by rw [show 2*578 = 1156 by decide, phi1156]; decide +kernel)
private theorem phi579 : Nat.totient 579 = 384 := step (p := 3) (m := 193) (by decide +kernel) (by decide) phi193 (by decide +kernel)
private theorem phi1158 : Nat.totient 1158 = 384 := step (p := 2) (m := 579) (by decide +kernel) (by decide) phi579 (by decide +kernel)
private theorem cell579 : Covered 579 580 := singleton (i := 579) (by rw [show 2*579 = 1158 by decide, phi1158]; decide +kernel)
private theorem grid578x580 : Covered 578 580 := pair cell578 cell579
private theorem phi1160 : Nat.totient 1160 = 448 := step (p := 2) (m := 580) (by decide +kernel) (by decide) phi580 (by decide +kernel)
private theorem cell580 : Covered 580 581 := singleton (i := 580) (by rw [show 2*580 = 1160 by decide, phi1160]; decide +kernel)
private theorem phi581 : Nat.totient 581 = 492 := step (p := 7) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem phi1162 : Nat.totient 1162 = 492 := step (p := 2) (m := 581) (by decide +kernel) (by decide) phi581 (by decide +kernel)
private theorem cell581 : Covered 581 582 := singleton (i := 581) (by rw [show 2*581 = 1162 by decide, phi1162]; decide +kernel)
private theorem phi1164 : Nat.totient 1164 = 384 := step (p := 2) (m := 582) (by decide +kernel) (by decide) phi582 (by decide +kernel)
private theorem cell582 : Covered 582 583 := singleton (i := 582) (by rw [show 2*582 = 1164 by decide, phi1164]; decide +kernel)
private theorem grid581x583 : Covered 581 583 := pair cell581 cell582
private theorem grid580x583 : Covered 580 583 := pair cell580 grid581x583
private theorem grid578x583 : Covered 578 583 := pair grid578x580 grid580x583
private theorem grid573x583 : Covered 573 583 := pair grid573x578 grid578x583
private theorem grid564x583 : Covered 564 583 := pair grid564x573 grid573x583
private theorem grid546x583 : Covered 546 583 := pair grid546x564 grid564x583
private theorem grid510x583 : Covered 510 583 := pair grid510x546 grid546x583
private theorem grid437x583 : Covered 437 583 := pair grid437x510 grid510x583
private theorem grid292x583 : Covered 292 583 := pair grid292x437 grid437x583
private theorem grid1x583 : Covered 1 583 := pair grid1x292 grid292x583
private theorem phi583 : Nat.totient 583 = 520 := step (p := 11) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi1166 : Nat.totient 1166 = 520 := step (p := 2) (m := 583) (by decide +kernel) (by decide) phi583 (by decide +kernel)
private theorem cell583 : Covered 583 584 := singleton (i := 583) (by rw [show 2*583 = 1166 by decide, phi1166]; decide +kernel)
private theorem phi1168 : Nat.totient 1168 = 576 := step (p := 2) (m := 584) (by decide +kernel) (by decide) phi584 (by decide +kernel)
private theorem cell584 : Covered 584 585 := singleton (i := 584) (by rw [show 2*584 = 1168 by decide, phi1168]; decide +kernel)
private theorem grid583x585 : Covered 583 585 := pair cell583 cell584
private theorem phi585 : Nat.totient 585 = 288 := step (p := 3) (m := 195) (by decide +kernel) (by decide) phi195 (by decide +kernel)
private theorem phi1170 : Nat.totient 1170 = 288 := step (p := 2) (m := 585) (by decide +kernel) (by decide) phi585 (by decide +kernel)
private theorem cell585 : Covered 585 586 := singleton (i := 585) (by rw [show 2*585 = 1170 by decide, phi1170]; decide +kernel)
private theorem phi1172 : Nat.totient 1172 = 584 := step (p := 2) (m := 586) (by decide +kernel) (by decide) phi586 (by decide +kernel)
private theorem cell586 : Covered 586 587 := singleton (i := 586) (by rw [show 2*586 = 1172 by decide, phi1172]; decide +kernel)
private theorem grid585x587 : Covered 585 587 := pair cell585 cell586
private theorem grid583x587 : Covered 583 587 := pair grid583x585 grid585x587
private theorem phi587 : Nat.totient 587 = 586 := step (p := 587) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1174 : Nat.totient 1174 = 586 := step (p := 2) (m := 587) (by decide +kernel) (by decide) phi587 (by decide +kernel)
private theorem cell587 : Covered 587 588 := singleton (i := 587) (by rw [show 2*587 = 1174 by decide, phi1174]; decide +kernel)
private theorem phi1176 : Nat.totient 1176 = 336 := step (p := 2) (m := 588) (by decide +kernel) (by decide) phi588 (by decide +kernel)
private theorem cell588 : Covered 588 589 := singleton (i := 588) (by rw [show 2*588 = 1176 by decide, phi1176]; decide +kernel)
private theorem grid587x589 : Covered 587 589 := pair cell587 cell588
private theorem phi589 : Nat.totient 589 = 540 := step (p := 19) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi1178 : Nat.totient 1178 = 540 := step (p := 2) (m := 589) (by decide +kernel) (by decide) phi589 (by decide +kernel)
private theorem cell589 : Covered 589 590 := singleton (i := 589) (by rw [show 2*589 = 1178 by decide, phi1178]; decide +kernel)
private theorem phi1180 : Nat.totient 1180 = 464 := step (p := 2) (m := 590) (by decide +kernel) (by decide) phi590 (by decide +kernel)
private theorem cell590 : Covered 590 591 := singleton (i := 590) (by rw [show 2*590 = 1180 by decide, phi1180]; decide +kernel)
private theorem phi591 : Nat.totient 591 = 392 := step (p := 3) (m := 197) (by decide +kernel) (by decide) phi197 (by decide +kernel)
private theorem phi1182 : Nat.totient 1182 = 392 := step (p := 2) (m := 591) (by decide +kernel) (by decide) phi591 (by decide +kernel)
private theorem cell591 : Covered 591 592 := singleton (i := 591) (by rw [show 2*591 = 1182 by decide, phi1182]; decide +kernel)
private theorem grid590x592 : Covered 590 592 := pair cell590 cell591
private theorem grid589x592 : Covered 589 592 := pair cell589 grid590x592
private theorem grid587x592 : Covered 587 592 := pair grid587x589 grid589x592
private theorem grid583x592 : Covered 583 592 := pair grid583x587 grid587x592
private theorem phi1184 : Nat.totient 1184 = 576 := step (p := 2) (m := 592) (by decide +kernel) (by decide) phi592 (by decide +kernel)
private theorem cell592 : Covered 592 593 := singleton (i := 592) (by rw [show 2*592 = 1184 by decide, phi1184]; decide +kernel)
private theorem phi593 : Nat.totient 593 = 592 := step (p := 593) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1186 : Nat.totient 1186 = 592 := step (p := 2) (m := 593) (by decide +kernel) (by decide) phi593 (by decide +kernel)
private theorem cell593 : Covered 593 594 := singleton (i := 593) (by rw [show 2*593 = 1186 by decide, phi1186]; decide +kernel)
private theorem grid592x594 : Covered 592 594 := pair cell592 cell593
private theorem phi1188 : Nat.totient 1188 = 360 := step (p := 2) (m := 594) (by decide +kernel) (by decide) phi594 (by decide +kernel)
private theorem cell594 : Covered 594 595 := singleton (i := 594) (by rw [show 2*594 = 1188 by decide, phi1188]; decide +kernel)
private theorem phi595 : Nat.totient 595 = 384 := step (p := 5) (m := 119) (by decide +kernel) (by decide) phi119 (by decide +kernel)
private theorem phi1190 : Nat.totient 1190 = 384 := step (p := 2) (m := 595) (by decide +kernel) (by decide) phi595 (by decide +kernel)
private theorem cell595 : Covered 595 596 := singleton (i := 595) (by rw [show 2*595 = 1190 by decide, phi1190]; decide +kernel)
private theorem grid594x596 : Covered 594 596 := pair cell594 cell595
private theorem grid592x596 : Covered 592 596 := pair grid592x594 grid594x596
private theorem phi1192 : Nat.totient 1192 = 592 := step (p := 2) (m := 596) (by decide +kernel) (by decide) phi596 (by decide +kernel)
private theorem cell596 : Covered 596 597 := singleton (i := 596) (by rw [show 2*596 = 1192 by decide, phi1192]; decide +kernel)
private theorem phi597 : Nat.totient 597 = 396 := step (p := 3) (m := 199) (by decide +kernel) (by decide) phi199 (by decide +kernel)
private theorem phi1194 : Nat.totient 1194 = 396 := step (p := 2) (m := 597) (by decide +kernel) (by decide) phi597 (by decide +kernel)
private theorem cell597 : Covered 597 598 := singleton (i := 597) (by rw [show 2*597 = 1194 by decide, phi1194]; decide +kernel)
private theorem grid596x598 : Covered 596 598 := pair cell596 cell597
private theorem phi1196 : Nat.totient 1196 = 528 := step (p := 2) (m := 598) (by decide +kernel) (by decide) phi598 (by decide +kernel)
private theorem cell598 : Covered 598 599 := singleton (i := 598) (by rw [show 2*598 = 1196 by decide, phi1196]; decide +kernel)
private theorem phi599 : Nat.totient 599 = 598 := step (p := 599) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1198 : Nat.totient 1198 = 598 := step (p := 2) (m := 599) (by decide +kernel) (by decide) phi599 (by decide +kernel)
private theorem cell599 : Covered 599 600 := singleton (i := 599) (by rw [show 2*599 = 1198 by decide, phi1198]; decide +kernel)
private theorem phi1200 : Nat.totient 1200 = 320 := step (p := 2) (m := 600) (by decide +kernel) (by decide) phi600 (by decide +kernel)
private theorem cell600 : Covered 600 601 := singleton (i := 600) (by rw [show 2*600 = 1200 by decide, phi1200]; decide +kernel)
private theorem grid599x601 : Covered 599 601 := pair cell599 cell600
private theorem grid598x601 : Covered 598 601 := pair cell598 grid599x601
private theorem grid596x601 : Covered 596 601 := pair grid596x598 grid598x601
private theorem grid592x601 : Covered 592 601 := pair grid592x596 grid596x601
private theorem grid583x601 : Covered 583 601 := pair grid583x592 grid592x601
private theorem phi601 : Nat.totient 601 = 600 := step (p := 601) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1202 : Nat.totient 1202 = 600 := step (p := 2) (m := 601) (by decide +kernel) (by decide) phi601 (by decide +kernel)
private theorem cell601 : Covered 601 602 := singleton (i := 601) (by rw [show 2*601 = 1202 by decide, phi1202]; decide +kernel)
private theorem phi1204 : Nat.totient 1204 = 504 := step (p := 2) (m := 602) (by decide +kernel) (by decide) phi602 (by decide +kernel)
private theorem cell602 : Covered 602 603 := singleton (i := 602) (by rw [show 2*602 = 1204 by decide, phi1204]; decide +kernel)
private theorem grid601x603 : Covered 601 603 := pair cell601 cell602
private theorem phi603 : Nat.totient 603 = 396 := step (p := 3) (m := 201) (by decide +kernel) (by decide) phi201 (by decide +kernel)
private theorem phi1206 : Nat.totient 1206 = 396 := step (p := 2) (m := 603) (by decide +kernel) (by decide) phi603 (by decide +kernel)
private theorem cell603 : Covered 603 604 := singleton (i := 603) (by rw [show 2*603 = 1206 by decide, phi1206]; decide +kernel)
private theorem phi1208 : Nat.totient 1208 = 600 := step (p := 2) (m := 604) (by decide +kernel) (by decide) phi604 (by decide +kernel)
private theorem cell604 : Covered 604 605 := singleton (i := 604) (by rw [show 2*604 = 1208 by decide, phi1208]; decide +kernel)
private theorem grid603x605 : Covered 603 605 := pair cell603 cell604
private theorem grid601x605 : Covered 601 605 := pair grid601x603 grid603x605
private theorem phi605 : Nat.totient 605 = 440 := step (p := 5) (m := 121) (by decide +kernel) (by decide) phi121 (by decide +kernel)
private theorem phi1210 : Nat.totient 1210 = 440 := step (p := 2) (m := 605) (by decide +kernel) (by decide) phi605 (by decide +kernel)
private theorem cell605 : Covered 605 606 := singleton (i := 605) (by rw [show 2*605 = 1210 by decide, phi1210]; decide +kernel)
private theorem phi1212 : Nat.totient 1212 = 400 := step (p := 2) (m := 606) (by decide +kernel) (by decide) phi606 (by decide +kernel)
private theorem cell606 : Covered 606 607 := singleton (i := 606) (by rw [show 2*606 = 1212 by decide, phi1212]; decide +kernel)
private theorem grid605x607 : Covered 605 607 := pair cell605 cell606
private theorem phi607 : Nat.totient 607 = 606 := step (p := 607) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1214 : Nat.totient 1214 = 606 := step (p := 2) (m := 607) (by decide +kernel) (by decide) phi607 (by decide +kernel)
private theorem cell607 : Covered 607 608 := singleton (i := 607) (by rw [show 2*607 = 1214 by decide, phi1214]; decide +kernel)
private theorem phi1216 : Nat.totient 1216 = 576 := step (p := 2) (m := 608) (by decide +kernel) (by decide) phi608 (by decide +kernel)
private theorem cell608 : Covered 608 609 := singleton (i := 608) (by rw [show 2*608 = 1216 by decide, phi1216]; decide +kernel)
private theorem phi609 : Nat.totient 609 = 336 := step (p := 3) (m := 203) (by decide +kernel) (by decide) phi203 (by decide +kernel)
private theorem phi1218 : Nat.totient 1218 = 336 := step (p := 2) (m := 609) (by decide +kernel) (by decide) phi609 (by decide +kernel)
private theorem cell609 : Covered 609 610 := singleton (i := 609) (by rw [show 2*609 = 1218 by decide, phi1218]; decide +kernel)
private theorem grid608x610 : Covered 608 610 := pair cell608 cell609
private theorem grid607x610 : Covered 607 610 := pair cell607 grid608x610
private theorem grid605x610 : Covered 605 610 := pair grid605x607 grid607x610
private theorem grid601x610 : Covered 601 610 := pair grid601x605 grid605x610
private theorem phi1220 : Nat.totient 1220 = 480 := step (p := 2) (m := 610) (by decide +kernel) (by decide) phi610 (by decide +kernel)
private theorem cell610 : Covered 610 611 := singleton (i := 610) (by rw [show 2*610 = 1220 by decide, phi1220]; decide +kernel)
private theorem phi611 : Nat.totient 611 = 552 := step (p := 13) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi1222 : Nat.totient 1222 = 552 := step (p := 2) (m := 611) (by decide +kernel) (by decide) phi611 (by decide +kernel)
private theorem cell611 : Covered 611 612 := singleton (i := 611) (by rw [show 2*611 = 1222 by decide, phi1222]; decide +kernel)
private theorem grid610x612 : Covered 610 612 := pair cell610 cell611
private theorem phi1224 : Nat.totient 1224 = 384 := step (p := 2) (m := 612) (by decide +kernel) (by decide) phi612 (by decide +kernel)
private theorem cell612 : Covered 612 613 := singleton (i := 612) (by rw [show 2*612 = 1224 by decide, phi1224]; decide +kernel)
private theorem phi613 : Nat.totient 613 = 612 := step (p := 613) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1226 : Nat.totient 1226 = 612 := step (p := 2) (m := 613) (by decide +kernel) (by decide) phi613 (by decide +kernel)
private theorem cell613 : Covered 613 614 := singleton (i := 613) (by rw [show 2*613 = 1226 by decide, phi1226]; decide +kernel)
private theorem grid612x614 : Covered 612 614 := pair cell612 cell613
private theorem grid610x614 : Covered 610 614 := pair grid610x612 grid612x614
private theorem phi1228 : Nat.totient 1228 = 612 := step (p := 2) (m := 614) (by decide +kernel) (by decide) phi614 (by decide +kernel)
private theorem cell614 : Covered 614 615 := singleton (i := 614) (by rw [show 2*614 = 1228 by decide, phi1228]; decide +kernel)
private theorem phi615 : Nat.totient 615 = 320 := step (p := 3) (m := 205) (by decide +kernel) (by decide) phi205 (by decide +kernel)
private theorem phi1230 : Nat.totient 1230 = 320 := step (p := 2) (m := 615) (by decide +kernel) (by decide) phi615 (by decide +kernel)
private theorem cell615 : Covered 615 616 := singleton (i := 615) (by rw [show 2*615 = 1230 by decide, phi1230]; decide +kernel)
private theorem grid614x616 : Covered 614 616 := pair cell614 cell615
private theorem phi1232 : Nat.totient 1232 = 480 := step (p := 2) (m := 616) (by decide +kernel) (by decide) phi616 (by decide +kernel)
private theorem cell616 : Covered 616 617 := singleton (i := 616) (by rw [show 2*616 = 1232 by decide, phi1232]; decide +kernel)
private theorem phi617 : Nat.totient 617 = 616 := step (p := 617) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1234 : Nat.totient 1234 = 616 := step (p := 2) (m := 617) (by decide +kernel) (by decide) phi617 (by decide +kernel)
private theorem cell617 : Covered 617 618 := singleton (i := 617) (by rw [show 2*617 = 1234 by decide, phi1234]; decide +kernel)
private theorem phi1236 : Nat.totient 1236 = 408 := step (p := 2) (m := 618) (by decide +kernel) (by decide) phi618 (by decide +kernel)
private theorem cell618 : Covered 618 619 := singleton (i := 618) (by rw [show 2*618 = 1236 by decide, phi1236]; decide +kernel)
private theorem grid617x619 : Covered 617 619 := pair cell617 cell618
private theorem grid616x619 : Covered 616 619 := pair cell616 grid617x619
private theorem grid614x619 : Covered 614 619 := pair grid614x616 grid616x619
private theorem grid610x619 : Covered 610 619 := pair grid610x614 grid614x619
private theorem grid601x619 : Covered 601 619 := pair grid601x610 grid610x619
private theorem grid583x619 : Covered 583 619 := pair grid583x601 grid601x619
private theorem phi619 : Nat.totient 619 = 618 := step (p := 619) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1238 : Nat.totient 1238 = 618 := step (p := 2) (m := 619) (by decide +kernel) (by decide) phi619 (by decide +kernel)
private theorem cell619 : Covered 619 620 := singleton (i := 619) (by rw [show 2*619 = 1238 by decide, phi1238]; decide +kernel)
private theorem phi1240 : Nat.totient 1240 = 480 := step (p := 2) (m := 620) (by decide +kernel) (by decide) phi620 (by decide +kernel)
private theorem cell620 : Covered 620 621 := singleton (i := 620) (by rw [show 2*620 = 1240 by decide, phi1240]; decide +kernel)
private theorem grid619x621 : Covered 619 621 := pair cell619 cell620
private theorem phi621 : Nat.totient 621 = 396 := step (p := 3) (m := 207) (by decide +kernel) (by decide) phi207 (by decide +kernel)
private theorem phi1242 : Nat.totient 1242 = 396 := step (p := 2) (m := 621) (by decide +kernel) (by decide) phi621 (by decide +kernel)
private theorem cell621 : Covered 621 622 := singleton (i := 621) (by rw [show 2*621 = 1242 by decide, phi1242]; decide +kernel)
private theorem phi1244 : Nat.totient 1244 = 620 := step (p := 2) (m := 622) (by decide +kernel) (by decide) phi622 (by decide +kernel)
private theorem cell622 : Covered 622 623 := singleton (i := 622) (by rw [show 2*622 = 1244 by decide, phi1244]; decide +kernel)
private theorem grid621x623 : Covered 621 623 := pair cell621 cell622
private theorem grid619x623 : Covered 619 623 := pair grid619x621 grid621x623
private theorem phi623 : Nat.totient 623 = 528 := step (p := 7) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem phi1246 : Nat.totient 1246 = 528 := step (p := 2) (m := 623) (by decide +kernel) (by decide) phi623 (by decide +kernel)
private theorem cell623 : Covered 623 624 := singleton (i := 623) (by rw [show 2*623 = 1246 by decide, phi1246]; decide +kernel)
private theorem phi1248 : Nat.totient 1248 = 384 := step (p := 2) (m := 624) (by decide +kernel) (by decide) phi624 (by decide +kernel)
private theorem cell624 : Covered 624 625 := singleton (i := 624) (by rw [show 2*624 = 1248 by decide, phi1248]; decide +kernel)
private theorem grid623x625 : Covered 623 625 := pair cell623 cell624
private theorem phi625 : Nat.totient 625 = 500 := step (p := 5) (m := 125) (by decide +kernel) (by decide) phi125 (by decide +kernel)
private theorem phi1250 : Nat.totient 1250 = 500 := step (p := 2) (m := 625) (by decide +kernel) (by decide) phi625 (by decide +kernel)
private theorem cell625 : Covered 625 626 := singleton (i := 625) (by rw [show 2*625 = 1250 by decide, phi1250]; decide +kernel)
private theorem phi1252 : Nat.totient 1252 = 624 := step (p := 2) (m := 626) (by decide +kernel) (by decide) phi626 (by decide +kernel)
private theorem cell626 : Covered 626 627 := singleton (i := 626) (by rw [show 2*626 = 1252 by decide, phi1252]; decide +kernel)
private theorem phi627 : Nat.totient 627 = 360 := step (p := 3) (m := 209) (by decide +kernel) (by decide) phi209 (by decide +kernel)
private theorem phi1254 : Nat.totient 1254 = 360 := step (p := 2) (m := 627) (by decide +kernel) (by decide) phi627 (by decide +kernel)
private theorem cell627 : Covered 627 628 := singleton (i := 627) (by rw [show 2*627 = 1254 by decide, phi1254]; decide +kernel)
private theorem grid626x628 : Covered 626 628 := pair cell626 cell627
private theorem grid625x628 : Covered 625 628 := pair cell625 grid626x628
private theorem grid623x628 : Covered 623 628 := pair grid623x625 grid625x628
private theorem grid619x628 : Covered 619 628 := pair grid619x623 grid623x628
private theorem phi1256 : Nat.totient 1256 = 624 := step (p := 2) (m := 628) (by decide +kernel) (by decide) phi628 (by decide +kernel)
private theorem cell628 : Covered 628 629 := singleton (i := 628) (by rw [show 2*628 = 1256 by decide, phi1256]; decide +kernel)
private theorem phi629 : Nat.totient 629 = 576 := step (p := 17) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi1258 : Nat.totient 1258 = 576 := step (p := 2) (m := 629) (by decide +kernel) (by decide) phi629 (by decide +kernel)
private theorem cell629 : Covered 629 630 := singleton (i := 629) (by rw [show 2*629 = 1258 by decide, phi1258]; decide +kernel)
private theorem grid628x630 : Covered 628 630 := pair cell628 cell629
private theorem phi1260 : Nat.totient 1260 = 288 := step (p := 2) (m := 630) (by decide +kernel) (by decide) phi630 (by decide +kernel)
private theorem cell630 : Covered 630 631 := singleton (i := 630) (by rw [show 2*630 = 1260 by decide, phi1260]; decide +kernel)
private theorem phi631 : Nat.totient 631 = 630 := step (p := 631) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1262 : Nat.totient 1262 = 630 := step (p := 2) (m := 631) (by decide +kernel) (by decide) phi631 (by decide +kernel)
private theorem cell631 : Covered 631 632 := singleton (i := 631) (by rw [show 2*631 = 1262 by decide, phi1262]; decide +kernel)
private theorem grid630x632 : Covered 630 632 := pair cell630 cell631
private theorem grid628x632 : Covered 628 632 := pair grid628x630 grid630x632
private theorem phi1264 : Nat.totient 1264 = 624 := step (p := 2) (m := 632) (by decide +kernel) (by decide) phi632 (by decide +kernel)
private theorem cell632 : Covered 632 633 := singleton (i := 632) (by rw [show 2*632 = 1264 by decide, phi1264]; decide +kernel)
private theorem phi633 : Nat.totient 633 = 420 := step (p := 3) (m := 211) (by decide +kernel) (by decide) phi211 (by decide +kernel)
private theorem phi1266 : Nat.totient 1266 = 420 := step (p := 2) (m := 633) (by decide +kernel) (by decide) phi633 (by decide +kernel)
private theorem cell633 : Covered 633 634 := singleton (i := 633) (by rw [show 2*633 = 1266 by decide, phi1266]; decide +kernel)
private theorem grid632x634 : Covered 632 634 := pair cell632 cell633
private theorem phi1268 : Nat.totient 1268 = 632 := step (p := 2) (m := 634) (by decide +kernel) (by decide) phi634 (by decide +kernel)
private theorem cell634 : Covered 634 635 := singleton (i := 634) (by rw [show 2*634 = 1268 by decide, phi1268]; decide +kernel)
private theorem phi635 : Nat.totient 635 = 504 := step (p := 5) (m := 127) (by decide +kernel) (by decide) phi127 (by decide +kernel)
private theorem phi1270 : Nat.totient 1270 = 504 := step (p := 2) (m := 635) (by decide +kernel) (by decide) phi635 (by decide +kernel)
private theorem cell635 : Covered 635 636 := singleton (i := 635) (by rw [show 2*635 = 1270 by decide, phi1270]; decide +kernel)
private theorem phi1272 : Nat.totient 1272 = 416 := step (p := 2) (m := 636) (by decide +kernel) (by decide) phi636 (by decide +kernel)
private theorem cell636 : Covered 636 637 := singleton (i := 636) (by rw [show 2*636 = 1272 by decide, phi1272]; decide +kernel)
private theorem grid635x637 : Covered 635 637 := pair cell635 cell636
private theorem grid634x637 : Covered 634 637 := pair cell634 grid635x637
private theorem grid632x637 : Covered 632 637 := pair grid632x634 grid634x637
private theorem grid628x637 : Covered 628 637 := pair grid628x632 grid632x637
private theorem grid619x637 : Covered 619 637 := pair grid619x628 grid628x637
private theorem phi637 : Nat.totient 637 = 504 := step (p := 7) (m := 91) (by decide +kernel) (by decide) phi91 (by decide +kernel)
private theorem phi1274 : Nat.totient 1274 = 504 := step (p := 2) (m := 637) (by decide +kernel) (by decide) phi637 (by decide +kernel)
private theorem cell637 : Covered 637 638 := singleton (i := 637) (by rw [show 2*637 = 1274 by decide, phi1274]; decide +kernel)
private theorem phi1276 : Nat.totient 1276 = 560 := step (p := 2) (m := 638) (by decide +kernel) (by decide) phi638 (by decide +kernel)
private theorem cell638 : Covered 638 639 := singleton (i := 638) (by rw [show 2*638 = 1276 by decide, phi1276]; decide +kernel)
private theorem grid637x639 : Covered 637 639 := pair cell637 cell638
private theorem phi639 : Nat.totient 639 = 420 := step (p := 3) (m := 213) (by decide +kernel) (by decide) phi213 (by decide +kernel)
private theorem phi1278 : Nat.totient 1278 = 420 := step (p := 2) (m := 639) (by decide +kernel) (by decide) phi639 (by decide +kernel)
private theorem cell639 : Covered 639 640 := singleton (i := 639) (by rw [show 2*639 = 1278 by decide, phi1278]; decide +kernel)
private theorem phi1280 : Nat.totient 1280 = 512 := step (p := 2) (m := 640) (by decide +kernel) (by decide) phi640 (by decide +kernel)
private theorem cell640 : Covered 640 641 := singleton (i := 640) (by rw [show 2*640 = 1280 by decide, phi1280]; decide +kernel)
private theorem grid639x641 : Covered 639 641 := pair cell639 cell640
private theorem grid637x641 : Covered 637 641 := pair grid637x639 grid639x641
private theorem phi641 : Nat.totient 641 = 640 := step (p := 641) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1282 : Nat.totient 1282 = 640 := step (p := 2) (m := 641) (by decide +kernel) (by decide) phi641 (by decide +kernel)
private theorem cell641 : Covered 641 642 := singleton (i := 641) (by rw [show 2*641 = 1282 by decide, phi1282]; decide +kernel)
private theorem phi1284 : Nat.totient 1284 = 424 := step (p := 2) (m := 642) (by decide +kernel) (by decide) phi642 (by decide +kernel)
private theorem cell642 : Covered 642 643 := singleton (i := 642) (by rw [show 2*642 = 1284 by decide, phi1284]; decide +kernel)
private theorem grid641x643 : Covered 641 643 := pair cell641 cell642
private theorem phi643 : Nat.totient 643 = 642 := step (p := 643) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1286 : Nat.totient 1286 = 642 := step (p := 2) (m := 643) (by decide +kernel) (by decide) phi643 (by decide +kernel)
private theorem cell643 : Covered 643 644 := singleton (i := 643) (by rw [show 2*643 = 1286 by decide, phi1286]; decide +kernel)
private theorem phi1288 : Nat.totient 1288 = 528 := step (p := 2) (m := 644) (by decide +kernel) (by decide) phi644 (by decide +kernel)
private theorem cell644 : Covered 644 645 := singleton (i := 644) (by rw [show 2*644 = 1288 by decide, phi1288]; decide +kernel)
private theorem phi645 : Nat.totient 645 = 336 := step (p := 3) (m := 215) (by decide +kernel) (by decide) phi215 (by decide +kernel)
private theorem phi1290 : Nat.totient 1290 = 336 := step (p := 2) (m := 645) (by decide +kernel) (by decide) phi645 (by decide +kernel)
private theorem cell645 : Covered 645 646 := singleton (i := 645) (by rw [show 2*645 = 1290 by decide, phi1290]; decide +kernel)
private theorem grid644x646 : Covered 644 646 := pair cell644 cell645
private theorem grid643x646 : Covered 643 646 := pair cell643 grid644x646
private theorem grid641x646 : Covered 641 646 := pair grid641x643 grid643x646
private theorem grid637x646 : Covered 637 646 := pair grid637x641 grid641x646
private theorem phi1292 : Nat.totient 1292 = 576 := step (p := 2) (m := 646) (by decide +kernel) (by decide) phi646 (by decide +kernel)
private theorem cell646 : Covered 646 647 := singleton (i := 646) (by rw [show 2*646 = 1292 by decide, phi1292]; decide +kernel)
private theorem phi647 : Nat.totient 647 = 646 := step (p := 647) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1294 : Nat.totient 1294 = 646 := step (p := 2) (m := 647) (by decide +kernel) (by decide) phi647 (by decide +kernel)
private theorem cell647 : Covered 647 648 := singleton (i := 647) (by rw [show 2*647 = 1294 by decide, phi1294]; decide +kernel)
private theorem grid646x648 : Covered 646 648 := pair cell646 cell647
private theorem phi1296 : Nat.totient 1296 = 432 := step (p := 2) (m := 648) (by decide +kernel) (by decide) phi648 (by decide +kernel)
private theorem cell648 : Covered 648 649 := singleton (i := 648) (by rw [show 2*648 = 1296 by decide, phi1296]; decide +kernel)
private theorem phi649 : Nat.totient 649 = 580 := step (p := 11) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi1298 : Nat.totient 1298 = 580 := step (p := 2) (m := 649) (by decide +kernel) (by decide) phi649 (by decide +kernel)
private theorem cell649 : Covered 649 650 := singleton (i := 649) (by rw [show 2*649 = 1298 by decide, phi1298]; decide +kernel)
private theorem grid648x650 : Covered 648 650 := pair cell648 cell649
private theorem grid646x650 : Covered 646 650 := pair grid646x648 grid648x650
private theorem phi1300 : Nat.totient 1300 = 480 := step (p := 2) (m := 650) (by decide +kernel) (by decide) phi650 (by decide +kernel)
private theorem cell650 : Covered 650 651 := singleton (i := 650) (by rw [show 2*650 = 1300 by decide, phi1300]; decide +kernel)
private theorem phi651 : Nat.totient 651 = 360 := step (p := 3) (m := 217) (by decide +kernel) (by decide) phi217 (by decide +kernel)
private theorem phi1302 : Nat.totient 1302 = 360 := step (p := 2) (m := 651) (by decide +kernel) (by decide) phi651 (by decide +kernel)
private theorem cell651 : Covered 651 652 := singleton (i := 651) (by rw [show 2*651 = 1302 by decide, phi1302]; decide +kernel)
private theorem grid650x652 : Covered 650 652 := pair cell650 cell651
private theorem phi1304 : Nat.totient 1304 = 648 := step (p := 2) (m := 652) (by decide +kernel) (by decide) phi652 (by decide +kernel)
private theorem cell652 : Covered 652 653 := singleton (i := 652) (by rw [show 2*652 = 1304 by decide, phi1304]; decide +kernel)
private theorem phi653 : Nat.totient 653 = 652 := step (p := 653) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1306 : Nat.totient 1306 = 652 := step (p := 2) (m := 653) (by decide +kernel) (by decide) phi653 (by decide +kernel)
private theorem cell653 : Covered 653 654 := singleton (i := 653) (by rw [show 2*653 = 1306 by decide, phi1306]; decide +kernel)
private theorem phi1308 : Nat.totient 1308 = 432 := step (p := 2) (m := 654) (by decide +kernel) (by decide) phi654 (by decide +kernel)
private theorem cell654 : Covered 654 655 := singleton (i := 654) (by rw [show 2*654 = 1308 by decide, phi1308]; decide +kernel)
private theorem grid653x655 : Covered 653 655 := pair cell653 cell654
private theorem grid652x655 : Covered 652 655 := pair cell652 grid653x655
private theorem grid650x655 : Covered 650 655 := pair grid650x652 grid652x655
private theorem grid646x655 : Covered 646 655 := pair grid646x650 grid650x655
private theorem grid637x655 : Covered 637 655 := pair grid637x646 grid646x655
private theorem grid619x655 : Covered 619 655 := pair grid619x637 grid637x655
private theorem grid583x655 : Covered 583 655 := pair grid583x619 grid619x655
private theorem phi655 : Nat.totient 655 = 520 := step (p := 5) (m := 131) (by decide +kernel) (by decide) phi131 (by decide +kernel)
private theorem phi1310 : Nat.totient 1310 = 520 := step (p := 2) (m := 655) (by decide +kernel) (by decide) phi655 (by decide +kernel)
private theorem cell655 : Covered 655 656 := singleton (i := 655) (by rw [show 2*655 = 1310 by decide, phi1310]; decide +kernel)
private theorem phi1312 : Nat.totient 1312 = 640 := step (p := 2) (m := 656) (by decide +kernel) (by decide) phi656 (by decide +kernel)
private theorem cell656 : Covered 656 657 := singleton (i := 656) (by rw [show 2*656 = 1312 by decide, phi1312]; decide +kernel)
private theorem grid655x657 : Covered 655 657 := pair cell655 cell656
private theorem phi657 : Nat.totient 657 = 432 := step (p := 3) (m := 219) (by decide +kernel) (by decide) phi219 (by decide +kernel)
private theorem phi1314 : Nat.totient 1314 = 432 := step (p := 2) (m := 657) (by decide +kernel) (by decide) phi657 (by decide +kernel)
private theorem cell657 : Covered 657 658 := singleton (i := 657) (by rw [show 2*657 = 1314 by decide, phi1314]; decide +kernel)
private theorem phi1316 : Nat.totient 1316 = 552 := step (p := 2) (m := 658) (by decide +kernel) (by decide) phi658 (by decide +kernel)
private theorem cell658 : Covered 658 659 := singleton (i := 658) (by rw [show 2*658 = 1316 by decide, phi1316]; decide +kernel)
private theorem grid657x659 : Covered 657 659 := pair cell657 cell658
private theorem grid655x659 : Covered 655 659 := pair grid655x657 grid657x659
private theorem phi659 : Nat.totient 659 = 658 := step (p := 659) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1318 : Nat.totient 1318 = 658 := step (p := 2) (m := 659) (by decide +kernel) (by decide) phi659 (by decide +kernel)
private theorem cell659 : Covered 659 660 := singleton (i := 659) (by rw [show 2*659 = 1318 by decide, phi1318]; decide +kernel)
private theorem phi1320 : Nat.totient 1320 = 320 := step (p := 2) (m := 660) (by decide +kernel) (by decide) phi660 (by decide +kernel)
private theorem cell660 : Covered 660 661 := singleton (i := 660) (by rw [show 2*660 = 1320 by decide, phi1320]; decide +kernel)
private theorem grid659x661 : Covered 659 661 := pair cell659 cell660
private theorem phi661 : Nat.totient 661 = 660 := step (p := 661) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1322 : Nat.totient 1322 = 660 := step (p := 2) (m := 661) (by decide +kernel) (by decide) phi661 (by decide +kernel)
private theorem cell661 : Covered 661 662 := singleton (i := 661) (by rw [show 2*661 = 1322 by decide, phi1322]; decide +kernel)
private theorem phi1324 : Nat.totient 1324 = 660 := step (p := 2) (m := 662) (by decide +kernel) (by decide) phi662 (by decide +kernel)
private theorem cell662 : Covered 662 663 := singleton (i := 662) (by rw [show 2*662 = 1324 by decide, phi1324]; decide +kernel)
private theorem phi663 : Nat.totient 663 = 384 := step (p := 3) (m := 221) (by decide +kernel) (by decide) phi221 (by decide +kernel)
private theorem phi1326 : Nat.totient 1326 = 384 := step (p := 2) (m := 663) (by decide +kernel) (by decide) phi663 (by decide +kernel)
private theorem cell663 : Covered 663 664 := singleton (i := 663) (by rw [show 2*663 = 1326 by decide, phi1326]; decide +kernel)
private theorem grid662x664 : Covered 662 664 := pair cell662 cell663
private theorem grid661x664 : Covered 661 664 := pair cell661 grid662x664
private theorem grid659x664 : Covered 659 664 := pair grid659x661 grid661x664
private theorem grid655x664 : Covered 655 664 := pair grid655x659 grid659x664
private theorem phi1328 : Nat.totient 1328 = 656 := step (p := 2) (m := 664) (by decide +kernel) (by decide) phi664 (by decide +kernel)
private theorem cell664 : Covered 664 665 := singleton (i := 664) (by rw [show 2*664 = 1328 by decide, phi1328]; decide +kernel)
private theorem phi665 : Nat.totient 665 = 432 := step (p := 5) (m := 133) (by decide +kernel) (by decide) phi133 (by decide +kernel)
private theorem phi1330 : Nat.totient 1330 = 432 := step (p := 2) (m := 665) (by decide +kernel) (by decide) phi665 (by decide +kernel)
private theorem cell665 : Covered 665 666 := singleton (i := 665) (by rw [show 2*665 = 1330 by decide, phi1330]; decide +kernel)
private theorem grid664x666 : Covered 664 666 := pair cell664 cell665
private theorem phi1332 : Nat.totient 1332 = 432 := step (p := 2) (m := 666) (by decide +kernel) (by decide) phi666 (by decide +kernel)
private theorem cell666 : Covered 666 667 := singleton (i := 666) (by rw [show 2*666 = 1332 by decide, phi1332]; decide +kernel)
private theorem phi667 : Nat.totient 667 = 616 := step (p := 23) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi1334 : Nat.totient 1334 = 616 := step (p := 2) (m := 667) (by decide +kernel) (by decide) phi667 (by decide +kernel)
private theorem cell667 : Covered 667 668 := singleton (i := 667) (by rw [show 2*667 = 1334 by decide, phi1334]; decide +kernel)
private theorem grid666x668 : Covered 666 668 := pair cell666 cell667
private theorem grid664x668 : Covered 664 668 := pair grid664x666 grid666x668
private theorem phi1336 : Nat.totient 1336 = 664 := step (p := 2) (m := 668) (by decide +kernel) (by decide) phi668 (by decide +kernel)
private theorem cell668 : Covered 668 669 := singleton (i := 668) (by rw [show 2*668 = 1336 by decide, phi1336]; decide +kernel)
private theorem phi669 : Nat.totient 669 = 444 := step (p := 3) (m := 223) (by decide +kernel) (by decide) phi223 (by decide +kernel)
private theorem phi1338 : Nat.totient 1338 = 444 := step (p := 2) (m := 669) (by decide +kernel) (by decide) phi669 (by decide +kernel)
private theorem cell669 : Covered 669 670 := singleton (i := 669) (by rw [show 2*669 = 1338 by decide, phi1338]; decide +kernel)
private theorem grid668x670 : Covered 668 670 := pair cell668 cell669
private theorem phi1340 : Nat.totient 1340 = 528 := step (p := 2) (m := 670) (by decide +kernel) (by decide) phi670 (by decide +kernel)
private theorem cell670 : Covered 670 671 := singleton (i := 670) (by rw [show 2*670 = 1340 by decide, phi1340]; decide +kernel)
private theorem phi671 : Nat.totient 671 = 600 := step (p := 11) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi1342 : Nat.totient 1342 = 600 := step (p := 2) (m := 671) (by decide +kernel) (by decide) phi671 (by decide +kernel)
private theorem cell671 : Covered 671 672 := singleton (i := 671) (by rw [show 2*671 = 1342 by decide, phi1342]; decide +kernel)
private theorem phi1344 : Nat.totient 1344 = 384 := step (p := 2) (m := 672) (by decide +kernel) (by decide) phi672 (by decide +kernel)
private theorem cell672 : Covered 672 673 := singleton (i := 672) (by rw [show 2*672 = 1344 by decide, phi1344]; decide +kernel)
private theorem grid671x673 : Covered 671 673 := pair cell671 cell672
private theorem grid670x673 : Covered 670 673 := pair cell670 grid671x673
private theorem grid668x673 : Covered 668 673 := pair grid668x670 grid670x673
private theorem grid664x673 : Covered 664 673 := pair grid664x668 grid668x673
private theorem grid655x673 : Covered 655 673 := pair grid655x664 grid664x673
private theorem phi673 : Nat.totient 673 = 672 := step (p := 673) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1346 : Nat.totient 1346 = 672 := step (p := 2) (m := 673) (by decide +kernel) (by decide) phi673 (by decide +kernel)
private theorem cell673 : Covered 673 674 := singleton (i := 673) (by rw [show 2*673 = 1346 by decide, phi1346]; decide +kernel)
private theorem phi1348 : Nat.totient 1348 = 672 := step (p := 2) (m := 674) (by decide +kernel) (by decide) phi674 (by decide +kernel)
private theorem cell674 : Covered 674 675 := singleton (i := 674) (by rw [show 2*674 = 1348 by decide, phi1348]; decide +kernel)
private theorem grid673x675 : Covered 673 675 := pair cell673 cell674
private theorem phi675 : Nat.totient 675 = 360 := step (p := 3) (m := 225) (by decide +kernel) (by decide) phi225 (by decide +kernel)
private theorem phi1350 : Nat.totient 1350 = 360 := step (p := 2) (m := 675) (by decide +kernel) (by decide) phi675 (by decide +kernel)
private theorem cell675 : Covered 675 676 := singleton (i := 675) (by rw [show 2*675 = 1350 by decide, phi1350]; decide +kernel)
private theorem phi1352 : Nat.totient 1352 = 624 := step (p := 2) (m := 676) (by decide +kernel) (by decide) phi676 (by decide +kernel)
private theorem cell676 : Covered 676 677 := singleton (i := 676) (by rw [show 2*676 = 1352 by decide, phi1352]; decide +kernel)
private theorem grid675x677 : Covered 675 677 := pair cell675 cell676
private theorem grid673x677 : Covered 673 677 := pair grid673x675 grid675x677
private theorem phi677 : Nat.totient 677 = 676 := step (p := 677) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1354 : Nat.totient 1354 = 676 := step (p := 2) (m := 677) (by decide +kernel) (by decide) phi677 (by decide +kernel)
private theorem cell677 : Covered 677 678 := singleton (i := 677) (by rw [show 2*677 = 1354 by decide, phi1354]; decide +kernel)
private theorem phi1356 : Nat.totient 1356 = 448 := step (p := 2) (m := 678) (by decide +kernel) (by decide) phi678 (by decide +kernel)
private theorem cell678 : Covered 678 679 := singleton (i := 678) (by rw [show 2*678 = 1356 by decide, phi1356]; decide +kernel)
private theorem grid677x679 : Covered 677 679 := pair cell677 cell678
private theorem phi679 : Nat.totient 679 = 576 := step (p := 7) (m := 97) (by decide +kernel) (by decide) phi97 (by decide +kernel)
private theorem phi1358 : Nat.totient 1358 = 576 := step (p := 2) (m := 679) (by decide +kernel) (by decide) phi679 (by decide +kernel)
private theorem cell679 : Covered 679 680 := singleton (i := 679) (by rw [show 2*679 = 1358 by decide, phi1358]; decide +kernel)
private theorem phi1360 : Nat.totient 1360 = 512 := step (p := 2) (m := 680) (by decide +kernel) (by decide) phi680 (by decide +kernel)
private theorem cell680 : Covered 680 681 := singleton (i := 680) (by rw [show 2*680 = 1360 by decide, phi1360]; decide +kernel)
private theorem phi681 : Nat.totient 681 = 452 := step (p := 3) (m := 227) (by decide +kernel) (by decide) phi227 (by decide +kernel)
private theorem phi1362 : Nat.totient 1362 = 452 := step (p := 2) (m := 681) (by decide +kernel) (by decide) phi681 (by decide +kernel)
private theorem cell681 : Covered 681 682 := singleton (i := 681) (by rw [show 2*681 = 1362 by decide, phi1362]; decide +kernel)
private theorem grid680x682 : Covered 680 682 := pair cell680 cell681
private theorem grid679x682 : Covered 679 682 := pair cell679 grid680x682
private theorem grid677x682 : Covered 677 682 := pair grid677x679 grid679x682
private theorem grid673x682 : Covered 673 682 := pair grid673x677 grid677x682
private theorem phi1364 : Nat.totient 1364 = 600 := step (p := 2) (m := 682) (by decide +kernel) (by decide) phi682 (by decide +kernel)
private theorem cell682 : Covered 682 683 := singleton (i := 682) (by rw [show 2*682 = 1364 by decide, phi1364]; decide +kernel)
private theorem phi683 : Nat.totient 683 = 682 := step (p := 683) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1366 : Nat.totient 1366 = 682 := step (p := 2) (m := 683) (by decide +kernel) (by decide) phi683 (by decide +kernel)
private theorem cell683 : Covered 683 684 := singleton (i := 683) (by rw [show 2*683 = 1366 by decide, phi1366]; decide +kernel)
private theorem grid682x684 : Covered 682 684 := pair cell682 cell683
private theorem phi1368 : Nat.totient 1368 = 432 := step (p := 2) (m := 684) (by decide +kernel) (by decide) phi684 (by decide +kernel)
private theorem cell684 : Covered 684 685 := singleton (i := 684) (by rw [show 2*684 = 1368 by decide, phi1368]; decide +kernel)
private theorem phi685 : Nat.totient 685 = 544 := step (p := 5) (m := 137) (by decide +kernel) (by decide) phi137 (by decide +kernel)
private theorem phi1370 : Nat.totient 1370 = 544 := step (p := 2) (m := 685) (by decide +kernel) (by decide) phi685 (by decide +kernel)
private theorem cell685 : Covered 685 686 := singleton (i := 685) (by rw [show 2*685 = 1370 by decide, phi1370]; decide +kernel)
private theorem grid684x686 : Covered 684 686 := pair cell684 cell685
private theorem grid682x686 : Covered 682 686 := pair grid682x684 grid684x686
private theorem phi1372 : Nat.totient 1372 = 588 := step (p := 2) (m := 686) (by decide +kernel) (by decide) phi686 (by decide +kernel)
private theorem cell686 : Covered 686 687 := singleton (i := 686) (by rw [show 2*686 = 1372 by decide, phi1372]; decide +kernel)
private theorem phi687 : Nat.totient 687 = 456 := step (p := 3) (m := 229) (by decide +kernel) (by decide) phi229 (by decide +kernel)
private theorem phi1374 : Nat.totient 1374 = 456 := step (p := 2) (m := 687) (by decide +kernel) (by decide) phi687 (by decide +kernel)
private theorem cell687 : Covered 687 688 := singleton (i := 687) (by rw [show 2*687 = 1374 by decide, phi1374]; decide +kernel)
private theorem grid686x688 : Covered 686 688 := pair cell686 cell687
private theorem phi1376 : Nat.totient 1376 = 672 := step (p := 2) (m := 688) (by decide +kernel) (by decide) phi688 (by decide +kernel)
private theorem cell688 : Covered 688 689 := singleton (i := 688) (by rw [show 2*688 = 1376 by decide, phi1376]; decide +kernel)
private theorem phi689 : Nat.totient 689 = 624 := step (p := 13) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi1378 : Nat.totient 1378 = 624 := step (p := 2) (m := 689) (by decide +kernel) (by decide) phi689 (by decide +kernel)
private theorem cell689 : Covered 689 690 := singleton (i := 689) (by rw [show 2*689 = 1378 by decide, phi1378]; decide +kernel)
private theorem phi1380 : Nat.totient 1380 = 352 := step (p := 2) (m := 690) (by decide +kernel) (by decide) phi690 (by decide +kernel)
private theorem cell690 : Covered 690 691 := singleton (i := 690) (by rw [show 2*690 = 1380 by decide, phi1380]; decide +kernel)
private theorem grid689x691 : Covered 689 691 := pair cell689 cell690
private theorem grid688x691 : Covered 688 691 := pair cell688 grid689x691
private theorem grid686x691 : Covered 686 691 := pair grid686x688 grid688x691
private theorem grid682x691 : Covered 682 691 := pair grid682x686 grid686x691
private theorem grid673x691 : Covered 673 691 := pair grid673x682 grid682x691
private theorem grid655x691 : Covered 655 691 := pair grid655x673 grid673x691
private theorem phi691 : Nat.totient 691 = 690 := step (p := 691) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1382 : Nat.totient 1382 = 690 := step (p := 2) (m := 691) (by decide +kernel) (by decide) phi691 (by decide +kernel)
private theorem cell691 : Covered 691 692 := singleton (i := 691) (by rw [show 2*691 = 1382 by decide, phi1382]; decide +kernel)
private theorem phi1384 : Nat.totient 1384 = 688 := step (p := 2) (m := 692) (by decide +kernel) (by decide) phi692 (by decide +kernel)
private theorem cell692 : Covered 692 693 := singleton (i := 692) (by rw [show 2*692 = 1384 by decide, phi1384]; decide +kernel)
private theorem grid691x693 : Covered 691 693 := pair cell691 cell692
private theorem phi693 : Nat.totient 693 = 360 := step (p := 3) (m := 231) (by decide +kernel) (by decide) phi231 (by decide +kernel)
private theorem phi1386 : Nat.totient 1386 = 360 := step (p := 2) (m := 693) (by decide +kernel) (by decide) phi693 (by decide +kernel)
private theorem cell693 : Covered 693 694 := singleton (i := 693) (by rw [show 2*693 = 1386 by decide, phi1386]; decide +kernel)
private theorem phi1388 : Nat.totient 1388 = 692 := step (p := 2) (m := 694) (by decide +kernel) (by decide) phi694 (by decide +kernel)
private theorem cell694 : Covered 694 695 := singleton (i := 694) (by rw [show 2*694 = 1388 by decide, phi1388]; decide +kernel)
private theorem grid693x695 : Covered 693 695 := pair cell693 cell694
private theorem grid691x695 : Covered 691 695 := pair grid691x693 grid693x695
private theorem phi695 : Nat.totient 695 = 552 := step (p := 5) (m := 139) (by decide +kernel) (by decide) phi139 (by decide +kernel)
private theorem phi1390 : Nat.totient 1390 = 552 := step (p := 2) (m := 695) (by decide +kernel) (by decide) phi695 (by decide +kernel)
private theorem cell695 : Covered 695 696 := singleton (i := 695) (by rw [show 2*695 = 1390 by decide, phi1390]; decide +kernel)
private theorem phi1392 : Nat.totient 1392 = 448 := step (p := 2) (m := 696) (by decide +kernel) (by decide) phi696 (by decide +kernel)
private theorem cell696 : Covered 696 697 := singleton (i := 696) (by rw [show 2*696 = 1392 by decide, phi1392]; decide +kernel)
private theorem grid695x697 : Covered 695 697 := pair cell695 cell696
private theorem phi697 : Nat.totient 697 = 640 := step (p := 17) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi1394 : Nat.totient 1394 = 640 := step (p := 2) (m := 697) (by decide +kernel) (by decide) phi697 (by decide +kernel)
private theorem cell697 : Covered 697 698 := singleton (i := 697) (by rw [show 2*697 = 1394 by decide, phi1394]; decide +kernel)
private theorem phi1396 : Nat.totient 1396 = 696 := step (p := 2) (m := 698) (by decide +kernel) (by decide) phi698 (by decide +kernel)
private theorem cell698 : Covered 698 699 := singleton (i := 698) (by rw [show 2*698 = 1396 by decide, phi1396]; decide +kernel)
private theorem phi699 : Nat.totient 699 = 464 := step (p := 3) (m := 233) (by decide +kernel) (by decide) phi233 (by decide +kernel)
private theorem phi1398 : Nat.totient 1398 = 464 := step (p := 2) (m := 699) (by decide +kernel) (by decide) phi699 (by decide +kernel)
private theorem cell699 : Covered 699 700 := singleton (i := 699) (by rw [show 2*699 = 1398 by decide, phi1398]; decide +kernel)
private theorem grid698x700 : Covered 698 700 := pair cell698 cell699
private theorem grid697x700 : Covered 697 700 := pair cell697 grid698x700
private theorem grid695x700 : Covered 695 700 := pair grid695x697 grid697x700
private theorem grid691x700 : Covered 691 700 := pair grid691x695 grid695x700
private theorem phi1400 : Nat.totient 1400 = 480 := step (p := 2) (m := 700) (by decide +kernel) (by decide) phi700 (by decide +kernel)
private theorem cell700 : Covered 700 701 := singleton (i := 700) (by rw [show 2*700 = 1400 by decide, phi1400]; decide +kernel)
private theorem phi701 : Nat.totient 701 = 700 := step (p := 701) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1402 : Nat.totient 1402 = 700 := step (p := 2) (m := 701) (by decide +kernel) (by decide) phi701 (by decide +kernel)
private theorem cell701 : Covered 701 702 := singleton (i := 701) (by rw [show 2*701 = 1402 by decide, phi1402]; decide +kernel)
private theorem grid700x702 : Covered 700 702 := pair cell700 cell701
private theorem phi1404 : Nat.totient 1404 = 432 := step (p := 2) (m := 702) (by decide +kernel) (by decide) phi702 (by decide +kernel)
private theorem cell702 : Covered 702 703 := singleton (i := 702) (by rw [show 2*702 = 1404 by decide, phi1404]; decide +kernel)
private theorem phi703 : Nat.totient 703 = 648 := step (p := 19) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi1406 : Nat.totient 1406 = 648 := step (p := 2) (m := 703) (by decide +kernel) (by decide) phi703 (by decide +kernel)
private theorem cell703 : Covered 703 704 := singleton (i := 703) (by rw [show 2*703 = 1406 by decide, phi1406]; decide +kernel)
private theorem grid702x704 : Covered 702 704 := pair cell702 cell703
private theorem grid700x704 : Covered 700 704 := pair grid700x702 grid702x704
private theorem phi1408 : Nat.totient 1408 = 640 := step (p := 2) (m := 704) (by decide +kernel) (by decide) phi704 (by decide +kernel)
private theorem cell704 : Covered 704 705 := singleton (i := 704) (by rw [show 2*704 = 1408 by decide, phi1408]; decide +kernel)
private theorem phi705 : Nat.totient 705 = 368 := step (p := 3) (m := 235) (by decide +kernel) (by decide) phi235 (by decide +kernel)
private theorem phi1410 : Nat.totient 1410 = 368 := step (p := 2) (m := 705) (by decide +kernel) (by decide) phi705 (by decide +kernel)
private theorem cell705 : Covered 705 706 := singleton (i := 705) (by rw [show 2*705 = 1410 by decide, phi1410]; decide +kernel)
private theorem grid704x706 : Covered 704 706 := pair cell704 cell705
private theorem phi1412 : Nat.totient 1412 = 704 := step (p := 2) (m := 706) (by decide +kernel) (by decide) phi706 (by decide +kernel)
private theorem cell706 : Covered 706 707 := singleton (i := 706) (by rw [show 2*706 = 1412 by decide, phi1412]; decide +kernel)
private theorem phi707 : Nat.totient 707 = 600 := step (p := 7) (m := 101) (by decide +kernel) (by decide) phi101 (by decide +kernel)
private theorem phi1414 : Nat.totient 1414 = 600 := step (p := 2) (m := 707) (by decide +kernel) (by decide) phi707 (by decide +kernel)
private theorem cell707 : Covered 707 708 := singleton (i := 707) (by rw [show 2*707 = 1414 by decide, phi1414]; decide +kernel)
private theorem phi1416 : Nat.totient 1416 = 464 := step (p := 2) (m := 708) (by decide +kernel) (by decide) phi708 (by decide +kernel)
private theorem cell708 : Covered 708 709 := singleton (i := 708) (by rw [show 2*708 = 1416 by decide, phi1416]; decide +kernel)
private theorem grid707x709 : Covered 707 709 := pair cell707 cell708
private theorem grid706x709 : Covered 706 709 := pair cell706 grid707x709
private theorem grid704x709 : Covered 704 709 := pair grid704x706 grid706x709
private theorem grid700x709 : Covered 700 709 := pair grid700x704 grid704x709
private theorem grid691x709 : Covered 691 709 := pair grid691x700 grid700x709
private theorem phi709 : Nat.totient 709 = 708 := step (p := 709) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1418 : Nat.totient 1418 = 708 := step (p := 2) (m := 709) (by decide +kernel) (by decide) phi709 (by decide +kernel)
private theorem cell709 : Covered 709 710 := singleton (i := 709) (by rw [show 2*709 = 1418 by decide, phi1418]; decide +kernel)
private theorem phi1420 : Nat.totient 1420 = 560 := step (p := 2) (m := 710) (by decide +kernel) (by decide) phi710 (by decide +kernel)
private theorem cell710 : Covered 710 711 := singleton (i := 710) (by rw [show 2*710 = 1420 by decide, phi1420]; decide +kernel)
private theorem grid709x711 : Covered 709 711 := pair cell709 cell710
private theorem phi711 : Nat.totient 711 = 468 := step (p := 3) (m := 237) (by decide +kernel) (by decide) phi237 (by decide +kernel)
private theorem phi1422 : Nat.totient 1422 = 468 := step (p := 2) (m := 711) (by decide +kernel) (by decide) phi711 (by decide +kernel)
private theorem cell711 : Covered 711 712 := singleton (i := 711) (by rw [show 2*711 = 1422 by decide, phi1422]; decide +kernel)
private theorem phi1424 : Nat.totient 1424 = 704 := step (p := 2) (m := 712) (by decide +kernel) (by decide) phi712 (by decide +kernel)
private theorem cell712 : Covered 712 713 := singleton (i := 712) (by rw [show 2*712 = 1424 by decide, phi1424]; decide +kernel)
private theorem grid711x713 : Covered 711 713 := pair cell711 cell712
private theorem grid709x713 : Covered 709 713 := pair grid709x711 grid711x713
private theorem phi713 : Nat.totient 713 = 660 := step (p := 23) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi1426 : Nat.totient 1426 = 660 := step (p := 2) (m := 713) (by decide +kernel) (by decide) phi713 (by decide +kernel)
private theorem cell713 : Covered 713 714 := singleton (i := 713) (by rw [show 2*713 = 1426 by decide, phi1426]; decide +kernel)
private theorem phi1428 : Nat.totient 1428 = 384 := step (p := 2) (m := 714) (by decide +kernel) (by decide) phi714 (by decide +kernel)
private theorem cell714 : Covered 714 715 := singleton (i := 714) (by rw [show 2*714 = 1428 by decide, phi1428]; decide +kernel)
private theorem grid713x715 : Covered 713 715 := pair cell713 cell714
private theorem phi715 : Nat.totient 715 = 480 := step (p := 5) (m := 143) (by decide +kernel) (by decide) phi143 (by decide +kernel)
private theorem phi1430 : Nat.totient 1430 = 480 := step (p := 2) (m := 715) (by decide +kernel) (by decide) phi715 (by decide +kernel)
private theorem cell715 : Covered 715 716 := singleton (i := 715) (by rw [show 2*715 = 1430 by decide, phi1430]; decide +kernel)
private theorem phi1432 : Nat.totient 1432 = 712 := step (p := 2) (m := 716) (by decide +kernel) (by decide) phi716 (by decide +kernel)
private theorem cell716 : Covered 716 717 := singleton (i := 716) (by rw [show 2*716 = 1432 by decide, phi1432]; decide +kernel)
private theorem phi717 : Nat.totient 717 = 476 := step (p := 3) (m := 239) (by decide +kernel) (by decide) phi239 (by decide +kernel)
private theorem phi1434 : Nat.totient 1434 = 476 := step (p := 2) (m := 717) (by decide +kernel) (by decide) phi717 (by decide +kernel)
private theorem cell717 : Covered 717 718 := singleton (i := 717) (by rw [show 2*717 = 1434 by decide, phi1434]; decide +kernel)
private theorem grid716x718 : Covered 716 718 := pair cell716 cell717
private theorem grid715x718 : Covered 715 718 := pair cell715 grid716x718
private theorem grid713x718 : Covered 713 718 := pair grid713x715 grid715x718
private theorem grid709x718 : Covered 709 718 := pair grid709x713 grid713x718
private theorem phi1436 : Nat.totient 1436 = 716 := step (p := 2) (m := 718) (by decide +kernel) (by decide) phi718 (by decide +kernel)
private theorem cell718 : Covered 718 719 := singleton (i := 718) (by rw [show 2*718 = 1436 by decide, phi1436]; decide +kernel)
private theorem phi719 : Nat.totient 719 = 718 := step (p := 719) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1438 : Nat.totient 1438 = 718 := step (p := 2) (m := 719) (by decide +kernel) (by decide) phi719 (by decide +kernel)
private theorem cell719 : Covered 719 720 := singleton (i := 719) (by rw [show 2*719 = 1438 by decide, phi1438]; decide +kernel)
private theorem grid718x720 : Covered 718 720 := pair cell718 cell719
private theorem phi1440 : Nat.totient 1440 = 384 := step (p := 2) (m := 720) (by decide +kernel) (by decide) phi720 (by decide +kernel)
private theorem cell720 : Covered 720 721 := singleton (i := 720) (by rw [show 2*720 = 1440 by decide, phi1440]; decide +kernel)
private theorem phi721 : Nat.totient 721 = 612 := step (p := 7) (m := 103) (by decide +kernel) (by decide) phi103 (by decide +kernel)
private theorem phi1442 : Nat.totient 1442 = 612 := step (p := 2) (m := 721) (by decide +kernel) (by decide) phi721 (by decide +kernel)
private theorem cell721 : Covered 721 722 := singleton (i := 721) (by rw [show 2*721 = 1442 by decide, phi1442]; decide +kernel)
private theorem phi1444 : Nat.totient 1444 = 684 := step (p := 2) (m := 722) (by decide +kernel) (by decide) phi722 (by decide +kernel)
private theorem cell722 : Covered 722 723 := singleton (i := 722) (by rw [show 2*722 = 1444 by decide, phi1444]; decide +kernel)
private theorem grid721x723 : Covered 721 723 := pair cell721 cell722
private theorem grid720x723 : Covered 720 723 := pair cell720 grid721x723
private theorem grid718x723 : Covered 718 723 := pair grid718x720 grid720x723
private theorem phi723 : Nat.totient 723 = 480 := step (p := 3) (m := 241) (by decide +kernel) (by decide) phi241 (by decide +kernel)
private theorem phi1446 : Nat.totient 1446 = 480 := step (p := 2) (m := 723) (by decide +kernel) (by decide) phi723 (by decide +kernel)
private theorem cell723 : Covered 723 724 := singleton (i := 723) (by rw [show 2*723 = 1446 by decide, phi1446]; decide +kernel)
private theorem phi1448 : Nat.totient 1448 = 720 := step (p := 2) (m := 724) (by decide +kernel) (by decide) phi724 (by decide +kernel)
private theorem cell724 : Covered 724 725 := singleton (i := 724) (by rw [show 2*724 = 1448 by decide, phi1448]; decide +kernel)
private theorem grid723x725 : Covered 723 725 := pair cell723 cell724
private theorem phi725 : Nat.totient 725 = 560 := step (p := 5) (m := 145) (by decide +kernel) (by decide) phi145 (by decide +kernel)
private theorem phi1450 : Nat.totient 1450 = 560 := step (p := 2) (m := 725) (by decide +kernel) (by decide) phi725 (by decide +kernel)
private theorem cell725 : Covered 725 726 := singleton (i := 725) (by rw [show 2*725 = 1450 by decide, phi1450]; decide +kernel)
private theorem phi1452 : Nat.totient 1452 = 440 := step (p := 2) (m := 726) (by decide +kernel) (by decide) phi726 (by decide +kernel)
private theorem cell726 : Covered 726 727 := singleton (i := 726) (by rw [show 2*726 = 1452 by decide, phi1452]; decide +kernel)
private theorem phi727 : Nat.totient 727 = 726 := step (p := 727) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1454 : Nat.totient 1454 = 726 := step (p := 2) (m := 727) (by decide +kernel) (by decide) phi727 (by decide +kernel)
private theorem cell727 : Covered 727 728 := singleton (i := 727) (by rw [show 2*727 = 1454 by decide, phi1454]; decide +kernel)
private theorem grid726x728 : Covered 726 728 := pair cell726 cell727
private theorem grid725x728 : Covered 725 728 := pair cell725 grid726x728
private theorem grid723x728 : Covered 723 728 := pair grid723x725 grid725x728
private theorem grid718x728 : Covered 718 728 := pair grid718x723 grid723x728
private theorem grid709x728 : Covered 709 728 := pair grid709x718 grid718x728
private theorem grid691x728 : Covered 691 728 := pair grid691x709 grid709x728
private theorem grid655x728 : Covered 655 728 := pair grid655x691 grid691x728
private theorem grid583x728 : Covered 583 728 := pair grid583x655 grid655x728
private theorem phi1456 : Nat.totient 1456 = 576 := step (p := 2) (m := 728) (by decide +kernel) (by decide) phi728 (by decide +kernel)
private theorem cell728 : Covered 728 729 := singleton (i := 728) (by rw [show 2*728 = 1456 by decide, phi1456]; decide +kernel)
private theorem phi729 : Nat.totient 729 = 486 := step (p := 3) (m := 243) (by decide +kernel) (by decide) phi243 (by decide +kernel)
private theorem phi1458 : Nat.totient 1458 = 486 := step (p := 2) (m := 729) (by decide +kernel) (by decide) phi729 (by decide +kernel)
private theorem cell729 : Covered 729 730 := singleton (i := 729) (by rw [show 2*729 = 1458 by decide, phi1458]; decide +kernel)
private theorem grid728x730 : Covered 728 730 := pair cell728 cell729
private theorem phi1460 : Nat.totient 1460 = 576 := step (p := 2) (m := 730) (by decide +kernel) (by decide) phi730 (by decide +kernel)
private theorem cell730 : Covered 730 731 := singleton (i := 730) (by rw [show 2*730 = 1460 by decide, phi1460]; decide +kernel)
private theorem phi731 : Nat.totient 731 = 672 := step (p := 17) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi1462 : Nat.totient 1462 = 672 := step (p := 2) (m := 731) (by decide +kernel) (by decide) phi731 (by decide +kernel)
private theorem cell731 : Covered 731 732 := singleton (i := 731) (by rw [show 2*731 = 1462 by decide, phi1462]; decide +kernel)
private theorem grid730x732 : Covered 730 732 := pair cell730 cell731
private theorem grid728x732 : Covered 728 732 := pair grid728x730 grid730x732
private theorem phi1464 : Nat.totient 1464 = 480 := step (p := 2) (m := 732) (by decide +kernel) (by decide) phi732 (by decide +kernel)
private theorem cell732 : Covered 732 733 := singleton (i := 732) (by rw [show 2*732 = 1464 by decide, phi1464]; decide +kernel)
private theorem phi733 : Nat.totient 733 = 732 := step (p := 733) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1466 : Nat.totient 1466 = 732 := step (p := 2) (m := 733) (by decide +kernel) (by decide) phi733 (by decide +kernel)
private theorem cell733 : Covered 733 734 := singleton (i := 733) (by rw [show 2*733 = 1466 by decide, phi1466]; decide +kernel)
private theorem grid732x734 : Covered 732 734 := pair cell732 cell733
private theorem phi1468 : Nat.totient 1468 = 732 := step (p := 2) (m := 734) (by decide +kernel) (by decide) phi734 (by decide +kernel)
private theorem cell734 : Covered 734 735 := singleton (i := 734) (by rw [show 2*734 = 1468 by decide, phi1468]; decide +kernel)
private theorem phi735 : Nat.totient 735 = 336 := step (p := 3) (m := 245) (by decide +kernel) (by decide) phi245 (by decide +kernel)
private theorem phi1470 : Nat.totient 1470 = 336 := step (p := 2) (m := 735) (by decide +kernel) (by decide) phi735 (by decide +kernel)
private theorem cell735 : Covered 735 736 := singleton (i := 735) (by rw [show 2*735 = 1470 by decide, phi1470]; decide +kernel)
private theorem phi1472 : Nat.totient 1472 = 704 := step (p := 2) (m := 736) (by decide +kernel) (by decide) phi736 (by decide +kernel)
private theorem cell736 : Covered 736 737 := singleton (i := 736) (by rw [show 2*736 = 1472 by decide, phi1472]; decide +kernel)
private theorem grid735x737 : Covered 735 737 := pair cell735 cell736
private theorem grid734x737 : Covered 734 737 := pair cell734 grid735x737
private theorem grid732x737 : Covered 732 737 := pair grid732x734 grid734x737
private theorem grid728x737 : Covered 728 737 := pair grid728x732 grid732x737
private theorem phi737 : Nat.totient 737 = 660 := step (p := 11) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi1474 : Nat.totient 1474 = 660 := step (p := 2) (m := 737) (by decide +kernel) (by decide) phi737 (by decide +kernel)
private theorem cell737 : Covered 737 738 := singleton (i := 737) (by rw [show 2*737 = 1474 by decide, phi1474]; decide +kernel)
private theorem phi1476 : Nat.totient 1476 = 480 := step (p := 2) (m := 738) (by decide +kernel) (by decide) phi738 (by decide +kernel)
private theorem cell738 : Covered 738 739 := singleton (i := 738) (by rw [show 2*738 = 1476 by decide, phi1476]; decide +kernel)
private theorem grid737x739 : Covered 737 739 := pair cell737 cell738
private theorem phi739 : Nat.totient 739 = 738 := step (p := 739) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1478 : Nat.totient 1478 = 738 := step (p := 2) (m := 739) (by decide +kernel) (by decide) phi739 (by decide +kernel)
private theorem cell739 : Covered 739 740 := singleton (i := 739) (by rw [show 2*739 = 1478 by decide, phi1478]; decide +kernel)
private theorem phi1480 : Nat.totient 1480 = 576 := step (p := 2) (m := 740) (by decide +kernel) (by decide) phi740 (by decide +kernel)
private theorem cell740 : Covered 740 741 := singleton (i := 740) (by rw [show 2*740 = 1480 by decide, phi1480]; decide +kernel)
private theorem grid739x741 : Covered 739 741 := pair cell739 cell740
private theorem grid737x741 : Covered 737 741 := pair grid737x739 grid739x741
private theorem phi741 : Nat.totient 741 = 432 := step (p := 3) (m := 247) (by decide +kernel) (by decide) phi247 (by decide +kernel)
private theorem phi1482 : Nat.totient 1482 = 432 := step (p := 2) (m := 741) (by decide +kernel) (by decide) phi741 (by decide +kernel)
private theorem cell741 : Covered 741 742 := singleton (i := 741) (by rw [show 2*741 = 1482 by decide, phi1482]; decide +kernel)
private theorem phi1484 : Nat.totient 1484 = 624 := step (p := 2) (m := 742) (by decide +kernel) (by decide) phi742 (by decide +kernel)
private theorem cell742 : Covered 742 743 := singleton (i := 742) (by rw [show 2*742 = 1484 by decide, phi1484]; decide +kernel)
private theorem grid741x743 : Covered 741 743 := pair cell741 cell742
private theorem phi743 : Nat.totient 743 = 742 := step (p := 743) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1486 : Nat.totient 1486 = 742 := step (p := 2) (m := 743) (by decide +kernel) (by decide) phi743 (by decide +kernel)
private theorem cell743 : Covered 743 744 := singleton (i := 743) (by rw [show 2*743 = 1486 by decide, phi1486]; decide +kernel)
private theorem phi1488 : Nat.totient 1488 = 480 := step (p := 2) (m := 744) (by decide +kernel) (by decide) phi744 (by decide +kernel)
private theorem cell744 : Covered 744 745 := singleton (i := 744) (by rw [show 2*744 = 1488 by decide, phi1488]; decide +kernel)
private theorem phi745 : Nat.totient 745 = 592 := step (p := 5) (m := 149) (by decide +kernel) (by decide) phi149 (by decide +kernel)
private theorem phi1490 : Nat.totient 1490 = 592 := step (p := 2) (m := 745) (by decide +kernel) (by decide) phi745 (by decide +kernel)
private theorem cell745 : Covered 745 746 := singleton (i := 745) (by rw [show 2*745 = 1490 by decide, phi1490]; decide +kernel)
private theorem grid744x746 : Covered 744 746 := pair cell744 cell745
private theorem grid743x746 : Covered 743 746 := pair cell743 grid744x746
private theorem grid741x746 : Covered 741 746 := pair grid741x743 grid743x746
private theorem grid737x746 : Covered 737 746 := pair grid737x741 grid741x746
private theorem grid728x746 : Covered 728 746 := pair grid728x737 grid737x746
private theorem phi1492 : Nat.totient 1492 = 744 := step (p := 2) (m := 746) (by decide +kernel) (by decide) phi746 (by decide +kernel)
private theorem cell746 : Covered 746 747 := singleton (i := 746) (by rw [show 2*746 = 1492 by decide, phi1492]; decide +kernel)
private theorem phi747 : Nat.totient 747 = 492 := step (p := 3) (m := 249) (by decide +kernel) (by decide) phi249 (by decide +kernel)
private theorem phi1494 : Nat.totient 1494 = 492 := step (p := 2) (m := 747) (by decide +kernel) (by decide) phi747 (by decide +kernel)
private theorem cell747 : Covered 747 748 := singleton (i := 747) (by rw [show 2*747 = 1494 by decide, phi1494]; decide +kernel)
private theorem grid746x748 : Covered 746 748 := pair cell746 cell747
private theorem phi1496 : Nat.totient 1496 = 640 := step (p := 2) (m := 748) (by decide +kernel) (by decide) phi748 (by decide +kernel)
private theorem cell748 : Covered 748 749 := singleton (i := 748) (by rw [show 2*748 = 1496 by decide, phi1496]; decide +kernel)
private theorem phi749 : Nat.totient 749 = 636 := step (p := 7) (m := 107) (by decide +kernel) (by decide) phi107 (by decide +kernel)
private theorem phi1498 : Nat.totient 1498 = 636 := step (p := 2) (m := 749) (by decide +kernel) (by decide) phi749 (by decide +kernel)
private theorem cell749 : Covered 749 750 := singleton (i := 749) (by rw [show 2*749 = 1498 by decide, phi1498]; decide +kernel)
private theorem grid748x750 : Covered 748 750 := pair cell748 cell749
private theorem grid746x750 : Covered 746 750 := pair grid746x748 grid748x750
private theorem phi1500 : Nat.totient 1500 = 400 := step (p := 2) (m := 750) (by decide +kernel) (by decide) phi750 (by decide +kernel)
private theorem cell750 : Covered 750 751 := singleton (i := 750) (by rw [show 2*750 = 1500 by decide, phi1500]; decide +kernel)
private theorem phi751 : Nat.totient 751 = 750 := step (p := 751) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1502 : Nat.totient 1502 = 750 := step (p := 2) (m := 751) (by decide +kernel) (by decide) phi751 (by decide +kernel)
private theorem cell751 : Covered 751 752 := singleton (i := 751) (by rw [show 2*751 = 1502 by decide, phi1502]; decide +kernel)
private theorem grid750x752 : Covered 750 752 := pair cell750 cell751
private theorem phi1504 : Nat.totient 1504 = 736 := step (p := 2) (m := 752) (by decide +kernel) (by decide) phi752 (by decide +kernel)
private theorem cell752 : Covered 752 753 := singleton (i := 752) (by rw [show 2*752 = 1504 by decide, phi1504]; decide +kernel)
private theorem phi753 : Nat.totient 753 = 500 := step (p := 3) (m := 251) (by decide +kernel) (by decide) phi251 (by decide +kernel)
private theorem phi1506 : Nat.totient 1506 = 500 := step (p := 2) (m := 753) (by decide +kernel) (by decide) phi753 (by decide +kernel)
private theorem cell753 : Covered 753 754 := singleton (i := 753) (by rw [show 2*753 = 1506 by decide, phi1506]; decide +kernel)
private theorem phi1508 : Nat.totient 1508 = 672 := step (p := 2) (m := 754) (by decide +kernel) (by decide) phi754 (by decide +kernel)
private theorem cell754 : Covered 754 755 := singleton (i := 754) (by rw [show 2*754 = 1508 by decide, phi1508]; decide +kernel)
private theorem grid753x755 : Covered 753 755 := pair cell753 cell754
private theorem grid752x755 : Covered 752 755 := pair cell752 grid753x755
private theorem grid750x755 : Covered 750 755 := pair grid750x752 grid752x755
private theorem grid746x755 : Covered 746 755 := pair grid746x750 grid750x755
private theorem phi755 : Nat.totient 755 = 600 := step (p := 5) (m := 151) (by decide +kernel) (by decide) phi151 (by decide +kernel)
private theorem phi1510 : Nat.totient 1510 = 600 := step (p := 2) (m := 755) (by decide +kernel) (by decide) phi755 (by decide +kernel)
private theorem cell755 : Covered 755 756 := singleton (i := 755) (by rw [show 2*755 = 1510 by decide, phi1510]; decide +kernel)
private theorem phi1512 : Nat.totient 1512 = 432 := step (p := 2) (m := 756) (by decide +kernel) (by decide) phi756 (by decide +kernel)
private theorem cell756 : Covered 756 757 := singleton (i := 756) (by rw [show 2*756 = 1512 by decide, phi1512]; decide +kernel)
private theorem grid755x757 : Covered 755 757 := pair cell755 cell756
private theorem phi757 : Nat.totient 757 = 756 := step (p := 757) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1514 : Nat.totient 1514 = 756 := step (p := 2) (m := 757) (by decide +kernel) (by decide) phi757 (by decide +kernel)
private theorem cell757 : Covered 757 758 := singleton (i := 757) (by rw [show 2*757 = 1514 by decide, phi1514]; decide +kernel)
private theorem phi1516 : Nat.totient 1516 = 756 := step (p := 2) (m := 758) (by decide +kernel) (by decide) phi758 (by decide +kernel)
private theorem cell758 : Covered 758 759 := singleton (i := 758) (by rw [show 2*758 = 1516 by decide, phi1516]; decide +kernel)
private theorem grid757x759 : Covered 757 759 := pair cell757 cell758
private theorem grid755x759 : Covered 755 759 := pair grid755x757 grid757x759
private theorem phi759 : Nat.totient 759 = 440 := step (p := 3) (m := 253) (by decide +kernel) (by decide) phi253 (by decide +kernel)
private theorem phi1518 : Nat.totient 1518 = 440 := step (p := 2) (m := 759) (by decide +kernel) (by decide) phi759 (by decide +kernel)
private theorem cell759 : Covered 759 760 := singleton (i := 759) (by rw [show 2*759 = 1518 by decide, phi1518]; decide +kernel)
private theorem phi1520 : Nat.totient 1520 = 576 := step (p := 2) (m := 760) (by decide +kernel) (by decide) phi760 (by decide +kernel)
private theorem cell760 : Covered 760 761 := singleton (i := 760) (by rw [show 2*760 = 1520 by decide, phi1520]; decide +kernel)
private theorem grid759x761 : Covered 759 761 := pair cell759 cell760
private theorem phi761 : Nat.totient 761 = 760 := step (p := 761) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1522 : Nat.totient 1522 = 760 := step (p := 2) (m := 761) (by decide +kernel) (by decide) phi761 (by decide +kernel)
private theorem cell761 : Covered 761 762 := singleton (i := 761) (by rw [show 2*761 = 1522 by decide, phi1522]; decide +kernel)
private theorem phi1524 : Nat.totient 1524 = 504 := step (p := 2) (m := 762) (by decide +kernel) (by decide) phi762 (by decide +kernel)
private theorem cell762 : Covered 762 763 := singleton (i := 762) (by rw [show 2*762 = 1524 by decide, phi1524]; decide +kernel)
private theorem phi763 : Nat.totient 763 = 648 := step (p := 7) (m := 109) (by decide +kernel) (by decide) phi109 (by decide +kernel)
private theorem phi1526 : Nat.totient 1526 = 648 := step (p := 2) (m := 763) (by decide +kernel) (by decide) phi763 (by decide +kernel)
private theorem cell763 : Covered 763 764 := singleton (i := 763) (by rw [show 2*763 = 1526 by decide, phi1526]; decide +kernel)
private theorem grid762x764 : Covered 762 764 := pair cell762 cell763
private theorem grid761x764 : Covered 761 764 := pair cell761 grid762x764
private theorem grid759x764 : Covered 759 764 := pair grid759x761 grid761x764
private theorem grid755x764 : Covered 755 764 := pair grid755x759 grid759x764
private theorem grid746x764 : Covered 746 764 := pair grid746x755 grid755x764
private theorem grid728x764 : Covered 728 764 := pair grid728x746 grid746x764
private theorem phi1528 : Nat.totient 1528 = 760 := step (p := 2) (m := 764) (by decide +kernel) (by decide) phi764 (by decide +kernel)
private theorem cell764 : Covered 764 765 := singleton (i := 764) (by rw [show 2*764 = 1528 by decide, phi1528]; decide +kernel)
private theorem phi765 : Nat.totient 765 = 384 := step (p := 3) (m := 255) (by decide +kernel) (by decide) phi255 (by decide +kernel)
private theorem phi1530 : Nat.totient 1530 = 384 := step (p := 2) (m := 765) (by decide +kernel) (by decide) phi765 (by decide +kernel)
private theorem cell765 : Covered 765 766 := singleton (i := 765) (by rw [show 2*765 = 1530 by decide, phi1530]; decide +kernel)
private theorem grid764x766 : Covered 764 766 := pair cell764 cell765
private theorem phi1532 : Nat.totient 1532 = 764 := step (p := 2) (m := 766) (by decide +kernel) (by decide) phi766 (by decide +kernel)
private theorem cell766 : Covered 766 767 := singleton (i := 766) (by rw [show 2*766 = 1532 by decide, phi1532]; decide +kernel)
private theorem phi767 : Nat.totient 767 = 696 := step (p := 13) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi1534 : Nat.totient 1534 = 696 := step (p := 2) (m := 767) (by decide +kernel) (by decide) phi767 (by decide +kernel)
private theorem cell767 : Covered 767 768 := singleton (i := 767) (by rw [show 2*767 = 1534 by decide, phi1534]; decide +kernel)
private theorem grid766x768 : Covered 766 768 := pair cell766 cell767
private theorem grid764x768 : Covered 764 768 := pair grid764x766 grid766x768
private theorem phi1536 : Nat.totient 1536 = 512 := step (p := 2) (m := 768) (by decide +kernel) (by decide) phi768 (by decide +kernel)
private theorem cell768 : Covered 768 769 := singleton (i := 768) (by rw [show 2*768 = 1536 by decide, phi1536]; decide +kernel)
private theorem phi769 : Nat.totient 769 = 768 := step (p := 769) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1538 : Nat.totient 1538 = 768 := step (p := 2) (m := 769) (by decide +kernel) (by decide) phi769 (by decide +kernel)
private theorem cell769 : Covered 769 770 := singleton (i := 769) (by rw [show 2*769 = 1538 by decide, phi1538]; decide +kernel)
private theorem grid768x770 : Covered 768 770 := pair cell768 cell769
private theorem phi1540 : Nat.totient 1540 = 480 := step (p := 2) (m := 770) (by decide +kernel) (by decide) phi770 (by decide +kernel)
private theorem cell770 : Covered 770 771 := singleton (i := 770) (by rw [show 2*770 = 1540 by decide, phi1540]; decide +kernel)
private theorem phi771 : Nat.totient 771 = 512 := step (p := 3) (m := 257) (by decide +kernel) (by decide) phi257 (by decide +kernel)
private theorem phi1542 : Nat.totient 1542 = 512 := step (p := 2) (m := 771) (by decide +kernel) (by decide) phi771 (by decide +kernel)
private theorem cell771 : Covered 771 772 := singleton (i := 771) (by rw [show 2*771 = 1542 by decide, phi1542]; decide +kernel)
private theorem phi1544 : Nat.totient 1544 = 768 := step (p := 2) (m := 772) (by decide +kernel) (by decide) phi772 (by decide +kernel)
private theorem cell772 : Covered 772 773 := singleton (i := 772) (by rw [show 2*772 = 1544 by decide, phi1544]; decide +kernel)
private theorem grid771x773 : Covered 771 773 := pair cell771 cell772
private theorem grid770x773 : Covered 770 773 := pair cell770 grid771x773
private theorem grid768x773 : Covered 768 773 := pair grid768x770 grid770x773
private theorem grid764x773 : Covered 764 773 := pair grid764x768 grid768x773
private theorem phi773 : Nat.totient 773 = 772 := step (p := 773) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1546 : Nat.totient 1546 = 772 := step (p := 2) (m := 773) (by decide +kernel) (by decide) phi773 (by decide +kernel)
private theorem cell773 : Covered 773 774 := singleton (i := 773) (by rw [show 2*773 = 1546 by decide, phi1546]; decide +kernel)
private theorem phi1548 : Nat.totient 1548 = 504 := step (p := 2) (m := 774) (by decide +kernel) (by decide) phi774 (by decide +kernel)
private theorem cell774 : Covered 774 775 := singleton (i := 774) (by rw [show 2*774 = 1548 by decide, phi1548]; decide +kernel)
private theorem grid773x775 : Covered 773 775 := pair cell773 cell774
private theorem phi775 : Nat.totient 775 = 600 := step (p := 5) (m := 155) (by decide +kernel) (by decide) phi155 (by decide +kernel)
private theorem phi1550 : Nat.totient 1550 = 600 := step (p := 2) (m := 775) (by decide +kernel) (by decide) phi775 (by decide +kernel)
private theorem cell775 : Covered 775 776 := singleton (i := 775) (by rw [show 2*775 = 1550 by decide, phi1550]; decide +kernel)
private theorem phi1552 : Nat.totient 1552 = 768 := step (p := 2) (m := 776) (by decide +kernel) (by decide) phi776 (by decide +kernel)
private theorem cell776 : Covered 776 777 := singleton (i := 776) (by rw [show 2*776 = 1552 by decide, phi1552]; decide +kernel)
private theorem grid775x777 : Covered 775 777 := pair cell775 cell776
private theorem grid773x777 : Covered 773 777 := pair grid773x775 grid775x777
private theorem phi777 : Nat.totient 777 = 432 := step (p := 3) (m := 259) (by decide +kernel) (by decide) phi259 (by decide +kernel)
private theorem phi1554 : Nat.totient 1554 = 432 := step (p := 2) (m := 777) (by decide +kernel) (by decide) phi777 (by decide +kernel)
private theorem cell777 : Covered 777 778 := singleton (i := 777) (by rw [show 2*777 = 1554 by decide, phi1554]; decide +kernel)
private theorem phi1556 : Nat.totient 1556 = 776 := step (p := 2) (m := 778) (by decide +kernel) (by decide) phi778 (by decide +kernel)
private theorem cell778 : Covered 778 779 := singleton (i := 778) (by rw [show 2*778 = 1556 by decide, phi1556]; decide +kernel)
private theorem grid777x779 : Covered 777 779 := pair cell777 cell778
private theorem phi779 : Nat.totient 779 = 720 := step (p := 19) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi1558 : Nat.totient 1558 = 720 := step (p := 2) (m := 779) (by decide +kernel) (by decide) phi779 (by decide +kernel)
private theorem cell779 : Covered 779 780 := singleton (i := 779) (by rw [show 2*779 = 1558 by decide, phi1558]; decide +kernel)
private theorem phi1560 : Nat.totient 1560 = 384 := step (p := 2) (m := 780) (by decide +kernel) (by decide) phi780 (by decide +kernel)
private theorem cell780 : Covered 780 781 := singleton (i := 780) (by rw [show 2*780 = 1560 by decide, phi1560]; decide +kernel)
private theorem phi781 : Nat.totient 781 = 700 := step (p := 11) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem phi1562 : Nat.totient 1562 = 700 := step (p := 2) (m := 781) (by decide +kernel) (by decide) phi781 (by decide +kernel)
private theorem cell781 : Covered 781 782 := singleton (i := 781) (by rw [show 2*781 = 1562 by decide, phi1562]; decide +kernel)
private theorem grid780x782 : Covered 780 782 := pair cell780 cell781
private theorem grid779x782 : Covered 779 782 := pair cell779 grid780x782
private theorem grid777x782 : Covered 777 782 := pair grid777x779 grid779x782
private theorem grid773x782 : Covered 773 782 := pair grid773x777 grid777x782
private theorem grid764x782 : Covered 764 782 := pair grid764x773 grid773x782
private theorem phi1564 : Nat.totient 1564 = 704 := step (p := 2) (m := 782) (by decide +kernel) (by decide) phi782 (by decide +kernel)
private theorem cell782 : Covered 782 783 := singleton (i := 782) (by rw [show 2*782 = 1564 by decide, phi1564]; decide +kernel)
private theorem phi783 : Nat.totient 783 = 504 := step (p := 3) (m := 261) (by decide +kernel) (by decide) phi261 (by decide +kernel)
private theorem phi1566 : Nat.totient 1566 = 504 := step (p := 2) (m := 783) (by decide +kernel) (by decide) phi783 (by decide +kernel)
private theorem cell783 : Covered 783 784 := singleton (i := 783) (by rw [show 2*783 = 1566 by decide, phi1566]; decide +kernel)
private theorem grid782x784 : Covered 782 784 := pair cell782 cell783
private theorem phi1568 : Nat.totient 1568 = 672 := step (p := 2) (m := 784) (by decide +kernel) (by decide) phi784 (by decide +kernel)
private theorem cell784 : Covered 784 785 := singleton (i := 784) (by rw [show 2*784 = 1568 by decide, phi1568]; decide +kernel)
private theorem phi785 : Nat.totient 785 = 624 := step (p := 5) (m := 157) (by decide +kernel) (by decide) phi157 (by decide +kernel)
private theorem phi1570 : Nat.totient 1570 = 624 := step (p := 2) (m := 785) (by decide +kernel) (by decide) phi785 (by decide +kernel)
private theorem cell785 : Covered 785 786 := singleton (i := 785) (by rw [show 2*785 = 1570 by decide, phi1570]; decide +kernel)
private theorem grid784x786 : Covered 784 786 := pair cell784 cell785
private theorem grid782x786 : Covered 782 786 := pair grid782x784 grid784x786
private theorem phi1572 : Nat.totient 1572 = 520 := step (p := 2) (m := 786) (by decide +kernel) (by decide) phi786 (by decide +kernel)
private theorem cell786 : Covered 786 787 := singleton (i := 786) (by rw [show 2*786 = 1572 by decide, phi1572]; decide +kernel)
private theorem phi787 : Nat.totient 787 = 786 := step (p := 787) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1574 : Nat.totient 1574 = 786 := step (p := 2) (m := 787) (by decide +kernel) (by decide) phi787 (by decide +kernel)
private theorem cell787 : Covered 787 788 := singleton (i := 787) (by rw [show 2*787 = 1574 by decide, phi1574]; decide +kernel)
private theorem grid786x788 : Covered 786 788 := pair cell786 cell787
private theorem phi1576 : Nat.totient 1576 = 784 := step (p := 2) (m := 788) (by decide +kernel) (by decide) phi788 (by decide +kernel)
private theorem cell788 : Covered 788 789 := singleton (i := 788) (by rw [show 2*788 = 1576 by decide, phi1576]; decide +kernel)
private theorem phi789 : Nat.totient 789 = 524 := step (p := 3) (m := 263) (by decide +kernel) (by decide) phi263 (by decide +kernel)
private theorem phi1578 : Nat.totient 1578 = 524 := step (p := 2) (m := 789) (by decide +kernel) (by decide) phi789 (by decide +kernel)
private theorem cell789 : Covered 789 790 := singleton (i := 789) (by rw [show 2*789 = 1578 by decide, phi1578]; decide +kernel)
private theorem phi1580 : Nat.totient 1580 = 624 := step (p := 2) (m := 790) (by decide +kernel) (by decide) phi790 (by decide +kernel)
private theorem cell790 : Covered 790 791 := singleton (i := 790) (by rw [show 2*790 = 1580 by decide, phi1580]; decide +kernel)
private theorem grid789x791 : Covered 789 791 := pair cell789 cell790
private theorem grid788x791 : Covered 788 791 := pair cell788 grid789x791
private theorem grid786x791 : Covered 786 791 := pair grid786x788 grid788x791
private theorem grid782x791 : Covered 782 791 := pair grid782x786 grid786x791
private theorem phi791 : Nat.totient 791 = 672 := step (p := 7) (m := 113) (by decide +kernel) (by decide) phi113 (by decide +kernel)
private theorem phi1582 : Nat.totient 1582 = 672 := step (p := 2) (m := 791) (by decide +kernel) (by decide) phi791 (by decide +kernel)
private theorem cell791 : Covered 791 792 := singleton (i := 791) (by rw [show 2*791 = 1582 by decide, phi1582]; decide +kernel)
private theorem phi1584 : Nat.totient 1584 = 480 := step (p := 2) (m := 792) (by decide +kernel) (by decide) phi792 (by decide +kernel)
private theorem cell792 : Covered 792 793 := singleton (i := 792) (by rw [show 2*792 = 1584 by decide, phi1584]; decide +kernel)
private theorem grid791x793 : Covered 791 793 := pair cell791 cell792
private theorem phi793 : Nat.totient 793 = 720 := step (p := 13) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi1586 : Nat.totient 1586 = 720 := step (p := 2) (m := 793) (by decide +kernel) (by decide) phi793 (by decide +kernel)
private theorem cell793 : Covered 793 794 := singleton (i := 793) (by rw [show 2*793 = 1586 by decide, phi1586]; decide +kernel)
private theorem phi1588 : Nat.totient 1588 = 792 := step (p := 2) (m := 794) (by decide +kernel) (by decide) phi794 (by decide +kernel)
private theorem cell794 : Covered 794 795 := singleton (i := 794) (by rw [show 2*794 = 1588 by decide, phi1588]; decide +kernel)
private theorem phi795 : Nat.totient 795 = 416 := step (p := 3) (m := 265) (by decide +kernel) (by decide) phi265 (by decide +kernel)
private theorem phi1590 : Nat.totient 1590 = 416 := step (p := 2) (m := 795) (by decide +kernel) (by decide) phi795 (by decide +kernel)
private theorem cell795 : Covered 795 796 := singleton (i := 795) (by rw [show 2*795 = 1590 by decide, phi1590]; decide +kernel)
private theorem grid794x796 : Covered 794 796 := pair cell794 cell795
private theorem grid793x796 : Covered 793 796 := pair cell793 grid794x796
private theorem grid791x796 : Covered 791 796 := pair grid791x793 grid793x796
private theorem phi1592 : Nat.totient 1592 = 792 := step (p := 2) (m := 796) (by decide +kernel) (by decide) phi796 (by decide +kernel)
private theorem cell796 : Covered 796 797 := singleton (i := 796) (by rw [show 2*796 = 1592 by decide, phi1592]; decide +kernel)
private theorem phi797 : Nat.totient 797 = 796 := step (p := 797) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1594 : Nat.totient 1594 = 796 := step (p := 2) (m := 797) (by decide +kernel) (by decide) phi797 (by decide +kernel)
private theorem cell797 : Covered 797 798 := singleton (i := 797) (by rw [show 2*797 = 1594 by decide, phi1594]; decide +kernel)
private theorem grid796x798 : Covered 796 798 := pair cell796 cell797
private theorem phi1596 : Nat.totient 1596 = 432 := step (p := 2) (m := 798) (by decide +kernel) (by decide) phi798 (by decide +kernel)
private theorem cell798 : Covered 798 799 := singleton (i := 798) (by rw [show 2*798 = 1596 by decide, phi1596]; decide +kernel)
private theorem phi799 : Nat.totient 799 = 736 := step (p := 17) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi1598 : Nat.totient 1598 = 736 := step (p := 2) (m := 799) (by decide +kernel) (by decide) phi799 (by decide +kernel)
private theorem cell799 : Covered 799 800 := singleton (i := 799) (by rw [show 2*799 = 1598 by decide, phi1598]; decide +kernel)
private theorem phi1600 : Nat.totient 1600 = 640 := step (p := 2) (m := 800) (by decide +kernel) (by decide) phi800 (by decide +kernel)
private theorem cell800 : Covered 800 801 := singleton (i := 800) (by rw [show 2*800 = 1600 by decide, phi1600]; decide +kernel)
private theorem grid799x801 : Covered 799 801 := pair cell799 cell800
private theorem grid798x801 : Covered 798 801 := pair cell798 grid799x801
private theorem grid796x801 : Covered 796 801 := pair grid796x798 grid798x801
private theorem grid791x801 : Covered 791 801 := pair grid791x796 grid796x801
private theorem grid782x801 : Covered 782 801 := pair grid782x791 grid791x801
private theorem grid764x801 : Covered 764 801 := pair grid764x782 grid782x801
private theorem grid728x801 : Covered 728 801 := pair grid728x764 grid764x801
private theorem phi801 : Nat.totient 801 = 528 := step (p := 3) (m := 267) (by decide +kernel) (by decide) phi267 (by decide +kernel)
private theorem phi1602 : Nat.totient 1602 = 528 := step (p := 2) (m := 801) (by decide +kernel) (by decide) phi801 (by decide +kernel)
private theorem cell801 : Covered 801 802 := singleton (i := 801) (by rw [show 2*801 = 1602 by decide, phi1602]; decide +kernel)
private theorem phi1604 : Nat.totient 1604 = 800 := step (p := 2) (m := 802) (by decide +kernel) (by decide) phi802 (by decide +kernel)
private theorem cell802 : Covered 802 803 := singleton (i := 802) (by rw [show 2*802 = 1604 by decide, phi1604]; decide +kernel)
private theorem grid801x803 : Covered 801 803 := pair cell801 cell802
private theorem phi803 : Nat.totient 803 = 720 := step (p := 11) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem phi1606 : Nat.totient 1606 = 720 := step (p := 2) (m := 803) (by decide +kernel) (by decide) phi803 (by decide +kernel)
private theorem cell803 : Covered 803 804 := singleton (i := 803) (by rw [show 2*803 = 1606 by decide, phi1606]; decide +kernel)
private theorem phi1608 : Nat.totient 1608 = 528 := step (p := 2) (m := 804) (by decide +kernel) (by decide) phi804 (by decide +kernel)
private theorem cell804 : Covered 804 805 := singleton (i := 804) (by rw [show 2*804 = 1608 by decide, phi1608]; decide +kernel)
private theorem grid803x805 : Covered 803 805 := pair cell803 cell804
private theorem grid801x805 : Covered 801 805 := pair grid801x803 grid803x805
private theorem phi805 : Nat.totient 805 = 528 := step (p := 5) (m := 161) (by decide +kernel) (by decide) phi161 (by decide +kernel)
private theorem phi1610 : Nat.totient 1610 = 528 := step (p := 2) (m := 805) (by decide +kernel) (by decide) phi805 (by decide +kernel)
private theorem cell805 : Covered 805 806 := singleton (i := 805) (by rw [show 2*805 = 1610 by decide, phi1610]; decide +kernel)
private theorem phi1612 : Nat.totient 1612 = 720 := step (p := 2) (m := 806) (by decide +kernel) (by decide) phi806 (by decide +kernel)
private theorem cell806 : Covered 806 807 := singleton (i := 806) (by rw [show 2*806 = 1612 by decide, phi1612]; decide +kernel)
private theorem grid805x807 : Covered 805 807 := pair cell805 cell806
private theorem phi807 : Nat.totient 807 = 536 := step (p := 3) (m := 269) (by decide +kernel) (by decide) phi269 (by decide +kernel)
private theorem phi1614 : Nat.totient 1614 = 536 := step (p := 2) (m := 807) (by decide +kernel) (by decide) phi807 (by decide +kernel)
private theorem cell807 : Covered 807 808 := singleton (i := 807) (by rw [show 2*807 = 1614 by decide, phi1614]; decide +kernel)
private theorem phi1616 : Nat.totient 1616 = 800 := step (p := 2) (m := 808) (by decide +kernel) (by decide) phi808 (by decide +kernel)
private theorem cell808 : Covered 808 809 := singleton (i := 808) (by rw [show 2*808 = 1616 by decide, phi1616]; decide +kernel)
private theorem phi809 : Nat.totient 809 = 808 := step (p := 809) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1618 : Nat.totient 1618 = 808 := step (p := 2) (m := 809) (by decide +kernel) (by decide) phi809 (by decide +kernel)
private theorem cell809 : Covered 809 810 := singleton (i := 809) (by rw [show 2*809 = 1618 by decide, phi1618]; decide +kernel)
private theorem grid808x810 : Covered 808 810 := pair cell808 cell809
private theorem grid807x810 : Covered 807 810 := pair cell807 grid808x810
private theorem grid805x810 : Covered 805 810 := pair grid805x807 grid807x810
private theorem grid801x810 : Covered 801 810 := pair grid801x805 grid805x810
private theorem phi1620 : Nat.totient 1620 = 432 := step (p := 2) (m := 810) (by decide +kernel) (by decide) phi810 (by decide +kernel)
private theorem cell810 : Covered 810 811 := singleton (i := 810) (by rw [show 2*810 = 1620 by decide, phi1620]; decide +kernel)
private theorem phi811 : Nat.totient 811 = 810 := step (p := 811) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1622 : Nat.totient 1622 = 810 := step (p := 2) (m := 811) (by decide +kernel) (by decide) phi811 (by decide +kernel)
private theorem cell811 : Covered 811 812 := singleton (i := 811) (by rw [show 2*811 = 1622 by decide, phi1622]; decide +kernel)
private theorem grid810x812 : Covered 810 812 := pair cell810 cell811
private theorem phi1624 : Nat.totient 1624 = 672 := step (p := 2) (m := 812) (by decide +kernel) (by decide) phi812 (by decide +kernel)
private theorem cell812 : Covered 812 813 := singleton (i := 812) (by rw [show 2*812 = 1624 by decide, phi1624]; decide +kernel)
private theorem phi813 : Nat.totient 813 = 540 := step (p := 3) (m := 271) (by decide +kernel) (by decide) phi271 (by decide +kernel)
private theorem phi1626 : Nat.totient 1626 = 540 := step (p := 2) (m := 813) (by decide +kernel) (by decide) phi813 (by decide +kernel)
private theorem cell813 : Covered 813 814 := singleton (i := 813) (by rw [show 2*813 = 1626 by decide, phi1626]; decide +kernel)
private theorem grid812x814 : Covered 812 814 := pair cell812 cell813
private theorem grid810x814 : Covered 810 814 := pair grid810x812 grid812x814
private theorem phi1628 : Nat.totient 1628 = 720 := step (p := 2) (m := 814) (by decide +kernel) (by decide) phi814 (by decide +kernel)
private theorem cell814 : Covered 814 815 := singleton (i := 814) (by rw [show 2*814 = 1628 by decide, phi1628]; decide +kernel)
private theorem phi815 : Nat.totient 815 = 648 := step (p := 5) (m := 163) (by decide +kernel) (by decide) phi163 (by decide +kernel)
private theorem phi1630 : Nat.totient 1630 = 648 := step (p := 2) (m := 815) (by decide +kernel) (by decide) phi815 (by decide +kernel)
private theorem cell815 : Covered 815 816 := singleton (i := 815) (by rw [show 2*815 = 1630 by decide, phi1630]; decide +kernel)
private theorem grid814x816 : Covered 814 816 := pair cell814 cell815
private theorem phi1632 : Nat.totient 1632 = 512 := step (p := 2) (m := 816) (by decide +kernel) (by decide) phi816 (by decide +kernel)
private theorem cell816 : Covered 816 817 := singleton (i := 816) (by rw [show 2*816 = 1632 by decide, phi1632]; decide +kernel)
private theorem phi817 : Nat.totient 817 = 756 := step (p := 19) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi1634 : Nat.totient 1634 = 756 := step (p := 2) (m := 817) (by decide +kernel) (by decide) phi817 (by decide +kernel)
private theorem cell817 : Covered 817 818 := singleton (i := 817) (by rw [show 2*817 = 1634 by decide, phi1634]; decide +kernel)
private theorem phi1636 : Nat.totient 1636 = 816 := step (p := 2) (m := 818) (by decide +kernel) (by decide) phi818 (by decide +kernel)
private theorem cell818 : Covered 818 819 := singleton (i := 818) (by rw [show 2*818 = 1636 by decide, phi1636]; decide +kernel)
private theorem grid817x819 : Covered 817 819 := pair cell817 cell818
private theorem grid816x819 : Covered 816 819 := pair cell816 grid817x819
private theorem grid814x819 : Covered 814 819 := pair grid814x816 grid816x819
private theorem grid810x819 : Covered 810 819 := pair grid810x814 grid814x819
private theorem grid801x819 : Covered 801 819 := pair grid801x810 grid810x819
private theorem phi819 : Nat.totient 819 = 432 := step (p := 3) (m := 273) (by decide +kernel) (by decide) phi273 (by decide +kernel)
private theorem phi1638 : Nat.totient 1638 = 432 := step (p := 2) (m := 819) (by decide +kernel) (by decide) phi819 (by decide +kernel)
private theorem cell819 : Covered 819 820 := singleton (i := 819) (by rw [show 2*819 = 1638 by decide, phi1638]; decide +kernel)
private theorem phi1640 : Nat.totient 1640 = 640 := step (p := 2) (m := 820) (by decide +kernel) (by decide) phi820 (by decide +kernel)
private theorem cell820 : Covered 820 821 := singleton (i := 820) (by rw [show 2*820 = 1640 by decide, phi1640]; decide +kernel)
private theorem grid819x821 : Covered 819 821 := pair cell819 cell820
private theorem phi821 : Nat.totient 821 = 820 := step (p := 821) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1642 : Nat.totient 1642 = 820 := step (p := 2) (m := 821) (by decide +kernel) (by decide) phi821 (by decide +kernel)
private theorem cell821 : Covered 821 822 := singleton (i := 821) (by rw [show 2*821 = 1642 by decide, phi1642]; decide +kernel)
private theorem phi1644 : Nat.totient 1644 = 544 := step (p := 2) (m := 822) (by decide +kernel) (by decide) phi822 (by decide +kernel)
private theorem cell822 : Covered 822 823 := singleton (i := 822) (by rw [show 2*822 = 1644 by decide, phi1644]; decide +kernel)
private theorem grid821x823 : Covered 821 823 := pair cell821 cell822
private theorem grid819x823 : Covered 819 823 := pair grid819x821 grid821x823
private theorem phi823 : Nat.totient 823 = 822 := step (p := 823) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1646 : Nat.totient 1646 = 822 := step (p := 2) (m := 823) (by decide +kernel) (by decide) phi823 (by decide +kernel)
private theorem cell823 : Covered 823 824 := singleton (i := 823) (by rw [show 2*823 = 1646 by decide, phi1646]; decide +kernel)
private theorem phi1648 : Nat.totient 1648 = 816 := step (p := 2) (m := 824) (by decide +kernel) (by decide) phi824 (by decide +kernel)
private theorem cell824 : Covered 824 825 := singleton (i := 824) (by rw [show 2*824 = 1648 by decide, phi1648]; decide +kernel)
private theorem grid823x825 : Covered 823 825 := pair cell823 cell824
private theorem phi825 : Nat.totient 825 = 400 := step (p := 3) (m := 275) (by decide +kernel) (by decide) phi275 (by decide +kernel)
private theorem phi1650 : Nat.totient 1650 = 400 := step (p := 2) (m := 825) (by decide +kernel) (by decide) phi825 (by decide +kernel)
private theorem cell825 : Covered 825 826 := singleton (i := 825) (by rw [show 2*825 = 1650 by decide, phi1650]; decide +kernel)
private theorem phi1652 : Nat.totient 1652 = 696 := step (p := 2) (m := 826) (by decide +kernel) (by decide) phi826 (by decide +kernel)
private theorem cell826 : Covered 826 827 := singleton (i := 826) (by rw [show 2*826 = 1652 by decide, phi1652]; decide +kernel)
private theorem phi827 : Nat.totient 827 = 826 := step (p := 827) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1654 : Nat.totient 1654 = 826 := step (p := 2) (m := 827) (by decide +kernel) (by decide) phi827 (by decide +kernel)
private theorem cell827 : Covered 827 828 := singleton (i := 827) (by rw [show 2*827 = 1654 by decide, phi1654]; decide +kernel)
private theorem grid826x828 : Covered 826 828 := pair cell826 cell827
private theorem grid825x828 : Covered 825 828 := pair cell825 grid826x828
private theorem grid823x828 : Covered 823 828 := pair grid823x825 grid825x828
private theorem grid819x828 : Covered 819 828 := pair grid819x823 grid823x828
private theorem phi1656 : Nat.totient 1656 = 528 := step (p := 2) (m := 828) (by decide +kernel) (by decide) phi828 (by decide +kernel)
private theorem cell828 : Covered 828 829 := singleton (i := 828) (by rw [show 2*828 = 1656 by decide, phi1656]; decide +kernel)
private theorem phi829 : Nat.totient 829 = 828 := step (p := 829) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1658 : Nat.totient 1658 = 828 := step (p := 2) (m := 829) (by decide +kernel) (by decide) phi829 (by decide +kernel)
private theorem cell829 : Covered 829 830 := singleton (i := 829) (by rw [show 2*829 = 1658 by decide, phi1658]; decide +kernel)
private theorem grid828x830 : Covered 828 830 := pair cell828 cell829
private theorem phi1660 : Nat.totient 1660 = 656 := step (p := 2) (m := 830) (by decide +kernel) (by decide) phi830 (by decide +kernel)
private theorem cell830 : Covered 830 831 := singleton (i := 830) (by rw [show 2*830 = 1660 by decide, phi1660]; decide +kernel)
private theorem phi831 : Nat.totient 831 = 552 := step (p := 3) (m := 277) (by decide +kernel) (by decide) phi277 (by decide +kernel)
private theorem phi1662 : Nat.totient 1662 = 552 := step (p := 2) (m := 831) (by decide +kernel) (by decide) phi831 (by decide +kernel)
private theorem cell831 : Covered 831 832 := singleton (i := 831) (by rw [show 2*831 = 1662 by decide, phi1662]; decide +kernel)
private theorem grid830x832 : Covered 830 832 := pair cell830 cell831
private theorem grid828x832 : Covered 828 832 := pair grid828x830 grid830x832
private theorem phi1664 : Nat.totient 1664 = 768 := step (p := 2) (m := 832) (by decide +kernel) (by decide) phi832 (by decide +kernel)
private theorem cell832 : Covered 832 833 := singleton (i := 832) (by rw [show 2*832 = 1664 by decide, phi1664]; decide +kernel)
private theorem phi833 : Nat.totient 833 = 672 := step (p := 7) (m := 119) (by decide +kernel) (by decide) phi119 (by decide +kernel)
private theorem phi1666 : Nat.totient 1666 = 672 := step (p := 2) (m := 833) (by decide +kernel) (by decide) phi833 (by decide +kernel)
private theorem cell833 : Covered 833 834 := singleton (i := 833) (by rw [show 2*833 = 1666 by decide, phi1666]; decide +kernel)
private theorem grid832x834 : Covered 832 834 := pair cell832 cell833
private theorem phi1668 : Nat.totient 1668 = 552 := step (p := 2) (m := 834) (by decide +kernel) (by decide) phi834 (by decide +kernel)
private theorem cell834 : Covered 834 835 := singleton (i := 834) (by rw [show 2*834 = 1668 by decide, phi1668]; decide +kernel)
private theorem phi835 : Nat.totient 835 = 664 := step (p := 5) (m := 167) (by decide +kernel) (by decide) phi167 (by decide +kernel)
private theorem phi1670 : Nat.totient 1670 = 664 := step (p := 2) (m := 835) (by decide +kernel) (by decide) phi835 (by decide +kernel)
private theorem cell835 : Covered 835 836 := singleton (i := 835) (by rw [show 2*835 = 1670 by decide, phi1670]; decide +kernel)
private theorem phi1672 : Nat.totient 1672 = 720 := step (p := 2) (m := 836) (by decide +kernel) (by decide) phi836 (by decide +kernel)
private theorem cell836 : Covered 836 837 := singleton (i := 836) (by rw [show 2*836 = 1672 by decide, phi1672]; decide +kernel)
private theorem grid835x837 : Covered 835 837 := pair cell835 cell836
private theorem grid834x837 : Covered 834 837 := pair cell834 grid835x837
private theorem grid832x837 : Covered 832 837 := pair grid832x834 grid834x837
private theorem grid828x837 : Covered 828 837 := pair grid828x832 grid832x837
private theorem grid819x837 : Covered 819 837 := pair grid819x828 grid828x837
private theorem grid801x837 : Covered 801 837 := pair grid801x819 grid819x837
private theorem phi837 : Nat.totient 837 = 540 := step (p := 3) (m := 279) (by decide +kernel) (by decide) phi279 (by decide +kernel)
private theorem phi1674 : Nat.totient 1674 = 540 := step (p := 2) (m := 837) (by decide +kernel) (by decide) phi837 (by decide +kernel)
private theorem cell837 : Covered 837 838 := singleton (i := 837) (by rw [show 2*837 = 1674 by decide, phi1674]; decide +kernel)
private theorem phi1676 : Nat.totient 1676 = 836 := step (p := 2) (m := 838) (by decide +kernel) (by decide) phi838 (by decide +kernel)
private theorem cell838 : Covered 838 839 := singleton (i := 838) (by rw [show 2*838 = 1676 by decide, phi1676]; decide +kernel)
private theorem grid837x839 : Covered 837 839 := pair cell837 cell838
private theorem phi839 : Nat.totient 839 = 838 := step (p := 839) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1678 : Nat.totient 1678 = 838 := step (p := 2) (m := 839) (by decide +kernel) (by decide) phi839 (by decide +kernel)
private theorem cell839 : Covered 839 840 := singleton (i := 839) (by rw [show 2*839 = 1678 by decide, phi1678]; decide +kernel)
private theorem phi1680 : Nat.totient 1680 = 384 := step (p := 2) (m := 840) (by decide +kernel) (by decide) phi840 (by decide +kernel)
private theorem cell840 : Covered 840 841 := singleton (i := 840) (by rw [show 2*840 = 1680 by decide, phi1680]; decide +kernel)
private theorem grid839x841 : Covered 839 841 := pair cell839 cell840
private theorem grid837x841 : Covered 837 841 := pair grid837x839 grid839x841
private theorem phi841 : Nat.totient 841 = 812 := step (p := 29) (m := 29) (by decide +kernel) (by decide) phi29 (by decide +kernel)
private theorem phi1682 : Nat.totient 1682 = 812 := step (p := 2) (m := 841) (by decide +kernel) (by decide) phi841 (by decide +kernel)
private theorem cell841 : Covered 841 842 := singleton (i := 841) (by rw [show 2*841 = 1682 by decide, phi1682]; decide +kernel)
private theorem phi1684 : Nat.totient 1684 = 840 := step (p := 2) (m := 842) (by decide +kernel) (by decide) phi842 (by decide +kernel)
private theorem cell842 : Covered 842 843 := singleton (i := 842) (by rw [show 2*842 = 1684 by decide, phi1684]; decide +kernel)
private theorem grid841x843 : Covered 841 843 := pair cell841 cell842
private theorem phi843 : Nat.totient 843 = 560 := step (p := 3) (m := 281) (by decide +kernel) (by decide) phi281 (by decide +kernel)
private theorem phi1686 : Nat.totient 1686 = 560 := step (p := 2) (m := 843) (by decide +kernel) (by decide) phi843 (by decide +kernel)
private theorem cell843 : Covered 843 844 := singleton (i := 843) (by rw [show 2*843 = 1686 by decide, phi1686]; decide +kernel)
private theorem phi1688 : Nat.totient 1688 = 840 := step (p := 2) (m := 844) (by decide +kernel) (by decide) phi844 (by decide +kernel)
private theorem cell844 : Covered 844 845 := singleton (i := 844) (by rw [show 2*844 = 1688 by decide, phi1688]; decide +kernel)
private theorem phi845 : Nat.totient 845 = 624 := step (p := 5) (m := 169) (by decide +kernel) (by decide) phi169 (by decide +kernel)
private theorem phi1690 : Nat.totient 1690 = 624 := step (p := 2) (m := 845) (by decide +kernel) (by decide) phi845 (by decide +kernel)
private theorem cell845 : Covered 845 846 := singleton (i := 845) (by rw [show 2*845 = 1690 by decide, phi1690]; decide +kernel)
private theorem grid844x846 : Covered 844 846 := pair cell844 cell845
private theorem grid843x846 : Covered 843 846 := pair cell843 grid844x846
private theorem grid841x846 : Covered 841 846 := pair grid841x843 grid843x846
private theorem grid837x846 : Covered 837 846 := pair grid837x841 grid841x846
private theorem phi1692 : Nat.totient 1692 = 552 := step (p := 2) (m := 846) (by decide +kernel) (by decide) phi846 (by decide +kernel)
private theorem cell846 : Covered 846 847 := singleton (i := 846) (by rw [show 2*846 = 1692 by decide, phi1692]; decide +kernel)
private theorem phi847 : Nat.totient 847 = 660 := step (p := 7) (m := 121) (by decide +kernel) (by decide) phi121 (by decide +kernel)
private theorem phi1694 : Nat.totient 1694 = 660 := step (p := 2) (m := 847) (by decide +kernel) (by decide) phi847 (by decide +kernel)
private theorem cell847 : Covered 847 848 := singleton (i := 847) (by rw [show 2*847 = 1694 by decide, phi1694]; decide +kernel)
private theorem grid846x848 : Covered 846 848 := pair cell846 cell847
private theorem phi1696 : Nat.totient 1696 = 832 := step (p := 2) (m := 848) (by decide +kernel) (by decide) phi848 (by decide +kernel)
private theorem cell848 : Covered 848 849 := singleton (i := 848) (by rw [show 2*848 = 1696 by decide, phi1696]; decide +kernel)
private theorem phi849 : Nat.totient 849 = 564 := step (p := 3) (m := 283) (by decide +kernel) (by decide) phi283 (by decide +kernel)
private theorem phi1698 : Nat.totient 1698 = 564 := step (p := 2) (m := 849) (by decide +kernel) (by decide) phi849 (by decide +kernel)
private theorem cell849 : Covered 849 850 := singleton (i := 849) (by rw [show 2*849 = 1698 by decide, phi1698]; decide +kernel)
private theorem grid848x850 : Covered 848 850 := pair cell848 cell849
private theorem grid846x850 : Covered 846 850 := pair grid846x848 grid848x850
private theorem phi1700 : Nat.totient 1700 = 640 := step (p := 2) (m := 850) (by decide +kernel) (by decide) phi850 (by decide +kernel)
private theorem cell850 : Covered 850 851 := singleton (i := 850) (by rw [show 2*850 = 1700 by decide, phi1700]; decide +kernel)
private theorem phi851 : Nat.totient 851 = 792 := step (p := 23) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi1702 : Nat.totient 1702 = 792 := step (p := 2) (m := 851) (by decide +kernel) (by decide) phi851 (by decide +kernel)
private theorem cell851 : Covered 851 852 := singleton (i := 851) (by rw [show 2*851 = 1702 by decide, phi1702]; decide +kernel)
private theorem grid850x852 : Covered 850 852 := pair cell850 cell851
private theorem phi1704 : Nat.totient 1704 = 560 := step (p := 2) (m := 852) (by decide +kernel) (by decide) phi852 (by decide +kernel)
private theorem cell852 : Covered 852 853 := singleton (i := 852) (by rw [show 2*852 = 1704 by decide, phi1704]; decide +kernel)
private theorem phi853 : Nat.totient 853 = 852 := step (p := 853) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1706 : Nat.totient 1706 = 852 := step (p := 2) (m := 853) (by decide +kernel) (by decide) phi853 (by decide +kernel)
private theorem cell853 : Covered 853 854 := singleton (i := 853) (by rw [show 2*853 = 1706 by decide, phi1706]; decide +kernel)
private theorem phi1708 : Nat.totient 1708 = 720 := step (p := 2) (m := 854) (by decide +kernel) (by decide) phi854 (by decide +kernel)
private theorem cell854 : Covered 854 855 := singleton (i := 854) (by rw [show 2*854 = 1708 by decide, phi1708]; decide +kernel)
private theorem grid853x855 : Covered 853 855 := pair cell853 cell854
private theorem grid852x855 : Covered 852 855 := pair cell852 grid853x855
private theorem grid850x855 : Covered 850 855 := pair grid850x852 grid852x855
private theorem grid846x855 : Covered 846 855 := pair grid846x850 grid850x855
private theorem grid837x855 : Covered 837 855 := pair grid837x846 grid846x855
private theorem phi855 : Nat.totient 855 = 432 := step (p := 3) (m := 285) (by decide +kernel) (by decide) phi285 (by decide +kernel)
private theorem phi1710 : Nat.totient 1710 = 432 := step (p := 2) (m := 855) (by decide +kernel) (by decide) phi855 (by decide +kernel)
private theorem cell855 : Covered 855 856 := singleton (i := 855) (by rw [show 2*855 = 1710 by decide, phi1710]; decide +kernel)
private theorem phi1712 : Nat.totient 1712 = 848 := step (p := 2) (m := 856) (by decide +kernel) (by decide) phi856 (by decide +kernel)
private theorem cell856 : Covered 856 857 := singleton (i := 856) (by rw [show 2*856 = 1712 by decide, phi1712]; decide +kernel)
private theorem grid855x857 : Covered 855 857 := pair cell855 cell856
private theorem phi857 : Nat.totient 857 = 856 := step (p := 857) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1714 : Nat.totient 1714 = 856 := step (p := 2) (m := 857) (by decide +kernel) (by decide) phi857 (by decide +kernel)
private theorem cell857 : Covered 857 858 := singleton (i := 857) (by rw [show 2*857 = 1714 by decide, phi1714]; decide +kernel)
private theorem phi1716 : Nat.totient 1716 = 480 := step (p := 2) (m := 858) (by decide +kernel) (by decide) phi858 (by decide +kernel)
private theorem cell858 : Covered 858 859 := singleton (i := 858) (by rw [show 2*858 = 1716 by decide, phi1716]; decide +kernel)
private theorem grid857x859 : Covered 857 859 := pair cell857 cell858
private theorem grid855x859 : Covered 855 859 := pair grid855x857 grid857x859
private theorem phi859 : Nat.totient 859 = 858 := step (p := 859) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1718 : Nat.totient 1718 = 858 := step (p := 2) (m := 859) (by decide +kernel) (by decide) phi859 (by decide +kernel)
private theorem cell859 : Covered 859 860 := singleton (i := 859) (by rw [show 2*859 = 1718 by decide, phi1718]; decide +kernel)
private theorem phi1720 : Nat.totient 1720 = 672 := step (p := 2) (m := 860) (by decide +kernel) (by decide) phi860 (by decide +kernel)
private theorem cell860 : Covered 860 861 := singleton (i := 860) (by rw [show 2*860 = 1720 by decide, phi1720]; decide +kernel)
private theorem grid859x861 : Covered 859 861 := pair cell859 cell860
private theorem phi861 : Nat.totient 861 = 480 := step (p := 3) (m := 287) (by decide +kernel) (by decide) phi287 (by decide +kernel)
private theorem phi1722 : Nat.totient 1722 = 480 := step (p := 2) (m := 861) (by decide +kernel) (by decide) phi861 (by decide +kernel)
private theorem cell861 : Covered 861 862 := singleton (i := 861) (by rw [show 2*861 = 1722 by decide, phi1722]; decide +kernel)
private theorem phi1724 : Nat.totient 1724 = 860 := step (p := 2) (m := 862) (by decide +kernel) (by decide) phi862 (by decide +kernel)
private theorem cell862 : Covered 862 863 := singleton (i := 862) (by rw [show 2*862 = 1724 by decide, phi1724]; decide +kernel)
private theorem phi863 : Nat.totient 863 = 862 := step (p := 863) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1726 : Nat.totient 1726 = 862 := step (p := 2) (m := 863) (by decide +kernel) (by decide) phi863 (by decide +kernel)
private theorem cell863 : Covered 863 864 := singleton (i := 863) (by rw [show 2*863 = 1726 by decide, phi1726]; decide +kernel)
private theorem grid862x864 : Covered 862 864 := pair cell862 cell863
private theorem grid861x864 : Covered 861 864 := pair cell861 grid862x864
private theorem grid859x864 : Covered 859 864 := pair grid859x861 grid861x864
private theorem grid855x864 : Covered 855 864 := pair grid855x859 grid859x864
private theorem phi1728 : Nat.totient 1728 = 576 := step (p := 2) (m := 864) (by decide +kernel) (by decide) phi864 (by decide +kernel)
private theorem cell864 : Covered 864 865 := singleton (i := 864) (by rw [show 2*864 = 1728 by decide, phi1728]; decide +kernel)
private theorem phi865 : Nat.totient 865 = 688 := step (p := 5) (m := 173) (by decide +kernel) (by decide) phi173 (by decide +kernel)
private theorem phi1730 : Nat.totient 1730 = 688 := step (p := 2) (m := 865) (by decide +kernel) (by decide) phi865 (by decide +kernel)
private theorem cell865 : Covered 865 866 := singleton (i := 865) (by rw [show 2*865 = 1730 by decide, phi1730]; decide +kernel)
private theorem grid864x866 : Covered 864 866 := pair cell864 cell865
private theorem phi1732 : Nat.totient 1732 = 864 := step (p := 2) (m := 866) (by decide +kernel) (by decide) phi866 (by decide +kernel)
private theorem cell866 : Covered 866 867 := singleton (i := 866) (by rw [show 2*866 = 1732 by decide, phi1732]; decide +kernel)
private theorem phi867 : Nat.totient 867 = 544 := step (p := 3) (m := 289) (by decide +kernel) (by decide) phi289 (by decide +kernel)
private theorem phi1734 : Nat.totient 1734 = 544 := step (p := 2) (m := 867) (by decide +kernel) (by decide) phi867 (by decide +kernel)
private theorem cell867 : Covered 867 868 := singleton (i := 867) (by rw [show 2*867 = 1734 by decide, phi1734]; decide +kernel)
private theorem phi1736 : Nat.totient 1736 = 720 := step (p := 2) (m := 868) (by decide +kernel) (by decide) phi868 (by decide +kernel)
private theorem cell868 : Covered 868 869 := singleton (i := 868) (by rw [show 2*868 = 1736 by decide, phi1736]; decide +kernel)
private theorem grid867x869 : Covered 867 869 := pair cell867 cell868
private theorem grid866x869 : Covered 866 869 := pair cell866 grid867x869
private theorem grid864x869 : Covered 864 869 := pair grid864x866 grid866x869
private theorem phi869 : Nat.totient 869 = 780 := step (p := 11) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem phi1738 : Nat.totient 1738 = 780 := step (p := 2) (m := 869) (by decide +kernel) (by decide) phi869 (by decide +kernel)
private theorem cell869 : Covered 869 870 := singleton (i := 869) (by rw [show 2*869 = 1738 by decide, phi1738]; decide +kernel)
private theorem phi1740 : Nat.totient 1740 = 448 := step (p := 2) (m := 870) (by decide +kernel) (by decide) phi870 (by decide +kernel)
private theorem cell870 : Covered 870 871 := singleton (i := 870) (by rw [show 2*870 = 1740 by decide, phi1740]; decide +kernel)
private theorem grid869x871 : Covered 869 871 := pair cell869 cell870
private theorem phi871 : Nat.totient 871 = 792 := step (p := 13) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi1742 : Nat.totient 1742 = 792 := step (p := 2) (m := 871) (by decide +kernel) (by decide) phi871 (by decide +kernel)
private theorem cell871 : Covered 871 872 := singleton (i := 871) (by rw [show 2*871 = 1742 by decide, phi1742]; decide +kernel)
private theorem phi1744 : Nat.totient 1744 = 864 := step (p := 2) (m := 872) (by decide +kernel) (by decide) phi872 (by decide +kernel)
private theorem cell872 : Covered 872 873 := singleton (i := 872) (by rw [show 2*872 = 1744 by decide, phi1744]; decide +kernel)
private theorem phi873 : Nat.totient 873 = 576 := step (p := 3) (m := 291) (by decide +kernel) (by decide) phi291 (by decide +kernel)
private theorem phi1746 : Nat.totient 1746 = 576 := step (p := 2) (m := 873) (by decide +kernel) (by decide) phi873 (by decide +kernel)
private theorem cell873 : Covered 873 874 := singleton (i := 873) (by rw [show 2*873 = 1746 by decide, phi1746]; decide +kernel)
private theorem grid872x874 : Covered 872 874 := pair cell872 cell873
private theorem grid871x874 : Covered 871 874 := pair cell871 grid872x874
private theorem grid869x874 : Covered 869 874 := pair grid869x871 grid871x874
private theorem grid864x874 : Covered 864 874 := pair grid864x869 grid869x874
private theorem grid855x874 : Covered 855 874 := pair grid855x864 grid864x874
private theorem grid837x874 : Covered 837 874 := pair grid837x855 grid855x874
private theorem grid801x874 : Covered 801 874 := pair grid801x837 grid837x874
private theorem grid728x874 : Covered 728 874 := pair grid728x801 grid801x874
private theorem grid583x874 : Covered 583 874 := pair grid583x728 grid728x874
private theorem phi1748 : Nat.totient 1748 = 792 := step (p := 2) (m := 874) (by decide +kernel) (by decide) phi874 (by decide +kernel)
private theorem cell874 : Covered 874 875 := singleton (i := 874) (by rw [show 2*874 = 1748 by decide, phi1748]; decide +kernel)
private theorem phi875 : Nat.totient 875 = 600 := step (p := 5) (m := 175) (by decide +kernel) (by decide) phi175 (by decide +kernel)
private theorem phi1750 : Nat.totient 1750 = 600 := step (p := 2) (m := 875) (by decide +kernel) (by decide) phi875 (by decide +kernel)
private theorem cell875 : Covered 875 876 := singleton (i := 875) (by rw [show 2*875 = 1750 by decide, phi1750]; decide +kernel)
private theorem grid874x876 : Covered 874 876 := pair cell874 cell875
private theorem phi1752 : Nat.totient 1752 = 576 := step (p := 2) (m := 876) (by decide +kernel) (by decide) phi876 (by decide +kernel)
private theorem cell876 : Covered 876 877 := singleton (i := 876) (by rw [show 2*876 = 1752 by decide, phi1752]; decide +kernel)
private theorem phi877 : Nat.totient 877 = 876 := step (p := 877) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1754 : Nat.totient 1754 = 876 := step (p := 2) (m := 877) (by decide +kernel) (by decide) phi877 (by decide +kernel)
private theorem cell877 : Covered 877 878 := singleton (i := 877) (by rw [show 2*877 = 1754 by decide, phi1754]; decide +kernel)
private theorem grid876x878 : Covered 876 878 := pair cell876 cell877
private theorem grid874x878 : Covered 874 878 := pair grid874x876 grid876x878
private theorem phi1756 : Nat.totient 1756 = 876 := step (p := 2) (m := 878) (by decide +kernel) (by decide) phi878 (by decide +kernel)
private theorem cell878 : Covered 878 879 := singleton (i := 878) (by rw [show 2*878 = 1756 by decide, phi1756]; decide +kernel)
private theorem phi879 : Nat.totient 879 = 584 := step (p := 3) (m := 293) (by decide +kernel) (by decide) phi293 (by decide +kernel)
private theorem phi1758 : Nat.totient 1758 = 584 := step (p := 2) (m := 879) (by decide +kernel) (by decide) phi879 (by decide +kernel)
private theorem cell879 : Covered 879 880 := singleton (i := 879) (by rw [show 2*879 = 1758 by decide, phi1758]; decide +kernel)
private theorem grid878x880 : Covered 878 880 := pair cell878 cell879
private theorem phi1760 : Nat.totient 1760 = 640 := step (p := 2) (m := 880) (by decide +kernel) (by decide) phi880 (by decide +kernel)
private theorem cell880 : Covered 880 881 := singleton (i := 880) (by rw [show 2*880 = 1760 by decide, phi1760]; decide +kernel)
private theorem phi881 : Nat.totient 881 = 880 := step (p := 881) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1762 : Nat.totient 1762 = 880 := step (p := 2) (m := 881) (by decide +kernel) (by decide) phi881 (by decide +kernel)
private theorem cell881 : Covered 881 882 := singleton (i := 881) (by rw [show 2*881 = 1762 by decide, phi1762]; decide +kernel)
private theorem phi1764 : Nat.totient 1764 = 504 := step (p := 2) (m := 882) (by decide +kernel) (by decide) phi882 (by decide +kernel)
private theorem cell882 : Covered 882 883 := singleton (i := 882) (by rw [show 2*882 = 1764 by decide, phi1764]; decide +kernel)
private theorem grid881x883 : Covered 881 883 := pair cell881 cell882
private theorem grid880x883 : Covered 880 883 := pair cell880 grid881x883
private theorem grid878x883 : Covered 878 883 := pair grid878x880 grid880x883
private theorem grid874x883 : Covered 874 883 := pair grid874x878 grid878x883
private theorem phi883 : Nat.totient 883 = 882 := step (p := 883) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1766 : Nat.totient 1766 = 882 := step (p := 2) (m := 883) (by decide +kernel) (by decide) phi883 (by decide +kernel)
private theorem cell883 : Covered 883 884 := singleton (i := 883) (by rw [show 2*883 = 1766 by decide, phi1766]; decide +kernel)
private theorem phi1768 : Nat.totient 1768 = 768 := step (p := 2) (m := 884) (by decide +kernel) (by decide) phi884 (by decide +kernel)
private theorem cell884 : Covered 884 885 := singleton (i := 884) (by rw [show 2*884 = 1768 by decide, phi1768]; decide +kernel)
private theorem grid883x885 : Covered 883 885 := pair cell883 cell884
private theorem phi885 : Nat.totient 885 = 464 := step (p := 3) (m := 295) (by decide +kernel) (by decide) phi295 (by decide +kernel)
private theorem phi1770 : Nat.totient 1770 = 464 := step (p := 2) (m := 885) (by decide +kernel) (by decide) phi885 (by decide +kernel)
private theorem cell885 : Covered 885 886 := singleton (i := 885) (by rw [show 2*885 = 1770 by decide, phi1770]; decide +kernel)
private theorem phi1772 : Nat.totient 1772 = 884 := step (p := 2) (m := 886) (by decide +kernel) (by decide) phi886 (by decide +kernel)
private theorem cell886 : Covered 886 887 := singleton (i := 886) (by rw [show 2*886 = 1772 by decide, phi1772]; decide +kernel)
private theorem grid885x887 : Covered 885 887 := pair cell885 cell886
private theorem grid883x887 : Covered 883 887 := pair grid883x885 grid885x887
private theorem phi887 : Nat.totient 887 = 886 := step (p := 887) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1774 : Nat.totient 1774 = 886 := step (p := 2) (m := 887) (by decide +kernel) (by decide) phi887 (by decide +kernel)
private theorem cell887 : Covered 887 888 := singleton (i := 887) (by rw [show 2*887 = 1774 by decide, phi1774]; decide +kernel)
private theorem phi1776 : Nat.totient 1776 = 576 := step (p := 2) (m := 888) (by decide +kernel) (by decide) phi888 (by decide +kernel)
private theorem cell888 : Covered 888 889 := singleton (i := 888) (by rw [show 2*888 = 1776 by decide, phi1776]; decide +kernel)
private theorem grid887x889 : Covered 887 889 := pair cell887 cell888
private theorem phi889 : Nat.totient 889 = 756 := step (p := 7) (m := 127) (by decide +kernel) (by decide) phi127 (by decide +kernel)
private theorem phi1778 : Nat.totient 1778 = 756 := step (p := 2) (m := 889) (by decide +kernel) (by decide) phi889 (by decide +kernel)
private theorem cell889 : Covered 889 890 := singleton (i := 889) (by rw [show 2*889 = 1778 by decide, phi1778]; decide +kernel)
private theorem phi1780 : Nat.totient 1780 = 704 := step (p := 2) (m := 890) (by decide +kernel) (by decide) phi890 (by decide +kernel)
private theorem cell890 : Covered 890 891 := singleton (i := 890) (by rw [show 2*890 = 1780 by decide, phi1780]; decide +kernel)
private theorem phi891 : Nat.totient 891 = 540 := step (p := 3) (m := 297) (by decide +kernel) (by decide) phi297 (by decide +kernel)
private theorem phi1782 : Nat.totient 1782 = 540 := step (p := 2) (m := 891) (by decide +kernel) (by decide) phi891 (by decide +kernel)
private theorem cell891 : Covered 891 892 := singleton (i := 891) (by rw [show 2*891 = 1782 by decide, phi1782]; decide +kernel)
private theorem grid890x892 : Covered 890 892 := pair cell890 cell891
private theorem grid889x892 : Covered 889 892 := pair cell889 grid890x892
private theorem grid887x892 : Covered 887 892 := pair grid887x889 grid889x892
private theorem grid883x892 : Covered 883 892 := pair grid883x887 grid887x892
private theorem grid874x892 : Covered 874 892 := pair grid874x883 grid883x892
private theorem phi1784 : Nat.totient 1784 = 888 := step (p := 2) (m := 892) (by decide +kernel) (by decide) phi892 (by decide +kernel)
private theorem cell892 : Covered 892 893 := singleton (i := 892) (by rw [show 2*892 = 1784 by decide, phi1784]; decide +kernel)
private theorem phi893 : Nat.totient 893 = 828 := step (p := 19) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi1786 : Nat.totient 1786 = 828 := step (p := 2) (m := 893) (by decide +kernel) (by decide) phi893 (by decide +kernel)
private theorem cell893 : Covered 893 894 := singleton (i := 893) (by rw [show 2*893 = 1786 by decide, phi1786]; decide +kernel)
private theorem grid892x894 : Covered 892 894 := pair cell892 cell893
private theorem phi1788 : Nat.totient 1788 = 592 := step (p := 2) (m := 894) (by decide +kernel) (by decide) phi894 (by decide +kernel)
private theorem cell894 : Covered 894 895 := singleton (i := 894) (by rw [show 2*894 = 1788 by decide, phi1788]; decide +kernel)
private theorem phi895 : Nat.totient 895 = 712 := step (p := 5) (m := 179) (by decide +kernel) (by decide) phi179 (by decide +kernel)
private theorem phi1790 : Nat.totient 1790 = 712 := step (p := 2) (m := 895) (by decide +kernel) (by decide) phi895 (by decide +kernel)
private theorem cell895 : Covered 895 896 := singleton (i := 895) (by rw [show 2*895 = 1790 by decide, phi1790]; decide +kernel)
private theorem grid894x896 : Covered 894 896 := pair cell894 cell895
private theorem grid892x896 : Covered 892 896 := pair grid892x894 grid894x896
private theorem phi1792 : Nat.totient 1792 = 768 := step (p := 2) (m := 896) (by decide +kernel) (by decide) phi896 (by decide +kernel)
private theorem cell896 : Covered 896 897 := singleton (i := 896) (by rw [show 2*896 = 1792 by decide, phi1792]; decide +kernel)
private theorem phi897 : Nat.totient 897 = 528 := step (p := 3) (m := 299) (by decide +kernel) (by decide) phi299 (by decide +kernel)
private theorem phi1794 : Nat.totient 1794 = 528 := step (p := 2) (m := 897) (by decide +kernel) (by decide) phi897 (by decide +kernel)
private theorem cell897 : Covered 897 898 := singleton (i := 897) (by rw [show 2*897 = 1794 by decide, phi1794]; decide +kernel)
private theorem grid896x898 : Covered 896 898 := pair cell896 cell897
private theorem phi1796 : Nat.totient 1796 = 896 := step (p := 2) (m := 898) (by decide +kernel) (by decide) phi898 (by decide +kernel)
private theorem cell898 : Covered 898 899 := singleton (i := 898) (by rw [show 2*898 = 1796 by decide, phi1796]; decide +kernel)
private theorem phi899 : Nat.totient 899 = 840 := step (p := 29) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi1798 : Nat.totient 1798 = 840 := step (p := 2) (m := 899) (by decide +kernel) (by decide) phi899 (by decide +kernel)
private theorem cell899 : Covered 899 900 := singleton (i := 899) (by rw [show 2*899 = 1798 by decide, phi1798]; decide +kernel)
private theorem phi1800 : Nat.totient 1800 = 480 := step (p := 2) (m := 900) (by decide +kernel) (by decide) phi900 (by decide +kernel)
private theorem cell900 : Covered 900 901 := singleton (i := 900) (by rw [show 2*900 = 1800 by decide, phi1800]; decide +kernel)
private theorem grid899x901 : Covered 899 901 := pair cell899 cell900
private theorem grid898x901 : Covered 898 901 := pair cell898 grid899x901
private theorem grid896x901 : Covered 896 901 := pair grid896x898 grid898x901
private theorem grid892x901 : Covered 892 901 := pair grid892x896 grid896x901
private theorem phi901 : Nat.totient 901 = 832 := step (p := 17) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi1802 : Nat.totient 1802 = 832 := step (p := 2) (m := 901) (by decide +kernel) (by decide) phi901 (by decide +kernel)
private theorem cell901 : Covered 901 902 := singleton (i := 901) (by rw [show 2*901 = 1802 by decide, phi1802]; decide +kernel)
private theorem phi1804 : Nat.totient 1804 = 800 := step (p := 2) (m := 902) (by decide +kernel) (by decide) phi902 (by decide +kernel)
private theorem cell902 : Covered 902 903 := singleton (i := 902) (by rw [show 2*902 = 1804 by decide, phi1804]; decide +kernel)
private theorem grid901x903 : Covered 901 903 := pair cell901 cell902
private theorem phi903 : Nat.totient 903 = 504 := step (p := 3) (m := 301) (by decide +kernel) (by decide) phi301 (by decide +kernel)
private theorem phi1806 : Nat.totient 1806 = 504 := step (p := 2) (m := 903) (by decide +kernel) (by decide) phi903 (by decide +kernel)
private theorem cell903 : Covered 903 904 := singleton (i := 903) (by rw [show 2*903 = 1806 by decide, phi1806]; decide +kernel)
private theorem phi1808 : Nat.totient 1808 = 896 := step (p := 2) (m := 904) (by decide +kernel) (by decide) phi904 (by decide +kernel)
private theorem cell904 : Covered 904 905 := singleton (i := 904) (by rw [show 2*904 = 1808 by decide, phi1808]; decide +kernel)
private theorem grid903x905 : Covered 903 905 := pair cell903 cell904
private theorem grid901x905 : Covered 901 905 := pair grid901x903 grid903x905
private theorem phi905 : Nat.totient 905 = 720 := step (p := 5) (m := 181) (by decide +kernel) (by decide) phi181 (by decide +kernel)
private theorem phi1810 : Nat.totient 1810 = 720 := step (p := 2) (m := 905) (by decide +kernel) (by decide) phi905 (by decide +kernel)
private theorem cell905 : Covered 905 906 := singleton (i := 905) (by rw [show 2*905 = 1810 by decide, phi1810]; decide +kernel)
private theorem phi1812 : Nat.totient 1812 = 600 := step (p := 2) (m := 906) (by decide +kernel) (by decide) phi906 (by decide +kernel)
private theorem cell906 : Covered 906 907 := singleton (i := 906) (by rw [show 2*906 = 1812 by decide, phi1812]; decide +kernel)
private theorem grid905x907 : Covered 905 907 := pair cell905 cell906
private theorem phi907 : Nat.totient 907 = 906 := step (p := 907) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1814 : Nat.totient 1814 = 906 := step (p := 2) (m := 907) (by decide +kernel) (by decide) phi907 (by decide +kernel)
private theorem cell907 : Covered 907 908 := singleton (i := 907) (by rw [show 2*907 = 1814 by decide, phi1814]; decide +kernel)
private theorem phi1816 : Nat.totient 1816 = 904 := step (p := 2) (m := 908) (by decide +kernel) (by decide) phi908 (by decide +kernel)
private theorem cell908 : Covered 908 909 := singleton (i := 908) (by rw [show 2*908 = 1816 by decide, phi1816]; decide +kernel)
private theorem phi909 : Nat.totient 909 = 600 := step (p := 3) (m := 303) (by decide +kernel) (by decide) phi303 (by decide +kernel)
private theorem phi1818 : Nat.totient 1818 = 600 := step (p := 2) (m := 909) (by decide +kernel) (by decide) phi909 (by decide +kernel)
private theorem cell909 : Covered 909 910 := singleton (i := 909) (by rw [show 2*909 = 1818 by decide, phi1818]; decide +kernel)
private theorem grid908x910 : Covered 908 910 := pair cell908 cell909
private theorem grid907x910 : Covered 907 910 := pair cell907 grid908x910
private theorem grid905x910 : Covered 905 910 := pair grid905x907 grid907x910
private theorem grid901x910 : Covered 901 910 := pair grid901x905 grid905x910
private theorem grid892x910 : Covered 892 910 := pair grid892x901 grid901x910
private theorem grid874x910 : Covered 874 910 := pair grid874x892 grid892x910
private theorem phi1820 : Nat.totient 1820 = 576 := step (p := 2) (m := 910) (by decide +kernel) (by decide) phi910 (by decide +kernel)
private theorem cell910 : Covered 910 911 := singleton (i := 910) (by rw [show 2*910 = 1820 by decide, phi1820]; decide +kernel)
private theorem phi911 : Nat.totient 911 = 910 := step (p := 911) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1822 : Nat.totient 1822 = 910 := step (p := 2) (m := 911) (by decide +kernel) (by decide) phi911 (by decide +kernel)
private theorem cell911 : Covered 911 912 := singleton (i := 911) (by rw [show 2*911 = 1822 by decide, phi1822]; decide +kernel)
private theorem grid910x912 : Covered 910 912 := pair cell910 cell911
private theorem phi1824 : Nat.totient 1824 = 576 := step (p := 2) (m := 912) (by decide +kernel) (by decide) phi912 (by decide +kernel)
private theorem cell912 : Covered 912 913 := singleton (i := 912) (by rw [show 2*912 = 1824 by decide, phi1824]; decide +kernel)
private theorem phi913 : Nat.totient 913 = 820 := step (p := 11) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem phi1826 : Nat.totient 1826 = 820 := step (p := 2) (m := 913) (by decide +kernel) (by decide) phi913 (by decide +kernel)
private theorem cell913 : Covered 913 914 := singleton (i := 913) (by rw [show 2*913 = 1826 by decide, phi1826]; decide +kernel)
private theorem grid912x914 : Covered 912 914 := pair cell912 cell913
private theorem grid910x914 : Covered 910 914 := pair grid910x912 grid912x914
private theorem phi1828 : Nat.totient 1828 = 912 := step (p := 2) (m := 914) (by decide +kernel) (by decide) phi914 (by decide +kernel)
private theorem cell914 : Covered 914 915 := singleton (i := 914) (by rw [show 2*914 = 1828 by decide, phi1828]; decide +kernel)
private theorem phi915 : Nat.totient 915 = 480 := step (p := 3) (m := 305) (by decide +kernel) (by decide) phi305 (by decide +kernel)
private theorem phi1830 : Nat.totient 1830 = 480 := step (p := 2) (m := 915) (by decide +kernel) (by decide) phi915 (by decide +kernel)
private theorem cell915 : Covered 915 916 := singleton (i := 915) (by rw [show 2*915 = 1830 by decide, phi1830]; decide +kernel)
private theorem grid914x916 : Covered 914 916 := pair cell914 cell915
private theorem phi1832 : Nat.totient 1832 = 912 := step (p := 2) (m := 916) (by decide +kernel) (by decide) phi916 (by decide +kernel)
private theorem cell916 : Covered 916 917 := singleton (i := 916) (by rw [show 2*916 = 1832 by decide, phi1832]; decide +kernel)
private theorem phi917 : Nat.totient 917 = 780 := step (p := 7) (m := 131) (by decide +kernel) (by decide) phi131 (by decide +kernel)
private theorem phi1834 : Nat.totient 1834 = 780 := step (p := 2) (m := 917) (by decide +kernel) (by decide) phi917 (by decide +kernel)
private theorem cell917 : Covered 917 918 := singleton (i := 917) (by rw [show 2*917 = 1834 by decide, phi1834]; decide +kernel)
private theorem phi1836 : Nat.totient 1836 = 576 := step (p := 2) (m := 918) (by decide +kernel) (by decide) phi918 (by decide +kernel)
private theorem cell918 : Covered 918 919 := singleton (i := 918) (by rw [show 2*918 = 1836 by decide, phi1836]; decide +kernel)
private theorem grid917x919 : Covered 917 919 := pair cell917 cell918
private theorem grid916x919 : Covered 916 919 := pair cell916 grid917x919
private theorem grid914x919 : Covered 914 919 := pair grid914x916 grid916x919
private theorem grid910x919 : Covered 910 919 := pair grid910x914 grid914x919
private theorem phi919 : Nat.totient 919 = 918 := step (p := 919) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1838 : Nat.totient 1838 = 918 := step (p := 2) (m := 919) (by decide +kernel) (by decide) phi919 (by decide +kernel)
private theorem cell919 : Covered 919 920 := singleton (i := 919) (by rw [show 2*919 = 1838 by decide, phi1838]; decide +kernel)
private theorem phi1840 : Nat.totient 1840 = 704 := step (p := 2) (m := 920) (by decide +kernel) (by decide) phi920 (by decide +kernel)
private theorem cell920 : Covered 920 921 := singleton (i := 920) (by rw [show 2*920 = 1840 by decide, phi1840]; decide +kernel)
private theorem grid919x921 : Covered 919 921 := pair cell919 cell920
private theorem phi921 : Nat.totient 921 = 612 := step (p := 3) (m := 307) (by decide +kernel) (by decide) phi307 (by decide +kernel)
private theorem phi1842 : Nat.totient 1842 = 612 := step (p := 2) (m := 921) (by decide +kernel) (by decide) phi921 (by decide +kernel)
private theorem cell921 : Covered 921 922 := singleton (i := 921) (by rw [show 2*921 = 1842 by decide, phi1842]; decide +kernel)
private theorem phi1844 : Nat.totient 1844 = 920 := step (p := 2) (m := 922) (by decide +kernel) (by decide) phi922 (by decide +kernel)
private theorem cell922 : Covered 922 923 := singleton (i := 922) (by rw [show 2*922 = 1844 by decide, phi1844]; decide +kernel)
private theorem grid921x923 : Covered 921 923 := pair cell921 cell922
private theorem grid919x923 : Covered 919 923 := pair grid919x921 grid921x923
private theorem phi923 : Nat.totient 923 = 840 := step (p := 13) (m := 71) (by decide +kernel) (by decide) phi71 (by decide +kernel)
private theorem phi1846 : Nat.totient 1846 = 840 := step (p := 2) (m := 923) (by decide +kernel) (by decide) phi923 (by decide +kernel)
private theorem cell923 : Covered 923 924 := singleton (i := 923) (by rw [show 2*923 = 1846 by decide, phi1846]; decide +kernel)
private theorem phi1848 : Nat.totient 1848 = 480 := step (p := 2) (m := 924) (by decide +kernel) (by decide) phi924 (by decide +kernel)
private theorem cell924 : Covered 924 925 := singleton (i := 924) (by rw [show 2*924 = 1848 by decide, phi1848]; decide +kernel)
private theorem grid923x925 : Covered 923 925 := pair cell923 cell924
private theorem phi925 : Nat.totient 925 = 720 := step (p := 5) (m := 185) (by decide +kernel) (by decide) phi185 (by decide +kernel)
private theorem phi1850 : Nat.totient 1850 = 720 := step (p := 2) (m := 925) (by decide +kernel) (by decide) phi925 (by decide +kernel)
private theorem cell925 : Covered 925 926 := singleton (i := 925) (by rw [show 2*925 = 1850 by decide, phi1850]; decide +kernel)
private theorem phi1852 : Nat.totient 1852 = 924 := step (p := 2) (m := 926) (by decide +kernel) (by decide) phi926 (by decide +kernel)
private theorem cell926 : Covered 926 927 := singleton (i := 926) (by rw [show 2*926 = 1852 by decide, phi1852]; decide +kernel)
private theorem phi927 : Nat.totient 927 = 612 := step (p := 3) (m := 309) (by decide +kernel) (by decide) phi309 (by decide +kernel)
private theorem phi1854 : Nat.totient 1854 = 612 := step (p := 2) (m := 927) (by decide +kernel) (by decide) phi927 (by decide +kernel)
private theorem cell927 : Covered 927 928 := singleton (i := 927) (by rw [show 2*927 = 1854 by decide, phi1854]; decide +kernel)
private theorem grid926x928 : Covered 926 928 := pair cell926 cell927
private theorem grid925x928 : Covered 925 928 := pair cell925 grid926x928
private theorem grid923x928 : Covered 923 928 := pair grid923x925 grid925x928
private theorem grid919x928 : Covered 919 928 := pair grid919x923 grid923x928
private theorem grid910x928 : Covered 910 928 := pair grid910x919 grid919x928
private theorem phi1856 : Nat.totient 1856 = 896 := step (p := 2) (m := 928) (by decide +kernel) (by decide) phi928 (by decide +kernel)
private theorem cell928 : Covered 928 929 := singleton (i := 928) (by rw [show 2*928 = 1856 by decide, phi1856]; decide +kernel)
private theorem phi929 : Nat.totient 929 = 928 := step (p := 929) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1858 : Nat.totient 1858 = 928 := step (p := 2) (m := 929) (by decide +kernel) (by decide) phi929 (by decide +kernel)
private theorem cell929 : Covered 929 930 := singleton (i := 929) (by rw [show 2*929 = 1858 by decide, phi1858]; decide +kernel)
private theorem grid928x930 : Covered 928 930 := pair cell928 cell929
private theorem phi1860 : Nat.totient 1860 = 480 := step (p := 2) (m := 930) (by decide +kernel) (by decide) phi930 (by decide +kernel)
private theorem cell930 : Covered 930 931 := singleton (i := 930) (by rw [show 2*930 = 1860 by decide, phi1860]; decide +kernel)
private theorem phi931 : Nat.totient 931 = 756 := step (p := 7) (m := 133) (by decide +kernel) (by decide) phi133 (by decide +kernel)
private theorem phi1862 : Nat.totient 1862 = 756 := step (p := 2) (m := 931) (by decide +kernel) (by decide) phi931 (by decide +kernel)
private theorem cell931 : Covered 931 932 := singleton (i := 931) (by rw [show 2*931 = 1862 by decide, phi1862]; decide +kernel)
private theorem grid930x932 : Covered 930 932 := pair cell930 cell931
private theorem grid928x932 : Covered 928 932 := pair grid928x930 grid930x932
private theorem phi1864 : Nat.totient 1864 = 928 := step (p := 2) (m := 932) (by decide +kernel) (by decide) phi932 (by decide +kernel)
private theorem cell932 : Covered 932 933 := singleton (i := 932) (by rw [show 2*932 = 1864 by decide, phi1864]; decide +kernel)
private theorem phi933 : Nat.totient 933 = 620 := step (p := 3) (m := 311) (by decide +kernel) (by decide) phi311 (by decide +kernel)
private theorem phi1866 : Nat.totient 1866 = 620 := step (p := 2) (m := 933) (by decide +kernel) (by decide) phi933 (by decide +kernel)
private theorem cell933 : Covered 933 934 := singleton (i := 933) (by rw [show 2*933 = 1866 by decide, phi1866]; decide +kernel)
private theorem grid932x934 : Covered 932 934 := pair cell932 cell933
private theorem phi1868 : Nat.totient 1868 = 932 := step (p := 2) (m := 934) (by decide +kernel) (by decide) phi934 (by decide +kernel)
private theorem cell934 : Covered 934 935 := singleton (i := 934) (by rw [show 2*934 = 1868 by decide, phi1868]; decide +kernel)
private theorem phi935 : Nat.totient 935 = 640 := step (p := 5) (m := 187) (by decide +kernel) (by decide) phi187 (by decide +kernel)
private theorem phi1870 : Nat.totient 1870 = 640 := step (p := 2) (m := 935) (by decide +kernel) (by decide) phi935 (by decide +kernel)
private theorem cell935 : Covered 935 936 := singleton (i := 935) (by rw [show 2*935 = 1870 by decide, phi1870]; decide +kernel)
private theorem phi1872 : Nat.totient 1872 = 576 := step (p := 2) (m := 936) (by decide +kernel) (by decide) phi936 (by decide +kernel)
private theorem cell936 : Covered 936 937 := singleton (i := 936) (by rw [show 2*936 = 1872 by decide, phi1872]; decide +kernel)
private theorem grid935x937 : Covered 935 937 := pair cell935 cell936
private theorem grid934x937 : Covered 934 937 := pair cell934 grid935x937
private theorem grid932x937 : Covered 932 937 := pair grid932x934 grid934x937
private theorem grid928x937 : Covered 928 937 := pair grid928x932 grid932x937
private theorem phi937 : Nat.totient 937 = 936 := step (p := 937) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1874 : Nat.totient 1874 = 936 := step (p := 2) (m := 937) (by decide +kernel) (by decide) phi937 (by decide +kernel)
private theorem cell937 : Covered 937 938 := singleton (i := 937) (by rw [show 2*937 = 1874 by decide, phi1874]; decide +kernel)
private theorem phi1876 : Nat.totient 1876 = 792 := step (p := 2) (m := 938) (by decide +kernel) (by decide) phi938 (by decide +kernel)
private theorem cell938 : Covered 938 939 := singleton (i := 938) (by rw [show 2*938 = 1876 by decide, phi1876]; decide +kernel)
private theorem grid937x939 : Covered 937 939 := pair cell937 cell938
private theorem phi939 : Nat.totient 939 = 624 := step (p := 3) (m := 313) (by decide +kernel) (by decide) phi313 (by decide +kernel)
private theorem phi1878 : Nat.totient 1878 = 624 := step (p := 2) (m := 939) (by decide +kernel) (by decide) phi939 (by decide +kernel)
private theorem cell939 : Covered 939 940 := singleton (i := 939) (by rw [show 2*939 = 1878 by decide, phi1878]; decide +kernel)
private theorem phi1880 : Nat.totient 1880 = 736 := step (p := 2) (m := 940) (by decide +kernel) (by decide) phi940 (by decide +kernel)
private theorem cell940 : Covered 940 941 := singleton (i := 940) (by rw [show 2*940 = 1880 by decide, phi1880]; decide +kernel)
private theorem phi941 : Nat.totient 941 = 940 := step (p := 941) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1882 : Nat.totient 1882 = 940 := step (p := 2) (m := 941) (by decide +kernel) (by decide) phi941 (by decide +kernel)
private theorem cell941 : Covered 941 942 := singleton (i := 941) (by rw [show 2*941 = 1882 by decide, phi1882]; decide +kernel)
private theorem grid940x942 : Covered 940 942 := pair cell940 cell941
private theorem grid939x942 : Covered 939 942 := pair cell939 grid940x942
private theorem grid937x942 : Covered 937 942 := pair grid937x939 grid939x942
private theorem phi1884 : Nat.totient 1884 = 624 := step (p := 2) (m := 942) (by decide +kernel) (by decide) phi942 (by decide +kernel)
private theorem cell942 : Covered 942 943 := singleton (i := 942) (by rw [show 2*942 = 1884 by decide, phi1884]; decide +kernel)
private theorem phi943 : Nat.totient 943 = 880 := step (p := 23) (m := 41) (by decide +kernel) (by decide) phi41 (by decide +kernel)
private theorem phi1886 : Nat.totient 1886 = 880 := step (p := 2) (m := 943) (by decide +kernel) (by decide) phi943 (by decide +kernel)
private theorem cell943 : Covered 943 944 := singleton (i := 943) (by rw [show 2*943 = 1886 by decide, phi1886]; decide +kernel)
private theorem grid942x944 : Covered 942 944 := pair cell942 cell943
private theorem phi1888 : Nat.totient 1888 = 928 := step (p := 2) (m := 944) (by decide +kernel) (by decide) phi944 (by decide +kernel)
private theorem cell944 : Covered 944 945 := singleton (i := 944) (by rw [show 2*944 = 1888 by decide, phi1888]; decide +kernel)
private theorem phi945 : Nat.totient 945 = 432 := step (p := 3) (m := 315) (by decide +kernel) (by decide) phi315 (by decide +kernel)
private theorem phi1890 : Nat.totient 1890 = 432 := step (p := 2) (m := 945) (by decide +kernel) (by decide) phi945 (by decide +kernel)
private theorem cell945 : Covered 945 946 := singleton (i := 945) (by rw [show 2*945 = 1890 by decide, phi1890]; decide +kernel)
private theorem phi1892 : Nat.totient 1892 = 840 := step (p := 2) (m := 946) (by decide +kernel) (by decide) phi946 (by decide +kernel)
private theorem cell946 : Covered 946 947 := singleton (i := 946) (by rw [show 2*946 = 1892 by decide, phi1892]; decide +kernel)
private theorem grid945x947 : Covered 945 947 := pair cell945 cell946
private theorem grid944x947 : Covered 944 947 := pair cell944 grid945x947
private theorem grid942x947 : Covered 942 947 := pair grid942x944 grid944x947
private theorem grid937x947 : Covered 937 947 := pair grid937x942 grid942x947
private theorem grid928x947 : Covered 928 947 := pair grid928x937 grid937x947
private theorem grid910x947 : Covered 910 947 := pair grid910x928 grid928x947
private theorem grid874x947 : Covered 874 947 := pair grid874x910 grid910x947
private theorem phi947 : Nat.totient 947 = 946 := step (p := 947) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1894 : Nat.totient 1894 = 946 := step (p := 2) (m := 947) (by decide +kernel) (by decide) phi947 (by decide +kernel)
private theorem cell947 : Covered 947 948 := singleton (i := 947) (by rw [show 2*947 = 1894 by decide, phi1894]; decide +kernel)
private theorem phi1896 : Nat.totient 1896 = 624 := step (p := 2) (m := 948) (by decide +kernel) (by decide) phi948 (by decide +kernel)
private theorem cell948 : Covered 948 949 := singleton (i := 948) (by rw [show 2*948 = 1896 by decide, phi1896]; decide +kernel)
private theorem grid947x949 : Covered 947 949 := pair cell947 cell948
private theorem phi949 : Nat.totient 949 = 864 := step (p := 13) (m := 73) (by decide +kernel) (by decide) phi73 (by decide +kernel)
private theorem phi1898 : Nat.totient 1898 = 864 := step (p := 2) (m := 949) (by decide +kernel) (by decide) phi949 (by decide +kernel)
private theorem cell949 : Covered 949 950 := singleton (i := 949) (by rw [show 2*949 = 1898 by decide, phi1898]; decide +kernel)
private theorem phi1900 : Nat.totient 1900 = 720 := step (p := 2) (m := 950) (by decide +kernel) (by decide) phi950 (by decide +kernel)
private theorem cell950 : Covered 950 951 := singleton (i := 950) (by rw [show 2*950 = 1900 by decide, phi1900]; decide +kernel)
private theorem grid949x951 : Covered 949 951 := pair cell949 cell950
private theorem grid947x951 : Covered 947 951 := pair grid947x949 grid949x951
private theorem phi951 : Nat.totient 951 = 632 := step (p := 3) (m := 317) (by decide +kernel) (by decide) phi317 (by decide +kernel)
private theorem phi1902 : Nat.totient 1902 = 632 := step (p := 2) (m := 951) (by decide +kernel) (by decide) phi951 (by decide +kernel)
private theorem cell951 : Covered 951 952 := singleton (i := 951) (by rw [show 2*951 = 1902 by decide, phi1902]; decide +kernel)
private theorem phi1904 : Nat.totient 1904 = 768 := step (p := 2) (m := 952) (by decide +kernel) (by decide) phi952 (by decide +kernel)
private theorem cell952 : Covered 952 953 := singleton (i := 952) (by rw [show 2*952 = 1904 by decide, phi1904]; decide +kernel)
private theorem grid951x953 : Covered 951 953 := pair cell951 cell952
private theorem phi953 : Nat.totient 953 = 952 := step (p := 953) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1906 : Nat.totient 1906 = 952 := step (p := 2) (m := 953) (by decide +kernel) (by decide) phi953 (by decide +kernel)
private theorem cell953 : Covered 953 954 := singleton (i := 953) (by rw [show 2*953 = 1906 by decide, phi1906]; decide +kernel)
private theorem phi1908 : Nat.totient 1908 = 624 := step (p := 2) (m := 954) (by decide +kernel) (by decide) phi954 (by decide +kernel)
private theorem cell954 : Covered 954 955 := singleton (i := 954) (by rw [show 2*954 = 1908 by decide, phi1908]; decide +kernel)
private theorem phi955 : Nat.totient 955 = 760 := step (p := 5) (m := 191) (by decide +kernel) (by decide) phi191 (by decide +kernel)
private theorem phi1910 : Nat.totient 1910 = 760 := step (p := 2) (m := 955) (by decide +kernel) (by decide) phi955 (by decide +kernel)
private theorem cell955 : Covered 955 956 := singleton (i := 955) (by rw [show 2*955 = 1910 by decide, phi1910]; decide +kernel)
private theorem grid954x956 : Covered 954 956 := pair cell954 cell955
private theorem grid953x956 : Covered 953 956 := pair cell953 grid954x956
private theorem grid951x956 : Covered 951 956 := pair grid951x953 grid953x956
private theorem grid947x956 : Covered 947 956 := pair grid947x951 grid951x956
private theorem phi1912 : Nat.totient 1912 = 952 := step (p := 2) (m := 956) (by decide +kernel) (by decide) phi956 (by decide +kernel)
private theorem cell956 : Covered 956 957 := singleton (i := 956) (by rw [show 2*956 = 1912 by decide, phi1912]; decide +kernel)
private theorem phi957 : Nat.totient 957 = 560 := step (p := 3) (m := 319) (by decide +kernel) (by decide) phi319 (by decide +kernel)
private theorem phi1914 : Nat.totient 1914 = 560 := step (p := 2) (m := 957) (by decide +kernel) (by decide) phi957 (by decide +kernel)
private theorem cell957 : Covered 957 958 := singleton (i := 957) (by rw [show 2*957 = 1914 by decide, phi1914]; decide +kernel)
private theorem grid956x958 : Covered 956 958 := pair cell956 cell957
private theorem phi1916 : Nat.totient 1916 = 956 := step (p := 2) (m := 958) (by decide +kernel) (by decide) phi958 (by decide +kernel)
private theorem cell958 : Covered 958 959 := singleton (i := 958) (by rw [show 2*958 = 1916 by decide, phi1916]; decide +kernel)
private theorem phi959 : Nat.totient 959 = 816 := step (p := 7) (m := 137) (by decide +kernel) (by decide) phi137 (by decide +kernel)
private theorem phi1918 : Nat.totient 1918 = 816 := step (p := 2) (m := 959) (by decide +kernel) (by decide) phi959 (by decide +kernel)
private theorem cell959 : Covered 959 960 := singleton (i := 959) (by rw [show 2*959 = 1918 by decide, phi1918]; decide +kernel)
private theorem grid958x960 : Covered 958 960 := pair cell958 cell959
private theorem grid956x960 : Covered 956 960 := pair grid956x958 grid958x960
private theorem phi1920 : Nat.totient 1920 = 512 := step (p := 2) (m := 960) (by decide +kernel) (by decide) phi960 (by decide +kernel)
private theorem cell960 : Covered 960 961 := singleton (i := 960) (by rw [show 2*960 = 1920 by decide, phi1920]; decide +kernel)
private theorem phi961 : Nat.totient 961 = 930 := step (p := 31) (m := 31) (by decide +kernel) (by decide) phi31 (by decide +kernel)
private theorem phi1922 : Nat.totient 1922 = 930 := step (p := 2) (m := 961) (by decide +kernel) (by decide) phi961 (by decide +kernel)
private theorem cell961 : Covered 961 962 := singleton (i := 961) (by rw [show 2*961 = 1922 by decide, phi1922]; decide +kernel)
private theorem grid960x962 : Covered 960 962 := pair cell960 cell961
private theorem phi1924 : Nat.totient 1924 = 864 := step (p := 2) (m := 962) (by decide +kernel) (by decide) phi962 (by decide +kernel)
private theorem cell962 : Covered 962 963 := singleton (i := 962) (by rw [show 2*962 = 1924 by decide, phi1924]; decide +kernel)
private theorem phi963 : Nat.totient 963 = 636 := step (p := 3) (m := 321) (by decide +kernel) (by decide) phi321 (by decide +kernel)
private theorem phi1926 : Nat.totient 1926 = 636 := step (p := 2) (m := 963) (by decide +kernel) (by decide) phi963 (by decide +kernel)
private theorem cell963 : Covered 963 964 := singleton (i := 963) (by rw [show 2*963 = 1926 by decide, phi1926]; decide +kernel)
private theorem phi1928 : Nat.totient 1928 = 960 := step (p := 2) (m := 964) (by decide +kernel) (by decide) phi964 (by decide +kernel)
private theorem cell964 : Covered 964 965 := singleton (i := 964) (by rw [show 2*964 = 1928 by decide, phi1928]; decide +kernel)
private theorem grid963x965 : Covered 963 965 := pair cell963 cell964
private theorem grid962x965 : Covered 962 965 := pair cell962 grid963x965
private theorem grid960x965 : Covered 960 965 := pair grid960x962 grid962x965
private theorem grid956x965 : Covered 956 965 := pair grid956x960 grid960x965
private theorem grid947x965 : Covered 947 965 := pair grid947x956 grid956x965
private theorem phi965 : Nat.totient 965 = 768 := step (p := 5) (m := 193) (by decide +kernel) (by decide) phi193 (by decide +kernel)
private theorem phi1930 : Nat.totient 1930 = 768 := step (p := 2) (m := 965) (by decide +kernel) (by decide) phi965 (by decide +kernel)
private theorem cell965 : Covered 965 966 := singleton (i := 965) (by rw [show 2*965 = 1930 by decide, phi1930]; decide +kernel)
private theorem phi1932 : Nat.totient 1932 = 528 := step (p := 2) (m := 966) (by decide +kernel) (by decide) phi966 (by decide +kernel)
private theorem cell966 : Covered 966 967 := singleton (i := 966) (by rw [show 2*966 = 1932 by decide, phi1932]; decide +kernel)
private theorem grid965x967 : Covered 965 967 := pair cell965 cell966
private theorem phi967 : Nat.totient 967 = 966 := step (p := 967) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1934 : Nat.totient 1934 = 966 := step (p := 2) (m := 967) (by decide +kernel) (by decide) phi967 (by decide +kernel)
private theorem cell967 : Covered 967 968 := singleton (i := 967) (by rw [show 2*967 = 1934 by decide, phi1934]; decide +kernel)
private theorem phi1936 : Nat.totient 1936 = 880 := step (p := 2) (m := 968) (by decide +kernel) (by decide) phi968 (by decide +kernel)
private theorem cell968 : Covered 968 969 := singleton (i := 968) (by rw [show 2*968 = 1936 by decide, phi1936]; decide +kernel)
private theorem grid967x969 : Covered 967 969 := pair cell967 cell968
private theorem grid965x969 : Covered 965 969 := pair grid965x967 grid967x969
private theorem phi969 : Nat.totient 969 = 576 := step (p := 3) (m := 323) (by decide +kernel) (by decide) phi323 (by decide +kernel)
private theorem phi1938 : Nat.totient 1938 = 576 := step (p := 2) (m := 969) (by decide +kernel) (by decide) phi969 (by decide +kernel)
private theorem cell969 : Covered 969 970 := singleton (i := 969) (by rw [show 2*969 = 1938 by decide, phi1938]; decide +kernel)
private theorem phi1940 : Nat.totient 1940 = 768 := step (p := 2) (m := 970) (by decide +kernel) (by decide) phi970 (by decide +kernel)
private theorem cell970 : Covered 970 971 := singleton (i := 970) (by rw [show 2*970 = 1940 by decide, phi1940]; decide +kernel)
private theorem grid969x971 : Covered 969 971 := pair cell969 cell970
private theorem phi971 : Nat.totient 971 = 970 := step (p := 971) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1942 : Nat.totient 1942 = 970 := step (p := 2) (m := 971) (by decide +kernel) (by decide) phi971 (by decide +kernel)
private theorem cell971 : Covered 971 972 := singleton (i := 971) (by rw [show 2*971 = 1942 by decide, phi1942]; decide +kernel)
private theorem phi1944 : Nat.totient 1944 = 648 := step (p := 2) (m := 972) (by decide +kernel) (by decide) phi972 (by decide +kernel)
private theorem cell972 : Covered 972 973 := singleton (i := 972) (by rw [show 2*972 = 1944 by decide, phi1944]; decide +kernel)
private theorem phi973 : Nat.totient 973 = 828 := step (p := 7) (m := 139) (by decide +kernel) (by decide) phi139 (by decide +kernel)
private theorem phi1946 : Nat.totient 1946 = 828 := step (p := 2) (m := 973) (by decide +kernel) (by decide) phi973 (by decide +kernel)
private theorem cell973 : Covered 973 974 := singleton (i := 973) (by rw [show 2*973 = 1946 by decide, phi1946]; decide +kernel)
private theorem grid972x974 : Covered 972 974 := pair cell972 cell973
private theorem grid971x974 : Covered 971 974 := pair cell971 grid972x974
private theorem grid969x974 : Covered 969 974 := pair grid969x971 grid971x974
private theorem grid965x974 : Covered 965 974 := pair grid965x969 grid969x974
private theorem phi1948 : Nat.totient 1948 = 972 := step (p := 2) (m := 974) (by decide +kernel) (by decide) phi974 (by decide +kernel)
private theorem cell974 : Covered 974 975 := singleton (i := 974) (by rw [show 2*974 = 1948 by decide, phi1948]; decide +kernel)
private theorem phi975 : Nat.totient 975 = 480 := step (p := 3) (m := 325) (by decide +kernel) (by decide) phi325 (by decide +kernel)
private theorem phi1950 : Nat.totient 1950 = 480 := step (p := 2) (m := 975) (by decide +kernel) (by decide) phi975 (by decide +kernel)
private theorem cell975 : Covered 975 976 := singleton (i := 975) (by rw [show 2*975 = 1950 by decide, phi1950]; decide +kernel)
private theorem grid974x976 : Covered 974 976 := pair cell974 cell975
private theorem phi1952 : Nat.totient 1952 = 960 := step (p := 2) (m := 976) (by decide +kernel) (by decide) phi976 (by decide +kernel)
private theorem cell976 : Covered 976 977 := singleton (i := 976) (by rw [show 2*976 = 1952 by decide, phi1952]; decide +kernel)
private theorem phi977 : Nat.totient 977 = 976 := step (p := 977) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1954 : Nat.totient 1954 = 976 := step (p := 2) (m := 977) (by decide +kernel) (by decide) phi977 (by decide +kernel)
private theorem cell977 : Covered 977 978 := singleton (i := 977) (by rw [show 2*977 = 1954 by decide, phi1954]; decide +kernel)
private theorem grid976x978 : Covered 976 978 := pair cell976 cell977
private theorem grid974x978 : Covered 974 978 := pair grid974x976 grid976x978
private theorem phi1956 : Nat.totient 1956 = 648 := step (p := 2) (m := 978) (by decide +kernel) (by decide) phi978 (by decide +kernel)
private theorem cell978 : Covered 978 979 := singleton (i := 978) (by rw [show 2*978 = 1956 by decide, phi1956]; decide +kernel)
private theorem phi979 : Nat.totient 979 = 880 := step (p := 11) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem phi1958 : Nat.totient 1958 = 880 := step (p := 2) (m := 979) (by decide +kernel) (by decide) phi979 (by decide +kernel)
private theorem cell979 : Covered 979 980 := singleton (i := 979) (by rw [show 2*979 = 1958 by decide, phi1958]; decide +kernel)
private theorem grid978x980 : Covered 978 980 := pair cell978 cell979
private theorem phi1960 : Nat.totient 1960 = 672 := step (p := 2) (m := 980) (by decide +kernel) (by decide) phi980 (by decide +kernel)
private theorem cell980 : Covered 980 981 := singleton (i := 980) (by rw [show 2*980 = 1960 by decide, phi1960]; decide +kernel)
private theorem phi981 : Nat.totient 981 = 648 := step (p := 3) (m := 327) (by decide +kernel) (by decide) phi327 (by decide +kernel)
private theorem phi1962 : Nat.totient 1962 = 648 := step (p := 2) (m := 981) (by decide +kernel) (by decide) phi981 (by decide +kernel)
private theorem cell981 : Covered 981 982 := singleton (i := 981) (by rw [show 2*981 = 1962 by decide, phi1962]; decide +kernel)
private theorem phi1964 : Nat.totient 1964 = 980 := step (p := 2) (m := 982) (by decide +kernel) (by decide) phi982 (by decide +kernel)
private theorem cell982 : Covered 982 983 := singleton (i := 982) (by rw [show 2*982 = 1964 by decide, phi1964]; decide +kernel)
private theorem grid981x983 : Covered 981 983 := pair cell981 cell982
private theorem grid980x983 : Covered 980 983 := pair cell980 grid981x983
private theorem grid978x983 : Covered 978 983 := pair grid978x980 grid980x983
private theorem grid974x983 : Covered 974 983 := pair grid974x978 grid978x983
private theorem grid965x983 : Covered 965 983 := pair grid965x974 grid974x983
private theorem grid947x983 : Covered 947 983 := pair grid947x965 grid965x983
private theorem phi983 : Nat.totient 983 = 982 := step (p := 983) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1966 : Nat.totient 1966 = 982 := step (p := 2) (m := 983) (by decide +kernel) (by decide) phi983 (by decide +kernel)
private theorem cell983 : Covered 983 984 := singleton (i := 983) (by rw [show 2*983 = 1966 by decide, phi1966]; decide +kernel)
private theorem phi1968 : Nat.totient 1968 = 640 := step (p := 2) (m := 984) (by decide +kernel) (by decide) phi984 (by decide +kernel)
private theorem cell984 : Covered 984 985 := singleton (i := 984) (by rw [show 2*984 = 1968 by decide, phi1968]; decide +kernel)
private theorem grid983x985 : Covered 983 985 := pair cell983 cell984
private theorem phi985 : Nat.totient 985 = 784 := step (p := 5) (m := 197) (by decide +kernel) (by decide) phi197 (by decide +kernel)
private theorem phi1970 : Nat.totient 1970 = 784 := step (p := 2) (m := 985) (by decide +kernel) (by decide) phi985 (by decide +kernel)
private theorem cell985 : Covered 985 986 := singleton (i := 985) (by rw [show 2*985 = 1970 by decide, phi1970]; decide +kernel)
private theorem phi1972 : Nat.totient 1972 = 896 := step (p := 2) (m := 986) (by decide +kernel) (by decide) phi986 (by decide +kernel)
private theorem cell986 : Covered 986 987 := singleton (i := 986) (by rw [show 2*986 = 1972 by decide, phi1972]; decide +kernel)
private theorem grid985x987 : Covered 985 987 := pair cell985 cell986
private theorem grid983x987 : Covered 983 987 := pair grid983x985 grid985x987
private theorem phi987 : Nat.totient 987 = 552 := step (p := 3) (m := 329) (by decide +kernel) (by decide) phi329 (by decide +kernel)
private theorem phi1974 : Nat.totient 1974 = 552 := step (p := 2) (m := 987) (by decide +kernel) (by decide) phi987 (by decide +kernel)
private theorem cell987 : Covered 987 988 := singleton (i := 987) (by rw [show 2*987 = 1974 by decide, phi1974]; decide +kernel)
private theorem phi1976 : Nat.totient 1976 = 864 := step (p := 2) (m := 988) (by decide +kernel) (by decide) phi988 (by decide +kernel)
private theorem cell988 : Covered 988 989 := singleton (i := 988) (by rw [show 2*988 = 1976 by decide, phi1976]; decide +kernel)
private theorem grid987x989 : Covered 987 989 := pair cell987 cell988
private theorem phi989 : Nat.totient 989 = 924 := step (p := 23) (m := 43) (by decide +kernel) (by decide) phi43 (by decide +kernel)
private theorem phi1978 : Nat.totient 1978 = 924 := step (p := 2) (m := 989) (by decide +kernel) (by decide) phi989 (by decide +kernel)
private theorem cell989 : Covered 989 990 := singleton (i := 989) (by rw [show 2*989 = 1978 by decide, phi1978]; decide +kernel)
private theorem phi1980 : Nat.totient 1980 = 480 := step (p := 2) (m := 990) (by decide +kernel) (by decide) phi990 (by decide +kernel)
private theorem cell990 : Covered 990 991 := singleton (i := 990) (by rw [show 2*990 = 1980 by decide, phi1980]; decide +kernel)
private theorem phi991 : Nat.totient 991 = 990 := step (p := 991) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1982 : Nat.totient 1982 = 990 := step (p := 2) (m := 991) (by decide +kernel) (by decide) phi991 (by decide +kernel)
private theorem cell991 : Covered 991 992 := singleton (i := 991) (by rw [show 2*991 = 1982 by decide, phi1982]; decide +kernel)
private theorem grid990x992 : Covered 990 992 := pair cell990 cell991
private theorem grid989x992 : Covered 989 992 := pair cell989 grid990x992
private theorem grid987x992 : Covered 987 992 := pair grid987x989 grid989x992
private theorem grid983x992 : Covered 983 992 := pair grid983x987 grid987x992
private theorem phi1984 : Nat.totient 1984 = 960 := step (p := 2) (m := 992) (by decide +kernel) (by decide) phi992 (by decide +kernel)
private theorem cell992 : Covered 992 993 := singleton (i := 992) (by rw [show 2*992 = 1984 by decide, phi1984]; decide +kernel)
private theorem phi993 : Nat.totient 993 = 660 := step (p := 3) (m := 331) (by decide +kernel) (by decide) phi331 (by decide +kernel)
private theorem phi1986 : Nat.totient 1986 = 660 := step (p := 2) (m := 993) (by decide +kernel) (by decide) phi993 (by decide +kernel)
private theorem cell993 : Covered 993 994 := singleton (i := 993) (by rw [show 2*993 = 1986 by decide, phi1986]; decide +kernel)
private theorem grid992x994 : Covered 992 994 := pair cell992 cell993
private theorem phi1988 : Nat.totient 1988 = 840 := step (p := 2) (m := 994) (by decide +kernel) (by decide) phi994 (by decide +kernel)
private theorem cell994 : Covered 994 995 := singleton (i := 994) (by rw [show 2*994 = 1988 by decide, phi1988]; decide +kernel)
private theorem phi995 : Nat.totient 995 = 792 := step (p := 5) (m := 199) (by decide +kernel) (by decide) phi199 (by decide +kernel)
private theorem phi1990 : Nat.totient 1990 = 792 := step (p := 2) (m := 995) (by decide +kernel) (by decide) phi995 (by decide +kernel)
private theorem cell995 : Covered 995 996 := singleton (i := 995) (by rw [show 2*995 = 1990 by decide, phi1990]; decide +kernel)
private theorem grid994x996 : Covered 994 996 := pair cell994 cell995
private theorem grid992x996 : Covered 992 996 := pair grid992x994 grid994x996
private theorem phi1992 : Nat.totient 1992 = 656 := step (p := 2) (m := 996) (by decide +kernel) (by decide) phi996 (by decide +kernel)
private theorem cell996 : Covered 996 997 := singleton (i := 996) (by rw [show 2*996 = 1992 by decide, phi1992]; decide +kernel)
private theorem phi997 : Nat.totient 997 = 996 := step (p := 997) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi1994 : Nat.totient 1994 = 996 := step (p := 2) (m := 997) (by decide +kernel) (by decide) phi997 (by decide +kernel)
private theorem cell997 : Covered 997 998 := singleton (i := 997) (by rw [show 2*997 = 1994 by decide, phi1994]; decide +kernel)
private theorem grid996x998 : Covered 996 998 := pair cell996 cell997
private theorem phi1996 : Nat.totient 1996 = 996 := step (p := 2) (m := 998) (by decide +kernel) (by decide) phi998 (by decide +kernel)
private theorem cell998 : Covered 998 999 := singleton (i := 998) (by rw [show 2*998 = 1996 by decide, phi1996]; decide +kernel)
private theorem phi999 : Nat.totient 999 = 648 := step (p := 3) (m := 333) (by decide +kernel) (by decide) phi333 (by decide +kernel)
private theorem phi1998 : Nat.totient 1998 = 648 := step (p := 2) (m := 999) (by decide +kernel) (by decide) phi999 (by decide +kernel)
private theorem cell999 : Covered 999 1000 := singleton (i := 999) (by rw [show 2*999 = 1998 by decide, phi1998]; decide +kernel)
private theorem phi2000 : Nat.totient 2000 = 800 := step (p := 2) (m := 1000) (by decide +kernel) (by decide) phi1000 (by decide +kernel)
private theorem cell1000 : Covered 1000 1001 := singleton (i := 1000) (by rw [show 2*1000 = 2000 by decide, phi2000]; decide +kernel)
private theorem grid999x1001 : Covered 999 1001 := pair cell999 cell1000
private theorem grid998x1001 : Covered 998 1001 := pair cell998 grid999x1001
private theorem grid996x1001 : Covered 996 1001 := pair grid996x998 grid998x1001
private theorem grid992x1001 : Covered 992 1001 := pair grid992x996 grid996x1001
private theorem grid983x1001 : Covered 983 1001 := pair grid983x992 grid992x1001
private theorem phi1001 : Nat.totient 1001 = 720 := step (p := 7) (m := 143) (by decide +kernel) (by decide) phi143 (by decide +kernel)
private theorem phi2002 : Nat.totient 2002 = 720 := step (p := 2) (m := 1001) (by decide +kernel) (by decide) phi1001 (by decide +kernel)
private theorem cell1001 : Covered 1001 1002 := singleton (i := 1001) (by rw [show 2*1001 = 2002 by decide, phi2002]; decide +kernel)
private theorem phi2004 : Nat.totient 2004 = 664 := step (p := 2) (m := 1002) (by decide +kernel) (by decide) phi1002 (by decide +kernel)
private theorem cell1002 : Covered 1002 1003 := singleton (i := 1002) (by rw [show 2*1002 = 2004 by decide, phi2004]; decide +kernel)
private theorem grid1001x1003 : Covered 1001 1003 := pair cell1001 cell1002
private theorem phi1003 : Nat.totient 1003 = 928 := step (p := 17) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi2006 : Nat.totient 2006 = 928 := step (p := 2) (m := 1003) (by decide +kernel) (by decide) phi1003 (by decide +kernel)
private theorem cell1003 : Covered 1003 1004 := singleton (i := 1003) (by rw [show 2*1003 = 2006 by decide, phi2006]; decide +kernel)
private theorem phi2008 : Nat.totient 2008 = 1000 := step (p := 2) (m := 1004) (by decide +kernel) (by decide) phi1004 (by decide +kernel)
private theorem cell1004 : Covered 1004 1005 := singleton (i := 1004) (by rw [show 2*1004 = 2008 by decide, phi2008]; decide +kernel)
private theorem grid1003x1005 : Covered 1003 1005 := pair cell1003 cell1004
private theorem grid1001x1005 : Covered 1001 1005 := pair grid1001x1003 grid1003x1005
private theorem phi1005 : Nat.totient 1005 = 528 := step (p := 3) (m := 335) (by decide +kernel) (by decide) phi335 (by decide +kernel)
private theorem phi2010 : Nat.totient 2010 = 528 := step (p := 2) (m := 1005) (by decide +kernel) (by decide) phi1005 (by decide +kernel)
private theorem cell1005 : Covered 1005 1006 := singleton (i := 1005) (by rw [show 2*1005 = 2010 by decide, phi2010]; decide +kernel)
private theorem phi2012 : Nat.totient 2012 = 1004 := step (p := 2) (m := 1006) (by decide +kernel) (by decide) phi1006 (by decide +kernel)
private theorem cell1006 : Covered 1006 1007 := singleton (i := 1006) (by rw [show 2*1006 = 2012 by decide, phi2012]; decide +kernel)
private theorem grid1005x1007 : Covered 1005 1007 := pair cell1005 cell1006
private theorem phi1007 : Nat.totient 1007 = 936 := step (p := 19) (m := 53) (by decide +kernel) (by decide) phi53 (by decide +kernel)
private theorem phi2014 : Nat.totient 2014 = 936 := step (p := 2) (m := 1007) (by decide +kernel) (by decide) phi1007 (by decide +kernel)
private theorem cell1007 : Covered 1007 1008 := singleton (i := 1007) (by rw [show 2*1007 = 2014 by decide, phi2014]; decide +kernel)
private theorem phi2016 : Nat.totient 2016 = 576 := step (p := 2) (m := 1008) (by decide +kernel) (by decide) phi1008 (by decide +kernel)
private theorem cell1008 : Covered 1008 1009 := singleton (i := 1008) (by rw [show 2*1008 = 2016 by decide, phi2016]; decide +kernel)
private theorem phi1009 : Nat.totient 1009 = 1008 := step (p := 1009) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2018 : Nat.totient 2018 = 1008 := step (p := 2) (m := 1009) (by decide +kernel) (by decide) phi1009 (by decide +kernel)
private theorem cell1009 : Covered 1009 1010 := singleton (i := 1009) (by rw [show 2*1009 = 2018 by decide, phi2018]; decide +kernel)
private theorem grid1008x1010 : Covered 1008 1010 := pair cell1008 cell1009
private theorem grid1007x1010 : Covered 1007 1010 := pair cell1007 grid1008x1010
private theorem grid1005x1010 : Covered 1005 1010 := pair grid1005x1007 grid1007x1010
private theorem grid1001x1010 : Covered 1001 1010 := pair grid1001x1005 grid1005x1010
private theorem phi2020 : Nat.totient 2020 = 800 := step (p := 2) (m := 1010) (by decide +kernel) (by decide) phi1010 (by decide +kernel)
private theorem cell1010 : Covered 1010 1011 := singleton (i := 1010) (by rw [show 2*1010 = 2020 by decide, phi2020]; decide +kernel)
private theorem phi1011 : Nat.totient 1011 = 672 := step (p := 3) (m := 337) (by decide +kernel) (by decide) phi337 (by decide +kernel)
private theorem phi2022 : Nat.totient 2022 = 672 := step (p := 2) (m := 1011) (by decide +kernel) (by decide) phi1011 (by decide +kernel)
private theorem cell1011 : Covered 1011 1012 := singleton (i := 1011) (by rw [show 2*1011 = 2022 by decide, phi2022]; decide +kernel)
private theorem grid1010x1012 : Covered 1010 1012 := pair cell1010 cell1011
private theorem phi2024 : Nat.totient 2024 = 880 := step (p := 2) (m := 1012) (by decide +kernel) (by decide) phi1012 (by decide +kernel)
private theorem cell1012 : Covered 1012 1013 := singleton (i := 1012) (by rw [show 2*1012 = 2024 by decide, phi2024]; decide +kernel)
private theorem phi1013 : Nat.totient 1013 = 1012 := step (p := 1013) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2026 : Nat.totient 2026 = 1012 := step (p := 2) (m := 1013) (by decide +kernel) (by decide) phi1013 (by decide +kernel)
private theorem cell1013 : Covered 1013 1014 := singleton (i := 1013) (by rw [show 2*1013 = 2026 by decide, phi2026]; decide +kernel)
private theorem phi2028 : Nat.totient 2028 = 624 := step (p := 2) (m := 1014) (by decide +kernel) (by decide) phi1014 (by decide +kernel)
private theorem cell1014 : Covered 1014 1015 := singleton (i := 1014) (by rw [show 2*1014 = 2028 by decide, phi2028]; decide +kernel)
private theorem grid1013x1015 : Covered 1013 1015 := pair cell1013 cell1014
private theorem grid1012x1015 : Covered 1012 1015 := pair cell1012 grid1013x1015
private theorem grid1010x1015 : Covered 1010 1015 := pair grid1010x1012 grid1012x1015
private theorem phi1015 : Nat.totient 1015 = 672 := step (p := 5) (m := 203) (by decide +kernel) (by decide) phi203 (by decide +kernel)
private theorem phi2030 : Nat.totient 2030 = 672 := step (p := 2) (m := 1015) (by decide +kernel) (by decide) phi1015 (by decide +kernel)
private theorem cell1015 : Covered 1015 1016 := singleton (i := 1015) (by rw [show 2*1015 = 2030 by decide, phi2030]; decide +kernel)
private theorem phi2032 : Nat.totient 2032 = 1008 := step (p := 2) (m := 1016) (by decide +kernel) (by decide) phi1016 (by decide +kernel)
private theorem cell1016 : Covered 1016 1017 := singleton (i := 1016) (by rw [show 2*1016 = 2032 by decide, phi2032]; decide +kernel)
private theorem grid1015x1017 : Covered 1015 1017 := pair cell1015 cell1016
private theorem phi1017 : Nat.totient 1017 = 672 := step (p := 3) (m := 339) (by decide +kernel) (by decide) phi339 (by decide +kernel)
private theorem phi2034 : Nat.totient 2034 = 672 := step (p := 2) (m := 1017) (by decide +kernel) (by decide) phi1017 (by decide +kernel)
private theorem cell1017 : Covered 1017 1018 := singleton (i := 1017) (by rw [show 2*1017 = 2034 by decide, phi2034]; decide +kernel)
private theorem phi2036 : Nat.totient 2036 = 1016 := step (p := 2) (m := 1018) (by decide +kernel) (by decide) phi1018 (by decide +kernel)
private theorem cell1018 : Covered 1018 1019 := singleton (i := 1018) (by rw [show 2*1018 = 2036 by decide, phi2036]; decide +kernel)
private theorem phi1019 : Nat.totient 1019 = 1018 := step (p := 1019) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2038 : Nat.totient 2038 = 1018 := step (p := 2) (m := 1019) (by decide +kernel) (by decide) phi1019 (by decide +kernel)
private theorem cell1019 : Covered 1019 1020 := singleton (i := 1019) (by rw [show 2*1019 = 2038 by decide, phi2038]; decide +kernel)
private theorem grid1018x1020 : Covered 1018 1020 := pair cell1018 cell1019
private theorem grid1017x1020 : Covered 1017 1020 := pair cell1017 grid1018x1020
private theorem grid1015x1020 : Covered 1015 1020 := pair grid1015x1017 grid1017x1020
private theorem grid1010x1020 : Covered 1010 1020 := pair grid1010x1015 grid1015x1020
private theorem grid1001x1020 : Covered 1001 1020 := pair grid1001x1010 grid1010x1020
private theorem grid983x1020 : Covered 983 1020 := pair grid983x1001 grid1001x1020
private theorem grid947x1020 : Covered 947 1020 := pair grid947x983 grid983x1020
private theorem grid874x1020 : Covered 874 1020 := pair grid874x947 grid947x1020
private theorem phi2040 : Nat.totient 2040 = 512 := step (p := 2) (m := 1020) (by decide +kernel) (by decide) phi1020 (by decide +kernel)
private theorem cell1020 : Covered 1020 1021 := singleton (i := 1020) (by rw [show 2*1020 = 2040 by decide, phi2040]; decide +kernel)
private theorem phi1021 : Nat.totient 1021 = 1020 := step (p := 1021) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2042 : Nat.totient 2042 = 1020 := step (p := 2) (m := 1021) (by decide +kernel) (by decide) phi1021 (by decide +kernel)
private theorem cell1021 : Covered 1021 1022 := singleton (i := 1021) (by rw [show 2*1021 = 2042 by decide, phi2042]; decide +kernel)
private theorem grid1020x1022 : Covered 1020 1022 := pair cell1020 cell1021
private theorem phi2044 : Nat.totient 2044 = 864 := step (p := 2) (m := 1022) (by decide +kernel) (by decide) phi1022 (by decide +kernel)
private theorem cell1022 : Covered 1022 1023 := singleton (i := 1022) (by rw [show 2*1022 = 2044 by decide, phi2044]; decide +kernel)
private theorem phi1023 : Nat.totient 1023 = 600 := step (p := 3) (m := 341) (by decide +kernel) (by decide) phi341 (by decide +kernel)
private theorem phi2046 : Nat.totient 2046 = 600 := step (p := 2) (m := 1023) (by decide +kernel) (by decide) phi1023 (by decide +kernel)
private theorem cell1023 : Covered 1023 1024 := singleton (i := 1023) (by rw [show 2*1023 = 2046 by decide, phi2046]; decide +kernel)
private theorem grid1022x1024 : Covered 1022 1024 := pair cell1022 cell1023
private theorem grid1020x1024 : Covered 1020 1024 := pair grid1020x1022 grid1022x1024
private theorem phi2048 : Nat.totient 2048 = 1024 := step (p := 2) (m := 1024) (by decide +kernel) (by decide) phi1024 (by decide +kernel)
private theorem cell1024 : Covered 1024 1025 := singleton (i := 1024) (by rw [show 2*1024 = 2048 by decide, phi2048]; decide +kernel)
private theorem phi1025 : Nat.totient 1025 = 800 := step (p := 5) (m := 205) (by decide +kernel) (by decide) phi205 (by decide +kernel)
private theorem phi2050 : Nat.totient 2050 = 800 := step (p := 2) (m := 1025) (by decide +kernel) (by decide) phi1025 (by decide +kernel)
private theorem cell1025 : Covered 1025 1026 := singleton (i := 1025) (by rw [show 2*1025 = 2050 by decide, phi2050]; decide +kernel)
private theorem grid1024x1026 : Covered 1024 1026 := pair cell1024 cell1025
private theorem phi2052 : Nat.totient 2052 = 648 := step (p := 2) (m := 1026) (by decide +kernel) (by decide) phi1026 (by decide +kernel)
private theorem cell1026 : Covered 1026 1027 := singleton (i := 1026) (by rw [show 2*1026 = 2052 by decide, phi2052]; decide +kernel)
private theorem phi1027 : Nat.totient 1027 = 936 := step (p := 13) (m := 79) (by decide +kernel) (by decide) phi79 (by decide +kernel)
private theorem phi2054 : Nat.totient 2054 = 936 := step (p := 2) (m := 1027) (by decide +kernel) (by decide) phi1027 (by decide +kernel)
private theorem cell1027 : Covered 1027 1028 := singleton (i := 1027) (by rw [show 2*1027 = 2054 by decide, phi2054]; decide +kernel)
private theorem phi2056 : Nat.totient 2056 = 1024 := step (p := 2) (m := 1028) (by decide +kernel) (by decide) phi1028 (by decide +kernel)
private theorem cell1028 : Covered 1028 1029 := singleton (i := 1028) (by rw [show 2*1028 = 2056 by decide, phi2056]; decide +kernel)
private theorem grid1027x1029 : Covered 1027 1029 := pair cell1027 cell1028
private theorem grid1026x1029 : Covered 1026 1029 := pair cell1026 grid1027x1029
private theorem grid1024x1029 : Covered 1024 1029 := pair grid1024x1026 grid1026x1029
private theorem grid1020x1029 : Covered 1020 1029 := pair grid1020x1024 grid1024x1029
private theorem phi1029 : Nat.totient 1029 = 588 := step (p := 3) (m := 343) (by decide +kernel) (by decide) phi343 (by decide +kernel)
private theorem phi2058 : Nat.totient 2058 = 588 := step (p := 2) (m := 1029) (by decide +kernel) (by decide) phi1029 (by decide +kernel)
private theorem cell1029 : Covered 1029 1030 := singleton (i := 1029) (by rw [show 2*1029 = 2058 by decide, phi2058]; decide +kernel)
private theorem phi2060 : Nat.totient 2060 = 816 := step (p := 2) (m := 1030) (by decide +kernel) (by decide) phi1030 (by decide +kernel)
private theorem cell1030 : Covered 1030 1031 := singleton (i := 1030) (by rw [show 2*1030 = 2060 by decide, phi2060]; decide +kernel)
private theorem grid1029x1031 : Covered 1029 1031 := pair cell1029 cell1030
private theorem phi1031 : Nat.totient 1031 = 1030 := step (p := 1031) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2062 : Nat.totient 2062 = 1030 := step (p := 2) (m := 1031) (by decide +kernel) (by decide) phi1031 (by decide +kernel)
private theorem cell1031 : Covered 1031 1032 := singleton (i := 1031) (by rw [show 2*1031 = 2062 by decide, phi2062]; decide +kernel)
private theorem phi2064 : Nat.totient 2064 = 672 := step (p := 2) (m := 1032) (by decide +kernel) (by decide) phi1032 (by decide +kernel)
private theorem cell1032 : Covered 1032 1033 := singleton (i := 1032) (by rw [show 2*1032 = 2064 by decide, phi2064]; decide +kernel)
private theorem grid1031x1033 : Covered 1031 1033 := pair cell1031 cell1032
private theorem grid1029x1033 : Covered 1029 1033 := pair grid1029x1031 grid1031x1033
private theorem phi1033 : Nat.totient 1033 = 1032 := step (p := 1033) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2066 : Nat.totient 2066 = 1032 := step (p := 2) (m := 1033) (by decide +kernel) (by decide) phi1033 (by decide +kernel)
private theorem cell1033 : Covered 1033 1034 := singleton (i := 1033) (by rw [show 2*1033 = 2066 by decide, phi2066]; decide +kernel)
private theorem phi2068 : Nat.totient 2068 = 920 := step (p := 2) (m := 1034) (by decide +kernel) (by decide) phi1034 (by decide +kernel)
private theorem cell1034 : Covered 1034 1035 := singleton (i := 1034) (by rw [show 2*1034 = 2068 by decide, phi2068]; decide +kernel)
private theorem grid1033x1035 : Covered 1033 1035 := pair cell1033 cell1034
private theorem phi1035 : Nat.totient 1035 = 528 := step (p := 3) (m := 345) (by decide +kernel) (by decide) phi345 (by decide +kernel)
private theorem phi2070 : Nat.totient 2070 = 528 := step (p := 2) (m := 1035) (by decide +kernel) (by decide) phi1035 (by decide +kernel)
private theorem cell1035 : Covered 1035 1036 := singleton (i := 1035) (by rw [show 2*1035 = 2070 by decide, phi2070]; decide +kernel)
private theorem phi2072 : Nat.totient 2072 = 864 := step (p := 2) (m := 1036) (by decide +kernel) (by decide) phi1036 (by decide +kernel)
private theorem cell1036 : Covered 1036 1037 := singleton (i := 1036) (by rw [show 2*1036 = 2072 by decide, phi2072]; decide +kernel)
private theorem phi1037 : Nat.totient 1037 = 960 := step (p := 17) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi2074 : Nat.totient 2074 = 960 := step (p := 2) (m := 1037) (by decide +kernel) (by decide) phi1037 (by decide +kernel)
private theorem cell1037 : Covered 1037 1038 := singleton (i := 1037) (by rw [show 2*1037 = 2074 by decide, phi2074]; decide +kernel)
private theorem grid1036x1038 : Covered 1036 1038 := pair cell1036 cell1037
private theorem grid1035x1038 : Covered 1035 1038 := pair cell1035 grid1036x1038
private theorem grid1033x1038 : Covered 1033 1038 := pair grid1033x1035 grid1035x1038
private theorem grid1029x1038 : Covered 1029 1038 := pair grid1029x1033 grid1033x1038
private theorem grid1020x1038 : Covered 1020 1038 := pair grid1020x1029 grid1029x1038
private theorem phi2076 : Nat.totient 2076 = 688 := step (p := 2) (m := 1038) (by decide +kernel) (by decide) phi1038 (by decide +kernel)
private theorem cell1038 : Covered 1038 1039 := singleton (i := 1038) (by rw [show 2*1038 = 2076 by decide, phi2076]; decide +kernel)
private theorem phi1039 : Nat.totient 1039 = 1038 := step (p := 1039) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2078 : Nat.totient 2078 = 1038 := step (p := 2) (m := 1039) (by decide +kernel) (by decide) phi1039 (by decide +kernel)
private theorem cell1039 : Covered 1039 1040 := singleton (i := 1039) (by rw [show 2*1039 = 2078 by decide, phi2078]; decide +kernel)
private theorem grid1038x1040 : Covered 1038 1040 := pair cell1038 cell1039
private theorem phi2080 : Nat.totient 2080 = 768 := step (p := 2) (m := 1040) (by decide +kernel) (by decide) phi1040 (by decide +kernel)
private theorem cell1040 : Covered 1040 1041 := singleton (i := 1040) (by rw [show 2*1040 = 2080 by decide, phi2080]; decide +kernel)
private theorem phi1041 : Nat.totient 1041 = 692 := step (p := 3) (m := 347) (by decide +kernel) (by decide) phi347 (by decide +kernel)
private theorem phi2082 : Nat.totient 2082 = 692 := step (p := 2) (m := 1041) (by decide +kernel) (by decide) phi1041 (by decide +kernel)
private theorem cell1041 : Covered 1041 1042 := singleton (i := 1041) (by rw [show 2*1041 = 2082 by decide, phi2082]; decide +kernel)
private theorem grid1040x1042 : Covered 1040 1042 := pair cell1040 cell1041
private theorem grid1038x1042 : Covered 1038 1042 := pair grid1038x1040 grid1040x1042
private theorem phi2084 : Nat.totient 2084 = 1040 := step (p := 2) (m := 1042) (by decide +kernel) (by decide) phi1042 (by decide +kernel)
private theorem cell1042 : Covered 1042 1043 := singleton (i := 1042) (by rw [show 2*1042 = 2084 by decide, phi2084]; decide +kernel)
private theorem phi1043 : Nat.totient 1043 = 888 := step (p := 7) (m := 149) (by decide +kernel) (by decide) phi149 (by decide +kernel)
private theorem phi2086 : Nat.totient 2086 = 888 := step (p := 2) (m := 1043) (by decide +kernel) (by decide) phi1043 (by decide +kernel)
private theorem cell1043 : Covered 1043 1044 := singleton (i := 1043) (by rw [show 2*1043 = 2086 by decide, phi2086]; decide +kernel)
private theorem grid1042x1044 : Covered 1042 1044 := pair cell1042 cell1043
private theorem phi2088 : Nat.totient 2088 = 672 := step (p := 2) (m := 1044) (by decide +kernel) (by decide) phi1044 (by decide +kernel)
private theorem cell1044 : Covered 1044 1045 := singleton (i := 1044) (by rw [show 2*1044 = 2088 by decide, phi2088]; decide +kernel)
private theorem phi1045 : Nat.totient 1045 = 720 := step (p := 5) (m := 209) (by decide +kernel) (by decide) phi209 (by decide +kernel)
private theorem phi2090 : Nat.totient 2090 = 720 := step (p := 2) (m := 1045) (by decide +kernel) (by decide) phi1045 (by decide +kernel)
private theorem cell1045 : Covered 1045 1046 := singleton (i := 1045) (by rw [show 2*1045 = 2090 by decide, phi2090]; decide +kernel)
private theorem phi2092 : Nat.totient 2092 = 1044 := step (p := 2) (m := 1046) (by decide +kernel) (by decide) phi1046 (by decide +kernel)
private theorem cell1046 : Covered 1046 1047 := singleton (i := 1046) (by rw [show 2*1046 = 2092 by decide, phi2092]; decide +kernel)
private theorem grid1045x1047 : Covered 1045 1047 := pair cell1045 cell1046
private theorem grid1044x1047 : Covered 1044 1047 := pair cell1044 grid1045x1047
private theorem grid1042x1047 : Covered 1042 1047 := pair grid1042x1044 grid1044x1047
private theorem grid1038x1047 : Covered 1038 1047 := pair grid1038x1042 grid1042x1047
private theorem phi1047 : Nat.totient 1047 = 696 := step (p := 3) (m := 349) (by decide +kernel) (by decide) phi349 (by decide +kernel)
private theorem phi2094 : Nat.totient 2094 = 696 := step (p := 2) (m := 1047) (by decide +kernel) (by decide) phi1047 (by decide +kernel)
private theorem cell1047 : Covered 1047 1048 := singleton (i := 1047) (by rw [show 2*1047 = 2094 by decide, phi2094]; decide +kernel)
private theorem phi2096 : Nat.totient 2096 = 1040 := step (p := 2) (m := 1048) (by decide +kernel) (by decide) phi1048 (by decide +kernel)
private theorem cell1048 : Covered 1048 1049 := singleton (i := 1048) (by rw [show 2*1048 = 2096 by decide, phi2096]; decide +kernel)
private theorem grid1047x1049 : Covered 1047 1049 := pair cell1047 cell1048
private theorem phi1049 : Nat.totient 1049 = 1048 := step (p := 1049) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2098 : Nat.totient 2098 = 1048 := step (p := 2) (m := 1049) (by decide +kernel) (by decide) phi1049 (by decide +kernel)
private theorem cell1049 : Covered 1049 1050 := singleton (i := 1049) (by rw [show 2*1049 = 2098 by decide, phi2098]; decide +kernel)
private theorem phi2100 : Nat.totient 2100 = 480 := step (p := 2) (m := 1050) (by decide +kernel) (by decide) phi1050 (by decide +kernel)
private theorem cell1050 : Covered 1050 1051 := singleton (i := 1050) (by rw [show 2*1050 = 2100 by decide, phi2100]; decide +kernel)
private theorem grid1049x1051 : Covered 1049 1051 := pair cell1049 cell1050
private theorem grid1047x1051 : Covered 1047 1051 := pair grid1047x1049 grid1049x1051
private theorem phi1051 : Nat.totient 1051 = 1050 := step (p := 1051) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2102 : Nat.totient 2102 = 1050 := step (p := 2) (m := 1051) (by decide +kernel) (by decide) phi1051 (by decide +kernel)
private theorem cell1051 : Covered 1051 1052 := singleton (i := 1051) (by rw [show 2*1051 = 2102 by decide, phi2102]; decide +kernel)
private theorem phi2104 : Nat.totient 2104 = 1048 := step (p := 2) (m := 1052) (by decide +kernel) (by decide) phi1052 (by decide +kernel)
private theorem cell1052 : Covered 1052 1053 := singleton (i := 1052) (by rw [show 2*1052 = 2104 by decide, phi2104]; decide +kernel)
private theorem grid1051x1053 : Covered 1051 1053 := pair cell1051 cell1052
private theorem phi1053 : Nat.totient 1053 = 648 := step (p := 3) (m := 351) (by decide +kernel) (by decide) phi351 (by decide +kernel)
private theorem phi2106 : Nat.totient 2106 = 648 := step (p := 2) (m := 1053) (by decide +kernel) (by decide) phi1053 (by decide +kernel)
private theorem cell1053 : Covered 1053 1054 := singleton (i := 1053) (by rw [show 2*1053 = 2106 by decide, phi2106]; decide +kernel)
private theorem phi2108 : Nat.totient 2108 = 960 := step (p := 2) (m := 1054) (by decide +kernel) (by decide) phi1054 (by decide +kernel)
private theorem cell1054 : Covered 1054 1055 := singleton (i := 1054) (by rw [show 2*1054 = 2108 by decide, phi2108]; decide +kernel)
private theorem phi1055 : Nat.totient 1055 = 840 := step (p := 5) (m := 211) (by decide +kernel) (by decide) phi211 (by decide +kernel)
private theorem phi2110 : Nat.totient 2110 = 840 := step (p := 2) (m := 1055) (by decide +kernel) (by decide) phi1055 (by decide +kernel)
private theorem cell1055 : Covered 1055 1056 := singleton (i := 1055) (by rw [show 2*1055 = 2110 by decide, phi2110]; decide +kernel)
private theorem grid1054x1056 : Covered 1054 1056 := pair cell1054 cell1055
private theorem grid1053x1056 : Covered 1053 1056 := pair cell1053 grid1054x1056
private theorem grid1051x1056 : Covered 1051 1056 := pair grid1051x1053 grid1053x1056
private theorem grid1047x1056 : Covered 1047 1056 := pair grid1047x1051 grid1051x1056
private theorem grid1038x1056 : Covered 1038 1056 := pair grid1038x1047 grid1047x1056
private theorem grid1020x1056 : Covered 1020 1056 := pair grid1020x1038 grid1038x1056
private theorem phi2112 : Nat.totient 2112 = 640 := step (p := 2) (m := 1056) (by decide +kernel) (by decide) phi1056 (by decide +kernel)
private theorem cell1056 : Covered 1056 1057 := singleton (i := 1056) (by rw [show 2*1056 = 2112 by decide, phi2112]; decide +kernel)
private theorem phi1057 : Nat.totient 1057 = 900 := step (p := 7) (m := 151) (by decide +kernel) (by decide) phi151 (by decide +kernel)
private theorem phi2114 : Nat.totient 2114 = 900 := step (p := 2) (m := 1057) (by decide +kernel) (by decide) phi1057 (by decide +kernel)
private theorem cell1057 : Covered 1057 1058 := singleton (i := 1057) (by rw [show 2*1057 = 2114 by decide, phi2114]; decide +kernel)
private theorem grid1056x1058 : Covered 1056 1058 := pair cell1056 cell1057
private theorem phi2116 : Nat.totient 2116 = 1012 := step (p := 2) (m := 1058) (by decide +kernel) (by decide) phi1058 (by decide +kernel)
private theorem cell1058 : Covered 1058 1059 := singleton (i := 1058) (by rw [show 2*1058 = 2116 by decide, phi2116]; decide +kernel)
private theorem phi1059 : Nat.totient 1059 = 704 := step (p := 3) (m := 353) (by decide +kernel) (by decide) phi353 (by decide +kernel)
private theorem phi2118 : Nat.totient 2118 = 704 := step (p := 2) (m := 1059) (by decide +kernel) (by decide) phi1059 (by decide +kernel)
private theorem cell1059 : Covered 1059 1060 := singleton (i := 1059) (by rw [show 2*1059 = 2118 by decide, phi2118]; decide +kernel)
private theorem grid1058x1060 : Covered 1058 1060 := pair cell1058 cell1059
private theorem grid1056x1060 : Covered 1056 1060 := pair grid1056x1058 grid1058x1060
private theorem phi2120 : Nat.totient 2120 = 832 := step (p := 2) (m := 1060) (by decide +kernel) (by decide) phi1060 (by decide +kernel)
private theorem cell1060 : Covered 1060 1061 := singleton (i := 1060) (by rw [show 2*1060 = 2120 by decide, phi2120]; decide +kernel)
private theorem phi1061 : Nat.totient 1061 = 1060 := step (p := 1061) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2122 : Nat.totient 2122 = 1060 := step (p := 2) (m := 1061) (by decide +kernel) (by decide) phi1061 (by decide +kernel)
private theorem cell1061 : Covered 1061 1062 := singleton (i := 1061) (by rw [show 2*1061 = 2122 by decide, phi2122]; decide +kernel)
private theorem grid1060x1062 : Covered 1060 1062 := pair cell1060 cell1061
private theorem phi2124 : Nat.totient 2124 = 696 := step (p := 2) (m := 1062) (by decide +kernel) (by decide) phi1062 (by decide +kernel)
private theorem cell1062 : Covered 1062 1063 := singleton (i := 1062) (by rw [show 2*1062 = 2124 by decide, phi2124]; decide +kernel)
private theorem phi1063 : Nat.totient 1063 = 1062 := step (p := 1063) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2126 : Nat.totient 2126 = 1062 := step (p := 2) (m := 1063) (by decide +kernel) (by decide) phi1063 (by decide +kernel)
private theorem cell1063 : Covered 1063 1064 := singleton (i := 1063) (by rw [show 2*1063 = 2126 by decide, phi2126]; decide +kernel)
private theorem phi2128 : Nat.totient 2128 = 864 := step (p := 2) (m := 1064) (by decide +kernel) (by decide) phi1064 (by decide +kernel)
private theorem cell1064 : Covered 1064 1065 := singleton (i := 1064) (by rw [show 2*1064 = 2128 by decide, phi2128]; decide +kernel)
private theorem grid1063x1065 : Covered 1063 1065 := pair cell1063 cell1064
private theorem grid1062x1065 : Covered 1062 1065 := pair cell1062 grid1063x1065
private theorem grid1060x1065 : Covered 1060 1065 := pair grid1060x1062 grid1062x1065
private theorem grid1056x1065 : Covered 1056 1065 := pair grid1056x1060 grid1060x1065
private theorem phi1065 : Nat.totient 1065 = 560 := step (p := 3) (m := 355) (by decide +kernel) (by decide) phi355 (by decide +kernel)
private theorem phi2130 : Nat.totient 2130 = 560 := step (p := 2) (m := 1065) (by decide +kernel) (by decide) phi1065 (by decide +kernel)
private theorem cell1065 : Covered 1065 1066 := singleton (i := 1065) (by rw [show 2*1065 = 2130 by decide, phi2130]; decide +kernel)
private theorem phi2132 : Nat.totient 2132 = 960 := step (p := 2) (m := 1066) (by decide +kernel) (by decide) phi1066 (by decide +kernel)
private theorem cell1066 : Covered 1066 1067 := singleton (i := 1066) (by rw [show 2*1066 = 2132 by decide, phi2132]; decide +kernel)
private theorem grid1065x1067 : Covered 1065 1067 := pair cell1065 cell1066
private theorem phi1067 : Nat.totient 1067 = 960 := step (p := 11) (m := 97) (by decide +kernel) (by decide) phi97 (by decide +kernel)
private theorem phi2134 : Nat.totient 2134 = 960 := step (p := 2) (m := 1067) (by decide +kernel) (by decide) phi1067 (by decide +kernel)
private theorem cell1067 : Covered 1067 1068 := singleton (i := 1067) (by rw [show 2*1067 = 2134 by decide, phi2134]; decide +kernel)
private theorem phi2136 : Nat.totient 2136 = 704 := step (p := 2) (m := 1068) (by decide +kernel) (by decide) phi1068 (by decide +kernel)
private theorem cell1068 : Covered 1068 1069 := singleton (i := 1068) (by rw [show 2*1068 = 2136 by decide, phi2136]; decide +kernel)
private theorem grid1067x1069 : Covered 1067 1069 := pair cell1067 cell1068
private theorem grid1065x1069 : Covered 1065 1069 := pair grid1065x1067 grid1067x1069
private theorem phi1069 : Nat.totient 1069 = 1068 := step (p := 1069) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2138 : Nat.totient 2138 = 1068 := step (p := 2) (m := 1069) (by decide +kernel) (by decide) phi1069 (by decide +kernel)
private theorem cell1069 : Covered 1069 1070 := singleton (i := 1069) (by rw [show 2*1069 = 2138 by decide, phi2138]; decide +kernel)
private theorem phi2140 : Nat.totient 2140 = 848 := step (p := 2) (m := 1070) (by decide +kernel) (by decide) phi1070 (by decide +kernel)
private theorem cell1070 : Covered 1070 1071 := singleton (i := 1070) (by rw [show 2*1070 = 2140 by decide, phi2140]; decide +kernel)
private theorem grid1069x1071 : Covered 1069 1071 := pair cell1069 cell1070
private theorem phi1071 : Nat.totient 1071 = 576 := step (p := 3) (m := 357) (by decide +kernel) (by decide) phi357 (by decide +kernel)
private theorem phi2142 : Nat.totient 2142 = 576 := step (p := 2) (m := 1071) (by decide +kernel) (by decide) phi1071 (by decide +kernel)
private theorem cell1071 : Covered 1071 1072 := singleton (i := 1071) (by rw [show 2*1071 = 2142 by decide, phi2142]; decide +kernel)
private theorem phi2144 : Nat.totient 2144 = 1056 := step (p := 2) (m := 1072) (by decide +kernel) (by decide) phi1072 (by decide +kernel)
private theorem cell1072 : Covered 1072 1073 := singleton (i := 1072) (by rw [show 2*1072 = 2144 by decide, phi2144]; decide +kernel)
private theorem phi1073 : Nat.totient 1073 = 1008 := step (p := 29) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi2146 : Nat.totient 2146 = 1008 := step (p := 2) (m := 1073) (by decide +kernel) (by decide) phi1073 (by decide +kernel)
private theorem cell1073 : Covered 1073 1074 := singleton (i := 1073) (by rw [show 2*1073 = 2146 by decide, phi2146]; decide +kernel)
private theorem grid1072x1074 : Covered 1072 1074 := pair cell1072 cell1073
private theorem grid1071x1074 : Covered 1071 1074 := pair cell1071 grid1072x1074
private theorem grid1069x1074 : Covered 1069 1074 := pair grid1069x1071 grid1071x1074
private theorem grid1065x1074 : Covered 1065 1074 := pair grid1065x1069 grid1069x1074
private theorem grid1056x1074 : Covered 1056 1074 := pair grid1056x1065 grid1065x1074
private theorem phi2148 : Nat.totient 2148 = 712 := step (p := 2) (m := 1074) (by decide +kernel) (by decide) phi1074 (by decide +kernel)
private theorem cell1074 : Covered 1074 1075 := singleton (i := 1074) (by rw [show 2*1074 = 2148 by decide, phi2148]; decide +kernel)
private theorem phi1075 : Nat.totient 1075 = 840 := step (p := 5) (m := 215) (by decide +kernel) (by decide) phi215 (by decide +kernel)
private theorem phi2150 : Nat.totient 2150 = 840 := step (p := 2) (m := 1075) (by decide +kernel) (by decide) phi1075 (by decide +kernel)
private theorem cell1075 : Covered 1075 1076 := singleton (i := 1075) (by rw [show 2*1075 = 2150 by decide, phi2150]; decide +kernel)
private theorem grid1074x1076 : Covered 1074 1076 := pair cell1074 cell1075
private theorem phi2152 : Nat.totient 2152 = 1072 := step (p := 2) (m := 1076) (by decide +kernel) (by decide) phi1076 (by decide +kernel)
private theorem cell1076 : Covered 1076 1077 := singleton (i := 1076) (by rw [show 2*1076 = 2152 by decide, phi2152]; decide +kernel)
private theorem phi1077 : Nat.totient 1077 = 716 := step (p := 3) (m := 359) (by decide +kernel) (by decide) phi359 (by decide +kernel)
private theorem phi2154 : Nat.totient 2154 = 716 := step (p := 2) (m := 1077) (by decide +kernel) (by decide) phi1077 (by decide +kernel)
private theorem cell1077 : Covered 1077 1078 := singleton (i := 1077) (by rw [show 2*1077 = 2154 by decide, phi2154]; decide +kernel)
private theorem grid1076x1078 : Covered 1076 1078 := pair cell1076 cell1077
private theorem grid1074x1078 : Covered 1074 1078 := pair grid1074x1076 grid1076x1078
private theorem phi2156 : Nat.totient 2156 = 840 := step (p := 2) (m := 1078) (by decide +kernel) (by decide) phi1078 (by decide +kernel)
private theorem cell1078 : Covered 1078 1079 := singleton (i := 1078) (by rw [show 2*1078 = 2156 by decide, phi2156]; decide +kernel)
private theorem phi1079 : Nat.totient 1079 = 984 := step (p := 13) (m := 83) (by decide +kernel) (by decide) phi83 (by decide +kernel)
private theorem phi2158 : Nat.totient 2158 = 984 := step (p := 2) (m := 1079) (by decide +kernel) (by decide) phi1079 (by decide +kernel)
private theorem cell1079 : Covered 1079 1080 := singleton (i := 1079) (by rw [show 2*1079 = 2158 by decide, phi2158]; decide +kernel)
private theorem grid1078x1080 : Covered 1078 1080 := pair cell1078 cell1079
private theorem phi2160 : Nat.totient 2160 = 576 := step (p := 2) (m := 1080) (by decide +kernel) (by decide) phi1080 (by decide +kernel)
private theorem cell1080 : Covered 1080 1081 := singleton (i := 1080) (by rw [show 2*1080 = 2160 by decide, phi2160]; decide +kernel)
private theorem phi1081 : Nat.totient 1081 = 1012 := step (p := 23) (m := 47) (by decide +kernel) (by decide) phi47 (by decide +kernel)
private theorem phi2162 : Nat.totient 2162 = 1012 := step (p := 2) (m := 1081) (by decide +kernel) (by decide) phi1081 (by decide +kernel)
private theorem cell1081 : Covered 1081 1082 := singleton (i := 1081) (by rw [show 2*1081 = 2162 by decide, phi2162]; decide +kernel)
private theorem phi2164 : Nat.totient 2164 = 1080 := step (p := 2) (m := 1082) (by decide +kernel) (by decide) phi1082 (by decide +kernel)
private theorem cell1082 : Covered 1082 1083 := singleton (i := 1082) (by rw [show 2*1082 = 2164 by decide, phi2164]; decide +kernel)
private theorem grid1081x1083 : Covered 1081 1083 := pair cell1081 cell1082
private theorem grid1080x1083 : Covered 1080 1083 := pair cell1080 grid1081x1083
private theorem grid1078x1083 : Covered 1078 1083 := pair grid1078x1080 grid1080x1083
private theorem grid1074x1083 : Covered 1074 1083 := pair grid1074x1078 grid1078x1083
private theorem phi1083 : Nat.totient 1083 = 684 := step (p := 3) (m := 361) (by decide +kernel) (by decide) phi361 (by decide +kernel)
private theorem phi2166 : Nat.totient 2166 = 684 := step (p := 2) (m := 1083) (by decide +kernel) (by decide) phi1083 (by decide +kernel)
private theorem cell1083 : Covered 1083 1084 := singleton (i := 1083) (by rw [show 2*1083 = 2166 by decide, phi2166]; decide +kernel)
private theorem phi2168 : Nat.totient 2168 = 1080 := step (p := 2) (m := 1084) (by decide +kernel) (by decide) phi1084 (by decide +kernel)
private theorem cell1084 : Covered 1084 1085 := singleton (i := 1084) (by rw [show 2*1084 = 2168 by decide, phi2168]; decide +kernel)
private theorem grid1083x1085 : Covered 1083 1085 := pair cell1083 cell1084
private theorem phi1085 : Nat.totient 1085 = 720 := step (p := 5) (m := 217) (by decide +kernel) (by decide) phi217 (by decide +kernel)
private theorem phi2170 : Nat.totient 2170 = 720 := step (p := 2) (m := 1085) (by decide +kernel) (by decide) phi1085 (by decide +kernel)
private theorem cell1085 : Covered 1085 1086 := singleton (i := 1085) (by rw [show 2*1085 = 2170 by decide, phi2170]; decide +kernel)
private theorem phi2172 : Nat.totient 2172 = 720 := step (p := 2) (m := 1086) (by decide +kernel) (by decide) phi1086 (by decide +kernel)
private theorem cell1086 : Covered 1086 1087 := singleton (i := 1086) (by rw [show 2*1086 = 2172 by decide, phi2172]; decide +kernel)
private theorem phi1087 : Nat.totient 1087 = 1086 := step (p := 1087) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2174 : Nat.totient 2174 = 1086 := step (p := 2) (m := 1087) (by decide +kernel) (by decide) phi1087 (by decide +kernel)
private theorem cell1087 : Covered 1087 1088 := singleton (i := 1087) (by rw [show 2*1087 = 2174 by decide, phi2174]; decide +kernel)
private theorem grid1086x1088 : Covered 1086 1088 := pair cell1086 cell1087
private theorem grid1085x1088 : Covered 1085 1088 := pair cell1085 grid1086x1088
private theorem grid1083x1088 : Covered 1083 1088 := pair grid1083x1085 grid1085x1088
private theorem phi2176 : Nat.totient 2176 = 1024 := step (p := 2) (m := 1088) (by decide +kernel) (by decide) phi1088 (by decide +kernel)
private theorem cell1088 : Covered 1088 1089 := singleton (i := 1088) (by rw [show 2*1088 = 2176 by decide, phi2176]; decide +kernel)
private theorem phi1089 : Nat.totient 1089 = 660 := step (p := 3) (m := 363) (by decide +kernel) (by decide) phi363 (by decide +kernel)
private theorem phi2178 : Nat.totient 2178 = 660 := step (p := 2) (m := 1089) (by decide +kernel) (by decide) phi1089 (by decide +kernel)
private theorem cell1089 : Covered 1089 1090 := singleton (i := 1089) (by rw [show 2*1089 = 2178 by decide, phi2178]; decide +kernel)
private theorem grid1088x1090 : Covered 1088 1090 := pair cell1088 cell1089
private theorem phi2180 : Nat.totient 2180 = 864 := step (p := 2) (m := 1090) (by decide +kernel) (by decide) phi1090 (by decide +kernel)
private theorem cell1090 : Covered 1090 1091 := singleton (i := 1090) (by rw [show 2*1090 = 2180 by decide, phi2180]; decide +kernel)
private theorem phi1091 : Nat.totient 1091 = 1090 := step (p := 1091) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2182 : Nat.totient 2182 = 1090 := step (p := 2) (m := 1091) (by decide +kernel) (by decide) phi1091 (by decide +kernel)
private theorem cell1091 : Covered 1091 1092 := singleton (i := 1091) (by rw [show 2*1091 = 2182 by decide, phi2182]; decide +kernel)
private theorem phi2184 : Nat.totient 2184 = 576 := step (p := 2) (m := 1092) (by decide +kernel) (by decide) phi1092 (by decide +kernel)
private theorem cell1092 : Covered 1092 1093 := singleton (i := 1092) (by rw [show 2*1092 = 2184 by decide, phi2184]; decide +kernel)
private theorem grid1091x1093 : Covered 1091 1093 := pair cell1091 cell1092
private theorem grid1090x1093 : Covered 1090 1093 := pair cell1090 grid1091x1093
private theorem grid1088x1093 : Covered 1088 1093 := pair grid1088x1090 grid1090x1093
private theorem grid1083x1093 : Covered 1083 1093 := pair grid1083x1088 grid1088x1093
private theorem grid1074x1093 : Covered 1074 1093 := pair grid1074x1083 grid1083x1093
private theorem grid1056x1093 : Covered 1056 1093 := pair grid1056x1074 grid1074x1093
private theorem grid1020x1093 : Covered 1020 1093 := pair grid1020x1056 grid1056x1093
private theorem phi1093 : Nat.totient 1093 = 1092 := step (p := 1093) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2186 : Nat.totient 2186 = 1092 := step (p := 2) (m := 1093) (by decide +kernel) (by decide) phi1093 (by decide +kernel)
private theorem cell1093 : Covered 1093 1094 := singleton (i := 1093) (by rw [show 2*1093 = 2186 by decide, phi2186]; decide +kernel)
private theorem phi2188 : Nat.totient 2188 = 1092 := step (p := 2) (m := 1094) (by decide +kernel) (by decide) phi1094 (by decide +kernel)
private theorem cell1094 : Covered 1094 1095 := singleton (i := 1094) (by rw [show 2*1094 = 2188 by decide, phi2188]; decide +kernel)
private theorem grid1093x1095 : Covered 1093 1095 := pair cell1093 cell1094
private theorem phi1095 : Nat.totient 1095 = 576 := step (p := 3) (m := 365) (by decide +kernel) (by decide) phi365 (by decide +kernel)
private theorem phi2190 : Nat.totient 2190 = 576 := step (p := 2) (m := 1095) (by decide +kernel) (by decide) phi1095 (by decide +kernel)
private theorem cell1095 : Covered 1095 1096 := singleton (i := 1095) (by rw [show 2*1095 = 2190 by decide, phi2190]; decide +kernel)
private theorem phi2192 : Nat.totient 2192 = 1088 := step (p := 2) (m := 1096) (by decide +kernel) (by decide) phi1096 (by decide +kernel)
private theorem cell1096 : Covered 1096 1097 := singleton (i := 1096) (by rw [show 2*1096 = 2192 by decide, phi2192]; decide +kernel)
private theorem grid1095x1097 : Covered 1095 1097 := pair cell1095 cell1096
private theorem grid1093x1097 : Covered 1093 1097 := pair grid1093x1095 grid1095x1097
private theorem phi1097 : Nat.totient 1097 = 1096 := step (p := 1097) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2194 : Nat.totient 2194 = 1096 := step (p := 2) (m := 1097) (by decide +kernel) (by decide) phi1097 (by decide +kernel)
private theorem cell1097 : Covered 1097 1098 := singleton (i := 1097) (by rw [show 2*1097 = 2194 by decide, phi2194]; decide +kernel)
private theorem phi2196 : Nat.totient 2196 = 720 := step (p := 2) (m := 1098) (by decide +kernel) (by decide) phi1098 (by decide +kernel)
private theorem cell1098 : Covered 1098 1099 := singleton (i := 1098) (by rw [show 2*1098 = 2196 by decide, phi2196]; decide +kernel)
private theorem grid1097x1099 : Covered 1097 1099 := pair cell1097 cell1098
private theorem phi1099 : Nat.totient 1099 = 936 := step (p := 7) (m := 157) (by decide +kernel) (by decide) phi157 (by decide +kernel)
private theorem phi2198 : Nat.totient 2198 = 936 := step (p := 2) (m := 1099) (by decide +kernel) (by decide) phi1099 (by decide +kernel)
private theorem cell1099 : Covered 1099 1100 := singleton (i := 1099) (by rw [show 2*1099 = 2198 by decide, phi2198]; decide +kernel)
private theorem phi2200 : Nat.totient 2200 = 800 := step (p := 2) (m := 1100) (by decide +kernel) (by decide) phi1100 (by decide +kernel)
private theorem cell1100 : Covered 1100 1101 := singleton (i := 1100) (by rw [show 2*1100 = 2200 by decide, phi2200]; decide +kernel)
private theorem phi1101 : Nat.totient 1101 = 732 := step (p := 3) (m := 367) (by decide +kernel) (by decide) phi367 (by decide +kernel)
private theorem phi2202 : Nat.totient 2202 = 732 := step (p := 2) (m := 1101) (by decide +kernel) (by decide) phi1101 (by decide +kernel)
private theorem cell1101 : Covered 1101 1102 := singleton (i := 1101) (by rw [show 2*1101 = 2202 by decide, phi2202]; decide +kernel)
private theorem grid1100x1102 : Covered 1100 1102 := pair cell1100 cell1101
private theorem grid1099x1102 : Covered 1099 1102 := pair cell1099 grid1100x1102
private theorem grid1097x1102 : Covered 1097 1102 := pair grid1097x1099 grid1099x1102
private theorem grid1093x1102 : Covered 1093 1102 := pair grid1093x1097 grid1097x1102
private theorem phi2204 : Nat.totient 2204 = 1008 := step (p := 2) (m := 1102) (by decide +kernel) (by decide) phi1102 (by decide +kernel)
private theorem cell1102 : Covered 1102 1103 := singleton (i := 1102) (by rw [show 2*1102 = 2204 by decide, phi2204]; decide +kernel)
private theorem phi1103 : Nat.totient 1103 = 1102 := step (p := 1103) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2206 : Nat.totient 2206 = 1102 := step (p := 2) (m := 1103) (by decide +kernel) (by decide) phi1103 (by decide +kernel)
private theorem cell1103 : Covered 1103 1104 := singleton (i := 1103) (by rw [show 2*1103 = 2206 by decide, phi2206]; decide +kernel)
private theorem grid1102x1104 : Covered 1102 1104 := pair cell1102 cell1103
private theorem phi2208 : Nat.totient 2208 = 704 := step (p := 2) (m := 1104) (by decide +kernel) (by decide) phi1104 (by decide +kernel)
private theorem cell1104 : Covered 1104 1105 := singleton (i := 1104) (by rw [show 2*1104 = 2208 by decide, phi2208]; decide +kernel)
private theorem phi1105 : Nat.totient 1105 = 768 := step (p := 5) (m := 221) (by decide +kernel) (by decide) phi221 (by decide +kernel)
private theorem phi2210 : Nat.totient 2210 = 768 := step (p := 2) (m := 1105) (by decide +kernel) (by decide) phi1105 (by decide +kernel)
private theorem cell1105 : Covered 1105 1106 := singleton (i := 1105) (by rw [show 2*1105 = 2210 by decide, phi2210]; decide +kernel)
private theorem grid1104x1106 : Covered 1104 1106 := pair cell1104 cell1105
private theorem grid1102x1106 : Covered 1102 1106 := pair grid1102x1104 grid1104x1106
private theorem phi2212 : Nat.totient 2212 = 936 := step (p := 2) (m := 1106) (by decide +kernel) (by decide) phi1106 (by decide +kernel)
private theorem cell1106 : Covered 1106 1107 := singleton (i := 1106) (by rw [show 2*1106 = 2212 by decide, phi2212]; decide +kernel)
private theorem phi1107 : Nat.totient 1107 = 720 := step (p := 3) (m := 369) (by decide +kernel) (by decide) phi369 (by decide +kernel)
private theorem phi2214 : Nat.totient 2214 = 720 := step (p := 2) (m := 1107) (by decide +kernel) (by decide) phi1107 (by decide +kernel)
private theorem cell1107 : Covered 1107 1108 := singleton (i := 1107) (by rw [show 2*1107 = 2214 by decide, phi2214]; decide +kernel)
private theorem grid1106x1108 : Covered 1106 1108 := pair cell1106 cell1107
private theorem phi2216 : Nat.totient 2216 = 1104 := step (p := 2) (m := 1108) (by decide +kernel) (by decide) phi1108 (by decide +kernel)
private theorem cell1108 : Covered 1108 1109 := singleton (i := 1108) (by rw [show 2*1108 = 2216 by decide, phi2216]; decide +kernel)
private theorem phi1109 : Nat.totient 1109 = 1108 := step (p := 1109) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2218 : Nat.totient 2218 = 1108 := step (p := 2) (m := 1109) (by decide +kernel) (by decide) phi1109 (by decide +kernel)
private theorem cell1109 : Covered 1109 1110 := singleton (i := 1109) (by rw [show 2*1109 = 2218 by decide, phi2218]; decide +kernel)
private theorem phi2220 : Nat.totient 2220 = 576 := step (p := 2) (m := 1110) (by decide +kernel) (by decide) phi1110 (by decide +kernel)
private theorem cell1110 : Covered 1110 1111 := singleton (i := 1110) (by rw [show 2*1110 = 2220 by decide, phi2220]; decide +kernel)
private theorem grid1109x1111 : Covered 1109 1111 := pair cell1109 cell1110
private theorem grid1108x1111 : Covered 1108 1111 := pair cell1108 grid1109x1111
private theorem grid1106x1111 : Covered 1106 1111 := pair grid1106x1108 grid1108x1111
private theorem grid1102x1111 : Covered 1102 1111 := pair grid1102x1106 grid1106x1111
private theorem grid1093x1111 : Covered 1093 1111 := pair grid1093x1102 grid1102x1111
private theorem phi1111 : Nat.totient 1111 = 1000 := step (p := 11) (m := 101) (by decide +kernel) (by decide) phi101 (by decide +kernel)
private theorem phi2222 : Nat.totient 2222 = 1000 := step (p := 2) (m := 1111) (by decide +kernel) (by decide) phi1111 (by decide +kernel)
private theorem cell1111 : Covered 1111 1112 := singleton (i := 1111) (by rw [show 2*1111 = 2222 by decide, phi2222]; decide +kernel)
private theorem phi2224 : Nat.totient 2224 = 1104 := step (p := 2) (m := 1112) (by decide +kernel) (by decide) phi1112 (by decide +kernel)
private theorem cell1112 : Covered 1112 1113 := singleton (i := 1112) (by rw [show 2*1112 = 2224 by decide, phi2224]; decide +kernel)
private theorem grid1111x1113 : Covered 1111 1113 := pair cell1111 cell1112
private theorem phi1113 : Nat.totient 1113 = 624 := step (p := 3) (m := 371) (by decide +kernel) (by decide) phi371 (by decide +kernel)
private theorem phi2226 : Nat.totient 2226 = 624 := step (p := 2) (m := 1113) (by decide +kernel) (by decide) phi1113 (by decide +kernel)
private theorem cell1113 : Covered 1113 1114 := singleton (i := 1113) (by rw [show 2*1113 = 2226 by decide, phi2226]; decide +kernel)
private theorem phi2228 : Nat.totient 2228 = 1112 := step (p := 2) (m := 1114) (by decide +kernel) (by decide) phi1114 (by decide +kernel)
private theorem cell1114 : Covered 1114 1115 := singleton (i := 1114) (by rw [show 2*1114 = 2228 by decide, phi2228]; decide +kernel)
private theorem grid1113x1115 : Covered 1113 1115 := pair cell1113 cell1114
private theorem grid1111x1115 : Covered 1111 1115 := pair grid1111x1113 grid1113x1115
private theorem phi1115 : Nat.totient 1115 = 888 := step (p := 5) (m := 223) (by decide +kernel) (by decide) phi223 (by decide +kernel)
private theorem phi2230 : Nat.totient 2230 = 888 := step (p := 2) (m := 1115) (by decide +kernel) (by decide) phi1115 (by decide +kernel)
private theorem cell1115 : Covered 1115 1116 := singleton (i := 1115) (by rw [show 2*1115 = 2230 by decide, phi2230]; decide +kernel)
private theorem phi2232 : Nat.totient 2232 = 720 := step (p := 2) (m := 1116) (by decide +kernel) (by decide) phi1116 (by decide +kernel)
private theorem cell1116 : Covered 1116 1117 := singleton (i := 1116) (by rw [show 2*1116 = 2232 by decide, phi2232]; decide +kernel)
private theorem grid1115x1117 : Covered 1115 1117 := pair cell1115 cell1116
private theorem phi1117 : Nat.totient 1117 = 1116 := step (p := 1117) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2234 : Nat.totient 2234 = 1116 := step (p := 2) (m := 1117) (by decide +kernel) (by decide) phi1117 (by decide +kernel)
private theorem cell1117 : Covered 1117 1118 := singleton (i := 1117) (by rw [show 2*1117 = 2234 by decide, phi2234]; decide +kernel)
private theorem phi2236 : Nat.totient 2236 = 1008 := step (p := 2) (m := 1118) (by decide +kernel) (by decide) phi1118 (by decide +kernel)
private theorem cell1118 : Covered 1118 1119 := singleton (i := 1118) (by rw [show 2*1118 = 2236 by decide, phi2236]; decide +kernel)
private theorem phi1119 : Nat.totient 1119 = 744 := step (p := 3) (m := 373) (by decide +kernel) (by decide) phi373 (by decide +kernel)
private theorem phi2238 : Nat.totient 2238 = 744 := step (p := 2) (m := 1119) (by decide +kernel) (by decide) phi1119 (by decide +kernel)
private theorem cell1119 : Covered 1119 1120 := singleton (i := 1119) (by rw [show 2*1119 = 2238 by decide, phi2238]; decide +kernel)
private theorem grid1118x1120 : Covered 1118 1120 := pair cell1118 cell1119
private theorem grid1117x1120 : Covered 1117 1120 := pair cell1117 grid1118x1120
private theorem grid1115x1120 : Covered 1115 1120 := pair grid1115x1117 grid1117x1120
private theorem grid1111x1120 : Covered 1111 1120 := pair grid1111x1115 grid1115x1120
private theorem phi2240 : Nat.totient 2240 = 768 := step (p := 2) (m := 1120) (by decide +kernel) (by decide) phi1120 (by decide +kernel)
private theorem cell1120 : Covered 1120 1121 := singleton (i := 1120) (by rw [show 2*1120 = 2240 by decide, phi2240]; decide +kernel)
private theorem phi1121 : Nat.totient 1121 = 1044 := step (p := 19) (m := 59) (by decide +kernel) (by decide) phi59 (by decide +kernel)
private theorem phi2242 : Nat.totient 2242 = 1044 := step (p := 2) (m := 1121) (by decide +kernel) (by decide) phi1121 (by decide +kernel)
private theorem cell1121 : Covered 1121 1122 := singleton (i := 1121) (by rw [show 2*1121 = 2242 by decide, phi2242]; decide +kernel)
private theorem grid1120x1122 : Covered 1120 1122 := pair cell1120 cell1121
private theorem phi2244 : Nat.totient 2244 = 640 := step (p := 2) (m := 1122) (by decide +kernel) (by decide) phi1122 (by decide +kernel)
private theorem cell1122 : Covered 1122 1123 := singleton (i := 1122) (by rw [show 2*1122 = 2244 by decide, phi2244]; decide +kernel)
private theorem phi1123 : Nat.totient 1123 = 1122 := step (p := 1123) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2246 : Nat.totient 2246 = 1122 := step (p := 2) (m := 1123) (by decide +kernel) (by decide) phi1123 (by decide +kernel)
private theorem cell1123 : Covered 1123 1124 := singleton (i := 1123) (by rw [show 2*1123 = 2246 by decide, phi2246]; decide +kernel)
private theorem grid1122x1124 : Covered 1122 1124 := pair cell1122 cell1123
private theorem grid1120x1124 : Covered 1120 1124 := pair grid1120x1122 grid1122x1124
private theorem phi2248 : Nat.totient 2248 = 1120 := step (p := 2) (m := 1124) (by decide +kernel) (by decide) phi1124 (by decide +kernel)
private theorem cell1124 : Covered 1124 1125 := singleton (i := 1124) (by rw [show 2*1124 = 2248 by decide, phi2248]; decide +kernel)
private theorem phi1125 : Nat.totient 1125 = 600 := step (p := 3) (m := 375) (by decide +kernel) (by decide) phi375 (by decide +kernel)
private theorem phi2250 : Nat.totient 2250 = 600 := step (p := 2) (m := 1125) (by decide +kernel) (by decide) phi1125 (by decide +kernel)
private theorem cell1125 : Covered 1125 1126 := singleton (i := 1125) (by rw [show 2*1125 = 2250 by decide, phi2250]; decide +kernel)
private theorem grid1124x1126 : Covered 1124 1126 := pair cell1124 cell1125
private theorem phi2252 : Nat.totient 2252 = 1124 := step (p := 2) (m := 1126) (by decide +kernel) (by decide) phi1126 (by decide +kernel)
private theorem cell1126 : Covered 1126 1127 := singleton (i := 1126) (by rw [show 2*1126 = 2252 by decide, phi2252]; decide +kernel)
private theorem phi1127 : Nat.totient 1127 = 924 := step (p := 7) (m := 161) (by decide +kernel) (by decide) phi161 (by decide +kernel)
private theorem phi2254 : Nat.totient 2254 = 924 := step (p := 2) (m := 1127) (by decide +kernel) (by decide) phi1127 (by decide +kernel)
private theorem cell1127 : Covered 1127 1128 := singleton (i := 1127) (by rw [show 2*1127 = 2254 by decide, phi2254]; decide +kernel)
private theorem phi2256 : Nat.totient 2256 = 736 := step (p := 2) (m := 1128) (by decide +kernel) (by decide) phi1128 (by decide +kernel)
private theorem cell1128 : Covered 1128 1129 := singleton (i := 1128) (by rw [show 2*1128 = 2256 by decide, phi2256]; decide +kernel)
private theorem grid1127x1129 : Covered 1127 1129 := pair cell1127 cell1128
private theorem grid1126x1129 : Covered 1126 1129 := pair cell1126 grid1127x1129
private theorem grid1124x1129 : Covered 1124 1129 := pair grid1124x1126 grid1126x1129
private theorem grid1120x1129 : Covered 1120 1129 := pair grid1120x1124 grid1124x1129
private theorem grid1111x1129 : Covered 1111 1129 := pair grid1111x1120 grid1120x1129
private theorem grid1093x1129 : Covered 1093 1129 := pair grid1093x1111 grid1111x1129
private theorem phi1129 : Nat.totient 1129 = 1128 := step (p := 1129) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2258 : Nat.totient 2258 = 1128 := step (p := 2) (m := 1129) (by decide +kernel) (by decide) phi1129 (by decide +kernel)
private theorem cell1129 : Covered 1129 1130 := singleton (i := 1129) (by rw [show 2*1129 = 2258 by decide, phi2258]; decide +kernel)
private theorem phi2260 : Nat.totient 2260 = 896 := step (p := 2) (m := 1130) (by decide +kernel) (by decide) phi1130 (by decide +kernel)
private theorem cell1130 : Covered 1130 1131 := singleton (i := 1130) (by rw [show 2*1130 = 2260 by decide, phi2260]; decide +kernel)
private theorem grid1129x1131 : Covered 1129 1131 := pair cell1129 cell1130
private theorem phi1131 : Nat.totient 1131 = 672 := step (p := 3) (m := 377) (by decide +kernel) (by decide) phi377 (by decide +kernel)
private theorem phi2262 : Nat.totient 2262 = 672 := step (p := 2) (m := 1131) (by decide +kernel) (by decide) phi1131 (by decide +kernel)
private theorem cell1131 : Covered 1131 1132 := singleton (i := 1131) (by rw [show 2*1131 = 2262 by decide, phi2262]; decide +kernel)
private theorem phi2264 : Nat.totient 2264 = 1128 := step (p := 2) (m := 1132) (by decide +kernel) (by decide) phi1132 (by decide +kernel)
private theorem cell1132 : Covered 1132 1133 := singleton (i := 1132) (by rw [show 2*1132 = 2264 by decide, phi2264]; decide +kernel)
private theorem grid1131x1133 : Covered 1131 1133 := pair cell1131 cell1132
private theorem grid1129x1133 : Covered 1129 1133 := pair grid1129x1131 grid1131x1133
private theorem phi1133 : Nat.totient 1133 = 1020 := step (p := 11) (m := 103) (by decide +kernel) (by decide) phi103 (by decide +kernel)
private theorem phi2266 : Nat.totient 2266 = 1020 := step (p := 2) (m := 1133) (by decide +kernel) (by decide) phi1133 (by decide +kernel)
private theorem cell1133 : Covered 1133 1134 := singleton (i := 1133) (by rw [show 2*1133 = 2266 by decide, phi2266]; decide +kernel)
private theorem phi2268 : Nat.totient 2268 = 648 := step (p := 2) (m := 1134) (by decide +kernel) (by decide) phi1134 (by decide +kernel)
private theorem cell1134 : Covered 1134 1135 := singleton (i := 1134) (by rw [show 2*1134 = 2268 by decide, phi2268]; decide +kernel)
private theorem grid1133x1135 : Covered 1133 1135 := pair cell1133 cell1134
private theorem phi1135 : Nat.totient 1135 = 904 := step (p := 5) (m := 227) (by decide +kernel) (by decide) phi227 (by decide +kernel)
private theorem phi2270 : Nat.totient 2270 = 904 := step (p := 2) (m := 1135) (by decide +kernel) (by decide) phi1135 (by decide +kernel)
private theorem cell1135 : Covered 1135 1136 := singleton (i := 1135) (by rw [show 2*1135 = 2270 by decide, phi2270]; decide +kernel)
private theorem phi2272 : Nat.totient 2272 = 1120 := step (p := 2) (m := 1136) (by decide +kernel) (by decide) phi1136 (by decide +kernel)
private theorem cell1136 : Covered 1136 1137 := singleton (i := 1136) (by rw [show 2*1136 = 2272 by decide, phi2272]; decide +kernel)
private theorem phi1137 : Nat.totient 1137 = 756 := step (p := 3) (m := 379) (by decide +kernel) (by decide) phi379 (by decide +kernel)
private theorem phi2274 : Nat.totient 2274 = 756 := step (p := 2) (m := 1137) (by decide +kernel) (by decide) phi1137 (by decide +kernel)
private theorem cell1137 : Covered 1137 1138 := singleton (i := 1137) (by rw [show 2*1137 = 2274 by decide, phi2274]; decide +kernel)
private theorem grid1136x1138 : Covered 1136 1138 := pair cell1136 cell1137
private theorem grid1135x1138 : Covered 1135 1138 := pair cell1135 grid1136x1138
private theorem grid1133x1138 : Covered 1133 1138 := pair grid1133x1135 grid1135x1138
private theorem grid1129x1138 : Covered 1129 1138 := pair grid1129x1133 grid1133x1138
private theorem phi2276 : Nat.totient 2276 = 1136 := step (p := 2) (m := 1138) (by decide +kernel) (by decide) phi1138 (by decide +kernel)
private theorem cell1138 : Covered 1138 1139 := singleton (i := 1138) (by rw [show 2*1138 = 2276 by decide, phi2276]; decide +kernel)
private theorem phi1139 : Nat.totient 1139 = 1056 := step (p := 17) (m := 67) (by decide +kernel) (by decide) phi67 (by decide +kernel)
private theorem phi2278 : Nat.totient 2278 = 1056 := step (p := 2) (m := 1139) (by decide +kernel) (by decide) phi1139 (by decide +kernel)
private theorem cell1139 : Covered 1139 1140 := singleton (i := 1139) (by rw [show 2*1139 = 2278 by decide, phi2278]; decide +kernel)
private theorem grid1138x1140 : Covered 1138 1140 := pair cell1138 cell1139
private theorem phi2280 : Nat.totient 2280 = 576 := step (p := 2) (m := 1140) (by decide +kernel) (by decide) phi1140 (by decide +kernel)
private theorem cell1140 : Covered 1140 1141 := singleton (i := 1140) (by rw [show 2*1140 = 2280 by decide, phi2280]; decide +kernel)
private theorem phi1141 : Nat.totient 1141 = 972 := step (p := 7) (m := 163) (by decide +kernel) (by decide) phi163 (by decide +kernel)
private theorem phi2282 : Nat.totient 2282 = 972 := step (p := 2) (m := 1141) (by decide +kernel) (by decide) phi1141 (by decide +kernel)
private theorem cell1141 : Covered 1141 1142 := singleton (i := 1141) (by rw [show 2*1141 = 2282 by decide, phi2282]; decide +kernel)
private theorem grid1140x1142 : Covered 1140 1142 := pair cell1140 cell1141
private theorem grid1138x1142 : Covered 1138 1142 := pair grid1138x1140 grid1140x1142
private theorem phi2284 : Nat.totient 2284 = 1140 := step (p := 2) (m := 1142) (by decide +kernel) (by decide) phi1142 (by decide +kernel)
private theorem cell1142 : Covered 1142 1143 := singleton (i := 1142) (by rw [show 2*1142 = 2284 by decide, phi2284]; decide +kernel)
private theorem phi1143 : Nat.totient 1143 = 756 := step (p := 3) (m := 381) (by decide +kernel) (by decide) phi381 (by decide +kernel)
private theorem phi2286 : Nat.totient 2286 = 756 := step (p := 2) (m := 1143) (by decide +kernel) (by decide) phi1143 (by decide +kernel)
private theorem cell1143 : Covered 1143 1144 := singleton (i := 1143) (by rw [show 2*1143 = 2286 by decide, phi2286]; decide +kernel)
private theorem grid1142x1144 : Covered 1142 1144 := pair cell1142 cell1143
private theorem phi2288 : Nat.totient 2288 = 960 := step (p := 2) (m := 1144) (by decide +kernel) (by decide) phi1144 (by decide +kernel)
private theorem cell1144 : Covered 1144 1145 := singleton (i := 1144) (by rw [show 2*1144 = 2288 by decide, phi2288]; decide +kernel)
private theorem phi1145 : Nat.totient 1145 = 912 := step (p := 5) (m := 229) (by decide +kernel) (by decide) phi229 (by decide +kernel)
private theorem phi2290 : Nat.totient 2290 = 912 := step (p := 2) (m := 1145) (by decide +kernel) (by decide) phi1145 (by decide +kernel)
private theorem cell1145 : Covered 1145 1146 := singleton (i := 1145) (by rw [show 2*1145 = 2290 by decide, phi2290]; decide +kernel)
private theorem phi2292 : Nat.totient 2292 = 760 := step (p := 2) (m := 1146) (by decide +kernel) (by decide) phi1146 (by decide +kernel)
private theorem cell1146 : Covered 1146 1147 := singleton (i := 1146) (by rw [show 2*1146 = 2292 by decide, phi2292]; decide +kernel)
private theorem grid1145x1147 : Covered 1145 1147 := pair cell1145 cell1146
private theorem grid1144x1147 : Covered 1144 1147 := pair cell1144 grid1145x1147
private theorem grid1142x1147 : Covered 1142 1147 := pair grid1142x1144 grid1144x1147
private theorem grid1138x1147 : Covered 1138 1147 := pair grid1138x1142 grid1142x1147
private theorem grid1129x1147 : Covered 1129 1147 := pair grid1129x1138 grid1138x1147
private theorem phi1147 : Nat.totient 1147 = 1080 := step (p := 31) (m := 37) (by decide +kernel) (by decide) phi37 (by decide +kernel)
private theorem phi2294 : Nat.totient 2294 = 1080 := step (p := 2) (m := 1147) (by decide +kernel) (by decide) phi1147 (by decide +kernel)
private theorem cell1147 : Covered 1147 1148 := singleton (i := 1147) (by rw [show 2*1147 = 2294 by decide, phi2294]; decide +kernel)
private theorem phi2296 : Nat.totient 2296 = 960 := step (p := 2) (m := 1148) (by decide +kernel) (by decide) phi1148 (by decide +kernel)
private theorem cell1148 : Covered 1148 1149 := singleton (i := 1148) (by rw [show 2*1148 = 2296 by decide, phi2296]; decide +kernel)
private theorem grid1147x1149 : Covered 1147 1149 := pair cell1147 cell1148
private theorem phi1149 : Nat.totient 1149 = 764 := step (p := 3) (m := 383) (by decide +kernel) (by decide) phi383 (by decide +kernel)
private theorem phi2298 : Nat.totient 2298 = 764 := step (p := 2) (m := 1149) (by decide +kernel) (by decide) phi1149 (by decide +kernel)
private theorem cell1149 : Covered 1149 1150 := singleton (i := 1149) (by rw [show 2*1149 = 2298 by decide, phi2298]; decide +kernel)
private theorem phi2300 : Nat.totient 2300 = 880 := step (p := 2) (m := 1150) (by decide +kernel) (by decide) phi1150 (by decide +kernel)
private theorem cell1150 : Covered 1150 1151 := singleton (i := 1150) (by rw [show 2*1150 = 2300 by decide, phi2300]; decide +kernel)
private theorem grid1149x1151 : Covered 1149 1151 := pair cell1149 cell1150
private theorem grid1147x1151 : Covered 1147 1151 := pair grid1147x1149 grid1149x1151
private theorem phi1151 : Nat.totient 1151 = 1150 := step (p := 1151) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2302 : Nat.totient 2302 = 1150 := step (p := 2) (m := 1151) (by decide +kernel) (by decide) phi1151 (by decide +kernel)
private theorem cell1151 : Covered 1151 1152 := singleton (i := 1151) (by rw [show 2*1151 = 2302 by decide, phi2302]; decide +kernel)
private theorem phi2304 : Nat.totient 2304 = 768 := step (p := 2) (m := 1152) (by decide +kernel) (by decide) phi1152 (by decide +kernel)
private theorem cell1152 : Covered 1152 1153 := singleton (i := 1152) (by rw [show 2*1152 = 2304 by decide, phi2304]; decide +kernel)
private theorem grid1151x1153 : Covered 1151 1153 := pair cell1151 cell1152
private theorem phi1153 : Nat.totient 1153 = 1152 := step (p := 1153) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2306 : Nat.totient 2306 = 1152 := step (p := 2) (m := 1153) (by decide +kernel) (by decide) phi1153 (by decide +kernel)
private theorem cell1153 : Covered 1153 1154 := singleton (i := 1153) (by rw [show 2*1153 = 2306 by decide, phi2306]; decide +kernel)
private theorem phi2308 : Nat.totient 2308 = 1152 := step (p := 2) (m := 1154) (by decide +kernel) (by decide) phi1154 (by decide +kernel)
private theorem cell1154 : Covered 1154 1155 := singleton (i := 1154) (by rw [show 2*1154 = 2308 by decide, phi2308]; decide +kernel)
private theorem phi1155 : Nat.totient 1155 = 480 := step (p := 3) (m := 385) (by decide +kernel) (by decide) phi385 (by decide +kernel)
private theorem phi2310 : Nat.totient 2310 = 480 := step (p := 2) (m := 1155) (by decide +kernel) (by decide) phi1155 (by decide +kernel)
private theorem cell1155 : Covered 1155 1156 := singleton (i := 1155) (by rw [show 2*1155 = 2310 by decide, phi2310]; decide +kernel)
private theorem grid1154x1156 : Covered 1154 1156 := pair cell1154 cell1155
private theorem grid1153x1156 : Covered 1153 1156 := pair cell1153 grid1154x1156
private theorem grid1151x1156 : Covered 1151 1156 := pair grid1151x1153 grid1153x1156
private theorem grid1147x1156 : Covered 1147 1156 := pair grid1147x1151 grid1151x1156
private theorem phi2312 : Nat.totient 2312 = 1088 := step (p := 2) (m := 1156) (by decide +kernel) (by decide) phi1156 (by decide +kernel)
private theorem cell1156 : Covered 1156 1157 := singleton (i := 1156) (by rw [show 2*1156 = 2312 by decide, phi2312]; decide +kernel)
private theorem phi1157 : Nat.totient 1157 = 1056 := step (p := 13) (m := 89) (by decide +kernel) (by decide) phi89 (by decide +kernel)
private theorem phi2314 : Nat.totient 2314 = 1056 := step (p := 2) (m := 1157) (by decide +kernel) (by decide) phi1157 (by decide +kernel)
private theorem cell1157 : Covered 1157 1158 := singleton (i := 1157) (by rw [show 2*1157 = 2314 by decide, phi2314]; decide +kernel)
private theorem grid1156x1158 : Covered 1156 1158 := pair cell1156 cell1157
private theorem phi2316 : Nat.totient 2316 = 768 := step (p := 2) (m := 1158) (by decide +kernel) (by decide) phi1158 (by decide +kernel)
private theorem cell1158 : Covered 1158 1159 := singleton (i := 1158) (by rw [show 2*1158 = 2316 by decide, phi2316]; decide +kernel)
private theorem phi1159 : Nat.totient 1159 = 1080 := step (p := 19) (m := 61) (by decide +kernel) (by decide) phi61 (by decide +kernel)
private theorem phi2318 : Nat.totient 2318 = 1080 := step (p := 2) (m := 1159) (by decide +kernel) (by decide) phi1159 (by decide +kernel)
private theorem cell1159 : Covered 1159 1160 := singleton (i := 1159) (by rw [show 2*1159 = 2318 by decide, phi2318]; decide +kernel)
private theorem phi2320 : Nat.totient 2320 = 896 := step (p := 2) (m := 1160) (by decide +kernel) (by decide) phi1160 (by decide +kernel)
private theorem cell1160 : Covered 1160 1161 := singleton (i := 1160) (by rw [show 2*1160 = 2320 by decide, phi2320]; decide +kernel)
private theorem grid1159x1161 : Covered 1159 1161 := pair cell1159 cell1160
private theorem grid1158x1161 : Covered 1158 1161 := pair cell1158 grid1159x1161
private theorem grid1156x1161 : Covered 1156 1161 := pair grid1156x1158 grid1158x1161
private theorem phi1161 : Nat.totient 1161 = 756 := step (p := 3) (m := 387) (by decide +kernel) (by decide) phi387 (by decide +kernel)
private theorem phi2322 : Nat.totient 2322 = 756 := step (p := 2) (m := 1161) (by decide +kernel) (by decide) phi1161 (by decide +kernel)
private theorem cell1161 : Covered 1161 1162 := singleton (i := 1161) (by rw [show 2*1161 = 2322 by decide, phi2322]; decide +kernel)
private theorem phi2324 : Nat.totient 2324 = 984 := step (p := 2) (m := 1162) (by decide +kernel) (by decide) phi1162 (by decide +kernel)
private theorem cell1162 : Covered 1162 1163 := singleton (i := 1162) (by rw [show 2*1162 = 2324 by decide, phi2324]; decide +kernel)
private theorem grid1161x1163 : Covered 1161 1163 := pair cell1161 cell1162
private theorem phi1163 : Nat.totient 1163 = 1162 := step (p := 1163) (m := 1) (by decide +kernel) (by decide) phi1 (by decide +kernel)
private theorem phi2326 : Nat.totient 2326 = 1162 := step (p := 2) (m := 1163) (by decide +kernel) (by decide) phi1163 (by decide +kernel)
private theorem cell1163 : Covered 1163 1164 := singleton (i := 1163) (by rw [show 2*1163 = 2326 by decide, phi2326]; decide +kernel)
private theorem phi2328 : Nat.totient 2328 = 768 := step (p := 2) (m := 1164) (by decide +kernel) (by decide) phi1164 (by decide +kernel)
private theorem cell1164 : Covered 1164 1165 := singleton (i := 1164) (by rw [show 2*1164 = 2328 by decide, phi2328]; decide +kernel)
private theorem phi1165 : Nat.totient 1165 = 928 := step (p := 5) (m := 233) (by decide +kernel) (by decide) phi233 (by decide +kernel)
private theorem phi2330 : Nat.totient 2330 = 928 := step (p := 2) (m := 1165) (by decide +kernel) (by decide) phi1165 (by decide +kernel)
private theorem cell1165 : Covered 1165 1166 := singleton (i := 1165) (by rw [show 2*1165 = 2330 by decide, phi2330]; decide +kernel)
private theorem grid1164x1166 : Covered 1164 1166 := pair cell1164 cell1165
private theorem grid1163x1166 : Covered 1163 1166 := pair cell1163 grid1164x1166
private theorem grid1161x1166 : Covered 1161 1166 := pair grid1161x1163 grid1163x1166
private theorem grid1156x1166 : Covered 1156 1166 := pair grid1156x1161 grid1161x1166
private theorem grid1147x1166 : Covered 1147 1166 := pair grid1147x1156 grid1156x1166
private theorem grid1129x1166 : Covered 1129 1166 := pair grid1129x1147 grid1147x1166
private theorem grid1093x1166 : Covered 1093 1166 := pair grid1093x1129 grid1129x1166
private theorem grid1020x1166 : Covered 1020 1166 := pair grid1020x1093 grid1093x1166
private theorem grid874x1166 : Covered 874 1166 := pair grid874x1020 grid1020x1166
private theorem grid583x1166 : Covered 583 1166 := pair grid583x874 grid874x1166
private theorem grid1x1166 : Covered 1 1166 := pair grid1x583 grid583x1166
theorem phi_ratio (n : Nat) (h : 2331 ≤ n) : 120*n < n.totient^2 := all_totient (fun m h1 h2 => grid1x1166 m h1 (by omega)) n h
#print axioms phi_ratio
end GoldbachEnergy
