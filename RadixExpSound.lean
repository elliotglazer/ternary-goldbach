module

public import RadixExpData
public import PreciseExp

@[expose] public section


open Real GoldbachEnergy
namespace RadixExp

def Interval.Holds (b : Interval) (S : Nat) (x : ℝ) : Prop := (b.lo:ℝ) ≤ x*S ∧ x*S ≤ b.hi

theorem unit_holds (S : Nat) : (unit S).Holds S 1 := by simp [unit,Interval.Holds]

theorem mul_holds {S : Nat} (hS : 0<S) {a b : Interval} {x y : ℝ}
    (hx : a.Holds S x) (hy : b.Holds S y) : (mul S a b).Holds S (x*y) := by
  have h : (0:ℝ)<S := by exact_mod_cast hS
  have xl := hx.1
  have yl := hy.1
  have xu := hx.2
  have yu := hy.2
  have y0 : 0 ≤ y*S := (Nat.cast_nonneg b.lo).trans yl
  have lower := mul_le_mul xl yl (Nat.cast_nonneg _) ((Nat.cast_nonneg _).trans xl)
  have upper := mul_le_mul xu yu y0 (Nat.cast_nonneg _)
  have roundLo : ((mul S a b).lo:ℝ)*S ≤ a.lo*b.lo := by
    exact_mod_cast Nat.div_mul_le_self (a.lo*b.lo) S
  have roundHi : (a.hi:ℝ)*b.hi ≤ ((mul S a b).hi:ℝ)*S := by
    have ht := (Nat.lt_mul_div_succ (a.hi*b.hi) hS).le
    rw [Nat.mul_comm S] at ht
    exact_mod_cast ht
  constructor
  · apply le_of_mul_le_mul_right _ h
    nlinarith only [roundLo,lower]
  · apply le_of_mul_le_mul_right _ h
    nlinarith only [roundHi,upper]

theorem digit_holds {S : Nat} (hS : 0<S) {b : Interval} {x : ℝ} (hb : b.Holds S (Real.exp x)) (d : Nat) :
    (digit S b d).Holds S (Real.exp (d*x)) := by
  induction d with
  | zero => simpa [digit] using unit_holds S
  | succ d ih =>
    rw [Nat.cast_succ,add_mul,one_mul,Real.exp_add]
    exact mul_holds hS ih hb

theorem row_at {S d : Nat} (s : Interval) (hd : d<17) :
    (oneRow S s).digits[d]! = digit S s d := by simp [oneRow,getElem!_pos,hd]

theorem eval_holds {S : Nat} (hS : 0<S) (rows : Nat) (b : Interval) (x : ℝ)
    (hb : b.Holds S (Real.exp x)) (n : Nat) (cut : n<16^rows) :
    (eval S (table S rows b) n).Holds S (Real.exp (n*x)) := by
  induction rows generalizing b x n with
  | zero =>
    have : n=0 := by simpa using cut
    subst n; simpa [table,eval] using unit_holds S
  | succ k ih =>
    by_cases z : n=0
    · subst n; simpa [table,eval] using unit_holds S
    have hcut : n/16<16^k := (Nat.div_lt_iff_lt_mul (by decide)).mpr (by simpa [pow_succ] using cut)
    have h16 := digit_holds hS hb 16
    have hnext : ((oneRow S b).digits[16]!).Holds S (Real.exp (16*x)) := by
      simpa [row_at b (by decide : 16<17)] using h16
    have high := ih _ (16*x) hnext (n/16) hcut
    have hd : n%16<17 := by omega
    have low := digit_holds hS hb (n%16)
    have v := mul_holds hS low high
    have e : (n%16:Nat)+(n/16)*16=n := by omega
    have e' : ((n%16:Nat):ℝ)+((n/16:Nat):ℝ)*16=n := by exact_mod_cast e
    simp only [table,eval,if_neg z,row_at b hd]
    rwa [← Real.exp_add,show ((n%16:Nat):ℝ)*x+((n/16:Nat):ℝ)*(16*x)=(n:ℝ)*x by
      linear_combination x*e'] at v

#print axioms eval_holds
end RadixExp
