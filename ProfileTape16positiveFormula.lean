module

public import ProfileTape16positive
public import ScaledBinding
public import ProfileFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileTape16positive
set_option maxHeartbeats 0
set_option maxRecDepth 65536
private theorem at_add (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.add, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) {b : MathExpr} (hr : r < i) (hb : expression t r = b) :
    expression t i = MathExpr.binary .add a b := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, hr, hb, Tag.code, OpCode.expr]

private theorem at_atan (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.atan, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) :
    expression t i = MathExpr.unary .atan a := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, Tag.code, OpCode.expr]

private theorem at_exp (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.exp, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) :
    expression t i = MathExpr.unary .exp a := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, Tag.code, OpCode.expr]

private theorem at_input (t : Nat → Step) (i l r : Nat) (z : Nat) (h : t i = ⟨.input z, l, r⟩) :
    expression t i = MathExpr.varRef z := by
  conv => lhs; rw [expression]
  simp [h, Tag.code, OpCode.expr]

private theorem at_inv (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.inv, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) :
    expression t i = MathExpr.unary .inv a := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, Tag.code, OpCode.expr]

private theorem at_literal (t : Nat → Step) (i l r : Nat) (z : Int) (h : t i = ⟨.literal z, l, r⟩) :
    expression t i = MathExpr.rational (ScaledGrid.rational z) := by
  conv => lhs; rw [expression]
  simp [h, Tag.code, OpCode.expr]

private theorem at_log (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.log, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) :
    expression t i = MathExpr.unary .log a := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, Tag.code, OpCode.expr]

private theorem at_max (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.max, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) {b : MathExpr} (hr : r < i) (hb : expression t r = b) :
    expression t i = MathExpr.binary .max a b := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, hr, hb, Tag.code, OpCode.expr]

private theorem at_min (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.min, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) {b : MathExpr} (hr : r < i) (hb : expression t r = b) :
    expression t i = MathExpr.binary .min a b := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, hr, hb, Tag.code, OpCode.expr]

private theorem at_mul (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.mul, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) {b : MathExpr} (hr : r < i) (hb : expression t r = b) :
    expression t i = MathExpr.binary .mul a b := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, hr, hb, Tag.code, OpCode.expr]

private theorem at_neg (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.neg, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) :
    expression t i = MathExpr.unary .neg a := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, Tag.code, OpCode.expr]

private theorem at_pi (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.pi, l, r⟩) :
    expression t i = MathExpr.pi := by
  conv => lhs; rw [expression]
  simp [h, Tag.code, OpCode.expr]

private theorem at_sqrt (t : Nat → Step) (i l r : Nat) (h : t i = ⟨.sqrt, l, r⟩) {a : MathExpr} (hl : l < i) (ha : expression t l = a) :
    expression t i = MathExpr.unary .sqrt a := by
  conv => lhs; rw [expression]
  simp [h, hl, ha, Tag.code, OpCode.expr]

private def e0 : MathExpr := MathExpr.rational (ScaledGrid.rational (0 : Int))
private theorem p0 : expression tape.fetch 0 = e0 :=
  at_literal tape.fetch 0 0 0 (0 : Int) (by rfl)

private def e1 : MathExpr := MathExpr.rational (ScaledGrid.rational (18268770466636286477546060408953537745699156787200000000000000000000 : Int))
private theorem p1 : expression tape.fetch 1 = e1 :=
  at_literal tape.fetch 1 0 0 (18268770466636286477546060408953537745699156787200000000000000000000 : Int) (by rfl)

private def e2 : MathExpr := MathExpr.pi
private theorem p2 : expression tape.fetch 2 = e2 :=
  at_pi tape.fetch 2 0 0 (by rfl)

private def e3 : MathExpr := MathExpr.binary .mul e1 e2
private theorem p3 : expression tape.fetch 3 = e3 :=
  at_mul tape.fetch 3 1 2 (by rfl) (by decide) p1 (by decide) p2

private def e4 : MathExpr := MathExpr.unary .sqrt e3
private theorem p4 : expression tape.fetch 4 = e4 :=
  at_sqrt tape.fetch 4 3 0 (by rfl) (by decide) p3

private def e5 : MathExpr := MathExpr.rational (ScaledGrid.rational (9134385233318143238773030204476768872849578393600000000000000000000 : Int))
private theorem p5 : expression tape.fetch 5 = e5 :=
  at_literal tape.fetch 5 0 0 (9134385233318143238773030204476768872849578393600000000000000000000 : Int) (by rfl)

private def e6 : MathExpr := MathExpr.binary .mul e4 e5
private theorem p6 : expression tape.fetch 6 = e6 :=
  at_mul tape.fetch 6 4 5 (by rfl) (by decide) p4 (by decide) p5

private def e7 : MathExpr := MathExpr.binary .add e5 e5
private theorem p7 : expression tape.fetch 7 = e7 :=
  at_add tape.fetch 7 5 5 (by rfl) (by decide) p5 (by decide) p5

private def e8 : MathExpr := MathExpr.unary .inv e1
private theorem p8 : expression tape.fetch 8 = e8 :=
  at_inv tape.fetch 8 1 0 (by rfl) (by decide) p1

private def e9 : MathExpr := MathExpr.binary .mul e7 e8
private theorem p9 : expression tape.fetch 9 = e9 :=
  at_mul tape.fetch 9 7 8 (by rfl) (by decide) p7 (by decide) p8

private def e10 : MathExpr := MathExpr.unary .inv e9
private theorem p10 : expression tape.fetch 10 = e10 :=
  at_inv tape.fetch 10 9 0 (by rfl) (by decide) p9

private def e11 : MathExpr := MathExpr.binary .mul e2 e10
private theorem p11 : expression tape.fetch 11 = e11 :=
  at_mul tape.fetch 11 2 10 (by rfl) (by decide) p2 (by decide) p10

private def e12 : MathExpr := MathExpr.unary .sqrt e11
private theorem p12 : expression tape.fetch 12 = e12 :=
  at_sqrt tape.fetch 12 11 0 (by rfl) (by decide) p11

private def e13 : MathExpr := MathExpr.varRef 8
private theorem p13 : expression tape.fetch 13 = e13 :=
  at_input tape.fetch 13 0 0 8 (by rfl)

private def e14 : MathExpr := MathExpr.binary .mul e3 e13
private theorem p14 : expression tape.fetch 14 = e14 :=
  at_mul tape.fetch 14 3 13 (by rfl) (by decide) p3 (by decide) p13

private def e15 : MathExpr := MathExpr.unary .atan e14
private theorem p15 : expression tape.fetch 15 = e15 :=
  at_atan tape.fetch 15 14 0 (by rfl) (by decide) p14

private def e16 : MathExpr := MathExpr.varRef 5
private theorem p16 : expression tape.fetch 16 = e16 :=
  at_input tape.fetch 16 0 0 5 (by rfl)

private def e17 : MathExpr := MathExpr.binary .mul e15 e16
private theorem p17 : expression tape.fetch 17 = e17 :=
  at_mul tape.fetch 17 15 16 (by rfl) (by decide) p15 (by decide) p16

private def e18 : MathExpr := MathExpr.unary .exp e17
private theorem p18 : expression tape.fetch 18 = e18 :=
  at_exp tape.fetch 18 17 0 (by rfl) (by decide) p17

private def e19 : MathExpr := MathExpr.binary .mul e12 e18
private theorem p19 : expression tape.fetch 19 = e19 :=
  at_mul tape.fetch 19 12 18 (by rfl) (by decide) p12 (by decide) p18

private def e20 : MathExpr := MathExpr.binary .min e6 e19
private theorem p20 : expression tape.fetch 20 = e20 :=
  at_min tape.fetch 20 6 19 (by rfl) (by decide) p6 (by decide) p19

private def e21 : MathExpr := MathExpr.varRef 7
private theorem p21 : expression tape.fetch 21 = e21 :=
  at_input tape.fetch 21 0 0 7 (by rfl)

private def e22 : MathExpr := MathExpr.binary .mul e3 e21
private theorem p22 : expression tape.fetch 22 = e22 :=
  at_mul tape.fetch 22 3 21 (by rfl) (by decide) p3 (by decide) p21

private def e23 : MathExpr := MathExpr.unary .inv e22
private theorem p23 : expression tape.fetch 23 = e23 :=
  at_inv tape.fetch 23 22 0 (by rfl) (by decide) p22

private def e24 : MathExpr := MathExpr.binary .mul e5 e23
private theorem p24 : expression tape.fetch 24 = e24 :=
  at_mul tape.fetch 24 5 23 (by rfl) (by decide) p5 (by decide) p23

private def e25 : MathExpr := MathExpr.unary .atan e24
private theorem p25 : expression tape.fetch 25 = e25 :=
  at_atan tape.fetch 25 24 0 (by rfl) (by decide) p24

private def e26 : MathExpr := MathExpr.binary .mul e25 e16
private theorem p26 : expression tape.fetch 26 = e26 :=
  at_mul tape.fetch 26 25 16 (by rfl) (by decide) p25 (by decide) p16

private def e27 : MathExpr := MathExpr.unary .neg e26
private theorem p27 : expression tape.fetch 27 = e27 :=
  at_neg tape.fetch 27 26 0 (by rfl) (by decide) p26

private def e28 : MathExpr := MathExpr.unary .exp e27
private theorem p28 : expression tape.fetch 28 = e28 :=
  at_exp tape.fetch 28 27 0 (by rfl) (by decide) p27

private def e29 : MathExpr := MathExpr.binary .mul e4 e28
private theorem p29 : expression tape.fetch 29 = e29 :=
  at_mul tape.fetch 29 4 28 (by rfl) (by decide) p4 (by decide) p28

private def e30 : MathExpr := MathExpr.binary .mul e2 e16
private theorem p30 : expression tape.fetch 30 = e30 :=
  at_mul tape.fetch 30 2 16 (by rfl) (by decide) p2 (by decide) p16

private def e31 : MathExpr := MathExpr.unary .exp e30
private theorem p31 : expression tape.fetch 31 = e31 :=
  at_exp tape.fetch 31 30 0 (by rfl) (by decide) p30

private def e32 : MathExpr := MathExpr.unary .inv e31
private theorem p32 : expression tape.fetch 32 = e32 :=
  at_inv tape.fetch 32 31 0 (by rfl) (by decide) p31

private def e33 : MathExpr := MathExpr.binary .add e31 e32
private theorem p33 : expression tape.fetch 33 = e33 :=
  at_add tape.fetch 33 31 32 (by rfl) (by decide) p31 (by decide) p32

private def e34 : MathExpr := MathExpr.binary .mul e33 e8
private theorem p34 : expression tape.fetch 34 = e34 :=
  at_mul tape.fetch 34 33 8 (by rfl) (by decide) p33 (by decide) p8

private def e35 : MathExpr := MathExpr.unary .inv e34
private theorem p35 : expression tape.fetch 35 = e35 :=
  at_inv tape.fetch 35 34 0 (by rfl) (by decide) p34

private def e36 : MathExpr := MathExpr.binary .mul e2 e35
private theorem p36 : expression tape.fetch 36 = e36 :=
  at_mul tape.fetch 36 2 35 (by rfl) (by decide) p2 (by decide) p35

private def e37 : MathExpr := MathExpr.unary .sqrt e36
private theorem p37 : expression tape.fetch 37 = e37 :=
  at_sqrt tape.fetch 37 36 0 (by rfl) (by decide) p36

private def e38 : MathExpr := MathExpr.unary .atan e22
private theorem p38 : expression tape.fetch 38 = e38 :=
  at_atan tape.fetch 38 22 0 (by rfl) (by decide) p22

private def e39 : MathExpr := MathExpr.binary .mul e38 e16
private theorem p39 : expression tape.fetch 39 = e39 :=
  at_mul tape.fetch 39 38 16 (by rfl) (by decide) p38 (by decide) p16

private def e40 : MathExpr := MathExpr.unary .exp e39
private theorem p40 : expression tape.fetch 40 = e40 :=
  at_exp tape.fetch 40 39 0 (by rfl) (by decide) p39

private def e41 : MathExpr := MathExpr.binary .mul e40 e40
private theorem p41 : expression tape.fetch 41 = e41 :=
  at_mul tape.fetch 41 40 40 (by rfl) (by decide) p40 (by decide) p40

private def e42 : MathExpr := MathExpr.binary .mul e37 e41
private theorem p42 : expression tape.fetch 42 = e42 :=
  at_mul tape.fetch 42 37 41 (by rfl) (by decide) p37 (by decide) p41

private def e43 : MathExpr := MathExpr.binary .min e29 e42
private theorem p43 : expression tape.fetch 43 = e43 :=
  at_min tape.fetch 43 29 42 (by rfl) (by decide) p29 (by decide) p42

private def e44 : MathExpr := MathExpr.unary .neg e43
private theorem p44 : expression tape.fetch 44 = e44 :=
  at_neg tape.fetch 44 43 0 (by rfl) (by decide) p43

private def e45 : MathExpr := MathExpr.binary .add e20 e44
private theorem p45 : expression tape.fetch 45 = e45 :=
  at_add tape.fetch 45 20 44 (by rfl) (by decide) p20 (by decide) p44

private def e46 : MathExpr := MathExpr.binary .max e45 e0
private theorem p46 : expression tape.fetch 46 = e46 :=
  at_max tape.fetch 46 45 0 (by rfl) (by decide) p45 (by decide) p0

private def e47 : MathExpr := MathExpr.rational (ScaledGrid.rational (91343852333181432387730302044767688728495783936000000000000000000000 : Int))
private theorem p47 : expression tape.fetch 47 = e47 :=
  at_literal tape.fetch 47 0 0 (91343852333181432387730302044767688728495783936000000000000000000000 : Int) (by rfl)

private def e48 : MathExpr := MathExpr.rational (ScaledGrid.rational (20552366774965822287239317960072729963911551385600000000000000000000 : Int))
private theorem p48 : expression tape.fetch 48 = e48 :=
  at_literal tape.fetch 48 0 0 (20552366774965822287239317960072729963911551385600000000000000000000 : Int) (by rfl)

private def e49 : MathExpr := MathExpr.binary .mul e5 e16
private theorem p49 : expression tape.fetch 49 = e49 :=
  at_mul tape.fetch 49 5 16 (by rfl) (by decide) p5 (by decide) p16

private def e50 : MathExpr := MathExpr.binary .mul e49 e49
private theorem p50 : expression tape.fetch 50 = e50 :=
  at_mul tape.fetch 50 49 49 (by rfl) (by decide) p49 (by decide) p49

private def e51 : MathExpr := MathExpr.binary .add e48 e50
private theorem p51 : expression tape.fetch 51 = e51 :=
  at_add tape.fetch 51 48 50 (by rfl) (by decide) p48 (by decide) p50

private def e52 : MathExpr := MathExpr.unary .sqrt e51
private theorem p52 : expression tape.fetch 52 = e52 :=
  at_sqrt tape.fetch 52 51 0 (by rfl) (by decide) p51

private def e53 : MathExpr := MathExpr.unary .inv e52
private theorem p53 : expression tape.fetch 53 = e53 :=
  at_inv tape.fetch 53 52 0 (by rfl) (by decide) p52

private def e54 : MathExpr := MathExpr.binary .mul e47 e53
private theorem p54 : expression tape.fetch 54 = e54 :=
  at_mul tape.fetch 54 47 53 (by rfl) (by decide) p47 (by decide) p53

private def e55 : MathExpr := MathExpr.unary .log e54
private theorem p55 : expression tape.fetch 55 = e55 :=
  at_log tape.fetch 55 54 0 (by rfl) (by decide) p54

private def e56 : MathExpr := MathExpr.unary .inv e55
private theorem p56 : expression tape.fetch 56 = e56 :=
  at_inv tape.fetch 56 55 0 (by rfl) (by decide) p55

private def e57 : MathExpr := MathExpr.binary .mul e46 e56
private theorem p57 : expression tape.fetch 57 = e57 :=
  at_mul tape.fetch 57 46 56 (by rfl) (by decide) p46 (by decide) p56

private def e58 : MathExpr := MathExpr.binary .add e0 e57
private theorem p58 : expression tape.fetch 58 = e58 :=
  at_add tape.fetch 58 0 57 (by rfl) (by decide) p0 (by decide) p57

private def e59 : MathExpr := MathExpr.unary .inv e14
private theorem p59 : expression tape.fetch 59 = e59 :=
  at_inv tape.fetch 59 14 0 (by rfl) (by decide) p14

private def e60 : MathExpr := MathExpr.binary .mul e5 e59
private theorem p60 : expression tape.fetch 60 = e60 :=
  at_mul tape.fetch 60 5 59 (by rfl) (by decide) p5 (by decide) p59

private def e61 : MathExpr := MathExpr.unary .atan e60
private theorem p61 : expression tape.fetch 61 = e61 :=
  at_atan tape.fetch 61 60 0 (by rfl) (by decide) p60

private def e62 : MathExpr := MathExpr.binary .mul e61 e16
private theorem p62 : expression tape.fetch 62 = e62 :=
  at_mul tape.fetch 62 61 16 (by rfl) (by decide) p61 (by decide) p16

private def e63 : MathExpr := MathExpr.unary .neg e62
private theorem p63 : expression tape.fetch 63 = e63 :=
  at_neg tape.fetch 63 62 0 (by rfl) (by decide) p62

private def e64 : MathExpr := MathExpr.unary .exp e63
private theorem p64 : expression tape.fetch 64 = e64 :=
  at_exp tape.fetch 64 63 0 (by rfl) (by decide) p63

private def e65 : MathExpr := MathExpr.binary .mul e4 e64
private theorem p65 : expression tape.fetch 65 = e65 :=
  at_mul tape.fetch 65 4 64 (by rfl) (by decide) p4 (by decide) p64

private def e66 : MathExpr := MathExpr.binary .mul e18 e18
private theorem p66 : expression tape.fetch 66 = e66 :=
  at_mul tape.fetch 66 18 18 (by rfl) (by decide) p18 (by decide) p18

private def e67 : MathExpr := MathExpr.binary .mul e37 e66
private theorem p67 : expression tape.fetch 67 = e67 :=
  at_mul tape.fetch 67 37 66 (by rfl) (by decide) p37 (by decide) p66

private def e68 : MathExpr := MathExpr.binary .min e65 e67
private theorem p68 : expression tape.fetch 68 = e68 :=
  at_min tape.fetch 68 65 67 (by rfl) (by decide) p65 (by decide) p67

private def e69 : MathExpr := MathExpr.binary .mul e28 e28
private theorem p69 : expression tape.fetch 69 = e69 :=
  at_mul tape.fetch 69 28 28 (by rfl) (by decide) p28 (by decide) p28

private def e70 : MathExpr := MathExpr.binary .mul e4 e69
private theorem p70 : expression tape.fetch 70 = e70 :=
  at_mul tape.fetch 70 4 69 (by rfl) (by decide) p4 (by decide) p69

private def e71 : MathExpr := MathExpr.binary .mul e31 e31
private theorem p71 : expression tape.fetch 71 = e71 :=
  at_mul tape.fetch 71 31 31 (by rfl) (by decide) p31 (by decide) p31

