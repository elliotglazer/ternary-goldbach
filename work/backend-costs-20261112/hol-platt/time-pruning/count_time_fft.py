"""Count edges kept by input/output pruning on the normalized radix-2 time FFT."""

import hashlib
import json
from collections import Counter
from functools import lru_cache
from pathlib import Path


HERE = Path(__file__).resolve().parent
SOURCE = (HERE.parents[2] / "qrh-campaign/agents/prime-estimates"
          / "sign_only_minimal_theta_nonprincipal_schedule_20261111.json")


def primitive_count(n):
    result, p = 1, 2
    while p*p <= n:
        if n % p == 0:
            power = 1
            while n % p == 0:
                n //= p
                power *= p
            result *= (p - 2 if power == p else power // (p*p) * (p-1)**2)
        p += 1
    if n > 1:
        result *= n - 2
    return result


def operation_counts(n, j, outputs):
    if not (n >= 2 and n & (n-1) == 0 and 0 <= j < n//2 and 0 < outputs <= n):
        raise ValueError("invalid radix, Fourier support or requested prefix")
    result = Counter()
    groups = 1
    while groups < n:
        size = n // groups
        half = size // 2
        active_parents = min(groups, 2*j+1)
        active_children = min(2*groups, 2*j+1)
        paired_parents = active_children - active_parents
        odd_children = min(groups, j)
        odd_only = odd_children - paired_parents
        required = min(size, outputs)
        phases = min(half, required)
        quarter = int(size >= 4 and size//4 < phases)
        result["dense_butterflies"] += groups * half
        result["dense_complex_adds"] += groups * size
        result["dense_normalized_output_slots"] += groups * size
        result["dense_general_rotations"] += groups * (half - 1 - int(size >= 4))
        result["dense_quarter_turns"] += groups * int(size >= 4)
        result["pruned_complex_adds"] += paired_parents * required
        # Charge both requested normalized results, even when an input is zero.
        # In particular, nearest rounding on a negative tie may be asymmetric.
        result["pruned_normalized_output_slots"] += active_parents * required
        result["pruned_general_rotations"] += odd_children * (phases - 1 - quarter)
        result["pruned_quarter_turns"] += odd_children * quarter
        result["single_output_active_pairs"] += paired_parents * (2*phases - required)
        result["double_output_active_pairs"] += paired_parents * (required - phases)
        result["odd_only_minus_outputs"] += odd_only * (required - phases)
        groups *= 2
    return result


def audit_small_graph(n, j, outputs):
    """Follow individual graph edges by index, independently of the stage formula."""
    phases, adds, quarter, minus = set(), set(), set(), set()

    @lru_cache(None)
    def live(depth, residue):
        modulus = 1 << depth
        return any(k % modulus == residue for k in range(-j, j+1))

    @lru_cache(None)
    def visit(depth, residue, k):
        groups = 1 << depth
        size = n // groups
        if size == 1:
            return
        half = size // 2
        lower = k % half
        even, odd = live(depth+1, residue), live(depth+1, residue+groups)
        if even:
            visit(depth+1, residue, lower)
        if odd:
            visit(depth+1, residue+groups, lower)
            key = (depth, residue, lower)
            if lower != 0:
                (quarter if 4 * lower == size else phases).add(key)
            if not even and k >= half:
                minus.add((depth, residue, k))
        if even and odd:
            adds.add((depth, residue, k))

    for k in range(outputs):
        visit(0, 0, k)
    expected = operation_counts(n, j, outputs)
    assert [len(phases), len(adds), len(quarter), len(minus)] == [
        expected[key] for key in ("pruned_general_rotations", "pruned_complex_adds",
                                   "pruned_quarter_turns", "odd_only_minus_outputs")]


def normalized_control(n, j, outputs, prune):
    """Compare complete integers, including every division/round after an empty leg."""
    scale = 16
    inputs = [(((7*k+3) % 23)-11, ((3*k+1) % 17)-8)
              if min(k, n-k) <= j else (0, 0) for k in range(n)]

    @lru_cache(None)
    def visit(groups, residue, k):
        size = n // groups
        if prune and not any(f % groups == residue for f in range(-j, j+1)):
            return (0, 0)
        if size == 1:
            return inputs[residue]
        half = size // 2
        phase = k % half
        ar, ai = visit(2*groups, residue, phase)
        br, bi = visit(2*groups, residue+groups, phase)
        if phase == 0:
            rr, ri = br, bi
        elif 4*phase == size:
            rr, ri = -bi, br
        else:
            # Arbitrary fixed-grid coefficients suffice for a dependency check.
            wr, wi = (phase*7) % scale, (phase*5) % scale - 8
            rr = (2*(wr*br-wi*bi)+scale) // (2*scale)
            ri = (2*(wr*bi+wi*br)+scale) // (2*scale)
        sign = 1 if k < half else -1
        return (ar + sign*rr + 1)//2, (ai + sign*ri + 1)//2

    count = outputs if prune else n
    return [visit(1, 0, k) for k in range(count)][:outputs]


def main():
    cases = 0
    for n in (2, 4, 8, 16, 32):
        for j in range(n//2):
            for outputs in range(1, n+1):
                audit_small_graph(n, j, outputs)
                assert normalized_control(n, j, outputs, True) == normalized_control(
                    n, j, outputs, False)
                cases += 1
    data = SOURCE.read_bytes()
    selected = json.loads(data)["scenarios"][0]["small_sign_only_conditional_candidate"]
    total = Counter()
    half_total = Counter()
    pack_rotations = 0
    for conductor, m, n, _, _ in selected["raw_metadata"]:
        # J = ceil(P*X/6), P=5N/64 and X=10.
        j = (50*n+383)//384
        row = operation_counts(n, j, m+1)
        multiplicity = primitive_count(conductor)
        for key, value in row.items():
            total[key] += value * multiplicity
        # The reviewed one-character Hermitian reduction packs U(2r), U(2r+1)
        # in output r. Its packed frequencies still occupy exactly [-j,j].
        packed = operation_counts(n//2, j, m//2 + 1)
        for key, value in packed.items():
            half_total[key] += value * multiplicity
        pack_rotations += j * multiplicity
        if conductor == 10000:
            assert multiplicity == 1600
            example = dict(points=n, j=j, outputs=m+1, per_character=dict(row))
    assert total["dense_butterflies"] == 89858217607168
    result = dict(source_sha256=hashlib.sha256(data).hexdigest(),
                  conductors=len(selected["raw_metadata"]), graph_controls=cases,
                  example=example, full_length=total, half_length_fft=half_total,
                  half_length_additional_packing_rotations=pack_rotations,
                  half_length_additional_packing_complex_adds=2 * pack_rotations)
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
