"""Construct and verify a Goldbach bitmap with recursive Lucas certificates.

Run 'python pilot.py' to regenerate the last 1,024 even targets up to 10^16.
Run 'python pilot.py --verify' to check only the saved JSON, using the Python
standard library. It emits a Lean consumer for the existing BatchPrime API.
"""
import argparse
import hashlib
import json
import math
from pathlib import Path
from time import process_time


HERE = Path(__file__).resolve().parent
LIMIT = 10**16
WIDTH = 1024


def candidate(n):
    """A deterministic filter for this generator. Lucas checks decide acceptance."""
    if n < 2:
        return False
    bases = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37]
    for a in bases:
        if n % a == 0:
            return n == a
    d = n - 1
    s = 0
    while d % 2 == 0:
        d //= 2
        s += 1
    for a in bases:
        x = pow(a, d, n)
        if x in (1, n - 1):
            continue
        for _ in range(s - 1):
            x = x*x % n
            if x == n - 1:
                break
        else:
            return False
    return True


def factors(n):
    if n == 1:
        return []
    if candidate(n):
        return [n]
    if n % 2 == 0:
        return [2] + factors(n // 2)
    # Pollard rho with deterministic restarts. Only used on candidates' p-1.
    for c in range(1, 100):
        x = y = 2
        for _ in range(100000):
            x = (x*x + c) % n
            y = (y*y + c) % n
            y = (y*y + c) % n
            d = math.gcd(x-y, n)
            if d == n:
                break
            if d > 1:
                return factors(d) + factors(n // d)
    raise ValueError(f"Factor search exhausted for {n}")


def lucas_nodes(roots):
    nodes = {2: (0, [])}

    def visit(p):
        if p in nodes:
            return
        fs = sorted(factors(p - 1))
        for q in set(fs):
            visit(q)
        for a in range(2, min(p, 10000)):
            if pow(a, p-1, p) == 1 and all(pow(a, (p-1)//q, p) != 1 for q in set(fs)):
                nodes[p] = (a, fs)
                return
        raise ValueError(f"No Lucas base for {p}")

    for root in sorted(roots):
        visit(root)
    return [[p, *nodes[p]] for p in sorted(nodes)]


def build():
    first = 3
    origin = LIMIT - 2*(WIDTH-1)
    anchors = []
    shifts = []
    mask = (1 << WIDTH) - 1
    filled = 0
    bits = 0
    slots = 0
    for q in range(origin-first, origin-first-20000, -2):
        if not candidate(q):
            continue
        shift = (origin-first-q)//2
        for j in range(slots, shift+WIDTH):
            if candidate(first+2*j):
                bits |= 1 << j
        slots = shift + WIDTH
        gain = (bits >> shift) & mask & ~filled
        if gain:
            shifts.append(shift)
            anchors.append(q)
            filled |= gain
        if filled == mask:
            break
    if filled != mask:
        raise ValueError("Anchor search exhausted")
    roots = set(anchors) | {first+2*j for j in range(slots) if bits >> j & 1}
    return dict(target_origin=origin, width=WIDTH, source_first_odd=first,
                source_bit_length=slots, source_hex=hex(bits), shifts=shifts,
                anchors=anchors, nodes=lucas_nodes(roots))


def verify(data):
    def require(flag, why):
        if not flag:
            raise ValueError(why)

    proven = set()
    for p, a, fs in data["nodes"]:
        require(p not in proven and p >= 2, "duplicate or invalid node")
        if p != 2:
            require(all(q < p and q in proven for q in fs), "unproved factor")
            require(math.prod(fs) == p-1, "incomplete factorization")
            require(pow(a, p-1, p) == 1, "incorrect Lucas base")
            require(all(pow(a, (p-1)//q, p) != 1 for q in set(fs)), "insufficient order")
        proven.add(p)
    origin = data["target_origin"]
    first = data["source_first_odd"]
    width = data["width"]
    slots = data["source_bit_length"]
    bits = int(data["source_hex"], 16)
    require(width == WIDTH and origin == LIMIT-2*(WIDTH-1), "wrong interval")
    require(0 <= bits < 2**slots, "wrong bitmap length")
    require(all(first+2*j in proven for j in range(slots) if bits >> j & 1), "unproved source")
    union = 0
    for shift, q in zip(data["shifts"], data["anchors"], strict=True):
        require(q in proven and shift >= 0 and q+first+2*shift == origin, "wrong anchor")
        union |= bits >> shift
    require((union & ((1 << width)-1)) == (1 << width)-1, "uncovered target")
    pairs = []
    for j in range(width):
        shift = next(k for k in data["shifts"] if bits >> (j+k) & 1)
        p, q = first+2*(j+shift), origin-first-2*shift
        require(p in proven and q in proven and p+q == origin+2*j, "bad summands")
        pairs.append((p, q))
    return pairs


def emit_lean(data, pairs):
    lines = ["import BatchPrime", "namespace UpperBinaryPilot", "open BatchPrime"]

    def tree(nodes):
        if not nodes:
            return "BatchPrime.Tree.empty"
        mid = len(nodes)//2
        p, a, fs = nodes[mid]
        left, right = tree(nodes[:mid]), tree(nodes[mid+1:])
        value = f"(BatchPrime.Tree.node {left} {p} {a} {fs} {right})"
        if len(nodes) >= 31:
            lines.append(f"def sub_{p} : BatchPrime.Tree := {value}")
            return f"sub_{p}"
        return value

    root = tree(data["nodes"])
    lines.append(f"def certificate : BatchPrime.Tree := {root}")
    chunks = []
    for i in range(0, len(pairs), 32):
        name = f"pairs{i}"
        chunks.append(name)
        lines.append(f"def {name} : List (Nat × Nat) := [" +
                     ", ".join(f"({p}, {q})" for p, q in pairs[i:i+32])+"]")
    lines.append("def witnesses : List (Nat × Nat) := " + " ++ ".join(chunks))
    origin, width = data["target_origin"], data["width"]
    lines.extend([
        "set_option maxRecDepth 65536",
        "set_option maxHeartbeats 0",
        "theorem valid : treeValid certificate certificate = true := by decide +kernel",
        f"theorem covered : checkedCover {origin} certificate witnesses = true := by decide +kernel",
        f"theorem width_eq : witnesses.length = {width} := by decide +kernel",
        f"theorem binary_interval : ∀ n : Nat, {origin} ≤ n → n < {LIMIT+2} → n % 2 = 0 →",
        "    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n := by",
        f"  apply PrimeCoverage.binaryGoldbach_interval {origin} {width} (by decide)",
        "  intro j hj",
        f"  exact checkedCover_sound valid witnesses {origin} covered j (width_eq.symm ▸ hj)",
        "end UpperBinaryPilot",
    ])
    (HERE/"UpperBinaryPilot.lean").write_text("\n".join(lines)+"\n", encoding="utf-8")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--verify", action="store_true")
    args = parser.parse_args()
    path = HERE/"upper-fixture.json"
    start = process_time()
    if not args.verify:
        data = build()
        path.write_text(json.dumps(data, separators=(",", ":"))+"\n", encoding="utf-8")
    produced = process_time() - start
    start = process_time()
    data = json.loads(path.read_text(encoding="utf-8"))
    pairs = verify(data)
    checked = process_time() - start
    row = dict(targets=len(pairs), low=data["target_origin"], high=LIMIT,
               anchors=len(data["anchors"]), marked_source_slots=int(data["source_hex"],16).bit_count(),
               lucas_nodes=len(data["nodes"]), first_pair=pairs[0], last_pair=pairs[-1],
               fixture_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
               generation_cpu_seconds=produced, native_verification_cpu_seconds=checked)
    if not args.verify:
        emit_lean(data, pairs)
        (HERE/"receipt.json").write_text(json.dumps(row, indent=2)+"\n", encoding="utf-8")
    print(json.dumps(row))