private def e72 : MathExpr := MathExpr.binary .mul e32 e32
private theorem p72 : expression tape.fetch 72 = e72 :=
  at_mul tape.fetch 72 32 32 (by rfl) (by decide) p32 (by decide) p32

private def e73 : MathExpr := MathExpr.binary .add e71 e72
private theorem p73 : expression tape.fetch 73 = e73 :=
  at_add tape.fetch 73 71 72 (by rfl) (by decide) p71 (by decide) p72

private def e74 : MathExpr := MathExpr.binary .mul e73 e8
private theorem p74 : expression tape.fetch 74 = e74 :=
  at_mul tape.fetch 74 73 8 (by rfl) (by decide) p73 (by decide) p8

private def e75 : MathExpr := MathExpr.unary .inv e74
private theorem p75 : expression tape.fetch 75 = e75 :=
  at_inv tape.fetch 75 74 0 (by rfl) (by decide) p74

private def e76 : MathExpr := MathExpr.binary .mul e2 e75
private theorem p76 : expression tape.fetch 76 = e76 :=
  at_mul tape.fetch 76 2 75 (by rfl) (by decide) p2 (by decide) p75

private def e77 : MathExpr := MathExpr.unary .sqrt e76
private theorem p77 : expression tape.fetch 77 = e77 :=
  at_sqrt tape.fetch 77 76 0 (by rfl) (by decide) p76

private def e78 : MathExpr := MathExpr.binary .mul e41 e40
private theorem p78 : expression tape.fetch 78 = e78 :=
  at_mul tape.fetch 78 41 40 (by rfl) (by decide) p41 (by decide) p40

private def e79 : MathExpr := MathExpr.binary .mul e77 e78
private theorem p79 : expression tape.fetch 79 = e79 :=
  at_mul tape.fetch 79 77 78 (by rfl) (by decide) p77 (by decide) p78

private def e80 : MathExpr := MathExpr.binary .min e70 e79
private theorem p80 : expression tape.fetch 80 = e80 :=
  at_min tape.fetch 80 70 79 (by rfl) (by decide) p70 (by decide) p79

private def e81 : MathExpr := MathExpr.unary .neg e80
private theorem p81 : expression tape.fetch 81 = e81 :=
  at_neg tape.fetch 81 80 0 (by rfl) (by decide) p80

private def e82 : MathExpr := MathExpr.binary .add e68 e81
private theorem p82 : expression tape.fetch 82 = e82 :=
  at_add tape.fetch 82 68 81 (by rfl) (by decide) p68 (by decide) p81

private def e83 : MathExpr := MathExpr.binary .max e82 e0
private theorem p83 : expression tape.fetch 83 = e83 :=
  at_max tape.fetch 83 82 0 (by rfl) (by decide) p82 (by decide) p0

private def e84 : MathExpr := MathExpr.binary .mul e1 e16
private theorem p84 : expression tape.fetch 84 = e84 :=
  at_mul tape.fetch 84 1 16 (by rfl) (by decide) p1 (by decide) p16

private def e85 : MathExpr := MathExpr.binary .mul e84 e84
private theorem p85 : expression tape.fetch 85 = e85 :=
  at_mul tape.fetch 85 84 84 (by rfl) (by decide) p84 (by decide) p84

private def e86 : MathExpr := MathExpr.binary .add e48 e85
private theorem p86 : expression tape.fetch 86 = e86 :=
  at_add tape.fetch 86 48 85 (by rfl) (by decide) p48 (by decide) p85

private def e87 : MathExpr := MathExpr.unary .sqrt e86
private theorem p87 : expression tape.fetch 87 = e87 :=
  at_sqrt tape.fetch 87 86 0 (by rfl) (by decide) p86

private def e88 : MathExpr := MathExpr.unary .inv e87
private theorem p88 : expression tape.fetch 88 = e88 :=
  at_inv tape.fetch 88 87 0 (by rfl) (by decide) p87

private def e89 : MathExpr := MathExpr.binary .mul e47 e88
private theorem p89 : expression tape.fetch 89 = e89 :=
  at_mul tape.fetch 89 47 88 (by rfl) (by decide) p47 (by decide) p88

private def e90 : MathExpr := MathExpr.unary .log e89
private theorem p90 : expression tape.fetch 90 = e90 :=
  at_log tape.fetch 90 89 0 (by rfl) (by decide) p89

private def e91 : MathExpr := MathExpr.unary .inv e90
private theorem p91 : expression tape.fetch 91 = e91 :=
  at_inv tape.fetch 91 90 0 (by rfl) (by decide) p90

private def e92 : MathExpr := MathExpr.binary .mul e83 e91
private theorem p92 : expression tape.fetch 92 = e92 :=
  at_mul tape.fetch 92 83 91 (by rfl) (by decide) p83 (by decide) p91

private def e93 : MathExpr := MathExpr.binary .add e58 e92
private theorem p93 : expression tape.fetch 93 = e93 :=
  at_add tape.fetch 93 58 92 (by rfl) (by decide) p58 (by decide) p92

private def e94 : MathExpr := MathExpr.binary .mul e64 e64
private theorem p94 : expression tape.fetch 94 = e94 :=
  at_mul tape.fetch 94 64 64 (by rfl) (by decide) p64 (by decide) p64

private def e95 : MathExpr := MathExpr.binary .mul e4 e94
private theorem p95 : expression tape.fetch 95 = e95 :=
  at_mul tape.fetch 95 4 94 (by rfl) (by decide) p4 (by decide) p94

private def e96 : MathExpr := MathExpr.binary .mul e66 e18
private theorem p96 : expression tape.fetch 96 = e96 :=
  at_mul tape.fetch 96 66 18 (by rfl) (by decide) p66 (by decide) p18

private def e97 : MathExpr := MathExpr.binary .mul e77 e96
private theorem p97 : expression tape.fetch 97 = e97 :=
  at_mul tape.fetch 97 77 96 (by rfl) (by decide) p77 (by decide) p96

private def e98 : MathExpr := MathExpr.binary .min e95 e97
private theorem p98 : expression tape.fetch 98 = e98 :=
  at_min tape.fetch 98 95 97 (by rfl) (by decide) p95 (by decide) p97

private def e99 : MathExpr := MathExpr.binary .mul e69 e28
private theorem p99 : expression tape.fetch 99 = e99 :=
  at_mul tape.fetch 99 69 28 (by rfl) (by decide) p69 (by decide) p28

private def e100 : MathExpr := MathExpr.binary .mul e4 e99
private theorem p100 : expression tape.fetch 100 = e100 :=
  at_mul tape.fetch 100 4 99 (by rfl) (by decide) p4 (by decide) p99

private def e101 : MathExpr := MathExpr.binary .mul e71 e31
private theorem p101 : expression tape.fetch 101 = e101 :=
  at_mul tape.fetch 101 71 31 (by rfl) (by decide) p71 (by decide) p31

private def e102 : MathExpr := MathExpr.binary .mul e72 e32
private theorem p102 : expression tape.fetch 102 = e102 :=
  at_mul tape.fetch 102 72 32 (by rfl) (by decide) p72 (by decide) p32

private def e103 : MathExpr := MathExpr.binary .add e101 e102
private theorem p103 : expression tape.fetch 103 = e103 :=
  at_add tape.fetch 103 101 102 (by rfl) (by decide) p101 (by decide) p102

private def e104 : MathExpr := MathExpr.binary .mul e103 e8
private theorem p104 : expression tape.fetch 104 = e104 :=
  at_mul tape.fetch 104 103 8 (by rfl) (by decide) p103 (by decide) p8

private def e105 : MathExpr := MathExpr.unary .inv e104
private theorem p105 : expression tape.fetch 105 = e105 :=
  at_inv tape.fetch 105 104 0 (by rfl) (by decide) p104

private def e106 : MathExpr := MathExpr.binary .mul e2 e105
private theorem p106 : expression tape.fetch 106 = e106 :=
  at_mul tape.fetch 106 2 105 (by rfl) (by decide) p2 (by decide) p105

private def e107 : MathExpr := MathExpr.unary .sqrt e106
private theorem p107 : expression tape.fetch 107 = e107 :=
  at_sqrt tape.fetch 107 106 0 (by rfl) (by decide) p106

private def e108 : MathExpr := MathExpr.binary .mul e41 e41
private theorem p108 : expression tape.fetch 108 = e108 :=
  at_mul tape.fetch 108 41 41 (by rfl) (by decide) p41 (by decide) p41

private def e109 : MathExpr := MathExpr.binary .mul e107 e108
private theorem p109 : expression tape.fetch 109 = e109 :=
  at_mul tape.fetch 109 107 108 (by rfl) (by decide) p107 (by decide) p108

private def e110 : MathExpr := MathExpr.binary .min e100 e109
private theorem p110 : expression tape.fetch 110 = e110 :=
  at_min tape.fetch 110 100 109 (by rfl) (by decide) p100 (by decide) p109

private def e111 : MathExpr := MathExpr.unary .neg e110
private theorem p111 : expression tape.fetch 111 = e111 :=
  at_neg tape.fetch 111 110 0 (by rfl) (by decide) p110

private def e112 : MathExpr := MathExpr.binary .add e98 e111
private theorem p112 : expression tape.fetch 112 = e112 :=
  at_add tape.fetch 112 98 111 (by rfl) (by decide) p98 (by decide) p111

private def e113 : MathExpr := MathExpr.binary .max e112 e0
private theorem p113 : expression tape.fetch 113 = e113 :=
  at_max tape.fetch 113 112 0 (by rfl) (by decide) p112 (by decide) p0

private def e114 : MathExpr := MathExpr.rational (ScaledGrid.rational (27403155699954429716319090613430306618548735180800000000000000000000 : Int))
private theorem p114 : expression tape.fetch 114 = e114 :=
  at_literal tape.fetch 114 0 0 (27403155699954429716319090613430306618548735180800000000000000000000 : Int) (by rfl)

private def e115 : MathExpr := MathExpr.binary .mul e114 e16
private theorem p115 : expression tape.fetch 115 = e115 :=
  at_mul tape.fetch 115 114 16 (by rfl) (by decide) p114 (by decide) p16

private def e116 : MathExpr := MathExpr.binary .mul e115 e115
private theorem p116 : expression tape.fetch 116 = e116 :=
  at_mul tape.fetch 116 115 115 (by rfl) (by decide) p115 (by decide) p115

private def e117 : MathExpr := MathExpr.binary .add e48 e116
private theorem p117 : expression tape.fetch 117 = e117 :=
  at_add tape.fetch 117 48 116 (by rfl) (by decide) p48 (by decide) p116

private def e118 : MathExpr := MathExpr.unary .sqrt e117
private theorem p118 : expression tape.fetch 118 = e118 :=
  at_sqrt tape.fetch 118 117 0 (by rfl) (by decide) p117

private def e119 : MathExpr := MathExpr.unary .inv e118
private theorem p119 : expression tape.fetch 119 = e119 :=
  at_inv tape.fetch 119 118 0 (by rfl) (by decide) p118

private def e120 : MathExpr := MathExpr.binary .mul e47 e119
private theorem p120 : expression tape.fetch 120 = e120 :=
  at_mul tape.fetch 120 47 119 (by rfl) (by decide) p47 (by decide) p119

private def e121 : MathExpr := MathExpr.unary .log e120
private theorem p121 : expression tape.fetch 121 = e121 :=
  at_log tape.fetch 121 120 0 (by rfl) (by decide) p120

private def e122 : MathExpr := MathExpr.unary .inv e121
private theorem p122 : expression tape.fetch 122 = e122 :=
  at_inv tape.fetch 122 121 0 (by rfl) (by decide) p121

private def e123 : MathExpr := MathExpr.binary .mul e113 e122
private theorem p123 : expression tape.fetch 123 = e123 :=
  at_mul tape.fetch 123 113 122 (by rfl) (by decide) p113 (by decide) p122

private def e124 : MathExpr := MathExpr.binary .add e93 e123
private theorem p124 : expression tape.fetch 124 = e124 :=
  at_add tape.fetch 124 93 123 (by rfl) (by decide) p93 (by decide) p123

private def e125 : MathExpr := MathExpr.binary .mul e94 e64
private theorem p125 : expression tape.fetch 125 = e125 :=
  at_mul tape.fetch 125 94 64 (by rfl) (by decide) p94 (by decide) p64

private def e126 : MathExpr := MathExpr.binary .mul e4 e125
private theorem p126 : expression tape.fetch 126 = e126 :=
  at_mul tape.fetch 126 4 125 (by rfl) (by decide) p4 (by decide) p125

private def e127 : MathExpr := MathExpr.binary .mul e66 e66
private theorem p127 : expression tape.fetch 127 = e127 :=
  at_mul tape.fetch 127 66 66 (by rfl) (by decide) p66 (by decide) p66

private def e128 : MathExpr := MathExpr.binary .mul e107 e127
private theorem p128 : expression tape.fetch 128 = e128 :=
  at_mul tape.fetch 128 107 127 (by rfl) (by decide) p107 (by decide) p127

private def e129 : MathExpr := MathExpr.binary .min e126 e128
private theorem p129 : expression tape.fetch 129 = e129 :=
  at_min tape.fetch 129 126 128 (by rfl) (by decide) p126 (by decide) p128

private def e130 : MathExpr := MathExpr.binary .mul e69 e69
private theorem p130 : expression tape.fetch 130 = e130 :=
  at_mul tape.fetch 130 69 69 (by rfl) (by decide) p69 (by decide) p69

private def e131 : MathExpr := MathExpr.binary .mul e4 e130
private theorem p131 : expression tape.fetch 131 = e131 :=
  at_mul tape.fetch 131 4 130 (by rfl) (by decide) p4 (by decide) p130

private def e132 : MathExpr := MathExpr.binary .mul e71 e71
private theorem p132 : expression tape.fetch 132 = e132 :=
  at_mul tape.fetch 132 71 71 (by rfl) (by decide) p71 (by decide) p71

private def e133 : MathExpr := MathExpr.binary .mul e72 e72
private theorem p133 : expression tape.fetch 133 = e133 :=
  at_mul tape.fetch 133 72 72 (by rfl) (by decide) p72 (by decide) p72

private def e134 : MathExpr := MathExpr.binary .add e132 e133
private theorem p134 : expression tape.fetch 134 = e134 :=
  at_add tape.fetch 134 132 133 (by rfl) (by decide) p132 (by decide) p133

private def e135 : MathExpr := MathExpr.binary .mul e134 e8
private theorem p135 : expression tape.fetch 135 = e135 :=
  at_mul tape.fetch 135 134 8 (by rfl) (by decide) p134 (by decide) p8

private def e136 : MathExpr := MathExpr.unary .inv e135
private theorem p136 : expression tape.fetch 136 = e136 :=
  at_inv tape.fetch 136 135 0 (by rfl) (by decide) p135

private def e137 : MathExpr := MathExpr.binary .mul e2 e136
private theorem p137 : expression tape.fetch 137 = e137 :=
  at_mul tape.fetch 137 2 136 (by rfl) (by decide) p2 (by decide) p136

private def e138 : MathExpr := MathExpr.unary .sqrt e137
private theorem p138 : expression tape.fetch 138 = e138 :=
  at_sqrt tape.fetch 138 137 0 (by rfl) (by decide) p137

private def e139 : MathExpr := MathExpr.binary .mul e108 e40
private theorem p139 : expression tape.fetch 139 = e139 :=
  at_mul tape.fetch 139 108 40 (by rfl) (by decide) p108 (by decide) p40

private def e140 : MathExpr := MathExpr.binary .mul e138 e139
private theorem p140 : expression tape.fetch 140 = e140 :=
  at_mul tape.fetch 140 138 139 (by rfl) (by decide) p138 (by decide) p139

private def e141 : MathExpr := MathExpr.binary .min e131 e140
private theorem p141 : expression tape.fetch 141 = e141 :=
  at_min tape.fetch 141 131 140 (by rfl) (by decide) p131 (by decide) p140

private def e142 : MathExpr := MathExpr.unary .neg e141
private theorem p142 : expression tape.fetch 142 = e142 :=
  at_neg tape.fetch 142 141 0 (by rfl) (by decide) p141

private def e143 : MathExpr := MathExpr.binary .add e129 e142
private theorem p143 : expression tape.fetch 143 = e143 :=
  at_add tape.fetch 143 129 142 (by rfl) (by decide) p129 (by decide) p142

private def e144 : MathExpr := MathExpr.binary .max e143 e0
private theorem p144 : expression tape.fetch 144 = e144 :=
  at_max tape.fetch 144 143 0 (by rfl) (by decide) p143 (by decide) p0

private def e145 : MathExpr := MathExpr.rational (ScaledGrid.rational (36537540933272572955092120817907075491398313574400000000000000000000 : Int))
private theorem p145 : expression tape.fetch 145 = e145 :=
  at_literal tape.fetch 145 0 0 (36537540933272572955092120817907075491398313574400000000000000000000 : Int) (by rfl)

private def e146 : MathExpr := MathExpr.binary .mul e145 e16
private theorem p146 : expression tape.fetch 146 = e146 :=
  at_mul tape.fetch 146 145 16 (by rfl) (by decide) p145 (by decide) p16

private def e147 : MathExpr := MathExpr.binary .mul e146 e146
private theorem p147 : expression tape.fetch 147 = e147 :=
  at_mul tape.fetch 147 146 146 (by rfl) (by decide) p146 (by decide) p146

private def e148 : MathExpr := MathExpr.binary .add e48 e147
private theorem p148 : expression tape.fetch 148 = e148 :=
  at_add tape.fetch 148 48 147 (by rfl) (by decide) p48 (by decide) p147

private def e149 : MathExpr := MathExpr.unary .sqrt e148
private theorem p149 : expression tape.fetch 149 = e149 :=
  at_sqrt tape.fetch 149 148 0 (by rfl) (by decide) p148

private def e150 : MathExpr := MathExpr.unary .inv e149
private theorem p150 : expression tape.fetch 150 = e150 :=
  at_inv tape.fetch 150 149 0 (by rfl) (by decide) p149

private def e151 : MathExpr := MathExpr.binary .mul e47 e150
private theorem p151 : expression tape.fetch 151 = e151 :=
  at_mul tape.fetch 151 47 150 (by rfl) (by decide) p47 (by decide) p150

private def e152 : MathExpr := MathExpr.unary .log e151
private theorem p152 : expression tape.fetch 152 = e152 :=
  at_log tape.fetch 152 151 0 (by rfl) (by decide) p151

private def e153 : MathExpr := MathExpr.unary .inv e152
private theorem p153 : expression tape.fetch 153 = e153 :=
  at_inv tape.fetch 153 152 0 (by rfl) (by decide) p152

private def e154 : MathExpr := MathExpr.binary .mul e144 e153
private theorem p154 : expression tape.fetch 154 = e154 :=
  at_mul tape.fetch 154 144 153 (by rfl) (by decide) p144 (by decide) p153

private def e155 : MathExpr := MathExpr.binary .add e124 e154
private theorem p155 : expression tape.fetch 155 = e155 :=
  at_add tape.fetch 155 124 154 (by rfl) (by decide) p124 (by decide) p154

