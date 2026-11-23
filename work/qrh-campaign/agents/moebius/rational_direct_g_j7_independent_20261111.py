"""PREPARATION ONLY: independent rational direct-g j7 acceptance checker.

No work is performed on import. Execution requires a separately authorized
supervised attempt. No producer module or numerical special-function package
is imported. See the companion preparation note for the remaining run gate.
"""
from __future__ import annotations

import argparse
import ctypes
import hashlib
import json
import math
import os
import re
import sys
import time
from fractions import Fraction as F
from pathlib import Path

LIMIT = 65536
TARGET_SHA = "2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E"
SPEC_SHA = "8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2"
ZERO = (F(0), F(0))
ONE = (F(1), F(0))
CENTER = (F(629, 1250), F(31985, 16))
OPS = 0
START = None
PROGRESS = {"stage": "startup", "replayed_leaves": 0, "independent_leaves": 0}
REPLAY_TALLY = None
PARTIAL_EVIDENCE = []
HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
PINS = {
    "major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md": SPEC_SHA,
    "zero-sum/REVIEW_RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md":
    "0ED13860F941BE3786D9EE780F71590581D2C658BF30B84A8CE79AF383ABE4ED",
    "major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md":
    "60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9",
    "zero-sum/REVIEW_FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md":
    "E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B",
    "major-constants/FINITE_EM_RATIONAL_ELEMENTARY_BUDGET_2026-11-11.md":
    "50D1FFB0385A0F2FCE3BA9EF3BBB4FFD3BAC5A0103E95A8329E79A25D524A541",
    "major-constants/EM_SMALL_BATCH_FULL_BUDGET_2026-11-11.md":
    "47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23",
    "integration/FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md":
    "F6B784776E24F767FA3A45C3006394F0E718FF491712077FC9EBDC74EDE92F22",
    "audit/REVIEW_FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md":
    "C62EEA09A4C1871E15FAB18EB3A3525777022E106F1AB39318F674D0272B448F",
    "independent-feasibility/FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md":
    "19DB61735647D0267954692733C2CF045B977D540A4CF55B5DBDB1145EE82CB8",
    "zero-sum/REVIEW_FINITE_EM_RATIONAL_PROOF_COST_DESIGN_2026-11-11.md":
    "022C335200DCD43E6E9639E978F122F5619199B3EBCC2B98F7B997C1328C8D8E",
    "moebius/SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md":
    "EFDC61B6EA7E137A917983AAA496413FBC76D2E59B506D5818A31C2E224C3F4B",
    "prime-estimates/REVIEW_SIGNED_DYADIC_ROUNDING_WITNESS_PLAN_2026-11-11.md":
    "F0D115608E1742220E4CAB26EA8DA930D24F2D1D410ED34609EA7B7DC4DABDA5",
}


class Reject(Exception):
    pass


def require(ok, message):
    if not ok:
        raise Reject(message)


def tick():
    global OPS
    OPS += 1
    if START is not None and OPS % 1024 == 0:
        require(time.monotonic() - START < 900, "900-second attempt cap")
        require(peak_memory() <= 512 * 1024**2, "512-MiB memory cap")


def integer(n):
    require(type(n) is int and abs(n).bit_length() <= LIMIT, "integer bound/type")
    return n


def rational(n, d=1):
    tick()
    integer(n)
    integer(d)
    require(d != 0, "zero divisor")
    r = F(n, d)
    integer(r.numerator)
    integer(r.denominator)
    return r


def add(a, b):
    a, b = F(a), F(b)
    # Charge every raw integer, before Fraction is allowed to cancel it.
    u = integer(a.numerator * b.denominator)
    v = integer(b.numerator * a.denominator)
    return rational(integer(u + v), integer(a.denominator * b.denominator))


def mul(a, b):
    a, b = F(a), F(b)
    return rational(integer(a.numerator * b.numerator),
                    integer(a.denominator * b.denominator))


def div(a, b):
    a, b = F(a), F(b)
    require(b != 0, "zero rational divisor")
    return rational(integer(a.numerator * b.denominator),
                    integer(a.denominator * b.numerator))


def power(a, n):
    require(type(n) is int and 0 <= n <= LIMIT, "power index")
    r = F(1)
    for _ in range(n):
        r = mul(r, a)
    return r


def zadd(a, b):
    return add(a[0], b[0]), add(a[1], b[1])


def zneg(a):
    return -a[0], -a[1]


def zmul(a, b):
    return add(mul(a[0], b[0]), -mul(a[1], b[1])), add(mul(a[0], b[1]), mul(a[1], b[0]))


def zscale(a, b):
    return mul(a[0], b), mul(a[1], b)


def distance(a, b):
    return add(abs(add(a[0], -b[0])), abs(add(a[1], -b[1])))


def signed_witness(p, q, g, m):
    require(type(g) is int and 0 <= g < LIMIT, "grid exponent")
    require(q > 0, "positive rounding denominator")
    S = integer(1 << g)
    middle = integer(integer(2 * p) * S)
    left = integer(integer(2 * m - 1) * q)
    right = integer(integer(2 * m + 1) * q)
    require(left <= middle < right, "invalid signed nearest rounding witness")


