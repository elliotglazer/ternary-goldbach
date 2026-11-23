"""Bounded exact arithmetic diagnostics; no special functions or sign evaluation."""
from fractions import Fraction as Q
from math import factorial, isqrt
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
checks = []


def check(name, condition):
    assert condition, name
    checks.append(name)


def atan_box(x, n):
    assert 0 <= x < 1 and n % 2 == 0
    lower = sum(((-1) ** j * x ** (2*j+1) / (2*j+1)
                 for j in range(n)), Q(0))
    return lower, lower + x ** (2*n+1) / (2*n+1)


def pi_box(n):
    a, b = atan_box(Q(1, 5), n)
    c, d = atan_box(Q(1, 239), n)
    return 16*a-4*d, 16*b-4*c


def floor_witness(t):
    for n in (4, 8, 16, 32, 64, 128):
        lo, hi = pi_box(n)
        alow2, ahigh2 = t/(2*hi), t/(2*lo)
        m = isqrt(alow2.numerator // alow2.denominator)
        if m*m <= alow2 and ahigh2 < (m+1)*(m+1):
            return {"n": n, "floor": m,
                    "pi_lower": str(lo), "pi_upper": str(hi)}
    raise AssertionError("bounded diagnostic failed to find floor witness")


check("sinc denominator lower > 7/12", 1-Q(22, 7)**2/24 > Q(7, 12))
check("numerator sinc radius < 2", 3*Q(22, 7)/8 < 2)
check("denominator sinc radius < 2", Q(22, 7)/2 < 2)
check("analytic plus evaluation reserve", Q(451, 1000)+Q(19, 1000)==Q(47, 100))

for m in range(2, 21):
    em = Q(2 * 2**(2*m), factorial(2*m+1))
    en = Q(2 * 2**(2*m+2), factorial(2*m+3))
    check(f"producer integrated tail ratio m={m}",
          en/em == Q(4, (2*m+2)*(2*m+3)) <= Q(2, 21))
    check(f"producer geometric tail upper m={m}",
          em <= Q(4, 15)*Q(2, 21)**(m-2))

# In a sinc polynomial through degree 2*m, the first omitted term is 2*m+2.
# Test exact ratios for many later omitted terms; the general monotonic proof
# is independent of this finite regression.
for m in range(21):
    radius = Q(2)
    ratio = radius**2/((2*m+4)*(2*m+5))
    check(f"tail ratio below one m={m}", ratio < 1)
    first = radius**(2*m+2)/factorial(2*m+3)
    partial_tail = sum((radius**(2*j)/factorial(2*j+1)
                        for j in range(m+1, m+32)), Q(0))
    check(f"partial sinc tail below geometric bound m={m}",
          partial_tail < first/(1-ratio))
    for j in range(m+1, m+17):
        actual_ratio = radius**2/((2*j+2)*(2*j+3))
        check(f"later ratio bounded m={m} j={j}", actual_ratio <= ratio)

# These exact polynomial identities are the pre-trigonometric part of the
# global removable quotient adapter; include the removable point itself.
for w in (Q(0), Q(1, 4), Q(1, 2), Q(3, 4), Q(1)):
    check(f"sinc factor identity w={w}",
          (w*w-Q(1, 4))/2 == (w-Q(1, 2))*(w+Q(1, 2))/2)
check("removable value factor", (Q(1, 2)+Q(1, 2))/2 == Q(1, 2))

plo, phi = pi_box(8)
cases = [("ordinary1500", Q(1500), 15),
         ("ordinary2000", Q(2000), 17),
         ("ordinary1000000", Q(1000000), 398),
         ("rational_below_integer_a16", 2*16**2*plo, 15),
         ("rational_above_integer_a16", 2*16**2*phi, 16)]
floors = []
for label, t, expected in cases:
    witness = floor_witness(t)
    check(label, witness["floor"] == expected)
    # Rational b=1/t obeys b^4*t^3<=1, hence b<=t^(-3/4).
    b = 1/t
    check(label+" rational power lower", b**4*t**3 <= 1)
    for requested in (Q(1), Q(1, 10**9), Q(1, 10**30)):
        eta = min(requested, Q(19, 1000)/t)
        check(label+f" tolerance {requested}",
              0 < eta <= requested and eta**4*t**3 <= Q(19, 1000)**4)
    floors.append({"name": label, "t": str(t), **witness})

source_root = Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib")
source_names = ["Analysis/SpecialFunctions/Trigonometric/Sinc.lean",
                "Analysis/SpecialFunctions/Trigonometric/Series.lean",
                "Analysis/Real/Pi/Irrational.lean",
                "Analysis/SpecialFunctions/Trigonometric/Bounds.lean",
                "Analysis/Complex/Exponential.lean"]
sources = {n: hashlib.sha256((source_root/n).read_bytes()).hexdigest().upper()
           for n in source_names}
producer_pins = {
    "PRINCIPAL_K0_INTERVAL_EVALUATION_PLAN_2026-11-11.md": "E3B6843DA11022ACBC0A7BBAFA5B8C125CF38B88127B69DCB3B8FF6EB90B157A",
    "principal_k0_interval_scalar_20261111.py": "F14C03BD72F13DC3DB570D9093A8920449D267121F8FD264BA61F2F391390892",
    "principal_k0_interval_scalar_20261111.json": "3212347EBE306A61B8496DA3AD31BADB211B9CDD2D2F21A4BDD38FE42C94B328",
}
for name, pin in producer_pins.items():
    check("producer pin "+name,
          hashlib.sha256((HERE.parent/'prime-estimates'/name).read_bytes()).hexdigest().upper() == pin)
result = {"status": "PASS_BOUNDED_EXACT_DIAGNOSTICS",
          "scope": "Arithmetic only; no full evaluator, special-function values, sign scan, or Lean proof.",
          "checks": len(checks), "check_names": checks,
          "floor_witnesses": floors, "source_sha256": sources,
          "producer_sha256": producer_pins,
          "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
out = HERE / "review_k0_interval_plan_20261111.json"
out.write_text(json.dumps(result, indent=2)+"\n", encoding="utf-8")
print(json.dumps({"status": result["status"], "checks": len(checks),
                  "floor_degrees": [v["n"] for v in floors],
                  "script_sha256": result["script_sha256"],
                  "receipt_sha256": hashlib.sha256(out.read_bytes()).hexdigest().upper()}))