private def e156 : MathExpr := MathExpr.binary .mul e94 e94
private theorem p156 : expression tape.fetch 156 = e156 :=
  at_mul tape.fetch 156 94 94 (by rfl) (by decide) p94 (by decide) p94

private def e157 : MathExpr := MathExpr.binary .mul e4 e156
private theorem p157 : expression tape.fetch 157 = e157 :=
  at_mul tape.fetch 157 4 156 (by rfl) (by decide) p4 (by decide) p156

private def e158 : MathExpr := MathExpr.binary .mul e127 e18
private theorem p158 : expression tape.fetch 158 = e158 :=
  at_mul tape.fetch 158 127 18 (by rfl) (by decide) p127 (by decide) p18

private def e159 : MathExpr := MathExpr.binary .mul e138 e158
private theorem p159 : expression tape.fetch 159 = e159 :=
  at_mul tape.fetch 159 138 158 (by rfl) (by decide) p138 (by decide) p158

private def e160 : MathExpr := MathExpr.binary .min e157 e159
private theorem p160 : expression tape.fetch 160 = e160 :=
  at_min tape.fetch 160 157 159 (by rfl) (by decide) p157 (by decide) p159

private def e161 : MathExpr := MathExpr.binary .mul e130 e28
private theorem p161 : expression tape.fetch 161 = e161 :=
  at_mul tape.fetch 161 130 28 (by rfl) (by decide) p130 (by decide) p28

private def e162 : MathExpr := MathExpr.binary .mul e4 e161
private theorem p162 : expression tape.fetch 162 = e162 :=
  at_mul tape.fetch 162 4 161 (by rfl) (by decide) p4 (by decide) p161

private def e163 : MathExpr := MathExpr.binary .mul e132 e31
private theorem p163 : expression tape.fetch 163 = e163 :=
  at_mul tape.fetch 163 132 31 (by rfl) (by decide) p132 (by decide) p31

private def e164 : MathExpr := MathExpr.binary .mul e133 e32
private theorem p164 : expression tape.fetch 164 = e164 :=
  at_mul tape.fetch 164 133 32 (by rfl) (by decide) p133 (by decide) p32

private def e165 : MathExpr := MathExpr.binary .add e163 e164
private theorem p165 : expression tape.fetch 165 = e165 :=
  at_add tape.fetch 165 163 164 (by rfl) (by decide) p163 (by decide) p164

private def e166 : MathExpr := MathExpr.binary .mul e165 e8
private theorem p166 : expression tape.fetch 166 = e166 :=
  at_mul tape.fetch 166 165 8 (by rfl) (by decide) p165 (by decide) p8

private def e167 : MathExpr := MathExpr.unary .inv e166
private theorem p167 : expression tape.fetch 167 = e167 :=
  at_inv tape.fetch 167 166 0 (by rfl) (by decide) p166

private def e168 : MathExpr := MathExpr.binary .mul e2 e167
private theorem p168 : expression tape.fetch 168 = e168 :=
  at_mul tape.fetch 168 2 167 (by rfl) (by decide) p2 (by decide) p167

private def e169 : MathExpr := MathExpr.unary .sqrt e168
private theorem p169 : expression tape.fetch 169 = e169 :=
  at_sqrt tape.fetch 169 168 0 (by rfl) (by decide) p168

private def e170 : MathExpr := MathExpr.binary .mul e78 e78
private theorem p170 : expression tape.fetch 170 = e170 :=
  at_mul tape.fetch 170 78 78 (by rfl) (by decide) p78 (by decide) p78

private def e171 : MathExpr := MathExpr.binary .mul e169 e170
private theorem p171 : expression tape.fetch 171 = e171 :=
  at_mul tape.fetch 171 169 170 (by rfl) (by decide) p169 (by decide) p170

private def e172 : MathExpr := MathExpr.binary .min e162 e171
private theorem p172 : expression tape.fetch 172 = e172 :=
  at_min tape.fetch 172 162 171 (by rfl) (by decide) p162 (by decide) p171

private def e173 : MathExpr := MathExpr.unary .neg e172
private theorem p173 : expression tape.fetch 173 = e173 :=
  at_neg tape.fetch 173 172 0 (by rfl) (by decide) p172

private def e174 : MathExpr := MathExpr.binary .add e160 e173
private theorem p174 : expression tape.fetch 174 = e174 :=
  at_add tape.fetch 174 160 173 (by rfl) (by decide) p160 (by decide) p173

private def e175 : MathExpr := MathExpr.binary .max e174 e0
private theorem p175 : expression tape.fetch 175 = e175 :=
  at_max tape.fetch 175 174 0 (by rfl) (by decide) p174 (by decide) p0

private def e176 : MathExpr := MathExpr.rational (ScaledGrid.rational (45671926166590716193865151022383844364247891968000000000000000000000 : Int))
private theorem p176 : expression tape.fetch 176 = e176 :=
  at_literal tape.fetch 176 0 0 (45671926166590716193865151022383844364247891968000000000000000000000 : Int) (by rfl)

private def e177 : MathExpr := MathExpr.binary .mul e176 e16
private theorem p177 : expression tape.fetch 177 = e177 :=
  at_mul tape.fetch 177 176 16 (by rfl) (by decide) p176 (by decide) p16

private def e178 : MathExpr := MathExpr.binary .mul e177 e177
private theorem p178 : expression tape.fetch 178 = e178 :=
  at_mul tape.fetch 178 177 177 (by rfl) (by decide) p177 (by decide) p177

private def e179 : MathExpr := MathExpr.binary .add e48 e178
private theorem p179 : expression tape.fetch 179 = e179 :=
  at_add tape.fetch 179 48 178 (by rfl) (by decide) p48 (by decide) p178

private def e180 : MathExpr := MathExpr.unary .sqrt e179
private theorem p180 : expression tape.fetch 180 = e180 :=
  at_sqrt tape.fetch 180 179 0 (by rfl) (by decide) p179

private def e181 : MathExpr := MathExpr.unary .inv e180
private theorem p181 : expression tape.fetch 181 = e181 :=
  at_inv tape.fetch 181 180 0 (by rfl) (by decide) p180

private def e182 : MathExpr := MathExpr.binary .mul e47 e181
private theorem p182 : expression tape.fetch 182 = e182 :=
  at_mul tape.fetch 182 47 181 (by rfl) (by decide) p47 (by decide) p181

private def e183 : MathExpr := MathExpr.unary .log e182
private theorem p183 : expression tape.fetch 183 = e183 :=
  at_log tape.fetch 183 182 0 (by rfl) (by decide) p182

private def e184 : MathExpr := MathExpr.unary .inv e183
private theorem p184 : expression tape.fetch 184 = e184 :=
  at_inv tape.fetch 184 183 0 (by rfl) (by decide) p183

private def e185 : MathExpr := MathExpr.binary .mul e175 e184
private theorem p185 : expression tape.fetch 185 = e185 :=
  at_mul tape.fetch 185 175 184 (by rfl) (by decide) p175 (by decide) p184

private def e186 : MathExpr := MathExpr.binary .add e155 e185
private theorem p186 : expression tape.fetch 186 = e186 :=
  at_add tape.fetch 186 155 185 (by rfl) (by decide) p155 (by decide) p185

private def e187 : MathExpr := MathExpr.binary .mul e156 e64
private theorem p187 : expression tape.fetch 187 = e187 :=
  at_mul tape.fetch 187 156 64 (by rfl) (by decide) p156 (by decide) p64

private def e188 : MathExpr := MathExpr.binary .mul e4 e187
private theorem p188 : expression tape.fetch 188 = e188 :=
  at_mul tape.fetch 188 4 187 (by rfl) (by decide) p4 (by decide) p187

private def e189 : MathExpr := MathExpr.binary .mul e96 e96
private theorem p189 : expression tape.fetch 189 = e189 :=
  at_mul tape.fetch 189 96 96 (by rfl) (by decide) p96 (by decide) p96

private def e190 : MathExpr := MathExpr.binary .mul e169 e189
private theorem p190 : expression tape.fetch 190 = e190 :=
  at_mul tape.fetch 190 169 189 (by rfl) (by decide) p169 (by decide) p189

private def e191 : MathExpr := MathExpr.binary .min e188 e190
private theorem p191 : expression tape.fetch 191 = e191 :=
  at_min tape.fetch 191 188 190 (by rfl) (by decide) p188 (by decide) p190

private def e192 : MathExpr := MathExpr.binary .mul e99 e99
private theorem p192 : expression tape.fetch 192 = e192 :=
  at_mul tape.fetch 192 99 99 (by rfl) (by decide) p99 (by decide) p99

private def e193 : MathExpr := MathExpr.binary .mul e4 e192
private theorem p193 : expression tape.fetch 193 = e193 :=
  at_mul tape.fetch 193 4 192 (by rfl) (by decide) p4 (by decide) p192

private def e194 : MathExpr := MathExpr.binary .mul e101 e101
private theorem p194 : expression tape.fetch 194 = e194 :=
  at_mul tape.fetch 194 101 101 (by rfl) (by decide) p101 (by decide) p101

private def e195 : MathExpr := MathExpr.binary .mul e102 e102
private theorem p195 : expression tape.fetch 195 = e195 :=
  at_mul tape.fetch 195 102 102 (by rfl) (by decide) p102 (by decide) p102

private def e196 : MathExpr := MathExpr.binary .add e194 e195
private theorem p196 : expression tape.fetch 196 = e196 :=
  at_add tape.fetch 196 194 195 (by rfl) (by decide) p194 (by decide) p195

private def e197 : MathExpr := MathExpr.binary .mul e196 e8
private theorem p197 : expression tape.fetch 197 = e197 :=
  at_mul tape.fetch 197 196 8 (by rfl) (by decide) p196 (by decide) p8

private def e198 : MathExpr := MathExpr.unary .inv e197
private theorem p198 : expression tape.fetch 198 = e198 :=
  at_inv tape.fetch 198 197 0 (by rfl) (by decide) p197

private def e199 : MathExpr := MathExpr.binary .mul e2 e198
private theorem p199 : expression tape.fetch 199 = e199 :=
  at_mul tape.fetch 199 2 198 (by rfl) (by decide) p2 (by decide) p198

private def e200 : MathExpr := MathExpr.unary .sqrt e199
private theorem p200 : expression tape.fetch 200 = e200 :=
  at_sqrt tape.fetch 200 199 0 (by rfl) (by decide) p199

private def e201 : MathExpr := MathExpr.binary .mul e170 e40
private theorem p201 : expression tape.fetch 201 = e201 :=
  at_mul tape.fetch 201 170 40 (by rfl) (by decide) p170 (by decide) p40

private def e202 : MathExpr := MathExpr.binary .mul e200 e201
private theorem p202 : expression tape.fetch 202 = e202 :=
  at_mul tape.fetch 202 200 201 (by rfl) (by decide) p200 (by decide) p201

private def e203 : MathExpr := MathExpr.binary .min e193 e202
private theorem p203 : expression tape.fetch 203 = e203 :=
  at_min tape.fetch 203 193 202 (by rfl) (by decide) p193 (by decide) p202

private def e204 : MathExpr := MathExpr.unary .neg e203
private theorem p204 : expression tape.fetch 204 = e204 :=
  at_neg tape.fetch 204 203 0 (by rfl) (by decide) p203

private def e205 : MathExpr := MathExpr.binary .add e191 e204
private theorem p205 : expression tape.fetch 205 = e205 :=
  at_add tape.fetch 205 191 204 (by rfl) (by decide) p191 (by decide) p204

private def e206 : MathExpr := MathExpr.binary .max e205 e0
private theorem p206 : expression tape.fetch 206 = e206 :=
  at_max tape.fetch 206 205 0 (by rfl) (by decide) p205 (by decide) p0

private def e207 : MathExpr := MathExpr.rational (ScaledGrid.rational (54806311399908859432638181226860613237097470361600000000000000000000 : Int))
private theorem p207 : expression tape.fetch 207 = e207 :=
  at_literal tape.fetch 207 0 0 (54806311399908859432638181226860613237097470361600000000000000000000 : Int) (by rfl)

private def e208 : MathExpr := MathExpr.binary .mul e207 e16
private theorem p208 : expression tape.fetch 208 = e208 :=
  at_mul tape.fetch 208 207 16 (by rfl) (by decide) p207 (by decide) p16

private def e209 : MathExpr := MathExpr.binary .mul e208 e208
private theorem p209 : expression tape.fetch 209 = e209 :=
  at_mul tape.fetch 209 208 208 (by rfl) (by decide) p208 (by decide) p208

private def e210 : MathExpr := MathExpr.binary .add e48 e209
private theorem p210 : expression tape.fetch 210 = e210 :=
  at_add tape.fetch 210 48 209 (by rfl) (by decide) p48 (by decide) p209

private def e211 : MathExpr := MathExpr.unary .sqrt e210
private theorem p211 : expression tape.fetch 211 = e211 :=
  at_sqrt tape.fetch 211 210 0 (by rfl) (by decide) p210

private def e212 : MathExpr := MathExpr.unary .inv e211
private theorem p212 : expression tape.fetch 212 = e212 :=
  at_inv tape.fetch 212 211 0 (by rfl) (by decide) p211

private def e213 : MathExpr := MathExpr.binary .mul e47 e212
private theorem p213 : expression tape.fetch 213 = e213 :=
  at_mul tape.fetch 213 47 212 (by rfl) (by decide) p47 (by decide) p212

private def e214 : MathExpr := MathExpr.unary .log e213
private theorem p214 : expression tape.fetch 214 = e214 :=
  at_log tape.fetch 214 213 0 (by rfl) (by decide) p213

private def e215 : MathExpr := MathExpr.unary .inv e214
private theorem p215 : expression tape.fetch 215 = e215 :=
  at_inv tape.fetch 215 214 0 (by rfl) (by decide) p214

private def e216 : MathExpr := MathExpr.binary .mul e206 e215
private theorem p216 : expression tape.fetch 216 = e216 :=
  at_mul tape.fetch 216 206 215 (by rfl) (by decide) p206 (by decide) p215

private def e217 : MathExpr := MathExpr.binary .add e186 e216
private theorem p217 : expression tape.fetch 217 = e217 :=
  at_add tape.fetch 217 186 216 (by rfl) (by decide) p186 (by decide) p216

private def e218 : MathExpr := MathExpr.binary .mul e125 e125
private theorem p218 : expression tape.fetch 218 = e218 :=
  at_mul tape.fetch 218 125 125 (by rfl) (by decide) p125 (by decide) p125

private def e219 : MathExpr := MathExpr.binary .mul e4 e218
private theorem p219 : expression tape.fetch 219 = e219 :=
  at_mul tape.fetch 219 4 218 (by rfl) (by decide) p4 (by decide) p218

private def e220 : MathExpr := MathExpr.binary .mul e189 e18
private theorem p220 : expression tape.fetch 220 = e220 :=
  at_mul tape.fetch 220 189 18 (by rfl) (by decide) p189 (by decide) p18

private def e221 : MathExpr := MathExpr.binary .mul e200 e220
private theorem p221 : expression tape.fetch 221 = e221 :=
  at_mul tape.fetch 221 200 220 (by rfl) (by decide) p200 (by decide) p220

private def e222 : MathExpr := MathExpr.binary .min e219 e221
private theorem p222 : expression tape.fetch 222 = e222 :=
  at_min tape.fetch 222 219 221 (by rfl) (by decide) p219 (by decide) p221

private def e223 : MathExpr := MathExpr.binary .mul e192 e28
private theorem p223 : expression tape.fetch 223 = e223 :=
  at_mul tape.fetch 223 192 28 (by rfl) (by decide) p192 (by decide) p28

private def e224 : MathExpr := MathExpr.binary .mul e4 e223
private theorem p224 : expression tape.fetch 224 = e224 :=
  at_mul tape.fetch 224 4 223 (by rfl) (by decide) p4 (by decide) p223

private def e225 : MathExpr := MathExpr.binary .mul e194 e31
private theorem p225 : expression tape.fetch 225 = e225 :=
  at_mul tape.fetch 225 194 31 (by rfl) (by decide) p194 (by decide) p31

private def e226 : MathExpr := MathExpr.binary .mul e195 e32
private theorem p226 : expression tape.fetch 226 = e226 :=
  at_mul tape.fetch 226 195 32 (by rfl) (by decide) p195 (by decide) p32

private def e227 : MathExpr := MathExpr.binary .add e225 e226
private theorem p227 : expression tape.fetch 227 = e227 :=
  at_add tape.fetch 227 225 226 (by rfl) (by decide) p225 (by decide) p226

private def e228 : MathExpr := MathExpr.binary .mul e227 e8
private theorem p228 : expression tape.fetch 228 = e228 :=
  at_mul tape.fetch 228 227 8 (by rfl) (by decide) p227 (by decide) p8

private def e229 : MathExpr := MathExpr.unary .inv e228
private theorem p229 : expression tape.fetch 229 = e229 :=
  at_inv tape.fetch 229 228 0 (by rfl) (by decide) p228

private def e230 : MathExpr := MathExpr.binary .mul e2 e229
private theorem p230 : expression tape.fetch 230 = e230 :=
  at_mul tape.fetch 230 2 229 (by rfl) (by decide) p2 (by decide) p229

private def e231 : MathExpr := MathExpr.unary .sqrt e230
private theorem p231 : expression tape.fetch 231 = e231 :=
  at_sqrt tape.fetch 231 230 0 (by rfl) (by decide) p230

private def e232 : MathExpr := MathExpr.binary .mul e108 e108
private theorem p232 : expression tape.fetch 232 = e232 :=
  at_mul tape.fetch 232 108 108 (by rfl) (by decide) p108 (by decide) p108

private def e233 : MathExpr := MathExpr.binary .mul e231 e232
private theorem p233 : expression tape.fetch 233 = e233 :=
  at_mul tape.fetch 233 231 232 (by rfl) (by decide) p231 (by decide) p232

private def e234 : MathExpr := MathExpr.binary .min e224 e233
private theorem p234 : expression tape.fetch 234 = e234 :=
  at_min tape.fetch 234 224 233 (by rfl) (by decide) p224 (by decide) p233

private def e235 : MathExpr := MathExpr.unary .neg e234
private theorem p235 : expression tape.fetch 235 = e235 :=
  at_neg tape.fetch 235 234 0 (by rfl) (by decide) p234

private def e236 : MathExpr := MathExpr.binary .add e222 e235
private theorem p236 : expression tape.fetch 236 = e236 :=
  at_add tape.fetch 236 222 235 (by rfl) (by decide) p222 (by decide) p235

private def e237 : MathExpr := MathExpr.binary .max e236 e0
private theorem p237 : expression tape.fetch 237 = e237 :=
  at_max tape.fetch 237 236 0 (by rfl) (by decide) p236 (by decide) p0

private def e238 : MathExpr := MathExpr.rational (ScaledGrid.rational (63940696633227002671411211431337382109947048755200000000000000000000 : Int))
private theorem p238 : expression tape.fetch 238 = e238 :=
  at_literal tape.fetch 238 0 0 (63940696633227002671411211431337382109947048755200000000000000000000 : Int) (by rfl)