def nearest(x, g):
    p, q = x.numerator, x.denominator
    S = integer(1 << g)
    m = integer(integer(integer(2 * p * S) + q) // integer(2 * q))
    signed_witness(p, q, g, m)
    return rational(m, S), m


def encode_q(x):
    return {"numerator": str(x.numerator), "denominator": str(x.denominator)}


def encode_d(x):
    d = x.denominator
    require(d & (d - 1) == 0, "non-dyadic output")
    a, e = x.numerator, -(d.bit_length() - 1)
    if a == 0:
        return {"mantissa": "0", "exponent": 0}
    while a % 2 == 0:
        a //= 2
        e += 1
    return {"mantissa": str(a), "exponent": e}


def encode_z(z):
    return {"re": encode_d(z[0]), "im": encode_d(z[1])}


def parse_int(x):
    require(isinstance(x, str) and len(x) <= 20000 and
            re.fullmatch(r"0|-?[1-9][0-9]*", x) is not None, "canonical integer string")
    return integer(int(x))


def parse_q(x):
    require(type(x) is dict and set(x) == {"numerator", "denominator"}, "rational shape")
    n, d = parse_int(x["numerator"]), parse_int(x["denominator"])
    require(d > 0 and math.gcd(n, d) == 1, "positive reduced rational")
    return rational(n, d)


def parse_d(x, canonical=True):
    require(type(x) is dict and set(x) == {"mantissa", "exponent"}, "dyadic shape")
    m, e = parse_int(x["mantissa"]), x["exponent"]
    require(type(e) is int and abs(e) < LIMIT, "dyadic exponent")
    if canonical:
        require((m == 0 and e == 0) or (m != 0 and m % 2 != 0), "canonical dyadic")
    require(abs(m).bit_length() + max(e, 0) <= LIMIT, "dyadic shifted numerator bound")
    return rational(integer(m * (1 << e)), 1) if e >= 0 else rational(m, 1 << -e)


def parse_z(x):
    require(type(x) is dict and set(x) == {"re", "im"}, "complex point shape")
    return parse_d(x["re"]), parse_d(x["im"])


def no_duplicates(pairs):
    result = {}
    for k, v in pairs:
        require(k not in result, "duplicate JSON key")
        result[k] = v
    return result


def file_sha(path):
    cap, size = 16 * 1024**2, 0
    require(Path(path).stat().st_size <= cap, "hash input cap")
    digest = hashlib.sha256()
    with open(path, "rb") as stream:
        while True:
            block = stream.read(65536)
            if not block:
                break
            size += len(block)
            require(size <= cap, "hash bounded read cap")
            digest.update(block)
            tick()
    return digest.hexdigest().upper()


def load(path, expected_sha=None):
    cap = 16 * 1024**2
    require(Path(path).stat().st_size <= cap, "input file cap before allocation")
    with open(path, "rb") as stream:
        data = stream.read(cap + 1)
    require(len(data) <= cap, "bounded input read cap")
    if expected_sha:
        require(hashlib.sha256(data).hexdigest().upper() == expected_sha, "immutable file hash")
    result = json.loads(data, object_pairs_hook=no_duplicates,
                        parse_constant=lambda _: (_ for _ in ()).throw(Reject("nonfinite JSON")))
    def validate_literals(value):
        if type(value) is int:
            integer(value)
        elif type(value) is float:
            require(math.isfinite(value), "nonfinite JSON number")
        elif type(value) is list:
            for item in value:
                validate_literals(item)
        elif type(value) is dict:
            for item in value.values():
                validate_literals(item)
    validate_literals(result)
    return result


class Gates:
    """One leaf's deterministic rounding events; encoding fixed by wire contract."""
    def __init__(self):
        self.hash = hashlib.sha256()
        self.count = 0

    def round(self, z, g):
        return self.real(z[0], g), self.real(z[1], g)

    def real(self, x, g):
        rounded, m = nearest(x, g)
        p, q = x.numerator, x.denominator
        rem = integer(integer(integer(2 * p * (1 << g)) + q) - integer(2 * q * m))
        require(0 <= rem < 2 * q, "rounding remainder")
        for value in (g, p, q, m, rem):
            self.hash.update((str(value) + "\n").encode("ascii"))
        self.count += 1
        if REPLAY_TALLY is not None:
            REPLAY_TALLY["count"] += 1
            REPLAY_TALLY["max_bits"] = max(REPLAY_TALLY["max_bits"],
                *(abs(v).bit_length() for v in (p, q, 2 * p * (1 << g), 2 * q, m, rem)))
        return rounded

    def receipt(self):
        return {"count": self.count, "sha256": self.hash.hexdigest().upper()}


def replay_log_inner(t, gates):
    v, t2 = F(0), mul(t, t)
    for k in range(511, -1, -1):
        v = gates.real(add(rational(1, 2 * k + 1), mul(t2, v)), 1041)
    return gates.real(mul(2 * t, v), 1041)


def forward_log_inner(t, gates):
    a, s, t2 = gates.real(t, 1081), F(0), mul(t, t)
    for j in range(512):
        term = gates.real(div(mul(2, a), 2 * j + 1), 1081)
        s = gates.real(add(s, term), 1081)
        if j != 511:
            a = gates.real(mul(t2, a), 1081)
    return s


def replay_pi(gates=None):
    gates, answers = gates or Gates(), []
    for d in (5, 239):
        t, v = rational(1, d), F(0)
        for k in range(255, -1, -1):
            v = gates.real(add(rational(1, 2 * k + 1), -mul(mul(t, t), v)), 1041)
        answers.append(gates.real(mul(t, v), 1041))
    value = gates.real(add(mul(16, answers[0]), -mul(4, answers[1])), 1025)
    return value, gates.receipt()


def forward_pi():
    gates, answers = Gates(), []
    for d in (5, 239):
        t = rational(1, d)
        a, s = gates.real(t, 1081), F(0)
        for j in range(256):
            term = gates.real(div(a, 2 * j + 1), 1081)
            s = gates.real(add(s, term), 1081)
            if j != 255:
                a = gates.real(-mul(mul(t, t), a), 1081)
        answers.append(s)
    return gates.real(add(mul(16, answers[0]), -mul(4, answers[1])), 1057)


def log_value(n, raw_log2, forward=False):
    gates = Gates()
    if n == 1:
        return F(0), gates.receipt()
    k = n.bit_length() - 1
    t = rational(n - (1 << k), n + (1 << k))
    inner = forward_log_inner(t, gates) if forward else replay_log_inner(t, gates)
    value = gates.real(add(mul(k, raw_log2), inner), 1057 if forward else 1025)
    return value, gates.receipt()


def replay_exp_poly(z, gates):
    v = ONE
    for k in range(511, -1, -1):
        v = gates.round(zadd(ONE, zscale(zmul(z, v), rational(1, k + 1))), 1041)
    return v


def forward_exp_poly(z, gates):
    term, total = ONE, ONE
    for j in range(1, 513):
        term = gates.round(zscale(zmul(z, term), rational(1, j)), 1081)
        total = gates.round(zadd(total, term), 1081)
    return total


def phase(logn, pi, forward=False, identity=False):
    gates = Gates()
    if identity:
        require(logn == 0, "identity phase input")
        return ONE, 0, ZERO, gates.receipt()
    z = zscale(CENTER, -logn)
    require(-8 <= z[0] <= 0, "real exponential domain")
    require(abs(z[1]) < 2**14, "unreduced phase domain")
    ratio = div(z[1], mul(2, pi))
    k = (2 * ratio.numerator + ratio.denominator) // (2 * ratio.denominator)
    require(abs(k) < 4096, "phase reduction integer domain")
    require(F(k) - F(1, 2) <= ratio < F(k) + F(1, 2), "signed phase period witness")
    rem = add(z[1], -mul(2 * k, pi))
    require(abs(rem) < 4, "reduced phase domain")
    poly = forward_exp_poly if forward else replay_exp_poly
    reduced_real = div(z[0], 16)
    if forward:
        term = real_value = F(1)
        for j in range(1, 513):
            term = gates.real(div(mul(reduced_real, term), j), 1081)
            real_value = gates.real(add(real_value, term), 1081)
    else:
        real_value = F(1)
        for j in range(512, 0, -1):
            real_value = gates.real(add(1, div(mul(reduced_real, real_value), j)), 1041)
    for _ in range(4):
        real_value = gates.real(mul(real_value, real_value), 1081 if forward else 1041)
    cis = poly((F(0), rem), gates)
    result = gates.round(zscale(cis, real_value), 1057 if forward else 1025)
    return result, k, z, gates.receipt()


def bernoulli():
    # B_n = -sum_(k<n) binom(n+1,k)*B_k/(n+1), B_1=-1/2.
    b = [F(1)]
    for n in range(1, 33):
        s = F(0)
        for k in range(n):
            s = add(s, mul(math.comb(n + 1, k), b[k]))
        b.append(div(-s, n + 1))
    require(b[1] == F(-1, 2), "Bernoulli convention")
    return b


def poly_product(a, b):
    result = [ZERO for _ in range(16)]
    for h in range(16):
        for k in range(h + 1):
            if k < len(a) and h - k < len(b):
                result[h] = zadd(result[h], zmul(a[k], b[h - k]))
    return result


def full_correction(logB, phaseB, b, omit_pole=False):
    corrpoly = [ZERO for _ in range(16)]
    corrpoly[0] = (F(1, 2), F(0))
    rising = [ONE] + [ZERO for _ in range(15)]
    for length in range(1, 32):
        factor = [zadd(CENTER, (F(length - 1), F(0))), ONE]
        rising = poly_product(rising, factor)
        if length % 2:
            m = (length + 1) // 2
            scale = div(b[2 * m], mul(math.factorial(2 * m), power(F(1025), 2 * m - 1)))
            require(abs(b[2 * m] / math.factorial(2 * m)) <= 1, "Bernoulli coefficient bound")
            corrpoly = [zadd(x, zscale(y, scale)) for x, y in zip(corrpoly, rising)]
    q = poly_product(corrpoly, [zadd(CENTER, (-F(1), F(0))), ONE])
    if not omit_pole:
        q[0] = zadd(q[0], (F(1025), F(0)))
    require(sum(abs(z[0]) + abs(z[1]) for z in q) < 2**48, "full Q polynomial coefficient bound")
    expcoeff, weight = [], F(1)
    for h in range(16):
        expcoeff.append(zscale(phaseB, weight))
        if h < 15:
            weight = div(mul(weight, -logB), h + 1)
    return poly_product(q, expcoeff)


def direct_g(logs, phases, independent=True):
    """Independent reverse head; complete correction via polynomial products."""
    head = [ZERO for _ in range(16)]
    order = range(1024, 0, -1) if independent else range(1, 1025)
    for n in order:
        weight = F(1)
        for h in range(16):
            head[h] = zadd(head[h], zscale(phases[n - 1], weight))
            if h < 15:
                weight = div(mul(weight, -logs[n - 1]), h + 1)
    grid = 545 if independent else 513
    def round_rows(values):
        result, traces = [], []
        for value in values:
            gate = Gates()
            result.append(gate.round(value, grid))
            traces.append(gate.receipt())
        return result, traces
    head, head_traces = round_rows(head)
    b = bernoulli()
    correction, correction_traces = round_rows(full_correction(logs[1024], phases[1024], b))
    result, traces = [], []
    for h in range(16):
        x = zadd(zmul(zadd(CENTER, (-F(1), F(0))), head[h]), correction[h])
        if h:
            x = zadd(x, head[h - 1])
        gate = Gates()
        result.append(gate.round(x, grid))
        traces.append(gate.receipt())
    return result, {"head": (head, head_traces), "correction": (correction, correction_traces),
                    "g": (result, traces)}, b


def interval_add(a, b):
    return add(a[0], b[0]), add(a[1], b[1])


def interval_mul(a, b):
    corners = [mul(x, y) for x in a for y in b]
    return min(corners), max(corners)


def interval_square(a):
    lo, hi = a
    return (F(0) if lo <= 0 <= hi else min(mul(lo, lo), mul(hi, hi)),
            max(mul(lo, lo), mul(hi, hi)))


def rect_mul(a, b):
    rr, ii = interval_mul(a[0], b[0]), interval_mul(a[1], b[1])
    return interval_add(rr, (-ii[1], -ii[0])), interval_add(interval_mul(a[0], b[1]), interval_mul(a[1], b[0]))


def rect_add(a, b):
    return interval_add(a[0], b[0]), interval_add(a[1], b[1])


def parse_rect(x):
    require(type(x) is dict and set(x) == {"re", "im"}, "rectangle shape")
    out = []
    for k in ("re", "im"):
        require(set(x[k]) == {"lo", "hi"}, "interval shape")
        lo, hi = parse_q(x[k]["lo"]), parse_q(x[k]["hi"])
        require(lo <= hi, "reversed interval")
        out.append((lo, hi))
    return tuple(out)


def image(boxes, offsets, omit_tail=False):
    z = ((F(0), F(0)), offsets)
    ans = ((F(0), F(0)), (F(0), F(0)))
    for box in reversed(boxes):
        ans = rect_add(rect_mul(ans, z), box)
    em = mul(div(4 * 2003 * 33, F(63, 2)), power(F(2034, 6 * 1025), 32))
    tail = F(1, 15 * 2**33)
    pad = em if omit_tail else add(em, tail)
    ans = tuple((add(a, -pad), add(b, pad)) for a, b in ans)
    denominator = ((add(CENTER[0], -1), add(CENTER[0], -1)),
                   (add(CENTER[1], offsets[0]), add(CENTER[1], offsets[1])))
    square = interval_add(interval_square(denominator[0]), interval_square(denominator[1]))
    require(square[0] > 0, "denominator norm-square lower bound")
    inverse_scale = (div(1, square[1]), div(1, square[0]))
    inverse = (interval_mul(denominator[0], inverse_scale),
               interval_mul((-denominator[1][1], -denominator[1][0]), inverse_scale))
    # The immutable target uses reciprocal-rectangle first, then multiply.
    # Reassociating these interval operations can change the final box.
    return rect_mul(ans, inverse)


def read_target(data):
    require(data["schema"] == "small-em-batch-candidate-v1", "target schema")
    p = data["parameters"]
    for k, v in {"N": 1024, "B": 1025, "M": 16, "K": 16, "J": 8, "L": 32, "p": 24}.items():
        require(p[k] == v, "target parameter " + k)
    require(parse_q(p["sigma"]) == CENTER[0] and parse_q(p["Delta"]) == F(-1, 8)
            and parse_q(p["t0"]) == F(31999, 16), "target grid")
    jets = data["g_jets"]
    require(len(jets) == 8 and [x["j"] for x in jets] == list(range(8)), "all target model labels")
    j = jets[7]
    require(tuple(parse_q(j["center"][k]) for k in ("re", "im")) == CENTER, "j7 center")
    require(len(j["coefficients"]) == 16, "sixteen target coefficients")
    boxes = []
    for row in j["coefficients"]:
        coordinates = []
        for key in ("re", "im"):
            m = parse_d(row[key]["mid"], canonical=False)
            r = parse_d(row[key]["rad"], canonical=False)
            require(r == F(1, 2**52), "immutable square radius")
            coordinates.append((add(m, -r), add(m, r)))
        boxes.append(tuple(coordinates))
    require(len(data["panels"]) == 8 and len(data["endpoints"]) == 9, "target image counts")
    panel, a, b = data["panels"][7], data["endpoints"][7], data["endpoints"][8]
    require(panel["index"] == 7 and panel["owner"] == 7 and parse_q(panel["top"]) == F(15993, 8)
            and parse_q(panel["bottom"]) == 1999, "panel ownership/geometry")
    for row, index, height in ((a, 7, F(15993, 8)), (b, 8, F(1999))):
        require(row["index"] == index and row["owner"] == 7 and parse_q(row["height"]) == height,
                "endpoint ownership/geometry")
    return boxes, [parse_rect(row["image"]) for row in (panel, a, b)]


def check_inside(z, radius, box):
    for k in (0, 1):
        require(box[k][0] <= add(z[k], -radius) and add(z[k], radius) <= box[k][1],
                "immutable coefficient containment")


def peak_memory():
    require(os.name == "nt", "mandatory Windows peak telemetry unavailable")
    class Counters(ctypes.Structure):
        _fields_ = [("cb", ctypes.c_ulong), ("PageFaultCount", ctypes.c_ulong)] + [
            (s, ctypes.c_size_t) for s in ("PeakWorkingSetSize", "WorkingSetSize", "QuotaPeakPagedPoolUsage",
            "QuotaPagedPoolUsage", "QuotaPeakNonPagedPoolUsage", "QuotaNonPagedPoolUsage", "PagefileUsage", "PeakPagefileUsage")]
    c = Counters()
    c.cb = ctypes.sizeof(c)
    kernel = ctypes.WinDLL("kernel32", use_last_error=True)
    kernel.GetCurrentProcess.restype = ctypes.c_void_p
    psapi = ctypes.WinDLL("psapi", use_last_error=True)
    psapi.GetProcessMemoryInfo.argtypes = [ctypes.c_void_p, ctypes.c_void_p, ctypes.c_ulong]
    require(psapi.GetProcessMemoryInfo(kernel.GetCurrentProcess(), ctypes.byref(c), c.cb) != 0,
            "peak telemetry failed")
    return int(c.PeakWorkingSetSize)


def require_external_job():
    require(os.name == "nt", "mandatory Windows supervision")
    kernel = ctypes.WinDLL("kernel32", use_last_error=True)
    kernel.GetCurrentProcess.restype = ctypes.c_void_p
    kernel.IsProcessInJob.argtypes = [ctypes.c_void_p, ctypes.c_void_p, ctypes.POINTER(ctypes.c_int)]
    inside = ctypes.c_int()
    require(kernel.IsProcessInJob(kernel.GetCurrentProcess(), None, ctypes.byref(inside)) != 0
            and inside.value != 0, "external job assignment required")


def validate_scalar_budgets():
    # Closed rational comparisons only, run inside the eventual supervised job.
    eta, delta, etai, deltai = F(1, 2**1024), F(1, 2**1040), F(1, 2**1056), F(1, 2**1080)
    tr = div(2, mul(2**513, math.factorial(513)))
    tc = div(2 * 4**513, math.factorial(513))
    tl = div(22, mul(1025 * F(8, 9), 3**1025))
    tp = F(20, 513 * 5**513)
    producer_errors = None
    for forward, E, D in ((False, eta, delta), (True, etai, deltai)):
        real_error = add(mul(81, tr), mul(165928 if forward else 283, D))
        require(real_error < E, "real-exp scalar budget")
        cis_error = add(add(tc, mul(41984 if forward else 81, D)), mul(8192, E))
        require(add(add(mul(2, real_error), cis_error), E) < mul(65536, E), "complex scalar budget")
        require(add(add(tl, mul(23936 if forward else F(77, 4), D)), E / 2) < E, "log scalar budget")
        require(add(add(tp, mul(F(46720, 3) if forward else F(145, 6), D)), E / 2) < E, "pi scalar budget")
        eps = F(1, 2**(544 if forward else 512))
        require(65536 * E < eps, "elementary versus outer budget")
        require((3 * 2001 + 1) * eps < 2**13 * eps, "actual phase-input budget")
        require(1024 * (2**13 * eps * 2**45 + 2**46 * eps) + eps < 2**70 * eps, "head budget")
        require(2**48 * (2**13 * eps * 2**13 + 2**13 * eps) + eps < 2**78 * eps, "correction budget")
        require(2002 * 2**70 * eps + 2**78 * eps + eps < 2**84 * eps, "assembled g budget")
        if not forward:
            producer_errors = (real_error, cis_error)
    er, ec = producer_errors
    names = ("log_tail_lt_eta_16", "pi_tail_lt_eta_16", "log_total_lt_eta", "pi_total_lt_eta",
             "real_exp_lt_eta", "all_real_square_errors_lt_one", "complex_exp_lt_2p16_eta",
             "primitive_lt_epsilon", "actual_phase_lt_2p13_epsilon", "head_bound", "correction_bound",
             "g_bound", "g_declared_radius")
    require(tl < eta / 16 and tp < eta / 16 and er < 1 and F(1, 2**428) < F(1, 2**420),
            "additional producer scalar conditions")
    return {"checks": dict.fromkeys(names, True), "log_tail": encode_q(tl), "pi_tail": encode_q(tp),
            "real_exp_error": encode_q(er), "cis_error": encode_q(ec), "eta": encode_d(eta),
            "epsilon": encode_d(F(1, 2**512)), "delta": encode_d(delta),
            "actual_phase_radius": encode_d(F(1, 2**499)), "g_error_bound": encode_d(F(1, 2**428)),
            "g_radius": encode_d(F(1, 2**420))}


def equal(actual, expected, label):
    # JSON metadata equality must distinguish booleans/floats from integers.
    require(type(actual) is type(expected), label + " type")
    if type(expected) is dict:
        require(set(actual) == set(expected), label + " keys")
        for key in expected:
            equal(actual[key], expected[key], label + "." + str(key))
    elif type(expected) in (list, tuple):
        require(len(actual) == len(expected), label + " length")
        for k, (a, b) in enumerate(zip(actual, expected)):
            equal(a, b, label + "[" + str(k) + "]")
    else:
        require(actual == expected, label)


def keys(x, expected, label):
    require(type(x) is dict and set(x) == set(expected), label + " keys")


def check_trace(x, expected):
    keys(x, ("count", "sha256"), "gate trace")
    require(type(x["count"]) is int and x["count"] >= 0, "gate count")
    equal(x, expected, "reconstructed gate count/digest")


def check_disk(inner, radius, outer, outer_radius):
    require(add(distance(inner, outer), radius) <= outer_radius, "full independent disk containment")


def check_bernoulli(rows, b):
    equal([parse_q(x) for x in rows], b, "all signed Bernoulli numbers")


def check_labels(rows):
    require(type(rows) is list and all(type(row["n"]) is int for row in rows), "integer leaf labels")
    equal([row["n"] for row in rows], list(range(1, 1026)), "complete ordered leaf labels")


def check_header(receipt, target, producer_sha):
    required = {"schema", "status", "producer_code_sha256", "pins", "parameters", "target", "recipe",
                "scalar_checks", "shared", "logs", "phases", "bernoulli", "head", "correction", "g",
                "images", "negative_controls", "counters", "telemetry"}
    keys(receipt, required, "producer receipt")
    equal(receipt["schema"], "rational-direct-g-j7-v1", "producer schema")
    equal(receipt["status"], "CANDIDATE", "producer candidate status")
    equal(receipt["producer_code_sha256"], producer_sha, "separately pinned producer source")
    equal(receipt["pins"], PINS, "complete producer source pins")
    p = receipt["parameters"]
    keys(p, ("N", "B", "M", "K", "j", "center", "outer_radius", "panel_radius"), "parameters")
    for key, value in (("N", 1024), ("B", 1025), ("M", 16), ("K", 16), ("j", 7)):
        require(type(p[key]) is int, "integer parameter")
        equal(p[key], value, "fixed " + key)
    equal(p["center"], {"re": encode_q(CENTER[0]), "im": encode_q(CENTER[1])}, "fixed center")
    equal(parse_q(p["outer_radius"]), F(1), "outer radius")
    equal(parse_q(p["panel_radius"]), F(1, 16), "panel radius")
    expected_target = {"sha256": TARGET_SHA, "g_jets": target["g_jets"][7], "panel": target["panels"][7],
                       "endpoints": target["endpoints"][7:9], "analytical_budget": {
                           "EM": target["analytical_budget"]["EM"],
                           "Taylor": target["analytical_budget"]["Taylor"]}}
    equal(receipt["target"], expected_target, "literal immutable target")
    equal(receipt["images"], {"panel": target["panels"][7], "endpoints": target["endpoints"][7:9]},
          "literal producer images")
    check_labels(receipt["logs"])
    check_labels(receipt["phases"])
    expected_recipe = dict(name="horner-j7-v1", rounding="floor(x*2^g+1/2); ties toward +infinity",
                           inner_grid=1041, canonical_grid=1025, outer_grid=513,
                           log_terms=512, atan_terms=256, exp_terms=513, real_squarings=4,
                           raw_log2_cache=True, log_order="n ascending; all512 updates except n1",
                           head_order="n ascending", normalization="complex-s derivative / h!",
                           period="floor(theta/(2*pi_hat)+1/2)",
                           digest="sha256 real-gate (g,p,q,m,remainder) decimal lines",
                           finite_g_rounds=["completed head", "completed full correction", "assembled g"])
    equal(receipt["recipe"], expected_recipe, "exact deterministic recipe")
    equal(receipt["scalar_checks"], validate_scalar_budgets(), "reconstructed producer scalar ledger")
    require(type(receipt["negative_controls"]) is list and len(receipt["negative_controls"]) == 10,
            "ten producer negative controls")
    for control in receipt["negative_controls"]:
        keys(control, ("name", "rejected", "reason"), "producer control")
        require(type(control["name"]) is str and control["rejected"] is True
                and type(control["reason"]) is str, "producer control status")
    require(len({control["name"] for control in receipt["negative_controls"]}) == 10,
            "unique producer negative controls")


def reconstruct_producer(receipt):
    """Re-evaluate the prescribed producer template, never its Python module."""
    global REPLAY_TALLY
    REPLAY_TALLY = {"count": 0, "max_bits": 0}
    gates = Gates()
    raw = replay_log_inner(F(1, 3), gates)
    pi, shared_trace = replay_pi(gates)
    shared = receipt["shared"]
    keys(shared, ("log2_raw", "pi", "gate_summary"), "shared leaves")
    equal(parse_d(shared["log2_raw"]), raw, "raw inner-grid log2")
    equal(parse_d(shared["pi"]), pi, "pi canonical center")
    check_trace(shared["gate_summary"], shared_trace)
    require(3 < pi < F(22, 7), "pi reduction range")
    logs, phases = [], []
    for n in range(1, 1026):
        PROGRESS["stage"] = "replay producer leaves"
        lr, pr = receipt["logs"][n - 1], receipt["phases"][n - 1]
        keys(lr, ("n", "k", "t", "center", "radius", "gates"), "log")
        keys(pr, ("n", "input", "period", "reduced", "center", "radius", "gates"), "phase")
        k = n.bit_length() - 1
        equal(lr["k"], k, "log exponent")
        equal(parse_q(lr["t"]), F(n - 2**k, n + 2**k), "exact log reduction")
        logn, trace = log_value(n, raw)
        equal(parse_d(lr["center"]), logn, "log center replay")
        require(0 <= logn <= 8, "log domain for source budgets")
        equal(parse_d(lr["radius"]), F(0) if n == 1 else F(1, 2**1024), "log radius")
        check_trace(lr["gates"], trace)
        value, period, inp, trace = phase(logn, pi, identity=(n == 1))
        equal(pr["input"], {"re": encode_q(inp[0]), "im": encode_q(inp[1])}, "phase exact input")
        equal(pr["period"], period, "phase period")
        equal(parse_q(pr["reduced"]), add(inp[1], -mul(2 * period, pi)), "phase reduced input")
        equal(parse_z(pr["center"]), value, "phase center replay")
        equal(parse_d(pr["radius"]), F(0) if n == 1 else F(1, 2**499), "actual phase radius")
        check_trace(pr["gates"], trace)
        logs.append(logn)
        phases.append(value)
        PROGRESS["replayed_leaves"] = n
    PROGRESS["stage"] = "replay producer finite g"
    G, detail, b = direct_g(logs, phases, independent=False)
    check_bernoulli(receipt["bernoulli"], b)
    for name, radius in (("head", F(1, 2**442)), ("correction", F(1, 2**434)), ("g", F(1, 2**420))):
        rows = receipt[name]
        equal([r["h"] for r in rows], list(range(16)), "all " + name + " orders")
        for h, row in enumerate(rows):
            allowed = {"h", "center", "radius", "gates"} | ({"old_containment"} if name == "g" else set())
            keys(row, allowed, name)
            equal(parse_z(row["center"]), detail[name][0][h], name + " center replay")
            equal(parse_d(row["radius"]), radius, name + " fixed radius")
            check_trace(row["gates"], detail[name][1][h])
    equal(REPLAY_TALLY["count"], 1028 + 1024 * (514 + 1542) + 96, "total reconstructed gates")
    equal(receipt["counters"], {
        "rounding_coordinate_gates": REPLAY_TALLY["count"],
        "observed_rounding_integer_bits": REPLAY_TALLY["max_bits"],
        "logs": 1025, "phases": 1025, "normalized_g_coefficients": 16,
        "whole_panels": 1, "endpoints": 2,
        "scope": "rounding observed sizes only; not all arithmetic temporary allocations"}, "producer counters")
    REPLAY_TALLY = None
    return logs, phases, G, pi


def independent_values(receipt, boxes):
    global PARTIAL_EVIDENCE
    raw = forward_log_inner(F(1, 3), Gates())
    pi = forward_pi()
    require(add(abs(add(pi, -parse_d(receipt["shared"]["pi"]))), F(1, 2**1056)) <= F(1, 2**1024),
            "independent pi containment")
    logs, phases, evidence = [], [], []
    PARTIAL_EVIDENCE = evidence
    for n in range(1, 1026):
        PROGRESS["stage"] = "independent forward leaves"
        logn, _ = log_value(n, raw, forward=True)
        require(0 <= logn <= 8, "independent log range for normalized powers")
        prodlog = parse_d(receipt["logs"][n - 1]["center"])
        irad, prad = (F(0), F(0)) if n == 1 else (F(1, 2**1056), F(1, 2**1024))
        require(add(abs(add(logn, -prodlog)), irad) <= prad, "independent full log containment")
        value, _, _, _ = phase(logn, pi, forward=True, identity=(n == 1))
        irad, prad = (F(0), F(0)) if n == 1 else (F(1, 2**531), F(1, 2**499))
        check_disk(value, irad, parse_z(receipt["phases"][n - 1]["center"]), prad)
        evidence.append({"n": n, "log": encode_d(logn),
                         "log_radius": encode_d(F(0) if n == 1 else F(1, 2**1056)),
                         "log_center_distance": encode_q(abs(add(logn, -prodlog))),
                         "phase": encode_z(value), "phase_radius": encode_d(irad),
                         "phase_center_l1_distance": encode_q(distance(value, parse_z(receipt["phases"][n - 1]["center"])))})
        logs.append(logn)
        phases.append(value)
        PROGRESS["independent_leaves"] = n
    PROGRESS["stage"] = "independent finite g"
    G, _, _ = direct_g(logs, phases, independent=True)
    for h, value in enumerate(G):
        check_disk(value, F(1, 2**450), parse_z(receipt["g"][h]["center"]), F(1, 2**420))
        check_inside(value, F(1, 2**450), boxes[h])
    return logs, phases, G, evidence, pi


def expect_reject(thunk, label):
    try:
        thunk()
    except Reject:
        return label
    raise Reject("negative control was accepted: " + label)


def negative_controls(receipt, target, boxes, targets, replay_logs, replay_phases, independent_G):
    # These invoke the same arithmetic/geometry predicates used above.
    checks = []
    changed = json.loads(json.dumps(target))
    changed["g_jets"][7]["center"]["re"] = encode_q(F(1))
    checks.append(expect_reject(lambda: read_target(changed), "changed_center"))
    changed = json.loads(json.dumps(target))
    changed["g_jets"][7]["j"] = 6
    checks.append(expect_reject(lambda: read_target(changed), "changed_index"))
    changed = json.loads(json.dumps(target))
    changed["endpoints"][8]["owner"] = 6
    checks.append(expect_reject(lambda: read_target(changed), "wrong_endpoint_owner"))
    omitted = [x for x in receipt["logs"] if x["n"] != 1024]
    checks.append(expect_reject(lambda: check_labels(omitted), "omitted_n1024"))
    badb = list(receipt["bernoulli"])
    badb[2] = encode_q(-parse_q(badb[2]))
    checks.append(expect_reject(lambda: check_bernoulli(badb, bernoulli()), "signed_bernoulli"))
    wrong_correction = full_correction(replay_logs[1024], replay_phases[1024], bernoulli(), omit_pole=True)
    wrong0 = Gates().round(wrong_correction[0], 513)
    checks.append(expect_reject(lambda: equal(wrong0, parse_z(receipt["correction"][0]["center"]),
                                              "complete correction identity"), "omitted_B_pole_term"))
    phase0 = parse_z(receipt["phases"][1]["center"])
    checks.append(expect_reject(lambda: check_disk(zadd(phase0, ONE), F(0), phase0, F(1, 2**499)),
                                "shifted_elementary_center"))
    checks.append(expect_reject(lambda: signed_witness(1, 3, 4, 6), "invalid_rounding_witness"))
    checks.append(expect_reject(lambda: equal(image(boxes, (F(-1, 16), F(1, 16)), omit_tail=True),
                                              targets[0], "full analytic padding"), "omitted_Taylor_tail"))
    mutated = json.loads(json.dumps(receipt["target"]["endpoints"]))
    mutated[1]["height"] = encode_q(F(1998))
    checks.append(expect_reject(lambda: equal(mutated, target["endpoints"][7:9], "immutable endpoint"),
                                "changed_immutable_endpoint"))
    return checks


def execute(args):
    target = load(args.target, TARGET_SHA)
    boxes, targets = read_target(target)
    receipt = load(args.producer)
    require(re.fullmatch("[0-9A-F]{64}", args.producer_sha) is not None, "producer source pin format")
    check_header(receipt, target, args.producer_sha)
    validate_scalar_budgets()
    logs, phases, G, _ = reconstruct_producer(receipt)
    for h, z in enumerate(G):
        check_inside(z, F(1, 2**420), boxes[h])
        margin = {axis: {"lower_margin": encode_q(add(add(z[k], -F(1, 2**420)), -boxes[h][k][0])),
                         "upper_margin": encode_q(add(boxes[h][k][1], -add(z[k], F(1, 2**420))))}
                  for k, axis in enumerate(("re", "im"))}
        equal(receipt["g"][h]["old_containment"], margin, "stored exact old containment margins")
    _, _, iG, leaf_evidence, ipi = independent_values(receipt, boxes)
    offsets = ((F(-1, 16), F(1, 16)), (F(1, 16), F(1, 16)), (F(-1, 16), F(-1, 16)))
    for offset, expected in zip(offsets, targets):
        equal(image(boxes, offset), expected, "exact full old-box image reconstruction")
    controls = negative_controls(receipt, target, boxes, targets, logs, phases, iG)
    return {"schema": "rational-direct-g-j7-independent-v1", "status": "ARITHMETIC_CANDIDATE",
            "target_sha256": TARGET_SHA, "spec_sha256": SPEC_SHA,
            "producer_source_sha256": args.producer_sha,
            "producer_receipt_sha256": file_sha(args.producer),
            "independent_source_sha256": file_sha(__file__),
            "counts": {"producer_logs": 1025, "producer_phases": 1025, "independent_logs": 1025,
                       "independent_phases": 1025, "independent_g": 16, "images": 3},
            "independent_pi": {"center": encode_d(ipi), "radius": encode_d(F(1, 2**1056))},
            "independent_leaves": leaf_evidence,
            "independent_g": [{"h": h, "center": encode_z(z), "radius": encode_d(F(1, 2**450))}
                              for h, z in enumerate(iG)], "negative_controls": controls}


def authorized_manifest(path):
    require(Path(path).stat().st_size <= 65536, "manifest size cap")
    m = load(path)
    keys(m, ("runtime_authorized", "independent_code_sha256", "producer_code", "producer_code_sha256",
             "producer_receipt", "producer_receipt_sha256", "output", "caps", "pins", "static_review",
             "preparation", "supervision"), "run manifest")
    require(m["runtime_authorized"] is True, "separate execution authorization required")
    equal(m["independent_code_sha256"], file_sha(__file__),
          "exact independent code authorization")
    equal(m["pins"], PINS, "manifest source pins")
    equal(m["caps"], {"seconds": 900, "peak_working_set_bytes": 512 * 1024**2,
                      "aggregate_bytes": 16 * 1024**2}, "fixed independent caps")
    for relative, digest in PINS.items():
        equal(file_sha(AGENTS / relative), digest, "source file pin")
    for key in ("static_review", "preparation"):
        ref = m[key]
        keys(ref, ("path", "sha256"), "approval reference")
        file = (AGENTS / ref["path"]).resolve()
        require(file.is_relative_to(AGENTS.resolve()) and file.suffix == ".md", "approval path")
        equal(file_sha(file), ref["sha256"], "approval hash")
    supervision = m["supervision"]
    keys(supervision, ("protocol", "supervisor_pid", "post_exit_seal_required", "no_children"), "supervision")
    require(supervision["protocol"] == "external-retained-handle-v1"
            and type(supervision["supervisor_pid"]) is int and supervision["supervisor_pid"] > 0
            and supervision["post_exit_seal_required"] is True and supervision["no_children"] is True,
            "mandatory external lifetime supervision")
    for field, suffix in (("producer_code", ".py"), ("producer_receipt", ".json")):
        file = (AGENTS / m[field]).resolve()
        require(file.is_relative_to(AGENTS.resolve()) and file.suffix == suffix, "producer input path")
        equal(file_sha(file), m[field + "_sha256"], "producer input pin")
    require(type(m["output"]) is str and Path(m["output"]).name == m["output"]
            and Path(m["output"]).suffix == ".json", "owned output name")
    return m


def main():
    global START
    START = time.monotonic()
    sys.set_int_max_str_digits(20000)
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", required=True)
    args = parser.parse_args()
    manifest = authorized_manifest(args.manifest)
    require_external_job()
    args.target = AGENTS / "integration/small_em_batch_candidate_20261111_01.json"
    args.producer = AGENTS / manifest["producer_receipt"]
    args.producer_sha = manifest["producer_code_sha256"]
    args.output = HERE / manifest["output"]
    marker = args.output.with_suffix(".attempt.json")
    require(not args.output.exists() and not marker.exists(), "no overwrite or resumed attempt")
    with marker.open("x", encoding="ascii") as record:
        json.dump({"manifest_sha256": file_sha(args.manifest),
                   "one_attempt": True}, record, separators=(",", ":"))
    result = {"schema": "rational-direct-g-j7-independent-v1", "status": "INCOMPLETE"}
    try:
        require(peak_memory() <= 512 * 1024**2, "initial memory cap")
        result = execute(args)
    except Exception as exc:
        result = {"schema": "rational-direct-g-j7-independent-v1", "status": "INCOMPLETE",
                  "failure": type(exc).__name__ + ": " + str(exc)[:2000], "progress": dict(PROGRESS),
                  "independent_completed_leaves": PARTIAL_EVIDENCE}
    try:
        peak = peak_memory()
        elapsed = time.monotonic() - START
        require(peak <= 512 * 1024**2 and elapsed < 900, "final worker cap")
        result["telemetry"] = {"peak_working_set_bytes": peak, "elapsed_seconds": elapsed,
                               "integer_rational_operations": OPS, "children_spawned": 0,
                               "scope": "worker_prepublication_requires_external_lifetime_seal"}
    except Exception as exc:
        result["status"] = "INCOMPLETE"
        result["failure"] = str(exc)[:2000]
    encoded = json.dumps(result, separators=(",", ":"), allow_nan=False).encode("ascii")
    require(len(encoded) < 15 * 1024**2, "reserved output cap")
    with open(args.output, "xb") as out:
        out.write(encoded)
    return 0 if result["status"] == "ARITHMETIC_CANDIDATE" else 2


if __name__ == "__main__":
    raise SystemExit(main())

