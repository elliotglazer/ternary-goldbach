"""Bind the Linux team's wide fixtures to the generic packed Lean checker.

Write separate source-expansion and per-shard modules so repeated shards
consume the same certified expansion. Run with width 8192 or 262144.
"""
import hashlib
import json
from pathlib import Path
import sys

here = Path(__file__).resolve().parent
width = int(sys.argv[1])
base = here.parent / f"aws-pilot/wide/w{width}"
d = json.loads((base/"workload.json").read_text())
blob = (base/"source.bin").read_bytes()
bits = int.from_bytes(blob, "little")
depth = (d["slots"]-1).bit_length()
assert bits < 1<<d["slots"]
max_roots = max(len(row["shifts"]) for row in d["blocks"])
# A single radix for every block in the fixture.
b = (max_roots-1).bit_length()
k = b+1
cached = "--cached" in sys.argv[2:]
out = here/(f"wide{width}" + ("-cache" if cached else ""))
out.mkdir(exist_ok=True)
# Lay out each positive bit as a base-2^k digit. The exported hex is checked.
expanded_bytes = bytearray((k*d["slots"]+7)//8)
for i in range(d["slots"]):
    if blob[i//8] >> (i%8) & 1:
        j=k*i
        expanded_bytes[j//8] |= 1 << (j%8)
expanded = int.from_bytes(expanded_bytes,"little")
prefix = "namespace PackedWide\nopen Goldbach.Packed\nset_option maxRecDepth 65536\n"
sourcefile = f"""import Expand
{prefix}
def source : Nat := {hex(bits)}
def expansion : Nat := {hex(expanded)}
theorem bound : source < 2^(2^{depth}) := by decide +kernel
theorem certified : expand {k} {depth} source = expansion := by decide +kernel
end PackedWide
"""
def operand(name, n):
    p=out/(name+".bin")
    p.write_bytes(n.to_bytes(max(1,(n.bit_length()+7)//8),"little"))
    return f'fixtureNat% "{p.name}"'
if cached:
    sourcefile="import FixtureNat\n"+sourcefile.replace(hex(bits),operand("bitmap",bits)).replace(
        hex(expanded),operand("expanded",expanded))
    pos=sourcefile.index("theorem bound")
    (out/"PackedWideInputs.lean").write_text(sourcefile[:pos]+"end PackedWide\n",encoding="utf-8")
    sourcefile="import PackedWideInputs\n"+prefix+sourcefile[pos:]
(out/"PackedWideSource.lean").write_text(sourcefile,encoding="utf-8")
for i, row in enumerate(d["blocks"]):
    s = max(row["shifts"])
    offsets = [s-j for j in row["shifts"]]
    shifts = str(offsets)
    origin = row["origin"]
    first = d["first"]
    arith=f"""import PackedWideSource
import PackedWindow
{prefix}
namespace Block{i}
def offsets : List Nat := {shifts}
def high : Nat := (2^{k})^{s} * (((2^{k})^{width} * (2^{b}) - (2^{b})) / (2^{k}-1))
def pad : Nat := (2^{k})^{s} * (((2^{k})^{width} * (2^{b}-1) - (2^{b}-1)) / (2^{k}-1))
theorem check : (expansion * anchorPolynomial {k} offsets + pad) &&& high = high := by decide +kernel
end Block{i}
end PackedWide
"""
    if cached:
        arith=arith.replace("import PackedWideSource","import PackedWideInputs")
        A=sum(1<<(k*t) for t in offsets)
        rep=((1<<(k*width))-1)//((1<<k)-1) << (k*s)
        h=rep*(1<<b)
        pad=rep*((1<<b)-1)
        arith=arith.replace("theorem check :",f"""def an : Nat := {operand(f"anchors{i}",A)}
def hi : Nat := {operand(f"mask{i}",h)}
def pd : Nat := {operand(f"padding{i}",pad)}
theorem aeq : anchorPolynomial {k} offsets = an := by decide +kernel
theorem heq : high = hi := by decide +kernel
theorem peq : pad = pd := by decide +kernel
theorem cachedCheck : ((expansion * an + pd) &&& hi) = hi := by rfl
theorem check :""").replace("high = high := by decide +kernel","high = high := by rw [aeq, heq, peq]; exact cachedCheck")
    (out/f"PackedArithmetic{i}.lean").write_text(arith,encoding="utf-8")
    (out/f"PackedWideShard{i}.lean").write_text(f"""import PackedArithmetic{i}
import PackedWideSource
import FastGoldbach
import Anchors
import Shared
{prefix}
set_option exponentiation.threshold 4194304
namespace Block{i}
theorem verified : ∀ n : Nat, {origin} ≤ n → n < {origin+2*width} → n%2=0 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  apply binary_interval_of_expansion source expansion {b} {depth} {s} {width} {origin} {first} offsets
  · exact bound
  · exact UpperShared.source_sound
  · exact certified
  · decide
  · have ha : ∀ t ∈ offsets, BatchPrime.contains ({origin}-({first}+2*({s}-t))) UpperAnchors.cert = true ∧
        {first}+2*({s}-t) ≤ {origin} := by decide +kernel
    intro t ht
    obtain ⟨hm, hl⟩ := ha t ht
    exact ⟨BatchPrime.contains_prime UpperAnchors.valid hm, hl⟩
  · decide
  · decide
  · decide
  · exact check
end Block{i}
end PackedWide
#print axioms PackedWide.Block{i}.verified
""", encoding="utf-8")
start=d["blocks"][0]["origin"]
mid=d["blocks"][1]["origin"]
assert mid==start+2*width
(out/"PackedWideTogether.lean").write_text(f"""import PackedWideShard0
import PackedWideShard1
namespace PackedWide
theorem verified : ∀ n : Nat, {start} ≤ n → n < {mid+2*width} → n%2=0 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n hl hr he
  by_cases hm : n < {mid}
  · exact Block0.verified n hl hm he
  · exact Block1.verified n (by omega) hr he
end PackedWide
#print axioms PackedWide.verified
""",encoding="utf-8")
(out/"PackedAssemblyReplay.lean").write_text(f"""import PackedWideTogether
import FiniteReplay
set_option maxRecDepth 65536
#replay_cover "assembly0" "PackedWide.Block0.verified" {width} 20 PackedWide.Block0.verified
#replay_cover "assembly1" "PackedWide.Block1.verified" {width} 20 PackedWide.Block1.verified
#replay_cover "join" "PackedWide.verified" {2*width} 50 PackedWide.verified
""",encoding="utf-8")
(out/"PackedReplay.lean").write_text(f"""import PackedArithmetic0
import PackedArithmetic1
import FiniteReplay
set_option maxRecDepth 65536
#print PackedWide.Block0.check
#print PackedWide.Block1.check
#replay_cover "packed0" "PackedWide.Block0.check" {width} 30 PackedWide.Block0.check
#replay_cover "packed1" "PackedWide.Block1.check" {width} 30 PackedWide.Block1.check
""",encoding="utf-8")
if cached:
    rp=out/"PackedReplay.lean"
    rp.write_text(rp.read_text().replace("Block0.check","Block0.cachedCheck").replace("Block1.check","Block1.cachedCheck"),
                  encoding="utf-8")
print(dict(source_sha256=hashlib.sha256(blob).hexdigest(), width=width, radix=2**k,
           source_bits=bits.bit_length(), expanded_bits=expanded.bit_length()))