private def e239 : MathExpr := MathExpr.binary .mul e238 e16
private theorem p239 : expression tape.fetch 239 = e239 :=
  at_mul tape.fetch 239 238 16 (by rfl) (by decide) p238 (by decide) p16

private def e240 : MathExpr := MathExpr.binary .mul e239 e239
private theorem p240 : expression tape.fetch 240 = e240 :=
  at_mul tape.fetch 240 239 239 (by rfl) (by decide) p239 (by decide) p239

private def e241 : MathExpr := MathExpr.binary .add e48 e240
private theorem p241 : expression tape.fetch 241 = e241 :=
  at_add tape.fetch 241 48 240 (by rfl) (by decide) p48 (by decide) p240

private def e242 : MathExpr := MathExpr.unary .sqrt e241
private theorem p242 : expression tape.fetch 242 = e242 :=
  at_sqrt tape.fetch 242 241 0 (by rfl) (by decide) p241

private def e243 : MathExpr := MathExpr.unary .inv e242
private theorem p243 : expression tape.fetch 243 = e243 :=
  at_inv tape.fetch 243 242 0 (by rfl) (by decide) p242

private def e244 : MathExpr := MathExpr.binary .mul e47 e243
private theorem p244 : expression tape.fetch 244 = e244 :=
  at_mul tape.fetch 244 47 243 (by rfl) (by decide) p47 (by decide) p243

private def e245 : MathExpr := MathExpr.unary .log e244
private theorem p245 : expression tape.fetch 245 = e245 :=
  at_log tape.fetch 245 244 0 (by rfl) (by decide) p244

private def e246 : MathExpr := MathExpr.unary .inv e245
private theorem p246 : expression tape.fetch 246 = e246 :=
  at_inv tape.fetch 246 245 0 (by rfl) (by decide) p245

private def e247 : MathExpr := MathExpr.binary .mul e237 e246
private theorem p247 : expression tape.fetch 247 = e247 :=
  at_mul tape.fetch 247 237 246 (by rfl) (by decide) p237 (by decide) p246

private def e248 : MathExpr := MathExpr.binary .add e217 e247
private theorem p248 : expression tape.fetch 248 = e248 :=
  at_add tape.fetch 248 217 247 (by rfl) (by decide) p217 (by decide) p247

private def e249 : MathExpr := MathExpr.binary .mul e218 e64
private theorem p249 : expression tape.fetch 249 = e249 :=
  at_mul tape.fetch 249 218 64 (by rfl) (by decide) p218 (by decide) p64

private def e250 : MathExpr := MathExpr.binary .mul e4 e249
private theorem p250 : expression tape.fetch 250 = e250 :=
  at_mul tape.fetch 250 4 249 (by rfl) (by decide) p4 (by decide) p249

private def e251 : MathExpr := MathExpr.binary .mul e127 e127
private theorem p251 : expression tape.fetch 251 = e251 :=
  at_mul tape.fetch 251 127 127 (by rfl) (by decide) p127 (by decide) p127

private def e252 : MathExpr := MathExpr.binary .mul e231 e251
private theorem p252 : expression tape.fetch 252 = e252 :=
  at_mul tape.fetch 252 231 251 (by rfl) (by decide) p231 (by decide) p251

private def e253 : MathExpr := MathExpr.binary .min e250 e252
private theorem p253 : expression tape.fetch 253 = e253 :=
  at_min tape.fetch 253 250 252 (by rfl) (by decide) p250 (by decide) p252

private def e254 : MathExpr := MathExpr.binary .mul e130 e130
private theorem p254 : expression tape.fetch 254 = e254 :=
  at_mul tape.fetch 254 130 130 (by rfl) (by decide) p130 (by decide) p130

private def e255 : MathExpr := MathExpr.binary .mul e4 e254
private theorem p255 : expression tape.fetch 255 = e255 :=
  at_mul tape.fetch 255 4 254 (by rfl) (by decide) p4 (by decide) p254

private def e256 : MathExpr := MathExpr.binary .mul e132 e132
private theorem p256 : expression tape.fetch 256 = e256 :=
  at_mul tape.fetch 256 132 132 (by rfl) (by decide) p132 (by decide) p132

private def e257 : MathExpr := MathExpr.binary .mul e133 e133
private theorem p257 : expression tape.fetch 257 = e257 :=
  at_mul tape.fetch 257 133 133 (by rfl) (by decide) p133 (by decide) p133

private def e258 : MathExpr := MathExpr.binary .add e256 e257
private theorem p258 : expression tape.fetch 258 = e258 :=
  at_add tape.fetch 258 256 257 (by rfl) (by decide) p256 (by decide) p257

private def e259 : MathExpr := MathExpr.binary .mul e258 e8
private theorem p259 : expression tape.fetch 259 = e259 :=
  at_mul tape.fetch 259 258 8 (by rfl) (by decide) p258 (by decide) p8

private def e260 : MathExpr := MathExpr.unary .inv e259
private theorem p260 : expression tape.fetch 260 = e260 :=
  at_inv tape.fetch 260 259 0 (by rfl) (by decide) p259

private def e261 : MathExpr := MathExpr.binary .mul e2 e260
private theorem p261 : expression tape.fetch 261 = e261 :=
  at_mul tape.fetch 261 2 260 (by rfl) (by decide) p2 (by decide) p260

private def e262 : MathExpr := MathExpr.unary .sqrt e261
private theorem p262 : expression tape.fetch 262 = e262 :=
  at_sqrt tape.fetch 262 261 0 (by rfl) (by decide) p261

private def e263 : MathExpr := MathExpr.binary .mul e232 e40
private theorem p263 : expression tape.fetch 263 = e263 :=
  at_mul tape.fetch 263 232 40 (by rfl) (by decide) p232 (by decide) p40

private def e264 : MathExpr := MathExpr.binary .mul e262 e263
private theorem p264 : expression tape.fetch 264 = e264 :=
  at_mul tape.fetch 264 262 263 (by rfl) (by decide) p262 (by decide) p263

private def e265 : MathExpr := MathExpr.binary .min e255 e264
private theorem p265 : expression tape.fetch 265 = e265 :=
  at_min tape.fetch 265 255 264 (by rfl) (by decide) p255 (by decide) p264

private def e266 : MathExpr := MathExpr.unary .neg e265
private theorem p266 : expression tape.fetch 266 = e266 :=
  at_neg tape.fetch 266 265 0 (by rfl) (by decide) p265

private def e267 : MathExpr := MathExpr.binary .add e253 e266
private theorem p267 : expression tape.fetch 267 = e267 :=
  at_add tape.fetch 267 253 266 (by rfl) (by decide) p253 (by decide) p266

private def e268 : MathExpr := MathExpr.binary .max e267 e0
private theorem p268 : expression tape.fetch 268 = e268 :=
  at_max tape.fetch 268 267 0 (by rfl) (by decide) p267 (by decide) p0

private def e269 : MathExpr := MathExpr.rational (ScaledGrid.rational (73075081866545145910184241635814150982796627148800000000000000000000 : Int))
private theorem p269 : expression tape.fetch 269 = e269 :=
  at_literal tape.fetch 269 0 0 (73075081866545145910184241635814150982796627148800000000000000000000 : Int) (by rfl)

private def e270 : MathExpr := MathExpr.binary .mul e269 e16
private theorem p270 : expression tape.fetch 270 = e270 :=
  at_mul tape.fetch 270 269 16 (by rfl) (by decide) p269 (by decide) p16

private def e271 : MathExpr := MathExpr.binary .mul e270 e270
private theorem p271 : expression tape.fetch 271 = e271 :=
  at_mul tape.fetch 271 270 270 (by rfl) (by decide) p270 (by decide) p270

private def e272 : MathExpr := MathExpr.binary .add e48 e271
private theorem p272 : expression tape.fetch 272 = e272 :=
  at_add tape.fetch 272 48 271 (by rfl) (by decide) p48 (by decide) p271

private def e273 : MathExpr := MathExpr.unary .sqrt e272
private theorem p273 : expression tape.fetch 273 = e273 :=
  at_sqrt tape.fetch 273 272 0 (by rfl) (by decide) p272

private def e274 : MathExpr := MathExpr.unary .inv e273
private theorem p274 : expression tape.fetch 274 = e274 :=
  at_inv tape.fetch 274 273 0 (by rfl) (by decide) p273

private def e275 : MathExpr := MathExpr.binary .mul e47 e274
private theorem p275 : expression tape.fetch 275 = e275 :=
  at_mul tape.fetch 275 47 274 (by rfl) (by decide) p47 (by decide) p274

private def e276 : MathExpr := MathExpr.unary .log e275
private theorem p276 : expression tape.fetch 276 = e276 :=
  at_log tape.fetch 276 275 0 (by rfl) (by decide) p275

private def e277 : MathExpr := MathExpr.unary .inv e276
private theorem p277 : expression tape.fetch 277 = e277 :=
  at_inv tape.fetch 277 276 0 (by rfl) (by decide) p276

private def e278 : MathExpr := MathExpr.binary .mul e268 e277
private theorem p278 : expression tape.fetch 278 = e278 :=
  at_mul tape.fetch 278 268 277 (by rfl) (by decide) p268 (by decide) p277

private def e279 : MathExpr := MathExpr.binary .add e248 e278
private theorem p279 : expression tape.fetch 279 = e279 :=
  at_add tape.fetch 279 248 278 (by rfl) (by decide) p248 (by decide) p278

private def e280 : MathExpr := MathExpr.binary .mul e156 e156
private theorem p280 : expression tape.fetch 280 = e280 :=
  at_mul tape.fetch 280 156 156 (by rfl) (by decide) p156 (by decide) p156

private def e281 : MathExpr := MathExpr.binary .mul e4 e280
private theorem p281 : expression tape.fetch 281 = e281 :=
  at_mul tape.fetch 281 4 280 (by rfl) (by decide) p4 (by decide) p280

private def e282 : MathExpr := MathExpr.binary .mul e251 e18
private theorem p282 : expression tape.fetch 282 = e282 :=
  at_mul tape.fetch 282 251 18 (by rfl) (by decide) p251 (by decide) p18

private def e283 : MathExpr := MathExpr.binary .mul e262 e282
private theorem p283 : expression tape.fetch 283 = e283 :=
  at_mul tape.fetch 283 262 282 (by rfl) (by decide) p262 (by decide) p282

private def e284 : MathExpr := MathExpr.binary .min e281 e283
private theorem p284 : expression tape.fetch 284 = e284 :=
  at_min tape.fetch 284 281 283 (by rfl) (by decide) p281 (by decide) p283

private def e285 : MathExpr := MathExpr.binary .mul e254 e28
private theorem p285 : expression tape.fetch 285 = e285 :=
  at_mul tape.fetch 285 254 28 (by rfl) (by decide) p254 (by decide) p28

private def e286 : MathExpr := MathExpr.binary .mul e4 e285
private theorem p286 : expression tape.fetch 286 = e286 :=
  at_mul tape.fetch 286 4 285 (by rfl) (by decide) p4 (by decide) p285

private def e287 : MathExpr := MathExpr.binary .mul e256 e31
private theorem p287 : expression tape.fetch 287 = e287 :=
  at_mul tape.fetch 287 256 31 (by rfl) (by decide) p256 (by decide) p31

private def e288 : MathExpr := MathExpr.binary .mul e257 e32
private theorem p288 : expression tape.fetch 288 = e288 :=
  at_mul tape.fetch 288 257 32 (by rfl) (by decide) p257 (by decide) p32

private def e289 : MathExpr := MathExpr.binary .add e287 e288
private theorem p289 : expression tape.fetch 289 = e289 :=
  at_add tape.fetch 289 287 288 (by rfl) (by decide) p287 (by decide) p288

private def e290 : MathExpr := MathExpr.binary .mul e289 e8
private theorem p290 : expression tape.fetch 290 = e290 :=
  at_mul tape.fetch 290 289 8 (by rfl) (by decide) p289 (by decide) p8

private def e291 : MathExpr := MathExpr.unary .inv e290
private theorem p291 : expression tape.fetch 291 = e291 :=
  at_inv tape.fetch 291 290 0 (by rfl) (by decide) p290

private def e292 : MathExpr := MathExpr.binary .mul e2 e291
private theorem p292 : expression tape.fetch 292 = e292 :=
  at_mul tape.fetch 292 2 291 (by rfl) (by decide) p2 (by decide) p291

private def e293 : MathExpr := MathExpr.unary .sqrt e292
private theorem p293 : expression tape.fetch 293 = e293 :=
  at_sqrt tape.fetch 293 292 0 (by rfl) (by decide) p292

private def e294 : MathExpr := MathExpr.binary .mul e139 e139
private theorem p294 : expression tape.fetch 294 = e294 :=
  at_mul tape.fetch 294 139 139 (by rfl) (by decide) p139 (by decide) p139

private def e295 : MathExpr := MathExpr.binary .mul e293 e294
private theorem p295 : expression tape.fetch 295 = e295 :=
  at_mul tape.fetch 295 293 294 (by rfl) (by decide) p293 (by decide) p294

private def e296 : MathExpr := MathExpr.binary .min e286 e295
private theorem p296 : expression tape.fetch 296 = e296 :=
  at_min tape.fetch 296 286 295 (by rfl) (by decide) p286 (by decide) p295

private def e297 : MathExpr := MathExpr.unary .neg e296
private theorem p297 : expression tape.fetch 297 = e297 :=
  at_neg tape.fetch 297 296 0 (by rfl) (by decide) p296

private def e298 : MathExpr := MathExpr.binary .add e284 e297
private theorem p298 : expression tape.fetch 298 = e298 :=
  at_add tape.fetch 298 284 297 (by rfl) (by decide) p284 (by decide) p297

private def e299 : MathExpr := MathExpr.binary .max e298 e0
private theorem p299 : expression tape.fetch 299 = e299 :=
  at_max tape.fetch 299 298 0 (by rfl) (by decide) p298 (by decide) p0

private def e300 : MathExpr := MathExpr.rational (ScaledGrid.rational (82209467099863289148957271840290919855646205542400000000000000000000 : Int))
private theorem p300 : expression tape.fetch 300 = e300 :=
  at_literal tape.fetch 300 0 0 (82209467099863289148957271840290919855646205542400000000000000000000 : Int) (by rfl)

private def e301 : MathExpr := MathExpr.binary .mul e300 e16
private theorem p301 : expression tape.fetch 301 = e301 :=
  at_mul tape.fetch 301 300 16 (by rfl) (by decide) p300 (by decide) p16

private def e302 : MathExpr := MathExpr.binary .mul e301 e301
private theorem p302 : expression tape.fetch 302 = e302 :=
  at_mul tape.fetch 302 301 301 (by rfl) (by decide) p301 (by decide) p301

private def e303 : MathExpr := MathExpr.binary .add e48 e302
private theorem p303 : expression tape.fetch 303 = e303 :=
  at_add tape.fetch 303 48 302 (by rfl) (by decide) p48 (by decide) p302

private def e304 : MathExpr := MathExpr.unary .sqrt e303
private theorem p304 : expression tape.fetch 304 = e304 :=
  at_sqrt tape.fetch 304 303 0 (by rfl) (by decide) p303

private def e305 : MathExpr := MathExpr.unary .inv e304
private theorem p305 : expression tape.fetch 305 = e305 :=
  at_inv tape.fetch 305 304 0 (by rfl) (by decide) p304

private def e306 : MathExpr := MathExpr.binary .mul e47 e305
private theorem p306 : expression tape.fetch 306 = e306 :=
  at_mul tape.fetch 306 47 305 (by rfl) (by decide) p47 (by decide) p305

private def e307 : MathExpr := MathExpr.unary .log e306
private theorem p307 : expression tape.fetch 307 = e307 :=
  at_log tape.fetch 307 306 0 (by rfl) (by decide) p306

private def e308 : MathExpr := MathExpr.unary .inv e307
private theorem p308 : expression tape.fetch 308 = e308 :=
  at_inv tape.fetch 308 307 0 (by rfl) (by decide) p307

private def e309 : MathExpr := MathExpr.binary .mul e299 e308
private theorem p309 : expression tape.fetch 309 = e309 :=
  at_mul tape.fetch 309 299 308 (by rfl) (by decide) p299 (by decide) p308

private def e310 : MathExpr := MathExpr.binary .add e279 e309
private theorem p310 : expression tape.fetch 310 = e310 :=
  at_add tape.fetch 310 279 309 (by rfl) (by decide) p279 (by decide) p309

private def e311 : MathExpr := MathExpr.binary .mul e280 e64
private theorem p311 : expression tape.fetch 311 = e311 :=
  at_mul tape.fetch 311 280 64 (by rfl) (by decide) p280 (by decide) p64

private def e312 : MathExpr := MathExpr.binary .mul e4 e311
private theorem p312 : expression tape.fetch 312 = e312 :=
  at_mul tape.fetch 312 4 311 (by rfl) (by decide) p4 (by decide) p311

private def e313 : MathExpr := MathExpr.binary .mul e158 e158
private theorem p313 : expression tape.fetch 313 = e313 :=
  at_mul tape.fetch 313 158 158 (by rfl) (by decide) p158 (by decide) p158

private def e314 : MathExpr := MathExpr.binary .mul e293 e313
private theorem p314 : expression tape.fetch 314 = e314 :=
  at_mul tape.fetch 314 293 313 (by rfl) (by decide) p293 (by decide) p313

private def e315 : MathExpr := MathExpr.binary .min e312 e314
private theorem p315 : expression tape.fetch 315 = e315 :=
  at_min tape.fetch 315 312 314 (by rfl) (by decide) p312 (by decide) p314

private def e316 : MathExpr := MathExpr.binary .mul e161 e161
private theorem p316 : expression tape.fetch 316 = e316 :=
  at_mul tape.fetch 316 161 161 (by rfl) (by decide) p161 (by decide) p161

private def e317 : MathExpr := MathExpr.binary .mul e4 e316
private theorem p317 : expression tape.fetch 317 = e317 :=
  at_mul tape.fetch 317 4 316 (by rfl) (by decide) p4 (by decide) p316

private def e318 : MathExpr := MathExpr.binary .mul e163 e163
private theorem p318 : expression tape.fetch 318 = e318 :=
  at_mul tape.fetch 318 163 163 (by rfl) (by decide) p163 (by decide) p163

private def e319 : MathExpr := MathExpr.binary .mul e164 e164
private theorem p319 : expression tape.fetch 319 = e319 :=
  at_mul tape.fetch 319 164 164 (by rfl) (by decide) p164 (by decide) p164

private def e320 : MathExpr := MathExpr.binary .add e318 e319
private theorem p320 : expression tape.fetch 320 = e320 :=
  at_add tape.fetch 320 318 319 (by rfl) (by decide) p318 (by decide) p319

private def e321 : MathExpr := MathExpr.binary .mul e320 e8
private theorem p321 : expression tape.fetch 321 = e321 :=
  at_mul tape.fetch 321 320 8 (by rfl) (by decide) p320 (by decide) p8

private def e322 : MathExpr := MathExpr.unary .inv e321
private theorem p322 : expression tape.fetch 322 = e322 :=
  at_inv tape.fetch 322 321 0 (by rfl) (by decide) p321

