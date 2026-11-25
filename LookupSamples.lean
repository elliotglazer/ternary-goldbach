module

public import ExpLookup

@[expose] public section


namespace ExpLookup

structure Sample where
  n : Nat
  lo : Nat
  hi : Nat

def Sample.check (s : Sample) : Bool :=
  decide (s.n+1<16^31 ∧ 0<s.lo ∧ s.lo≤(RadixExp.eval RadixExp.arithmeticScale rows s.n).lo ∧
    (RadixExp.eval RadixExp.arithmeticScale rows (s.n+1)).hi≤s.hi)

end ExpLookup
