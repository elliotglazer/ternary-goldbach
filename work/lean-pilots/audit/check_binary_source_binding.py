"""Read-only binding audit for the one concrete binary pilot word.

No primality test, certificate generation, or Lean execution occurs here.
The eventual Lean export, not this metadata check, must prove primality.
"""
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
BINARY = ROOT / "work/lean-pilots/binary"
TRACE = ROOT / "work/formal-goldbach-bench/prime-cover/actual_trace.json"
PRATT = ROOT / "work/formal-goldbach-bench/native/pratt_certificates.json"
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()

checks = 0
def check(p):
    global checks
    assert p
    checks += 1

manifest = json.loads((BINARY / "pilot_manifest.json").read_text())
trace = json.loads(TRACE.read_text())
word = next(w for w in trace["words"] if w["id"] == manifest["word_id"])
check(manifest["fixture_sha256"] == sha(TRACE))
check(manifest["pratt_fixture_sha256"] == sha(PRATT))
check(manifest["word_id"] == "b0-nearest-0")
origin = 3999999997356523524
upper = 3999999997356523650
check(word["target_start"] == manifest["origin"] == origin)
check(manifest["upper"] == upper == origin + 126)
check(manifest["target_count"] == 64)
check(origin % 2 == upper % 2 == 0)
check(len(word["updates"]) == len(manifest["sources"]) == 12)
acc = 0
tiles = [0, 0]
roots = set()
for update, source in zip(word["updates"], manifest["sources"]):
    mask = int(update["source_lo_hex"], 16) + (int(update["source_hi_hex"], 16) << 64)
    shift = update["shift"]
    anchor = update["anchor"]
    base = origin - anchor - 2 * shift
    check(source["base"] == base and source["anchor"] == anchor)
    check(source["mask"] == mask and source["shift"] == shift)
    check(base > 0 and base % 2 == 1 and 0 <= shift < 64)
    positives = [base + 2 * j for j in range(128) if (mask >> j) & 1]
    check(positives == source["primes"])
    roots.update(positives)
    roots.add(anchor)
    shifted = (mask >> shift) & ((1 << 64) - 1)
    check(shifted == int(update["mask_hex"], 16))
    check(acc == int(update["acc_before_hex"], 16))
    acc |= shifted
    check(acc == int(update["acc_after_hex"], 16))
    for tile in range(2):
        tile_shift = shift + 32 * tile
        check(tile_shift + 32 <= 128)
        check(anchor + base + 2 * tile_shift == origin + 64 * tile)
        tiles[tile] |= (mask >> tile_shift) & ((1 << 32) - 1)
check(acc == int(word["expected_hex"], 16) == (1 << 64) - 1)
check(tiles == [(1 << 32) - 1] * 2)
check(sorted(roots) == manifest["prime_roots"])
check(roots.issubset(set(manifest["pratt_nodes"])))
check(list(range(origin, upper + 1, 2)) ==
      [origin + 2 * i for i in range(32)] +
      [origin + 64 + 2 * i for i in range(32)])

paths = [TRACE, PRATT, BINARY / "pilot_manifest.json",
         BINARY / "BinarySupport.lean", BINARY / "PilotPrimes.lean",
         BINARY / "BinaryPilot.lean", Path(__file__)]
receipt = {
    "scope": "Exact source-word/endpoint binding only; no primality or kernel verdict",
    "checks": checks, "word": manifest["word_id"], "origin": origin,
    "upper": upper, "targets": 64, "slices_per_tile": 12,
    "root_count": len(roots), "pratt_nodes": len(manifest["pratt_nodes"]),
    "pins": {str(p.relative_to(ROOT)).replace('\\', '/'): sha(p) for p in paths},
}
out = HERE / "binary_source_binding_receipt.json"
with out.open("x", encoding="utf-8") as f:
    json.dump(receipt, f, indent=2)
    f.write("\n")
print(json.dumps({"checks": checks, "receipt": str(out), "sha256": sha(out)}))
