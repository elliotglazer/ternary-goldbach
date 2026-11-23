import Lean

theorem three_real (a b c d : Int) :
    c * (a+b) - b * (c+d) = a*c-b*d := by
  rw [Int.mul_add, Int.mul_add, Int.mul_comm c a, Int.mul_comm c b]
  omega

theorem three_imag (a b c d : Int) :
    c * (a+b) + a * (d-c) = a*d+b*c := by
  rw [Int.mul_add, Int.mul_sub, Int.mul_comm c a, Int.mul_comm c b]
  omega

theorem round_interval (n q r s h : Int) (hs : s = 2*h)
    (hw : n+h=q*s+r) (hr0 : 0 <= r) (hr1 : r < s) :
    -s <= 2*(n-q*s) ∧ 2*(n-q*s) < s := by
  omega

example : (123456789123456789123456789 : Int) * (-234567891234567891234567891) =
  -28958998654229529954275262992531624791126352 := by decide