private def e323 : MathExpr := MathExpr.binary .mul e2 e322
private theorem p323 : expression tape.fetch 323 = e323 :=
  at_mul tape.fetch 323 2 322 (by rfl) (by decide) p2 (by decide) p322

private def e324 : MathExpr := MathExpr.unary .sqrt e323
private theorem p324 : expression tape.fetch 324 = e324 :=
  at_sqrt tape.fetch 324 323 0 (by rfl) (by decide) p323

private def e325 : MathExpr := MathExpr.binary .mul e294 e40
private theorem p325 : expression tape.fetch 325 = e325 :=
  at_mul tape.fetch 325 294 40 (by rfl) (by decide) p294 (by decide) p40

private def e326 : MathExpr := MathExpr.binary .mul e324 e325
private theorem p326 : expression tape.fetch 326 = e326 :=
  at_mul tape.fetch 326 324 325 (by rfl) (by decide) p324 (by decide) p325

private def e327 : MathExpr := MathExpr.binary .min e317 e326
private theorem p327 : expression tape.fetch 327 = e327 :=
  at_min tape.fetch 327 317 326 (by rfl) (by decide) p317 (by decide) p326

private def e328 : MathExpr := MathExpr.unary .neg e327
private theorem p328 : expression tape.fetch 328 = e328 :=
  at_neg tape.fetch 328 327 0 (by rfl) (by decide) p327

private def e329 : MathExpr := MathExpr.binary .add e315 e328
private theorem p329 : expression tape.fetch 329 = e329 :=
  at_add tape.fetch 329 315 328 (by rfl) (by decide) p315 (by decide) p328

private def e330 : MathExpr := MathExpr.binary .max e329 e0
private theorem p330 : expression tape.fetch 330 = e330 :=
  at_max tape.fetch 330 329 0 (by rfl) (by decide) p329 (by decide) p0

private def e331 : MathExpr := MathExpr.binary .mul e47 e16
private theorem p331 : expression tape.fetch 331 = e331 :=
  at_mul tape.fetch 331 47 16 (by rfl) (by decide) p47 (by decide) p16

private def e332 : MathExpr := MathExpr.binary .mul e331 e331
private theorem p332 : expression tape.fetch 332 = e332 :=
  at_mul tape.fetch 332 331 331 (by rfl) (by decide) p331 (by decide) p331

private def e333 : MathExpr := MathExpr.binary .add e48 e332
private theorem p333 : expression tape.fetch 333 = e333 :=
  at_add tape.fetch 333 48 332 (by rfl) (by decide) p48 (by decide) p332

private def e334 : MathExpr := MathExpr.unary .sqrt e333
private theorem p334 : expression tape.fetch 334 = e334 :=
  at_sqrt tape.fetch 334 333 0 (by rfl) (by decide) p333

private def e335 : MathExpr := MathExpr.unary .inv e334
private theorem p335 : expression tape.fetch 335 = e335 :=
  at_inv tape.fetch 335 334 0 (by rfl) (by decide) p334

private def e336 : MathExpr := MathExpr.binary .mul e47 e335
private theorem p336 : expression tape.fetch 336 = e336 :=
  at_mul tape.fetch 336 47 335 (by rfl) (by decide) p47 (by decide) p335

private def e337 : MathExpr := MathExpr.unary .log e336
private theorem p337 : expression tape.fetch 337 = e337 :=
  at_log tape.fetch 337 336 0 (by rfl) (by decide) p336

private def e338 : MathExpr := MathExpr.unary .inv e337
private theorem p338 : expression tape.fetch 338 = e338 :=
  at_inv tape.fetch 338 337 0 (by rfl) (by decide) p337

private def e339 : MathExpr := MathExpr.binary .mul e330 e338
private theorem p339 : expression tape.fetch 339 = e339 :=
  at_mul tape.fetch 339 330 338 (by rfl) (by decide) p330 (by decide) p338

private def e340 : MathExpr := MathExpr.binary .add e310 e339
private theorem p340 : expression tape.fetch 340 = e340 :=
  at_add tape.fetch 340 310 339 (by rfl) (by decide) p310 (by decide) p339

private def e341 : MathExpr := MathExpr.binary .mul e187 e187
private theorem p341 : expression tape.fetch 341 = e341 :=
  at_mul tape.fetch 341 187 187 (by rfl) (by decide) p187 (by decide) p187

private def e342 : MathExpr := MathExpr.binary .mul e4 e341
private theorem p342 : expression tape.fetch 342 = e342 :=
  at_mul tape.fetch 342 4 341 (by rfl) (by decide) p4 (by decide) p341

private def e343 : MathExpr := MathExpr.binary .mul e313 e18
private theorem p343 : expression tape.fetch 343 = e343 :=
  at_mul tape.fetch 343 313 18 (by rfl) (by decide) p313 (by decide) p18

private def e344 : MathExpr := MathExpr.binary .mul e324 e343
private theorem p344 : expression tape.fetch 344 = e344 :=
  at_mul tape.fetch 344 324 343 (by rfl) (by decide) p324 (by decide) p343

private def e345 : MathExpr := MathExpr.binary .min e342 e344
private theorem p345 : expression tape.fetch 345 = e345 :=
  at_min tape.fetch 345 342 344 (by rfl) (by decide) p342 (by decide) p344

private def e346 : MathExpr := MathExpr.binary .mul e316 e28
private theorem p346 : expression tape.fetch 346 = e346 :=
  at_mul tape.fetch 346 316 28 (by rfl) (by decide) p316 (by decide) p28

private def e347 : MathExpr := MathExpr.binary .mul e4 e346
private theorem p347 : expression tape.fetch 347 = e347 :=
  at_mul tape.fetch 347 4 346 (by rfl) (by decide) p4 (by decide) p346

private def e348 : MathExpr := MathExpr.binary .mul e318 e31
private theorem p348 : expression tape.fetch 348 = e348 :=
  at_mul tape.fetch 348 318 31 (by rfl) (by decide) p318 (by decide) p31

private def e349 : MathExpr := MathExpr.binary .mul e319 e32
private theorem p349 : expression tape.fetch 349 = e349 :=
  at_mul tape.fetch 349 319 32 (by rfl) (by decide) p319 (by decide) p32

private def e350 : MathExpr := MathExpr.binary .add e348 e349
private theorem p350 : expression tape.fetch 350 = e350 :=
  at_add tape.fetch 350 348 349 (by rfl) (by decide) p348 (by decide) p349

private def e351 : MathExpr := MathExpr.binary .mul e350 e8
private theorem p351 : expression tape.fetch 351 = e351 :=
  at_mul tape.fetch 351 350 8 (by rfl) (by decide) p350 (by decide) p8

private def e352 : MathExpr := MathExpr.unary .inv e351
private theorem p352 : expression tape.fetch 352 = e352 :=
  at_inv tape.fetch 352 351 0 (by rfl) (by decide) p351

private def e353 : MathExpr := MathExpr.binary .mul e2 e352
private theorem p353 : expression tape.fetch 353 = e353 :=
  at_mul tape.fetch 353 2 352 (by rfl) (by decide) p2 (by decide) p352

private def e354 : MathExpr := MathExpr.unary .sqrt e353
private theorem p354 : expression tape.fetch 354 = e354 :=
  at_sqrt tape.fetch 354 353 0 (by rfl) (by decide) p353

private def e355 : MathExpr := MathExpr.binary .mul e170 e170
private theorem p355 : expression tape.fetch 355 = e355 :=
  at_mul tape.fetch 355 170 170 (by rfl) (by decide) p170 (by decide) p170

private def e356 : MathExpr := MathExpr.binary .mul e354 e355
private theorem p356 : expression tape.fetch 356 = e356 :=
  at_mul tape.fetch 356 354 355 (by rfl) (by decide) p354 (by decide) p355

private def e357 : MathExpr := MathExpr.binary .min e347 e356
private theorem p357 : expression tape.fetch 357 = e357 :=
  at_min tape.fetch 357 347 356 (by rfl) (by decide) p347 (by decide) p356

private def e358 : MathExpr := MathExpr.unary .neg e357
private theorem p358 : expression tape.fetch 358 = e358 :=
  at_neg tape.fetch 358 357 0 (by rfl) (by decide) p357

private def e359 : MathExpr := MathExpr.binary .add e345 e358
private theorem p359 : expression tape.fetch 359 = e359 :=
  at_add tape.fetch 359 345 358 (by rfl) (by decide) p345 (by decide) p358

private def e360 : MathExpr := MathExpr.binary .max e359 e0
private theorem p360 : expression tape.fetch 360 = e360 :=
  at_max tape.fetch 360 359 0 (by rfl) (by decide) p359 (by decide) p0

private def e361 : MathExpr := MathExpr.rational (ScaledGrid.rational (100478237566499575626503332249244457601345362329600000000000000000000 : Int))
private theorem p361 : expression tape.fetch 361 = e361 :=
  at_literal tape.fetch 361 0 0 (100478237566499575626503332249244457601345362329600000000000000000000 : Int) (by rfl)

private def e362 : MathExpr := MathExpr.binary .mul e361 e16
private theorem p362 : expression tape.fetch 362 = e362 :=
  at_mul tape.fetch 362 361 16 (by rfl) (by decide) p361 (by decide) p16

private def e363 : MathExpr := MathExpr.binary .mul e362 e362
private theorem p363 : expression tape.fetch 363 = e363 :=
  at_mul tape.fetch 363 362 362 (by rfl) (by decide) p362 (by decide) p362

private def e364 : MathExpr := MathExpr.binary .add e48 e363
private theorem p364 : expression tape.fetch 364 = e364 :=
  at_add tape.fetch 364 48 363 (by rfl) (by decide) p48 (by decide) p363

private def e365 : MathExpr := MathExpr.unary .sqrt e364
private theorem p365 : expression tape.fetch 365 = e365 :=
  at_sqrt tape.fetch 365 364 0 (by rfl) (by decide) p364

private def e366 : MathExpr := MathExpr.unary .inv e365
private theorem p366 : expression tape.fetch 366 = e366 :=
  at_inv tape.fetch 366 365 0 (by rfl) (by decide) p365

private def e367 : MathExpr := MathExpr.binary .mul e47 e366
private theorem p367 : expression tape.fetch 367 = e367 :=
  at_mul tape.fetch 367 47 366 (by rfl) (by decide) p47 (by decide) p366

private def e368 : MathExpr := MathExpr.unary .log e367
private theorem p368 : expression tape.fetch 368 = e368 :=
  at_log tape.fetch 368 367 0 (by rfl) (by decide) p367

private def e369 : MathExpr := MathExpr.unary .inv e368
private theorem p369 : expression tape.fetch 369 = e369 :=
  at_inv tape.fetch 369 368 0 (by rfl) (by decide) p368

private def e370 : MathExpr := MathExpr.binary .mul e360 e369
private theorem p370 : expression tape.fetch 370 = e370 :=
  at_mul tape.fetch 370 360 369 (by rfl) (by decide) p360 (by decide) p369

private def e371 : MathExpr := MathExpr.binary .add e340 e370
private theorem p371 : expression tape.fetch 371 = e371 :=
  at_add tape.fetch 371 340 370 (by rfl) (by decide) p340 (by decide) p370

private def e372 : MathExpr := MathExpr.binary .mul e341 e64
private theorem p372 : expression tape.fetch 372 = e372 :=
  at_mul tape.fetch 372 341 64 (by rfl) (by decide) p341 (by decide) p64

private def e373 : MathExpr := MathExpr.binary .mul e4 e372
private theorem p373 : expression tape.fetch 373 = e373 :=
  at_mul tape.fetch 373 4 372 (by rfl) (by decide) p4 (by decide) p372

private def e374 : MathExpr := MathExpr.binary .mul e189 e189
private theorem p374 : expression tape.fetch 374 = e374 :=
  at_mul tape.fetch 374 189 189 (by rfl) (by decide) p189 (by decide) p189

private def e375 : MathExpr := MathExpr.binary .mul e354 e374
private theorem p375 : expression tape.fetch 375 = e375 :=
  at_mul tape.fetch 375 354 374 (by rfl) (by decide) p354 (by decide) p374

private def e376 : MathExpr := MathExpr.binary .min e373 e375
private theorem p376 : expression tape.fetch 376 = e376 :=
  at_min tape.fetch 376 373 375 (by rfl) (by decide) p373 (by decide) p375

private def e377 : MathExpr := MathExpr.binary .mul e192 e192
private theorem p377 : expression tape.fetch 377 = e377 :=
  at_mul tape.fetch 377 192 192 (by rfl) (by decide) p192 (by decide) p192

private def e378 : MathExpr := MathExpr.binary .mul e4 e377
private theorem p378 : expression tape.fetch 378 = e378 :=
  at_mul tape.fetch 378 4 377 (by rfl) (by decide) p4 (by decide) p377

private def e379 : MathExpr := MathExpr.binary .mul e194 e194
private theorem p379 : expression tape.fetch 379 = e379 :=
  at_mul tape.fetch 379 194 194 (by rfl) (by decide) p194 (by decide) p194

private def e380 : MathExpr := MathExpr.binary .mul e195 e195
private theorem p380 : expression tape.fetch 380 = e380 :=
  at_mul tape.fetch 380 195 195 (by rfl) (by decide) p195 (by decide) p195

private def e381 : MathExpr := MathExpr.binary .add e379 e380
private theorem p381 : expression tape.fetch 381 = e381 :=
  at_add tape.fetch 381 379 380 (by rfl) (by decide) p379 (by decide) p380

private def e382 : MathExpr := MathExpr.binary .mul e381 e8
private theorem p382 : expression tape.fetch 382 = e382 :=
  at_mul tape.fetch 382 381 8 (by rfl) (by decide) p381 (by decide) p8

private def e383 : MathExpr := MathExpr.unary .inv e382
private theorem p383 : expression tape.fetch 383 = e383 :=
  at_inv tape.fetch 383 382 0 (by rfl) (by decide) p382

private def e384 : MathExpr := MathExpr.binary .mul e2 e383
private theorem p384 : expression tape.fetch 384 = e384 :=
  at_mul tape.fetch 384 2 383 (by rfl) (by decide) p2 (by decide) p383

private def e385 : MathExpr := MathExpr.unary .sqrt e384
private theorem p385 : expression tape.fetch 385 = e385 :=
  at_sqrt tape.fetch 385 384 0 (by rfl) (by decide) p384

private def e386 : MathExpr := MathExpr.binary .mul e355 e40
private theorem p386 : expression tape.fetch 386 = e386 :=
  at_mul tape.fetch 386 355 40 (by rfl) (by decide) p355 (by decide) p40

private def e387 : MathExpr := MathExpr.binary .mul e385 e386
private theorem p387 : expression tape.fetch 387 = e387 :=
  at_mul tape.fetch 387 385 386 (by rfl) (by decide) p385 (by decide) p386

private def e388 : MathExpr := MathExpr.binary .min e378 e387
private theorem p388 : expression tape.fetch 388 = e388 :=
  at_min tape.fetch 388 378 387 (by rfl) (by decide) p378 (by decide) p387

private def e389 : MathExpr := MathExpr.unary .neg e388
private theorem p389 : expression tape.fetch 389 = e389 :=
  at_neg tape.fetch 389 388 0 (by rfl) (by decide) p388

private def e390 : MathExpr := MathExpr.binary .add e376 e389
private theorem p390 : expression tape.fetch 390 = e390 :=
  at_add tape.fetch 390 376 389 (by rfl) (by decide) p376 (by decide) p389

private def e391 : MathExpr := MathExpr.binary .max e390 e0
private theorem p391 : expression tape.fetch 391 = e391 :=
  at_max tape.fetch 391 390 0 (by rfl) (by decide) p390 (by decide) p0

private def e392 : MathExpr := MathExpr.rational (ScaledGrid.rational (109612622799817718865276362453721226474194940723200000000000000000000 : Int))
private theorem p392 : expression tape.fetch 392 = e392 :=
  at_literal tape.fetch 392 0 0 (109612622799817718865276362453721226474194940723200000000000000000000 : Int) (by rfl)

private def e393 : MathExpr := MathExpr.binary .mul e392 e16
private theorem p393 : expression tape.fetch 393 = e393 :=
  at_mul tape.fetch 393 392 16 (by rfl) (by decide) p392 (by decide) p16

private def e394 : MathExpr := MathExpr.binary .mul e393 e393
private theorem p394 : expression tape.fetch 394 = e394 :=
  at_mul tape.fetch 394 393 393 (by rfl) (by decide) p393 (by decide) p393

private def e395 : MathExpr := MathExpr.binary .add e48 e394
private theorem p395 : expression tape.fetch 395 = e395 :=
  at_add tape.fetch 395 48 394 (by rfl) (by decide) p48 (by decide) p394

private def e396 : MathExpr := MathExpr.unary .sqrt e395
private theorem p396 : expression tape.fetch 396 = e396 :=
  at_sqrt tape.fetch 396 395 0 (by rfl) (by decide) p395

private def e397 : MathExpr := MathExpr.unary .inv e396
private theorem p397 : expression tape.fetch 397 = e397 :=
  at_inv tape.fetch 397 396 0 (by rfl) (by decide) p396

private def e398 : MathExpr := MathExpr.binary .mul e47 e397
private theorem p398 : expression tape.fetch 398 = e398 :=
  at_mul tape.fetch 398 47 397 (by rfl) (by decide) p47 (by decide) p397

private def e399 : MathExpr := MathExpr.unary .log e398
private theorem p399 : expression tape.fetch 399 = e399 :=
  at_log tape.fetch 399 398 0 (by rfl) (by decide) p398

private def e400 : MathExpr := MathExpr.unary .inv e399
private theorem p400 : expression tape.fetch 400 = e400 :=
  at_inv tape.fetch 400 399 0 (by rfl) (by decide) p399

private def e401 : MathExpr := MathExpr.binary .mul e391 e400
private theorem p401 : expression tape.fetch 401 = e401 :=
  at_mul tape.fetch 401 391 400 (by rfl) (by decide) p391 (by decide) p400

private def e402 : MathExpr := MathExpr.binary .add e371 e401
private theorem p402 : expression tape.fetch 402 = e402 :=
  at_add tape.fetch 402 371 401 (by rfl) (by decide) p371 (by decide) p401

private def e403 : MathExpr := MathExpr.binary .mul e218 e218
private theorem p403 : expression tape.fetch 403 = e403 :=
  at_mul tape.fetch 403 218 218 (by rfl) (by decide) p218 (by decide) p218

private def e404 : MathExpr := MathExpr.binary .mul e4 e403
private theorem p404 : expression tape.fetch 404 = e404 :=
  at_mul tape.fetch 404 4 403 (by rfl) (by decide) p4 (by decide) p403

private def e405 : MathExpr := MathExpr.binary .mul e374 e18
private theorem p405 : expression tape.fetch 405 = e405 :=
  at_mul tape.fetch 405 374 18 (by rfl) (by decide) p374 (by decide) p18

private def e406 : MathExpr := MathExpr.binary .mul e385 e405
private theorem p406 : expression tape.fetch 406 = e406 :=
  at_mul tape.fetch 406 385 405 (by rfl) (by decide) p385 (by decide) p405

