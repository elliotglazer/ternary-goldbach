module

public import PrefixCheck

@[expose] public section

namespace SmallGoldbach
open WideGoldbach PrimeCoverage

/-- One small-prime table segment. Its offset is measured from the odd number three. -/
structure Segment where
  start : Nat
  cutoff : Nat
  count : Nat
  code : Nat

def segmentBits (s : Segment) := marks (unpack s.count s.code)

def segmentOK (s : Segment) : Bool :=
  let ps := entries (3+2*s.start) (unpack s.count s.code)
  ps.all (fun p => decide (1 < p ∧ p < (s.cutoff+1)^2)) &&
    decide (Nat.Coprime ps.prod s.cutoff.factorial)

def sourceBits : List Segment → Nat
  | [] => 0
  | s::ss => (segmentBits s <<< s.start) ||| sourceBits ss

theorem source_sound (ss : List Segment) (hc : ss.all segmentOK = true) :
    PrimeBitmap 3 (sourceBits ss) := by
  induction ss with
  | nil => exact PrimeBitmap.zero _
  | cons s rest ih =>
    obtain ⟨h, hr⟩ := splitAnd hc
    obtain ⟨hb, hp⟩ := splitAnd h
    exact PrimeBitmap.union (shift_chunk 3 s.start _ (table_chunk _ s.cutoff _ hb (of_decide_eq_true hp))) (ih hr)

end SmallGoldbach
