"""Exact scalar checks only. No analytic functions, prime data, or Lean execution."""
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
import json
import math

ROOT = Path(__file__).resolve().parents[4]
checks = []

def lt(name, a, b):
    a, b = F(a), F(b)
    assert a < b, name
    checks.append({"name": name, "left": str(a), "relation": "<", "right": str(b)})

def eq(name, a, b):
    a, b = F(a), F(b)
    assert a == b, name
    checks.append({"name": name, "left": str(a), "relation": "=", "right": str(b)})

def exp_lower(x, n):
    return sum((F(x)**k / math.factorial(k) for k in range(n + 1)), F(0))

# e < 11/4: sum through 4 plus geometric upper bound for the tail from 5.
lt("elementary e upper", exp_lower(1, 4) + F(1, 120) / (1-F(1,6)), F(11,4))
lt("log(1e12)>27", F(11,4)**27, 10**12)
lt("log(10)<3", 10, exp_lower(3, 4))
lt("log(7)<2", 7, exp_lower(2, 5))
lt("log(5/2)<1", F(5,2), exp_lower(1, 3))
lt("sqrt(pi)<1.773 from pi<22/7", F(22,7), F(1773,1000)**2)
lt("Gamma(5/2)>1 from pi>3", 1, F(27,16))
lt("mixture mass below 2", F(192182,100000), 2)
lt("V upper", F(137259,100000)**2 * F(3,8)*F(1773,1000), F(1254,1000))
lt("real theta relative error", F(1,27**3)+F(492,10**9)+F(1,10**12), F(52,10**6))
eq("D0 pair ratio", 4+2*F(5,2), 9)
eq("D1 coarse ratio", 20+8*4, 52)
eq("Dhalf0 coarse ratio", 9+32, 41)
lt("inverse-square weighted derivative", F(14,3)*16, 75)
eq("Dhalf1 coarse ratio", 20+9+32+75, 136)
eq("prime-power constant term", 136+5, 141)
eq("low-error integrated constant", F(6144,25)+F(1024,5), F(11264,25))
lt("low-error bracket at Y", F(12288,5)*75+F(11264,25), 200000)
eq("low-error final scale", F(200000,10**65), F(2,10**60))
lt("sqrt(Y)>3e12", (3*10**12)**2, 10**25)
lt("small-prime logarithm square", (2+F(75,2))**2, 1600)
lt("small-prime final bound", F(1024*7**5*1600,10**62), F(1,10**50))
lt("prime-power prefactor", F(14262,10000)*F(1254,1000), F(18,10))
lt("prime-power endpoint", F(18,10)*(41*75+141)/(3*10**12), F(2,10**9))
lt("combined small coefficient", F(2,10**9)+F(1,10**50), F(21,10**10))
eq("prime logarithm coefficient", 1+F(52,10**6)*9, F(1000468,10**6))
eq("prime constant coefficient", F(1,2)+F(52,10**6)*53, F(502756,10**6))
eq("eta2 first moment", 4*F(3,8)**2, F(9,16))
eq("etaU first moment", 2*F(9,16), F(9,8))
eq("linear test moment", 3*F(5,4)-F(9,8), F(21,8))
eq("linear test lower V", F(21,8)**2/9, F(49,64))
lt("lower V exceeds 3/4", F(3,4), F(49,64))

sources = [
    "MajorArcs/Cor933.lean", "MajorArcs/Eta2Moments.lean", "MajorArcs/Prop715.lean",
    "Prelim/ThetaExplicit.lean", "Prelim/LambdaMu.lean", "Helfgott/Defs.lean", "Helfgott/Eta2.lean",
]
base = ROOT / "work/ternary-goldbach/TernaryGoldbach"
pins = [{"path": str((base / p).relative_to(ROOT)), "sha256": sha256((base / p).read_bytes()).hexdigest().upper()} for p in sources]
out = {"status": "PASS", "scope": "Exact rational comparisons only; analytic derivation and source localization are paper obligations.",
       "checks": checks, "count": len(checks), "source_pins": pins,
       "script_sha256": sha256(Path(__file__).read_bytes()).hexdigest().upper()}
target = Path(__file__).with_suffix(".json")
with target.open("x", encoding="utf-8", newline="\n") as f:
    json.dump(out, f, indent=2)
    f.write("\n")
print(json.dumps({"status": "PASS", "checks": len(checks), "receipt": str(target), "sha256": sha256(target.read_bytes()).hexdigest().upper()}))