private def e407 : MathExpr := MathExpr.binary .min e404 e406
private theorem p407 : expression tape.fetch 407 = e407 :=
  at_min tape.fetch 407 404 406 (by rfl) (by decide) p404 (by decide) p406

private def e408 : MathExpr := MathExpr.binary .mul e377 e28
private theorem p408 : expression tape.fetch 408 = e408 :=
  at_mul tape.fetch 408 377 28 (by rfl) (by decide) p377 (by decide) p28

private def e409 : MathExpr := MathExpr.binary .mul e4 e408
private theorem p409 : expression tape.fetch 409 = e409 :=
  at_mul tape.fetch 409 4 408 (by rfl) (by decide) p4 (by decide) p408

private def e410 : MathExpr := MathExpr.binary .mul e379 e31
private theorem p410 : expression tape.fetch 410 = e410 :=
  at_mul tape.fetch 410 379 31 (by rfl) (by decide) p379 (by decide) p31

private def e411 : MathExpr := MathExpr.binary .mul e380 e32
private theorem p411 : expression tape.fetch 411 = e411 :=
  at_mul tape.fetch 411 380 32 (by rfl) (by decide) p380 (by decide) p32

private def e412 : MathExpr := MathExpr.binary .add e410 e411
private theorem p412 : expression tape.fetch 412 = e412 :=
  at_add tape.fetch 412 410 411 (by rfl) (by decide) p410 (by decide) p411

private def e413 : MathExpr := MathExpr.binary .mul e412 e8
private theorem p413 : expression tape.fetch 413 = e413 :=
  at_mul tape.fetch 413 412 8 (by rfl) (by decide) p412 (by decide) p8

private def e414 : MathExpr := MathExpr.unary .inv e413
private theorem p414 : expression tape.fetch 414 = e414 :=
  at_inv tape.fetch 414 413 0 (by rfl) (by decide) p413

private def e415 : MathExpr := MathExpr.binary .mul e2 e414
private theorem p415 : expression tape.fetch 415 = e415 :=
  at_mul tape.fetch 415 2 414 (by rfl) (by decide) p2 (by decide) p414

private def e416 : MathExpr := MathExpr.unary .sqrt e415
private theorem p416 : expression tape.fetch 416 = e416 :=
  at_sqrt tape.fetch 416 415 0 (by rfl) (by decide) p415

private def e417 : MathExpr := MathExpr.binary .mul e201 e201
private theorem p417 : expression tape.fetch 417 = e417 :=
  at_mul tape.fetch 417 201 201 (by rfl) (by decide) p201 (by decide) p201

private def e418 : MathExpr := MathExpr.binary .mul e416 e417
private theorem p418 : expression tape.fetch 418 = e418 :=
  at_mul tape.fetch 418 416 417 (by rfl) (by decide) p416 (by decide) p417

private def e419 : MathExpr := MathExpr.binary .min e409 e418
private theorem p419 : expression tape.fetch 419 = e419 :=
  at_min tape.fetch 419 409 418 (by rfl) (by decide) p409 (by decide) p418

private def e420 : MathExpr := MathExpr.unary .neg e419
private theorem p420 : expression tape.fetch 420 = e420 :=
  at_neg tape.fetch 420 419 0 (by rfl) (by decide) p419

private def e421 : MathExpr := MathExpr.binary .add e407 e420
private theorem p421 : expression tape.fetch 421 = e421 :=
  at_add tape.fetch 421 407 420 (by rfl) (by decide) p407 (by decide) p420

private def e422 : MathExpr := MathExpr.binary .max e421 e0
private theorem p422 : expression tape.fetch 422 = e422 :=
  at_max tape.fetch 422 421 0 (by rfl) (by decide) p421 (by decide) p0

private def e423 : MathExpr := MathExpr.rational (ScaledGrid.rational (118747008033135862104049392658197995347044519116800000000000000000000 : Int))
private theorem p423 : expression tape.fetch 423 = e423 :=
  at_literal tape.fetch 423 0 0 (118747008033135862104049392658197995347044519116800000000000000000000 : Int) (by rfl)

private def e424 : MathExpr := MathExpr.binary .mul e423 e16
private theorem p424 : expression tape.fetch 424 = e424 :=
  at_mul tape.fetch 424 423 16 (by rfl) (by decide) p423 (by decide) p16

private def e425 : MathExpr := MathExpr.binary .mul e424 e424
private theorem p425 : expression tape.fetch 425 = e425 :=
  at_mul tape.fetch 425 424 424 (by rfl) (by decide) p424 (by decide) p424

private def e426 : MathExpr := MathExpr.binary .add e48 e425
private theorem p426 : expression tape.fetch 426 = e426 :=
  at_add tape.fetch 426 48 425 (by rfl) (by decide) p48 (by decide) p425

private def e427 : MathExpr := MathExpr.unary .sqrt e426
private theorem p427 : expression tape.fetch 427 = e427 :=
  at_sqrt tape.fetch 427 426 0 (by rfl) (by decide) p426

private def e428 : MathExpr := MathExpr.unary .inv e427
private theorem p428 : expression tape.fetch 428 = e428 :=
  at_inv tape.fetch 428 427 0 (by rfl) (by decide) p427

private def e429 : MathExpr := MathExpr.binary .mul e47 e428
private theorem p429 : expression tape.fetch 429 = e429 :=
  at_mul tape.fetch 429 47 428 (by rfl) (by decide) p47 (by decide) p428

private def e430 : MathExpr := MathExpr.unary .log e429
private theorem p430 : expression tape.fetch 430 = e430 :=
  at_log tape.fetch 430 429 0 (by rfl) (by decide) p429

private def e431 : MathExpr := MathExpr.unary .inv e430
private theorem p431 : expression tape.fetch 431 = e431 :=
  at_inv tape.fetch 431 430 0 (by rfl) (by decide) p430

private def e432 : MathExpr := MathExpr.binary .mul e422 e431
private theorem p432 : expression tape.fetch 432 = e432 :=
  at_mul tape.fetch 432 422 431 (by rfl) (by decide) p422 (by decide) p431

private def e433 : MathExpr := MathExpr.binary .add e402 e432
private theorem p433 : expression tape.fetch 433 = e433 :=
  at_add tape.fetch 433 402 432 (by rfl) (by decide) p402 (by decide) p432

private def e434 : MathExpr := MathExpr.binary .mul e403 e64
private theorem p434 : expression tape.fetch 434 = e434 :=
  at_mul tape.fetch 434 403 64 (by rfl) (by decide) p403 (by decide) p64

private def e435 : MathExpr := MathExpr.binary .mul e4 e434
private theorem p435 : expression tape.fetch 435 = e435 :=
  at_mul tape.fetch 435 4 434 (by rfl) (by decide) p4 (by decide) p434

private def e436 : MathExpr := MathExpr.binary .mul e220 e220
private theorem p436 : expression tape.fetch 436 = e436 :=
  at_mul tape.fetch 436 220 220 (by rfl) (by decide) p220 (by decide) p220

private def e437 : MathExpr := MathExpr.binary .mul e416 e436
private theorem p437 : expression tape.fetch 437 = e437 :=
  at_mul tape.fetch 437 416 436 (by rfl) (by decide) p416 (by decide) p436

private def e438 : MathExpr := MathExpr.binary .min e435 e437
private theorem p438 : expression tape.fetch 438 = e438 :=
  at_min tape.fetch 438 435 437 (by rfl) (by decide) p435 (by decide) p437

private def e439 : MathExpr := MathExpr.binary .mul e223 e223
private theorem p439 : expression tape.fetch 439 = e439 :=
  at_mul tape.fetch 439 223 223 (by rfl) (by decide) p223 (by decide) p223

private def e440 : MathExpr := MathExpr.binary .mul e4 e439
private theorem p440 : expression tape.fetch 440 = e440 :=
  at_mul tape.fetch 440 4 439 (by rfl) (by decide) p4 (by decide) p439

private def e441 : MathExpr := MathExpr.binary .mul e225 e225
private theorem p441 : expression tape.fetch 441 = e441 :=
  at_mul tape.fetch 441 225 225 (by rfl) (by decide) p225 (by decide) p225

private def e442 : MathExpr := MathExpr.binary .mul e226 e226
private theorem p442 : expression tape.fetch 442 = e442 :=
  at_mul tape.fetch 442 226 226 (by rfl) (by decide) p226 (by decide) p226

private def e443 : MathExpr := MathExpr.binary .add e441 e442
private theorem p443 : expression tape.fetch 443 = e443 :=
  at_add tape.fetch 443 441 442 (by rfl) (by decide) p441 (by decide) p442

private def e444 : MathExpr := MathExpr.binary .mul e443 e8
private theorem p444 : expression tape.fetch 444 = e444 :=
  at_mul tape.fetch 444 443 8 (by rfl) (by decide) p443 (by decide) p8

private def e445 : MathExpr := MathExpr.unary .inv e444
private theorem p445 : expression tape.fetch 445 = e445 :=
  at_inv tape.fetch 445 444 0 (by rfl) (by decide) p444

private def e446 : MathExpr := MathExpr.binary .mul e2 e445
private theorem p446 : expression tape.fetch 446 = e446 :=
  at_mul tape.fetch 446 2 445 (by rfl) (by decide) p2 (by decide) p445

private def e447 : MathExpr := MathExpr.unary .sqrt e446
private theorem p447 : expression tape.fetch 447 = e447 :=
  at_sqrt tape.fetch 447 446 0 (by rfl) (by decide) p446

private def e448 : MathExpr := MathExpr.binary .mul e417 e40
private theorem p448 : expression tape.fetch 448 = e448 :=
  at_mul tape.fetch 448 417 40 (by rfl) (by decide) p417 (by decide) p40

private def e449 : MathExpr := MathExpr.binary .mul e447 e448
private theorem p449 : expression tape.fetch 449 = e449 :=
  at_mul tape.fetch 449 447 448 (by rfl) (by decide) p447 (by decide) p448

private def e450 : MathExpr := MathExpr.binary .min e440 e449
private theorem p450 : expression tape.fetch 450 = e450 :=
  at_min tape.fetch 450 440 449 (by rfl) (by decide) p440 (by decide) p449

private def e451 : MathExpr := MathExpr.unary .neg e450
private theorem p451 : expression tape.fetch 451 = e451 :=
  at_neg tape.fetch 451 450 0 (by rfl) (by decide) p450

private def e452 : MathExpr := MathExpr.binary .add e438 e451
private theorem p452 : expression tape.fetch 452 = e452 :=
  at_add tape.fetch 452 438 451 (by rfl) (by decide) p438 (by decide) p451

private def e453 : MathExpr := MathExpr.binary .max e452 e0
private theorem p453 : expression tape.fetch 453 = e453 :=
  at_max tape.fetch 453 452 0 (by rfl) (by decide) p452 (by decide) p0

private def e454 : MathExpr := MathExpr.rational (ScaledGrid.rational (127881393266454005342822422862674764219894097510400000000000000000000 : Int))
private theorem p454 : expression tape.fetch 454 = e454 :=
  at_literal tape.fetch 454 0 0 (127881393266454005342822422862674764219894097510400000000000000000000 : Int) (by rfl)

private def e455 : MathExpr := MathExpr.binary .mul e454 e16
private theorem p455 : expression tape.fetch 455 = e455 :=
  at_mul tape.fetch 455 454 16 (by rfl) (by decide) p454 (by decide) p16

private def e456 : MathExpr := MathExpr.binary .mul e455 e455
private theorem p456 : expression tape.fetch 456 = e456 :=
  at_mul tape.fetch 456 455 455 (by rfl) (by decide) p455 (by decide) p455

private def e457 : MathExpr := MathExpr.binary .add e48 e456
private theorem p457 : expression tape.fetch 457 = e457 :=
  at_add tape.fetch 457 48 456 (by rfl) (by decide) p48 (by decide) p456

private def e458 : MathExpr := MathExpr.unary .sqrt e457
private theorem p458 : expression tape.fetch 458 = e458 :=
  at_sqrt tape.fetch 458 457 0 (by rfl) (by decide) p457

private def e459 : MathExpr := MathExpr.unary .inv e458
private theorem p459 : expression tape.fetch 459 = e459 :=
  at_inv tape.fetch 459 458 0 (by rfl) (by decide) p458

private def e460 : MathExpr := MathExpr.binary .mul e47 e459
private theorem p460 : expression tape.fetch 460 = e460 :=
  at_mul tape.fetch 460 47 459 (by rfl) (by decide) p47 (by decide) p459

private def e461 : MathExpr := MathExpr.unary .log e460
private theorem p461 : expression tape.fetch 461 = e461 :=
  at_log tape.fetch 461 460 0 (by rfl) (by decide) p460

private def e462 : MathExpr := MathExpr.unary .inv e461
private theorem p462 : expression tape.fetch 462 = e462 :=
  at_inv tape.fetch 462 461 0 (by rfl) (by decide) p461

private def e463 : MathExpr := MathExpr.binary .mul e453 e462
private theorem p463 : expression tape.fetch 463 = e463 :=
  at_mul tape.fetch 463 453 462 (by rfl) (by decide) p453 (by decide) p462

private def e464 : MathExpr := MathExpr.binary .add e433 e463
private theorem p464 : expression tape.fetch 464 = e464 :=
  at_add tape.fetch 464 433 463 (by rfl) (by decide) p433 (by decide) p463

private def e465 : MathExpr := MathExpr.binary .mul e249 e249
private theorem p465 : expression tape.fetch 465 = e465 :=
  at_mul tape.fetch 465 249 249 (by rfl) (by decide) p249 (by decide) p249

private def e466 : MathExpr := MathExpr.binary .mul e4 e465
private theorem p466 : expression tape.fetch 466 = e466 :=
  at_mul tape.fetch 466 4 465 (by rfl) (by decide) p4 (by decide) p465

private def e467 : MathExpr := MathExpr.binary .mul e436 e18
private theorem p467 : expression tape.fetch 467 = e467 :=
  at_mul tape.fetch 467 436 18 (by rfl) (by decide) p436 (by decide) p18

private def e468 : MathExpr := MathExpr.binary .mul e447 e467
private theorem p468 : expression tape.fetch 468 = e468 :=
  at_mul tape.fetch 468 447 467 (by rfl) (by decide) p447 (by decide) p467

private def e469 : MathExpr := MathExpr.binary .min e466 e468
private theorem p469 : expression tape.fetch 469 = e469 :=
  at_min tape.fetch 469 466 468 (by rfl) (by decide) p466 (by decide) p468

private def e470 : MathExpr := MathExpr.binary .mul e439 e28
private theorem p470 : expression tape.fetch 470 = e470 :=
  at_mul tape.fetch 470 439 28 (by rfl) (by decide) p439 (by decide) p28

private def e471 : MathExpr := MathExpr.binary .mul e4 e470
private theorem p471 : expression tape.fetch 471 = e471 :=
  at_mul tape.fetch 471 4 470 (by rfl) (by decide) p4 (by decide) p470

private def e472 : MathExpr := MathExpr.binary .mul e441 e31
private theorem p472 : expression tape.fetch 472 = e472 :=
  at_mul tape.fetch 472 441 31 (by rfl) (by decide) p441 (by decide) p31

private def e473 : MathExpr := MathExpr.binary .mul e442 e32
private theorem p473 : expression tape.fetch 473 = e473 :=
  at_mul tape.fetch 473 442 32 (by rfl) (by decide) p442 (by decide) p32

private def e474 : MathExpr := MathExpr.binary .add e472 e473
private theorem p474 : expression tape.fetch 474 = e474 :=
  at_add tape.fetch 474 472 473 (by rfl) (by decide) p472 (by decide) p473

private def e475 : MathExpr := MathExpr.binary .mul e474 e8
private theorem p475 : expression tape.fetch 475 = e475 :=
  at_mul tape.fetch 475 474 8 (by rfl) (by decide) p474 (by decide) p8

private def e476 : MathExpr := MathExpr.unary .inv e475
private theorem p476 : expression tape.fetch 476 = e476 :=
  at_inv tape.fetch 476 475 0 (by rfl) (by decide) p475

private def e477 : MathExpr := MathExpr.binary .mul e2 e476
private theorem p477 : expression tape.fetch 477 = e477 :=
  at_mul tape.fetch 477 2 476 (by rfl) (by decide) p2 (by decide) p476

private def e478 : MathExpr := MathExpr.unary .sqrt e477
private theorem p478 : expression tape.fetch 478 = e478 :=
  at_sqrt tape.fetch 478 477 0 (by rfl) (by decide) p477

private def e479 : MathExpr := MathExpr.binary .mul e232 e232
private theorem p479 : expression tape.fetch 479 = e479 :=
  at_mul tape.fetch 479 232 232 (by rfl) (by decide) p232 (by decide) p232

private def e480 : MathExpr := MathExpr.binary .mul e478 e479
private theorem p480 : expression tape.fetch 480 = e480 :=
  at_mul tape.fetch 480 478 479 (by rfl) (by decide) p478 (by decide) p479

private def e481 : MathExpr := MathExpr.binary .min e471 e480
private theorem p481 : expression tape.fetch 481 = e481 :=
  at_min tape.fetch 481 471 480 (by rfl) (by decide) p471 (by decide) p480

private def e482 : MathExpr := MathExpr.unary .neg e481
private theorem p482 : expression tape.fetch 482 = e482 :=
  at_neg tape.fetch 482 481 0 (by rfl) (by decide) p481

private def e483 : MathExpr := MathExpr.binary .add e469 e482
private theorem p483 : expression tape.fetch 483 = e483 :=
  at_add tape.fetch 483 469 482 (by rfl) (by decide) p469 (by decide) p482

private def e484 : MathExpr := MathExpr.binary .max e483 e0
private theorem p484 : expression tape.fetch 484 = e484 :=
  at_max tape.fetch 484 483 0 (by rfl) (by decide) p483 (by decide) p0

private def e485 : MathExpr := MathExpr.rational (ScaledGrid.rational (137015778499772148581595453067151533092743675904000000000000000000000 : Int))
private theorem p485 : expression tape.fetch 485 = e485 :=
  at_literal tape.fetch 485 0 0 (137015778499772148581595453067151533092743675904000000000000000000000 : Int) (by rfl)

private def e486 : MathExpr := MathExpr.binary .mul e485 e16
private theorem p486 : expression tape.fetch 486 = e486 :=
  at_mul tape.fetch 486 485 16 (by rfl) (by decide) p485 (by decide) p16

private def e487 : MathExpr := MathExpr.binary .mul e486 e486
private theorem p487 : expression tape.fetch 487 = e487 :=
  at_mul tape.fetch 487 486 486 (by rfl) (by decide) p486 (by decide) p486

private def e488 : MathExpr := MathExpr.binary .add e48 e487
private theorem p488 : expression tape.fetch 488 = e488 :=
  at_add tape.fetch 488 48 487 (by rfl) (by decide) p48 (by decide) p487

private def e489 : MathExpr := MathExpr.unary .sqrt e488
private theorem p489 : expression tape.fetch 489 = e489 :=
  at_sqrt tape.fetch 489 488 0 (by rfl) (by decide) p488

