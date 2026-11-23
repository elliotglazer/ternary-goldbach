"""Bind the actual wide data and leave only the explicit primality inputs open."""
from pathlib import Path
import json
import sys

here=Path(__file__).resolve().parent
w=int(sys.argv[1])
data=json.loads((here.parent/f"aws-pilot/wide/w{w}/workload.json").read_text())
first=data["first"]
depth=(data["slots"]-1).bit_length()
b=(max(len(r["shifts"]) for r in data["blocks"])-1).bit_length()
body="""import PackedArithmetic0
import PackedArithmetic1
import PackedWideSource
import FastGoldbach
import PrimeBitmap
namespace PackedWide
open Goldbach.Packed PrimeCoverage
set_option maxRecDepth 65536
set_option exponentiation.threshold 4194304
"""
for i,row in enumerate(data["blocks"]):
    origin=row["origin"]
    s=max(row["shifts"])
    body+=f"""
theorem Block{i}.of_prime_inputs (hsrc : PrimeBitmap {first} source)
    (ha : ∀ t ∈ Block{i}.offsets, ({origin}-({first}+2*({s}-t))).Prime) :
    ∀ n : Nat, {origin} ≤ n → n < {origin+2*w} → n%2=0 →
      ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  have hl : ∀ t ∈ Block{i}.offsets, {first}+2*({s}-t) ≤ {origin} := by decide +kernel
  have hcheck : (expansion * anchorPolynomial {b+1} Block{i}.offsets +
      windowValue {b+1} {s} {w} (2^{b}-1)) &&& windowValue {b+1} {s} {w} (2^{b}) =
        windowValue {b+1} {s} {w} (2^{b}) := by
    decide +kernel
  exact binary_interval_of_expansion source expansion {b} {depth} {s} {w} {origin} {first} Block{i}.offsets
    bound hsrc certified (by decide) (fun t ht => ⟨ha t ht, hl t ht⟩)
    (by decide) (by decide) (by decide) hcheck
#print axioms Block{i}.of_prime_inputs
"""
    (here/f"wide{w}-cache"/f"PackedWideShard{i}.lean").write_text(f"""import PendingPrimes
import Shared
import Anchors
namespace PackedWide
set_option maxRecDepth 65536
set_option exponentiation.threshold 4194304
theorem Block{i}.verified : ∀ n : Nat, {origin} ≤ n → n < {origin+2*w} → n%2=0 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  apply Block{i}.of_prime_inputs UpperShared.source_sound
  have hm : ∀ t ∈ Block{i}.offsets, BatchPrime.contains ({origin}-({first}+2*({s}-t))) UpperAnchors.cert = true := by
    decide +kernel
  exact fun t ht => BatchPrime.contains_prime UpperAnchors.valid (hm t ht)
end PackedWide
#print axioms PackedWide.Block{i}.verified
""",encoding="utf-8")
(here/f"wide{w}-cache"/"PendingPrimes.lean").write_text(body+"end PackedWide\n",encoding="utf-8")
