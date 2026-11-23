"""Integer sizes only; no prime tests, searches or certificate evaluation."""
from pathlib import Path
from math import factorial
import hashlib
import json

ROOT=Path(__file__).resolve().parents[4]
B,D=6*10**17,2**19
assert B<2**60 and factorial(20)>B
rows=[]
for L,expected in [(2**32,27),(2**34,25),(2**36,23)]:
    U=2*(L+D)-1
    assert U*U>=B
    depth=0
    while U*2**depth<B:
        depth+=1
    assert depth==expected
    rows.append({"L":L,"source_max":U,"source_bits":U.bit_length(),
                 "large_chain_nodes_upper":depth})
assert rows[0]["source_max"]==8590983167
assert rows[0]["source_bits"]==34
assert 2*33+1==67 and 59+59+29+1==148
paths=[ROOT/"work/mm0-efficient/primality.md",
       ROOT/"work/formal-goldbach-bench/prime-cert/REPORT.md",
       ROOT/"work/formal-goldbach-bench/prime-cert/PrimeSupport.lean",
       ROOT/"work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean"]
mathlib=Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib")
paths += [mathlib/"NumberTheory/Fermat.lean",mathlib/"GroupTheory/OrderOfElement.lean"]
out={"scope":"Integer size bounds and read-source hashes only; no prime evaluation.",
     "B":B,"rows":rows,"component_power_upper":118,"factor_count_upper":18,
     "powers_plus_unit_products_upper":136,
     "pins":[{"path":str(p),"sha256":hashlib.sha256(p.read_bytes()).hexdigest().upper()} for p in paths]}
Path(__file__).with_suffix(".json").write_text(json.dumps(out,indent=2)+"\n",encoding="utf-8")
print("PASS: integer source/cache-chain size bounds only")