private def e490 : MathExpr := MathExpr.unary .inv e489
private theorem p490 : expression tape.fetch 490 = e490 :=
  at_inv tape.fetch 490 489 0 (by rfl) (by decide) p489

private def e491 : MathExpr := MathExpr.binary .mul e47 e490
private theorem p491 : expression tape.fetch 491 = e491 :=
  at_mul tape.fetch 491 47 490 (by rfl) (by decide) p47 (by decide) p490

private def e492 : MathExpr := MathExpr.unary .log e491
private theorem p492 : expression tape.fetch 492 = e492 :=
  at_log tape.fetch 492 491 0 (by rfl) (by decide) p491

private def e493 : MathExpr := MathExpr.unary .inv e492
private theorem p493 : expression tape.fetch 493 = e493 :=
  at_inv tape.fetch 493 492 0 (by rfl) (by decide) p492

private def e494 : MathExpr := MathExpr.binary .mul e484 e493
private theorem p494 : expression tape.fetch 494 = e494 :=
  at_mul tape.fetch 494 484 493 (by rfl) (by decide) p484 (by decide) p493

private def e495 : MathExpr := MathExpr.binary .add e464 e494
private theorem p495 : expression tape.fetch 495 = e495 :=
  at_add tape.fetch 495 464 494 (by rfl) (by decide) p464 (by decide) p494

private def e496 : MathExpr := MathExpr.binary .mul e465 e64
private theorem p496 : expression tape.fetch 496 = e496 :=
  at_mul tape.fetch 496 465 64 (by rfl) (by decide) p465 (by decide) p64

private def e497 : MathExpr := MathExpr.binary .mul e4 e496
private theorem p497 : expression tape.fetch 497 = e497 :=
  at_mul tape.fetch 497 4 496 (by rfl) (by decide) p4 (by decide) p496

private def e498 : MathExpr := MathExpr.binary .mul e251 e251
private theorem p498 : expression tape.fetch 498 = e498 :=
  at_mul tape.fetch 498 251 251 (by rfl) (by decide) p251 (by decide) p251

private def e499 : MathExpr := MathExpr.binary .mul e478 e498
private theorem p499 : expression tape.fetch 499 = e499 :=
  at_mul tape.fetch 499 478 498 (by rfl) (by decide) p478 (by decide) p498

private def e500 : MathExpr := MathExpr.binary .min e497 e499
private theorem p500 : expression tape.fetch 500 = e500 :=
  at_min tape.fetch 500 497 499 (by rfl) (by decide) p497 (by decide) p499

private def e501 : MathExpr := MathExpr.unary .neg e0
private theorem p501 : expression tape.fetch 501 = e501 :=
  at_neg tape.fetch 501 0 0 (by rfl) (by decide) p0

private def e502 : MathExpr := MathExpr.binary .add e500 e501
private theorem p502 : expression tape.fetch 502 = e502 :=
  at_add tape.fetch 502 500 501 (by rfl) (by decide) p500 (by decide) p501

private def e503 : MathExpr := MathExpr.binary .max e502 e0
private theorem p503 : expression tape.fetch 503 = e503 :=
  at_max tape.fetch 503 502 0 (by rfl) (by decide) p502 (by decide) p0

private def e504 : MathExpr := MathExpr.rational (ScaledGrid.rational (146150163733090291820368483271628301965593254297600000000000000000000 : Int))
private theorem p504 : expression tape.fetch 504 = e504 :=
  at_literal tape.fetch 504 0 0 (146150163733090291820368483271628301965593254297600000000000000000000 : Int) (by rfl)

private def e505 : MathExpr := MathExpr.binary .mul e504 e16
private theorem p505 : expression tape.fetch 505 = e505 :=
  at_mul tape.fetch 505 504 16 (by rfl) (by decide) p504 (by decide) p16

private def e506 : MathExpr := MathExpr.binary .mul e505 e505
private theorem p506 : expression tape.fetch 506 = e506 :=
  at_mul tape.fetch 506 505 505 (by rfl) (by decide) p505 (by decide) p505

private def e507 : MathExpr := MathExpr.binary .add e48 e506
private theorem p507 : expression tape.fetch 507 = e507 :=
  at_add tape.fetch 507 48 506 (by rfl) (by decide) p48 (by decide) p506

private def e508 : MathExpr := MathExpr.unary .sqrt e507
private theorem p508 : expression tape.fetch 508 = e508 :=
  at_sqrt tape.fetch 508 507 0 (by rfl) (by decide) p507

private def e509 : MathExpr := MathExpr.unary .inv e508
private theorem p509 : expression tape.fetch 509 = e509 :=
  at_inv tape.fetch 509 508 0 (by rfl) (by decide) p508

private def e510 : MathExpr := MathExpr.binary .mul e47 e509
private theorem p510 : expression tape.fetch 510 = e510 :=
  at_mul tape.fetch 510 47 509 (by rfl) (by decide) p47 (by decide) p509

private def e511 : MathExpr := MathExpr.unary .log e510
private theorem p511 : expression tape.fetch 511 = e511 :=
  at_log tape.fetch 511 510 0 (by rfl) (by decide) p510

private def e512 : MathExpr := MathExpr.unary .inv e511
private theorem p512 : expression tape.fetch 512 = e512 :=
  at_inv tape.fetch 512 511 0 (by rfl) (by decide) p511

private def e513 : MathExpr := MathExpr.binary .mul e503 e512
private theorem p513 : expression tape.fetch 513 = e513 :=
  at_mul tape.fetch 513 503 512 (by rfl) (by decide) p503 (by decide) p512

private def e514 : MathExpr := MathExpr.binary .add e495 e513
private theorem p514 : expression tape.fetch 514 = e514 :=
  at_add tape.fetch 514 495 513 (by rfl) (by decide) p495 (by decide) p513

private def e515 : MathExpr := MathExpr.rational (ScaledGrid.rational (12788139326645400534282242286267476421989409751040000000000000000000000 : Int))
private theorem p515 : expression tape.fetch 515 = e515 :=
  at_literal tape.fetch 515 0 0 (12788139326645400534282242286267476421989409751040000000000000000000000 : Int) (by rfl)

private def e516 : MathExpr := MathExpr.varRef 4
private theorem p516 : expression tape.fetch 516 = e516 :=
  at_input tape.fetch 516 0 0 4 (by rfl)

private def e517 : MathExpr := MathExpr.binary .mul e516 e516
private theorem p517 : expression tape.fetch 517 = e517 :=
  at_mul tape.fetch 517 516 516 (by rfl) (by decide) p516 (by decide) p516

private def e518 : MathExpr := MathExpr.binary .mul e517 e517
private theorem p518 : expression tape.fetch 518 = e518 :=
  at_mul tape.fetch 518 517 517 (by rfl) (by decide) p517 (by decide) p517

private def e519 : MathExpr := MathExpr.binary .mul e518 e518
private theorem p519 : expression tape.fetch 519 = e519 :=
  at_mul tape.fetch 519 518 518 (by rfl) (by decide) p518 (by decide) p518

private def e520 : MathExpr := MathExpr.binary .mul e519 e516
private theorem p520 : expression tape.fetch 520 = e520 :=
  at_mul tape.fetch 520 519 516 (by rfl) (by decide) p519 (by decide) p516

private def e521 : MathExpr := MathExpr.binary .mul e515 e520
private theorem p521 : expression tape.fetch 521 = e521 :=
  at_mul tape.fetch 521 515 520 (by rfl) (by decide) p515 (by decide) p520

private def e522 : MathExpr := MathExpr.binary .add e516 e5
private theorem p522 : expression tape.fetch 522 = e522 :=
  at_add tape.fetch 522 516 5 (by rfl) (by decide) p516 (by decide) p5

private def e523 : MathExpr := MathExpr.binary .mul e521 e522
private theorem p523 : expression tape.fetch 523 = e523 :=
  at_mul tape.fetch 523 521 522 (by rfl) (by decide) p521 (by decide) p522

private def e524 : MathExpr := MathExpr.rational (ScaledGrid.rational (200956475132999151253006664498488915202690724659200000000000000000000 : Int))
private theorem p524 : expression tape.fetch 524 = e524 :=
  at_literal tape.fetch 524 0 0 (200956475132999151253006664498488915202690724659200000000000000000000 : Int) (by rfl)

private def e525 : MathExpr := MathExpr.binary .add e0 e524
private theorem p525 : expression tape.fetch 525 = e525 :=
  at_add tape.fetch 525 0 524 (by rfl) (by decide) p0 (by decide) p524

private def e526 : MathExpr := MathExpr.binary .mul e523 e525
private theorem p526 : expression tape.fetch 526 = e526 :=
  at_mul tape.fetch 526 523 525 (by rfl) (by decide) p523 (by decide) p525

private def e527 : MathExpr := MathExpr.rational (ScaledGrid.rational (11417981541647679048466287755595961091061972992000000000000000000000 : Int))
private theorem p527 : expression tape.fetch 527 = e527 :=
  at_literal tape.fetch 527 0 0 (11417981541647679048466287755595961091061972992000000000000000000000 : Int) (by rfl)

private def e528 : MathExpr := MathExpr.binary .add e0 e361
private theorem p528 : expression tape.fetch 528 = e528 :=
  at_add tape.fetch 528 0 361 (by rfl) (by decide) p0 (by decide) p361

private def e529 : MathExpr := MathExpr.binary .mul e527 e528
private theorem p529 : expression tape.fetch 529 = e529 :=
  at_mul tape.fetch 529 527 528 (by rfl) (by decide) p527 (by decide) p528

private def e530 : MathExpr := MathExpr.binary .mul e529 e529
private theorem p530 : expression tape.fetch 530 = e530 :=
  at_mul tape.fetch 530 529 529 (by rfl) (by decide) p529 (by decide) p529

private def e531 : MathExpr := MathExpr.binary .mul e530 e530
private theorem p531 : expression tape.fetch 531 = e531 :=
  at_mul tape.fetch 531 530 530 (by rfl) (by decide) p530 (by decide) p530

private def e532 : MathExpr := MathExpr.binary .mul e531 e529
private theorem p532 : expression tape.fetch 532 = e532 :=
  at_mul tape.fetch 532 531 529 (by rfl) (by decide) p531 (by decide) p529

private def e533 : MathExpr := MathExpr.binary .mul e532 e532
private theorem p533 : expression tape.fetch 533 = e533 :=
  at_mul tape.fetch 533 532 532 (by rfl) (by decide) p532 (by decide) p532

private def e534 : MathExpr := MathExpr.binary .mul e526 e533
private theorem p534 : expression tape.fetch 534 = e534 :=
  at_mul tape.fetch 534 526 533 (by rfl) (by decide) p526 (by decide) p533

private def e535 : MathExpr := MathExpr.rational (ScaledGrid.rational (3242706757827940849764425722589252949861600329728000000000000000000 : Int))
private theorem p535 : expression tape.fetch 535 = e535 :=
  at_literal tape.fetch 535 0 0 (3242706757827940849764425722589252949861600329728000000000000000000 : Int) (by rfl)

private def e536 : MathExpr := MathExpr.unary .inv e535
private theorem p536 : expression tape.fetch 536 = e536 :=
  at_inv tape.fetch 536 535 0 (by rfl) (by decide) p535

private def e537 : MathExpr := MathExpr.binary .mul e534 e536
private theorem p537 : expression tape.fetch 537 = e537 :=
  at_mul tape.fetch 537 534 536 (by rfl) (by decide) p534 (by decide) p536

private def e538 : MathExpr := MathExpr.unary .log e537
private theorem p538 : expression tape.fetch 538 = e538 :=
  at_log tape.fetch 538 537 0 (by rfl) (by decide) p537

private def e539 : MathExpr := MathExpr.binary .mul e514 e538
private theorem p539 : expression tape.fetch 539 = e539 :=
  at_mul tape.fetch 539 514 538 (by rfl) (by decide) p514 (by decide) p538

private def e540 : MathExpr := MathExpr.binary .mul e61 e505
private theorem p540 : expression tape.fetch 540 = e540 :=
  at_mul tape.fetch 540 61 505 (by rfl) (by decide) p61 (by decide) p505

private def e541 : MathExpr := MathExpr.unary .neg e540
private theorem p541 : expression tape.fetch 541 = e541 :=
  at_neg tape.fetch 541 540 0 (by rfl) (by decide) p540

private def e542 : MathExpr := MathExpr.unary .exp e541
private theorem p542 : expression tape.fetch 542 = e542 :=
  at_exp tape.fetch 542 541 0 (by rfl) (by decide) p541

private def e543 : MathExpr := MathExpr.binary .mul e4 e542
private theorem p543 : expression tape.fetch 543 = e543 :=
  at_mul tape.fetch 543 4 542 (by rfl) (by decide) p4 (by decide) p542

private def e544 : MathExpr := MathExpr.varRef 6
private theorem p544 : expression tape.fetch 544 = e544 :=
  at_input tape.fetch 544 0 0 6 (by rfl)

private def e545 : MathExpr := MathExpr.binary .mul e544 e8
private theorem p545 : expression tape.fetch 545 = e545 :=
  at_mul tape.fetch 545 544 8 (by rfl) (by decide) p544 (by decide) p8

private def e546 : MathExpr := MathExpr.binary .mul e545 e545
private theorem p546 : expression tape.fetch 546 = e546 :=
  at_mul tape.fetch 546 545 545 (by rfl) (by decide) p545 (by decide) p545

private def e547 : MathExpr := MathExpr.binary .add e48 e546
private theorem p547 : expression tape.fetch 547 = e547 :=
  at_add tape.fetch 547 48 546 (by rfl) (by decide) p48 (by decide) p546

private def e548 : MathExpr := MathExpr.unary .sqrt e547
private theorem p548 : expression tape.fetch 548 = e548 :=
  at_sqrt tape.fetch 548 547 0 (by rfl) (by decide) p547

private def e549 : MathExpr := MathExpr.unary .inv e548
private theorem p549 : expression tape.fetch 549 = e549 :=
  at_inv tape.fetch 549 548 0 (by rfl) (by decide) p548

private def e550 : MathExpr := MathExpr.binary .mul e47 e549
private theorem p550 : expression tape.fetch 550 = e550 :=
  at_mul tape.fetch 550 47 549 (by rfl) (by decide) p47 (by decide) p549

private def e551 : MathExpr := MathExpr.unary .log e550
private theorem p551 : expression tape.fetch 551 = e551 :=
  at_log tape.fetch 551 550 0 (by rfl) (by decide) p550

private def e552 : MathExpr := MathExpr.unary .inv e551
private theorem p552 : expression tape.fetch 552 = e552 :=
  at_inv tape.fetch 552 551 0 (by rfl) (by decide) p551

private def e553 : MathExpr := MathExpr.binary .mul e543 e552
private theorem p553 : expression tape.fetch 553 = e553 :=
  at_mul tape.fetch 553 543 552 (by rfl) (by decide) p543 (by decide) p552

private def e554 : MathExpr := MathExpr.binary .mul e61 e544
private theorem p554 : expression tape.fetch 554 = e554 :=
  at_mul tape.fetch 554 61 544 (by rfl) (by decide) p61 (by decide) p544

private def e555 : MathExpr := MathExpr.unary .neg e554
private theorem p555 : expression tape.fetch 555 = e555 :=
  at_neg tape.fetch 555 554 0 (by rfl) (by decide) p554

private def e556 : MathExpr := MathExpr.unary .exp e555
private theorem p556 : expression tape.fetch 556 = e556 :=
  at_exp tape.fetch 556 555 0 (by rfl) (by decide) p555

private def e557 : MathExpr := MathExpr.unary .neg e556
private theorem p557 : expression tape.fetch 557 = e557 :=
  at_neg tape.fetch 557 556 0 (by rfl) (by decide) p556

private def e558 : MathExpr := MathExpr.binary .add e5 e557
private theorem p558 : expression tape.fetch 558 = e558 :=
  at_add tape.fetch 558 5 557 (by rfl) (by decide) p5 (by decide) p557

private def e559 : MathExpr := MathExpr.unary .inv e558
private theorem p559 : expression tape.fetch 559 = e559 :=
  at_inv tape.fetch 559 558 0 (by rfl) (by decide) p558

private def e560 : MathExpr := MathExpr.binary .mul e553 e559
private theorem p560 : expression tape.fetch 560 = e560 :=
  at_mul tape.fetch 560 553 559 (by rfl) (by decide) p553 (by decide) p559

private def e561 : MathExpr := MathExpr.binary .add e505 e545
private theorem p561 : expression tape.fetch 561 = e561 :=
  at_add tape.fetch 561 505 545 (by rfl) (by decide) p505 (by decide) p545

private def e562 : MathExpr := MathExpr.unary .inv e61
private theorem p562 : expression tape.fetch 562 = e562 :=
  at_inv tape.fetch 562 61 0 (by rfl) (by decide) p61

private def e563 : MathExpr := MathExpr.binary .mul e5 e562
private theorem p563 : expression tape.fetch 563 = e563 :=
  at_mul tape.fetch 563 5 562 (by rfl) (by decide) p5 (by decide) p562

private def e564 : MathExpr := MathExpr.binary .max e561 e563
private theorem p564 : expression tape.fetch 564 = e564 :=
  at_max tape.fetch 564 561 563 (by rfl) (by decide) p561 (by decide) p563

private def e565 : MathExpr := MathExpr.binary .add e564 e524
private theorem p565 : expression tape.fetch 565 = e565 :=
  at_add tape.fetch 565 564 524 (by rfl) (by decide) p564 (by decide) p524

private def e566 : MathExpr := MathExpr.binary .mul e523 e565
private theorem p566 : expression tape.fetch 566 = e566 :=
  at_mul tape.fetch 566 523 565 (by rfl) (by decide) p523 (by decide) p565

private def e567 : MathExpr := MathExpr.binary .add e564 e361
private theorem p567 : expression tape.fetch 567 = e567 :=
  at_add tape.fetch 567 564 361 (by rfl) (by decide) p564 (by decide) p361

private def e568 : MathExpr := MathExpr.binary .mul e527 e567
private theorem p568 : expression tape.fetch 568 = e568 :=
  at_mul tape.fetch 568 527 567 (by rfl) (by decide) p527 (by decide) p567

private def e569 : MathExpr := MathExpr.binary .mul e568 e568
private theorem p569 : expression tape.fetch 569 = e569 :=
  at_mul tape.fetch 569 568 568 (by rfl) (by decide) p568 (by decide) p568

private def e570 : MathExpr := MathExpr.binary .mul e569 e569
private theorem p570 : expression tape.fetch 570 = e570 :=
  at_mul tape.fetch 570 569 569 (by rfl) (by decide) p569 (by decide) p569

private def e571 : MathExpr := MathExpr.binary .mul e570 e568
private theorem p571 : expression tape.fetch 571 = e571 :=
  at_mul tape.fetch 571 570 568 (by rfl) (by decide) p570 (by decide) p568

private def e572 : MathExpr := MathExpr.binary .mul e571 e571
private theorem p572 : expression tape.fetch 572 = e572 :=
  at_mul tape.fetch 572 571 571 (by rfl) (by decide) p571 (by decide) p571

private def e573 : MathExpr := MathExpr.binary .mul e566 e572
private theorem p573 : expression tape.fetch 573 = e573 :=
  at_mul tape.fetch 573 566 572 (by rfl) (by decide) p566 (by decide) p572

private def e574 : MathExpr := MathExpr.binary .mul e573 e536
private theorem p574 : expression tape.fetch 574 = e574 :=
  at_mul tape.fetch 574 573 536 (by rfl) (by decide) p573 (by decide) p536

private def e575 : MathExpr := MathExpr.unary .log e574
private theorem p575 : expression tape.fetch 575 = e575 :=
  at_log tape.fetch 575 574 0 (by rfl) (by decide) p574

private def e576 : MathExpr := MathExpr.binary .mul e361 e544
private theorem p576 : expression tape.fetch 576 = e576 :=
  at_mul tape.fetch 576 361 544 (by rfl) (by decide) p361 (by decide) p544

private def e577 : MathExpr := MathExpr.unary .inv e564
private theorem p577 : expression tape.fetch 577 = e577 :=
  at_inv tape.fetch 577 564 0 (by rfl) (by decide) p564

private def e578 : MathExpr := MathExpr.binary .mul e576 e577
private theorem p578 : expression tape.fetch 578 = e578 :=
  at_mul tape.fetch 578 576 577 (by rfl) (by decide) p576 (by decide) p577

private def e579 : MathExpr := MathExpr.binary .mul e578 e556
private theorem p579 : expression tape.fetch 579 = e579 :=
  at_mul tape.fetch 579 578 556 (by rfl) (by decide) p578 (by decide) p556

private def e580 : MathExpr := MathExpr.binary .mul e579 e559
private theorem p580 : expression tape.fetch 580 = e580 :=
  at_mul tape.fetch 580 579 559 (by rfl) (by decide) p579 (by decide) p559

private def e581 : MathExpr := MathExpr.binary .add e575 e580
private theorem p581 : expression tape.fetch 581 = e581 :=
  at_add tape.fetch 581 575 580 (by rfl) (by decide) p575 (by decide) p580

private def e582 : MathExpr := MathExpr.binary .mul e560 e581
private theorem p582 : expression tape.fetch 582 = e582 :=
  at_mul tape.fetch 582 560 581 (by rfl) (by decide) p560 (by decide) p581

private def e583 : MathExpr := MathExpr.binary .add e539 e582
private theorem p583 : expression tape.fetch 583 = e583 :=
  at_add tape.fetch 583 539 582 (by rfl) (by decide) p539 (by decide) p582

private def e584 : MathExpr := MathExpr.binary .mul e2 e8
private theorem p584 : expression tape.fetch 584 = e584 :=
  at_mul tape.fetch 584 2 8 (by rfl) (by decide) p2 (by decide) p8

private def e585 : MathExpr := MathExpr.binary .add e584 e38
private theorem p585 : expression tape.fetch 585 = e585 :=
  at_add tape.fetch 585 584 38 (by rfl) (by decide) p584 (by decide) p38

private def e586 : MathExpr := MathExpr.binary .mul e585 e505
private theorem p586 : expression tape.fetch 586 = e586 :=
  at_mul tape.fetch 586 585 505 (by rfl) (by decide) p585 (by decide) p505

private def e587 : MathExpr := MathExpr.unary .neg e586
private theorem p587 : expression tape.fetch 587 = e587 :=
  at_neg tape.fetch 587 586 0 (by rfl) (by decide) p586

private def e588 : MathExpr := MathExpr.unary .exp e587
private theorem p588 : expression tape.fetch 588 = e588 :=
  at_exp tape.fetch 588 587 0 (by rfl) (by decide) p587

private def e589 : MathExpr := MathExpr.binary .mul e4 e588
private theorem p589 : expression tape.fetch 589 = e589 :=
  at_mul tape.fetch 589 4 588 (by rfl) (by decide) p4 (by decide) p588

private def e590 : MathExpr := MathExpr.binary .mul e589 e552
private theorem p590 : expression tape.fetch 590 = e590 :=
  at_mul tape.fetch 590 589 552 (by rfl) (by decide) p589 (by decide) p552

private def e591 : MathExpr := MathExpr.binary .mul e585 e544
private theorem p591 : expression tape.fetch 591 = e591 :=
  at_mul tape.fetch 591 585 544 (by rfl) (by decide) p585 (by decide) p544

private def e592 : MathExpr := MathExpr.unary .neg e591
private theorem p592 : expression tape.fetch 592 = e592 :=
  at_neg tape.fetch 592 591 0 (by rfl) (by decide) p591

private def e593 : MathExpr := MathExpr.unary .exp e592
private theorem p593 : expression tape.fetch 593 = e593 :=
  at_exp tape.fetch 593 592 0 (by rfl) (by decide) p592

private def e594 : MathExpr := MathExpr.unary .neg e593
private theorem p594 : expression tape.fetch 594 = e594 :=
  at_neg tape.fetch 594 593 0 (by rfl) (by decide) p593

private def e595 : MathExpr := MathExpr.binary .add e5 e594
private theorem p595 : expression tape.fetch 595 = e595 :=
  at_add tape.fetch 595 5 594 (by rfl) (by decide) p5 (by decide) p594

private def e596 : MathExpr := MathExpr.unary .inv e595
private theorem p596 : expression tape.fetch 596 = e596 :=
  at_inv tape.fetch 596 595 0 (by rfl) (by decide) p595

private def e597 : MathExpr := MathExpr.binary .mul e590 e596
private theorem p597 : expression tape.fetch 597 = e597 :=
  at_mul tape.fetch 597 590 596 (by rfl) (by decide) p590 (by decide) p596

private def e598 : MathExpr := MathExpr.unary .inv e585
private theorem p598 : expression tape.fetch 598 = e598 :=
  at_inv tape.fetch 598 585 0 (by rfl) (by decide) p585

private def e599 : MathExpr := MathExpr.binary .mul e5 e598
private theorem p599 : expression tape.fetch 599 = e599 :=
  at_mul tape.fetch 599 5 598 (by rfl) (by decide) p5 (by decide) p598

private def e600 : MathExpr := MathExpr.binary .max e561 e599
private theorem p600 : expression tape.fetch 600 = e600 :=
  at_max tape.fetch 600 561 599 (by rfl) (by decide) p561 (by decide) p599

private def e601 : MathExpr := MathExpr.binary .add e600 e524
private theorem p601 : expression tape.fetch 601 = e601 :=
  at_add tape.fetch 601 600 524 (by rfl) (by decide) p600 (by decide) p524

private def e602 : MathExpr := MathExpr.binary .mul e523 e601
private theorem p602 : expression tape.fetch 602 = e602 :=
  at_mul tape.fetch 602 523 601 (by rfl) (by decide) p523 (by decide) p601

private def e603 : MathExpr := MathExpr.binary .add e600 e361
private theorem p603 : expression tape.fetch 603 = e603 :=
  at_add tape.fetch 603 600 361 (by rfl) (by decide) p600 (by decide) p361

private def e604 : MathExpr := MathExpr.binary .mul e527 e603
private theorem p604 : expression tape.fetch 604 = e604 :=
  at_mul tape.fetch 604 527 603 (by rfl) (by decide) p527 (by decide) p603

private def e605 : MathExpr := MathExpr.binary .mul e604 e604
private theorem p605 : expression tape.fetch 605 = e605 :=
  at_mul tape.fetch 605 604 604 (by rfl) (by decide) p604 (by decide) p604

private def e606 : MathExpr := MathExpr.binary .mul e605 e605
private theorem p606 : expression tape.fetch 606 = e606 :=
  at_mul tape.fetch 606 605 605 (by rfl) (by decide) p605 (by decide) p605

private def e607 : MathExpr := MathExpr.binary .mul e606 e604
private theorem p607 : expression tape.fetch 607 = e607 :=
  at_mul tape.fetch 607 606 604 (by rfl) (by decide) p606 (by decide) p604

private def e608 : MathExpr := MathExpr.binary .mul e607 e607
private theorem p608 : expression tape.fetch 608 = e608 :=
  at_mul tape.fetch 608 607 607 (by rfl) (by decide) p607 (by decide) p607

private def e609 : MathExpr := MathExpr.binary .mul e602 e608
private theorem p609 : expression tape.fetch 609 = e609 :=
  at_mul tape.fetch 609 602 608 (by rfl) (by decide) p602 (by decide) p608

private def e610 : MathExpr := MathExpr.binary .mul e609 e536
private theorem p610 : expression tape.fetch 610 = e610 :=
  at_mul tape.fetch 610 609 536 (by rfl) (by decide) p609 (by decide) p536

private def e611 : MathExpr := MathExpr.unary .log e610
private theorem p611 : expression tape.fetch 611 = e611 :=
  at_log tape.fetch 611 610 0 (by rfl) (by decide) p610

private def e612 : MathExpr := MathExpr.unary .inv e600
private theorem p612 : expression tape.fetch 612 = e612 :=
  at_inv tape.fetch 612 600 0 (by rfl) (by decide) p600

private def e613 : MathExpr := MathExpr.binary .mul e576 e612
private theorem p613 : expression tape.fetch 613 = e613 :=
  at_mul tape.fetch 613 576 612 (by rfl) (by decide) p576 (by decide) p612

private def e614 : MathExpr := MathExpr.binary .mul e613 e593
private theorem p614 : expression tape.fetch 614 = e614 :=
  at_mul tape.fetch 614 613 593 (by rfl) (by decide) p613 (by decide) p593

private def e615 : MathExpr := MathExpr.binary .mul e614 e596
private theorem p615 : expression tape.fetch 615 = e615 :=
  at_mul tape.fetch 615 614 596 (by rfl) (by decide) p614 (by decide) p596

private def e616 : MathExpr := MathExpr.binary .add e611 e615
private theorem p616 : expression tape.fetch 616 = e616 :=
  at_add tape.fetch 616 611 615 (by rfl) (by decide) p611 (by decide) p615

private def e617 : MathExpr := MathExpr.binary .mul e597 e616
private theorem p617 : expression tape.fetch 617 = e617 :=
  at_mul tape.fetch 617 597 616 (by rfl) (by decide) p597 (by decide) p616

private def e618 : MathExpr := MathExpr.binary .add e583 e617
private theorem p618 : expression tape.fetch 618 = e618 :=
  at_add tape.fetch 618 583 617 (by rfl) (by decide) p583 (by decide) p617

private def e619 : MathExpr := MathExpr.binary .mul e22 e22
private theorem p619 : expression tape.fetch 619 = e619 :=
  at_mul tape.fetch 619 22 22 (by rfl) (by decide) p22 (by decide) p22

private def e620 : MathExpr := MathExpr.binary .add e5 e619
private theorem p620 : expression tape.fetch 620 = e620 :=
  at_add tape.fetch 620 5 619 (by rfl) (by decide) p5 (by decide) p619

private def e621 : MathExpr := MathExpr.unary .sqrt e620
private theorem p621 : expression tape.fetch 621 = e621 :=
  at_sqrt tape.fetch 621 620 0 (by rfl) (by decide) p620

private def e622 : MathExpr := MathExpr.unary .sqrt e621
private theorem p622 : expression tape.fetch 622 = e622 :=
  at_sqrt tape.fetch 622 621 0 (by rfl) (by decide) p621

private def e623 : MathExpr := MathExpr.unary .inv e622
private theorem p623 : expression tape.fetch 623 = e623 :=
  at_inv tape.fetch 623 622 0 (by rfl) (by decide) p622

private def e624 : MathExpr := MathExpr.binary .mul e618 e623
private theorem p624 : expression tape.fetch 624 = e624 :=
  at_mul tape.fetch 624 618 623 (by rfl) (by decide) p618 (by decide) p623

private def e625 : MathExpr := MathExpr.varRef 0
private theorem p625 : expression tape.fetch 625 = e625 :=
  at_input tape.fetch 625 0 0 0 (by rfl)

private def e626 : MathExpr := MathExpr.varRef 1
private theorem p626 : expression tape.fetch 626 = e626 :=
  at_input tape.fetch 626 0 0 1 (by rfl)

private def e627 : MathExpr := MathExpr.varRef 2
private theorem p627 : expression tape.fetch 627 = e627 :=
  at_input tape.fetch 627 0 0 2 (by rfl)

private def e628 : MathExpr := MathExpr.varRef 3
private theorem p628 : expression tape.fetch 628 = e628 :=
  at_input tape.fetch 628 0 0 3 (by rfl)

private def e629 : MathExpr := MathExpr.binary .mul e625 e625
private theorem p629 : expression tape.fetch 629 = e629 :=
  at_mul tape.fetch 629 625 625 (by rfl) (by decide) p625 (by decide) p625

private def e630 : MathExpr := MathExpr.binary .mul e629 e625
private theorem p630 : expression tape.fetch 630 = e630 :=
  at_mul tape.fetch 630 629 625 (by rfl) (by decide) p629 (by decide) p625

private def e631 : MathExpr := MathExpr.binary .mul e627 e630
private theorem p631 : expression tape.fetch 631 = e631 :=
  at_mul tape.fetch 631 627 630 (by rfl) (by decide) p627 (by decide) p630

private def e632 : MathExpr := MathExpr.unary .sqrt e516
private theorem p632 : expression tape.fetch 632 = e632 :=
  at_sqrt tape.fetch 632 516 0 (by rfl) (by decide) p516

private def e633 : MathExpr := MathExpr.binary .mul e632 e625
private theorem p633 : expression tape.fetch 633 = e633 :=
  at_mul tape.fetch 633 632 625 (by rfl) (by decide) p632 (by decide) p625

private def e634 : MathExpr := MathExpr.binary .min e631 e633
private theorem p634 : expression tape.fetch 634 = e634 :=
  at_min tape.fetch 634 631 633 (by rfl) (by decide) p631 (by decide) p633

private def e635 : MathExpr := MathExpr.binary .mul e625 e8
private theorem p635 : expression tape.fetch 635 = e635 :=
  at_mul tape.fetch 635 625 8 (by rfl) (by decide) p625 (by decide) p8

private def e636 : MathExpr := MathExpr.unary .exp e635
private theorem p636 : expression tape.fetch 636 = e636 :=
  at_exp tape.fetch 636 635 0 (by rfl) (by decide) p635

private def e637 : MathExpr := MathExpr.unary .inv e636
private theorem p637 : expression tape.fetch 637 = e637 :=
  at_inv tape.fetch 637 636 0 (by rfl) (by decide) p636

private def e638 : MathExpr := MathExpr.binary .mul e634 e637
private theorem p638 : expression tape.fetch 638 = e638 :=
  at_mul tape.fetch 638 634 637 (by rfl) (by decide) p634 (by decide) p637

private def e639 : MathExpr := MathExpr.binary .mul e627 e625
private theorem p639 : expression tape.fetch 639 = e639 :=
  at_mul tape.fetch 639 627 625 (by rfl) (by decide) p627 (by decide) p625

private def e640 : MathExpr := MathExpr.unary .sqrt e21
private theorem p640 : expression tape.fetch 640 = e640 :=
  at_sqrt tape.fetch 640 21 0 (by rfl) (by decide) p21

private def e641 : MathExpr := MathExpr.binary .mul e639 e640
private theorem p641 : expression tape.fetch 641 = e641 :=
  at_mul tape.fetch 641 639 640 (by rfl) (by decide) p639 (by decide) p640

private def e642 : MathExpr := MathExpr.unary .inv e641
private theorem p642 : expression tape.fetch 642 = e642 :=
  at_inv tape.fetch 642 641 0 (by rfl) (by decide) p641

private def e643 : MathExpr := MathExpr.binary .mul e5 e642
private theorem p643 : expression tape.fetch 643 = e643 :=
  at_mul tape.fetch 643 5 642 (by rfl) (by decide) p5 (by decide) p642

private def e644 : MathExpr := MathExpr.binary .min e638 e643
private theorem p644 : expression tape.fetch 644 = e644 :=
  at_min tape.fetch 644 638 643 (by rfl) (by decide) p638 (by decide) p643

private def e645 : MathExpr := MathExpr.rational (ScaledGrid.rational (876900982398541750922210899629769811793559525785600000000000000000 : Int))
private theorem p645 : expression tape.fetch 645 = e645 :=
  at_literal tape.fetch 645 0 0 (876900982398541750922210899629769811793559525785600000000000000000 : Int) (by rfl)

private def e646 : MathExpr := MathExpr.unary .inv e628
private theorem p646 : expression tape.fetch 646 = e646 :=
  at_inv tape.fetch 646 628 0 (by rfl) (by decide) p628

private def e647 : MathExpr := MathExpr.binary .mul e1 e646
private theorem p647 : expression tape.fetch 647 = e647 :=
  at_mul tape.fetch 647 1 646 (by rfl) (by decide) p1 (by decide) p646

private def e648 : MathExpr := MathExpr.unary .sqrt e647
private theorem p648 : expression tape.fetch 648 = e648 :=
  at_sqrt tape.fetch 648 647 0 (by rfl) (by decide) p647

private def e649 : MathExpr := MathExpr.binary .mul e626 e648
private theorem p649 : expression tape.fetch 649 = e649 :=
  at_mul tape.fetch 649 626 648 (by rfl) (by decide) p626 (by decide) p648

private def e650 : MathExpr := MathExpr.unary .inv e621
private theorem p650 : expression tape.fetch 650 = e650 :=
  at_inv tape.fetch 650 621 0 (by rfl) (by decide) p621

private def e651 : MathExpr := MathExpr.binary .mul e649 e650
private theorem p651 : expression tape.fetch 651 = e651 :=
  at_mul tape.fetch 651 649 650 (by rfl) (by decide) p649 (by decide) p650

private def e652 : MathExpr := MathExpr.binary .min e645 e651
private theorem p652 : expression tape.fetch 652 = e652 :=
  at_min tape.fetch 652 645 651 (by rfl) (by decide) p645 (by decide) p651

private def e653 : MathExpr := MathExpr.rational (ScaledGrid.rational (27403155699954429716319090613430306618548735180800000000000000000 : Int))
private theorem p653 : expression tape.fetch 653 = e653 :=
  at_literal tape.fetch 653 0 0 (27403155699954429716319090613430306618548735180800000000000000000 : Int) (by rfl)

private def e654 : MathExpr := MathExpr.binary .add e652 e653
private theorem p654 : expression tape.fetch 654 = e654 :=
  at_add tape.fetch 654 652 653 (by rfl) (by decide) p652 (by decide) p653

private def e655 : MathExpr := MathExpr.binary .mul e644 e624
private theorem p655 : expression tape.fetch 655 = e655 :=
  at_mul tape.fetch 655 644 624 (by rfl) (by decide) p644 (by decide) p624

private def e656 : MathExpr := MathExpr.binary .add e654 e655
private theorem p656 : expression tape.fetch 656 = e656 :=
  at_add tape.fetch 656 654 655 (by rfl) (by decide) p654 (by decide) p655

theorem formula : expression tape.fetch 656 = profilePriceExpr 16 false :=
  p656.trans (by decide +kernel)
#print axioms formula
end ProfileTape16positive
